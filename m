Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA68606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=kW1y7UTd;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=rANu4lpt
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 63851810D3;
	Tue,  3 Nov 2026 13:04:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zrHVtxrNl5XV; Tue,  3 Nov 2026 13:04:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 72637810CE
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793711088;
	b=C5p0M57bI8lZp51tBcOKxC9BpOvTukTc3eM8/fMXkqu0lKQbvaIQjUDN8PfbxMyAl7Ni
	 exdEOF2l4SK9+t8KiUMolNWCGydOgKCUT2OjPPZYsdMBYjL+cQ8ual2roHb3btygs3+rl
	 2EL7t9d4h/FCWHmmvmlIhv0GB2yzsh2kPGj+QSNxbWnwYn5hbJbL/tMzNBrckMGWTRUui
	 DlqW3Rumhw4IlPBY3ter8m7xuK+FhsRGa5u/HbX+GdT4sufEZUC/U30YhN2RbHSbz1O0V
	 wrfKtJC5Zlw5WuMhpQLvZx+aKta1gddObycuwKYBAw9/SMgbIeVN5HASSGBJvfQndzQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711088;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:user-agent:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:
	 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
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
	bh=1UF0PgT4LiQclJrpEEUP2nui9gogkVx47s1HQCF0Ag0=;
	b=BRabj1cdJxsqHcQP7Z9oNCdEacnXPz7sJhogy7i20MgMF2PpwJaUrM1c6c3iKE9fIn0i
	 opdY3N31k8qSc+p0wgq35j8HWmojTgJCOg5rhHxjxTLM2M/1YQ4XSwV5A4pQCpOK3CuDw
	 cspPZ4GkeZvuWFecOnbWdWeCeHzMqkNzy+uhcd5j+xP44cEVEQP8wcpEMRDB/e0zH2gsd
	 Otk/Hzr6kBIn0lPGCq0JBhVFCAiSJoszoMQDrCekKVmNI4VXJcoVl7Vz7EpUhx2whZ4lS
	 qAjVxJgClTVGacFdCtjP7rbQIH9pudFUWXNph13YfmbPaOpmZnZSKWuuqbSNU/iqTSw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711088;
	bh=1UF0PgT4LiQclJrpEEUP2nui9gogkVx47s1HQCF0Ag0=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kW1y7UTd7cWPzqIfROxfjM/cVfsfgO7bVYhyMzwcyH/Blo0vk8Kt5DQgbeYN10XSm
	 mOl3UTyaiv7/Oc5UHbnd948WgT3wXfb/P6occIo70fUqGrg3cZ/tZubzzlJpl1eBK2
	 ZlLnwnHZ4Hzvop7BEJlxABXARQU9jmESmTFDzHVMnATnxBAFJSKiAHbOmsCP7ggfmE
	 nGpQuQeE38Y0UluWNBPtl7eRMdra/nzWCqQlWKp3aeHaoAV3OkWPD4AVOvm3fY3etZ
	 B3hJVyRnnR7zpGZXkCH4wbk9wt+stKwNOSrDokc9Zx/wFVk3PeIFf40517/MOEw6Mo
	 JUXHbV5IH3l3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72637810CE;
	Tue,  3 Nov 2026 13:04:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BF84C411
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:55:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B0BEB405C6
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:55:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id l4Sh81g7zZ8b for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 08:55:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9958B405AD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793696134;
 b=qX/nuEhL2lNlI1/1+qCOjGD9yiGXE1TLyWeXAUSaBJBI7+kB4p9mY7pnAQYDaci9CNAg
 +sEER4bTW4Gjwofw7iyFZAC/vrVAEwof1bseGwl+6z5qNBHAk28eHddBboPS1q2JnEkrO
 RGFuY7UxeAgoX//l/apX9brqi0f8Lywd5srX4uC8Qmn7xcMEwoObuwRvUkxKINd0hzzBo
 DiXWcZ+AoSEgcNo/fHlzNSzHAVa/9iEiFTsjJ2hwlhuT9Ik2nQxzMmMi6Um8yWH4nbS5v
 kwFOWhFPNvBXqvRdi8W+uhSh57s26a0UnU3jSwiz1zn5s8fVmpw1sOtCQwzXB7qG2bA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793696134;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 user-agent:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:
 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
 x-ms-exchange-antispam-relay:x-microsoft-antispam:
 x-microsoft-antispam-message-info:x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:Content-ID:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=1UF0PgT4LiQclJrpEEUP2nui9gogkVx47s1HQCF0Ag0=;
 b=DX/ZUlKMa1FqAyZAewni493XPrbTQY8ejOqtkF60Xn9D+6ek3vMgwSentRRbb+pN23Ay
 y8Arx+wLXRsxGfJIOcRgCq5TqF/iNqTHu+n6w1W0CSA4yjSFdKStn3ytabzfJoFjw6vBu
 Gh0nV6uz6J5v1Aj6UypccG+y7tPaV+CFOXgppfflch20genp36gr2MNTBBJLVtFKYVp9o
 xNjKyn4Q5LW4cWqNZZTqYlDgLd7mlYIzwPSGvB6shahrMpuyjRRLE+nqQ15DBoEfO/0i8
 5nzQ4V3NxH8Kz9IKlplGNLLW49pAc2/i/4jRTVEAm4XzejEW/Egc2RBolg73rTl6rNA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=rANu4lpt; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=rANu4lpt
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9958B405AD
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:55:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJTTBUkzF2kn5abDOSy71gnOxih/uzW2ImTgGlXZ8PZtlMaUoi5/fUmzlMzbl3V1oLh0RPv9BrUGp1D32a2ty/VgWyyY/SUszom/uHsMunKlOoeh1XSLq3CLNqptQpkEdLPI/mYrAy+5egSGlYLi8cuXpqtpM2a2s+2V1Wu8YFOLwYTkLztnqI/aR7jwfxQONugLex085zEX6U5WasOhZ7P54J5/7qIASFoagWY8rUjZatG01Bje26QAAqIzG9+hsOCwqS+qJVIQmxH0B9wDyZtp5bqw5MwQ/8BaQzQkrqfKr8bwpXpj3cFbfprNmg8/vp9hZMasTLNUlVpGK4LD0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UF0PgT4LiQclJrpEEUP2nui9gogkVx47s1HQCF0Ag0=;
 b=iVOas2ZS9ouV/ZZjsTU9KqKQePKW0ePSydu5iGROZ6mIDeIpB2ynRSHpbN1h1tbzG++a2zN9R4XGObUBruvB4wSYUYGudGyfeuPsPtqfV7kWcaihyK2BRW+rf7KLOp/N9HIMfOTM041O+hjC/yznjp+alD3QJVE9bBOggkX0cRnovb00cooRj3Epf7+wJyON/yMDbm+EbX2YgU/lIrGrhUTmk/JFcIiMd3RWQ/Z/AWPypIxl9zjqUbKTH1JlwvFPvB6B+E2fB1ZcH48rXewaXwBfopcYMDsNVyr/2IDKozE+0G/Ysn4tf+9G84SimeBRBlyNgMqKkyVdME54keXTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UF0PgT4LiQclJrpEEUP2nui9gogkVx47s1HQCF0Ag0=;
 b=rANu4lptNR+WbuspHDDr3Iq0kbPb2HgHcVmNo1PJl5l3+LoeTnuJWeKAOjYT4e2A93yP+TB9U/840V48DaO3zXbP5rYP+KPfT37WgplzuOolVrhd7WVRDkP6u4rGfb/zH8D/anBBle7nQYQqC2h4BtdGO2nbf0mGOmGPDdWTssDxkVw5GbnAnZLDeMh1v+myhqlS78rWoMvUBrP5M3GUc4XbmChNas+kF2Qe8oBDcocTobyMwgq+SI6zxmADPfMi3G7jHTAE6CgHoF9bxL5gd3tC+Kx1sls6Y5eENEpnB9xNJKiiSsQXQrJPwuZoC/V9VCf82UvhXah4qFI1DQLeAg==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DB8PR10MB3959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:149::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 08:55:27 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 08:55:27 +0000
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: Simon Glass <sjg@chromium.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "ilias.apalodimas@linaro.org"
 <ilias.apalodimas@linaro.org>, "Kiszka, Jan" <jan.kiszka@siemens.com>
Subject: Re: [PATCH 2/3] efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
Thread-Topic: [PATCH 2/3] efi_selftest: add test for EFI_TIMESTAMP_PROTOCOL
Thread-Index: AQHdaHxi4/LvJS2iTUmIiAy4Tr9kRLcXVEQAgAS854A=
Date: Tue, 3 Nov 2026 08:55:27 +0000
Message-ID: <2550fe4beb920c85a9995f454b63bb0d6e4817a5.camel@siemens.com>
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
 <20261030143843.467968-3-felix.moessbauer@siemens.com>
 <CAFLszTgZ7BHpivUBqfrJTJEe99OHJZw6SmzjFa22t9xQRFjsTw@mail.gmail.com>
In-Reply-To: <CAFLszTgZ7BHpivUBqfrJTJEe99OHJZw6SmzjFa22t9xQRFjsTw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10+b1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DB8PR10MB3959:EE_
x-ms-office365-filtering-correlation-id: e407ff4b-cd33-4681-065b-08df398834dd
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|261021135927099003|261021121427099003|4143699003|261009223027099003|261028144727099003|261022105027099003|261026121527099003|261022075727099003|261026140227099003|11063799006|10067099003|18002099003|55112099003|22082099003|261102123227099003|3023799007;
x-microsoft-antispam-message-info: SRyrCXHOBiXYG8Pp+XCYbSpHOPCiSg64oRenGf4coKp2fr26aUTzRS/ofCXbLVWf4CXa2572qlK7rhfsDMqr5F/tlFP+df4AUgAD1RkLdGqLd1U5DlTIjS73masdzp+Ih+iHS7mmrcm+cJJlNHvx6fSz38tSuTDkNMUcPSjrj4UGJ5kl7p9FP4FGUcIT6+fYD4GKW/IAIH5w0Dsy9Z1iWKI0fV5Y03OqfMc5M/TqaiQMh30wCV6Js9Csr9SCnpS7O3UWgVWxfwq3L6N5XqkZvgIvzz0pv7bIthPKOalC57wKTdjIwcINXp0ypdqhIaWx0pIA0a5Ge9UBXMhgwnzBCgmI21rRu8Dgdf6LIQO3IH99B93dzqTQOGVhHPUD7n+CEuS69CXTfF+kF7N75wTAB6zjk2ydjMwGCxUFjomcViIy4IRdR/GoWCxS4XnXXmMLv9mDZqZ2CjEESIqunEfzX6xPb/lojUw5ROLZNIgVHa9x7eD1Sg+LUCXbUs4QxJjHUYTfq2ME7YVh9qi3yzE9txOK8wzMTSqqaKDGbLeFiehu5g3SoJe9FkTqaJPt8ro2tTPucLwATEYxZcq1j8hXqf64r3hS1pcQ6A8gf8BMbWyGOkAbxB66BGO0s6tS+rKpT+fzFgaStV9GtI78rS8Giz8gjyzcomaob0YU+6jjiI5t8Sx5nNZhwzxpVd/VyZ4VkNScgL8gIyO+stAaXdKvfQOkLTTVOkDfS7OnQK/U45E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(261021135927099003)(261021121427099003)(4143699003)(261009223027099003)(261028144727099003)(261022105027099003)(261026121527099003)(261022075727099003)(261026140227099003)(11063799006)(10067099003)(18002099003)(55112099003)(22082099003)(261102123227099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QTg5R1QyQnpONzQzaXZYVi8rL21wUmJIQzBKVndTV253cW5Ka3ZVL2RsRzA0?=
 =?utf-8?B?YkVBaDNTVzF1L0pUdFY0NGdrWEJVS0xHOVEwTC8vUEFTSjlVYmdkbS9LbXJY?=
 =?utf-8?B?ckZwZG9mRFp1Nmo0NjhPK3ZBdzNVOFlUcGthVUVsM2tQYkk1aXdtSzBjNmc3?=
 =?utf-8?B?bXo1NkhnSTlBL1k0dTBTMk5ocGZsM2hXc0crWHhQQ2ZiWHJyOG12dXk1cWJu?=
 =?utf-8?B?ZnRxUnBZOXo0TGcxa0h4NHdndDZHTE1vOTlKQ3kzVTlabEQyU3hNcVFnSWUv?=
 =?utf-8?B?TjQ2Y3AvMnR3Q1JESTg0ZlB4ZmZmUUZxaHNhWG93UDExNnlCa2lWTUlQT1RH?=
 =?utf-8?B?L0lzWm1qUGpLYmZZRUh1bXpTa3YvNnNYcHR4aWg0M2p4MW9la2YyYjRMV3ZT?=
 =?utf-8?B?SXIwZVZsZnU4aG0vZFU0NGJBckVDU1NvWnRnSENHdEdjVW9nVEY0VGovN240?=
 =?utf-8?B?UVJERU1YVVhUV2YyNEpCblpSdEJBSWxVbW5nVU9PTnFHN2FvWGZQMW9iWkdm?=
 =?utf-8?B?VGNNQWJldzNrRm50SDNjMkw5TjVZMVhLVUp6cWRRK3FxNmdSRTNGMW5KaFFl?=
 =?utf-8?B?ckZsZktSMXN3cmEvMVI2K1UzUFJTdTNWc0ZvL3h3UVZNUDBSUHlGMmlibzU3?=
 =?utf-8?B?eHEza2xMSld1UlVlRVhxQkp5b3NrZTdzUGJXNTA0WUVYa3Bvd3lzR3FQU1ZX?=
 =?utf-8?B?V3VuSE0zQm14TzlReTNoZUttTWdhNkd3U1YzZG5yYWJMWDRiSDZScm1aZ3Qz?=
 =?utf-8?B?QldoSmFCVGxpL1RSNlA4dk9oSXpzQUs0WDJYTHBkSmR1Y0EzZzFHSmYzcmFm?=
 =?utf-8?B?M0ZDRnVXM3FlK01tR1dqVWJ3NEwyNzNnMWdudVJjYmFZSm5pTjhUa21abnQ0?=
 =?utf-8?B?azVNdk9YZlRtNXVhOFphYWpVN2ltc2Z2T1ZmeHBDdFZpV01rTlJiUjBxWnZX?=
 =?utf-8?B?Sm5aSTEvYkloakM3RFBoZXZSS3VHeUpzdjVnZXpHclpwcm5kTWtnWFBzdVQ5?=
 =?utf-8?B?WGx4dkFScEgwN0phaytRdXBLeFE5QXhDa2M1Y3lqcDIzcCtrT1V2d0VWZGxa?=
 =?utf-8?B?N2Njek5iN3dWSFdlaXAyYWRMSU9aWWF5bmloOUlJNkR1THRJM2dMeld4R2s2?=
 =?utf-8?B?R1p3b3owYmFyYzJBZ0wrNGRYRk1rZ3VXUndGNVQ0aVprUGhVbzhMK1Bpd01H?=
 =?utf-8?B?N3hYNjhsMXFyeERxQ3JaUUd2MXQ0U2hHd0kwbTlacHR5ejExZTgwd0dkU1RF?=
 =?utf-8?B?Q09RaGVmb1RHbWNLNGI2eVdLNkdicVNUQzBUL0JlUE1raG1GRU5ZSFhNNWk4?=
 =?utf-8?B?UzFEckYrTkRmL2M3YTZIOFY2Q0N1djdkOFh5amFZSU9uZGlqMkk4ODBYY1JS?=
 =?utf-8?B?WVRGc3NzNWdBQWF3ZFE5OXg1TzNkMUNCdm9QaWkvNGFSZ0NReERtaDhRK0Ri?=
 =?utf-8?B?RFlGK0ZSemRXM29RS2tRZkRibzdLbEZubEF1RGFIS0kyWEk5MWN1ZHlVSnFo?=
 =?utf-8?B?akFBajFDOHR1bG1abk1wbDAwaWQwZHh6WWF5ekRXcVkwa0dIWWNGdTk1ZXhG?=
 =?utf-8?B?UUtqNkdEUmpaYWIvSFRucWRBQ0l3d0hwaGJmaXc2ekFZNlpERDE0QjA0US95?=
 =?utf-8?B?dWF0TFdtRzNIbjNaY3lyckhUWnhqcmpaYjRmY1ZqNjM5b2JkT2xKaENwbUtr?=
 =?utf-8?B?RGpMMFVNcjZmUXUrVFBzOEVqR1FtSnZ3dkl4V0lTR2tEVlpjajNCWjN1Q05D?=
 =?utf-8?B?eGdSVTJDWWo4cm9qUHV0cUZwMGlnRVVRd3BxdDhhTEkxRDhXWGpxYXZoa2hl?=
 =?utf-8?B?VDBPaXA0blFyMjRuUWIxNFVyVDJ0K2YxU1BISkV1dHdud3N4UUFWdWh6NGVH?=
 =?utf-8?B?WUJSRis2Ylljbk9NbjdWOFF2RnVta0FxNk5yTllyZVVSK2JnYU9VZWdqN0hM?=
 =?utf-8?B?TjFJS3JpMVVjVi92VUkxM0hRcUdSdDM3RTEyTU5QTW1iQVB3YmtmRHNUZTRj?=
 =?utf-8?B?b1orajYwOTZXQldPbjRJa25QakJwQmZmYklBMjV5QjZFSmhCYlhuZHo1NjY2?=
 =?utf-8?B?eFhEQWtQeXBSYlo5WlM4S3h1QWtEUzN0TUJvK3I0MEdTcXB6Q1BqODVUNTNy?=
 =?utf-8?B?cnVEZ1pyRExuQUpTUjRnbjRxOFBBMUNvbXhTYmhNcG9adGRaMnRwZ1RWZXVC?=
 =?utf-8?B?dWRRbFN5N0xlZ0xjNDZiSEdZanlEUUZoWVhwMndVcGpEZmxiczBJaUFLTCtG?=
 =?utf-8?B?ekpDaGJ3NVRZR3YyWVgybEpNTHNqbTRpOWNRWTdKS1NjOUx6UGlqeDRRNHcz?=
 =?utf-8?B?V0VWZGxKNTcvNTBIUFRZUHVUejNXSEpsSDhGcGVBeUwvcEw4WUt0UT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DEF4E84030B854EA601CD2BFEFB57A2@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e407ff4b-cd33-4681-065b-08df398834dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 08:55:27.5044 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RqSKNPsKT28wObZ/prgaAigVP4gRlpKOy4WrEDyFPCqihadziesfaDNjlX0fwkZ3y9hcMAI0fpQQRFMtmYR+kKEMtcqTSjLTG1fd+gFmWU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3959
X-Mailman-Approved-At: Tue, 03 Nov 2026 13:04:38 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

T24gU2F0LCAyMDI2LTEwLTMxIGF0IDAxOjM0IC0wNzAwLCBTaW1vbiBHbGFzcyB3cm90ZToKPiBI
aSBGZWxpeCwKPiAKPiBPbiAyMDI2LTEwLTMwVDE0OjM4OjQwKzExOjAwLCBGZWxpeCBNb2Vzc2Jh
dWVyCj4gPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+IHdyb3RlOgo+ID4gZWZpX3NlbGZ0
ZXN0OiBhZGQgdGVzdCBmb3IgRUZJX1RJTUVTVEFNUF9QUk9UT0NPTAo+ID4gCj4gPiBNYWtlIHN1
cmUgdGhlIHByb3RvY29sIGlzIHVzYWJsZTogdGhlIGNvdW50ZXIgbXVzdCBhZHZhbmNlIGF0IHJv
dWdobHkKPiA+IHRoZSByZXBvcnRlZCBmcmVxdWVuY3ksIG90aGVyd2lzZSBhcHBsaWNhdGlvbnMg
Z2V0IHdyb25nIHRpbWUKPiA+IG1lYXN1cmVtZW50cy4KPiAKPiBJIGRvbid0IHRoaW5rIHRoZSB0
ZXN0IGNhbiBhY3R1YWxseSBjaGVjayB0aGlzLiBTZWUgYmVsb3cuCj4gCj4gPiBkaWZmIC0tZ2l0
IGEvbGliL2VmaV9zZWxmdGVzdC9lZmlfc2VsZnRlc3RfdGltZXN0YW1wLmMgYi9saWIvZWZpX3Nl
bGZ0ZXN0L2VmaV9zZWxmdGVzdF90aW1lc3RhbXAuYwo+ID4gQEAgLTAsMCArMSw5OSBAQAo+ID4g
Kwl0MCA9IHRzLT5nZXRfdGltZXN0YW1wKCk7Cj4gPiArCXJldCA9IGJvb3R0aW1lLT5zdGFsbCgx
MDAwMCk7Cj4gPiArCWlmIChyZXQgIT0gRUZJX1NVQ0NFU1MpIHsKPiA+ICsJCWVmaV9zdF9lcnJv
cigiU3RhbGwgZmFpbGVkXG4iKTsKPiA+ICsJCXJldHVybiBFRklfU1RfRkFJTFVSRTsKPiA+ICsJ
fQo+ID4gKwl0MSA9IHRzLT5nZXRfdGltZXN0YW1wKCk7Cj4gPiArCj4gPiArCWlmICh0MSA8PSB0
MCkgewo+ID4gKwkJZWZpX3N0X2Vycm9yKCJUaW1lc3RhbXAgZGlkIG5vdCBhZHZhbmNlXG4iKTsK
PiA+ICsJCXJldHVybiBFRklfU1RfRkFJTFVSRTsKPiA+ICsJfQo+ID4gKwkvKiAxMCBtcyBjb3Jy
ZXNwb25kIHRvIGZyZXF1ZW5jeSAvIDEwMCB0aWNrcywgYWxsb3cgNTAgJSBzbGFjayAqLwo+ID4g
KwlleHBlY3RlZCA9IHByb3BzLmZyZXF1ZW5jeSAvIDEwMDsKPiA+ICsJaWYgKHQxIC0gdDAgPCBl
eHBlY3RlZCAvIDIpIHsKPiA+ICsJCWVmaV9zdF9lcnJvcigiVGltZXN0YW1wIGFkdmFuY2VkIHRv
byBzbG93bHlcbiIpOwo+ID4gKwkJcmV0dXJuIEVGSV9TVF9GQUlMVVJFOwo+ID4gKwl9Cj4gCj4g
VGhpcyBjaGVjayBpcyBjaXJjdWxhci4gZWZpX3N0YWxsKCkgc2V0cyAnZW5kX3RpY2sgPSBnZXRf
dGlja3MoKSArCj4gdXNlY190b190aWNrKG1pY3Jvc2Vjb25kcyknIGFuZCBzcGlucyB1bnRpbCBn
ZXRfdGlja3MoKSByZWFjaGVzIGl0LAo+IGFuZCB1c2VjX3RvX3RpY2soKSB1c2VzIGdldF90YmNs
aygpLiBTbyB3aGVuIHN0YWxsKCkgcmV0dXJucywgdGhlCj4gY291bnRlciBoYXMgYWxyZWFkeSBh
ZHZhbmNlZCBieSBhdCBsZWFzdCBmcmVxdWVuY3kgLyAxMDAgdGlja3MsCj4gd2hhdGV2ZXIgdGhl
IHJlYWwgZnJlcXVlbmN5IGlzLiBUaGUgY2hlY2sgY2FuIG9ubHkgZmFpbCBpZgo+IGdldF90aW1l
c3RhbXAoKSBzdG9wcyB1c2luZyBnZXRfdGlja3MoKTsgYSB3cm9uZyBnZXRfdGJjbGsoKSB2YWx1
ZQo+ICh0aGUgY2FzZSB0aGUgY29tbWl0IG1lc3NhZ2UgZGVzY3JpYmVzKSBzdGlsbCBwYXNzZXMu
IFRoZSA1MCUgc2xhY2sKPiBzdWdnZXN0cyB0b2xlcmFuY2UgZm9yIGEgcmVhbC10aW1lIG1lYXN1
cmVtZW50LCBidXQgdGhlcmUgaXNuJ3Qgb25lCj4gaGVyZS4KClJpZ2h0Li4uIHRoYW5rcyBmb3Ig
cG9pbnRpbmcgb3V0LgoKPiAKPiBDaGVja2luZyB0aGUgZnJlcXVlbmN5IG5lZWRzIGFuIGluZGVw
ZW5kZW50IHRpbWUgc291cmNlLCBlLmcuIHRoZQo+IHJ1bnRpbWUgZ2V0X3RpbWUoKSBzZXJ2aWNl
IHdoZW4gQ09ORklHX0VGSV9HRVRfVElNRSBpcyBlbmFibGVkLAo+IG1lYXN1cmluZyBvdmVyIGEg
c2Vjb25kIG9yIHR3bywgdGhvdWdoIHRoYXQgbWFrZXMgdGhlIHRlc3Qgc2xvd2VyLgo+IE90aGVy
d2lzZSwgcGxlYXNlIGNhbiB5b3UgcmV3b3JkIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgdGhlIGNv
bW1lbnQgdG8KPiBjbGFpbSBvbmx5IHRoYXQgdGhlIGNvdW50ZXIgaXMgbW9ub3RvbmljIGFuZCBj
b25zaXN0ZW50IHdpdGggU3RhbGwoKSwKPiBhbmQgZHJvcCB0aGUgc2xhY2ssIHNpbmNlIHN0YWxs
KCkgYWxyZWFkeSBndWFyYW50ZWVzICd0MSAtIHQwID49Cj4gZXhwZWN0ZWQnLiBXaGF0IGRvIHlv
dSB0aGluaz8KCklmIGEgdGVzdCBkdXJhdGlvbiBvZiB+MS4yIHNlY29uZHMgaXMgZmluZSwgSSds
bCBqdXN0IGltcGxlbWVudCB0aGUKY29tcGFyaXNvbiB3aXRoIGdldF90aW1lKCkuIEp1c3QgY2hl
Y2tpbmcgZm9yIG1vbm90b25pY2l0eSBJTUhPIGRvZXMKbm90IG1ha2UgbXVjaCBzZW5zZS4KCj4g
Cj4gVGhlcmUgaXMgYWxzbyBubyB1cHBlciBib3VuZCwgc28gYSByZXBvcnRlZCBmcmVxdWVuY3kg
dGhhdCBpcyBmYXIgdG9vCj4gbG93IHdvdWxkIG5vdCBiZSBjYXVnaHQgZWl0aGVyIHdheS4KClll
cywgYnV0IHdpdGggeW91ciBwcm9wb3NlZCAxcysgdGVzdCB0aGlzIHdvdWxkIGJlIGNvcnJlY3Rs
eSBkZXRlY3RlZC4KCkZlbGl4Cgo+IAo+ID4gCj4gPiBTaWduZWQtb2ZmLWJ5OiBGZWxpeCBNb2Vz
c2JhdWVyIDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPgo+ID4gCj4gPiAgbGliL2VmaV9z
ZWxmdGVzdC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgfCAgMSArCj4gPiAgbGliL2VmaV9zZWxm
dGVzdC9lZmlfc2VsZnRlc3RfdGltZXN0YW1wLmMgfCA5OSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMDAgaW5zZXJ0aW9ucygrKQo+IAo+IFJl
Z2FyZHMsCj4gU2ltb24K
