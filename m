Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01E7FF01812
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 08:49:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBC1883F00;
	Fri,  6 Mar 2026 09:49:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="tnRp9DrX";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="V7kO85Uj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2C0F83F2D; Fri,  6 Mar 2026 09:49:48 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08AE7839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 09:49:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 675ba4ee193911f1a39cd589f645bc18-20260306
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=80e+Aoe8mIAaMJU6JOh7kDOwasqLZK4iIXGihut7syA=; 
 b=tnRp9DrXJPUTAtJYKHKJGD05ohe1SQ9JO+cja8JYqFqbz2VvuGNAkMi1cUkEBNZX3U/iKGlNiUzuSt27PjxUNjVkPEA0UyUQyCYzmjJ1McJ11ixTmdFerMVX39HfnN538nvjl4zfQSncHU3dLEJ7C/q9oxoyDsmrAMEq8oLwTNE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:3988d0ee-f647-48ba-b492-30a672e9978a, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:4d50987b-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 675ba4ee193911f1a39cd589f645bc18-20260306
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1865801673; Fri, 06 Mar 2026 16:49:36 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 6 Mar 2026 16:49:35 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Fri, 6 Mar 2026 16:49:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wr4u4hJ7f77vUCaYXyssvxgcZZRMP5e+/+6W2LTR2zdXE5lJQC2G2vuf2cYkIMIRN+iiUO1+AoYZpUetCHdrdsev+VcrXSZPVipM7YJvLywx1ayX5hjbBePbh7C9IMgEEb0y156U3QeddBCV1PIs5IDU4I0JKAIjSAQ+n+JgxMw386GTH8nd8lGpbXWxVDWyQCHM90hWZynZ+VChz47bVSsZE3V9e6/jD8dg6qzw3LgnqBXHT32vOVCHqzX5UkG4W8NV4Azt9GIMkeqNhVJZgaXmLg7knIDUHoja7m9EDyTI0Go0fGExFW2L9MD9nU/dqigRwkKdjHsedfnaqS5FfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80e+Aoe8mIAaMJU6JOh7kDOwasqLZK4iIXGihut7syA=;
 b=R5WiYqhHBQ7HNTBlAXtTD94bohHXxGX7clq18dYJ+iPZQEpS1JKnNNU91CdoWyjvyS/PWoKQF6aKFMSbuv7fs2G9j9ujg57qvFBnJVmVDSelt/Ehz22F2MS3SSXWwO4Yf6QA2UBHHfD9j9fWSBdXGNcImxX0+ZG5pisok4IpXTQ8UogAH/14YCeS8COe8M3K8n5v0IXXJlQWIQDCpF8I8Ttg4rUflf3k31c72BOuIrtzb6NILYT/rPiZo9vIpqJNz+iylbM9iNsXIfZ4DtA40ggQjsjPG33VdKf68ZE1AcHKUp4TTF4cn0h7SCgQkPm7hKxUabPF6xO/Ow69r4O46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80e+Aoe8mIAaMJU6JOh7kDOwasqLZK4iIXGihut7syA=;
 b=V7kO85Uj8kEo0HUYODHS5PfLTX8pfJ5Pl9p8ncuzpFQeaMVXS5RpY5Y6kSwZg3c3Wf4h1CHUCdZmEawDWoU5mx/otH6fSlZ4P92T626ndfBNQJrNq28YM1zYyfcHQk/PUHMbCOK6bQuOc1ySkck5+J0+h8JN3cAWfZTxayvm+KM=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by OSQPR03MB8575.apcprd03.prod.outlook.com (2603:1096:604:279::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 08:49:32 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Fri, 6 Mar 2026
 08:49:31 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] pinctl: mediatek: add bounds check on number of base
 addresses
Thread-Topic: [PATCH 1/3] pinctl: mediatek: add bounds check on number of base
 addresses
Thread-Index: AQHcmh4VhTh6bSG6iEu4PM0AnzC4hbWhWA4A
Date: Fri, 6 Mar 2026 08:49:31 +0000
Message-ID: <b82935d532f026e48956a6c0ed0054e28ac83e86.camel@mediatek.com>
References: <20260209-mtk-pinctl-mt8189-v1-0-a7a3069eda6c@baylibre.com>
 <20260209-mtk-pinctl-mt8189-v1-1-a7a3069eda6c@baylibre.com>
In-Reply-To: <20260209-mtk-pinctl-mt8189-v1-1-a7a3069eda6c@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|OSQPR03MB8575:EE_
x-ms-office365-filtering-correlation-id: 699ce6c1-312e-4a73-e84a-08de7b5d48e1
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: 6I7Y/n7kXTvJ5wqC9VHaGLp17gTyp15zrZrOgbWi0h+JNAJeJIYW2kkdn37bypTNkofpxar8q9eJCDniAiRsK6VKNo/JU+psOrJHsrsr5eEejuvhszBPrD6qW4ouqnyEOjRbDVRijz7qlqSq6QNwNt8LNUrjL4UjWsAcV3dwpEKqEwCoq9KsiLiXCK3OkS0OQTwV6eL+DM347lEk2+C3+xxNOki1W3YVhl3cKuPl8Uz9KJv645vqQMQ61vOUVwFM82D+CroIRhClQ3JV8VTospXIftglhII6wxlti6Xmx0qVyjQL+VVcUSwvtZJH+eOo3eWcEYYGFpljuTL0MDTx0J2jEPBhX8qJ50u1qv4V/QIzFLeJLT921LNn3tkfETUm3H2MS3/k0SucUxNGt1E/ZVbM5LQf1A/25Bv1YDQxWgnUihfZ9q5qD5joHcuwXStvjlGskPVEOjS7zn4mvzsAaP2CfZpBmV5dFTPE8fTj/CHDM25vXaPafYu8UH/LU90hUqc+kvOrs0ZwYd5BdNQj3oX6NdInizUVuKhxSQ9fpdJcWEOw/77sWV88Ve0ULC8pRzd3eUM8cMPWiv6zSR2TLWxghcNmcXcdGe/VQWZmF4yGtiLJ5gDQ2l7RSRrfBI0N4XxcGpXSugoj9NDVbI7BKTWmEB1A2KjNnj/DOI7d9Fgv2mWFyI5DtD3a/tZcBq0z7IrGwq3/jEG1zFB6VxDMYri9a0qMjO6SjIqlAF1n58uA8sE7pbBMtnx/oF/qXkg8Z8ig2d2AtsxdJBo8k6aDX8Di/RDAS/hJ2AgQsgzxLo8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDZPckc3YW1WbmFjOERQQTd1aGpoeTZEYlc1R2xORnpGTktPSWh6Q3dhYzFk?=
 =?utf-8?B?bDZVdmtweXNqdkJod2FkUTQ1RUVmQWpHWGxwMkJIZVRKN2xMMlhWRCtjNHBj?=
 =?utf-8?B?emJMOERuUFJ4N2k4bnFwZk9YeUxTYUtRcGdPWFJ0UUR1MWJkUVdBM3VHYnhi?=
 =?utf-8?B?T2pLMFBua1hFWjFrNlJuSStlaVZsaGN2YTVkbHNmNHdVaFJod1NhQVZaQzZa?=
 =?utf-8?B?VDVkWktLZ2Z1NU1IaEhMQ3FVR0pVdHhpdHRGUnpLZG5zL3htdlB4L0tTZW4x?=
 =?utf-8?B?MTltTHVJdHVNcDdkdXoraXg0WnBrZVNZNElXejVXM2paUTUzVjBpam1oclE2?=
 =?utf-8?B?M01CRVJhNkFlbDY0L3VVSFJTemcycE9CcEN3RmZ1YXdna3pJU0I3cDNYYS9T?=
 =?utf-8?B?WjhZK3BBNkYwa2hOQlVGcEVIZHpjUjZCdHhET2NRejRLeHlIbXljTVVRSCsz?=
 =?utf-8?B?R1hONnVBOEhCVys4VU1pK3ZoTlBGYWt6L1J0MFFzYlVVMGE5Z1YxZEx0Vjlw?=
 =?utf-8?B?VU9HQ3I3T3dNcjZBclp4d2dicm1saVAvWEFlRkhpWmE4aGUxeHVZenlvMkVX?=
 =?utf-8?B?SW8wTSt3blNQK0E3Zmpqd0Y2OHh2SmMyc3o1UzFEVHR6NU1yTTM4aEpwRVd6?=
 =?utf-8?B?Z05sdGR0bjJUSWx2bkduWXFPSERDb2VzL2E2T0JVdlp2NFZTMUNSbk9DOFdL?=
 =?utf-8?B?S21PaFI4V2lHUUdjZEhDZHlYYzI4V3diK1F2dW5MMSs3Z1UxQWp5QnliM1Nu?=
 =?utf-8?B?NkorSkdib3lXWERZdlVnMWRnZW51ZjRIUitGelRSdE5TelFJQmRKdHpOOGxF?=
 =?utf-8?B?Y3Qwd1BMaHdHZndJZFRTVHFnZXBhUkp5WUFBM20yQktwajJzRmJ5V0VkdGJm?=
 =?utf-8?B?ZmtqQmRhM3dHMW5xNHU0WGc2eUZLdXZMS1QycGk0cVZDVWZCWHRmQWxHOTlJ?=
 =?utf-8?B?M3R6Tm45RnpacEQ5WTdCeHdBOXM4cVdTOU05ZDBuRWN0aGxSSE51VmIxcUt6?=
 =?utf-8?B?SVJudzdlOFoyWDRwb0dvcHYxQ3A0WGpxMlMxOTB2YnhBL0NWNmFRSHJXLy9I?=
 =?utf-8?B?N0IzU2s4KytJS2pnU09aTThUZldxUGN2NUZwUXcrcDhtdnd6MENWaERjSm11?=
 =?utf-8?B?UnAxeEZVa2F3ZjIrMWpOWnFNWEdCa1FMNmdTZUE2Um00SEhRaFcyVFJEVjdT?=
 =?utf-8?B?M1dmcHA4WFIwdWtldHVMcEY0OUpWdW1VbENyQnlmL2tUR3ZNWlBMV3cwRzgr?=
 =?utf-8?B?LytNN2pXcHZ2WmFnQStLQ3orK0pMVmE2NVU3M3BlM3grR2FHS0R1SjNtckRq?=
 =?utf-8?B?STlWcm41dVZZcWhXVE45ZHovUFd5bzkzUUN6MkV6NGFvbjZRdDJQek50NWZK?=
 =?utf-8?B?UTBHQ0dBbUtqVThRRlhqL0dJQWZKQXkvK2FvSnRSMXNBNTUrVEp1SmFIbFRM?=
 =?utf-8?B?dVIzQnloZDk2YVNFdk5BRmpyeDhSa0VLa0xqa2wxd3g5YXBMb2RFWXdRSWd5?=
 =?utf-8?B?eERXbzJqR2ZacGpDVjU2aXdha3k5U0xvY1ozTmhCcjI3MUZoWVRoUDE0WXRz?=
 =?utf-8?B?a3RsdjMzUW1GZWhqUHdtZTA2SENVTjZJbFB3RXkremtzMGd6aEV1KzlTY2Vu?=
 =?utf-8?B?SUZMQitqa2JzS3JJYVA3VlQ1QXptZ2dzVFM2bVNHWDBSc2wraWc1cGVUdGdN?=
 =?utf-8?B?akhKRU1iMmtmS1FBbjBuU3RyQ0NteDd2YW92NFEvbnpURGoxUzhoVldrdFM3?=
 =?utf-8?B?RWhsdzd2RXZRNkhvWk5QL2tCSlU2V0x4c3RaYlZlV3NJanVoVzZ3SUhyalNM?=
 =?utf-8?B?Ykh4SVZ2RExJREpEUHJKS2VGTjBWdG9mcHI2a1U3WEViMGgvVnV6TUFNZytX?=
 =?utf-8?B?bWtTNVVaaW9HMFlIVUhmajB4bDZ1N2NtMlIvNjYrb1huM2VObjlIc2VBeTFo?=
 =?utf-8?B?dGUzVjRPblQxTjJORXpNanFMZ2VPUlE5eTlnaXlrNnVFM2luemUxYU15Y09m?=
 =?utf-8?B?QytoRGZIa0U3NlVCYWlNWDZGV2xNZUluSmc2bERJZVJ2Z0lYajU5eGwyenNk?=
 =?utf-8?B?d3NuR1dEUmo3VWFxeld0ZkMwYnphaG1WbERXSGtnQ0h2U2FnbFhMYmhNZmdS?=
 =?utf-8?B?cmRYV3lpOE5IN1JhSzlyZXhDcWdDdU8zcXR5UkJwR0RFdmJ2ZHpxb2lUTFFO?=
 =?utf-8?B?Rzh5RVdDaHkwQmpTYUE3L29zZmZjK0tXT1pIdGp4NVN6b0d1SWNMb01uSnR0?=
 =?utf-8?B?bGlZTWJQbmFJTG5JSXdSZ1FGZXdhejMzQTVicW1MSUFiK2pBb3haTXEwZFNN?=
 =?utf-8?B?YmxjMU5OTXFkQUhrK1VFcEVLNUE1RTV0a3oyTStCZjlkUUtSLzdTaW16aGtU?=
 =?utf-8?Q?SDBJWnBzMgQypUyg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A7669134032C0A4D84B9B5A0BFBCAB5A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gsdvoffeAXvWMzk45Cyc7qrCWcfsEek8ju+KgWbQIiQPgCyESYPk5wfMq/QlC6G54tz052bTHlRnycWakwFRfpo/zNGxVXE1UTgWVEyVvErpfORMZojT28yoY0M8wNhqblLyGSn+YHBhJQg4XncVp3jWLsGS94Bpt2STBJcWCp3UtU1IilzHOUtyk0pW88PwKpNv7wCnYroceSuFwrTbaH+GDwYrJGJbAnlsnDPiKA+hJ8+qn+f7Z6gblzD2Wb+T4g0IIWHYqDznwULc5fwOeCZkGUK5AyH+E20oHam3L3KqlJGHLYAhUXfyqkVGYi0ftKqHlwJx0qJwL4rnXCSXjg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699ce6c1-312e-4a73-e84a-08de7b5d48e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2026 08:49:31.7894 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mrx9t8AuEYa53XQQxirhyoqT2nxcorevBPX7d7rz7UMiX+2OdOOqgUkpEKYSruyES+F8K6KFj5def6PJfX7QMjvQWdWwrTWYYP60y/Mhmu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB8575
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

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDE3OjM0IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgYSBib3VuZHMgY2hlY2sgb24gdGhlIG51bWJlciBvZiBiYXNlIGFkZHJlc3NlcyB0byBw
cmV2ZW50DQo+IG91dC1vZi1ib3VuZHMgYWNjZXNzIHRvIHRoZSBwcml2LT5iYXNlIGFycmF5Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29t
Pg0KPiAtLS0NCj4gwqBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9u
LmMgfCAzICsrKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLmMN
Cj4gYi9kcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLmMNCj4gaW5k
ZXggZTk5MWUwM2VhNDEuLmQxNTJlMjE2NjM0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BpbmN0
cmwvbWVkaWF0ZWsvcGluY3RybC1tdGstY29tbW9uLmMNCj4gKysrIGIvZHJpdmVycy9waW5jdHJs
L21lZGlhdGVrL3BpbmN0cmwtbXRrLWNvbW1vbi5jDQo+IEBAIC04NTYsNiArODU2LDkgQEAgaW50
IG10a19waW5jdHJsX2NvbW1vbl9wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2LA0KPiDCoAlpZiAo
IWJhc2VfY2FsYykNCj4gwqAJCW5iYXNlX25hbWVzID0gMTsNCj4gwqANCj4gKwlpZiAobmJhc2Vf
bmFtZXMgPiBNQVhfQkFTRV9DQUxDKQ0KPiArCQlyZXR1cm4gLUVOT1NQQzsNCj4gKw0KPiDCoAlm
b3IgKGkgPSAwOyBpIDwgbmJhc2VfbmFtZXM7IGkrKykgew0KPiDCoAkJaWYgKHNvYy0+YmFzZV9u
YW1lcykNCj4gwqAJCQlhZGRyID0gZGV2X3JlYWRfYWRkcl9uYW1lKGRldiwgc29jLQ0KPiA+YmFz
ZV9uYW1lc1tpXSk7DQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGlu
QG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
