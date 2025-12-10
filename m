Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2823ED3C525
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 03:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C62683B48;
	Wed, 10 Dec 2025 04:20:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="chMD2FFI";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="t4rSZEwV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA0DD83B4A; Wed, 10 Dec 2025 04:20:27 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47ADA83AEF
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 04:20:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 2285956ad57711f0b2bf0b349165d6e0-20251210
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=THDco1EXtgTvQWmvkzcIfRRkv9lhS09I+PdRCuRrR/o=; 
 b=chMD2FFIpv3yfhjxaRjRfWugJ05mbqamNejG8B5Hg2mjEhjry/H3eVPnAWzocQfKSySo3nXReCYML71l0OdKBzvkyJ/zyOyWjTOyoER9FF19rd+ACb3Y7YotzgyTB42VGlf/haMguwM0fQYVlMhqO92MClmxUS8PYLvbEEwKdGs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:d1662929-c3f5-437f-8f5b-f8917a017f0f, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:ba0a9902-1fa9-44eb-b231-4afc61466396,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|80|1,File:130,RT:0,Bulk:nil,QS:
 nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2285956ad57711f0b2bf0b349165d6e0-20251210
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 412188092; Wed, 10 Dec 2025 11:20:10 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 10 Dec 2025 11:20:09 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Wed, 10 Dec 2025 11:20:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VgsUZrkxAlntgOiDxvy+GbCCMINuFQ0gWp675Y3kXUXExFkOA8iZaoIxiBOzENgkstOu0vPRcpKUZHb/Xri7lgoaVb9PZyZzXRVlCqtzkz81n1Eux9NAjsaRpIcxFfywoprTBos39x+CvjT60PjEh2MK1bDMinqWeZ1Bk6is6Bo1mL7qoEn453a5tYyycycti9QZAXR8ObBPpmMpJe64DcwB6aoJgIwJiLUSJTEtLxSpBowEKXmE8p40bMKd4hSW8RzgpkzQXYQNMXD3VD7SdLOAitu383pLeZ6T2Tqv8AEJ0GtvtB95nYS1Wctd2hqqs7nFHmgQg8HI1PjXXNpJ/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=25SIEa+omY4IkpXy6p3pYcZhYOcMbxcBHIyKTQ0Ayds=;
 b=DZLtoW7JAAeCmfmALNARf4RPOnpKi3mlbT2U3hqVWJF5HdjOLKehIY8W4QxvPNz5SqV/UvmSrfewuaO0dXqbdSmtiXo8nH1xDiwwrMl449VuoXVjK7GcSjQVeoKoAc15RIpDS7RQfU76FFP9FKJ2iDp9KHMmzWquT8x+pPVD2zJ0YrPkqVRBiEzSDjD23mb1qSkpQcMrsaoe3hS2am1tvUSe3m7NOcdC+uMEEX5j9LGTzklJveWaUL++OvkBDwAJSG7NpGRLlEuHTvP/XGRu+lbs13b2ivLpLraWhK4XohlW5kJKdznB2n7sDheozThnFwQN4XiEaDhxu4/BUyxXsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=25SIEa+omY4IkpXy6p3pYcZhYOcMbxcBHIyKTQ0Ayds=;
 b=t4rSZEwVRFkgnzCGcHUaGieew73Y94F+EqUyaRzmKTsji9Yptv6mUEOxA0XR+XAVyhuOi5ukpYjej4i8oT7wHYNi2rzAlZUjMO8xXiL7s46AeEAjQJCFPqI6lCrp/v4h030u3Qnm8Uo+HlVaQdBXCDadCuHzthJ5lp92rjr6gS0=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KL1PR03MB7694.apcprd03.prod.outlook.com (2603:1096:820:e6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Wed, 10 Dec
 2025 03:20:05 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2557:de4d:a3c7:41e8%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 03:20:05 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>
CC: =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, "mkorpershoek@kernel.org"
 <mkorpershoek@kernel.org>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "stefan.roese@mailbox.org" <stefan.roese@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "malysagreg@gmail.com" <malysagreg@gmail.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Julien Masson
 <jmasson@baylibre.com>, "nathan.morrison@timesys.com"
 <nathan.morrison@timesys.com>, "alif.zakuan.yuslaimi@altera.com"
 <alif.zakuan.yuslaimi@altera.com>, "sumit.garg@kernel.org"
 <sumit.garg@kernel.org>, "lukma@denx.de" <lukma@denx.de>,
 "vasileios.bimpikas@analog.com" <vasileios.bimpikas@analog.com>,
 "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "utsav.agarwal@analog.com" <utsav.agarwal@analog.com>, "ziyao@disroot.org"
 <ziyao@disroot.org>, =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?=
 <Sam.Shih@mediatek.com>, "Oliver.Gaskell@analog.com"
 <Oliver.Gaskell@analog.com>, "seanga2@gmail.com" <seanga2@gmail.com>,
 "arturs.artamonovs@analog.com" <arturs.artamonovs@analog.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "jerome.forissier@linaro.org"
 <jerome.forissier@linaro.org>, David Lechner <dlechner@baylibre.com>, "Ryder
 Lee" <Ryder.Lee@mediatek.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>
Subject: Re: [PATCH 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
Thread-Topic: [PATCH 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
Thread-Index: AQHcZGOxzz51nEZvL0WyoHInDGYZ07US4dYAgAYwg4CAASygAA==
Date: Wed, 10 Dec 2025 03:20:04 +0000
Message-ID: <c219d665542faf2d87b02bd91a60e321b765e0c4.camel@mediatek.com>
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-1-9a06ebb97734@baylibre.com>
 <2130bf1ebe2e3684a3d1c7341249ce2ca524d0bb.camel@mediatek.com>
 <CAEHHSvbUNo0zxaasC9K8+k1i_S9H2GGi4GjF5qqMTibk=Q2abA@mail.gmail.com>
In-Reply-To: <CAEHHSvbUNo0zxaasC9K8+k1i_S9H2GGi4GjF5qqMTibk=Q2abA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KL1PR03MB7694:EE_
x-ms-office365-filtering-correlation-id: add497c6-5b9b-4e12-cc30-08de379b0379
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?utf-8?B?N21uWnlQWUZXTVViMEJuZ01qVERGZkNmYi9YQjRZbE8vek9EREIxZ09LOWJm?=
 =?utf-8?B?dytsSjlWTnVQeDhuWkhaeDJhdUhkSmQ2RG1tVVRkd0NHSCtGUlB6ODhoMzYz?=
 =?utf-8?B?cVFxcjVKVitJMTY5bkhhQ0FzWVdNdzVsMmFvL2ZPMVhHc0ZwdTJjOVYzUUdJ?=
 =?utf-8?B?S1N3OUVWVWM2QzdORmdLcEltQTBWdCs1bFhqTStzVm85ajI4dERDeEw2bWRL?=
 =?utf-8?B?dERBM2Y4K3RFRy8yT0xzc201L1RzT2hkYjBEYWFjMGN2eDlwL0VoVU1UMEN0?=
 =?utf-8?B?WEpzM3l0SU5Kb2xSQ2QrcjB4a3dOZWVhaWhtdkRqc3hDUU9vM1EyZFcwd1Rt?=
 =?utf-8?B?b1dkUVZyU0E2S3RURzdyODVPWlBHRWYwbzJLTFZGbTNxemVvQVFWMzAzc2tX?=
 =?utf-8?B?MlN5R3lBYW51MVdXT3VGRzluMkZZWll2aWZOQWFncDJyejNVbUxSNitYaEVx?=
 =?utf-8?B?eFV2WndnMmltbUtLV2ZYVEQ2bEQ5VEt2cUlCVWtXbHlxOEZxVjY0dnIwa1Jt?=
 =?utf-8?B?angwWmRmSVRxdTVmWUZ0bm10blJiK0FkRHY1UmlIazBXVkpOdm8vaEh6NHBz?=
 =?utf-8?B?c1NjNjRLN2hOUURZaEJMWnRiR3RpVkNob3NNSGFQdE1RWjdrdEp5UXhWSkE2?=
 =?utf-8?B?T0l0T2VxcndDR25MYWNKYWt1UDd5NzJtNzBKNmI2aklLWnV6NFhERHIxcjlJ?=
 =?utf-8?B?dUNHSHpnOEtGYUplZ0pZZjgyd25nSUZMZnI0MzRYT1lkaDVsQkYzeTR6MFN6?=
 =?utf-8?B?V1MxRVpKWVh5ditOZkZicldXc3p6U3IzV2Y3ZjFLZnEwUkdFeXZVK3hHSW1y?=
 =?utf-8?B?bDRNbXlHT3FHMWJiRHBlYldYNnczTC9XSkZCcnJOT2NHWnJtSDVzZG9POUdC?=
 =?utf-8?B?aDVWRkhkMGo3dkI1aFd6OGZwRFozOUtMdllFSTVLemVZTDBVcVA4aHdBS1My?=
 =?utf-8?B?aGEvdGVPN1JJeGhqNEhjdUxpSndWR3RVWGlvYTczZEsyZ3lFRWhMOHZzZGJ6?=
 =?utf-8?B?ZlgweEpteXFZcDBXRDBpRHRDc2NSSjFRVVRVcHVKWUJORnNDU0dSL2xKVWpo?=
 =?utf-8?B?aDBwbDE5RFZPZlZDMmpjdGFpQWZUc0ZHaDk5MForTG5yUG8xOEQvTGV1bjQw?=
 =?utf-8?B?UDdCRWs2dHRxTTdYSUthbmQzLy9INkNzM3h0YjJmUHBFSjY0WWNlOHJOWCt0?=
 =?utf-8?B?dENrU0NZakN2Nk5pTmNGNUNVSVZ3TzRkNkd5eVQreno4ZjhIYUlJTlE0WmVp?=
 =?utf-8?B?MWxCS21VWnd3MTRHc2lPdDhzNGcvMVRPOXAxNDYvT2pXb1pJeUlFY05EdHE3?=
 =?utf-8?B?ZmNwRHR4bVF2RVgvRzN5ZzZWelRIK0Q4cmljN29vRE56d0VQY1FKcElJVmdB?=
 =?utf-8?B?TVdVS2hYQmZVYjNLVjhsZjhDT2VtVlY2czNZbWdJcG5HWXM2dE1wYmVSalNw?=
 =?utf-8?B?L0E4Q3RXaFU3QXFwcGxoR3Q3blBpNTlFZ3E3eXFmOC9qRW54WVNKQmcwQlR3?=
 =?utf-8?B?bTB6Zk5FdE9zV0Z6dmd3SlBNSElGME9acDBWdFZWZjlJWjJOamZ0aVNmVzVK?=
 =?utf-8?B?VTZ2cjEyNTlmY3ZGMGdkTDJtQThabVlrK0hueTBBeURsL1Bra3E3ODhta0NW?=
 =?utf-8?B?dE12bkNVcklsdHVOdUVWcUtMQTJ3N0tnNnpJMkNXMVlXcjRmTEUyMlZHSEhS?=
 =?utf-8?B?WGpzYWhCMHh0QlQwaURya1doZGJEVWtvSHdUUUxXYWFHaXBWckhZSWdhc3Ft?=
 =?utf-8?B?WFRNaTRCRCs1dytoV0ZITmVnWVc2NkJBMVhEMm02NGZ1V2F0YTV1bW42TjFr?=
 =?utf-8?B?cFMrK2NPdUNmSU44VUdJRzVVVUgxWC9SMTFVRFZtdWtiWGwyVlNuTWU0ekxI?=
 =?utf-8?B?aHZWamNpQ3p2em5SZE8xdURGRmhQeC8rczRUUURjckludS9NZG9UZ1pjQXZz?=
 =?utf-8?B?UlVKcFhnSytlOXpFaDJCblNUNXlVbitYVDRQNmIrMWxVME9nUnltdUtpUGIv?=
 =?utf-8?B?SXFJNXBTdERXMjhHQmwzOUh4a1NxeEVXWWRWQzFPTXQxb3paZ0QzY3lwRmlj?=
 =?utf-8?Q?RRLFHF?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LytCNTRlaUx2cXhlNUxCOGVnUEpGYjk4UER2RlBTZHpYUVZhSGxqZkdjbmhh?=
 =?utf-8?B?RFdJSzAyVktkOFgxSlJOamhqb2xsVm9jdm5OZmEwQU1QcXJsUlpJZG5QODdE?=
 =?utf-8?B?dEFxSEJaeHJiT0V5eWFlSWxLbDIreWpHZzZmVTFWVlh2cGpSY2Q3cktEZzRw?=
 =?utf-8?B?VTBsYjBlVUtEVWtZMTZ6K3htM1JTVnA5S0VzUnZCY2pIbTY0eHB6UWFrRmxT?=
 =?utf-8?B?TDhSdWJXWi9LQXRzWGZtQjNvSUgvVElLZUIrWHVoOFZZTDkyWmV5RTBaTGs1?=
 =?utf-8?B?cmpMb3VJSWxoN2RPeGZuK3MvcDFVR3hIUG9WU052MWhReGMvMjNiNEVXR0tD?=
 =?utf-8?B?Y1poelpGTFVMUzFvYU5kQnVibTNTWGdpUVZOeXRRQy92SEZGV2ZRNDU3NTBX?=
 =?utf-8?B?a3lZVXZZbXY5aDlJNDEyVHBkRWt1S1AySC9SRVdtSENyVkt4VEliSEdQaW5F?=
 =?utf-8?B?NEkxMXVyYkZueWg4QmduWVFMdTVZeHVEbU5YTHcycnhZc0lwNGJnRHRWVUN3?=
 =?utf-8?B?Wmoxdi81SFdFUXFtZkZqa1VJZVV0RlJyNWZwdzNLZTZhUnVzdHhDNVVSVVcz?=
 =?utf-8?B?Z1FYTEpOOTZGaFIzR2dlKzI5MWJGRE9GVk1tSXVLd1d3V3NoYmFYM2g3Nk1K?=
 =?utf-8?B?UzdiUnBUb09tdXNRcnBmVDlsR2dnd1lhNDl3QTIvV3RPOFpRcjFqZzYyZnkr?=
 =?utf-8?B?eXZRMzI1bEgvQzVCVFJ3QTRXckplTWhvSWJWMFdkUHJXT2ZCd1RiTFUyRXpS?=
 =?utf-8?B?U2VtaXZUZVp0WlRGMHJSSGZDRHJtNGQ2d1pMaGRka2w5QlRvMzRIM3ZWeWIy?=
 =?utf-8?B?am43U0NyR3JXcTh1a2tWcDBYMENiNmdJdEhXVXlZWEdST2tHMmtjRzU3MmFa?=
 =?utf-8?B?MGJEeE5rcVhHeGt6M1BWSzdXd0J4SkZ1NTBjdUVvRXdKWncvN3BuMTVHeHJZ?=
 =?utf-8?B?STJpaVE0RE9OYUJ6RmpSN0V4MmJSRytGZUpLVjdLWitRS3JJSFJ4QmFjVER3?=
 =?utf-8?B?RGdFQnY2b05pTXBUNzlTYlVRRlU0dW00Mk5DcXlZRVZLV1VxblFWMW1tcXM2?=
 =?utf-8?B?SjVUUTVvUDlUVGFWaGNkYTkxOEo5OVBOc2trNzJaMm5qbGplVitKRDY1M3pX?=
 =?utf-8?B?YmJjdklMYmgzb2pQMUFsaEdpYXNKdnl5NGoveGlxTWFLYytSZlltc212L2ti?=
 =?utf-8?B?MkkzTXFJeHhYeWlaT3lzcGFlLy9KTmcrUkJWRUJyZGRLR2dESnZhbXdUbGtJ?=
 =?utf-8?B?aGxOZkFocnBLbDVueU1nQml0U0RESld4N0VLNVhxZGpTZTZkaENWS2J3cjdX?=
 =?utf-8?B?T2h5QWVyM2R3YlRtdkV3a1lKbHliTkg0RG9aRlNGSTdvSUs2WWVMTUhvdnpI?=
 =?utf-8?B?SmZxWDdSdG9oSHpVaVFCK3NjZC81dUQ2U0M4ZEY3NnI4eUZIaHIzaXlPWDhj?=
 =?utf-8?B?WU92MlNOSUdtZFdkNnNuR3REYUhheE5IVFlILzdnUlBVYm0zeGsrblp2T2xR?=
 =?utf-8?B?SzNONDQxOG9nQ2JXNXJuMXhvVGV1Yis3WWV6TkQwK3M0MlVhR2NwV2p4OHJr?=
 =?utf-8?B?TmhtaVdZbnExSzl6anpJcXRibHliaHVjRUJ2YUlubVpPSE85dldpYzZEcHhx?=
 =?utf-8?B?RjRzMld5dGw1YStmdEpDd1VRcFhpbDZ3bXMxR05nQUF6ODZxMVF1QzBnekw2?=
 =?utf-8?B?L0NJa2FlRnFxenRrWkZZdk9TdEZRR2NwK3MvRXZDcVI3OUtMSWdBaXhQM3lY?=
 =?utf-8?B?TXMyR3NqcGJpQnJQMjBHVmZSbDE0SjNnT2UzYkpwSGgrdzdjdDZoQ3RuNUMx?=
 =?utf-8?B?aW1jYTRWM2lxZHhFQTU1OU5DQWMxb3RUeVpXZmk4MHFsQU9UZTgvSWE4VVZp?=
 =?utf-8?B?aUxBSFp6TmdGaEFDY2Z1d0dlS3IrL0dyTE1uSmxxT3M4Z2JNU095QUVwSmsv?=
 =?utf-8?B?YkZIMEV3cnhPY01UYmltbnRqTkcydCtiT29ockQxeEdmd09zYURvVFRpT2l2?=
 =?utf-8?B?UWpwMHhUVVRiSnFtcklHMytEVll6WG81aFJqV1FaRXZWUjFTQmRMS0FxUXI0?=
 =?utf-8?B?dGdCdnFoUDlKWjR2TTZRaCt3NldrcW5VRGFVRVhlckt2NnFteE1pYitjOVk3?=
 =?utf-8?B?RDl1aDZzcFZzc1VUaUNkYWVsQ2hyU2NyeVB3ZGpqbFNsUVZNbURHWjVNVDFj?=
 =?utf-8?B?TEE9PQ==?=
Content-ID: <09F2E22E12833A48B9117B96C1457EC7@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add497c6-5b9b-4e12-cc30-08de379b0379
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2025 03:20:05.0631 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: al60X/jA2SgV2eLKnAm8PI+pcqW0s9fpIQqkpwur9pHXG1BOM0gB9nSgDfpVLb7/bs8WcgtYZistw1j2Nhx7xVR/Pm/tpr4SakNTL9/nsxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR03MB7694
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

T24gVHVlLCAyMDI1LTEyLTA5IGF0IDEwOjI0ICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gDQo+IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVu
IGF0dGFjaG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhl
IGNvbnRlbnQuDQo+IA0KPiANCj4gTGUgdmVuLiA1IGTDqWMuIDIwMjUgw6AgMTE6NTMsIE1hY3Bh
dWwgTGluICjmnpfmmbrmlowpDQo+IDxNYWNwYXVsLkxpbkBtZWRpYXRlay5jb20+IGEgw6ljcml0
IDoNCj4gPiANCj4gPiBPbiBXZWQsIDIwMjUtMTItMDMgYXQgMTA6MzEgKzAxMDAsIEp1bGllbiBT
dGVwaGFuIHdyb3RlOg0KPiA+ID4gDQo+ID4gPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBu
b3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cw0KPiA+ID4gdW50aWwNCj4gPiA+IHlv
dSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRlbnQuDQo+ID4gPiANCj4gPiA+
IA0KPiA+ID4gRnJvbTogSnVsaWVuIE1hc3NvbiA8am1hc3NvbkBiYXlsaWJyZS5jb20+DQo+ID4g
PiANCj4gPiA+IFRoaXMgYWRkcyBiYXNpYyBzdXBwb3J0IGZvciBNZWRpYVRlayBNVDgxODggU29D
Lg0KPiA+ID4gDQo+ID4gPiBBZGQgd2F0Y2hkb2cgc3VwcG9ydCBieSBhZGRpbmcgdXBzdHJlYW0g
Y29tcGF0aWJsZSBzdHJpbmcuDQo+ID4gPiANCj4gPiA+IEFkZCB0cGh5IHN1cHBvcnQgYnkgYWRk
aW5nICJtZWRpYXRlayxnZW5lcmljLXRwaHktdjIiIGNvbXBhdGlibGUNCj4gPiA+IHN0cmluZw0K
PiA+ID4gaW4gYXJjaC9hcm0vZHRzL210ODE4OC11LWJvb3QuZHRzaQ0KPiA+ID4gDQo+ID4gPiBT
aWduZWQtb2ZmLWJ5OiBKdWxpZW4gTWFzc29uIDxqbWFzc29uQGJheWxpYnJlLmNvbT4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBTdGVwaGFuIDxqc3RlcGhhbkBiYXlsaWJyZS5jb20+DQo+
ID4gPiAtLS0NCj4gPiA+IMKgTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+ID4gwqBhcmNoL2FybS9kdHMv
bXQ4MTg4LXUtYm9vdC5kdHNpwqDCoMKgwqDCoMKgwqAgfCAxMCArKysrKw0KPiA+IA0KPiA+IFdo
ZXJlIGlzIG10ODE4OC5kdHNpPw0KPiA+IFdvdWxkIHlvdSBwbGVhc2UgdG8ga2VlcCB0aGUgbXQ4
MTg4LmR0c2kNCj4gPiBhbmQgdGhlbiBjcmVhdGUgdGhlIHNlcGVyYXRlIG10ODE4OC11LWJvb3Qu
ZHRzaT8NCj4gPiBQbGVhc2UgcmVmZXIgdG8gb3RoZXIgcGxhdGZvcm1zIGxpa2UgbXQ3NjIyIG9y
IG10Nzk4MiwgZXRjLg0KPiA+IA0KPiANCj4gSGkgTWFjcGF1bCwNCj4gDQo+IG10ODE4OC5kdHNp
IGlzIGxvY2F0ZWQgaW7CoA0KPiBkdHMvdXBzdHJlYW0vc3JjL2FybTY0L21lZGlhdGVrL210ODE4
OC5kdHNpDQo+IG10ODE4OC11LWJvb3QuZHRzaSBpcyBhcHBsaWVkIG9uIHRvcCBvZiB0aGlzIGRl
dmljZSB0cmVlLg0KPiBJZiBJIGFtIGNvcnJlY3QgbmV3IHN1Ym1pc3Npb25zIHNob3VsZCB1c2Ug
dGhlIExpbnV4IEtlcm5lbCB1cHN0cmVhbQ0KPiBkdHMgbG9jYXRlZCBpbiBkdHMvdXBzdHJlYW0g
KGNvbmZpZyBPRl9VUFNUUkVBTSkuDQo+IEkgdGhpbmsgb3RoZXIgcGxhdGZvcm1zIGxpa2UgbXQ3
NjIyIG9yIG10Nzk4MiBuZWVkcyB0byBiZSBzd2l0Y2hlZCB0bw0KPiBjb25maWcgT0ZfVVBTVFJF
QU0uDQoNCkdvdCBpdC4gVGhlIHByZXZpb3VzIHJlcGx5IGlzIGJlY2F1c2UgSSd2ZSBub3Qgc2Vl
biB0aGUgZGVmY29uZmlnIG9mDQp0aGlzIGJvYXJkIGhlcmUuIEhlbmNlIEknbSBub3Qgc3VyZSBp
ZiB5b3UnZCBsaWtlIHRvwqB1c2UgY29uZmlnDQpPRl9VUFNUUkVBTS4NCkknbGwgdHJlYXQgdGhl
IGZvbGxvd2luZyBwYXRjaGVzIGFwcGx5IHRoZSBzYW1lIHBvbGljeSBieSBkZWZhdWx0LiANCg0K
PiANCj4gPiA+IMKgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9LY29uZmlnwqDCoMKgwqDCoMKgwqDC
oCB8IDExICsrKysrLQ0KPiA+ID4gwqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL01ha2VmaWxlwqDC
oMKgwqDCoMKgwqAgfMKgIDEgKw0KPiA+ID4gwqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE4
OC9NYWtlZmlsZSB8wqAgMyArKw0KPiA+ID4gwqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE4
OC9pbml0LmPCoMKgIHwgNjkNCj4gPiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysNCj4gPiA+IMKgZHJpdmVycy93YXRjaGRvZy9tdGtfd2R0LmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDEgKw0KPiA+ID4gwqA3IGZpbGVzIGNoYW5nZWQsIDk1IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIv
TUFJTlRBSU5FUlMNCj4gPiA+IGluZGV4DQo+ID4gPiBiNDNkYWU4ODJiM2VhMzNjMmNkNzQ1YmQz
NzU5ZTNmNGQ5N2FiYzgwLi41YjUyZDJmZTE3NTA2ZDI2NTliZTkwMQ0KPiA+ID4gNmE3Yw0KPiA+
ID4gYTYzOTA2MjMzMmFlOSAxMDA2NDQNCj4gPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gPiAr
KysgYi9NQUlOVEFJTkVSUw0KPiA+ID4gQEAgLTQxNSw2ICs0MTUsNyBAQCBNOsKgIENodW5mZW5n
IFl1biA8Y2h1bmZlbmcueXVuQG1lZGlhdGVrLmNvbT4NCj4gPiA+IMKgTTrCoMKgwqDCoCBJZ29y
IEJlbHdvbiA8aWdvci5iZWx3b25AbWVudGFsbHlzYW5lbWFpbmxpbmVycy5vcmc+DQo+ID4gPiDC
oFI6wqDCoMKgwqAgR1NTX01US19VYm9vdF91cHN0cmVhbQ0KPiA+ID4gPEdTU19NVEtfVWJvb3Rf
dXBzdHJlYW1AbWVkaWF0ZWsuY29tPg0KPiA+ID4gwqBTOsKgwqDCoMKgIE1haW50YWluZWQNCj4g
PiA+ICtGOsKgwqDCoMKgIGFyY2gvYXJtL2R0cy9tdCoNCj4gPiA+IMKgRjrCoMKgwqDCoCBhcmNo
L2FybS9tYWNoLW1lZGlhdGVrLw0KPiA+ID4gwqBGOsKgwqDCoMKgIGFyY2gvYXJtL2luY2x1ZGUv
YXNtL2FyY2gtbWVkaWF0ZWsvDQo+ID4gPiDCoEY6wqDCoMKgwqAgYm9hcmQvbWVkaWF0ZWsvDQo+
ID4gPiANCj4gPiA+IA0KPiA+ID4gW3NuaXBdDQo+ID4gDQo+ID4gVGhhbmtzIGZvciBoZWxwaW5n
IHVwc3RyZWFtIHRoZXNlIFNPQyB0byB1LWJvb3QgdXBzdHJlYW0uDQo+ID4gSG93ZXZlciwgSSd2
ZSBmb3VuZCBpdCBzZWVtcyBsb3RzIG9mIGZvcm1hdHRpbmcgaXNzdWVzIChlcnJvcnMNCj4gPiBh
bmQgd2FybmluZ3MpIGluIGNvZGluZyBzdHlsZSB3aGVuIEkgcmFuIGNoZWNrcGF0Y2ggdGhyb3Vn
aA0KPiA+IHRoZXNlIHBhdGNoZXMuDQo+ID4gDQo+ID4gUGxlYXNlIGhlbHAgdG8gZml4IHRoZW0g
YXMgY291bGQgYXMgcG9zc2libGUuDQo+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
ZHRzL210ODE4OC11LWJvb3QuZHRzaQ0KPiA+ID4gYi9hcmNoL2FybS9kdHMvbXQ4MTg4LXUtDQo+
ID4gPiBib290LmR0c2kNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4gPiBpbmRleA0K
PiA+ID4gMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMC4uNmQxYjJhYjgy
ZGExYzk1YTQ5YjhhNjkNCj4gPiA+IDNlYjANCj4gPiA+IGY4NTRhYjkxM2EyNmINCj4gPiA+IC0t
LSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL2FyY2gvYXJtL2R0cy9tdDgxODgtdS1ib290LmR0c2kN
Cj4gPiANCj4gPiBbc25pcF0NCj4gPiANCj4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9hcmNoL2Fy
bS9tYWNoLW1lZGlhdGVrL210ODE4OC9pbml0LmMNCj4gPiA+IGIvYXJjaC9hcm0vbWFjaC0NCj4g
PiA+IG1lZGlhdGVrL210ODE4OC9pbml0LmMNCj4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
ID4gPiBpbmRleA0KPiA+ID4gMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MC4uMzM4OWMwM2IwNjAwNmU4MTMwYjRjZTQNCj4gPiA+IDQ4ZDUNCj4gPiA+IGRjZmI4ZjEwM2My
OGYNCj4gPiA+IC0tLSAvZGV2L251bGwNCj4gPiA+ICsrKyBiL2FyY2gvYXJtL21hY2gtbWVkaWF0
ZWsvbXQ4MTg4L2luaXQuYw0KPiA+ID4gQEAgLTAsMCArMSw2OSBAQA0KPiA+ID4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ID4gPiArLyoNCj4gPiA+ICsgKiBDb3B5cmln
aHQgKEMpIDIwMjUgTWVkaWFUZWsgSW5jLg0KPiA+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyNSBC
YXlMaWJyZSwgU0FTDQo+ID4gPiArICogQXV0aG9yOiBKdWxpZW4gTWFzc29uIDxqbWFzc29uQGJh
eWxpYnJlLmNvbT4NCj4gPiA+ICsgKi8NCj4gPiANCj4gPiANCj4gPiBXb3VsZCB5b3UgcGxlYXNl
IGhlbHAgdG8ga2VlcCB0aGUgb3JpZ2luIGF1dGhvciBoZXJlIHRvZ2V0aGVyIHdpdGgNCj4gPiB5
b3U/DQo+ID4gU2luY2UgdGhpcyBmaWxlIHNob3VsZCBjb21lIGZyb20NCj4gPiANCj4gPiANCj4g
PiBodHRwczovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9naXRsYWIuY29tL21lZGlhdGVr
L2Fpb3QvYnNwL3UtYm9vdC8tL2Jsb2IvbXRrLXYyMDIyLjEwL2FyY2gvYXJtL21hY2gtbWVkaWF0
ZWsvbXQ4MTg4L2luaXQuYz9yZWZfdHlwZT1oZWFkc19fOyEhQ1RSTktBOXdNZzBBUmJ3IWcxanZz
ZW9lLWFXZlJJMDNBT2hXZGVJempMNzFIRmhhbHlBcTRJZDRReEpmbnRCRGk0NXdNa3BjVG5hYUN0
X3FuYmhIYm9qX25WX1R5dENjT0gxWnd3JA0KPiA+IEF1dGhvcjogQ2hyaXMtUUogQ2hlbiA8Y2hy
aXMtcWouY2hlbkBtZWRpYXRlay5jb20+DQo+ID4gDQo+IA0KPiB5b3UgYXJlIHJpZ2h0LCBJIGZv
cmdvdCB0byBhZGTCoCBiYWNrIENocmlzLVFKIENoZW4sIEknbGwgZG8gaXQsIHRoYW5rDQo+IHlv
dSBmb3IgdGhlIHJlbWluZGVyIQ0KPiANCj4gQ2hlZXJzDQo+IEp1bGllbiBTdGVwaGFuDQo+IA0K
PiA+IEFuZCBwbGVhc2UgaGVscCB0byBkbyBpdCBzbyB3aGVuIHlvdSBhZGRpbmcgYmFjayBtdDgx
ODguZHRzaS4NCj4gPiANCj4gPiBUaGFua3MhDQo+ID4gTWFjcGF1bCBMaW4NCj4gPiANCg0KQmVz
dCByZWdhcmRzLA0KTWFjcGF1bCBMaW4NCg==
