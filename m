Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900A606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Tj0X1Yf9;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=ECXJphaZ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6DF9B40805;
	Tue, 24 Nov 2026 13:23:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id r_tIyhJP2M8A; Tue, 24 Nov 2026 13:23:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B973740806
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526584;
	b=kt/EXLiCnFU5lnA3mq5s58k/JuOx8PmUolO2dGV/QaAuj4cvz5IC5ULOpnep02KfbfQg
	 2rOhfB2wZr9d60rqxPZt9TKdYDJ+NCWg3jJa3mvt87h0vY59e8AtzcVaABbHDrRbCc18U
	 F3hlORjcA6zMVnmh7T08+hoGP+VAuO/KrrF7NIyoZjXe9O3iGmnO72tXWMxwPUt1AUtDp
	 SH9D6ezYdNsgIaSkcN8+2SJ+R/3yGuK1WH+7fqdvd5Dd7616VCvBotPGZpYEuGeSjzkWp
	 GKHxgv8FEpO1zcQ1kTP5xkUQBndGSh/im9mBCphamnkMu1W29uEvX5+eJbITXwbOjpA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526584;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 x-ms-traffictypediagnostic:x-ms-publictraffictype:client-request-id:
	 request-id:x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-Exchange-RoutingPolicyChecked:X-OriginatorOrg:
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
	bh=69RZA3mQotiaNVQvpv7bH6CCJr8zoZ+QW9E3asb08o4=;
	b=GBmhSH+K7PKWTTqXWnWlAi9lTwoTq1kpawc/hTj9c+jmy7hH9P8SmSqymeYcyo/xfd6f
	 PUYRiFuE1Qt1IImhcHmLqqxfEYJsGCvaD2DW4p9iromAQA3vBKdzc+DORenowvGdN0I2/
	 ETXfCnj0knS4urHKc9w5NyVLz0kIhBuBJm2gCpkP/H0vwER6mvDAaGMwEGBzTA+02ergL
	 DLc8QpyxaY7p/Z0gfXKJVyH2yIPAogX3W+BQ1O0bINrDRAFpGwLqITqNigkiW72BUtSQw
	 NJQDAnBiqloRkQW7HFur2SznziyXdeHIgg3EpWZM4oCAn9XLcepIHTNscKFwkyTM/ug==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526584;
	bh=69RZA3mQotiaNVQvpv7bH6CCJr8zoZ+QW9E3asb08o4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tj0X1Yf9g/iH/rgzUgP0Th6pgfPOYduBIxXZ+Muw8cMenw/XR12Z/LkI/FEv+rVMw
	 5sYeTYyCwyyV2ENPstbSLDkbmYLlv65pmj28Z0d//0zZKz18dYSnS+izoD73xp3Yyy
	 ONSVx9MRh4olGqKSxqErmgXLOEgN1E8QnR+QTl0HYZymm/My7/qi3U17xz2bdhYuI2
	 qICY+z0WrZTaVNHY9DG0ym53GFO43i5tyuXE0tevNRoED4ok9sUVbo7CetPcSKL23K
	 npLMa6Sl5YEezvTPJ7wrPzShymAQdNBTNbPVvOisWmYy6xc2YYG9OM5OuW7ukuq6HP
	 zedmHj5BdQMlA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B973740806;
	Tue, 24 Nov 2026 13:23:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 800121AB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:46:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65DF480F76
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:46:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BFo7aHzJ1m0g for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:46:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5887580F6C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c40f::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c40f::6;
 helo=seypr02cu001.outbound.protection.outlook.com;
 envelope-from=jacky_chou@aspeedtech.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com
 header.a=rsa-sha256 header.s=selector1 header.b=ECXJphaZ
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5887580F6C
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=69RZA3mQotiaNVQvpv7bH6CCJr8zoZ+QW9E3asb08o4=;
 b=ECXJphaZFSsReTys6YTtMFRt0j3ZxFtl2QxHu5s2wCo5Db65+yvWe3n5p+W4MEyXS43brk14DXP7GiNsIVpgpiiAP15zxfW6V30xRdErIx4klxJ1AhRVMVTfKVSukk/tNUjHxceyIrvOYs2G8q8FjuGU1fAtTEDZroW4BpHvGrNhJeAxq+2WfQNm3zDPKQk4hLSoBm7tAzRN4paqmPYyCjKpV+Y3CGBGo400dG0MPBy/KIrSruUmp8fmgvRvdHEnPUB8Jy5U8iLy1si783Swg8IcZEFE/lNYNyPGZ0wrgUxiKz9M6CnakcA96CzWFF0lT/FGpTT9gTOtiZwJ//4bpQ==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SE2PPF6240AD2A0.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 08:46:21 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0662.000; Tue, 24 Nov 2026
 08:46:21 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: James Hilliard <james.hilliard1@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, BMC-SW
 <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
CC: Ryan Chen <ryan_chen@aspeedtech.com>, ChiaWei Wang
 <chiawei_wang@aspeedtech.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Tom Rini <trini@konsulko.com>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0hdIG5ldDogZnRnbWFjMTAwOiByZWNlaXZlIEV0aGVy?=
 =?utf-8?Q?net_multicast_frames?=
Thread-Topic: [PATCH] net: ftgmac100: receive Ethernet multicast frames
Thread-Index: AQHde4Ze3nhLwJC9nkiM2K3T/fzUJrc86SqA
Date: Tue, 24 Nov 2026 08:46:20 +0000
Message-ID: <SEYPR06MB5134C4D77669A7AA0E5637519D442@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261123-submit-ftgmac100-multicast-v1-v1-1-bea28ecbd8b6@gmail.com>
In-Reply-To: <20261123-submit-ftgmac100-multicast-v1-v1-1-bea28ecbd8b6@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SE2PPF6240AD2A0:EE_
x-ms-publictraffictype: Email
client-request-id: f7067a30-6dbe-483b-9e58-420fdea1417f
request-id: a31fe193-acf6-4431-f3fb-08df4a0769d3
x-ms-office365-filtering-correlation-id: a31fe193-acf6-4431-f3fb-08df4a0769d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|261009223027099003|22082099003|56012099006|261026140227099003|261022105027099003|261022075727099003|261028144727099003|38070700021|10067099003;
x-microsoft-antispam-message-info: XT8hLIALth8+Ot1EljzBpyPcEjl1fnbKRbdV1q/Myxvu4cU9mf54Uxi9Nr2bog8JnKEY8w4ny8IzfJb5gjzMEAZATv/57NxY/Z0ti/PXZhO87Z3JP3L9s5sPMZpsRlgNYeehD6jLAMkeLyDNQ79jNhZfC6ghM7CHnka9dZ4Bxb3EZhX33hfLPLAxbcWDlRGUz9kxlnNWNfAPphY751ZtrpuVBUxp+EO1e6l9dcfx/R6AN5Ed2w6NmERimOM46emiviCCrtyDK+P7FEktYMpSVA2U6qVLxhTHHz9VFMbxOKPUEl7wjOCtEBc7rpuKjnWkSwulIEzKbB1+FLFI2B/5flqHeu0JpMiyjNHi+EFVaAVLwbWsN6oxhienO3ydhEvfDpPStAFfPUG2ykmWPFq7W0zVSlCghyt/bWKehh5Bo615Z2X1/FmPmSUqzDLqrYpDV39WALYUgvnbiPlQryhw4Xzock7EtVoM9SmRaSZbvt6jiI8VNeGSSTD3xe9be+AAL1lHLEfhUqZtahZS1b6UuchsuZs7nQ7kn7h4YgRtHDaeS/FJ6sZW6c95ailCu0K+XnNoTvwaT/VJaa6nBDHZDOwCwx7VNYcBx8yr38KbyJr8n8EYBfOTbRbuNQLa/YRddUTnC8uj/DDAhDfSySAZhQk14dJbCY6liuGjw+qLyTQPsz94hZ8iBa4op3lVLWsghagpWwNF9Ro74NbAFIaaX3/OAhnSnXUW/tFlYiqN+Yg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(261009223027099003)(22082099003)(56012099006)(261026140227099003)(261022105027099003)(261022075727099003)(261028144727099003)(38070700021)(10067099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTRaZkk5dUZTemdtQWFWYkM2WERqb25qZHVMOGFCMzB3TlkwZ3RLSUpmSU1s?=
 =?utf-8?B?L1NnT1VtUkhOUlFiOWZ1dld0czl4ajVVQldkVjJIUnhVU0xkcnBETWJFUU5u?=
 =?utf-8?B?bVh0TzA4Z1FWNk1XTHFVKytRd1l1bE4rak5VNEhlODlWZGFNVlNjTERDaXJ3?=
 =?utf-8?B?emgxR3hzR3hseUpRYkZrUkgvOEpBYmJxUWJwNS9JUlJZbTR1ditSN251MEE3?=
 =?utf-8?B?bTdsTFdQR0tJRm5mR3ZmdVRnejNPVDF2YjY0ZkpDYkZ0SVJkT204czJkbUZr?=
 =?utf-8?B?MVVYc0RnRlBobTg5cDI2dTErdVdoUlVnUG02YmwyWE5SbFdCVHNjeXVxU0wz?=
 =?utf-8?B?SjdNcVBvL2I3RCtEVUhOZjNyUWpzSkJrOU1HYjU2b2YwOEl5dE5yNVMyYkE1?=
 =?utf-8?B?UUs5NGdDSFc2elRSTStvN2M2c0UyYVdqRTMzUUZTeXdkZUFIcDRvWkNzK3FG?=
 =?utf-8?B?a0VjcDIxaWduZWJjdjQvdVJ4TUJROXNHUVBra0hicStUd0cxaEh3bDI1YmZn?=
 =?utf-8?B?YUdTSTlPbHlRV0gwd0czeDl4MjlHV0RIUTY4MTNWUmZVVkRYY3BwR2V2Ti9i?=
 =?utf-8?B?c3FFVU0yN2xhUkJPOWVDQ2VIVjVMSVBvT2NoeUNiMUZHbE9FTTU2WFI4Wkl0?=
 =?utf-8?B?ODdhbUNjTG02OVcwVmVrV3RvSENINnROVWk5c2tuU2toMWdiMVRDUmh0enBI?=
 =?utf-8?B?ZzhyK1Y5RzNDbjhWMnVyWnRuaVJkdmNFaWFId2hhM0VYYm1zWlgwNjhjVTBi?=
 =?utf-8?B?aE0ybTU0MktVYUdoZ0VaMElpSW5lT1d1NWljc1c5Uy9aeEk5RWhPKy8zUDJH?=
 =?utf-8?B?c1g5cCtjeHpWK05DKzM3WFVUeGNtbFJXdU51UDIwWGkwRlpsOU9mdUZ3cDJM?=
 =?utf-8?B?eUFnR1JHaDVOQzNVSDVPbFBBRmNVbm4yWlpSUUpSYWplTmpGc2tHaUZmQlhv?=
 =?utf-8?B?aXd6ZVV3VEExTnA3M1lob1h6RUFjZEZpOFV1RUNBaC9lVzNPcHoyd1libmdO?=
 =?utf-8?B?MHQwK3RBVEp6ODQ5NGw4NXJZbGFZU1RzMmpmcDJTRkw2aXJ5bmMzSjl5YkM3?=
 =?utf-8?B?VCt6NjdlNnZaTFhNRzlsRG8rQkkyQzNPQ3lNdmVtNWVqb1ZSTGVDRUVYZjZF?=
 =?utf-8?B?L1dBMUYxdjdlVTVaT1ZTVVFIaysrb3Q1RFhBM3BLd25TLzNqRTJqdjBFUGNv?=
 =?utf-8?B?QlZQYmlYOGN2Wnc5K1FTbjRVaXZTNE9nVVZUdUFEWjdUMWNvaXQzV2ZLRFpn?=
 =?utf-8?B?UHUvWjdldlZJYncvVjdOaE96OWp5cEhCandWZDc0WEliNlJocGtrVHRZQk8w?=
 =?utf-8?B?QmVvNTU0MHk1SklxSnhZOUdwQWFkMUk5cHE4TndYN1VpdExqVVpXUG5aZjVE?=
 =?utf-8?B?NXNjNngzQmVrYXlsMVFGbjlidjlKZGZuOWdWR1QvZ2l3SjNEYWpoL2NoMlFS?=
 =?utf-8?B?SHJ5Ti8vZXBxYnZNQVBiRmlYTm4zWGdJa2pvUFlGc0FONS9HYnpuZ05MaGwv?=
 =?utf-8?B?SnNyejBPUU9yVzF6THRiekRsRkZBMUdqR2RGM3hwckhpRU85YUwvOUc2OGxO?=
 =?utf-8?B?TEFWcENpcVRoMmtFanRWZW5vbzRJMnZlNEVvVUJRTnBiRFQwd0x6UTJiM0Vl?=
 =?utf-8?B?OWFPY28vMVFrMUp2U3Y1OGQ0WVp4c1gzakl3VVdDRE1BUW5KeFlWVWQ4cDU2?=
 =?utf-8?B?VHJGMkRZeUJQdmZtUUVFR2NyR08rYTNEbS9uc2p0M055TEd2VWdtbDJKWnhN?=
 =?utf-8?B?WkYrYjEzb0lDV0NYaXhCQ1d5MkM3SkdiSTFENUxHZU5KMFFUbjZaY0hEYVJ2?=
 =?utf-8?B?NkZwZXpDSlJXQkxNZVQvTkJTb0JJaXB6YWJzVDhxMFZhQ2dZTkRSRFRGTFhI?=
 =?utf-8?B?N3QxeVYrem0vVy9DL2I1eGMxR3BzckdQTys3SENUWktLRU5NdDJVT2I3VnV6?=
 =?utf-8?B?OVlsV3ZjNno0RkZPSkRqUGdSaTUrM2llQmdBdlp1NEpZdUJiM1gyKy9OOS9k?=
 =?utf-8?B?YjZzWG1qS3J4emJSc2k1TGxHbUd6Y2k5am1lRE05WlJRM2UrSnNQc0dBaVJ6?=
 =?utf-8?B?MWpUY1NHQituekZ5QUVacjJxV0pJZTdKU1NWSnNGQ0Nhb3I2ZHBLOXl3ekc5?=
 =?utf-8?B?MHJNWExOUXR3TGRLN0plWnhreFo2Rit2bGtnQkFPYXR4c1lzSktIL0wrUjh4?=
 =?utf-8?B?aGUwZE1XYW4xU2M0Z2gxcGEzckh5cWZ3US9mMHo1czJlclFaay9iUVBQTHBJ?=
 =?utf-8?B?dlFrNEIvUnZlMCtsdWJGR0VRb1dyTEJPM3RCTVNRcCtWOFpJWXJSMm16c2VD?=
 =?utf-8?B?TjNKNTdzOFB2eTN0MDcxQjJxbXFEYlhhRFZCVHVNUHhGN1QvRjYxZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: N/gnNH5IFtNQJjzUUmHHqF5PnBlnE70Gt/EQ2YNgTjpt2/eQH+PQRuZPh6XMmSeOrdOq8oU2pFujjzKSgJ/Aw6yobMORIkOEIJ9bqzt7NsC7bMFXuKzKOv7lxbStyyZFenAZb/r9VfmS85Bfa/BqR2l8u0KsX1Ffn/FyN6FjBougbOBiAOfLpzlQ7vcAS/ROljVRhvL7FEjcSwJNVCiXlpOw40KiO+TLry8sAKQ3IRa1kYxVac7RMDye3pVxQjHAVMMerwdeIzpX8s+HAH4mZmO/qKK3z7hJ962nML359ERdlG+cA7zjqHSAA/jYDlT4Zw72y6G7KRWTAB5QRQIVUw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a31fe193-acf6-4431-f3fb-08df4a0769d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:46:21.0514 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2hWOLVC9lC8ZgvKmGOIpI22mh2K3kabTEqnZMmmoXR+IDRII3tlnLBaxOlE/Hvrs8MN1792NLAfKK+YH7nPVXWZnEv9rSnPX9xs9/zsa358=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPF6240AD2A0
X-Mailman-Approved-At: Tue, 24 Nov 2026 13:22:50 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSmFtZXMsDQoNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2Z0Z21hYzEwMC5jIGIvZHJp
dmVycy9uZXQvZnRnbWFjMTAwLmMgaW5kZXgNCj4gNWU3NGY5NzY5OTkuLjEzOWUxMjkyZGIzIDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9mdGdtYWMxMDAuYw0KPiArKysgYi9kcml2ZXJzL25l
dC9mdGdtYWMxMDAuYw0KPiBAQCAtNDE5LDYgKzQxOSw3IEBAIHN0YXRpYyBpbnQgZnRnbWFjMTAw
X3N0YXJ0KHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ICAJCUZUR01BQzEwMF9NQUNDUl9DUkNfQVBE
IHwNCj4gIAkJRlRHTUFDMTAwX01BQ0NSX0ZVTExEVVAgfA0KPiAgCQlGVEdNQUMxMDBfTUFDQ1Jf
UlhfUlVOVCB8DQo+ICsJCUZUR01BQzEwMF9NQUNDUl9SWF9NVUxUSVBLVCB8DQo+ICAJCUZUR01B
QzEwMF9NQUNDUl9SWF9CUk9BRFBLVDsNCj4gDQoNClRoYW5rcyBmb3IgdGhlIHBhdGNoLiBPbmUg
dGhpbmcgd2Ugd2FudGVkIHRvIGFzayBhYm91dDogc2luY2UgdGhpcw0KZHJpdmVyIGhhcyBubyBt
dWx0aWNhc3QgaGFzaCBmaWx0ZXJpbmcsIGVuYWJsaW5nDQpGVEdNQUMxMDBfTUFDQ1JfUlhfTVVM
VElQS1QgbWVhbnMgZXZlcnkgbXVsdGljYXN0IGZyYW1lIG9uIHRoZSB3aXJlDQpnZXRzIHBhc3Nl
ZCB1cCwgbm90IGp1c3QgdGhlIG9uZXMgVS1Cb290IG5lZWRzIChJUHY2IE5ELCBldGMpLg0KDQpH
aXZlbiBSWCBkZXNjcmlwdG9ycyBoZXJlIGFyZSB1c3VhbGx5IHZlcnkgZmV3IChDT05GSUdfU1lT
X1JYX0VUSF9CVUZGRVINCmRlZmF1bHRzIHRvIDQpLCBjb3VsZCBhIGJ1c3kgbXVsdGljYXN0DQpu
ZXR3b3JrIGZpbGwgdXAgdGhlIFJYIHJpbmcgd2l0aCBpcnJlbGV2YW50IGZyYW1lcyBhbmQgY3Jv
d2Qgb3V0DQpyZXBsaWVzIHdlIGFjdHVhbGx5IGNhcmUgYWJvdXQgKERIQ1AsIFRGVFApPyBKdXN0
IGN1cmlvdXMgaWYNCnRoYXQncyBhIGtub3duIG5vbi1pc3N1ZSwgb3Igc29tZXRoaW5nIHdvcnRo
IGd1YXJkaW5nIGFnYWluc3QuDQoNClRoYW5rcywNCkphY2t5DQoNCg==
