Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D4EFEEF49
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:34:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1ECC783A41;
	Tue,  7 Apr 2026 16:34:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ogrw6eSd";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="OxOZ2gcL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 394AA8406D; Tue,  7 Apr 2026 16:34:13 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E54A80433
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:34:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: d350fd5c328e11f19a16598d5ca7f8ec-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=x9+za7KRAIkFagXEWRde/P1Ivw8MEq1JfwpLIoJDZ4M=; 
 b=ogrw6eSdPuPTK68QUfkiOannkqxeAefY3tfDAuOtxahExbN/1N9E2qW3zw3wN5Lrzmjec5qV+7Gg8qLU8ImVqt4rIA1kAlYC9/dv8AzZ1AZj8OeJt0jsNkWAbGBLfcNK2R0WX719UXnJ9+imGkglpivTEfLG36ZHNw8ONRofBEs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:1c2286d7-5a01-40a4-a0b4-c50d60ea82ac, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:024e95d5-060f-4ecc-9ee0-121eeeb4a682,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS
 :nil,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,AR
 C:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d350fd5c328e11f19a16598d5ca7f8ec-20260407
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1398369345; Tue, 07 Apr 2026 22:34:03 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:34:02 +0800
Received: from SI4PR04CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:34:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K68lXUYwRYwpuKl3gPXTvlnnemJ4g8+2jYdumKFqM7V0ghiNkc9jU3FSyyL5M5rlP4XALVqIiK1bvBby/Zl0WDWuOVRfT+ox1OeIsXdjOZ7YK1jW/I+W2cbk7Fthe0HgBoOsrDFOUnmB08+wC+Ef+t3sP9UgTSm1ihJOQu6V7w/WgvpJgW1VRMPq+/b0Dj/HHhdONVosGSRRg6IHKHPfclySAySp5I5tqsu6q9sIzoraaJQG51wC2RfrUOUESWl3lXMX62Boo1zoPlzz6TkJOQhHmbDhN0eEwPdddW9h/iSuWpX4x+X/QF+gtMVszAsxx2j+bwDvRSxvBzF53rR5fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9+za7KRAIkFagXEWRde/P1Ivw8MEq1JfwpLIoJDZ4M=;
 b=YQXO8Y+P+lqSH2GeZ0xR7GTJ49ZQ3wcNGxnMlnRfV6Iu4iBNUAjmYVfcEiPVRNDqUoVIgVz1Azub5dIlPFgnE4sb/3kXoBUSeB+Zwhe+kFyiHl6wdTDiaNxqj2BnK2B3IPk5KO5K0fUdusTLXph6EBggwJxVZmANOma5dkpeqAhYSip9VJBZWx8JprqYEaUQnG5bjxSPseceP9ERXqmBmInRTeLEZ35znUQhN1Dx57ekyPsr65jB504V1iJykgctz/jdxRw0VsFDccbyGfwwKdP/K0yGEyQ74OLov1TK+V/C51QXRXWued2q6d9Oh6kUDpzI245GlMZm76BBF+raRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x9+za7KRAIkFagXEWRde/P1Ivw8MEq1JfwpLIoJDZ4M=;
 b=OxOZ2gcL7XSv8p4D687yTKtjcMSTA8zJzWbqAS30ukeyIlB6OFRCBOL9oO3jmiUXo9xxhaWSPzIuSOd3EVhu2eWPZC9c97sL0+0Le3SbuscngLI0zAxqRb7AA49YjOcYxbZUoXJyDrA0ybTDjEAok1lLa+0zTQuZUyDp9DPRWEE=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYUPR03MB7180.apcprd03.prod.outlook.com (2603:1096:400:355::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 14:33:58 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:33:58 +0000
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
Subject: Re: [PATCH 4/6] arm: dts: mt8189: add UFS nodes
Thread-Topic: [PATCH 4/6] arm: dts: mt8189: add UFS nodes
Thread-Index: AQHcwIX4dAxRVvqfBkiVQ492TdT8MLXTthaA
Date: Tue, 7 Apr 2026 14:33:58 +0000
Message-ID: <39e0409ecf908727f6303874719c24307a758165.camel@mediatek.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
 <20260330-mtk-genio-720-ufs-v1-4-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-4-3bad8362ed70@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYUPR03MB7180:EE_
x-ms-office365-filtering-correlation-id: bd22ed64-9b15-4901-6536-08de94b2b483
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|921020|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 7KJO+Mr524k+m3/zyLYofhq+M5VpicUQTKx2PFFULIpQyLz0hCXKkRQfGLxmgw2nM5sefGwoKBseDLTivF5hZ1IYhJYWfDstYipkU0MhfkGXACxk3nC1l13HQl0nwwfYuiUI0bO8fkTWAw/AMErQNJ9i8VdCpOfHOm2h1g7A4Alj5o8fWPOt8yCUNIzJWCNgukq4U9wqIpm4U6AZATEQ5vTikD2u0X0jkISHVlsbLWE1M1ALnZ6T475dVrfeePZjHgn/cyQxu8o/CSfpzAH6t2pc2YwUsWAk2KcUlzq/RgQ4IjUbBfASzxilU2K1bzrT9fcaXzyH5g60EfLpkbyn77a38KwtY7lOfm480lSel+/V0+0HIUiOYHcc+rovO70ZH0ZGVCv1/r/NBO7rTJ6+RfOdBCXW8qqiqdNW5g+BDpkKYNK/9hCHCw+0CPkzH7ZyAR+O3vOBxAyXNnIwdVLEaq9ZvznsfVhe1pTRnah/GNMLFntXdImJQgiLmWkLdkQJK9A6IpQ/i90wW2NfjSRgPirSiYSQRyViRSJPelBz4cNv3DjHrKkQgC73/2MivkAeqFo/6A9IePwcE61My5vOWnUSpyGeKwe6fAxV6DFJ4j+AdsoxjZQktNQzcOBdKP88LHwYQvzb6GRHWhwmy2N12OOm5SHitRNKbIQ+5vJy1PXqAEBdON1afzykzsKvdQEMp3POl4xW8cdRzwSb2nc2doJHYBmomo4QkewBQVXFPAOymoSBQCuTZVYjHqA4kk8OkuByCmGzaztVK5OWUPNGaaA9kRqhoSwHHVQwraXFXbUmUacAWIHFqCluJAo2AMWx
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(921020)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VExXdDV4b2J5MlhINzdxMzhkaFltV0tpMC83R1JsTUFzRVdFUUN0R1ZvZVZn?=
 =?utf-8?B?TlhNQTNqOEFkMG41V2hoR2ZGVHViRUpIdVdGS016QnhkeGpna1RVbExYRHhU?=
 =?utf-8?B?TzhpRVRyVzQ1czZDMWUxUWVPcEg5eFovcDh0UVVyTEZFMlIwcms3TUpIeUYz?=
 =?utf-8?B?Zkl4MzRGUFBlS0thcXRhNWJBK3FDbysrckFDNldKbFhid2lVeG5NcVJZS1FP?=
 =?utf-8?B?WUdVdm5GMmZObk4zV2FYNVhuZmkrTS9tRjdMTGlSa2JsZXljVy8xRVdUL3VZ?=
 =?utf-8?B?L0lCQ1ZzZnNiRkc3cVJZNmlGRHJFcHk5VkVoM29YZm85aDNrUEI5alVtVDEw?=
 =?utf-8?B?ZmcvV1lOYW9VQmd3QTIwSnFockZLNGFmUG5TcG5kTVR1WmVUWVd4VW5uenVW?=
 =?utf-8?B?c2xhaTBpa0ZJa0xMemM1WTFVMHVETDFuay9qVVd5ZVpkY3hrZGxFZFdwUVY1?=
 =?utf-8?B?VzZCMU1rUkZucklYWkx6MFZZVk1OOVkzd1lnZkpENVZMWjVGZGp6Q0IxaHdR?=
 =?utf-8?B?TFF1Mkt3Ujg0RUdLNjRTQjJxaE14RWpUa1R2N0FSNDJBaUJhM2ZGZ3RZZUdX?=
 =?utf-8?B?UFV5ZDhEcmNMR1c1OXNSMkIvTlgrREw2M1lJQzI3cWtJVktpNFVEQVVzT2x0?=
 =?utf-8?B?b093VTd6RW9LZkRNY2V5S3JNSnVLUVBtNUxnaG9CUm5FeTlTd05rN1pibjNJ?=
 =?utf-8?B?U1FXZ0c3b3BKVzQrVFkzYW9HMXp5azRwVmZTMTFLVW5qU2w0MGNxd3FvdU92?=
 =?utf-8?B?MGpiNXJrZ2t4bGYzZTV4RU1OYnU1d1ZQVlY0dElVbmEzMFdPZ2RzVmdWdlBZ?=
 =?utf-8?B?ZnJQaENzNW9vSnpydWMwU01DWTZBVHJWcDZkSjVvU0c1L2pzQzBXVERuR2JI?=
 =?utf-8?B?R2FBK09VYWVXRTQyM2dtVitkUHo0N2dKNnlNQk41Y21SRC9MdVdRT21RaWpV?=
 =?utf-8?B?YkVpbm43a0tmS3kvRUtXUkVhUmIxZExQZ1ppUGNLdm5tbzQyakJDREJoRDk0?=
 =?utf-8?B?MFpXNktScEdDa0JyTDNXVk9Lekw5bmZsVFc1cUFtNXRrZ2J3bEZBb0M0ODI4?=
 =?utf-8?B?RFlrZ0w3NEVmQWhWRElTam1EUmFWSW1TM21aL0NuWTgwblNhdHpKOHlCNnFR?=
 =?utf-8?B?M09ZM3hvejMvVUNzYllWdHQwY29ZUFRRSmJ6WE5oMk4vVlp1Qk83MG5RU1Ar?=
 =?utf-8?B?NmtDamhzdGc1djlRSER4ME5hVHo5VHk1UllTd3NVblhYODNWZ2VLQk9YMFQ2?=
 =?utf-8?B?eU42SnV5OS9wbkg1eE1ITitVaXR4N2J5RU01cEpELzk2WDhrWGxRbXgzNmJX?=
 =?utf-8?B?OGZnVDJmc1BINzhjS3NISy85VW1LZXUxempKRnYzcnE3N0gzMVBIUWVWaVAv?=
 =?utf-8?B?MEd3Z0pDQzBuR2FSY2c0emNGdmlnVk0yRTZ4dXd2Vk1oMDR6czRaejVmNS9N?=
 =?utf-8?B?NU1oMzNsazMvTG14cWZpRWRrQ1JCZ0NJK1BZQTZmbHJGK2VVdklWVExoU0Z4?=
 =?utf-8?B?QkdIL0QwVkRibnkycVB6c05hQ2praTMwQVVEaTRKOC93ZkpPeU9HdUVnWWtq?=
 =?utf-8?B?bXdBZzZnZ2NpWmhuQWxCenZyOStzYVljRFFNcm9Jby9tR0xiYzBSL05tWDBY?=
 =?utf-8?B?UjE5UnV4VEVhT1Y0a3Jpa3VqanphQ2FHcndlWFNkb0tKSHdUc1BoT0NuZXFs?=
 =?utf-8?B?TGp2SEI2UEViR3VDTDNCeDZ1RmlhaWU3WlFKNmU0ODhWYVdhYTBaeXMzdVVx?=
 =?utf-8?B?cGNjSEhiT2dzRSsxMXJNR0sxN3EyU1hJbzlHRUduWkp5czNnNGRUT1hoYkQy?=
 =?utf-8?B?b2NtQzE0ZHd2Z2NZdVlFMFpIaWRVNjhZb2FXRjRsbzFjUWdpVi9KVzlZcHc2?=
 =?utf-8?B?N1dSRHFTRTZWajlCZ1MveHFURW1BUFhmbVBydDFML2p4NlhUOXVxaE5iOEF3?=
 =?utf-8?B?cm56L0JoakhCQzE4WkhEYTRVNExjOFRmZmZmeXh4Yk0ranROWEhCcmtPZVp4?=
 =?utf-8?B?dHltME83T2lxTXZ3NTdRMFdXWG0yZzF2d1F5cGRnZnBnSHg1MkpkYlgrdmtU?=
 =?utf-8?B?WjZJclpPSlZjYXdFMS9RQk9sOTNWekx3TmVTdEdMYmNiYXhlUDhRaS9nN2Y1?=
 =?utf-8?B?M2NPMmN4NDBib05VUlBiRGZ6UjNxTjNRV2twYXA3SlJnMmRRVzFSOHdsWGFM?=
 =?utf-8?B?RUVieU9mYmRPNEhOTmVuYUZtbzJzd3paZEZ3aktnK3QxcnY4OCtGV0xxV2Zi?=
 =?utf-8?B?dnJSbmRaRVIrZ2dKMlVNWnk2TmM1S01xbWVUbGZFOVFDWkpobTk2aElpU0tq?=
 =?utf-8?B?TUtXcDdCaVdEMkdtRENFMjVZcE5CbjJMUThUcDBkN2VQK0kydVBqWkJ1RVZR?=
 =?utf-8?Q?p/P8Y/gDp4HwueAI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F6702F3930E4EE43AA9A572E9E30FBC3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: l1whLV6XwZBzQflFhW1a6ygYOyvT0uyaM6YinvNdanArJf/vyCG1jj862to577LUA8vUC2PWhFhxwyJZQwC4j2CGXkIiWTGF8hn3lDxNyCpbSNrrx8EKMU8tkfUfvAbca8PaDAD5U2t1vNcmO0U7ZBeIghXdIbQauPxABGoViMytNDYq8vCyDMPu403xRYx4xZCgNvtJmN+zGT2wepGA2SM2TCh+/Ma+VJB6MmILLheMQS5oaFgnRDFDY+CRDLWMMu7wGSoc4BDntFXWRuDyoB/GBP5/skWRzdgP0COPfqdZkQBEzRUQcp6mLLcCtfDTwdDOzLDac46Yib3fm5Se3Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd22ed64-9b15-4901-6536-08de94b2b483
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:33:58.6596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /58WYFPWE8cHr49YfCh00BtqDpAt18yM9UpPNGORQICqKs8H2G7mWNgqDLllBfxEFqOMdHB0szBml3BIe3zdFcqn/PvzEAG7Rr0bmQoHAKw=
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
PiBBZGQgVUZTIG5vZGVzIHRvIG10ODE4OS5kdHNpLg0KPiANCj4gVGhpcyBpcyBjb3BpZWQgZnJv
bSB0aGUgcHJvcG9zZWQgdXBzdHJlYW0gcGF0Y2ggWzFdLg0KPiANCj4gTGluazoNCj4gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbWVkaWF0ZWsvMjAyNTExMTEwNzAwMzEuMzA1MjgxLTEw
LWpoLmhzdUBtZWRpYXRlay5jb20vDQo+IMKgWzFdDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExl
Y2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKgYXJjaC9hcm0vZHRzL210
ODE4OS5kdHNpIHwgMTE1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDExNSBpbnNlcnRpb25zKCspDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL210ODE4OS5kdHNpIGIvYXJjaC9hcm0vZHRzL210ODE4
OS5kdHNpDQo+IGluZGV4IGQyNDZiZTYzMjkzLi5lOWZkMjFlYTA5NSAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9hcm0vZHRzL210ODE4OS5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2R0cy9tdDgxODkuZHRz
aQ0KPiBAQCAtNyw2ICs3LDcgQEANCj4gwqAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvY2xvY2svbWVk
aWF0ZWssbXQ4MTg5LWNsay5oPg0KPiDCoCNpbmNsdWRlIDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQt
Y29udHJvbGxlci9pcnEuaD4NCj4gwqAjaW5jbHVkZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNv
bnRyb2xsZXIvYXJtLWdpYy5oPg0KPiArI2luY2x1ZGUgPGR0LWJpbmRpbmdzL3Jlc2V0L3RpLXN5
c2Nvbi5oPg0KPiDCoA0KPiDCoC8gew0KPiDCoAljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4
OSI7DQo+IEBAIC0yODYsNiArMjg3LDEyMCBAQA0KPiDCoAkJCSNpbnRlcnJ1cHQtY2VsbHMgPSA8
Mj47DQo+IMKgCQl9Ow0KPiDCoA0KPiArCQl1ZnNoY2k6IHVmc2hjaUAxMTJiMDAwMCB7DQo+ICsJ
CQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My11ZnNoY2kiOw0KPiArCQkJcmVnID0gPDAg
MHgxMTJiMDAwMCAwIDB4MjMwMD47DQo+ICsJCQlpbnRlcnJ1cHRzID0gPEdJQ19TUEkgMzkzDQo+
IElSUV9UWVBFX0xFVkVMX0hJR0ggMD47DQo+ICsNCj4gKwkJCWNsb2NrcyA9IDwmdG9wY2tnZW5f
Y2xrIENMS19UT1BfVV9TRUw+LA0KPiArCQkJCSA8JmNsazI2bT4sDQo+ICsJCQkJIDwmdG9wY2tn
ZW5fY2xrIENMS19UT1BfTVNEQ1BMTF9EMj4sDQo+ICsJCQkJIDwmdG9wY2tnZW5fY2xrDQo+IENM
S19UT1BfQUVTX1VGU0ZERV9TRUw+LA0KPiArCQkJCSA8JnRvcGNrZ2VuX2Nsaw0KPiBDTEtfVE9Q
X1VfTUJJU1RfU0VMPiwNCj4gKwkJCQkgPCZ1ZnNjZmdfYW9fcmVnX2Nsaw0KPiBDTEtfVUZTQ0ZH
X0FPX1JFR19VTklQUk9fVFhfU1lNPiwNCj4gKwkJCQkgPCZ1ZnNjZmdfYW9fcmVnX2Nsaw0KPiBD
TEtfVUZTQ0ZHX0FPX1JFR19VTklQUk9fUlhfU1lNMD4sDQo+ICsJCQkJIDwmdWZzY2ZnX2FvX3Jl
Z19jbGsNCj4gQ0xLX1VGU0NGR19BT19SRUdfVU5JUFJPX1JYX1NZTTE+LA0KPiArCQkJCSA8JnVm
c2NmZ19hb19yZWdfY2xrDQo+IENMS19VRlNDRkdfQU9fUkVHX1VOSVBST19TWVM+LA0KPiArCQkJ
CSA8JnVmc2NmZ19hb19yZWdfY2xrDQo+IENMS19VRlNDRkdfQU9fUkVHX1VfU0FQX0NGRz4sDQo+
ICsJCQkJIDwmdWZzY2ZnX2FvX3JlZ19jbGsNCj4gQ0xLX1VGU0NGR19BT19SRUdfVV9QSFlfVE9Q
X0FIQl9TX0JVUz4sDQo+ICsJCQkJIDwmdWZzY2ZnX3Bkbl9yZWdfY2xrDQo+IENMS19VRlNDRkdf
UkVHX1VGU0hDSV9VRlM+LA0KPiArCQkJCSA8JnVmc2NmZ19wZG5fcmVnX2Nsaw0KPiBDTEtfVUZT
Q0ZHX1JFR19VRlNIQ0lfQUVTPiwNCj4gKwkJCQkgPCZ1ZnNjZmdfcGRuX3JlZ19jbGsNCj4gQ0xL
X1VGU0NGR19SRUdfVUZTSENJX1VfQUhCPiwNCj4gKwkJCQkgPCZ1ZnNjZmdfcGRuX3JlZ19jbGsN
Cj4gQ0xLX1VGU0NGR19SRUdfVUZTSENJX1VfQVhJPjsNCj4gKw0KPiArCQkJY2xvY2stbmFtZXMg
PSAidWZzX3NlbCIsDQo+ICsJCQkJwqDCoMKgwqDCoCAidWZzX3NlbF9taW5fc3JjIiwNCj4gKwkJ
CQnCoMKgwqDCoMKgICJ1ZnNfc2VsX21heF9zcmMiLA0KPiArCQkJCcKgwqDCoMKgwqAgInVmc19m
ZGUiLA0KPiArCQkJCcKgwqDCoMKgwqAgInVmc19tYmlzdCIsDQo+ICsJCQkJwqDCoMKgwqDCoCAi
dW5pcHJvX3R4X3N5bSIsDQo+ICsJCQkJwqDCoMKgwqDCoCAidW5pcHJvX3J4X3N5bTAiLA0KPiAr
CQkJCcKgwqDCoMKgwqAgInVuaXByb19yeF9zeW0xIiwNCj4gKwkJCQnCoMKgwqDCoMKgICJ1bmlw
cm9fc3lzIiwNCj4gKwkJCQnCoMKgwqDCoMKgICJ1bmlwcm9fcGh5X3NhcCIsDQo+ICsJCQkJwqDC
oMKgwqDCoCAicGh5X3RvcF9haGJfc19idXMiLA0KPiArCQkJCcKgwqDCoMKgwqAgInVmc2hjaV91
ZnMiLA0KPiArCQkJCcKgwqDCoMKgwqAgInVmc2hjaV9hZXMiLA0KPiArCQkJCcKgwqDCoMKgwqAg
InVmc2hjaV91ZnNfYWhiIiwNCj4gKwkJCQnCoMKgwqDCoMKgICJ1ZnNoY2lfYWVzX2F4aSI7DQo+
ICsNCj4gKwkJCWZyZXEtdGFibGUtaHogPSA8MjYwMDAwMDAgMjA4MDAwMDAwPiwNCj4gKwkJCQkJ
PDAgMD4sDQo+ICsJCQkJCTwwIDA+LA0KPiArCQkJCQk8MCAwPiwNCj4gKwkJCQkJPDAgMD4sDQo+
ICsJCQkJCTwwIDA+LA0KPiArCQkJCQk8MCAwPiwNCj4gKwkJCQkJPDAgMD4sDQo+ICsJCQkJCTww
IDA+LA0KPiArCQkJCQk8MCAwPiwNCj4gKwkJCQkJPDAgMD4sDQo+ICsJCQkJCTwwIDA+LA0KPiAr
CQkJCQk8MCAwPiwNCj4gKwkJCQkJPDAgMD4sDQo+ICsJCQkJCTwwIDA+Ow0KPiArDQo+ICsJCQl2
Y2Mtc3VwcGx5ID0gPCZtdDYzNTlfdmVtY18xX2xkb19yZWc+Ow0KPiArCQkJdmNjcS1zdXBwbHkg
PSA8Jm10NjM1OV92aW8xOF9sZG9fcmVnPjsNCj4gKwkJCXZjY3EyLXN1cHBseSA9IDwmbXQ2MzU5
X3Z1ZnNfbGRvX3JlZz47DQo+ICsNCj4gKwkJCXJlc2V0cyA9IDwmdWZzY2ZncGRuX3JzdCAwPiwN
Cj4gKwkJCQkgPCZ1ZnNjZmdwZG5fcnN0IDE+LA0KPiArCQkJCSA8JnVmc2NmZ3Bkbl9yc3QgMj47
DQo+ICsNCj4gKwkJCXJlc2V0LW5hbWVzID0gInVuaXByb19yc3QiLA0KPiArCQkJCcKgwqDCoMKg
wqAgImNyeXB0b19yc3QiLA0KPiArCQkJCcKgwqDCoMKgwqAgImhjaV9yc3QiOw0KPiArDQo+ICsJ
CQltZWRpYXRlayx1ZnMtZGlzYWJsZS1tY3E7DQo+ICsJCQltZWRpYXRlayx1ZnMtcnRmZi1tdGNt
b3M7DQo+ICsJCQltZWRpYXRlayx1ZnMtYnJva2VuLXZjYzsNCj4gKw0KPiArCQkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gKwkJfTsNCj4gKw0KPiArCQl1ZnNjZmdfYW9fcmVnX2Nsazogc3lzY29u
QDExMmI4MDAwIHsNCj4gKwkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg5LXVmc2NmZy1h
byIsDQo+ICJzeXNjb24iLCAic2ltcGxlLW1mZCI7DQo+ICsJCQlyZWcgPSA8MCAweDExMmI4MDAw
IDAgMHgxMDAwPjsNCj4gKwkJCSNjbG9jay1jZWxscyA9IDwxPjsNCj4gKw0KPiArCQkJdWZzY2Zn
YW9fcnN0OiByZXNldC1jb250cm9sbGVyIHsNCj4gKwkJCQljb21wYXRpYmxlID0gInRpLHN5c2Nv
bi1yZXNldCI7DQo+ICsJCQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiArDQo+ICsJCQkJdGkscmVz
ZXQtYml0cyA9IDwNCj4gKwkJCQkJLyogdWZzIG1waHkgcmVzZXQgKi8NCj4gKwkJCQkJLyogODog
bXBoeSAqLw0KPiArCQkJCQkweDQ4wqAgOCAweDRjwqAgOCAwIDANCj4gKwkJCQkJKEFTU0VSVF9T
RVQgfCBERUFTU0VSVF9TRVQgfA0KPiBTVEFUVVNfTk9ORSkNCj4gKwkJCQk+Ow0KPiArCQkJfTsN
Cj4gKwkJfTsNCj4gKw0KPiArCQl1ZnNjZmdfcGRuX3JlZ19jbGs6IHN5c2NvbkAxMTJiYjAwMCB7
DQo+ICsJCQljb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OS11ZnNjZmctcGRuIiwNCj4gInN5
c2NvbiIsICJzaW1wbGUtbWZkIjsNCj4gKwkJCXJlZyA9IDwwIDB4MTEyYmIwMDAgMCAweDEwMDA+
Ow0KPiArCQkJI2Nsb2NrLWNlbGxzID0gPDE+Ow0KPiArDQo+ICsJCQl1ZnNjZmdwZG5fcnN0OiBy
ZXNldC1jb250cm9sbGVyIHsNCj4gKwkJCQljb21wYXRpYmxlID0gInRpLHN5c2Nvbi1yZXNldCI7
DQo+ICsJCQkJI3Jlc2V0LWNlbGxzID0gPDE+Ow0KPiArDQo+ICsJCQkJdGkscmVzZXQtYml0cyA9
IDwNCj4gKwkJCQkJLyogdWZzIHVmc2NoaS9jcnlwdG8vdW5pcHJvDQo+IHJlc2V0ICovDQo+ICsJ
CQkJCS8qIDA6IHVuaXBybyAqLw0KPiArCQkJCQkweDQ4wqAgMCAweDRjwqAgMCAwIDANCj4gKwkJ
CQkJKEFTU0VSVF9TRVQgfCBERUFTU0VSVF9TRVQgfA0KPiBTVEFUVVNfTk9ORSkNCj4gKwkJCQkJ
LyogMTogdWZzLWNyeXB0byAqLw0KPiArCQkJCQkweDQ4wqAgMSAweDRjwqAgMSAwIDANCj4gKwkJ
CQkJKEFTU0VSVF9TRVQgfCBERUFTU0VSVF9TRVQgfA0KPiBTVEFUVVNfTk9ORSkNCj4gKwkJCQkJ
LyogMjogdWZzaGNpICovDQo+ICsJCQkJCTB4NDjCoCAyIDB4NGPCoCAyIDAgMA0KPiArCQkJCQko
QVNTRVJUX1NFVCB8IERFQVNTRVJUX1NFVCB8DQo+IFNUQVRVU19OT05FKQ0KPiArCQkJCT47DQo+
ICsJCQl9Ow0KPiArCQl9Ow0KPiArDQo+IMKgCQlwd3JhcDogcHdyYXBAMWNjMDQwMDAgew0KPiDC
oAkJCWNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg5LXB3cmFwIiwNCj4gIm1lZGlhdGVrLG10
ODE5NS1wd3JhcCIsICJzeXNjb24iOw0KPiDCoAkJCXJlZyA9IDwwIDB4MWNjMDQwMDAgMCAweDEw
MDA+Ow0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRl
ay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwgTGluDQo=
