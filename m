Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3473DD6CFD5
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 05:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55CD0839DF;
	Fri, 23 Jan 2026 06:56:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="NzaXOREs";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="nwYQIXDG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB8EE83A6A; Fri, 23 Jan 2026 06:56:47 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A23A839D5
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 06:56:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 45c2b88ef82011f0b7fc4fdb8733b2bc-20260123
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=C1vk7g1wmqaPar5pKW6awBjDb3OOdoRBEMaOV3nQ8bQ=; 
 b=NzaXOREsLwyN4hQbA7zLtDLzjGS+3BvtORzqWQQFVGKLuwLFHfeIUOOSII/KiEiG6w0HICc8YVfUqIzxWzOB1cdaDpeVIZggb+a+aIHy+PrNkdWGjt/BnlbHdgoWed0y68orpO4R7Etjow41UWrEBHpeudF2c+qHs/cgBHfpnYA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:ae9915f8-c322-477b-8488-abc2753c4c88, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:47c1d8e8-ef90-4382-9c6f-55f2a0689a6b,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 45c2b88ef82011f0b7fc4fdb8733b2bc-20260123
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1312325929; Fri, 23 Jan 2026 13:56:34 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 23 Jan 2026 13:56:32 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 23 Jan 2026 13:56:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLQ/VW2YIVUCvmpyja2VCvK+khdWafLd97JcRVF1Tw60DWRneEe3afJz7AktHLzlpkRtR8E0+gmWM7NNNj9S/pj34gmVAR+Z5rKKPy6KCzE7lPVHup+5FZc6f9lCQJFu8s7qeLFCLNb4FrAioa+DjsF0ejiKCsdD7h9gLalneiokNsdisl5vmFe0a+870dVfbmVewkDdk0jtN75alLou/dqUDfpnttWevJw1bzqZJjQsHPqwZGSxfdVu/+8VgXwfS/g4b9pZYPIbVSypTQyPWW0jn43hfJ2aIeXiJVr6JomEsk8b+Ncfi7ygywphTZDFirqiF365zA5oZr1XZAx1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1vk7g1wmqaPar5pKW6awBjDb3OOdoRBEMaOV3nQ8bQ=;
 b=wicUSMe4l0jbZ1wgERpqMDYGB7qv4B0FZwCNGo7efIqgscaUIFlyFa30/MQye4FMm1qwk00rhlJlzRiTFwQtY4jpWITwS6F9ZdDxrhsMojpKHbTOr2tJjdF0Pdh7+yOG/Zq5JoYiG3+A0Ny0T0HUUaUO0DEjfcSimeEjApP6JcIHi2k3+KSYxuHqWIU01Bcbj13n7vzKGY7Zh/PRM9MYSTuSohnW8Cign3w4UbjGpuFj6caaRCkWNiaO+aMKWENttZ5qi0E5mIfh31QC7tpY+QZNakLm8zc7PdVpfY/1WnEyFQHPXTBnWf+XA2b0dhdk+kTV505PwlReO5DvVXtGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1vk7g1wmqaPar5pKW6awBjDb3OOdoRBEMaOV3nQ8bQ=;
 b=nwYQIXDGSg3syeXtA+tLiTQcNCVkLKdfiRdU8ejU2iZ/pz39T5Y0x6FG+COeWkIqB8EWYFyYy++OAmx9TRT6pkSpAdPspa7JhorljwGX9u934Nniz5hhX8tWOYC4A/WvGU7F3IUPqEy1P3OT4Ywnpjm2sTjzuEirvi5CPgYfmy0=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB7668.apcprd03.prod.outlook.com (2603:1096:400:41a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Fri, 23 Jan
 2026 05:56:29 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%3]) with mapi id 15.20.9542.009; Fri, 23 Jan 2026
 05:56:29 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Vitor Sato Eschholz
 <vsatoes@baylibre.com>, Julien Masson <jmasson@baylibre.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?utf-8?B?U2h1LXl1biBXdSAo5ZCz5oGV5piAKQ==?=
 <Shu-yun.Wu@mediatek.com>
Subject: Re: [PATCH 1/2] pinctrl: mediatek: Add pinctrl driver for MT8188 SoC
Thread-Topic: [PATCH 1/2] pinctrl: mediatek: Add pinctrl driver for MT8188 SoC
Thread-Index: AQHchssjXLIsF53fY06HXA3CF2H4KrVfTHEA
Date: Fri, 23 Jan 2026 05:56:28 +0000
Message-ID: <ac7fe0d340567d07bd71b3990bd6e78d856a611e.camel@mediatek.com>
References: <20260116-add-mt8188-pinctrl-support-v1-0-fdf3b9227c71@baylibre.com>
 <20260116-add-mt8188-pinctrl-support-v1-1-fdf3b9227c71@baylibre.com>
In-Reply-To: <20260116-add-mt8188-pinctrl-support-v1-1-fdf3b9227c71@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB7668:EE_
x-ms-office365-filtering-correlation-id: 06a3c8eb-bb5b-4c1e-72ba-08de5a4426fa
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QVJxWHcyMGl0TzhMUEE0U1k1c3hHZWpRY2RoVmdxaG1DT0k1REFKTURER0h1?=
 =?utf-8?B?Ykw0VlNwWW1oa01zY3ozYjNZaFZWQlFHMDZvUVZyVVE5V3hYZGNqSVVQbUFU?=
 =?utf-8?B?aElkeWZCdEZVZzg5YVRvOHExMC9PaWpvWFNkT1dTam1OcXNySkEwUkFSRHJG?=
 =?utf-8?B?cEhOVUt5bkhvbmxkOXNsaVUremdMM2oxQ0d4ZlVRMHJncWJUY3FiSkxud0dT?=
 =?utf-8?B?SDZEQmhOTEcrQndtb215S1VWSFZnOGpqc2ZTc3BkaytRaktYUWZBRzdLZ0hD?=
 =?utf-8?B?ZENvUzVOU1lhZzZnUXBZTkNWdHB5WU1Ebm9VYWduazJEZG5pYStOOEtWUFdS?=
 =?utf-8?B?Z1VXVGZzZlNJdXFVODhrRVhIMEduZWRxRWVKR0VhdnAyYmFtNm5VeTRhNzRh?=
 =?utf-8?B?YlB4YUE0WDNHeXlENEJjMHJjVURnQWRNVkxkTEFuYnJRa3hGRmFwblNNZGpu?=
 =?utf-8?B?S29zMDBoV3lsUy9CNDMxZXBqTm9mYkViRDJUQXdnMFEyOERpUjBMOWgvRUxE?=
 =?utf-8?B?bVlsUTNZdWdTOEdpRW02VDVUTHdtcW5aNjdlV1JPNEVCTHZDdVFidmtJaUhI?=
 =?utf-8?B?WVZINlVwU0xJbXRJelpkRjN0cjZSSlExeHZJdDJHeW9hUTJKamVSd3dZdHlP?=
 =?utf-8?B?bG9aVks0ZU1rRlVOS0dKcXZsbG5QSFdPTm0vTWZpY1FRdmgwQzVMcFZOUzNI?=
 =?utf-8?B?NkVpYkFtY0FvS0h5QzZldUlOaFB6WnRCR2grd1o3TEIvcFZ0eDhPakEzRGU5?=
 =?utf-8?B?NitvQ1RjdS84c3N4b3QwZXN2NEJob2pBb1hTTkUxU3pIZExCWjZGSFR4OG4v?=
 =?utf-8?B?bTNwMUhFWDdNRXdKS1diaDA0TjUrcG9sMEN5QzVYbnpid3hGSmhncmVqaExO?=
 =?utf-8?B?dkJaYlgyL2VQR24wNXBMUk5IczY4WTJRSFUzVG5LUGRDTXpBTGhBcVM5OWYx?=
 =?utf-8?B?cnhYNXExMWNrYmVZZlN3WVR2S2JSUi95YlZDS3ZWZ0hPTnlpTjFOV3ozUG1Z?=
 =?utf-8?B?WGkwKzlpNlc4MW9OT3pxbEdGTmRTVUVrR0VVY3hOUG8wLzVhUGJCVjFHeExL?=
 =?utf-8?B?R0ZwTmRadmNmWDNJdEZkL05QNmx3YnpiZ2FSQk5iOVpyK2VOQXlzbEhGZVNq?=
 =?utf-8?B?bjdWclZPRGlabjRvZHZyUlp0WDlnUlBTNnYxbVJhRXNxV3haNG1nemZCbXgy?=
 =?utf-8?B?S0V1Sjl0ZjNTMks0QXFuWktza2tuRU44ZmVGL0NXalhwbEgzdlVEUERuRkFR?=
 =?utf-8?B?T1lWRjBycThsNWFBcGp1MTNvUDZqM0pRZ1J2dmxJalBpS0RmTE9qcVNyTGhv?=
 =?utf-8?B?MzZ3bThLZG5jeTVSUzd4RGtCY1BZcmNNS1BCOFNORXM2NXhYblRQYkh1TGFU?=
 =?utf-8?B?NDBLQXFmaVNiR3dlZ1BkU1VqR2RkVWtreHlTbzR4dm5UUnRXZmw0UUFwMUFv?=
 =?utf-8?B?aTNTYldYUFdRb3NEVVJRcERVQmtHcElrMWdIeFhVZlJvQ20xQWRQcFlmcklB?=
 =?utf-8?B?a3BKSk9DV3pRK1NZT2Nka2xTQStVMUhmaVI2MnIyRUZiMHUxNTEzcFBiQjli?=
 =?utf-8?B?UUp4YU1nZ05wVFVmU1BtZ3Zrb21LS0dzUkxkcHVZc2dlN0VMNmliWUhCcDQ4?=
 =?utf-8?B?aUswRW5ja0YxYVF0K1pmV01jeW1IUXJXYzV1ckRSNG5MN3g1NWxMYVpCUzNY?=
 =?utf-8?B?QnJuRXRpZWhEOEJ6bmxTbDZ0aWo5K1E0eU82RXdrd3JXMWF2a1lRZEtuK1Ex?=
 =?utf-8?B?S2NybEVrRDJJbHpRSXlNTnV1Z0NvdWpYZW45Y1pIQUEyWkZKU3NzaG0rdHpC?=
 =?utf-8?B?M3Y4RnVhR055U0prTS9ULy9nNXhMVEEwcENwSWhEMmgvT0lxa2QzR200UFdq?=
 =?utf-8?B?RlVRSExhejd0UlFpOTh1U2gweVNmVFVxdTZURUFtZGFCSGFpUXpYOTZ5QTJn?=
 =?utf-8?B?aWgreDlrVi9ZL3hGMjFzOGdhR0gvVTY2OGhPdjk3NStzZlVKbUZoK245ekpB?=
 =?utf-8?B?MVQxbEh5SHpSTGdmeGVjejlaOUxoOTFZNHBUMFB6WTRCTkZqUWF1d3hxeWJv?=
 =?utf-8?B?ZVBjZG82ZTk2dEsvanVER2I2TlBWa3YwSGFOMnpuYS9HdzFIY2RyeDlDVTUx?=
 =?utf-8?B?Y1JnZHhOdHhOYmJnUXMrNHB1ZThEU3BNaldxY1g3c2U3N2FkQkZHY1Z0eVZN?=
 =?utf-8?Q?EPoYM1GXIc1WJC06yTUjqTU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QVpnOXNpanpGbzlRTTFhVHM2bFpsUmtXVVZyamtzVXR0RGM1bnREUm5VR3kr?=
 =?utf-8?B?MXRmUXZjSlB1U1dTWkV4V3VkSFZKY3NUUlEvQnVIcXdqeEVpUnprUHVQWXVX?=
 =?utf-8?B?M0NMSHpqTkVPTTRXWWZWMHFDenh5SHYwamxQNy9QenMybUNsclpZTDkwalN6?=
 =?utf-8?B?QUIxN01tMDkyQUdCazMzMTYweVlWeDAyVFFaejVxZzN2c1p5VDBRRWlCcTVU?=
 =?utf-8?B?ZjZ1ZW5YSVlVdmxsbEo5ZDVvZXlzb3dpMDBNWVFiTFNYeGM3QUpNdjBnenRl?=
 =?utf-8?B?aHhNMmt5bTZyNm5BQU9vaVh6eHRQYlVyMmtVUjFqK2lidnFaY25oT3RUVnFU?=
 =?utf-8?B?d2MwaDQ0ZkVTbDUzT3N6OUluNmhWUFN1aXQ1M1BwMHNQOE5ka2FmdTNyeDJU?=
 =?utf-8?B?VTl4ekN2cDl3ZmlZSm5aSm5qWDl1WTIzYTFNdlZWdVhDNC9Pcm5CYk1RVElt?=
 =?utf-8?B?UThpSWlWZE9Xc0JVclgrVm01WW1KSEhORWQxcVFnenowcGRYNW5VSGNuamRK?=
 =?utf-8?B?NmtXMDYzL1kzK2w4enh5MGIyZGlXbXFxUFd5b0o4b0tWZ2V4eFBieXk3ME5Y?=
 =?utf-8?B?UnEvL2pYeFVMQlpKalI4R3dYQnhlVytHOEtRZGtaRGJvb2x5WisvV3IwVm1z?=
 =?utf-8?B?N1VKQzhzeFZkTkFzbEdpOHN2aE1teU9jNkJueFMwT1djeXBoZVRXNFc4SFND?=
 =?utf-8?B?RzVEbm9XTkY1VHlBRWx5NGZOMDd4eVJqRjk5dzJ3dFZoWG1JMFFvWFkxN2RO?=
 =?utf-8?B?MlFLTThOeVZ6V1pVM0pTbTdLRDR3cHJzNUIwSzA3Q09ZTXlzSTlla1J0bTJn?=
 =?utf-8?B?UWRuTkJ3RzBpcWszdjZZdEthTGxGUFVKeEI4WW80RDRTWG0yZThmMFJBVkxX?=
 =?utf-8?B?Y21DZjkxa2lLT3UzRTU3QS9BZkhIazN6czVRcks2WlMxZUhsZjV1UG95bXRX?=
 =?utf-8?B?UTcyM1dzak50dlkwSjBMT3I4aDZBUkw3QklacXp5NFdpTkRxUFlzK1Y5T3Rk?=
 =?utf-8?B?Q0ZYKzMvYjdtM1RiRG1CaFhZWnhtUkp0NmlHcXVhdmV1WStsR2swZWs3NHVG?=
 =?utf-8?B?WmJ1WjdxNDBqNkhWd29LNmZCR2JqeFhvMjBKYzRMeWplN05ISmc1WWxITm8r?=
 =?utf-8?B?T0J3TXpwSk5GZXpPbzNFTmNaWHpLOEVQT25BNUgydVZIWFBqUHJUbUpkWmg1?=
 =?utf-8?B?cFdwQ0wzRmpqd1Z1SGorMHZwelNjNU94U1B1VmJlWnZkQVI4cHhORUxEblBp?=
 =?utf-8?B?L28wU081YTI0UHJnU011dlMzYWlPTmVDTTI3ZHNpQklOSHVOWTZYdTdxa09o?=
 =?utf-8?B?OWQ0citKNkF6LzUvbjJhTkFIUG9rYlVDblhnZnIrclRaL05talRLb0dXK0V3?=
 =?utf-8?B?VytZM1UxUGxGQmlYYVc4blYrcnhIcnpLcG9OY0N4TEJ1eU9wMk1zeHZhWk02?=
 =?utf-8?B?TTdqaUhoL0VPNUpUN0tpMHlBc1A5Vy85cSttRVJsME45QlZGQ3ZtM0t4empI?=
 =?utf-8?B?TTR5MjBNZnBkbmppMy9iNjNIV0VKQWJmRHFtYkV6V1VRbUJ0NkM0QzRsRWRp?=
 =?utf-8?B?V2l0aFJrSFdvOGVOY0x1bzZuQkpxam5Jb1RQSGpEdEVPd3ozOXZBOHdWcHhT?=
 =?utf-8?B?dGc1OEEzbm9YVEhJaHI3cVMzbkNOVzRYeEFIdUNHQjV6Z2NJVlRJZDFGczF1?=
 =?utf-8?B?eDZ4VUxYbVBuVkI0VDAxRnZkSHVOd1NlbXFiemVIKzZ1dzQ4anhWa3drRGh6?=
 =?utf-8?B?NkF1R3ZjR3dZMXRiRlREY3BwSzEzTi9lRkhqUytmR2tqbXp6LzU5Q1ZqaTNL?=
 =?utf-8?B?c3JiUFZ6VGF6NldPMDZnbGVCYTQrdWVsRG4vc1g2N3lIZHkzVm92NDhkbU5n?=
 =?utf-8?B?b2lwZUtEQ3dqZ3RZL1pBZi9xS2tPMmVvcm14SW1xWUZFa2svRm9zVXU1LytK?=
 =?utf-8?B?N3h3M0Y3eWlHZk1rUnhRRi9vWkZST1h3SkcvYS9ZNm1lYjFYZEdSOGp3aXQ5?=
 =?utf-8?B?NUxGeHNyc3lmYmlLTW1rdFBKaFhDSnNwWWE3eXMzL2ZGRDFlSHNsWElscGNt?=
 =?utf-8?B?NWxmUUcyVFNmSVBpbE1sZkJVUFh3VGN5bnR6UmduYU8rTTJnamRPcmNyYVlu?=
 =?utf-8?B?aFZhb2Rla3g3b2l6WGo0cytBM0dIVGtBbC9xblkvQTZSQzhyUW8zRVp6U2h0?=
 =?utf-8?B?dTZjcXViMStOckljcFJScnlMdUJpRExhZUNBTEtHb0VXcWFMcFZ6bzJQbnJQ?=
 =?utf-8?B?dDNKanVxVGZveUx2YkFacmh3MDhvMlpEa0tSOFFjOGlGUHV1T2wzRTlSaTJY?=
 =?utf-8?B?VGIxR1BJR01Bak03N080SHNqYnduMkpSTHppZVpKK2lqWE53eTJoc3ljbjZQ?=
 =?utf-8?Q?xNHEKYnQS+Kq8Tyc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2A9FF181DDA0E34ABD4E48FCC71A63E2@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a3c8eb-bb5b-4c1e-72ba-08de5a4426fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 05:56:29.1149 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g4dj2EmxcAD49R6ltw8nD9x73j8AYr7wM375/m56ixCGagJJU41ZHRzKHOgP9jflREr5uXOwokKK4Lh3d+DvBInrJcuVx1atFmq5huNNqL4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7668
X-MTK: N
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

T24gRnJpLCAyMDI2LTAxLTE2IGF0IDEwOjMyICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gRnJvbTogQ2hyaXMtUUogQ2hlbiA8Y2hyaXMtcWouY2hlbkBtZWRpYXRlay5jb20+DQo+IA0K
PiBBZGQgcGluY3RybCBkcml2ZXIgZm9yIG10ODE4OC4gVGhlIGRyaXZlciBpcyBiYXNlZCBvbiB0
aGUga2VybmVsDQo+IGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IENocmlzLVFKIENoZW4g
PGNocmlzLXFqLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKaWxsLld1IDxz
aHUteXVuLnd1QG1lZGlhdGVrLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVml0b3IgU2F0byBFc2No
aG9seiA8dnNhdG9lc0BiYXlsaWJyZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVw
aGFuIDxqc3RlcGhhbkBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqAgNCArDQo+IMKgZHJpdmVy
cy9waW5jdHJsL21lZGlhdGVrL01ha2VmaWxlwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgIDEgKw0K
PiDCoGRyaXZlcnMvcGluY3RybC9tZWRpYXRlay9waW5jdHJsLW10ODE4OC5jIHwgMTM0NA0KPiAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgMTM0OSBp
bnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVr
L0tjb25maWcNCj4gYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvS2NvbmZpZw0KPiBpbmRleCA0
YTY5ODU2OGE3ZS4uMDRiNWU2NWJhZGYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGluY3RybC9t
ZWRpYXRlay9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9LY29uZmln
DQo+IEBAIC0zMiw2ICszMiwxMCBAQCBjb25maWcgUElOQ1RSTF9NVDc5ODgNCj4gwqAJYm9vbCAi
TVQ3OTg4IFNvQyBwaW5jdHJsIGRyaXZlciINCj4gwqAJc2VsZWN0IFBJTkNUUkxfTVRLDQo+IMKg
DQo+ICtjb25maWcgUElOQ1RSTF9NVDgxODgNCj4gKwlib29sICJNVDgxODggU29DIHBpbmN0cmwg
ZHJpdmVyIg0KPiArCXNlbGVjdCBQSU5DVFJMX01USw0KPiArDQo+IMKgY29uZmlnIFBJTkNUUkxf
TVQ4MzY1DQo+IMKgCWJvb2wgIk1UODM2NSBTb0MgcGluY3RybCBkcml2ZXIiDQo+IMKgCXNlbGVj
dCBQSU5DVFJMX01USw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL01h
a2VmaWxlDQo+IGIvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL01ha2VmaWxlDQo+IGluZGV4IDU2
NTI3OTE1N2Y5Li5iOTExNmMwNzNlYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waW5jdHJsL21l
ZGlhdGVrL01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvcGluY3RybC9tZWRpYXRlay9NYWtlZmls
ZQ0KPiBAQCAtMTAsNiArMTAsNyBAQCBvYmotJChDT05GSUdfUElOQ1RSTF9NVDc5ODEpICs9IHBp
bmN0cmwtbXQ3OTgxLm8NCj4gwqBvYmotJChDT05GSUdfUElOQ1RSTF9NVDc5ODYpICs9IHBpbmN0
cmwtbXQ3OTg2Lm8NCj4gwqBvYmotJChDT05GSUdfUElOQ1RSTF9NVDc5ODcpICs9IHBpbmN0cmwt
bXQ3OTg3Lm8NCj4gwqBvYmotJChDT05GSUdfUElOQ1RSTF9NVDc5ODgpICs9IHBpbmN0cmwtbXQ3
OTg4Lm8NCj4gK29iai0kKENPTkZJR19QSU5DVFJMX01UODE4OCkgKz0gcGluY3RybC1tdDgxODgu
bw0KPiDCoG9iai0kKENPTkZJR19QSU5DVFJMX01UODM2NSkgKz0gcGluY3RybC1tdDgzNjUubw0K
PiDCoG9iai0kKENPTkZJR19QSU5DVFJMX01UODUxMikgKz0gcGluY3RybC1tdDg1MTIubw0KPiDC
oG9iai0kKENPTkZJR19QSU5DVFJMX01UODUxNikgKz0gcGluY3RybC1tdDg1MTYubw0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9waW5jdHJsL21lZGlhdGVrL3BpbmN0cmwtbXQ4MTg4LmMNCj4gYi9k
cml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDgxODguYw0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMC4uMzg2ZDRkNGE5MjINCj4gLS0tIC9kZXYvbnVs
bA0KPiArKysgYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDgxODguYw0KPiBA
QCAtMCwwICsxLDEzNDQgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4w
DQo+ICsvKg0KPiArICogVGhlIE1UODE4OCBkcml2ZXIgYmFzZWQgb24gTGludXggZ2VuZXJpYyBw
aW5jdHJsIGJpbmRpbmcuDQo+ICsgKg0KPiArICogQ29weXJpZ2h0IChDKSAyMDI2IE1lZGlhVGVr
IEluYy4NCj4gKyAqIEF1dGhvcjogQ2hyaXMgQ2hlbiA8Y2hyaXMtcWouY2hlbkBtZWRpYXRlay5j
b20+DQo+ICsgKsKgwqDCoMKgwqDCoMKgwqAgVml0b3IgU2F0byBFc2NoaG9seiA8dnNhdG9lc0Bi
YXlsaWJyZS5jb20+DQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGRtLmg+DQo+ICsjaW5jbHVk
ZSAicGluY3RybC1tdGstY29tbW9uLmgiDQo+ICsNCj4gKy8qIE1UODE4OCBoYXZlIG11bHRpcGxl
IGJhc2VzIHRvIHByb2dyYW0gcGluIGNvbmZpZ3VyYXRpb24gbGlzdGVkIGFzDQo+IHRoZSBiZWxv
dzoNCj4gKyAqIGlvY2ZnWzBdOjB4MTAwMDUwMDAsIGlvY2ZnWzFdOjB4MTFjMDAwMDAsIGlvY2Zn
WzJdOjB4MTFlMTAwMDAsDQo+ICsgKiBpb2NmZ1szXToweDExZTIwMDAwLCBpb2NmZ1s0XToweDEx
ZWEwMDAwDQo+ICsgKiBlbnVtIGJhc2UgY291bGQgYmUgdXNlZCB0byBpbmRpY2F0ZSB3aGF0IGJh
c2UgdGhlIHBpbiBzaG91bGQgYmUNCj4gbWFwcGVkIGludG8uDQo+ICsgKi8NCg0KW3NuaXAuLi5d
DQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0K
DQpUaGFua3MNCk1hY3BhdWwgTGluDQo=
