Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2361FEEF49
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:28:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2015D83F98;
	Tue,  7 Apr 2026 16:28:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="lZrt9xQz";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OK/YBfd7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DC828404A; Tue,  7 Apr 2026 16:28:19 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3EBE180433
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:28:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 0047bdce328e11f19a16598d5ca7f8ec-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=+UHdaZhCCt2/GEmdJTFvSMGAnhFTYG6+Ak0wJ8hE8tg=; 
 b=lZrt9xQzrGwGXgj7ocEzFTpnnAfCTh4vTdUb9fEQvcFQvoyiWVR6mQBEhT75wygQYVd8pO55RCRVNhWw8+Qsax1XhFiLP2O43qaqAY/xhM4ZFNfjPJxtUiIAzyXg3SlkrmXi0reEmFYgx0CQQ4rnWiLRQiZe+9AEfLzNDQ3NCS8=;
X-CID-CACHE: Type:Local,Time:202604072228+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:76c9133f-c27b-4d2c-81fb-c1f92ba1f10e, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:764595d5-060f-4ecc-9ee0-121eeeb4a682,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0047bdce328e11f19a16598d5ca7f8ec-20260407
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1673880240; Tue, 07 Apr 2026 22:28:09 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:28:08 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:28:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndYQCHuxsVZosYqO/WBo0bQppVuHE/OCbMM6p7vVSrsOgcdtxFg9BZ1NKqEC2WiT7XRhKpsgL67jdwDu/Yc8L+DCCq1BkQTckL+PUNCrblcD17ZTc0AuCrUZ9UHVDqPC8+TbKDpsEHYySO3ryR798a0cwf8otXSe6qtlXKO+gg85m2P0wfGLw6WkOkw7foZrp0mbNKe/J/dzhIA+KiBI4vm7ZT1zttxuVfUd2yzX1jNwWByHP5wplSyAeYW9f+EWgtx3zEcZgyTf05Z7SP3SjDR4LTgW/yueS3/Tk4UVWhjWjHNPsbabrZ1fDxL6ssBlhwYSsyv9uCOS6yxhMpBM4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UHdaZhCCt2/GEmdJTFvSMGAnhFTYG6+Ak0wJ8hE8tg=;
 b=DW+hmGO/FBsYNxYqZqVMSGsydVsRBldyQMhGDHvI84BtNG46mNdtAFzoPhpithfurO4AoG0USTVNlz91Dm7aL8raJDch/hs+Fuf00zHZpZPoNploCQyKk+Hidc6YzLqb7SgTbpw+ekcJUp1jfrtGQ2YdYqOrY0cE+N+MaHudmwlcmTrL73A1cRKyMSQCjqAHaXf6yVWyR+Ecz9hSglSYz5zRfdRy46ecC+u0lhqXIbJ9zi6U5p2RCmdlDjTyKicbT5hpVHuHsRd8bRihYgETuVhGHen/K2LOQwc1CLHcMaNB4wlV/eXsPFXMHCVmYSUiAHdoKelEpqWpmh/3m9oeng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UHdaZhCCt2/GEmdJTFvSMGAnhFTYG6+Ak0wJ8hE8tg=;
 b=OK/YBfd72xKQ1y1Z4znossMqP9aMg6v5aeC3UxtYPtPXFxkUeLQvCuLMCr+ctoYThCVvfoBbSyiR3RZhANwfWMtjzftZlFrmAlewjmIvj4CbbyCwyGuZxViGiVSnrLhly0fSqCfSDWpxRI14h2eq6JFlIt8PNybqb7PpAJp5gy0=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB8250.apcprd03.prod.outlook.com (2603:1096:405:23::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 7 Apr
 2026 14:28:04 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:28:04 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH 3/3] configs: mediatek: mt8189: enable USB support
Thread-Topic: [PATCH 3/3] configs: mediatek: mt8189: enable USB support
Thread-Index: AQHcwiIsdB7UwodUr0W++jyAo/TM/rXTsTeA
Date: Tue, 7 Apr 2026 14:28:04 +0000
Message-ID: <b0a3c84d1f04824976fbd2869ee87b813d6136b1.camel@mediatek.com>
References: <20260401-mtk-mt8189-usb-v1-0-a4bf951aa8ad@baylibre.com>
 <20260401-mtk-mt8189-usb-v1-3-a4bf951aa8ad@baylibre.com>
In-Reply-To: <20260401-mtk-mt8189-usb-v1-3-a4bf951aa8ad@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB8250:EE_
x-ms-office365-filtering-correlation-id: 045b2a1e-56dc-47f6-d5b7-08de94b1e191
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: vtmuGXxVn8Q55RxGTv2ZiETNOz/FNlAedbs5epEVHYN8pk4tOZ9HIXeMyRMqqz6xO1ruyWd3cmG+si2oSsv/EatzHgrGNnlx8wx9BXbaH627e/lNdIcdhd0CB494JuoOY5j/TU9WptlC5QGA+ov15R7PVvrhc4HTIWCC27GLJDfTcIpFGpVjmnHSr1ymy/5r2VE6GKZkBicgdPzODl/DCDpwABEyOKFzsD36UsMcI5uCNX8+fu+fSjGzwpFk+kN5SkK8s1bRC2562PtQYQecJoQE7n4CaFFrXx4qD0iryV8QFC/cGRssWvL5wnvjQFD7EE4o3KdTcRP+whFD6Xki4POtgrbNMH7p0WnWOhxySyFZXmxyhqg/GGLRMr7uyJ7IYZLRA5PnXRLuhRU97/vAwmtowW6+MZHhAIYEJWF1Dh+6QOnJNKhhRWw7FXIWn3jla269UFhawczOTOzClc0S1nri0ABCxhmxsqB4p08h01JuXFolDK4WpzdLcV8/zGaSkOhz5xI1S0JlqNpsqzcHH4g96XLDFXpUCc/HLnoxW7tCE6NpJgih8m6a57q5zBivJ2SXJ4YrpmLyxGvq49Hon53kLxiwg0IUDbV26XvFhbh2LXr5JZ45ECvaEmbGCJ5f4uee1R+EGumKR0j8pTK7jfAMvbGTwY1ekhNBa6N97JK1z+JmAIiB5dvZUIii14GmQbviaeyMGhZYEmrkQ06mkYM6o/3KApSx4y4ppDiqjy6Axp9qkcLmvlq52pVAYF/zKyX3tU30q8JWA/HTm+63niNH4zyZ10FxlAHAJWa05aE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWVFS1FhdUQ0NVBiRlUrRnl6VUV6bHRjMm5wbUZxVndIbWNTYk80MW1vWW1S?=
 =?utf-8?B?WWc4RGRmTkQvWmxyNHB2NWhIZ0psNjdLRkxCMk9SMktpYW9iYjMvdG1yNzFy?=
 =?utf-8?B?R01LZU9PUEUxM1ltTzlqS2VTMUplKzZPQ2FITzYySTM3MGxlNDlsY1A3M1E0?=
 =?utf-8?B?TnRUcXBnSU9Da2Jxc2hDOFB3QjZsS1M4OVM1OWVoZ0Rpdk1iMnpqV0Q4RXM4?=
 =?utf-8?B?RC8vaVQ5UENhTEVLQTlVTWNMNFpScDhGcEIrNUQySjdWRHdiWmZ6OHhMbDVQ?=
 =?utf-8?B?eGpacDBjakM2UkxEUjZuV2liSlQ2R08ydWhyN25ERS9jeTZzWjVyK25xVlJz?=
 =?utf-8?B?YVB5MmJlYk9OR0g4Z2hMNWd4L3oyNWdWSnRMZEF0M25XWGErc2Fub0RMUERS?=
 =?utf-8?B?Nnc2RDRmeDJ0VHVDZEZndjhianVJYlBnSkI1K0pUUms0RlRCR3IzQStnc3Vl?=
 =?utf-8?B?Q1FxTDZ1eDEzLzJnQU1xa2RPa1FjeS9zT3RNVVpaRnRJbCtDS2g5Ym1sSTR0?=
 =?utf-8?B?RHlCeGU0azJwczdyZTNXTi9zU092SUg1WDNxcU5tMXNHcldKNzZxeXdBcTBq?=
 =?utf-8?B?dHAxMUdvUXVYWjVyRWxkTkNPb1JmSEpwVUloK1hTV1pEU0FwZGRnSXBWMW9S?=
 =?utf-8?B?akJsUjFuZ0N0Z0x4K05pVUdyeHRaN3FHOHFKeElObmZ0bFZZd3U4RWpSNnND?=
 =?utf-8?B?aUJ6N3BWSHVUek1PdERYdkg2RnRqdHNQbHBDTzREUHU3Qm0xak1qNUpJdUlV?=
 =?utf-8?B?bTA5REExT3haSDNEbzQ5SGpSWnlJVnBVbnlBVFJBanE3Q1JhVTBKOTgzUWRo?=
 =?utf-8?B?aWNoSW5wN3lscVVYTUcySEhXTThFUEQzU2ZneURSNGorWGlsZWpadUNDeHVy?=
 =?utf-8?B?Z3B1dVM3d3p0U0MzbmZPSm05bExwZ1VFNUx6TkZLY1pDVkFtdUN6MUR3U2hN?=
 =?utf-8?B?MldtQStiNnZzR0luTWhWN2hvNGxsT2F3NXZOTjRQVDdtWmZlcXZxVDVsdXhz?=
 =?utf-8?B?ekY0Z0pLd2d4QjFldXQ1SHpYNE1WbGE4czdST1hrM3RlOVJNNEoxdGlleDJw?=
 =?utf-8?B?djdBcnFDRDFiYzcrMXdWNnFsVnYyM0VEZzNvKzVCdjNtaGtzZ1hjZDZLaTBt?=
 =?utf-8?B?czRoZWFVQWRnaWMraE9CdXhnQlNQZTJoZGwwSlZRRXJObmtmZEtvT084eVA0?=
 =?utf-8?B?aEhKdVNZK294OURnMTI0SWlQL2FKRy83Zk5QajdrUzhJdnRhOVc1RWtZR21E?=
 =?utf-8?B?c3V6elJNQjBlY2g2QTRJQUpkbmhuZWZDNlV0OE9QK1dEZW1zSUlHSFVGbU9D?=
 =?utf-8?B?OUYrRmxCb1ZjNW9UcW5wM0tYQndFMEtSZHNjbzNIRS8xK2YwcEtiS3BhSmY3?=
 =?utf-8?B?N3ZCWmhDMGJGN1ZCcndiSUh3NUV0UXkrYnFzdlh2Q2pha3JjbFBHMFYrc0JC?=
 =?utf-8?B?M3llbGxOcTU1dXV2SWR4RkRqZUdjMmJIS3IyR1ZxTmJmMFRuNVgwVlAreUxE?=
 =?utf-8?B?cG5lN25GWWlmd2lyMGJVVjNBaTNLMXc4bm0wREpaSFdOSWRaWU9UNXRhV3V6?=
 =?utf-8?B?Uk9hSWtlNGd6bXN2M0xxaXp2TXY3aDdrSlJKVG9rU0Z0QkdmN01ISG5JYXhV?=
 =?utf-8?B?STRQTmZKMkoxMGNZaitxY2pzdUFnaEU1ZFVhRUx4ZFE2MmZST1R0YXA3NHBY?=
 =?utf-8?B?WUVYVmFPTHlBS0orOGkzeFRtNmhXeFJINnVuYU1Gb25vSmFXcnB6Mk5aSWJs?=
 =?utf-8?B?Ykx5elp4UTBkdmkrbWgyNWhOdWFUbU1Xb1NZaXpiOGM3cklydUcrY05IS0li?=
 =?utf-8?B?dmdOc3o0U1RrVkNtTDA2cE43cGErK1d6M0NUbWI1Ymc3N2h5SXRDUlNGUm12?=
 =?utf-8?B?MGNGMlRqWlBtUGRnK2xhUUMzYzR4bFRQMHRSTGF5UDhCUDZpcVlVK3dZdndX?=
 =?utf-8?B?NmFzOTRrU1Bwdm1wbEt2bFd3NUFoRitJU0dzNTBHT1drMk5MTDM3aU5OQk8x?=
 =?utf-8?B?RkxjYXVsZmh1MVIwdzhockdmYndWdnpvblgrbjRkWE1tb3Z2ajNyOUdKdExs?=
 =?utf-8?B?QVl2Vld0VkNBSExYcUNNOEM4RWkyTWRlemNtb29wbEoydFZEM0VrZFlWblNH?=
 =?utf-8?B?bVZNZ3gyckRZUkswUEtQazFhZXpXSGJGdU1lMTBUdDVvQjN1Sldjcm9rdkxn?=
 =?utf-8?B?TnVJV1V1ZEROT0NsUWE1ZWtvQjI1LytQNUl2VXJVbUlDMXNHWUE0S1g0U1RE?=
 =?utf-8?B?OE45bkNnUnNsbVZhZWVRNzB5TGVVbDNLUlhLWHlMUkh0M085cHh3Ykk0VUZF?=
 =?utf-8?B?RHo4b1ZMOGhFb2xyM0xwbWtXLzBySTY5eVNMYXozM3BzRmtXMVRtYXEwalFL?=
 =?utf-8?Q?dW2OPG2TsLklWMps=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C92426DD8A38BA439961CCB6A4D22CAB@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: kLLAE8wO4EA4IjBqIBLtmntnEYFWErl9sGAQGYsiu3/996nvAddeqybJapI5y9j120cBESZaF6M5acdbb0Cm1l1SUkzYjPokGWPl5uzB21ZfXlS9yPSYCiKmq3qPPIMSp84cAuntgo7fwZkTu09Q1zz4l15bvyGvzoDYvA2z1CNCntuU/mvltt2Mk5neoCp0vym/t/5FajHp1RADFRElAzCRtWbuZ34J0Ja52Put8MfOo93nOxU7oB+mFYWrEfZ1FP4sD6vPdQiduIXOXKDPXZcEwNkLjdbotgMv0FQXn62HGkUUYWhXQn3B47FjgYKXS7GzTSU+qFNkqipoZTPtrg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 045b2a1e-56dc-47f6-d5b7-08de94b1e191
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:28:04.7591 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SFksIAgTPgkuGuWNKQFlGk6H7ajXLEqdGS/j9X/Fm8NliCd8k6slJwPu65g+4mTP2CKnIJYTEK4lA+JcbICjaTzUoucgkUWm9htSwOzczvE=
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

T24gV2VkLCAyMDI2LTA0LTAxIGF0IDE2OjUzIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgY29uZmlnIG9wdGlvbnMgcmVxdWlyZWQgZm9yIFVTQiBzdXBwb3J0IG9uIFRBUkdFVF9N
VDgxODkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXls
aWJyZS5jb20+DQo+IC0tLQ0KPiDCoGNvbmZpZ3MvbXQ4MTg5LmNvbmZpZyB8IDggKysrKysrKysN
Cj4gwqAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEv
Y29uZmlncy9tdDgxODkuY29uZmlnIGIvY29uZmlncy9tdDgxODkuY29uZmlnDQo+IGluZGV4IDBj
MTU4Y2Q5NDMwLi43NGVkZDAxNjllYSAxMDA2NDQNCj4gLS0tIGEvY29uZmlncy9tdDgxODkuY29u
ZmlnDQo+ICsrKyBiL2NvbmZpZ3MvbXQ4MTg5LmNvbmZpZw0KPiBAQCAtMTYsMjEgKzE2LDI5IEBA
IENPTkZJR19DTURfQ0xLPXkNCj4gwqBDT05GSUdfQ01EX0dQSU89eQ0KPiDCoENPTkZJR19DTURf
R1BUPXkNCj4gwqBDT05GSUdfQ01EX01NQz15DQo+ICtDT05GSUdfQ01EX1VTQj15DQo+IMKgQ09O
RklHX0NNRF9QTUlDPXkNCj4gwqBDT05GSUdfQ01EX1JFR1VMQVRPUj15DQo+IMKgQ09ORklHX0NM
Sz15DQo+IMKgIyBDT05GSUdfTU1DX1FVSVJLUyBpcyBub3Qgc2V0DQo+IMKgQ09ORklHX01NQ19I
UzIwMF9TVVBQT1JUPXkNCj4gwqBDT05GSUdfTU1DX01USz15DQo+ICtDT05GSUdfUEhZPXkNCj4g
K0NPTkZJR19QSFlfTVRLX1RQSFk9eQ0KPiArQ09ORklHX1BIWV9NVEtfWFNQSFk9eQ0KPiDCoENP
TkZJR19QSU5DVFJMPXkNCj4gwqBDT05GSUdfUElOQ09ORj15DQo+IMKgQ09ORklHX1BJTkNUUkxf
TVQ4MTg5PXkNCj4gwqBDT05GSUdfRE1fUE1JQz15DQo+IMKgQ09ORklHX0RNX1BNSUNfTVRLX1BX
UkFQPXkNCj4gwqBDT05GSUdfRE1fUkVHVUxBVE9SPXkNCj4gK0NPTkZJR19ETV9SRUdVTEFUT1Jf
RklYRUQ9eQ0KPiDCoENPTkZJR19ETV9SRUdVTEFUT1JfTVQ2MzU5PXkNCj4gwqBDT05GSUdfQkFV
RFJBVEU9OTIxNjAwDQo+IMKgQ09ORklHX0RNX1NFUklBTD15DQo+IMKgQ09ORklHX01US19TRVJJ
QUw9eQ0KPiArQ09ORklHX1VTQj15DQo+ICtDT05GSUdfVVNCX1hIQ0lfSENEPXkNCj4gK0NPTkZJ
R19VU0JfWEhDSV9NVEs9eQ0KPiDCoENPTkZJR19XRFQ9eQ0KPiDCoENPTkZJR19XRFRfTVRLPXkN
Cj4gDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29t
Pg0KDQpUaGFua3MhDQpNYWNwYXVsIExpbg0K
