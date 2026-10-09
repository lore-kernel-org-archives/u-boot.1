Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34AC9CA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:05:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DD99360663;
	Fri,  9 Oct 2026 17:05:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iKfHyD-w2tSN; Fri,  9 Oct 2026 17:05:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B98260680
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565519;
	b=CkXj9SQQ6C+nbQxIA3qOqkQnudXNbI9Gbk9Aj7bX3MzWCwlzCAsvfBUWPEQL1lKOaZiQ
	 KCmHLYUsha8KtEMSVBv1ynqUl34JByILMdiJhW/34TYipOwU6FjVZ8A/H78mhkUaAcPB9
	 l4SV0Kt5ZByVHMOslhnda8yxEV+vm+cw5zBMB+VbdcUru9JUC/RhGi6NW/6imLAYBCZRh
	 Dn/+oKHRmEtLTcLBEeoOFtAvHW+A2EYE5ieZ4ja23Wd9OWUyFNZKsu3B+XegksoIMqXtY
	 oxpZ4s8/1fQCedxrmDK8r3Y0ZONaQYcM7uORlW8gbYMLpuQkeeCFiahUXGyxWopJkPQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565519;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=xFluIbMeJiOqHMavS1aFliaVwT4R2Zk3M77bgi/0LrM=;
	b=tdJEUO56Y82aW4ZyQEczCO+DRU9hIFUe4kzSkodCsSzXcGCaKiV2HstZAztvVH87aQwe
	 4Meaw9Xu/a2Ph7Zc2pGx0yC3GgITTyfG7TO5V1OuFBv4bvMvaDgE3ofCw7cFrofFpg1iO
	 ZBkZIop7FWZsPa6DK2Mf14qMmrK/46pxquNYzFyTpoqciREjIpVSmjFncnpqCnSRvcN7b
	 pUyRSzGPnJga2dU9X21NovMoBjEKRkavlYlS6jneLSdbv1K3+N46ML1bU7U2YNGtoQihs
	 B0NfWH/ryb4er97lctWvg7yhnTQAq9s1hLgjw0O5Btx87JbITcmmJM6tl+kVeo3hKZg==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=a8z7SEWf;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=a8z7SEWf;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565519;
	bh=xFluIbMeJiOqHMavS1aFliaVwT4R2Zk3M77bgi/0LrM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qHpWnCu+6LHmwfu1RPnzUgtvlPITPkJGpPR7bScAa4I/qaQ70lQdXXlHhgkLibsn4
	 TwU5XE0gDJW/7wxPOKx6N1e8HJyaUYeLcHEcF18TXXyHnW5bdtpYT8zGVuzH7AJ8ey
	 ReDz3bU0r1X7EovsWHtBGAbAHaM3pUCTMY1NQ3aKFfA05zLxdnzdHG3Rw7XWhhvKRL
	 X/+NqbR2BSGr0VCJEZZp8W7jBp1jCLyBxBfKW+AX+6Lu05wF4W2C1y75pIhLHOIbWG
	 8I+TfciAfcg8cMO007aNf1VNPyVPBKl8TmZj7gw82IagwZn5yMkRi/SxcimC2SNSLM
	 XvOkURd32zrcw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2B98260680;
	Fri,  9 Oct 2026 17:05:19 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id E295B317
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D0F7960680
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WpYLMbdcrYJB for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:05:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D794060663
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565517;
 b=KcYMb21KHAOkL2X+UUSvn5D+M2jpifznUfalYtMT4dIPB/5b0yCZCb8OUbUMCTjyHY39
 OGfdUbwXsYRbupUk4uJeTXghDkDOZhK0Du4bSxD3AtwAxYXgpB+5S+N2qquarr5KjBqq1
 inS4DVjcbKEyhicfmqcr072dK0vsApt/QUaDx9EE4i+svrfgk6uij5M/Zfa4dMimsQH2Z
 iAfV9/HxiuAx2P0XZT6W/uPVdOPURgXxBcVAJMSgrsvXXN5ANKb+PcxX1m5GpVwGh+gnE
 fUzs0S3N/Pw02racYfs0Xvx6Nz79ipPv3aQFT07D2gFG4J1e4RxQqcstEiGuQjsRAXA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565517;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 bh=xFluIbMeJiOqHMavS1aFliaVwT4R2Zk3M77bgi/0LrM=;
 b=UUt1GDQSvkMl9JCKHTzWp0SVWpCqA+UYNS5AnpHqFfXO6wyOZh1qPBiEV3RG6ZM4t4T0
 O6HYSF3Irfo/aHRk+At9MbpxP28bO0pRMTvjSrJ7T2LC+lEkqXlEyddSfzl40YClnA8Dy
 97IMaj0zZ0NwAHPhatKqr0iHs+SkxMHtwWO9POi9mzbWeXUPXEN/47oLiwGT1egW7cmGY
 NSsj9FQvFgrUVlFU5IuWkjqKAYoxAGGoaowuplZ89UkIjGMyovKTf2msYVHrccjR7QRFb
 4Quzkzv7fpD/Q+LLWa2RifxK78QMBFOoFDlv7/aAyCZ9J9y48gwLXs8hj7Tfx4sUEjQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=a8z7SEWf; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=a8z7SEWf; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=a8z7SEWf; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=a8z7SEWf
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D794060663
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:16 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=B/0nQxitDySZfFbfbtvQP9vmWg3wwtuZViyglqZPJ2DOtUv+voBZro+3l/9yy4Fwl0UQYlV+0p7kUGnwxfQvsh/jfx3tfefsttaoVMMYwFJe4rzheQwo6pwg65IpF+bUdNoD4+38dm+EX59WsuZO3nzJRA2HJF0fi7Zj7Q2fJil76E0Co2zlozjSMBWZNOlFVnndPL7/jwGTbWR9Pm6npip/JwZdfTE2GkP6OckRnsgKf5Rnq5FeVs4CBoMRz2tFkCnTbQrr0xe3eRD9gTG+uObx8Z5M7LOQ3m041BnjeKoqpRfuCeaPYktytZKLm0ywI1v6pZr1/2/Sn7x1Vl5I+w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFluIbMeJiOqHMavS1aFliaVwT4R2Zk3M77bgi/0LrM=;
 b=t1wlTovd8EZdkru90Hg0RyeZesQoJolhspLEPA1s7xBrvXE9VLR6mjkwtSrJRD+F9NzSFwTOyPb50ktD/tYuf48vQChnEwOmyfFA/WCxENPANKqdGAdn2uXf7cGvrkkFD/+FhTvzC3jgfU3rSmPjzWZQVSiA7z1Zsu+Ifn+ugOgIbFZvZvmQuXPXZ3lUNJGv3yu4yVGAywbxbE9fwQqMCVvMxSdruw/sBZL7iI2k21nspuwEWm8RP9XGHl69+JnbkupfKqgJ+aB2uXaHFUVyTFG/5RvIgXo8SRL1kY1CAfc1ikvbGfw2HCRcXMrHaJ+tdPmVhhy69Spo6AE9ndZHWg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFluIbMeJiOqHMavS1aFliaVwT4R2Zk3M77bgi/0LrM=;
 b=a8z7SEWfNcW5N03M3YRb/fK1qH3peNPtffXLda6B1u+cLpXuT3S/+/pQKbv/Lxe/LQodVpTT9DYZ6j0YtstofXiR2UwhS0k7YxxHHg+DYpDeuDdaP3EfcZjTAX6Id7YYQDIOJPHsn/vkDl5/dUlhItUiHXI2FKKLGtu0M2BRZpM=
Received: from DUZP191CA0039.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::13)
 by DU0PR08MB8730.eurprd08.prod.outlook.com (2603:10a6:10:402::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.35; Fri, 9 Oct
 2026 17:05:08 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::74) by DUZP191CA0039.outlook.office365.com
 (2603:10a6:10:4f8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri, 9
 Oct 2026 17:05:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:05:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kgFeKNkZHSTLq1Ma1PdH8iZqO24nh20SIpyKTriBCbfCiiX4O9AAVVDgJGj0/BohwhidzqTU5ABMAd0paKXfOBNw1+kcvOIHTW+DQhdEkRzC7G+HjuAFBFEL3wkesQlbF12IejfRtseRMv4lN8uRUbU7bo5uCnZNOPqsu3nDhBk1ZOnofFLfGXgrqgxb/MPJqUyvXbnFVtaBQgmVvxy9ELkEXH3rS7Qvh/zYNAMI2U3ufVKxfUJadQ8+TQzX6WegmzQ+iwHfyfhbFK92YCwiSfa8kaKbNcl2F5SmH/cAczzbcGpJIXFbMCFwEIAae4Jog9SI0TevjpG8PzuTooLLPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFluIbMeJiOqHMavS1aFliaVwT4R2Zk3M77bgi/0LrM=;
 b=qpmCLdBuxT09VFM62VcC5FTDeypSoUf5bLER0bJZvgiKkDDNgLsKT9+W8v8qRQJHZgAjqp97ZhFGZ6kpCtqKNMcdMOrcNGAXMWz0PeK7LgLMxlHggiJJZBTTli6hloQ2DLYo7LdXh89mB5D5+kltHneYVmeNYUZWehnVIkirA/Xgw4SzFGu/8t/IJlRpSAUxSIzHi9hHBI0xr/0vycvVlqKCIeY58Srt35aeu1iZv7hnbQ1aUJwgQTpuUjQOjGtmbPvnM/qqCqVScJSxRawN4W2rwc/k1NNWhH3S47YZ4T+0O0a1Jo/UGH6JCPR/h+kgJhXqqgGx6hQilLx5DPQRsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFluIbMeJiOqHMavS1aFliaVwT4R2Zk3M77bgi/0LrM=;
 b=a8z7SEWfNcW5N03M3YRb/fK1qH3peNPtffXLda6B1u+cLpXuT3S/+/pQKbv/Lxe/LQodVpTT9DYZ6j0YtstofXiR2UwhS0k7YxxHHg+DYpDeuDdaP3EfcZjTAX6Id7YYQDIOJPHsn/vkDl5/dUlhItUiHXI2FKKLGtu0M2BRZpM=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB10251.eurprd08.prod.outlook.com
 (2603:10a6:20b:647::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 17:04:35 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:04:35 +0000
Message-ID: <7cf9f042-30f9-44d3-8214-af1487f46699@arm.com>
Date: Fri, 9 Oct 2026 19:04:34 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: phy: dp83867: fix register number for extended
 read/write
To: Tom Rini <trini@konsulko.com>,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Cc: u-boot@ew.tq-group.com, u-boot@lists.u-boot-project.org, nd <nd@arm.com>
References: <20260907095641.28754-1-nora.schiffer@ew.tq-group.com>
Content-Language: en-US
In-Reply-To: <20260907095641.28754-1-nora.schiffer@ew.tq-group.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0506.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB10251:EE_|DB1PEPF000509F9:EE_|DU0PR08MB8730:EE_
X-MS-Office365-Filtering-Correlation-Id: 278198f1-ff53-448f-678b-08df262778c8
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: /YLTIdgGS8e/XdQL6+QacSxvOis8zrKnK/ODPBxsmTDeHDqRFYdZuX4r0R+cmEwIdFqRcrm55OK4IREZ7ktWAjGwC9u5MALPqFy23GNko5rIz2CFIizy+2njsJK87U1m4KHJJCw1Kx+NO7+bXn8UYjXGAVWYszrHnzzEwpKmn2843W2FGbrjjh0fph1lAoXntEnlX9boAaWU0DMbeVy6pCaAyhyndsAb60+IL/viDavyMERKeR7vRmBGjHGKBfVPvo9XeB735Sh5E+C3LyU2vVlJBZASDyvoLy2n3pgZNbnUIDqsTI0yVwkzA7b2+PYquqXzSoN8P159GaQK0oRxSZbJh0ENxcX1lf7NJ0BOt2efgbUnYDcfqZEWEw335vvxNk8Oa0QrOfqPnaglpm0vUMlzGCWqqXIcClrW8iwEJBYqSFdzpraT/tlaGMTWzLLO73+phI5ktctSwywbyVWV1bRZvZQs0fUcOU1tkCEQ1qy4ztDvP7Jt3prYQYOkymZ09mhAZP5iC9choyfQNlZJeUC2oGdJRFeVJyMtLvxS13BA5lMnrTDGJzmsCDBqfJ5rxJSZd71Ck0l4OVSVX9txpo15JlwFyIR0ABVzQaczT6c6Dk8OrUuSQ9Rqb8GqHu2qRl5TRuePsewJha4ZDxDdrzfALoAPVUWJyAyOS/aVH4s=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: DxnJtwF7afUCYnh0xZpug+d8Gvfl/7kDQEkGF48o9Err3vJYFPO3AqDNZ4LPZiHNbKPNl0jDKgYq2dPPe90VunU6GVu7/+LN9t2DRLmSzmU0Qn3aEwDgmndZozW5TFC145Xgg/8NiW2Xp6570mmztm5yyEK6aOAW4n6wJRFpavJQ2upaa4eEria0v4CsDPHhlaR/pe/uU7vmylpxIvKhqzaMYC93cnCumxXuoWsr6f3ejK2gDL/dt9Y4N8opIhfUxz/8IExhH+G99+L+c2CpOne+PG9B7DmnF0ZdqbCpko4PQpjO8EWE4Zvm9E8H5tZGMFfyzVT8R7OQRhHjaM2PEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10251
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa67094f-f348-4689-1899-08df26276567
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|35042699022|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: yjdzoVw0F13oEFTs2qgTSSMh5HzQ5TjV+mF8pXrAdL8L+9Nbsmcx9issdAN/PaqD7s9ZjAbkzzJH3Xce73IyM6k+dKbFcBzvghXLH5nooIma1beJKHvemGX5yPAFEmntozUJktaJAFRBx6+xaygFJWiuJsFy8wVk6duqCNaMFznGJVCZuqxnA4lWU8jKFdh/Nuyu2qnU+59HqOhGFH+r0o6lgFNW8Ki0ywglC15zm81SUh3fh81GQ8O3+l/w0AVzi0whdDNeYR5ZahnQol2t/vaf+hyEv3yy350MqRCiJ/NRU3HZOxwPKcq8iHcyvvw+STRDQ/4WziVuafGuHvCjCyptSJm7Trb7jHIYN6JKnBmXpmv3JqjXmDtKel+KBKy/bjLp7ZsfPU9GydbRgZCrcc9FfrvPTRDKV1vqtMEq88OFJL57s6JFaZtbLyyoEU4IIMSk+WVUSpWD4SsMNGmENPaptEbSVvkC5SBv+Xd4gcpaqxkEJ78SDI/simzfqfPZyjHQGAI48mkTyRaI/ZkKS77KkBiF+IiKC9PFPxuSdlscextdFa7M/UEgj4/gl2+P2OhBpB/gwPoI/rCe/9LML1z1pxzcHIy9IFkSXDEDRQJ4vCfSOnEILVi2NoP9HsWnY8EJrrEh7I9dGU9wFj/VWLhCeUb7nfluSE7weyULczBPBB35NgO+Kk/dxdqYBByRVPmYR0y5dj2bdeEiNFzXyw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(35042699022)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aAznxobHc8XtAqu6EBnAOOGulnjcB50As83qisBan+74kdUzYgsITz37rzjhB9m3C8sn+cJ5lr7KnnQYrVs6N72OuHK/iiWvXSjyQJj2PLXXXZfuhbd5SwsPJTpjMqFqORHuOkweCSVPItXBU2uqUlyDkMwzxJUUyBIexddDSa3+BTDpOObtjcQ1Fn7JtM8ASQcgsDpaee9qRU/M5HyC80/PQXBp2lQ5cEuFwnI2WyQjdVRK8rC7V6D1lG638UAr4dicQ7kLpNSzIuTX6NoCox2NyYe+f9CxYg4XXa7lpq35It7xAd1NtKoYaxfBrasJ/GfzAeRTAwcoSLWxTpXh6VLJUweEhfnFsRv4+d3fIoqsFfvn9yjFnpfLZ/+l4MPBDZTYJiRMb5+ZtOCC22FiR9j4pW6BXSAUvaU8iFjFhThKzubWxBuPk2EG/ZZG0p/Q
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:05:08.0871 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 278198f1-ff53-448f-678b-08df262778c8
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8730
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

On Mon, 07 Sep 2026 11:56:41 +0200, Nora Schiffer wrote:
> Actually pass the register number and not the PHY address to
> phy_[read,write]_mmd.
> 
> 

Applied to u-boot-net branch for-next, thanks!

[1/1] net: phy: dp83867: fix register number for extended read/write
      commit: 436a9ec1a52372f75971309c29462fab5e906e77

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

