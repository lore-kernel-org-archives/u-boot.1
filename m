Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A86EB48F8
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 10:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8540483A47;
	Thu, 12 Feb 2026 11:41:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="b8I4oVgC";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="igZcJY31";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA34583CE3; Thu, 12 Feb 2026 11:41:16 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E90E83015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:41:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 57617e1007ff11f185319dbc3099e8fb-20260212
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=uFDFl9gGAe+CA/JXpJk6pVoh/PgoQ/CCZu/BUhIiEe4=; 
 b=b8I4oVgCcqqH9IigenavV0hl4jV10Th+L3zlAhQrDd+R3bXNJVvsyiQ5NC4SMCpgxnAzB4M2iT4w7X5Roeqt591dVx3HxFtY+fgLssIZP3oMyDFhcMIkAi5raYT5Fj3drceI4GZK30dAxGqFBEY6gWAvZlfVnqtuDVLNW7n4yJ0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:316640a1-d923-44a4-8720-8e82a625dc87, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:c873395b-a957-4259-bcca-d3af718d7034,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 57617e1007ff11f185319dbc3099e8fb-20260212
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1739546218; Thu, 12 Feb 2026 18:41:08 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Feb 2026 18:41:07 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 12 Feb 2026 18:41:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v9TBGvyXkKdAv0IhOe3wzokAPwTVHR+SNoRmmGXgA2M6x7eL5nwJtHR1bCal0qU+g7HWVtVqpG4KTM+1F5Y9fU4b4KhCsYQqadng/0E8HOC3QGvo+5lmGSYJOMHVyMzOrSL/OChQbfdzhujU58ZOdlLVP+iK+t0WEU7Yd9sLcNiqCxfMOyDhGWmaPQKmMiT4+zblCEYuO0g95SgMeCG1cfbCj+aKYU+/dBnUvqolL+zkEOS2gck/Etc1SKbX1rdD18WTD2fluA5X2exJh/OBuGbdu2sYFK//xsv5rT60cMcd/DdPww7kuHKdQaHW7vLNEhARvKqFpj82ZRKEffpuaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFDFl9gGAe+CA/JXpJk6pVoh/PgoQ/CCZu/BUhIiEe4=;
 b=J+/lA1j5/xCgfbdKSAicyNqhbltiGAyQieWpfppn8EphYQGM1KKwIQOulGueERWR2SxQ7TvJwbW48NlQhp1a1LpiA2qeoVq3nRDcLG8w1oGwtvWqEM78m3cY0wcKKprro51Tw+KHubqhcOitXLphN+gbNoqBxa2XGn2koC9xH71x3piJ6qX+Xu1kpzsUoq3HDswrkyKRDgQxRaxa0T8pDJzRD+rqTamgXWRvdWWA7PuS7Vnu0rMDOBl5E4a6Vl+DN2J3r+PuZZx1ZhzgzswOFLqYC+lIwvTu76mDWlGUe2DGIijDuvtNja3nEMX1n6Ym7jBff9hDexweBV3wK41x4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uFDFl9gGAe+CA/JXpJk6pVoh/PgoQ/CCZu/BUhIiEe4=;
 b=igZcJY31yAVu10EZDlNnTdI1e3N35t+1BVmRs83abpiJrVKr47gskvWQezcJTanULJa1fr3O8iy989e3tghmCGu44N8yYH6h7tra91SXsXTZJJs+0BPTFCr1sB6+UlL5avfwe7NeFr7bEt9qO08SLEdNwDbrmrH2g6W7wriuTN0=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SEYPR03MB7296.apcprd03.prod.outlook.com (2603:1096:101:14a::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.10; Thu, 12 Feb
 2026 10:41:04 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9611.008; Thu, 12 Feb 2026
 10:41:04 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH 1/4] arm: mediatek: add support of MT8189 SoC family
Thread-Topic: [PATCH 1/4] arm: mediatek: add support of MT8189 SoC family
Thread-Index: AQHcmfFowDnHm49nTUyEkuYMwQruTLV+5EiA
Date: Thu, 12 Feb 2026 10:41:04 +0000
Message-ID: <6a47891ceaa27c1ac5be55f4b3e63191dfb5c6e2.camel@mediatek.com>
References: <20260209-mtk-mt8391-initial-support-v1-0-b23ab9d0b9bc@baylibre.com>
 <20260209-mtk-mt8391-initial-support-v1-1-b23ab9d0b9bc@baylibre.com>
In-Reply-To: <20260209-mtk-mt8391-initial-support-v1-1-b23ab9d0b9bc@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SEYPR03MB7296:EE_
x-ms-office365-filtering-correlation-id: a8bfea1d-2d8c-42ad-ac4c-08de6a233907
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?cjVjR2d0NVN3MmE0SnhUZ2VIdlEya3NhOUNVdFN6aTdXZnZUZlJYT0RxdzBT?=
 =?utf-8?B?YnNrT01TazNHMTlWb09IcEgrRXVueHR3eVVGMDVnQlR4Rll4VHh4dU4rc3g4?=
 =?utf-8?B?VkliSUVDampSSG1MVHF6a21OOSttelk5Wm13RHBKRXpKYm1IbXArejZxVVVP?=
 =?utf-8?B?TWRGamNxWENubWxITHZrVkIyWVlPZ0dtZzJrVVJHTGVxb2JHb3Ntc0Fkc2Uv?=
 =?utf-8?B?QXVYUk1IV0ovQ1NvSkFHT1ZpZkVQWkc1RlpBVkxhVkJMODgrMnJjL3NwV05p?=
 =?utf-8?B?Z1RNdzAxc01IRzFIZnJjalduSHAyTUptbGpyUXUxbmU0OHJZNkYwc2xmbTdS?=
 =?utf-8?B?MFppZ25oV1A5SzJ0eGdzV291MWZOVkVYVk9Edi9kaFdyNThPZFN5Qi95M3hs?=
 =?utf-8?B?TlNjZnRaWDFnYlJBaXZUR3hxMEo5eG01SzU1RTBZOUpBSHFjYWdmOWgzOTdE?=
 =?utf-8?B?TTlGZ0tGeVpZQVA2Q2xmVXptQzJxNm5rbVhvazIxV1JQZGR3MStudE1GTlMy?=
 =?utf-8?B?cVdjMDdyMHZMVkhhMkZGMGpXM0ZKVWZzZUtDVmF6K04rWTFBdjMvMzRBUUdE?=
 =?utf-8?B?WDVZYzUrN3A3UEJrbWIxQkRmbDltTUZHMTUrQWphSy8rU3Fsa2ptWXR1WU1W?=
 =?utf-8?B?NjBtTjhraXRQOUxzSjBjOE1zRXNJb2lKeTRncGxuRzYxVVpjcDhSalFPQnYv?=
 =?utf-8?B?MjZQcGFWclNpNlA0eEV1c2krbFRTcTVTd3dzWnFYbENlVmwzb2hQM2lkYmpm?=
 =?utf-8?B?YkRsOEk1ZWFGSTl4RTEza3h0azlwa1Y2SDcvSlVsTTh6RjE4VWtOZFdHZU9h?=
 =?utf-8?B?M3JUOGlLU2locUVsR2pSa1lPTlQreFpLOVMxWWVXRDdSbC9HY1kzZVh1RHRw?=
 =?utf-8?B?NURzeHV1a3dzWXN1SytGODBHejNzeTJrQ0hFenAzUmJKL2h5cXhDZmNjNVpz?=
 =?utf-8?B?VnpMQ0ZMdml5MWpHZm05OXlkWURyTGt4eERTM0ZCSlBpTjNMUFdFRFh3WnNZ?=
 =?utf-8?B?UmlQamd0OFZCREw4RTRWWDNpS2JFMTVQUkhUK3RJRm1zSkFrWnVuNWR3WU4x?=
 =?utf-8?B?NUxLcG9RQkpDMmg2Ym4yMVZ0TXFyQTFRNzRhdUdIdm5KeDVZNkF2YWR3UnBs?=
 =?utf-8?B?U3cxZTZCMFB2bnlTQ3Z3V3pIU2tLbW9oank4d2liUHhuWXJXc2MyM1EwVE5k?=
 =?utf-8?B?YzRqdHdkSmRZS3JKMVI0VG40eEFVcTdocnZlSkEra2N6bENXWFlWUDdackMv?=
 =?utf-8?B?dXdwNWFrZmlPbG00TUQrbWV4cThkc2c5VnJ1U0huSjFBV2pYK2lTVmJwQnU2?=
 =?utf-8?B?RU9jSTVJckdxUExad3RZU2k1MVhkbEhOVHFkcVFLdWd0WU1kSEtpdDdhR2hX?=
 =?utf-8?B?aUc5MXR4bW1mSm5xQnF1WHN5c0l2TEFJN2ZOVnM4ZmFCWk9zdmZEclpNbktH?=
 =?utf-8?B?dGQrTndzUWxUZDJNd2dyUHgvOGVrd2J3NlNoQ2xZaGdNNU1mWkxoOFd0ZUpM?=
 =?utf-8?B?WGU2L24rLzBUNTYzcU9iNFk0ak9QSFFUUEduOFlUcDNKa3F0b3lhMkNUU2t0?=
 =?utf-8?B?MktvcGRaNnNORFRGYnd4aTJRN1JDVWMraEszTllvOGNRTkJOYllvMWJLV3A1?=
 =?utf-8?B?Y2JyeEZseUp6RnBzRkJhUk1kcFUwbjluelozZzQ2ekl0ZDVWanpZUFhWZ3h5?=
 =?utf-8?B?QW9EL3d3ZFZqM1dZc2thR1NydllCNXZqVndnTk94UXNFZVErcjNsbUNma1hj?=
 =?utf-8?B?eEFKWXRKTks4SERIKzJmYk5PanBSam1sYitocmdiVm95R0dGZVUxMERIQUhk?=
 =?utf-8?B?K3hTbCtJTmVJTFkzTzlQekRwNHQvLzdZempmYi9wa0UwMUFWUlVpNFNhS1Zt?=
 =?utf-8?B?a1d4QWZITzhocGF1a2czOVhDT2lMQjZOVU9lK2FnUXZjcTcwVGhtVThnT1ZM?=
 =?utf-8?B?TzFYbWRPdmNGdmZSMis3NFY1Zk5HbWorUXF3UzVLS0R3blRiRkVKMjN3Yjdn?=
 =?utf-8?B?VjJpUlg0T3dsZjNrT0dlQXpqZktVYU9hbXEzL1JGTkREOFVDd2VwOStybzRU?=
 =?utf-8?B?ZERrbmlocHNveFNXR3JYS0dMMnM1aEZscEUyRy9tVzQ5MzEzbnFJL1d3MFlr?=
 =?utf-8?B?ZTJJaFFVaEZBcG16T21HWnBYMWhuNGQvQXhnSHVUQUdqUUQwajNtMy9xTXc0?=
 =?utf-8?Q?zVLtz7H7AYa5InvN8ZGKXA4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU5MZm8wdTFtYmNvaklRLzg2NHFhWVQxOGlEL25SUGM3ZE1MNFdvUWdnRFNC?=
 =?utf-8?B?SEkrTkM4UWkrZ0h0aWlmUHhVWUFCbENRcXVzNi9IMlczMzJrNTJSMFREMitL?=
 =?utf-8?B?TVRML2RwNFdVWmNpb3MvdFlwUUhZYkpKdkdyS09SWnMva1BPbWo2UVpaaDA2?=
 =?utf-8?B?WTZoVXlPNVo1N3RhVkgrTXZRNnhtU3V0TWx5aEczYlRTS0JTY3FkWjFDcDUz?=
 =?utf-8?B?cFF0dkhRQ3J6RVR2QmhCT1ZiblU0OHlheG52bkZaYm1JZHZmU1hZUTVhUEpw?=
 =?utf-8?B?bGpYUkhZM2V0MFNEUEowZXp3alVsTzFlc29DamhSQ3gvU0NQSHBzV2c0N2Yx?=
 =?utf-8?B?d0JMVnFqaVVjVklHT3lRVjdhZXNvbTFNSzBMajVwMThRa1B0ZDZ6bGZlMkly?=
 =?utf-8?B?Rm92dDBtZEo3alVsYWdQaWFWOGNqcHlDelRIVmV2dVBWS1U0Z3M3dlZNcVM4?=
 =?utf-8?B?TGU5V3NVNWdGd01Tek5jOFBvcFAwSnBnbkc5Tm9hNnRuZDVJTWNmNzA2UU81?=
 =?utf-8?B?SjRsLzE1b0tQbmpSaWZtUzloYzBPUFNadW11NGE5Tzh6cmtCd2MzQWswTXBy?=
 =?utf-8?B?VXQ5enRzUEVvbEFRWVlBUmlTbGwvaUVycnNZVDBBY3J4NjJTdjFUSUdaNjRz?=
 =?utf-8?B?Mm84QnNpMzUwSXZUdTlrc1hJVlhjNUpYRkpvL3IvU0hDOWVLM1BKNTVhK1Zm?=
 =?utf-8?B?WEN4VnlEOHoxTlZZSVF1bktRSFhya1VCaFRPaFJRYUtnSGZENDdEVEljWDlO?=
 =?utf-8?B?cERFZkc1ZzEvMzd4Ylc4dUlMdy9MS2M1VXQyYmZHWmY1bXN2TlRoMVpnNWdn?=
 =?utf-8?B?cHpmZlRSbjVFbzN6VGs5NmFUVE9LTGlCbk9vUk9ZR0JQSHNCMEpUbW5pVjZq?=
 =?utf-8?B?bW1BdHBzWmp3RXZBazBBVDEzWlgwWkZFSHpkeWRyNGRreklZczhMaERNbVlr?=
 =?utf-8?B?NTRhWDBOQ2xMcUQva2loRlNCYklSYVBLdGZQNGV3N21VU0F3WEhKdG4zMk5k?=
 =?utf-8?B?NnNPWHNPOU9kSmhrS0JzOFZuM2JZSmdtY09IOVB1RUFXeWV6M1Bndy9Cdmlh?=
 =?utf-8?B?TVh5QmJTdUlXRTJRa09xeG1JVnQxb0VUK1BmQ0h1UGhUVkMydEFuT04ySjgx?=
 =?utf-8?B?djRvbXlFTUFyUStYOUt3WExhckRYck1kazY4YXk5YjlDZE1vVk5GL1pTNzVl?=
 =?utf-8?B?eUlWSGttanEycGNOSmxkNmRTMzlZZFU5b24xYkZCVm5MOS85WHBMcVhlaGZx?=
 =?utf-8?B?aklsWHRaWXJQSitzb0w1dXV1ZWhWQzVoL3NLMVQ0TXkweUpXR21RQlRTZ0pM?=
 =?utf-8?B?aFZKaEFCS3JQZ1dIL0FhV1lRNFNsSXhWUGNuc0tNVElCWFowZ0xpaDcxN1lH?=
 =?utf-8?B?VHl2WDZlTWVRY1drZ2g0RjRnNFRQVEJvK1lsQ2F6T21EWkpMR1M5dStUMUxq?=
 =?utf-8?B?U3c0cHNwU2IwTHJNd3cxR0d3WFV3SmtWLzRrSEdxaW5ka25mQXdaYTdkOXhV?=
 =?utf-8?B?NGRwUUU1M0VwTHlmZ29RaFZJa3o1MWdtNzV1SWxNL1luWFFnZEg1bGlHRGYr?=
 =?utf-8?B?RHRHNnZTWVo2Wk9GOHEwaWdHMDVUQUVWSEU1M2ZOdzBJR3FPalltTWFIc2FC?=
 =?utf-8?B?eCtJbzdXT3ZnS0ZET0tlcW94RTdYRXRBd1ZwbEh2OEFTZDNnSk5LMmdtdFFj?=
 =?utf-8?B?TnFTQUxtaVRZK3RMV0g2UkRHZ1pwc20zVjJDeXVWZnRFWDdsNzZyTWRZcm9h?=
 =?utf-8?B?dVNKS3A0aktrMkdLSjlGbHBxTjJBeXlFQTNOVHRaNHR3eFpCa05peEViU2Fu?=
 =?utf-8?B?QS9qZjR4c1hBWndNZFZCcld3cEVacFptTVdqU0pUYURRQ1FIelpKc0FITk9a?=
 =?utf-8?B?eTYvNHp4dFZYbURXaUVJMmVQV0kwVVIrWmd3ZE1TZ0xQdDhMdHFPaTR6dGRB?=
 =?utf-8?B?OHB4TG9vTm5URklqN29lTU9pS2s5VGZPbmJGQXhMRlVDVU4yaUtLTFphcTRY?=
 =?utf-8?B?eEhYWDFQV0NMTUx4ZVNUcUpIanZlUjZvQzBNQlJxQmFoakF5em9qcUlJRzNC?=
 =?utf-8?B?M0VheFhVSFAxMVhLUFZzbXYrYktzMHk0VW5EOCtLQTdiL2RZL3B0cUlpd2dE?=
 =?utf-8?B?a240RG5tTWFqenM2VitrcGtCbFpWcGtvYTU1OEJ6RlUwYWY5aENkRnc0VHlU?=
 =?utf-8?B?ZVpmV1ZDR3hXNnRrOUV0UGpkOGkxcTdyQ2NmZXExRU5zbnZPc3pHK3AzRGd3?=
 =?utf-8?B?Rmh5VHIzd0pnSENlZjBQVGxaemJqSnNueFRxVnhDY0w4bDZOcng2bnlZYVFj?=
 =?utf-8?B?c3ZRYXZaamZrT2R6a0JVSyt2VS90WUYxNFpFUW5KWHhISjBhWDJCMTNmaU5C?=
 =?utf-8?Q?5XOJkmW8rkX/onHc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <488CC479826EA0499E563F129587D1F8@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bfea1d-2d8c-42ad-ac4c-08de6a233907
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2026 10:41:04.6340 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AINsiI0TrKVZBNpB0uYpBM8mZgan7hrukNR8Oz++VKBJaCQOlEepT1EvJqz3KU4OnzKXZMPoFRdqD8QqQZB0SFzz92YDkUyGbmXqnWTAXwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7296
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

T24gTW9uLCAyMDI2LTAyLTA5IGF0IDEyOjIzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBGcm9tOiBDaHJpcy1RSiBDaGVuIDxjaHJpcy1xai5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gDQo+
IEFkZCBUQVJHRVRfTVQ4MTg5IGZvciBNVDgxODkgYW5kIHNpbWlsYXIgU29Dcy4NCj4gDQo+IFNp
Z25lZC1vZmYtYnk6IENocmlzLVFKIENoZW4gPGNocmlzLXFqLmNoZW5AbWVkaWF0ZWsuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBNYWNwYXVsIExpbiA8bWFjcGF1bC5saW5AbWVkaWF0ZWsuY29tPg0K
PiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+DQo+
IC0tLQ0KPiDCoGFyY2gvYXJtL21hY2gtbWVkaWF0ZWsvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqAg
fCAxMSArKysrKystDQo+IMKgYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9NYWtlZmlsZcKgwqDCoMKg
wqDCoMKgIHzCoCAxICsNCj4gwqBhcmNoL2FybS9tYWNoLW1lZGlhdGVrL210ODE4OS9NYWtlZmls
ZSB8wqAgMyArKw0KPiDCoGFyY2gvYXJtL21hY2gtbWVkaWF0ZWsvbXQ4MTg5L2luaXQuY8KgwqAg
fCA1OA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+IMKgNCBmaWxlcyBj
aGFuZ2VkLCA3MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9LY29uZmlnIGIvYXJjaC9hcm0vbWFjaC0NCj4gbWVk
aWF0ZWsvS2NvbmZpZw0KPiBpbmRleCA4ZGE0YmE1Y2VhYi4uYmRiYzQyMzMwNTQgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvS2NvbmZpZw0KPiArKysgYi9hcmNoL2FybS9t
YWNoLW1lZGlhdGVrL0tjb25maWcNCj4gQEAgLTkzLDYgKzkzLDE1IEBAIGNvbmZpZyBUQVJHRVRf
TVQ4MTg4DQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIFVTQjMuMCBkdWFsIHJvbGUsIFNEIGFuZCBN
TUMgY2FyZHMsIFVGUywgUFdNLCBJMkMsIEkyUywNCj4gUy9QRElGLCBhbmQNCj4gwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc2V2ZXJhbCBMUEREUjMgYW5kIExQRERSNCBvcHRpb25zLg0KPiDCoA0KPiAr
Y29uZmlnIFRBUkdFVF9NVDgxODkNCj4gKwlib29sICJNZWRpYVRlayBNVDgxODkgU29DIg0KPiAr
CXNlbGVjdCBBUk02NA0KPiArCWhlbHANCj4gKwnCoCBUaGUgTWVkaWFUZWsgTVQ4MTg5IGlzIGEg
QVJNNjQtYmFzZWQgU29DIHdpdGggYSBkdWFsLWNvcmUNCj4gQ29ydGV4LUE3OCBhbmQNCj4gKwnC
oCBhIHNpeC1jb3JlIENvcnRleC1BNTUuIEl0IGlzIGluY2x1ZGluZyBVQVJULCBTUEksIFVTQjMu
MA0KPiBkdWFsIHJvbGUsDQo+ICsJwqAgU0QgYW5kIE1NQyBjYXJkcywgVUZTLCBQV00sIEkyQywg
STJTLCBTL1BESUYsIGFuZCBzZXZlcmFsDQo+IExQRERSNHgNCj4gKwnCoCBhbmQgTFBERFI1eCBv
cHRpb25zLg0KPiArDQo+IMKgY29uZmlnIFRBUkdFVF9NVDgxOTUNCj4gwqAJYm9vbCAiTWVkaWFU
ZWsgTVQ4MTk1IFNvQyINCj4gwqAJc2VsZWN0IEFSTTY0DQo+IEBAIC0yMDEsNyArMjEwLDcgQEAg
Y29uZmlnIFNZU19DT05GSUdfTkFNRQ0KPiDCoGNvbmZpZyBNVEtfQlJPTV9IRUFERVJfSU5GTw0K
PiDCoAlzdHJpbmcNCj4gwqAJZGVmYXVsdCAibWVkaWE9bm9yIiBpZiBUQVJHRVRfTVQ4NTE4IHx8
IFRBUkdFVF9NVDg1MTIgfHwNCj4gVEFSR0VUX01UNzYyOQ0KPiAtCWRlZmF1bHQgIm1lZGlhPWVt
bWMiIGlmIFRBUkdFVF9NVDg1MTYgfHwgVEFSR0VUX01UODM2NSB8fA0KPiBUQVJHRVRfTVQ4MTgz
IHx8IFRBUkdFVF9NVDgxODggfHwgVEFSR0VUX01UODE5NQ0KPiArCWRlZmF1bHQgIm1lZGlhPWVt
bWMiIGlmIFRBUkdFVF9NVDg1MTYgfHwgVEFSR0VUX01UODM2NSB8fA0KPiBUQVJHRVRfTVQ4MTgz
IHx8IFRBUkdFVF9NVDgxODggfHwgVEFSR0VUX01UODE4OSB8fCBUQVJHRVRfTVQ4MTk1DQo+IMKg
CWRlZmF1bHQgImxrPTEiIGlmIFRBUkdFVF9NVDc2MjMNCj4gwqANCj4gwqBjb25maWcgTVRLX1Ra
X01PVkFCTEUNCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvTWFrZWZpbGUg
Yi9hcmNoL2FybS9tYWNoLQ0KPiBtZWRpYXRlay9NYWtlZmlsZQ0KPiBpbmRleCBkMWY2NGQ2MWFi
OS4uMzVmNzQ4YTcwZDYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvTWFr
ZWZpbGUNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9NYWtlZmlsZQ0KPiBAQCAtMTQs
NiArMTQsNyBAQCBvYmotJChDT05GSUdfVEFSR0VUX01UNzk4NykgKz0gbXQ3OTg3Lw0KPiDCoG9i
ai0kKENPTkZJR19UQVJHRVRfTVQ3OTg4KSArPSBtdDc5ODgvDQo+IMKgb2JqLSQoQ09ORklHX1RB
UkdFVF9NVDgxODMpICs9IG10ODE4My8NCj4gwqBvYmotJChDT05GSUdfVEFSR0VUX01UODE4OCkg
Kz0gbXQ4MTg4Lw0KPiArb2JqLSQoQ09ORklHX1RBUkdFVF9NVDgxODkpICs9IG10ODE4OS8NCj4g
wqBvYmotJChDT05GSUdfVEFSR0VUX01UODE5NSkgKz0gbXQ4MTk1Lw0KPiDCoG9iai0kKENPTkZJ
R19UQVJHRVRfTVQ4MzY1KSArPSBtdDgzNjUvDQo+IMKgb2JqLSQoQ09ORklHX1RBUkdFVF9NVDg1
MTIpICs9IG10ODUxMi8NCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvbXQ4
MTg5L01ha2VmaWxlIGIvYXJjaC9hcm0vbWFjaC0NCj4gbWVkaWF0ZWsvbXQ4MTg5L01ha2VmaWxl
DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwLi44ODZhYjdlNGVi
OQ0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsvbXQ4MTg5
L01ha2VmaWxlDQo+IEBAIC0wLDAgKzEsMyBAQA0KPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmll
cjoJR1BMLTIuMA0KPiArDQo+ICtvYmoteSArPSBpbml0Lm8NCj4gZGlmZiAtLWdpdCBhL2FyY2gv
YXJtL21hY2gtbWVkaWF0ZWsvbXQ4MTg5L2luaXQuYyBiL2FyY2gvYXJtL21hY2gtDQo+IG1lZGlh
dGVrL210ODE4OS9pbml0LmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAw
MDAwMDAuLjU2ZTg1MmUyMzc0DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvYXJjaC9hcm0vbWFj
aC1tZWRpYXRlay9tdDgxODkvaW5pdC5jDQo+IEBAIC0wLDAgKzEsNTggQEANCj4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+ICsvKg0KPiArICogQ29weXJpZ2h0IChDKSAy
MDI2IE1lZGlhVGVrIEluYy4NCj4gKyAqIEF1dGhvcjogQ2hyaXMtUUogQ2hlbiA8Y2hyaXMtcWou
Y2hlbkBtZWRpYXRlay5jb20+DQo+ICsgKi8NCj4gKw0KPiArI2luY2x1ZGUgPGZkdGRlYy5oPg0K
PiArI2luY2x1ZGUgPHN0ZGlvLmg+DQo+ICsjaW5jbHVkZSA8YXNtL2dsb2JhbF9kYXRhLmg+DQo+
ICsjaW5jbHVkZSA8YXNtL3N5c3RlbS5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3NpemVzLmg+DQo+
ICsNCj4gK0RFQ0xBUkVfR0xPQkFMX0RBVEFfUFRSOw0KPiArDQo+ICtpbnQgZHJhbV9pbml0KHZv
aWQpDQo+ICt7DQo+ICsJaW50IHJldDsNCj4gKw0KPiArCXJldCA9IGZkdGRlY19zZXR1cF9tZW1v
cnlfYmFua3NpemUoKTsNCj4gKwlpZiAocmV0KQ0KPiArCQlyZXR1cm4gcmV0Ow0KPiArDQo+ICsJ
ZmR0ZGVjX3NldHVwX21lbV9zaXplX2Jhc2UoKTsNCj4gKw0KPiArCS8qDQo+ICsJICogTGltaXQg
Z2QtPnJhbV90b3Agbm90IGV4Y2VlZGluZyBTWl80Ry4NCj4gKwkgKiBCZWNhdXNlIHNvbWUgcGVy
aXBoYWxzIGxpa2UgbW1jIHJlcXVpcmVzIERNQSBidWZmZXINCj4gKwkgKiBhbGxvY2F0ZWQgYmVs
b3cgU1pfNEcuDQo+ICsJICoNCj4gKwkgKiBOb3RlOiBTWl8xTSBpcyBmb3IgYWRqdXN0aW5nIGdk
LT5yZWxvY2FkZHIsDQo+ICsJICrCoMKgwqDCoMKgwqAgdGhlIHJlc2VydmVkIG1lbW9yeSBmb3Ig
dS1ib290IGl0c2VsZi4NCj4gKwkgKi8NCj4gKwlpZiAoZ2QtPnJhbV9iYXNlICsgZ2QtPnJhbV9z
aXplID49IFNaXzRHKQ0KPiArCQlnZC0+bW9uX2xlbiA9IChnZC0+cmFtX2Jhc2UgKyBnZC0+cmFt
X3NpemUgKyBTWl8xTSkNCj4gLSBTWl80RzsNCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiAr
DQo+ICtpbnQgZHJhbV9pbml0X2JhbmtzaXplKHZvaWQpDQo+ICt7DQo+ICsJZ2QtPmJkLT5iaV9k
cmFtWzBdLnN0YXJ0ID0gZ2QtPnJhbV9iYXNlOw0KPiArCWdkLT5iZC0+YmlfZHJhbVswXS5zaXpl
ID0gZ2QtPnJhbV9zaXplOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3ZvaWQg
cmVzZXRfY3B1KHVsb25nIGFkZHIpDQo+ICt7DQo+ICsJaWYgKCFDT05GSUdfSVNfRU5BQkxFRChT
WVNSRVNFVCkpDQo+ICsJCXBzY2lfc3lzdGVtX3Jlc2V0KCk7DQo+ICt9DQo+ICsNCj4gK2ludCBw
cmludF9jcHVpbmZvKHZvaWQpDQo+ICt7DQo+ICsJcHJpbnRmKCJDUFU6wqDCoCBNZWRpYVRlayBN
VDgzOTFcbiIpOw0KPiArDQo+ICsJcmV0dXJuIDA7DQo+ICt9DQo+IA0KDQpSZXZpZXdlZC1ieTog
TWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1
bCBMaW4NCg0K
