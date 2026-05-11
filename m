Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126AFCD37AC
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 12:51:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AF36845E3;
	Mon, 11 May 2026 14:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="LNWrBHeU";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="NkfiRA2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABF1884860; Mon, 11 May 2026 12:19:30 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FC9C847F6
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 12:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: dde3b67a4d2211f1a4e839cc21f16abe-20260511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=xLzUBrSz8V7nC0YvKwzFF8Gl3UGhj6K/VogCZ0ou1c4=; 
 b=LNWrBHeUSNNwQaAAB7VqQJ05ZDqtSdcPNsz+X4L1paPgvHG1XfvTlQyvncmT+wF9OquAA5/avzzki7L9PHTd2hb/7lqWcaXzjL9xitywaG8jUBy+PN29hSkMMzMgGAJ+nvSlUT8DCGR+rKLHUy8QyqmZ0kAxajpazX+HZr54ssQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:e40943c2-d782-43bf-bdcd-d2e959786028, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:87c66c45-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: dde3b67a4d2211f1a4e839cc21f16abe-20260511
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2021805226; Mon, 11 May 2026 18:19:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 11 May 2026 18:19:15 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 11 May 2026 18:19:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePD29UTN7ovXds3DXuGv8dd97NlLf8RgAksMN9WAwNt5S9IKOFFrttJNbcVypokykvfdwztoL/81Mj4M4jLXExSzzV/qm74PEfUHtfhyLyaJnYOwa4j3jr1NJi+D2cWOGPRSDKf4DgfsfhzJiUtxJ8wxa/XVM86SJpncmHfAXtJUEQP9uGqIy4saNTLOSNaHc6d6tRNZpevW63oTUQJbHNDvtCX4y5xxmweroHPYOy8OQrhE69DLAPGbg6jntAY7Gi0oDIRaFbyY4Fut7+Y6EVHTunwRP6jHlo86Qdi5vLqQD6cIrQi5sviiDvYj0f4PBcGEKnQNlwXbIPhx40pPAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLzUBrSz8V7nC0YvKwzFF8Gl3UGhj6K/VogCZ0ou1c4=;
 b=mL4BEu9n7nEi6tHLYtHbcursSkMCGkZwl33cP5wfiUuDxiIocXDJMjxzUompAsmTU9/Y2+Xp/b5bcVxhIi/IPY/u6MHun2+zobGeT+85BsANo0+FVzs8y199QXn4D6QE14dajgKG0w95QuySil7VwZCrBywLKzmxGz5lhzS6UiM856IiBQs5QW92c4W0UtVqgL5seShaM2zMk/fi7LMYSmoYwtlOWuLItNUP5cFyvGyhGwJLA8fQCvBApisvqRRoz4y6YzDX3VZktiPgGdZ57vQu2/EiADHAzvUbdUXXayvvaI2a+4tmGNLQOPdaufgK7p4SHA6eO46llBDSwK7bRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLzUBrSz8V7nC0YvKwzFF8Gl3UGhj6K/VogCZ0ou1c4=;
 b=NkfiRA2eL1XtaN7PMZ7OkT9xS6jQpSPmiBiw/vCfIFVramD9d9U8i81otoStyKhAvkfMutgYnUjfkwIJUzxPebIRhpY7pl72lCXP13Vmj3S6RzH6AlqMTYSULIqSx4vNfXDzhELOyuz1FeY6EQCBp7JlzpBNPCIbMJ6QkT70sNg=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYZPR03MB7790.apcprd03.prod.outlook.com (2603:1096:400:45c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.14; Mon, 11 May
 2026 10:19:11 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.21.0025.012; Mon, 11 May 2026
 10:19:11 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?TGFycnkgTGkgKOadjuejiik=?=
 <Larry.Li@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?=
 <Biao.Huang@mediatek.com>
CC: "philip.molloy@analog.com" <philip.molloy@analog.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "s-vadapalli@ti.com"
 <s-vadapalli@ti.com>, "jerome.forissier@arm.com" <jerome.forissier@arm.com>,
 "romain.gantois@bootlin.com" <romain.gantois@bootlin.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "patrice.chotard@foss.st.com" <patrice.chotard@foss.st.com>,
 =?utf-8?B?U2t5TGFrZSBIdWFuZyAo6buD5ZWf5r6kKQ==?=
 <SkyLake.Huang@mediatek.com>, "stefan.roese@mailbox.org"
 <stefan.roese@mailbox.org>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "heiko@sntech.de" <heiko@sntech.de>,
 "ycliang@andestech.com" <ycliang@andestech.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "pbrobinson@gmail.com" <pbrobinson@gmail.com>, "semen.protsenko@linaro.org"
 <semen.protsenko@linaro.org>, "mikhail.kshevetskiy@iopsys.eu"
 <mikhail.kshevetskiy@iopsys.eu>, "me@ziyao.cc" <me@ziyao.cc>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "ansuelsmth@gmail.com" <ansuelsmth@gmail.com>,
 "raymond.mao@riscstar.com" <raymond.mao@riscstar.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>,
 =?utf-8?B?S2V2aW4tS1cgSHVhbmcgKOm7g+alt+aWhyk=?= <kevin-kw.huang@airoha.com>, 
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
 "marek.vasut@mailbox.org" <marek.vasut@mailbox.org>, "sjg@chromium.org"
 <sjg@chromium.org>, "peng.fan@nxp.com" <peng.fan@nxp.com>, "root@infi.wang"
 <root@infi.wang>, "visitorckw@gmail.com" <visitorckw@gmail.com>,
 "robert.marko@sartura.hr" <robert.marko@sartura.hr>,
 "samuel.holland@sifive.com" <samuel.holland@sifive.com>,
 =?utf-8?B?VG9tbXkgU2hpaCAo5pa95piT5bu3KQ==?= <tommy.shih@airoha.com>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "lucienzx159@gmail.com" <lucienzx159@gmail.com>,
 "patrick.delaunay@foss.st.com" <patrick.delaunay@foss.st.com>,
 =?utf-8?B?WWFucWluZyBXYW5nICjnjovnh5XmuIUp?= <ot_yanqing.wang@mediatek.com>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>,
 "christophe.roullier@foss.st.com" <christophe.roullier@foss.st.com>,
 "michael@amarulasolutions.com" <michael@amarulasolutions.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "kory.maincent@bootlin.com"
 <kory.maincent@bootlin.com>, David Lechner <dlechner@baylibre.com>,
 "jonas@kwiboo.se" <jonas@kwiboo.se>,
 =?utf-8?B?RmFueWkgWmhhbmcgKOW8oOmAuOW4hik=?= <Fanyi.Zhang@mediatek.com>
Subject: Re: [PATCH v4 7/9] net: dwc_eth_qos: Add mediatek support
Thread-Topic: [PATCH v4 7/9] net: dwc_eth_qos: Add mediatek support
Thread-Index: AQHc1+B2ebAVs/BqpkqrmgG5pJMhorYIr3UA
Date: Mon, 11 May 2026 10:19:11 +0000
Message-ID: <8c5c2455c0db60128f8c2e091f29cb8cbbd72435.camel@mediatek.com>
References: <20260429-add-ethernet-support-for-genio-520-720-v4-0-be54e17239b7@baylibre.com>
 <20260429-add-ethernet-support-for-genio-520-720-v4-7-be54e17239b7@baylibre.com>
In-Reply-To: <20260429-add-ethernet-support-for-genio-520-720-v4-7-be54e17239b7@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYZPR03MB7790:EE_
x-ms-office365-filtering-correlation-id: 83f4f7e9-3772-4a52-fc17-08deaf46be9e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info: YzsfJwJbNYFT8LieP2C7BX6TZZ2wGYVrYW11TLIz6rYKwpPuLxynhyw00LhtQ+NMM4Q/gN6aXg/71zVM4Q6u0WhJRUcmJU3yRp2+WeXcTjBzG/qw203I2HRgbG3KVqShEWbYVo0go938W1A51+3kor9IWr27GVuXEOMcch09oLxhBIzH4yUZ4MaV7vEHitr1WAEfxnnEbE9U24bHJFrVeaRjUJ8H2sU3iAA9P9fuu7s4KLeH2aeKGwbSz8cKLOSu01FPQ9NQb1N7NyUTJAHzlMLQ79UfxeJNYKAJVkk3VPN0TDdu4hgxCfT8n4T8v8g6vZp+yQq2xTpA+1Y3xbtVHcByJd+/PC1/B56xc5p1Z7T380vKn1YA+nECc8Fk+DzqtsDzJxbzI0/78p4wbvAqvJ97tvaQVsLZ6msmvKXby97Nh6jvuH9vi2W024S+rItCp8emsOfPqIFK+AHTbz7tKHweYHj/qVy4JhihWHoV+YYhk/IINKTMZScQsIFFE7WN7yoOtVCl/9iaU4pQJUYdhZBgMCfPNQExFbaop84ZmYPqr5vyb8emVXSVsj1d0ibRLa+AkS/+oexC2nZnlAmpvb3DZvHXgERV8TwvPfZaStU4q1KH8AXJe39CjL6IGdlVlTgiW3UNKcw9WtzYdjVfqEK6NmnbIIlLLER9unwaJykqheYkHo0XJCuAuMTMiWIxVz98w91UISzOZOa22YUU8Vle/FWIanmGDOpTLjPqHCdBM4iCoa3xXOLnzXOsxX/j
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjVwR2p4OXRNUmpWQTl1dWVxc28zU2U5eXdOZk03S2U5WXlrL20xaVhZZ1Rv?=
 =?utf-8?B?RnVIYnpobncwLys4ckp3dUFQeWJXVHNVemsrOE93VEJIdmQ5N3JZVUNBTUQx?=
 =?utf-8?B?eVRRRGNOZ3p3Z0tkUHp3bnJWOUdKWWl4ZkVaQU90UkY5Z0ZqdGo3SjhabExN?=
 =?utf-8?B?QnpTYXVvL3Y3QS9hVnNQN250VzgzUHFJZUZYK0s0R3Z4anY4TzhSV1lZVkkv?=
 =?utf-8?B?aUhSQXNlQ0ZqdGtmSFJIVlhPWVdsTzJadmQ5K0dOcEwwUUdFc2p4Wko1N0Np?=
 =?utf-8?B?ajM0OE1uRzArdUZpa3RBUzJYSVMweCtEc0dKNU1GbXI0c3BYeUpvbXJ6RFhY?=
 =?utf-8?B?QkRDdmI2Vmx6SHQvblN3eTR2RERIYXJZSEFQMytCaXZadU1zZC9yeW96R3dR?=
 =?utf-8?B?VHlkd0Y0WUN2MFlZMFVTQ2pxakliMjFZeE9SVXVCck93czBuTVhQNlpaYm1D?=
 =?utf-8?B?Y3o3Q3BZM21qMFlHMjNIVGVsVTJMZ0xYcFBBZ0g4SkNBeFQ1anNaTktjYk4v?=
 =?utf-8?B?T2JhSHVYR1BHYndmS1pFQ3ZRSU5vaXlUTCs0WUFQZTQrNnBZamEzUmppNEdL?=
 =?utf-8?B?RFVzZGwvSnNtZHluSlI3elJUWm1vcDdWOGlsUlJibzlHR3ROZm1kbHJZVnc5?=
 =?utf-8?B?RWlvMFVZTjU4MFF6YVQzMVQ1NWxVV0dVSFY4a1l6QklWeHVGUyt1WkdLWElL?=
 =?utf-8?B?TVBsMmRkVlJGMWNRYTBQODhobDBoWGhPdS94ZmNIb3V1K0xKNGdSUGI5c3ha?=
 =?utf-8?B?elFZekpXZWtsMDN5dGlldHF4NS9ZTTMzNDZHUWJsYzZCY2dEOXZudlZXWWc4?=
 =?utf-8?B?NjhjZjM1dkl2dkk4ODk0THpRVFVobzBEU0JFOEQwaVdLQTh4YWhMTVNqWmdz?=
 =?utf-8?B?OGJEZ3ZYa00rNDVFcWwzcG0rVXZWSE02dlNobno5dkY2MVhVeDY3eG1KWGQy?=
 =?utf-8?B?RHVsT01xbldiUTNveC85bmo1dGhGOUd3aWlwalNsNEdYak1MR1g4c2hMTWdJ?=
 =?utf-8?B?RUN4djJqRFQwb1NwRmRGa3pmMXQ1ekF3ZDZmY0dTWHVYY3pRRXFMV0NwUUFh?=
 =?utf-8?B?bGJvbEtqcmNXbUlsZFdlU0VWSTA4T25UTEpOa3FRa2RPamEwT1pjYWxKOFJM?=
 =?utf-8?B?TkVqRldLN3ZZL2N4Ky92amY4cTd0bWtWTVRPMk1pMHlRTDNHUUV3RTZ1eFo4?=
 =?utf-8?B?a1JjWnFoR3V2czdKalhVYXJYSmZKV3RXM210S0t4SDR3dXRGYis0YmNqcnJN?=
 =?utf-8?B?Zlh5QVgwS25qc1c1Yk9hVjV2WUxDeVZ5dDFmdFJWbGpXb0lYaEs0aUQ2Ri85?=
 =?utf-8?B?Vm85VkJtZUd3a2hJMUkyYlJzTWhISXBRcG1sRk84eEk0Q3EzVThadHJZVnZD?=
 =?utf-8?B?STRIZXc0cy85dWVQeU5lYWREeUtCTFpzYnMwNHFYdGZFY1VPMTJrRnVyeC9q?=
 =?utf-8?B?YjBxY0c2VlJGQzZNQ0J0N0pkTVpPUVVCWHhIKzQ3ZWhFSnJwcnljUzcxdnVK?=
 =?utf-8?B?SmUzdWg4N0NDcEV6Y0F5L1NTeUhzVS81dzR4aWNvNlN6MDlUOFNmZ2pNZTlR?=
 =?utf-8?B?SWliOGZOL2JtRThRQU9TcnpyUEFjT0lZTkZmL1ZQbGwxZXZjQ0xoVml3WGl6?=
 =?utf-8?B?NGJyS3ZRR1VjajNxQ2N2eHoweHZnWVg2dG5kak9wT1plTzB3dnZiTFNZKzBO?=
 =?utf-8?B?b3RFaHA5Sks2c0dTQklqamIycXpGMEhTcFRsUk90QXljTUZoWjdaanVIV2RN?=
 =?utf-8?B?TUNDN3NUbkF2NU1DWHU3UUZLOXdzcFNPM3dWTUlhU1dJUWxSYW5nM1d3bVh6?=
 =?utf-8?B?RnNZTm1xUWhjM1hDTkFIRVJJTVUwMWVKZmR0d1A1TFNSR1hsRFQwZVA2SUcy?=
 =?utf-8?B?dEk2MW13SmhKeWRaazcwN0xOS0FoVVVrT2pQV1hxTmtNcGFtSGtHdDczVWxu?=
 =?utf-8?B?Nys5S3h1MThVOUpRUEsxdnJBU294ZlBxaDZQcGY0R1JTSUY0QjcxNDZUMFo4?=
 =?utf-8?B?UG52YyswSDJ1aDRYY0prNCtHeVBLUU9mZmVkMGwxTzFoMlpnYWZNOUVsQUc0?=
 =?utf-8?B?WUpLWXFVZHY5WkF1bWxUb3A2SDUyZHRxTWNUQlk5cFI4NkVHSU00N3MzUEtv?=
 =?utf-8?B?Qm5ieTVCV2t4MDBkRW9LNkZVRmN1bVhxWWdoamJTTll0OG1JMXNhb1lNVlRk?=
 =?utf-8?B?eG1SWE5FMkpKUFNleTlJZWp2QURhYi84czcyTU9TNUtKZFpYVVg2c3dJOU85?=
 =?utf-8?B?VnB5cjFaZDhtM3JDYUF2c0k4OG5GR0pKdjRVOVcxenJWV1ArYUNSbk5MOGdn?=
 =?utf-8?B?M0MzaUlQYjdhMi9KeC8rdDNsV1lMLzYzS0RUUUthc21XVGhYWHVTaDhNRjRt?=
 =?utf-8?Q?Vfp+Z7Hs+7coEG8I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C8B4BF0A958ACE4B80007F0333B27830@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: uXQLFiFexEoNFJEc9DZb3C82E80hx7As4jlg9vdhoKjNVjslZTSm9M6N5bEgFrzWTQng39osop30RK0pckqK3xac3ITppg+WAbCArk+qPrG6djZUwIv9QijPpgDLGaJJBjo/LOgPE+Rb7aCr/wFOX5LkteS/vWZcQvHwOK+xyCiMwhB2Ubrhn8oMYMi4Z3mdzznTYWtkX2kGs51gn4sdjO3fYGwrGhyZoOmn+Up3jQJAndYLQEXFlie7nAwztnUWWOPBNc8oQnPEX1TIA916cZOr2tA0tR0US7ePfkYWeRZ8tSogwxarVCs+28YfX97fCZXBtj7+2eQAFH+6WZbDtw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f4f7e9-3772-4a52-fc17-08deaf46be9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 10:19:11.3429 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4vSurAiNT9MejUngkv8/EG/PllEO7ayAGdMiaGPMfDfYFsnQddOm/B/HeTwlwmsS4Ld6aTUIX64S8uZSlVWgbz32JmfjPiwECY4wbFWp9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7790
X-MTK: N
X-Mailman-Approved-At: Mon, 11 May 2026 14:51:08 +0200
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

T24gV2VkLCAyMDI2LTA0LTI5IGF0IDE1OjU5ICswMjAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gU3lub3BzeXMgRFdDIEV0aGVybmV0IFFPUyBkZXZpY2Ugc3VwcG9ydCBmb3IgTWVkaWFUZWsg
U29Dcy4NCj4gaW4gcGFydGljdWxhciB0aGlzIGluaXRpYWwgY29tbWl0IGFkZHMgc3VwcG9ydCBm
b3IgR2VuaW8gNTIwLzcyMCBhbmQNCj4gR2VuaW8gNTEwLzcwMCBFVktzDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBmYW55aSB6aGFuZyA8ZmFueWkuemhhbmdAbWVkaWF0ZWsuY29tPg0KPiBTaWduZWQt
b2ZmLWJ5OiBKdWxpZW4gU3RlcGhhbiA8anN0ZXBoYW5AYmF5bGlicmUuY29tPg0KPiAtLS0NCj4g
wqBNQUlOVEFJTkVSU8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAx
ICsNCj4gwqBkcml2ZXJzL25ldC9LY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNyAr
DQo+IMKgZHJpdmVycy9uZXQvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMSArDQo+
IMKgZHJpdmVycy9uZXQvZHdjX2V0aF9xb3MuY8KgwqDCoMKgIHzCoMKgIDYgKw0KPiDCoGRyaXZl
cnMvbmV0L2R3Y19ldGhfcW9zLmjCoMKgwqDCoCB8wqDCoCAyICsNCj4gwqBkcml2ZXJzL25ldC9k
d2NfZXRoX3Fvc19tdGsuYyB8IDQ0Mg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysNCj4gwqA2IGZpbGVzIGNoYW5nZWQsIDQ1OSBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRleCAxNjU5OTRj
ZDcyZi4uOWI2NWJiNDNkOGYgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01B
SU5UQUlORVJTDQo+IEBAIC00NDIsNiArNDQyLDcgQEAgRjoJZHJpdmVycy9jbGsvbWVkaWF0ZWsv
DQo+IMKgRjoJZHJpdmVycy9jcHUvbXRrX2NwdS5jDQo+IMKgRjoJZHJpdmVycy9pMmMvbXRrX2ky
Yy5jDQo+IMKgRjoJZHJpdmVycy9tbWMvbXRrLXNkLmMNCj4gK0Y6CWRyaXZlcnMvbmV0L2R3Y19l
dGhfcW9zX210ay5jDQo+IMKgRjoJZHJpdmVycy9uZXQvbXRrX2V0aC8NCj4gwqBGOglkcml2ZXJz
L25ldC9waHkvbWVkaWF0ZWsvDQo+IMKgRjoJZHJpdmVycy9waHkvcGh5LW10ay0qDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9LY29uZmlnIGIvZHJpdmVycy9uZXQvS2NvbmZpZw0KPiBpbmRl
eCAxNWE0YjNiNzcwNS4uY2Q4Njg3MzFkMTEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L0tj
b25maWcNCj4gKysrIGIvZHJpdmVycy9uZXQvS2NvbmZpZw0KPiBAQCAtMjQ2LDYgKzI0NiwxMyBA
QCBjb25maWcgRFdDX0VUSF9RT1NfSU5URUwNCj4gwqAJwqAgVGhlIFN5bm9wc3lzIERlc2lnbndh
cmUgRXRoZXJuZXQgUU9TIElQIGJsb2NrIHdpdGggdGhlDQo+IHNwZWNpZmljDQo+IMKgCcKgIGNv
bmZpZ3VyYXRpb24gdXNlZCBpbiB0aGUgSW50ZWwgRWxraGFydC1MYWtlIHNvYy4NCj4gwqANCj4g
K2NvbmZpZyBEV0NfRVRIX1FPU19NVEsNCj4gKwlib29sICJTeW5vcHN5cyBEV0MgRXRoZXJuZXQg
UU9TIGRldmljZSBzdXBwb3J0IGZvciBNZWRpYVRlaw0KPiBTb0NzIg0KPiArCWRlcGVuZHMgb24g
RFdDX0VUSF9RT1MgJiYgQVJDSF9NRURJQVRFSw0KPiArCWhlbHANCj4gKwnCoCBUaGUgU3lub3Bz
eXMgRGVzaWdud2FyZSBFdGhlcm5ldCBRT1MgSVAgYmxvY2sgd2l0aCB0aGUNCj4gc3BlY2lmaWMN
Cj4gKwnCoCBjb25maWd1cmF0aW9uIHVzZWQgaW4gTWVkaWFUZWsgU29Dcy4NCj4gKw0KPiDCoGNv
bmZpZyBEV0NfRVRIX1FPU19RQ09NDQo+IMKgCWJvb2wgIlN5bm9wc3lzIERXQyBFdGhlcm5ldCBR
T1MgZGV2aWNlIHN1cHBvcnQgZm9yIFFjb20NCj4gU29DcyINCj4gwqAJZGVwZW5kcyBvbiBEV0Nf
RVRIX1FPUw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvTWFrZWZpbGUgYi9kcml2ZXJzL25l
dC9NYWtlZmlsZQ0KPiBpbmRleCBjNDg1MDY4ZTVkMi4uNzYxZjdmMGY0NTEgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvbmV0L01ha2VmaWxlDQo+ICsrKyBiL2RyaXZlcnMvbmV0L01ha2VmaWxlDQo+
IEBAIC0yMSw2ICsyMSw3IEBAIG9iai0kKENPTkZJR19EV0NfRVRIX1FPUykgKz0gZHdjX2V0aF9x
b3Mubw0KPiDCoG9iai0kKENPTkZJR19EV0NfRVRIX1FPU19BREkpICs9IGR3Y19ldGhfcW9zX2Fk
aS5vDQo+IMKgb2JqLSQoQ09ORklHX0RXQ19FVEhfUU9TX0lNWCkgKz0gZHdjX2V0aF9xb3NfaW14
Lm8NCj4gwqBvYmotJChDT05GSUdfRFdDX0VUSF9RT1NfSU5URUwpICs9IGR3Y19ldGhfcW9zX2lu
dGVsLm8NCj4gK29iai0kKENPTkZJR19EV0NfRVRIX1FPU19NVEspICs9IGR3Y19ldGhfcW9zX210
ay5vDQo+IMKgb2JqLSQoQ09ORklHX0RXQ19FVEhfUU9TX1FDT00pICs9IGR3Y19ldGhfcW9zX3Fj
b20ubw0KPiDCoG9iai0kKENPTkZJR19EV0NfRVRIX1FPU19ST0NLQ0hJUCkgKz0gZHdjX2V0aF9x
b3Nfcm9ja2NoaXAubw0KPiDCoG9iai0kKENPTkZJR19EV0NfRVRIX1FPU19TVEFSRklWRSkgKz0g
ZHdjX2V0aF9xb3Nfc3RhcmZpdmUubw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHdjX2V0
aF9xb3MuYyBiL2RyaXZlcnMvbmV0L2R3Y19ldGhfcW9zLmMNCj4gaW5kZXggMGYzMWQ2NDY4NDUu
LmI3ZTYyOTljMzA3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kd2NfZXRoX3Fvcy5jDQo+
ICsrKyBiL2RyaXZlcnMvbmV0L2R3Y19ldGhfcW9zLmMNCj4gQEAgLTE2NTgsNiArMTY1OCwxMiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IHVkZXZpY2VfaWQgZXFvc19pZHNbXSA9IHsNCj4gwqAJCS5j
b21wYXRpYmxlID0gImFkaSxzYzU5eC1kd21hYy1lcW9zIiwNCj4gwqAJCS5kYXRhID0gKHVsb25n
KSZlcW9zX2FkaV9jb25maWcNCj4gwqAJfSwNCj4gKyNlbmRpZg0KPiArI2lmIElTX0VOQUJMRUQo
Q09ORklHX0RXQ19FVEhfUU9TX01USykNCj4gKwl7DQo+ICsJCS5jb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE4OS1nbWFjIiwNCj4gKwkJLmRhdGEgPSAodWxvbmcpJmVxb3NfbXRrX2NvbmZpZw0K
PiArCX0sDQo+IMKgI2VuZGlmDQo+IMKgCXsgfQ0KPiDCoH07DQoNCltzbmlwXQ0KDQpSZXZpZXdl
ZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0K
TWFjcGF1bCBMaW4NCg==
