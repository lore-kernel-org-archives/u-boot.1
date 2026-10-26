Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EDD606A31D
	for <u-boot@archiver.kernel.org>; Mon, 26 Oct 2026 17:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=rCLkelSV;
	dkim=pass (2048-bit key, unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com header.a=rsa-sha256 header.s=selector1 header.b=l0r7o1zI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 203F94083E;
	Mon, 26 Oct 2026 17:35:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZUKaC0gqFgd2; Mon, 26 Oct 2026 17:35:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 94F96407CA
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793036107;
	b=R5n1Wb6hlUWTyk9v6ciAvlKfglqcI8OHrZUzsei2ajHoRs3exf9+tPWb4KtKCoOh9dLy
	 UVAaJgHBOFLBVs3cB9ZEBfgCzkMdDjVeeGuoUmkgO410JVPctrQts9A90lwP5wa8qb7DY
	 1iHk2MgGttnX7lRK+s7Gx+8km5qgLPm+MI7uzkpVmkCDBXlQfwNAEHOND6ZgzeXKfjyVj
	 zeIjdByp5pyRAMTPADibU4i+LUDYx2i2RzjmMpjQaLjBMvcUkhx3gGHTHkPNW7EXLSEuI
	 oaLK2NjvifUy81neGGd+QvBBWso9+NwD9Z8emxD9bFAOehOpZnbiRnolGip5bG8vjiQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793036107;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Thread-Topic:
	 Thread-Index:Date:Message-ID:References:In-Reply-To:Accept-Language:
	 Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:msip_labels:
	 x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-he-o365-outbound:
	 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
	 x-microsoft-antispam:x-microsoft-antispam-message-info:
	 x-forefront-antispam-report:
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
	bh=8igFjCupu4e8Scln1FIMSIo8Z6qKsSbVsHnIUz/HPU4=;
	b=gQcfBUgpvQP/OVTRWhA8hjVzF8GsSYVK/EMObuxSI/3oNBPDtPUKGVm1N0veW2H3eKtQ
	 0z4C9b6Uggjs6mw8QVP+GQNuFYQhGwUiCFcRiBlv6kip7P0sIvm1E/dYAtUxZI3eOqpZA
	 ZwLw/Q9H4kpbNrz55IOat/06ATy3+B0jlLH/RM1/FeTlusuZtEkyTzZcJBxptGP9smQ/Q
	 h96oxGEmALMdDCsnnQGZXEp0WJJYhGCWaAX3TvEu7oXW82nYH1wJRgbsXDbfT6gHD8XGC
	 DCZrcMHGat0w/1U5EdLlG0VVlw1tAQgxry3YiOZjUTasBP2/K0NkdgRAxkXMIyjB1rw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793036107;
	bh=8igFjCupu4e8Scln1FIMSIo8Z6qKsSbVsHnIUz/HPU4=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rCLkelSVXBuisSFrzHt6kpuB4MWFitJ9WJj6vrdX513fuZa4qKHKYKY/9Zrc6t1dO
	 935TluJTFjP18WxdISR9SJEVUPE98yD/0Fe9FrFghhVEFjGthpwFsJ5gJdTJcOwv8h
	 Qv79k2G9aHLYa0bUbH8/TaVQIx4lepfGlP8NCB2U+yG7x7bvIVAnSk2l6JUhn3O/rS
	 cVa4Dl44skI9O/JFt7+JeTLxcKDGsGxjOekTxtQ/7qsntnaxIIWU5OlfCMytC7gOvF
	 PH3GvUFtqrQ8cjFTIChBtgh/Juw1XJdEvfRgmlJYSi5aPFmwVVhVixVOppg94rhZhY
	 yqzj0+OUKv0rg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94F96407CA;
	Mon, 26 Oct 2026 17:35:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ED3F7380
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:55:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id DEB7E60603
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:55:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bIyiZICADamE for <u-boot@lists.u-boot-project.org>;
 Mon, 26 Oct 2026 16:55:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9EA0C605EB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793033716;
 b=EJwFv1NjkiYUPHnxcmHGhKF9KX6ZDd7exrcaL1uQTK6SHsWHbG5K08/B4MoX8A2umcgN
 +VADeOm36uiVxSQdyk4KksaoUAiZmzNeKMzFo57zDp7XVYswZRR5gUUaXX1UOR69JrjBK
 5FdS24vuWRxe/h3fUa4zoVMJhYmgVtNfjpGUZb9b0dFg0qIqehWWch81Tg5iS+R6WkG6x
 TmjpegWpH+TTuHtGk9D16jFN91PCAqe8O++adsTJhUj9/EKAcp3VlmIP9Vq//h92MKner
 VGhvQxkNcX5XbQWtNMLWhUm7K1hlticbxt4TLiOhEorzU1Bd5jPqFFvAnBWfsA6AU+Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793033716;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:x-he-o365-outbound:
 x-ms-exchange-senderadcheck:x-ms-exchange-antispam-relay:
 x-microsoft-antispam:x-microsoft-antispam-message-info:
 x-forefront-antispam-report:
 x-ms-exchange-antispam-messagedata-chunkcount:
 x-ms-exchange-antispam-messagedata-0:Content-Type:
 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-originalarrivaltime:
 X-MS-Exchange-CrossTenant-fromentityheader:
 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
 X-MS-Exchange-CrossTenant-userprincipalname:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=8igFjCupu4e8Scln1FIMSIo8Z6qKsSbVsHnIUz/HPU4=;
 b=UFUGqwWwnwnLkm/nbNUDdA6Az6azcU46CWFJ93mr7Jqnu3nl8PnjpSAx4LU6FcBaOTny
 DzhMrsAYuyJVYp8SXgERPMZ1j6uWxix3KzIdZAxL5emlkDA/Hb3wbtLfUTj5aJChR4LGP
 GlHOt5IW70v72AmVUCeODK0Ok8q2mmSA9QvkEaFs9tXFSqaS0Ew0bbs4xaWZopRm0pciL
 UnM7NZnBXbRlCl0pZeMNEXKeLcbqJbi8o+KpPm1OBbgBHR2//CdRH19ihqX1GN2ijurE/
 rAwVlFpYxXzsnaXfV7vvvnlNucsGVOJvdVi+z6heZYfyl9MYrswCgOmLza0Df2iIuig==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=hitachienergy.com;
 dkim=pass header.d=hitachienergy.com header.i=@hitachienergy.com
 header.a=rsa-sha256 header.s=selector1 header.b=l0r7o1zI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=tomas.alvarez-vanoli@hitachienergy.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=hitachienergy.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=hitachienergy.com header.i=@hitachienergy.com
 header.a=rsa-sha256 header.s=selector1 header.b=l0r7o1zI
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9EA0C605EB
 for <u-boot@lists.u-boot-project.org>; Mon, 26 Oct 2026 16:55:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zg8KSZ1om7Kq4Npd/Ax7Z0MqjGZ4Tn6WyiIONlEbrcsREVK4CkgMxAWPAM7I91lmGpILNbuxdVxjIXNdn7NWQZYL2yFssH0DrsSOsn3YfzhX8LLv4tADiV9Q0CQky4+zIRO9n/d8l8oEjiroFKFoDLpICl5AdKZU6WiKZbbG48JmK7kZF5G4plH7dE6xmkczCE5o5NWKuBQBJHI3lAgCOw0THA+C3TYtZ2Cqjjnc+cpEFgmg7kZBUIqZdySiJqbfNtI40GqSoxe2DoR/eecOcyVPcFKD2rpM0w7ZJW8XnjJgyonOyBBZAeH6AybDdywioOtXZC5RnSN5Nf5h50rfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8igFjCupu4e8Scln1FIMSIo8Z6qKsSbVsHnIUz/HPU4=;
 b=xlFqr3w5wK5yVTFitlzH6BLMPfOkAlpW9jqCBJbwvV3+Ln7ONxSf4EaarsQ4Yexcs4ZQyoKDLFuHReBJsE5APDHYvUpiRAzvtOHIOplkpLquWiCKz2tp+KnKBmITx8k7YYyPhcg+I/fRgVYRFAmXpudF4L6By0oj6Wx+koSFpCGJj3J929ay/f+4Rij5OOrb3hdJH/hDz0kpRYFVJC9nDNtx0sK3OzBUrauZBqvekvPKwXCbs1SLDQhhOsly8hVOLjyfK4tDLfSVuavXc8sDkxZyiIc2r/tmDweSaSAR43ZtKYhMMQkBN+KyaU9ENZB30mYGXeIZU3t4ibjShLLs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hitachienergy.com; dmarc=pass action=none
 header.from=hitachienergy.com; dkim=pass header.d=hitachienergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hitachienergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8igFjCupu4e8Scln1FIMSIo8Z6qKsSbVsHnIUz/HPU4=;
 b=l0r7o1zI+NoX4f2eRF9GbgyT803hJz8Xgdkhp0/x97r+W2IYo27VBMWh2r/1bLge/BJOVlPxVUePibsiz7/CBkhJACGscmkdXst2FwmAHPGv3X5cdsT7F/9iR2fpyZWzAS14j+HgHFFsFwDWI/XSo3OUxf47bncfF4MZP8drJh9t98VlkwIEXGq2/OU+cHcR80P/fnKrHrAIPW4FUKlgpMhMZObENDrEhBLeuDRRkI+7TnDnMiJupd55+Xjg7wJhzz7nARZH81uJZPYBLIVBjxN1zlxDxO07xIizCyQpbWIs7z2QBoQ1l0cn8Vps9Ex3SI4EcBd8qltQO/ovKYxoeQ==
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com (2603:10a6:10:291::22)
 by AS8PR06MB7640.eurprd06.prod.outlook.com (2603:10a6:20b:335::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:55:09 +0000
Received: from DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::f0f5:da:c159:65ab]) by DB9PR06MB7849.eurprd06.prod.outlook.com
 ([fe80::f0f5:da:c159:65ab%7]) with mapi id 15.21.0546.021; Mon, 26 Oct 2026
 16:55:09 +0000
From: Tomas Alvarez Vanoli <tomas.alvarez-vanoli@hitachienergy.com>
To: Bradley Morgan <brads@mainlining.org>, Vincent Jardin <vjardin@free.fr>
CC: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>, Sinan
 Akman <sinan@writeme.com>, Bryan Brattlof <bb@ti.com>, Holger Brunck
 <holger.brunck@hitachienergy.com>
Subject: Re: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Thread-Topic: [GIT PULL] Please pull fsl-qoriq-for-2027-01-rc1
Thread-Index: AQHdYfgxcd8Euf/YrEWQnfd/hXanv7cJoxWAgAXlIwCAAAu0gIAAUmqAgAAKiICAABa0AIAAAhgAgAAA4g6AAAOUAIAAA1fY
Date: Mon, 26 Oct 2026 16:55:09 +0000
Message-ID: <DB9PR06MB78493ACFF21592386826CA93C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
References: <atm8jabAOY-wLeaB@nxa18884-linux-1.ap.freescale.net>
 <C7012F65-D275-4D2D-AE1A-9340A5171FB9@mainlining.org>
 <at8StA3lzLMDbcrR@L30177.local>
 <6C364E68-4927-470F-BEEE-1F9AFF3FDCD0@mainlining.org>
 <20261026142023.GA624796@bill-the-cat>
 <50F741B3-1E13-4B3F-BF87-9DD7C45E1216@mainlining.org>
 <at99iCtY7_bTF85U@l3017728.home>
 <8961F479-747C-46A1-A6AD-DC55A25379B6@mainlining.org>
 <DB9PR06MB78490540DD8519B943F1B688C2612@DB9PR06MB7849.eurprd06.prod.outlook.com>
 <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
In-Reply-To: <9A4733E5-6C6F-41B3-B181-18531264976E@mainlining.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hitachienergy.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR06MB7849:EE_|AS8PR06MB7640:EE_
x-ms-office365-filtering-correlation-id: cc8aaa40-f950-4058-b876-08df3381e51a
x-he-o365-outbound: HEO365Out
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|261026140227099003|38070700021|11063799006|4143699003|56012099006|261022075727099003|261022105027099003|10067099003|261026121527099003|22082099003|18002099003|41080700001;
x-microsoft-antispam-message-info: EIVr9iyM6Pei0ZYBMPmDoT8VQWMYXYAOONNjw0d7OxMxSHY8zU31ddkG3a9tpwVous1j+UxU9jnec844MJ5UdIRHFImUxyFFz70uxQwnGcn5NGnYe8h0lwF25sL8CNMUwJ84tqDS7ZfgxFiJAPrmF/t+6XCneaXKPeX3LqjjbeXTtPR23YG9kzOeMQOmGr26zSUpCZZ5RBNoakg3u/15AQ1K+SxKf+0qOmpmF4bkZNEQn13d8a+HxuuzhutUQ30SwtADXjEGmtXk8ovD+H2QbC+T5mx+V+6S1t3IgmcgXzcMFiIsL2kw66sggrPKKby821VW9blqgTKME9vWeX4Mj5ZhdwQm7nlSgxzvml6AabcViOGbcq2qSpq5Rmg7vfjYmEdr+MQjDsjGKZJ5Qxvs95NBovhlxIOqI1VhpaloaN78bAS3syJsbFzB5QFCldqfrKQy5BN3SVB4blp4uRBQizW8LHXY4pSW0NS4+b8yrSmQQa2HYpcSj2NaTdhV+CPtrpHkZJNZJ6ICMSD0IcP+o+b+b45uzxgmJloYahdTBGdJCjaB44PAXpZrhSsGGUqR7WD+IfEI7Y7OIpD5hAwDr0KUYXpOGO74FliK6jzJ9l4jNcabEH7uE0YWhsbaXOBmIIsuyzWRuA0bj+7fl3A10SJVsi/4WfyC7ECbIWDfA7MluYrh4VpS/o8nj8AL1DCGai0HvOsYhO/eUxEsuEm868IrBTPwioaBWP6WUF3ta7XC23dzFiaFbOx7+QmPHElu
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR06MB7849.eurprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(261026140227099003)(38070700021)(11063799006)(4143699003)(56012099006)(261022075727099003)(261022105027099003)(10067099003)(261026121527099003)(22082099003)(18002099003)(41080700001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?OHeJLFKEALcmwaHTE2kdYNkY0r9gp9vjenLBR7C67jSz0eeubFMb/azoMu?=
 =?iso-8859-1?Q?EABzFl2Vcjwi/t2QkEq6JIBnnQ8fZydAr0ddWeUsLptjtAXGAzNyys75V1?=
 =?iso-8859-1?Q?KGI2FZdlPi7pb950Hsd4sgQGTY3r0F0GhkuKGJs+zdXD43RXNnXAubPdbL?=
 =?iso-8859-1?Q?lVNoTQMAVcMwl5IWeKjX98fRKOCS1eGZLudTwV4FFAkt/e1O3NoRqM91eG?=
 =?iso-8859-1?Q?IcfRLWq5UeTnz+n/+NOnx0VjGuTiIhlWk+WYr4CL62Nhq74ZZIXRj9JTXZ?=
 =?iso-8859-1?Q?aCYiaQdDCVdvZZqbXOxT1eCKBPqjMCW0iFe9rMPbmBcIajyNDq9vSbydOn?=
 =?iso-8859-1?Q?X3rzbyzI7uvzaziTwlpinSjhKS5NozYOGC6Mz+73HTVelKcJ380noSkQTk?=
 =?iso-8859-1?Q?xm+xz7o6WCg+Py1dOKpGYtZkhFMd5ErVBi4Jdij+UJrq953ABXGLo/qYZo?=
 =?iso-8859-1?Q?/P0YJFLOhuSrxB+K9LIDVsxTgO03l0LhhUhbMoiLRe0RYRedgUYEASYGe9?=
 =?iso-8859-1?Q?Ohrw1Ef/W/pPXc1HrfUWAHfCflFI31Ou5Ek3MN7/ElOaDN8nl4GyVU387q?=
 =?iso-8859-1?Q?Hno9+ySPm1V9+6cLPX/s13lw6BJKYOUtIrt5jm9/rOTEozr8GHvNmHHvLO?=
 =?iso-8859-1?Q?UI2Ii+FSOjLIzFTPZRwHS5vr9vycX/sE7FpMXK3zUVxYEU13qsw351uNtQ?=
 =?iso-8859-1?Q?iwt48nrlpbg9tO6FNx4Y1fqQn/SfaX/m6Qn25xgYYTjagUahi7+JVTci3w?=
 =?iso-8859-1?Q?MRKlLZLqlhg8ms5tqeLEIB0DOV2Ihub/f13Qq401wojatU9z7sJ5Ob+yui?=
 =?iso-8859-1?Q?vJDDFJXhsjCZ8K5QswimDSOrWL94KDVXckN3ie27M3Fdov9NyrEE2dk44c?=
 =?iso-8859-1?Q?lANt+n9x4dEOf+zo8Q0/n0f3Usk87kfzBVzFOa0Hw9qCodnWZMlAsOCYBs?=
 =?iso-8859-1?Q?MAs/EyGB4GqGVUDXx7FlGiC31wJnJWNnRvlx6o+voOkdEphwygdnt2Xozd?=
 =?iso-8859-1?Q?ZG5G91Boky4nhtKsblMUGfd57F7gzmPK5zFYJirUCUTGbjxuo0r6Xtvsez?=
 =?iso-8859-1?Q?lAlZfYviRZBaJzLxFRW57fQnLvJqksp0QgXDPDBfnwyNYDEBcY9koNBVho?=
 =?iso-8859-1?Q?rKXY/UdOhIjnOWH9krW77MAMWS6qEY9jLGZ/MSFls+UG95jgFqcQiyyu9u?=
 =?iso-8859-1?Q?SjR2makOBMUu3u2Jb72g1GVvZFnHU6+QEbGRKAi9gyuY7Py9UGJqCTqn67?=
 =?iso-8859-1?Q?2WcFBH1RocMbSGUHBhMhUlhHZBk31dXoxBQ8tBIB0Vo+jwb+x2Kd0miw5n?=
 =?iso-8859-1?Q?NNQcKGmarfVYXZ0XQrcn5nPnpb/BffLKoPr93AD/cNQ0lIcFkmTNjBeM+A?=
 =?iso-8859-1?Q?JgJ92LtCy4g8HNuGSw1Ur5AI8NezCGaw5tAa3bd2EO+PmgOsQOD9ps2kJG?=
 =?iso-8859-1?Q?8u7ymxPlONI86fzrrRNyoe7OqgRp5t1Zte03vEUjBYAkiyfcE0Rcg1MqKv?=
 =?iso-8859-1?Q?p952xy36r7VmzndbOoQNbuvX2mE99vcfZNTYYk2GQO37wN0egArX0+67QT?=
 =?iso-8859-1?Q?FY8lf9AVZ4edI9qK4+uVc4O2VKynF3HyLK07zD/zYLWkdkq35pe0iXhc81?=
 =?iso-8859-1?Q?OVxiPrKNx7670jbCYEw3UBhm0VXUViQvgTafPJFA/ROUBgDT/0MlR9QQq5?=
 =?iso-8859-1?Q?Kzt7C8EeWxU2d6Cpmi1eW6VTnu5NnFkQNRCGt23dTN5guEAUPn9cfO9JDZ?=
 =?iso-8859-1?Q?GkSDeMvYJQkk3z8mFitr3YjWRqXah7evF8L/fjOG1py3oXrG4wreC+e66u?=
 =?iso-8859-1?Q?Mi+YvQZSI1+jzBX09nN7su3coVpVDhN2+PT0fzrJFoIHwNDTFhBh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: hitachienergy.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR06MB7849.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8aaa40-f950-4058-b876-08df3381e51a
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2026 16:55:09.6873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7831e6d9-dc6c-4cd1-9ec6-1dc2b4133195
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eHBwRRtzLiXleiEg52QLzE47FGVqhaoAhND++UG56U7QJyEVc2CU4WIKAITIMDX7jS9Tu7yZx8P/vsK8gGdLmh99XhR7nO69hamGRIJCryU+0yBTONjUBeSHn47yVS02
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR06MB7640
X-Mailman-Approved-At: Mon, 26 Oct 2026 17:34:44 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>>=0A=
>>Hi all,=0A=
>>=0A=
>>Just a data point from a user: we are using U-Boot on a T1040 (QorIQ /=0A=
>>mpc85xx) in a product, and we intend to keep up with mainline as much as=
=0A=
>>we can. We'd appreciate PowerPC support staying in tree, and we're happy=
=0A=
>>to test patches on T1040 hardware and report back.=0A=
>>We run u-boot in 32-bit mode (not sure if it is possible to use 64-bit)=
=0A=
>>and=0A=
>>linux in 64-bit.=0A=
>>I am in the process of bringing it up to our 2025.07 branch and=0A=
>>potentially=0A=
>>mainlining as much as possible. We have some remnants of it under=0A=
>>`board/keymile/kmcent2`.=0A=
>=0A=
>Would T1042D4RDB affect you?=0A=
=0A=
Not directly from what I see in the code, as long as the shared code with=
=0A=
ARCH_T1040 is kept. Sorry for the false alarm, just wanted to report that=
=0A=
there are dozens of us using powerpc :)=0A=
=0A=
>=0A=
>>=0A=
>>If any of the planned removals or cleanups touch T104x/QorIQ code or=0A=
>>boards, please keep me and holger.brunck@hitachienergy.com on Cc.=0A=
>>=0A=
>>Thanks to everyone maintaining this.=0A=
>>=0A=
>>Best regards,=0A=
>>Tomas=0A=
>>=0A=
>=0A=
>--- Thanks!=0A=
=0A=
=0A=
=0A=
=0A=
