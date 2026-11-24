Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06338606A31E
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=FAZs97AB;
	dkim=pass (2048-bit key, unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com header.a=rsa-sha256 header.s=selector1 header.b=K28Zuv7k
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CF53D6083C;
	Tue, 24 Nov 2026 13:23:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pN1fi3n3D4Xh; Tue, 24 Nov 2026 13:23:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 243BB60841
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795526583;
	b=a1GO9q3AYAyBfVzMaW863s6Vyp2lEiD627iin4s0NvfflWie7LjBX5dHmzp64R5ylCqI
	 S2PlJNub24IvGatcCkQdcIiQkKUddo41MAtzv8cBBuGcQMkxm0SsanPY/yEX+p0kwhP2R
	 XJDV2WuaBWr/hC45/3uBDq4n/c38N5P90kFcsXkR3Q2OxEU1HQ5wQ7UthXgSfrjAa9/XU
	 ws7+VM0hHxNjrDkLjQhtd8+kDIwL4yhBR/uTvQPoeJ3v2C4zzdbTVFBvqEPJ3Jmub4WRP
	 mx9YeguJ6ENKNApqu1bMKUbOG5CdPwUsuVnE3hvqbeOdvQeQiBVP1EMIqTgEalkgwJA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795526583;
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
	bh=v4moPtESog1vxDJmMcH/mcvbLw1XWvnBdTNMSsJXXlM=;
	b=LZqZKGUkCMkhEQT43wTKv/arWI6AeR6W2dqGTUy6o5T1CpYwVxio34vgdnRSunLgHQqe
	 rDEcCR/PghudOiSfY2KnhI2jB/y6a3v227wJKxXxwrDjPOktX5grgjF9YETFpa/sddUcz
	 4R/trsaLxB1CEzSarqoTHxvr2LhUo1Mywb4q6B2rB/uOfhRZtr8w0fzrY2FlLVMgY0qUs
	 QH0lNdDfxeS6g3Jo+yFn6A9I+rE7zTof03PIseSLad0wBKA8gOTKTweNxps8wINOqSmsw
	 QoG2kzgHYYlCKthNzVi4FQ1ABzufVFa76T8JS0ooX8/wSBX9CvRkgzD4dZx2+OLgKcg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795526583;
	bh=v4moPtESog1vxDJmMcH/mcvbLw1XWvnBdTNMSsJXXlM=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FAZs97ABZq3boXBAqWYqKBdIMA15oEJrzT3mLmSDIDZLUmp1NSYYt2Iy+EgWXZ25g
	 UXNYoTa2rboJBM2p/fNmsfKhAQ0D5VvNjJWqFMyH5z39GS5Ba2pVXIyMfwJ4zSZtpz
	 S8suIfjb/KzRBQ6DxgcJ6UaUXSpdIw9NXfWRrrB/Epw29ys+gL1bl0Y4pd0ap+B7v0
	 6Emh1Lt5A2xY49kuSb64XyorVxZv7g1lAXeBOkRMqlNEi6j76Y/oJrZRRBemjZ/+Bv
	 EnGSIy/N2W+il/bfSEoD54W0gu6KtCGOuTE+KcJhIdyKvrrN4MyKxHiLZ99++goC9C
	 MnLWJybqIGUnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 243BB60841;
	Tue, 24 Nov 2026 13:23:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2401BFBB
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1597D40779
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:24:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ED9-lhVWPTYF for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 08:24:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5C38040774
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c406::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c406::3;
 helo=os8pr02cu002.outbound.protection.outlook.com;
 envelope-from=jacky_chou@aspeedtech.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=aspeedtech.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=aspeedtech.com header.i=@aspeedtech.com
 header.a=rsa-sha256 header.s=selector1 header.b=K28Zuv7k
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazlp170120003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c406::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5C38040774
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4moPtESog1vxDJmMcH/mcvbLw1XWvnBdTNMSsJXXlM=;
 b=K28Zuv7kqC2ZyeYSwQ5Oa9Ot7ctkLoOtuBuigPPHRAzjqG0vk3vE12Nf51jGgteyl1gN9CvPeXIblejUiVa4w9+/i2U8EHHsQZwX0SbD8TndaAxuFTzDdD0gKrWkfGcvXlWeoGvLtEHIIMBJZ/Exhx9jEEhvNCqy7Se6oxq1GS9LDWRjRYXaWQ3y+pjjZoK5tYur+bucmVS6VikxcQOYjdSgdFYrAPkUyL2KajIE7NMFIIaL0P2rTFV3tK7SKWpDGoyVIw3IjoKhv3p1qiP4zboKyVcgR9J9gtiY6MHXUDduUXWvlGcR9jUjB8gWVLSk2K1OagmQ5YCy3tvhUTDOyA==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TYZPR06MB8324.apcprd06.prod.outlook.com with HTTP via P2P;
 Tue, 24 Nov 2026 08:24:49 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::f53d:547a:8c11:fc6c%3]) with mapi id 15.21.0662.000; Tue, 24 Nov 2026
 08:24:48 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: James Hilliard <james.hilliard1@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, BMC-SW
 <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>, Macpaul Lin
 <macpaul@andestech.com>
CC: Ryan Chen <ryan_chen@aspeedtech.com>, ChiaWei Wang
 <chiawei_wang@aspeedtech.com>, Jerome Forissier <jerome.forissier@arm.com>,
 Tom Rini <trini@konsulko.com>
Subject: =?utf-8?B?5Zue6KaGOiBbUEFUQ0hdIG5ldDogZnRnbWFjMTAwOiByZWN5Y2xlIHJlY2Vp?=
 =?utf-8?Q?ve_descriptors_after_frame_errors?=
Thread-Topic: [PATCH] net: ftgmac100: recycle receive descriptors after frame
 errors
Thread-Index: AQHde4YT8CabLV7eKk2YeTQbYr3vA7c84liw
Date: Tue, 24 Nov 2026 08:24:48 +0000
Message-ID: <SEYPR06MB51341F9112201F8371976FA39D442@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20261123-submit-ftgmac100-rx-recycle-v1-v1-1-d2afd61f2ffa@gmail.com>
In-Reply-To: <20261123-submit-ftgmac100-rx-recycle-v1-v1-1-d2afd61f2ffa@gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TYZPR06MB8324:EE_
x-ms-publictraffictype: Email
client-request-id: 51536e36-b089-4fa9-a0ec-88f94a9e4968
request-id: fc8d2266-2d2e-45de-194c-08df4a046766
x-ms-office365-filtering-correlation-id: fc8d2266-2d2e-45de-194c-08df4a046766
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|261021121427099003|261022105027099003|38070700021|261102123227099003|261026121527099003|261026140227099003|261028144727099003|56012099006|10067099003|5023799004;
x-microsoft-antispam-message-info: lqxRXfc0HlPCFBQ/81cP0hYaXBOBfCvHRPewE9BPwTHl8nJOIWtwXLmpFgG8lM6xB7d4Plp/x9CDrObWHiLY/TYMiiB17BaG21Qx6fs2h6OZsryYPv+n+DEf4mF+S6uiRwtYm5sSgKj0k8+SrUrustH0tJGEJaaZdDrWIPyYQuYokakXFeZquyNdjnnl+sqPbdAXc0wPhrTsOOQg3LICah1R0kBI0vhZomgwSNEp9VCMxGlMkLAO7yddy5ilrp6FrnnHwzMYtytfLQ5djlJHOBomza1QyWUeNKNzN1z6hC/s4hD/AVuVFjm1LvkGCJv9kDqB02vvLzOS22iWBRXvPSzNs+Qj7nw/6fq9e2ZMAPgAYr9ZKQT5n7o3cmYqNv63+5zsFkk5MWh84Tpltrh8WIdiAyLgtXZ7vhSBI5Tz2Y+BBoKondo90wCUBs42Hat7Y/LIC7kMPRDwTch92nglDxouad1+dRkzjbIA7b/n5PbOpqesF/omLfEkAFi95MEwgHOKeTA2eUa5OFlJ0/qXFvrnSlkSKDbgV1PFDDp0y5QE4sws52F6vafBPT4I7aEYZKX71CjwDyGqZFGKw0/hUzEJuBtnuo56XAUDP4dIf3giyC6+X7N7JmC5sTLBEf/FLRePQt4yuWfSXhH5r/Td0IxjYk4aAl35AEkrkGAxKNhssu5LWXBeNYwnDR1iMgG2HCORaQKrn9TGgzxR/e/cB+NKZg3qdNCx8fRTictKFbQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(261021121427099003)(261022105027099003)(38070700021)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(5023799004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUVIUFZRK2ZTcGxtTTlXWWNHYmdQWlNFRmhhb0F1MDl5ekxJSkVHaU13bjBS?=
 =?utf-8?B?MWYwWUtvT3VhZ1oyRU1iak10eEZDaExVQVl6cHFLUkxqNGQzVWZ1ekduNGRK?=
 =?utf-8?B?MlRqeGJYNzFZWlZQbkJxakhJRm1YYk5OUFNHNGZQNzQrVkY2M2ZNNkhHRENM?=
 =?utf-8?B?VGdFTUM0UFh3bmg0dmxkVWJFVFpMTHhscHAwcUZLaUF0RjBGcHo0YzdjdXNF?=
 =?utf-8?B?OVB6NEFKdlhxZFJ0d2JtWVdnODNOUGZtNzlaUFFQakx6eFZtRk1HWU5qd21I?=
 =?utf-8?B?SXpEa2lraU1SajlzM3VhdXlQcDNObFUzNFpWKzQrZ24rbHpIbG4wa21IcVEw?=
 =?utf-8?B?anpNYzZTVGcvc2txaXNBQmhwUG1ub2ZCREU1V0Q4bzBscStuSUw4NlpMdVlW?=
 =?utf-8?B?VHBGTFlZVnNzOTJuNjBEOUloN0piaHJtNThPMTN4eVRJWGdKV3lFT0tibHdS?=
 =?utf-8?B?Z3IyQlIxUUxyYkxoUGZjMWtMMkNKVWNvaGdSaHJRc2ZiY25sRzRpQzZlMUJD?=
 =?utf-8?B?aFo0dUVMdlBPUmlQblNsY09UT2toQVFicWswMUl1NElESWUra05IcXUrTVVi?=
 =?utf-8?B?OVQ2cXNsODZ5T0svb0NCYlNmOTF0NHdhWU54RDhMTHVXUFBMUzQvTzg4ZmpK?=
 =?utf-8?B?a1BDNVVXVXJoSllFZm45THkxNTlVb1ZOeHFLMllodXRabDcxb1A1VExOam1R?=
 =?utf-8?B?UHpNN2l1bzJYVmhkNXF1ZzM4aCtmUFVMbkZTM0RYcndrc2IxdTQzaXFyRlZv?=
 =?utf-8?B?ZUszTnpUcjZPVERvNExSR24vdEV5cVR4TjNEcFBwK2x2KzBjQ21NdmRZRFFr?=
 =?utf-8?B?UzBDZnk2Rzh5YVByTmJBSW10bDB3U2pJVjJXSUpleWdpYlViZDByOG9ISU5i?=
 =?utf-8?B?d3ZTNU1SVGRabFY4TnhRNloyWVArWmxTTE5Ja0tMNVVYNW8rcDNPTU16ZXVD?=
 =?utf-8?B?SWh3RzBYRmJjSXczbmRzdnJxZStGVVZ6cndnRXZhWTVVd3Y1UDJ5cG9YOHVQ?=
 =?utf-8?B?d2p5T2dNbXljdGNzRklZOE5iaWk2WEJobmdPNnM5aEd1N1FrRTUyN2I5YVAz?=
 =?utf-8?B?UU5zM3VzWlFiano4bzVDRFhXajROSUp4bktBbExRSzZZUlFoS1VrVGt5M3g0?=
 =?utf-8?B?c1Fnb1ZoVzFySGFSOU9EcmJ3S2dIVk0yKzlmeGk2RmVpclNOcWg2c0k4RzZM?=
 =?utf-8?B?T0lmcUR6bi9vejRGd3J2bW5ETVBUQW5hSm9lQUpiMUFmVE1lZVExaUJVQkV3?=
 =?utf-8?B?c1JjTXZYQ0l1VlZKMmhqd1p5Ui9PZFRReEw2dmNyTFhIME9DLyttRFhBV2sx?=
 =?utf-8?B?MCthdjZualJENTVweGhSMlZIc1VEQVlKQVp0YlZMNUhWcmVKYkh2bEJiMWgz?=
 =?utf-8?B?RTY5bk5tVDc4YnlvUC9TUHJIOXBrUUNKb3lwZG1LL255Uy90NFJtRjRoKzlm?=
 =?utf-8?B?RzFxN0FOR1pSay9NM2c0ZjlRbkgvSDdDWWg5S1JxWHlLMzJmT1ErbnBGcDU5?=
 =?utf-8?B?NjZIbWlWSG1rOTlOeGVvNjcxem9kMXhOWDJmUEpTL09Ga2VYeURGL3VzN2pP?=
 =?utf-8?B?UkJud2wrVmREQUlhdVdmbWF3SlRBbmFWZHF5L05qbzhDNDlRQ2xjbHpuWXlu?=
 =?utf-8?B?K3czTGlmVzlXY1hPWUpUci9qVnozamxaT2dnSVpkc010MC9mekRzQ0JjVVkw?=
 =?utf-8?B?M2Jnam9adnkxeCtUR09aYnBZNFBkYlA1a0NGNmtNODBMWFRxRDVES1kwbVNB?=
 =?utf-8?B?dlRmdDVDZmFSYVRVdFhQaEJNUFRiR3p2MUJYTnZLK2hTY1FyM1UrUTh5M1g4?=
 =?utf-8?B?eldqSVQvQ3ZwSFA4NjI5anI4QUUwZWNqMWd4TXNWcDFTYXNMcEVZcG4xME8x?=
 =?utf-8?B?Mzh3cXJVdWlZSGNPY1ExeitYK2gxWFU5T2QvUWtJT1Z6bXFMZXdOTjhSSnFv?=
 =?utf-8?B?RmU5Q29vY2EyV1RvWHBHVVZvbG1LRmpxam5IUDVCYWIvRisrRk5wQ0Y0RVgw?=
 =?utf-8?B?blNmdUEyNnV6UVBselJFUkYzbnV2a0xFemY5MkY3YWd0TVlpc09wZitxY0s5?=
 =?utf-8?B?dzd5UzRvSXZUNmR5QjVad1QxZ0xCaEdHbGlWcElBazEwTmN3a1lQTG9JZDlE?=
 =?utf-8?B?cEVPdy8rWHI0a2tjMkthOTFCZW5tc1Y3MlJyc1ZtQWY1NkRxL09FdEtvMHlm?=
 =?utf-8?B?NmVtQzBBTXlrdkJVbXJ1TFdyampFZGtxdkF0ZmkwbStsQi9CZHIrKzh6NDBC?=
 =?utf-8?B?U3NkN2MvbHQ0dGFSVFY5SEhFQUtHWGh5ZXYzcEtHOWFxdnptdE9OUzNWZXpG?=
 =?utf-8?B?S1pudXQ1K3Z1c0orVDFZbWhpcm1LNUpERTVSUDhoYnEzbTRmN3l4dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UnSajbWiCfxmDCRtKSc//zE8C+AgBOGjFbVB9mvJ/ox+BQWs4WJ7xBQGDFIbM9x7YHYTjc8v+oBq3AAqQGdtzYGhZ1uqNY+3HcqyDgC1NgTbU3YWl80o/xGopZ9WLLDrPJq1RNpEEXwEBTcdOBp/NCS8XW4u4XI6XNTL0MM6gj2MPz7YqwO7PIzJso/tquIMNk/QF23zo1xMWRKjJOnYGj+NXSh7RWB59x3QKJi7IHy2ccHLV/ml3g7Rhgs5KGHBWUzLxerjAM350F71jCEBkz6aJkKOPwHb2ex9uGliaZGpPCEehe6ZgCshytqpFh/31RgreZKjvzNjwdeIywClkw==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8d2266-2d2e-45de-194c-08df4a046766
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2026 08:24:48.4061 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SDe/Hzsx453Kyn93qn45gTRWlpq8QgfA/0iNavMrQiSxaYgSJ5juS9EagX0bPa1mMKUyQOsiXSUi91x4rWPWVtRa30Qd2Afpp9sMfsJvlZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB8324
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgSmFtZXMsDQoNClRoYW5rcyBmb3IgY2F0Y2hpbmcgdGhpcy4gVGhpcyBsb29rcyBsaWtlIGEg
c2VyaW91cyBvbmU6IHdpdGhvdXQNCnJlbGVhc2luZyB0aGUgZGVzY3JpcHRvciBoZXJlLCBhIHNp
bmdsZSBiYWQgZnJhbWUgKENSQyBlcnJvciwgcnVudCwNCm92ZXJzaXplZCwgb2RkIGJ5dGUgY291
bnQpIHBlcm1hbmVudGx5IHdlZGdlcyB0aGUgUlggcmluZywgc2luY2UNClJYUEtUX1JEWSBpcyBu
ZXZlciBjbGVhcmVkIGFuZCByeF9pbmRleCBuZXZlciBhZHZhbmNlcyBwYXN0IGl0LiBFdmVyeQ0K
c3Vic2VxdWVudCBwb2xsIHJlLWV4YW1pbmVzIHRoZSBzYW1lIGRpc2NhcmRlZCBkZXNjcmlwdG9y
Lg0KDQpXZSBjaGVja2VkIGJvdGggY2FsbCBwYXRocyB0aGF0IGNvbnN1bWUgcmVjdigpJ3MgcmV0
dXJuIHZhbHVlOg0KDQotIG5ldC9ldGgtdWNsYXNzLmM6ZXRoX3J4KCkgb25seSBjYWxscyAtPmZy
ZWVfcGt0KCkgd2hlbiByZXQgPj0gMA0KLSBuZXQvbHdpcC9uZXQtbHdpcC5jJ3MgcnggbG9vcCBv
bmx5IGNhbGxzIGZyZWVfcGt0KCkgd2hlbiBsZW4gPj0gMA0KDQpOZWl0aGVyIGNhbGxzIGZyZWVf
cGt0KCkgb24gLUVBR0FJTiwgc28gYmVmb3JlIHRoaXMgcGF0Y2ggdGhlDQpkZXNjcmlwdG9yIHJl
YWxseSB3YXMgbmV2ZXIgcmVjeWNsZWQgb24gdGhlIGVycm9yIHBhdGguIFRoZSBmaXggaXMNCmNv
cnJlY3Qgb24gYm90aCBzdGFja3MgKGxlZ2FjeSBhbmQgbHdJUCksIG5vdCBqdXN0IG9uZS4NCg0K
V2UgYWxzbyBjb25maXJtZWQgZnRnbWFjMTAwX2ZyZWVfcGt0KCkgZG9lc24ndCBkZXJlZmVyZW5j
ZSB0aGUNCnBhY2tldC9sZW5ndGggYXJndW1lbnRzIGF0IGFsbCwgc28gY2FsbGluZyBpdCB3aXRo
IChOVUxMLCAwKSBoZXJlIGlzDQpzYWZlLCBhbmQgc2luY2UgcmVjdigpIHN0aWxsIHJldHVybnMg
LUVBR0FJTiBhZnRlcndhcmRzLCBuZWl0aGVyDQpjYWxsZXIgd2lsbCBpbnZva2UgZnJlZV9wa3Qo
KSBhIHNlY29uZCB0aW1lIGZvciB0aGlzIGRlc2NyaXB0b3IsIHNvDQp0aGVyZSdzIG5vIGRvdWJs
ZS1yZWxlYXNlLg0KDQpSZXZpZXdlZC1ieTogSmFja3kgQ2hvdSA8amFja3lfY2hvdUBhc3BlZWR0
ZWNoLmNvbT4NCg0KVGhhbmtzLA0KSmFja3kNCg==
