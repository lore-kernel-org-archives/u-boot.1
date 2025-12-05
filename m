Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BD6D2CE11
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 03:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB2E684129;
	Fri,  5 Dec 2025 04:17:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="lf4/q4cC";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kL4baq7/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFA3A84181; Fri,  5 Dec 2025 04:17:23 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0B1984129
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 04:17:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: df58a1d4d18811f0b2bf0b349165d6e0-20251205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=+mnmbdefwKN7+koWuj2t7ofjbsMSuQgBkBKdtz17vks=; 
 b=lf4/q4cCV8I2Q/fcxlULv/eayx0zpTwABjdj4uU3Gk1+ZvE5JBdhXcoJ7Nzb1m74h4fzpVduOQ73/rby77Nm/bmHhuapnNDHNdv209UlvLGGeGm691qDee4Q/WAMV6FmDLyWrN/jaMEupgehHRWnz0PeP1x3PAojbwgqUoSxvXQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:f27eb805-e1c8-4315-84f1-224f78b13ed9, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:1c09a8b2-13de-4936-a6df-52eb9b61d285,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: df58a1d4d18811f0b2bf0b349165d6e0-20251205
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 329250634; Fri, 05 Dec 2025 11:17:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 5 Dec 2025 11:17:02 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 5 Dec 2025 11:17:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8mVAyr5BNyj6rJvsRegY/Wu3yz1alXJn+42yvGuPGrKc96wQ521k1GMQvmFSiJpJ3XZdjyZp3wC6VJZ1DIhOGWok8r/ZXbPrHdNBKQ4O9ZvOqbqSzo4jjOinq1YNOI1beuV0q17Qb3gk5tRaJquqrAWE0EZ/Ro1DXYqMfKgk3CeO5FHxdpqNgyi5ir/FLHK/46046Utrz/1NBHTAA6rwMBT99Scmv5Y0sAPxp0cSmClDJ5yb5D4rcTdK4mXowmEVAiQq06Hp32aRU3Q+pvAuAx7uU7UHIA0NWAnmdvnFIvzDNuOr66hLBVkJJrfropeCVyCFAf0JsXVMLo9uRLswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uf9Cx04m2tNvFD11Far/u5zibACd3kAsQ7wYJUECWRA=;
 b=L3vDTjomq9ddiUL+hKNlutb7A/apUIYac1dnWjvO4Wvi5jLyETf1UDxAqbpOm4LjEJ0eE4rWwkS0qpe2f1JA1nAr8AyC+M+HQTRiOI0vaRJGKPlaVQ268tungX7spb8YhnbeE9waWdw1Mnpqa2edmL9NbvIPrXxU2+3Lqk5JrsYIa3LJyoQXKu5VUrI0jE8s9jOFodjOEra3OmP+yccSqrF1lpwOHj2x+qNRRkwsTnxMfMtqAUnI+Mp4Quj0lGo5QiDYVNI47cnFRah0thQ9XZxzCfqTS7yrB5UMKGxkQgeRrdRXfQjqiouEbAbXv2BNqU8ENru3MCc6m7Ng6ydd2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uf9Cx04m2tNvFD11Far/u5zibACd3kAsQ7wYJUECWRA=;
 b=kL4baq7/PmPzxCs/BWFfvVQ87t56GukkJEyXFKaPFj5K49zT6nIAii7b3ruWOL+Zaehk9MUkZZf1hG6kfZKLk8jU40Rf+0iE/LgURjbmtWeGGP6jZt+SLoTE4mtX9kiwor5sRqfTFHTERSp8xrWF61a9kBYxGQ2TnEsBldhT148=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYSPR03MB7737.apcprd03.prod.outlook.com (2603:1096:400:42c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 03:16:59 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 03:16:59 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, "David
 Lechner" <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>, 
 "trini@konsulko.com" <trini@konsulko.com>, "lukma@denx.de" <lukma@denx.de>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, Julien Masson <jmasson@baylibre.com>,
 "seanga2@gmail.com" <seanga2@gmail.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
 "macpaul@gmail.com" <macpaul@gmail.com>,
 =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>,
 "semen.protsenko@linaro.org" <semen.protsenko@linaro.org>
Subject: Re: [PATCH] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
Thread-Topic: [PATCH] arm: dts: mediatek: switch mt8365 to OF_UPSTREAM
Thread-Index: AQHcXjRa9T3F2dZmkkSZPFazDnk52bUSbtIA
Date: Fri, 5 Dec 2025 03:16:59 +0000
Message-ID: <7021158b1829c5daabf62b1901a8b4988a940a92.camel@mediatek.com>
References: <20251125-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-707eee6dfdbc@baylibre.com>
In-Reply-To: <20251125-arm-dts-mediatek-switch-mt8365-to-of_upstream-v1-1-707eee6dfdbc@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYSPR03MB7737:EE_
x-ms-office365-filtering-correlation-id: af14be8e-6352-4086-46da-08de33acc0ad
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?MHk2SDA4NFhhbHg3UkxxdjBtRWtVZGdJRnZRSHBsOTFtdkFWVU9JWjZsWkph?=
 =?utf-8?B?SmYrVTFMNUxES3o5YWlQbkVTTUJLRWRqbzczRDNCNUtZalVhT3VFTFViU2JD?=
 =?utf-8?B?MUYzQUIrek9JSUNwQkNDU0JNN2xQWGlncEpqbTYybUlnejBkQjdod09vWXRl?=
 =?utf-8?B?QmhvTmdzcVBVemI5SGh3ZXpxWStpM2pMRElvSnJQV1gxVEJvbGhNbWlBUlNZ?=
 =?utf-8?B?WEx5VjNGczNoS1lodWQ3OXppUVRaakVpb1J3cWpYWkNiaTVZWE9mTVRKMC9M?=
 =?utf-8?B?UG04YWoreEF3V1VMRUExUUhCM3M3TkRPVDZsQjRSWUlEMXJaNW5wbUxqUTlk?=
 =?utf-8?B?NzlGLzA5STFaVmN2UjJSaUFkS0NnZlVCZlBneHZabGVCNElBT1Jubzk2aHRV?=
 =?utf-8?B?M2lhOXdjWERabGVBMG5GUkFML1hJOTRyZEgzbEV4MVFoU0ZGY1lJMFIyWnkx?=
 =?utf-8?B?UFlyZmdGQWRQWHJXK3ZnRDdkQ1pldXBtQUdSbEliUGdSd2NTV0xRN3d4V0pJ?=
 =?utf-8?B?Y3pHZTZjRkttS0FIZjA4SlEvQUg3MjYxK2RVdWtrMWsyUVJkOVp4SGhKVDZq?=
 =?utf-8?B?Ly8vbURkbDNFOWZ2R1pRakovRDk0UDRqT0ZBVkNHMGlNYmF6ZVJUcmxzTUpj?=
 =?utf-8?B?YTloWnoyTmRVNmx5T2RmUjR2dDhHaU1pYXhtbFdVaVUwNjBDOFlUQ0R1WE9i?=
 =?utf-8?B?RVVtVWRibCtZRXFOUWNwNkQvTUpxaW1rcjVJWGppU1hRcDArbFdubE1EbTBJ?=
 =?utf-8?B?MmFaN256aXJQa1MyRVFJdUJNOU5sbVFvSGQ5Wm9mQ2hVUDRCdFB4Q2dOSUdY?=
 =?utf-8?B?YnVDbmhDVldsbEY4cTIyMnludUFITUhDYi9RRm1PT2oveTYrWnRkc1NWSnFh?=
 =?utf-8?B?NTFnek90STM1QmFGTzljYjZseGRzZ3ZYUWUyU1FVSlRwUHZGNjZBSVdmcXYz?=
 =?utf-8?B?VlpuVS8yR0JKWTYrMW5yQm1xMTQ3emtIc0haMXZ3T1VtTHR0dG53OUw0ZG1a?=
 =?utf-8?B?c1lSemtsemR5eEh5WkhVYlhTZzI5OFV5NkdKVTVrSnJZQ3BhUDZGZ1hqM1Iz?=
 =?utf-8?B?cnZMcmZrdFVDOUQzd0lscVlvanVYYzZVVGxjTTlnbnRLR294SG9zcW5GSlFN?=
 =?utf-8?B?bnF2bzV2YWFQcVgvTFNzT2ZuT292MXYzTFJvR3owWU9Zd0JzRzRvdmlBOUtr?=
 =?utf-8?B?Sk83bTVUMjlrR2dVSzMvajA1WG1SZTRta296aGVPMnlMa0xlWWdUY1pWcHpx?=
 =?utf-8?B?OUtmNUd0MktpT1FnbmhRUndoZWZUM280OXcvdmltMEpPeVBWaDhDT2tWeTJu?=
 =?utf-8?B?MnJYYnVsTi9aeE1MZzZFMFRpNWYwYzgvQWVHOG9TYjBYQ2phMFJsYUFOY1dt?=
 =?utf-8?B?dFBockJxdW80U1JyU1gvK1BKa1ErQ2haRDF4OWdSRG1lK3l0WjZUMno0NVFk?=
 =?utf-8?B?T3V3MVo3cXdNWDJMaUc0R0twcytiMUZtS3VTb20rQ1FYS3ZVZ283eHM3WlJN?=
 =?utf-8?B?dEVtRU1GRldGa1kyaVJZc2lnMWNUSk9PUDFZN0MxQTc0YmljMVhUQ1hBRFB6?=
 =?utf-8?B?NDYrdEp4TW02amF3QVorRGZXUC8zeHRUY1JhU3VVellCTXRTU0xvMUhQb09Z?=
 =?utf-8?B?NmhwOWc2UGFEVFY4dWhsUGNXMGlnL0lNdTRxSVRIZlZuMnNkRVUySTNjUWhT?=
 =?utf-8?B?ODBQQlZpWk4vNHUzTDRFREdEdFZvS25xcDJ4SmoyRFRvNDVqQzFLbldudjVm?=
 =?utf-8?B?RlJuaGJSM0FZajk0RWhCYXZXaVNsaEg4bEdBNzUwOSttZEFCVDFqMG1MT2ZK?=
 =?utf-8?B?b2doRVMxV2dIQ0tnaFhpa001clVQZWNNdzNrWm1JR3pVeTh2WVVyOG41dHJQ?=
 =?utf-8?B?SkhldlBGZW0yWURGUnhrM0RYbFp5QVI5SnVuY3FYcC9tMnBBaDR3dm1oVTJm?=
 =?utf-8?B?TGVyQ2FvcHdONjJFOHlJSDVYeFcvM2VrejFXRk5FVmlhNy94aVovVmhMSndi?=
 =?utf-8?B?K01MeHhPVHdLNThyaW1sNEZVVFN0bVBGOXFYOEt1SElSaVpXa2JMUnJxQXh5?=
 =?utf-8?Q?WW/T2t?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFJ4eFZlaGNsMlFYaENXSWdJNXZ5Q0RiZzVYUXV0d0VkWTNRWnpuekZuN3BJ?=
 =?utf-8?B?SHZTMTh5bEovbTNyaEpGT1BPOTRsU0FLeThIK1g1UmR3TjYyWmlLNmRReWRl?=
 =?utf-8?B?bWJia1Bza0RuVVdqdzhBdjdlR3dwb2ZFVjhwK3pJZm0vNERkTjdSQ2haOCtQ?=
 =?utf-8?B?bG1MYnJkRHUxdFQySXJsUVlnSlB6TFhDVXZKdjZBd0JQV09IdnVTUmJ2cjg5?=
 =?utf-8?B?R082WFpPbStkWk1sdExNOElOblpkU08yT2ZhMDlQcEJtQkhWdTdBcmhpankv?=
 =?utf-8?B?RnBldjBDd0N3MHdaNkd1U2hFSWZIaDhFRjd1Q0E3dEt2M1BCdGpaMkxvWWt6?=
 =?utf-8?B?UkpVSFpkM2NBN2M4UGtZU0hIQ2kxTkprV1NuWWN5WjhhcFprOVorZDBXTTJw?=
 =?utf-8?B?ejZFenFNSzZIdnJmNUVNMmZoYkFDMVR5SmgyUW1SYkVrSzFlZnJuaHFScXhO?=
 =?utf-8?B?RVdrMmRPN2l6VXY2djVpVFNJdDhGQ1dpbVh2dUJSaHlqeGxYOUV0YVhRRDJa?=
 =?utf-8?B?NVJ6OE9CeVBBM2VNL3NpNE5meU1MbSt6ODdKS1dCZjM4RU91RzBpUUcrNW4r?=
 =?utf-8?B?TGhUbTVFTlNTeHd5bkZGQjVjWCtmTXcwMGRGd3VKanRFajF1NE9sUnBhb2pn?=
 =?utf-8?B?WG5taE96ODNPYmR5SlN4emxFeEVvZWVzZmc2aUUxTTZRdTdqekhCclF4Z2VU?=
 =?utf-8?B?bWNRejZianJzMDVpa3hsQmEwUy9IMit4Y3piRHpwNzF5cUp0YnNYWDZzOFNL?=
 =?utf-8?B?VzlaSEZLK2I2NmFZZWZQcXBsRnB1a2FBbUs2Yk1zejZxU1NVc1JXcTY4TXVH?=
 =?utf-8?B?SWQ2SHl4MXNpSFdBdGNjclA0Uk5MSWI5Q3lQNnMxYytKZ3BOR2Zod1JYbE5r?=
 =?utf-8?B?Ujlqc0J0NTZ5bFRtWWRwSUwyTFJHNGJqUzg0ZXhJdVdJNzhYVmVPWW1VMTVr?=
 =?utf-8?B?eTBMUm1ERENSb0k2c01FcmhENGtpWXVwUEFWeXQvcW1OeW4wbXloUnc4OElV?=
 =?utf-8?B?UzBUTWZRMUNIL0FIZFQ5Y3ZCUHJuVjVZNFgzYVA0N01hZVVlTXBuakNGQTNG?=
 =?utf-8?B?ajJOdnRiRlorbTNuTnVCTkZtcWFQaEJwNlU3RENnNWRyaXN4eG1pWmFpTmwv?=
 =?utf-8?B?dUxxa3E3aENqSUNHeDB3Z05tZ2p5Y2xRbjdxTmV4aW4vM1BWV2ZZc29DU0x4?=
 =?utf-8?B?T2hRY3NwUHE4L3pnczlmcUhGYXdiNTZ2VGgyS2FSeUt4UEttK1hnZVQ0K095?=
 =?utf-8?B?ZTdLeUxhODcyZDVkbVFCUXErMHF1OTFuMVUvdWRaWjhFVXdjU0lrRmsvWWlV?=
 =?utf-8?B?L2ZqdDRGckNscElHd3E4QUJNbkhOZThtZWYvbnFqdzU4R3gyRUJsOW5NWGVS?=
 =?utf-8?B?MmdnUnVGbm9JNWV5K0xZd3R1YzVrRmpsS2NzVlpzeVhhNEQzYngxcjlWRTJy?=
 =?utf-8?B?MG1HYzF0UE8yS0wxM1ZGbkZpVStzeTBHNGJyK0h1OEtEMVVFOFQ1SFRMYTB0?=
 =?utf-8?B?U2dYcTd1UHVnbmhDZVVDeWhndHZwaXJweHV5R21nTEt0ZElzQUlFZ3JqeUhi?=
 =?utf-8?B?VGlQancrRDNHNFZRdm5pSEl5UVZoRkZHQ3JhQ2lZZGU5MlYwTUlDdHBzSmhJ?=
 =?utf-8?B?TlpNTVFzbVhxR0pGMGRRWUZJblZyUjNpQitnekRYY1MyakJaSitJR2lmQkt1?=
 =?utf-8?B?Mll6NFAzSEVMajlyQ2trcjgxc1FEYWFEZmk5a3VHV1FoZnRxUjVqWUd0MURB?=
 =?utf-8?B?NDFjSURDcm56M05XZllJNWZGSHRFQ0ROQ003NUpoUFBodUpXcXdTK3JPczZh?=
 =?utf-8?B?aTFCNEhyYnhKcmRjWU9FQkV0QkJlUkxkYTF5NlNtQ1lrd3NkdHF3cTU0QmhI?=
 =?utf-8?B?TG9lc1dFVDVyK2lzMGJIbVl6cUJ0Q3Z4ajJCelQ1NEhrRzZSQ1l0Q2xtdFZl?=
 =?utf-8?B?emhuU2gzRFNiU0hCbXd6QktnbkRRTDRGVjlNS0VwY2RVOWUraURNdEFNejgz?=
 =?utf-8?B?cVQwYk8rVXhLSCtPM1lxTDk5aTFBbmZsZTdHNkZ0emFTeGZyVWJOb1EwY3c0?=
 =?utf-8?B?WWpHaVc2b2x3WFI0cWN5RnYxMnZWemd1WHFLNzE5eU41YW9rR3gxNzFMRnND?=
 =?utf-8?B?YVkvS2NUa0V2N081SzB0Q1AyNHcvOHh3Yjc4cjYvWlF3aDdUWDJzUVVES2V5?=
 =?utf-8?B?TkE9PQ==?=
Content-ID: <2A561962BE853F4C9104EDF93CA9C1DB@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af14be8e-6352-4086-46da-08de33acc0ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 03:16:59.2806 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BPrTprJfnYj518sc7hrJLk3f2bVcH3/N1XUo2PrIQ/qt3KB48/ks8FVbRQtAuwVZ8yW24n6jjOSlP493imsNRcGp89u6xOZ0/OcVM5ZBczE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7737
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

T24gVHVlLCAyMDI1LTExLTI1IGF0IDExOjM1IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiANCj4gRXh0ZXJuYWwgZW1haWwgOiBQbGVhc2UgZG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4g
YXR0YWNobWVudHMgdW50aWwNCj4geW91IGhhdmUgdmVyaWZpZWQgdGhlIHNlbmRlciBvciB0aGUg
Y29udGVudC4NCj4gDQo+IA0KPiBDaGFuZ2UgbXQ4MzY1X2V2a19kZWZjb25maWcgdG8gdXNlIENP
TkZJR19PRl9VUFNUUkVBTT15IGFuZCBkZWxldGUNCj4gdGhlDQo+IFUtQm9vdCBjb3B5IG9mIHRo
ZSBkZXZpY2V0cmVlIHNvdXJjZSBmaWxlcyBmb3IgbXQ4MzY1Lg0KPiANCj4gVGhlIHVwc3RyZWFt
IGRldmljZXRyZWUgaXMgaWRlbnRpY2FsIHRvIHRoZSBVLUJvb3Qgb25lIGJlaW5nIHJlbW92ZWQN
Cj4gKG90aGVyIHRoYW4gaGF2aW5nIG1vcmUgbm9kZXMgZm9yIGRldmljZXMgbm90IHVzZWQgYnkg
VS1Cb290IGFuZA0KPiB1cHN0cmVhbSBmaXhlZCBhIGNvbXBhdGlibGUgc3RyaW5nIGluICZzY3Bz
eXMsIGFsc28gbm90IGFmZmVjdGluZw0KPiBVLUJvb3QpLg0KPiANCj4gVGhlcmUgd2FzIG9uZSBt
aW5vciBnbGl0Y2ggd2l0aCB1cHN0cmVhbSBtaXNzaW5nIGEgZmV3IHRvcGNrZ2VuIG1hY3JvDQo+
IGRlZmluaXRpb25zLCBzbyB0aG9zZSBhcmUgYWRkZWQgdG8gdGhlIGNsb2NrIGRyaXZlciBkaXJl
Y3RseSBhcyBhDQo+IHdvcmthcm91bmQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNo
bmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGFyY2gvYXJtL2R0cy9tdDgz
NjUtZXZrLmR0c8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfCA0MTgg
LS0tLS0tLS0tLS0tDQo+IMKgYXJjaC9hcm0vZHRzL210ODM2NS5kdHNpwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDg0MCAtLS0tLS0tLS0tLS0tLQ0KPiAt
LS0tLS0tLS0tDQo+IMKgYm9hcmQvbWVkaWF0ZWsvbXQ4MzY1X2V2ay9NQUlOVEFJTkVSU8KgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgLQ0KPiDCoGNvbmZpZ3MvbXQ4MzY1X2V2a19kZWZjb25m
aWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAzICstDQo+IMKg
ZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODM2NS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8wqDCoCA0ICsNCj4gwqBpbmNsdWRlL2R0LWJpbmRpbmdzL2Nsb2NrL21lZGlhdGVrLG10
ODM2NS1jbGsuaCB8IDM3NSAtLS0tLS0tLS0tLQ0KPiDCoDYgZmlsZXMgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCAxNjM1IGRlbGV0aW9ucygtKQ0KPiANCg0KVGhhbmtzIGZvciB5b3VyIG9ic2Vy
dmF0aW9uIQ0KSG93ZXZlciwgdGhlcmUgYXJlIHNvbWUgYmFzaWMgY2hlY2tzIHNob3VsZCBiZSBy
YW4gYW5kwqANCnBsZWFzZSBrZWVwIGluIG1pbmQgYmVmb3JlIHlvdSBzZW5kIHRoZSBwYXRjaC4N
Cg0KMS4gUGxlYXNlIGFsd2F5cyBwdXQgdGhlIE1haW50YWluZXJzIGFuZCBSZXZpZXdlcnMgKHJ1
bg0KLi9zY3JpcHQvZ2V0X21haW50YWluZXIucGwpIGluICJUbzoiIHdoZW4geW91DQpzZW5kIHRo
ZSBwYXRjaC4NCk90aGVyd2lzZSByZXZpZXdlcnMgbWlnaHQgc2ltcGx5IGZpbHRlciBtYWlsIHRv
IHRoZSBvdGhlciBmb2xkZXJzwqANCmluIG1haWwgY2xpZW50IGFuZCBza2lwIGl0Lg0KDQoyLiBQ
bGVhc2UgYWx3YXlzIHJ1biAuL3NjcmlwdC9jaGVja3BhdGNoLnBsIGFuZCBjaGVjayBlcnJvcnMg
DQpiZWZvcmUgc2VuZCBvdXQgdGhlIHBhdGNoLg0KSSd2ZSBkb3dubG9hZCB0aGlzIHBhdGNoICgu
bWJveCkgZnJvbSBldm9sdXRpb24gYW5kIGZvdW5kIA0KdGhlIGZvbGxvd2luZyBlcnJvcnMgbXVz
dCBiZSBmaXhlZC4NCg0KRVJST1I6IERPUyBsaW5lIGVuZGluZ3MNCiMxODA5OiBGSUxFOiBjb25m
aWdzL210ODM2NV9ldmtfZGVmY29uZmlnOjg6DQorQ09ORklHX0RFRkFVTFRfREVWSUNFX1RSRUU9
M0QibWVkaWF0ZWsvbXQ4MzY1LWV2ayJeTSQNCg0KRVJST1I6IERPUyBsaW5lIGVuZGluZ3MNCiMx
ODE1OiBGSUxFOiBjb25maWdzL210ODM2NV9ldmtfZGVmY29uZmlnOjE0Og0KK0NPTkZJR19PRl9V
UFNUUkVBTT0zRHleTSQNCg0KRVJST1I6IHBhdGNoIHNlZW1zIHRvIGJlIGNvcnJ1cHQgKGxpbmUg
d3JhcHBlZD8pDQojMTgyODogRklMRTogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODM2NS5j
OjE0Og0KDQoNCkVSUk9SOiBET1MgbGluZSBlbmRpbmdzDQojMTgyOTogRklMRTogZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLW10ODM2NS5jOjE1Og0KKy8qIE1pc3NpbmcgdG9wY2tnZW4gY2xvY2tz
IGRlZmluaXRpb24gaW4gZHQtYmluZGluZ3MgKi9eTSQNCg0KRVJST1I6IERPUyBsaW5lIGVuZGlu
Z3MNCiMxODMwOiBGSUxFOiBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MzY1LmM6MTY6DQor
I2RlZmluZSBDTEtfVE9QX0NMSzI2TSAgICAgICAgIDE0MV5NJA0KDQpFUlJPUjogRE9TIGxpbmUg
ZW5kaW5ncw0KIzE4MzE6IEZJTEU6IGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgzNjUuYzox
NzoNCisjZGVmaW5lIENMS19UT1BfQ0xLMzJLICAgICAgICAgMTQyXk0kDQoNCkVSUk9SOiBET1Mg
bGluZSBlbmRpbmdzDQojMTgzMjogRklMRTogZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODM2
NS5jOjE4Og0KK15NJA0KDQp0b3RhbDogNyBlcnJvcnMsIDIgd2FybmluZ3MsIDAgY2hlY2tzLCAz
NiBsaW5lcyBjaGVja2VkDQoNCkJlc3QgcmVnYXJkcywNCk1hY3BhdWwgTGluDQo=
