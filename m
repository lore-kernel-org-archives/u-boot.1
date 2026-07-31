Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FEECC5516D
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 12:42:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A742607E5;
	Fri, 31 Jul 2026 12:42:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YFCq9nrDk6PZ; Fri, 31 Jul 2026 12:42:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5BD5260B42
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785501721;
	bh=qFI1dBCZ8TuDGie7y2M6twF76PSvcTd4NRbp26+91Ew=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gtOChpfnEDSYmH5I/XvWjXZG612Of6NIo2EtfrDvIMlBvbMZWZydCd723HbQ2+ins
	 Hi4nPQCI7bAQawsgciYGcJ5QNqeEIkanLaSI779Ofqz+Dw6SVBAddVhb5E6TxMQvis
	 GLtf9ffCIR11tvEn+uBhk3q5mJYrP+Y1LynNQlOob8HzhHCgV9Qbtwg+tHNy2Mj5ZC
	 AnKvCSk+E1fDW5N7gv4tj7TXJOJGHWDFPCbMvXR+omwHbnE+gtSv9QgFQ05I9wdafO
	 BRgaA8ObfYeMoj88JZZ8grfizgqu2+bwmig9NlHJzXohQw3W+HxIu/WuEVpPAtQ3Xn
	 kTg5l4jjiW/Ow==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5BD5260B42;
	Fri, 31 Jul 2026 12:42:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 91D1827C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7FFC5401EB
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5lczS9PUWQqY for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 10:10:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=pdeiber@lynx.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A2D4F401D2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A2D4F401D2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A2D4F401D2
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 10:10:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B5F484A0B; Fri, 31 Jul 2026 12:10:30 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC053849BC
 for <u-boot@lists.denx.de>; Fri, 31 Jul 2026 12:10:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FJWmbPG/38PjwA3r/7SS/iwDJ0mZDEaiKd67QaPUUpoKAcmRiFG5MXsJ8njbcPAf5dpjZsHEA+6iQIIo8EPZjd2fSJ44QKpXVhrr079XRm7VfSUlr45y3lQQVjUAkbg8cjlsNYl/czAtrYyZnze4l1hQDSNSXjibhe5H39Q1yEwL3RFbUSx+SZdrnsBNcF6lMeNvSrdyIapmanT/wEJKjQHzgiwKmA2ts2xVKB/me5VeOmYOtZSmMbR2qqWtYQ6d8JMkCeDZ5REtY0xNN0I6xd5jzTNeWJjoK47iJ3giP5EjwGag0omwbAL7cX0qfExkGUus0+ck13ISHFJpmkNGfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rpta127tWTKhfIgNkbuQy6Q72vbK9maIxKEdkXg0FC4=;
 b=er1d4E6siMNPbEJxgnfw5Am3qiXj0QMpbtB8z1qGUnkMT73Sf7GTC6dejNtu9HxRWZQcIf4eEADI/TAFrGCC9kwjSaYNfkMYj0F5NQYRK7wt2ayYuqleDetTo5bmfvnklOpyRxtEtY7qVtgYZ6Xxe9VVsEh40oQomHbxaMGmhteO5WGjygBH6RLEwRCf4Gq4nrBZ5zWsZgyNBa7QyiaNuU6TZTo8eEIDyuXsXzUrSb2Hoc/e31weZlrN7SOiifN5585lVCSEg0gZ0jCkqDNrhtddluh/8oxdFK5Ksblsdg48e5GbSSvugP/ZXMtAHtlTP0IkTnHqO0KriGt2PFF6Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lynx.com; dmarc=pass action=none header.from=lynx.com;
 dkim=pass header.d=lynx.com; arc=none
Received: from IA2PR22MB5617.namprd22.prod.outlook.com (2603:10b6:208:4b8::18)
 by SA1PR22MB5635.namprd22.prod.outlook.com (2603:10b6:806:3ea::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 10:10:21 +0000
Received: from IA2PR22MB5617.namprd22.prod.outlook.com
 ([fe80::45ba:781:c68d:65a7]) by IA2PR22MB5617.namprd22.prod.outlook.com
 ([fe80::45ba:781:c68d:65a7%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 10:10:21 +0000
From: Patrick Deiber <pdeiber@lynx.com>
To: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>, Tom Rini
 <trini@konsulko.com>
CC: Quentin Schulz <quentin.schulz@cherry.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re:  Re: Re: Re: Re: Re: [PATCH] arm: Backward compatibility to
 U-Boot v2020.04
Thread-Topic: Re: Re: Re: Re: Re: [PATCH] arm: Backward compatibility to
 U-Boot v2020.04
Thread-Index: AQHcpzRe2+mcoRbah0Kuc/Nv5xoyYbaIIT3ggAA5o/s=
Date: Fri, 31 Jul 2026 10:10:21 +0000
Message-ID: <IA2PR22MB56172034CF2D817EF2BA3C65DBC82@IA2PR22MB5617.namprd22.prod.outlook.com>
References: <25380f75dd2443c0a882bcce78503511@rohde-schwarz.com>
 <20260203170002.GO2603314@bill-the-cat>
 <f8f1197e979b4998afb5dc952f7a8a63@rohde-schwarz.com>
 <20260206015447.GP2603314@bill-the-cat>
 <989f3c4aa5a04fd3b1c2efda1aedd459@rohde-schwarz.com>
 <20260206150345.GT2603314@bill-the-cat>
 <1000751cb4604e768e2f789c3dfda18e@rohde-schwarz.com>
 <f991777100194a22b350660b5977cf27@rohde-schwarz.com>
 <20260225222417.GY1593142@bill-the-cat>
 <669abe865bc74dd6aeea69caabeae259@rohde-schwarz.com>
 <20260226152640.GG1593142@bill-the-cat>
 <ab9b77d1c3204235a50c9de34aa86498@rohde-schwarz.com>
In-Reply-To: <ab9b77d1c3204235a50c9de34aa86498@rohde-schwarz.com>
Accept-Language: en-150, en-GB, en-US
Content-Language: aa
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA2PR22MB5617:EE_|SA1PR22MB5635:EE_
x-ms-office365-filtering-correlation-id: 87fe2db9-66a7-4527-eba4-08deeeebee59
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|7049299003|3109299003|6049299003|19092799006|366016|69100299015|1800799024|38070700021|4013099003|4053099003|13003099007|6133799003|10067099003|56012099006|11063799006|4143699003|22082099003|18002099003|8096899003;
x-microsoft-antispam-message-info: tbjwwdduqYPSk8xyuEPoGe8f0rHATMDb1PQadFhWyYGO914otNPpRVZM3SJSZUKZR4hBWhdI0/wVPkjsbVHkON9y1VVvLx1XAOe7tKjW7wYwPTu7nV3kBcW7NKKxqO2G/GqGaNIEP9QtfHpfigozCfGWCXtC6HGl77ajlsSRBmPTQ432X8EtIk6JUpAgU67SJv37JMk7tu/hQLQAUmVY0kyKVxuYrG3UmAecWFbsgx7UsFxDCzG7nrGZPk2lK0BinVowCZXSCWVXyOvaN35QMwcPmuvsSndbDHau6HM3P+T9lPlNuaWyDYpjg+i1UzLmquUpIn8LyMUjZFpK41WI8GdJD1JXfW7itGVIhA3zPSUW/FgUn/P/EPrth9Ex2cO4o9GnLdPerdIg5adtbAmEPWXZmSNVDB1zg//lbM2q6D4DqrZ+M9zgbwi7ArVcnYGuQC44X2qyLKjDGHK1ZGbzdW8NI0qQeSh8KofGSTtHSJ5MxKkZCawOPlPKJdZciV6JNke5el/od6b/9amONg1OVUE/RKw7km8QIKj9l4tWbXd3oMckT7rWv//bwa6yvQVsqY7CwUigPzMw5Lgjicg01xFqwXKPqXRLURRNggFfR9Y9IfX17HjtN7sdOJzvApYUdB6ofof6F0HeT532rb2cUbkvuiKdNT76FXR+HVOxuQc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA2PR22MB5617.namprd22.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7049299003)(3109299003)(6049299003)(19092799006)(366016)(69100299015)(1800799024)(38070700021)(4013099003)(4053099003)(13003099007)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?/hgukrphh4v84ztcisZHP2PTw7q6IfkZoWqGAf9zZueePiWYzxibly3M?=
 =?Windows-1252?Q?hP90gMmmE9EldiRAa90BpSJ/oQrMNRfS09OjNtCiuQFFRJWDWKfukr+f?=
 =?Windows-1252?Q?rTn+VEyqEOmhwrLnLltrwDHIrWWWTuH2Tq0sH1eRxT24digrPapjPbvi?=
 =?Windows-1252?Q?QUAxNwxa8Ncjb6VfJF57+Ei5rKHnaHraHylXtHTlFbCUByKERSz7o3+g?=
 =?Windows-1252?Q?ywlNu2PfNP7FaWYi1xoUr07UkLdA4tJQOI74Zi4BbJY14N3yd/mO0H6a?=
 =?Windows-1252?Q?QCGgGfieC31HewD04mc6nMRGfakCqTt7CP/ek71uLVj5l9lzukx3Qmwa?=
 =?Windows-1252?Q?95mEOwF1EihA6DaE/PY4NmwDKLjulvt8mRFSQaPtAPhG4i7WUgM7T3B2?=
 =?Windows-1252?Q?wL/cp3lZMypp+zdgIDv0Yc++DIjbYj3+OKMyeCfN+n9i00GiiO80ZTDU?=
 =?Windows-1252?Q?QmJQ4Bis4g87MryQGrKJaPRMyUYBgK22CM4N0UaHJha5HMDbeAGd4QR3?=
 =?Windows-1252?Q?aSwpVNtXhSmGMC3FSgAeIUWbW2I4PN2eCWsNiRY2j4Yx2u3UXWpJHgKx?=
 =?Windows-1252?Q?VZAHJn21s59PGnflYsheu9gKsts0qGd6KFTU99fzQkGJMHB7sIUiWbnr?=
 =?Windows-1252?Q?ZjC3FjLCNe8DJknu0AxtspKaL8tgIsg8u0F7IoDA1e+HZzIQhaWs8509?=
 =?Windows-1252?Q?+5uTg4DLyVSxqmiqDm/N+pT0mQr8R9EYfDEX2c8oCm1hKAo4wTZ3TJwS?=
 =?Windows-1252?Q?Ja6I9HCHzuE6pUkuHRmRkUpvmPk2hKoFweSwsy0jDuC2j3UjcT0QCjm6?=
 =?Windows-1252?Q?Vcd2o2QYTikI3DKU1jP/yViBqrnLSq2IuGASkTLuegCPE2p30KE0sVzc?=
 =?Windows-1252?Q?EU6mfuYLWHlYNquCX2f4X2WeAiyBR6zQM2ApILa1sXHulmJmjQa84lXD?=
 =?Windows-1252?Q?aodEHTJ+19OsxxpM2GlIgvaRRRwbrkPAvZyn2Sn7sT4ICZOiR14ZKQgB?=
 =?Windows-1252?Q?kU2GaF6DDcqTyeptkTRI5DYKwTiT7UoAB2whkn9AhgJ4hdbtUFQxXefP?=
 =?Windows-1252?Q?u8t4TuPAM4MiG7RcC2wypruKI/VRcD7qjwwjas3Zi4VFkBIzr1w8CEDV?=
 =?Windows-1252?Q?N4gKkN1OKkaSG8nF8IKoziva/XwPeyCw9PCpyP/VBNBfPftP89KNOban?=
 =?Windows-1252?Q?kGqdSm8VEpE7pO/sA5vZWzioYgUJw9rT/0cYvxhwFe/LOhPebR/nWdQz?=
 =?Windows-1252?Q?ivgYBXYfpuO1ojAZua+uY+lz5f7myl1Lm5DWBaGHWNOpUldDrR3yj0hT?=
 =?Windows-1252?Q?ro+u8nS/cdh0m6mZsZX5JkIamxztLMamS8gUFQuKf62hrWOG1CYGxBp0?=
 =?Windows-1252?Q?yFZT3WX0CecPHMrG8N6tZJr7sh3pDxBnhHE2WBck8SK4lx9D72QcfNBA?=
 =?Windows-1252?Q?bD+tZznzy8ZoW2yodl+gQ0kDyq3Zth/g+mIpxjhClOqD4Um9pSRUJPp9?=
 =?Windows-1252?Q?OdjtIAkQF+6LBPgVp/nwcNSk/9SY5lRoXmWZxqMZ9iqQspSWKiq2B0PD?=
 =?Windows-1252?Q?K1J4DpRrLdwnMUbWhR1/L6XrADwfXwU2vcoIS/kTslQ8mTc4FeMJEA2B?=
 =?Windows-1252?Q?ETnkZuuOb+9cEUlEnQUj6fQbAXBP65ZI/GiE87wgWEZzwisU4F0NQvI7?=
 =?Windows-1252?Q?ffsfZ4+RbFduWUtJjfbN/s22sldtN22uVFjNLYkoHgsk/0YDuL5rMYoR?=
 =?Windows-1252?Q?XuJrIIV7qBWcWy1InXgtg4ME68zpP17/IF9zXkhxjQ+Dn7IP/juyxmuX?=
 =?Windows-1252?Q?b3TQLDTwWMBHZ62PRSlQJbwpAaaWKZLtlYqJDVQhTiXjt6wv?=
Content-Type: multipart/related;
 boundary="_004_IA2PR22MB56172034CF2D817EF2BA3C65DBC82IA2PR22MB5617namp_";
 type="multipart/alternative"
MIME-Version: 1.0
X-OriginatorOrg: Lynx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA2PR22MB5617.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87fe2db9-66a7-4527-eba4-08deeeebee59
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2026 10:10:21.6743 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 76f7f3b2-94a1-4806-8168-1230a353cde3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OkOpT4YWP9SupMi6JQm6Epw2/82OsZSLESQmOX4PgYVIWEhyeE5My1fFJoxJo5acHgDXAuHMhUS6vftR7vFgSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR22MB5635
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 31 Jul 2026 12:41:59 +0000
X-Content-Filtered-By: Mailman/MimeDel 2.1.30
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Lynx.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rpta127tWTKhfIgNkbuQy6Q72vbK9maIxKEdkXg0FC4=;
 b=n0GRsLrRBwaI9Q239S0K2RhCfrZTnht+HjTjY2Q6VOiWG5DbmoVoUY+nPqIM9z0kjQ9ZLLuquGVJbCILt//BmFX9vNAJhL/pGiGJacRdPGeB7td6kt4URohG1SU48FHgN5q03ysMFp6XjIdAisbxTwfO3sq009FDnSNOrHhyxAYvbi5FDPmJxnPvILy+RRR1Iz3bI3+GUR2Cpe3IMrDiHJa0nex1UP10wri9+30Fw/O1zUcZUR0B3bRtISjS2CGcP0CymlUKimgL4cdSt0e03QF8Rjt2l1FLu8UlD8vIDSfxkTN6XV8KHyHILzqj4v3GV/baL3hWrkEFj/fVeEENjA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=lynx.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=lynx.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=Lynx.com header.i=@Lynx.com header.a=rsa-sha256
 header.s=selector1 header.b=n0GRsLrR
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=lynx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=pdeiber@lynx.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=Lynx.com header.i=@Lynx.com header.b="n0GRsLrR"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lynx.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

--_004_IA2PR22MB56172034CF2D817EF2BA3C65DBC82IA2PR22MB5617namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks. I will share the contacts to our product team.

Regards,
Patrick


__

Patrick Deiber

Technical Account Manager, EMEA

[https://www.lynx.com/hubfs/email-signature-cellphone2.png] +49 171 81 34 5=
40

[https://www.lynx.com/hubfs/email-signature-location2.png] Germany

[https://www.lynx.com/hubfs/email-signature-globe2.png] www.lynx.com<https:=
//www.lynx.com/>

[YouTube]<https://www.youtube.com/@lynxsoftwaretechnologies>[LinkedIn]<http=
s://linkedin.com/company/lynxsoftwaretechnologies>

[Lynx Logo]

CONFIDENTIALITY NOTE: The information contained in this transmission may be=
 privileged and confidential and is intended only for the use of the indivi=
dual or entity named above. If the reader of this message is not the intend=
ed recipient, you are hereby notified that any dissemination, distribution =
or copying of this communication is prohibited. If you have received this t=
ransmission in error, please immediately reply to the sender that you have =
received this communication in error and then delete it. Thank you.

________________________________
From: Dorde Stojicevic <dorde.stojicevic@rohde-schwarz.com>
Sent: Friday, 31 July 2026 08:46
To: Tom Rini <trini@konsulko.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>; u-boot@lists.denx.de <u-boot=
@lists.denx.de>; Patrick Deiber <pdeiber@lynx.com>
Subject: RE: Re: Re: Re: Re: Re: [PATCH] arm: Backward compatibility to U-B=
oot v2020.04

Hi Tom,

I have news regarding this.

It became an important point at Lynx, so Patrick from Lynx (or a another as=
signed colleague) will get in touch with you to sort this out.

I already discussed the solution proposed by you (therefore forwarding the =
e-mails below) and we see no technical problem with implementing like this.

Pls keep me in the loop as I would be interested in the final implementatio=
n as well, for the purpose of my project.

Thanks and talk to you soon
Dj


Dorde Stojicevic

Technology Systems

Rohde & Schwarz SIT GmbH
Hemminger Strasse 41 | 70499 Stuttgart-Weilimdorf | Germany
Phone: +4971169945195

Internet: www.rohde-schwarz.com<https://www.rohde-schwarz.com/>

[cid:DF7F3780CBD74D75@A9C3C673EA6C2A40]

Gesch=E4ftsf=FChrer / Managing Director: Dino Huber
Aufsichtsratsvorsitzender / Chair of the Supervisory Board: Markus Dolfen
Sitz / Registered Office: Stuttgart
Handelsregister / Commercial Register: AG Stuttgart HRB 759 934
Umsatzsteuer-Identifikationsnummer (USt-IdNr.) / VAT Identification No.: DE=
 121 963 283
Elektro-Altger=E4te Register (EAR) / WEEE Register No.: DE 877 727 67



-----Original Message-----
From: Tom Rini <trini@konsulko.com>
Sent: Thursday, February 26, 2026 4:27 PM
To: Stojicevic Dorde (11SIEPT1) <dorde.stojicevic@rohde-schwarz.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>; u-boot@lists.denx.de
Subject: *EXT* Re: Re: Re: Re: Re: [PATCH] arm: Backward compatibility to U=
-Boot v2020.04 ***CAUTION_Invalid_Signature***

On Thu, Feb 26, 2026 at 08:15:14AM +0000, Dorde Stojicevic wrote:

> Hi all,
>
> yup, I completely understand and agree with you.
>
> One way would be to detect the characteristic string Lynx has in the begi=
nning of the FIT image " eLynxSecure" :
>
> mkimage:
> FIT description: LynxSecure 2025.10.0-39844b80e0 SRP (aarch64)
> Created: Thu Feb 19 11:44:07 2026
> Image 0 (kernel-1)
> Description: LynxSecure 2025.10.0-39844b80e0 SRP (aarch64)
> Created: Thu Feb 19 11:44:07 2026
> Type: Kernel Image
> Compression: uncompressed
> Data Size:
> Architecture: AArch64
> OS: Linux
> Load Address:
> Entry Point:
> Image 1 (fdt-1)
> Description: Flattened Device Tree blob for LynxSecure 2025.10.0-39844b80=
e0 SRP (aarch64)
> Created: Thu Feb 19 11:44:07 2026
> Type: Flat Device Tree
> Compression: uncompressed
> Data Size:
> Architecture: AArch64
> Default Configuration: 'conf-1'
> Configuration 0 (conf-1)
> Description: LynxSecure 2025.10.0-39844b80e0 SRP (aarch64)
> Kernel: kernel-1
> FDT: fdt-1
>
> xxd -l 128
> 00000000: d00d feed 1dea 3bd5 0000 0030 1dea 3b64 ......;....0..;d
> 00000010: 0000 0030 0000 0011 0000 0010 0000 0000 ...0............
> 00000020: 0000 0071 1dea 3b34 0000 0000 0000 0000 ...q..;4........
> 00000030: 0000 0001 0000 0000 0000 0003 0000 002e ................
> 00000040: 0000 0065 4c79 6e78 5365 6375 7265 2032 ...eLynxSecure 2
> 00000050: 3032 352e 3130 2e30 2d33 3938 3434 6238 025.10.0-39844b8
> 00000060: 3065 3020 5352 5020 2861 6172 6368 3634 0e0 SRP (aarch64
> 00000070: 2900 0000 0000 0003 0000 0004 0000 0056 )..............V
>
> Thing is I am currently pretty busy with other stuff, so wont be able to =
commit myself to it at the moment.
> Maybe you can work out a proper solution, based on info I provided.
> To my understanding, shouldn=92t actually be that complex, e.g. just add =
check for eLynxSecure in the code location where my patch is.
> But may be I don=92t see the whole picture of U-Boot and missing somethin=
g.
>
> Let me know if I can be of help somehow

I was suggesting adding a new IH_OS type because otherwise we're going to b=
e opening ourselves up to invalid (or malicious) images being passed in. Th=
anks!

--
Tom

--_004_IA2PR22MB56172034CF2D817EF2BA3C65DBC82IA2PR22MB5617namp_
Content-Type: image/png; name="image001.png"
Content-Description: image001.png
Content-Disposition: inline; filename="image001.png"; size=9150;
	creation-date="Fri, 31 Jul 2026 06:47:02 GMT";
	modification-date="Fri, 31 Jul 2026 10:09:16 GMT"
Content-ID: <DF7F3780CBD74D75@A9C3C673EA6C2A40>
Content-Transfer-Encoding: base64

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

--_004_IA2PR22MB56172034CF2D817EF2BA3C65DBC82IA2PR22MB5617namp_--
