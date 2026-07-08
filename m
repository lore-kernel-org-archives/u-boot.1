Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AA3C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 01:54:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 394C384B51;
	Thu,  9 Jul 2026 03:53:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="MSIhsTwp";
	dkim=pass (2048-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="cQXojCuD";
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="NiuEMk4E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30ADC84A8F; Thu,  9 Jul 2026 01:04:50 +0200 (CEST)
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com
 [148.163.156.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB161847AF
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 01:04:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=synopsys.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Thinh.Nguyen@synopsys.com
Received: from pps.filterd (m0098571.ppops.net [127.0.0.1])
 by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668K60H83831364; Wed, 8 Jul 2026 16:04:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfptdkimsnps;
 bh=Nej7DUH76pp6M9gjImu2DGAa9yw/QHpOqSn573FUtgU=; b=MSIhsTwp1g2d
 kOW2KUKiKwtS85LwLjXFXok5X/XhsmCHD0fdJVYNPcViqxFpOFr8jmjC9E8khm4D
 ZAyIHmYHBCPyp+zegxnSFIk3tReOLwOXGINybqOApsv3MyyDZvkO5aAc2OUJmbW5
 SVFI0fSdORj43fhsxh2ASjYQaVpJ1DL93s9jQedjqf3ru2rmzdbx8U9DR1uPrkiM
 p2P39Iqd+bdI7JDjw4KVMSrn/6lnGTmz/TAixKv5xAHztK2VIFXnYBL3gWTjIKd6
 pi3Q+sc9I94txqEa9nfUMAwCKqrA8VrCJ+ByOJo1RT8Cqp0O9cxzeWFfVxCzEiCY
 mPscSVWLUg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com
 [149.117.73.133])
 by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4f9w8r93us-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 16:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
 t=1783551874; bh=SksnNz17aReRGOoWyjq7gTEn7dVg3+pccXyUfrhA3Rc=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=cQXojCuDNOgYc2xXCqd28wsUQdcICiIfF9eTjJR0LPlw1i59c59pJ/kjhLJ6Uk2At
 lI9Mxyya4CF0ziBkt/fIY1IKyZ/2CVc77Qb6YaFUVzMVrimniEHTjvfBfDs64BWApd
 mEy/CeEO9hKhsKGJx4SpGyUWMed0OCd8gF0ti0pCILezKo+P58joXrviiJzTyNcZwM
 W1/P9Pvc78jyxGkW7IkUXEln6C0ZG8Zl+h/XYiAcR5+Cwbu1XE/hHBLdio0w04uWZx
 as+tTrpjKexD+HyTuw6SdhVrW5e5Mc2fHa3WYnbGE4XGpTwATyJWk94pcQD5qc93ut
 Q+uym7IK5qYRw==
Received: from mailhost.synopsys.com (badc-mailhost4.synopsys.com
 [10.192.0.82])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
 by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 7ED0F4012F;
 Wed,  8 Jul 2026 23:04:34 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com
 [10.4.161.137])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits)
 client-signature RSA-PSS (2048 bits))
 (Client CN "o365relay-in.synopsys.com",
 Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
 by mailhost.synopsys.com (Postfix) with ESMTPS id 60283A009A;
 Wed,  8 Jul 2026 23:04:34 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com;
 dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
 spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; dkim=pass (1024-bit key;
 unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256
 header.s=selector1 header.b=NiuEMk4E; 
 dkim-atps=neutral
Received: from BYAPR08CU003.outbound.protection.outlook.com
 (mail-byapr08cu00300.outbound.protection.outlook.com [40.93.1.104])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest
 SHA256 client-signature RSA-PSS (2048 bits) client-digest SHA256)
 (Client CN "mail.protection.outlook.com",
 Issuer "DigiCert Cloud Services CA-1" (verified OK))
 by o365relay-in.synopsys.com (Postfix) with ESMTPS id DB0DF40342;
 Wed,  8 Jul 2026 23:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt5pjbTD5jw//6tCUNC0jPt7PUIJhfOZ38gp0kF3mUR5k5Bx2pmjjkObuPup83FMnLwHTkQ6T9guCwD6UZ2WCK/F9o1Q11ZNE4frUDVBL9qbZ0bLZ4yhPdAG8KOD9wfTetaN7gCwE43o1OZ+nbG8l2Brw7ziaMh1PZEd/D+MTI9BIT1czoTEu/RjeMqYQihyziQsuBOnnkMaLTxsHW5VjnposmmyhnmrbMvXzu0y9Kr3FoD4STj8/aqlSvxWOm0z1mxiccDmFa6EEMiVHiG2qjiiJlny0tjJCHtIVBHqUh2TFe6Uvl+LWAsS0sy7ULz3n08unojnbqCWWMntgrPinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nej7DUH76pp6M9gjImu2DGAa9yw/QHpOqSn573FUtgU=;
 b=U8bcoPGH36iWLK4hgCntrc5aYzg1Yr7gUxRfkxe7uy7bLJFojOk3Mmqw9miOcBPVSbWpaEkz3w8c8p6c4loZei5dXs3wlf806TcYZQCLYxi44PLgh3vLSevD/uM73O6Aa2N6/Tri51P/uBNR/Cy+e/4lBy/CrqZZbeR8JeUmIVgE6sw9WgY0CLNwyE44m1VBo5i+2Wuxu2NM4EQFbh2pWm1IJAifYJxuYF7/VE76ZIW4hJ1fg1qdz9EmdctLGmZcH4cSKAl1UIEyRolxIBtpah6tsiCrPvMinPQGKGAPaneQSaxKQ/+BirglsEF+v38RT4eBZeZkmYu6M7KsKStg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nej7DUH76pp6M9gjImu2DGAa9yw/QHpOqSn573FUtgU=;
 b=NiuEMk4EqqD86yYnC1/KBOoqIetmV8VCqQhtDGE4AcJic7zk7IewrbyaO+A8gCLxzuYlFGL/KY2dJMCLpro949x6Wsc/9uneT6z88AyscjCksKPz3do1vQs3zZ7NKxEnBwqV1Hpr8LLnzcQZstCJKRQVWwSJ+KPej4+t9nFrfH8=
Received: from PH0PR12MB7486.namprd12.prod.outlook.com (2603:10b6:510:1e9::6)
 by LV8PR12MB9358.namprd12.prod.outlook.com (2603:10b6:408:201::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 23:04:25 +0000
Received: from PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109]) by PH0PR12MB7486.namprd12.prod.outlook.com
 ([fe80::7df9:b25e:9216:f109%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 23:04:25 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Tejas Narendra Joglekar <Tejas.Joglekar@synopsys.com>,
 Dan Tran <Dan.Tran1@synopsys.com>, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
CC: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: [PATCH 2/2] usb: gadget: dfu: add SuperSpeed descriptor support
Thread-Topic: [PATCH 2/2] usb: gadget: dfu: add SuperSpeed descriptor support
Thread-Index: AQHdDy4eLzZU3JThXkqU3E/MHCl3Hw==
Date: Wed, 8 Jul 2026 23:04:24 +0000
Message-ID: <9535e0b6b8fac3552a7001353b203c89d1b3c753.1783551505.git.Thinh.Nguyen@synopsys.com>
References: <cover.1783551505.git.Thinh.Nguyen@synopsys.com>
In-Reply-To: <cover.1783551505.git.Thinh.Nguyen@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB7486:EE_|LV8PR12MB9358:EE_
x-ms-office365-filtering-correlation-id: d4baaca9-7c01-4e4a-c57d-08dedd454132
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|56012099006|11063799006|6133799003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: A9fe+xxa/MORFiZRTPj5MjtVA9Ooy9MyOo3K8AaAG9auvb6s0KGNsHGjOA96gCDFQUiz8nguKWYISWDRIjW39wnYTVk6CTrPaWX+LjbbX3DIr7sI05UtUSJ+xuhCpiUxpvyPzx76YGu+muJnYhsVGSh+5KNWXS8RJpktJwm3c01QlIvoC+uPzKhOMu90+eMORLGWx/B/bagunzf8a+SA1lVguYfl7YjJiNVN8sX0qSgwmJI0QVBhPzg/3MzTbu11j7y1drq81udshx8IR1MRiy38U5F779H5hHqQtjuhnoDdib3NQ4RzEEqWUdom1RZp4Od/YaYa4aihRyi10575jNO4hTEX4nd+fh4mtKY1gDTyRDJZ5s4sO1FXnSf7cmhVMqHDTtred3y4nesWk+8YL5wK6wUyLQb2JvrPza3k4QEVFWQWJ2lkbUGAQTCbH7y3+vlX9orZ+yP4UzDJ9uW4uUjJYJu3YrloC6vewI/K5KfvKHH8rc8dvzTPVovCNHZAfy5HOh85Zubx9Ev0OF6xA0m1ALhczOHa1TnywyI3XniaF/jyaRsMlNyQ/sxi+QjvLjYITx2MRytkDUJ/YI5hQXQi0sHhpb4xkIaCB+b3xVuVJrteuZYYwrZ8+ucgWQofRFlL3QnV9U0Mgi+ZGwtJdArE7HAPkxPygJJUTTkXOZawspVxNiveXIQXAnra5shPlwEryOCb+KrwHEgr9wavQaocN/nYpYr+Rb69mheGC9E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB7486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?YMgOdlrZwa0dc2Zvmn3k+FCppHS1PBkCS+wNgg6NQZ+GfrOTh0MFmLd3Vt?=
 =?iso-8859-1?Q?6ymDjPbBd5Yv+W1ugtecg1U6ZWHdvslhNEwDG8pExrBbmyjjtgjrgWb8o1?=
 =?iso-8859-1?Q?rR9EvJ0BMEgO1W8Dx6tjSr/vbBTvsWNNrZRa5tvimePHYzPvRq7gRR1Wad?=
 =?iso-8859-1?Q?b1brHWPLs15WJmNjzTbxgX7DaTwxcE0GN1/Jr2RcwfXiwxDVLn1sllM1J0?=
 =?iso-8859-1?Q?2DGEXXQhttkn5eRNM2BEZzrFJLtrE7bsDE1ZszjJlSte96to5/48gl9YlH?=
 =?iso-8859-1?Q?cRvNvwU+BKc36kjZYnsqkeRRbAw7Duqv1HzH2fFaoDSfOT+kHC3f1zTRkK?=
 =?iso-8859-1?Q?gpWheA/B/edZuohlpvxrLO4cgwzbSXYCOYONa9Yi+lkVoFxEnrgPmXnopj?=
 =?iso-8859-1?Q?nn60EYqUdc16q8wuhhJ4ax0eslBGaqNMM+GgGx9vSocyJ05RVrJCP4jGhl?=
 =?iso-8859-1?Q?3MqvH0mcUTHujqLfVgRUx/amoFnOcbjOUbH+9y/mFUPTFX/ML5Og/5lfew?=
 =?iso-8859-1?Q?8EULUwT5kxQokx48eIbH41B0K+LOg4yQuUdrnBs/HVxvHfhW+0cK78IRH4?=
 =?iso-8859-1?Q?snyY+Ln+wPDlD/pyi3Ixd5ctrRD4VlDGVpljH4VG9D7k6Rqgyi6Q5+V93n?=
 =?iso-8859-1?Q?GIOw87nGnVlKGA0xTkqOULyRCFa505eI2r0XsvQSFoBEtCF+wtziRUFFZK?=
 =?iso-8859-1?Q?+m0L4Bg2Qb6JyO0vuwaFnQZ7YXII+gwNEMXwUmk9OOGhx4e6DvSXOpaj0N?=
 =?iso-8859-1?Q?9U2JaHOVY4kagKppTg3wutS0MhPGKNUde1d7vn0liBAZYxAqfi1+1MQpLE?=
 =?iso-8859-1?Q?jJzAqC4JsqEWJopYNLsdstClfm0SifCUmUkrP8jMc/x61XVlZSXlmsDhv7?=
 =?iso-8859-1?Q?wLm88BBY6kFN3mso80fkuya5XQ/DYkCqgOb0DvbsCBLiV+ou9EmzF2P2aH?=
 =?iso-8859-1?Q?CjWZUhTYQ2Ip1uvPE/LVPLzbJdTXJqfZIrh1RNXW+MQ4l16jgPYS2VDvXO?=
 =?iso-8859-1?Q?k0ZevEK1E3jhwM9YJA5NBpXmRuBsYmdL5GPD8EAVcBpRi712nV4PrOYqWl?=
 =?iso-8859-1?Q?sCt3qMghqljEQzkgrDTrJoBAm1zzzDW4JX0JjcRyXNInj08yA5e7xXnfcR?=
 =?iso-8859-1?Q?fUkUw2ZOH7AskzsIWqxxo+4/fPoNsvF+J+a+QfplqjDidxTYTKhP8sV9jZ?=
 =?iso-8859-1?Q?+R+KOHmW9RIRlmlz6KNET2STgzdIwquUT+ZfstIpaPcL++/6jc10rptL4Y?=
 =?iso-8859-1?Q?fXV9uusixQJ+bBrpXhF3jZ8rVmvOkHPZWXiUj4SSolgm3AHVx4nPNk+FoH?=
 =?iso-8859-1?Q?hgRkvAi0a8FvZOHWZK3Nj0p0yEu8SAQodXX93N2hTPv/MJqgS7G3yx1vhf?=
 =?iso-8859-1?Q?llVu/vM0zeVIt9kc4c1lk7rfs7SlqJT9Uv/TA1+SWthQwL0R9/QwXhqRno?=
 =?iso-8859-1?Q?PN22KjzpmcFua/HPasw6OaAhbJGRW9H2WxAhK5Oh85qrMMXffIuSBrQJ/n?=
 =?iso-8859-1?Q?yDy3l+Z5/ZX07/3eQndbMgRwKhBtkQtLWPvwbfBX1AyOCuOpoGRUSz8AWJ?=
 =?iso-8859-1?Q?zOWu6D7LO0SWfkNslMVtQkqseoNU40gnQ/PYHLRgZFAx70dTbH+JmgllVS?=
 =?iso-8859-1?Q?0A4m86izMchTEDoF6L1CyJN+y5H4cTA4DRy3yI7oCTbkb9LsqAtnG5tcRQ?=
 =?iso-8859-1?Q?QLIcyiPfgt5GNSK37q687bGcYYZ/l+XklUxv3MEPC+DaLCnopzWov3BbJM?=
 =?iso-8859-1?Q?gR4gr/LRm/jstTPUekqzovw46EmrJtw/tgqLIvC8bFk3vbWD3RvtXrdpNv?=
 =?iso-8859-1?Q?Zgqq0EXpRQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gt6TRMycjMoi3D/G64ZlFVnYRPl5Ui+h29GIZYmu8yAGMiG3Z38L0VlG/mm+bEuMsYNkvUDo3wGbzcEN2/+mY7JtiYrEATwL2BPrJmrROxR9+OtR5mPjsRAiBoZs+uvO6JKKsF/7L4vqnDx6wmFRFwY7Wr6h7NRIi/n2hKfBxU40TaGwwV1QJ3W74HwPRk5fHScx5umHwDEqCTZxnNFJ1hoQYB4Hj6mnhmPLYLIb1KbW6K8ZYKWT/bbDUeCxxJx9K7l3+2gJ8Z1MRvZxjUbsEfHcgSfJrHnJIEfb0jRirYZCFpBv+UWgPQ3sZQoF4PGJzi3QpRT2iYXpMq9Vmf7C7g==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: xPmGo2+Bq6V/SHxNeWllj+SbdykGOz3O0rvBhz6eA+ewea3OBrcIydE0BdP9gvRoreULETTH2zLcUHadD26ZUcjyz+fn1v3TB5WLBaVsq5KkHCb2bUfZChL0EgMviltJvV8pCI3RldWaLgMGlcUL9X5/p5TIW7cEAT/+AUTIuzEGyCytic3FGdeWZRdooJ48ZF9sKcRdoQA6ybrRLBkNBMZsCK28dLLyRH76tBh0El372P0x3TJIQUu6j5SOl6ZekW/yXBOp4GxFib0vhya3uCqLJVfEQbWOdCvs5kN+Eaz32sZPZMiQrQ0t6+7dCeEuQ3NkvUIWMHxfrvObDA5DffUDbiEcwJJqMiwInpOPOaWdWxGe9ezyGVrk5tfyT7ILpPHlh5mp98jh6I5y3Sz772gE/9kf2DtSW+qinW7zPQQ1h1qBOhD36IcBAEtDsZDzbQvd00Zi6PlmR0ieCo4T53SpXPcos377MJXQ6XB1pfNYB4lUMI2f1xEv4fwTjaEjMFsvB9TH7pbWDBEdznCwTVAq/4lyFWX1lZUBaObng+fN6/0R2qA0UrJrbhsnOsEsFBT8hzXbuYGES2CaO4QJmGCdaeUl5oOcd/9KM1HuSmAIvKxp0gsPzVh2fzLIlolxHRvwxRxRUMmMQm0+bzpkzg==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4baaca9-7c01-4e4a-c57d-08dedd454132
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 23:04:24.8978 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jrSRfO67CyC4WU/ivN+dw7u18o8EXHtFE6KgcZTahGpmEkCnumkh5FjZTPSz3fwdRv8X0Bm9DkFwmI6zqQJG1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9358
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfX+MDKEBKXactv
 1N9OzxTh2BkLZ6u1HtAq/KO2pdvHdgSREv202dJf+dDq68IbAQvQ5Amz081mM6/uAkrKuMtlYY6
 g0cFUQNvJXbAnyn6B3JuJAe/NMf3QmE=
X-Authority-Analysis: v=2.4 cv=Icu3n2qa c=1 sm=1 tr=0 ts=6a4ed783 cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=xKlp24NoqlmsZ8y70KjX:22
 a=jIQo8A4GAAAA:8 a=s0PobUhQxtb2yrBSvdQA:9 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: P-wAi4pW3OIgZraatsUq9Tn7R0vAoPv4
X-Proofpoint-GUID: P-wAi4pW3OIgZraatsUq9Tn7R0vAoPv4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIyNiBTYWx0ZWRfX6SnPP8VAE0qZ
 NvQCYe2XyB+vSRAgz2+n+neiRKienHHtQ8V2NTfbYMsLEa3gwpC0zbiKs4JZ9oikwuG+r2O6tYR
 jjZsEw03xvUllq6FFEVi0kZi51Od2jPTVkyvXvxGpbacrDWxw1U6YxlJDYN64kelqRCu3k9mW8w
 3+2g5H+gnIFytczLURGf60i0J+yrH0CrgBgWMBjk5eCa5cEjqKNGmeu2OuSwOUErN1ylU4XaSnZ
 8d9P7tvXKeKp13vqXxDT4Y6WDw8Jk3YYylDkp4xt3N50cTwGvUOVP2h9ahf2XKdketZDSCT/YE8
 3C/g43M1FFWhY/HIplDYB8SHIocXKymuctD1HGUj2MhwoDK3Y5dlqeThNAWL7Thcxft4Cj7Ag88
 Hkvp/YJGBWncMR6/2XG2vxPjGuNlw18GQCin0dGuNco3iwTcU3zs5bfTh728mtm+4JArzKyskML
 ESshXkxErbgL5ENL/8A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 clxscore=1011 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080226
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

From: Dan Tran <trandan@synopsys.com>

Populate ss_descriptors to support SuperSpeed connections. DFU is
control-only so no separate SS descriptor set is needed; reuse the
same descriptors across all speeds.

Reviewed-by: Tejas Narendra Joglekar <joglekar@synopsys.com>
Signed-off-by: Dan Tran <trandan@synopsys.com>
Signed-off-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
---
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
