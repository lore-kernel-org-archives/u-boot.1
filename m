Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B09606A322
	for <u-boot@archiver.kernel.org>; Tue, 27 Oct 2026 03:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Ad5YfSzr;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=DO+MwBiu
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3BC2340578;
	Tue, 27 Oct 2026 03:29:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AGrtXYAu9vL0; Tue, 27 Oct 2026 03:29:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 79EF040411
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793071747;
	b=A2RbmjKrw2lVlR+nCgp89en7gEMjZSyhnSHaafpGQDAiHw/qdr1nLN/rbIMfJyFZILom
	 ZdrJ6tcPdFTVid1qX+BsSYHQQNEFzEaSSDuH5CFmm4u5vomAxJuIfRR20Nn+yaal21D4H
	 H5MZkpa6W1+HOxHy1hj7ivIka6QG3OMFnEiJi6JLK1PjC93EAHEL+o77lNntf/78SC087
	 Mrd8h1I8ZkWYxVTyeKOIrkgXBBqmkE3gvH0TYWNQNDjg3YNvZHgR+PJypX1c32thN+idR
	 abzU4iEPu4awJ0a29/BNrXwZGa+nB4eiftj4RTQUGirudQyRr2HRx3dy2i+4lQP4sng==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793071747;
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
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
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
	bh=JNyKajrfhH0Mza1wHMDLU7o5lZmd/RIeHXMQrRvEols=;
	b=LrADrkP0h10lXt18w0i/TQH3RKNt+jIsjvxGpX/CzvZ0cZykzrvy/5ZAGAe2NgXUUh0m
	 A/uIauf54wJ6TPIu/nA3ok1b0td198NY2Axxze8CyagbNSQpqHJVwgHvK+6A/Ar7XqZpb
	 TldPuUc5kwPcUcEcPDr8a/ByKkHXDYrnH7Vok4Ba2s2B0LZeobxMqckTPHWH7H/V/C0YC
	 wZh9Sn0kB7Y1HATX+I8WeimPuNYm+A+ORorW/uGJ2Sq4hhM2QS6CFINeM8tt58QZvDAB/
	 9lNZbYkbOwH+fwG8Bd4CyLrb0yr/CsAmP2XUwsctQl1EK6Ov6DMUekeKSXd2dPLTWkw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793071747;
	bh=JNyKajrfhH0Mza1wHMDLU7o5lZmd/RIeHXMQrRvEols=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ad5YfSzr37EAT8YG73CcMMF0IMuDtrL25/azVJolifI8Q1uv5oL5uYgj5NqVH26nK
	 fk5ataTeDxIF4khKoel5DgGB9npMLZMxMpQmCQyk4YXcy7BGxWeqWHTYPEOiBHLmCA
	 K4Y1Uys+g1aSWLkRm2sQMRgf1SyD4B81ZRp/GQicMr+o8R46vE/E5sisF3aOJWGLvc
	 /SVAT7ggPdtlZ85SX4aOxn4d84O0P24txvpZc1UIVU/W2nysYBG5JbW7uvkgU8XJ0X
	 qMh1cqhio/qt8VgeFFQ3uzZ+N8i7ynAJhIE7lTLnPP+bEKU13wVcc2WepKlGSLrCw7
	 7wVEoExoRmfIw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 79EF040411;
	Tue, 27 Oct 2026 03:29:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B1330356
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 03:29:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A2B734006F
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 03:29:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kiB9ofD-TN4p for <u-boot@lists.u-boot-project.org>;
 Tue, 27 Oct 2026 03:29:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0CFDD40062
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793071744;
 b=IRC93K3ZxLgm3hhdOcFyEUFmzpdGSGkA9fQkViH53UIQZImpYdH/IFEVEtAdEURCQxAT
 JwXkaQ6ZmcFsMaAD5hhKm51pn7kNrW4S9ZQIVQmpZK3S8xcZpgmc5H7qcShrrUV0lR7Xo
 crH4KHu8XSmp4TBB+F3AaNrTiN8NUoxsbYPf/Vt+xGVR/h/0/80iT0m4OBjVgB/ROWmJn
 f6fg660BHzk52ZDR0F4lLrGO/8E/+ZPUhG0nZHju8fhb5IUGCtmTR4+b8CPhneJHzVCNO
 IN1GD6vQCkb6DhQNdifYu8aXA6QU69Le1rXKBTM07fd77Au4F4q78M/2ay1J1mzCgVw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793071744;
 h=X-Comment:Received:X-Spam-Checker-Version:X-Spam-Level:X-Spam-Status:
 Received:DKIM-Signature:Received:Received:From:To:CC:Subject:
 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
 x-ms-office365-filtering-correlation-id:
 x-ms-exchange-atpmessageproperties:x-ms-exchange-senderadcheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Virus-Scanned:
 X-Virus-Status;
 bh=JNyKajrfhH0Mza1wHMDLU7o5lZmd/RIeHXMQrRvEols=;
 b=nC0+uAkAF/lM7Zq7qoKzMcDxdJ0/KkIKaK18itP94eoDGiw/wrvl4Eota8M7tSwdGqUN
 FZMVJvg7kJLBujNZyxojkNIcFGA9Hx2Fg62A4rReLdNASotvjxnAlrBXbRM5ATMXmmh7x
 22vQAV4DoZkffROej4gLdnJ0HpFTQbjSN6ZSlrClr6y5c4MzkWzXPsATI/+2UNvvxe0YS
 GYjL5u1wv5eC6x+DgwW39G4IDb4V1XzrjaFSw0yQtwIixZyPsZjjVTdZ2bk6TcSq7+dbb
 KbrHFdswvasKXryhKk4ID8Dg+ddhHDEFtztu/Fsb80P4pM4bARejtypUN/hGm2hKnIQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=DO+MwBiu; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp2.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=DO+MwBiu
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0CFDD40062
 for <u-boot@lists.u-boot-project.org>; Tue, 27 Oct 2026 03:29:01 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F558840D8; Tue, 27 Oct 2026 04:28:58 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D350883108
 for <u-boot@lists.denx.de>; Tue, 27 Oct 2026 04:28:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yr3ldKKaVYgqZkPObcYFHkiLJVRECtiDqQckrReZW/BOJiIFxMfABIXS7F3NVsNwKiSSVmRCqQsJ2a7LIIMda1KBqedsgYtVcjxHBtby/J8G8c6eaU98pfeZqK3AWgpQ86liZbAQ7nQV7floBdsNqf+co5ZkLe/GfPyQNYCOBHXBXx+1XqLfMpsOx+UssEY/KccBRH2GYF5p5cFvQ6K2ho5yf2G4mxsDk8PmkcFsCcVJqQ8UYUICC0mZcDnNit3kxYz6DIaBKfsZJK+HYB6tmqJ4Kpaosky1WmCf7Giu4y0cwNuujKEfCD2Hyix43RIFUuGC+JGXyHzmTYjvDWaJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JNyKajrfhH0Mza1wHMDLU7o5lZmd/RIeHXMQrRvEols=;
 b=LiT6H0dkmV6X6yqp9cYw5MJ+hoSdh+UsSd6N68z6ln2MQPM1gVijEx0WvtCnufr0hC40/9XnEpQHYJgftkmfmMf//qA7Z+3KJA9MyICpFhvQgCBOWGraSlR+N2ITKtkIrqJnmAnqYorp/1nyHsmVKuus8LJY4bW6lwuNI2cOTcRAjBOAWpbQV8gYsD06mlplNJNv4kltUCCSqLnYbXCi4FLvbFGkhoeXVMePJGJ+GsPc5v7A5D3Kdpta54cLggMxrlmaIMBQvVTDvtAUU5vgoxILvc6Y7mjyxPM/4c+t73qGyYXk5cWq8wNNkbrqBh/v7asNV7JF0xvqYNdHbhItZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JNyKajrfhH0Mza1wHMDLU7o5lZmd/RIeHXMQrRvEols=;
 b=DO+MwBiuhJguO8jvxJcS1jkj1SoRFrSpw+nyeUxSq7iGWIEMVzG9gW7MDqwtEFWzaqPjHD5/vqhEWUPZ/QbFj7iP61Z415wquxjPD/Ggy+EcsPu7atRr4gkHJCAgzV+8iRvJm4A+Briv7AHem6ienbpzZ0RyxfBhpCEwS7FLzVloYv3wgoEl4a2l/LyIUXqk/tDQ+M1x16jE6jWL0t2rgH9BiOxpQDUsONU6wXTbBFbNbjvrznNIseH0wzYfseBT5Qe2NgAewtTb1l+OqM6aU44jAlXEBEhyf5uqDYk0Br4lvalec0152nbmz5GqDHDO4STz2FALhB+ElM8mCqv3fQ==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DS0PR03MB182899.namprd03.prod.outlook.com (2603:10b6:8:4eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 03:28:47 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0522.013; Tue, 27 Oct 2026
 03:28:46 +0000
From: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Peng Fan <peng.fan@nxp.com>, David Lechner
 <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>, Will <btdai@terasic.com.cn>, "Teoh,
 Shi Lin" <shi.lin.teoh@altera.com>
Subject: RE: [PATCH] arm: dts: socfpga: Add Terasic DE-25 Standard Board
 Support
Thread-Topic: [PATCH] arm: dts: socfpga: Add Terasic DE-25 Standard Board
 Support
Thread-Index: AQHdH8/VgudXmWPh906hU2wqqF9cWLb8AI8AgBVFwqA=
Date: Tue, 27 Oct 2026 03:28:46 +0000
Message-ID: <PH7PR03MB7063ED09D25C3DB523439C5BAD602@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20260730030205.25260-1-alif.zakuan.yuslaimi@altera.com>
 <ee230408-175f-4683-b498-998affadeda9@altera.com>
In-Reply-To: <ee230408-175f-4683-b498-998affadeda9@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-10-27T03:26:36.0000000Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|DS0PR03MB182899:EE_
x-ms-office365-filtering-correlation-id: 2d25d3bb-cd45-4f10-ff94-08df33da68d2
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|7416014|376014|261009223027099003|261022105027099003|261022113327099003|261021123027099003|261021121427099003|10067099003|56012099006|261026121527099003|3023799007|22082099003|55112099003|18002099003|4143699003|11063799006|261026140227099003|38070700021;
x-microsoft-antispam-message-info: veIie7hwGlOQYVBrUCpBFgkGvy4c7FSd3R7iG1fpYz9BgzEMN3w9mb/3kRNNez/CfQfQPVojys3XqTGReq9TkCMM1LTWNthb79JoVnrDcwrYiVCYh/mEdvem+Uii598/p67mFClhZXo/WsOr/GtvyF1fbK4r6+xrMTN9DEBJFUwrUvZNJy8ZL1+Zv2cCLEPtdk1pA7J2pGypk9CZKHC33sjCCqcaWj1PGsyB5TrQ6+NOBJl9+4IIPcSSg9ENOWwmrTsHuNCwagx2QII2IhRwsbcMHYUo35HuMXLUyTOiaodBVfFkUx9e85CzBUAOrphLIW+UdqbCyPsY3zoqtVgf35KqG+10helDow9S/JnrsB3Hcdz7jbI9DIYsj/hwQdGjLxfUVJU5pR2e7J1o+R6Ci5yRErJJNX+onHCm6Uv9oVirkr1nKaisU7OD3gSVBvFD4eitKlYtMGtWl8XIGr25uR01fZfaHs3bGEL4cybAAPQPMOpGcGZzFj9zVYUW1FNA2DToLcylvKwOm7Kktv8dxG4EadaSnH2mHq8uVXLPOqK4HWOMD23Us3cQ10fJj0s3c+612f2byd/2n+svxOg4zSCSEkZzOVkMtesHzUMef6HmJndVvOGwskzc3/f2N0nR0lhQeoKDwsXwQ3ztCWmKsv5m41HvWjOwjJAqIFi+Scw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(7416014)(376014)(261009223027099003)(261022105027099003)(261022113327099003)(261021123027099003)(261021121427099003)(10067099003)(56012099006)(261026121527099003)(3023799007)(22082099003)(55112099003)(18002099003)(4143699003)(11063799006)(261026140227099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTZLVVBQY1ptRW5xak5iajNtNGRvTGZHL3lQbXhwZ0RGdDcwUnNpU1RlNEla?=
 =?utf-8?B?OUlULytoS2o0SXl1VGM2dEpxY2ZJSXBhcnM1UHBLbDB2VDVKVlZUNDJBTlh5?=
 =?utf-8?B?UlpyVXlUTlVUbWM5YmlJc00zWVpiMHpncTdNWnAydS9JWGxSek53UkI4a3JE?=
 =?utf-8?B?RVBWMUZNTDN5N3BxM3VSeEY5R1pyTGVYWWtqbmZZZG0wOGRZdStlallBTFlr?=
 =?utf-8?B?VCthZ1pnZytEdXFVc3JrU2RraThTMnBROUpPTEplWlBRcVFPVzNGTkJ3WUFj?=
 =?utf-8?B?WC9PZFlHNmFiWDlDQ2E4VXl4eWJwRVpHVDNvMldlVkZXLzJ0cXptMW1wMkRC?=
 =?utf-8?B?V1UvTGg2Z20vRnFTUXB2bEdRaG1YRjNuWGFoRkMwU1NTNnJLdGVEQ3NjbU5P?=
 =?utf-8?B?OXloZmVRNGExYnNTMnBFUUdSNmJoeXRwaEQycGI1bm5aR1VqR3FNTnVEcmVu?=
 =?utf-8?B?bW5wZUhsWGVTUWUxQ0xtNStrQ0t0cGZNdkUvbXV1QXZVbUNHeWJFN2NJVkdK?=
 =?utf-8?B?ck43dXNWRVByVzNaNTY0VVdyZm1rNkZaT1pYTklacVRVb3N0bXZNTHBHdE9y?=
 =?utf-8?B?Zy94R1NCejlQTnd2dExrOGY0MlphVlprVmdqNnJwMGVOejZyUVY3TnFkRFFI?=
 =?utf-8?B?ZitTRnVCczhXWVVyUWNkU09tMGVkRU85S0hUQ0tSSlJvN0x6NlFiWnl2RkE1?=
 =?utf-8?B?RjR2MEtYbXpPU3Y3K1JkM2NSSTVOSU05WVgyTTljRjZlRjVib3BmL0plcGtH?=
 =?utf-8?B?b2VUaDNHVHpXSDdsZHB5ZGo2MVdJemNNaG81NVVodFZvNjE4TnU3L2VtemRs?=
 =?utf-8?B?N0xpallZandORlZ0Ymc2clpDS29ydTlqeTByUmVaQU1uOEIyRzBtUTEzYlow?=
 =?utf-8?B?STlScEtmWEV5RE5yU0RLZVRiWWVpK05SSUdDYmhjTW0ySDBEakRsNUxOTm9J?=
 =?utf-8?B?VG9GaTVpR3RYSGlaTlhjbFUwMThrcjhWaE5iRmdFSHVIdTF5Ujg5eGxrMWhC?=
 =?utf-8?B?eXhRLzhIUk8zaEtleFpnRTlRTUZ3Ym9iZFVyU1dCQkxLY29OWWFscFRpb3ps?=
 =?utf-8?B?RmkyMDhzQTlwaDVWVE4zVnBtN0JSRzBiRXhNSzh5ejkzOEhhc2tPQW1Zc2tj?=
 =?utf-8?B?TEp4dkJXbWMrR2xCK3cxTW9IZHVMM0VPUVRId2VVWVRRTGdhV2RMaHBnVDVU?=
 =?utf-8?B?WEl1a2x2em44c2J1QlVzOWgyYmFtcWFwTGU3d2UxY2JFQXBVcUdGVGlpUlpj?=
 =?utf-8?B?QU90dXZ5YTVlZGFkdk5oVFpmNlBMdTl2dDFVbFUrQVdnQ25ONTNGZmVDSFJo?=
 =?utf-8?B?Lzc3TE9Na2d2ODB3SlBsTi9CdlcvQ1k2ek01Z2RacEpGWFFTelQ3Z1hoaWxj?=
 =?utf-8?B?clVYMWdBRHoySm8xMmc3ekJyNUNzWU1UdFZRNmF6cEFmV3dhNVJlK1ZkYUdl?=
 =?utf-8?B?YlZGd0N0dW5ReFhBZmd3dHI1TDR0ZUNHUDRlU1JjaG5pa1lvTXh1dFV6YVhu?=
 =?utf-8?B?TldzWE1CcndScFdRWldrUWVMVkZ6R3g2T2Rpb1ZaUVQyZVJjSkN1cTBWdG5i?=
 =?utf-8?B?TUZMYzhyZmZ3QTV2NkNCM0w1a2FCYmU1eEU2TzV4NVVCTWZjNUNFVERFSDV3?=
 =?utf-8?B?K08xak5OeFBzdGoybVpibGFFbGg0OFVtanE2VzNpTDNSL0FPWWdaZzVRMVlL?=
 =?utf-8?B?M1lzNVpOL2RlU1dQV3BWZ1ZRRFA4enFucnZjU21idE84S0M3SVdtRDBHc2Vo?=
 =?utf-8?B?UkVFQzFTV0xtNjJUaDFCYWIyNTdmUG9QUlFTZGdzMkRvK2ZvMWZ0QVpna2Jq?=
 =?utf-8?B?V3VZZ09CbEx3WnIrMVVGb0hRTVFyYzFWTGJLaGk1a1hSdEg4WVI2VTlPb3Uw?=
 =?utf-8?B?Vm8za0xVU21WMDFrRTNWZks2bENwM2cyd2Noam4rbXpCWFJDWnhERllURVg4?=
 =?utf-8?B?RDB1ZTdvTmgrS2UydjYzV3phUXNQRmlYSlV6RXhmeDZSeGoybW5qOWUxbWxS?=
 =?utf-8?B?Y2RhK2txQWVGNis4T2ZGWVdDR1QxYks2cENTVFFTQkxYRDV4d3RuVjN5OExj?=
 =?utf-8?B?VHBiVk8rOVRwcWFJQmJTZnArV3RIb01MS3piUElzYlRIaW80ZmV1NHQrREp6?=
 =?utf-8?B?Y0VvY3lDM0h4U3FYS2ZSRzVTLzNtS09hbXR6Q1I3QkhMZVUrd1ZnWEpuckRq?=
 =?utf-8?B?SVZDRUxhQTR3bVpiaEppREowSDh2SDE3NXNra1FIdGhBTVNvWW5ad2JZcUJ2?=
 =?utf-8?B?M0hxRTR1MjI1MStwYmY5SURGKzZGQTd2Zm9PbVMwQWl2OWZDeUY3VGptZ0tu?=
 =?utf-8?B?NklNTU4vNUxJOW9lU1ZFVjVVbE9NMzhRcXJ4dCtWVE9vcmhkbWtpQjBWVnFQ?=
 =?utf-8?Q?WLf8Hu1zJil5zb5k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d25d3bb-cd45-4f10-ff94-08df33da68d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2026 03:28:46.4164 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r+lNbA7MD75YIsGhbo2a1hkFHEhDj2rIOKzrnBwK+2TGHW4W4b0AgYVtTA/rGHHF3rb5XxUNTPKhmntMsO0x3LjXGn92PZx3qds+B2xeb+M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB182899
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

SGkgVGllbiBGb25nLA0KDQoNCkFsdGVyYSBDb25maWRlbnRpYWwNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogQ2hlZSwgVGllbiBGb25nIDx0aWVuLmZvbmcuY2hlZUBhbHRl
cmEuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEzLCAyMDI2IDEwOjM1IFBNDQo+IFRv
OiBZVVNMQUlNSSwgQUxJRiBaQUtVQU4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGFsdGVyYS5jb20+
OyB1LQ0KPiBib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxr
by5jb20+OyBJbGlhcyBBcGFsb2RpbWFzDQo+IDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+
OyBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT47IFNpbW9uDQo+IEdvbGRzY2htaWR0IDxzaW1v
bi5rLnIuZ29sZHNjaG1pZHRAZ21haWwuY29tPjsgUGVuZyBGYW4NCj4gPHBlbmcuZmFuQG54cC5j
b20+OyBEYXZpZCBMZWNobmVyIDxkbGVjaG5lckBiYXlsaWJyZS5jb20+OyBKb2hhbiBKb25rZXIN
Cj4gPGpieDYyNDRAZ21haWwuY29tPjsgTWFya3VzIFNjaG5laWRlci1QYXJnbWFubiA8bXNwQGJh
eWxpYnJlLmNvbT47DQo+IFdpbGwgPGJ0ZGFpQHRlcmFzaWMuY29tLmNuPjsgVGVvaCwgU2hpIExp
biA8c2hpLmxpbi50ZW9oQGFsdGVyYS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTog
ZHRzOiBzb2NmcGdhOiBBZGQgVGVyYXNpYyBERS0yNSBTdGFuZGFyZCBCb2FyZA0KPiBTdXBwb3J0
DQo+DQo+IEhpIFl1c2xhaW1pLA0KPg0KPiBPbiBUaHUsIDMwIEp1bCAyMDI2IDExOjAyOjA1ICsw
ODAwLCBBbGlmIFpha3VhbiBZdXNsYWltaQ0KPiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAYWx0ZXJh
LmNvbT4gd3JvdGU6DQo+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9zb2NmcGdhX2Fn
aWxleDVfZGUyNXMtdS1ib290LmR0c2kNCj4gPiBiL2FyY2gvYXJtL2R0cy9zb2NmcGdhX2FnaWxl
eDVfZGUyNXMtdS1ib290LmR0c2kNCj4gPiBAQCAtMCwwICs2NSw2IEBADQo+ID4gKyAgICAqLw0K
PiA+ICsNCj4gPiArICAgbWVtb3J5IHsNCj4gPiArICAgICAgICAgICByZWcgPSA8MHgwIDB4ODAw
MDAwMDAgMHgwIDB4NDAwMDAwMDA+Ow0KPg0KPiBIYXJkY29kZWQgMSBHaUIgRFJBTSBkaXZlcmdl
cyBmcm9tIFNvQ0RLL05hbm8gaGFuZG9mZiBwYXR0ZXJuDQo+DQo+IFBsZWFzZSBjaXRlIFRlcmFz
aWMgREUtMjUgU3RhbmRhcmQgRFJBTSBzaXplIGV2aWRlbmNlLCBvciBkcm9wIHRoZSByZWcNCj4g
b3ZlcnJpZGUgaWYgaGFuZG9mZiBhbHdheXMgZmlsbHMgaXQNCj4NCg0KTm90ZWQsIHYyIHdpbGwg
ZHJvcCB0aGUgb3ZlcnJpZGUgYW5kIHJlbHkgb24gaGFuZG9mZiBmb3IgRFJBTSBzaXplIGZvbGxv
d2luZyBERTI1IE5hbm8NCg0KPiA+ICsgICB9Ow0KPiA+ICsNCj4NCj4gWy4uLl0NCj4NCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYWdpbGV4NV9kZTI1cy11LWJvb3QuZHRz
aQ0KPiA+IGIvYXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYWdpbGV4NV9kZTI1cy11LWJvb3QuZHRzaQ0K
PiA+IEBAIC0wLDAgKzE4OCw1IEBADQo+ID4gKyAgIHN0YXR1cyA9ICJva2F5IjsNCj4gPiArICAg
LyogUEhZIGRlbGF5cyBpcyBjb25maWd1cmVkIHZpYSBza2V3IHByb3BlcnRpZXMgKi8NCj4gPiAr
ICAgcGh5LW1vZGUgPSAicmdtaWkiOw0KPiA+ICsgICBwaHktaGFuZGxlID0gPCZlbWFjMF9waHkw
PjsNCj4NCj4gUEhZIG1vZGUgcmdtaWkgdnMgc2libGluZyBOYW5vIHJnbWlpLWlkDQo+DQo+IFBs
ZWFzZSBjaXRlIHRoZSBUZXJhc2ljIExpbnV4IERUIC8gYm9hcmQgbm90ZSBzbyByZXZpZXdlcnMg
ZG8gbm90IHRyZWF0IHRoZQ0KPiBOYW5vIGRlbHRhIGFzIGEgbWlzcw0KDQpJIHdpbGwgc3VibWl0
IHYyIHdpdGggcmdtaWktaWQgZm9sbG93aW5nIEQyNSBOYW5vDQoNCj4NCj4gPiArDQo+DQo+IFsu
Li5dDQo+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0cy9zb2NmcGdhX2FnaWxleDVfZGUy
NXMuZHRzDQo+ID4gYi9hcmNoL2FybS9kdHMvc29jZnBnYV9hZ2lsZXg1X2RlMjVzLmR0cw0KPiA+
IEBAIC0wLDAgKzEsMyBAQA0KPiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogICAgIEdQ
TC0yLjANCj4gPiArLyoNCj4gPiArICogQ29weXJpZ2h0IChDKSAyMDI2IEFsdGVyYSBDb3Jwb3Jh
dGlvbiA8d3d3LmFsdGVyYS5jb20+DQo+DQo+IGNoZWNrcGF0Y2ggTUFJTlRBSU5FUlMgd2Fybmlu
ZyBvbiBuZXcgZmlsZXMNCj4NCj4gUGxlYXNlIG5vIGhhcmQgcmVxdWlyZW1lbnQ7IG9wdGlvbmFs
IE1BSU5UQUlORVJTIEY6IGxpbmVzIGlmIG1hdGNoaW5nIE5hbm8NCj4gc2VyaWVzIGRpc3Bvc2l0
aW9uDQo+DQoNCldpbGwga2VlcCBNQUlOVEFJTkVSUyB1bnRvdWNoZWQgYXMgdGhlIG5ldyBmaWxl
cGF0aHMgYXJlIGFscmVhZHkgY292ZXJlZA0KDQo+IFsuLi5dDQo+DQo+IFNvbGlkIEFnaWxleDUg
Ym9hcmQtYWRkIGFsaWduZWQgd2l0aCBTb0NESyBwYXR0ZXJucy4gQ29uZmlybSBoYXJkY29kZWQg
MQ0KPiBHaUIgRFJBTSB2cyBoYW5kb2ZmIGFuZCBicmllZmx5IGNpdGUgVGVyYXNpYyBMaW51eCBE
VCBmb3IgcmdtaWkgdnMgTmFubyByZ21paS0NCj4gaWQuDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4g
VGllbiBGb25nDQoNClRoYW5rIHlvdSBmb3IgeW91ciB0aW1lIHJldmlld2luZyB0aGlzIHBhdGNo
LiBJIHdpbGwgc3VibWl0IHYyIHRvIGFkZHJlc3MgdGhlIGNvbW1lbnRzLg0KDQpXYXJtIHJlZ2Fy
ZHMsDQpBbGlmDQo=
