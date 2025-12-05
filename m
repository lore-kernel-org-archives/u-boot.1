Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93595D2F7EB
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 12:21:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F53841CC;
	Fri,  5 Dec 2025 13:21:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="KNjPeN0Z";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="QpL6Suf8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E9BE38420C; Fri,  5 Dec 2025 12:11:23 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CCC8841F4
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 12:11:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 1c76d364d1cb11f0b33aeb1e7f16c2b6-20251205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Z2hsuB/N3DJCx3wz8VRa91t78K60StSAuSlduter78I=; 
 b=KNjPeN0ZKcGHiwQHxedN5HgL1Vpm8EQ8VywLruM+bZpR2r83azqpe/JUBk+n1HfDC6KRidveh93oXX8wFAdUyq+ESmDr2Rf4u/0fy2L1P0teukuhJbafGT/L5l3OTiB9GmL4XESOYsw+4baEe9b1ENVgTATSgnW/pECYi/Zing8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:4b2459ce-3336-4c0b-9c12-8c10a47933db, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:3fdaacb2-13de-4936-a6df-52eb9b61d285,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1c76d364d1cb11f0b33aeb1e7f16c2b6-20251205
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 526565124; Fri, 05 Dec 2025 19:11:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 5 Dec 2025 19:11:12 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 5 Dec 2025 19:11:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pePvbcQ8Vjv90979WqaEB8WkSYCx9/Z1aEjejj/svS3gLhqcPPyon9opYUMOMn9VSK6XW2IED4mAi/huFVVvx8kK17/ux+qG1JXI1H1A+1tThTG9S+zlWyYh6UlQHIa7pPutnhy9nbXl3rENo/F8VnMqF9/kfmb1CJwAI58ifQUZY54pWlttc/sK2502hfb8pt9kYw/X+KPk0YllsKZnyZYfGRDRKHjVGGjqAzIQocauGa8b0a2E0o0mpT3Ft+JUQxvem41uommBzWdC5c2aQOJ/WDvaVlbp8IlfQRDD9Z+ATAypvoD7Bdy7QpSfZaGQ+I6M309ue6KDMN2EYjrpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VHwTBInghMaF1m2vrXRXVC0O0NqglnEORiHyFAhqDto=;
 b=EkavKCVK6ug0492Y83sD4XehLuLdhaBg+XzP3oR9G4vTbACnz2fwmVlLOOPKVYaJEcSLsBqs82M9uAOThCzierpk0CPN7z128lydmVh58rKM4JR3B6KWIpYJVxbZVlk+UB+lrxBtPDg++p51g7ezFOahyF60NE0TSfXN2CopU5B+UXp7xmllwB19VO0XI7N1nAX2rRvzElIJJIYMpA6VCtdLOjvAAMTNQ96nqyk/EMk93XaS062UHwH03mV42V2r2MeZ8GmcwYUmD51uEnWsNdhAqbk9OnqpjKhzZ6dOHY4sPrqSjzSKh+/696SiRtb2O9gsEczDIsUtLK1Q0Q4bOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VHwTBInghMaF1m2vrXRXVC0O0NqglnEORiHyFAhqDto=;
 b=QpL6Suf8cQ+ULOv1uwLaUVp2ynL8M2KkiuhxO9CbcaJqxhz0UelJM1gAKHDnQQ1aVAPBTF4tPnz8L92jaG2lgzx6Z6OKtxkkBA+aax6Apv2BHEL6uF0rU+3NxRbdkiq49D041wQetolzRrahCAfdo0nr6Bq4qb8YaPgkX/0ip8c=
Received: from JH0PR03MB7806.apcprd03.prod.outlook.com (2603:1096:990:2c::12)
 by KL1PR03MB8069.apcprd03.prod.outlook.com (2603:1096:820:fb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 11:11:07 +0000
Received: from JH0PR03MB7806.apcprd03.prod.outlook.com
 ([fe80::d42b:4391:f865:71fb]) by JH0PR03MB7806.apcprd03.prod.outlook.com
 ([fe80::d42b:4391:f865:71fb%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 11:11:07 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
 "macpaul.lin@gmail.com" <macpaul.lin@gmail.com>, "trini@konsulko.com"
 <trini@konsulko.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?=
 <Macpaul.Lin@mediatek.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "stefan.roese@mailbox.org"
 <stefan.roese@mailbox.org>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "alif.zakuan.yuslaimi@altera.com"
 <alif.zakuan.yuslaimi@altera.com>, Julien Masson <jmasson@baylibre.com>,
 "nathan.morrison@timesys.com" <nathan.morrison@timesys.com>,
 "vasileios.bimpikas@analog.com" <vasileios.bimpikas@analog.com>,
 "sumit.garg@kernel.org" <sumit.garg@kernel.org>, "lukma@denx.de"
 <lukma@denx.de>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "utsav.agarwal@analog.com" <utsav.agarwal@analog.com>, "ziyao@disroot.org"
 <ziyao@disroot.org>, =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
 <Sam.Shih@mediatek.com>, "Oliver.Gaskell@analog.com"
 <Oliver.Gaskell@analog.com>, "seanga2@gmail.com" <seanga2@gmail.com>, "David
 Lechner" <dlechner@baylibre.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
 "arturs.artamonovs@analog.com" <arturs.artamonovs@analog.com>,
 "malysagreg@gmail.com" <malysagreg@gmail.com>
Subject: Re: [PATCH 2/2] clk: mediatek: add MT8188 clock driver
Thread-Topic: [PATCH 2/2] clk: mediatek: add MT8188 clock driver
Thread-Index: AQHcZGPb3k6u42qAhkyXDWM192mkaLUS5uqA
Date: Fri, 5 Dec 2025 11:11:06 +0000
Message-ID: <9c792e4632bef504cdfc95e5ecdd92fb76869777.camel@mediatek.com>
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-2-9a06ebb97734@baylibre.com>
In-Reply-To: <20251203-add-mt8188-support-v1-2-9a06ebb97734@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7806:EE_|KL1PR03MB8069:EE_
x-ms-office365-filtering-correlation-id: 2a8b65f8-e0d0-4de8-0b0b-08de33eefcc6
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?RVRhNXZqRXlKMUF3NitkbjJSTHpEYXhWaS9KUEd1U1NBbUJDeUhuV242WUNM?=
 =?utf-8?B?S1A0TnkxS1Z5citQL2hkbXVlanpLU2dZZmFiRkFOeXdvZ0FUbnVXbWRQWkhZ?=
 =?utf-8?B?eWo0Z05LbnBQTzhmdWlKSE1xQ3F6cE1kTDBESjJtZ3J1R0t1RHljcVQ1YXA3?=
 =?utf-8?B?TEQxclhMRTBQZWdPNXpsOFNrSUt5L3o0dDArZjdpcGYrbFllcW4xU2R6cEVo?=
 =?utf-8?B?NWlyQ09IN0Y4Y3VzK0M1VjRPMDJDUG1TbGpTUytZN2dsVCtVZ1J0ZDFIU3Y4?=
 =?utf-8?B?YjNFa3NWbmx4QnlaRDVaQi9pUlg2Zk1rYkNhdUpxcHZMcUtRSlFBNzR5U3c0?=
 =?utf-8?B?MFF5RjhTNXpXdW54ckVKR3hmOU1LRHJDdkJZTW5sUTFCd3d6SGhHUDdUQURa?=
 =?utf-8?B?RHlrajhNL0hpQnVNS0FaRkNMVG5CQU9PTjhndml0aUQxZEh2UkYxWW8rQkhs?=
 =?utf-8?B?di80enJBSXlKdHBXSkpnbTVyQTNNbm1pa1FtUzdIc1ZHQXk0MEdseTcyL1Fs?=
 =?utf-8?B?bE1GNWJuTncrbWlIRXgrNkNTM2RSbysvYkxNMkhYL0pLMXJMb3VPcnl0eVkw?=
 =?utf-8?B?M2RMd0EwV1JlaWdNSml6cWM1a2xYS1JQSmlKemNXQUptL041bjB5bjNubkZ0?=
 =?utf-8?B?ZGdsbE9ETEd3dVJBQlB5SUV3WGcvSGJBUEowZzdmdy9BdkhLRWExbmllaWly?=
 =?utf-8?B?cEFicjF6dW9ybzJOdmNPQ2VQT25CcW90UUVtK0x0eldHUDJmWENIbDlaQ1RE?=
 =?utf-8?B?OXlqdWVpUlplVzl5WGVLT2J2M1BDakpEMkFLSnVLcFlNUHdZWTRpZ0pNeTN6?=
 =?utf-8?B?SUdlZ0lobjNVSmlZeFRYdWg4UW9HQVI1THhSNDNzdXJwMlR2WlRERWp6YWpp?=
 =?utf-8?B?cFR4RCs2WUYxaUdudGQ0SXpIMlg0MUxnK2QwWTFReDZMWk81VmpCU2Nvallq?=
 =?utf-8?B?ZjlIL1hpQzFmZWpqY0dRMjV2KzhKYnk5TDdwY2c1Y1E2bWc2TTExZExqOWZH?=
 =?utf-8?B?REVuQXF3R01XZUQ1bWMva25yUklUSmdFSWNpOWg0bVM2MkRLUGRsMDZiSWQr?=
 =?utf-8?B?eEVhWEs4ak1Kb1A1NG5hVDFyZCtTVDl6NmkyaG5jcEpTSVdrMzRyU1ZHbDZm?=
 =?utf-8?B?bURxdzhkUzAvaUdReG0wL3RCYjFudWFrM01PSHNQbHNWSDVvU0I5NGJNTzBD?=
 =?utf-8?B?SmNQNnQ3c0IvZW1aK21UMFBMNlVRdktadXBCQnEyZWJmUnpRMXlQelV0VGJ4?=
 =?utf-8?B?VkUvY3ZLUDgrMDNHdzlxU3kvSXhpNmIxelRoUlBNbTUxMDBWWU5wbUxXMlNj?=
 =?utf-8?B?UWpGZ0tnZE85VGxCN0lhVmpXcEw2Um15MnBoVUdXcWpybEJiSk5HdTh0UkxH?=
 =?utf-8?B?ZHBBZ1B1MjAzZHBXNFJkc0cyQjIyNXpRaEdKL1RSb2xXVDh3bk05dVpkS0t4?=
 =?utf-8?B?RkZnYk5SY205b0VGTFBKZC9sSHRscGZLYnVMMTBrOWIzRGVpZXpiUDJ5ekNq?=
 =?utf-8?B?aXRvRmo5SEExdUZxYVN5elp5ZDNuSnZ4THNlMmVJaEwwdmJOL1JCUTdHaDk0?=
 =?utf-8?B?YzhDTzVwN01sYnh3OHlYNUxnUlFXT0dBTHo4RWMyZnYvU1ZsazM5SDcrT2Fl?=
 =?utf-8?B?eUFXNnV1djNvTDhRNkZzQUR4bEwrbkN2cjFIWHNzbFVsYXdOWk5mSy9JaG5j?=
 =?utf-8?B?ZnpZWk1FeXVFeHJDdzlDZEFOeGEzZ0NLdnE3aU5HRkNtWTJhWnJQdXYzU01H?=
 =?utf-8?B?WmlnZHhBK3FhejkwNVBMaGpnV2VSOHdHejZBa0ZKNlRQNDg3enJ0dlMzK0hj?=
 =?utf-8?B?V29NaVdJZWxUUHVMKy83Y05Xd2gyNWdJVHZ6VWlaeDdMdGtLQ1NEYUpRK3Ju?=
 =?utf-8?B?WXcxdHA5VXU5ZVFLbG5YUUFKc2ZKYjJ3L2JzK3lWU250WHlxQ0ROSEtNTFNW?=
 =?utf-8?B?YXUzZnZUWjZoL3lSQ1krN1J0U3MzRjNrdC8zSHFLanJIWmRLWHJROFBIT1VO?=
 =?utf-8?B?Tk5INFU0Y0tJZWJ6VkIxOFVyd0xTVUI2UmdqZTN4T0RZSUhnZlFtUnJXcUtE?=
 =?utf-8?B?dldJT1FOMDNsS2NQSVVRRVBvM2Z3RmNMYmdjZz09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:JH0PR03MB7806.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MXJqUlBqQ1daZUdJd0VTOGd0NmlIT3RhOGllYWRFMGZEZjFwNlI0T3hIbzk3?=
 =?utf-8?B?NlpKd25HNWxqR1VDcElhRnFwbUJFc3lFWnRKbGVjV0ZpKy9VNTRNZkhEdmMx?=
 =?utf-8?B?WlNQOWhqNkVyUzNKL1pJYXB5R1F2T01PRmFsZ2R4NlFZam9Hd0xoOSs0SGY3?=
 =?utf-8?B?MFN2NGdjTGhMS1k2OEE5MEw0cWNudVlvbU14bmpEN0gveUkzYmFrMGtJcWdW?=
 =?utf-8?B?YjRRNmtubTcrNDl4K1UwK2JVMUQwc053K2Y4alNHSGNWcjRCRHR0VzdiNHli?=
 =?utf-8?B?a1VGNWMwVmRGcmdTemJKMisxMnVYY3RxZ0ZyTitpZUtBOXRpVms0a1ZacHB0?=
 =?utf-8?B?QnhsNkRmM0QxMW9lVzl6SXdJVEt1R2J6T0xNdVlETW9mUUI3M2Y3c0M5QUVP?=
 =?utf-8?B?dWord2V3SXp5MkRqQU4rMzFULzBPQ2UzeTQ2Q2U3MC82a0JudFFSZUxWUkZr?=
 =?utf-8?B?WG9kdjQxN1V0MCtMbm4wSENzUG95c2lEQ1B1TkZRWWd0QmRKRHhVNkYzYXpi?=
 =?utf-8?B?eUM5TSs1d2gyT0FLbkxHbExzc0F0RTAzVWFhV3k4eFJsbW95RjRSSXpOeU0z?=
 =?utf-8?B?b0JLOTAvWjFZZGkyaDFabHpBRm00M1VlOU10WWgyZFViY1JnaS9CSGdaSGhw?=
 =?utf-8?B?aS9zY25IU0F1RmE1ejBaT1FMR0kyRkVwcGc5RmhRUG5ma0FJUGxEcDdPTTl1?=
 =?utf-8?B?c1dqY3c0WUlWVEd3cWFwWkZWZC96TmpZNDN1RGlPVFRVeUg5SlkxMTFnK21n?=
 =?utf-8?B?bU41My80TVNUTXcyL0N2UElla2tsNmRodEZhemMyNDdTOUExUWV0NjVTdjlL?=
 =?utf-8?B?YmFSb25JOFU2MUxaelJ0UzI1Q1FTMk10VlcxQlMzWUZHTVBqbGJPemQ3Q0E5?=
 =?utf-8?B?TkJGUTBWdHhkUGJRVVF1c0l2TlRJQ0dSRDFldU9IWWVNZzZpLzNpQ2JvdXJ3?=
 =?utf-8?B?WXBQU0RtRFFEc3VUbVBGWlYwZ3MvckJhc0RTUXUxejlBeU5LREFXdGJPaFFl?=
 =?utf-8?B?eGtjOWdyQWtOT3NLNkNyYXZFbnlEZ2hXQUVYaG9vREtRaHNzU0ZVU1ZkOTVn?=
 =?utf-8?B?Nmx5aDEvS292M0h2Q3MzbmNCWnFoWm9pR1NFTHgzaDB3aFgrdTdWZXJkY01a?=
 =?utf-8?B?TlNWRitGc3hsRFAybVBSdmRBczc1NmpPN2tWRzU3NVRlMVFsTFVkd1dTYmtU?=
 =?utf-8?B?b2Y4VTFoc3F6aFQ1ZXp1NHdGaXYxSUxQbWtEbkR2bGdvZE9ua1YzdlNxMm0v?=
 =?utf-8?B?ekpNSklRODRNcmtTYW56VEZIRDBWRU1TM2tGQ1pyZUk0RnhQVlg4NGJhdTda?=
 =?utf-8?B?cE1qOHVha0RyMU9OYUtWODZ4bkFiUFlSb3piN0RJSVlQOVhMWWgxNkUzekds?=
 =?utf-8?B?R1pJV3VocVluVW9mR1VWWXdUci96cDY0ZFNBRndvb0ZuR3R3OUdpc0E2Y0t5?=
 =?utf-8?B?SS9YM1UzWm00TEhlZTJxRVhKQVFOZFhIZWVId0gvbjhWcU9uUVkrZ3VtQTJR?=
 =?utf-8?B?TisrMTZRVDV0REgrVEs5VERQZ3FubUZhOHFHSmdQejJmTFNUNG5wNkNjMlBL?=
 =?utf-8?B?QktReFdYdVVCZjBwS1k4QTk2WVBzblpOd1dMYnViMzVmNTFNS0VOZkxuU1dK?=
 =?utf-8?B?NzN1akt5eURFWmNRTDVDeHp2c1Q3SEYzUDllNUh0V09jc204ZzREaGVHNjRV?=
 =?utf-8?B?ZzhUdXJ6WHQ5cjVZNm1UQjlWZE5wcFZpMG9ZSlNRS1EwRVF1M1R1ZzFwY3Zu?=
 =?utf-8?B?ZjdUam1EMXZNOTRSZWdzM2ZkMjl1NXBWaGJRcG51UzZJSS9ub2pJS1hITDZM?=
 =?utf-8?B?OHVuTTNSc3BRZkJLMlQ4T0hJK3hsVkYyMEtJeVd0MHhrQ1lCczNVTFYxR0xH?=
 =?utf-8?B?Yjcyc3VhOW5VNm52Nm1iYmF2ZWFLd1BSeHl5bi8rSzFXTzFnb0VrcTFXc0ph?=
 =?utf-8?B?MHNRaW8xT3BtQTQ0Qkswa25jdEw0KzFvNmdqYitRMlVOU0xjNVZ4UW1lUEdm?=
 =?utf-8?B?b0syY3JKM0RPQ2h5dktFRkZVR3preUpwY1NBeTBhclB1c0VGVGZibE1tUVRF?=
 =?utf-8?B?VFB4azBuWFBrNTJqMDJmQWVwd3BjTjg4RS9MaytWbGV0OHhwSXFxNmVXNFdu?=
 =?utf-8?B?MzlDbDg3WnpJTFRmb2FBa1UxTXduK0xlOGtOb3VxZllud2I0NWNpQll4Y2U5?=
 =?utf-8?B?d1E9PQ==?=
Content-ID: <1CC31FDAEF90AE44BD5A92D47C4EE60F@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7806.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a8b65f8-e0d0-4de8-0b0b-08de33eefcc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 11:11:06.8676 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tRQRRcGvYt15soYUw7OnPcBMQD0OBt1ZIdJwUM9Mln9DklMjfVWCIWJPvVxTzqgXRE4oyQkjWeWTJaZJ8Ez4pqBqttHhSItxj7Ynwm4xsAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB8069
X-Mailman-Approved-At: Fri, 05 Dec 2025 13:21:26 +0100
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

T24gV2VkLCAyMDI1LTEyLTAzIGF0IDEwOjMxICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gRnJvbTogSnVsaWVuIE1hc3NvbiA8am1hc3NvbkBiYXlsaWJy
ZS5jb20+DQo+IA0KPiBUaGUgZm9sbG93aW5nIGNsb2NrcyBoYXZlIGJlZW4gYWRkZWQgZm9yIE1U
ODE4OCBTb0M6DQo+IGFwbWl4ZWRzeXMsIHRvcGNrZ2VuLCBpbmZyYWNmZywgcGVyaWNmZyBhbmQg
aW1wX2lpY193cmFwDQo+IA0KPiBUaGVzZSBjbG9ja3MgZHJpdmVyIGFyZSBiYXNlZCBvbiB0aGUg
b25lcyBwcmVzZW50IGluIHRoZSBrZXJuZWw6DQo+IGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1t
dDgxODgtKg0KPiANCj4gU2lnbmVkLW9mZi1ieTogSnVsaWVuIE1hc3NvbiA8am1hc3NvbkBiYXls
aWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBiYXls
aWJyZS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvY2xrL21lZGlhdGVrL01ha2VmaWxlwqDCoMKg
wqAgfMKgwqDCoCAxICsNCj4gwqBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg4LmMgfCAx
ODQwDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gwqAyIGZpbGVz
IGNoYW5nZWQsIDE4NDEgaW5zZXJ0aW9ucygrKQ0KPiANCj4gDQpUaGFua3MgZm9yIGhlbHBpbmcg
dXBzdHJlYW0gdGhlc2UgU09DIHRvIHUtYm9vdCB1cHN0cmVhbS4NCkhvd2V2ZXIsIEkndmUgYWxz
byBmb3VuZCBpdCBzZWVtcyBsb3RzIG9mIGZvcm1hdHRpbmcgaXNzdWVzIChlcnJvcnMNCmFuZCB3
YXJuaW5ncykgaW4gY29kaW5nIHN0eWxlIHdoZW4gSSByYW4gY2hlY2twYXRjaCB0aHJvdWdoDQp0
aGVzZSBwYXRjaGVzLg0KDQpQbGVhc2UgaGVscCB0byBmaXggdGhlbSBhcyBjb3VsZCBhcyBwb3Nz
aWJsZS4NCg0KW3NuaXBdDQoNCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsv
TWFrZWZpbGUNCj4gYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9NYWtlZmlsZQ0KPiBpbmRleA0KPiAx
Mjg5MzY4N2I2OGZjNmMxMzZhMDZlMTkzMDViMWRkMGM4YTgxMDFhLi42OGIzZDZlOTYxMGQ4ZTdm
NGM0YzYyNWY1MmUNCj4gNTI1MTc0ZTkyNzg3YSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsv
bWVkaWF0ZWsvTWFrZWZpbGUNCj4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvTWFrZWZpbGUN
Cj4gQEAgLTExLDYgKzExLDcgQEAgb2JqLSQoQ09ORklHX1RBUkdFVF9NVDc5ODEpICs9IGNsay1t
dDc5ODEubw0KPiDCoG9iai0kKENPTkZJR19UQVJHRVRfTVQ3OTg4KSArPSBjbGstbXQ3OTg4Lm8N
Cj4gwqBvYmotJChDT05GSUdfVEFSR0VUX01UNzk4NykgKz0gY2xrLW10Nzk4Ny5vDQo+IMKgb2Jq
LSQoQ09ORklHX1RBUkdFVF9NVDgxODMpICs9IGNsay1tdDgxODMubw0KPiArb2JqLSQoQ09ORklH
X1RBUkdFVF9NVDgxODgpICs9IGNsay1tdDgxODgubw0KPiDCoG9iai0kKENPTkZJR19UQVJHRVRf
TVQ4MzY1KSArPSBjbGstbXQ4MzY1Lm8NCj4gwqBvYmotJChDT05GSUdfVEFSR0VUX01UODUxMikg
Kz0gY2xrLW10ODUxMi5vDQo+IMKgb2JqLSQoQ09ORklHX1RBUkdFVF9NVDg1MTYpICs9IGNsay1t
dDg1MTYubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC5j
DQo+IGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC5jDQo+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0DQo+IGluZGV4DQo+IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAuLmU0N2RjM2U2MjgwNTU5MTAzMDBmOTdmZjljMw0KPiA5ZmVkMTBkNTZkN2ZlDQo+IC0tLSAv
ZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OC5jDQo+IEBA
IC0wLDAgKzEsMTg0MCBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gKy8qDQo+ICsgKiBNZWRpYVRlayBjbG9jayBkcml2ZXIgZm9yIE1UODE4OCBTb0MNCj4gKyAq
DQo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgQmF5TGlicmUsIFNBUw0KDQpTaG91bGRuJ3QgdGhp
cyBDb3B5cmlnaHQgYmUgY2hhbmdlZCB0byAyMDI1IGZvciBhIG5ldyBmaWxlIGJlDQphZGRlZMKg
aW50byB1cHN0cmVhbSBjb2RlIGJhc2U/DQoNCj4gKyAqIENvcHlyaWdodCAoYykgMjAyNCBNZWRp
YVRlayBJbmMuDQo+ICsgKiBBdXRob3JzOiBKdWxpZW4gTWFzc29uIDxqbWFzc29uQGJheWxpYnJl
LmNvbT4NCj4gKyAqwqDCoMKgwqDCoMKgwqDCoCBHYXJtaW4gQ2hhbmcgPGdhcm1pbi5jaGFuZ0Bt
ZWRpYXRlay5jb20+DQo+ICsgKi8NCj4gKw0KDQpbc25pcF0NCg0KQmVzdCByZWdhcmRzLA0KTWFj
cGF1bCBMaW4NCg==
