Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32921C982E1
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 10:24:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DBE936064C;
	Mon, 21 Sep 2026 10:24:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AMGuziz4DoP3; Mon, 21 Sep 2026 10:24:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 28087606A5
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789986283;
	b=EwwZk0+HELtRM9XgfvQDFnCx8m0cowG1AJoVvQKOQhjj4iJg+3JJkr8PEp1y2wcrb3fb
	 K88Y5HoyYFdN2/E0W5WuLOGSnqzfSelTdxKcxGeZaFkxD0NQKEBe4jeGKgZXit/QZ4V3G
	 1k4r3OchN+DEj3NLDQacZgiv/mWbgS9zs32InHHXRgNETX9SIoeU/lopri8VytQ1v+YcH
	 3RMGOv86O5TOXjzbwoFb97FzG3HRfXgB13Ghjz+czjLrGj3q3bPmxrIj2oRYTsFWa5MmI
	 NFT2CBtSSKxCUo74QQUizoo7dM+q4cwQ8nvfDfOu+N1zDq7Dv2cjsonZyBKZAL+f/+A==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789986283;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Content-Type:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2Ke1q0WVuKLdJdTV0d0YQRknQfez/MK9avN6PGWA5Lw=;
	b=gbdvYNxhXupRmA9oBIylO+njnFFGVldoAI0ZCm/P8pfa0Qfza5fsnTPsgJaYspf82vaJ
	 HWcCpj148pUQ1KMlZvEhJhSYyGwdDFN49lTkDTLCG7VQasVtXNrIdYOaJ7Ro4utbWbPN6
	 /Yy1vZ3KmftYvQsxaK9jFyOUyyNSal6gk3PIT8wQ76pgLTurN9JZ/fCkd3p0aiPDT5sJI
	 lPIcwXeY4c+iiJBxhRexs3Df0hqiyYRSMMKH1fRJ6cwDqBwI0mZ7E+Iw8nO1kJrP3oNWo
	 Y65uBknM9XrEeqelu0B5e7li98c/jc2ehhD46/QzzvR5f3uLUsA5nr6DKviZcDuF75w==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789986283;
	bh=2Ke1q0WVuKLdJdTV0d0YQRknQfez/MK9avN6PGWA5Lw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0oYl3fPXFibxAHsFox6i+kRg4BVF1Ma+fu4i3nLTq365rb+x576U7Ucj+LTuP5Sx5
	 jOCz7V0Vvc4nLqe4leeIgnUC4vvrwn8GLlvyMO3I9RM7prtDmsMj3gGDH05wGujTX0
	 GwXoTohfMftFhVsPf5m4zL4j2sEdnr8BKvXzjiJW1GVd8ZsxLlLSYpa8gcTVwW2aAn
	 ZfkDG8eBbUCtLPeF9AYzhfoXG4Acg2QBKvjDT1qY2pWgwHslT7pTt9xS67QyE3zQc6
	 07l7DqatyVaaOJ7QKkoBUD4HJ27dgkXE+CjIPon3g+rBc1ZHFiiUDGQjhfUxDj9mtt
	 GLlpTPDza35Jg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28087606A5;
	Mon, 21 Sep 2026 10:24:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FDEA3AF
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 10:24:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 65CD380C73
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 10:24:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uvw5LGYMrGBf for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 10:24:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 886BF80C6E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789986280;
 b=q+f4kzOqiI+WyTKczIL1yurMXek+qsXQ/W8nujwzGV/uybMYqi7zbatIIQWiApCDqhoW
 J67XGXT8sTIFoC91t9jS+19+BQFHZzOhS60CXFCLO/bHIM1d06ouismx9zq03B2DWmZk+
 YVWjOQTGXPF1VsNK4qxt1BKluvSfjsPaDOVyOdu6QoEy/USCpR8phTNnS6Na9pLCa9but
 +etZuN9ebVkKoAoX7BPJmBqY77gOwadgdZHTSVmskc+5JKN/VZGrhiLDxkvP6X3AwgE/M
 gtCniVs5ppzeemT6BDwFxZteg2jdtk5lLiJUtEfXBFcdkDo5XLFOu6purqJI07MHCFQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789986280;
 h=Received-SPF:DKIM-Signature:Received:Received:Content-Type:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
 X-MS-Exchange-CrossTenant-UserPrincipalName:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=2Ke1q0WVuKLdJdTV0d0YQRknQfez/MK9avN6PGWA5Lw=;
 b=ginLkn0kiPDcU4gVUUiyU6NFrUV5vCScBKSbZv/NOqBjRKCzQ1uPLVt9xcvlRUt6/agY
 Itqu32BF6Dvcq97SRogwOwZuDevReEQgs5elbsCypWFNgTAOePDh6G81fZi+tqmIBZWYy
 w5zB9t3wtS63T3pHUXbqb1bb1OKxMifoR03p9EsDJtvBhe77odMzk+5IumT77D+EB2WQK
 W2maoZbrlO/cvyJet3UMAfP4//lXBsWWkC18sRUb2rDs4T26U31VLFhY59XgsP9uZglY5
 /S37AXB9BzWEQ+bmb3QOINKufiF1nDRK9Xggv/Dxqrd1a4POLqEAO9oGTg3HbDnAKgA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=KoEtLByA; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=KoEtLByA
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 886BF80C6E
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 10:24:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6YsQrBW/iWSykViIW9lXBRHU0N/FUHxmE6PEM2G1glq3Si+fFiXrLH46eebAQPwu+EROYdxx8oytGUn3wT8l83ip0b6QPYNZ23edl3GWNH724ewBh2PdelVZHXJqkD/QTb4cqAsKwLUYHkAg+4mgUzIe3pkiVYz9QPGEssBvKBFADQOy15OFq3HDxZ5yHaDn7fTPCfODDHeRUhpoc8T837Zu6fxj90Lcf42i0hh3C0J/FbSWyuPEzkl/2WirxX6nu34RI79xkZndj13PURks/rZlqXlS1FKnudbLmMfFxY+t665uTQyHC2nJ7FcWbqEOOTp4AfjC8GlHhIUi3kEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Ke1q0WVuKLdJdTV0d0YQRknQfez/MK9avN6PGWA5Lw=;
 b=d4W0AyEzUldojeWxb0YzbwBLRmXEm61vsnOqZqD2ewFPlFAYh3G+i4/apnA1dr8alg+pNXW1ez/aR8ySS7uI+s8jIN0fAelXfvS3R1Uw9cti42tztzDZCoJD4i+wTMKddvb65qcS5/NOwOnLsHOzFWdxvF5zVakX8J5KXa+h2ptUcUecbqudeE2OEvV01LzDPEHTwadQR3BzyrVJ7VbQdTmG3fUcrwTPnIdgvT2Hr57r6KOBnpSSNFm1h/y8HKFHmzYUfe3Ldgm711A5N09ZIRxoC2DgpDJrCefC1CwbKAFzNsJ/w3AcwCUeb7VEjWeU6WaYmxoABR/fWGg9pRJLmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Ke1q0WVuKLdJdTV0d0YQRknQfez/MK9avN6PGWA5Lw=;
 b=KoEtLByAatFC0WYgS6cUj+rPlcPHjg2TpJ6ZTKu3DzHEBPCX0zYWsHuX5Tl/NxGLFKiAWizxI58yhiTdJOYPpNCKLpqxmCR6qAELb9u3ulxaNk9k0eUCnkiN8lw2O1u2bsqHWViL9ONydlYKJSyRL7rDR2psq+ef2fmKQjF+XKF7qIhXdyQzGfL0taKc4d0szjC050EWhvvF/QoRFlDiyjJftvevDY1jiltTsRwebB6dAcclRECe6p+hhduEOW+2jhzgYqG/nImal8YboYClNlmFe8O/QlB0+sN665iz5UVrMQi92m4oEaZroqHabkny4Z4ir2X3kA1ye7eRA5nfiw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MW4PR03MB6363.namprd03.prod.outlook.com (2603:10b6:303:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 10:24:34 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 10:24:34 +0000
Content-Type: multipart/alternative;
 boundary="------------Ykbj9JAW0XEJC0QmNKzjzsHi"
Message-ID: <1b3552ca-42c9-45b2-9c62-9ad7918b5531@altera.com>
Date: Mon, 21 Sep 2026 15:54:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: dw_mmc: Add the missing MMC_HS400_ES_SUPPORT to
 mmc_set_card_speed
To: "baozhu.liu" <lucas.liu@siengine.com>, u-boot@lists.u-boot-project.org
Cc: peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 eric.chung@riscstar.com
References: <20260921094632.19215-1-lucas.liu@siengine.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <20260921094632.19215-1-lucas.liu@siengine.com>
X-ClientProxiedBy: MA5PR01CA0064.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b7::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MW4PR03MB6363:EE_
X-MS-Office365-Filtering-Correlation-Id: 3292f57c-1f63-44a9-afd2-08df17ca881c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|6133799003|56012099006|11063799006|8096899003|55112099003|18002099003|22082099003|10067099003;
X-Microsoft-Antispam-Message-Info: lHyVbzDje0Qbvdy+Lb3nNh+xKQwwH90OgUZxuLAc4HiF9VQ3QvHoZwXeD9Ww5Dr0ci12DNNsLI1zsx8lNkj1Z/JRMpzxixdn1Ou3edozBUj93rsoOYZqN6x2abdQl1uZYoKtf9pbWRC18TiVTo0yEzdkpbXsYx/+K4pev88TQElXuq6WG04xL7RIxZWC3Ky2iB/+2EPbfzQuZjZ1gRVyQmsWjPzDHvOWwiCwhkREblSeeM51hgL7m5yk2YdGjKjFoh4vf2Fy3eQJxO3yFDb7xrVwAwEcs0ADHTlT7voH0L98ZolphPzmgB9A9Ogs5UePQeiMR06MkLR8EhOzSKcBvASJJUvPeKq4+doWRCrndjhpXrTGTY/FVfpsg06tK24lcbU9fKzhWx5xooJ/K5l5lKi5nbQvgQsXRQlJrxAzuZ7Z288TWAvmVf2GHs1Ocpth1RVOdrtUbPusfC8xg0vz1XSRCZLvsVE85nWIg2iqRXvpVI+KL6E/vgTrtyjXZA+rImKpTO1A4rPmRXvvhwb1pLqBl1zyLIzYCagb4MBveN7NWOxjpkA3lC6xFNkYZZODED1elTJTcmktqjeOIS+BaHL/eA/GRp2KpDtEaQpuDi8txSLA4KqJXK6WGjF0mJZGYRX2uhRYYNMRmyan8x2AAuZaJR/C9OY/LpmwS1jkH6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(56012099006)(11063799006)(8096899003)(55112099003)(18002099003)(22082099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0o3R0hqMTA0UlFMeVVtY3hVWU1QYXBrL0pKN1N6ckE3L2JiSUlYcTZxTWJi?=
 =?utf-8?B?NmFxRzVnVjR0U2FNVnA4bjJBOC9BbTRGaEhSZzExa1EyRkNjd0c3Y2l5aTBm?=
 =?utf-8?B?dFkzUXl5cjZiVkxrY0tMSEpYTzRMZEVYcmx5azNEVG42L2VjQTY1d3pwNGR0?=
 =?utf-8?B?V0VHaFhpdlZWczdjaC9ObFRZNGM4U2ZvQm4xYkFHUmNoNTNua1pDdlVPRXVk?=
 =?utf-8?B?dFo3RGtRNWFlQ3Z2OFgyN1BDTmVjWlU5NnJKN25SV3ZjUXhRWnV2cDF1TkZE?=
 =?utf-8?B?NVVHcXI2THRpUFp6UTBpRmdQTlNaZTJKc3FtSlp3Rkt5T09aYXR1bTNpS0Ur?=
 =?utf-8?B?TmVjeUU4YzdscCszUHZ4eENsblZSZkpRZkNNaDJDN3FnYTN4UTh1cTZEY1Jj?=
 =?utf-8?B?K1pzcFR0Q3ZnejJsRUpzUGtmNjB4dC9hS04vdEZUN2FuTjFjcWVlaGJhT1Jj?=
 =?utf-8?B?VE13eGpxa1praityaDRyTjBrd0krM2pvYTRnMGZyVlZwMmsvWUZOMWFqaEJr?=
 =?utf-8?B?bjFNczF0RzdCRVhDMFZ2cWxMSmwxSVpBR3luUU9QdnloeERsN0p1anQwdTBm?=
 =?utf-8?B?R1MyZng5STNLQW1tUmQyRlIxZis0YUFrMmJHY3hYdVlaVTA2U1FYUFFxdmwy?=
 =?utf-8?B?Y200UmRNekYvcVJLdUNRVE8zSVJ3MEgyRFRmbXMwdXlHL0IzOTBOV2RmUFpy?=
 =?utf-8?B?YXZPSTZhZ0EwQTQvamVXTXY1UGpqRCtZYlk3UEl1UCtkZW5hN2xYeG52dU8v?=
 =?utf-8?B?bXlkcFBTdTA2TE9sZTJ5QXhIbGwvUWRpbUtnRDJXeXBNc2ZSZFdzbk1VVGox?=
 =?utf-8?B?VmFWakVNZFF6QWdFd0ovTEJBUE85enhrM0dnVHdIME1yQXo5cXpZdS9ZZFBr?=
 =?utf-8?B?VmE0d29wRU1EYXBLRFJWUkdWMm5KdkFldmV4ckROQ3ZDS2RxMHFLYk9TRHJh?=
 =?utf-8?B?MzgxQ0pvRDVqZVF2dVp1Q3dSNGYzaW45WXR4bno1dUloUG5uS05WOXpURnM5?=
 =?utf-8?B?VWZSYWRPNmlPeW82UEI4c3BKVGVOam5EaGJXYlg5ZWxJT005TFJuYnJZRzFl?=
 =?utf-8?B?MElXTGpRY3U1bU90cXBCU0kybVhWTS9GNGpUSEtueFMrU0VwbDdmMDJBYXpF?=
 =?utf-8?B?UFM3NnNVeTJSQkJCNGxyUVFnSCs4U1NORnpDUXNzUVFkbHBxYmFULzBvME94?=
 =?utf-8?B?aVU5VEVHOUZVSVRRaU16K1AxQ3VBaUpNY0dwSCsreUpKSGlPV0RjUS80aHVK?=
 =?utf-8?B?VkFhSXZydThWT3dXVUxISGFjMTZTaU4ySUUrQ3p2dFBmZXNqU3FFLy9kQjlD?=
 =?utf-8?B?MU8zdTFJZ2JNTEhZRGluZ1R2ZzE5cVhMMDVzWEZJUzdWckEzOG10M0c1T3U4?=
 =?utf-8?B?MHc5azdWdUZnN25hajZ6Q3JBcTZrbjBrWFJvdGhYN28rbDdnczBjaVVXa2Jl?=
 =?utf-8?B?eE1WK1JCNEVaMmNNVkVEYkhuU0lBL3RONmE3WW95VDdkMTNKTmNXNDhaV2FD?=
 =?utf-8?B?VFBEK0Q0d01Gamx2b0ZveFErc3VFc0s1S0s5ZjBXZ3J2UWEvV0tpMXd1Ym9V?=
 =?utf-8?B?dXdKemJpM0JQc0pNejFhUW0zcDI1b0NUOVMwb1F5Q1E4a1N0ZUF1NFZsTE1S?=
 =?utf-8?B?U3BMbkRMczgrMnFmeStWUktrMDN3TXJacGE3K2ZRSVlNbzNucEI4dEFickd5?=
 =?utf-8?B?Tm03Mm4rakt1dGVvNlFzdlQzTkhYU28xQ2tlR3dmWUhXMU9Ta0xHU3BQSlNO?=
 =?utf-8?B?TkcrUWtLN2hGd0VVMWxycllpQ1FDamZqL08zUzM3LzNFaEcvVG5JM1lQT1Q3?=
 =?utf-8?B?dTJGazJyL0F3aXFlM3lQNUZXUHphWFlFY1hZdDltTTNvZDFmaUZMK1Q3QXJl?=
 =?utf-8?B?eUVFWmtBNGVjQUdncVc4UnJPRTlhWnFpVHI4dlYrZWoyd240QW9nTWFUQzlm?=
 =?utf-8?B?MktscHY1d1phQjY5QitNc3JSR3F3U2JzZ0RpT2tucFBYTjBiM1Ara1UwQ1Uz?=
 =?utf-8?B?NUFFVHY3Q2xPOHpDWEtESUNuL2wvZ1BHMTNrVEZob0RUZmFNbk14cDJFUWpM?=
 =?utf-8?B?ZHg2YkZFWlVubnd0SlZLdEJKOHZKNFhqYzE2VmZDVW0yZzVyOXZoQXRlYnh1?=
 =?utf-8?B?dThIcTloNXdxckJTcmFMdjJDYkxCcmF0SlZjb0JMKzh4Y2FGQzNWa0k3ZlVl?=
 =?utf-8?B?cGVFcWZQRG9IVXhIUTNlZlVnSzR4K2FRZ3hzOG5ZYkV2QW4zcWhQU1haYzJZ?=
 =?utf-8?B?Ri94VzBvWCsreG1NSm5tVW0rcHVLTFNjTjFBdTNlZ1Q2ODcxZGx4NUV3bE41?=
 =?utf-8?B?RzRpTmR2S1VLdnczUldCZVFvazRSVkdCb242SWl0YU1uNmVaVmFpOEFPcmlV?=
 =?utf-8?Q?NG932bU7fjI+Xm2c=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3292f57c-1f63-44a9-afd2-08df17ca881c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 10:24:34.7874 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reFKGZNYvK0PI+uaoh3Yi8NIka3+gj0N+1chf2MC0OtOdyUxJsMCehYpfZ2OIi/bOcuM8h7KHqDMm6H4I0wz0RYr8rgnXH9bqQOXYAgVEYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR03MB6363
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

--------------Ykbj9JAW0XEJC0QmNKzjzsHi
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

HI Liu,

This is generic mmc.c, not dw_mmc.

On 9/21/2026 3:16 PM, baozhu.liu wrote:
> In the mmc_select_hs400es function, mmc_set_card_speed(mmc, MMC_HS,
> true) is executed.

Also mention |mmc_select_mode_and_width()|, which already passes 
|true| for HS400-ES.

> The third parameter is set to true, but the judgment branch for the
> hsdowngrade parameter does not include MMC_HS400_ES_SUPPORT.

Not a missing runtime if case - if (hsdowngrade) never checks the mode.
Modify the message.

> Signed-off-by: baozhu.liu<lucas.liu@siengine.com>
> ---
>   drivers/mmc/mmc.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
> index 670e92ee12b..2bc36c1405c 100644
> --- a/drivers/mmc/mmc.c
> +++ b/drivers/mmc/mmc.c
> @@ -1007,7 +1007,8 @@ static int mmc_set_card_speed(struct mmc *mmc, enum bus_mode mode,
>   		return err;
>   
>   #if CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
> -    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
> +	CONFIG_IS_ENABLED(MMC_HS400_SUPPORT) || \
> +	CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
>   	/*
>   	 * In case the eMMC is in HS200/HS400 mode and we are downgrading

Update this comment to mention HS400-ES as well.

--------------Ykbj9JAW0XEJC0QmNKzjzsHi
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>HI Liu,<br>
      <br>
      This is generic mmc.c, not dw_mmc.<br>
      <br>
    </p>
    <div class="moz-cite-prefix">On 9/21/2026 3:16 PM, baozhu.liu wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260921094632.19215-1-lucas.liu@siengine.com">
      <pre wrap="" class="moz-quote-pre">In the mmc_select_hs400es function, mmc_set_card_speed(mmc, MMC_HS,
true) is executed.
</pre>
    </blockquote>
    <br>
    Also mention&nbsp;<code class="ui-markdown__inline-code ui-rtu7ee ui-1i9v5mb ui-1hhlpkd ui-6lrnw6 ui-115g5cq ui-odjx36 ui-1wd3ewq ui-hayvgc ui-eb7xqv ui-15bjb6t ui-1lldw8n ui-1mzt3pk">mmc_select_mode_and_width()</code>,
    which already passes&nbsp;<code class="ui-markdown__inline-code ui-rtu7ee ui-1i9v5mb ui-1hhlpkd ui-6lrnw6 ui-115g5cq ui-odjx36 ui-1wd3ewq ui-hayvgc ui-eb7xqv ui-15bjb6t ui-1lldw8n ui-1mzt3pk">true</code>&nbsp;for
    HS400-ES.<br>
    <br>
    <blockquote type="cite" cite="mid:20260921094632.19215-1-lucas.liu@siengine.com">
      <pre wrap="" class="moz-quote-pre">
The third parameter is set to true, but the judgment branch for the
hsdowngrade parameter does not include MMC_HS400_ES_SUPPORT.
</pre>
    </blockquote>
    <br>
    Not a missing runtime if case - if (hsdowngrade) never checks the
    mode.<br>
    Modify the message.<br>
    <br>
    <blockquote type="cite" cite="mid:20260921094632.19215-1-lucas.liu@siengine.com">
      <pre wrap="" class="moz-quote-pre">
Signed-off-by: baozhu.liu <a class="moz-txt-link-rfc2396E" href="mailto:lucas.liu@siengine.com">&lt;lucas.liu@siengine.com&gt;</a>
---
 drivers/mmc/mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index 670e92ee12b..2bc36c1405c 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -1007,7 +1007,8 @@ static int mmc_set_card_speed(struct mmc *mmc, enum bus_mode mode,
 		return err;
 
 #if CONFIG_IS_ENABLED(MMC_HS200_SUPPORT) || \
-    CONFIG_IS_ENABLED(MMC_HS400_SUPPORT)
+	CONFIG_IS_ENABLED(MMC_HS400_SUPPORT) || \
+	CONFIG_IS_ENABLED(MMC_HS400_ES_SUPPORT)
 	/*
 	 * In case the eMMC is in HS200/HS400 mode and we are downgrading</pre>
    </blockquote>
    <br>
    Update this comment to mention HS400-ES as well.<br>
    <br>
  </body>
</html>

--------------Ykbj9JAW0XEJC0QmNKzjzsHi--
