Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98E1C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:54:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0134C84B48;
	Thu,  9 Jul 2026 03:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="CPDbS6Rn";
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="YHLAVgv4";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="wmUoA8e6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FC7D847AF; Thu,  9 Jul 2026 01:04:47 +0200 (CEST)
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com
 [148.163.156.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E348A84A51
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 01:04:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thinh.Nguyen@synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668K6OFq4001439; Wed, 8 Jul 2026 16:04:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfptdkimsnps; bh=JcUy6WtMuhpGiw/k0UM
 M0UvQOC0gT4OlnsF/x5IK4eU=; b=CPDbS6RnKJnriXpA+lBcSFozvyiuykVsx/S
 yIFvTPJP7X16xArrtjxiVZWCXE9/UOQk5i9sT3ReVG+VJ9LL88GYrZe6PQ5gIBEj
 s2GGRj8XL/5KiLyBkUvamPYI5PGgBMmgMwA3rVSIDlvMkoWOZ4VQEn5ebtcQ1AEj
 Jmd51LrQ1GL3g25nkSazT4kv3V+1Z1zDomVeRSeK0AgbH8IHdVltknWRSArli+pH
 okPQp2okPsEqQgELr7dwdCnO50n1yt0Cu3HWI0W8tZqoXC4gRPcFUdaMNt7MLt/E
 pbltLtY6pVoNAl1WycjaFInTrrnlHjKfzFVINXG26qh/hbwVhIg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.87.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4f9srbbd62-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 16:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1783551863; bh=sYKx9T/JhGyEAQEOPlFp1Muqr2lDaEdhCcbn74zzaWA=;
 h=From:To:CC:Subject:Date:From;
 b=YHLAVgv4Elwji7/MOGnVuEjNfJBGLk6spHQnrcb/BZUgm9JvJ8FCAs1fhy8UQGV7z
 Cq5C6CplzoeKosVzTQTq6PdX0ngrO0IqHSYIKtbzd/K/s8DooeIAe3BRp3jPM8ztrl
 7ZC+BM2ZrUhv6c5mmPDsiYhCEXwTDDm4DQsqoZQNm2ZTM6EbLnl3cBD04kJBzqO+Ha
 EtQk//25JdEYGCzY3XEJKEiigD02+4WIovxG73VfQqWsQLaVvBs4QIOhIO8PWXa6Jy
 KvmApFT4idgaZ/HSe/zZMvWUJ1B7RiDb6XOLH8HcBlWzSQKSUvS/1OQMv3I7UY9uEC
 kZCdwxdI0d7kQ==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com
 [10.192.0.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 304684011A;
 Wed,  8 Jul 2026 23:04:22 +0000 (UTC)
Received: from o365relay-in.synopsys.com (sv2-o365relay7.synopsys.com
 [10.202.1.143])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 86BF6A00AE;
 Wed,  8 Jul 2026 23:04:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=wmUoA8e6; 
 dkim-atps=neutral
Received: from DM2PR04CU003.outbound.protection.outlook.com
 (mail-dm2pr04cu00304.outbound.protection.outlook.com [40.93.13.60])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id EA151220384;
 Wed,  8 Jul 2026 23:04:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Up0NDHE5XI3ZDZ/iH5nDCuGlJiOy+U9qoYWe6kMVS67WlS4R8+yjZvLs6zYxh9jtAZtZLi+hkg0vyI2YzJ2qGKvt1LSqDqMl5Ojoc0A8T2UDExEgZLm1fBLUSydE/Na0sGUyXV/cJNgOMX/imCdBSmjBriXabgNpIwOJ/Ml+1/F0gCGGoIpPNxaOProm0lQPqU1iLpo/etVCwUuJg/GE4+EGfJ7pSn8VzQcAFf7CO2vmvl949E/T6eeClgoJfqu6YxjjnrVzDvJFRNfp9OOXCqj2cH1WvJbWjfdtxQ1dpoBXX5KDMs4wd7DYSJSApJRoku1pAbBt03VJmG5rBARjtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JcUy6WtMuhpGiw/k0UMM0UvQOC0gT4OlnsF/x5IK4eU=;
 b=sy2teGtR/LhhN5xRxYyt0rEICKiZ4ja+MrWmeV7KjE3UPKBeCSRwKxMVidUHU9ieUozwvSfETvupbpv+lu9SYWHiiB+UtFZqxpO8Hd6m6c8DPVz9bpszC5srGIM2omwZkqE1XqykZYJVrxeYqbIzOf8VqGFlTTgkwm9H2DL6lQ/C6ke7BIDHSpKPaxOwrjg2TgQd6keGJw3KK/2SmwoE7Ez/dpezsV6OyGcrXznm0PUaCQpdbKR81S79JsReMl7FeGwwYL+pojvcjdctJb5sFq8fhSyGOL3USfOeU8UTCvz7PukaU08xoCUNSORHnUCXdAOYXuUABi4PR3G4rqqY0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JcUy6WtMuhpGiw/k0UMM0UvQOC0gT4OlnsF/x5IK4eU=;
 b=wmUoA8e6luXs6PHDHgGhIMHONw8qAMlnBgdQL93ag+577VRS+VblLEgpxBBc6RauH6uHhA/p+hYGQ8AzXrB1riLKsYlYBWSSXEKToEGlNhjLEWu8Y/gFsRHo1GUt1UAf2mZqDrvzEld+euP1aur0DEuir0a3KVPycxddkJb0mXw=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 23:04:13 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 23:04:13 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Topic: [PATCH 0/2] usb: gadget: add SuperSpeed descriptor support
Thread-Index: AQHdDy4Xxj1ueZVS2UGU+zbJAT6CDA==
Date: Wed, 8 Jul 2026 23:04:13 +0000
Message-ID: <cover.1783551505.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|LV8PR12MB9358:EE_
x-ms-office365-filtering-correlation-id: 0f5fc212-860b-4183-d78e-08dedd453a35
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info: 9K1aDkdCRV4nMoz0MGkhwG7NhLbT9iu3YSCTvLkVj/PyMqCxVJcpD8DRlKaQFVrBDd5cUQ04nmBjgMSf4IjI6QPDKM8ksgnD3Yo3YmuiSWXLyZ26nGG3mSjBmbOrTHT/eOuW/HCx8o3wal75kG547yqqX4dH0ctHJ/wPmAlcf5lMmP+XGBueBUns7kKpIDTXXdzifZG9Tjg+Ctc0JwJMY601gBi9DGEeCWUyjmS1v4j+4TudxiBUM80/dSf+gWu7PuKnoxWLOyJM3B96H7p2FnciVqgrGUF5Bzymy+ze6ql/cEW+7ecZg0R0ZedCmQOgniDAC/6+cUOJNKXlEQiP9GWGE8lP04i9pP1l2wDQQboYXegqCyzvT+K7vjuV5FZwtrItf1jwQT+pj3NlQKm/84iTOSKFxbPgH7LtVOZ7ceCubemoD5b4U3lxfBQKK8CsxT2QuDhUBefPtMSaSSaPqwJLOnAudm3c3ugqzxTdFvvcdPoqBiWI1hUq8MoBs5jKi4B+wqRKrfNNT/UaVyJLEAm7Y6x3Xsk7KOEZY1dVERJaChB4cspe0sgXWM3DhrtAv2FFhIP6WdEXwTi9joskSLd8c4YKESrhGaTGoiL5Dr4PNQ4ejdzajfcMaMdCrNF3hPrOGWiMnUI5fVHDFFeaENGCXlcl+76QoxInvOEIa+anEqepIkrQJLC6WTNWl2E2uo3i+OWtgBP2nQWVyqweZrZKQP3G0eUMtAwypkbw+30=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5YRe2EDnPcfY0PJB1wOxXlEGpGooHDnLa+QgrmlOPAPkCOfrkW4hO3seH4?=
 =?iso-8859-1?Q?gLp/fXfvY9r8DvgJi15jdGIIPMa4jHmO3qwJkyRpofuAYPZg1aegfNUKqo?=
 =?iso-8859-1?Q?pPXBrLbsNEZ5Kam3y9/B8GCB4h0USyXnVGPzToKXP+C6rPwKCwL7x1XPrN?=
 =?iso-8859-1?Q?GFF+Xp0Wu+Mj0cIYySuX/0ImkbA2eVSikFjZeZF4bZPkaRNu+iP+Rb05ed?=
 =?iso-8859-1?Q?biXInVrJvU0ewEhJeEjufwrkMlujwvxKTBAad26rspkTETl/BCH6rQOzZG?=
 =?iso-8859-1?Q?XPkNmdtr/oNUEGR8rqGzoClJV6RXNSOvc2VId8tAKDE/t1jQdMhCibTU1E?=
 =?iso-8859-1?Q?oRBRqXPYJgiLq8VrbXH8di+TyZksvJ3q5+CrPaYfdOFmplVtpSa19/A8/U?=
 =?iso-8859-1?Q?TS6/Q27y2iMT5DiDbfNJGrdv19BfGJjVwWaruP8ED7xZlDEvwm+Suf9tou?=
 =?iso-8859-1?Q?wkoSfQIIOKgHLF6tuwOGkBHApIqtHMTnP10B+/0aqFDX2zqnii0FdJtYDZ?=
 =?iso-8859-1?Q?RkFYykau2yG56FV24dVd87elLkLmSOkwH37HT6P1Uobm88rinQ1WgEQIxr?=
 =?iso-8859-1?Q?LnUFNxTwSKi4p1ZVjqtffNJT1WPkKTxwueDReuan4IYyzwTfR01Yh8/yeV?=
 =?iso-8859-1?Q?CNXquqUAkicGQ2GCH38hPQFRTMRi4VBC2mQnWekmMuRyBh2ICvKEdOt2y0?=
 =?iso-8859-1?Q?dIKJP6rI4fHmmlizCDvkNs/XMvFZ1bn1yH0oRlHw951nmI4wg9EbQYQmTo?=
 =?iso-8859-1?Q?zb4DPxwC6Xa2DgUZgQqTBi0+qKV9CYhcXCC+gNXBUrOdY4i0+AARbPQMd9?=
 =?iso-8859-1?Q?QQ/hXqBhmQJrOotCcv/kbD2bX9lzYfwvGo7kNTBVVpk6+P6owbWyLxJ1/5?=
 =?iso-8859-1?Q?j7BUHtZZIdKHTUvEMDqQEuGEDjrec2jC3nK29p03uIfgRMRvGWkGJRuMm+?=
 =?iso-8859-1?Q?VBhmvG9LylmkzmFSe4PaV4a5IREB7f7Z7ylUdGYb7mj0vJWV86EzLbcfmP?=
 =?iso-8859-1?Q?VV5QXM+zme3A1QDH2A/xIUguX9uLT5iF7LJUz7gz7Wttkfk+5LUez6+m0E?=
 =?iso-8859-1?Q?FkHI+LykfQMPeZqVYsVqW7lGMla/6Kho5V+N07AU5ykCUpC/utY5qwHvfD?=
 =?iso-8859-1?Q?FaouAqUqoz5SAAcHAG5Xov2XViktPeuY1z12dolIZl1W1ITiVoZc2U6O1f?=
 =?iso-8859-1?Q?lRVtVa+QXTeEKe31OC33BJvjNSout6B5Yqp0+ScTaHvJXZewRn2rWNbJpy?=
 =?iso-8859-1?Q?xx3Xo+JC/j6f2Dr66ovtQJ2Vxs9Gcz5Ikh0NxWMfRqmO4yz56ZuaZEi/L1?=
 =?iso-8859-1?Q?KZ/KIWxi2fanC9U0felZAuCJMv/3NPhZ5RAfwwYjxKYsd8/YQnSosbtD6R?=
 =?iso-8859-1?Q?a8LtSL3sMDsEE4D8+AAZgandU5Zwa4f8qfhiM2uqm3UtP4FGxYZvVVBjwl?=
 =?iso-8859-1?Q?smtfQkgn5nx5bNkPTlza6+8GfFZX1fP5NtHclAgDOfvOgL3DvgwGJJ71G0?=
 =?iso-8859-1?Q?2QEcOcWLqIDU0/YFd56ZzEuOI2KjOki8kWGalznt+8FllliJBhG5vTplkG?=
 =?iso-8859-1?Q?KWDhD0EEn8A/sltfw2YnIrhSO/l2edJVZo90CtaNxWmvqLkuomMp2tzUCv?=
 =?iso-8859-1?Q?bKZgrnf8DO/3ki9lKknJJrjLD5dTyguHRyuR4xfVJqNoUb5+IjXYvmyfqG?=
 =?iso-8859-1?Q?KWb6qaAY1dtyAMhSDrp1DgCSW06va2LEXtlCp4qM1ourcY6PI7ozn6beNR?=
 =?iso-8859-1?Q?vbA8vXa42qvUffM4UCDwReYUTRlysg3Tc+xg7w3lxnkZ7KIogokszoc87y?=
 =?iso-8859-1?Q?dZkiRbtCIQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: jNcwmB32xw14T7xi/O55OTK8ctyLIH8llCOjwaT1yGk4DakLR4xrvNFCpYQ5yLY2SrLg+jnRFnFS1YDR0XCvALLxpZ9ldO2qdTiqC+or+a6dZRhVehbsiQRCWeDbp0+TXfeeMaB201MZ6b5ViFb/RtAVQlP20UtEz1nlU7iGVrn3qBA8idznNiUMIAmRDzfmb7sZ40sndaQUqqnbd5OKjSpYs9u10b77RdB4WioFoNYdZdFnTsXgJshSC6rCZyeUcI6kH/CjLZhuyQjqQb9Rm945utAX/K7qSADqiry460WYv7LAZerFa3n4OgTc2j3C+gproZd+lwBnNrypSTiP8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: c85xHAJgeYN77P7UICzRjYKtMhVUM8pls6OvfYWWfmBsYWLWIrPXF+J0JcoDV0DCHbpXqdFWd8kypLn9EYl0pp+IfgB/A/leg3epFGD6j2OcDQM0bhZZqV/WEqcoewFffSn+CNREHn72ceiQm0qWLpLvTzdD+9WYm8s4qZkJaKU1gFuY7sbOR+WzhnH5/VcOeo8HELPpYciT6AcussTPCS6dd91pgEl4Og581+m2t6d1AMSW9+LFhf4nMtRgWhCcbZVTI2G8b8ee2ukCthEKviOynY2q0jxseC8JFrS+LdS6gdW6bInjRsxbnP5J+H5WcVE7VA3LeCMvkDmE6ZJ4rWz0/FCtzv5JcjtrzXICJMhagUpUAzp8NnZSm52PeO6mdmiG7y6MWVN8vEHtvn5O8tYqbrnJplaQTz+/QAyTuJwuNZut6ZUa/d1w85wS+iJBsnbnVpwA+Aa5y6l5JaP9di7OaDi/9Cd95nisP1Nvi6ZMkLvHdtiiPzWkGdntx3PFLEgLJ270mIBTyxdBqP0QyWn1h5yekcbSkUU7wKyfWQsTQLLUMDPRuwHleQx+1On6/5XH/ypVlnpNwh1/qxUn/ungzS7rW7qjLdXjtrlmYVdrLjAzc80FY4n/ony4NfupFP/01/Fo151YMPwCO1FD2w==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5fc212-860b-4183-d78e-08dedd453a35
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 23:04:13.1662 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcTUBMIXLfM2DqDmr5djsQWgU6/j5ojwBtXpu81aSPnwV6JsP0lXOJaG3ErUT+McDa4lePMHNEGNqXHGEBTVMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
X-Proofpoint-GUID: 8SPGv93b9WAxCNWb_VX3UCFAUZDq9ECa
X-Authority-Analysis: v=2.4 cv=YbWNIQRf c=1 sm=1 tr=0 ts=6a4ed778 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=Wo6YDfOMAEstGd-0DxeT:22
 a=3FhGs3WUeaINx9rcAAoA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: 8SPGv93b9WAxCNWb_VX3UCFAUZDq9ECa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfXzf4VL8Yi53bO
 KHOHNQAx5zpaml96oGxKdwLtrIwMMRu9yNUivU+ebPt2Egd1VEGPhAKAhdW8JBuE8Jcz+s+xqCJ
 uq3wDRHd8pgbbk0wxw9itfZ4G+QOOBJEg8twuQKOWPCzLHXEt4qOGmRXotFPDILUy7147uSnKLn
 MPJs6SqOdyyEsVEqHFo8ASROChP7FtS2cJI+amIoeqWZGnPT2x48iW31jOZmRzPqeeCgmcZTBhp
 /ypLL4hbk8j1SAREbfl3hiT3CGlZ2jOifU6vOXX1jPcLJoPP8YbaTczzfqDCxPtuxnZMmLgYrh6
 aW/xrVqu/9Gl5vVZhisvL21mQcGP1VtCHBe+qFyX2z0H5qR1BQ3lOoZ1SLOTFa7Fr+uIENzXlO1
 e2FJOgS9yGt0BU8GUhiv1xDLNpcFSG2xEl099/UgNLrqzDfCbX2VOCBiADc9MkmVaruoZ80ptKS
 VfeR8oigiGjos3G3tTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfX9rvvPF7TnbEH
 TIxZYhJRCTdA2GMaQC/Edp0jogHgpJegUHtn3vIdPKcZbku778UOTau4cDMmg+O4kg88YwWYt7Y
 e4jaqZAmsK7Nij7jVW7ATkg8MPAIhlk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 priorityscore=1501 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 clxscore=1011 malwarescore=0 adultscore=0 classifier=typeunknown authscore=0
 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2607080226
X-Mailman-Approved-At: Thu, 09 Jul 2026 03:53:42 +0200
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

This series adds SuperSpeed descriptor support for the mass_storage and DFU
gadget functions so they can operate correctly at SuperSpeed.


Dan Tran (2):
  usb: gadget: mass_storage: add SuperSpeed descriptor support
  usb: gadget: dfu: add SuperSpeed descriptor support

 drivers/usb/gadget/f_dfu.c          |  6 ++++
 drivers/usb/gadget/f_mass_storage.c | 25 ++++++++++++--
 drivers/usb/gadget/storage_common.c | 52 ++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 3 deletions(-)


base-commit: 913fedc816570c07bfc7f9c4046dc2a3a55e4099
--=20
2.53.0
