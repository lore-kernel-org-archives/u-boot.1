Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117E8D6DDF8
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 12:50:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D0D9890E4;
	Fri, 15 Nov 2024 13:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ab+jMMcZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ab+jMMcZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B28818910C; Fri, 15 Nov 2024 13:49:59 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BF898907B
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 13:49:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Harrison.Mutai@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=M0H1VoTplI6UzWz1/v9PL/uIXKkml/K1LBlhs2cc1ABoQDwZDQU/4dNyYCb7NOTLlNpC5iJV0fJ6UlB85GExZ24dp+f4ExcYXaSYMr3gl+d0+R/p7vYcQKrffhtCVM5XzZ4Ejaah8jhGBEwrzorXnCQT7I87jgdb/I+rUi3NqqEe4tINRma11BMjI2V4i2j/WIchj6eGGdBuqb9pg4DU+w6Quwr2m37t6Pb27n6CRw2OsSSY8qhGY6icrO26toAFVKjT3hfZgC4Wtcw/WDz4CCKgzR8lxaJsuH0QbS+Q6QATT4yCvAbzlnbNrh9o+QoIvYzckUAnUGL8JR896ZpYAQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziFCialmfj4M9ZbDUtPcjosK7ok7oF5yLoyeNQ6/QYQ=;
 b=IYSlFVr/vsLNsRGFn41SDnjNlhN2kqjUw9pJBaEu6UH0T5Wu0N4Ozpmkwue8mBYR2dSDZRFZ54j6poSo9jpDNVyeHKFBAvz0r8SSzi/Tot4I0Cqrn3v8iP1PqLbISyvGQB05U2g3FnQHEMmmMkZiwbC90s/RpPzdqafnJwSXOvdNYxaMsI8ZsHGjeetiJBpQ47b4OCwQ9i263qQY2PpbrswjNKRCjBwtTBphqX9aYfNpgHghhlD6glMLQPKooX0pNEekoWhFrGgLodJHxE91hsIKQtKDMMcShkLH5XSLwW7ckx2nM8km4CIeM/omtpKlkLfjjGOfLVJS4fVUfKRwMQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziFCialmfj4M9ZbDUtPcjosK7ok7oF5yLoyeNQ6/QYQ=;
 b=ab+jMMcZf7un+XwLoGEBy2drpJJmkwf+j+7LIZ0u7lcJpGLnuh27XRu9TRkwxd7zYEUIJGosOOkMHLAvgujzGFqGVRK1nTTKctNJ9SHu5pPzF+6fACW+5+xuwn98LYc58sZpMczNmNmHYZI37z6X0+MRtUiwnCA8p3C5Jco0mHE=
Received: from DUZP191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::28)
 by AS8PR08MB9867.eurprd08.prod.outlook.com (2603:10a6:20b:5ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 12:49:53 +0000
Received: from DB3PEPF0000885D.eurprd02.prod.outlook.com
 (2603:10a6:10:4fa:cafe::10) by DUZP191CA0051.outlook.office365.com
 (2603:10a6:10:4fa::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19 via Frontend
 Transport; Fri, 15 Nov 2024 12:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB3PEPF0000885D.mail.protection.outlook.com (10.167.242.8) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.14
 via Frontend Transport; Fri, 15 Nov 2024 12:49:52 +0000
Received: ("Tessian outbound d013e61db77e:v490");
 Fri, 15 Nov 2024 12:49:52 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1a8ed0900c4987be
X-TessianGatewayMetadata: GZ9/IZe/I1ik67pNTm8+aLCzlLvguEUQ6ESYimafHyELRORPG2/eMYmNbnFr4EgUVaZw/VdRPW7tG7xEJCtUdbrHHQ/41XTbnAaj+MyK35ce2FvPeSpSYWddVV13jzv16pFVimd75eu03UMCWEvePfV5CPqQSfdRyo1qBH47Wco=
X-CR-MTA-TID: 64aa7808
Received: from L04032dc20375.1
 by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 DC9502B5-BDB4-40FA-9E21-BD43EF3A4A1C.1; 
 Fri, 15 Nov 2024 12:49:45 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 L04032dc20375.1 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Fri, 15 Nov 2024 12:49:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UyISiedn/bPawo4vFAoeYdrFGMOLRajVgIC8/zkax4m1aRkdYvqcqIk0NZRODtiOz8Bt7tdcBHKccaR1/qDRV3cjAy868kMihJXPogx52v0rXEri561Z+/oh7r51Ji36Z7AxXIulvwrBsbTk+i2VH1KwBQdEsTfXkf0Gn/a0H3Hk6KCgXFMCqNcQ8T8Y/cvkTgQTD4BNDIGkMtz0+ZfKkgKzl8bvcHtgovrm8hu3327SsScEosrP5yL1+k97mRzuFi4bpTH+PJ6EZHuxyEaS5/XcbVRLrijIFAx0vbPtrJQ9sF+AeiAr+GfqbXYZL5A42O2wG9gHmkPJCHoGc2WLzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ziFCialmfj4M9ZbDUtPcjosK7ok7oF5yLoyeNQ6/QYQ=;
 b=oXq+dp9VzWaJzteAq9Mv9OA7od0YjajJEIr8JojqTf962gKadXlSJFRwIbUHvVB9J9VYouYmEGNlYUJ81B4Ev6lUGPCb20vUp33k+AoMK7JYxWqvCClC0BDC4erdfYYOBnxOYDj+qe+dgb1t3S9+OfXaftNU9l6Cb1+4euTvi6bsfIAz2nxm5Fol989v1DNr0yJ8zooWUlgv9IBwY7ccREAJ+y+ztWW1YG8sSMYqCBbUYkXgQ3Ekf4gBNg42hMFLQicS6w/vbfKAlfBd1noFRhbxy905dDRSwg+cfgzHg/JAcq2IXOi0YM/DWWO9ePZJvXAstErHXJdraUnuE8/T8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ziFCialmfj4M9ZbDUtPcjosK7ok7oF5yLoyeNQ6/QYQ=;
 b=ab+jMMcZf7un+XwLoGEBy2drpJJmkwf+j+7LIZ0u7lcJpGLnuh27XRu9TRkwxd7zYEUIJGosOOkMHLAvgujzGFqGVRK1nTTKctNJ9SHu5pPzF+6fACW+5+xuwn98LYc58sZpMczNmNmHYZI37z6X0+MRtUiwnCA8p3C5Jco0mHE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com (2603:10a6:10:571::11)
 by DU0PR08MB7462.eurprd08.prod.outlook.com (2603:10a6:10:355::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Fri, 15 Nov
 2024 12:49:43 +0000
Received: from DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df]) by DU4PR08MB11188.eurprd08.prod.outlook.com
 ([fe80::5926:9f0b:ea5d:24df%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 12:49:43 +0000
Message-ID: <ccbc084e-5125-45ee-833f-0844be8e5417@arm.com>
Date: Fri, 15 Nov 2024 12:49:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: Clarification on Bloblist Initialization Settings
Content-Language: en-GB
To: Simon Glass <sjg@chromium.org>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Arthur She <arthur.she@linaro.org>, Manish Pandey2 <Manish.Pandey2@arm.com>,
 nd@arm.com
References: <DU4PR08MB111882C823AA07294E82B4FFC935B2@DU4PR08MB11188.eurprd08.prod.outlook.com>
 <CAFLszTgRhKWNiB4LeDP+zkXrX12YnRfMvfx5ZdA7mWMU2Qb69w@mail.gmail.com>
From: Harrison Mutai <harrison.mutai@arm.com>
In-Reply-To: <CAFLszTgRhKWNiB4LeDP+zkXrX12YnRfMvfx5ZdA7mWMU2Qb69w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0158.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::17) To DU4PR08MB11188.eurprd08.prod.outlook.com
 (2603:10a6:10:571::11)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU4PR08MB11188:EE_|DU0PR08MB7462:EE_|DB3PEPF0000885D:EE_|AS8PR08MB9867:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f3014dd-d245-4eef-7733-08dd0573ffd0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?clFUMFk2RW5EL3VjY0cvazZ5NmFac3lnSFFGbzJ4cVFwQ1B4QVI3YXg0SG9O?=
 =?utf-8?B?bGpsZ0pINjZjQml1cWxUdlN5OHNuRHdSOGNwNmtZT3NoZUV1a3Uxb1lndnVx?=
 =?utf-8?B?RlJzSlhwZkpxdUs5Tm8rWU53ZXFSR1RrY1JJWXVRTWkyQ3BnNG50YlJLczRQ?=
 =?utf-8?B?MGx4b1pTR0VNU0Q3dlJYRzQ3KzVYeklva1U2WEN2NnVZd1l4c0lBRXIvVng0?=
 =?utf-8?B?K2RXNnYwMUo1b0FObHBhcm44YjAySEt4WTJyQ0RmQkpyWVVXRjhoanEvNlVN?=
 =?utf-8?B?VnMyLzIyMFg3cTU5SHAzWVFjVVNMOUlsU0FRb3YzOXRsMDFBWXV4c3UwbTFr?=
 =?utf-8?B?cGx3WlZ1NFBSd2tXOUxXUkNleExXOUUvS0gxbzlpUkQwdVN0czhTYTJnVlpW?=
 =?utf-8?B?UEJJV0VGSHVsVXRsRnczcjI3QVpKaWMzSFZGWDZvKzBGNm05Q3ErWmwzVVFa?=
 =?utf-8?B?dHNsMEljNjhVKzV5bzFEcU1xVGVBRFpJU0t2S0IzSTQ1OU1ONDJJa0NMMEVh?=
 =?utf-8?B?VlV0aEtGMjdKejY3V3N1MmNrYVpqT3o2NDB3aU96eEpYWjBCTWpsNk9BTGVv?=
 =?utf-8?B?OVpqY2ZpVUxQbXpodnhhUmdrNDkwbVRsSDhRYU1rQTdRV00zU2tXU2RVaUdy?=
 =?utf-8?B?UVBsMllhamRCYUk3OFVuUE1SbElwaTMyMHJMMmxCSVNwbGVwYm4vazhYNXNG?=
 =?utf-8?B?bzd2dFJXMW9RdkFaOEdnaHl3aTFjUC9zSVM1aXIzS2xoK0prRXlmZUlhMTlj?=
 =?utf-8?B?TTgxclBhY2lTMGxBMHRpNmpod1lRV3o2VXFkRE1ZdllyY2xZeFNEV1JOQzgr?=
 =?utf-8?B?WkNPUGlxYkg4UVF6am5heXFkdzcxci9xSEk0aWNjYmRvVWwwNzYxMU10MTRB?=
 =?utf-8?B?WjhMb0l2VjFsZ2tibGZORDgzTnBQNDBmUFVXNksrd0Z4Um85aGZtcEEzNkFt?=
 =?utf-8?B?SlVjbmh4bmJUR0xtekh6VTc4b2JsYmRDRkdIM1hrdm5vSldxV0R6Z3BKYlQ4?=
 =?utf-8?B?SzZmbnJmUHBrOHJUaFBuVVlTZjVId3BncllUalFDM01KVVFwOVF1YTVLNjNs?=
 =?utf-8?B?dThPY0hWTEVWVWpodk5zOWZZMUREY0lZdVEya2lKa2pxemRUeXhjKzNyUVJO?=
 =?utf-8?B?S2d3VjV2TTJxVG91VURSTGVkSVowQ3hURFN6eWs1K211ZWgwYlcxeFNja2pt?=
 =?utf-8?B?UDZ4dHppMnVtV1U2QzJna3lqWGdNKzRsMThqVlpXU1JUMTVUNFB3OEloWVdU?=
 =?utf-8?B?SDVISXdkaFp2dC91N2VPUnFEQnJsYngxU0NEK2xJTlJIbWZERXhFRmRuYnZi?=
 =?utf-8?B?Z040d0pXZTNGSjZtRWNwdndBa0V6Qm1YSDhaT2tDVC9EQk5wOWNLQU01cms5?=
 =?utf-8?B?eDJSbi9PQ0tac2tzM21JYlM2R2NsU0RySlFKRThyRi9EcGJhWmJxTTZFUlEv?=
 =?utf-8?B?a0FBRGhTMnBMNW51R211WkNhdEtSVVJHMThheEwwalZzYVhiQUxKR0orb05w?=
 =?utf-8?B?OG94WUN1RG0yV2pjMnppaXdrK3RaN1BKTlZkOWlFUmVRS2ZpalM1VCtKbzk0?=
 =?utf-8?B?RzBGU1JmSThqRHNQd2E0LzcrQXpveG5VbEFYYXljK3ZBNGkrSVhIK3V3OEtj?=
 =?utf-8?B?WGQydW1MVDZXR3grWVVJYWErRElJTmF2K2xFVW1KRGVsTlUrN2dRY216elVI?=
 =?utf-8?B?QU5xUG13RGE3NWJtRVhWQXdzL1k5bkRqdmxLZFRQYWY0WERHRlhpL1dYL2Z2?=
 =?utf-8?Q?/Uxtrcx8duCSlefwksTYB0bSTLdzJbBopszwkV4?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DU4PR08MB11188.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB7462
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender: ip=[2603:10a6:10:571::11];
 domain=DU4PR08MB11188.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c8f3d0e6-af12-47c8-e8c3-08dd0573fa02
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|36860700013|1800799024|376014|82310400026|35042699022;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NCs3bEJYOUpJZm11NUFyYUVnekN6SldiMVJEZEJPdklYY21PUXlGUGQxMGZJ?=
 =?utf-8?B?T0RRdm5uRFBaMGtBa3B5a3NrZnNoaVVBRVF0bFlKTDMvR2F1d25lZWNNMnZk?=
 =?utf-8?B?Z0pvcWl6L3R1V3hmam5RdmFhSzRpUWpoblBmNW5NelE2N29nZmtkWDloTkZM?=
 =?utf-8?B?VXNpbWxqNmNuYnQ0Rlpmay9saUNwc1pRM3VLNXMvVW5QSE12U1Q0V3R3a09M?=
 =?utf-8?B?UVRacmQxZDFtWEZVWk5JSmszRmYvbVF0MW1FeTI3U3lxWTFCenVkUFc3VDhS?=
 =?utf-8?B?OFJRcnljK09xT2oyQzFjNEZnLzluR0NLNTVqNHpDeG9Ta2ZDS3FML2V5Ui9y?=
 =?utf-8?B?RS9MMnkraDBIbTlTK09mMVpTaDRvMzUvaFdqbVVlMlpXZ2NCcTlySVFabWxt?=
 =?utf-8?B?Rzc5MTB4QUpQTlpyTFUvSFFZYVV6RFdjTHpvRVIvRlMxOHc0b1paQWlLYWs5?=
 =?utf-8?B?ZkRHUkZpUVFBS1RlWEFOZ3I0VzFNQVdmNmZZQnpCQ3hCRlBseEdXQVhDMEl1?=
 =?utf-8?B?TnVKQy92bkp2cHQ4N0hvV0dpUVl0amgxd1hJYWtIOGRDL0s0K0JCdmVUSVlQ?=
 =?utf-8?B?T3E3MHBzd2t2dEkwZlcwTEtGYTRZbXpGZDJwbUp1Yi9WUW5JYWYwU3kzbmUx?=
 =?utf-8?B?bk9wSUhEYWVmaDVBazNXZCtCWjFVY2FhNFFtdGc0TkxuY0JiMTVlNTV0OXNP?=
 =?utf-8?B?U05vYTQxTTA0NG1heEZCWjJRc1QxWmJvV2N1bGJJdXp0SGZYcGVRZTN6eTFk?=
 =?utf-8?B?ZURYNlI0SFNibVR3aDdmNHM0RVdKYW1oMnNMcTA5dyt0MzJhQ2hSNE4rSTNH?=
 =?utf-8?B?VHNLWm9EckYrZ1IyaVZuSVNja2ZTb21zSEpteGJlNGRLanR3L2xaTGRTcmxD?=
 =?utf-8?B?alIvTEFhZ3pmMUtKWEZNYlhvNFZ4Lzd2V0cwK0ptbzJtT1ZJWEd2eFE2TjA1?=
 =?utf-8?B?L0IySk45bnNWWFg2ZW9WVHREbythWmUzRzBUQ3E5azVsS2VFOVBsNFFMaTlF?=
 =?utf-8?B?U1NpS1NGM0wxcWRBaGVBNjJvNnBrMDhKaytOVGdiRXlaMEpCWFRsbDlUc1NC?=
 =?utf-8?B?Z1ZpYUlZTTFNTVpUMDhKUXRta0htVTU4VXB4OGdmbVhJK2VOSG01cytCR2xX?=
 =?utf-8?B?UnZSb3ZaUTQ4N0x1RHhuWDVCeTVlUy9JNEltSnVKdWxONHZaUXF2a2lpRU5x?=
 =?utf-8?B?NmxzQVNmdVNMREkrUlV1QUh2dng5THhTN3F2UTR6WlZnRkE2ZmZMUkFGRWFi?=
 =?utf-8?B?MHdvVVBJYW84bjNHeU5jTStpZVZiTEtXUDR3Y1d6eFBFMlJRLzNXUWdPVVl0?=
 =?utf-8?B?aEZiYW0vS1NjME1NMzBSN24wM1pubTlDV2xkcnNRVlJ0YnM4QnpEUUk4bSt1?=
 =?utf-8?B?RFBOa3JJK2lRUm5aZGlyRmpBSDU5RDV1VGI5TktiZ0EvbFJkYVNPU0ZqRE90?=
 =?utf-8?B?bjArVVI0K1BGb1Bxcy90S1ovNkpraHh2KzNYQ1lEcEFiS0k4bDdjOTR0RGtD?=
 =?utf-8?B?SmJRMjFjMk1WWDZMKzM0TWFYQzhCejQ4Ui9MdVNvUE43bXBQMTBNZVFaNWw3?=
 =?utf-8?B?WG5kRDF1Z0NIUFRwTFFydmJVcFFuT0lzY0QzVnlhdzBvYnlSL2dXRDMrUWx3?=
 =?utf-8?B?d2lQaXdMQ2FlbFMrTjdyY2dGNGtOM2RGeHN4QkFldWVrUjNQbklVb291bm9k?=
 =?utf-8?B?b1lVaERraGxicC9PbDNwbTd4VklrUXhycXdOTDFnNUZFcFN5dzl2U25CL0Jt?=
 =?utf-8?B?VmRzTnl1YlRwNzJPMnYzUjd0NmtzR3VFMDZmMFZnR2FlU0dhZWRvS0IrZnFa?=
 =?utf-8?B?MUlIWjhNNU55QzkwRzBDbE8zMEY0My8zTWt2ZFVrbmMzbFJCc1NTZUVSTjgx?=
 =?utf-8?B?bGdza2FKZC95OEJWd2RzbWh0aGR5UzFGcDd6NFR1TVhHSWc9PQ==?=
X-Forefront-Antispam-Report: CIP:63.35.35.123; CTRY:IE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:64aa7808-outbound-1.mta.getcheckrecipient.com;
 PTR:64aa7808-outbound-1.mta.getcheckrecipient.com; CAT:NONE;
 SFS:(13230040)(14060799003)(36860700013)(1800799024)(376014)(82310400026)(35042699022);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 12:49:52.7708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3014dd-d245-4eef-7733-08dd0573ffd0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[63.35.35.123];
 Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9867
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Simon,

Thanks for the clarification.

On 14/11/2024 22:06, Simon Glass wrote:
> Hi Harrison,
> 
> On Thu, 14 Nov 2024 at 13:41, Harrison Mutai <Harrison.Mutai@arm.com> wrote:
>>
>> Hi all,
>> I wanted to clarify some details about the settings for initializing a Bloblist (i.e., CONFIG_BLOBLIST_ALLOC, CONFIG_BLOBLIST_FIXED, CONFIG_BLOBLIST_PASSAGE). The documentation states that if CONFIG_BLOBLIST_PASSAGE is selected, it uses the bloblist in the incoming standard passage.
>> Does this mean that the bloblist is used in-place wherever the previous stage places it? For example, if TF-A passes a bloblist at an address specified in the platform's boot parameters, would this mode use the bloblist in that location?
> 
> Yes that's right, but if BLOBLIST_SIZE_RELOC is used, U-Boot may relocate it.
> 
That's what I thought but was slightly tripped-up by the wording in the 
documentation. Correct me if I'm mistaken, but it doesn't appear to be a 
supported use-case in U-Boot currently? From what I can see, 
bloblist_init assumes either BLOBLIST_ALLOC or BLOBLIST_FIXED.
>> The reason I ask is that I'm preparing some patches to add bloblist support to vexpress64, and I'm looking to configure this platform without specifying BLOBLIST_ADDR or BLOBLIST_SIZE (i.e., automatically detect these).
> 
> Yes, that is a better way to do it, now that we have the ability to
> pass a bloblist between phases.
> 
> 
>> Thanks for your help!
>> Best regards,
>> Harrison
>>
>> IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
> 
> I hope not!
> 
Argh - apologies for this!
> Regards,
> Simon

All the best,
Harrison
