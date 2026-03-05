Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273CFF33A65
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 13:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CEA083EDF;
	Thu,  5 Mar 2026 14:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="cvFR5hap";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dljBjA1O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6848683F2E; Thu,  5 Mar 2026 14:56:26 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F398781E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 14:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 144f66ee189b11f1a39cd589f645bc18-20260305
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=65StyX4f2pN4z5goWN01BemsvsdXEJ1vMPR/y1+UnQI=; 
 b=cvFR5hap7JzCdKj4uIIF+N1F8xUpu5GoaDBGMSnIQzK6CRxND/vyfZOhyYQeoJ6NYgd9LVkukvXq3bM2iF/Kj0HB6FbQaIj7O5HmMpvteesF81D302K+TqG62zphFvCqPBCYBg/32WdALNeFKrrgwSKQ2m67t6PpY29D6fX6zlU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.11, REQID:fc6d3d5f-1f3e-4d0b-a80a-738bed3e583f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:89c9d04, CLOUDID:62588f7b-8c8a-4fc4-88c0-3556e7711556,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BE
 C:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 144f66ee189b11f1a39cd589f645bc18-20260305
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 83872468; Thu, 05 Mar 2026 21:56:16 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 5 Mar 2026 21:56:15 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Thu, 5 Mar 2026 21:56:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRyaCZYLV53xijVl+krbra+O+gUOrXTUsJVInvPFhC77uhmlhrtPyw34psEt4q4QsKFa+jcmTaNtPGUREu7wKkrDAuDaG9PLhu/e/3japBW72bCLIhoIw6ejFKUVWTWYKNxL+m8HAbzITcSgm3kjS4oNMSMPU9AxfjIfbrvQuch6dr1C/wUegjG79JOzL6Rc2/s8puxsCNihtPDm30+BFORfCSjxrl9IXSUEEikpfkavuVYv03rCLVX64JcSTr32RV34LePsCwaWbTYX9D6HTsqfo8MmT+3NTqJqLnVZf/FnNTuTv6cwNuEt7r1X/7++uBaK2StQ0dtuJiApeSLPMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65StyX4f2pN4z5goWN01BemsvsdXEJ1vMPR/y1+UnQI=;
 b=xv5pRAaTlG67k3frULdwSeHKbrIR4qJXdTehW9CY9rEh4MynhNGuii7yHLV2wYKlKdnY2C3CaJsspqWgfNxCRYbYZpzLrg+vlic8Vbglphz9zyJ1sTRyXVVQNh/880obvZLj/zuM43VixX9nu6JEEYohEIYfktBrFFM/VAH2+PDyar9vtpFry3x7quANipNeneKbPRWgYBHv7g01Q4mPLUkKwIZyC9HepC1KTbaeXevAeaZO8qxdJ+gFDXfdW+EIj5ZpLQ/7InvS0K3ho88/fEVVAuKyIVWWorEIFuxbVXMlw1/BoSoY8M5OSLTpXlWFQwR6PTEOLAhj8qr3V2rvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65StyX4f2pN4z5goWN01BemsvsdXEJ1vMPR/y1+UnQI=;
 b=dljBjA1Oj1QDphsmqCJLelurSzPuyuqrmdWnVQsclBlRs30+UARyjaaJE8tubYiH4tZBX65QmSA2HkBO51ea62w+5j2T47nrZyIBQkfxUvvmnyZbCYzY9hWyzLMPrXETo/h44AQZuGuy8Te2Rv14eWPF/4LwXYNAz/tQxzd4/58=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by KUZPR03MB9734.apcprd03.prod.outlook.com (2603:1096:d10:61::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Thu, 5 Mar
 2026 13:56:12 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9678.017; Thu, 5 Mar 2026
 13:56:12 +0000
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
Subject: Re: [PATCH 08/14] clk: mediatek: mt8195: convert to struct mtk_parent
Thread-Topic: [PATCH 08/14] clk: mediatek: mt8195: convert to struct mtk_parent
Thread-Index: AQHcqqHQdwiG2DT3SkKvNmuX3HZcubWf+mGA
Date: Thu, 5 Mar 2026 13:56:12 +0000
Message-ID: <944e78cbf622c09ae1393595d438fb7b076f7d2b.camel@mediatek.com>
References: <20260302-clk-mtk-unify-mux-parents-v1-0-32f45085f4d0@baylibre.com>
 <20260302-clk-mtk-unify-mux-parents-v1-8-32f45085f4d0@baylibre.com>
In-Reply-To: <20260302-clk-mtk-unify-mux-parents-v1-8-32f45085f4d0@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|KUZPR03MB9734:EE_
x-ms-office365-filtering-correlation-id: 4c0c433a-f5bb-4afb-d298-08de7abef622
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|921020; 
x-microsoft-antispam-message-info: qKTXrOMfsM2ByuC4vO7CSfr0taC1S+FrNgwl+6ZfPevNGGTUw96UPiPwyyQ1nKenWDd0uxy40SM3gPzFECKA/B+wmIs99vw6bzlVubcUsMS/wpnSiVzxXUvFiSWASjLMrQ8c61jnAraK5oLcW9IWmyw2PXZ2ZeDKnjn4JNjTy81TkQk16i0onfUa0l5bxU6ki/oQsPUFJ8WHSGDvlEnMaRyEN8Zqre//pB8JeiovETuOcRjHoHrNjq1v2ocwgNwl0U9ZwayjXw+1ZCjgD54/ehfxjWIUk7SgYgI9pv6sSE+E2l9O4wtHkklGw6YVOWO6H2DyvzKytDrg2gsz5HGqC39yqtBolVmkyJUsU78s5XDD5VURM5P5dZL7wp27W0XTrKlQrxr43Dpr0jsN2kThLMKEJnIJ9k5P9aCVZ/rr7F3jQtDQXWM9z7QaNiqJHecer8ixtoOhqhvQq6/w9PH6m9zXz6bq3a+4/tdN6hM5PmrZfy5AxMGkSwan0T71HinymCM3ioj/TlA6Dx9544f7QCEMramui/aYYo1v/4gwPSQs8ZaQL1aouz2rkTO0wju7FzeAf+KLX6aXWouNx3SFULP1FjZ6O7EKEXeHsBNrhBbS7S2wwh+5N6JAW3KhBhWlTRN5RPWcHKP59eZFylqSbIgNCdGepz3HgZao3lruHPNVzRPMNyArc+MpMwLX66Bm1dyg17mwhFFVEzKa4PxhDlv9CUxGJ+VHRg1Uc/I00UuUuwU1uZXOcgQg8ys3fnZvHqGJQ1+N+UBhGeHaQGpfE43jVtyYoqRTLV5E/fgaRzA/QNgfkMeHo1l2igZBBO41
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(921020); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlRlQ0J0VnBUU2FYTG5Mai9lTFNSN1BzWUlCSUpCNmY0ZzJSc0NZaUIrNTYr?=
 =?utf-8?B?cFp2NW1DaVdUVlVNQ0tySllwM3dPNEtTNUg1eUVqMnAxNkhSMVdsM2tTUjdw?=
 =?utf-8?B?a2NOMUY1VnRrWnEyb3p2Y1pzTWJmWEJWRnAyWVUxWThzSitHRVl6bGFxelc4?=
 =?utf-8?B?NUJDdnRoQlBmRTZOU0RJUjZEa2NyVmdzRjN4R0lIc1NVcTFDbGxrVUxtTHZ6?=
 =?utf-8?B?dHdvTEg5L3Q5YTZydHkrZUpYZ09VZGVwSWdvMGl3SU10MC8xeHlpYmxENlo1?=
 =?utf-8?B?alFJTFIrRkZ4ek5vb2ZlcUUrY3YwSmd6Vkl5Q0pRdk02UEhJL3lwbWhWWnU3?=
 =?utf-8?B?UTRrRVhnTkNOU1ZSR2xTZ1VRY1JrZHF2OTFHL2t5MndmMzU0UWNjdDl2Ulo2?=
 =?utf-8?B?Rm9QZlVvMnNhMk5zUHY1b0dvUmF0MlNnU0JEM1FieXlQMnEwU3hqNlpBc2lY?=
 =?utf-8?B?djF1enpRbkRwc2tUWTZNeGN4TFJESVljS21OYVNVRjJBUUo2d1pHNGJ4K0ho?=
 =?utf-8?B?TWtlakdNZHFoZmcwMVVIaUVIVjVNT3V3YXF6ZUdmT1hJNllseVFRbGUvUTJ2?=
 =?utf-8?B?RFBBak4yUi83VVFZOHAvcXZtMnpGMVlybFEvOUVxb1c4V3BTOVNHbUQvZGdo?=
 =?utf-8?B?VVhjbit0TnA1N1RrV2dka2R4bXo3YlJYM2JEN1E0bGtkZk14Wk9ncnJWTU10?=
 =?utf-8?B?a1lxUFd2Y3VvVlNENjNzWVhqbXNTSm1qclFRTUFYYXlxckdLUk1VQnJXdHcx?=
 =?utf-8?B?N3JaLzZGSUQyVDV5MURKUFROYW44N0xFK2JKWU5rNjJBbTdBbzYwU0luZ2NT?=
 =?utf-8?B?alpDbWF2aUJTQVllUjlqLzNZc21YMlNXeER4RjZJSWlYdWFYZ1NXc0FwRXpM?=
 =?utf-8?B?MnhuUjZhT3Vvbzc4SjVwRUlTNkxsa0tGSGFDVjdsZEw5dWJuOVJnQVhyVkpC?=
 =?utf-8?B?VjlSUi9WNkFXR0xIU3dvYWlWWUZBVzBrMFpZUjdpaHlBejhyam1NS2QrQWZ4?=
 =?utf-8?B?VkZtY3dJL0ZZRVQzazludGFWRVJXZmtuNmlvRFRQZW13RkpQWFFnc3RBS0VG?=
 =?utf-8?B?dmpjSm91OGM4ekp3RjcxQWtRZHlKS2JCVFVPSWIrbmFPL3Y2UU9aT3RIa0U2?=
 =?utf-8?B?QlFoa3Y3TFNSN21pUVp6TnZCY3NiYzh0NHJJMEJoYUh0UmVNSlVnV0x1YXJm?=
 =?utf-8?B?cjhra3F4alN1SWFLM0hUMzZhWW96OEFRN3QzeVhaVG9QWWU0NWdKaTlzRGNQ?=
 =?utf-8?B?TkNzb0FlVDY5Z1JZOHBJT3dkdDZvclJmQTc3ZDY1dFhwTzZRRzl0UU43TStF?=
 =?utf-8?B?WjA3aEtZcWtQMGJtYUxqVlBidjIvV280UG55Yk5uQkdnZWpaR2xKVVJoc2JQ?=
 =?utf-8?B?T2pGTHBaT1lkZ0MxMzRWeE9hd3prV056ZDIxNTdkQS84cXdlOHNtVW9yb2xw?=
 =?utf-8?B?NFQzdFE4YkNtOTRYWS93VWhwNlJ0OGVEMjRJNXdSb2RheDRsbzNEd3ZubHNH?=
 =?utf-8?B?L1RvSHQrbE5vUFQ2ODU0QzVEcVJLYUJiRFBpNUxtM1BwQVNTaHF1U3RkM2tF?=
 =?utf-8?B?TDhiNnUyTnVZVXlsaWkzaDF0dnA3MFF3c0VnbVZDZlN0UVpGbUNzT3oxSDlS?=
 =?utf-8?B?Z3N6SHNQeXkyeTRVeEdWZWk0U3FOanIwMnlNd0kzUjRLTkcyaE5xaUl0Q1lU?=
 =?utf-8?B?SkVIZ3lKWTcra3ZNd2p4ZFF4WlgzNnc2V3QzQzcxeHFERkNrNXNvaStrcUdw?=
 =?utf-8?B?N3YrYmJpR2FLTFp0STc2ekZ0dEJNQ0VHb3k1NkkzMzNIbS9HKzFNR2RJNHZI?=
 =?utf-8?B?Y2ZTMDBENURYN2l1eW9aVVdxV1FhZUsvdTRUaU1iTlZ5eG5qc1E5eDdQb0VW?=
 =?utf-8?B?TEh2OFdQS3RITVF4VnB0TFJQalpnbE45M1lQY1FCbDFHVkZiWkZ3UENyMUJW?=
 =?utf-8?B?czBHV1lTY1BJUHI2SVpOWHhOZnhqbUZvak16OTFsQmxrSlJhWlc5SzY0TEtX?=
 =?utf-8?B?TnBzalZmTnJlZlUwNSttbnBXOGNVOFhzSzhLWVZyOGp1T1M0dVd2Ny9ZRFNj?=
 =?utf-8?B?UGQxa3doM0h4c3BHRjhvUW1xR2xhby9iMEZzRE0ycU9uY2RsQXNCc1h6Tm9R?=
 =?utf-8?B?U01ncEt5MGd3OGZOQTJJS0l4ZUhUdE1VSGl2RWwxQXpnb09rQ0EyeVY3L2d3?=
 =?utf-8?B?ckdBdWxDZ0xERzIrODNOam9zRVhESFJKYVBJb3hSUHVVUlN4M1g2R1NFbE9M?=
 =?utf-8?B?YW0xelMxN014VE5nRFBJRzY4RkYwc0g0RVgzQnRxd1dPc2VYa28rYXRobEpw?=
 =?utf-8?B?OTVBNk81YmRFaFVmTCtIMjZWdjlkWExWUlYxbzVlMlYxY3NJei9qMTQvQk1o?=
 =?utf-8?Q?2K/jBqRUtXP+nWUo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7592DFD7EF5F674C92E62DFD6C377762@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: rQkpdfjsfPehdjYZbcC1TOE8aAS2qrfrs8eJKyoVxXlUFYJMeT0yNKoeCgEb+FtJRtBuF/o9yIenrPZ/AB3yChAaD5fZO9+kubhKRi4140jwfkHinbM2H5UH///ONlP1Ymd6yXezXqnrRTyn+px1A2mWhhNyOVutS+KmjZLOZjdErPGlhFv+R6i/RWTAVcxvwrYMvGT2cpojbU619+Tx9g8ogAPfREpmfMjGXFNq8b1GjbJf2jOAAdagx94bhtOaO000aUcmI9FeencbTn2H8HeTnAHbNP7JAX6usIpqO283q5cyma1i06sDVbBW59Jp0cNqTnfnGs8cvqMWFuAeRw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c0c433a-f5bb-4afb-d298-08de7abef622
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2026 13:56:12.4683 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0hBnQQ1XcTHpr3gf5UmvzXF1pBdLnwx/t0Qk1nCarW5Mkm1K0c2udS8P0RBcTQHg97/zMBd6mWOcGykLKnKTXplLYRndvOi/u28pCmTN+7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9734
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

T24gTW9uLCAyMDI2LTAzLTAyIGF0IDE4OjAzIC0wNjAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBDb252ZXJ0IGFsbCBwYXJlbnQgY2xvY2sgYXJyYXlzIHRvIHVzZSBzdHJ1Y3QgbXRrX3BhcmVu
dC4gVGhpcyB3aWxsDQo+IGFsbG93IHVzIHRvIHNpbXBsaWZ5IGNvcmUgY29kZSBsYXRlciBieSBo
YXZpbmcgb25seSBvbmUgcG9zc2libGUgZGF0YQ0KPiB0eXBlIGZvciBtdXggcGFyZW50IGFycmF5
cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJl
LmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9jbGsvbWVkaWF0ZWsvY2xrLW10ODE5NS5jIHwgMTU3
OCArKysrKysrKysrKysrKysrKystLS0tLS0tLS0NCj4gLS0tLS0tLS0tLQ0KPiDCoDEgZmlsZSBj
aGFuZ2VkLCA3ODkgaW5zZXJ0aW9ucygrKSwgNzg5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTUuYw0KPiBiL2RyaXZlcnMvY2xr
L21lZGlhdGVrL2Nsay1tdDgxOTUuYw0KPiBpbmRleCBkOWQ2MzYwMWNjNC4uMWRmNWY4NzU1MzQg
MTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvY2xrL21lZGlhdGVrL2Nsay1tdDgxOTUuYw0KPiArKysg
Yi9kcml2ZXJzL2Nsay9tZWRpYXRlay9jbGstbXQ4MTk1LmMNCj4gQEAgLTIzMiw4OTAgKzIzMiw4
OTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZml4ZWRfZmFjdG9yDQo+IHRvcF9maXhlZF9k
aXZzW10gPSB7DQo+IMKgCUZBQ1RPUjAoQ0xLX1RPUF9IRE1JUlhfQVBMTCwgQ0xLX0FQTUlYRURf
SERNSVJYX0FQTEwsIDEsIDEpLA0KPiDCoH07DQoNCltzbmlwLi4uXQ0KDQpSZXZpZXdlZC1ieTog
TWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzLA0KTWFjcGF1
bCBMaW4NCg==
