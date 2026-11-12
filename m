Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E0F606A323
	for <u-boot@archiver.kernel.org>; Thu, 12 Nov 2026 05:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IzSlHL7t;
	dkim=pass (2048-bit key, unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=ijC0Ilhf
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E407881659;
	Thu, 12 Nov 2026 05:51:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ODqyfcADVPVr; Thu, 12 Nov 2026 05:51:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8A2748134B
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794462698;
	b=HDmx6ttScglqUrftWaTYMzHrnKZuegXIjSYFHyNhux/iFUrT8402g9UZc7KBAb2Rbsc7
	 oD3R2V+p+0f9BaMEsQtA1n9PtQbJKN0auNkst5OZYkc1NxjTnD/98gr3eGQhGffBT7x7y
	 xFLtN3NuCinr44913syFOOBMl97deR19KUVpYaQbehyMiGyAGVbhDNENJRIe/8jOBH1wZ
	 Z4LVc4gHUKFlgukwLzNM3cq/jiuYHoqibfHRHF+wxh6ltxDBAFXmz971nX4XyIb/w/+Cm
	 +ZAd1egpX+X+ear1RblwJUflZchIsiwefztkHcnIyicI5kClEuzClYQacDiki7wcHzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794462698;
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
	bh=gVxhhrsHrhJaFcuzk4w4fD/LO3+qBkXTlqv/yJYsAtc=;
	b=ss9B7Ep9+dWiM5psvO5SJ+blf7+yGNXmNL/+ellTdrHDZqG+t+Z9BPFBsUVyiryBq20J
	 7UBDxE0xKIqNhqpibZ4OzjaWpUn63aonkiD02RCt9bUGHZUZLkQHjaxCq+UNqC0LKuwn4
	 n1TQ9GNgekRmB0hH1TOT3f2vTIKI0giwSGH22ITMvNhqOLgkWRBDmfeIKmHYy4JQP9agf
	 Q6H8N3KcrUeDf18i7Y6cx4Nor0kepBaZy2s/4HWcx2BM4tsDbXATnBFHvm6+lrxgorT32
	 g9nVvlSl4SxkgPx5hEsoSlu19YMkWKKX/cBtkw6XBHQpdwV0xK7DKzAbaTDHIW5nF8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794462698;
	bh=gVxhhrsHrhJaFcuzk4w4fD/LO3+qBkXTlqv/yJYsAtc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IzSlHL7tmnDj2RnjqZBmRlq62Vl045amPxB4od3MvgoLY0oSShNMQR+6qJJNFAMg5
	 0zMYAxpZVUFBWISfgaS3Izncm82hnY/47/JQk/eRxIZQDYMKo7byt2BSyenUfB2hnt
	 XqXFDJ4dUfxMf2LdDXw4571FaBeKR2kxeIBlBQAM1Ri1Z0XBbVNCAa3j+eXPdKxmAi
	 0pvUwElN/HYNf7xf707CRyL5eUZz52JKaMI0tOVCPxmxaitGKEIU6rBtrtVjtLOtbU
	 MnDaMFgo7ShZ2H7oR28lBqzbMdzl6lptLUwTVBYWYAx/fwL8syzFAHr5Io6ZPtg0DS
	 aClxBtZTjjscg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8A2748134B;
	Thu, 12 Nov 2026 05:51:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 63D692FE
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:51:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5557760887
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:51:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YKNKSMlBomyK for <u-boot@lists.u-boot-project.org>;
 Thu, 12 Nov 2026 05:51:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 31F866085F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=85.214.62.61
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=alif.zakuan.yuslaimi@altera.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; spf=fail smtp.mailfrom=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=ijC0Ilhf
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 31F866085F
 for <u-boot@lists.u-boot-project.org>; Thu, 12 Nov 2026 05:51:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846B484ABE; Thu, 12 Nov 2026 06:51:28 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1AEB184A3A
 for <u-boot@lists.denx.de>; Thu, 12 Nov 2026 06:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alif.zakuan.yuslaimi@altera.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVxhhrsHrhJaFcuzk4w4fD/LO3+qBkXTlqv/yJYsAtc=;
 b=ijC0IlhfUB4k3hyfktsY/cdOWQfVqVSf/Dfq172G9XSloYcCSWL0PNrPkGwc5yaU0mBGolP28LSbUQ7loD9A1agnQ3CbYiutb0ezD6j9uTLl+YILmWmofPBfra7QEuxcNCf8Hdh8nTjCbh0pcGJfwzDlaEsQ99MXwFLCh0bbK0+P8/gx4yarIBLnmdMqrDy0aQoYnaUd37tFGR9jzhULWF+ckS2+HvSz1VzR7hCH6jH6m5c15/pE6t5AkVBfZmJCFLzuB3u8+BQSxC2JTeXAqiwBHb/nFb41ZuTDNF7MaotBfPATKCFhfYfbEmNDbZjhaBKaQwKgvEHuaRha6oifdw==
Received: from PH7PR03MB7063.namprd03.prod.outlook.com (2603:10b6:510:2a4::6)
 by DS3PR03MB989218.namprd03.prod.outlook.com (2603:10b6:8:38f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 05:51:17 +0000
Received: from PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21]) by PH7PR03MB7063.namprd03.prod.outlook.com
 ([fe80::f6cf:4203:1cbc:cd21%4]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 05:51:17 +0000
From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
To: Tien Fong Chee <tien.fong.chee@altera.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Marek Vasut <marek.vasut+socfpga@mailbox.org>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, Peng Fan
 <peng.fan@nxp.com>, Markus Schneider-Pargmann <msp@baylibre.com>, Bitao Dai
 <btdai@terasic.com.cn>
Subject: RE: [PATCH v2] arm: dts: socfpga: Add Terasic DE-25 Standard Board
 Support
Thread-Topic: [PATCH v2] arm: dts: socfpga: Add Terasic DE-25 Standard Board
 Support
Thread-Index: AQHdZnxIZn6E6VG8yUSCt1ASXQwS47col+qAgAFuC+A=
Date: Thu, 12 Nov 2026 05:51:17 +0000
Message-ID: <PH7PR03MB7063C2004ECA599B9DA3ECD4AD702@PH7PR03MB7063.namprd03.prod.outlook.com>
References: <20261028013257.8553-1-alif.zakuan.yuslaimi@altera.com>
 <50fcc808-5845-41f7-a1a1-c22306a47c7c@altera.com>
In-Reply-To: <50fcc808-5845-41f7-a1a1-c22306a47c7c@altera.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Enabled=True;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SiteId=fbd72e03-d4a5-4110-adce-614d51f2077a;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_SetDate=2026-11-12T05:48:38.0000000Z;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Name=Confidential;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_ContentBits=3;
 MSIP_Label_43f0520e-0011-44d3-b6f7-0e705cf4078b_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB7063:EE_|DS3PR03MB989218:EE_
x-ms-office365-filtering-correlation-id: 7d518bb5-abd5-403e-420f-08df4080f80d
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|261009223027099003|55112099003|4143699003|10067099003|11063799006|56012099006|261102123227099003|261028144727099003|261022113327099003|261026121527099003|261022105027099003|261026140227099003|261021121427099003|38070700021;
x-microsoft-antispam-message-info: ZrXgATHApUeQ8H49czDUKVzQhyiqtIZjG4N2WR0NSOdNKnCgUhhkk+9HcgrSJhDOXDMMa1mLLNdVfpWjarCop0B+TU+1tQVhSVOYCz5cMxEft4y6El2I1iLLOcH/ecd9peT1i16fkXFPm8V6fbSVcp9NrP/29/bx10L2SFjjyr/pWP2Iqi2ssSA9VK+ogzt6NEi9di/ePeKu2KZirf32vpY+uKXOsFpHL1jJFAVj9S3WPP4bo2JF28AyU971rvBhtR0Yjf0JPbEUtQilXhWbYFaxZYQQEnFssggzzCZIKyR0aPHJVZvnGsOyyRCGhZtgNFekSSaVanmyq+wbDP+tCKApRSL8bNNi+VRJMxBnMMcTQ5hG9iXgXc46NBN8m/7ayJvO37+AxW1ZSm2/8oG9Dgo2Csz7oUmyVebjEHt0WDwBuLvzcNT+bVIz2mRN1AQ1ypE2uOst7bjzUURDNjzksHlMX7Fbdadji21vJGuU2jJErOKGexavgYY4pAo6hm/cDDOreqXXMfapDs8+sXJe05+Frrd3SDJ9LM/K1Rr8Jn+zQ3RuE29EMWuxMYj/kOwzA6wNEQW591crvRQ6LRufZQt7xHbwmxaV9Jx2uD+iY9p+447z7+OsV5YZQqOaQ5B38kErq3YEpEN4ZYkkpjVHMcpFTwwkOTDW6sKiU8p+OLY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB7063.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(261009223027099003)(55112099003)(4143699003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261028144727099003)(261022113327099003)(261026121527099003)(261022105027099003)(261026140227099003)(261021121427099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YWF2NmRHYnRXQ2M0ZkZCNEtrS09yd3lpbVlWY3JKOWQ2RnNqSVFUdVk0Mk1w?=
 =?utf-8?B?UUJzeGJ4ekMzZDhUcUdJUWVDUXFGRit5VFg1dktWMWphNWphYU4zNnllRWFO?=
 =?utf-8?B?NmhXc0duZHNEOEdXaFlDcG5LVzdyOGpoMG0zK3JzbGZKTzAzckZ3L1prcTdq?=
 =?utf-8?B?dnFWai9zaHF4b0hTUTFMcnFMNW9pVlFHOVN2UHF5YitsTG4wWHZNMFNBRm1r?=
 =?utf-8?B?ZVJiVTBUQmc4bkdVYnkxOUhPVnR2bTB6L1ZmYUdHMWVGanVuQ1VkL21RWnYw?=
 =?utf-8?B?dXZSMkhaQ1JWM2NTMEtva0xYMXdtNk1PYVM1cDFUTUhEKzRlakZ3bXhyWk9P?=
 =?utf-8?B?MTZmbTlkZ0l4UHhOYmVZdUpLK3lBcTZNdkVaVzRQRDZRS0ovN0F3QVVoQ3Rq?=
 =?utf-8?B?eHZ0QzJybzdKNHMyMFVuYzVodHNSY1RwMjE2LzdCcDlRQUdBdjRwNFJBb0h0?=
 =?utf-8?B?ZUpmZmlDYWVNd0dIOGZGVHI0a2xLWTk4ajZwSFczakxqWG9hc3FtYlpjeTlS?=
 =?utf-8?B?MHBKZHhYWHFYcjRXSmFGaCtTTzUvbnk1cTl4TG9RdDRkTlRzZEg4aHJKcCtv?=
 =?utf-8?B?VHJkL0JEL284dHRoRS9pQ3o0bk5QeGpjK2lWaEZvQlQwbUg5cWJPckFEU05n?=
 =?utf-8?B?alpDNGNxcG0zNStZQmljVUZEUWIyTjFaNm1FQ1psQ1M5SzZEd3RJU2xRL3Qv?=
 =?utf-8?B?WEQxczhaR3dMbzNITjJkcnl1Nm9wS0dlZlFSL0hRWXVCYVVFV0RlanYyU3pz?=
 =?utf-8?B?NG5pV0xNTnUwTWRnaFJsUHF0azVuK1pMWms1OVRXU25Rb3FGaWdvTzg5S242?=
 =?utf-8?B?Z3gyQXJUWTNGVW9NUlRWK2xsNG9iaWdTemw1cG5vcUVnUlJmYkFjOHJCWVVh?=
 =?utf-8?B?aTRub2VZU3pBYXgra0Erb0YzNTBvbytpNnBMakc5MHU2YmpCV2pLYWlxZjN2?=
 =?utf-8?B?VXF1MVlBSExJdlk0L3d5T0UxSkxUSXJleitRV1lVRlZBWkxoa2tIRlU3QVRE?=
 =?utf-8?B?b0VyUVRTMWllalJadGppa0pTZFllRGlxNTFmMVpYNldFQ1R6VTRzVGxIajRF?=
 =?utf-8?B?RzNlR3VaQ1RpaWRqM2NEWnlWYzFHYzZXejNFVmF4Q0YrR3dmWkNIN3kvcXZh?=
 =?utf-8?B?Nkx0SUhaa0YvRnlYZjVKd2JERGwvMElkbXFHcFhKWDhEajRWelVJcnU1Uyt0?=
 =?utf-8?B?Q2hJdmR0bjVNUlVMMG0zMWNzQnJFSXgzTHMycGdkTmZXVkU5WDNKQ2xsQUdr?=
 =?utf-8?B?NDFiL3BFRUlqMEVhT3VKSVYzYmc1RW5zTTZOeEFmOXVDWldvYXJJOXMzTUdL?=
 =?utf-8?B?K21jQnJmNmtkNW1CVmYzTjVUMFhoTEpuMk1uOXk1RFBXM2IrYmtPN0tHb3pF?=
 =?utf-8?B?VXpvNk5IdXlSWEdZUkNXSGZuRDU2Qm1QakR2bUNkZFRaa2VYRDI2Y2UrVlMw?=
 =?utf-8?B?QkltaVlBZUUxbFBKNXIwdkhCVWdPbllXR2pLdlhvVkUxVzh0d2RCUW9OQmtL?=
 =?utf-8?B?KzJBYjdkOU91S1dYdE16UTlHOTZHbkh5b2xZUnhSdXQ1QWN0S0ZDeFZPQlFy?=
 =?utf-8?B?UGQ3RHlHTnl4eHRZM081dTRVVXo0MHdnV0NqMmdXWWpUVzVPdEgwdnkzcFVi?=
 =?utf-8?B?L0lWRmViRXhlL2JsRDg5VCtLTzgzZ2dOS0NmMW9aQVhHV3A2U0IxQkNGK1Ny?=
 =?utf-8?B?SHhWZVNVbFpJZDNrSlN2NlF5QnA0aXN3M3E5Y1llMVFqeXJWYk01K0R6eGVE?=
 =?utf-8?B?Wm00a3FYN052UFpHc3VjWS9nbDJpVVNRVkdBTFlnSHI5L0N2N1lZVmZQQUYw?=
 =?utf-8?B?VU5LQ0xFR3pWc0RkcEQzMzlXSXFRdHFtcWZtcWZuUko2c3o3NU43bVp5SDJv?=
 =?utf-8?B?T1RUb2NadHdHdlZpSGVKL0tvRXNXL3pZUmhEcmsra0xZeEZNaGZ1M2Nqb011?=
 =?utf-8?B?djMwY2M2ZEpVR1EwVEQ2M3hGOGZVQ3BtU2dKQkdDSmVjbndEUlVQR2w4eE43?=
 =?utf-8?B?SUhJb2VFQTRKS1l6dHlUemcwQUoydFFWK016YUJYWWVSUExadlQyYzJKcWpu?=
 =?utf-8?B?b1BGcjEvNWVsZmVzeHRxeU53ci8zeG1Tc3JyQ04rUzZQQ2dpQm9TMS9wWlZm?=
 =?utf-8?B?VmpvWWZwdkNFaS9wTk8zbzI0OG1jQ3YxVExkaVFlQlZsWnA5ODd2QW4yMGx0?=
 =?utf-8?B?UEp6QmtYK2x0MFI5ZXVGZUhYRnkyaGkzcm5KM3FyRktpQmdoUVlmTXR0MU9u?=
 =?utf-8?B?T0lZM1BIKzRsd0tPMlovTWQ5WFZPNzdBVjlyVWNpQnI5Y2JCek5Ld015NTlN?=
 =?utf-8?B?aWFNMW1RQ2JONmtuMUx3UUpsU1k1c2FqeWh6a2NGb3NGRnA5clhVV3hDbG1K?=
 =?utf-8?Q?7eD5GpCuSU3wwnx4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB7063.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d518bb5-abd5-403e-420f-08df4080f80d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2026 05:51:17.1376 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6me+irK9qIXwk3lk/RoMqn6dEoAyC4Ws0duLnVbZGyP+RWS3/q9AX5YOmMLqLX2IWCl/9inr+J1bL3kaTP84o/Jl01DADp2Dp7GDhAPyaaY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR03MB989218
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

SGkgVGllbiBGb25nLA0KDQoNCkFsdGVyYSBDb25maWRlbnRpYWwNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogVGllbiBGb25nIENoZWUgPHRpZW4uZm9uZy5jaGVlQGFsdGVy
YS5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMTEsIDIwMjYgMzo1OSBQTQ0KPiBU
bzogQWxpZiBaYWt1YW4gWXVzbGFpbWkgPGFsaWYuemFrdWFuLnl1c2xhaW1pQGFsdGVyYS5jb20+
OyB1LQ0KPiBib290QGxpc3RzLmRlbnguZGUNCj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxr
by5jb20+OyBJbGlhcyBBcGFsb2RpbWFzDQo+IDxpbGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+
OyBNYXJlayBWYXN1dA0KPiA8bWFyZWsudmFzdXQrc29jZnBnYUBtYWlsYm94Lm9yZz47IFNpbW9u
IEdvbGRzY2htaWR0DQo+IDxzaW1vbi5rLnIuZ29sZHNjaG1pZHRAZ21haWwuY29tPjsgUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+OyBNYXJrdXMNCj4gU2NobmVpZGVyLVBhcmdtYW5uIDxtc3BA
YmF5bGlicmUuY29tPjsgQml0YW8gRGFpIDxidGRhaUB0ZXJhc2ljLmNvbS5jbj4NCj4gU3ViamVj
dDogUmU6IFtQQVRDSCB2Ml0gYXJtOiBkdHM6IHNvY2ZwZ2E6IEFkZCBUZXJhc2ljIERFLTI1IFN0
YW5kYXJkIEJvYXJkDQo+IFN1cHBvcnQNCj4NCj4gSGkgWVVTTEFJTUksDQo+DQo+IE9uIFdlZCwg
MjggT2N0IDIwMjYgMDk6MzI6NTcgKzA4MDAsIEFsaWYgWmFrdWFuIFl1c2xhaW1pDQo+IDxhbGlm
Lnpha3Vhbi55dXNsYWltaUBhbHRlcmEuY29tPiB3cm90ZToNCj4NCj4gPiBkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYWdpbGV4NV9kZTI1cy11LWJvb3QuZHRzaQ0KPiA+IGIvYXJj
aC9hcm0vZHRzL3NvY2ZwZ2FfYWdpbGV4NV9kZTI1cy11LWJvb3QuZHRzaQ0KPiA+IEBAIC0wLDAg
KzY3LDUgQEANCj4gPiArICAgY2hvc2VuIHsNCj4gPiArICAgICAgICAgICBzdGRvdXQtcGF0aCA9
ICJzZXJpYWwwOjExNTIwMG44IjsNCj4gPiArICAgICAgICAgICB1LWJvb3Qsc3BsLWJvb3Qtb3Jk
ZXIgPSAmbW1jLCZmbGFzaDAsJm5hbmQsIi9tZW1vcnkiOw0KPg0KPiBUaGUgbmV3IFUtQm9vdCBE
VCBwbGFjZXMgZmxhc2gwIGluIHUtYm9vdCxzcGwtYm9vdC1vcmRlciwgYnV0IHRoZW4gZGlzYWJs
ZXMNCj4gaXRzIHBhcmVudCBxc3BpIG5vZGUg4oCUIHNwbF9ub2RlX3RvX2Jvb3RfZGV2aWNlKCkg
b25seSBtYXBzIHRoZSBmbGFzaCBub2RlDQo+IGFmdGVyIHVjbGFzc19nZXRfZGV2aWNlX2J5X29m
X29mZnNldChVQ0xBU1NfU1BJX0ZMQVNILCAuLi4pIHN1Y2NlZWRzOyB3aXRoDQo+IHFzcGkgZGlz
YWJsZWQsIHRoYXQgZW50cnkgaXMgc2tpcHBlZC4NCj4NCj4gUGxlYXNlIGVpdGhlciBlbmFibGUg
cXNwaSBmb3IgYSBmdW5jdGlvbmFsIFFTUEkgZmFsbGJhY2ssIG9yIHJlbW92ZQ0KPiAmZmxhc2gw
IGZyb20gdS1ib290LHNwbC1ib290LW9yZGVyIGFuZCBkb2N1bWVudCB0aGF0IHRoZSBib2FyZCBp
cw0KPiBpbnRlbnRpb25hbGx5IFNEL01NQy1vbmx5DQo+DQoNClRoZSBUZXJhc2ljIERlMjUgU3Rh
bmRhcmQgZGV2a2l0IGRvZXMgc3VwcG9ydCBRU1BJIGZsYXNoLiBJIHdpbGwgZW5hYmxlIFFTUEkg
Zm9yIHYzIHN1Ym1pc3Npb24uDQoNCj4gPiArICAgfTsNCj4gPiArfTsNCj4NCj4gWy4uLl0NCj4N
Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vZHRzL3NvY2ZwZ2FfYWdpbGV4NV9kZTI1cy5kdHMN
Cj4gPiBiL2FyY2gvYXJtL2R0cy9zb2NmcGdhX2FnaWxleDVfZGUyNXMuZHRzDQo+ID4gQEAgLTAs
MCArMSwzIEBADQo+ID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAgICAgR1BMLTIuMA0K
PiA+ICsvKg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjYgQWx0ZXJhIENvcnBvcmF0aW9uIDx3
d3cuYWx0ZXJhLmNvbT4NCj4NCj4gY2hlY2twYXRjaCByZXBvcnRzIHRoYXQgTUFJTlRBSU5FUlMg
Y292ZXJhZ2UgbWF5IG5lZWQgdXBkYXRpbmcgZm9yIHRoZQ0KPiBuZXcgYm9hcmQgc3VwcG9ydCBm
aWxlcyDigJQgdGhpcyBpcyBhIHJlcG9zaXRvcnktb3duZXJzaGlwL3Byb2Nlc3Mgd2FybmluZywN
Cj4gbm90IGEgZnVuY3Rpb25hbCBkZWZlY3QNCj4NCj4gUGxlYXNlIGFkZCB0aGUgYXBwcm9wcmlh
dGUgREUyNSBib2FyZCBwYXRoIGFuZCBtYWludGFpbmVyIGVudHJ5IGlmIHRoZSBib2FyZA0KPiBo
YXMgYSBkaXN0aW5jdCBtYWludGFpbmVyOyBvdGhlcndpc2UgYWNrbm93bGVkZ2UgdGhlIHdhcm5p
bmcgaW4gdGhlIHNlcmllcw0KPiByZXZpZXcNCj4NCj4gWy4uLl0NCj4NCg0KSSB3aWxsIGFkZCBh
IG5ldyBNQUlOVEFJTkVSUyBmaWxlIHVuZGVyIGEgbmV3IGJvYXJkL3RlcmFzaWMvZGUyNS1zdGFu
ZGFyZCBmb2xkZXIgZm9yIHYzDQoNCj4gT25lIGZ1bmN0aW9uYWwgYm9vdC1vcmRlciBjb250cmFk
aWN0aW9uIHJlcXVpcmVzIGNvcnJlY3Rpb247IGNoZWNrcGF0Y2ggYWxzbw0KPiByZXBvcnRzIGEg
TUFJTlRBSU5FUlMgY292ZXJhZ2Ugd2FybmluZy4NCj4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHRp
bWUNCkFsaWYNCg0KPiBCZXN0IHJlZ2FyZHMsDQo+IFRpZW4gRm9uZw0K
