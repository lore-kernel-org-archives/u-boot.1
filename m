Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426A6D2F7D1
	for <u-boot@archiver.kernel.org>; Fri,  5 Dec 2025 10:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC2B3841B8;
	Fri,  5 Dec 2025 11:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="qWv7yqF7";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="WYciXfZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 90B12841B8; Fri,  5 Dec 2025 11:53:14 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFE3841A2
 for <u-boot@lists.denx.de>; Fri,  5 Dec 2025 11:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 92696f62d1c811f0b33aeb1e7f16c2b6-20251205
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Type:MIME-Version:Content-Transfer-Encoding:Content-ID:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=zn4Jnc+Wzm5wEYp+0RYz8RKmE/1IofS207vykxEfuyw=; 
 b=qWv7yqF7uLoIJXdtWp7jwIykoFEfrjmkcoWz8Rmh9rtbaNtQhfbXE+1KzSt9dzmgXUWRiFrimndBqyd0loaXfG1zjIpsn4xsx3PxprCdYW3oQ5XDXwgP1UN4LkE8h40mnc5eV/ayz8GQq9VqfkRQ31c5UsbgL/GzMWUXLqQEJnA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6, REQID:20cd5bc0-71e2-4a7f-8fca-07eb26b6b750, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:a9d874c, CLOUDID:079b7102-1fa9-44eb-b231-4afc61466396,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
 ,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 92696f62d1c811f0b33aeb1e7f16c2b6-20251205
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1914859190; Fri, 05 Dec 2025 18:53:02 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Fri, 5 Dec 2025 18:53:02 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Fri, 5 Dec 2025 18:53:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JoGl02th2D1sFMfHi1W7IGHM+3FIKNgEkk0+99fu43PYXkRuG/t4UL+GjBbwG/Z2CI7X3KEA3YHxIcSjBrtur/JdrmJm1CRPv4zg8ndzJPtt96CG2fY4/6+zx0xUUFhupEBvlG5vpBaB/hScFnX0ALb97SAhHREvahRIu3By9P0b1rdjuf110um7LxyKCYGr5ZS0oXJd7Ywqp1cC9gLMzR5BUdMJWnOH/ndDTkPgtn6QRB9duS0ZgN0+TmZYUsWS7EGIwjbePwqI4Vv2SvM9KMbSt6ZT9vtbp9qu1E9+egxBCvuKbyFlf7Na+gIZp1iJcWYXmPvaRo0thgnl2Bv6cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1k2tUsL2STm3KcIQ4ffbC3BPru2zgifL9SNCSJVzxs=;
 b=OKBBz87DXA5b7XYJofgGl11TXKP8I6w14eqfldtLl4XnB1yzxgbhAinKFvs+aXWnGKtDsgSkS+8EQMknytD3ZxAXJXwIS13GIMYLYqOX2gUDBm4dqWHzIeqvfnkh3eh62hXt1g7CJCjjmoy698gH4U4g0qSMcyfnuD0x8yFeexQ8RrmXonQPrt2AiqyjC7KMvAQ9KyUCBiGKM7DAxEcKZwbwBfb1E4p7HarChcW7fAYpTioZiTDo2643i9JOEKGXEgJ/lz5THSD69ELjjT5A12/ANu8JrBWuyzif6RurHR8p0c19GECAyYQMPT8tWqK8xACQE4qLp/Tm7wBNPloo+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1k2tUsL2STm3KcIQ4ffbC3BPru2zgifL9SNCSJVzxs=;
 b=WYciXfZEO/6UnfMwmlTKNpDMJ+uzrGWXkGrFvbRTBTy1eyZxC+uw5JyTeL98Zq8CCXeKxtvhQcFYqaCo1oIuYNBYXc8b2K1RFsr8dwCgBtJr0DRIPZiFBGqBmy5dkkT3aVH4xNBjTNG7KSapE7d3zKJWgVL2Ds+s1+075r3T1Po=
Received: from JH0PR03MB7806.apcprd03.prod.outlook.com (2603:1096:990:2c::12)
 by SEYPR03MB8480.apcprd03.prod.outlook.com (2603:1096:101:1fd::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.12; Fri, 5 Dec
 2025 10:52:55 +0000
Received: from JH0PR03MB7806.apcprd03.prod.outlook.com
 ([fe80::d42b:4391:f865:71fb]) by JH0PR03MB7806.apcprd03.prod.outlook.com
 ([fe80::d42b:4391:f865:71fb%4]) with mapi id 15.20.9388.003; Fri, 5 Dec 2025
 10:52:55 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Ryder Lee <Ryder.Lee@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
CC: "mkorpershoek@kernel.org" <mkorpershoek@kernel.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, "stefan.roese@mailbox.org" <stefan.roese@mailbox.org>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "alif.zakuan.yuslaimi@altera.com"
 <alif.zakuan.yuslaimi@altera.com>, Julien Masson <jmasson@baylibre.com>,
 "nathan.morrison@timesys.com" <nathan.morrison@timesys.com>,
 "sumit.garg@kernel.org" <sumit.garg@kernel.org>,
 "vasileios.bimpikas@analog.com" <vasileios.bimpikas@analog.com>,
 "lukma@denx.de" <lukma@denx.de>, "kory.maincent@bootlin.com"
 <kory.maincent@bootlin.com>, "utsav.agarwal@analog.com"
 <utsav.agarwal@analog.com>, "ziyao@disroot.org" <ziyao@disroot.org>,
 =?utf-8?B?U2FtIFNoaWggKOWPsueiqeS4iSk=?= <Sam.Shih@mediatek.com>,
 "Oliver.Gaskell@analog.com" <Oliver.Gaskell@analog.com>, "seanga2@gmail.com"
 <seanga2@gmail.com>, David Lechner <dlechner@baylibre.com>,
 "sjg@chromium.org" <sjg@chromium.org>, "jerome.forissier@linaro.org"
 <jerome.forissier@linaro.org>, "arturs.artamonovs@analog.com"
 <arturs.artamonovs@analog.com>, "malysagreg@gmail.com" <malysagreg@gmail.com>
Subject: Re: [PATCH 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
Thread-Topic: [PATCH 1/2] arm: mediatek: add support for MediaTek MT8188 SoC
Thread-Index: AQHcZGOxzz51nEZvL0WyoHInDGYZ07US4dYA
Date: Fri, 5 Dec 2025 10:52:55 +0000
Message-ID: <2130bf1ebe2e3684a3d1c7341249ce2ca524d0bb.camel@mediatek.com>
References: <20251203-add-mt8188-support-v1-0-9a06ebb97734@baylibre.com>
 <20251203-add-mt8188-support-v1-1-9a06ebb97734@baylibre.com>
In-Reply-To: <20251203-add-mt8188-support-v1-1-9a06ebb97734@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: JH0PR03MB7806:EE_|SEYPR03MB8480:EE_
x-ms-office365-filtering-correlation-id: bb68d4ad-7391-4d58-c846-08de33ec7252
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: =?utf-8?B?TmVvRzdLNFBiWXhTdjEwMUp3Q3VsR3JTdGc2bVA1aEhnU2RZbXR6eFJnMHg0?=
 =?utf-8?B?OEtaeEJTemFFZmdsL3VGZ2svTHFtSFFKelpvdThKNm5VV0lHQ2xaOU9vREpM?=
 =?utf-8?B?b2VYWENxeEdPQWQwMnhJTXljTEwyT0puL3FUOXI3aDJWdnQvbUZZUStYaS9k?=
 =?utf-8?B?ZUovZ0Q4Ty93Y0t6YWVUOGVwb2NVSkZOSG5FYmx4WEpEN0lpV3pWbHBXUzB5?=
 =?utf-8?B?TEd6OVlveW1VamltQThaQXpZSXZXc2NsSktMRjMxOWVKR2E2YjFFVVpQZE1r?=
 =?utf-8?B?TExwRXBNYzlUcGYremZGcy9yWFBLWnEvRmp3TEJXRzhsd1FxUnM0VDFuN0ov?=
 =?utf-8?B?Y2taSWJ5S2Q3MDl3dmg3NFY4d0xpYzkySU1ncjRCUVpIL3IxbXdDb3hrczYx?=
 =?utf-8?B?ZGRvUW54OFJLMUplVW84MlcrcUZyYzZIcStzNVVVR3VtMGVXYlNIS3pNT1lm?=
 =?utf-8?B?bXdKL015R1dzREU2NHEwU1REK3ExOE5xKzMxemN6c28wQzZab3N4a1p3eWdN?=
 =?utf-8?B?M2ZCYmxRQjhTWW15UmJZVHZ0K2hiMjYvZnVTMnVkOVV5dFhFYTY3OUc0N2Fo?=
 =?utf-8?B?OWQ1dzN4V2d4TDdiY2NwRVFOaFlrWWR5R3B1dXYrd1Q2c2Z3Y1IwSXAyclh0?=
 =?utf-8?B?SXdWL01XK29JTFI5elArT0wrdHJId3VNVjJ1YzBSM3BUbk1IZllmT2Zpamtp?=
 =?utf-8?B?QWx0T0pNb1RHU1pLdVVESVo5Z1RNQUwxcy9paUV5VkN0MDBOOUUvUjFPZXE3?=
 =?utf-8?B?MTFMa096bGR0b01XRTdTaXBMM0dxRk9DN05mdHZ1VkRlNXVzdjllOEJKWkN1?=
 =?utf-8?B?aW84TEtCV1RnemViYmUzWFpjeDJ0M3poRVgwUTUvZCt2MXB4bmxGSkxNQ1hs?=
 =?utf-8?B?OEpuMmpRVVk2MEV4NXlVZ1doYi9pcSthZThwWnd5Mkk2OGVmY3VhMDBHSEh2?=
 =?utf-8?B?aGNrQTQ2eDEzbnFoU0lxdDk0V1dEZFdja2p1U0EwUHI3RE1ZbnZHaGtuYk9T?=
 =?utf-8?B?ejI4bG15STcvTzJFOU9adDBUS3NnaU5od1U4eE1EUUM0bk1GRnZOZFRKT1NW?=
 =?utf-8?B?aXNxZ25tajQxM0IrMEtTVjUwa2dHS0xzTVNCWWNveGR1NnNLVmtTRkVkemlp?=
 =?utf-8?B?QUh4VGt6RHJyOVZBVkV6dVlnSCt0NUdkZUV4ZGNCZDhiYjBLYVpYbnJSU1No?=
 =?utf-8?B?Tml5UjZXMHFwc1Fhb2FMUUFCVU4vMW9pVzZhaWJLUkx6NjVzcTl0UUFnTlBJ?=
 =?utf-8?B?Q294eEZ0MVhzMlFwTHU4MzZKT2JBVGpKeHhCbVkwNkFSYktQRnBXTmw4TUQx?=
 =?utf-8?B?OWtEUTc1Ync4UXMrUWZUVkxhUzlJdkZxdG5NbUN5bk5LajFJK1F5ZHhVSEp3?=
 =?utf-8?B?aDlDbDJtNm9tQ1Y3RVkwaHh0a0wrYkhZekJObU40N0QvSm80VW9PN0JocDNN?=
 =?utf-8?B?bGM1dEIrbXdTbmpqbUhoOWlqVExrcVhHS014cHF3VE9xRnZiWjBWU0Qra0lR?=
 =?utf-8?B?bXJCOENkQmI1YVhJdzNkdGR6R0ZoZ0l6NmwrYXYwZk5rS3BPM3RhMXVIc21z?=
 =?utf-8?B?YWd3S21zZitkNjV6eENseURKUDlMQjhEVmV1NVhXdDhJT0ZsV0RKQUdoZGNm?=
 =?utf-8?B?YWdwNVZTV09qOGZ0dWFXYnM5bGZGUU5qZ0J3QmlxQUkydnFua2NxcGZUV3dH?=
 =?utf-8?B?anlqWDZ1bTltUGlBdkFFY3ZQRWJVdjBlVnBvaGhVMGdNWjNmNHNzY1laZzUv?=
 =?utf-8?B?aEpKVnplY25VcGFwY2lQTjJWeTJQOEtCdDllQVFLM3YrbFhPalVQMTNMYVpm?=
 =?utf-8?B?Y1F6aFFLNjlya2NNRlA2YUNhQU5aenZ4bEtIZUpTNGV5d2w1YVBUanhHc0xM?=
 =?utf-8?B?aDVqUEppS3Z1YUFqWE5sYjNqaGt0Wmt0QUYvSTVZUlQ4cjRtSUs5ckhyVy9l?=
 =?utf-8?B?eUlvekxBRkRaQlhaaXV0WnJWdXBWZUIwandxZ2FmZE5CZ0RKQ1RSZFVSOGpq?=
 =?utf-8?B?ck0rUEZDbUlFa0p0Sit5NXBWNytqZnN0NVU0T2pFRDQyd05xTzNXcnBzQ3VK?=
 =?utf-8?B?Qk81K0ZHdU5FRjZpR0xmUVJONi9kL2RNVjd1UT09?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:JH0PR03MB7806.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021)(921020);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmV6SVhvV0JIUnhMemVqNGNlQmp3akxsL2hjdmhHQVJuTFVoVEJReXJLL1dD?=
 =?utf-8?B?RStxZStTMVluemt3clVQUEVPK1R6a1dORUg2RDhwN3g4OUN5OTBVc0RGR0l4?=
 =?utf-8?B?ZTFTdmN3ZlM0ZDd2bDBTSm1sbm03VGp4SnFpQ0VqbGxHQTlSTThoM0VnbGFB?=
 =?utf-8?B?K01oZnprdmN3SEorOFFTODdDL2ZKOENzQTFlcjY2U21NMDVuMEtjcjJjZDh4?=
 =?utf-8?B?Y0swdWFxYzUrOVFxbkR6VEZybXh5YkJJcXRuVk1DMXNNWnE3WkZHVkJRR0ll?=
 =?utf-8?B?SWNtME84WHViRm8xTlNWWXcvZERjeUdsQW1sclZZR2pkNWtYR2Z2d2VSZ0Mr?=
 =?utf-8?B?b2E0TGlncjgwTVlRejQvOHVkb2RHYytIUHRqYys1UXVHOHNreCtTYm16WmF0?=
 =?utf-8?B?eUNIWG9vV2ZraEFaa0dxRjJmRzdaamxjSzBvdXNDZzBrZjRSZmtBNTVQMmdj?=
 =?utf-8?B?cTllRFphL0UyV2RwRnU5L0RWQmF5SFBVYjRqdWZuZFhONGJYdEtJTW16akty?=
 =?utf-8?B?V2FLVnhaSTRtL1k2eFN3bXoyb2VxNXNEajFxTTVETVVPWmhXVkt6L0ZQb1J0?=
 =?utf-8?B?elNNbnFOeFN1aFBxR1YxVE0zbURiZ2tYZTVqRFN2NnQzcjhzY3E0ME83Y1RB?=
 =?utf-8?B?OThHeTRlaThxS2lYblNCVjB1SkR6OW1OZjF5NUpkOWc4VEd5Wi9CRUovazdp?=
 =?utf-8?B?WWpTN1VYVUt5cGo4NG9ZTVBFeEhQNG4rTldTS0hqZGpycGV0ZEI1a3dwcTlv?=
 =?utf-8?B?VTlOeFY5ZkF2d25XZXlXcjMvNmUvSUtVWWNZY3ZNanNWZklvUG5NNng0eG1D?=
 =?utf-8?B?VFdOa1hXcTBYNjJ0WHh2QlQ3SWNTcllvRnhQT2NlbEFtdDh6Wk8yaDg3VlhS?=
 =?utf-8?B?U1l6Y3dDMVpDeXIzTFJHNnY4VkllUlAxazBEdGg4SElPMGZ4a0JzVVFEQ1Ru?=
 =?utf-8?B?RmViYktNdGRnNmFLSUZlVmRIYnpXSXI3V2crbmI1b21mM3I5S3ZvL1o0VFhV?=
 =?utf-8?B?UmZIYlZubFA2aVcvMS9XcXlaRC9nOHdQaTdmWCtYUGdBd3U3eTl5ampxOXFw?=
 =?utf-8?B?dDEwQkpyaUpuVk1ONm9NdHMzS0lNMEVLZE9IT0FuYytmbnZNaGR6KzlINld1?=
 =?utf-8?B?UWxlcVhJamVBSUJ6UGlUc0hDTFUyTVZwMS9TRG5IOTlER2dGUFdUaFJHMXFl?=
 =?utf-8?B?bndTOTNlWGVFcHdYYXJnbkhnakYzRVVFREdZVUlUZWRzZW9udkgxWVVSR1Ez?=
 =?utf-8?B?TCtqOTlUTFJwbG5va2RHYjdkWTI4VE9qcUdSRHVKclBOMi81SGZwNnhxZ2sv?=
 =?utf-8?B?Z2xRSmNpU2hmUTdNQjJzS3hXWTdKbU5WVEVVWUdsMHBxc29kT2RrTjZrWTBE?=
 =?utf-8?B?S2Y2Rys2RW41Wmlmb3FHczhNVHpCaWF3dloxREtnd0RhOWh6dm82YUlqVk84?=
 =?utf-8?B?Z293N1JsYjRkZitRaGswMFg3UTVoNS9HSzdyVGN1WlhxdGJzaVh3OXl0bmQx?=
 =?utf-8?B?TGZhcVpSc2NTMVRqbXk2QWluN1BRaVBWb0dzamlrSjE3ZE5rNW5mTlRzS0g1?=
 =?utf-8?B?Nnk4SEp6NG4rL3JpWE8wQ2NXblBBTWlBRVlHZ00reXFlL0xkNjNMRHd1MGMv?=
 =?utf-8?B?NWJ1SnI0V0lDM1dZbUQ5cE10Q3hxcVMzV1pqR2RFa1RUYko2TTNqUXlMajN0?=
 =?utf-8?B?YWZTU1YzeC8yZEZqV09JWDlNK1hmM0h1U0l1KzNxQnkwTmExWC84a29vS0cr?=
 =?utf-8?B?YjJwZEZZS3djWjg4S1ZJdXgrUk1vU0RIemRtRlVpeDgxSjB4eVh2L3pNeXRI?=
 =?utf-8?B?VEtnakNCS1ZkazdWVnNpR0g5d1RjUW9GVVI4VHFUZXFRek1CblNJY1lOeUlz?=
 =?utf-8?B?enVlSkN3YWlNVTRtdnllcmtYZHZrc0ZWbXlaU2U4TVhmOVEvdVJ1YXhybWJQ?=
 =?utf-8?B?S05oa1NqRjFNRkdZbzk5RUl5c1g2aG1zdFJ6TFk5NlI0aWlqZVJud0twUXVC?=
 =?utf-8?B?TmUwcWt1Q0ljWG1mc1RoR1FkRjZiY0NaZjd0UWlUY2pFeFEra3JkL0x1RklV?=
 =?utf-8?B?QXhpZmt6bVAzNWpPcmNFZnkwSUF2dDZMZ3dyelNVTndiSjg0VFRrc1ZsVUM2?=
 =?utf-8?B?VWdjNVNxL0ExZllpQ0YrT1h5UjhQQ0l5VlAvZ3hRWWZ6SlVaWnRPeUVsTTJr?=
 =?utf-8?B?NFE9PQ==?=
Content-ID: <D9D79A267B451546A3E2139998E551FD@apcprd03.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7806.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb68d4ad-7391-4d58-c846-08de33ec7252
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 10:52:55.5896 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: coPtpO+27HGmsPSlAM3oNDzag/ARllb4rhh4iR9Zmxm9fIA7DxeRc6971znLzYT+Psm/4y3ljr0xx82bTtPGyWS7fOhfZkFp1kbM0zj//NM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8480
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
ZS5jb20+DQo+IA0KPiBUaGlzIGFkZHMgYmFzaWMgc3VwcG9ydCBmb3IgTWVkaWFUZWsgTVQ4MTg4
IFNvQy4NCj4gDQo+IEFkZCB3YXRjaGRvZyBzdXBwb3J0IGJ5IGFkZGluZyB1cHN0cmVhbSBjb21w
YXRpYmxlIHN0cmluZy4NCj4gDQo+IEFkZCB0cGh5IHN1cHBvcnQgYnkgYWRkaW5nICJtZWRpYXRl
ayxnZW5lcmljLXRwaHktdjIiIGNvbXBhdGlibGUNCj4gc3RyaW5nDQo+IGluIGFyY2gvYXJtL2R0
cy9tdDgxODgtdS1ib290LmR0c2kNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEp1bGllbiBNYXNzb24g
PGptYXNzb25AYmF5bGlicmUuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBKdWxpZW4gU3RlcGhhbiA8
anN0ZXBoYW5AYmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArDQo+IMKg
YXJjaC9hcm0vZHRzL210ODE4OC11LWJvb3QuZHRzacKgwqDCoMKgwqDCoMKgIHwgMTAgKysrKysN
Cg0KV2hlcmUgaXMgbXQ4MTg4LmR0c2k/DQpXb3VsZCB5b3UgcGxlYXNlIHRvIGtlZXAgdGhlIG10
ODE4OC5kdHNpDQphbmQgdGhlbiBjcmVhdGUgdGhlIHNlcGVyYXRlIG10ODE4OC11LWJvb3QuZHRz
aT8NClBsZWFzZSByZWZlciB0byBvdGhlciBwbGF0Zm9ybXMgbGlrZSBtdDc2MjIgb3IgbXQ3OTgy
LCBldGMuDQoNCj4gwqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL0tjb25maWfCoMKgwqDCoMKgwqDC
oMKgIHwgMTEgKysrKystDQo+IMKgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9NYWtlZmlsZcKgwqDC
oMKgwqDCoMKgIHzCoCAxICsNCj4gwqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE4OC9NYWtl
ZmlsZSB8wqAgMyArKw0KPiDCoGFyY2gvYXJtL21hY2gtbWVkaWF0ZWsvbXQ4MTg4L2luaXQuY8Kg
wqAgfCA2OQ0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgZHJpdmVy
cy93YXRjaGRvZy9tdGtfd2R0LmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDEgKw0KPiDC
oDcgZmlsZXMgY2hhbmdlZCwgOTUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXgNCj4gYjQzZGFl
ODgyYjNlYTMzYzJjZDc0NWJkMzc1OWUzZjRkOTdhYmM4MC4uNWI1MmQyZmUxNzUwNmQyNjU5YmU5
MDE2YTdjDQo+IGE2MzkwNjIzMzJhZTkgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsr
KyBiL01BSU5UQUlORVJTDQo+IEBAIC00MTUsNiArNDE1LDcgQEAgTTrCoCBDaHVuZmVuZyBZdW4g
PGNodW5mZW5nLnl1bkBtZWRpYXRlay5jb20+DQo+IMKgTTrCoMKgwqDCoCBJZ29yIEJlbHdvbiA8
aWdvci5iZWx3b25AbWVudGFsbHlzYW5lbWFpbmxpbmVycy5vcmc+DQo+IMKgUjrCoMKgwqDCoCBH
U1NfTVRLX1Vib290X3Vwc3RyZWFtIDxHU1NfTVRLX1Vib290X3Vwc3RyZWFtQG1lZGlhdGVrLmNv
bT4NCj4gwqBTOsKgwqDCoMKgIE1haW50YWluZWQNCj4gK0Y6wqDCoMKgwqAgYXJjaC9hcm0vZHRz
L210Kg0KPiDCoEY6wqDCoMKgwqAgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay8NCj4gwqBGOsKgwqDC
oMKgIGFyY2gvYXJtL2luY2x1ZGUvYXNtL2FyY2gtbWVkaWF0ZWsvDQo+IMKgRjrCoMKgwqDCoCBi
b2FyZC9tZWRpYXRlay8NCj4gDQo+IA0KPiBbc25pcF0NCg0KVGhhbmtzIGZvciBoZWxwaW5nIHVw
c3RyZWFtIHRoZXNlIFNPQyB0byB1LWJvb3QgdXBzdHJlYW0uDQpIb3dldmVyLCBJJ3ZlIGZvdW5k
IGl0IHNlZW1zIGxvdHMgb2YgZm9ybWF0dGluZyBpc3N1ZXMgKGVycm9ycw0KYW5kIHdhcm5pbmdz
KSBpbiBjb2Rpbmcgc3R5bGUgd2hlbiBJIHJhbiBjaGVja3BhdGNoIHRocm91Z2gNCnRoZXNlIHBh
dGNoZXMuIA0KDQpQbGVhc2UgaGVscCB0byBmaXggdGhlbSBhcyBjb3VsZCBhcyBwb3NzaWJsZS4N
Cg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL210ODE4OC11LWJvb3QuZHRzaSBiL2FyY2gv
YXJtL2R0cy9tdDgxODgtdS0NCj4gYm9vdC5kdHNpDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+
IGluZGV4DQo+IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAuLjZkMWIy
YWI4MmRhMWM5NWE0OWI4YTY5M2ViMA0KPiBmODU0YWI5MTNhMjZiDQo+IC0tLSAvZGV2L251bGwN
Cj4gKysrIGIvYXJjaC9hcm0vZHRzL210ODE4OC11LWJvb3QuZHRzaQ0KDQpbc25pcF0NCg0KDQo+
IGRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE4OC9pbml0LmMgYi9hcmNo
L2FybS9tYWNoLQ0KPiBtZWRpYXRlay9tdDgxODgvaW5pdC5jDQo+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0DQo+IGluZGV4DQo+IDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAu
LjMzODljMDNiMDYwMDZlODEzMGI0Y2U0NDhkNQ0KPiBkY2ZiOGYxMDNjMjhmDQo+IC0tLSAvZGV2
L251bGwNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9tdDgxODgvaW5pdC5jDQo+IEBA
IC0wLDAgKzEsNjkgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+
ICsvKg0KPiArICogQ29weXJpZ2h0IChDKSAyMDI1IE1lZGlhVGVrIEluYy4NCj4gKyAqIENvcHly
aWdodCAoQykgMjAyNSBCYXlMaWJyZSwgU0FTDQo+ICsgKiBBdXRob3I6IEp1bGllbiBNYXNzb24g
PGptYXNzb25AYmF5bGlicmUuY29tPg0KPiArICovDQoNCg0KV291bGQgeW91IHBsZWFzZSBoZWxw
IHRvIGtlZXAgdGhlIG9yaWdpbiBhdXRob3IgaGVyZSB0b2dldGhlciB3aXRoIHlvdT8NClNpbmNl
IHRoaXMgZmlsZSBzaG91bGQgY29tZSBmcm9tIA0KDQoNCmh0dHBzOi8vZ2l0bGFiLmNvbS9tZWRp
YXRlay9haW90L2JzcC91LWJvb3QvLS9ibG9iL210ay12MjAyMi4xMC9hcmNoL2FybS9tYWNoLW1l
ZGlhdGVrL210ODE4OC9pbml0LmM/cmVmX3R5cGU9aGVhZHMNCkF1dGhvcjogQ2hyaXMtUUogQ2hl
biA8Y2hyaXMtcWouY2hlbkBtZWRpYXRlay5jb20+DQoNCkFuZCBwbGVhc2UgaGVscCB0byBkbyBp
dCBzbyB3aGVuIHlvdSBhZGRpbmcgYmFjayBtdDgxODguZHRzaS4NCg0KVGhhbmtzIQ0KTWFjcGF1
bCBMaW4NCg0K
