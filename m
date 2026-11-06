Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E40D606A31B
	for <u-boot@archiver.kernel.org>; Fri,  6 Nov 2026 03:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Cq9gVXxY;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=bK30bL1c
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07FB480F6B;
	Fri,  6 Nov 2026 03:13:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qlFf3lK3b-TY; Fri,  6 Nov 2026 03:13:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4374E80F8D
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793934786;
	b=qAizHQNdH85kSw+Sz4nUbbperEHxWGkIfuTnVqIGftxALekF4xMqTYF1TGfezkX2MQn3
	 FZ38ORUHKqbd9twg1IDzL1xzSvhBinv9996DmlQQ3iOCSS02yK0eAgv6XEn2BCmBhgGI4
	 xlK/te9EAxd0AQUJsRDtTRoSxiswbJyrTRagzcLNF4Pc2CR4/vge/mlPpJoqYgDk+8Puw
	 1IFWlvPDckAH6z685bh4OsZrYWoGBUrDryhvs4VZ5c5inIP6ZTMKxJwt3XId8u7CodolZ
	 SNXEcpUxxwsbHmPw5jOs9J/ueIbII+xiEzvCnC7qcEmJ5VEEhNy9D8WPB13T6WPS85g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793934786;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Comment:Received:Received:
	 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:
	 x-ms-exchange-antispam-messagedata-1:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
	 X-Virus-Status:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=/uAGmO5j4mXWlYESErfxfA/lKJZJbBoRXkIvqLQDFh0=;
	b=iSelZxdc8M2FC53N7Y+LoGXax+zR7ctSsD7+ylFWaVhlUeONjWDSgIZbnhU3v4bPJczY
	 1FOr5FhMRAd72VSYOcJH1PptX9MCKf3XWoZEVafGCDZAyFHZ5PoFsnoCQjraLpIueYOxX
	 RCUKoPnvwiMrf4xQE1uVAky/mAlLXiGk9DSSTMEi3l1B3lRWm7LxMgzS2EnQBqeN8zWAK
	 TwXAcPQPchOuS271jj3Os+Qup5Q+N19DC0IILdZQY+eIqheN2n8IJ138ykjm4WWpuUYo8
	 g/UX1I6aG9wdRNadz7QGpfX/FYr/p8zUDtDNUqty3o7hcqkmaPKSwLzFgBPyKqLBn1Q==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793934786;
	bh=/uAGmO5j4mXWlYESErfxfA/lKJZJbBoRXkIvqLQDFh0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cq9gVXxYSmOOiLRSvwp5P2YkVVX47TVWI4y2l1zwesP0w4kufMd4RQG0tdFrJTLpQ
	 NF4AHk+4HYFI24IZ77dk3f6K6AZUzN0lsR9x9MYzHT5w7UktcqtmxQXAlXPR7TGt2T
	 KjAADxStKFG+Bp0mmxcLqgJHprK2hy2hHqTHiZ83GVQFHklA1hMg+fL5qXrzYnuEku
	 siJ/6xE/Jow+lxMURF8fdE4QsZPlSOECFvUI9jo6hgqKl8McsnbH7z+Jzhlm/uZOI5
	 K8kPVP8FLKSp6AmR3EfFWjJwIMcc/NbammHHb7GQBIkE07lpzQO3xiXKx2UxcAJlY6
	 TtJWlTSmuPI2A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4374E80F8D;
	Fri,  6 Nov 2026 03:13:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 06B3C2E5
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:13:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 042024016D
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:13:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NLZUExeK42jN for <u-boot@lists.u-boot-project.org>;
 Fri,  6 Nov 2026 03:13:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 2A424400F9
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:238:438b:c500:173d:9f52:ddab:ee01"
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=alif.zakuan.yuslaimi@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=bK30bL1c
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 2A424400F9
 for <u-boot@lists.u-boot-project.org>; Fri,  6 Nov 2026 03:13:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A94438482A; Fri,  6 Nov 2026 04:12:57 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 500AC84820
 for <u-boot@lists.denx.de>; Fri,  6 Nov 2026 04:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uAGmO5j4mXWlYESErfxfA/lKJZJbBoRXkIvqLQDFh0=;
 b=bK30bL1cl3GYCugEoy4O+lLfj+KCICf8TzWDn+mmiKvbpXm+fuIqXCn/B/sUWFXbSCC8ppbp3pubL0x0Y94Djtp66gFbwqci65nnrHq6dxzun35FlQSssxYKUxaBcYNiwEZBPsZZHtmW02R6SE+xq6Qc2BjaCHCxOVOBO3pbvFu04+4xsCcP3su7Y8kUjRk8supi2uwyihMXjhuLK/N5uYZ3qOk96uZ5qH2cA99q+hyxCkM0JTk64P6Of71eNimiUfBrcNuDQA59mX8qfo0U15eowd0Eve7rtEJVd0V7GPK3is1g8TFYgiRZjn+dBg6tzOg9Xp5V1fbOGt7eOAZvvw==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA1PR03MB989269.namprd03.prod.outlook.com (2603:10b6:806:4fa::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 03:12:45 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0569.011; Fri, 6 Nov 2026
 03:12:45 +0000
From: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
To: Heiko Schocher <hs@nabladev.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "MANIYAM, DINESH" <dinesh.maniyam@altera.com>, Tom Rini
 <trini@konsulko.com>, Pranav Tilak <pranav.vinaytilak@amd.com>
Subject: RE: [PATCH 0/2] i3c: harden device index and detach handling
Thread-Topic: [PATCH 0/2] i3c: harden device index and detach handling
Thread-Index: AQHdazmL6LWRuLob3U22wyuBuSXEobcbw/cAgASetRA=
Date: Fri, 6 Nov 2026 03:12:44 +0000
Message-ID: <PH7PR03MB70632551FD8CE34CC18D836DAD762@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20261103021743.27111-1-alif.zakuan.yuslaimi@altera.com>
 <c28b0507-8bdc-e8ee-f4dc-e744cc7eced2@nabladev.com>
In-Reply-To: <c28b0507-8bdc-e8ee-f4dc-e744cc7eced2@nabladev.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-11-06T03:11:48.0000000Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|SA1PR03MB989269:EE_
x-ms-office365-filtering-correlation-id: 0e4e8975-bedd-46d1-6a43-08df3bb3d3e8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|55112099003|10067099003|22082099003|18002099003|261009221727099003|4143699003|11063799006|56012099006|261022105027099003|261026121527099003|261028144727099003|261102123227099003|261021123027099003|261026140227099003|261009221227099003|261021121427099003|261009220027099003|261009223327099003|261009223027099003|38070700021|261022075727099003;
x-microsoft-antispam-message-info: A8KeucxLkJmjCDIQSYlpZQSeBCal7X2AQNe4S9VAAYjsOhP+pPfuptbXSNi2Zwspu6YnVN3kz1qeLhc0UwgBamO9TjSHXhO3oUB9f9B+Gn/8tD3mtWF2eR/L9jxwbosi9sdpdUyxtP164rOkr7vAbQ4pr2ljE3XmULvAvd2T7fZPyBWQDXn4HjnvZRci1zeqSkjqfkGSTPOBNeBtCyXCLxaTykWdXMxduHu/8LY/kFw7dAO3osGJLEbuFsAirFOIQVD+9erZctbKe5TCHMgjR1+NWyJZNdFVw0PbkJn1TgwxDiQojiXRz7LRKp1kDYms/f4gJOjZ1olH84sXfzEdk40SZwlm1m6YsbxeqFan+YsCcPh926vbO+5IrtjgIAogK2KeyBu0+0B/bdMBifCuhNiJRBjdnPeMeeQnld4LP5Y5HOX8Sr8X9Yv1Muqa5imn1cISoQS5eWHUhaQiOWMS9eCp/Av+1x5/mRYCpqtG0pRDQe8No0P8oDMG3g7Op/jWNK4iqCh1AvZ+ClMMQw8HlFp2ZCvvClJc169+B29gr7GhZhkLVLRl7jb1XkDWJf5yoHZ2xhHwpVWTwk+rGLZ0EUae3/ttqe+9kasWLsR3dsCxTx0b6ay3gQvSgAvxS2xhk79ABUEDhlImgWiYmYAUKGDDZUHr6S7yB5cNLJri/jg+I/mTrP0WOak2tSCtJuJQRXIp71dL4i9oMv+4e2PZhrL8ycjKkEMIYZike2Ng/UI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(55112099003)(10067099003)(22082099003)(18002099003)(261009221727099003)(4143699003)(11063799006)(56012099006)(261022105027099003)(261026121527099003)(261028144727099003)(261102123227099003)(261021123027099003)(261026140227099003)(261009221227099003)(261021121427099003)(261009220027099003)(261009223327099003)(261009223027099003)(38070700021)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3NZTlhwVnVsQS8wQlloYnFCdm5XdmtPUERrK3RETllCeHF2WlhTZXpZQ3ZD?=
 =?utf-8?B?NzJ1R0lhUVdocE9UUW83MHF5OVNYaEk1RkFPRE9lYTlzWEZFbzlsMFFKZHlt?=
 =?utf-8?B?aTJrTk5ubkVBdTFvWXg0eEZDVXpLZFhOOS9uNytOZkRGcWpPSDd3ak8zYzRQ?=
 =?utf-8?B?ck9YVjU0UGx3UEJCM0lONHhaRDZja2k1L1c1VlF2YW5pNERPSDRSNXZBYkIy?=
 =?utf-8?B?ZVo1aSt4Q0c3QisyWGo4MXpYR3Y1Rk84WVBSNUltSHRQUDQ3NnM2Z2E3eGlo?=
 =?utf-8?B?RFB5OE9rc0d4N2tsOFFkUU82UXVGTE1ONWFDUmdwYzU0NGVtcEJDQVBsVVJy?=
 =?utf-8?B?VFduMU9yNXVyOHd1b2xqZkNrOVdwTVFrbHVtYTEzK1dVOG8vNnVGc2FyVXZX?=
 =?utf-8?B?VkNrTjNyN1BNTG9yc0pUd3dNY0FOclVHVmNML1JXblNrWHBXSFBFR1llQkNI?=
 =?utf-8?B?TDl1Y2k1UEtPUlhBMHFGdW9wNm5Fam1zcmtVZmgrUUZQTC9YSFpFaVlYc2p1?=
 =?utf-8?B?S3VMMTNiemxjbXkrbzU4WmJEaFhPMGU3RmdpM1l1WXFQOEVhQnJuRnYzQzlJ?=
 =?utf-8?B?SVFXYVdQL2JGL1JsQkcvdjJUYzk0ZVhoZ1dIc0hTUUhzc0JZcWZlWFFaRnJP?=
 =?utf-8?B?RWpyMFh6NHNKTTVrd0o3ZEIzZHBWMC9KTjdqdXhCVHhaNUdHV0FqQ0tzU2ZY?=
 =?utf-8?B?cUM0VzdTUEhuYk9CYjhLc01LOFV1SWIwOURWS2xVaVJBS3E1YldicEt1Uyt0?=
 =?utf-8?B?TGVoQ2s3NHZoNHl0ajloMlRKM2MzUzJhWStpMDhEMnZoS0R5akN3bm9FclZZ?=
 =?utf-8?B?ZHE1QzB4VURrVlo3alNxeVFEcjRtZ3lZeFExUnBBcU5sbHRSa0JOeHZTUURS?=
 =?utf-8?B?czVUc3k0THU0cnd6RHZjZEo2MjVSUXRvMVhwbFV6QTV3TnhYOFYwUlNreit4?=
 =?utf-8?B?OUQwYVd3Rjk4VTA1VDZqSm5lQUJxUlN0VWZERmY1emhZb2t4MGQ2ZmEyb1VQ?=
 =?utf-8?B?aXNDWXpnNU5WdUxWUnliMW5TZXdNa0lYMzNvcXE5NjE5RHZBMVZxNmpHRHZO?=
 =?utf-8?B?M29MV2RoTWIzV0l1L3dkOGJqN2NVU2FtdmpPN2ZvT3BnT05FWDBFSkJrZ0tx?=
 =?utf-8?B?WXBRZW1sb2ZuNDZaYlcwNHQwS21tZkp2VGlvQjAzSmh1WnMvQ2VBTmcweDgx?=
 =?utf-8?B?WWgwOUhMcWJ6M2R1cE9OSGVlLzBBY3FZak1UaWdHdGEwZTdOU1lJaTJWNmd5?=
 =?utf-8?B?dEVZWm90MXR6SGdVZzJDYU95WkhBMnFSVzRWMTBJSTFpZHlqcHJWMjMzVlFn?=
 =?utf-8?B?UGtOZDVIVWZ0U0RFS0IzSWVucnQxZWU0Q2VqWjRJZ2ZhdGh1VjM0WFJTTzNV?=
 =?utf-8?B?VWlHVWVjS0NQU3JQd1EzY3h6eU9zQnpDR21vVjFtNUJHL1ZOWnlCZXdQTDNX?=
 =?utf-8?B?dkVERVgrQitGampkbkx3SmxpaERxL3lFeE5GQm5mREpwNUxPUjJzc2pJVkZa?=
 =?utf-8?B?SFZlUHd0UHZ2UEsxZHBZLzdXWG50VE5ySjdLUkFEQU5xalR6WWUycUlIR0lE?=
 =?utf-8?B?YklIOHc3Q2hMY1lCN0JicmJnUHZsTGhhTXpuTDFQN0lBcjA5Vlp3RERuY1o0?=
 =?utf-8?B?WjQvRndVL2oyMnB5VGVlUkZqWDhaWXhDQVVPTU9GZDMxQzJpQ3pIMUcxN201?=
 =?utf-8?B?QTl0TWQ1VU5BZ1NISEh1MzhNVHFNbDF2V09kQ21zNGFkNXU0dC9GSlI3WjdY?=
 =?utf-8?B?dDBTaFQxRUpPV2x3SW85MzUyK1U0SHVhQ1p4K2JsdklQS3BWdWlOUFVPckIw?=
 =?utf-8?B?VEF2ZHNBdGFQS1htZlg2aEV0Ync3a3F3STVPUGhmTXRjTUVTQzFMQ3VUTXVx?=
 =?utf-8?B?TEpCbGVpS2NpWnJaV0ZrR2JEV3loM1ZsZmhobUl3elArNXBQWGsvU2Fya2Qv?=
 =?utf-8?B?RE4weVNIajI2VXdhVXZ0VnNPRUhJSkQ1SFo0YUtEREREUHhST1RJdENCTVpR?=
 =?utf-8?B?bXkzMDFlSFMwL3IxaGJRZmdzcW5TNnd2WTkzOFB4MlQvSTdnMmY1cmNCa0g3?=
 =?utf-8?B?ejJ3SlFpcHhHWVJKUm5kY2VlTm5UOGI2S2ZOU3ZwT3NuSWdHN0pPejloZHVS?=
 =?utf-8?B?eThrYUU1N0VFYUZkR1pNajVYNXIyaTdtOC8ra0o0Rmw3YnNaTk1KQjA3Y1Bu?=
 =?utf-8?B?aU94MXlocDg2WWNsaC91Yk0xUUplb212OXM3NWdUeXZFSWkxSlBUc2taN21o?=
 =?utf-8?B?VHNVeFhxcGJrL1Z0VHMra0l6WHFMMUliaU5Hem9zeGxpcVlNSCthS2QvV2Ft?=
 =?utf-8?B?dk1GZlpMaGkxaUkxTktvMzB2N1RGQW5BT2o1eGtaNlFsbW9PemVhdWlaVjlo?=
 =?utf-8?Q?tH80vWEIGVHbdFxdQMq/jPGx1AX6LLmZMdsutAnzhe1tz?=
x-ms-exchange-antispam-messagedata-1: vKHVOmqO9cMLf3X3sZJrgKqTpGJPtkFvrAU=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e4e8975-bedd-46d1-6a43-08df3bb3d3e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 03:12:44.9795 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gflp/Zuafov66LJs/sGC4pz9YMcqnTiCd7WjTPFaDMQnTA9TGADfhjZOFyKaaYDEUE9ZYyeHy/DGKrMfq/CjywivrDg3YGOrlMD7+0gsoSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB989269
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_FAIL,SPF_HELO_NONE autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGVsbG8gSGVpa28sDQoNCg0KQWx0ZXJhIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZWlrbyBTY2hvY2hlciA8aHNAbmFibGFkZXYuY29tPg0KPiBT
ZW50OiBUdWVzZGF5LCBOb3ZlbWJlciAzLCAyMDI2IDEyOjM5IFBNDQo+IFRvOiBZVVNMQUlNSSwg
QUxJRiBaQUtVQU4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGFsdGVyYS5jb20+OyB1LQ0KPiBib290
QGxpc3RzLmRlbnguZGUNCj4gQ2M6IE1BTklZQU0sIERJTkVTSCA8ZGluZXNoLm1hbml5YW1AYWx0
ZXJhLmNvbT47IFRvbSBSaW5pDQo+IDx0cmluaUBrb25zdWxrby5jb20+OyBQcmFuYXYgVGlsYWsg
PHByYW5hdi52aW5heXRpbGFrQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMC8yXSBp
M2M6IGhhcmRlbiBkZXZpY2UgaW5kZXggYW5kIGRldGFjaCBoYW5kbGluZw0KPg0KPiBbQ0FVVElP
TjogVGhpcyBlbWFpbCBpcyBmcm9tIG91dHNpZGUgeW91ciBvcmdhbml6YXRpb24uIFVubGVzcyB5
b3UgdHJ1c3QgdGhlDQo+IHNlbmRlciwgZG8gbm90IGNsaWNrIG9uIGxpbmtzIG9yIG9wZW4gYXR0
YWNobWVudHMgYXMgaXQgbWF5IGJlIGEgZnJhdWR1bGVudA0KPiBlbWFpbCBhdHRlbXB0aW5nIHRv
IHN0ZWFsIHlvdXIgaW5mb3JtYXRpb24gYW5kL29yIGNvbXByb21pc2UgeW91ciBjb21wdXRlci5d
DQo+DQo+IEhlbGxvIEFsaWYsDQo+DQo+IGNvdWxkIHlvdSBwbGVhc2UgcmVzZW5kIHRoaXMgc2Vy
aXMgdG8gbmV3IHUtYm9vdCBtYWlsaW5nbGlzdDoNCj4NCj4gVS1Cb290IE1haWxpbmcgTGlzdCA8
dS1ib290QGxpc3RzLnUtYm9vdC1wcm9qZWN0Lm9yZz4NCj4NCj4gYW5kIGRyb3AgdGhlIG9sZCBk
ZW54IG9uZSwgVGhhbmtzIQ0KPg0KDQpTdXJlIHRoaW5nLCBJIHdpbGwgcmVzZW5kIHRoaXMgcGF0
Y2ggc2VyaWVzIHdpdGggdGhlIG5ldyBVLUJvb3QgbWFpbGluZyBsaXN0DQoNClRoYW5rcywNCkFs
aWYNCg0KPiBieWUsDQo+IEhlaWtvDQo+DQo+IE9uIDAzLjExLjI2IDAzOjE3LCBhbGlmLnpha3Vh
bi55dXNsYWltaUBhbHRlcmEuY29tIHdyb3RlOg0KPiA+IEZyb206IEFsaWYgWmFrdWFuIFl1c2xh
aW1pIDxhbGlmLnpha3Vhbi55dXNsYWltaUBhbHRlcmEuY29tPg0KPiA+DQo+ID4gVGhlIERlc2ln
bldhcmUgSTNDIG1hc3RlciBpbmRleGVzIG1hc3Rlci0+aTNjZGV2W10gZm9yIHRyYW5zZmVycyBh
bmQNCj4gPiBsaXN0aW5nIHdpdGhvdXQgY2hlY2tpbmcgZm9yIGFuIG91dC1vZi1yYW5nZSBvciBl
bXB0eSBzbG90LiBBIGJhZA0KPiA+IGRldmljZSBudW1iZXIgb3IgYSBkZXRhY2hlZCBEQVQgZW50
cnkgY2FuIHRoZXJlZm9yZSBOVUxMLWRlcmVmZXJlbmNlLg0KPiA+DQo+ID4gVGhpcyBzZXJpZXMg
cmVqZWN0cyBpbnZhbGlkIGluZGljZXMgb24gcmVhZC93cml0ZSwgY2xlYXJzIHRoZSBpM2NkZXZb
XQ0KPiA+IHNsb3Qgb24gZGV0YWNoIChsZWF2aW5nIG51bV9pM2NkZXZzIHVuY2hhbmdlZCksIGFu
ZCBza2lwcyBOVUxMIHNsb3RzDQo+ID4gd2hlbiB0aGUgaTNjIGNvbW1hbmQgbGlzdHMgZGV2aWNl
cy4gQWxzbyBkcm9wIHVudXNlZCBpbmNsdWRlcyBmcm9tDQo+ID4gY21kL2kzYy5jLg0KPiA+DQo+
ID4gQWxpZiBaYWt1YW4gWXVzbGFpbWkgKDIpOg0KPiA+ICAgIGkzYzogZHc6IHZhbGlkYXRlIGRl
dmljZSBpbmRleCBhbmQgY2xlYXIgc2xvdCBvbiBkZXRhY2gNCj4gPiAgICBjbWQ6IGkzYzogZHJv
cCB1bnVzZWQgaW5jbHVkZXMgYW5kIHNraXAgZW1wdHkgZGV2aWNlIHNsb3RzDQo+ID4NCj4gPiAg
IGNtZC9pM2MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgfCAxOCArKysrKysrLS0tLS0tLS0t
LS0NCj4gPiAgIGRyaXZlcnMvaTNjL21hc3Rlci9kdy1pM2MtbWFzdGVyLmMgfCAxNSArKysrKysr
KysrKysrLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pDQo+ID4NCj4NCj4gLS0NCj4gTmFibGEgU29mdHdhcmUgRW5naW5lZXJpbmcNCj4g
SFJCIDQwNTIyIEF1Z3NidXJnDQo+IFBob25lOiArNDkgODIxIDQ1NTkyNTk2DQo+IEUtTWFpbDog
b2ZmaWNlQG5hYmxhZGV2LmNvbQ0KPiBHZXNjaMOkZnRzZsO8aHJlciA6IFN0ZWZhbm8gQmFiaWMN
Cg==
