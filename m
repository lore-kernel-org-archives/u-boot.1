Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A58FC624D6
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 12:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 551BA40ACD;
	Thu,  3 Sep 2026 12:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id penuRKTnWozv; Thu,  3 Sep 2026 12:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 4A97140B09
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788439874;
	b=skH1sosriPVpeKXKOSVMzJP0avZBwWqTu0AYlFJZjDtYDeNEqXs/0SpjBhA9D1NWi1yb
	 Ml9fJsqEltB8erXwWktyZmfJO8zNH5kaIhmin87rfEX9/HfJxcWVBHQxRf/SI4okGJEzp
	 nQYlZuYDzG7YnV+RhXJmtXyRA9diSgc2V6zK9IBWO52ORILdpTUY6eL/VcKJ9awO/UuAy
	 WFhMlk37jABQJtc6SOEKHTIP5ns21ciIqYfWY53cHgGoKiINdeZ/RL7Oqo9ZimHPoc4Ob
	 dDHc7aw6NuoxVz0XFjCcmOJV1IyqiIsT89C0k4RTVKVZw91BAXsK/WC3c3PaLCknVkA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788439874;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
	b=XG+1dGUvUU0lkZYo/fbX1R0XyNwH0NLyWzaVzwrcOvzGc3b4ioOt3Zl5R+oKoR1BWMw2
	 mEk+07+sseqnn2K9GLkdvLD1vDxk4wP2n7TA2mFe6EtxIgZUeF2aX30VoZYpcVTFUymYx
	 f6hfg2r8SctO5+0Moj7Ozt8EyZ71ih8lz5zBYzNLyX9esxqZ9QRMuoWYuhel/Q+v6ur5z
	 3i6Cf5mH+Y4aEmd6j/GExNVxTIDCgMCW09OVqCWLm9Dv38SUnd/U2GehrmFzR+nivoagx
	 AKgbXxe0LXaaInZLce1sIKw9rlAWKl9u9FGIBgQWQ8TFJ54w4WjiwKfiXcUvnZIxYIg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788439874;
	bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tuMs+eoOc8jdR3HXhQLJOGItLoP1UH7tnJtIppX9gb6JVu2RDF+gKX9PHnUqlcdnn
	 aI4AzDIWuf/Z3bP757z4C8uEF0aak0WjSXLJfPHcp4L22QXMDEWTAIOXIfvxex4ITZ
	 WUrOicE5tkbiJlUCoh3hTSu19MRGd23hC6mO1SKcm+wO8p0u2Amfl+h/fQmmJLHHeI
	 GQnyHfwiQFoLJFuJHAxf8Oq9c0WrzFTW8SLNTvBFwhaF7IrbQkXoY2qRmC7FvoHI66
	 0Abp+RyyYN6e14CZP0ld8BCW9stoiUHpW5q2DhE8LsQiw7vdEIEzW3AYeD5v6oqnVE
	 QwiCWHYyRjoSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4A97140B09;
	Thu,  3 Sep 2026 12:51:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 688F7230
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5A7FA80FE8
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U08uk0VqJKRd for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 07:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3EE1A80FF4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788420557;
 b=T2PZX9alliNUJB0zhxEuI9vxxFVVfAdGXbMyS6KqoHAgr9evtAqLPMYOUwuWWGq8dqwB
 VqLxibi3oVRT+uKNfY5yxH6ymAFkUaATcbIfb7uwapzPgtGcjFqxD5WLZCRxFvOEmh2n9
 CzMNmIFFJv2pfMoxVWXlms7wn3GZMgJHzaD1hJD2jIRpnLMc1Rs1S5ybMu3bQqqZ/f9p1
 zA83WDyy2n1U5rBsGFGKDf2tmLUujEeaFNQ8t2M/3UgqxpQaUWhIv0MKzWFN7ovGysKOS
 B7GY75GJNGd7jI48rEM9Dkng9XQukY3GVXjF9dBTckVkvkiJr6SFnVDRayz2GJp0w5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788420557;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
 X-OriginatorOrg:X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
 b=aUL8ODQYRz6tGcWYKgJZyUKaYC0NzkdIcZLoPO3MnhPwq/bd9ELLBeT5dzXMXOLHemRp
 UO2QkZcwG6GFzd14vlyRq3dWMiA5IqIg7qTIa0Tw47gg0e3Sw4c8EyNDFSbFSoYrrlgjs
 NZdiJmCSlByUZYrwIaSkx4gUUD6LxTEw40tSjps5z2nlLAs6i/wN7I4Duf1Vq4DYaLekG
 CJf7D78L9RDRsT48rezUV4a/Or8m6jJ/0rcSvs7A2zec30kNG+ZfAaS9MnJWunTfw1E9A
 sAE+MK2xsAb0SKZGeScYeBZgXHccxpXvU3ub/b7FYqo3vVxXk/pKOUKFolVQ3LwMcjQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="dXR62/Xm"; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=XaUB4QwR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=dXR62/Xm; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=XaUB4QwR
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3EE1A80FF4
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 07:29:16 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6835jSWp137753;
 Thu, 3 Sep 2026 02:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9Nsgm
 G4=; b=dXR62/XmvZAlxE2bhVE1cfPSdMr/zxVBtsRHwbcxfS1dpVEpeAwPQ+gtx
 iTKHydmyXMNPxGzDUp9JvEL07vNvkv5o7Wn6lSxSqps+uFHYOJA991RaM11NmynN
 7PLlETPU8xJkreXcVHpXQbSeRGpC6mAI6qnpV3otN4Y5PiAgHk/+JAT1faus6kso
 1L8V5Q7OoYwFwzozjIVGh0pu3gvWQKX3IEEq2W8rk9vl4MrnsbWu+ucUAWRnTd2x
 j+vgguPw5PiFecB/VuuSz3U2+40ouBNUaSnvrBsogBBbEVeexYdckzr0i/dD4J7s
 cG57ix2gC8XuoaZT65AOBswjkZiAQ==
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010060.outbound.protection.outlook.com [52.101.85.60])
 by m0380145.ppops.net (PPS) with ESMTPS id 4gewt8j4e7-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 03 Sep 2026 02:29:11 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQgP1UHoSDPJdopaVlsAd7oZbBlNBxmnnsOJL1nGLh7ktGii0dNr8N01nejv6OZKXgKqxI4xEU1+XJqFHmhjda+duG13BSF9hKmQdZu2a21X2LJ0fnQ3etdLD5bc2MZhNhD1sMaatFOdN2zuPrCPkN/Ihz9zeUEtoy8cPQeWnTl2C6owPmLAAf3Id6BcR7pyiNPQixqSq5Vk6jMe+kNoB2xg6kMuGc4Vidk6MAoDgrZxByeZvD18fGGLDSCHhyW77hCvAaNKLMYUAJepk8w+nhSBGe9E8HsEEF/NpxcN4Oyu3AkGNtcDah8MEoqRSrJqSYyVwSzgAb3R7b6A36QQhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
 b=a/3zG5XKQ4u7VW2qe4Qfl2PNyMeR8hibuzY1+TuwNhVWDhE2biXdw++2os2rYZ9zEFGvcUg9dRU1ZmCqoyGeyHweBNZgdw0J6LGpbQ6snlqHV0Nywzm5QHl14cVVYg9am0L9yx/x+3u8k91/sLP8Y3axjoM53vKrw9joKa/m/gJqfgJOSRpsllyoKzH+fGM81LneEPDuQJrGxxAgdv+W+3SyQBDrud+dTzIbx4lVK6oNU2x41VumfZC5Yd22CxX5QX0YZ3WpqGLTqbEys7RgA7snpaIoFlHpiHToFp4rnJXB/FfVnzj0ixr1xFTNEeYxTcHuNY3AsRQiYYEKv9yWQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfOqL6iID5eOmGe0jkzHnqOOa1mINjW9x05e9NsgmG4=;
 b=XaUB4QwRR50wnPFUf/YV2LcFOjJii5Q0AqZxbas/jWJ1D0hxq3c0aKXFzoHUtO0MCybqFPigsNyWepVonb7woE//bo/AutKWn/Yv+mM9bElyt1PRXPgS3f5akXXnr0ITvcLZAi8Ih0VHiErShqPhElBh2anwUEizwpjLrd+FNGo=
Received: from BN9PR03CA0720.namprd03.prod.outlook.com (2603:10b6:408:ef::35)
 by CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.1; Thu, 3 Sep 2026
 07:29:09 +0000
Received: from BN3PEPF00022BDB.namprd03.prod.outlook.com
 (2603:10b6:408:ef:cafe::15) by BN9PR03CA0720.outlook.office365.com
 (2603:10b6:408:ef::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 07:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BN3PEPF00022BDB.mail.protection.outlook.com (10.167.248.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Thu, 3 Sep 2026 07:29:07 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 02:28:20 -0500
Received: from DFLE208.ent.ti.com (10.64.6.66) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 3 Sep
 2026 02:28:20 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Thu, 3 Sep 2026 02:28:20 -0500
Received: from a0507176-HP-Z2-Tower-G9-Workstation-Desktop-PC.dhcp.ti.com
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.51.66])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6837SBAS1110504;
 Thu, 3 Sep 2026 02:28:19 -0500
From: Gokul Praveen <g-praveen@ti.com>
To: <trini@konsulko.com>, <g-praveen@ti.com>, <n-francis@ti.com>,
 <u-boot@lists.u-boot-project.org>
Subject: [PATCH v4 2/3] arm: k3-binman: add tinospl.bin for direct U-Boot boot
Date: Thu, 3 Sep 2026 12:58:04 +0530
Message-ID: <20260903072805.31010-3-g-praveen@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903072805.31010-1-g-praveen@ti.com>
References: <20260903072805.31010-1-g-praveen@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDB:EE_|CO1PR10MB4594:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f38b441-3687-443a-6cc1-08df098d0a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: cjeVF30w59o5d5Yf+sxW1TQyOf6CJL2HS4FFbzo6iWLgALImNt3JJLE4gVFIqfYFKGcnbDWEA8mW7RCmJtlC0c86brFrrvs5lRKX9fH4sE291R6irXdkPBYX/L8bj/p9s6O3w7FrhZgtSjoUNEdO0VrvEhNs4dP1/bWGrSIpCghZGNGhSq0CsW5QVu7AUV55q+wBNST4KRTFSjDISE/6aHM89ur0RUXb81wg5fF4A0qDQNVIhD94kkr6MkJ59lqLjZhnMGZkgV7pjTNOwOW0N1tr6+XvXa85W5tQVYidPmPp3L+msqJLlDOmMfAasM5Vp42HdB8QS77dMgk/vZ3ClPsoh4xbrjbnFG6jMHB+S/W2UpNTk+TYCX/9qfQglWrIYqRxGoxIweKENmUlers0004zPogfryUBJPToDEUP0qJOM4WYn5pczVI44F3A/Ubx9Pia5lcCluwLfJGFEpeX12IvuZvODQ6KIsY5zTJD2IK17Hephp1ZZDGd7d+iMtGFui44ep5NYEeHZ1sq31vZEP7jP1MWeObSp84C3/KB4NJn/0WwbN9SLbJEdWWaXf4QEZKc1tGigrncluRlQZlqVjjVdqyXDZ5/rQlc3PyCjGMYEfPguitfw4wibvaLDNIy9h36kpQH7xV0BaKtibNMdmfPFGvFCM6H8GI0++bVHdLRFBUrfgoK94ON+u4nuZEyiLxzr4YNejeqb8EbmxoQ7A==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 82Qe50R5gz6OUjcZX1ta/BVxD5Inxm2LtGJYEM/lCVBEMV6i7U2U0crNheGXWLJ0Bq96o10EEIpOb5nyic3UTfKUibzkyLN64cP+vrNAzUbEpaoUZloUUtF8QstDn02ZyPcUgNpVpYfx7zF963At1h49hjYC3BVWU7zEiWI6QnkXhJYU0zT2asx6Hprk1izrsPxjGfRrDzlU4t34s9hCus0UUnqsrmgDNKxXTdirHM9nweB2+FXWbgOYG3/6mmVgf7AIX1q5+coK9617qNtSbtzkLenUk/h1xKfZLMIsT3PwjgqJfrGKM/x+xCQCArEjr6q++lllY/fRCYfFrsR7itna+jGhH9InMTExiSI8fPOeNAE6iC5XT1FJohATijsUZm6hR5zuddVCNnRbMen39PlgQExM+xIQVqFL1u9gvVZVEJrOyJ0ga3hX2kyNo3f1
X-Exchange-RoutingPolicyChecked: zsXF8SXzLSdA2cC9yhkr2TgxoJW18/wS1SDNqcw/tkggx04591NGAK4SUKo1Km/sUWTgM7PjsDxQsVcFn/l+Oe4dXCd+q4AWIonUOQUv4ZbhnqvNkmlr+CedBiWc8cddVbJOtQp2JpoPLljKmmMWenu7H8Q9YVl1wNhduP5oBF7T5j8D4opIG6YJkjTgQHDjlCr9z+wDVh1k6SqOIluWqU+LRUBVtBPHaKC1DW/JV4yf9jOGBckvXLSNcmIJcqQ9e5IEdDOBvRrpWnmYPtsRaf7rUvsC8s7qGZVfS3tNY3xaE1uQfatozyUNR2OS1Qh5GE4zX0no+aerPu+8oGJ8lg==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 07:29:07.9268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f38b441-3687-443a-6cc1-08df098d0a76
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BDB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Authority-Analysis: v=2.4 cv=de+wG3Xe c=1 sm=1 tr=0 ts=6a9921c7 cx=c_pps
 a=tP1g6Cq6k527JP85+VkTLg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=sozttTNsAAAA:8 a=d6pU8RGRqkria7-D748A:9
X-Proofpoint-ORIG-GUID: FxHBqejoaVTrOSY4mUyZY1dJf3ib12ZE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA2NSBTYWx0ZWRfX4MaAgCVP40Dd
 yakbx/0xb4MoQ/EJyyPSz4VSatW8UHFtvBZN5zzzzFR8EWLyXZcV9IzkqjQd5CuWlX+aEbm6+5R
 oJTB4DXDC6mMx1GGiBKql1GLasALPjw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA2NSBTYWx0ZWRfXyxmZCsq5iMsT
 ivgtp09/o7Yl0vuAROEkwloKYJtN9IX9Kjf51BoBu4XBvQdHy64Ay2lgAtaIXNibBfx5M2R6s5t
 O9hDExaIzjF2bA9kB5qVdV4O9dNNmnSu18B3KMcmJtIaAjkTcXKFbSoHUJirur8RCTKKYXNC/9+
 fuDZ/IBWHR212KdQsjhMpCuz3b0oRc1dS9oqZMD26738QQxPB89fDnohMr15oGOaFqULKXDyRLn
 3Zf+Vh9G2D0a/DKpelrn7/J7271VwHU1ZvZk7iXqcIcACQZlomk/W4Ketv7Bg9EvUijJaI83+ON
 yf5t0yPYoQn5Q0p/nrm6oPMP5MvKwCK5rVFr72T3AAjz2Pl2zqCxh3aOBD1FrNmeBUBnmHb5c+x
 HxJscqFPGu47evN1PEqenlVu9m0lIpVr7JSxNmsv9AXu1qW5xSpkL4x0Hrb6lrH15+zaZKbZfdK
 cWXvgdQUv3boEBOqZGw==
X-Proofpoint-GUID: FxHBqejoaVTrOSY4mUyZY1dJf3ib12ZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_02,2026-09-02_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030065
X-Mailman-Approved-At: Thu, 03 Sep 2026 12:50:58 +0000
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

This patch adds creation of tinospl.bin for J784S4 EVM.

The contents are similar to the existing tispl.bin but the A72 SPL
and its FDT have been removed and replaced with U-Boot proper and its
FDT. This binary is used in a boot mode where R5 SPL directly loads
U-Boot, bypassing the A Core SPL stage.

This reduces boot time by eliminating the A Core SPL stage.

tispl.bin   = TFA + TEE + DM + A72 SPL + FDT(A72 SPL)
tinospl.bin = TFA + TEE + DM + U-Boot  + FDT(U-Boot)

Signed-off-by: Gokul Praveen <g-praveen@ti.com>
Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
---
 Makefile                               |  2 +-
 arch/arm/dts/k3-binman.dtsi            | 47 +++++++++++++++++++
 arch/arm/dts/k3-j784s4-binman.dtsi     | 65 ++++++++++++++++++++++++++
 arch/arm/dts/k3-j784s4-evm-u-boot.dtsi | 14 ++++++
 4 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c6253670a94..c6723d63f59 100644
--- a/Makefile
+++ b/Makefile
@@ -2556,7 +2556,7 @@ CLEAN_FILES += include/autoconf.mk* include/bmp_logo.h include/bmp_logo_data.h \
 	       idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb \
 	       Test* capsule*.*.efi-capsule capsule*.map mkimage.imx-boot.spl \
 	       mkimage.imx-boot.u-boot mkimage-out.imx-boot.spl mkimage-out.imx-boot.u-boot \
-	       imx9image* m33-oei-ddrfw* tifalcon.bin
+	       imx9image* m33-oei-ddrfw* tifalcon.bin tinospl.bin
 
 # Directories & files removed with 'make mrproper'
 MRPROPER_FILES  += include/config include/generated spl tpl vpl \
diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
index ad127663d03..aa8479bc0f6 100644
--- a/arch/arm/dts/k3-binman.dtsi
+++ b/arch/arm/dts/k3-binman.dtsi
@@ -543,6 +543,53 @@
 		};
 	};
 
+	ti_nospl_template: template-16 {
+		filename = "tinospl.bin";
+		pad-byte = <0xff>;
+
+		fit {
+			description = "Configuration for no-SPL boot";
+			#address-cells = <1>;
+
+			images {
+				atf {
+					description = "ARM Trusted Firmware";
+					type = "firmware";
+					arch = "arm64";
+					compression = "none";
+					os = "arm-trusted-firmware";
+					load = <CONFIG_K3_ATF_LOAD_ADDR>;
+					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
+					atf-bl31 {
+						filename = "bl31.bin";
+					};
+				};
+				tee {
+					description = "OP-TEE";
+					type = "tee";
+					arch = "arm64";
+					compression = "none";
+					os = "tee";
+					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
+					tee-os {
+						filename = "tee-raw.bin";
+						optional;
+					};
+				};
+				dm {
+					description = "DM binary";
+					type = "firmware";
+					arch = "arm32";
+					compression = "none";
+					os = "DM";
+					load = <0x89000000>;
+					entry = <0x89000000>;
+				};
+			};
+		};
+	};
+
 };
 
 #endif
diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
index 34b2cc1e681..0dec4316d6b 100644
--- a/arch/arm/dts/k3-j784s4-binman.dtsi
+++ b/arch/arm/dts/k3-j784s4-binman.dtsi
@@ -317,4 +317,69 @@
 		};
 	};
 };
+
+&binman{
+	ti_nospl: template-17{
+		insert-template = <&ti_nospl_template>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+					};
+				};
+
+				uboot {
+					description = UBOOT_BOARD_DESCRIPTION;
+					type = "firmware";
+					os = "u-boot";
+					arch = "arm";
+					compression = "none";
+					load = <CONFIG_TEXT_BASE>;
+					ti-secure {
+						content = <&u_boot_nodtb_nospl>;
+						keyfile = "custMpk.pem";
+					};
+					u_boot_nodtb_nospl: blob-ext {
+						filename = "u-boot-nodtb.bin";
+					};
+					hash {
+						algo = "crc32";
+					};
+				};
+
+				fdt-0 {
+					description = BOARD_DESCRIPTION;
+					type = "flat_dt";
+					arch = "arm";
+					compression = "none";
+
+					ti-secure {
+						content = <&j784s4_evm_dtb_nospl>;
+						keyfile = "custMpk.pem";
+					};
+
+					j784s4_evm_dtb_nospl: blob-ext {
+						filename = "u-boot.dtb";
+					};
+
+					hash {
+						algo = "crc32";
+					};
+				};
+			};
+
+			configurations {
+				default = "conf-0";
+
+				conf-0 {
+					description = BOARD_DESCRIPTION;
+					firmware = "atf";
+					loadables = "tee", "dm", "uboot";
+					fdt = "fdt-0";
+				};
+			};
+		};
+	};
+};
 #endif
diff --git a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
index cc0b562d27e..fc6f23736ae 100644
--- a/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+++ b/arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
@@ -87,6 +87,20 @@
 	u-boot-unsigned {
 		insert-template = <&u_boot_unsigned>;
 	};
+
+	ti-nospl {
+		insert-template = <&ti_nospl>;
+
+		fit {
+			images {
+				dm {
+					ti-dm {
+						filename = "ti-dm/j784s4/ipc_echo_testb_mcu1_0_release_strip.xer5f";
+					};
+				};
+			};
+		};
+	};
 };
 
 #endif
-- 
2.34.1

