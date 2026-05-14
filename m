Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8EACD37AC
	for <u-boot@archiver.kernel.org>; Thu, 14 May 2026 02:21:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D67B8467F;
	Thu, 14 May 2026 04:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="QWik7/WG";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="aghqxQSf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 211F684687; Thu, 14 May 2026 04:21:05 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C1C684676
 for <u-boot@lists.denx.de>; Thu, 14 May 2026 04:21:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 89df10404f3b11f1b5a00d44d12bea5a-20260514
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=Uemcl8vJ7toklrww/7zbGvw4iAZriS//j/wVkemIJYA=; 
 b=QWik7/WGUXSl6JtyCLVUCBuwQqvHrUlsr8ggjJol7bnL0owcm8YA5UCnCSiK/4mnLySaD89MCjr+F96jrPgSQykBiRCMMTZl3XWPb+0r1PP8LYIhE17LHoIOj52/nnQ3DqOxnU7rj7Ju0dkdfEZjaIULEycTAlQfgml4njgrpbw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:f1d05048-e5c7-482d-a740-0794c6a4d15f, IP:0,
 U
 RL:0,TC:0,Content:3,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:3
X-CID-META: VersionHash:9091e75, CLOUDID:01b961c4-1dfd-41c0-8544-20bb494fc627,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:4|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 89df10404f3b11f1b5a00d44d12bea5a-20260514
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 954576599; Thu, 14 May 2026 10:20:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 14 May 2026 10:20:54 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 14 May 2026 10:20:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g04NJ/skPu3YB6CxakeDtSfvtbSBDHKN+40IvPPsP8WRlYS8tv0C7+U1HHmGExcjBgBhfsleTh9oltP/SOCmtVBMrQXGXH7KZ7xzDOkbmRZEvZ8NXhLmrt3gywlBsFc5rQyd/i7K6HyuT2sFn4OvIkKDuDgIdsSlwziF5/NmK1k3dooUdcbN8GopLWiDFakoZxX+wBcMDIaQ0yLOD/I1YBduPCyNMkOEFZX9I5KLXFTVtuqMWJt0QxBXwcUzmd0xjatGXy8OjPFoG2CWk2bw3YFoYFpt/6ruMNgrJaah8lm2FC6OBmcyJLGWUgwabjMnoOGiZuWWdpkwLURH/2RAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uemcl8vJ7toklrww/7zbGvw4iAZriS//j/wVkemIJYA=;
 b=YHcp7lsieF/X+5cwgu0wlPmba9zXG+dTmTAE/QpcaSCCrT2gPgr+2TmitRdGsC1jQ2/g5QtPn+kGQxPf9v0pql7kGt/mcoRIXzDOO+ai7bvvn0srKalH0nVnOx59qLhysLq2nM0SSI1kZc4zVFvWzRuZihD3s6sMy5BF5Ila1CQ0Q26PhqbAjviQ6cv3gs77gGq+xiAjYU2ApzDelG/sG0SM/3e4CRbHQ4EACUwakhY+5cVosJ+1KE/liRfBHLre2a7h4MlutEVY2cOIpr6TfbrUCoAaBVUSaEcviCQ4syNblz7o+Fy6n0dmisQb/5OAJ3EylotPLOlMg4p9Id6XIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uemcl8vJ7toklrww/7zbGvw4iAZriS//j/wVkemIJYA=;
 b=aghqxQSf2tLV4Zco5j0FNhoD1wiqdwsuaoA/T/wx0sL5snSTbpclxMI6ga2L05KndOAVu75BK2+eSHCX1RVlRrieuweKcnYgu12FOMKRUzVpgTw7ZS0EoV5fUCHe6wRTzC2a37f0PNLgvTiigz+AZ1YpKjs8LVOiI2CmoBmepWE=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEZPR03MB8183.apcprd03.prod.outlook.com (2603:1096:101:196::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.17; Thu, 14 May
 2026 02:20:50 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.21.0025.012; Thu, 14 May 2026
 02:20:50 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>, "kever.yang@rock-chips.com"
 <kever.yang@rock-chips.com>, "neil.armstrong@linaro.org"
 <neil.armstrong@linaro.org>, "trini@konsulko.com" <trini@konsulko.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 "sumit.garg@kernel.org" <sumit.garg@kernel.org>,
 =?utf-8?B?QmlhbyBIdWFuZyAo6buE5b2qKQ==?= <Biao.Huang@mediatek.com>,
 "iwamatsu@nigauri.org" <iwamatsu@nigauri.org>, "casey.connolly@linaro.org"
 <casey.connolly@linaro.org>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "philipp.tomsich@vrull.eu" <philipp.tomsich@vrull.eu>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "u-boot-qcom@groups.io" <u-boot-qcom@groups.io>
Subject: Re: [PATCH] phy: Kconfig: use bool instead of tristate
Thread-Topic: [PATCH] phy: Kconfig: use bool instead of tristate
Thread-Index: AQHc4uKf7GlJDAEOwkqjn6ro7R58jrYMysmA
Date: Thu, 14 May 2026 02:20:50 +0000
Message-ID: <401e2279172c25287c2533a9285db4b2dff4337a.camel@mediatek.com>
References: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
In-Reply-To: <20260513-phy-kconfig-no-tristate-v1-1-c4cbee0c1831@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEZPR03MB8183:EE_
x-ms-office365-filtering-correlation-id: cbdebbb6-2f36-4227-5939-08deb15f6acc
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|921020|3023799003|11063799003|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Fg5X5K6l5/O7PxkzElgxskxNJrJxTA6dckJm+50ZSzgFo4/TS3JY0PX37UdHeBBa2DQiPXOHDrCU3CtXP2vRhVCH1+uxBjw8bj8rRDo2beWH+m15XhTp/XeaPa7oQ3ZpiZnLrQpkUva1koNfJZlJjmnk/63r0dZ+hvEY3AAd1zgZqdUvixbCbhkfcP7rfH9biUAhAHpdGCQXFnFZBJMvFtRo9PKO+NXozI8OUM1H9v57sS8I391RIQTNNn8q4AKf1F1qq/JBdwuhLUhsjskWmqlq+k2gGtduLjR1KBSfxiLv7FcPj14FGFE7XHjb82CzZSTQfhSFO2x0Z6Bvqq7z4VYzg5rF3unPn6cSYfT0ZRHEfzZIT53ZvQEJcHga5Sd/jjhmzbjzfUm6baY0R4PnXSacsvxitNJYuxgSI6aUOgCv19MuV93gaJ9GmTlnPpBD3pabc3yLLh4+smohQzkWCr4AuzPLfanmHo+t/qWvK27R4qHV3Dt3NI3vqAOKGePTH/9yM9PD3KpFYSNFPYQb1hKNqlwB1+9hw2YLdBMvoPezocEX9/LK48zIXFrk5dsPUrr5JJd0wNT7uE840QPGxOZ0JAWFb7xzpeyUF3a0C7Tgfj3fkEJz4P+B8G8c6xXbCMTUjbrFxuCX/yBu1VDpDjGV/vS+RBCq3F9bAY4IFBBBfCWq/cDEZcXDsmwhuVP4hJ3J0XYo/jt2W3ttrubQ5A5BLoZ3vWGaVouvyTu0fVv5llyDc4IceT3Czb6aaKxC+dGlFcYLxav2ofOdEvC3fQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(921020)(3023799003)(11063799003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UnVxcC9wREpUd29VMUpNZXoxOHFaT3FLc1BqdllmU1RhZ0Z6ZzA4SXpaQThs?=
 =?utf-8?B?VDdrb0FTc2xjbHhISEU1Nm80VkNoemx0Y0Y4SFZ5Nkwwc0pwRWFNZkhZZjZ6?=
 =?utf-8?B?VWJwdGs0a3FIUlhpRGJQdThaaTlYMDlvYU5mbWJHbnpQRWh2aWFDNllCMFdI?=
 =?utf-8?B?clZ4NnpiakUwaGJJR0ZzS05RUjNVMDFxMWZrcisvcUNRRDNGbnFHWHJaT01N?=
 =?utf-8?B?TXd0V3dmMTZYMDRodEJ0NTh3enJNQkwxaVFrUWh6cWNJQ3gwbU1OL1hkbHlX?=
 =?utf-8?B?L1l0RUNhbnlpQjlqOTVlbmhaWE0xckNVWE1obnRDazBXNmt5OFF4SW5SeUtC?=
 =?utf-8?B?VWtmSzlMQlJVMjNEMTdMampCOWxucWxGTXd0N1JjZ2JhaTlQdStwUzk5Skd2?=
 =?utf-8?B?TjUrNUsxVDJic3BmNlQycUN4NlBCK0RpV3hQdWpjc2JzMnlkOE90VENXblE1?=
 =?utf-8?B?cXdHR2V1YytZTnQ5b3BOLzU1SHJ2YkVlVWNlbnpvSGVWZkhFSTJkbXRHR2Zi?=
 =?utf-8?B?WlQxOVBqV08zV3JjQ2pzd0h0bFJXSWdQT1RUbWV0V0VTLzVLZXhqVm1HVG9T?=
 =?utf-8?B?T29OMjg5cGtJMi91a2EreFl3a0NJUmFIVmhCNDZDWGNoY1ZJVlU1VFJsL3BS?=
 =?utf-8?B?OVQwUkkrQzNIZm5qOXpOMXhxdC93MnpWSlpxeC9jTHpWd2MzRWtZSHcwZHpj?=
 =?utf-8?B?N0FRNmFRemFCK2pXOWtNNmdkQ1c0ZVRNUE8yMmlhN1NTWnhkNzZ4eFl3Y3Ns?=
 =?utf-8?B?NEx4cURqMW5tTXdRWEtRVGpxRkJsejBSOXFGZTEwMEZzTWZjWXV5ZFg3QVp3?=
 =?utf-8?B?cEFuMU5EQ1kxV3hwNnZTSG03ZmlNc0lkRDI0ZnArZ0RuQytjZHFhdWcveWd1?=
 =?utf-8?B?UWFWZjVzUS81dTByTGdKUk12dXF6L3Y2cFQyNkxrdjFFQmJQU1BWdmFGVEpO?=
 =?utf-8?B?eVRmVTRiUGNBTVVHT3hxVHlrUncwZWtPYWxqaW5hK2tZRGI4RkhoekJZZjNL?=
 =?utf-8?B?T1JQSTIxS1BlTWNLVXUwRDFpc0trY2xRVTlDU2xDMHBZSmlSVEROS2NqYUhJ?=
 =?utf-8?B?NmFSTHBwZUFWdnprNEFFR3liRDdTNDI1UjBuZ3FleVUvVzY5VVJIMzNNN2xU?=
 =?utf-8?B?RkRSTTFJOEVIZGltTjhzRUlnWmFzaXVGZ0U2ZS9ZL3dxNUY2enUxSFF5N3BK?=
 =?utf-8?B?L01tT2YvU3BEdHFuRjEwQ2UrUUVvRnBkbzZYQ3V5TStvS05zWkN1UmRFcEdI?=
 =?utf-8?B?ZWZhdENMY0xsTjBwNy9tbnR0eHVtK3c5dzRuWks2ajYrYlJKbzhoU3FsMFFw?=
 =?utf-8?B?Z1FJaDNoK0ptOFk4U1hQZ3NLVk13QUpGWlRqMHFCMzV0ZDcyRzNWeisrUkdw?=
 =?utf-8?B?SlFWMnNBMC83dzl4bHZaTU9GZWwrdTdRTGJyRzdpY00yYWlBWnNxWEJvemI2?=
 =?utf-8?B?aUVPWTNiTDA3dmJodkw5Mlk2STBmbnJ6Z2c3UTE5dkNYM0lxZnVpNDg1eXQx?=
 =?utf-8?B?cmpXUmlvTVVpTHY0UzQwaUVvbXhGdkI3dThlWlo5TzdFakprVGJ5VktDNks4?=
 =?utf-8?B?Uldqd3FCSzhpdi9QS3gvQXdidTFnZnczVW1STUcxV3V2Ny92cU8rMDFDVXJW?=
 =?utf-8?B?MVpDSVhRSnpNSk5rNlVwc2h2Unk4RytBVUV5ZXhabDBEYzR4Q1d5L29NSjVI?=
 =?utf-8?B?T0hmMlRuekhhODZqL0d4b0gxZVUxeEJXRUpXQW1tVVducFR2UHNoRXkraGZx?=
 =?utf-8?B?dG9zWkFFS3ZicGJacnNQWVU0UStwenR4bTdFaVdlc3Y4bkZvZnNFaGJ1dGpD?=
 =?utf-8?B?ZjJ1dVR2QzJkNWYyQUk4eHFDeGJyT2UrZjVtK0hFaHBqRk1POUx1Wkp4alNU?=
 =?utf-8?B?Rm9tNHpQNW02R3h3OWp4azVmRWl5SmpvS2Z5aW55OHZBOENRK3V5UlJOT3VC?=
 =?utf-8?B?MDJFc2lxdUhvMm5tVyswOC9mZzcrUE5NWXVucDkvSmFOQkRxY3duQnZHMlVP?=
 =?utf-8?B?YkpvU1FoTEhsUW9aNENBVGhXaXlHZ1JndXloVnUrK2YzdzBxYTNXbkdTOXAx?=
 =?utf-8?B?SFJwRVczYUZyTUJDT3FJaU5Qem8wMTRsV1JxemxBV211VWhwV0lyWU5zVm83?=
 =?utf-8?B?V0pRQUtvRWNvdllkOXlhT3pwSHJYQUx2ancyeGIrMDZzZnZxcTE1SDhHM2wv?=
 =?utf-8?B?SVZqYmx3MGZrTEZTWEp6MGRGTlBZQ1oxaWdKeTh3ajh5dFgySmF5aXpDMVNY?=
 =?utf-8?B?TmJtK2x6WTl4WVNUNGFKbC92S3BHU1dxTEdZazB2VkdncVpMclJXSHNCcVR1?=
 =?utf-8?B?amZWQUQ3NUltK0VKVk13VGxFckV0SW5yZjU0dGRwaUhEOGlobmRkL1NkUm42?=
 =?utf-8?Q?UBw30RHOneUY1k9o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2531AA5CD309EE4688A8C25B1A804C32@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: MFr5FVSQ8K4lEAIbJNjjviJFCGlyOw8SKulFh+9QFmUWWlRuDKMaUH9hMxXm7aXH9KNCTiwAP9QAu5kvrZ7IrT0D34Rw5AQfJYCBE1CH6p2zjF0hbslcAhxY/jj7d6dWfqIekCBhqwz2KfWIXsW0zfhD4m89XhkgOaAgWGdw0cSeMLVeTa8BWkhhOf4F3OvvxaXUT5VZq0ZTflQWjdwAw0wpodNIWmwDcRcvgtiMhe25OdwdTpatJznRpIcY6jVsNN8HvXFHom+D/0KkJ8larFUThJ7NWjAjjJJApchtWy4XwYNBxwLfqtMdYrGRmGrha23l5gEG2qGODQlCyJUtFA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbdebbb6-2f36-4227-5939-08deb15f6acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2026 02:20:50.4378 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YtqKBPPmPrQCMpz/mBYVrDLpmsAgg7yidXEcZ9Im/hoT4txkC4m9hfd9gU29tWoKLVdnAtK8mAG5Ou1z0bnDFJAzYE/WlI57V6Udxe73G78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8183
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

T24gV2VkLCAyMDI2LTA1LTEzIGF0IDA5OjExIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBDaGFuZ2UgYWxsIHVzZXMgb2YgdHJpc3RhdGUgaW4gdGhlIFBIWSBLY29uZmlncyB0byBib29s
LiBVLUJvb3QgZG9lcw0KPiBub3Qgc3VwcG9ydCBtb2R1bGVzLCBzbyB0cmlzdGF0ZSBkb2VzIG5v
dCBtYWtlIHNlbnNlIGhlcmUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNobmVyIDxk
bGVjaG5lckBiYXlsaWJyZS5jb20+DQo+IC0tLQ0KPiDCoGRyaXZlcnMvcGh5L0tjb25maWfCoMKg
wqDCoMKgwqDCoMKgwqAgfCAxNCArKysrKysrLS0tLS0tLQ0KPiDCoGRyaXZlcnMvcGh5L2NhZGVu
Y2UvS2NvbmZpZ8KgIHzCoCA0ICsrLS0NCj4gwqBkcml2ZXJzL3BoeS9xY29tL0tjb25maWfCoMKg
wqDCoCB8IDE2ICsrKysrKysrLS0tLS0tLS0NCj4gwqBkcml2ZXJzL3BoeS9yZW5lc2FzL0tjb25m
aWfCoCB8wqAgNiArKystLS0NCj4gwqBkcml2ZXJzL3BoeS9yb2NrY2hpcC9LY29uZmlnIHzCoCAy
ICstDQo+IMKgZHJpdmVycy9waHkvdGkvS2NvbmZpZ8KgwqDCoMKgwqDCoCB8wqAgMiArLQ0KPiDC
oDYgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvS2NvbmZpZyBiL2RyaXZlcnMvcGh5L0tjb25maWcN
Cj4gaW5kZXggNWM4ZWMyYjE0NmYuLmVhZmE4MmZlNDk0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L3BoeS9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvcGh5L0tjb25maWcNCj4gQEAgLTExNCw3ICsx
MTQsNyBAQCBjb25maWcgQkNNX1NSX1BDSUVfUEhZDQo+IMKgCcKgIElmIHVuc3VyZSwgc2F5IE4u
DQo+IMKgDQo+IMKgY29uZmlnIFBIWV9EQThYWF9VU0INCj4gLQl0cmlzdGF0ZSAiVEkgREE4eHgg
VVNCIFBIWSBEcml2ZXIiDQo+ICsJYm9vbCAiVEkgREE4eHggVVNCIFBIWSBEcml2ZXIiDQo+IMKg
CWRlcGVuZHMgb24gUEhZICYmIEFSQ0hfREFWSU5DSQ0KPiDCoAloZWxwDQo+IMKgCcKgIEVuYWJs
ZSB0aGlzIHRvIHN1cHBvcnQgdGhlIFVTQiBQSFkgb24gREE4eHggU29Dcy4NCj4gQEAgLTEzOCw3
ICsxMzgsNyBAQCBjb25maWcgU1BMX1BJUEUzX1BIWQ0KPiDCoAnCoCBhbmQgb21hcDUNCj4gwqAN
Cj4gwqBjb25maWcgQU02NTRfUEhZDQo+IC0JdHJpc3RhdGUgIlRJIEFNNjU0IFNFUkRFUyBzdXBw
b3J0Ig0KPiArCWJvb2wgIlRJIEFNNjU0IFNFUkRFUyBzdXBwb3J0Ig0KPiDCoAlkZXBlbmRzIG9u
IFBIWSAmJiBBUkNIX0szDQo+IMKgCXNlbGVjdCBSRUdNQVANCj4gwqAJc2VsZWN0IFNZU0NPTg0K
PiBAQCAtMTU1LDcgKzE1NSw3IEBAIGNvbmZpZyBTVElfVVNCX1BIWQ0KPiDCoAnCoCBTVGlINDA3
IFNvQyBmYW1pbGllcy4NCj4gwqANCj4gwqBjb25maWcgUEhZX1JDQVJfR0VOMg0KPiAtCXRyaXN0
YXRlICJSZW5lc2FzIFItQ2FyIEdlbjIgVVNCIFBIWSINCj4gKwlib29sICJSZW5lc2FzIFItQ2Fy
IEdlbjIgVVNCIFBIWSINCj4gwqAJZGVwZW5kcyBvbiBQSFkgJiYgUkNBUl9HRU4yDQo+IMKgCWhl
bHANCj4gwqAJwqAgU3VwcG9ydCBmb3IgdGhlIFJlbmVzYXMgUi1DYXIgR2VuMiBVU0IgUEhZLiBU
aGlzIGRyaXZlcg0KPiBvcGVyYXRlcyB0aGUNCj4gQEAgLTE2Myw3ICsxNjMsNyBAQCBjb25maWcg
UEhZX1JDQVJfR0VOMg0KPiDCoAnCoCBhbGxvd3MgY29uZmlndXJpbmcgdGhlIG1vZHVsZSBtdWx0
aXBsZXhpbmcuDQo+IMKgDQo+IMKgY29uZmlnIFBIWV9SQ0FSX0dFTjMNCj4gLQl0cmlzdGF0ZSAi
UmVuZXNhcyBSLUNhciBHZW4zIFVTQiBQSFkiDQo+ICsJYm9vbCAiUmVuZXNhcyBSLUNhciBHZW4z
IFVTQiBQSFkiDQo+IMKgCWRlcGVuZHMgb24gUEhZICYmIENMSyAmJiBETV9SRUdVTEFUT1IgJiYg
KFJDQVJfR0VOMyB8fA0KPiBSWkcyTCkNCj4gwqAJZGVmYXVsdCB5IGlmIChSQ0FSX0dFTjMgfHwg
UlpHMkwpDQo+IMKgCWhlbHANCj4gQEAgLTE3MSw3ICsxNzEsNyBAQCBjb25maWcgUEhZX1JDQVJf
R0VOMw0KPiDCoAnCoCBQSFkgY29ubmVjdGVkIHRvIEVIQ0kgVVNCIG1vZHVsZSBhbmQgY29udHJv
bHMgVVNCIE9URw0KPiBvcGVyYXRpb24uDQo+IMKgDQo+IMKgY29uZmlnIFBIWV9TVE0zMl9VU0JQ
SFlDDQo+IC0JdHJpc3RhdGUgIlNUTWljcm9lbGVjdHJvbmljcyBTVE0zMiBTb0MgVVNCIEhTIFBI
WSBkcml2ZXIiDQo+ICsJYm9vbCAiU1RNaWNyb2VsZWN0cm9uaWNzIFNUTTMyIFNvQyBVU0IgSFMg
UEhZIGRyaXZlciINCj4gwqAJZGVwZW5kcyBvbiBQSFkgJiYgQVJDSF9TVE0zMk1QDQo+IMKgCWhl
bHANCj4gwqAJwqAgRW5hYmxlIHRoaXMgdG8gc3VwcG9ydCB0aGUgSGlnaC1TcGVlZCBVU0IgdHJh
bnNjZWl2ZXIgdGhhdA0KPiBpcyBwYXJ0IG9mDQo+IEBAIC0yODMsNyArMjgzLDcgQEAgY29uZmln
IFBIWV9NVEtfVFBIWQ0KPiDCoAnCoCBzbyB5b3UgY2FuIGVhc2lseSBkaXN0aW5ndWlzaCB0aGVt
IGJ5IGJhbmtzIGxheW91dC4NCj4gwqANCj4gwqBjb25maWcgUEhZX01US19VRlMNCj4gLQl0cmlz
dGF0ZSAiTWVkaWFUZWsgVUZTIE0tUEhZIGRyaXZlciINCj4gKwlib29sICJNZWRpYVRlayBVRlMg
TS1QSFkgZHJpdmVyIg0KPiDCoAlkZXBlbmRzIG9uIEFSQ0hfTUVESUFURUsNCj4gwqAJZGVwZW5k
cyBvbiBQSFkNCj4gwqAJaGVscA0KPiBAQCAtMzM3LDcgKzMzNyw3IEBAIGNvbmZpZyBQSFlfSU1Y
OE1fUENJRQ0KPiDCoAnCoCBUaGlzIFBIWSBpcyBmb3VuZCBvbiBpLk1YOE0gZGV2aWNlcyBzdXBw
b3J0aW5nIFBDSWUuDQo+IMKgDQo+IMKgY29uZmlnIFBIWV9YSUxJTlhfWllOUU1QDQo+IC0JdHJp
c3RhdGUgIlhpbGlueCBaeW5xTVAgUEhZIGRyaXZlciINCj4gKwlib29sICJYaWxpbnggWnlucU1Q
IFBIWSBkcml2ZXIiDQo+IMKgCWRlcGVuZHMgb24gUEhZICYmIEFSQ0hfWllOUU1QDQo+IMKgCWhl
bHANCj4gwqAJwqAgRW5hYmxlIHRoaXMgdG8gc3VwcG9ydCBaeW5xTVAgSGlnaCBTcGVlZCBHaWdh
Yml0DQo+IFRyYW5zY2VpdmVyDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9jYWRlbmNlL0tj
b25maWcNCj4gYi9kcml2ZXJzL3BoeS9jYWRlbmNlL0tjb25maWcNCj4gaW5kZXggOGMwYWI4MGZi
YmMuLmY1ZjA5Njg4OWZlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BoeS9jYWRlbmNlL0tjb25m
aWcNCj4gKysrIGIvZHJpdmVycy9waHkvY2FkZW5jZS9LY29uZmlnDQo+IEBAIC0xLDExICsxLDEx
IEBADQo+IMKgY29uZmlnIFBIWV9DQURFTkNFX1NJRVJSQQ0KPiAtCXRyaXN0YXRlICJDYWRlbmNl
IFNpZXJyYSBQSFkgRHJpdmVyIg0KPiArCWJvb2wgIkNhZGVuY2UgU2llcnJhIFBIWSBEcml2ZXIi
DQo+IMKgCWRlcGVuZHMgb24gRE1fUkVTRVQNCj4gwqAJaGVscA0KPiDCoAnCoCBFbmFibGUgdGhp
cyB0byBzdXBwb3J0IHRoZSBDYWRlbmNlIFNpZXJyYSBQSFkgZHJpdmVyDQo+IMKgDQo+IMKgY29u
ZmlnIFBIWV9DQURFTkNFX1RPUlJFTlQNCj4gLQl0cmlzdGF0ZSAiQ2FkZW5jZSBUb3JyZW50IFBI
WSBEcml2ZXIiDQo+ICsJYm9vbCAiQ2FkZW5jZSBUb3JyZW50IFBIWSBEcml2ZXIiDQo+IMKgCWRl
cGVuZHMgb24gRE1fUkVTRVQNCj4gwqAJaGVscA0KPiDCoAnCoCBFbmFibGUgdGhpcyB0byBzdXBw
b3J0IHRoZSBDYWRlbmNlIFRvcnJlbnQgUEhZIGRyaXZlcg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9waHkvcWNvbS9LY29uZmlnIGIvZHJpdmVycy9waHkvcWNvbS9LY29uZmlnDQo+IGluZGV4IDQ5
ZjgzMGFiZjAxLi43MDk0OTAzZDg2OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waHkvcWNvbS9L
Y29uZmlnDQo+ICsrKyBiL2RyaXZlcnMvcGh5L3Fjb20vS2NvbmZpZw0KPiBAQCAtNyw3ICs3LDcg
QEAgY29uZmlnIE1TTTg5MTZfVVNCX1BIWQ0KPiDCoAnCoCBUaGlzIFBIWSBpcyBmb3VuZCBvbiBx
dWFsY29tbSBkcmFnb25ib2FyZDQxMGMgZGV2ZWxvcG1lbnQNCj4gYm9hcmQuDQo+IMKgDQo+IMKg
Y29uZmlnIFBIWV9RQ09NX0lQUTQwMTlfVVNCDQo+IC0JdHJpc3RhdGUgIlF1YWxjb21tIElQUTQw
MTkgVVNCIFBIWSBkcml2ZXIiDQo+ICsJYm9vbCAiUXVhbGNvbW0gSVBRNDAxOSBVU0IgUEhZIGRy
aXZlciINCj4gwqAJZGVwZW5kcyBvbiBQSFkgJiYgQVJDSF9JUFE0MFhYDQo+IMKgCWhlbHANCj4g
wqAJwqAgU3VwcG9ydCBmb3IgdGhlIFVTQiBQSFktcyBvbiBRdWFsY29tbSBJUFE0MHh4IFNvQy1z
Lg0KPiBAQCAtMjEsMjYgKzIxLDI2IEBAIGNvbmZpZyBQSFlfUUNPTV9RTVBfQ09NQk8NCj4gwqAJ
wqAgUEhZIChVU0IzICsgRGlzcGxheVBvcnQpLiBDdXJyZW50bHkgb25seSBVU0IzIG1vZGUgaXMN
Cj4gc3VwcG9ydGVkLg0KPiDCoA0KPiDCoGNvbmZpZyBQSFlfUUNPTV9RTVBfUENJRQ0KPiAtCXRy
aXN0YXRlICJRdWFsY29tbSBRTVAgUENJZSBQSFkgZHJpdmVyIg0KPiArCWJvb2wgIlF1YWxjb21t
IFFNUCBQQ0llIFBIWSBkcml2ZXIiDQo+IMKgCWRlcGVuZHMgb24gUEhZICYmIEFSQ0hfU05BUERS
QUdPTg0KPiDCoAloZWxwDQo+IMKgCcKgIEVuYWJsZSB0aGlzIHRvIHN1cHBvcnQgdGhlIFBDSWUg
UU1QIFBIWSBvbiB2YXJpb3VzDQo+IFF1YWxjb21tIGNoaXBzZXRzLg0KPiDCoA0KPiDCoGNvbmZp
ZyBQSFlfUUNPTV9RTVBfVUZTDQo+IC0JdHJpc3RhdGUgIlF1YWxjb21tIFFNUCBVRlMgUEhZIGRy
aXZlciINCj4gKwlib29sICJRdWFsY29tbSBRTVAgVUZTIFBIWSBkcml2ZXIiDQo+IMKgCWRlcGVu
ZHMgb24gUEhZICYmIEFSQ0hfU05BUERSQUdPTg0KPiDCoAloZWxwDQo+IMKgCcKgIEVuYWJsZSB0
aGlzIHRvIHN1cHBvcnQgdGhlIFVGUyBRTVAgUEhZIG9uIHZhcmlvdXMgUXVhbGNvbW0NCj4gY2hp
cHNldHMuDQo+IMKgDQo+IMKgY29uZmlnIFBIWV9RQ09NX1FVU0IyDQo+IC0JdHJpc3RhdGUgIlF1
YWxjb21tIFVTQiBRVVNCMiBQSFkgZHJpdmVyIg0KPiArCWJvb2wgIlF1YWxjb21tIFVTQiBRVVNC
MiBQSFkgZHJpdmVyIg0KPiDCoAlkZXBlbmRzIG9uIFBIWSAmJiBBUkNIX1NOQVBEUkFHT04NCj4g
wqAJaGVscA0KPiDCoAnCoCBFbmFibGUgdGhpcyB0byBzdXBwb3J0IHRoZSBTdXBlci1TcGVlZCBV
U0IgdHJhbnNjZWl2ZXIgb24NCj4gdmFyaW91cw0KPiDCoAnCoCBRdWFsY29tbSBjaGlwc2V0cy4N
Cj4gwqANCj4gwqBjb25maWcgUEhZX1FDT01fVVNCX1NOUFNfRkVNVE9fVjINCj4gLQl0cmlzdGF0
ZSAiUXVhbGNvbW0gU05QUyBGRU1UTyBVU0IgSFMgUEhZIHYyIg0KPiArCWJvb2wgIlF1YWxjb21t
IFNOUFMgRkVNVE8gVVNCIEhTIFBIWSB2MiINCj4gwqAJZGVwZW5kcyBvbiBQSFkgJiYgQVJDSF9T
TkFQRFJBR09ODQo+IMKgCWhlbHANCj4gwqAJwqAgRW5hYmxlIHRoaXMgdG8gc3VwcG9ydCB0aGUg
UXVhbGNvbW0gU3lub3BzeXMgRGVzaWduV2FyZQ0KPiBDb3JlIDdubQ0KPiBAQCAtNDgsNyArNDgs
NyBAQCBjb25maWcgUEhZX1FDT01fVVNCX1NOUFNfRkVNVE9fVjINCj4gwqAJwqAgaXMgdXN1YWxs
eSBwYWlyZWQgd2l0aCBTeW5vcHN5cyBEV0MzIFVTQiBJUHMgb24gTVNNIFNPQ3MuDQo+IMKgDQo+
IMKgY29uZmlnIFBIWV9RQ09NX1NOUFNfRVVTQjINCj4gLQl0cmlzdGF0ZSAiUXVhbGNvbW0gU3lu
b3BzeXMgZVVTQjIgSGlnaC1TcGVlZCBQSFkiDQo+ICsJYm9vbCAiUXVhbGNvbW0gU3lub3BzeXMg
ZVVTQjIgSGlnaC1TcGVlZCBQSFkiDQo+IMKgCWRlcGVuZHMgb24gUEhZICYmIEFSQ0hfU05BUERS
QUdPTg0KPiDCoAloZWxwDQo+IMKgCcKgIEVuYWJsZSB0aGlzIHRvIHN1cHBvcnQgdGhlIFF1YWxj
b21tIFN5bm9wc3lzIERlc2lnbldhcmUNCj4gZVVTQjINCj4gQEAgLTU2LDcgKzU2LDcgQEAgY29u
ZmlnIFBIWV9RQ09NX1NOUFNfRVVTQjINCj4gwqAJwqAgaXMgdXN1YWxseSBwYWlyZWQgd2l0aCBT
eW5vcHN5cyBEV0MzIFVTQiBJUHMgb24gTVNNIFNPQ3MuDQo+IMKgDQo+IMKgY29uZmlnIFBIWV9R
Q09NX1VTQl9IU18yOE5NDQo+IC0JdHJpc3RhdGUgIlF1YWxjb21tIDI4bm0gSGlnaC1TcGVlZCBQ
SFkiDQo+ICsJYm9vbCAiUXVhbGNvbW0gMjhubSBIaWdoLVNwZWVkIFBIWSINCj4gwqAJZGVwZW5k
cyBvbiBQSFkgJiYgQVJDSF9TTkFQRFJBR09ODQo+IMKgCWhlbHANCj4gwqAJwqAgRW5hYmxlIHRo
aXMgdG8gc3VwcG9ydCB0aGUgUXVhbGNvbW0gU3lub3BzeXMgRGVzaWduV2FyZQ0KPiBDb3JlIDI4
bm0NCj4gQEAgLTY1LDcgKzY1LDcgQEAgY29uZmlnIFBIWV9RQ09NX1VTQl9IU18yOE5NDQo+IMKg
CcKgIElQcyBvbiBNU00gU09Dcy4NCj4gwqANCj4gwqBjb25maWcgUEhZX1FDT01fVVNCX1NTDQo+
IC0JdHJpc3RhdGUgIlF1YWxjb21tIFVTQiBTdXBlci1TcGVlZCBQSFkgZHJpdmVyIg0KPiArCWJv
b2wgIlF1YWxjb21tIFVTQiBTdXBlci1TcGVlZCBQSFkgZHJpdmVyIg0KPiDCoAlkZXBlbmRzIG9u
IFBIWSAmJiBBUkNIX1NOQVBEUkFHT04NCj4gwqAJaGVscA0KPiDCoAnCoCBFbmFibGUgdGhpcyB0
byBzdXBwb3J0IHRoZSBTdXBlci1TcGVlZCBVU0IgdHJhbnNjZWl2ZXIgb24NCj4gdmFyaW91cw0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9waHkvcmVuZXNhcy9LY29uZmlnDQo+IGIvZHJpdmVycy9w
aHkvcmVuZXNhcy9LY29uZmlnDQo+IGluZGV4IGFmZmJlZTA1MDBjLi4zMzU4ZDQ1NGU1OSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9waHkvcmVuZXNhcy9LY29uZmlnDQo+ICsrKyBiL2RyaXZlcnMv
cGh5L3JlbmVzYXMvS2NvbmZpZw0KPiBAQCAtMywxOSArMywxOSBAQA0KPiDCoCMgUGh5IGRyaXZl
cnMgZm9yIFJlbmVzYXMgcGxhdGZvcm1zDQo+IMKgDQo+IMKgY29uZmlnIFBIWV9SOEE3NzlGMF9F
VEhFUk5FVF9TRVJERVMNCj4gLQl0cmlzdGF0ZSAiUmVuZXNhcyBSLUNhciBTNC04IEV0aGVybmV0
IFNFUkRFUyBkcml2ZXIiDQo+ICsJYm9vbCAiUmVuZXNhcyBSLUNhciBTNC04IEV0aGVybmV0IFNF
UkRFUyBkcml2ZXIiDQo+IMKgCWRlcGVuZHMgb24gUkNBUl82NCAmJiBQSFkNCj4gwqAJaGVscA0K
PiDCoAnCoCBTdXBwb3J0IGZvciBFdGhlcm5ldCBTRVJERVMgZm91bmQgb24gUmVuZXNhcyBSLUNh
ciBTNC04DQo+IFNvQ3MuDQo+IMKgDQo+IMKgY29uZmlnIFBIWV9SOEE3ODAwMF9FVEhFUk5FVF9Q
Q1MNCj4gLQl0cmlzdGF0ZSAiUmVuZXNhcyBSLUNhciBYNUggRXRoZXJuZXQgUENTIGRyaXZlciIN
Cj4gKwlib29sICJSZW5lc2FzIFItQ2FyIFg1SCBFdGhlcm5ldCBQQ1MgZHJpdmVyIg0KPiDCoAlk
ZXBlbmRzIG9uIFJDQVJfNjQgJiYgUEhZDQo+IMKgCWhlbHANCj4gwqAJwqAgU3VwcG9ydCBmb3Ig
RXRoZXJuZXQgUENTIGZvdW5kIG9uIFJlbmVzYXMgUi1DYXIgWDVIIFNvQ3MuDQo+IMKgDQo+IMKg
Y29uZmlnIFBIWV9SOEE3ODAwMF9NUF9QSFkNCj4gLQl0cmlzdGF0ZSAiUmVuZXNhcyBSLUNhciBY
NUggTXVsdGktUHJvdG9jb2wgUEhZIGRyaXZlciINCj4gKwlib29sICJSZW5lc2FzIFItQ2FyIFg1
SCBNdWx0aS1Qcm90b2NvbCBQSFkgZHJpdmVyIg0KPiDCoAlkZXBlbmRzIG9uIFJDQVJfNjQgJiYg
UEhZDQo+IMKgCWhlbHANCj4gwqAJwqAgU3VwcG9ydCBmb3IgTXVsdGktUHJvdG9jb2wgUEhZIG9u
IFJlbmVzYXMgUi1DYXIgWDVIIFNvQ3MuDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BoeS9yb2Nr
Y2hpcC9LY29uZmlnDQo+IGIvZHJpdmVycy9waHkvcm9ja2NoaXAvS2NvbmZpZw0KPiBpbmRleCA4
MDEyODMzNWQ1Mi4uNmYzZDdlYmUyOWUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGh5L3JvY2tj
aGlwL0tjb25maWcNCj4gKysrIGIvZHJpdmVycy9waHkvcm9ja2NoaXAvS2NvbmZpZw0KPiBAQCAt
NDksNyArNDksNyBAQCBjb25maWcgUEhZX1JPQ0tDSElQX1NOUFNfUENJRTMNCj4gwqAJwqAgYWxz
byBiZSBhYmxlIHNwbGl0ZWQgaW50byBtdWx0aXBsZSBjb21iaW5hdGlvbnMgb2YgbGFuZXMuDQo+
IMKgDQo+IMKgY29uZmlnIFBIWV9ST0NLQ0hJUF9VU0JEUA0KPiAtCXRyaXN0YXRlICJSb2NrY2hp
cCBVU0JEUCBDT01CTyBQSFkgRHJpdmVyIg0KPiArCWJvb2wgIlJvY2tjaGlwIFVTQkRQIENPTUJP
IFBIWSBEcml2ZXIiDQo+IMKgCWRlcGVuZHMgb24gQVJDSF9ST0NLQ0hJUA0KPiDCoAlzZWxlY3Qg
UEhZDQo+IMKgCWhlbHANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L3RpL0tjb25maWcgYi9k
cml2ZXJzL3BoeS90aS9LY29uZmlnDQo+IGluZGV4IGRmNzUwYjI2ZDY2Li5mZTk2ZWI2ODA2ZiAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9waHkvdGkvS2NvbmZpZw0KPiArKysgYi9kcml2ZXJzL3Bo
eS90aS9LY29uZmlnDQo+IEBAIC0xLDUgKzEsNSBAQA0KPiDCoGNvbmZpZyBQSFlfSjcyMUVfV0la
DQo+IC0JdHJpc3RhdGUgIlRJIEo3MjFFIFdJWiAoU0VSREVTIFdyYXBwZXIpIHN1cHBvcnQiDQo+
ICsJYm9vbCAiVEkgSjcyMUUgV0laIChTRVJERVMgV3JhcHBlcikgc3VwcG9ydCINCj4gwqAJZGVw
ZW5kcyBvbiBBUkNIX0szDQo+IMKgCWhlbHANCj4gwqAJwqAgVGhpcyBvcHRpb24gZW5hYmxlcyBz
dXBwb3J0IGZvciBXSVogbW9kdWxlIHByZXNlbnQgaW4gVEkncw0KPiBKNzIxRQ0KPiANCj4gLS0t
DQo+IGJhc2UtY29tbWl0OiBlM2U2NTFjNDgwYzQ2YjMzMmYxNmE3NTU1Yjk3YzZjNmZkNjQwYTQw
DQo+IGNoYW5nZS1pZDogMjAyNjA1MTMtcGh5LWtjb25maWctbm8tdHJpc3RhdGUtNjFiYzJkMzI0
MTQ5DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IC0twqAgDQo+IERhdmlkIExlY2huZXIgPGRsZWNo
bmVyQGJheWxpYnJlLmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1
bC5saW5AbWVkaWF0ZWsuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpNYWNwYXVsIExpbg0K
