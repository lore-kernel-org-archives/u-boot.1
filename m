Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CF9EBFD1C
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 08:56:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 59D97836AC;
	Mon, 13 Apr 2026 10:56:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Y2ILjX/Q";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Tt6YA6c/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D39D839DF; Mon, 13 Apr 2026 10:56:24 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38A118352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 10:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 9e789680371611f19a16598d5ca7f8ec-20260413
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=w9m2CYWWU7YavZl85jpkA2rvw5Yg7LvX7Go0JNpImis=; 
 b=Y2ILjX/Qw5g6I7BqXiT1PyUltk02okypcSioyBnPwcWyjs1t+k+wk/aCUTq2NWt10MpHYRVxM4mTLEbZu3uHvvjQZevKzip+E932b4QMeR1d6NGTjH9hiDYyh9woBMalmGD5xDm2t6YH5bxWDPpavUGy99UdX5YR6RpK0S6y2Tg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:734318e0-f7aa-4cfc-bff8-532c60364994, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:863a5c8f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9e789680371611f19a16598d5ca7f8ec-20260413
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1854506071; Mon, 13 Apr 2026 16:56:11 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 13 Apr 2026 16:56:10 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 13 Apr 2026 16:56:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MDDgR5ldE2B1nkWyX930DD/GMSYk7D3zy8JoMIbr1UZ+O8Gc3Omp7Gefv/syA2J+/yJjP14K3whC4oSw/LfK5Irv0cVnZtSjLfFx8/qNmS9edccSkpYcOcOcIApUk/nrlQWw1oOJBeoEu2z1Nu2RDspgEt2U7OVPzWilSmcIl2mZ+uNyuNt2LFbgN0bCBAQ0d2DX8eIJaofO1BERX4MelMsVZ0qtc950F3YslHKqx1zVWOffFQZ+Ez7JdgA6uEumOGMXCU4S+MLCgl+Ct7n3Ps0ZQrAtl15AAzX1DOY7IgowNtgTuzMgtwzENLsB4A2nu2zXySFQphEMv5koUp+gmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9m2CYWWU7YavZl85jpkA2rvw5Yg7LvX7Go0JNpImis=;
 b=UMT44iCs2RKYMo1rBAa7lKnFuU8sWVPPHqAtEA52kjdIMKjwnDnu5MD+S/Pj3+fhjcU8M9YmF59Xn1ePatz15NK81ZsxHN+4+cjWEPh8phT2FcNh8pwSa1mMKRpH8+KO1afDr0kx0SsvJ04d3D7uLd/vdiPvWp0jOr4DSAkVb0a/UukN7JHWBUJV4aLOIs4ROhRTJ1mSggNJzz0Iz6DgGH/wfKlepJV7O1fEVuPtVZx0h0n4yjZC7UYA4HZIOybIwjvZUcGvYZ+FfyK0NC9zjALYENmpdB8uXKXI2uhBjelnKhRkYn0LJNP365/suuAKzQj/C1kStQeAVGW0u86Yrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w9m2CYWWU7YavZl85jpkA2rvw5Yg7LvX7Go0JNpImis=;
 b=Tt6YA6c/Yr5EpN5D11mNhReoXKCZzkdy3q0GLCK1lZ9xOrbBEoqirSWku7FVRF26QbGcwTwV6AIm+mw1V8MH6Zjw1/TCGxGDO3H9VnzRsoJO+UbIN/1yZF8+CIEtEkJY39xqUOxyeX+GVM3kvhGT1MfYGRs18nb2zTzNYx4F2QY=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KU4PR03MB9855.apcprd03.prod.outlook.com (2603:1096:d10:7b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 08:56:07 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.046; Mon, 13 Apr 2026
 08:56:07 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "jh80.chung@samsung.com" <jh80.chung@samsung.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?SmlsbCBDaGFuZyAo5by15paH5r2UKQ==?=
 <Jill.Chang@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>, =?utf-8?B?S2V2aW4gU2hlbiAo5rKI5a6P5r6kKQ==?=
 <Kevin.Shen@mediatek.com>
Subject: Re: [PATCH 2/3] power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
Thread-Topic: [PATCH 2/3] power: pmic: mtk-pwrap: add PWRAP_CAP_WDT_SRC flag
Thread-Index: AQHcvhySjRUmAKWJkEOnDSVFjGle+rXcyoAA
Date: Mon, 13 Apr 2026 08:56:07 +0000
Message-ID: <c166c23553a12171d3d0850ab882bd4d353f2c5c.camel@mediatek.com>
References: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
 <20260327-mtk-pmic-fixes-v1-2-ef874ca82409@baylibre.com>
In-Reply-To: <20260327-mtk-pmic-fixes-v1-2-ef874ca82409@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KU4PR03MB9855:EE_
x-ms-office365-filtering-correlation-id: 02993920-03c8-4bfc-fac7-08de993a805f
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: DE/E2oNmVJ+eAGTzFL01COy7TI72gqvwIN8XwbHt4BMSfFQG/9+qGp5JzfICNwvGOBAmbbSjw9WI24aIuj8+4hAXZ2hWjbOY9Bi9TUSR8mS2vzo4nARFaHPjdfRm0ZktmJOpPfofoRNV/r6BL3XGc6Azgl2+vaWc6J/9CT20i6RuSB728DFBcysGjTZEkY1RknHnMDODsBjWS6M7tqu++kSfvxBzofwiiX5yS55aJnppB+AVZfs+b3szbnJl3khs4hxh49JS8TNtsVfVHAtv+2u3D57ReEOQVhnNN6ROP75PPEbOMeFEYZb0FM4owbREz1eWj8kjc0Swwmx0Yl3N6uLxK6AY9DeddPjGD/Ab+4OhXR44cmJ7WZKSibBfx7qC7A1T/L/ZTE2QfEvGZ4iOPmKZfwXy56bO+eOXiz/3KuPXJpYwvkV/dnOPYBkfr/gliH/y1g3xVWGySccIXkeMIelrkkB18dtyBwEFwJmuP3bATAcKxh0wk6MClS4N3JHy90THBuohN+nWirLnROP69fSxPTry52sJD2Kffom+yFXg0fwtN1RW7jOwluobwm264/1PRo2CpiqJDC/ZGRMtr9yWRRUc6dLTJPilkiwalbv96Hwdbd0vily/6DYsvqySr7lOGurwoOBUfRJcqR25d77q8YTnNI6gLcYYG35lgiZLsbyrErvrHHvZCb5EkvNOC8q5hjlMUSW/h7A2iPTx44/AQ1aE+f8qKnQo8SvJ4bV28qTE5P1KLZFjGW8thc/kiU0rZwfya14sr33lH3yZ8DY2fbWh0Y1qpTpe6EgpRVk=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3dYenprSGFUZUl5ODd3VW45RjYrdzJFVzFyeGR4b0ZmSFZpam02eXVrQ01N?=
 =?utf-8?B?TjNubW1mOWtPcVMxSGNjQm9IcmNxZVhwamozWUh2UDFHeE82VUxzMCs3Zko2?=
 =?utf-8?B?Q0VNU1BaV0RCVFZaY2Z1Rk5uRDJ6UklyS2hKTzlWaS9sazdqcW5LemJnZDVx?=
 =?utf-8?B?Q3FnM1VEV05NUktKV2lDODl5dTJuUmQ3dFhWNTA0SnNpNFZvUEM1SFlpbktj?=
 =?utf-8?B?RkpidFpuVU8wanRFa01Ya1dhRW9FKzhQeDBFd1dpTzVxdFl1WTdPMm0rcWJk?=
 =?utf-8?B?OGlPbHdNN0s4T0xRQnFxSldNendKZW1OWEU3MTlMNWZ5K2ZxMXNEbTJpaUxQ?=
 =?utf-8?B?NUFHNGNBOFpISC8zb0FQMUIrWlNwSTI4bmJYckdwR2V3U0ZwRGsrRytQQnhj?=
 =?utf-8?B?QlJTUXl2Nnk2dURTNXlkQkdld1NYbVJ3WnhZb2I1OVpIQmdkTzIwV3FiOGw2?=
 =?utf-8?B?NU8xRDZnbjN2QWc2UVFadGIya0JOdzVGVkdtcUJWRnZ6UkVrZTM5TGNnSEN2?=
 =?utf-8?B?UzRyeXhJNHZia1gvV2RIUUh1VExGdWJsYkg2OWlUeVZod1V4NnBCY1VIUW1u?=
 =?utf-8?B?NHA2cjFRN2ZWZlc2Rk5oUHZ0S0w1UDJuVjN6SCtucUVabGJRR09kTC83V0RW?=
 =?utf-8?B?UkNZejhBbUx5YS9xZUVFblhWay8rSkpkR0xIeVFMbFpxU1ppUmNEeUxjSW9M?=
 =?utf-8?B?aDZhM21SeHBTQmlLMXExOFkrTnd6TExQQXVCS0ZKT0x6bzZYS2JGZGZEdmcw?=
 =?utf-8?B?T2JQNmVOTFB2UHlqMHljM240K1lsNENWcHRzTm9ycE9QVGZvRWNYb2lPalFK?=
 =?utf-8?B?VFBqa3VHTStCSjViamo1VDR0NFlScmJwV3dCb3NEYlRXUko5dzJJK0xabTdK?=
 =?utf-8?B?NXdtbFNzRlJJZUdmMTFWbjNxaU1NKzBKNmZOS1loaFBPUVAvOFhQZDBwUzVx?=
 =?utf-8?B?NGVPcEdRMXgyZXJDZUhPdWFrSTIzVHowdndMREl2RVNrWjZyUDdTNzJJYm8w?=
 =?utf-8?B?ZDkwdXlLOWovVitRRCtMNURFdEp5Rys3WDliQ3NqUHJZUno3ZWNDOE8wa2o2?=
 =?utf-8?B?MGJIc2tjcWtoMkJoNGtleWtpTDdIVDZuaUVDL24yUG1sTDROb0ZSZ0lyTWFi?=
 =?utf-8?B?M0pmUjcwNEJPVGp5RVQ4K2JkLzd2Vm5RNW14NFE3NVFLWHhKeEJuRDZSVmJU?=
 =?utf-8?B?ZG5wU05OaTJrMGlxWURlZmVrT3pNbU5hbjA0Qm5waGdma0R3dlhiTGF1NnAw?=
 =?utf-8?B?aERib1d6SmhNcS9xQTJhRERUSjY5eTlEeTVLZ0FmR09CTS8xYW1JT2h3Wk9L?=
 =?utf-8?B?SHVjRjFPaTJCREpaNkVqVVBKNFhleGRpWFF0VUVSZGh4bGZzR1RiQmN3OGVW?=
 =?utf-8?B?M1BvbFVoN1RRNlREV08vdnNjbEpvbklYejA4YWUrV2VRTEpOWldSbE12YWJu?=
 =?utf-8?B?VGZFTk5na1NOQkFvVEJHbVozVzFTeXBCY3BKUWxDc29oOGxUTHlwSU5jR0dx?=
 =?utf-8?B?UnB3V0lsYXJybGRtUGQzY1J3amRoWVJnb21YNy9XVUJ4WElIR3dQNFdkZ3RK?=
 =?utf-8?B?cFJoQ1owZU9NVGw1SzEvUmdCK29NMXU2c0NHR1lSR21LNC9EYWJzdGtGK3hi?=
 =?utf-8?B?ekozcDFEWnJMSVIxbkJJemE1Ukl2ZUdQcGkvY3lQaHhvOGZJU2tQSm0xdTFQ?=
 =?utf-8?B?NWV4Y0daTTZ3Rmw1K2J2R2JlcC9BbmUxRmU1R05XM3FsZHlORFNwMWNrNGlM?=
 =?utf-8?B?VVJEYXltTVpiVUVISGx0UWRJaWUrU2NJRUx6cDVGS2JZVnNXOGl5N2FKN21a?=
 =?utf-8?B?ZStzTFRBbU9tbUJvL1M3M2dhcWhLdnB3Y0l6UEhBQ1hYTFFIRUcxSG9nZDlL?=
 =?utf-8?B?bTRvQnZ4N2VVS3JqU3hqWGVYUzhCVzluNDU2dksxd2RIQnlhMDdpNjhaVnlL?=
 =?utf-8?B?SGc5M28wWlZYeXlsOXNmM3lGdE9EMnVFNHl4K0hFTjZaRXNwaDJ4bTVUR3c1?=
 =?utf-8?B?WVJzK1J2STZvZGwvSytmeUdnb0pIcUx0aTkxU2psSGo1dzVWN1kva1NxbTFp?=
 =?utf-8?B?NURMQm9rajJ0a3AxcnNMRXo0OVF0eWk1SkVlbUVzUmJGNUFBOGI4SW9XZlc1?=
 =?utf-8?B?TXpadHdMT2wvRHhFMU1hMXczMnZLOUliUmcyQzJmcHlrOHR5bUNGVFFoUWFT?=
 =?utf-8?B?cUxWYkpBNHNlUS9GNGlEV0FtdGZtMjRrdlVIMnZvQjFaL3RTczJUOVRZckF6?=
 =?utf-8?B?cCtod3FsQUxMNHkrRXFWQldWL3dwcy9Lby9udStCbE1sZVdUNUxjbGUxaEp6?=
 =?utf-8?B?UDBxZTRiU0xUWmJzK1p6YTdQL1JmWGtOeGJzcjhDS3o4VFd5R3ZiTUZvSU1w?=
 =?utf-8?Q?M+VaYYYLp242fBm0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6A0F5607AC2384B841AFC5F3C3DEA32@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: pySnyS9UDV/CIjxlhvkjRLew2b/A907WJfR8mwtO5oZe6jze3rpQYig8mSBuxueLJhk3+Xe4LB4Gkvrzhe1ogLl8ezp+9wpbYzvruGZBBU9/Sk6PqzNAOepvskW/+nTruzUevEb4kL9S7rfH80PfmqYf199zgb6r7m5WSy6sxKK3/oFNEukVi+JCCaQNwXEClcbQgw3i0EESFgqo/C0EyWorboXa6F0qoKcxaARRsZI65WFCk/WciiOdOjmP2tmwa5XUA4rKhFXJsHHXOqgmbyr5cj0Xa5ncCSMfrddHQFyCc3iP+4H7Hmdp5JjcKM0X5n7mEQa0hIWjhLMf0MSwJg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02993920-03c8-4bfc-fac7-08de993a805f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 08:56:07.3531 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGpbz2zU6E1lJgY1+4Eo/a/8VpqX1owRg+h9tSYKQq5hzf7bdFMmNRbgIcSdJIFBxzORdV74F2JNZ3nz6yW9lb9E/GQbXrD+kUCAdg5WmAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU4PR03MB9855
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

T24gRnJpLCAyMDI2LTAzLTI3IGF0IDE0OjAzIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgYSBQV1JBUF9DQVBfV0RUX1NSQyBmbGFnIHRvIGluZGljYXRlIGlmIGEgUE1JQyB3cmFw
cGVyIGhhcyBhDQo+IFdEVF9TUkMNCj4gb3Igbm90LiBUaGVuIHVzZSB0aGlzIHRvIGNvbmRpdGlv
bmFsbHkgZW5hYmxlIHRoZSB3YXRjaGRvZyB0aW1lci4NCj4gDQo+IFByaW9yIHRvIHRoaXMgY2hh
bmdlLCBzaW5jZSB0aGUgcmVnaXN0ZXIgd2FzIG5vdCBkZWZpbmVkLCBpdA0KPiBkZWZhdWx0ZWQN
Cj4gdG8gMCwgc28gdGhlIHdyb25nIHJlZ2lzdGVyIChET05FMikgd2FzIGJlaW5nIHdyaXR0ZW4g
dG8uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJy
ZS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvcG93ZXIvcG1pYy9tdGstcHdyYXAuYyB8IDEyICsr
KysrKystLS0tLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wb3dlci9wbWljL210ay1wd3JhcC5j
IGIvZHJpdmVycy9wb3dlci9wbWljL210ay0NCj4gcHdyYXAuYw0KPiBpbmRleCA5ZmYwNmZkYjNi
ZC4uZDg0OTg2NDY5MjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcG93ZXIvcG1pYy9tdGstcHdy
YXAuYw0KPiArKysgYi9kcml2ZXJzL3Bvd2VyL3BtaWMvbXRrLXB3cmFwLmMNCj4gQEAgLTYwLDEw
ICs2MCwxMSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBtaWNfY2hpbGRfaW5mbw0KPiBtdDYzNTlf
cG1pY19jaGlsZHJlbl9pbmZvW10gPSB7DQo+IMKgDQo+IMKgLyogR3JvdXAgb2YgYml0cyB1c2Vk
IGZvciBzaG93biBwd3JhcCBjYXBhYmlsaXR5ICovDQo+IMKgI2RlZmluZSBQV1JBUF9DQVBfSU5U
MV9FTgkJQklUKDMpDQo+IC0jZGVmaW5lIFBXUkFQX0NBUF9XRFRfU1JDMQkJQklUKDQpDQo+IC0j
ZGVmaW5lIFBXUkFQX0NBUF9BUkIJCQlCSVQoNSkNCj4gKyNkZWZpbmUgUFdSQVBfQ0FQX1dEVF9T
UkMJCUJJVCg0KQ0KPiArI2RlZmluZSBQV1JBUF9DQVBfV0RUX1NSQzEJCUJJVCg1KQ0KPiArI2Rl
ZmluZSBQV1JBUF9DQVBfQVJCCQkJQklUKDYpDQo+IMKgLyogVG8gaW1wbGVtZW50IHRoaXMgY2Fw
YWJpbGl0eSwgdGhlIHJlZ2lzdGVycyB1c2VkIGluIHB3cmFwX2luaXQoKQ0KPiBtdXN0IGJlIGRl
ZmluZWQuICovDQo+IC0jZGVmaW5lIFBXUkFQX0NBUF9JTklUCQkJQklUKDYpDQo+ICsjZGVmaW5l
IFBXUkFQX0NBUF9JTklUCQkJQklUKDcpDQo+IMKgDQo+IMKgLyogZGVmaW5lcyBmb3Igc2xhdmUg
ZGV2aWNlIHdyYXBwZXIgcmVnaXN0ZXJzICovDQo+IMKgZW51bSBkZXdfcmVncyB7DQo+IEBAIC03
ODAsNyArNzgxLDggQEAgc3RhdGljIGludCBtdGtfcHdyYXBfcHJvYmUoc3RydWN0IHVkZXZpY2Ug
KmRldikNCj4gwqAJICogU2luY2UgU1RBVVBEIHdhcyBub3QgdXNlZCBvbiBtdDgxNzMgcGxhdGZv
cm0sDQo+IMKgCSAqIHNvIFNUQVVQRCBvZiBXRFRfU1JDIHdoaWNoIHNob3VsZCBiZSB0dXJuZWQg
b2ZmDQo+IMKgCSAqLw0KPiAtCXB3cmFwX3dyaXRlbCh3cnAsIHdycC0+bWFzdGVyLT53ZHRfc3Jj
LCBQV1JBUF9XRFRfU1JDX0VOKTsNCj4gKwlpZiAoSEFTX0NBUCh3cnAtPm1hc3Rlci0+Y2Fwcywg
UFdSQVBfQ0FQX1dEVF9TUkMpKQ0KPiArCQlwd3JhcF93cml0ZWwod3JwLCB3cnAtPm1hc3Rlci0+
d2R0X3NyYywNCj4gUFdSQVBfV0RUX1NSQ19FTik7DQo+IMKgDQo+IMKgCWlmIChIQVNfQ0FQKHdy
cC0+bWFzdGVyLT5jYXBzLCBQV1JBUF9DQVBfV0RUX1NSQzEpKQ0KPiDCoAkJcHdyYXBfd3JpdGVs
KHdycCwgd3JwLT5tYXN0ZXItPndkdF9zcmMsDQo+IFBXUkFQX1dEVF9TUkNfRU5fMSk7DQo+IEBA
IC05MTIsNyArOTE0LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwbWljX3dyYXBwZXJfdHlwZQ0K
PiBwd3JhcF9tdDgzNjUgPSB7DQo+IMKgCS5pbnQxX2VuX2FsbCA9IDB4MCwNCj4gwqAJLnNwaV93
ID0gUFdSQVBfTUFOX0NNRF9TUElfV1JJVEUsDQo+IMKgCS53ZHRfc3JjID0gUFdSQVBfV0RUX1NS
Q19NQVNLX0FMTCwNCj4gLQkuY2FwcyA9IFBXUkFQX0NBUF9JTlQxX0VOIHwgUFdSQVBfQ0FQX1dE
VF9TUkMxIHwNCj4gUFdSQVBfQ0FQX0lOSVQsDQo+ICsJLmNhcHMgPSBQV1JBUF9DQVBfSU5UMV9F
TiB8IFBXUkFQX0NBUF9XRFRfU1JDIHwNCj4gUFdSQVBfQ0FQX1dEVF9TUkMxIHwgUFdSQVBfQ0FQ
X0lOSVQsDQo+IMKgfTsNCj4gwqANCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IHVkZXZpY2VfaWQg
bXRrX3B3cmFwX2lkc1tdID0gew0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNw
YXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwgTGluDQo=
