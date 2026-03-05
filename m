Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4FB6F33A6B
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:10:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30B708382A;
	Thu,  5 Mar 2026 15:10:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="rrPSB0br";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="TaUrNQzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74FB48382A; Thu,  5 Mar 2026 15:10:42 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 181BF81E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:10:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 135a9a9a189d11f1a39cd589f645bc18-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=TjPDOnnXIv2m4Vh/idBPgdCWL1mVDBY7ARx71szj9bg=; 
 b=rrPSB0brsufqXhvLTnEJmECUVwvAgK6EdGJzoF3QQqXY0EfgSopTzjADhrZp+lp6ky3dOH5utRmPtKB+Y1ohh9Gy07Q8xivq12Lo/rQmQiAEHpjVWlcaDTSBQ5jidyUJCJQZAeM772XGavaFb6Bhx39XYF7jE87OuxziaYoQG10=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:86c14575-40ae-4285-8726-de89a2f886dd, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:2c6e8f7b-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 135a9a9a189d11f1a39cd589f645bc18-20260305
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1721155420; Thu, 05 Mar 2026 22:10:33 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 22:10:32 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 22:10:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdE1EURlXgr0X/zf0Bg8OiB+1d5DNs6NH0jeeiPK+sQziFVCgGrzQS4izcwEfT2LVstJET/JjXNFJR/bRhDGI0x05p9vw5N5PG6YqocfyZ1oelCC++n2me6EVzCkIYP67WyOG4hK8vrKnM9i5TGxxlsXGbppJzWR4OSq/b5pj9ylI7Hm82No+zq+GwnzcEfEwSf+T5Nbq0Ffoxo5HOpgjyC6QcPOTgOMDiJ+wAgeU3x8TkBM7XCfqJ3Ewp1/w35IZXu6595+jaMKOobq4D+QmkE93UHgGo5J7XBJfvXKgkDAjrQL5uIcKFDoOCvhmxSpd6IwAn0WNGQ6V1rNKdxxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjPDOnnXIv2m4Vh/idBPgdCWL1mVDBY7ARx71szj9bg=;
 b=URM+npcbooWiugNT+xlf9tql72LmfE4uJtIVig2/+Wuii4/cPZ78PcR2mV9iIZ8Rm1Lne9yvGzWtQtyA/QiBdxHUJuxrJ/K0NE0TLTv2JRAGDXZ7fn4wmHOYWmyGxbiZFpXdTwJVw8ZXXzQFB6buWu8yNkR+aThob3fKFRfGbjTQ04eI9gGA2y2uDhJdB+3rtIA+oHw+n5U1fLcqfFvROCutWjNpxrmJp8JwcxiXnmAs4SiSyBUuGtSRpJuXQxdkQ/Bt6hgj4rCJ4L1wBmpvkbjIyInf13XIFbL1bRzuiUoXFdCm2jfjwL5TdiXXRRMBfFCYl/xL4ZaU225wXXYzEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjPDOnnXIv2m4Vh/idBPgdCWL1mVDBY7ARx71szj9bg=;
 b=TaUrNQzrnxIsAyidbcoWfDO/V2eioR4hGbSTlMQRVJe+JdPs3zqbaEgn+GngMcDyQhjonEnRgT6ut1xUyZ/pMmAFjTgIXbTZYZWlAie6Y8t0PwAM6Faw+xH3CaH3MjmyUd2Od60QTfLyx1+jJb85pqgOhDhWEEoMsSpQm1aCvqU=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEYPR03MB8578.apcprd03.prod.outlook.com (2603:1096:101:209::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Thu, 5 Mar
 2026 14:10:29 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 14:10:29 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "lukma@denx.de" <lukma@denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, Ryder Lee <Ryder.Lee@mediatek.com>, 
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH v4 5/7] clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS()
 macro
Thread-Topic: [PATCH v4 5/7] clk: mediatek: add MUX_MIXED_CLR_SET_UPD_FLAGS()
 macro
Thread-Index: AQHcq0gXxhOls+tVG0mGCsW3FPQV/rWf/RIA
Date: Thu, 5 Mar 2026 14:10:28 +0000
Message-ID: <32ab120a0130479676198bc1cb7dba417371e6ef.camel@mediatek.com>
References: <20260303-mtk-mt8189-clocks-v4-0-ee85f8dd2f0d@baylibre.com>
 <20260303-mtk-mt8189-clocks-v4-5-ee85f8dd2f0d@baylibre.com>
In-Reply-To: <20260303-mtk-mt8189-clocks-v4-5-ee85f8dd2f0d@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEYPR03MB8578:EE_
x-ms-office365-filtering-correlation-id: f648adb7-de2b-4999-6a3b-08de7ac0f4a7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|921020; 
x-microsoft-antispam-message-info: LTRQPeJynV/chQaxAwF+Wi7Yz8M5/pMnWrTrVJip4Oe/4NRBX+lRj9Ussitl6pEbUTdeSJvjTDT+/KyeleJNgiyeE9WTif9dYd8LkNTZsWS2Jbtp3S/quv9DI6UvHSIUslp3SO9pfDNOVGyP7DTH7SCdPPdR9rPdtIbku4xN1w1WuQKUVjgXUNk5dxRnSTj21gh8apMYhRsXWyOPOQg2CqzvLSCg3FuqVZg3bBVhzAar1qtFbsX7mAZ/JSlWAgtfK/0dEr6zMY7eAC2OxT/r7BA1ovJNn7hpMpKPNz3HcJzZYkcRJ+OLyyZ9sKBEKJy9hit4SJKfOdBq14qlzAXHbCB/4XIytr/+ZHD3U/wU3XGRj81O2wkyCOAyorXiyZXJ7TzwTUaqk27VNU3dL2A0AO1z4zXBVPUc8PY3ciIu/QNueyceLUyGPjLUdcCj2zet7IUFPR1a9kRSdjZFhTgUMeOHXD0kEiuDLWiicxiEDJg8XQPoDI92h+P583oHdoX2zrxNlyws/X6zt5y0RhKyEaw8GvkZHivjJj6iTCxKk5lMbyw4szy3xbYgPHN+IKp8L8vuiTpRVziIjj52l0ZO63DwGpnPuwgWpDc5sRYOhFF3LOZx0Mz+DEnUAB7wSYDhVAo0RedgnsYxeRhIeo+IOLqnYmNHQi3Dige7woLHEzUX6jthZbjOIiEmkIPoScdAMtNL0iWHNeOwaN62jmC+4NI4BWYN4300E0p3ivBRi7l04+vnnTq8YzlBJJk06eVvANOobNTiCbilq9uTOh+Pn18XxpwmboeUVPemls9Li8U1EB+E9UK9AE45eMUilgdI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUdMVDhkdXNtZ0ROUUFEdHgvSlZYZjZndUYzV1pmVnZITmxlSUtpbUdQeTdS?=
 =?utf-8?B?UUVoN1J0TUQ1Rm45SG1CL1hqOG5hSEZqNyt6Y01OSE1aanJxZFFGYnh6L3VX?=
 =?utf-8?B?N2JaTFJLWi96TWIwL2cvdTZmVjlkWXJ6bkF4NzQ4Q3VpWWhsKzFpdXNOQU5O?=
 =?utf-8?B?UFVEUzNiNXovSHF1eC9vQ212WGtZY3djdEsyY3pWek5NTVhCa2xvNi93WThB?=
 =?utf-8?B?SEdjdlM5MnByK2cxOEY1Um9uT2lNdU5WS3VRYm50czk5b0dDL1Znbk1oeVhB?=
 =?utf-8?B?ZjhCODh6bXhKVU94ZUxMbU81R0Z6ZVNXQUhLUy9sS1ZWMkt5SElpbkdteDBS?=
 =?utf-8?B?QTM1RW9SbWtML1FERGQ2dXdhR3FHR2FuMVJ4aE8xVjNvZ2JQcjJ1SGlmU3Z3?=
 =?utf-8?B?ZTVoTjVqMkYzd05odXg3M09KZFVQd2VTQStwcDBwZW42ak9KZ1F1Z3BDUTFF?=
 =?utf-8?B?ejZlc3QwWml4OXFneU1pdnpnNUMzeWswYlRhcmZJRU9Va2M3TDBwTnlQMENM?=
 =?utf-8?B?Nm1McU9CQzhVNDREZGFaSkpwQzcvR0E5dENWUURxVGRQS2JibzlwRFhBSVRX?=
 =?utf-8?B?djl2UkxKWEN1MnlZWUYwMFM1QU5Lem1UbzRQVFE0UktuM21XcEptd2Y3amEz?=
 =?utf-8?B?SUZyeXVoalBGMDFRQWxRS2pKbVA3WVBPNEltcVJOeElQbmxud0NJdTR2bTdX?=
 =?utf-8?B?cHAwdW9zbmVsR3NqejJxM3IwVXgySW03a2FmcWY3QlkzMVRWeFFaL2YxM09V?=
 =?utf-8?B?QkFnM1FVU1o5R0Z5OWNGL3M4WEJYZFpmb3BCMDZnWWoxNkt1d2tOR1pJTmRh?=
 =?utf-8?B?OWZCbFFvVmNPR1hsbEVtdnRIUU45TFJkckZSdEtCUms1bzZxN2RvY0ZrZC9S?=
 =?utf-8?B?a0pRN2pSdEh1SC9TK0ZqcTZwTDhKc3hib3ZUdHFiU0FFM2V4VWVtOHQ2Mm5x?=
 =?utf-8?B?ZklNL2V2K0FBMU01VWpzQ3I2VC8xTHZoU29IT0s2Z3RkZkh4VGlGRGVOVVlQ?=
 =?utf-8?B?SEQ0N0U3WnJqeHNtWlVaWEUvQnROb01Lb2lyOHVrSGdKSHR2RXVxN0YrTERa?=
 =?utf-8?B?KzlhdXJwbUwyRHY3STlueENIVFNISE5nRzRCbnE5ZEVGb2U4WFg0bGE3TXhI?=
 =?utf-8?B?clBnSmlkMVV4azBTS1RGS0J4NGZiK3pUcUd3clRxbHMyY1hydFJtUmR6K041?=
 =?utf-8?B?YUl3NHdld0xXWGV4aGwzbGswTDR0K3haWkcrck0wa1I1QjFTempNVnI1YVZG?=
 =?utf-8?B?ejAyQWRmU1ZtNjBlVGFaU2o2MUFxbW9UZ0thZEZHT1NQMk9aTWFhRTFST0Rp?=
 =?utf-8?B?dk1MZHlLblFNcm93eGwrYnRKaU1wNTdGODliSytNVWFIb1ZYQ29NZXZkNVdF?=
 =?utf-8?B?R2VaaWtJdU9JLzdPaHQ4TzJ5OUFoaXNYTytLL1lRWGhyOThRR092bEVRZThu?=
 =?utf-8?B?dURjanZERlN6TEJXR2RGakw3V25jRzFCM0xpWlU1MUxCQi9EemhWR3VRMUVS?=
 =?utf-8?B?akhDelY5MVlMa1RmaDFlc2l1V0pqVG5RYXJqQ0hSOVRKZWQ1b1RDYkt4MUxa?=
 =?utf-8?B?SWxsc3drNVlKNnU3cW9BbEZGaW5DQjRZSTQvZ2pCNGt6S01nRFhpQ1pWTUFX?=
 =?utf-8?B?ZjVFdUV4QmpyTkNZTjZCZHBtQWpiU1l1THZuclFZeENVRmk3c0xIMUR0T3l1?=
 =?utf-8?B?K2RhejJoT25seHFWUDBUUE16bEllS2hEZVFzeWd3dXpoaTJUZnF4ZG1pTis3?=
 =?utf-8?B?aFRhNmhuTXJGSUV1b3FUcC93UVdGS09LQlcwaHBrZmVQRUphOFd6SVdlY29E?=
 =?utf-8?B?TFZTZUxJckNGVThVOXRxQWkzWGVpVXlVMFhlcXEzT0VUUENZcmozRXRZdWlO?=
 =?utf-8?B?cDlBdUYvS3JhK1B2UUhCRGxnMERpZ0pqUEpOdUVtZU1SVTNpMVVUZkZpU2p5?=
 =?utf-8?B?azZlcXF3a1k0U1IyUGhxVUxKM1lBQUxoRUFzaXh5bmZtSExTK0c2NzhhbFRl?=
 =?utf-8?B?czhGUGNEOGtYT2lCK0FNdkduTlJIK1lTV2tUYXhLMTgvY25DT1QyazcvYWs0?=
 =?utf-8?B?MWVHdU1iT0lVR1hTRHRGNG81U3EweGxOK3U2VVYyQncrZGRXcmNOaTI5ZWRL?=
 =?utf-8?B?TkwzSzFUUWE0aGRVOHhFNTJUSXZkWDZIV0hJb25ENXZsNVVIaHZWQXludkxY?=
 =?utf-8?B?V2dkVTNqTkRmSGJQemx2eTBCVUsyNElJMUdNYWE4cnY4OXRKUmordDduY3Jl?=
 =?utf-8?B?MUJjdm93QUluOTl5TGEwTGJIV2pDZk5TdENYd0NZVWtndDhyV1QxbmpCbWFW?=
 =?utf-8?B?QzU1OGFYbkt6V0x6c0V4dGtjL1l5eUdRZGlZZEpzMGlKSWxtNU1PVE5UazJh?=
 =?utf-8?Q?+tqrfik3CBKHfk60=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <083C71C82D6A674E9026118D332532B1@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: fzlKGmJoby2/B+DecpVDxo5rH5QEqz1fC7LRJLlAlxpNvbWdpoSNN1sDjKxBnXZmZrFM3uJmpX9E42WtkCU5vzhPaS7CN6wwra0PgoI5jndvaicjGtqDwKY7s1eCfiZCdg9Lb70NdbQ6tHudaWP0SD7rXB+Pn8FNyK3m15UwepKozEnxfLaDgs9IuI42YnEhCS0k5MjJ0SjAuVDheweGNDTSWJe8YNaR5sQVM33ahJfJ+gvKndjWesocPAPOAocbBkHqc3qkuWIlt9vmWiVf8rLEan6B1vSkurmZlUmOd6xFg7h1HvMCrEzpzlnHrMg/fGa2GBvFwEjkH9Ey6zw01Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f648adb7-de2b-4999-6a3b-08de7ac0f4a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 14:10:28.9722 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7nFlcfZLroaN1gcSKzD8lyFl+PbwOMmZHwXMe/WSjZmEmNHMGF+fHo72p/Y7L0lmd5hBFHk9sdFYh7RaX7FvSMfaBu/jeyWhcgyl+bzZpfI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8578
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

T24gVHVlLCAyMDI2LTAzLTAzIGF0IDEzOjU0IC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgYSBuZXcgTVVYX01JWEVEX0NMUl9TRVRfVVBEX0ZMQUdTKCkgbWFjcm8uIFRoaXMgaXMg
dGhlIHNhbWUgYXMNCj4gTVVYX0NMUl9TRVRfVVBEX0ZMQUdTKCkgZXhjZXB0IHRoYXQgaXQgdXNl
cyB0aGUgcGFyZW50X2ZsYWdzIG1lbWJlcg0KPiBvZiB0aGUgdW5pb24gaW5zdGVhZCBvZiBwYXJl
bnQuDQo+IA0KPiBUaGlzIHdpbGwgYmUgbmVlZGVkIGJ5IHRoZSBpbmNvbWluZyBtdDgxODkgY2xv
Y2sgZHJpdmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJA
YmF5bGlicmUuY29tPg0KPiAtLS0NCj4gwqBkcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmgg
fCAxOCArKysrKysrKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9u
cygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuaA0K
PiBiL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsuaA0KPiBpbmRleCBjNjg3NDQ0NWRiZS4u
YzRhZWVlNDlhYmQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdGsu
aA0KPiArKysgYi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXRrLmgNCj4gQEAgLTIyMSw2ICsy
MjEsMjQgQEAgc3RydWN0IG10a19jb21wb3NpdGUgew0KPiDCoAkJLmZsYWdzID0NCj4gX2ZsYWdz
LAkJCQkJXA0KPiDCoAl9DQo+IMKgDQo+ICsjZGVmaW5lIE1VWF9NSVhFRF9DTFJfU0VUX1VQRF9G
TEFHUyhfaWQsIF9wYXJlbnRzLCBfbXV4X29mcywNCj4gX211eF9zZXRfb2ZzLFwNCj4gKwkJCQnC
oMKgwqAgX211eF9jbHJfb2ZzLCBfc2hpZnQsIF93aWR0aCwNCj4gX2dhdGUsXA0KPiArCQkJCcKg
wqDCoCBfdXBkX29mcywgX3VwZCwgX2ZsYWdzKQ0KPiB7CQlcDQo+ICsJCS5pZCA9DQo+IF9pZCwJ
CQkJCQlcDQo+ICsJCS5tdXhfcmVnID0NCj4gX211eF9vZnMsCQkJCQlcDQo+ICsJCS5tdXhfc2V0
X3JlZyA9DQo+IF9tdXhfc2V0X29mcywJCQkJXA0KPiArCQkubXV4X2Nscl9yZWcgPQ0KPiBfbXV4
X2Nscl9vZnMsCQkJCVwNCj4gKwkJLnVwZF9yZWcgPQ0KPiBfdXBkX29mcywJCQkJCVwNCj4gKwkJ
LnVwZF9zaGlmdCA9DQo+IF91cGQsCQkJCQlcDQo+ICsJCS5tdXhfc2hpZnQgPQ0KPiBfc2hpZnQs
CQkJCQlcDQo+ICsJCS5tdXhfbWFzayA9IEJJVChfd2lkdGgpIC0NCj4gMSwJCQkJXA0KPiArCQku
Z2F0ZV9yZWcgPQ0KPiBfbXV4X29mcywJCQkJCVwNCj4gKwkJLmdhdGVfc2hpZnQgPQ0KPiBfZ2F0
ZSwJCQkJCVwNCj4gKwkJLnBhcmVudF9mbGFncyA9DQo+IF9wYXJlbnRzLAkJCQlcDQo+ICsJCS5u
dW1fcGFyZW50cyA9DQo+IEFSUkFZX1NJWkUoX3BhcmVudHMpLAkJCVwNCj4gKwkJLmZsYWdzID0g
Q0xLX1BBUkVOVF9NSVhFRCB8DQo+IChfZmxhZ3MpLAkJCVwNCj4gKwl9DQo+ICsNCj4gwqBzdHJ1
Y3QgbXRrX2dhdGVfcmVncyB7DQo+IMKgCXUzMiBzdGFfb2ZzOw0KPiDCoAl1MzIgY2xyX29mczsN
Cj4gDQoNClJldmlld2VkLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29t
Pg0KDQpUaGFua3MsDQpNYWNwYXVsIExpbg0K
