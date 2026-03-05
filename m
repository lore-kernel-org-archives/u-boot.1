Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD69F33A69
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:02:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0880839A8;
	Thu,  5 Mar 2026 15:02:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="N6B7pdfq";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vLr4pllI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69D3A83E81; Thu,  5 Mar 2026 15:02:18 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 138038382A
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: c040623c189b11f1a02d4725871ece0b-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=rGPEgyR79n2RJapZfZKnN6eQGfkacfkJWr2k6hPHJ2E=; 
 b=N6B7pdfqmogCoGpNihcTndq5ZembWwgkNKy7lkHn/C1ZXq3/QDFX1KmoEj6f0fJYLaSJul8j4g2Mo0DypkPs7RC8tguteia1CuTyxezTJEZgEB5vMjqOEefjqBW8o9kVpMTUECTq2DAUEEG4Nheu3VeaVjFe8/IPUjcXPlFPKbw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:f2c8c33b-3373-437e-ab9e-495f1a4f0152, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:775f8f7b-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c040623c189b11f1a02d4725871ece0b-20260305
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 179241241; Thu, 05 Mar 2026 22:01:04 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 22:01:03 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 22:01:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xQz/395ml2FLS0/5paXYFPnmhvQgvnBdwOTXTR5HbH3PEZk/wvmKQu0/IZbK26mnr9IZ7HjBXdtkPeXRJJsTm56Edjzz53PRnUS/PwwIaMowURcdA3TuPO4ZC+8WLCPIfkOkod5c+pHpRFi5/Iz9HEImQNj6n5nlMTCdK0VJ3OW5cdZx0wuC80eZB70zSHObcroULg7QPDQcNQO16u4V/F1aJGBXV+I+AXfWfCcHV7o8JWMtrb2SdNu3uszl2HUPIrAETJH3atCu/+cN4eUloGJWLXv9GpJneebzsf51YYJ/OBctFa7DXAg0Bx9slhS2E4uy58B4oH3OQxW2p0hOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGPEgyR79n2RJapZfZKnN6eQGfkacfkJWr2k6hPHJ2E=;
 b=xxxG5chSqgxDfByZwYPjnV6sazeJQtJfwOLynuWns1qkEFrr0lSvi1UoGc0OjJ0pNTvjIeHiT4pFWEDPg46VCKar3vJUbVVCqe3vwVBEvt5I5e83ipBszH0nhyEMoLERZs3deE82B8/Cw+5A2KCU0AhTZ5YOp6Yg7Ig8EiCT4WzAArG4wTmGL0XyvbamnktOrPqGZpf/pYIzRpYy2CPMneKK932zInt28aPkWYuguoR0LSXk4onK8YdpcfSVxm51xgsViUWsa6nPDad3Q9wcy/70VntwcqlIssBLu4pjTz7Wodge3bC/f8dvoRhVwSZvfITC5PTlit8U/2ECVBsaiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGPEgyR79n2RJapZfZKnN6eQGfkacfkJWr2k6hPHJ2E=;
 b=vLr4pllInZFNb843J8Jv+q4E2h1BB+7twL+FooHgzn8Ror+YuGzqjYA2iTvcVx4VfgJ3EgDmuKU8xPCuX2uU9UwY5LPavA4E10xexlSocZClQhBf/Si7k9pIzAzcyYwDvYK8zrZBAVM+xHcjx2XlwIH1nXnfaHhr112vWQfyRH0=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYQPR03MB9429.apcprd03.prod.outlook.com (2603:1096:405:2f8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Thu, 5 Mar
 2026 14:01:00 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 14:01:00 +0000
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
Subject: Re: [PATCH 13/14] clk: mediatek: remove CLK_PARENT_MIXED flag
Thread-Topic: [PATCH 13/14] clk: mediatek: remove CLK_PARENT_MIXED flag
Thread-Index: AQHcqqHH+maCxd8zlEa+Fwiqk/YaUbWf+7mA
Date: Thu, 5 Mar 2026 14:00:59 +0000
Message-ID: <1f9daaf43ea26f0a75517117aeb4a64755c51886.camel@mediatek.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
 <20260302-clk-mtk-unify-mux-parents-v1-13-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-13-32f45085f4d0@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYQPR03MB9429:EE_
x-ms-office365-filtering-correlation-id: 7992cdb6-2151-4b9c-7477-08de7abfa17c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: cDn13g+YFQzk/7EuPpR3U3M5MR6SQaRbqjYw581Mgdpi0Ihda51eWTYknotdFUgm0JiDh+Rj5fwS4F0MicCsKfZ1mdcEMONho+JBbM9u0546xb/bi3kCVjJHqWMgvKlWPkjteBFaIwGaly8vyNr7NgZQ/++buok59gy/jXIiBZLbyRoDHAekAKsQNrMTsZsM8QQbcc+3oBp3Gwm31oRZycwDlTW89aHHhOy6WBQf1Fe+o1QJUK9FVs4lx44fwns0IefgA9bhKtI0UC6POJqj/0SJp7ZNmmqwrKMJeG6KYi5TnxJJ1GQFOfDB/bNGDG/gFX8c3J04rdzqL5ZkjBGQj182YZr6beyyhkFT9m9XIdZ6W+NBHeKAOhdw6BZrcIk8rFh9J+/6dyfA/oPObbAzKN25KRgVcmZuEShwO5j5eHfZDm1xAVSykAYVY/4fEONoDQdAC3uJE5EfJyc7aJhVNSDEFQ+MSa+vmacdswnrJsvAvv41glxfIx3oLeRBXTzLFws5C4cWtQ7O4nptbB/B5z1m6m7euJ+xMkqvVmpVtj4qg2ItgGPG/uPC59bjdN2AdT0j04wmM8jcPSI0Q7eIPLWwgY7HL1I+a2GUxqv1omMr07uJbXqeMZ3hvH54jlyDHZ7twV6ESIBwJ19MsOk7pgNCbK7pTKhBh5Xi2jrlPxNqXm8d9nBfsUe0xgJTb1m0rop5mfMYgkxVpbgsVHu2NSSYiQkaS9t9+PhBdlthalvhSfelfaNZvddqcWd/pWnfjLhE5rqf4ERYcs/TD1vMD1Ma+TWBXppmSLEqCtABr4KgJ7bKjCQFzj+g/OHbmcxx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZWF2KzdjazB2eTNoT1VJVWVManVnRTdsTkF3OEFSSFY3NFEwNmlYd1B5Ulls?=
 =?utf-8?B?WnVrMzJwWlc4aXNxaFhnNWFzNkpHbFprOTZHSXh6WktuTStNQnFJNW5uTXRC?=
 =?utf-8?B?cUkwbzJGaWRTeEUrckl0bmcrSmY2L2hKWEdlaXdQWGRkZ0VLWEZ2VENtN0lj?=
 =?utf-8?B?TjFYSzYzQk5DNmxPWXlsQ1dOc1dRNXZkRzhJWWtXcFRBMURTQVZ3YzljYkQ1?=
 =?utf-8?B?NXprR0Z3Z3BFNzFZQ0UxVDRLOGNLSHlNcWdKVnV3bnVING53QlRtTzdLM3F5?=
 =?utf-8?B?VmtZSjNCV0FpcXJWWWlwRHFRckQrOFdCdmVXY1V5KzlZdWxDZFlOOGF6R3NH?=
 =?utf-8?B?WG8zYkhvOUpyVktudDlGNEpueFhIUnpTZllsaXRWQVZPVzBOZ0RrVnN6OHBm?=
 =?utf-8?B?cmt4UGwvKy9LYzlGRTVqSlhzcEhHaVFGekNOajdmVkpQaWxJb2N2YVNNNVlG?=
 =?utf-8?B?ejJUTXZEaXFOVFNHeWQwbkhqSnl2WC9GSkhCNGV6eXljbTZ0dndFS08yNEpm?=
 =?utf-8?B?SWM0REs0dlhxWG05M2ZVSzVNV21NQTNkTDhFMTg0UlJDcFV4TG1ZVlRoOU15?=
 =?utf-8?B?Wk5SUGozNkJmSEt0dTBySlZ4WS9ZSVdEVWkvZitkZXVzNTEvdEVYbHZnZ2xR?=
 =?utf-8?B?dktyM1dkcW1oakJwbGNYZjhPVWhOTGdOT3VveGV1VzFxZjlTdHM2dHFlaGtI?=
 =?utf-8?B?WEdJcEErVEd3OVAyWEtUYVEwWHBvOHduYnVkdFdsd3FSTUllTnh3S29ncHJE?=
 =?utf-8?B?WGxIRDFyb3BUejh4YmRUMDZWc1E2NnUvbnFDNm1rK3BJN2VUeHBsRGx0dVZI?=
 =?utf-8?B?UDNpd05BcUxLK1BxUmdVZm9oVkpjdFRscHNZZE9LeWdCZTFiOXFrOVhJYk1p?=
 =?utf-8?B?SURiaFBmMmZZem1yYy9BblZBeEFPZWhnZkdTanVYWnora2Z4alkrSDdLVGVY?=
 =?utf-8?B?aVV3TG1WQzNQbWJDbnhYcnU3UkIvTWxqTDNLVVNzeXJTRzZqb1ZsemwvR1h3?=
 =?utf-8?B?a0hjV0xPTWdBZWEzRkdXZE9aUGd0eG1xaERJcVEwZ1NVSGhiSkVWWkZTOTg0?=
 =?utf-8?B?clBvQ29XUU1ETVRDYWJJc21EL3d6NmppNFJvN09PVUY5bUpBK01ZZDBqYU5u?=
 =?utf-8?B?cnFEZ2xob2toTk12anFzWWtNVEx6enY0eFhLYklxeHRqN1BoSkhJd0E4cDFk?=
 =?utf-8?B?cmw1Wm9CTjJDRHlnYjVQMDlHVm9VNnoveHZVLzc2cXhNUk9CVThDUjRZWm9r?=
 =?utf-8?B?cnVDd0dqeEtCTDB1SmZnMTRFelZ6K0JXQWJZR2ZMN244NXh1bWx0cFhnQUpt?=
 =?utf-8?B?TkwyMmxZTVdZVU9wa3VvK05xbDB6SWdmUW94K2U1dGkxa2RxOERzQnJCSzFp?=
 =?utf-8?B?cjA5SzlFTVpiUW5ZUUJUeWxVamJQY2szdHdUeitEVDN4Q3ZZVDVuUWpteHZJ?=
 =?utf-8?B?UyswaDQvZWxEd2FTQW42aXVRV1JLSThPUlZYVWxISitBdngxemFzdEJvTUsv?=
 =?utf-8?B?TUlTL3k4YVB4c3lJODIrWGpnTWRGOTIxeTM4c3NINHUrTzUwaE04ZklIa2gx?=
 =?utf-8?B?WUR4YUhwM25FYmM0VWw0SElBS3llTzRtcW4rbmpON0N6M0JPYUUya3VnWUNH?=
 =?utf-8?B?REJNdGRTVHEzeVpLZ3V0Zkwxak1QNnV4djdhc0pOUmJJUy94ekc1WFpnaklQ?=
 =?utf-8?B?VEJpRitMeWIxS1JTWDcrbEMxZytTc1lrUTAxb0ZGWThQUWxmTnlBVGFESWNV?=
 =?utf-8?B?KzJINkc1R2paQllFT29VRjZHQVE3NUNtM1NKVmNxdHNWVUQ3dkpWSUVlSklh?=
 =?utf-8?B?RmozdlFiSjZVb1E3TWREVzBJcFJHSjJMOXBGRHQvSW8wYUVzWmwzdzhoWUwy?=
 =?utf-8?B?WHc1SVF4RkJvTmJFVGNocXFST29vdThPcXpIcGNMdHBDcmNaa245OHRBa284?=
 =?utf-8?B?R2VFYTlOT1hsV3g1RnlMTFQ4MEV3UVRISG8xcGtISUlUNHJ0THdadmdBdzln?=
 =?utf-8?B?Z2doMnFndEpSNzlyTHVqT2NRYnBoSER6ZEdRbS8yZVpNZ0huVkMvK3NtTnNH?=
 =?utf-8?B?YytDQktVYTRaR3NUUkR3azdzcDJHdVRCVXN1R0ZoUytIV1F1aDN4T21lMWpH?=
 =?utf-8?B?cmc1RFEwNXpDRXN4UFVFUStpNm1MOUI4QjJzRkxhQXNwTmtOeVdpSUxrQmd2?=
 =?utf-8?B?N3k1KzJERE9TVWVRVDh0SlZCMEJNdi9JS1FDemt4ZFdRNU5JOVNOd1N3U0Fx?=
 =?utf-8?B?eUx1QkNhQjUvbUU3YkNTdnl4VnY0MDY0cTFBZHRZUFRCWUlpb0F6Ky9BbFcv?=
 =?utf-8?B?SXpGb0xVNnU3d1lTOStGZ0lFdjNHaUlHQTBnZGpMRTlwNzhwQTlBUWl3THJK?=
 =?utf-8?Q?l2S6A2LdvOvNuKG8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B7F9A0E154A8E24CB87D16E026C4B574@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Q1K6/71icVhA8JomitvdYIjw5GtFaNKX8XO0m10DtrEeRc2AEeh12EionQ8euge1/Gez6ci/7UE9TOHWVNCUnxre0zecy8a7AWeRePQHVDETXTVlQlJCf42hmRlUwVUmJ0xIp0P++8MyAr5M3dVCKEFmnNUV6bjyDRIVNtJJJqGhLpObWvGYMHtHF9Qi1c9bSK28q2/YIy7JcJnB+w1T/kT5DTHRNTajaKcwx0icbFHxD9dv91H7YCdiuUQayIYBcaAg+mXvqnfxbH+xXZKoRY1YDdxbK7h2sc8BGFex1CDIElCOP6+ocGta0hseD7wxR9HucQl3JRPbfDUoY1G84A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7992cdb6-2151-4b9c-7477-08de7abfa17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 14:00:59.9452 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TzVxqE7I8u7s7Us3UbPtVa+A7+8gRLPsCi85hHvMrexHGXfCgJVXksL63K1et4+y9HCeFaAnjGlodwhZoglhJIubR7E0wk1dBKrVrJ6zhc0=
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
PiBSZW1vdmUgQ0xLX1BBUkVOVF9NSVhFRCBhbmQgYWxsIGRlYWQgY29kZSBwYXRocyByZWxhdGVk
IHRvIGl0Lg0KPiANCj4gQWxsIG11eCBjbG9ja3MgaGF2ZSBiZWVuIGNvbnZlcnRlZCB0byB1c2Ug
c3RydWN0IG10a19wYXJlbnQgKHRoZQ0KPiBwYXJlbnRfZmxhZ3MgZmllbGQgb2YgdGhlIHBhcmVu
dC9wYXJlbnRfZmxhZ3MgdW5pb24pLiBVc2Ugb2YgdGhpcw0KPiBzdHJ1Y3Qgd2FzIGluZGljYXRl
ZCBieSBDTEtfUEFSRU5UX01JWEVELiBOb3csIHRoaXMgaXMgYWx3YXlzIHRoZQ0KPiBjYXNlDQo+
IGFuZCB3ZSBjYW4gZHJvcCB0aGUgZmxhZyBhbmQgdGhlIHVuaW9uLiBBbGwgTVVYX01JWEVEKiBt
YWNyb3MgYXJlDQo+IGNoYW5nZSB0byB1c2UgdGhlIGVxdWl2YWxlbnQgTVVYKiBtYWNyb3Mgc2lu
Y2Ugd2Ugbm8gbG9uZ2VyIG5lZWQgdG8NCj4gc2V0IHRoZSBmbGFnLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBk
cml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ3NjIyLmMgfMKgIDc5ICsrKysrKystLS0tLS0NCj4g
wqBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ3NjIzLmMgfCAxNDcgKysrKysrKysrKysrLS0t
LS0tLS0tLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10NzYyOS5jIHzCoCA3MSAr
KysrKystLS0tLS0NCj4gwqBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ3OTgxLmMgfMKgwqAg
OSArLQ0KPiDCoGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDc5ODYuYyB8wqAgMTAgKy0NCj4g
wqBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ3OTg3LmMgfMKgwqAgOCArLQ0KPiDCoGRyaXZl
cnMvY2xrL21lZGlhdGVrL2Nsay1tdDc5ODguYyB8wqDCoCA5ICstDQo+IMKgZHJpdmVycy9jbGsv
bWVkaWF0ZWsvY2xrLW10ODE4My5jIHzCoCA4NCArKysrKysrLS0tLS0tLQ0KPiDCoGRyaXZlcnMv
Y2xrL21lZGlhdGVrL2Nsay1tdDgxODguYyB8IDE4MiArKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tDQo+IC0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OS5jIHzCoCAxMiAr
LQ0KPiDCoGRyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTUuYyB8IDIzMiArKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tDQo+IC0tLS0tLS0tLS0NCj4gwqBkcml2ZXJzL2Nsay9tZWRpYXRl
ay9jbGstbXQ4MzY1LmMgfMKgIDg2ICsrKysrKystLS0tLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVk
aWF0ZWsvY2xrLW10ODUxMi5jIHzCoCA5MCArKysrKysrLS0tLS0tLS0NCj4gwqBkcml2ZXJzL2Ns
ay9tZWRpYXRlay9jbGstbXQ4NTE2LmMgfMKgIDg2ICsrKysrKystLS0tLS0tDQo+IMKgZHJpdmVy
cy9jbGsvbWVkaWF0ZWsvY2xrLW10ODUxOC5jIHwgMTE4ICsrKysrKysrKy0tLS0tLS0tLS0NCj4g
wqBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmPCoMKgwqAgfMKgIDY2ICsrKy0tLS0tLS0t
DQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ay5owqDCoMKgIHzCoCA1MiArLS0tLS0t
LS0NCj4gwqAxNyBmaWxlcyBjaGFuZ2VkLCA2MzIgaW5zZXJ0aW9ucygrKSwgNzA5IGRlbGV0aW9u
cygtKQ0KPiANCg0KW3NuaXAuLi5dDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1
bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MsDQpNYWNwYXVsIExpbg0K
