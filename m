Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202B5606A326
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=I+ybsEnE;
	dkim=pass (2048-bit key, unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256 header.s=selector2 header.b=jIRGXitY
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E736160822;
	Tue,  3 Nov 2026 13:04:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X8Vx4RhGO0BX; Tue,  3 Nov 2026 13:04:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1FDF5607AE
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793711090;
	b=phe1kP2lV3ygNzFlY0H+NcizY65TYwSbxAGHarRFCCuowEXpLoiLP+7ZMytjZgU9m6v5
	 CGmpuD3m7DUQQidleVBoDlFNztfGE1VWkvwjrGI7FKvaxlYDCumP8YPUg+FSxoxr34+VO
	 a9hVscDBv9Ejg4zh068mKXfeqt3lIpilV5i84pnfJ1/B5oryJWXcrI5JevKvejoY/FSSA
	 0D8RXw33zRI0zElTD01RY3Iu/hxiN6FONjkinXsfq9enehuylq54woAzv8Sozj5Qtzi9A
	 2HtX+iNZB75cTR5GfNOV+uAhCVMyq9eroU7NHQ+tR0KwmTPlQMwYZSUSiEHOpUk4k0g==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793711090;
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
	bh=eCiz+tfyN30ASxI8QvcXu1+fGWbhigYm1QeJJK/Ytcg=;
	b=CNczEYCyqqQDQ66JnxdX2ll6hSxMbm37Hb30/D+WBCIt9kpwBdix/cISB9GxNqMm2ADD
	 JaACEaMgDbdqZ9ruTrAAYDR1yb5c6tO6UdHFxK+LbThZ02KDn16Eozx+C3iGvPc6BzyjK
	 qUQIYg0WUAMOY69Hs/1rNtUAnSvAm5mrd2/yw3NK2r+84rUyShrGUOa/cW4MBmxzuzkSK
	 wrQwp3IOgEBsjwIiDNUljNb9KblR7EVxvtFsVuXk6HaFljtMgej5Mg5uCOrVCBr7i/45O
	 Vzom7Pymh5f3mX7Ae2I2gBdy5VOKzzHRiMRsM1yDfORGC4+wDMGxUUY5ZxrSc+4NRVQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793711090;
	bh=eCiz+tfyN30ASxI8QvcXu1+fGWbhigYm1QeJJK/Ytcg=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I+ybsEnEJenU47IYUryGstzuV8iNiKDwx5AYWcSr5kZ5sUpayZpOvK8wpsL88Izjl
	 CneLfkKc6gWGR94H56K2+iSEnGwb7HFbo/346EydgcQB0bD7WCf56Fp5pvPh/NQjDp
	 B2JbT+6k6GhGlk3up/GqPq8t9JjesgrYzfQKL/e4/irkZzy0ljYVzl9YtkBGPg41kX
	 IRaLo+eMHGUW1CRUgsNxsvGpC4MGEoF3dFEh47uLmDyj5GNa7030PYSwS34vKBvsmn
	 1LQSqrXnVAaKPMB5qTJWmpB4vKJMi2XMQoD4RisCrhWX1RiMD/IlxZ1WbeVMwCz4qH
	 o8JCjMPP8e/5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FDF5607AE;
	Tue,  3 Nov 2026 13:04:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 98D33356
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:56:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A8BD40229
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:56:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ehsg1R_ybrp6 for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 08:56:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C248440080
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793696188;
 b=iIsap7sZPCq4h0RlEQ3Q+XowZQr8+5/4ak/1rNALXkAVoa3HJdsXYMt3UndloP3FmMd0
 Q2encprVFPIbjBZKTS/Ks0y0xzUMl/9G4eqLQfHtyNLFWm5VRxpTYcO+u+CO8cEFC2AuI
 EdQ6K4UtKpRGcI/RSepEcz1oRF+kTlmR5sITuG21446krNGfahvqMBi3mfcSSKFsLvjul
 HKMZEkjBaSQR0SM9WezlcogiN4I7jU7OiEuHaBTMjaVPNpxOo0j0YEQyqPTcVUjDKEAtR
 JBZRq0WIDNhIhdPkQvQ3bwqhrc60aj9DOrF5uWgxpMxoQz0dFnBN2cJHffJCoTHKCWQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793696188;
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
 bh=eCiz+tfyN30ASxI8QvcXu1+fGWbhigYm1QeJJK/Ytcg=;
 b=ZOfpte0w86J1Jm+h9xChdLT0p+enBdn+AGjHSgSzWTLJtlijLNuahZ0cNF+bdu8booKE
 0zN32N9b65MFBUukgQRdvq0udb9dqR09CIPoZeStBG0mXwc0duyefT6w0IjVESlJHNU9y
 sP7epEab13l74XS+gEI0K5t9PsWtyHOVIYSx84rJlsJdeoKB2jCLgiSPSySfZC97b22qv
 xPdjq1tdIgXIY+GW3hpvBDAsCT9QeruugRmFyXHlo1alUdgFCmzr6lt4zigDKGAYY8O1f
 E6AG8sCQ9fyw08ttZGzhBk8yyAkvNwjx1mBwmgB3WCdLw39OXGz2KDj+r5DAB3xLVnw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=siemens.com;
 dkim=pass header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=jIRGXitY; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=felix.moessbauer@siemens.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=siemens.com header.i=@siemens.com header.a=rsa-sha256
 header.s=selector2 header.b=jIRGXitY
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C248440080
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 08:56:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfEO4O3eyWsIO8KStIDeYUAUn8sEcX4GFYVkx5vVhDAJbqyLJi48cBcVEwohe8Bc4YUYq15Z2ucmhjNB5SiOc63OVLMlUaL59HIyJ3KKBLZ1ZcSspk4asRRZP0sDKLELWjVCh0wAWlDZj1ZX8ajeexG2G3g4IVAKJx+S28fRhA9ZoFPmDCzj5SYX/N6DFu+iavC4WPO8//pMrnkI7FZtyU72hT9GPFZnQQX/PYqQr8T1T60w+uSzoeOrRNlKPXXYcFxZyCJDwyBc8bdjF6YBleTZVbBJ3NbPdnYJqkECbdDfgZ10EXNzWMb2NAawTfW5Ckw+VFMEtbnlkByNiKuGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eCiz+tfyN30ASxI8QvcXu1+fGWbhigYm1QeJJK/Ytcg=;
 b=hvmt8+2/MwwpnrVSd4koSRrz9rxjUMnpiWkgZ88qNZ1Fg0ryh9HxBUf+HFne+9c9wtKPQ8u7CuRqPtDV404bGisB5tOtSn/ULOGGdlk2R4+8gdtz74N2JvXLLcXKnlQYpXB6CHv3xSO41HHjRZOWWGy2rjuMtHSKqrnemdCOALB8FH3quAWjlWg9wnXVvjtJYzTh4WyYycTdHJF2P2R+7FnRBxqUpV1U5JH1A6ClMcQCugOR3OaiCkIdPmEDt1pFxsVfchZBJTSrRcJsSzVlHolL8zPOfLxF8D0bF3x5/Qrtb9wsV2PbthySwyLQveFXHqg9gfHvwi6S2n/n4+RxNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eCiz+tfyN30ASxI8QvcXu1+fGWbhigYm1QeJJK/Ytcg=;
 b=jIRGXitYUHMyUlUsz5SVzUBiRuDATqLibqObttxK9xhRkvEj3ZDMuCzS3AT8fP0oxChneHUQ0+yBT7iRCYgkv2Dk7H2nVXwsLBygHYPkE8UlwNX8xXn5SBk7igHk5pATXU2+JjPfaZgVskj/rTGgHK5nTJoZ68nNrxs5akj2OJQ5PQItvKoyic38bxdGpGCNTZOhhyvtVol0It6ZwW2NKA+PmCDsBVyw1ZgwAqQ+GY44uPTuXLk/o7mKunpkcswodSTUddUc4j9He9KJyH9KgnHXQbspF8oSF6oLIDM939Y7wJ/MXGq//5S/84MrkAnvakpSHmAsTWnMd8G5nPCF7Q==
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:17e::10)
 by DB8PR10MB3959.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:149::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 08:56:22 +0000
Received: from AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c]) by AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::c54c:ccd8:ebbf:477c%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 08:56:22 +0000
From: "Moessbauer, Felix" <felix.moessbauer@siemens.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
CC: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 "xypron.glpk@gmx.de" <xypron.glpk@gmx.de>, "Kiszka, Jan"
 <jan.kiszka@siemens.com>
Subject: Re: [PATCH 3/3] doc: uefi: describe EFI_TIMESTAMP_PROTOCOL
Thread-Topic: [PATCH 3/3] doc: uefi: describe EFI_TIMESTAMP_PROTOCOL
Thread-Index: AQHdaHxjgpKLKZaOQ0yzCy51MCkgMrcY9lEAgAMbGoA=
Date: Tue, 3 Nov 2026 08:56:22 +0000
Message-ID: <7a690c39231d83d04aebed1a2491b4431e55bd76.camel@siemens.com>
References: <20261030143843.467968-1-felix.moessbauer@siemens.com>
 <20261030143843.467968-4-felix.moessbauer@siemens.com>
 <CAC_iWj+ORNwMfNvw6KSaeq9YjA=9F34t46A_pE5BMVKoivu-2Q@mail.gmail.com>
In-Reply-To: <CAC_iWj+ORNwMfNvw6KSaeq9YjA=9F34t46A_pE5BMVKoivu-2Q@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.2-10+b1 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR10MB3956:EE_|DB8PR10MB3959:EE_
x-ms-office365-filtering-correlation-id: 26867b39-e3c6-49a0-2380-08df39885591
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|38070700021|56012099006|261021135927099003|261021121427099003|4143699003|261022115727099003|261026121527099003|261022075727099003|11063799006|10067099003|18002099003|55112099003|22082099003|261102123227099003|6133799003|3023799007;
x-microsoft-antispam-message-info: jYPZNCX60M5MVwY2DRySZOlUlw/4qPwLAAxBIMQHtOv+LgJESV24o09p9RzxaJBGkmsG8/1Kd6adWVFulIXnhSOYEhWeQp1+79Tou5x1kXsHQMysiO1ojRsOPmAePGOy/CXKKAHeVyPCfAOvrKoKR6yravNz2IQw7ziOUhDc7iBFsqB1MqChpqhkDQizy+c3liOMo/Jr90kDKeO2DOCAMC0p0a+Tg7hZP1N0bEijwJycpirddqq89BfnkBaauhUI9UANppIUQjH9c0j9J6e0+s6zk7Oy/ix/V1wFmBtxzCJwHVs5kUUaYX9v4kKX3FbLIdQdVpq/kqvEhOEDin1n+hDsuQ6TrO7/If6RMepPHPxkPJ2evGFgGmC90jNmeIAkBtCPUbVk0obDZVoQJHdxgGduL26nthz9VDxyKYe8ZrMy7miLUldskKQQZUTLkTXUgJVouiA0CUGBWfm02SX5TTqhit8PUVuwXXKBkB/mWwBIoOQJ5DdOsHCIg5bNhW/llpmZJ4dN1ywEneSTaaDidEHzNI4LzNSByVPHtSsPJkwxojkZX1K184TeVLQ2Qr5RLeXDYIY0TT2XtbmVMC1yJ/8kfmOly+lTsQonVdLq6XrScixdx39oE5134mVr7LBiOZAto5B1mgo0Am4pM34TZQrm2Rp6WsaAT3g22p6vMZwhoDn03Js6GVYlC76HtzVpzK75PfxGS+d677nSM/rmxmtDaWX73S6inYjHu/GRhTA=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(38070700021)(56012099006)(261021135927099003)(261021121427099003)(4143699003)(261022115727099003)(261026121527099003)(261022075727099003)(11063799006)(10067099003)(18002099003)(55112099003)(22082099003)(261102123227099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ODV4bExDMWtFSW5TV055aSttWWtkamdGT0tjM2l2d1RFWlFLUHJOQkszd0ly?=
 =?utf-8?B?bm9PNVhjVmlXRTcyYTUxcCtIY0lGdHFGZlZ2eEQ5MDJpMlFWOGJuWXVORlc5?=
 =?utf-8?B?WktUandSOFF2cHRjanVjVUNubFRmWVk1R1RKN2EzRWtYVzZvcGFId0dUQk1W?=
 =?utf-8?B?K3BISzVjM1ZGSmVFdGZsR3RNY0FyaDdoZVhuekd4Sm9EZFJ1S2ZmQnAydkE1?=
 =?utf-8?B?a2RtREpKcHZZMVBDMkc2UmsvVVJYNkYwVEtaMERqOGFvSGsvQmFiY3NpZk15?=
 =?utf-8?B?UkhBLys2SjFIeXlER2VuK2psMzZWOWNXMG9GSUtpeEswM2RQdW95czlWZEk1?=
 =?utf-8?B?QnNUTXlBeTNGT3pJbUd3UmpyaDlaM1FxWDJJSnN6MU5TWEx1aDlzbktoTU95?=
 =?utf-8?B?eGNBVCswZzF2U0UzdWk4eWFmUU53OUhoTG9zdGdrVkpNNU1iWFVPZjZPcVRz?=
 =?utf-8?B?OUh2VjUyQjNmVXVJdmRlaXJISUp1blJ6S0hYNWpGUUFpaUN5RU1WU2hLRGdC?=
 =?utf-8?B?SWI4QkE4aXMxRGlabmhCb3E2b3Nodi8rZ2tvTWhNODJJeGtyMW4xbzhaRFVz?=
 =?utf-8?B?TmJMR1ZwSDF1Z2s4dDNFdjFQN0VyakNTTUNPUmF6a1h2cU1KN3JxSUFucHdp?=
 =?utf-8?B?ZmcyREpOMU14VEx6VENPQ2lDT2FlZXg0NTNaZzVQUFNNRlN4dDR2K3paK1Bv?=
 =?utf-8?B?ZHUxZ21weDE0S2xLTSt4b3hCRVJKd2c5ekdxUHRaSmVVQk90RDZjakY3a2hI?=
 =?utf-8?B?VHY3R3hGSzI4U2RzcmtZWlNnMWc2eFdYL0habnJrUTdJeHZYNElQYmF3K0pV?=
 =?utf-8?B?cUtTYXF1dHdLeG1Ha2YvdTZuOUNTQXNxRkI2Zlk3VEcwZFowUnhtUXVHeGc4?=
 =?utf-8?B?bDVZTTlwSnY3TnMwOXNVK2xtUW02cWhNNjljZm0yVHlGbGdWM0ZaRVhrSWNu?=
 =?utf-8?B?dCt5S1dQWVNHaTlCaUxVOENWbDI2b0pwaXNuSXRqYnFScXJlT3Y4YVYySjBT?=
 =?utf-8?B?MHhkTVlVZHVBU2dVVFE0UDN0VmFxVDIxL0VYL2R6aDNYK0VZWnNTRmlua0h6?=
 =?utf-8?B?WWZOTndKODRONSs5bHF6bTEzMUdOL2h1OFhNa2NsU2M3Qk92VW8vMkFxOU9N?=
 =?utf-8?B?TEV5Rm1MNU9TQzgvbHI0ei9NcW84Q05LcW9CV1ZvSE1qRjN1dUUzaDdRUVVv?=
 =?utf-8?B?U0J2UmhGaFpWVkFEVzFib2FTRkR1Tkc2UUw4MFc0K3J1TjlJbEZxRG1KUm9v?=
 =?utf-8?B?OWtIaFVlV05HQlZ3SU80L1JxOXBsOFNpd0pFd0dxT0VIWUtabmtPM284OFg4?=
 =?utf-8?B?WHVYaXFieURKV0JpakYveitxRjlDc0NJYzBWNHZZakx3TFV0bVdzbUJnU0t5?=
 =?utf-8?B?R3dEVDMyQXNhWjByQ2dOS1JBS0RXMlhjczRBVHVqRG45NEhObU5vWWpVN2p1?=
 =?utf-8?B?SFZGWlhEdko2TEZhZ1dCMTZXSXVNY2hhWFVMYWM1cmgxR2dwTllYelpaOGlx?=
 =?utf-8?B?TmlSVjE2eUxaS01CSlY1NXVIZURvRXNoWHV4Zm5NMTFock8xcXJoMGJPbWZ2?=
 =?utf-8?B?aEhPSDFZVFJlbG55YXQvczlwVVhsck85azBqQzhoTGlsMURSbWpYVlFhQlAv?=
 =?utf-8?B?TSttK2F3N1YzcW1rV2ZVZk8ySUoxYzB4ZGNBZFJHRnhhVWM3OUtiUHVHaHM0?=
 =?utf-8?B?VmxSK1pZL3Q5ZHo3Mng4aW41aHlDUG5zNHBKYW1WVGlTbUU5RGMxcHR2dEZs?=
 =?utf-8?B?ZEhTSTRnT1dJcVhoSVcvS0tFenJLaStnblJuOCthNXFUOVhOdUlPQVlyWUJt?=
 =?utf-8?B?RDZKZmRPam92aWJtMmo2cmFoOW1QUTRJM0FZNDFQQ3NOdWNuMGdTY0JaeThh?=
 =?utf-8?B?YkhlaGo1WXo0WHRXVXBTeG0yOU0yNU45OW1UYVpqS2Zhc01NSlg0a0I2OHZT?=
 =?utf-8?B?aTEyaU45SlpmL253R28zVk4xSDEyNzlDNHJ5QXBvdjdJbFRoQ2d5djhJZXFM?=
 =?utf-8?B?NXYyWEtYYUJFeUJIdHZOT0NtMURsWU1ZZXZtQ2kycTRXR0hNRTU5RFU1NzIw?=
 =?utf-8?B?aHJuSDN3Slc5WWxJOHN0Q1pTMjlEaTRPV3c1dWZhakI4YmMyZXprc0ZKQWtq?=
 =?utf-8?B?WElsVmlsNEhLOVJKaFBXTk5MN0ZIdW10OHVQNldZVFNRWGViNkVrUWJhdytB?=
 =?utf-8?B?bmxUMndvcE9BbThId3o4ZnIvUmsxMUt6UzZZZXFNNzZ4Z2Zxd3BvZWcySUJB?=
 =?utf-8?B?QU1nWFNVd0UwYUhwbGFCQmtMUlpEOVNMdXE0VmhCanN6Z29zcmRmcmxrWjVB?=
 =?utf-8?B?OHpGODFIMVcrcUgzcFJmbUtWeVlWT3F2anhHVEpoTGhzVGk1SVRJUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <037E28B92DE6E24289698B8198606635@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7PR10MB3956.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 26867b39-e3c6-49a0-2380-08df39885591
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Nov 2026 08:56:22.3220 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MH1KeZoirdud0bYyuJHDvr7CGHaOUb59ujr7jgBAmt+aPRxYc3JxAfP0HttHU0CLvE+47Huo2uCsKVn3CIQ7oxA+dQcBo6lLBYuJ9xPQfr4=
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

T24gU3VuLCAyMDI2LTExLTAxIGF0IDExOjMwICswMjAwLCBJbGlhcyBBcGFsb2RpbWFzIHdyb3Rl
Ogo+IEhpIEZlbGl4Cj4gCj4gT24gRnJpLCAzMCBPY3QgMjAyNiBhdCAxNjozOCwgRmVsaXggTW9l
c3NiYXVlcgo+IDxmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tPiB3cm90ZToKPiA+IAo+ID4g
TGV0IHVzZXJzIGtub3cgdGhhdCB0aGUgcHJvdG9jb2wgZXhpc3RzIGFuZCBob3cgdG8gZGlzYWJs
ZSBpdC4KPiA+IAo+ID4gU2lnbmVkLW9mZi1ieTogRmVsaXggTW9lc3NiYXVlciA8ZmVsaXgubW9l
c3NiYXVlckBzaWVtZW5zLmNvbT4KPiA+IC0tLQo+ID4gIGRvYy9kZXZlbG9wL3VlZmkvdWVmaS5y
c3QgfCAxMyArKysrKysrKysrKysrCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KykKPiA+IAo+ID4gZGlmZiAtLWdpdCBhL2RvYy9kZXZlbG9wL3VlZmkvdWVmaS5yc3QgYi9kb2Mv
ZGV2ZWxvcC91ZWZpL3VlZmkucnN0Cj4gPiBpbmRleCA5NGRkZjY5MDQ0MC4uN2Q1ZDg5NDMzNjAg
MTAwNjQ0Cj4gPiAtLS0gYS9kb2MvZGV2ZWxvcC91ZWZpL3VlZmkucnN0Cj4gPiArKysgYi9kb2Mv
ZGV2ZWxvcC91ZWZpL3VlZmkucnN0Cj4gPiBAQCAtMTAxNSw2ICsxMDE1LDE5IEBAIFNvIG91ciBm
aW5hbCBmb3JtYXQgb2YgdGhlIEZpbGVQYXRoTGlzdFtdIGlzOjoKPiA+IAo+ID4gICAgICBMb2Fk
ZWQgaW1hZ2UgLSBlbmQgbm9kZSAoMHhmZikgLSBWZW5NZWRpYSAtIGluaXRyZF8xIC0gW2VuZCBu
b2RlICgweDAxKSAtIGluaXRyZF9uIC4uLl0gLSBlbmQgbm9kZSAoMHhmZikKPiA+IAo+ID4gK1Rp
bWVzdGFtcCBwcm90b2NvbAo+ID4gK35+fn5+fn5+fn5+fn5+fn5+fgo+ID4gKwo+ID4gK1RoZSBF
RklfVElNRVNUQU1QX1BST1RPQ09MIGdpdmVzIFVFRkkgYXBwbGljYXRpb25zIGFjY2VzcyB0byBh
IG1vbm90b25pYwo+ID4gK3RpbWVzdGFtcCBjb3VudGVyLCBlLmcuIGZvciBwZXJmb3JtYW5jZSBt
ZWFzdXJlbWVudHMuIEl0IGlzIGVuYWJsZWQgYnkKPiA+ICtkZWZhdWx0IGFuZCBjYW4gYmUgZGlz
YWJsZWQgd2l0aDo6Cj4gPiArCj4gPiArICAgIENPTkZJR19FRklfVElNRVNUQU1QX1BST1RPQ09M
PW4KPiA+ICsKPiA+ICtHZXRUaW1lc3RhbXAoKSByZXR1cm5zIHRoZSB2YWx1ZSBvZiBVLUJvb3Qn
cyB0aWNrIGNvdW50ZXIgKGdldF90aWNrcygpKS4KPiA+ICtHZXRQcm9wZXJ0aWVzKCkgcmVwb3J0
cyB0aGUgdGljayBmcmVxdWVuY3kgKGdldF90YmNsaygpKSBhbmQgYW4gZW5kIHZhbHVlIG9mCj4g
PiArMHhmZmZmZmZmZmZmZmZmZmZmIGFzIFUtQm9vdCBleHRlbmRzIG5hcnJvd2VyIGhhcmR3YXJl
IGNvdW50ZXJzIHRvIDY0IGJpdHMuCj4gCj4gSXQncyB0cnVlIHRoYXQgYWxsIGJvYXJkIGZ1bmN0
aW9ucyByZXR1cm4gYSB1NjQuIEJ1dCBzb21lIG9ubHkgcmV0dXJuCj4gYSAzMmJpdCB2YWx1ZS4g
RS5nIGFzdF90aW1lcl9nZXRfY291bnQoKS4KPiAKPiBJIHRoaW5rIHdlIHNob3VsZCBjbGFyaWZ5
IGhlcmUgdGhhdCB0aGUgcmV0dXJuIHZhbHVlIGRlcGVuZHMgb24gdGhlCj4gYm9hcmQgaW1wbGVt
ZW50YXRpb24sIGJ1dCB0aGUgcmV1dG4gdmFsdWUgaXMgZ3VhcmFudGVlZCB0byBiZSA2NGJpdHMu
CgpBY2shIFdoaWxlIGRvaW5nIHNvLCBJJ2xsIGFsc28gYWRkIGEgY29tbWVudCBhYm91dCB0aGUg
d3JhcC1hcm91bmQKc2l0dWF0aW9uLiBUaGFua3MgZm9yIHRoZSByZXZpZXchCgpGZWxpeAoKPiAK
PiBDaGVlcnMKPiAvSWxpYXMKPiA+ICsKPiA+ICBMaW5rcwo+ID4gIC0tLS0tCj4gPiAKPiA+IC0t
Cj4gPiAyLjU1LjAKPiA+IAo=
