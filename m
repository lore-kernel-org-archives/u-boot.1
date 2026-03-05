Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF615F33A6A
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C314839A8;
	Thu,  5 Mar 2026 15:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="FF3O4y/W";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="m9A1phBf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1613183F2D; Thu,  5 Mar 2026 15:03:58 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0558382A
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:03:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 1f7dec4c189c11f1a02d4725871ece0b-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=9UIbzNwYhlcpsrTtej90746gX7IEOHekjK+CFN2/tkQ=; 
 b=FF3O4y/Wh0xtnxYmSK/s072t5oOLCnSO7ZJP+LFQR6W6V6UeSVXmUeKCs0Jpj5aYu+Z86Eo8PzwpW9hE0vrAiNVONg+0Ene42I4CX81kb10mCVvE6DpqZ6viKUonw9pFSma9jfQ9jysPmra5oSzt9+8Q1txxVQe0B4wp78TkcpI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:93b766f5-76bb-4214-845b-802a1e36e773, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:55e84cf1-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1f7dec4c189c11f1a02d4725871ece0b-20260305
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 997509420; Thu, 05 Mar 2026 22:03:44 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 22:03:43 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 22:03:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HQTvSCxziW/k9AeNoqGdQBMAgpxRb5+dIckyQg8fdXab48Rf5pdrNLWvbhZ5PmeazU9bWd0krGy65IG3Y1SD8fuk6YaCa8n6okwUL4m2yCrQts61BAM8FTOeH4BGWKl2uqE3Cyoqaxc9UpQEvncq0H3/B3MJvWz7sRC0RbBAfEgd0eeyjZ7wxR6BiSnJu/pLFdFA238WYAiVPcdaGVJJXgHX5SYiU/qCRTlK2D0W87AQDanAYHRbEiM/06SLBjZs8s23o0pP0ZUaapxfnTfErhP5g1AQBdv3FkAEWB25dYQlulHKFXHiO+IhxiyzAEUPGlQW9gcmz88nz3F6xBShEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9UIbzNwYhlcpsrTtej90746gX7IEOHekjK+CFN2/tkQ=;
 b=JEXiCoQjURqzVkHjNqiVc/RwRU2h1ShcVsDkzyF8waTti2waqp3rrZcLCg/koHM7zJV6m/QS9XedOFo7GauvcdM5T/K8j9diF2duUd8skjxWtJ6LX/itDBoU38rKWAJKV7YkQzAT4rOjtjY8qJfwE6wtEBuVQ5bL2s8krxttmNiNEkB4hFm6Xm9mIoqMhwPrbHWDj09sZo8P/whZciFFZ1twl/GoaXe1TJfGZoyoDNQakt5IjvVVBXIy4VuZPxsWGTeFrOxCGr6bJdNgBKK3eqk/HpKBJ2wNEYm63wXbiiYPTzgjqYl5JZ3UaVFelIy/xZovMac4x89bsCOmnbMrdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9UIbzNwYhlcpsrTtej90746gX7IEOHekjK+CFN2/tkQ=;
 b=m9A1phBfcGZonEqnU/HfWcEktxgJQHU/LcTweUTynbfVpR7FcNGLpT05h4660cTD/d4y+jnm98lKdjbkSnvW3bMAdLXYhwOvCjVhiUIlQ4ncEd2uXVrKUjXf0QVvz2Imkfbhbc7cs1YmJ71UqSlmBSHmPuzOTmkQArid007S2Ag=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYQPR03MB9429.apcprd03.prod.outlook.com (2603:1096:405:2f8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 14:03:39 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 14:03:39 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 14/14] clk: mediatek: refactor duplicate *_mux_get_rate()
Thread-Topic: [PATCH 14/14] clk: mediatek: refactor duplicate *_mux_get_rate()
Thread-Index: AQHcqqG+n7qVBKLE4E6TRXT15lDkSbWf/HYA
Date: Thu, 5 Mar 2026 14:03:39 +0000
Message-ID: <99f9ce93d1079600ef7372f42f3a1285157dd743.camel@mediatek.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
 <20260302-clk-mtk-unify-mux-parents-v1-14-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-14-32f45085f4d0@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYQPR03MB9429:EE_
x-ms-office365-filtering-correlation-id: 110515a7-7d13-4fc7-001e-08de7ac00093
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: COqXFkEVXlZ7Y+8gp8Fp4XG7fUyPajtujzVdHwvuZa4rZcx7fF2tsJfybrD6xTUJ/D8nDgXyPoJm7GHmDF9+r90/fAfT0p6GRlIJNXzZe452L45BndfI3mEx4WR2nU1QjBttunJtzoha1IiCDZsq5nerQh7nnd0sXoXGmU4eP4rXt7SLLAOszl8xbLT4VWGy7L+hLR/GH3OpMVKS7TU7RKaewa8DV6lfF7EgD+hnLA/VBx+kunFF+Xnf+yjBQJJVYdwmw8nlBnAUx+3PJDVOk0MvGG9XecNht/2D/0O8EFx0tG/M5Y/auFP9wGYJiRcK0V4EQI/cA/MDe61XmkRxnGvRvc4pW6WKBmWiv5FVnVnLNfY0jrUiwYAZfqUiNh6p7DjOMzNb1hFVRSZCHrrE0wj5TizY2p6DDCv7VBThGxO7UTPq7lyJYW3XSbqiBNyfsyDRBrw9YhlazFJU6XokBLOXo3sfmkvIQnUJUprjc0ET/9bBQ4Pij2OBRTQBfwrtQ7DYIXE3K1/vd36dhPdox5yV0YZeZnaqAkMEM0FoQ4Sz4hd/eKTB4jf7qPYqGPVgZh0k2VLu1SIu85ZYwfs2X4pq4+5FSOWK6T9FtYcP3Cmnicnw3CMm7ToimZJOeyR0AgrTy2HxHkbE4ct0IO6mjwxiTK03waHijgZUWzPzqMBIwJAqE+c0QB8cJX+PvxxV1oC/AxKf4YWpmDvhG3PDpxNqzNvIodYFlnlK2+S+7nXsaUvMFnOB3NDSR8hVGnJcjSTCDXXRJgVnaBUbDGAdBxeRr61VcM5o/O16xMxJqZgsDFh+mwSBN8z39/2PHkia
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0dOS3l2MHMxZ2xLNStpa3ZndGNFNDI1dFRUUThJeS93a2tzMDdXZHZEaFJp?=
 =?utf-8?B?MVZtNEI1OHdoNm5FNGJKdEJIbmhGMzg0UFVPN2pYSys4SEZWaVZYZUlGMTl5?=
 =?utf-8?B?ZGRwT0kyL01YMTBpdFJlc3pGQmw1UTZkWUlEOWpNdGxTWVJRRFp6U3pZWTN1?=
 =?utf-8?B?RkU2VHA3STJGcWpzdXdUREVUKzVtQVM3eGhDdnQ1ZFo2UXIrbk53cnI5YVZE?=
 =?utf-8?B?VjFDQ1VYbTF6R2hwS3JiQjVHQVVZSGpReEZlV29GZ0h6Z3FhT1ZONFNxMkM3?=
 =?utf-8?B?djBQS1l3WFV0S1VvcHd0bTAwKzA2L1V0YlFJbm9DTlBxcGdWN0luTGt2L0Vv?=
 =?utf-8?B?b3E4V0lhekRnWGlXdzlyZHVBQzBGNE5yMTd3NW1mdWNTZXYvbHR2ek9VVGcw?=
 =?utf-8?B?SDBUR3RkSVVwRytsdDdUdHdMRGlZZVY0TC9rd3liKzBTTGVmVHN1UDJQMlc0?=
 =?utf-8?B?Z3JtTFBDV205YVZ3UFZwOXV4TnU4SXpzZkxRbnVnNVo1cHlVQm9aUC9aakY3?=
 =?utf-8?B?eFRyNnd5NTlaYXZZbmhSWFJKZ2wwcU5WVGIyNGZpb0dScjl3MFBnS3RZa0Jl?=
 =?utf-8?B?Q3ZqV080Wi82dU9wMmhpS2JtU3JIUzBJcDNyZjl4bjJlZXBQU0ovL254TXA2?=
 =?utf-8?B?bWxjcG1OSDR0SnZBWkgwcE45M3lRQWFtQ1pDUzREOHhNUElsNTlWZW1yNXp1?=
 =?utf-8?B?SGtGbmNYQnRPcEdyN01nZWlRTnp0aEkyMGs0TnBCeis3Y1NZZmRqUVpnRkY4?=
 =?utf-8?B?N3lwQjJma2Q4M3luckhDOG9NNGZGanlTbzY2VlMyVCtuekQxM0JOblRkeGNW?=
 =?utf-8?B?SStaNk5rOG5rditMUXpqanVaZ0RWYjNTMnVXTEx5QWN4T0xscDhQd2Y0amV0?=
 =?utf-8?B?cTZGU1gzdjZlNFhEMEV2eGw5R0Ruam5oYWRHL0gwVnFRTUxhc3VEWGpLTkZU?=
 =?utf-8?B?blZGWnlKWFR3MUYrV1QreHl3MUZDN0cxQkR5Y0Fkbmd1MTcwamU4bG9yNlF0?=
 =?utf-8?B?eVpoQm1oV0VoMWJEeUJ1UmY5ZkRHREUzQUJtM0xLbFl5WTQ0S0p2MjYzU0ta?=
 =?utf-8?B?Vkp6RDBPZ3BBQ0treWpySWZ1K0Nxa1daNnpaRG5YYnFkd05qWmFzT3Z2dlhM?=
 =?utf-8?B?d0gxOHkxeFNYN0RQTlR2RzdlcHJyekdoS1hrVnFTTW1xejlRa0ZqNzJoanE1?=
 =?utf-8?B?UzF6RzN4TnNHVEdudWVuZEozQmpyKzVlQVdtM09sRCtxRTZHWUo1azZ2VlVo?=
 =?utf-8?B?czFQcCtRUE5oSFN4OW5oQ0tnWUNVb1VxUGxEdU1ONG9BL0VydVlrdUlsUkJH?=
 =?utf-8?B?UlVYMW1RZmhpT2RhMHBCaDZWRzFDZjNQTVFFVldQMUMzeUdsVVNkd3EycGtq?=
 =?utf-8?B?SlVMVlZvejVhNmk0UEdxMDE1WnYxcXJIZjJSSFVUMTgvR0ZVcjRJVFpjTW5O?=
 =?utf-8?B?QlJmNGFJM1FIbHZRcElkOHRkSi91RlgrM2VQY1g5MHYyNGt0d0Njcjd1V2pY?=
 =?utf-8?B?ZWtmelZXSjNQcVVzaGZlVkhSVk0xM3VYdHorK3IxUnRFSFlNdTlvOGdKRFVF?=
 =?utf-8?B?QkJzcGZ1aHdHcEJScnoxbjZMU3FtQmZyWjFvczRGNzExTUorMmpPTFBYOSs0?=
 =?utf-8?B?Znl5MzhXZTNTbGRxYXlaQm94cTZ6UkxQV29tWkJPcTFKczdPRDdJOHNTUXdD?=
 =?utf-8?B?bEhPNjhhYnhQaVhLcEIya0NFdElKVTQ3QWJzTjZWdjhDMS9DZXJQdDdoTE15?=
 =?utf-8?B?M0F0alNwM0kyb0I3dzlnVTVmYmZ2eVBtUXI0V3B0N0owTUltZGtxc1kyeHg3?=
 =?utf-8?B?d3hPbXZMakhxVTRPMGF5VnMzZm5ER3FMdGo0SnZzeTIxRVlwTVFMV1NkTXVC?=
 =?utf-8?B?dERuZVZDREh3aUpWTXg4b0dSd3g1UWV5TGo3Sm1TdFo3VGs1alRWekZOTDdO?=
 =?utf-8?B?SUNZUHV3NmlLVDU3YUdpdURndzdOQkNRQWI2eC9aVGo2bFlIcnlIejVyZGxk?=
 =?utf-8?B?QnRiZHBPTTh3eFMxUUNHTFMvTzA3MmdxMFFTNnIweVdZZ3ZraTNkRUZJbWVu?=
 =?utf-8?B?cWRDeHlnSTVOaEUyWFVFUWQrbG1xRGZGRm8wZXBaTk9sSnZWMlVVeWNock9N?=
 =?utf-8?B?dGRreXFKdEtNZWhGY3JnNTJrOTBvTi9QS1hwMkhKRXkvUWx2cVREK2NLWHpR?=
 =?utf-8?B?dUw4UTMvMWc3MlprQ2dQUGQrYVVMZjBZUmRZMHZla2NHUWJNZnBEbmRRY1Fx?=
 =?utf-8?B?SGJEenFjME1kS1psdFlDdy9LeW1jaDEza0NyTlRadlpubEV4emxtcU9Vcys3?=
 =?utf-8?B?MW9TSGhEK3hwV2VRVDNXTmhVaXR5eitENUUvMGxUdFJIWUg1Y01TalRUMlBu?=
 =?utf-8?Q?dOTLyXLwxAnYONvI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3F08C3A69438445AA7BCE409BAB8E96@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rg07GU4O/BedukGipA7yoZpJcsC/IzJx2yk9wAHGbkLlTwgOgE9kJlCAbaiM0KYXukGovB682vVzYPseznsbx34vKXmIyWt9NQJn8DUy/+0a8DRxllhzc9NRxqgcKlPh9pmimyYrq+N9MVXKzDkt/UXNVKY5yV0z42eID/9TFQUV5DkpOB+y+YL8+gH7Rdxu32Ev3yARcn9x/QcGoJM9BWblX5hEdEmaIka41DMZTSqiiIlIkTEyQCu9Xp5ZlhiiR7p1y1P645YhClKmYZ/KPfZPxeV0fZRHSOfqHGNVJ14MVO645ppyfVBpSQY+Gif4vTVXGeSCluJuJNGSjqdd3w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 110515a7-7d13-4fc7-001e-08de7ac00093
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 14:03:39.4544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jxl5tT3/B0ZEfO35fWXnS6dtHRkienSCzzoyXsLHHzFq6sypUeWg3JKcelcjCS9hEBu/MfTObAHQasb0hI6/BjK04+K4xduDFjlbe40+7aM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYQPR03MB9429
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

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE4OjAzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBSZWZhY3RvciB0d28gaWRlbnRpY2FsIGZ1bmN0aW9ucyBmb3IgZ2V0dGluZyBtdXggY2xvY2sg
cmF0ZXMuIFRoZQ0KPiBmdW5jdGlvbnMgYXJlIHJlbmFtZWQgYW5kIG1vdmVkIHRvIHRoZSBzZWN0
aW9uIG9mIHRoZSBjb2RlIHRoYXQNCj4gY29udGFpbnMNCj4gb3RoZXIgY29tbW9uIGZ1bmN0aW9u
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJl
LmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5jIHwgNTAgKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmMNCj4gYi9kcml2ZXJzL2Nsay9tZWRp
YXRlay9jbGstbXRrLmMNCj4gaW5kZXggYzY1MjMwYTdmOWIuLmM1ZjZkNDVmZDY3IDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmMNCj4gKysrIGIvZHJpdmVycy9j
bGsvbWVkaWF0ZWsvY2xrLW10ay5jDQo+IEBAIC0yNTMsNiArMjUzLDIxIEBAIHN0YXRpYyB1bG9u
ZyBtdGtfZmluZF9wYXJlbnRfcmF0ZShzdHJ1Y3QNCj4gbXRrX2Nsa19wcml2ICpwcml2LCBzdHJ1
Y3QgY2xrICpjbGssDQo+IMKgCXJldHVybiBtdGtfY2xrX2ZpbmRfcGFyZW50X3JhdGUoY2xrLCBw
YXJlbnQsIHBhcmVudF9kZXYpOw0KPiDCoH0NCj4gwqANCj4gK3N0YXRpYyB1bG9uZyBtdGtfY2xr
X211eF9nZXRfcmF0ZShzdHJ1Y3QgY2xrICpjbGssIHUzMiBvZmYpDQo+ICt7DQo+ICsJc3RydWN0
IG10a19jbGtfcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihjbGstPmRldik7DQo+ICsJY29uc3Qg
c3RydWN0IG10a19jb21wb3NpdGUgKm11eCA9ICZwcml2LT50cmVlLT5tdXhlc1tvZmZdOw0KPiAr
CWNvbnN0IHN0cnVjdCBtdGtfcGFyZW50ICpwYXJlbnQ7DQo+ICsJdTMyIGluZGV4Ow0KPiArDQo+
ICsJaW5kZXggPSByZWFkbChwcml2LT5iYXNlICsgbXV4LT5tdXhfcmVnKTsNCj4gKwlpbmRleCAm
PSBtdXgtPm11eF9tYXNrIDw8IG11eC0+bXV4X3NoaWZ0Ow0KPiArCWluZGV4ID0gaW5kZXggPj4g
bXV4LT5tdXhfc2hpZnQ7DQo+ICsJcGFyZW50ID0gJm11eC0+cGFyZW50W2luZGV4XTsNCj4gKw0K
PiArCXJldHVybiBtdGtfZmluZF9wYXJlbnRfcmF0ZShwcml2LCBjbGssIHBhcmVudC0+aWQsIHBh
cmVudC0NCj4gPmZsYWdzKTsNCj4gK30NCj4gKw0KPiDCoHN0YXRpYyBpbnQgbXRrX2Nsa19tdXhf
c2V0X3BhcmVudCh2b2lkIF9faW9tZW0gKmJhc2UsIHUzMiBwYXJlbnQsDQo+IMKgCQkJCcKgIHUz
MiBwYXJlbnRfdHlwZSwNCj4gwqAJCQkJwqAgY29uc3Qgc3RydWN0IG10a19jb21wb3NpdGUgKm11
eCkNCg0KW3NuaXAuLi5dDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5A
bWVkaWF0ZWsuY29tPg0KDQpUaGFua3MsDQpNYWNwYXVsIExpbg0K
