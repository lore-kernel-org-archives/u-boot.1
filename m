Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC7DFEEF41
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 13:25:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67A88840AB;
	Tue,  7 Apr 2026 15:25:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="utBQP1Xb";
	dkim=pass (1024-bit key; unprotected) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="d/Olit06";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58A578412A; Tue,  7 Apr 2026 15:25:13 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E2C983F98
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 15:25:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=macpaul.lin@mediatek.com
X-UUID: 2d3e5738328511f1ae70033691e9ac7d-20260407
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From;
 bh=WlM3krzeYRnSE2+pTHxocAhMkdfgFe1TDrMBE9eepY0=; 
 b=utBQP1Xb4S2IOEGfRTz7f1kRZjF6CG8lzBnq3QI9tqc1xk59eyA8gBOpSH+0bcoJJ9Sxm4NGBcu3iA9Uo+tGz8d4AENDWDbDxFp/PESBqAbsvPsaEKjFkpT0WC0qcX8KI2CPBvLkAoeOFqlf6YNSZOPTbidE2piTj5T8bWhJIus=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:c30afc25-54dc-4d0a-81da-0e6ed259cea7, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:b5ea248f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|865|888|
 898,TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:ni
 l,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2d3e5738328511f1ae70033691e9ac7d-20260407
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw01.mediatek.com (envelope-from <macpaul.lin@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 232646269; Tue, 07 Apr 2026 21:24:59 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 7 Apr 2026 21:24:58 +0800
Received: from SI4PR04CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 7 Apr 2026 21:24:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nfNfzvSD9KWyZXBrOiR27Q48q/CDczuwQK9mHXb2NB1hmzpPpyTvV1Il6gdxy2Ke4k8HpB9Nj8TPKZhilJqvyOzA0OUAlpIi6B+uu4e/RF1FbPDMcrLsnSbyBc2m5e2yfKcjVRtqsLh1xZwFl8d2bd6IVufUImdVjC36a2Cwrc7SqgpwAF4myjhSBSy7tVXW2mnXKZZ6eUKVB7tTsBTG5QNYsWtKWnKN4SUX+l5+M+H+G7HKdsk48OATg+aC2W8qiK82lW4toHHVSfAQZpCifqMy2MaUdJDVjp+4dcxKdMF6eKRDTRKRbN7YBrQ8y58sg3SEi2sOzX7Fn0ymGaGhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WlM3krzeYRnSE2+pTHxocAhMkdfgFe1TDrMBE9eepY0=;
 b=TjSLT6ZEpZQx6YZJjBhJrlA2MLpctFsngLwrX1CSmkMU8cdpVnXQyyAodkwvXo6g6KcSgogncv+v985z391H5A95FJ+LWAdSclI6r+wTUwKN4SVrU3E5erwJAW9QVquYL4f11fgPSrUGltAxf8oa9p5Ul+VtY1sLP8+uYDtKO4oIjmw6jpJ0hihNj0GFKNzpEtLfBoY6X5QuOSIVZhYB2uyyQBMsawpOGmSf5BzaZNnHOyNEBRExuicTO0EPmAfTimw2SWMAIVgDEwMtklgterAtqEtnMKCBobqeB13sGb7XHZRpSS+KJpYH5I9ImNfkeD0eMziUTVIEONoKzoK7zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WlM3krzeYRnSE2+pTHxocAhMkdfgFe1TDrMBE9eepY0=;
 b=d/Olit064WTOGxHs0Sij2CpJKLon/DzrJWnU0m7NMH1TsSVZfFP4cyFUXR6Cn6b2MTnIyfriKUNuo0LygvBnkd9NwbvlXBGEF0/wB3G5Wf8KOUg3GO2UasTg9WsmtUbVt7R6ose8XpE7S3rCO5/gG6SjAgwnkvKozBpj578Hemw=
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com (2603:1096:101:184::13)
 by SG2PR03MB6612.apcprd03.prod.outlook.com (2603:1096:4:1dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 13:24:55 +0000
Received: from SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8]) by SEZPR03MB7810.apcprd03.prod.outlook.com
 ([fe80::2599:cb55:e0f0:92e8%4]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 13:24:54 +0000
From: =?utf-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>
To: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 "trini@konsulko.com" <trini@konsulko.com>, Ryder Lee
 <Ryder.Lee@mediatek.com>, David Lechner <dlechner@baylibre.com>,
 =?utf-8?B?V2VpamllIEdhbyAo6auY5oOf5p2wKQ==?= <Weijie.Gao@mediatek.com>,
 =?utf-8?B?Q2h1bmZlbmcgWXVuICjkupHmmKXls7Ap?= <Chunfeng.Yun@mediatek.com>,
 "igor.belwon@mentallysanemainliners.org"
 <igor.belwon@mentallysanemainliners.org>
CC: Julien Stephan <jstephan@baylibre.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?=
 <pablo.sun@mediatek.com>, =?utf-8?B?QmVhciBXYW5nICjokKnljp/mg5/lvrcp?=
 <bear.wang@mediatek.com>, =?utf-8?B?Q2hyaXMtcWogQ2hlbiAo6Zmz5aWH6YCyKQ==?=
 <Chris-qj.Chen@mediatek.com>,
 =?utf-8?B?SG93YXJkLXloIExpbiAo5p6X6IKy6LGqKQ==?= <Howard-yh.Lin@mediatek.com>
Subject: Re: [PATCH 1/2] arm: mediatek: add SIP platform bininfo lookups
Thread-Topic: [PATCH 1/2] arm: mediatek: add SIP platform bininfo lookups
Thread-Index: AQHcwIM8RoAaQeGfwUCvqXaumrhIcbXTos+A
Date: Tue, 7 Apr 2026 13:24:54 +0000
Message-ID: <278fcba517597949ad2ad563c1e6cfeddde9dccd.camel@mediatek.com>
References: <20260330-mtk-mt8189-cpu-type-v1-0-4059c3b52761@baylibre.com>
 <20260330-mtk-mt8189-cpu-type-v1-1-4059c3b52761@baylibre.com>
In-Reply-To: <20260330-mtk-mt8189-cpu-type-v1-1-4059c3b52761@baylibre.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7810:EE_|SG2PR03MB6612:EE_
x-ms-office365-filtering-correlation-id: 4e6db64a-74b5-4d1f-327e-08de94a90e98
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: atkyuKf/TksGjEmXiigA0K/x5CxvLIhhcIDZfJZa6e/0z5W/XKvJTqgqs6HL/66zkZC474lr1sul4m3mzdKC1Hw4o9YsTGOO+9sUm5xo8wYvrwX+mZbhJTS4oOEnGMuhI1EjzRLDG06PKuiHwG3rQ+IWDwBD02vWyDk/9/jrAlVHb5OTPX+9ftPUrBBbsh5k2n+geaNi0rXynVCB0Ts+Cw4b0k2CZmSM0alj6K6z2p0wxq54lbLVXIoYctMJJDk4IKC0aN2gZbobuH55YlNv6zUUoI1IVcfPWbFl8rRHFgiergimCXJQYYMleg8WWkYv/UMJo7L+8oDqbAgcgXOIsOFF6SbVJZ+hTIWu4jwZq5jjSwZ83En63BsVk5YQnR+O658nQmlJildIEBOX6fFGQ+lxxyIl8BIvTNZV7GUSJaZUhCHPhjYJNQpE6Q9X/B0TZl07s2s/FlcZrr5qJZXGIKMIyWN09W+TN4DBl2F6cQbxCFeG0Tkozzt0n5+CguB3T4Qy9EB86cWnmI8BELdbU1QOTEfeZoyNeLKkjQ9uZivuTUucZzU3OzOWgLgpMLljqN1FxW1LVJSJVHWF043OB12JTLKpdEqyEJMaBKR2YFKOHGdL5G9RQSXieIlItwUP1JPWRljjk4PR/18SvtK7rqNU6Cf21hJxFC2Kk7gDutFJ0mc7s3oiH4263BDFfG3o+gNBWGJMTO3OLLicHXv+1CJceVofX+NlNz+UtrEN9Her1UHpjL2FQ7R2CPM01y2wq9WWQ6KLHAZG5zjviKSp2tTt2lfMfgQQDVYE8H8hU3o=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SEZPR03MB7810.apcprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UDdRU0YvZkwyWlp1SC9wSEszOFM3Ylg3b0hWRXdRSWphQUtaV3AzbkVvNUZW?=
 =?utf-8?B?QlRLLzcvVEhtYWY0dlZHaTd5enRDVDJpOWdrSlNxcXhSMkRyMXdVOHhQeWd1?=
 =?utf-8?B?ZnJPN08zRTAzTzROWWJ6Vi9zVzFqYkRYNWNJdnpIbjVSbTJINE8yc1RsYmg2?=
 =?utf-8?B?U2JaVGJKakxDblorVG02T1oxUDJ2bi9Jd0s1WGhlaHIzRlppTzFSbVhsci8v?=
 =?utf-8?B?WnQ0cERZZ0dYV0toZlNNeG8rNWkrN2dXVFY1eUQ4VnNKcmhyalhsdVlXbFFM?=
 =?utf-8?B?SXJjc0VEUCtBT3NmU08yRVM3bkw4YUZjVHVRRnRXVTJjbXRTRFlsMUpTQWpL?=
 =?utf-8?B?MVRCTHgxQ1lvR1NtVUVJNFRHME1TeFM2bkpENmdNekhZU09WNXFFTzJVc21m?=
 =?utf-8?B?UWJ0WXBrNTdsVXpMRFA1eXg1dDVTOTcybTUyT0tmYXNIWmN2N1FkRnhlcytp?=
 =?utf-8?B?T3Z2S29NSHVjTHZDOUxZMGRacTY3N0xsa3doelhDOG1DSHlRWTVJZytwdG85?=
 =?utf-8?B?d1hRQVJzWDd2dHdhTWhIK25VMTlVYTdpajBwZmdKZ1ZhYmxGL0kvbzBvS3ZB?=
 =?utf-8?B?Sk5zUXpxT2kybWxrbFY5bHcvUFNtWWdvanZveGVMMW4rS0E1bVQxc1h6djQr?=
 =?utf-8?B?M2czQklHQ09sR0NjNWZCNml2RzB3LzJ6VStCczlJOHhySEtrUHMvOWU3dzBB?=
 =?utf-8?B?QmdpcUlQYXUyZjMzUHd5R1NUc29QN01aSTY2REtWbFV5SkNHLzVZSjBZdDdt?=
 =?utf-8?B?bTM1L1NRdWIyMno5Z2EreE5VUVF1NjN0QXhWc2JBWUhGaEFMdFIxeTM2NDZn?=
 =?utf-8?B?Y3BRQkdEbDVPVUZLZGJSLzVvYXBHemE1NWFVSmNxbGNqRjNscEZ1d2hIK1NE?=
 =?utf-8?B?ekR4dTRzejUxRUJlWGR5L0tJcllOaFVUVlFvSXJtL3AzYWtLbjgvMUliNjRz?=
 =?utf-8?B?dVV0d2tIdmpZY2VkQkQwUytpb0hJQjJ1L1FYUHFDSGtxWTJWTzVIS0MzYnRF?=
 =?utf-8?B?SjdHbytjelMwSFBwNVFWNkt2M21icU04TEVlOGEyd3BaeW9VNEdZTGtjWms3?=
 =?utf-8?B?cktqQm55QSsvYXIyNTdYdXRoWmlFR3RQRVpXNWVJcjZ5dzRLRjA4V3lWMFZa?=
 =?utf-8?B?Zi83MWFGdWd5QmFERU14blI2dkJLdlVYT3poRFlReU9lUHd3WTg3V1VoVGpV?=
 =?utf-8?B?c3lvOWljNkRneUJHNDRRZjJVeXZWZlBhbUZiUXpic0J3Ynp1OGdRSDAxdThu?=
 =?utf-8?B?bldRZmRJcm1RNG1iNTVVUzdSK1JuRXpnNC9CRnJlNmU5b1R1VGxPV2FwTjlX?=
 =?utf-8?B?MWVqT1pMSzRtamZSWE5oRDFDek9lR3UxdWdjN3VQY3YySHQ0RmZTdkh5NFBj?=
 =?utf-8?B?U1lMUzNWOE5xUnV3emIvQmtPb3RjVmp0MElGZDFMNzVBRS9KdzBDZGtxeTFL?=
 =?utf-8?B?bmNxT2JGNUE0djVvazg2T3JSdVN4d3ZmMHBLMVpub05nL2lNYWRtZk8yVStQ?=
 =?utf-8?B?YUF2QU1KdGY3VGpXV2RFaEVkT1ZIaXhMeDRsb3FqUXZXbTg1NW9KK09pamN0?=
 =?utf-8?B?cFc4UzJLa3ZhNDN5ckkrUGdjVGxvbDQwRVViTmtINTFlMitVaC9KQi9VaXl0?=
 =?utf-8?B?QS9jbGdLL3NYdEpmWnB3OUYyRWVmUzVzZ3ZkUG15WEkvSloyWnk5QzFrVWlX?=
 =?utf-8?B?YTZmWDRqYVhUZ0F0TXUvbjYydWpuc3JFcEg3cTJibmZGcG9xU1JYQVdsWkRI?=
 =?utf-8?B?eUVBNjBaREdUSUd2NkNiVnJWYXh5ekNkdlE1R2VCZ2xWYVlHWkppQzBVRVhk?=
 =?utf-8?B?em0yWldmaHRRWGNvY3BMOEsxQnVWUFdjdk9WVzVGTW1EZDZOOXJsTmwrTFM1?=
 =?utf-8?B?clkvM3dRdEZYdDNEdFBPVVFHeHJYcTI1T3h3SUd0dmZCZWZJUE5KejJQcUZ0?=
 =?utf-8?B?R3AramZRWXN2VWZHZngxYmU3MFUzM0s3clNKamN0ZXJ3RlB1b2VRVzRheFhB?=
 =?utf-8?B?Y2ZMdG9xN1haUVBzN2dYRWpZK0FqdDhrbm9DRmxYTWhJWGpFWnVsd0Y0elAz?=
 =?utf-8?B?K3NyVUsyNDdMUysvbGg1R0Jpcit2cm53bEdMZmdrL20xYXlJSXc1ZUswYnA5?=
 =?utf-8?B?K2pPWUhZOHhxTkhrMGNDRXhEdGtKQTBXNFk1TTBseVY3LzRLKzRGalQva05R?=
 =?utf-8?B?SWxaZVR1bXp4MVZhRTBzOGlQYUdaMlJPZUZjT1l5K295cG9zZitFdVpmRWIv?=
 =?utf-8?B?MzYyTHFyR29NRGVGMUYxSXZ1SG1wOURFSUl5SFVtOUVyOWgyTU53UFphOVBJ?=
 =?utf-8?B?ZG5nMDVSZHpwR3VTd3poa0R6cktLbVd4a1E3dDJFanlXUkdiVUhmQ0Nid3BR?=
 =?utf-8?Q?EWNgNGVZOaPGC9R8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7180DA7825778443B66B53728AB80DA6@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: s1sWRmnn4fe2qfU2DJ9Ufq89/evZ3CsgUuNDTeX9O4Fnw0s8h0+McoWb2hXNcEHs4CvxhOBhuIB22ejf2H43xr4Ns24N6szXm0ccVlrjyQhpEdmsOhCdI7LC1lP2MS1tXT9VjZQu6LaDaYDNMSKxrw/dxFA3umgOsxAbpKKtwpkOk2/eALxQL8Q1zHv6pll+79YO3QfynyXArsqYL0e9w2t70/ImckPcfuQDD07XXICfsI80wnQtTFWG/0YJvw7CQgt9KlRV9xsDd/+ng7afizxvWGCDQDYcvdV7KR3bWmI8x56LpXBj0jr3l0YzOHDsECiNQGJaMk96RBebCmGW/w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7810.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e6db64a-74b5-4d1f-327e-08de94a90e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 13:24:54.7244 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +20SHI03gqm08afGB7jIebU2r04I0Fx5yi0/jKt1wq4N3UXanMx85pq3p1/RqH0EAasnSmMiqlY9oDJqTOyo213hoKQsU/DS/uSq5cIwusY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6612
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

T24gTW9uLCAyMDI2LTAzLTMwIGF0IDE1OjIzIC0wNTAwLCBEYXZpZCBMZWNobmVyIHdyb3RlOg0K
PiBBZGQgYSBjb3VwbGUgb2YgZnVuY3Rpb25zIHRvIGxvb2sgdXAgdGhlIHNlZ21lbnQgYW5kIHBh
cnQgbmFtZSB1c2luZw0KPiBTSVANCj4gY2FsbHMuIFRoZXNlIHdpbGwgYmUgdXNlZCB0byBwcmlu
dCBtb3JlIGFjY3VyYXRlIENQVSBpbmZvcm1hdGlvbiBpbg0KPiBwcmludF9jcHVpbmZvKCkuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+
DQo+IC0tLQ0KPiDCoGFyY2gvYXJtL21hY2gtbWVkaWF0ZWsvY3B1LmMgfCA1NQ0KPiArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDCoGFyY2gvYXJtL21hY2gt
bWVkaWF0ZWsvY3B1LmggfCAxNCArKysrKysrKysrKw0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNjkg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsv
Y3B1LmMgYi9hcmNoL2FybS9tYWNoLQ0KPiBtZWRpYXRlay9jcHUuYw0KPiBpbmRleCA4ZThiYzRm
OWNlYS4uNTZhNDFlNDJkZjYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL21hY2gtbWVkaWF0ZWsv
Y3B1LmMNCj4gKysrIGIvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9jcHUuYw0KPiBAQCAtOCw2ICs4
LDExIEBADQo+IMKgI2luY2x1ZGUgPGluaXQuaD4NCj4gwqAjaW5jbHVkZSA8d2R0Lmg+DQo+IMKg
I2luY2x1ZGUgPGRtL3VjbGFzcy1pbnRlcm5hbC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L2FybS1z
bWNjYy5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L3R5cGVzLmg+DQo+ICsNCj4gKyNkZWZpbmUgTVRL
X1NJUF9QTEFUX0JJTkZPIEFSTV9TTUNDQ19DQUxMX1ZBTChBUk1fU01DQ0NfRkFTVF9DQUxMLA0K
PiBBUk1fU01DQ0NfU01DXzY0LCBcDQo+ICsJCQkJCcKgwqDCoMKgwqAgQVJNX1NNQ0NDX09XTkVS
X1NJUCwNCj4gMHg1MjkpDQo+IMKgDQo+IMKgaW50IGFyY2hfY3B1X2luaXQodm9pZCkNCj4gwqB7
DQo+IEBAIC0yMSwzICsyNiw1MyBAQCB2b2lkIGVuYWJsZV9jYWNoZXModm9pZCkNCj4gwqAJLyog
RW5hYmxlIEQtY2FjaGUuIEktY2FjaGUgaXMgYWxyZWFkeSBlbmFibGVkIGluIHN0YXJ0LlMgKi8N
Cj4gwqAJZGNhY2hlX2VuYWJsZSgpOw0KPiDCoH0NCj4gKw0KPiArLyoqDQo+ICsgKiBtZWRpYXRl
a19zaXBfcGFydF9uYW1lIC0gZ2V0IHRoZSBwYXJ0IG5hbWUNCj4gKyAqDQo+ICsgKiBSZXRyaWV2
ZSB0aGUgcGFydCBuYW1lIG9mIHBsYXRmb3JtIGRlc2NyaXB0aW9uLg0KPiArICoNCj4gKyAqIFRo
aXMgb25seSBhcHBsaWNhYmxlIHRvIFNvQ3MgdGhhdCBzdXBwb3J0IFNJUCBwbGF0IGJpbmZvIFNN
Qw0KPiBjYWxsLg0KPiArICoNCj4gKyAqIFJldHVybnM6IHRoZSBwYXJ0IG5hbWUgb3IgMCBpZiBl
cnJvciBvciBubyBwYXJ0IG5hbWUNCj4gKyAqLw0KPiArdTMyIG1lZGlhdGVrX3NpcF9wYXJ0X25h
bWUodm9pZCkNCj4gK3sNCj4gKwlpZiAoQ09ORklHX0lTX0VOQUJMRUQoVEFSR0VUX01UODE4OCkg
fHwNCj4gQ09ORklHX0lTX0VOQUJMRUQoVEFSR0VUX01UODE4OSkgfHwNCj4gKwnCoMKgwqAgQ09O
RklHX0lTX0VOQUJMRUQoVEFSR0VUX01UODE5NSkgfHwNCj4gQ09ORklHX0lTX0VOQUJMRUQoVEFS
R0VUX01UODM2NSkpIHsNCj4gKwkJc3RydWN0IGFybV9zbWNjY19yZXMgcmVzIF9fbWF5YmVfdW51
c2VkOw0KPiArDQo+ICsJCWFybV9zbWNjY19zbWMoTVRLX1NJUF9QTEFUX0JJTkZPLCAwLCAwLCAw
LCAwLCAwLCAwLA0KPiAwLCAmcmVzKTsNCj4gKwkJaWYgKHJlcy5hMCkNCj4gKwkJCXJldHVybiAw
Ow0KPiArDQo+ICsJCXJldHVybiByZXMuYTE7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+
ICt9DQo+ICsNCj4gKy8qKg0KPiArICogbWVkaWF0ZWtfc2lwX3NlZ21lbnRfbmFtZSAtIGdldCB0
aGUgc2VnbWVudCBuYW1lDQo+ICsgKg0KPiArICogUmV0cmlldmUgdGhlIHNlZ21lbnQgbmFtZSBv
ZiBwbGF0Zm9ybSBkZXNjcmlwdGlvbi4NCj4gKyAqDQo+ICsgKiBUaGlzIG9ubHkgYXBwbGljYWJs
ZSB0byBTb0NzIHRoYXQgc3VwcG9ydCBTSVAgcGxhdCBiaW5mbyBTTUMNCj4gY2FsbC4NCj4gKyAq
DQo+ICsgKiBSZXR1cm5zOiB0aGUgc2VnbWVudCBuYW1lIG9yIDAgaWYgZXJyb3Igb3Igbm8gc2Vn
bWVudCBuYW1lDQo+ICsgKi8NCj4gK3UzMiBtZWRpYXRla19zaXBfc2VnbWVudF9uYW1lKHZvaWQp
DQo+ICt7DQo+ICsJaWYgKENPTkZJR19JU19FTkFCTEVEKFRBUkdFVF9NVDgxODgpIHx8DQo+IENP
TkZJR19JU19FTkFCTEVEKFRBUkdFVF9NVDgxODkpIHx8DQo+ICsJwqDCoMKgIENPTkZJR19JU19F
TkFCTEVEKFRBUkdFVF9NVDgxOTUpIHx8DQo+IENPTkZJR19JU19FTkFCTEVEKFRBUkdFVF9NVDgz
NjUpKSB7DQo+ICsJCXN0cnVjdCBhcm1fc21jY2NfcmVzIHJlcyBfX21heWJlX3VudXNlZDsNCj4g
Kw0KPiArCQlhcm1fc21jY2Nfc21jKE1US19TSVBfUExBVF9CSU5GTywgMSwgMCwgMCwgMCwgMCwg
MCwNCj4gMCwgJnJlcyk7DQo+ICsJCWlmIChyZXMuYTApDQo+ICsJCQlyZXR1cm4gMDsNCj4gKw0K
PiArCQlyZXR1cm4gcmVzLmExOw0KPiArCX0NCj4gKw0KPiArCXJldHVybiAwOw0KPiArfQ0KPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tZWRpYXRlay9jcHUuaCBiL2FyY2gvYXJtL21hY2gt
DQo+IG1lZGlhdGVrL2NwdS5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAw
MDAwMDAwLi43NjgyODRlNDg3Zg0KPiAtLS0gL2Rldi9udWxsDQo+ICsrKyBiL2FyY2gvYXJtL21h
Y2gtbWVkaWF0ZWsvY3B1LmgNCj4gQEAgLTAsMCArMSwxNCBAQA0KPiArLyogU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb25seSAqLw0KPiArLyoNCj4gKyAqIENvcHlyaWdodCAoQykg
MjAyNiBNZWRpYVRlayBJbmMuDQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBfTUFDSF9NRURJQVRF
S19DUFVfSF8NCj4gKyNkZWZpbmUgX01BQ0hfTUVESUFURUtfQ1BVX0hfDQo+ICsNCj4gKyNpbmNs
dWRlIDxsaW51eC90eXBlcy5oPg0KPiArDQo+ICt1MzIgbWVkaWF0ZWtfc2lwX3NlZ21lbnRfbmFt
ZSh2b2lkKTsNCj4gK3UzMiBtZWRpYXRla19zaXBfcGFydF9uYW1lKHZvaWQpOw0KPiArDQo+ICsj
ZW5kaWYgLyogX01BQ0hfTUVESUFURUtfQ1BVX0hfICovDQo+IA0KDQpSZXZpZXdlZC1ieTogTWFj
cGF1bCBMaW4gPG1hY3BhdWwubGluQG1lZGlhdGVrLmNvbT4NCg0KVGhhbmtzIQ0KTWFjcGF1bCBM
aW4NCg==
