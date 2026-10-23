Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F949606A31A
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 03:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Xr5ph0Wo;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=wJ4xIu/G
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 163B5404C8;
	Fri, 23 Oct 2026 03:23:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lm3OFZB42Ny4; Fri, 23 Oct 2026 03:23:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 35EC1404F5
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792725828;
	b=hpejS0ViitRXRpw8HurqUv5wgZ1NDq3qM02lRtx+rAoNMjbsaXatKc7TfyVQEJ/ZVYQ/
	 V5Puuzm7Pj04ik/v9AJw/39QJOtqKxoAMWB1JzZ/mmdQLgiQSz8ZoZj70JP0RfpyvQB0w
	 XVpghMMwKtIZcAMkfVrg6D5kWfWygGG/QCFO4LkIMmgiVZ1vpgYIhJyje6ALo3ie1XQ0s
	 i8xzi8SgPj76NectwGwqukN+PVMu+zMJURhwVMYb05k94ppZ3M4aivV4oUWiGuirCuUN5
	 0XNPIqJp3rOU9Hh2iR6xfGcNRJUUcgiKJhJhTanqBpB0WIFrpABFgaI4LWbUuqpCTfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792725828;
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
	bh=zPE6HlMNLsoBwvL8jC/C6azIEIxk86sEeKlJMyDrrSY=;
	b=gQ7KemfNoUZt1QYiwHRK6JRSSMbumPlPV5kodY5X5ypr3FD4KQ1ChsMClO+5RilcnOSC
	 0HlWFGABteUg8e3E0u0mOzLEnY/F1HeLlIzyQKbU4ro6ewGCkCpBuX1uVb2H16BHZcnU1
	 pPoxFiWtGuo4jRdh31dvqmTmddsuycXuRzK9FaGQEnZLIrGgZnSBlOUiUiayYHp01GL12
	 3JB+hmP+WIiQx3A1DPgV3gwoRhABJMuWckB5tXVFVcO3dWAVJAR7G3SxDa1+RZ4UZ9Fj1
	 5fUBkUpkyuLpRcBUPAjL40KuAKt4siz0bJQbSRfeT6l1d0YOAHAJ528hy7Prk2AML9w==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792725828;
	bh=zPE6HlMNLsoBwvL8jC/C6azIEIxk86sEeKlJMyDrrSY=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xr5ph0Woih2DLO/YIkKTzv5UW3oDHaeaX7Ww9UzV9jMNcItbtLLLIhZ/tULAgdfgV
	 WYPI1OI7zGHuUhcrWBWldVXmAlT/CWfJW/WdJGj20VAFqd+jeNpCFZXgjQ2gAIhuN8
	 4bPYYzq+6Nqnh4pvrlMO2qUiXfkofi6I7i/UFDDWrWYy/3TeGdYTiRaYjerHVYUeqC
	 nq4V/42GZjUnW/WAbNzyNySI98hYH6TRQKIYYnVZqbzI47k/+LnF1EFrv1SMQ8S40c
	 aW9HiMStgAGrcsCBOfzSpVIpb+yAqnDlWV9huCiQLApj1eIJj2aKFvH+cGr1mz4mIu
	 PH1vv8LA9Egcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35EC1404F5;
	Fri, 23 Oct 2026 03:23:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5C2D9356
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:23:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4DE5B6063E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:23:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bHv_pRCGytB5 for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 03:23:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D135C6064E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792725825;
 b=N5WCIlHh2pfDQetIpgeTiPK5wgWrjTzy1nyt8sOXma7kh64FRRzT8Opkfhdf+0zo73qB
 tJmhDh0xaniyI4kOZjhJaECmaJWcf8kbfhXDtKmWn2CEZpTpSCHVKOT3mVswjleN+7vDg
 v+cCiOU6BxVu1imCbyKqDUvebl0zkolo72QHeyfiDCQdHXcQTwITX9kJQjbTsk8Y3AdFW
 bYI0aYjQ3Qvyg9uLD02j/ysNsXPC3/7l9PBVn8Ima0oOyfVlTk1LBSn5N/vhdXHDoBwcK
 SpQeTejNr8GnjxaJuQe+y8MDPsMxG0vUlaY7a540F63m6u1VxJoN2fBy+XmNwB3mDmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792725825;
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
 bh=zPE6HlMNLsoBwvL8jC/C6azIEIxk86sEeKlJMyDrrSY=;
 b=p5tUYmwlXoRTZKeAsDWSJHpSvfcknaYQNMdY1ymK7kCS07N1/LbWzBA2y+dytXJBAIWH
 2aZ5rzAGDjl3TMIRfQIYp/Cthk5kWPVl++7A0oxbFJcr961GHeX/6TFl9aaYvi0tlA9f/
 /WDIgFpgWNCN2qi4CdleUX5J/JvD04nn4USlMGJwHD/OkrddFV7FfQcYICysKqpp/mKMW
 oug37K2DQS+YLgm3VP6eK+ryidAU6/zGPsO/s1i9nhSAqZzp4aIsbbkk1sLGMiqGoT+66
 X88xKyw4r4cyIMQD/TLpd8FGGtXyOKq1x2wpze1Pp2D8lLnAA0PbZ3XqhAsYuvNenvw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=altera.com;
 spf=fail smtp.mailfrom=altera.com;
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b="wJ4xIu/G"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=wJ4xIu/G
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D135C6064E
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 03:23:41 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12B9F847EC; Fri, 23 Oct 2026 05:23:38 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D9E8404D
 for <u-boot@lists.denx.de>; Fri, 23 Oct 2026 05:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9b8dQIFXleVcI0H5aQUdMhSZPhGYKaXtTuE7/w5ZcnipMO49DEcqbi7b0KcK5qWFgUxvMoFiL44hFwgq09HV4uhSZm2mgcq0RyzBCGmsREC3za3Tc8rbhBuGU9zeD16A8N20ixdhJaWTT6walpdSZUL9dMAfM7zy6D90YwRiGl2lyDX1ay2cSukccO6TBu/EONHlkh8CnqeErGmLvMJ/0Wh6ZmpnFcJS1F4icQoLtAoHGpvynV19YxANWX2pDOrDAwS5IEvFjOBU4PR0C5nJxl/eaIlufOwvFiLZU6xrLvgM4yvunhSFf17VXQZiPCHUyyPSa0LFC4rIuT8SWQcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPE6HlMNLsoBwvL8jC/C6azIEIxk86sEeKlJMyDrrSY=;
 b=yPkrExibW2q1YndNkcafJW49q9EWEANLHRiziP9cVjVWVXyyr1DwTYf+5Ctpss7USH0eJhvPBeRdmpOu82JbSvce0yBB5Arec+MiwKJbvXXg0fnDNOoazy/7xMOo1qjo4tII+lg4Uv6/3Y0JUea8qAX4oFe4LcUT8pPV/dNdGXJsKU9bJKNhATDl+zDTo0SALdKl0iVZ0cQFm6rp/doUNWhyQRReK7St0sgzmu5zqsIBlzOyWGO5RtRZsbzLh0jEuJklze/zxFrG5KulU9yNW79a8yDD7HU0k+vMXYQiJ5XCjrmO+u5VnYS83D9UjHXBblkOZTWkWagI1K7uQMYpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPE6HlMNLsoBwvL8jC/C6azIEIxk86sEeKlJMyDrrSY=;
 b=wJ4xIu/GD4IUHFWfb+6QKsIDbZegfZPycNnoZHNsamBTWmikYGvDCqy5Kj8hTwRLeXUT/WHavDo3r7rmFptpHLQgwLkikuefBIDNOf+FS5uEpFiRP83eCoMRIIJFAJM1Nb4d/egi6w/N8PjiDQjOnd5LFe+qvvOeutIKKbLP1ouK0nblVC+0ZnnLooPe2/2N9a7JEDcq/1s/ZpB+RHq6EwF/2d/+OyDYWdvhqNVfBmBu1cKpMR9sBQYUTqhzxsx8faWnd1+1D5zEYlFe32bBREZBDU6ePw8J373Lh11qpZd7j2UDDN3BCQO0ypFQnwpNJGXmk8TJ8bmRriP3pRAx3g==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by SA1PR03MB6548.namprd03.prod.outlook.com (2603:10b6:806:1c7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Fri, 23 Oct
 2026 03:23:24 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0522.013; Fri, 23 Oct 2026
 03:23:23 +0000
From: "YUSLAIMI, ALIF ZAKUAN" <alif.zakuan.yuslaimi@altera.com>
To: "Chee, Tien Fong" <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, Simon Goldschmidt
 <simon.k.r.goldschmidt@gmail.com>, Peng Fan <peng.fan@nxp.com>, David Lechner
 <dlechner@baylibre.com>, Johan Jonker <jbx6244@gmail.com>, Markus
 Schneider-Pargmann <msp@baylibre.com>, Will <btdai@terasic.com.cn>, "Teoh,
 Shi Lin" <shi.lin.teoh@altera.com>
Subject: RE: [PATCH] arm: dts: socfpga: Add Terasic DE-25 Nano Board Support
Thread-Topic: [PATCH] arm: dts: socfpga: Add Terasic DE-25 Nano Board Support
Thread-Index: AQHdHvtU3F9n4v8hRkO4kSJlZ4pxDrb7xPQAgA82yOA=
Date: Fri, 23 Oct 2026 03:23:23 +0000
Message-ID: <PH7PR03MB7063283769B4C116BA414E47AD642@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20260729014057.17982-1-alif.zakuan.yuslaimi@altera.com>
 <971c24cf-0332-4438-b7dc-34ad55356ad6@altera.com>
In-Reply-To: <971c24cf-0332-4438-b7dc-34ad55356ad6@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-10-23T03:16:09.0000000Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|SA1PR03MB6548:EE_
x-ms-office365-filtering-correlation-id: 9cfae04b-74d8-45cf-e46d-08df30b4fed8
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|366016|7416014|1800799024|376014|38070700021|261022115727099003|11063799006|261022113327099003|4143699003|56012099006|261021121427099003|261021123027099003|261009223027099003|10067099003|18002099003|22082099003|55112099003|6133799003|261022105027099003|261022075727099003;
x-microsoft-antispam-message-info: lOovvWZWvc2sVy9RpnBwRLSalV3dV2xTH8MdhKkK9VI+LKvdcTQpF4tHv7IFdOFW0rNw7hlt4KkooBi2ZDSCPH8zFb3k/iBRuRE9V0VnsDMaVRTKAuFYnTgPv7R35ZnYixMQNkOeJmFer5FpcGjq8pLp9tBtDZAOwlgepVfWRtPISFvqil1TJocm6Pnh2MTWPZaT8iP+QzOG49iZfaR5MT3sYP5cUoLr6fzts2O8O7yXjCy5r7ANgGL2jXwSSNnZcf8GNAsal+k6SrpR3oiQM3NdwXQbO3nN9actKNmTMsiozwHAuLb0e+EFrH2NIwtM1JDhgFdJ7HZc6q+SBsH4y+x30Ljsb60+Pvn1iDdzaAjifE0N1kbMa+WwR7alrcOU6vxajI7DKqPbKxVecC0hLDVSnxh+boqayaQ0AHQ2bVN+RLML05rjuOJVWwXaySIxULkt1mfUB3NspebKZMz9UhPnfsy0AEGHqZ7pZk4lo9IH69GGrZjGYOgjoMv8x8H46YT6LKiKV0LJ53EeQEWfkMVZHQL9AqF1yCWkQGOCntfqOb0gqvJx+z4rCbpr45Ph0MoSqJ9M4ABFLfRPLwD4YXEYgCQ/ElBlMeCtRk22KeSkpLYWoJk5xBpIvgY25p8J2S3zCx7HExE0tWaD4JcUZrAqYStbSFbc2/qJTgGXNKI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(7416014)(1800799024)(376014)(38070700021)(261022115727099003)(11063799006)(261022113327099003)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(55112099003)(6133799003)(261022105027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MnlNZlFWd3MxTGpndC80WUhLam1wcHNzQkpSdlRFR2NMQWlKTWFkNjlZN00y?=
 =?utf-8?B?eTVma3hqeDNDVGFjMUpFWkkyTGcrZFhDdjVmR0RVMVVnTkNoSlZub3VCNm1W?=
 =?utf-8?B?L0xzOFZEbndhZGNnVG41cnllVkNZN1UrZ2p6dWF1VUZvQ05KSWMvUThvaDB4?=
 =?utf-8?B?M2pTeWdPSU5rc21uYStPQ2daVWJWSmY2NitVR0hJSXQ5WnAvYkxjNGNwUTA3?=
 =?utf-8?B?SGxnNUVuSnZmbklJdXlOWjVsV0V0bnJWMEtXN3VLRmJVR0F1WmduUXpnWitk?=
 =?utf-8?B?MFFwZUFQOEdIZkVCV1BRb01TSUVKdW5KZG51MElPTUhOeSs4TjQzUm5QZ1U0?=
 =?utf-8?B?SjFSNHo5R3FPZ091aVBmQ1ZmaFgzQkQyaTBqdS9WaGUvc05MTEl4YnRsQWdB?=
 =?utf-8?B?dnV5SkJ2MlA0VWV4YytMWGxnbDFqKzM0MWJOalVSajZRRTVYQ0t1UWl0U1Vw?=
 =?utf-8?B?VVgrSkNPQlgreit3VEEwWUtQYldnSzUzd3EyaGhzNmt3Rmd4NTFSRGZYSzFN?=
 =?utf-8?B?RDJkcVg2TzFpcndKWkI5b2ZnMUlSOGhZOGZNMkFEUnA1Zk5ta0hrOU5JNGVm?=
 =?utf-8?B?LzZvVTJKQzhVQmZsN1ppMmNOZ283blJvSjgwaG9oTHFPajkxa0RIcFVrM3pM?=
 =?utf-8?B?VmNHcEpNOFRNTm5IRzFVWlJZelYweWZURkNkRWpxVjJ1NTdUREYyUXJ4b0hW?=
 =?utf-8?B?ek51VHdtZFV1ZEJLcHE0bWRudk1tNWUwL3BzdzdxRkZzb2REVzhPNzd1V3dC?=
 =?utf-8?B?NWs5ejQ4L2VaRmovY0ZsOE9aLzBaWmxUZEdLek1oVy8vWWlHbi8zUjMyRHFZ?=
 =?utf-8?B?U3Vpa3Jsa29LT0YyQWdCemFCWG1rbzF1NnpyWjMrUC9iMmVvc0lpcHF0RHZs?=
 =?utf-8?B?QUhudmoyclRtdTZNajFCYkx3czhrQ2lxd3FROVMyR2JpbEYwL2gyTXdidWlS?=
 =?utf-8?B?cUhYb0Y5V3FHaWhSZmsyRWJyMjMzcEFzRkMxWVNSUnVDOUJHelEzcUYvZU81?=
 =?utf-8?B?NCtFU2l3aEd2emRnZUMrNFlQWnJvdEJicFprU0l4Q2FLQVBRT0NiRWY5NFdT?=
 =?utf-8?B?RlFUUkY0SHFhRkFackdsNGM5RmplQ2FEQkhnMmxpUEFwdWsrWXMrcjhhaU9k?=
 =?utf-8?B?R2ZtUWM3TGJDazB0c0JDTlJzYjlKR0k5Q1NENlAwTkpXaHgrS2hYUTh3K0hK?=
 =?utf-8?B?VGV0a2VodUUyNUVyOVAvYzZJUGcyRm5IdXdheUZkcGt1QWF4UGdVK0tIUFBm?=
 =?utf-8?B?aHdoQjlnRXZFdEFoZUpGWmxkc1ZxNjVxR3RwZHhnZGJhUFlGaDRrSjJtYnVY?=
 =?utf-8?B?ZU54alZ0ZVVEcC9pQ0p5eHlDcmxybXBLSjJQZHlOUVNUbWk5NVArY3pQZ0NJ?=
 =?utf-8?B?b24wOWJHd1ZySDdsODg1ZkZxNWxIS2ZoSFpMNlhQVXp6eDV2N3RWZXVTa2VZ?=
 =?utf-8?B?MGdIVkN1R1hub2N1WlBiMVFFL2NnR294c1hqVFd6dm9FajBYNFExU0tTeXIr?=
 =?utf-8?B?U2h6M00yWU00ekt0eUF0Qk9BQVRFS2x4b1cyak1QK1BrTE9oakRCS2IvWkZk?=
 =?utf-8?B?Y2hWbVBFZW43em9xVTBIL1RDcHNNZS8wcVRzOW1jS2pEb1c2bjJXRGEweTJm?=
 =?utf-8?B?T1BjMHErMnhnMkNTVEgrUDRqcTRldld4S0haWERxZThDRVRxK0UxbTFOUTA4?=
 =?utf-8?B?Qmh2dXIzditaR0dvZWpSOGpzeVBKZHhiNW9iZ2tXZm5pejQ1YXJzb28rNzZI?=
 =?utf-8?B?dzU1TkM2dXR4aXc3WHlvK1BaVWhJYy94ZmZTMEg4RmZDemdMSGZ6RXVvRUh1?=
 =?utf-8?B?cE9seUFaYWxZcGJTMlZJOUptSHVLRVhLV0pBbGZ3bDRLSEQzSHFpLzhtRVEv?=
 =?utf-8?B?d0JkeWRjQ05kZEUrcnpLNmhJS0xzRURwT2I4WE11anUyOWRJVEh5U1Y1Yy9n?=
 =?utf-8?B?Z3BlRDBoV1haSEJmYzljdlNGUFBtNkVsY0JjUmZOeG9EaklMb2EzbmV3YURL?=
 =?utf-8?B?MEFsZjdwY1hvSU1LbENUa0xZYk1MR2hmWVBtQ29SOHRoRWpKV2lWS0FpdFJ6?=
 =?utf-8?B?b3dMRnNYSUJQUFcyYU0xQWdjbWs5QjZGM3lZeVhmYUlwNDI4YWxPN2tCcUMy?=
 =?utf-8?B?WDJZM01KRDdVTkpEUDAzWEFWSmdHalNmNHNQLy9zWXJGQ3Y2NHVVNXJmNE96?=
 =?utf-8?B?Vk01RE9XR0p4ckNGNTQ3VFl1Ritlek9uMFNGY0MwQ0ZjdWFVckx3bkg0aFhs?=
 =?utf-8?B?R1NUYlBSZUMyQWdkUEtvK2RINmNwQlkwbDZuY29pOVpxYm5PbEl1TUtiMHVs?=
 =?utf-8?B?dnBYYWtYTVZyM1N3bXZqTTFzZU9MRzNRYit0R09xbFBVWVZMMzB3SW41YVJH?=
 =?utf-8?Q?t9AMZwzRf8Nf+wYI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cfae04b-74d8-45cf-e46d-08df30b4fed8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 03:23:23.7132 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RLi85gQTjPI/jGHQpDYKOBjVt3dMKkT/SJtro/gYo6DwfDPXb9J2rbgr3fKY99i6ItQlriadUc3ZPkhieOjaVI4RriCNccFbGQumfPLxPf8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6548
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
cmEuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDEzLCAyMDI2IDY6NTYgUE0NCj4gVG86
IFlVU0xBSU1JLCBBTElGIFpBS1VBTiA8YWxpZi56YWt1YW4ueXVzbGFpbWlAYWx0ZXJhLmNvbT47
IHUtDQo+IGJvb3RAbGlzdHMuZGVueC5kZQ0KPiBDYzogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtv
LmNvbT47IElsaWFzIEFwYWxvZGltYXMNCj4gPGlsaWFzLmFwYWxvZGltYXNAbGluYXJvLm9yZz47
IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPjsgU2ltb24NCj4gR29sZHNjaG1pZHQgPHNpbW9u
Lmsuci5nb2xkc2NobWlkdEBnbWFpbC5jb20+OyBQZW5nIEZhbg0KPiA8cGVuZy5mYW5AbnhwLmNv
bT47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNvbT47IEpvaGFuIEpvbmtlcg0K
PiA8amJ4NjI0NEBnbWFpbC5jb20+OyBNYXJrdXMgU2NobmVpZGVyLVBhcmdtYW5uIDxtc3BAYmF5
bGlicmUuY29tPjsNCj4gV2lsbCA8YnRkYWlAdGVyYXNpYy5jb20uY24+OyBUZW9oLCBTaGkgTGlu
IDxzaGkubGluLnRlb2hAYWx0ZXJhLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gYXJtOiBk
dHM6IHNvY2ZwZ2E6IEFkZCBUZXJhc2ljIERFLTI1IE5hbm8gQm9hcmQNCj4gU3VwcG9ydA0KPg0K
PiBIaSBZdXNsYWltaSwNCj4NCj4gT24gV2VkLCAyOSBKdWwgMjAyNiAwOTo0MDo1NyArMDgwMCwg
QWxpZiBaYWt1YW4gWXVzbGFpbWkNCj4gPGFsaWYuemFrdWFuLnl1c2xhaW1pQGFsdGVyYS5jb20+
IHdyb3RlOg0KPg0KPiA+IEFkZCBkZWRpY2F0ZWQgZGV2aWNlIHRyZWUgc3VwcG9ydCBmb3IgdGhl
IFRlcmFzaWMgREUtMjUgTmFubyBib2FyZCwNCj4gPiB3aGljaCBpcyBiYXNlZCBvbiBBZ2lsZXg1
Lg0KPiA+DQo+ID4gRm9sbG93aW5nIFRlcmFzaWMncyBMaW51eCBkZXZpY2UgdHJlZSBmb3IgREUt
MjUgTmFubyBjb25maWd1cmF0aW9uIGluDQo+ID4gd2hpY2ggVUFSVCBhbmQgTU1DIG1vZGUgZGlm
ZmVycyBmcm9tIEFsdGVyYSBTb0NESyBib2FyZHMgLSBlbmFibGUNCj4gPiBVQVJUMSBpbnN0ZWFk
IG9mIFVBUlRUMCBhbmQgdXNpbmcgU0RSNTAgaW5zdGVhZCBvZiBTRFIxMDQgbW9kZSBmb3INCj4g
PiBNTUMuIFRoZSBkZXZpY2UgdHJlZSBpcyBhbHNvIHR3ZWFrZWQgdG8gZW5hYmxlIHRoZSAxNk1C
IFFTUEkgZmxhc2ggdG8NCj4gPiBzdG9yZSBVLUJvb3QgaW1hZ2UgaW4gYSBzaW5nbGUgcGFydGl0
aW9uIGZvciBRU1BJIGJvb3QuDQo+ID4NCj4gPiBOZXcgZmlsZXMgYWRkZWQ6DQo+ID4gLSBzb2Nm
cGdhX2FnaWxleDVfZGUyNV9uYW5vLmR0czogTWFpbiBkZXZpY2UgdHJlZQ0KPiA+IC0gc29jZnBn
YV9hZ2lsZXg1X2RlMjVfbmFuby11LWJvb3QuZHRzaTogVS1Cb290IHNwZWNpZmljIGFkZGl0aW9u
cw0KPiA+IC0gY29uZmlncy9zb2NmcGdhX2FnaWxleDVfZGUyNV9uYW5vX2RlZmNvbmZpZzogQm9h
cmQgY29uZmlndXJhdGlvbnMNCj4NCj4gQ29tbWl0IG1lc3NhZ2UgdHlwbyBhbmQgU09CIGZvcm1h
dHRpbmcNCj4NCj4gUGxlYXNlIGZpeCBVQVJUMCBzcGVsbGluZzsgcmVtb3ZlIGxlYWRpbmcgc3Bh
Y2VzIG9uIFNPQiBsaW5lczsgdXNlIGZ1bGwgbmFtZQ0KPiBmb3IgVGVyYXNpYyBhdXRob3IgaWYg
YXZhaWxhYmxlDQo+DQoNClRoYW5rcyBmb3IgcG9pbnRpbmcgb3V0IHRoZSB0eXBpbmcgZXJyb3Iu
IEkgd2lsbCBzdWJtaXQgdjIgd2l0aCBjb21taXQgbWVzc2FnZSB1cGRhdGUgYW5kIFdpbGwncyBm
dWxsIG5hbWUgaW4gdGhlIHNpZ24tb2ZmLg0KDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2R0
cy9zb2NmcGdhX2FnaWxleDVfZGUyNV9uYW5vLXUtYm9vdC5kdHNpDQo+ID4gYi9hcmNoL2FybS9k
dHMvc29jZnBnYV9hZ2lsZXg1X2RlMjVfbmFuby11LWJvb3QuZHRzaQ0KPiA+IEBAIC0wLDAgKzcy
LDUgQEANCj4gPiArICAgbWF4LWZyZXF1ZW5jeSA9IDwyMDAwMDAwMDA+Ow0KPiA+ICsgICBzZGhj
aS1jYXBzID0gPDB4MDAwMDAwMDAgMHgwMDAwYzgwMD47DQo+ID4gKyAgIC8qIFNEIGNhcmQgZGVm
YXVsdCBzcGVlZCAoRFMpIGFuZCBVSFMtSSBTRFIxMiBtb2RlIHRpbWluZw0KPiBjb25maWd1cmF0
aW9uICovDQo+ID4gKyAgIGNkbnMscGh5LWRxcy10aW1pbmctZGVsYXktc2QtZHMgPSA8MHgwMDc4
MDAwMD47DQo+ID4gKyAgIGNkbnMscGh5LWdhdGUtbHBiay1jdHJsLWRlbGF5LXNkLWRzID0gPDB4
ODFhNDAwNDA+Ow0KPiA+IFsuLi5dDQo+DQo+IE1NQyBTRFI1MCBzdG9yeSBpbmNvbXBsZXRlIHZz
IGNvbW1pdCB0ZXh0DQo+DQo+IFBsZWFzZSBpZiBTRFI1MCBpcyByZXF1aXJlZCwgZXhwbGljaXRs
eSBlbmFibGUgc2QtdWhzLXNkcjUwICsgbWF0Y2hpbmcNCj4gY2RucyxwaHktKiB0aW1pbmcsIG9y
IGNpdGUgYm9hcmQgYnJpbmctdXAgdGhhdCBIUy1vbmx5IGlzIGVub3VnaA0KPg0KDQpJIHdpbGwg
c3VibWl0IHYyIHdoaWNoIHdpbGwgZW5hYmxlIHNkLXVocy1zZHI1MCB3aXRoIG1hdGNoaW5nIENh
ZGVuY2UgUEhZL2N0cmwgdGltaW5ncywgYW5kIGRyb3AgVUhTL0lPLXZvbHRhZ2UgZGlzYWJsZSBk
ZWZjb25maWdzIHNvIFNEUjUwIGNhbiBiZSBzZWxlY3RlZC4NCg0KPiA+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9kdHMvc29jZnBnYV9hZ2lsZXg1X2RlMjVfbmFuby5kdHMNCj4gPiBiL2FyY2gvYXJt
L2R0cy9zb2NmcGdhX2FnaWxleDVfZGUyNV9uYW5vLmR0cw0KPiA+IEBAIC0wLDAgKzEsNSBAQA0K
PiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogICAgIEdQTC0yLjANCj4gPiArLyoNCj4g
PiArICogQ29weXJpZ2h0IChDKSAyMDI2IEFsdGVyYSBDb3Jwb3JhdGlvbiA8d3d3LmFsdGVyYS5j
b20+ICAqLw0KPiA+ICsjaW5jbHVkZSAic29jZnBnYV9hZ2lsZXg1LmR0c2kiDQo+ID4gWy4uLl0N
Cj4NCj4gTUFJTlRBSU5FUlMgbm90IHVwZGF0ZWQgZm9yIG5ldyBib2FyZCBmaWxlcw0KPg0KPiBQ
bGVhc2UgZXh0ZW5kIGJvYXJkL2ludGVsL2FnaWxleDUtc29jZGsvTUFJTlRBSU5FUlMgd2l0aCBG
OiBsaW5lcyBmb3IgdGhlDQo+IG5ldyBmaWxlcw0KPg0KDQpDb21taXQgMDUxODhmNzNmZGI0ICgi
TUFJTlRBSU5FUlM6IFJlcGxhY2UgQWx0ZXJhL1NvQ0ZQR0EvQWdpbGV4IHdpdGggTjoiKSBhbHJl
YWR5IGNvdmVycyB0aGUgc2NvcGUgb2YgdGhlc2UgbmV3IGZpbGVwYXRocy4NCg0KPiBTUERYIHNw
YWNpbmcgYW5kIGR1cGxpY2F0ZSByZWd1bGF0b3Igbm9kZXMNCj4NCj4gUGxlYXNlIG1hdGNoIFNQ
RFggdG8gc2libGluZyBmaWxlczsga2VlcCBib2FyZC1zcGVjaWZpYyByZWd1bGF0b3IgR1BJTyBv
bmx5IGluDQo+IG9uZSBsYXllciAocHJlZmVyIC11LWJvb3QuZHRzaSBsaWtlIHNvY2RrKQ0KPg0K
DQpJIHdpbGwgc3VibWl0IHYyIHdoaWNoIHdpbGwga2VlcCBTRCByZWd1bGF0b3IgR1BJTyBvbmx5
IGluIHRoZSAtdS1ib290LmR0c2kuDQoNCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL3Nv
Y2ZwZ2FfYWdpbGV4NV9kZTI1X25hbm8uZHRzDQo+ID4gYi9hcmNoL2FybS9kdHMvc29jZnBnYV9h
Z2lsZXg1X2RlMjVfbmFuby5kdHMNCj4gPiBAQCAtMCwwICsxMzgsNSBAQA0KPiA+ICsgICAgICAg
ICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICNzaXplLWNlbGxzID0g
PDE+Ow0KPiA+ICsgICAgICAgICAgIGNvbXBhdGlibGUgPSAibXQyNXF1MDJnIjsNCj4gPiArICAg
ICAgICAgICByZWcgPSA8MD47DQo+ID4gKyAgICAgICAgICAgc3BpLW1heC1mcmVxdWVuY3kgPSA8
MTAwMDAwMDAwPjsNCj4gPiBbLi4uXQ0KPg0KPiBRU1BJIHNpemUgY2xhaW0gdnMgZmxhc2ggY29t
cGF0aWJsZQ0KPg0KPiBQbGVhc2UgYWxpZ24gY29tcGF0aWJsZS9wYXJ0IHNpemUgd2l0aCB0aGUg
Qk9NLCBvciBjbGFyaWZ5IHRoYXQgb25seSBhDQo+IDE2IE1pQiBVLUJvb3QgcGFydGl0aW9uIGlz
IHVzZWQgb24gYSBsYXJnZXIgZGV2aWNlDQo+DQoNCkkgd2lsbCBzdWJtaXQgdjIgd2l0aCBhbGln
bmVkIGNvbXBhdGlibGUvcGFydCBzaXplIHdpdGggdGhlIEJPTS4NCg0KPiA+IGRpZmYgLS1naXQg
YS9jb25maWdzL3NvY2ZwZ2FfYWdpbGV4NV9kZTI1X25hbm9fZGVmY29uZmlnDQo+ID4gYi9jb25m
aWdzL3NvY2ZwZ2FfYWdpbGV4NV9kZTI1X25hbm9fZGVmY29uZmlnDQo+ID4gQEAgLTAsMCArMiw1
IEBADQo+ID4gKw0KPiA+ICtDT05GSUdfREVGQVVMVF9ERVZJQ0VfVFJFRT0ic29jZnBnYV9hZ2ls
ZXg1X2RlMjVfbmFubyINCj4gPiArQ09ORklHX1RBUkdFVF9TT0NGUEdBX0FHSUxFWDVfREUyNV9O
QU5PPXkNCj4gPiArQ09ORklHX01NQ19TUEVFRF9NT0RFX1NFVD15DQo+ID4gKyMgQ09ORklHX0lT
T19QQVJUSVRJT04gaXMgbm90IHNldA0KPiA+IFsuLi5dDQo+DQo+IFVua25vd24gVEFSR0VUX1NP
Q0ZQR0FfQUdJTEVYNV9ERTI1X05BTk8g4oCUIG5vIEtjb25maWcgYm9hcmQNCj4gc2VsZWN0DQo+
DQo+IFBsZWFzZSBlaXRoZXIgZHJvcCBDT05GSUdfVEFSR0VUX1NPQ0ZQR0FfQUdJTEVYNV9ERTI1
X05BTk8gYW5kDQo+IGZvbGxvdyB0aGUgZW1tY19kZWZjb25maWcgaW5jbHVkZSBwYXR0ZXJuLCBv
ciBhZGQgYSBmdWxsIEtjb25maWcgY2hvaWNlICsNCj4gU1lTXyogZGVmYXVsdHMgKGFuZCBNQUlO
VEFJTkXigKYNCj4NCg0KVGhhbmtzIGZvciBwb2ludGluZyB0aGlzIG91dC4gSSB3aWxsIHN1Ym1p
dCB2MiB3aGljaCBkcm9wcyB0aGlzIHVuZGVmaW5lZCBkZWZjb25maWcgYW5kIGZvbGxvdyBlbW1j
X2RlZmNvbmZpZyBpbmNsdWRlIHBhdHRlcm4uDQoNCj4gVXNlZnVsIERFMjUtTmFubyBEVFMgZGVs
dGEgKFVBUlQxLCBNTUMvUVNQSSBwYXJ0aXRpb25zKSBidXQgbm90DQo+IG1lcmdlYWJsZSB1bnRp
bCBib2FyZCBUQVJHRVQvS2NvbmZpZyBwYWNrYWdpbmcgbWF0Y2hlcyBleGlzdGluZyBBZ2lsZXg1
DQo+IHBhdHRlcm5zIChvciB0aGUgYm9ndXMgVEFSR0VUIGxpbmUgaXMgZHJvcHBlZCkuDQo+DQo+
IEJlc3QgcmVnYXJkcywNCj4gVGllbiBGb25nDQoNClRoYW5rcywNCkFsaWYNCg==
