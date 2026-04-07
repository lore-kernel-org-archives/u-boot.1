Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD53AFEEF44
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:33:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1278B840AB;
	Tue,  7 Apr 2026 15:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="q8m1bQ3K";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="ifezKsR6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ECBF84105; Tue,  7 Apr 2026 15:33:00 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44E1183F98
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 45159b72328611f19a16598d5ca7f8ec-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=jZwQoYuCAwD2qi7UCqukbq6bWULGTqIRZrhPTmWrtIM=; 
 b=q8m1bQ3KiOtL06oiOSr6jjMXgZ2O+DU/ZzmKTFnw7AUZdHdretR9nEd4IiPWq1h2boZkwhvcn9dXa2PywkM2t8SNonO0CPNbv++enck9FNvjuvGrKLYAw2CCAH7WphB1BNj9hKbgK2rMCW/OxIUcCijh2VpL2WPOG508L4dpoqE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:d0e51cf4-94fd-4ef1-ad61-bfc52e487399, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:03f8248f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 45159b72328611f19a16598d5ca7f8ec-20260407
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1099575632; Tue, 07 Apr 2026 21:32:49 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 21:32:47 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 21:32:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcNyKhCsqz4pt2O03U880G7NJma68XXSB1TdRt+0n/5QHbY6cB1dEiAKGiWzmO8Vuu8mP8eZkjXiujQt60oNf6j97Ff9mc/QOGNVUunB0EmHL0uWKtREK9/7MoM7RdeEBDB8a4tE6zV4mIaCe8G+WYf72Fp98ow0z+/2JjfOHGdmBF4S1AK8MVVnpp46DVVgsvhhe9arKDHrPKmGmqBwDyC/r0FSvZrrtyzKq2UG2Z8xlDkGjKxfEiqA3tOfCh1DnOsYi901W9Nv1wJbhC5wQ4zTF2Cc7tsoo2mmJz99tjK+4R41gaUcyKpVBLqeH3sk1/Vl3cRMu2jt85h2O9mpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZwQoYuCAwD2qi7UCqukbq6bWULGTqIRZrhPTmWrtIM=;
 b=h/Dgmz0YnRgEhVleftPe7oCb7mooOdw9a/j/MTHtMVQICEo2ylM9Xe3eiJHLQPjFy0HJRVCro8K96zms4JftcDArUOd+9kmGXKARD+YpagddUuwq8DAeIIFbNRZ1us1zy1+39v8B/hFyJqkx1KBX7Vw4Jh6tIB+GUe8lkTyCSKNK5HRNc7eCENHStj0/cD87wj4BacgYCk+0ibcghLGe2YjclQxhd/zzKUgacTy7WrLlVlg5at+j/K+9Z4JFbMNkj4W2ntC6tSnc8Wl4v3BoVyGqQh+J8GwiclmK0VE5gNwK9EY0LK6OlOHlOkTTO2R5SEO+IrixBNqivJtzcKPRKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZwQoYuCAwD2qi7UCqukbq6bWULGTqIRZrhPTmWrtIM=;
 b=ifezKsR6P4k6Pg/Oqu+ka7/p2U9b3YHSM04uslCH5gJkvaI69iMRuvuI6SAizdl888XeYzuQ1gB51jMFb4h1nmYWHdfMHmq80i/TopZEqzLCJ9lJ3aYhnvYlrIiL2nN2ZXdOkdG0PCI+539jxwlq5/ZWFfFMipw5TLlbIdT8ACw=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by TYSPR03MB8427.apcprd03.prod.outlook.com (2603:1096:405:59::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 13:32:45 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 13:32:44 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: Julien Stephan <jstephan@baylibre.com>,
 =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, "David
 Lechner" <dlechner@baylibre.com>,
 =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?= <bear.wang@mediatek.com>,
 =?utf-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>
CC: =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>, 
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>, "lukma@denx.de" <lukma@denx.de>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?= <Chris-qj.Chen@mediatek.com>
Subject: Re: [PATCH v3 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
Thread-Topic: [PATCH v3 6/6] board: mediatek: Add Genio 520/720 EVK defconfigs
Thread-Index: AQHcuwJfTnl07kaF0UibDGt4foAcmbXHO8qAgAx0N4A=
Date: Tue, 7 Apr 2026 13:32:44 +0000
Message-ID: <ba7ca476be7db87132d59ee3cca03f166e953f8d.camel@mediatek.com>
References: <20260323-mtk-mt8391-initial-support-v3-0-19dd92f4543f@baylibre.com>
 <20260323-mtk-mt8391-initial-support-v3-6-19dd92f4543f@baylibre.com>
 <CAEHHSvanPwLr8GyUrCO1Pmo=PuS1Ymy1wmzdwXZeGW2KBiTagA@mail.gmail.com>
In-Reply-To: <CAEHHSvanPwLr8GyUrCO1Pmo=PuS1Ymy1wmzdwXZeGW2KBiTagA@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|TYSPR03MB8427:EE_
x-ms-office365-filtering-correlation-id: d5e114a2-2d53-4d8a-80a3-08de94aa26ad
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|38070700021|22082099003|56012099003;
x-microsoft-antispam-message-info: WYowV2GKCSQ11chXqZnqtIIJYLxksnS4DD+N6fCAWmbGdMmXJb2BCYRKiZ/k1kC4xB4XLKeetBRz+5jBxfpqzuy024otv/pKtye9NnOgAVJolnRdtx9wACoigzZoBDuwZ9upMzGkUfvtm4cvmyG6LuoW+OCMD4+ysu8Md3H5ZoXSRbITSr+290jKbFdw5qFLso/jpDxlDRRq6cxDWLybR7gFuAtyCE3A6SVJaxx10VSZlUVf3B9G5e37e4EhcEndg+D/UlbEapkvaQ3Vf7+E7mtyeFDsfIV9YdW5lqP2UsIqtR7f2Ql79PbnLQP/rC71YF1gUkh2EW53hJEN9JzjJvOlwV4HRI2GDCrfth4m/ksXIU70YO5BLeFJP2roxWq35j6cF2ou3qiQgp8wXfjcVP+NrFNG/w+/4lv+pRX9akox48Qi19YFrdKgTcqDOdvSqoTf28fHXEPnDFNq2Os31VF+bj4mecJWZwP2BpjfkRgqJMk13Qxg2urubo3WRlZHdZZSi2ZzJF8yhmkQqJ9t1b51kYCjwX81bg23wFbdMm5pb20wp+zNJZ8QDFNGYyeQueqawtT8g9zFrpTP8zPeBrSpeOjDYWbS4tttxU2VjqgmHSSuEKcZ3YaqfFj7/lh32+Vl/8EJjtogZTu06YqQUyeoeUWVJHi+pz4zdCd6OmDNO3l56GMYWdm+ZZsjxqV2E5ItkJWfkmxIIRw2BVEkT1WssscWT2Q4CN78Spl4zNh3LE0KJbuxFPknOFTqkdRdRopYwJi8SF6y6uqrRWpeQlErdARbsn59WaPtNV3UHwU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(38070700021)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUhiRHQxL3k0S295SjVwSmNxajBWbDlzU1duRW1zRjk3Wkw4cWlPOFMvN24v?=
 =?utf-8?B?VmpZS1V0OUFlZWl2ckFnNzNUd1N3Q0FSNlZ6aXVnRlZaNENDTWhuTk1LMjNQ?=
 =?utf-8?B?cndGdmxBUkg4dlQwT1hhTmlOakVJc0pETlZkdUo3UFpnV1k4N2N6OUtaS2E2?=
 =?utf-8?B?OVQrbmJNazRHOUkwWEYxS0RzSlh2eVVwVDV1dGRWOVNtZUIyakYrMzJyR0NF?=
 =?utf-8?B?WE9LS0hOa1RIb2YwWDdLcGdGY3VBRlhtckU0YmpmQm1MSlErakdUcWhabjI4?=
 =?utf-8?B?RFErQk5XMjYyNXFRWUxQbk9FdHcwb1I1QTF1a2JLRE51RVUvM1NEc0phNkJa?=
 =?utf-8?B?UXdVTUUzWE04bnpQZDcvSjc0eUJjN29jNkRiYWp6NCt4dithSTVpakJncTVG?=
 =?utf-8?B?ZVhIRzdqZWRDSEs0Y3B0T1pWMUM2ZGpIRUt6R2ZQeWZ4QzdvTERvcXlKOW9X?=
 =?utf-8?B?Q0NwSnl3LzFjaHJSeEF3UDhwS2hPQTdDOCtOQlU0OFFOaWpLTTBZVkJxWStB?=
 =?utf-8?B?NU5YdzNWWVJ3VEpuZDhEbjBsYUtVSHVIOHkwT1RUYnJ6REp6SzhjK2c0Q1k0?=
 =?utf-8?B?YUtpRVVtSUcrajIwZWZmdTJLdE01aFpCNkZyMjF5TXN4VWE1aENpOUduZjZC?=
 =?utf-8?B?OTNxV05FbmVTZFh5RXl2VFJ0L1FaK1ZUWDdCNW1JQlFzeEhIM0pqT0NPYjNz?=
 =?utf-8?B?ZmFqbzhIdUJyNTJsMktOSTN6aVJvclE0a1dWM1BieVlkN0ZVVWp5SVZOYUJ1?=
 =?utf-8?B?aW4xUjRNc0R1eHdRZXpHWjBxampaWG9pdjNJYUFGdzRIOFpqNXdCbnB0WjBt?=
 =?utf-8?B?Z1pGZXBEaXkyNnZ0aHlUQ1dnZXJuYU45NHRmaWpqcTBoK0VkR0l5clVvaUxK?=
 =?utf-8?B?Nk9RcEZlZ0Fyd2VxZ29HRGFZMFRMeWZ6bDJjVlhyT1RBUUlCalhVL2hJdDJH?=
 =?utf-8?B?Wmo2bUZaTEkzd21rWVlNbUk4bW5iOC9STEJxZGdPSDFHVTloeWFMNENvR2l1?=
 =?utf-8?B?Lys5NG5Ec2FrMFNxVWZYQ2ZwVjRlS3JFOGdMRExyR0JQbE5wVm91SXVnb0lE?=
 =?utf-8?B?MU5lRFJaNnNOYXNUVThPKy85c1IzTWhzOFBybFdmeDJpb2VQT1dLdkxvOWFs?=
 =?utf-8?B?Y3VDZjdFQmVlRmNkdm9BdDVMQlhLRlpHeElGVHhQSDN5N2pnU2NNTmVZZGtw?=
 =?utf-8?B?SDNvR0w1L0J5UUhpOEZBR2swNU4ydnphSUlRK1daTytiMjhLaHFUSmlYRkJz?=
 =?utf-8?B?THlIZ2F3WkE4VnZ5Z29sRXJFWUhOSy8xeG5CRHJMclZQTXhwamcwOEx3M3A5?=
 =?utf-8?B?d2hKQy8vVUpzbHgzRnk4bTdVQVhLeEUvcTkrYkgrcnl3STVFLzZkZGJzdE4v?=
 =?utf-8?B?RXRQenJGZFVjV3RoNXBRNFo5d3BTcjhOTGFTbE9JdjJoREFyVTRZeFRYU3V4?=
 =?utf-8?B?S0Q4OVVPS24yOXBsQW42aEFBaWZTY0trYm9tQmxabm9wSDVCa3hIY3NkRXdt?=
 =?utf-8?B?WWtCdmlJNlVTa3BwQ1FWNVpyU0tQYmw2U3pEQkREOHVtTVZPNzRJWnJyT0pQ?=
 =?utf-8?B?QndCZ1RxazlOaWlKMDUxY2M5MlM5TUF4Q21DQnp6UjF4bXpiMitCUzJIbkdX?=
 =?utf-8?B?eTM1UUsvRmJ3K0Nzd2tJVWJrZ3JGVVJtQWxraWd0ME5rTGRDQzFsa0FmR2tn?=
 =?utf-8?B?Zm94RHA3RTE1TXdTVURDbTBGbnpFQXVXNHlxRXhLc2pMa2Y1bkh5WEZaQmk5?=
 =?utf-8?B?L0Y4RUE0Q1dkWmVtaThsS0RPUzVOUEtHaFpIb256SHZHNUwyQnIrZEVKN0Ji?=
 =?utf-8?B?UmdHUlMxR0h3bnNML29nMjAwWGJqaGFEN3FjWDR2UUJGNTY4eGhkQkY0MzJC?=
 =?utf-8?B?RWU0UDZXTWFXVElYRnRVaUlldW1Mb3NvREtPd0prT3NGL2N2UERJNEg2U1A4?=
 =?utf-8?B?Uk5QdGZtU2tYNHpuTUZCUlFmenVyaGRUa2dEMnJ3ZCsvR1RZWE5ZSFhwNCs1?=
 =?utf-8?B?SThNMzlHM1RabWc3QmI0eWppRm1RVUQreERTaVA0OUtsTURnQ1I2Yy96c2Jn?=
 =?utf-8?B?QTJ0QjBLN0lncFVJRTQvbHk5empNdUNuc005cFpCazRxd0lBZlQ5Q2JVVFJQ?=
 =?utf-8?B?UmRjUkJSNmk2ekhjQXVNZno3aExnMzkwem5OWXRxcVhqVCtFL3hZRm82OENH?=
 =?utf-8?B?d0lQdjhSc2tNQkg4MXBFNkZUcTBmazRmNGZ4eG9LNU5nYmpQWFJaVisxT1FI?=
 =?utf-8?B?NTNmUUhFMUJqcXplVEJxNWt5Y3R0Y0w2R2JYM25vZHlEWlJwWmpNZ0xQcTZt?=
 =?utf-8?B?dk9IV1RIOXgwcEZwMTdrNTFvTDRPeDZMcEppTk1NWmlXQXlRdFZWUThQOU4r?=
 =?utf-8?Q?m68v/Jl/6KDkUPF8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4C19CA7C1013E4ABC97FA8CAEB80F2B@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: YASv9Xo58rqs5nGvvjbZsSQAoevfEaDv+5YyknnKeMFfovRXEurTuW3zSvwE8m0Qy1UtohrsobNsO13hqWfQTifZP3kTwvSspnjK7/V+wI+z2eB9fYYfkW5rCwRVEKr6zevvUFYWP3fsXwd7TjoZG4ksnpunyRPbMoni21YW6/lomtZgvCj5ZLc1Vdukav1cYs/s2UCCAdx4Kv7ufT4GSbjn2bjo0KIbKPDkTjVMzwwMxI90xLGDmCfssJGGyDcvjuAjSad51nTbllpC3Gc0Iv6mZCXwfoQ2NIoS/8cBbeVpZH0s/ybFf5erU29FDWxfwOkrmRA3AodapSj45O/1WA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5e114a2-2d53-4d8a-80a3-08de94aa26ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 13:32:44.6966 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JgubL4kmBD6cvTi27XV2+Y+sYsWrbYAyOIf6RwBNkh6bjI0mVnJQD0pmec/mD8HkWgdb6etQwURZSmY+KEeoyT6HJ1TsV2Adg2KtvzxS454=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8427
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE3OjIxICswMjAwLCBKdWxpZW4gU3RlcGhhbiB3cm90ZToN
Cj4gTGUgbHVuLiAyMyBtYXJzIDIwMjYgw6AgMjE6MTgsIERhdmlkIExlY2huZXIgPGRsZWNobmVy
QGJheWxpYnJlLmNvbT4gYQ0KPiDDqWNyaXQgOg0KPiA+IA0KPiA+IEZyb206IENocmlzLVFKIENo
ZW4gPGNocmlzLXFqLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IA0KPiA+IEFkZCBiYXNpYyBkZWZj
b25maWdzIGZvciBHZW5pbyA1MjAgYW5kIDcyMCBFVktzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IENocmlzLVFKIENoZW4gPGNocmlzLXFqLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IE1hY3BhdWwgTGluIDxtYWNwYXVsLmxpbkBtZWRpYXRlay5jb20+DQo+ID4gU2ln
bmVkLW9mZi1ieTogRGF2aWQgTGVjaG5lciA8ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiA+IC0t
LQ0KPiA+IMKgYm9hcmQvbWVkaWF0ZWsvTUFJTlRBSU5FUlPCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIDcgKysrKysrKw0KPiA+IMKgY29uZmlncy9tdDgxODkuY29uZmlnwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDM0DQo+ID4gKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKw0KPiA+IMKgY29uZmlncy9tdDgzNzFfZ2VuaW9fNTIwX2V2a19kZWZjb25maWcg
fMKgIDQgKysrKw0KPiA+IMKgY29uZmlncy9tdDgzOTFfZ2VuaW9fNzIwX2V2a19kZWZjb25maWcg
fMKgIDQgKysrKw0KPiA+IMKgNCBmaWxlcyBjaGFuZ2VkLCA0OSBpbnNlcnRpb25zKCspDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL2JvYXJkL21lZGlhdGVrL01BSU5UQUlORVJTDQo+ID4gYi9ib2Fy
ZC9tZWRpYXRlay9NQUlOVEFJTkVSUw0KPiA+IGluZGV4IDQ0NmE5ZThlNTNjLi40ZjM3MTU5MjA1
OSAxMDA2NDQNCj4gPiAtLS0gYS9ib2FyZC9tZWRpYXRlay9NQUlOVEFJTkVSUw0KPiA+ICsrKyBi
L2JvYXJkL21lZGlhdGVrL01BSU5UQUlORVJTDQo+ID4gQEAgLTEsMyArMSwxMCBAQA0KPiA+ICtN
VDgxODkvTVQ4MzcxL01UODM5MSBFVksNCj4gPiArTTrCoMKgwqDCoCBNYWNwYXVsIExpbiA8bWFj
cGF1bC5saW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gRG9uJ3QgeW91IHdhbnQgdG8gYWRkIHlvdXJz
ZWxmIGhlcmU/IFNpbmNlIHlvdSBoYXZlIGFsbCB0aGUgYm9hcmRzIHRvDQo+IHRlc3QuLg0KPiAN
Cj4gT3RoZXIgdGhhbiB0aGF0LCBmb3IgdGhlIHdob2xlIHNlcmllczoNCj4gDQo+IFJldmlld2Vk
LWJ5OiBKdWxpZW4gU3RlcGhhbiA8anN0ZXBoYW5AYmF5bGlicmUuY29tPg0KPiBUaGFua3MNCj4g
SnVsaWVuDQo+IA0KDQpTdXJlISBJIGp1c3Qgbm90IHN1cmUgSSBzaG91bGQgYWRkIGEgdGFnIGZv
ciBhIHBhdGNoIEkndmUgcGFydGljaXBhdGVkDQpiZWZvcmUuIEFuZCwgSSd2ZSBqdXN0IGNhbWUg
YmFjayBmb3IgMiB3ZWVrcyB2YWNhdGlvbnMuIFRoYW5rcyBmb3INCnJlbWluZCBtZSB0aGF0Lg0K
DQpSZXZpZXdlZC1ieTogTWFjcGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0K
VGhhbmtzIQ0KTWFjcGF1bCBMaW4NCg0KW3NuaXAuLi5dDQo=
