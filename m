Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 488E3FEEF51
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 14:40:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9968483A41;
	Tue,  7 Apr 2026 16:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="uS+DHei3";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="E/oZd4mb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C26D8840B0; Tue,  7 Apr 2026 16:40:19 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCDAB80433
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 16:40:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: af78aeba328f11f1ae70033691e9ac7d-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=tpbubEEdkv8haF1dC4gENrStC+E87RO88xbv77UTwuE=; 
 b=uS+DHei35ZU3fNvdTkmNPAYRTi/BqQO92shlr5xjkC0S7A8hsgl1ieCe/nMtCECGu3DBh6M7DHpCtwC5l9gTO3f/XQrv+DGbJ4hcxeht99AQ3VNZukUBfjYPsXUjBrQXQ3FcO5Gu+jRKzsHamsC7e8Q1GWfhm10LpQG9qSAkcMA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:b4210a77-32f9-47bc-94a4-c1c2d73226cb, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:a756258f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: af78aeba328f11f1ae70033691e9ac7d-20260407
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1366768399; Tue, 07 Apr 2026 22:40:13 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 22:40:11 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 22:40:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=moJkYLht4WzSKteFUK8qf6AIyiPn2P9fdtJKRxEgh4Fivbi8zAlgDhNBfVMuaMj3gErUHLlaNDOVxDpjeV5VXTht1RS/26bePh5a9nLpZY0MohugcSd43oKuQpNe9rPXQ1sP42kDSB3Aexn2FJtBvUwOj/maslfre+fZvu+8mBRdVTBK9KmjV8J0GksHQ6KWTTgXCsw4oy+6gnqXBZwrRHJQaOhwXUCp+oAkfkR/dMp/SmlrRiKMnlvjI1ctlLcY6ruX1U/FGp0yymjmJkMaC2TK5rEDjCFbQf94QaeefNQ0+eZatzFlo5+/SFYuaEuuQNbAXMO5Q56r8jlwG5cngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpbubEEdkv8haF1dC4gENrStC+E87RO88xbv77UTwuE=;
 b=kARbqIE5kjnYeQ/zywurYv7+DMowoOcp4vO70rGLtNVlQaNGV3WJHjA4hwHYbHjwY5e8ldOwnIMpBzbmFPyMocBdHKyS+F++7CH0E64RaUllvIZU2PW/PcSpJwwbmZ2rfdaIaWr4YKGElWtYYlLRlN3geRiWptVfSN0x0mxcMS4SEsMG1McvawrzdQHa8TJeqXkzG8amREb6jDimyufvuxhK67KZ4dTAsqIou427MtDKqt9ahVW+HpvoxuVpdYe1wYZMZZEm/tq5XpJra1fz9EPCTX9SK/B1Wiu8IJn4MM+phgE0I02uhXLk7/EpeOt05aEBftnojvknlvcabOLdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tpbubEEdkv8haF1dC4gENrStC+E87RO88xbv77UTwuE=;
 b=E/oZd4mbGO7e8UFRR3dKFPxleb6ar2j6GofncWawY7xAOZutj6MaRsr9IJ8sUg5F/XD4yr7kKD4zuhpW9xqtQiPMfwIg2SNPrMrhjkG1SWC/mwa4onJYzVHNey5x6HT1XPavE5QeBrMx/WTCJ1mEikVR8ksiF76BP0iR4Ck7d2M=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYUPR03MB7180.apcprd03.prod.outlook.com (2603:1096:400:355::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 14:40:08 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 14:40:08 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>, "David
 Lechner" <dlechner@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?SmlsbCBDaGFuZyAo5by15paH5r2UKQ==?=
 <Jill.Chang@mediatek.com>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH v2 2/4] pinctrl: mediatek: mt8189: fix pinconf bias
Thread-Topic: [PATCH v2 2/4] pinctrl: mediatek: mt8189: fix pinconf bias
Thread-Index: AQHcwF6megrGm6I0XECa63pbBRwv77XTuBwA
Date: Tue, 7 Apr 2026 14:40:07 +0000
Message-ID: <ba770ad672fb585be763d8dd2c37556a526bf49a.camel@mediatek.com>
References: <20260330-pinctrl-mtk-fix-mt8189-v2-0-05a737ec623d@baylibre.com>
 <20260330-pinctrl-mtk-fix-mt8189-v2-2-05a737ec623d@baylibre.com>
In-Reply-To: <20260330-pinctrl-mtk-fix-mt8189-v2-2-05a737ec623d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYUPR03MB7180:EE_
x-ms-office365-filtering-correlation-id: c563ee7a-ec85-46bc-98a6-08de94b39098
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: nf3jF1iduz/llMEAX+/klT8cnl2Ggiv/CLK9oIrHaYzgfvl+GocNzn8S94QYTYOC08TxmO9Qans6eheEW2Pfphiyd65kR8kTfcwFJ0rJPoyhR5wZOEyu77Bils8+1qsQespcaoDiTbq7CwgS3zYyuaqTJwA2NE/Yq5ubibI/KdUlbdwMHI5I3UnB2OIyWg0tc/TrHDH+azqvhMaH/G8aKPdpnSY9YT7QIPecvKZ01usukJNUKM9lVgcIb5cqCGQFtIG5O1L39zosv513lntzmOOISZ7QkBiNE3ZvocXrZmbEkKdvUguc1YD8TVzmcpRCSOCTeISUitb44z+V412TQc3DC4zg9/JjAgf0s17VNTW9jC+FcUh0jjvh+5j6njboFcXqasAVuz9aBBj+o85CsRSspT3/H8P315ECKPdHaed83t4GibKAbL9IKvjmQWQZkjo/UP6smqsobUHnAfZWa0KMKHhPg2K+cjCWSOCXCx1Q6LesWY5CRsKPMQlB9neCWmROYoAgyoKnCAAwGLRQD3tWBSefDKu2MZYAdC3qW+zsv0phkZJT7QDUQTkpj/amJ3xjuLfd6Huw3cJK6iIRShGgqNLYl9Z4dLjNfYu14U3P5A56X7wVtVm0cHI8/som439tJW/0qs/7bwvJX/wXJoobv5QxmeMW9H8MGLR7ypLleYWYEuz+qssfov+0B/iMdnzi68B9vdjXEwrTo7312f3OqWGKsaOvPIpH9tJj/RP8g+bDdVWuEkMxwdNGPFZO4YhO+LdI6k0lOc3zP09Twfpzl2U5tGpAGvLlvGHVt+0=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z2Q0YnlILzVDcVBoaGw0cHpwVUpnVWU5eEthY3RLSS9nV2haWnMzS2tWSllX?=
 =?utf-8?B?WDhkMms3UkJTQ3IySnRrZ3VQekUyMmxtSDRRWjQ0S1VWY21XMjJvN2FHcXFJ?=
 =?utf-8?B?YUZQa0J4R2tvL2tBZUNDeERZS095TnBNQktVR0hpQ0dHTUhDT3JxL1NpS05p?=
 =?utf-8?B?Mmo1Zlp2dU02MTdZSUVFbFNZdEtVbDNIZjEwNWZ5eUkzaSsreTA1aXlmeUJx?=
 =?utf-8?B?RlBqcndDVUtGT3FJUUZxak9yZ29pZ1VQRE91ZlYyUkFJQ084dVBkbXkrVFFN?=
 =?utf-8?B?OVE5M3laS1I4bTRPcy9pRC9YMm1iRmVlMXJwT3crekxmN2xNOTQ4RXhEeHVv?=
 =?utf-8?B?Sjg4eDhtbk8vOEhjOHVWdm01Q0d5WGV2RDE0UEoxVlRvSGk3QVZQd01CL0Np?=
 =?utf-8?B?eCt6VU1DMjJDRzFnVzAyUGNUUEcwWEpXbUVoMkJ5VVZQZ0h5WVRvQkRDaFRK?=
 =?utf-8?B?dXRNSmhGTjBzdzJlS1c1RUdQaVpkTytYVkZxSm4yS2paVUlmWVhGNDh5UmQ3?=
 =?utf-8?B?bjJFNEcwS2pVU2lhbXJWcUVqVTlKSy9xeFZrRm5laGdEdk0yNkIzY1NDU3Rw?=
 =?utf-8?B?UlRwZnd4SDQ1RGJMKzRQR21pajF3WWY4VkVWeTdQR1U4V2hEYnY2TFd3VDly?=
 =?utf-8?B?MExIaUpKeVlHZ0dLZm5oNFdpbUNTOUwyU3d3NVlPZy9KWmR3UStlNUdSb2xR?=
 =?utf-8?B?QnRSZmNnS0U0aUM2QkpjVkxqL2laYWFvaXRZbWFVK1liMVgySDJkaTdBdms5?=
 =?utf-8?B?cWJnVGF5SVYxY0kzOENPd3RHa1p6R0Frc1ZmQjR4bGlGYXBvcmV4TC8xUmhk?=
 =?utf-8?B?YjNZMFlCVE0vWGovUHpSZ1dWUkxsdXZiUkRzbldrWmJmcm56VG1CNmdKWEtJ?=
 =?utf-8?B?cCtGdzhiMjdOQmFObUhrbm5BL0w2dmtWVUhBMFlabjJOUnNZOWRRTGNhOGdU?=
 =?utf-8?B?TFBaN1ExR3NpeEkzYXZnVHFyRnczbGVrMEJaUEU3YSt4R2dJL3ZGYXg4MXZR?=
 =?utf-8?B?N25MeTViMXF2WUJRQ0RDSW1Ra2NtUlNsdnd3cXlCc3pTTlNFSUl5TFZxSjhQ?=
 =?utf-8?B?b3lCYUx2VVhCaStpRmdoa3JlQnRFTWlza1NEZnlZM3J1bXBwTlY5L1FOQlhh?=
 =?utf-8?B?K1hvdUFzZzZvbFZmRkF6ZmR5ek00K1pZbDVRdmhwbHh0YlllYTQvTXNJRjlV?=
 =?utf-8?B?WDk3T1ZtUGtuOXBoRTVybE1oL01CZS9oQktENWZ3SENrckhLVnVWZW9IeFg1?=
 =?utf-8?B?YU15RkZSTDh2bVU5MGdMV0RYOXhacTgyYWg4WGFlQU1wSGhhb2hreVVUWG5x?=
 =?utf-8?B?Y2dVcnlqSXp1Z3NKeU11V2VUQitET3pkQ3lJM1hjY29FazdSYUhsQTBOZHIv?=
 =?utf-8?B?bm5QSnVySXRFUU5GZzFBR2hoTjRHb1pmN1hocXBhNXRybmF6dkJxUWhJQUN5?=
 =?utf-8?B?ZExoanRzOU0rUS9rczRkR09pcUJDNkpmZzFCNHBJcmMxNEpYcnVFZEFyRUpr?=
 =?utf-8?B?ck9FSEs4RkFXWFZ6MkErZzY5WjlFcUVOQmljSmRpaWRyTVZEV1RmUE5QUDhv?=
 =?utf-8?B?NXhaSG1IL09xOHFLVjNsd3I0WHNlY1dRRUtlLzhOZ3FtTm9JN3Z2ZldBcjJF?=
 =?utf-8?B?Rk5INUNEQTZUeXZhVDRlZzE1enJQRDlYMHgyeGg3QmNXYTZoWHI4MlNpOGo5?=
 =?utf-8?B?eVZiRGp5SWZ5TU5ZTW5HWTlJbHg1WXkwSk9McFQxWTFiLzFteXBKRHYyeW1L?=
 =?utf-8?B?dy9IckN2YVJCZlk5TWwrbkovS3Uxd0owemxMK0w4UTVFNE5MZDkvVzdad1lG?=
 =?utf-8?B?N2ZOMzJvZjZVZWVBRnJKOXVjVjhvYVVkR3dQVUVkLyt4clB6a2VHRVBaU0ds?=
 =?utf-8?B?ZTNQZ0ZkNUlDR0p2ZHIzMC9ZOWh1anV2Q0V1OWhnSWNvYlAxMEhLSEVzcEI0?=
 =?utf-8?B?bTRiQkxocXUwVkdKY2ZnV2ZxUmtLZFFKdDNNWHpFS1EvWFQ5UkRGM3lEMm9D?=
 =?utf-8?B?UTc1K2IzZ2VXbnBGc2pMNkJ2SE1aVldDcmJQMHArQVV4ZmlFY1VEVmZvbHUx?=
 =?utf-8?B?dEN3WFlLQmZNN0puNXNlOGh6TG5vU0l0SGQ4MmVQK0NQTlNnZmxEenAzTkRa?=
 =?utf-8?B?ZlMxaCtsbklhcDVUaVIvNm81Nk91RUVQbDRITVpiUG1kN1pxKzNHQi9aem94?=
 =?utf-8?B?eUZ2T0VHSEpIL0VpaVJ2WDZXQzZ6N21aV3g5S2o5Q1hId1NoT3BpQXN2djk4?=
 =?utf-8?B?V2p3U2NSN1FjUldTaEF0RWxOVFZpYnovbFh1SHd4YzNwbE0yNzMwUEczczJs?=
 =?utf-8?B?VnJ1RXR2OWVPRktkS083WnZHdkFJcGhXRGdlVVlSeXRjQ05tM1NCd1dFWlhh?=
 =?utf-8?Q?nlBT2QwjGCjWdg/E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48FAA5F13154D3428978D897C1F96762@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: oRbNJu6zz/tCop8Yv4d8VvKHXXNaAs3MjzpQYRpRapYelDugg6qnK5MHRCSWPzeESnTlwVn/kzI1HdbSDGUrD9s3zgXdCWr460XeFBaRNKgyvxnP3EtTOJU9UzFZ0Ubtf7jjanpF6W+Kc5HNucYTVC4V5CAK1O/FQo/E25mlQIxM2LPF2kyX+zRD8/lgjLDDa7bNXJECdVj+lMa/F6N9xipYJJ33Lf8LTcLM4fsvuIW+Pg/RtVrmYu1rDaOJhr3mXXwLXY1hrBhjWDX61dRj3AjaWp7d4/wNKhg5v9PyKdM38MjxJoC/dsRsrEnUCe1uFLqJzSNKgAClNM8i6kS6Xg==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c563ee7a-ec85-46bc-98a6-08de94b39098
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 14:40:07.9097 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fUKCwA+yBiijrG9R8TZq/e1QAObSbkih9OdKH494XqLLz+PpIGTlbzA1SUBYLygxaR3OexQ+NoV/wviWCK5YjxVTz9Usx+pmxq9zdYOVO1o=
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDExOjAwIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBGaXggc2V0dGluZyBwaW5jb25mIGJpYXMgZm9yIE1UODE4OS4NCj4gDQo+IFVzaW5nIG10a19w
aW5jb25mX2JpYXNfc2V0X3YxKCkgd2FzIHdyb25nIGJlY2F1c2UgTVQ4MTg5IGRvZXMgbm90DQo+
IGhhdmUNCj4gUFVMTEVOL1BVTExTRUwgcmVnaXN0ZXJzLiBJdCBoYXMgUFUgYW5kIFBEIHJlZ2lz
dGVycyBmb3IgbW9zdCBwaW5zLg0KPiBNU0RDIHBpbnMgbmVlZCBzcGVjaWFsIGhhbmRsaW5nIHNp
bmNlIHRoZXkgaGF2ZSBQVVBEL1IxL1IwIHJlZ2lzdGVycy4NCj4gSTJDIHBpbnMgbmVlZCBzcGVj
aWFsIGhhbmRsaW5nIHNpbmNlIHRoZXkgaGF2ZSBQVS9QRC9SU0VMIHJlZ2lzdGVycy4NCj4gTmV3
IGdyb3VwcyBhcmUgYWRkZWQgZm9yIE1TREMgYW5kIEkyQyBwaW5zIGFuZCB0aGUgYmlhc19zZXQg
Y2FsbGJhY2sNCj4gaXMgbm93IHNldCBhcHByb3ByaWF0ZWx5IGZvciBhbGwgZ3JvdXBzLg0KPiAN
Cj4gQSBuZXcgdGFibGUgaXMgbmVlZGVkIGZvciB0aGUgUlNFTCByZWdpc3RlcnMgc2luY2UgdGhv
c2Ugd2VyZQ0KPiBtaXNzaW5nLg0KPiANCj4gU29tZSBuZXcgbWFjcm9zIGFyZSBpbnRyb2R1Y2Vk
IHRvIGF2b2lkIHJlcGVhdGluZyB0aGUgc2FtZSBpbmZvIG1hbnkNCj4gdGltZXMgaW4gTVRLX1RZ
UEVEX1BJTigpLiBUaGlzIGFsc28gZml4ZXMgdGhlIHNlbWFudGljYWxseSBpbmNvcnJlY3QNCj4g
dXNlIG9mIERSVl9HUlBYIGZvciB0aGUgSU9fVFlQRV9HUlBYIGZpZWxkLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiAtLS0NCj4g
wqBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvcGluY3RybC1tdDgxODkuYyB8IDQxMyArKysrKysr
KysrKysrKysrKy0tLQ0KPiAtLS0tLS0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDIyOSBpbnNl
cnRpb25zKCspLCAxODQgZGVsZXRpb25zKC0pDQo+IA0KDQpbU25pcC4uLl0NCg0KUmV2aWV3ZWQt
Ynk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQoNClRoYW5rcyENCk1h
Y3BhdWwgTGluDQo=
