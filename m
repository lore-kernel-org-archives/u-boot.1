Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A996EFEEF34
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:15:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F20FD840BE;
	Tue,  7 Apr 2026 15:15:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="cKP6dmQr";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="g5C57f65";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E6B078412A; Tue,  7 Apr 2026 15:15:14 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7374683F98
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:15:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: c9451b28328311f1ae70033691e9ac7d-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=iXxsUPSWa4eVAsx+d6NN2i+YVRuI/UeqZS353upblIM=; 
 b=cKP6dmQr83zTbnTeinYi+6m2Lu922fUql3pfZnT8gmqgnmpOXlcetKw6VwVIUUlbuhT/7O6qGzqd/c6uAHhU5idk3OQumIhWW8bJD1nV++F+ujat3GEVcMW/wu8cN65SfZgz85fqZ/YHjUhluNi3L1L4l9mcmG7L/sqj5k5/fYI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:edc741a9-d318-4f0a-a782-c2ce2e6a46a0, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:a5dd94d5-060f-4ecc-9ee0-121eeeb4a682,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c9451b28328311f1ae70033691e9ac7d-20260407
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1716651497; Tue, 07 Apr 2026 21:15:02 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 21:15:01 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 21:15:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpor2U9WALi5x642e8CNLkH6wErMBsnVE9vy7c9lywSps/RGnPNGwdfqLXzsnbN1G7bo5Z2d6UEVnLK+zST4pO+ijb4f41oHkcuX29jQMQXLXZQ9GcU2VKt+hHx2vZ2bbv/v/n6aac3o7DLXuHpIq3C7A3HfFIsklTI9drdRIMZTertHVSWMzhCACL0uy1ldADh5p5NAYKDg6P0xbdq2PrRnOqkXRFmIiH+5/rV+/JufbmKgHRjSAXPbe9SLuGNmECUh+Bi7so0fMR2HDVdHjQEwJ/zoSxMRIRPBxdYRO6PDr7+ec/hIvZuNdehjX0IVyRMKZ6JS4CvwKLZVmWlQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iXxsUPSWa4eVAsx+d6NN2i+YVRuI/UeqZS353upblIM=;
 b=IXHqrMiTnZw07VWITDgDEX8lVvIxX4193zoWIvYH4dyVCwMI3Zg9v/blqJU/Ch+v308CcRIBFFnu5eHixjw66Kztd/9CAylmaXZjomxYYxv5CwEz/wNnJmkt6jCkdxDAwnREvrCTs5zM78O3HCOy7ew0eIzyKO/t9Xi/QGrjuaXr+PEYeUTzaEKSngW4VnUsFDIuFhLv74/vcN+SQFMkEpee4EUpAWQrLid9L53jHOWHzOYqy1z6LJs22olrlnbbwZJJnGtEO7SBWtG3F5BGPwTe0fLiRid+uSvqKIkJMAbgeGwu0KOTja7pUQUOn67ITPVi90wkZM8Kk1vRHwgzLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iXxsUPSWa4eVAsx+d6NN2i+YVRuI/UeqZS353upblIM=;
 b=g5C57f65EG37ncoYABWfadMJl8b7DPJe8m3gyUQAg1vpCnnHFauCxIomsYuDRfR+7CVAi64MQ6djQ/3eMvNkyjBh8xvso1UvOKvqOa/AKQgN/AUhMPheURv5AYb9OELPlgiiR9KoJvoA6mDoEqiYiZziWQQCRTmWCv7bTniOCJw=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KU2PPFF748F2C7E.apcprd03.prod.outlook.com (2603:1096:d18::432)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 13:14:57 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 13:14:57 +0000
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
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?=
 <Ramax.Lo@mediatek.com>
Subject: Re: [PATCH 1/6] ufs: ufs-mediatek: add mt8183-ufshci compatible
Thread-Topic: [PATCH 1/6] ufs: ufs-mediatek: add mt8183-ufshci compatible
Thread-Index: AQHcwIXxVkaLpwd5AkS72+cxcAKNqLXToAIA
Date: Tue, 7 Apr 2026 13:14:57 +0000
Message-ID: <b99dcfa403cbd5ef588c34998aaaf61a4699ef3f.camel@mediatek.com>
References: <20260330-mtk-genio-720-ufs-v1-0-3bad8362ed70@baylibre.com>
 <20260330-mtk-genio-720-ufs-v1-1-3bad8362ed70@baylibre.com>
In-Reply-To: <20260330-mtk-genio-720-ufs-v1-1-3bad8362ed70@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KU2PPFF748F2C7E:EE_
x-ms-office365-filtering-correlation-id: 3836b01b-1be0-45e6-c492-08de94a7aa8e
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|921020|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 3h2YyTVMP6JrJF+/o4FLLeufatqRdjFyaIcxZl5eX290Rs0gPqIPmWWVun+bBO+LSOTwSpDp0qEuuBrECcGRrgUw7BPqjzCkDqQF/fAicO7AfTkAz8JnDMTz+6d7nErrfzqSBPlwbq59JtUUFiNr6CR5OtTeF5e7pJi/2YVRjU0twRhEH0TpznQs8jpams7JPGNMgflk1by8jqOrEQmzkUWjlsrq4wWPCeygFjK/pcDvbgpkNN6ndnYEOB/Mg4LXqPGbh9CSbdBnEwFyxCg69pxiH8OOzyZsbgUL0mHEYbZ8ce8elOWVbBoz1k+VHrDJf/qD3hdJ9dBoAtK5Kq2shXmMj7fHeepbUs181gi34ODcSdZuuIc4+yi6PCHWKw4FAGO7MRrh92jJ9RKRgSkUM0twS5zIaIOgnPC7mvExGRIe3GaSQSjyx8W6cHVHTfR0BMMXFe+pM7Y4+jpc/UesZaR+e8ClCy3knImbTTjthxx+DNshARNkmVAZsi6AfoM027ayKulY53kp5W9jGsop7d7Lah1RfjNga5vfmImeLqh6lQqammOoLoPbI64hePoly6ets1WlKyY7yncEtKZA7HRfwfKVIMdyc/mcq/5OX0E2+cxHg/3LhlKSRuxwg0M6t565l5u29hQRKVrS0f1O+rXmHWhRMLL219AVH0DWy3fedUbbB/UzJvDuC0ju52AA4aEIshGaAXY1AF8oCdfFmLNnnUSChMUBdMTUavfXPi+ZfaB14Egg2uEXCbnOSrHjS+dJofSYheu+Go9ay5NgpB9uMZZ210xRdpTcT62qMp4Hg9M0cb/QqKO1+Lux7JzE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(921020)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUFKaUptV0V4TFR4UHQzNHNlWU5GQWR6NnBNaytRUXZSeFk1cVRDcE9mT2lm?=
 =?utf-8?B?V0F6RUw5RTZacFRkdkxnVjM5UkxqUU1wYTAycEpEZ0RSQnhsbmE3R0xrNmYv?=
 =?utf-8?B?QTNRK0ZhMER5Uk1ydHlwUG1pREhMc0Z6dExaYjIzTGVjWmFGTWE0UnJSWlRO?=
 =?utf-8?B?d2c1dW1IeTdFUmRLTUREaWdjODV4NFQvL2FRNy9QRnl3alVsMm9rK01rOFZB?=
 =?utf-8?B?Rm1FazNJOE1jR1NIeW1qWFJHb21BbE1Gcm4rYVlCOEowV3FUK3N5cGhjU1Bj?=
 =?utf-8?B?M2w2d0VZOEhxa3oxWTkvQndETkxqa1I0bjhpdkNkNFBzSjlXL1BrU0g0Yi9N?=
 =?utf-8?B?UlVkUjRORlNOYTF2blN3TmI5NDhFaVMyejNhd0xyQ3JlTDY1WlhvV2NxbDZi?=
 =?utf-8?B?TndHbXVZQjZ0djI4Z1cyRkczbXo1NDdYMUtUTXJTUTR3MG5NalBybTVoWmEx?=
 =?utf-8?B?RlR2VGg2dDd6VDBKc0Q3OHBrQXo4MGtuOVNxZTdFdFZvWCtiM2cxZVhPbmtH?=
 =?utf-8?B?WGtaRmtWYzIvTnRJZjc3Sm5sd2RtUEVMRW8veE9ncksydGFGWG0vd0hiQkNN?=
 =?utf-8?B?MHVRbzU5dGVzelIvc241ZFNocVcvSHkzdnl4NW9UemU5SFJ2ckljQVh5a1Jl?=
 =?utf-8?B?OWN5R1JnWjd0V3ZETXlNZDl4b3Z3QUZUVG0rMTFubExMdkpWT3MzcVZRZlRV?=
 =?utf-8?B?eHVSTG1lcHZHMDNKcmp6dUxxM0d0RHBZbEMwNTZmU1ZObVRZdHhMWm1IYVpO?=
 =?utf-8?B?S0s0ZjhNdGVMa3RnaGN1KzNjNnJSL3ZLZkw3SDlwc3BCaUU0RlgzU2ozWERF?=
 =?utf-8?B?VFpPMkh4RThOZnZXQmJzUnA1V0g3dWhla3F1aHVuM05Oc2VKQ0Yyc09vOUdz?=
 =?utf-8?B?aXdyalZNY3AreTFQcnVKRGxhczluTzdjS0VVSk93OFU3b3ZUb25ZbjIwUTU1?=
 =?utf-8?B?enhUd21CZnAxVGNvelhxeHhLRTR3d0lyRjh6K0VlVmFhZzZySmlhV3ZJZEVj?=
 =?utf-8?B?ZjlVeFRnVUpnUW5UbUxsL3dvQnBaQXdvYUFVQnl1NmdPaUszZm5BcDhoM3FU?=
 =?utf-8?B?L0Z1eFhZeTNmeWlZK2U2eER3aEQ3RHFjNHludEpBWFE5NkpXVWVmOGMwcXVh?=
 =?utf-8?B?RUROckZTbm5ldWZ0WWVTczFjbmNCcXlBM2RTb1c2VllXV3RadFc1UWZkVnZN?=
 =?utf-8?B?MGc4UWc3eVJ6WEdYSmNyTWozVU5tcE55VHozdVh6Ti9NRi82b0JHcG9zdnlo?=
 =?utf-8?B?c0ljenNwR3crd1puRllUdENjaUlseXBlK21hVHhWeC9YQS9sL003QTg0dkwz?=
 =?utf-8?B?N3p1eEJZb3dPbkZ3QTE3KzhFRmV4VnMyWGVsRHlxVkM5S1lVbnhKMTg5WFJ4?=
 =?utf-8?B?MHlkMi80dUEzK05ieTVrcVRtTWZubHRsVkt5a3lKWTZZU2NxYVlWWHNVK2Ro?=
 =?utf-8?B?Z0JKS214Mm9adjJtd3I5YktaSmlkUWE4QXBtTkZLeTNVUVVZK0VPVnFMeGRz?=
 =?utf-8?B?bDJMZ2lianJUMGUrNnc2T1Q5S3UxbU84dEVlRityc0N2OUl3dGNQY1BMRDJY?=
 =?utf-8?B?UDdrSTBTNmFxVW5PeWxEa244ei9JTXcxN09Wc2pmb08xS0JDYlFBWE5wd3ZZ?=
 =?utf-8?B?L2JBZjUyZkoyQkdjcURvWkNoazk3ek1BeXJIZjRvbHl2dmFzcXFWQnM2dkJU?=
 =?utf-8?B?UDNwcEdpbEFvVk0rZE15anhTQkdoRXhGK2hrd3dPd3A1ekpCQTRUbXlMM0Ix?=
 =?utf-8?B?V1d1aWxqL2o4STNkZ1Q0OWhSeUNIN2FYMGhraEdCbFBTQmJsS0J0WTJCWVRl?=
 =?utf-8?B?OERDR0duYW5QakltUU95aWVrN0huK3ZyVHFRQ1FqTFg2NXRqRXYydElKZHZE?=
 =?utf-8?B?SDh6SmZzRmpudExLbFhIdHI2S1cwK0JleHhMcDViaFI4U2g2NVovTUdKSmg4?=
 =?utf-8?B?cDNNdGNLYzlNa0xpaVQrOG5sWmxTOWdSdHJxWHRQRDB5TUY2Z21CWjF3Kzdr?=
 =?utf-8?B?RUpqZVlxd1pOZFp2cEtvak10dWJRTFJuOXJWeThqbEhDR0pUMWZFWWlvUkNM?=
 =?utf-8?B?VjhQSTJGVFdzY1ZZUmMwSmovYkljYmxBVWZQN21JcFBXM09JNW9ncmFVeFlI?=
 =?utf-8?B?ZWZUWnZ1K2xVNjR3czkrdU5YQjEvMXNKdEFnc3RZNjQycGdWM3RLeHFlNXVE?=
 =?utf-8?B?TnhSQkcyWkNWbS82RjBIVHc5WWV1SDErWGlEcnR4c3IwUktpVUhBWXVpV3M0?=
 =?utf-8?B?eXVXUFlkUjA4UG5FNGdVYVgyZCt6SDRPaHE5bUg1UzhQZHR5eDRpWEFlSUJL?=
 =?utf-8?B?V3I1ZTZOTThTK0tBbWs4RUJRTGlqVE1rckNtR1Q4Ky81SUtNWDdiRXhDallv?=
 =?utf-8?Q?PgGbHexn8/iEsQS4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E154ACC442F21748BCA4A706A4DB024C@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: VKEbdPM4IYAPAcNnmrQfFGFmBy2SpJKuF5aUgqfqvHroqtnUicIFaCyP5qYtjdj1yjNr2Nb2bf2alR3f5EGfzFP9zYpWZ/7e3ypPqtmwEmF9vhcJuaY2Ii9x1IRZRStt6NHhMzD4V5k/OZbZ7uiQ7qkJeJWaCFCa4PNh/Vy891h7aP7uZwL2f2tf76rbdSCCiYezGA2xr9imm8VUYJz/wCfRci0qEMzXtpqh71iNEj4iWkH/xiToEgU19dSS/VOaWi+V2fv6FFgxa7CT+/UWpeQD8a8P0K3gl7ERHXSxuzWm3Rq7a41LRV46psy84Ikr9eqC6qXqaNFICaKP7aMt5Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3836b01b-1be0-45e6-c492-08de94a7aa8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 13:14:57.4772 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UueYceH3zBY9lMoGIVpUCstm7upwe0iPW/H1qrBWTFIe7/QjjAXq4Pc/6SGA9j3SLOEkwuuuTarmbA9yQzvyUYTovYjF22QhIJpZadvlL1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFF748F2C7E
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
PiBBZGQgYSBuZXcgY29tcGF0aWJsZSBtYXRjaCBmb3IgbWVkaWF0ZWssbXQ4MTgzLXVmc2hjaS4N
Cj4gDQo+IFRoaXMgY29tcGF0aWJsZSBpcyBhbHJlYWR5IGRlZmluZWQgaW4gdXBzdHJlYW0gZGV2
aWNldHJlZSBiaW5kaW5ncy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRs
ZWNobmVyQGJheWxpYnJlLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy91ZnMvdWZzLW1lZGlhdGVr
LmMgfCAxICsNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3Vmcy91ZnMtbWVkaWF0ZWsuYyBiL2RyaXZlcnMvdWZzL3Vmcy1tZWRp
YXRlay5jDQo+IGluZGV4IDI1MmM1ZmM0MzE4Li4yY2Y2NWEzMTg1YyAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy91ZnMvdWZzLW1lZGlhdGVrLmMNCj4gKysrIGIvZHJpdmVycy91ZnMvdWZzLW1lZGlh
dGVrLmMNCj4gQEAgLTM5NSw2ICszOTUsNyBAQCBzdGF0aWMgaW50IHVmc19tdGtfcHJvYmUoc3Ry
dWN0IHVkZXZpY2UgKmRldikNCj4gwqANCj4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IHVkZXZpY2Vf
aWQgdWZzX210a19pZHNbXSA9IHsNCj4gwqAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDY4
NzgtdWZzaGNpIiB9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTgzLXVmc2hj
aSIgfSwNCj4gwqAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtdWZzaGNpIiB9LA0K
PiDCoA0KPiDCoAl7fSwNCj4gDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5s
aW5AbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MhDQpNYWNwYXVsIExpbg0K
