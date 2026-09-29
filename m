Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9BDCA5FA1
	for <u-boot@archiver.kernel.org>; Tue, 29 Sep 2026 11:04:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77911406A1;
	Tue, 29 Sep 2026 11:04:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FR40VmSG3p5f; Tue, 29 Sep 2026 11:04:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org B4AAF40680
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790679855;
	b=bCBHa/9ZQcNQFC8HSiuNeIoWZZNHBNUoKSVvdqVDC8n0OjAzvvFh7B8uxkDxhboJt139
	 ZmaoD2dSGSHVQmuhYkLzxXbs29Vi+TszQGlOSZBiO+c7Wupxw6eQS+C4x6POjLbHCVBOr
	 tRIf9i2BbnjbDWr788cPM3u7+dPBO3Xlk6Dc7PWLfnPnwOsmbh+HQD5rTXgi5TAIHVjKo
	 lHgUElUVwWfi1g+3+F9GwWlY03/NE0yObn8YcrOi7Jz6z2OS8TVHbMjpSAQi3WXWefTjy
	 sZeVTBcKwbvmXf+hRbtVKgwDXvKy+BFRqaCH/7b4V2dnMRgEmaZV7xxGeplL/Af3eLg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790679855;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=PbvglTu0FoMKeWRHpzc2689nPQtrnHhz3F+kXTlUSOE=;
	b=p1pDryMYGb2axOdOJsYv6Vw3jd8pRgdTSK7+x+k3IOI0I4Hq8JNcnNkLiu7bWc5RW0JT
	 9EkabdEPdgi8BgcLPs7F+1P/uPyuBzAr4JF7eNxp6kPHYS6sSwBC7pRiNMNCq1j0rcpYv
	 V/io5+G0bJl2V5T+mtEbxUH4wYSO74tVYvPf+eh2aqOUgcRKABvH5U1p4rb1fbKXRAhGH
	 w2ccUP/vpJrNtoX5oRSf2uHUQ2+2/wrrQOLvrRxFhQ0l/EVrlkkp5PZnqV+N86zx9sQE4
	 awhgbekX2pn4L9dH+DBYe/0Wx4nd2Sw5DgLbXPD45FerwgLIt/5cRU4slLJnhtKJhaA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790679855;
	bh=PbvglTu0FoMKeWRHpzc2689nPQtrnHhz3F+kXTlUSOE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=raCQMyE5l1+ioh8RxN1mpeyAcJ7Wu+3KGJiewL9x8mU9Y2zzofZygCBaawOzFHnWm
	 VD/NnSuHUlzr2y1NlMIp9eBQLftTYBPZwId9Xzj6VL3MUFgyjBRM9v5PtjssRBU/+U
	 Grdoe0rQz8HQXLQLWQPhxp9hddrSDlgn0MzB9o1fFqpwMgy6o/b7HJVsll1NANFktl
	 5/fwQC89VXaakc7kAER/F5UDhb0b4PdDMb3I53TMEgAFk+K+DU8jgWnGglSkWxJQH0
	 mECKGRv3+X7WicX+YUZ+7ejWckwt/6zY7y7YDkxvMZ8W2JsXABTzh3lnFKwPh3PSfo
	 Qo4AOYKwUZNWw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id B4AAF40680;
	Tue, 29 Sep 2026 11:04:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EFAC92E5
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:04:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D60BB4027D
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:04:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sDb3E5clsVOd for <u-boot@lists.u-boot-project.org>;
 Tue, 29 Sep 2026 11:04:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DDC13402BC
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::9"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790679842;
 b=rZQXF/jirEZd1ZPWM8EJqz2A43VpntcaqVhQ1EmXkofaeGwwHzBKdbWlWwBkCoOE+QTt
 KmZa/Sx5ejk6Pf1r4WDJtkJUqTUmgoGWtbvqIUfbw2yxhoALIfkgNepMK2wydoODZeKQo
 X5ZXFvyJgTJfGft8e8WkNI/baMfVPJUYbLi4dXIJ1lofGqbh8oh40Q19pJyEN39ZUQYsL
 G3qEX/3ZpVLMFPyGoOf+Duv+EhEm/IGgLiIrIXf7JeppSNGMk87L3gIIaHb+V1G2qPx4z
 RSaXtgD6mX3sQ0Y8xMxR+RwEJvSjoOiGy+3TJulJUkQKKj5dN9jqNJZzrzKHW5/I8ZA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790679842;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
 X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=PbvglTu0FoMKeWRHpzc2689nPQtrnHhz3F+kXTlUSOE=;
 b=Kjz6NkEus+Fb7YRKNKnMUSITeHQQtHWIVDlG7H6efbd4QprBU91HZ9E4Z6Bpr/uVnDtP
 lLFbR1hQ9sQ54r4w/G8+v69QbacD9DfnnyBmFwTn9dhQXZfqbOnhDFmU6ZlvVKih28aAW
 7zFrCTbEjBWRvJ2/35GXKryUzcqoT2VCrfEgxrDLOVIDPkYaVJ4kKxP6JL2AKtbg9F3fm
 Di1NOHdh4X0U1j56zKzsBeVPrz4sv/g0GsW2qLc8cE/4oP2Ftaghyk0lx7u5i+sMGGvRf
 NQm1tBXTY0xm/9ulNBid8Dp5uS9DGkE1hfpw3NC17SoN9MuOxWe1UH1vmC7WL22CiwQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AHqck5Bp; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::9"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::9;
 helo=ph7pr06cu001.outbound.protection.outlook.com;
 envelope-from=suraj.hanumantkakade@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=AHqck5Bp
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170100009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::9])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDC13402BC
 for <u-boot@lists.u-boot-project.org>; Tue, 29 Sep 2026 11:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkO+B3eP8/uzMDQUO5E0t1+kAwIAczzpGCsmCIF1auaLLLY2giW0Iv4LoNJpJCDGhmzYs8KJK8B/dO0wpCbX6J7/QclfFDBA2N7OOFcr0DounFMUaTuBYOBtTVbyChY6J+CCrEKdHzDB5wfPLp8KXDnLFi2bpBoIpJylaW5f/4HB/Gplrf7uXcQwtg9M0k/ei1/0ZGcvkECuIzcDnJH/BNTCZ/YZE89nkx81gMO8WOoY+u/9QpMjmRkQlfFSwXPxjU4I5wx+IHZEPZKdostwmAtzeXLryBxXolMOwNDnlMdG+dxa6Qm7ryy0XmtEd5IH8HyeG7PzKfWhktf8+7UZgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbvglTu0FoMKeWRHpzc2689nPQtrnHhz3F+kXTlUSOE=;
 b=M3w3UroRjeJ6B8oaEALGvk13VnPxeXKHI076w1gGblMf7JUoNvViZd2ME0qFtC2mvTJ0r1JQJ/yo+hwlv+vVW6zKkAtZugMqmcI1kiC0PS8IYJ1ainE1iOs3M87qhKhy5g480YNS4SsMpUiPpZg4INEt5w4AIojEWvLu4yvpMponN+mV+KszG9XmJRRu1jZD33xgtb2oDXsydG5lqhA/WRG8ljDMBJ0xdljXPTZXkhXSiX0bNa2o/BcGcouFu3xEoaqwqAt+oCd/9TQCKALnHyToyonSriPlqnd8jrrIUV4b7YUTIp184hXr9ozglIFYRXtj9YTNc/iaFi71dMbrwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbvglTu0FoMKeWRHpzc2689nPQtrnHhz3F+kXTlUSOE=;
 b=AHqck5Bpy4292e9THqrY2aGn6RnKCAKy7kGm4KKTNnDakXMGCR4ZHw9E3/P4oRWdRWEptoLxmUmA/bUorYGkkuik9otiEWHdVlbbkf2WvwrFzBx+10UkQHlNkYWACcy6ZtZST+6z2DIeuNCe8ZMzQk9jeWcUxZYIiug2Cz09uwo=
Received: from SJ2P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::6)
 by DM3PR12MB9434.namprd12.prod.outlook.com (2603:10b6:0:4b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 11:03:54 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:5db:cafe::17) by SJ2P221CA0006.outlook.office365.com
 (2603:10b6:a03:5db::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 11:03:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 11:03:52 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 06:03:47 -0500
Received: from xhdsuhanuma50x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 29 Sep 2026 06:03:44 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, <ilias.apalodimas@linaro.org>,
 Suraj Kakade <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, "Markus Schneider-Pargmann (TI)"
 <msp@baylibre.com>
Subject: [PATCH v2 2/2] Makefile: drop GNU Make < 4.0 compatibility code
Date: Tue, 29 Sep 2026 16:32:54 +0530
Message-ID: <20260929110315.2879640-3-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
References: <20260929110315.2879640-1-suraj.hanumantkakade@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|DM3PR12MB9434:EE_
X-MS-Office365-Filtering-Correlation-Id: da8ac1fd-4d04-4566-5d7d-08df1e1958f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|10067099003|5023799004|11063799006|3023799007|6133799003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RmCZnydDh1+eIO70G2qYtTlqPVUBp74adB+Ji+ELIKMV+0WwHaTZXR55VcAiK/FVplrqE9bgOWQtueJDKSCMIx0EI/fqMIZY98D2JQyhxwaHha/lTVrNvdOVOeLeFfnBnReyAPcbcsoJyjr2bV/8t4EA5+Ho37zX4i6qigf2Ev1scIZW2gKJsaJkLlpJkTO/raB5scLVAkjq9x4R7v3qC8ZkV+u72RskAMOeF7QwVKCBh2GgCrh5ZE1aDKCo7V+6voWX7t6911wNsdXp+aAfhaloII/hmuR80k4CMiwoOht/m4/kJDclUoam0qRGy+bECUTt3iMu09tDCW1OsbBmYdvTT8z6UcgOwgHF8urTNjmhQt3ZPq47uvU/HKscDosOzYHOV87m2fKZykEYSjF20EZ6wLV2t662gLhCe4TOvIuV623pSrz5MMxgGgqQZzC+u7BitLVP3wKtBsC6X5eMt5zFWSMRqIGw/BhEHxghzdOT7zjiPq88rhg6c0iS1hLTaibcK7+TbuwzVvmVKsnU7zRu3chKoW14xIow8Sa+J/Aqs0fUbfz8u75180isxRbqsB023MVyir0uVg7n/k6fklDqVt+jMRVQ6j5sW+2NPYSJNdOpfTaaFlSSP0vQq4uCCgn34H55YoQ5nBk7cSbGmPH9MrXdjvENcYVj9LhmGkZ9fE4W+DMhcU9QjTKLRLyBAr6znc1eee4uQUwovWWUwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(10067099003)(5023799004)(11063799006)(3023799007)(6133799003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Y8WyFnMAf7xi7UIZ8bU/qNdTyP0No8L5+9eb9vwutEZ+S5ekb+6+LIaU4+sWfoYXp06WuxJvXF+h/jHb9UHha3EqN+0oUfm1S7VPx/AIOrOuQ+ZYL5CiiIjo5z5xQdjC0ZERXhD4kYc8OMWyFFeLtwL4xR4bvCPjiMPJ7MQhfYbZPkGVSomLjp5/VjwQMV7vqeLk0QI7qAKWsh7087o12eW+ldl6I9BiVGsXgL+v9wk4Ngq451l2ZMTkF5lMU/NdkPt5vbJ8pQgQQkNk2+np9u4ve3Azzxz0sbWrP3tf6ap4VCO+4EyXds8ylQ7s7+n8XyXpmT9DwfJlRwF8nEVzWEj8kN2E9ZY+5cmGu/du3XO3IZ+P34k4Equ0DxPEeFFFmeqiSsL3SVDHUOEBi9DhSANUlxO6QSvhTe37xDALRJvlF+wa5x8KBgNNjreR9q60
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 11:03:52.4360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8ac1fd-4d04-4566-5d7d-08df1e1958f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9434
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

RHEL/CentOS 7, a popular distribution that installs GNU Make 3.82,
reached EOM/EOL on June 30, 2024. While you may get extended support,
it is a good time to raise the minimum GNU Make version.

The new requirement, GNU Make 4.0, was released in October, 2013.

Raise the enforced minimum GNU Make version to 4.0 and drop the
now-unreachable compatibility code for older versions:

- Add an explicit "GNU Make >= 4.0 is required" version-check gate.
- Simplify the "make -s" (silent mode) detection to a single
  unconditional check instead of branching on make-4 vs make-3.8x.
- Drop the GNU Make 3.x sub-make workaround, which is now dead code.

Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
---
 Makefile | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index ff5c29a4918..b731fe9087d 100644
--- a/Makefile
+++ b/Makefile
@@ -12,6 +12,10 @@ NAME =
 # Comments in this file are targeted only to the developer, do not
 # expect to learn how to build the kernel reading this file.
 
+ifeq ($(filter output-sync,$(.FEATURES)),)
+$(error GNU Make >= 4.0 is required. Your Make version is $(MAKE_VERSION))
+endif
+
 $(if $(filter __%, $(MAKECMDGOALS)), \
 	$(error targets prefixed with '__' are only for internal use))
 
@@ -93,15 +97,9 @@ endif
 
 # If the user is running make -s (silent mode), suppress echoing of
 # commands
-ifneq ($(filter 4.%,$(MAKE_VERSION)),)	# make-4
-ifneq ($(filter %s ,$(firstword x$(MAKEFLAGS))),)
-  quiet=silent_
-endif
-else					# make-3.8x
-ifneq ($(filter s% -s%,$(MAKEFLAGS)),)
+ifneq ($(findstring s,$(firstword -$(MAKEFLAGS))),)
   quiet=silent_
 endif
-endif
 
 export quiet Q KBUILD_VERBOSE
 
@@ -166,14 +164,6 @@ ifneq ($(abs_srctree),$(abs_objtree))
 MAKEFLAGS += --include-dir=$(abs_srctree)
 endif
 
-ifneq ($(filter 3.%,$(MAKE_VERSION)),)
-# 'MAKEFLAGS += -rR' does not immediately become effective for GNU Make 3.x
-# We need to invoke sub-make to avoid implicit rules in the top Makefile.
-need-sub-make := 1
-# Cancel implicit rules for this Makefile.
-$(this-makefile): ;
-endif
-
 export abs_srctree abs_objtree
 export sub_make_done := 1
 
-- 
2.43.7

