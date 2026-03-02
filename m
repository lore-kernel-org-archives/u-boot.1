Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A92E1D58E47
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 03:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 921D183EC6;
	Mon,  2 Mar 2026 04:38:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="EvCIVVcq";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ZIVTI+ou";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A34683EC9; Mon,  2 Mar 2026 04:38:31 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC69483D17
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 04:38:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 3f92ff0015e911f1b7fc4fdb8733b2bc-20260302
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=13uPoUV8cjTrVvM1MVrno2iedN7ijLu5tEpVxGgBCqs=; 
 b=EvCIVVcqsK0TrwcDdBo3IozLJcLfRU1fBSnnjK8M9Nj5gfqvz20vFY8IgVePxiJXlam1QAVtyr+lR45IPsd71AkcXD771kqiIgVKdZ48NGH+9JbCEFGOXh3SY3dDxmEGgF3p27D09WnrawqtLDpuoGAlP/1TeGzi06kTepdo640=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:842838f8-129e-4489-ac6e-9822a6a71f96, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:8cfa24f1-16bd-4243-b4ca-b08ca08ab1d8,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3f92ff0015e911f1b7fc4fdb8733b2bc-20260302
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2117039598; Mon, 02 Mar 2026 11:38:16 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 2 Mar 2026 11:38:15 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 2 Mar 2026 11:38:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoi4V/jO5oqaEDfySWoCS2RE7tH5QRd0j2I2EMpgS3RhruMjrqT1mWoiEk7T/+fJkJjOCj6JS5kUeFmMmtXwMpj5Lndnr8toeUXmiBtGfqsBS+nrsLvVQPKkDwdYUpicXN/ce96TZ9HrdzYU1ZQdeYhsfKGVc69PkZsmXzus3EpdWDJT9jAl/EzbFI9veoeXStndUMkRYyRO4aRb8M3vxnnY48IXhdNcvMQ6vV/Jd65YGmD1tw1/SY1KYbQ+RoAJUT5RY+ttzSffD3fuPdh3x1jKa3LJ7T3wgCjxgaD59XM4d/6gFel8H6CBKfV+iSnibjjIBZZBwP1PSwSiRPge1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=13uPoUV8cjTrVvM1MVrno2iedN7ijLu5tEpVxGgBCqs=;
 b=At9YO+DPw+gRlIRllIlp86R5WyGMHxkoOUmCDXnA4lJM4FmXgfys8pwq8ALeDdvFZaU1RoLXeX+yy9LKDryoj8FIovrPbdvt3PbUGqFl2N51paeGjT0lKo3nDqPUKcpvikullkok90des4oJ2HLl5VMEsgfdAbIO6hgUY7Jd9P1XU4JU+BNGwhBty44N8GPYpQlXZ6yENNZ4oLEiHI8DSLJtrJj8VLTEW0WYrXAP0dhvIMgpNW/nQdyIMyf6GwBFHLfXUo7LHare2PFk9bsARpV0Yi1AjFkdi45SXgBofFGT6n91jgoG6GhqQwPc0owksYUpA8F1qVJI1/DncHUMKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=13uPoUV8cjTrVvM1MVrno2iedN7ijLu5tEpVxGgBCqs=;
 b=ZIVTI+ouJBa+Y6IFRALxAXtS6HkeSmU4SmkSXOyJR3b/b7XsOdAFz8DssPwbrbj3xuOpQ69VoZe8Dxtwnw0JPgBMPvusQmvt6KOU9ZimHiOOAtTQGhK0tkPSrZXAJ+sergD1vutG42BwdnSGrlYOcYpQfvaW1JcsKX5RV4HqP6U=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SI2PR03MB6757.apcprd03.prod.outlook.com (2603:1096:4:1ec::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Mon, 2 Mar
 2026 03:38:07 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9654.020; Mon, 2 Mar 2026
 03:38:07 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>
CC: David Lechner <dlechner@baylibre.com>, "mkorpershoek@kernel.org"
 <mkorpershoek@kernel.org>, =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?=
 <Chunfeng.Yun@mediatek.com>, "trini@konsulko.com" <trini@konsulko.com>,
 "Ryder Lee" <Ryder.Lee@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "peng.fan@nxp.com"
 <peng.fan@nxp.com>, =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?=
 <Weijie.Gao@mediatek.com>, Julien Masson <jmasson@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "semen.protsenko@linaro.org" <semen.protsenko@linaro.org>
Subject: Re: [PATCH v2 2/2] board: mediatek: add MT8395 EVK board support
Thread-Topic: [PATCH v2 2/2] board: mediatek: add MT8395 EVK board support
Thread-Index: AQHcoYci+bMg42X6FUWR45Ck/DZcA7WaqOaA
Date: Mon, 2 Mar 2026 03:38:06 +0000
Message-ID: <af3e9e30410efd09dca2d1801fbf24f1f951c845.camel@mediatek.com>
References: <20260219-add-mt8395-evk-v2-0-18b190d91cb6@baylibre.com>
 <20260219-add-mt8395-evk-v2-2-18b190d91cb6@baylibre.com>
In-Reply-To: <20260219-add-mt8395-evk-v2-2-18b190d91cb6@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SI2PR03MB6757:EE_
x-ms-office365-filtering-correlation-id: 4e86d4c3-d625-42d6-74b7-08de780d1e5c
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: +0gwzmIjw22Y4yPaBCYfmfVHjTi5HWPhBrMXTIX+7Takn41TR2z57oE6ANYGzFo12KEDhI1Ki1TC26dn/WzWJwKOvbI3xvwggmFWQqAaUkVqCLIOrVdCTuybEdo52/f6jnsaK6VAVqH+Of8UBM4L5yjWaCMqBpZdNy1lytOOpIQQw0YDC8Rxof37D1FGNQhFFn/J/S2xG4X+zFkc4FnpNiwp2XfweV69UDXlj/eLNih7ksihQ9PVx6Rf96IHLAnB59cQKfGWQCF9QnSIlWGc3rvgTDIFuHXyoDswr3eZVPp2EA0tw3+aUvU1LRCU2MCVgkWPXf76hOcFJZA6ylgaLK5BX9h1/AjgdO7HRgx4BU3I/vp7kDCufm7j6In084TjFicWObS1VMkXKM5vflfma7xuh5NYrezam3Y8kNNOURrxr7o5MjtcKeYDsAMKX4yy4crhp4Rh/O7FLhDiO64Fv7meej++ui7qdNuzlt8+ehYDWXaSmu+1X9IXf24UN+kqT80QqB7QSvmN2aSPhmBHGXYWK6ltNUAUA0uHUEnmhQ1AmuEzgLKzcSwajdpH/Q762Z1aNgNW9seKrBHbORz2O0TuHsQRoy0kZEhg7A1vN0S0/OJrMVYeqdAUIzkG0gv0AVyUbs5m6z9VFFPsWa8iRk4yWNEmiwW/6vh2amj9g8h7kKpOB+8vHtWujcShu/aAyXbzBko7jbJeiWCPfp/WtJq7T5602+BZtShUv9NPnJl2Fragg9RkfrjdOwnz+WPVlXG0sYaq4qQv7So9wALRehrN9qq2YDepYYWTvi9yngw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmlwTzBNM04vQmtwd1B5S2tPTUlqdjl1clNFMzhyWER0Nll3ME1WZzJqRmZw?=
 =?utf-8?B?SWZaOEIyZDVCTUxSNVdSb2xvK0J2SFdobUNBY2k5UlJ0WFBMYmlmWmc3TDgv?=
 =?utf-8?B?QnZSZGtLM01rZFJVN0pMd096YnFYeWRaMUFNclRMbTY1ems3NVVjZG1HeGQ4?=
 =?utf-8?B?ck5uQVRCdjB5aWhWWFhkSmlTRHpzNktRbkZQVldvVG02aGZYTW83TGgwNjlF?=
 =?utf-8?B?UEtJV3FDWWwzcHhXa2M3OExqcndYTTJQVVhzOGwvVjlaUjNXS240RnhmbTFK?=
 =?utf-8?B?QWVFL1Y3VWRaa2xub3A3WnA0S3VhdGRtNnNIbSsrSjJXUzc2Tm4zUU92RWdP?=
 =?utf-8?B?UjUyRytwRHhMR1c0bW15TDdhR0dMTXk4QmxIVnBvdG9HNWR0VVhjdHJtWVBE?=
 =?utf-8?B?ejk0ME93eDA5ZmtRb0krMWoxajVWTDVhRWV3Q2lta2traGdkdW1rWGYxYm5v?=
 =?utf-8?B?dUN2dEd4dGgwdm9CWklneFJ2QU50SXl0NUtodjFJRllZK2dRY3JGZTRET0Mx?=
 =?utf-8?B?UnUyTFRkbG92WWMrdTQxbU02NU9hY3BnZGlqS01saWV1ZlVneHI1N1BONEZS?=
 =?utf-8?B?TEI1My9vbk5SdnBtRmlwM3crdFRvQ0thUkNoc3ZwVlh2ZHM2NXdYQ3pESVZD?=
 =?utf-8?B?dG1HTG5pZk1CaVUybFJadDM2MnRDUy9MV3BWbkdWQ2FseENQVWRlOXcwV1Qv?=
 =?utf-8?B?KzhXaHlkaUNkN0l5UElubWdJQWFpUXFWQWVBOG9lamFFbW9XeUFQbUNwdlZE?=
 =?utf-8?B?MU5HaTB3WHd3ZG5vWEpDSTJLOVFKcUtRWHp6RUdyM1NUVGkvNUFCYnhGUCtV?=
 =?utf-8?B?SkdhemF4VnVLNEZYWG9jMzVmeHdTK0xhTWN2VG96YmxjUVloY3pBK1ZnQ2pP?=
 =?utf-8?B?cVJzUTFQRjRCVHpmRzZpeWtEejdUL0dSSzRPTk5BYWpIRlhDOVlaYTZNMlYz?=
 =?utf-8?B?VTkwZjI0ek1TU1RKQ2NBcDJVOTJZWmh0MlhmaFNQRDdsWE9HbVo4VjF2Vzds?=
 =?utf-8?B?NkFHdEIveldRT2R6alZMUUtpWThJNmcwb1N3TDQwcG1sRWZiNko4RFZudEJq?=
 =?utf-8?B?ZDdWQnhrVVl4cjhzMnlSMkQ5K0RSQ0xyQlRic2JCaFFiKzNqODFITi9mV2Zo?=
 =?utf-8?B?eHZXQkRjbE1lMnJwNms5VlMrRkRVcUd0bGVHaUlTTE5jZExYQit3VWJSbVNq?=
 =?utf-8?B?czc4Mkp2TnlKdFYxdFBmL0ZwVExTSjFBRG4yMzhYTS9yU1FVcXFsc0JEYjd2?=
 =?utf-8?B?WjJ0Z1dKbVlHTC8yOUp5Snp5ODJzZXpzdm1zc044d3ZPemtYUGNqSHJzS2ky?=
 =?utf-8?B?SC95a292dmVRNmxJYmw2TVk5SmIvSXlFa0pvNysrQ2x2N0FxU0Q5a2M5aDVt?=
 =?utf-8?B?czdLN2VNWGhHWnBWZ2ZxbVBPbjlZMUloQUZBeTVibVl5VjMycENjSlVzTE1N?=
 =?utf-8?B?UjRsNnB3MEVOZlNuY1hXWjVQdlhZTU0rN0V5QTVNVlFQbnZGUnF3cXFmem9T?=
 =?utf-8?B?d29vTkJxRGVYakF5dXlPV1MwTGRVMEI5MjJ4TWljcElodytZMDRMZUc0cStC?=
 =?utf-8?B?MG9hODFnL0JuU09yNEJNa3lGeTZNNzh4QXJtQ1VPbUdIVndaRCttL05md0ZH?=
 =?utf-8?B?WXUyejE4UmZMeUhhcGZlQTlwVVFPcC9scHZaYkpvMGNjT3BSemFoR1FVSy9Y?=
 =?utf-8?B?UWpJMHlkL2NiSEp2bDZadDMwcXV4RTA4YTFWRjI2RFpGcG9MYzVtRWIwOGhh?=
 =?utf-8?B?ZWRUTFlMK0RvaE9YamRoYnRzOHlDRGp0VkdGRk9XNXE3VUtUN3R4UkFGMzBF?=
 =?utf-8?B?dkdra3NxVzRuRjE0azFqb2N2enZwd3ladExnSFBOdlZqYWpwcjlOUnloMmFX?=
 =?utf-8?B?eTQxenluQ21LNml1VHZmY3ZMRksrYm00ZnZKTGlIRUZZVWNlalQzM2VtUWh5?=
 =?utf-8?B?dkhkSUJnbElVMEh5Zm1WTVp0MFFabnFqTWlibXdoMER6WDNlRytsaHc0cjFH?=
 =?utf-8?B?S29ISmEreUJMc2ZWZG1pZjZRbHdKMmV3SEhZQll1OG5oWHJFSGhhZHJqaElR?=
 =?utf-8?B?UldvT1JTU1VKS0dYK0lNcFBJMGc4NUdLZ2twc0RLZ0VKcWM0YitueGNSZ09W?=
 =?utf-8?B?MHRCUGJMcGFFZlNxNUJiZFNSSEcvZko4dFMydVFpQjJMNm1oaWpMN2ZscHNM?=
 =?utf-8?B?WGg5a1JiY2VBRnZDVEVLU0d5WG4rSmdqYjg0WXJDQkY2TDAvUEtZemNnVTBt?=
 =?utf-8?B?VGRiT2tIemZZQlRIRjZ2Ym82bVlKNTdramZGWmI4Z0JMMnBNMWxuVmVSRkpF?=
 =?utf-8?B?dDZHSWE2bC9HdkM4NFdpbFZObVRPb0dZb1lrem9ZNU5tVmlMREZWblk5SUN4?=
 =?utf-8?Q?s9fIyqR4stLhfhSk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <85D3D9B58E115D4DB6C02FE9DDB0B94F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: RB7ZPPskpPp0x2sSaGIZW8BoMywyvM131pHh5Y/yyqpZDDU17Ysb5mGgUbhBWp/R3YHl6BxmwFgXnJEJ5UPCt767vKDgIdAwlZciFCDKzNYi+dcXBHQQbZ6dvqutwwDTyuVXNUhCk0zZ9nL/9CwiOoZjoDe7W0FsTbw6MBKO3l+yKyMSreyn0FJQ3tCenXW4Lpv+HS6iQNAyKdEGkDimSY7eOSkYFPryvCs2/IvUEu+JMUNNE8HG3isl7240DKfXyAPqkhwTZE4o4r8m8JLTXmIbgrW6vdPI0NNWDuBSiMTiJO0N6TgxgIlHJ7KkFSaYSV5WG6cv8B1J3IM/1ebFJw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e86d4c3-d625-42d6-74b7-08de780d1e5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 03:38:07.1769 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0Q0HzElOQShfMVi6jJYzaVvr3OrXZQUuBcyU7kfRvgaC+ynLP6fUPoXtWC6mSlOY7YNpJUiElIKQvp4xrOl8X1LtGtII7bg5gyzCMitYFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB6757
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

T24gVGh1LCAyMDI2LTAyLTE5IGF0IDExOjAzICswMTAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gVGhpcyBhZGRzIHN1cHBvcnQgZm9yIHRoZSBNVDgzOTVfRVZLIGJvYXJkIHdpdGggdGhlIGZv
bGxvd2luZw0KPiBmZWF0dXJlcyBlbmFibGVkL3Rlc3RlZDogQm9vdCwgVUFSVCwgV2F0Y2hkb2cg
YW5kIE1NQy4NCj4gDQo+IE1UODM5NV9FVksgaXMgYmFzZWQgb24gTVQ4MTk1Lg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogSnVsaWVuIFN0ZXBoYW4gPGpzdGVwaGFuQGJheWxpYnJlLmNvbT4NCj4gLS0t
DQo+IMKgYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlPCoMKgIHzCoCA1ICsrKysrDQo+IMKgY29u
Zmlncy9tdDgzOTVfZXZrX2RlZmNvbmZpZyB8IDI2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
DQo+IMKgMiBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlMgYi9ib2FyZC9tZWRpYXRlay9NQUlOVEFJTkVS
Uw0KPiBpbmRleCA1OTU0NjA3NDM5YS4uNDQ2YTllOGU1M2MgMTAwNjQ0DQo+IC0tLSBhL2JvYXJk
L21lZGlhdGVrL01BSU5UQUlORVJTDQo+ICsrKyBiL2JvYXJkL21lZGlhdGVrL01BSU5UQUlORVJT
DQo+IEBAIC0xMywzICsxMyw4IEBAIE06CUp1bGllbiBNYXNzb24gPGptYXNzb25AYmF5bGlicmUu
Y29tPg0KPiDCoE06CU1hY3BhdWwgTGluIDxNYWNwYXVsLkxpbkBtZWRpYXRlay5jb20+DQo+IMKg
UzoJTWFpbnRhaW5lZA0KPiDCoEY6CWNvbmZpZ3MvbXQ4MzkwX2V2a19kZWZjb25maWcNCj4gKw0K
PiArTVQ4Mzk1IEVWSw0KPiArTToJTWFjcGF1bCBMaW4gPE1hY3BhdWwuTGluQG1lZGlhdGVrLmNv
bT4NCj4gK1M6CU1haW50YWluZWQNCj4gK0Y6CWNvbmZpZ3MvbXQ4Mzk1X2V2a19kZWZjb25maWcN
Cj4gZGlmZiAtLWdpdCBhL2NvbmZpZ3MvbXQ4Mzk1X2V2a19kZWZjb25maWcNCj4gYi9jb25maWdz
L210ODM5NV9ldmtfZGVmY29uZmlnDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAw
MDAwMDAwMDAwLi4yZWRmM2NiM2UzNQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2NvbmZpZ3Mv
bXQ4Mzk1X2V2a19kZWZjb25maWcNCj4gQEAgLTAsMCArMSwyNiBAQA0KPiArQ09ORklHX0FSTT15
DQo+ICtDT05GSUdfQ09VTlRFUl9GUkVRVUVOQ1k9MTMwMDAwMDANCj4gK0NPTkZJR19QT1NJVElP
Tl9JTkRFUEVOREVOVD15DQo+ICtDT05GSUdfQVJDSF9NRURJQVRFSz15DQo+ICtDT05GSUdfVEVY
VF9CQVNFPTB4NGMwMDAwMDANCj4gK0NPTkZJR19OUl9EUkFNX0JBTktTPTENCj4gK0NPTkZJR19E
RUZBVUxUX0RFVklDRV9UUkVFPSJtZWRpYXRlay9tdDgzOTUtZ2VuaW8tMTIwMC1ldmsiDQo+ICtD
T05GSUdfVEFSR0VUX01UODE5NT15DQo+ICtDT05GSUdfU1lTX0xPQURfQUREUj0weDYwMDAwMDAw
DQo+ICtDT05GSUdfSURFTlRfU1RSSU5HPSIgbXQ4Mzk1LWV2ayINCj4gKyMgQ09ORklHX0JPQVJE
X0lOSVQgaXMgbm90IHNldA0KPiArQ09ORklHX0NNRF9DTEs9eQ0KPiArQ09ORklHX0NNRF9HUFQ9
eQ0KPiArQ09ORklHX0NNRF9NTUM9eQ0KPiArQ09ORklHX0NNRF9QQVJUPXkNCj4gK0NPTkZJR19P
Rl9VUFNUUkVBTT15DQo+ICtDT05GSUdfQ0xLPXkNCj4gK0NPTkZJR19NTUNfTVRLPXkNCj4gK0NP
TkZJR19QSU5DVFJMPXkNCj4gK0NPTkZJR19QSU5DT05GPXkNCj4gK0NPTkZJR19QSU5DVFJMX01U
ODE5NT15DQo+ICtDT05GSUdfQkFVRFJBVEU9OTIxNjAwDQo+ICtDT05GSUdfRE1fU0VSSUFMPXkN
Cj4gK0NPTkZJR19NVEtfU0VSSUFMPXkNCj4gK0NPTkZJR19XRFQ9eQ0KPiArQ09ORklHX1dEVF9N
VEs9eQ0KPiANCg0KUmV2aWV3ZWQtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRl
ay5jb20+DQoNClRoYW5rcyENCk1hY3BhdWwgTGluDQo=
