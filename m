Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF55FEEF51
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:32:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE30D83A41;
	Tue,  7 Apr 2026 16:32:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Ox1ZcrIc";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dGARPjZV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3746A83F98; Tue,  7 Apr 2026 16:31:59 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DC4E80433
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:31:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 82f6258a328e11f19a16598d5ca7f8ec-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=3dUfr9cRTl+wn1YXlmuVKRGKERxRdOLXOovlVguFiYY=; 
 b=Ox1ZcrIcSYBBjBz1PHzBv/PN7TBGxrSmgkU4Gep4k448jHvXDGrdGPL/yE61W6ezyYzcZmPw8gPbeJvJi57R02MBm11Due62AQ/0wqKMGlDXPAUfjtgrZ3PzFePIJ9kcBgoaWGfO1yBV7X6bCRPe1K7vrUza7NICzPhMaCqDe1w=;
X-CID-CACHE: Type:Local,Time:202604072231+08,HitQuantity:3
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:4307b397-4f0f-4b65-8ca2-e066355b7e0a, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:a0179624-cb5c-4236-a89a-9a7fb20c9bc4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 82f6258a328e11f19a16598d5ca7f8ec-20260407
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1316148046; Tue, 07 Apr 2026 22:31:48 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:31:47 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:31:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nHAQoktOoUbQvDUDxP0KdpE057T2To/FxoWuYiqBqUx+hQTH8yIT48/0eCcWc73fvXeTfun82Cnq3fXqVO7joBiMv5hElIDfwoZqEHNH2N9v10cIfQp0DgEb3J+cUwq5yfxtMnqwOMIzbsnnhlbLt8fcNqncT7xlKf2JjWjtawHPp1f5F1HFA6Gjx5xSrc4F5qLxP09DfqiZqSjF/tCRRiikpIKukDN5zwRT5DX6di0GhBqtEay9m3hjIOBsbsqGUeJyZfBUQiP6lHy5DtfV9jY/5Pv3Gw1ZalLtW5tXcH/KH3T9oHvKPjy3VocEcX5XN9SunyCRGK6L5UsmmiVZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dUfr9cRTl+wn1YXlmuVKRGKERxRdOLXOovlVguFiYY=;
 b=TgB43zW5lL84qdyXfos5TZ+NNUCesZLGum3GlGFKFejJoy0Xby/I/LWl/0AbSOdXMkXKTp8FYMM9BpmqRztaZUgzAdzk28nlWeqMySVlMZO8bESxa6z6DwbH72tKTJH0JtucYIYs532kQB6UKuohNFDNa9yxA4LtW5imtOiEHt+zOFPde81Utc7n/Izu8BWgRnHgyHXywsj8C0EBMJJnAEE9whgKybzmXQBY5TEiOFkG3JeUoaEwjiM2PW7wMaj9KaZtfbvUh8KFKr2HaXNc8gO113FVxS2n904HuZQNdRKqljEL0AfHKHlKP+ueuolqNEDhMp+6Btt2rkPzTyvl1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dUfr9cRTl+wn1YXlmuVKRGKERxRdOLXOovlVguFiYY=;
 b=dGARPjZVHe4a8zHxyC9NmztrtXKJZIYjpsyGWtLwlu9gDkmlwvHduyZx6uTMjBw+Pq//eMWKat2MLYhq0IVsf4pVJdu954FADygqWbokyL8ZDTkaMHWKWBhxIWCTNiU5CgC5hnZexdhzHX2vRCAEcJk0TMrklWAN7lwoi930Klc=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB8250.apcprd03.prod.outlook.com (2603:1096:405:23::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 7 Apr
 2026 14:31:44 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:31:44 +0000
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
 <bear.wang@mediatek.com>, =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?=
 <Ramax.Lo@mediatek.com>
Subject: Re: [PATCH 5/6] arm: dts: mediatek: add UFS variant of Genio 520/720
 EVK
Thread-Topic: [PATCH 5/6] arm: dts: mediatek: add UFS variant of Genio 520/720
 EVK
Thread-Index: AQHcwIYAoIj8SuBp8UOu7WpRonm4krXTtXaA
Date: Tue, 7 Apr 2026 14:31:44 +0000
Message-ID: <64bf7a9fc95e907d8d3f88b06b07894c3fb3afca.camel@mediatek.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
 <20260330-mtk-genio-720-ufs-v1-5-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-5-3bad8362ed70@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB8250:EE_
x-ms-office365-filtering-correlation-id: 3afdae4c-db13-4f94-6923-08de94b26462
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|921020|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: NmaUgOCHbW5tDjhAKLHhiLIafPVVFAnXUehv0lHUwglAhczb/H+S/ECs4Ey+5Nmb2MXTDh8nOjMx3JWVUEPFQ8sEnCj+Et4V1CcULJxHpouTtUzUH9yLtldlDa/WpuTeUtww/VrRQh7Gpr3D8/s4BRko/1vxHTiJ50cYp7ysb29AHo1vK9iWdpP3XQkRFymQHQQW8jD4t9alHy36Ys9RY+LUKjwjYbC0u5I8r4blp8V2RFdWwfNsETFPBDasGCZ0AbaAzxVbYU7BjASKhUiCAV2LrlEIecbOXYIgJ0XH0SXwOmQNyog60jqE2F9O4fSc4NmO1zeKhBalgRrhJVFRDvAM+rf3AFlrV+kfRAOEvYJbsa+p2wsYNW2PR1B9tSXeW99LtmGG0WrZyURk7mwNheif9cI5jeZ4gulyEPycLJi9lCc1Fo1zmQ+Bkq+BNSOFykoQO8vFIMqfDmHuzyBQGU2GDe+a+RJo1QxHn0IPtpSGAeVuf59JP8KzU1nH0kgKv2dE6Bz1qqk5CoC8GAwu37EHiSMCGbVxkHJsmmUclwdtuX6J+PduqRhSzouf7TvUAyeZTLSAKdXTsj+2Iym7iCXRSd+OWbcRK8Cy+67Z+hixdKpCEnVe934tp1iwzAdHdZ6kxAo1HbjWl/FEssiaQwnY+XqsNbLBdxjihCb5ddG2kOsRMfUzKUMLKFAIiQNmxhrwR/WpBNsWDGCJsXKnp+eO3z3Ju0w6WmdneO7v1Nplo6ZKpDXn/Z7LpGPc+4mgcavUkSIA9fAnm6Clgubi+utgOK94f191MaNgdM3T7f7jQrfJu2u6au6+bHrL0OR7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(921020)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlIrSFRWaEx6NGFGUGZoWHhZYTdFU0Q4SzVYdm5RVHpYSC83dHpKdkMxVTJq?=
 =?utf-8?B?ODRMYjZwRUJJb0w3ZDB4aWJmcEJkNjcxV1hHQUhKWjRIM0NEeWRaRkZPT3FX?=
 =?utf-8?B?YUY3OFZZaWJWUzZLVEtIbHpON1djL01nTnhBUDc5cjdqdkF5ZnYxWHkvNmRL?=
 =?utf-8?B?UXh1U01NejdzRkxXeFBFSzZBR0IvMk81MVpDTHE4STE3TkF2SHNaK2x6elpo?=
 =?utf-8?B?dXREZU9yeW1YSjY3OEpIMmphZzk2UDVMakJINjZEVExTMzNqN284cDVCK0VR?=
 =?utf-8?B?c0RXNUYyQXBRQWxvRkpDTDJ5T1JCMjZTOWNZMWVCUjV6M3FQUlNKbVV2eXFm?=
 =?utf-8?B?bTNaa1R1YzRURlB5WER4bU9wWGZwcHpzUmliQUgyYW5mc0pFVlRCWDRXS0Mz?=
 =?utf-8?B?Q3FiZmpUblhMUnk0L1N1OUVoMjcrc0FXSkliQTlVS3BXUGNZRUhtdFIxTk5B?=
 =?utf-8?B?S212alVFVitZOWdFV2RlSVkrQ3pFTHMzMDJkSDBjTHlYNUhRNzlySitwNWVj?=
 =?utf-8?B?eFRxVktocWwvRkRkVm9uOGpzdGVxcWczTWVJUWk3a2NHYUc2dkpvQTJyeThY?=
 =?utf-8?B?WVRDOFNXQkpIY2hocDQva0pJczllYTh3Mzl2dW5WaHVMU29WSTF2UU0yRmRK?=
 =?utf-8?B?eEcwdGg1M1ZYWlVlRGVLanBLZ3M3cjFJR0xFeUY4RFloRmVyc1BaMXFQYlRa?=
 =?utf-8?B?cjZnNHVMYkNpM3VVajl5MXlVbC9peVZCSERHUWtCT2pYNUFxR29WZURrcEhL?=
 =?utf-8?B?RkZtaWNYT3J5Z2JSRzAxSGhTSW15MHoxOGMvSWFpeE11b2RJSmJNUVZVRXov?=
 =?utf-8?B?Si94UFdzb1lCUE4wM3JjdEdMMGhmWlExeDEwbmhnRDNwL2RqZWNpNERWdmNu?=
 =?utf-8?B?Uko0VzVxU0pETXlINmtPRGhIcTBaTk9nMzBteWtqeUE5bHk2NHJZblBmNlIw?=
 =?utf-8?B?Z2EyQTVxNUJHSm5Ia3kwUFNsWEI2c3cvS293dVNMTk9rVVlZZk9nTDNRb2JI?=
 =?utf-8?B?WEo0ZmRZYzFSZ0RHZ1RRcHlMaUhhaFFrNWpTOWxoV0NLT0F3R002eGh3T0lp?=
 =?utf-8?B?L3BJRnM4Y1FjbHk5WndneVd5cXV3dHdpeDVJZTJKbDhvZjhCQlh4NmJrTGcx?=
 =?utf-8?B?S3N2a0hlV0hCWGM4UHNQcVNNbXlXcmludUI3bVlxRWs2MVlFUnZ6T2RBSmtp?=
 =?utf-8?B?UW5lM1cxM3Nab1lUeWhkQnpvT3FMR1NIQzRGSDlNMXNhVUk3QVBUQmNNWlVX?=
 =?utf-8?B?M1IwY2NnV1J5b01sTi9UOU00TjJFSFVYOEpSTUc5ang4QU13VVhzRi9QR2Jz?=
 =?utf-8?B?MUMzT0VzcVV6c05VRW9zbE94VEVZRUNLWmJ0MGRSSWpTc2xOQ2FvTnQ0R0p4?=
 =?utf-8?B?WmNyOXAvMzdLZlVFNlNIcnphL1I1MXlpZXlxOTZBM2h5UnpaVm9wdXFjaTVD?=
 =?utf-8?B?RGROTzFDMXhwY0IwdFhtVWxEaDZFaWlibWNsejdIR09QOWVVQVdLaFI5eFB5?=
 =?utf-8?B?dHRDTTFhWTh1Zkl4NDhFaHE1UUV4QkQ1amxrU2NHUG9qdHNJV1hwczNEL2lW?=
 =?utf-8?B?eExXQkNicnZEVjRtbERkYWR4d1dCSVVuTGs2TlErd3RSRzRPR0w4REZ4RG9t?=
 =?utf-8?B?Z25MeXVoeDZzL0pydzZZd3ZyV09LVnBLZFZ4MFNwYzdWTDlBUkxxSWVvSW9L?=
 =?utf-8?B?TmR5cnZ2NVNwRFp3WXlrSVJnYzRlZnRxQkN4RU4xRnY0aFI1eXd5TmVjQk9r?=
 =?utf-8?B?NzhaWUhrMmRKM0lnU3pWR0EwSEJQZ05IZWE1Q3JuSmZ1WXN4bURMdjgyWmNF?=
 =?utf-8?B?TmhlVlozb1YyVGJwcmJwZVhGM0VVNlMxNWFEZk1lNGFRUzBWWDczUGtvZUYw?=
 =?utf-8?B?OGNXUklWcFNMYnJtTzgwQ2xxMFRWWE5yK3dGcEFJbHZOcFpLNGJ5ejdxYjE2?=
 =?utf-8?B?N3liM1dwaE1ob0paMytrZUppR2QrV2xWZ0FuNFY5NGpiWGdLMWg2RzNGWEtQ?=
 =?utf-8?B?OGhoS1RRbk83MVBmWjZnNC9peVc2R0RkUUlYTjh0VThqazRGMkZELzhMWllU?=
 =?utf-8?B?S3VMUjBQM1FmbHBwbk9YQ3Z5V2lpUUNPZmFReXJPanByK2xYTGMxa2tibHk1?=
 =?utf-8?B?YXpyWUMxS3RraWdQcTlldVF0eWVHS3d2aFEreWM1YUxSdDYyQ0ZXWFBmSFhW?=
 =?utf-8?B?UGx5L3BIMmJRRm90UmpHeFZYYnl5QUtPb0VCVWlMUDdvS2ptcDlmaXJQRG9Q?=
 =?utf-8?B?OVNPMmRveUtMaG1wRlZQQlJKaUdUWnpiSG9PRlpDVnZWRVM2dkg4UmtTMHYx?=
 =?utf-8?B?YS94aTFxOGc3aFAxZlpUU3NadjFOajRsaVlEbTU3dHFRMmQ1TktweTFqdnRn?=
 =?utf-8?Q?4XNEXKUrlm7jSGQg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA27B430FD201140AB830121705277F1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: j/1eAGNyLetOYH/643L+ZUaoONCPJoJHACWW4c9/B8IkR7Ma3vjjeSZI1dR47cXRmk0vbhD4RrajlWG9n6E7g86vChUtsVScgfcdmhxe6crixN9POA5bem95IMkEZS5Hic27taoFGDYa9zGjZ/Etzwg5rga5XTYM1kBvAFhjL1SvM1Tcmonv023ID2H65M0SuA2BB6is75PgBFtkjdJTR6oFPguKXNqhNQeHFAmLdoEujtRMA8FjWdsmkzI+0DvmEZ+U3HLDyEudNKreY9IZpdHagg0qC6zW/YVdheLORetBFLl4c4jmW8qHmT5vsuCMJdfs7wAgUvcXIQ+Ltly8Nw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3afdae4c-db13-4f94-6923-08de94b26462
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:31:44.1861 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/dZUcny9FeGpWCKTBF4r1sMbZhsJACHwTHP3fCgvqAYFlKm7CRIlgw/rHbSFPnSbjQD7zxHw+hdcIbWxNLMYd2JUKCVyqb31lfaGPMGMZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8250
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
PiBBZGQgYSBkZXZpY2V0cmVlIG92ZXJsYXkgYW5kIFVGUyB2YXJpYW50cyBvZiB0aGUgR2VuaW8g
NTIwIGFuZCBHZW5pbw0KPiA3MjANCj4gRVZLIGRldmljZXRyZWUgdGFyZ2V0cy4gVGhlcmUgYXJl
IGRpcCBzd2l0Y2hlcyBhbmQganVtcGVycyBvbiB0aGUgRVZLDQo+IHRoYXQgZGlzY29ubmVjdCB0
aGUgZU1NQyBhbmQgY29ubmVjdCB0aGUgVUZTIGluc3RlYWQuIFRoZSBvdmVybGF5DQo+IGFkanVz
dHMgdGhlIGRldmljZXRyZWUgZm9yIHRoaXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBM
ZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGFyY2gvYXJtL2R0cy9N
YWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDUgKysr
KysNCj4gwqBhcmNoL2FybS9kdHMvbXQ4MzcxLWdlbmlvLWNvbW1vbi11ZnMuZHRzbyB8IDE4ICsr
KysrKysrKysrKysrKysrKw0KPiDCoGJvYXJkL21lZGlhdGVrL01BSU5UQUlORVJTwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDI0IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9kdHMvTWFrZWZpbGUgYi9h
cmNoL2FybS9kdHMvTWFrZWZpbGUNCj4gaW5kZXggNDA4NWQ0YzJkZTEuLmJmZjM0MWQ2MTE4IDEw
MDY0NA0KPiAtLS0gYS9hcmNoL2FybS9kdHMvTWFrZWZpbGUNCj4gKysrIGIvYXJjaC9hcm0vZHRz
L01ha2VmaWxlDQo+IEBAIC0xMTA1LDYgKzExMDUsOSBAQCBkdGItJChDT05GSUdfU09DX0szX0FN
NjJEMikgKz0gazMtYW02MmQyLXI1LQ0KPiBldm0uZHRiDQo+IMKgZHRiLSQoQ09ORklHX1NPQ19L
M19BTTYyUDUpICs9IGszLWFtNjJwNS1yNS1zay5kdGIgXA0KPiDCoAkJCcKgwqDCoMKgwqDCoCBr
My1hbTYycDUtdmVyZGluLXI1LmR0Yg0KPiDCoA0KPiArbXQ4MzcxLWdlbmlvLTUyMC1ldmstdWZz
LWR0YnMgOj0gbXQ4MzcxLWdlbmlvLTUyMC1ldmsuZHRiIG10ODM3MS0NCj4gZ2VuaW8tY29tbW9u
LXVmcy5kdGJvDQo+ICttdDgzOTEtZ2VuaW8tNzIwLWV2ay11ZnMtZHRicyA6PSBtdDgzOTEtZ2Vu
aW8tNzIwLWV2ay5kdGIgbXQ4MzcxLQ0KPiBnZW5pby1jb21tb24tdWZzLmR0Ym8NCj4gKw0KPiDC
oGR0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBcDQo+IMKgCW10NzYyMi1yZmIuZHRiIFwN
Cj4gwqAJbXQ3NjIzYS11bmllbGVjLXU3NjIzLTAyLWVtbWMuZHRiIFwNCj4gQEAgLTExMjUsNyAr
MTEyOCw5IEBAIGR0Yi0kKENPTkZJR19BUkNIX01FRElBVEVLKSArPSBcDQo+IMKgCW10Nzk4OC1z
ZC1yZmIuZHRiIFwNCj4gwqAJbXQ4MTgzLXB1bXBraW4uZHRiIFwNCj4gwqAJbXQ4MzcxLWdlbmlv
LTUyMC1ldmsuZHRiIFwNCj4gKwltdDgzNzEtZ2VuaW8tNTIwLWV2ay11ZnMuZHRiIFwNCj4gwqAJ
bXQ4MzkxLWdlbmlvLTcyMC1ldmsuZHRiIFwNCj4gKwltdDgzOTEtZ2VuaW8tNzIwLWV2ay11ZnMu
ZHRiIFwNCj4gwqAJbXQ4NTEyLWJtMS1lbW1jLmR0YiBcDQo+IMKgCW10ODUxNi1wdW1wa2luLmR0
YiBcDQo+IMKgCW10ODUxOC1hcDEtZW1tYy5kdGINCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0
cy9tdDgzNzEtZ2VuaW8tY29tbW9uLXVmcy5kdHNvDQo+IGIvYXJjaC9hcm0vZHRzL210ODM3MS1n
ZW5pby1jb21tb24tdWZzLmR0c28NCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAw
MDAwMDAwMDAuLmI3NWZkYWZjZjliDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9hcm0v
ZHRzL210ODM3MS1nZW5pby1jb21tb24tdWZzLmR0c28NCj4gQEAgLTAsMCArMSwxOCBAQA0KPiAr
Ly8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wIE9SIE1JVCkNCj4gKy8qDQo+ICsg
KiBDb3B5cmlnaHQgKEMpIDIwMjYgTWVkaWFUZWsgSW5jLg0KPiArICoNCj4gKyAqIEFkanVzdHMg
Zm9yIHdoZW4gYm9vdCBESVAgc3dpdGNoZXMvanVtcGVycyBvbiBFVksgYXJlIHNldCBmb3IgVUZT
DQo+IGJvb3QNCj4gKyAqIGluc3RlYWQgb2YgZU1NQy4NCj4gKyAqLw0KPiArDQo+ICsvZHRzLXYx
LzsNCj4gKy9wbHVnaW4vOw0KPiArDQo+ICsmdWZzaGNpIHsNCj4gKwlzdGF0dXMgPSAib2theSI7
DQo+ICt9Ow0KPiArDQo+ICsmbW1jMCB7DQo+ICsJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gK307
DQo+IGRpZmYgLS1naXQgYS9ib2FyZC9tZWRpYXRlay9NQUlOVEFJTkVSUyBiL2JvYXJkL21lZGlh
dGVrL01BSU5UQUlORVJTDQo+IGluZGV4IDdhMzg4NDA5NzQyLi5iMGZiZmZkMjZlYSAxMDA2NDQN
Cj4gLS0tIGEvYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlMNCj4gKysrIGIvYm9hcmQvbWVkaWF0
ZWsvTUFJTlRBSU5FUlMNCj4gQEAgLTMsNiArMyw3IEBAIE06CU1hY3BhdWwgTGluIDxtYWNwYXVs
LmxpbkBtZWRpYXRlay5jb20+DQo+IMKgUzoJTWFpbnRhaW5lZA0KPiDCoEY6CWFyY2gvYXJtL2R0
cy9tdDgzNzEtZ2VuaW8tNTIwLWV2ay11LWJvb3QuZHRzaQ0KPiDCoEY6CWFyY2gvYXJtL2R0cy9t
dDgzNzEtZ2VuaW8tY29tbW9uLXUtYm9vdC5kdHNpDQo+ICtGOglhcmNoL2FybS9kdHMvbXQ4Mzcx
LWdlbmlvLWNvbW1vbi11ZnMuZHRzbw0KPiDCoEY6CWFyY2gvYXJtL2R0cy9tdDgzOTEtZ2VuaW8t
NzIwLWV2ay11LWJvb3QuZHRzaQ0KPiDCoEY6CWNvbmZpZ3MvbXQ4MTg5LmNvbmZpZw0KPiDCoEY6
CWNvbmZpZ3MvbXQ4MzcxX2dlbmlvXzUyMF9ldmtfZGVmY29uZmlnDQo+IA0KDQpSZXZpZXdlZC1i
eTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFj
cGF1bCBMaW4NCg==
