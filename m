Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2925BC5CFC1
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 08:57:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E0C8C60678;
	Fri, 14 Aug 2026 08:57:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61XPuewrlZKB; Fri, 14 Aug 2026 08:57:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0CE3460683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786697834;
	bh=HlOdQ2ckoAeDPtXub7nlT1fDHWveoFHssirFIDQsGzU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dzrns2h/OkmA37/y7H4oe/PM1vq1kCJnDHRbgEg89gSVIeSQha+LJyucJkMmBN5vp
	 5FBhNBCFDj3/1bC+DzTTIg/gOP4i7iv/1bMYO6op0vElc6xiTBlX+oHdkqPN/ocbpl
	 86Izwtl9mBtfTpJt+gRAUZoU3HTaN8j5U5OjKKti6nWCRqEijNUze/K9PEAxde6m4v
	 bAEBi+GbfVpL7eK8HzJTxIq7T1Q1faB2PmfQP3NPw+j7U++ihEcU32yJ2OmA8+zN9c
	 qwTRVt9GscXIPqJf2jPniGaD78Pc2uEdO75V7PwR0LOvPFUA+CTqCg0P1YHfYZF2cq
	 Hu0h17Q4rJl+A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0CE3460683;
	Fri, 14 Aug 2026 08:57:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 13E0E33B
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:57:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05BE160678
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:57:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lng85p6K3Tkm for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 08:57:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 7D28E60674
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7D28E60674
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Yfk1wQvb; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=Yfk1wQvb
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7D28E60674
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 08:57:09 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Km87om9ut9w8/h+SuuIjoBPK4SHrE0uEzGSCeMQJSBhYStwU6U3rAb2eZd3AH0BeSCi7tG/oM7BCVYYapEVx9HCNvZz1/5EXGWecaWtO9pJDK+Xj0ZgkGk6N6M4mFKN9wybhujkdzYj+SowE6ZpHW99+l37vSMRvFjtRpAKb0tk16NqWywWMOzRWdpdGZpzaFQstyzXFL13gXfOObiklu93BMg4xeTHlskROaard4kKo+SEgkLWo4twNc0CSK/8c9RM7xcJSkxlEExb1BTEWi4b07yqETwyA7QCwdLHmJGz/bUc1vbJeNxRvJSluEnAQAMwcn93V0lV1iXamA48pYg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlOdQ2ckoAeDPtXub7nlT1fDHWveoFHssirFIDQsGzU=;
 b=HREkAdGU0Fme/gU6rEL1NOYPYJpD0pmv/erfDX5FplR4eZfd5grBhHDnccxSPUfxi+WLqIfu2VeSJr81l0WJHgRQAunscxYXh0CZ5FgG66z5WxEihMeTyj08CgZQNABwLU4cC5Gn4oxAnpH13HanEv/WD9Km9INYk8lXbkwQUZW6OvOMk5nELX0uwV6j6E9WczUhiGGCxVQ9GylYshzBhuTQcjkR7HmXQu4LrZUjOf7+YLYD9XAca+IM814Ss0d+cIYLDIBIyde4rGIXWZPZ1XL+0SVH/n6WNlTs5wzyeouX+Jye47sOwE8j/VzqQjSqFlR0MAloTSMLla3BV4gYMQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlOdQ2ckoAeDPtXub7nlT1fDHWveoFHssirFIDQsGzU=;
 b=Yfk1wQvb6nfldKqBw848zCs9BENpAEUixd43kLnWYZyYe+F4+jZxc1PdvqaxIHAeqLIiJ58liKp07nvoa15FiiEYdX7VRrlps8c8fMYUyIA8YFL0KC1uW2geT1Y9V+/6MSEwsP+wu7rlUYqoExxyDgYZrLqSqOu2bXvWnsQkKoc=
Received: from DU2PR04CA0291.eurprd04.prod.outlook.com (2603:10a6:10:28c::26)
 by PR3PR08MB5594.eurprd08.prod.outlook.com (2603:10a6:102:8b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 08:57:04 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::8e) by DU2PR04CA0291.outlook.office365.com
 (2603:10a6:10:28c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 08:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.3
 via Frontend Transport; Fri, 14 Aug 2026 08:57:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJz2X91+ptZX8e6hNaukEe/9s3wdnHmhTfYp6RmFd4pqRyqqM78TtDDDRoyHW3GI4/fY5P+GekzrBP2DXmZBQ7sG/eOqZJqgtEgP3GmrzD4jIaSOqCPNEEFT/6+By7ygOCCwGgXXOUb2+6C4J/ZoVwkowuCCoo2Nbbgf2JCk1r55lfvCEjXrcdm4gOnW40okcRQf8NRRotzgN48vUu4B71KsVZckERRTQOEBx+a2f9Xn2PRSiXnB/U5dhgfcfuzqS6clFMeDCJM3K/WkmVPXat46C4qY6bYupvRKyaPv7TQosGxUs6HmuHBWnzsQMKuDPCMT5tQtvSKvmVIOE3wwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlOdQ2ckoAeDPtXub7nlT1fDHWveoFHssirFIDQsGzU=;
 b=KQ48rVgAB0as3wnLDO4hS59oV5yAqm6+I3z39Fa5NWuGjGa29dXPiOeK33hm2BO4mJ39MkI5AmHNHYF0BajH3nMJe3vnpszV4B8EFG2PIPmuYzb31RbGn0UKRjm58ja0SJCpi/rsMV5uz0Q9g0mw0dRhGdZ5lR9jv29egdv387xB/FKnELbNqTKM6efmquDJ8BtUKGJOFHYQtn2pVh5hU+LPM8jSkOh0NuFIPffubbMi+Xl1hV+Qp/CwF/d4IVP8k+xcCVfIRGGryCXpOXwEMWGs8mihNEo7eYhHLGCwqt0NSA5g2MFRo1PRPaqb5pZ/h3VLQSAVovZsy0RjO8bMJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlOdQ2ckoAeDPtXub7nlT1fDHWveoFHssirFIDQsGzU=;
 b=Yfk1wQvb6nfldKqBw848zCs9BENpAEUixd43kLnWYZyYe+F4+jZxc1PdvqaxIHAeqLIiJ58liKp07nvoa15FiiEYdX7VRrlps8c8fMYUyIA8YFL0KC1uW2geT1Y9V+/6MSEwsP+wu7rlUYqoExxyDgYZrLqSqOu2bXvWnsQkKoc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV1PR08MB7330.eurprd08.prod.outlook.com
 (2603:10a6:150:1d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 08:56:27 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0315.014; Fri, 14 Aug 2026
 08:56:27 +0000
Message-ID: <1fa9b820-d4e5-4956-b1ab-928e06e024bf@arm.com>
Date: Fri, 14 Aug 2026 10:56:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] net: nfs: bound server-supplied lengths in READ
 and READLINK replies
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
 Argus <argus@byteray.co.uk>
References: <20260813-nfs-oob-fix-v2-0-80993770518e@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260813-nfs-oob-fix-v2-0-80993770518e@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO2P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::21) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV1PR08MB7330:EE_|DB1PEPF000509F2:EE_|PR3PR08MB5594:EE_
X-MS-Office365-Filtering-Correlation-Id: ee7d1b63-9af8-4973-7f5c-08def9e202d7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: WUSzIYOUS3PlESiS7UbHgz4XYnQYTVT/XvZnN2fzGfs1yuhaS9uelDcrmIIhD9tHyc94Stng9Nkhk7W3Uk4x1nez0M8kJ7Eys8z2QwU8g8uVhg9J7vvsSzUy//Kldcshqdx7U0k4EEAqrY2RpejmhIbrqCtVzfUffDo8jzDzjVLXlF4in9Tzbe46j/jFiCZvkuM9Yp3Ut1a5j6fmiRK/Wd+2o7PV5vjAULkwz0xYCFjj1pdWeV7bdII5qXHuART1oUKH5uP3plIvoisHbE7lUWzCUnySlo4u6HKqsCZ72Ua2Vb28BsCGfjLyRglMhb7urjtl1Q/Q+zKXcs8z18CPICX1hbYaQ+Agmko4KBnSY49YBeKf7dv9hUwwt+7OBUUk0iOX4R+Wm7AFEJF+7aEhW1K+G7zehNTYcdF6TynRqBsnmkMEGTzR2pZ67plBDwaoKWLYg0w+kzIsOjploHVabJKGZ+okKhGYB11J+vCoshMcKe1WPF2YYzzlGfyIr2PH+x2dGdmnmuI4oUrQtqeF+ijJ0V3PmkFZo3Dl1Mr2JFgFHqwjApLxAEIrkRzAvfqCG3XoT97DRUvOsD+8dXzrp21kMhDADY3BjJeDEfAoobD2hVHeuuqHlyVBfzPWxhdYM0J9G6oopjoIcSrCeU+e7x1y4cNAN2PPe1xg7xQgyWI=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: YC4WjPzIRw5eXx3G8RLGIHrAvQdplpCrn2ck5fFxUPZ5bSV2Agk39YP5Lbn1VKzrEsicmk5TkmhZbYgbHLQ8wgtBifTt8KVHQz/ztl9HGxTXmNA1Q1vAm8CH/fPgzaCJx10DbFLYxGTUfvMhx8WGAe0EwOnpiiwBRNOgpV6Vto0V+nAoam2xvPUC/g9fF5Nlv7BMM3ROXnexsPcSj4pG6MJ5z9QIXcowk4U2yLb6Oy904q/a/JsTKsIlGikzYZMyrJkB+m2sqwcSM48wCzjKHaLsiVU9a0WleRQkCHdX29ACQwMRAhamcbj+Nk74kz1iVaT4XRYyqRCa8yefwktc+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7330
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c96db753-e2e2-45e7-1464-08def9e1ed2a
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|35042699022|14060799003|23010399003|82310400026|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ZZo468qE7okZafpM8BRw8+Ai48QC5xHxWGXc4WcvSy75h2DXdAH7miRM4hcJ8S/UiSLdeE29hsfvUiiQmTy2NWbzxBbsJP0LluKDe80cm9ZZTAQWb0UtaZ24N3dtXJimY00r0uoa3kKRPQTFJ9djGY7lqqmUu09IdZVzJwbd8u3X9LM6bR9IGgoCX4epNsIxwjQg1VJdmpkihmQ9bxSi7lvvQwkmY0T7hV08XrAhMcBijufuxc0yhnCesz7/+lOsEsFpISi3AoO4c//43rTaoRr7u+r2u9O+D943f15miZZDbTPWwPdtThYg4GnumjxTA+iOyHPV5zzirbYoiQl/YbcoC3n27KkUXiIFLplaQvqdDa26mRF5r5IEML62Fz+4qh7OQX7364IaCt/EtiP79CN8vzazP6mtdr1Q6IO/Hdx3pl1G/APonKT3vaj+3j/CW1xurMosuXjdnmOSxqcsLTELXPZl6eT4XO1FFe4zZ/aC19DBw2lb6yMIbv8HjD7NQK3qTxp1cSHe3/xyTCj5iL+0ZusEXKwQdT62iJlSYDbVAvUAAkecG92fUnmH+6MdMobCvqac6PzzUAKEIlJ4IJdybAomKPmVuvvmFdEOYzEIZr9wu+uMr3pO6SpjVls6dLWl1E+aYLVy2+4yP4cR27ofafUKDGZYvmWzgHFnymgm4ED4Hi46l2u5NK7pEhiPyF8ZTeCl3gfF32CPxsQHzw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(35042699022)(14060799003)(23010399003)(82310400026)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: c6H+Chwfk+qO4ro8ZCgkPcnbFy2Ph96CBtxOHL34Ac2YaPeBwVNxBJgz5EuvmMYxPkMi5ATc9sBklCV+tLnNyNs4aGODHSlnDFNelyR3SXjNwFYLYVTVrtjP76QL2hiFARrzFmzfBaGJDAwMApgYtj6GlOMZ1RRhlrLYJfXkFvQwHNb1QLKVLGxN8bDr6ny1UCyAJJWEqH9eix6n2DzRQ0r5s69WotlafvVQQLzhQzGZ6wcziruhUE/XAYdGxCQmyPIz4herEjFpc9UgHxZUV/IS4PaboP3XXMG4dHtyV5g0AsibvHeM0FTFJ+TtzNrE9beM4mVzGvCzZtqqRB7CsVZ8LjwXwXpfHmYN+NOJ3wgfsqpHn/sHbDdMZD5hc4urOgVL/Tr163TrQGjvx17b8KG9i3W8viFFZ43sqHiEdKHsBeIsG4pjcp9jV0U00W2N
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 08:57:03.7690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7d1b63-9af8-4973-7f5c-08def9e202d7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5594
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

Hi Shahriyar,

On 13/08/2026 17:48, Shahriyar Jalayeri wrote:
> A malicious NFS server can return replies whose 32-bit lengths are crafte=
d
> to defeat the client's bounds checks.
>
> nfs_read_reply() keeps the READ length in a signed int. On LP64 a value
> with the top bit set is negative, the bounds check passes, and
> store_block() then hands a ~2 GB length to memcpy(), which reads past the
> 1152-byte reply buffer on the stack and writes past image_load_addr.
>
> nfs_readlink_reply() has the same signed-length flaw. A length of -1 slip=
s
> past the destination bound as pathlen - 1 and drives a memcpy() off
> nfs_path_buff. The bound is also measured from the reply header rather th=
an
> from the symlink data, so a large positive length reads a few bytes past
> the received reply. A server reaches this handler by answering the READ
> with an ISDIR status, which moves the client into the readlink state.
>
> Both handlers are shared by the classic and lwIP NFS clients through
> nfs_pkt_recv().
>
> Patch 1 bounds the READ length by NFS_READ_SIZE. Patch 2 rejects a negati=
ve
> readlink length and measures its bound from the symlink data. Patch 3
> enables CONFIG_CMD_NFS in the sandbox config and adds DM regression tests
> that drive nfs_pkt_recv() with crafted replies.


I think the rlen < 0 check in patches 1 and 2 is awkward and not fully robu=
st.
I suggest making rlen a u32 instead.

- For nfs_read_reply() in patch 1:

  u32 rlen;
  size_t data_offset;

  rlen =3D ntohl(rpc_pkt.u.reply.data[3 + nfsv3_data_offset]);
  if (rlen > NFS_READ_SIZE)
          return -9999;

  data_offset =3D data_ptr - (uchar *)&rpc_pkt;
  if (data_offset > len || rlen > len - data_offset)
          return -9999;

- For nfs_readlink_reply() in patch 2:

  u32 rlen;
  size_t data_offset;

  rlen =3D ntohl(rpc_pkt.u.reply.data[1 + nfsv3_data_offset]);
  data_offset =3D (uchar *)&rpc_pkt.u.reply.data[2 + nfsv3_data_offset] -
                (uchar *)&rpc_pkt;

  if (data_offset > len || rlen > len - data_offset)
           return -NFS_RPC_DROP;

In addition, nfs_readlink_reply() has this check:

  if (pathlen + rlen >=3D sizeof(nfs_path_buff))

IMO pathlen should be size_t and the test replaced with:

  if (pathlen >=3D sizeof(nfs_path_buff) ||
      rlen >=3D sizeof(nfs_path_buff) - pathlen)
          return -NFS_RPC_DROP;

What do you think?

Thanks,
--
Jerome

>
> A reproducer is available on request.
>
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
> Changes in v2:
> - Add a fix for the same signed-length flaw in nfs_readlink_reply(),
>   rejecting a negative length and measuring the bound from the symlink
>   data.
> - Enable CONFIG_CMD_NFS in sandbox_defconfig so the regression tests are
>   built and run under sandbox; the v1 test was skipped in CI.
> - Add a readlink regression test alongside the read one.
>
> ---
> Shahriyar Jalayeri (3):
>       net: nfs: reject a negative or oversized NFS read length
>       net: nfs: reject a negative or oversized readlink length
>       test: dm: nfs: add regression tests for the NFS reply-length checks
>
>  configs/sandbox_defconfig |  1 +
>  net/nfs-common.c          |  9 ++++-
>  test/dm/Makefile          |  1 +
>  test/dm/nfs.c             | 90 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 100 insertions(+), 1 deletion(-)
> ---
> base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
> change-id: 20260811-nfs-oob-fix-31c433a22c91
>
> Best regards,
> --
> Shahriyar Jalayeri <shahriyar@byteray.co.uk>
>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
