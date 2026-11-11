Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B402606A320
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 02:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=j73OT+15;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=oh5jbLa4
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F01DF81376;
	Wed, 11 Nov 2026 02:34:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U6tk2ZWBkSyV; Wed, 11 Nov 2026 02:34:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 11B5881368
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794364456;
	b=k1gSxLak+rICH47Bni4nhyiT/150G2UW26vOX960EUHttTwE1pop9qjnFJ+gcml/8X9V
	 ZRGnZKkSvjVqncpsIBiOn90+QIZifjN+nARWF2iZ3sVXTPUgTvdBm5pZoS0+k8yLBhm8J
	 JnKZp3UjvOOd3Y+o8eTc3wssThsMYj6PPgYi4fFVtfv1tczXqlm8ndICr4iVkPaHPSdOx
	 wq5qbntDb8f8h9/35Yh3nnOV1qbdg8dScRAacxHLyL39t7IYYBwhlGz6AmnadgRdHz8Ds
	 ekB1qOpG0XYIEeQ82Jl5sGB2DCXPBAgwvigyPs1iVuRTs68lI+/JnwaBJUWBTqAspnA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794364456;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=9BLTAKdhbEIDq+2H3N4LfQJxpU2Q/u2nhMnHdC8gQpQ=;
	b=jhGKAvnHhLrfWvcSUFz1R184VExHBJOHQd9bVFTR0tAbTbWPofnVrLznG8xUYUAqAU1d
	 uRPdyoR0iyH5sO9/vmD5ae6tKDbeRmb5IyO9BxL0/8TDoNO7hS/YZZ8AC/mTxJhSbhW+h
	 Yxqe2mw83bdwRqzOY7hhgsa1RS7nqXqhS2qWc6oAI5ZqhBDk8xhWSw83Eu7Ok0Zfklitq
	 c3AN/G+zrXca54yAV877HfOs9W3CkJF9/k/mnR8ZCGX2i1bQY27rb8jRqpeH9dAU0rNHh
	 hqF5Cy51B4nhjeRI96ZtqkORyM/r9HvkYSiyiiBsCFbNSR/mXkXgewTjCYWWkH/avBA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=aspeedtech.com;
	dkim=pass header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=oh5jbLa4;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794364456;
	bh=9BLTAKdhbEIDq+2H3N4LfQJxpU2Q/u2nhMnHdC8gQpQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j73OT+157VqOndBQtgIW98vh9ljdOqoiUv0Gad+yqVYO1yDPUBz6g+nIOfMIFPFWX
	 2Q4m2Qw1K1h7ndgLc/frejTVbWBFbolAjarFM9RYQDrBTcfoGAXqzL278Avd5QsY34
	 zHmqsJ5w5dKXunKWni4WSdYo0BYic1707/J+jNkHJE/0QchbeIl98JIabN5JzZhzgx
	 nS4ciF9R6t2yMQ30k57C5q+yMCMOG3RasEhnuyymOtuju+/fmj/U4Nj5ldiZ7C0tLr
	 hM/+t4DbjBndYoF9mt37DdF1mxc6a+I1q9hu9RYbIqvzyBFSOtGrFdz7j1U2d6tx1m
	 ZT6/vppNBWLGA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 11B5881368;
	Wed, 11 Nov 2026 02:34:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7B1D29D1
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:30:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 63A5B81291
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:30:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mtGBFi7_qQPM for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 00:30:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 250B081206
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=ryan_chen@aspeedtech.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com
 header.a=rsa-sha256 header.s=selector1 header.b=oh5jbLa4
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 250B081206
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 00:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9BLTAKdhbEIDq+2H3N4LfQJxpU2Q/u2nhMnHdC8gQpQ=;
 b=oh5jbLa4AmJ04b0uxIy5TKhUVK8bD7ovCQjMAk/DpXFdn72vuyfUYFnl3BKCCze3BoLBcDuhGPGm1lbPJbMlX2FKURMPO5WYG0ttK1fHHU9wjf9WaVblkuRdMsheyHTLg96YwhndNcJMB/fqc7N7W0W3RNxcf7AnueBJ6Ft6LzzVRrkH/grk1CBMFyNxMwzLQmXfdVEtf5g078BukL9HiLbhzYr+/ZmRIgCtuqXMg++FmyNWm9+GvPz5udR/JMj9/aQ8ggEuuSen2Jxz40bOPLKl98egCxWbEkuU/gzxgkPdO+WY+iZ4T7CMH0/02eOEaknR93r2qxU3ULyFJf0I1g==
Received: from TYZPR06MB7920.apcprd06.prod.outlook.com (2603:1096:405:24::8)
 by SEZPR06MB5199.apcprd06.prod.outlook.com (2603:1096:101:73::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 00:30:49 +0000
Received: from TYZPR06MB7920.apcprd06.prod.outlook.com
 ([fe80::f787:b04e:6ef9:c0d9]) by TYZPR06MB7920.apcprd06.prod.outlook.com
 ([fe80::f787:b04e:6ef9:c0d9%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 00:30:48 +0000
From: Ryan Chen <ryan_chen@aspeedtech.com>
To: Tan Siewert <tan.siewert@9elements.com>, BMC-SW <BMC-SW@aspeedtech.com>,
 Joel Stanley <joel@jms.id.au>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@nabladev.com>, ChiaWei Wang
 <chiawei_wang@aspeedtech.com>, Tom Rini <trini@konsulko.com>, Pedro Maione
 <pedro.maione@9elements.com>
Subject: RE: [PATCH] clk: ast2700: Bind the SCU child nodes
Thread-Topic: [PATCH] clk: ast2700: Bind the SCU child nodes
Thread-Index: AQHdcWvGAmQrPZiroEi6s7f9OWhP2bcoBHug
Date: Wed, 11 Nov 2026 00:30:48 +0000
Message-ID: <TYZPR06MB79201CC989A90266B02A8B79F2712@TYZPR06MB7920.apcprd06.prod.outlook.com>
References: <20261111-ast2700-clk-scu-v1-1-4e6c71b1cb0e@9elements.com>
In-Reply-To: <20261111-ast2700-clk-scu-v1-1-4e6c71b1cb0e@9elements.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR06MB7920:EE_|SEZPR06MB5199:EE_
x-ms-office365-filtering-correlation-id: 252b3e5f-1d47-4f84-1687-08df3f8b0852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|38070700021|261028144727099003|56012099006|261009223027099003|261022105027099003|261021121427099003|261009221227099003|261026121527099003|261026140227099003|261102123227099003|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info: iha3AxQEMi6jfH5XXL+K6G8tT34UGxXmMRVKObENDP+34LzKghPOmeNjdxcZuEN2QEh04QmbNR8uwg646vk7Xw2P4PiPmFhtLRu/ym6UGasQBWkXGsJRKW49dTzKTAaZsff/HrUdM5FODNTt2Jf1GdzVYQchvCJ7/N1lf6vgg7SbDDP7jf9lZv63fYG2T11sw62H/ED5aY8/a5ec8hHKFrrpSJn9n7BxpXmorIVK/JV9OeAB12PaCXZ9jAyIA1LJVk9Bxd30LYIxEY+Cj8g6WtbsZOBAJFZoVUqDhJZbVKl9j3xiRwvmbFnPECi6TVzsrbGTayu15o298juLQQHKgMInz8pxpxZfhtS1h3onleNVru/AHG4fJb3jMn0GP7pDgu5AtKOyR4ae18rCp482NsRuwTyPAT4dXLuuTm3KlWoGOnBY1k/TLfgKjH+ZOOX3xcb6DoxrdsN6VmY/1KglJ9fzFnwR1du84YwN+7nATHgKLmWDOTKObUjx6qm67PdQXjvKhlsD2hmNxPr5yxW0TlzLwxdJ8XWHMshLYdgfsYjDq2f2r/YPbfPvEWnJJaH3rKtTjjmuxfsxHW0Pyc2S1vig8HUG9AlaHsE8qHaQReBYFyy/e9mUXY7cC+W0tAhcFwCqCpRFRtQbjBBdYVmpSjwhiziofxtnUPD4WUeEn+c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:TYZPR06MB7920.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(38070700021)(261028144727099003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261009221227099003)(261026121527099003)(261026140227099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUlZdG50ejJhbVVmMkdRK1VOTmV2V3hVUDFFV0lUTmd4NVowUGN6Q2Y0NDZz?=
 =?utf-8?B?eTlyTGdsL2ppQTRzY1cvZ1VLZE1HelVROWtQMFlrdnVhQWFxVjhFU092dFRJ?=
 =?utf-8?B?cWcvRFhsV0F2YVBRNWVnbU5mWFhJOHpUNm5vZk5PUW1senZXUDg1MGtBU0xE?=
 =?utf-8?B?VnpzOExxaWdjWE82SG5OS0ZSYzluQ0paNktKZFhPNUpyejJMUFFKYzhvckxl?=
 =?utf-8?B?RHA4WFY2aXVmaXVjVml3Wm5vUHZIWVYvcXlqOWZheUJtRWlEbGdBdUNuRFhj?=
 =?utf-8?B?c0dPblBLVDdDUkl3QXpRSWFkVllqTjBrOVN6ZVRuenpyRGt5OE1SeWlOQ2or?=
 =?utf-8?B?WmhPUWRZL0VyV1hIeDNKZStMbDl6TTk2cWFkM2Z5cGVhcWgwcGRqbG9JL2Jm?=
 =?utf-8?B?bTA1N0pQMG91MkhnaUIvTHNRTzdTTEVmSnZzczlvbjNaa3BNU0tJc1BDTmtk?=
 =?utf-8?B?ZSs3Qjd4WmkzOGlGK3ZuM05aUGJwVFl6NjN6NGYxUE0zdkJxdXU2NDlsZysz?=
 =?utf-8?B?STJ2TURCNndweUxyYXpqbm9iMTYvZ1lxYU1ic0tvemFtZEdkazFicDNtMzZJ?=
 =?utf-8?B?Vnk3U3lqQjlaRXREVncwaEF1ajlSNzdBZktydHRJc3ZxU2Jhc1VpZmVSejFz?=
 =?utf-8?B?Z1RVY1o1ay9HKzNLdGxQQzhacVI4V2NoMVVzck5GdVFzSnJWT1g2aHJmQ1Fl?=
 =?utf-8?B?Qkg2cWZCY21pOGttUm5zYzVxdktHRUlxNmZLMWlnOTlCeUlZZzVuZzVHRkVp?=
 =?utf-8?B?cWxwdkdNTkkzZHpFZW5SQlVsOWhTZ1V5d0wwd1hTR2kwalhycWsvbjZTQzA3?=
 =?utf-8?B?cEw1dkd2dThMcFVQdzFNd1F3WlhuYVhtckdpRWpDclBSWnVWc0lnU0tnYUV5?=
 =?utf-8?B?Q09QN3lqVnFVQzAwLzNWbWw5d1pXa0w2Tko0bmhZakEwUXZ3S0k4dCtZKy9Y?=
 =?utf-8?B?RldHV0l2TDlOWEhpT2Q3WVdKbGhOalgrd0JFVjlkdkJFK3hIVmxQUjhiTllC?=
 =?utf-8?B?eWROT05WWWFZcXNNVWVRSjlsUVlUQXpiRVVlNjVRTUowZ1lYUlJYVjJkRFZT?=
 =?utf-8?B?K21GVUROTnVQL054c3gzVExyL1g1bEpmNmYvSkNlaE5VRVJPTm15QVkyRTQ1?=
 =?utf-8?B?TEJRamx5aTYwTmVLWktQcEJhdWVQZjZZdEltMkFOcHRMR1hlNVdONHNoT3RY?=
 =?utf-8?B?Ny9LZ0VmeTRleDQ2T2FKaUVsUDQrYmRiZkx3ZktCVUNjUWdvU2NrQngrSElj?=
 =?utf-8?B?YWN4ZjB4TWY4VGljSTJOWkplSjZFUnhwZ0NCYThKTjJyd0drMDkvMnRNSnBv?=
 =?utf-8?B?bGdETW1SVVA2ZkRwYlFyVjRhUmxZdTJzSUpOSGNML3MxYXhkMGNwbVRkQ0xp?=
 =?utf-8?B?a0lERFhrZ1o1WFN2bHE1OHF6bDFEd1R4YXd6MDhPcFpsbUt0dnNPY3JJejlG?=
 =?utf-8?B?eEVwNTZxMmVSMGFkYVBKN05kSitRWnlkWGFkb3Q3cDdHZWxPOGpoR2pubThV?=
 =?utf-8?B?OHpNa3ljM1B5T3RCM2dmVW1zYWluL0d1eFBqZVo5c2FkbGF4NjlBaFh5U1dv?=
 =?utf-8?B?U2dkZkRmcm5QOURiMTlZejBjMTZ5aXJBU05uOGU2eEJCM3RkUytPSElvRzlj?=
 =?utf-8?B?MlRjZVpUaEdkRFBud0x2Y2xjTlNUdkpweDcvNWlKV3VVbW5FeDYxQXFDZXpw?=
 =?utf-8?B?NlpFdXVLR0NJQUs3d3RCWWRmcTZKQ1JLdjVOMGhCZG1zRzRDQ2dNaFR3NkJV?=
 =?utf-8?B?aExZZFlrbU0yNm9tRkdBYjVOYm50OU5RU1JoekY4U01ZV1FTN2RobzAxM3Rs?=
 =?utf-8?B?b1NPSlRkVllZNmxBQThzb0drcmhkR0xyUnBNOWxNRmRGYjZmZldOalpCK1R5?=
 =?utf-8?B?S2VkOEF2UUlZQ0Fjc3kvTHRCbk1mQlhORExQVG1Gb25nczI1OU5NMEpxc1N6?=
 =?utf-8?B?Zk56OVFBRXY2dDlRbzVoZ3pYK1E1NzY3YkU0QUZiUThlVmJ3c3dVMUVJbDRH?=
 =?utf-8?B?UVlxVTZiMSt3eVBvRmNXdnJsUjlsbzNXSzVnK1EzMnhuSHlXSWh0eGN3aHpC?=
 =?utf-8?B?eEgrTzVrbHpEOEIxQktqWmJXdmVYQjBMWFVudUs2eW5qeG1EMmpLdWY1c2Vm?=
 =?utf-8?B?MStPSS9BTlBZK2gxbC96ck5pSVBnTmZsdnJrMjhnd0dQYnVGcnRGKzFVSFJ3?=
 =?utf-8?B?Vkxlei9HeTA1dGFQNVFuQlR0cjEwdXZxTlBPdWozOEl6dGE2YWFIcE5MS1l4?=
 =?utf-8?B?bVlFOTl5L0FBcTVRUldYakdrOUJiSENlNFZYUm0zTmdyWUcyNlBBcm1Ldm8v?=
 =?utf-8?B?bjlEQnRBRW9iSDRIdklzYVJ2bVoxRUE4ZkwrdGM5K2FrNml0NWVlQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB7920.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252b3e5f-1d47-4f84-1687-08df3f8b0852
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2026 00:30:48.1880 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j75iss434p438fZWQuSY+nXjLKEn4y7+DSFTqN/IcOw/n7++2La0sXfNxGSbEz4xSozL3F/Kd+n3O7LR6c2yqCk2mMDo5jO/WIFSUzCyxAA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5199
X-Mailman-Approved-At: Wed, 11 Nov 2026 02:34:14 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

PiBTdWJqZWN0OiBbUEFUQ0hdIGNsazogYXN0MjcwMDogQmluZCB0aGUgU0NVIGNoaWxkIG5vZGVz
DQo+IA0KPiBGcm9tOiBQZWRybyBNYWlvbmUgPHBlZHJvLm1haW9uZUA5ZWxlbWVudHMuY29tPg0K
PiANCj4gVGhlIFNDVSBub2RlcyBhcmUgYm91bmQgYnkgdGhlIGNsb2NrIGRyaXZlciwgd2hpY2gg
bWF0Y2hlcyB0aGVpciBmaXJzdA0KPiBjb21wYXRpYmxlLiBUaGVpciBwaW5jdHJsQDQwMCBjaGls
ZHJlbiBhcmUgbmV2ZXIgc2Nhbm5lZCwgc28gdGhlIFNvQzAgYW5kDQo+IFNvQzEgcGluY3RybCBk
cml2ZXJzIG5ldmVyIGJpbmQsIGFuZCBhIHBpbmN0cmwtMCByZWZlcmVuY2UgdG8gYSBzdGF0ZSB1
bmRlciB0aGVtDQo+IGZhaWxzIHNpbGVudGx5IGF0IHByb2JlLg0KPiANCj4gU2NhbiB0aGUgY2hp
bGRyZW4gZnJvbSB0aGUgY2xvY2sgZHJpdmVyIGJpbmQsIGFzIHRoZSBnZW5lcmljIHN5c2NvbiBk
cml2ZXINCj4gd291bGQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZWRybyBNYWlvbmUgPHBlZHJv
Lm1haW9uZUA5ZWxlbWVudHMuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBUYW4gU2lld2VydCA8dGFu
LnNpZXdlcnRAOWVsZW1lbnRzLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL2Nsay9hc3BlZWQvY2xr
X2FzdDI3MDAuYyB8IDUgKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9hc3BlZWQvY2xrX2FzdDI3MDAuYw0KPiBi
L2RyaXZlcnMvY2xrL2FzcGVlZC9jbGtfYXN0MjcwMC5jDQo+IGluZGV4IGNhNzZhYmVmNDhmLi4z
MDQ4N2M1OTJmYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9jbGsvYXNwZWVkL2Nsa19hc3QyNzAw
LmMNCj4gKysrIGIvZHJpdmVycy9jbGsvYXNwZWVkL2Nsa19hc3QyNzAwLmMNCj4gQEAgLTkxOCw2
ICs5MTgsMTEgQEAgc3RhdGljIGludCBhc3QyNzAwX2Nsa19iaW5kKHN0cnVjdCB1ZGV2aWNlICpk
ZXYpDQo+ICAJCQlkZWJ1ZygiV2FybmluZzogZmFpbGVkIHRvIGJpbmQgcmVzZXQgY29udHJvbGxl
cjogcmV0ID0gJWRcbiIsDQo+IHJldCk7DQo+ICAJfQ0KPiANCj4gKwkvKiBUaGUgU0NVIG5vZGUg
aXMgYm91bmQgYXMgYSBjbG9jayBkZXZpY2UsIHNvIGJpbmQgaXRzIHBpbmN0cmwgY2hpbGQgKi8N
Cj4gKwlyZXQgPSBkbV9zY2FuX2ZkdF9kZXYoZGV2KTsNCj4gKwlpZiAocmV0KQ0KPiArCQlkZWJ1
ZygiV2FybmluZzogZmFpbGVkIHRvIGJpbmQgU0NVIGNoaWxkcmVuOiByZXQgPSAlZFxuIiwgcmV0
KTsNCj4gKw0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiANCj4gDQo+IC0tLQ0KPiBiYXNlLWNvbW1p
dDogOGMxZWEyYWE2NjM4NmZhM2M4ZWE4Mjk1MzFmNTgxODQ3ODE0YTU2OQ0KPiBjaGFuZ2UtaWQ6
IDIwMjYxMTEwLWFzdDI3MDAtY2xrLXNjdS1mNjAwNmNjZDc5NzUNCj4gDQo+IEJlc3QgcmVnYXJk
cywNCj4gLS0NCj4gVGFuIFNpZXdlcnQgPHRhbi5zaWV3ZXJ0QDllbGVtZW50cy5jb20+DQpIZWxs
byBUYW4sDQoNCkkgZG8gc3VibWl0IHRoZSBwYXRjaCBpbiB1LWJvb3QgdGhyZWFkLiBQbGVhc2Ug
Y2hlY2sgb24gdGhpcy4NCmh0dHBzOi8vbGlzdHMudS1ib290LXByb2plY3Qub3JnL3BpcGVybWFp
bC91LWJvb3QvMjAyNi1Ob3ZlbWJlci82Mzg0OTEuaHRtbA0KVGhhbmtzLg0KDQpSeWFuDQo=
