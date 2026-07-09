Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB49DC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 12:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC2C84ACA;
	Fri, 10 Jul 2026 14:56:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="TzretMYV";
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="QtKTDVWy";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="G283fV3C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D997284BF2; Thu,  9 Jul 2026 20:19:53 +0200 (CEST)
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com
 [148.163.158.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AC6B84BF6
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 20:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thinh.Nguyen@synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
 by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 669HWkZm2246682; Thu, 9 Jul 2026 11:19:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfptdkimsnps;
 bh=YH6CA7z3gBkxeSPaKwNrhLrBcrl1RtFvD7haamIwVEM=; b=TzretMYVlwYy
 O1jW2F3ZTBfpF6HW79XEQc5pOiQv7ItnkUFtT6EihGRaXXNpvr2Tjh1iBWkeamGg
 bK2KxGedLujH79pTc5AP/EzxK/4C80/5wwwavZk8F4y+2MdbIL3RZ/EmfRiMZq32
 pT0NZzukpVHWKWkVd7x2OPvKCOs6zD5ar03JhSiuB+7w1iUU3ZxhfR4jUv4AMe0N
 2lV6/YgZ6zM4ED503h7/f4/IHeTE3lTUiqF9btbqX2zce7acIh+/z1EdLKtj80jO
 gaRMmRvLFT6Rswz3GbZJDeO3/U8/G2PiXUth2hvuVakaxLsc07oJLAB1bCJK9foH
 ai3lT53W9w==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4fabjq31b4-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 09 Jul 2026 11:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1783621184; bh=8C+LJ5zhhzxQOMrmT8QJkiUTtQe3MmNnyfVJuAmVwDM=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=QtKTDVWytXJ51wd/LSd0pwC0S1FLtQTWvAnWC9umuwxkcg2xo1OcE8vF3puFrdEXw
 CskxgGRa7qnycz/DizgqYV7oyHIn/tK9nn3IMIasFMH0fNGwWc3GY54NNvRwJA+m+n
 F5b7XKOPMBkzTJmWhfyWMTY5IDOBvGqFuAMNr1aoWs6QzVKPz1vG7DLfo2GCzuQrPV
 TXGLcsZUqPFWS6C6EpZ7XvU0S1/P5lDMhrz6YW6GAfHOV0xs6qZwFG/BNl2uacGf7G
 /tgLZKiOPZqI/u+4vLIz+fWCROulSCst3kBSzFkg9jHQ5u8el3tvLAcSdvx/YdJcqj
 /ydi2JiW4L/JA==
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com
 [10.205.2.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ED64040117;
 Thu,  9 Jul 2026 18:19:43 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com
 [10.202.1.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id DCC66A1525;
 Thu,  9 Jul 2026 18:19:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=G283fV3C; 
 dkim-atps=neutral
Received: from BN1PR07CU003.outbound.protection.outlook.com
 (mail-bn1pr07cu00307.outbound.protection.outlook.com [40.93.12.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id B3DBF40124;
 Thu,  9 Jul 2026 18:19:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPm+riniTmvOj/Ed93JExsdjhaxmJXeLcwkKMtNi3plTFQE6zb+jkHkIGjwM45C7I8TEjuCbI/OqvkQpm1m5VfFyNMbWS+YlvUHc4Hn2D5c9qQCXh5MjxK6OOXnVAtB204Q//9zWVMYIOCAPs3Yy8GzbHlMxt8V/LuNBaVjuJ2G4k3347TKPTw372p2i7mD307gpenzoD53AEv/07awDRSvY4eoqhU/U8h2/tcz2pr71Sd/sd9iIu0bAfSWkL2KgwQcvRIGYOryJcHagMo7gaMVemtcpuMIwXcvTQ3qz5bT8xG4DgmD0S9XuiLCy5aiGTZ2ySjCyZlqv3T1JjrYb7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YH6CA7z3gBkxeSPaKwNrhLrBcrl1RtFvD7haamIwVEM=;
 b=PwZKYftmKP69VRQDmfgoxrRV0wK9wXi3bUQKndU0PPyV5DMblk9vi1SCPNF7SKz+GH5fQO/Dz2obfg0RmtVgNgfRKLdkCRkKpP4iIGx/uGpv9ooTzBvIrGtGu9hCDrvP33vuEeuJeOF/ScWRyrPk1zhHeZDO/+b5ac23kjF4vFYU8oD3ADds2rs1Cxt/O/aDBDm7kYKepRylk4CeQFYp8YbPMhZSKCEcDIe7HuSKZwdv343J5DWmolvQkl40Kx9Int69p/xDl4K4O0kFXU5fqCZvGYN4+GH155hnzcURpCnA/rGSihdfxCzxcWK/eb6unPCvFT9uoKc6smTrbwLHvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YH6CA7z3gBkxeSPaKwNrhLrBcrl1RtFvD7haamIwVEM=;
 b=G283fV3Cjwd0KCmsqt862IjUk++krD2MUrL+8YwYLFdT9hxYEfjD0goOKN9OLJok9QJUb5x2oSrCYunVDQ/KZdhlRuOI+EwSl9zmnusECAJilrtiBTxCz7cXc2/eZNc44YdkxGUvgOiKqP5LNtIk18nk4Wdck0nvFOl0UOTKd5A=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 18:19:36 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 18:19:36 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
CC: Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH v2 2/2] usb: gadget: dfu: add SuperSpeed descriptor support
Thread-Topic: [PATCH v2 2/2] usb: gadget: dfu: add SuperSpeed descriptor
 support
Thread-Index: AQHdD89/nAOpDtv5TESo302SnCVStw==
Date: Thu, 9 Jul 2026 18:19:36 +0000
Message-ID: <a6c2533e5d59c5bcb1199fc0b939e6a7a5ee2382.1783620779.git.Thinh.Nguyen@synopsys.com>
References: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1783620779.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|DM6PR12MB4418:EE_
x-ms-office365-filtering-correlation-id: 9d721a02-506d-48e8-9492-08dedde6a1f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|18002099003|22082099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: CIB1d6HhXBWoMenThiYJWjjF+lbXJbeP4MIcq9mb82q6hSzAQ4O7bIUUWF/G9GzLDTV+mZiEDF53KNLBe6B4BYsI3YOZKYUxf/8K9SQYLGI3gF8KFwjVe7dib6uSeMPLt2B4661Q8KRHEdATxNai7HIDywE6rNLmz7DMrW+VhYCNqG47PXo0Fg0jCQnc/1hFApjH6DUjOodFSGZ9zeAWIGD6cKf9AY2qD3WuTqaTzycZ628GRVTHm4e/QwfbwTvFh20+slOH7mbeh/BvqRAnpx9dwT6BSCTUIID0U9Ae3c9ljgjBraAxx0Qq+BhpCkcP8ncUPwNnqHgZnSo+jlLCFzVg5Df/myKzAdF1Z1CKdcnnHcvnNxNIMwJ/HssRIcJYJP/264iaKhUcuFUftLvIi3Stjwp/37WK8isDaGanhBVQINiwylwjiqPW2BoA5HaPjueuOkYGk6EMy+q7qYNkdFMRT5KDF7P7UndVPN7VUY/NiDfBICrbPM1HaSzYQ9tsh7mx6EqwHk4npPcrejftvLxcrnNPu/BXI46Ps9GSSMqF4L/+lEoLXoGHItAiVeB0RIF8gQJDDtrtaVQpBjfqtIUXCyo+vpfqc9jVb4hdq2bO6lzPS9mgHJP1sUJQQD3vgMaWo34xyK/vIgJMPEspDBCJ6LKT1FlTL+PLPWImv7IAtJxZbC4K6zCOb6Z4qYy4qveN8lvtRG1a0TswhoGO07JXu0LUaGZGoZiizIoLgHw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(18002099003)(22082099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?tCYlGcQOl3z3kEkzVxcYEXqFGbOP0sw//cON6wyEvhU8NrU5xLeYdkH+tP?=
 =?iso-8859-1?Q?T72FfaGbwmeGhR/o4Y3JGsQXA6Armp32EgVCVBiukQeZpiFhIUZRah06vW?=
 =?iso-8859-1?Q?pZZYI9ojDGP/JtYsVUUDd1jGQp+NmYKX+Bx5exLF+khZYByTKpkQiZbJEc?=
 =?iso-8859-1?Q?DhH7SeLR83En9P4Ar0UqcBvsobmA7pEnHbRnwgZxAzlcYFbz52vaDzAw61?=
 =?iso-8859-1?Q?C+yBfGdDs61Vhe6jptkwGhf9BazPaYWi1dguCpaV0x7wZpXdRwb67VG8ZL?=
 =?iso-8859-1?Q?wiKlWB/Y6b8zfAiU13fCJ2MPA/iQ6okvUGbZIWWMaPMUApr6mXNJFtmeXg?=
 =?iso-8859-1?Q?L5C9O4GiUa84X6lYsAcgoKVliJO8+HVKi5z9hTBxHPLry46fBOhmE/UKwF?=
 =?iso-8859-1?Q?ZZwcArQSYE7X5cVvSLlSwvgSJUdc0MEXZDyipPjv141jEcW7tXxov1AEUO?=
 =?iso-8859-1?Q?7M+5msp5FGyqwVxA6tfb8/kQfB21J3TXmJ1RjbuyK0iu/nGE9nXrftuH6b?=
 =?iso-8859-1?Q?89F9xyMd7DWEiP+VGqYyaGWnowhyBRV4osSvSl3MqoGSzp7ubBdCoTZftH?=
 =?iso-8859-1?Q?Ze9ouLbOVEdG0BeqR90IIU/i6qOxRjjQo85XFYN0ivP5ekgk6IgPjKoBp9?=
 =?iso-8859-1?Q?spw5ACUK9UIT5SL9ppcc2cLoZHDA+DhuL3Kn8XKW74WXmizWccwBjW4/yD?=
 =?iso-8859-1?Q?i+Pu1NL4NLogQrAOieP9AE/ileeVsJiJEHap14Xw0mXrm8uxmp+keDYJ/E?=
 =?iso-8859-1?Q?dgFElnDrhmxMxuRrk/pSGjVayNCqKSyyue36Ki8hqcG3bn+x3J4h2eQBpp?=
 =?iso-8859-1?Q?d298YjOAIe92y6DcIL1EudybUo0CkfTjSRaoBVLJ2IYvjSJ4oZA06iEEX+?=
 =?iso-8859-1?Q?wiryAEUQNl5WtPzJDcbaWXykSl51elZzfB00fMYat5szjSRdSSxisbIIFh?=
 =?iso-8859-1?Q?nxewQB2idQpB3n1rkUV/FYz7CB4pPzM9XqhW+W5WEvNasGTi6ZgCh5X7EP?=
 =?iso-8859-1?Q?wN77LnVzo5AKmGJ4E6Uiyf6FYOppl1VJdt7hwDPjkkfqJynlfvSQD1l3qQ?=
 =?iso-8859-1?Q?683HavAYzeKpDg1d69MocrgZgMIOjzf4w6K4rLNVxiOEmzh8k2belV/qNW?=
 =?iso-8859-1?Q?1FaxgVoKTV10YfR9QcHIY5oLPz+Wi8qeRtHK6mfh33hLHrtNV+8zqggDsj?=
 =?iso-8859-1?Q?NDYnruvAx4NTf/XEifY39W0zpxPihAHbGH9DSwS38Cv9+30UrZFYhD+Wef?=
 =?iso-8859-1?Q?xYPdww20sDhcQhjRLPhVXQP3JNiXoFCqlVa53FOjfxe+nmkIw9dr6md59c?=
 =?iso-8859-1?Q?qmK+DWUugDpVc/qoXgDzcd4T4TOj+lC3U7JJF7Tp+h6NaRWLJRtjnjAuey?=
 =?iso-8859-1?Q?WyYlobf3sCUsp/h56v3J3q7SQiUp8MdupTrLXiOgKW0x0sI15uPPMFdZ30?=
 =?iso-8859-1?Q?9MKLH1B1JlNtsz2is6kqwIOzMFoG5CgivjQCEL30VHvBVVktxviS/ru4hf?=
 =?iso-8859-1?Q?3kQdgec5MRMTgbQGpwNsAv6Rn9CxRGoUJiEgTviKJwFphEtiaAJFfTRZq0?=
 =?iso-8859-1?Q?64BH6KK4I2413Aw0to3fz1GUavUSChZ2/wzua6YNyQBl/W3PV7OyLrz420?=
 =?iso-8859-1?Q?QmVT3jLBtxjMIqEw4VDy5peBYjqIrZDRxsbr95aRMlNY1XXN1tz8C+8/WY?=
 =?iso-8859-1?Q?O9IpsAKWrkjNr7G/RjSuTECwb1fY+irwnCL9RNHbgk0KPr3ILxz7r3/dtD?=
 =?iso-8859-1?Q?kz8E63U3oCgnbYCeUNVaexjNcYalSlHH8z1yraviQj8j5m1JiZ0OF1M03p?=
 =?iso-8859-1?Q?8650F8DnwA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Nr2ubgCWIBYyyrJnAaC8bijfakMSmXoI2ub4HY+JVdAJF56oJE3jrxELNiTvi721cIjtxFWhcripQbzpr/6RVqVzrssNSUKgxnjphOngT+Kqp3l2gCHB3jMDAIka/G/2E7LyYbed5n38O3w6X68Y3joAklj19pEfLWTh+l7jIA0bwjeiRMPdeOjaY7KSAk9vt1JR6QkGeCo8SEjZ5tMO1S1dF94r545cxn0Tc6ZjA7oDQZMsAxvsWuPVRXNb0StDxTnC3M4rfUmtXlRjymwdMbneVyiH7ZuyoC63ORaAE4lAAtI35xNDMpUKDxsiWVikjrMFF/HDSeTwTGigmSwpgg==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eZQSXyWecQZAvyIE0mKWuVuFQwJlR0ZLa7WRpfjuj3IMqmwLSqqiYXmwVr815IASVIt10INoOg+EGR2ZyKI9nuuWo14qmLBV4c6v4GFMtFw3jKg6fUvLijDuHzvpSUmeyivc7XYfVyZ4OnYsJJ57snIsoSpC7wxlCSscWK95cST21m5qWcnp3Hq7wIM8iK2lIph1AUr5eQ30L4TY/IJqlE5xeb1CkKQXnZW0m0crjVNfccGSWTkK45yEuAkY2TD8Z0sJl9S6CNKofe7xXC+c9kOJgjzEZ1FZuQbPdaAWPhyWdeF5P7bGv2/LK9cfU2APnlHztcOX6/4XOdMJJY2SafdB8hb5uHIbqMZzezlyPQo1MHk1Yp9EZIaYCKC5Dm47Sj9xPhXwTxDy9dPhZIPERT9A7N84qXgxUDWNKEbTQHjP09uWbXJOMsDRy1/w3iuxB/PUTUnAHJ8e7pD0TEGJJyIr683mNJCigg16bfFNN8dq0AwXQAxQSlR20cdFHlyq74SUDxTWvNPQuHqfRFb97Vndc2THv3cRBMfCVs6WL/eZUbiATdki8EuE8bN5UU5FEBT/yhLFDSx4KQmeiB7XO8FpOdUl7MmUP9T/jfOcnziWs9ZanGqYRh2gC9pkbHmDV35d87+DOhj4AupP/1M9fQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d721a02-506d-48e8-9492-08dedde6a1f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2026 18:19:36.2474 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jD7hgooHmPF3CQH1/Bg1WYAlMywOHZbMcqSh08N1AH7pGWht58NC7CEl9gmw5XDTQ5BwmzQJH0mq5ve/6pFO0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
X-Authority-Analysis: v=2.4 cv=Zd8t8MVA c=1 sm=1 tr=0 ts=6a4fe640 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=jIQo8A4GAAAA:8 a=s0PobUhQxtb2yrBSvdQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE4MSBTYWx0ZWRfX7QUgjVlsLmVA
 qFF1j8yheORps8U7xIkB+EmRwqHR1dKRAeMA1xserYkgNk8inB6cksokeCCYHOQVoPWdHp4K9rg
 2yM8stGYklf77xNOswafX1SQXYsOhMsLnmPqqQAos+dVUPXAkevGoyL/2WpwkExBkA+BYANTqhF
 2tnnvQ4gcCCpT2qcwDVrzyfkRF7jPOTf6V84GoSfRUf2hs5O/90yZLp4XTsSrUrWa+BTtlwKT0H
 RsVdsD/VC8IDF63lL9qa2kCQ0FBCA3uOqfWi6pgk0307b1iVigSfR2gv/hRMYOggGp0BFlALNVj
 PUMVWQlThEf1XchUvLAIufonb2qAseJe7N9kLLT5eWD8O5ZtnoqvfpSkBwf/l7Twiwdi5rpKwxv
 bVIAw4K9yuFP41Uu+A0DBY2VehwzYFFp8TDcUEOWiHU1jUDytl/onArntli6KOl3zGq1x6ZI7v7
 r902IXABaGG8MvdrcqQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE4MSBTYWx0ZWRfX/8Kj8o9cadVE
 3oKigVjugKiegtBNWPpLe/NI3DyPv+LsiHqXCdHrzpN8KJV9XYOFZTXz542nswUmpkLJTFhI4PS
 E1xDnVDrsQyiFFVIC+3ANOeARGN3GNU=
X-Proofpoint-GUID: RLjzCep4Zu8BnYnEXcY1DC87pGld9wRT
X-Proofpoint-ORIG-GUID: RLjzCep4Zu8BnYnEXcY1DC87pGld9wRT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 impostorscore=0 suspectscore=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607090181
X-Mailman-Approved-At: Fri, 10 Jul 2026 14:56:43 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Dan Tran <trandan@synopsys.com>

Populate ss_descriptors to support SuperSpeed connections. DFU is
control-only so no separate SS descriptor set is needed; reuse the
same descriptors across all speeds.

Signed-off-by: Dan Tran <trandan@synopsys.com>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
 Changes in v2:
 - Removed internal Reviewed-by tags

 drivers/usb/gadget/f_dfu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/f_dfu.c b/drivers/usb/gadget/f_dfu.c
index ca8b36e077bc..68d2ec7ebbe8 100644
--- a/drivers/usb/gadget/f_dfu.c
+++ b/drivers/usb/gadget/f_dfu.c
@@ -227,6 +227,7 @@ static inline void to_dfu_mode(struct f_dfu *f_dfu)
 	f_dfu->usb_function.strings =3D dfu_strings;
 	f_dfu->usb_function.hs_descriptors =3D f_dfu->function;
 	f_dfu->usb_function.descriptors =3D f_dfu->function;
+	f_dfu->usb_function.ss_descriptors =3D f_dfu->function;
 	f_dfu->dfu_state =3D DFU_STATE_dfuIDLE;
 }
=20
@@ -235,6 +236,7 @@ static inline void to_runtime_mode(struct f_dfu *f_dfu)
 	f_dfu->usb_function.strings =3D NULL;
 	f_dfu->usb_function.hs_descriptors =3D dfu_runtime_descs;
 	f_dfu->usb_function.descriptors =3D dfu_runtime_descs;
+	f_dfu->usb_function.ss_descriptors =3D dfu_runtime_descs;
 }
=20
 static int handle_upload(struct usb_request *req, u16 len)
@@ -752,6 +754,9 @@ static int dfu_bind(struct usb_configuration *c, struct=
 usb_function *f)
 	if (s)
 		g_dnl_set_serialnumber((char *)s);
=20
+	if (gadget_is_superspeed(cdev->gadget))
+		f_dfu->usb_function.ss_descriptors =3D f_dfu->function;
+
 error:
 	return rv;
 }
@@ -826,6 +831,7 @@ static int dfu_bind_config(struct usb_configuration *c)
 	f_dfu->usb_function.name =3D "dfu";
 	f_dfu->usb_function.hs_descriptors =3D dfu_runtime_descs;
 	f_dfu->usb_function.descriptors =3D dfu_runtime_descs;
+	f_dfu->usb_function.ss_descriptors =3D dfu_runtime_descs;
 	f_dfu->usb_function.bind =3D dfu_bind;
 	f_dfu->usb_function.unbind =3D dfu_unbind;
 	f_dfu->usb_function.set_alt =3D dfu_set_alt;
--=20
2.53.0
