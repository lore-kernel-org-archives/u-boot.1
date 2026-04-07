Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25F37FEEF49
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:36:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A585D83A41;
	Tue,  7 Apr 2026 16:36:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="TrHwN4kn";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="HDZlDxDN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3AE5840AB; Tue,  7 Apr 2026 16:36:22 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4155580433
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:36:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 207d2d26328f11f1ae70033691e9ac7d-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=q1zTH2vcefplg5I9VXriYVhbPe0KkZnrdt54phwuUBs=; 
 b=TrHwN4knrLPakoJ8KjJZZKiTrju0ZkiVU6JyMCmQTaBSJnJ1BYWdKDVzJFt54eOob6XLnKdwaFoQOcYhohoNokdxM3BW8/fUFz4wlMmFEHMG30MLT8qjL3GaHCyCaFwuMa7mGQ42/uloSs4XuiXo2AVynI7/sSzh06KjG1l8Vjc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:c9de36de-bd13-42c2-915c-1d72b9351f29, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:361e9624-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 207d2d26328f11f1ae70033691e9ac7d-20260407
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1916971325; Tue, 07 Apr 2026 22:36:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:36:11 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:36:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DnmCXlby0OREQxkrhCfXFJgdVlYDSI1Y/SfPPkUtZXlV4MdjL/5AQQg1GEDt61ud1PELoWnUCNSLiM+++n4vRHSOIjBFSXcSm0FWLT+N4WNPqAYEeWYaCfiY1YXLLYIZ/5Wyhv2oS/yfUs2ZuAifj6exMo2f+IRyMWahhm9tJUiOEikJyNuWbfoR39WpntpCXx6mRLkNGiMFkYHyM3AJhxIAal+djSYpWj9ws2gPoFCwz0rJMn5E7z7CS+FO9SPTglEiHnGda55omCdD18kD7TcqtIkwZLr/x3yfwhFwfnc84zGIu6ZPAS2nye9ylfHdAUu6f1wjYSml+we6Jo+M/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q1zTH2vcefplg5I9VXriYVhbPe0KkZnrdt54phwuUBs=;
 b=G2GMYx8VGWHwD6gC4YdhCzIka1tiZrn3xORaqPVpWqFcp+xXyl3eJ8zQdzI4KXiP7Ap2bwMArXfrV2t/hkiAwW9K4V4lBxhdwmjaCufFRk3kF0rX9G053pR99o8QJBc/Xj8aY2oKVQWT8tWgNMnarN5U4BlJeO9pNlU3r3NFqlR+y0yIY1uxGX6cUTiao/x3TfM/OYcx55mG4uqaO3sTita076oX9qz7vZPBKOUYHPMmZmLeM9Dt0DCQNgNZZfrzK7WkXXI3YTvAp+0OHOep2HJ1Wi1I2OhqFBfwJqZFbK2xetPhN8TM5jqmOmHPpoIETG5g372g923b2mWNcxG7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q1zTH2vcefplg5I9VXriYVhbPe0KkZnrdt54phwuUBs=;
 b=HDZlDxDNynNhS+m+ox4TyX+53EpHSGvFFauS2l1Um9X9b06+f7324y+6elgPZr5L82/D7WXmCJgP+XGgRzErCHJj7mGPDFDgfCvBJ82HX3IlYxRCTqE4OiaU96F0z0kVeApDgHz+gO9ysqMhZZZEHwAnJRgAmUgHvbhc2ipszTs=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYUPR03MB7180.apcprd03.prod.outlook.com (2603:1096:400:355::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 14:36:08 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:36:08 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 Ryder Lee <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "trini@konsulko.com"
 <trini@konsulko.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "bhupesh.linux@gmail.com"
 <bhupesh.linux@gmail.com>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, "lukma@denx.de" <lukma@denx.de>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?SHQgTGluICjmnpfngJrlrpcp?=
 <Ht.Lin@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
Subject: Re: [PATCH 3/6] clk: mediatek: mt8189: add UFS clocks
Thread-Topic: [PATCH 3/6] clk: mediatek: mt8189: add UFS clocks
Thread-Index: AQHcwIX9aW6325cc5UyGJlNnkBvbi7XTtrGA
Date: Tue, 7 Apr 2026 14:36:07 +0000
Message-ID: <49770f948d90155704b6862817e9b1a111c3c08c.camel@mediatek.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
 <20260330-mtk-genio-720-ufs-v1-3-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-3-3bad8362ed70@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYUPR03MB7180:EE_
x-ms-office365-filtering-correlation-id: a1aa1818-40d7-4ffa-38a5-08de94b301ad
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: cEw+CqPsMHErRyc2U6U7kzmCtI+Kwdt90ORiNsuUwJvY3EzN/EIJeEFdDxRZsZpLWsZOLJjG6wzzxnOLaBIYppR2OEd4d/p3UjNfylJwZNEZtoRwwxpnrG3QgKR+eCOxw4kqzyAV4Rk4/txmzVHERysSyS3xi39V1YBBHc/f/LBARjuzrpvWJ1dxCtaTE7U4rAzfTIFIsb1BHJbBke6RWCTEwcff6LMDCxLOBtRILxQGYpo4p7mZS12kFh6Akob6VTq6Ma6prUh9sFC4WQ1ceCQprG6VwX2EivHWwtuN6pL6VJPtJNUpy8ClQ8cR+lcXxtrtZR8fUZnUGtdftAm0P7aX0PvpI/6tB10lGBJaS2tioQcz7A9av61Nh3pUmhAkdylAMaF+G48GP5cCPejLTKKltPJw8eanOv9ONAaU8daYz135qpy7hREEjx8odI93PdIQDXfUhHnvTISzobojSXOZvaeaWouXjpu89qoDtkWVcnXHeSveQsV3PzIJQEf7k4e6uuy3ps7kjJJO5Tcd1f31br9QDuGCaHmJs2xbpjuhTkZKICLO7VHmg3b6b+v5WwLFoUE+di2x1UB3nGGeic4yzw2LS5mJ+391if7wapFjKAA2XW4BbtbU01k2B0ExNrXi4e8mCJS7u2F/kD/hDZJInneszdbAxOI+SNXlM6hYJch7jyG81E8z2PcI2mmJyw25Pyvv3rKxVrILZb+ManlTZeFoMNWR86ntq/tAnl7xv5ICN2VVhakWwbpz2dPTxMnNiKqRWmymFhpIgh6UL6gNE9fSPOQrLMLOKBnsB3OVTt8bqoJACd0QaFqSk1pI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z1R2b0Vjb0J3MURtQWtFMVpEUko1WkUzUVF2NG1FalVzSlJ6Zk40bHN0aUdH?=
 =?utf-8?B?dUtsZCtsRFFUY2lJNW53SS9lUDlqSjhiUmJ2WkVEMzQ3QWRpaUljRmt3UGg5?=
 =?utf-8?B?SnRLZWJMYVpDUlF5bUM2MDJnVmxKdVFFMVJYamFqYzZDdzNrdE1hV1VlbnJS?=
 =?utf-8?B?eFVLWklwODhOUmE4SENvVjR3MEtKZWtqaFY1N3lwaDlmSnltZ1dycWVPemk0?=
 =?utf-8?B?cjFvcWNhbjkrQysrTStQUFg3WUFnTkNUOEJOMDMvWDA1VDZSYmFFTy93TU01?=
 =?utf-8?B?eXdKNndhVUJ4SmFkWlFQNmxlTHFZajJvd0ZqU1NHWFIwYjhkakVJbE5ROFE2?=
 =?utf-8?B?MWUwSU5iUWtoV0ovRU9ja1dITUxoZ0xKT21UTmc3ak9qbnExZ3RaM3ZiWmJN?=
 =?utf-8?B?YUNJb3RXdWRVdlZlMmNLWXMyVE5GQTZTdjF4R3UrK2h5TWRjMEZMU0RFSVVB?=
 =?utf-8?B?ZlRYRS8xYmVSajZVR3ROc0Z6MU1rRE12YVlsQWRPcHZEVjBLd1BEZUF5V084?=
 =?utf-8?B?SjNrWVFxTG8rV0tCdHppdUtkOXUreEQ0RlMvd3MvalVkd1pRNnNjSmVlNGhz?=
 =?utf-8?B?WTdiWkxlM0N6QncyQVZVZHI2c3MvanNsQWErQ0RnZjFUekRWYUcwN1VabDZl?=
 =?utf-8?B?cm95MWV3ZlpId1pCWitzdU9UcUtTZmV3R3Q1VnlkVWptTDRwaE1RcVIzR1lp?=
 =?utf-8?B?MXJaM2FQRWpXN25JaDZNZFdhSTlYYkErVFpNVUZ1OU5xcHlpV211cjEvSFla?=
 =?utf-8?B?NWI0OGFqZ1NNZHFjejhhRU4zcTJlN3o0UXB4STBkZGJHYXl3V3N2TnJ4MjUy?=
 =?utf-8?B?VTBuM25BM3JKOENUdzV6S2hDdUI0QzRJeFcyb0QrQ2k5dFNnRXIzeDhUMk4w?=
 =?utf-8?B?czJGTUlLUHRGaE9vb3pRcGV4cElVdStLRlIrSXg5TXVoV3dQOEQvRHpya2pL?=
 =?utf-8?B?bXVIdzA3aXFNRDlZWHg1Z2l5S1hFYjdibHh3MnlZNmtaUFNndHFCWDVmZUpm?=
 =?utf-8?B?SldlOXF4WThMcE13K2c1VkpWOC9UWDc3UGFVOGxxYkZZc0xwZU0weFRCbENq?=
 =?utf-8?B?VVU5MktROEdOWTNHZGhnU1cyY1I5b2pNR2dVN2lkTnF5MHl3amdRVndaMjNw?=
 =?utf-8?B?NVZZQlpOdVBCVUNpd1Nhb2c0QUEzRXhqNFVlUWJ0WWlhNk16ZzNHNmFYU0RQ?=
 =?utf-8?B?NXJhWGtTR2xyU2RPUFF1clVDaHVhR29JZE1VYUZnU3FvN0pNK3ZuTEl0UXZN?=
 =?utf-8?B?Q2pOQ1JXNmdubkhVNklnQUV4ZGVKWFl2NDM2bFlqWG9Jb2dPaWNndUJZY0k3?=
 =?utf-8?B?bG43U1dFemMvaFN2ZHRoWTdMR2dhdkJCUTZJSHV5b2xjdlFxTmRKMHVMVllF?=
 =?utf-8?B?VWNPTndraVp1RE8yRVFaWmtHVWFCS3dONVBuQnVCOHVyVzZZUjYwODBDQUNv?=
 =?utf-8?B?VmhkQmw2ZmdDYkZrQ0lFdmxnQkkxSkVROGdtUS9nK25DUjRmWUpTMVFaMjho?=
 =?utf-8?B?b0pXOTJocVBsdDhDbkZaak92R2RmS0ZEOTFES3NtU2RXOXRuR2pha2lKYlRq?=
 =?utf-8?B?dEpoc3ZrdkNtb2htZisxZ0VxZGNOLzYyQkRPZW96aDB1ZW54eGdyU1FWOXl6?=
 =?utf-8?B?ZDkxWDQvWFFBVkc1V2Y1U2ZiRDBvaVJ2NDBLU1hZczIyZnRJRlREbEx6UmZw?=
 =?utf-8?B?QkhCV0pOY1FpclIvM0tobTNzS1FiejJ5a0dSamUyTll1QlZXd3V0SFF2MEFi?=
 =?utf-8?B?Rlc0VlRMWGp4cUVWcVordXZsYm5PWEptQ1BpZ2MzbDRNeFRLWEtwUUxBQ0Rn?=
 =?utf-8?B?YnFXUGJBU0lLcGh1ODB0VTlmWE42ZFZjUFkyM3RNc1ZBQUswNnhkK0pXTEJv?=
 =?utf-8?B?N295MGNiTlJGYVo1Wno3a0ZGUzd1YlhDcUFjckNQTGRHNlVXSk44c2tTVk1V?=
 =?utf-8?B?QitjVUFiYXZ5QzQ2Z3VWWHFtZHRnY0IyNW1pV1R5cHdFRUlkTk5mZjZLdXR5?=
 =?utf-8?B?U1hwVFR3cWZVbjR1M285a3h1QUg3L2hvWndmSjVNbUFuK0JwVWRuM2ZGZ1A1?=
 =?utf-8?B?b3lhTUFDZzQ5T3FkWjVYWFEwNlRzUnVwams5SVdxVU12N1grNFp2ZnpRckx5?=
 =?utf-8?B?OEpvdEp4TXhWVHF2T05hZ0VKRnBtRExxMXdoR0VFdERnTU40NTc1ZE1xRlJ6?=
 =?utf-8?B?ejBJSjJVWU1YSnNqbGxEZ01QcENKb1VTbXllOGk2NjVoendKcDVicCswTXFE?=
 =?utf-8?B?Z1VLbVpNVDZqMGs0OHFvMkJJMXBEZ3JSMzJDY0NCczdBTi82dnpYaGx6Mzk3?=
 =?utf-8?B?dHBXNnRCckJaTFJobXRDQnNJRnhzUmVPNjJ5T2dBZkxZSkNvZVFUdTlNbFdt?=
 =?utf-8?Q?KXPd/x+x9McBT8Bg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <60319ADC008B2C4D9DD738D1E1C36BE9@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: TvDfmgDUKtWdCFHvssUtjbYXK6SWu3xPy8Rq3KrLPJNIjW0pjNmKvg9t5BjQMxJdQLiOHUPV1ASgOPNiDg+r0/rmdlSMyeNij2bVz7DIc1VH9uK+KoXoRGM4vpkYwRW6KTPtX285ym9uh5FSwWPLt5st0TT27Mpnmy55s81eWGvvRC6u9eaWLboOc9so/LvFTm0G3fCn8glCV3HQqOUEJQ1n5QX+Kgk3yjf6jlobWDL9JZhATwCWfe381HIBEo8B9SavgTVPwQZ1ITA16RgpsyzdX/MO+Am4WLLBHYp9ZOLVGLahAYfkaAc/TL7aZXKJZIYsNH+ToKGweVsREd23OA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aa1818-40d7-4ffa-38a5-08de94b301ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:36:08.0744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SHXUgW+vu6WG0/N8xbAuO8we7KXSb8QB/rHenm50Tdr/PdC4YL1C9c0++l5X/2xX+PtAb9na9DHKrSNWeV7usyJBz6E32gUZhWhCxOYNns0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7180
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE1OjQyIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgc29tZSBjbG9ja3MgcmVxdWlyZWQgZm9yIFVGUyBvbiBNVDgxODkgdGFyZ2V0cy4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4N
Cj4gLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE4OS5jIHwgNDQNCj4gKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQs
IDQ0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9tZWRpYXRl
ay9jbGstbXQ4MTg5LmMNCj4gYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTg5LmMNCj4g
aW5kZXggOWU2NDAwNTlmMTEuLmQxMTk0N2VlNDYxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Ns
ay9tZWRpYXRlay9jbGstbXQ4MTg5LmMNCj4gKysrIGIvZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xr
LW10ODE4OS5jDQo+IEBAIC0xNjQxLDYgKzE2NDEsNDYgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBt
dGtfZ2F0ZQ0KPiBtbWluZnJhX2NvbmZpZ19jbGtzW10gPSB7DQo+IMKgCUdBVEVfTU1JTkZSQV9D
T05GSUcxKENMS19NTUlORlJBX0dDRV8yNk0sDQo+IENMS19UT1BfTU1JTkZSQV9TRUwsIDE3KSwN
Cj4gwqB9Ow0KPiDCoA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZV9yZWdzIHVmc2Nm
Z19hb19yZWdfY2dfcmVncyA9IHsNCj4gKwkuc2V0X29mcyA9IDB4OCwNCj4gKwkuY2xyX29mcyA9
IDB4YywNCj4gKwkuc3RhX29mcyA9IDB4NCwNCj4gK307DQo+ICsNCj4gKyNkZWZpbmUgR0FURV9V
RlNDRkdfQU9fUkVHX0VYVChfaWQsIF9wYXJlbnQsIF9zaGlmdCkgXA0KPiArCUdBVEVfRkxBR1Mo
X2lkLCBfcGFyZW50LCAmdWZzY2ZnX2FvX3JlZ19jZ19yZWdzLCBfc2hpZnQsIFwNCj4gKwkJwqDC
oCBDTEtfR0FURV9TRVRDTFIgfCBDTEtfUEFSRU5UX0VYVCkNCj4gKw0KPiArI2RlZmluZSBHQVRF
X1VGU0NGR19BT19SRUdfVE9QKF9pZCwgX3BhcmVudCwgX3NoaWZ0KSBcDQo+ICsJR0FURV9GTEFH
UyhfaWQsIF9wYXJlbnQsICZ1ZnNjZmdfYW9fcmVnX2NnX3JlZ3MsIF9zaGlmdCwgXA0KPiArCQnC
oMKgIENMS19HQVRFX1NFVENMUiB8IENMS19QQVJFTlRfVE9QQ0tHRU4pDQo+ICsNCj4gK3N0YXRp
YyBjb25zdCBzdHJ1Y3QgbXRrX2dhdGUgdWZzX2NvbmZpZ19hb19jbGtzW10gPSB7DQo+ICsJR0FU
RV9VRlNDRkdfQU9fUkVHX0VYVChDTEtfVUZTQ0ZHX0FPX1JFR19VTklQUk9fVFhfU1lNLA0KPiBD
TEtfUEFEX0NMSzI2TSwgMSksDQo+ICsJR0FURV9VRlNDRkdfQU9fUkVHX0VYVChDTEtfVUZTQ0ZH
X0FPX1JFR19VTklQUk9fUlhfU1lNMCwNCj4gQ0xLX1BBRF9DTEsyNk0sIDIpLA0KPiArCUdBVEVf
VUZTQ0ZHX0FPX1JFR19FWFQoQ0xLX1VGU0NGR19BT19SRUdfVU5JUFJPX1JYX1NZTTEsDQo+IENM
S19QQURfQ0xLMjZNLCAzKSwNCj4gKwlHQVRFX1VGU0NGR19BT19SRUdfVE9QKENMS19VRlNDRkdf
QU9fUkVHX1VOSVBST19TWVMsDQo+IENMS19UT1BfVV9TRUwsIDQpLA0KPiArCUdBVEVfVUZTQ0ZH
X0FPX1JFR19FWFQoQ0xLX1VGU0NGR19BT19SRUdfVV9TQVBfQ0ZHLA0KPiBDTEtfUEFEX0NMSzI2
TSwgNSksDQo+ICsJR0FURV9VRlNDRkdfQU9fUkVHX1RPUChDTEtfVUZTQ0ZHX0FPX1JFR19VX1BI
WV9UT1BfQUhCX1NfQlVTDQo+ICwgQ0xLX1RPUF9BWElfVV9TRUwsIDYpLA0KPiArfTsNCj4gKw0K
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZ2F0ZV9yZWdzIHVmc2NmZ19wZG5fcmVnX2NnX3Jl
Z3MgPSB7DQo+ICsJLnNldF9vZnMgPSAweDgsDQo+ICsJLmNscl9vZnMgPSAweGMsDQo+ICsJLnN0
YV9vZnMgPSAweDQsDQo+ICt9Ow0KPiArDQo+ICsjZGVmaW5lIEdBVEVfVUZTQ0ZHX1BETl9SRUco
X2lkLCBfcGFyZW50LCBfc2hpZnQpIFwNCj4gKwlHQVRFX0ZMQUdTKF9pZCwgX3BhcmVudCwgJnVm
c2NmZ19wZG5fcmVnX2NnX3JlZ3MsIF9zaGlmdCwgXA0KPiArCQnCoMKgIENMS19HQVRFX1NFVENM
UiB8IENMS19QQVJFTlRfVE9QQ0tHRU4pDQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgbXRr
X2dhdGUgdWZzX2NvbmZpZ19wZG5fY2xrc1tdID0gew0KPiArCUdBVEVfVUZTQ0ZHX1BETl9SRUco
Q0xLX1VGU0NGR19SRUdfVUZTSENJX1VGUywNCj4gQ0xLX1RPUF9VX1NFTCwgMCksDQo+ICsJR0FU
RV9VRlNDRkdfUEROX1JFRyhDTEtfVUZTQ0ZHX1JFR19VRlNIQ0lfQUVTLA0KPiBDTEtfVE9QX0FF
U19VRlNGREVfU0VMLCAxKSwNCj4gKwlHQVRFX1VGU0NGR19QRE5fUkVHKENMS19VRlNDRkdfUkVH
X1VGU0hDSV9VX0FIQiwNCj4gQ0xLX1RPUF9BWElfVV9TRUwsIDMpLA0KPiArCUdBVEVfVUZTQ0ZH
X1BETl9SRUcoQ0xLX1VGU0NGR19SRUdfVUZTSENJX1VfQVhJLA0KPiBDTEtfVE9QX01FTV9TVUJf
VV9TRUwsIDUpLA0KPiArfTsNCj4gKw0KPiDCoHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX3BhcmVu
dCB2bHBfMjZtX29zY2QxMF9wYXJlbnRzW10gPSB7DQo+IMKgCUVYVF9QQVJFTlQoQ0xLX1BBRF9D
TEsyNk0pLA0KPiDCoAlUT1BfUEFSRU5UKENMS19UT1BfT1NDX0QxMCksDQo+IEBAIC0xOTU1LDYg
KzE5OTUsOCBAQCBHQVRFX0NMS19EQVRBKHBlcmFvX2Nsa3MpOw0KPiDCoEdBVEVfQ0xLX0RBVEEo
aW1wX2Nsa3MpOw0KPiDCoEdBVEVfQ0xLX0RBVEEobW1fY2xrcyk7DQo+IMKgR0FURV9DTEtfREFU
QShtbWluZnJhX2NvbmZpZ19jbGtzKTsNCj4gK0dBVEVfQ0xLX0RBVEEodWZzX2NvbmZpZ19hb19j
bGtzKTsNCj4gK0dBVEVfQ0xLX0RBVEEodWZzX2NvbmZpZ19wZG5fY2xrcyk7DQo+IMKgR0FURV9D
TEtfREFUQSh2bHBjZmdfYW9fY2xrcyk7DQo+IMKgDQo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCB1
ZGV2aWNlX2lkIG9mX21hdGNoX210ODE4OV9jbGtfZ2F0ZVtdID0gew0KPiBAQCAtMTk2Miw2ICsy
MDA0LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB1ZGV2aWNlX2lkDQo+IG9mX21hdGNoX210ODE4
OV9jbGtfZ2F0ZVtdID0gew0KPiDCoAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OS1p
aWMtd3JhcCIsIC5kYXRhID0NCj4gKHVsb25nKSZpbXBfY2xrc19kYXRhIH0sDQo+IMKgCXsgLmNv
bXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg5LWRpc3BzeXMiLCAuZGF0YSA9DQo+ICh1bG9uZykm
bW1fY2xrc19kYXRhIH0sDQo+IMKgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg5LW1t
LWluZnJhIiwgLmRhdGEgPQ0KPiAodWxvbmcpJm1taW5mcmFfY29uZmlnX2Nsa3NfZGF0YSB9LA0K
PiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg5LXVmc2NmZy1hbyIsIC5kYXRhID0N
Cj4gKHVsb25nKSZ1ZnNfY29uZmlnX2FvX2Nsa3NfZGF0YSB9LA0KPiArCXsgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTg5LXVmc2NmZy1wZG4iLCAuZGF0YSA9DQo+ICh1bG9uZykmdWZzX2Nv
bmZpZ19wZG5fY2xrc19kYXRhIH0sDQo+IMKgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4
MTg5LXZscGNmZy1hbyIsIC5kYXRhID0NCj4gKHVsb25nKSZ2bHBjZmdfYW9fY2xrc19kYXRhIH0s
DQo+IMKgCXsgfQ0KPiDCoH07DQo+IA0KDQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3Bh
dWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg==
