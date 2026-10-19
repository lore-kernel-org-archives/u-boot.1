Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D99CCF2DB
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 10:41:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 95CE8406CA;
	Mon, 19 Oct 2026 10:41:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oOMgAuvpr_l1; Mon, 19 Oct 2026 10:41:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 5CCE4406AC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792406467;
	b=ii3i8h4YErTtj2LQPXmbfHhjiAj5v6ZaqxgbwO0qexgRNg8UmqBxqoV34SRtqQ9Ev3MD
	 YyZ7hG1JYylawEuiFeDuYnuW9ZXIyo2j7N40GT5gcyYfuUNEAUvHbU4T8xcp3SAiaRxpp
	 WnXLWPjNJfmAE0Yr23ro2nqEwdZB7W6xnSRkEyM9kjM5oIb9b4vGaS4xDnz6M66NxXkf+
	 SbmgVUEi82EYQzlF0IFw56hoWAVbDs3/dsX5Cl0F7Ue2VSVOUviOi+nqrcThDktyHhz0G
	 FYIdsOS3T35bthWQTrOBiSeJZvIwq+1ESupqDCtl4eysgKbI7T4uEjOndgnBfzha5xQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792406467;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
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
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XmDZHfXolZetn0D6REeLzDtLBWek8RVjKhrUvvqXIsU=;
	b=ach0WP6BhC1C5JKVdjyGsHk9fG7qZQldDj0UYWopoX60oyJZ9OyT5Zm0jTyEdo+5OzIq
	 H8QUIpuuB9+HKziBTTRbQN74cspqrAlmHRgNYyHWIbKpjgEOfLg234iOo/OrP8Rj22eZw
	 ZCXyUKJ2y0z6hkzFHiHX7A5IgQGRG2HRwmHjCtjUwlIWWIfYmW6lHLSEK9Vr3situ28ma
	 pTKSeGyBYDzXs8QJ1/pyfz0UuLqXq/4sjrHnurinvs8Qqj/90mOsFXqbABhwLw2O+Blm7
	 CzECkx1xJ821HrvostXGaGt86xJRaZsYVE6J/lP00c6zcWJZUihQMrAV6JBV0eLq68A==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ti.com;
	dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=DBjxXmId;
	dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com header.b=eWp2uyhr;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792406467;
	bh=XmDZHfXolZetn0D6REeLzDtLBWek8RVjKhrUvvqXIsU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MNzlbmXzzl6tERqIBmQ9lc/5H+HD5TZFtBZ7h+7s3tO53kZOZijnTsET2solSLwcf
	 KBsOAaWz+dTYuD6WnhXgckTCeFv1MowL7wXD0HMjfeFdLhBcpMsLR3NiTN2O5hXqex
	 WoqUCx9I5AyCmCmW2qFyHWWS59r/IFa9soZfsPQoAHLFfbLklkmzONqawZAdVvtCTz
	 IDIfiOLn55jhnny+MWnrqoqci/7FMtplq+ZJSs0S/jTIdyyyeBZ2t85fBvWXDa1osg
	 fpEk7Cxfe30AOGcgnCQBUCMJW5lq0DVVQaBbT1lS63zc1HmuVqzaE5/7mf0j1hI8uM
	 XMCsaK571eeMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5CCE4406AC;
	Mon, 19 Oct 2026 10:41:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6F0D31AB
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:41:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5547F4069A
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:41:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pbHjF3v3pNTM for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 10:41:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 16014406A0
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.150.75
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792406465;
 b=YNnqRZY59wDkesp1QVMp/Sj2zl1UrbAJ7wk9drlX97JDcBT0WbOjRfEolem+nhFykg96
 35MPycChqLDaUp1qQKa2OKiOlwI8t/uXXWKk6iZZgtA8BHS8Ee4bZyCCbWlatJXCvcS1h
 OsWio+HnIgJfi2TxbMXt/UXOlH3J0BswaMKRPGcll1fgfEKFHkm8O1JlX7gSk6K7icpe8
 Y+rd0SDaWora33qvvFPKWhJux6lBXnvWc/DhxHvGN84cOQ8is2QqqsnYvhPkB+1UY4TDX
 VnSQpQYwTE4/9JFCjDgxIm9dO61bEGqXDCfCESTQL5oA1BKjhEZJJZg4I3i8tYiQtOA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792406465;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
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
 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details;
 bh=XmDZHfXolZetn0D6REeLzDtLBWek8RVjKhrUvvqXIsU=;
 b=LKKaPYxsq1cML3cI50sQIPODrrVOKrq9S3yQe5Oo4UfFJxJ4/2F7qgZVwNTnu/lr/6xQ
 3IgBoAVq6d6yNJLJMjz6WarmkuFRs/7BuhvcXrmCiz0IOlWH2z0Vd6eOIcay0KVElIRNV
 RClsh+Gfa2ZaDNzTcRtzvUmFg8ADdwsOOL5ZXtgjX/y5Emab8obeW95MUWFWAXdT716oC
 qebRshHABTduZB1VQ5HKjy3yrap+j+xA+OscJwH4+u8AgWeWNi2QZpt5RX0rgVccRKsob
 sVD0T4JcxOs5G6xqxMO8kdEIcRebE1EaSgC8MaIVEbd6+px7B64dBFNYCBWgGhGVIqg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ti.com;
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=DBjxXmId; 
 dkim=pass header.d=ticloud.onmicrosoft.com header.i=@ticloud.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-ticloud-onmicrosoft-com
 header.b=eWp2uyhr; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.150.75
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=b-padhi@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=DBjxXmId; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ticloud.onmicrosoft.com
 header.i=@ticloud.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-ticloud-onmicrosoft-com header.b=eWp2uyhr
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 16014406A0
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 10:41:04 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 69J8MwRZ3814202;
 Mon, 19 Oct 2026 05:41:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=XmDZHfXolZetn0D6REeLzDtLBWek8RVjKhrUvvqXI
 sU=; b=DBjxXmIdp95pjrS53bJRn7bkJHFYpSeC067mtTCWwEr2MDkGiZLJfohnn
 0l+aTw/GRXrg49UouASAznmkIxE6R/bWQYGw7H9EMZVz3/zTd1pEli64isKGlXON
 dH6tqScVE0DVTIxafViGzRci+9H+UHFYV6PAlXD8JQXR1JAfAzgWjpRq03+4Kaxj
 g7pi90kKebQMi3qzwRt6iFEogjyGCUGqEKXYKLKi3cbioJyJKRCMNlhcpaIMWva4
 qefQR5p+u99HS9c9Nz5QxOf6PPHtyt5lhEfarexat14aTLBvkGqbUlnChygoMUPK
 Osb0Un//rdiB3v4eSiqkwDojnXcUA==
Received: from ph8pr06cu001.outbound.protection.outlook.com
 (mail-westus3azon11012069.outbound.protection.outlook.com [40.107.209.69])
 by m0380145.ppops.net (PPS) with ESMTPS id 4hct1jn5hy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 19 Oct 2026 05:41:02 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBZozu6R0USmg6Mo+myTRqorHh/8Y1koxZoF0syC13YgseKRexUoJjlo1NIfC80ii0XEdGz21NDV9zoyoMLETdb3iF8Ofan6FetCPTwahCjfg0rVPped/eq5uT5WmtBwJ+PLDoLCT/UttnNtXwYQxnIFuPbEODV2aSnzcq19OmxfLhrXH1U4h0thVHEfFz6DSOgYV6Fqdt6icE3sDUkDaNEebQf4OgPdkzw9kDN488bsKITvgmpJNUmLES0IzO61+lzkC6DRaKr8QLqOfovXDlU8lXIhcimDxVOQsVL5rvl43JtNlnxEa6mqFyTdYuOWvfXrWHQzxAzvFw0A0w+KKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XmDZHfXolZetn0D6REeLzDtLBWek8RVjKhrUvvqXIsU=;
 b=KA9xSc9lw+o1ODot/tKU2ehIe2CtZGapio6lNxDpAY3RrAqWN9l0KalWkOdRbVOpLt42P3K8OUngYObBuK3Qj/yxf5M13OwFjcxx4qwuEyr9jGD9RTmaX5/Ti1eX9KL5WbMTWzwlZnsujBlw70Ssfadup4Qq1fpGXNOnSUcKCDL6xxLVmscm8nFtYhN6iyWbptRTM8hyeOumC9deh+rDKXEf5M5Gz+5gUFbguAVGRq48PnoEasTC7jZPUO3bkay4ZQhFOX1sowNPUfJeejv/D6yh1lCSSP3Z9wU0S6NUSBtfIRhRlS1V27vM4gwGEEi/Ov9bielMcXXKWtdQGIC/ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ticloud.onmicrosoft.com; s=selector1-ticloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XmDZHfXolZetn0D6REeLzDtLBWek8RVjKhrUvvqXIsU=;
 b=eWp2uyhrs1M+kueYa9UTE3IOv2IFXV7RleHpegwvvO46xrptshsz9JVxuBvnqZDGRC2523n5+esJWlRwh6+grPa8W6V1uyYpxS9V6cn7ZFAXiyXTN+zTEbVAdyCNnLTgL1xSHmHqa/mxqo7bpilVJclrjtFBd/vhpPKzzTCjjv0=
Received: from PH8PR15CA0008.namprd15.prod.outlook.com (2603:10b6:510:2d2::27)
 by DM6PR10MB4201.namprd10.prod.outlook.com (2603:10b6:5:216::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Mon, 19 Oct
 2026 10:40:55 +0000
Received: from PH4PEPF0000B610.namprd21.prod.outlook.com
 (2603:10b6:510:2d2:cafe::a2) by PH8PR15CA0008.outlook.office365.com
 (2603:10b6:510:2d2::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon,
 19 Oct 2026 10:40:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 PH4PEPF0000B610.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Mon, 19 Oct 2026 10:40:53 +0000
Received: from DFLE204.ent.ti.com (10.64.6.62) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:40:13 -0500
Received: from DFLE210.ent.ti.com (10.64.6.68) by DFLE204.ent.ti.com
 (10.64.6.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 19 Oct
 2026 05:40:13 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Mon, 19 Oct 2026 05:40:13 -0500
Received: from uda0510294.dhcp.ti.com (uda0510294.dhcp.ti.com [10.24.50.162])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id
 69JAdgTn2629975; Mon, 19 Oct 2026 05:40:09 -0500
From: Beleswar Padhi <b-padhi@ti.com>
To: <trini@konsulko.com>, <sjg@chromium.org>
CC: <afd@ti.com>, <bb@ti.com>, <anshuld@ti.com>, <hnagalla@ti.com>,
 <jm@ti.com>, <nm@ti.com>, <n-francis@ti.com>, <u-kumar1@ti.com>,
 <b-padhi@ti.com>, <u-boot@lists.u-boot-project.org>
Subject: [PATCH v8 7/7] doc: board: ti: k3: Add section for HSM M4F core
 loading
Date: Mon, 19 Oct 2026 16:09:42 +0530
Message-ID: <20261019103942.2497201-8-b-padhi@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019103942.2497201-1-b-padhi@ti.com>
References: <20261019103942.2497201-1-b-padhi@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH4PEPF0000B610:EE_|DM6PR10MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: fa653601-4e13-4793-1771-08df2dcd7372
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|22082099003|10067099003|3023799007|13003099007|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: Wv0aqxJp4jw0zcArpzgwQVPf9hbFy/9Qg1YVoP+/G7OXH107C9MotTLxDvn7+KkFA0FJYSbY8CSoGTjJ8VjrNEzJVP3zh3Zwo4cgKboQsB/i7k97RbJFDXTe+KVbZoRxEUIZhSTATqKwbppr6tM5Os9aFOunNU6bR2wFsgIlS4+G/YJlyK1i6Ida8yof16Rh6fKPnMCt4/HJeI6QwvC59ri/qSmKD6ATnHyqVO9rrA/towA2CbkxIBK6oYupxwSfuPOh+CGYJaYyFTatbg3GtsvWcauO1ftyFcOQEftX4wxjj+PqYXmhvf+6BBHgKMEXPBdeRXRVyB3lTlIKeSQSIQlt52oxIi5soYYFsxhDh4Yf9Mt8yHk/JGrFbitl2Oz7HfVs7sHb1Z2ZTTP/Glz0HOf+Fbamcgg/kXZAeElKaJv/rD/FC6D5b1oNRah1pfL+kbneJEGsPRLthAA2jKjlXjgdbcCB5BFrSKX2m3OaHVGI2RdG6f5rHFE/Yvt+H3Y8xm2exoIKFrDaFhYgbuM5y7YWSP2qFZe5mRcAn6ZLIHsJrLMSzKY+gJXVgLu4H42avAOa2bpbDOkPOZCX4kVqoo3tBzF4eDRJ7qvs7zXwJDtbBKuYOhasPxJ8xlM69t9kvD45/7Jsbu5SrI9Yfi0qXg==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(22082099003)(10067099003)(3023799007)(13003099007)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2yPnz/BAZ+S3Fb/FX9Ek0roHYHqgEuJtV751Qrq2fgWZvMsMtJAKoPiKlMgZGI//VoJkaPtm6ZJ/gl1tPPtQ13ThGz/kI/JrsSit2EKi+Kydkl4SKJgnT/UrXeOyNawxmTXGYLKkTrCOv2DVbqYDT6T/4EMyN0SgCmYPH5G8vBIhvbvB8hCw041R2fZACo55+lbgjU0pvXEDCD7GQn3/C9dIW7Ox8PcDJpSxzQRlzk8dord2I34AymyQJQGoHJgaCm9/zQHKOklxHfgWAWJGT8vbjmQ32yoShw0Rn9WuKS3iDHpS3UNPEZ7Sk58QnxFmm4irYel5W3G9ohDpb6vhV0ml0xXlil1h8yPrTlQkxRiYWvd9ahU8jXLLhH+cFaNNQFMGIaygEy0eF0lMUkimrie3DmfZoS3WNjoHFOgKrbTB9CsEuT9fnuRsdL45sIbA
X-Exchange-RoutingPolicyChecked: XZtH4OTW8e034tDKfC7ROs7da4TIu5fgmboHzPwhpMT760DDFug+gZytClCnzIiJp5TRwU+ZlA/jWb0aKpPBP3xYkiiU/vzPVKRo/sBv0p15j6j5zbIsh2BCywm3C2Mok+R+B9I6bfscE+9ypW8Adj0nyYss8160x9MHtT1TXA2OL6gUpsclJSNvC2dCtef8aXD9b1HuLWbwjCs4Lt6EZoYJyZHNreLBL0LMB/tOTZR/aB+FoHT1I/WTmXGcSu2NIeyxmj9QiNqJjt66LptgclfUE7hfp/LL1XhZpzzPqtuEs5VpifSWQdTc58VyzJ7bflINqHs4uXDeTt5xa0IT6A==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 10:40:53.7193 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa653601-4e13-4793-1771-08df2dcd7372
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: PH4PEPF0000B610.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4201
X-Proofpoint-ORIG-GUID: VkQNsXf76SoW4KLVv1XoYdnNI_tgntMF
X-Authority-Analysis: v=2.4 cv=ZN9CCn7b c=1 sm=1 tr=0 ts=6ad5f3be cx=c_pps
 a=Cwg/eoBiIzPoLCvUJpemAw==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=660iZSQnnn4A:10 a=AlMIdn_sM9wA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=gO1vWkAQAl3rybz1DQOp:22
 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=voM4FWlXAAAA:8 a=NEAV23lmAAAA:8
 a=xyjKfQhMXZlMLvdiQTQA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfXycHaYw0w78ZZ
 x7ReNb1V5225rTIFt7si+5DzHVP8TmRzOqVgtC7Lx9blFSwosq9BXLUTdF0rhkbwxQs458gkVJy
 4sIbo16fmdq5xuBaX33UKfVAeBoOyAvSHxNO7vUP11wlReuAsdZCPo5/OGEu9YOD8joHprGtKgI
 ti1P4TRuu2NJfw5zDz+x26F0oAx2ZqeFzWA9dJQEy5lmmCez0NYl+QDcx6FxbTFtdq7wgne3lIt
 l2nHMYB9ShDqfocjC7xy0ciaQNmEDmR7Qj5czsBruxHZfMRjwB9cONq01MuFZ8wQUp/p93RCerx
 PQk/yvuZ/DkMfNQlMEqfuv1jlYaDVUx/kvN/1r3IPAyYke++ZJVWe8xsV4QneuVUnPzzhEQQ5/w
 G8tsX9MF+U4imy7XKrtvGwjFOTGa/2qoWAf86A2FMLk0auA3Oi7ff5zSruX2vrIg9yhUwT6K2xR
 sIuuNFHzCZbJ0kf/v0g==
X-Proofpoint-GUID: VkQNsXf76SoW4KLVv1XoYdnNI_tgntMF
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA0MiBTYWx0ZWRfX0sSApnijgZMm
 ZCSHQhTRn2sWu7ljxBDWV1LO0gLaRnnAlBFOwdJ3SkwIp6E3MXnZOmSu5+l3YZFeCI+O7LPrkIk
 YPcpeZPYX1cRibcAAPy4jVrPv1pzXsk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610190042
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

Add a concise section for loading and booting the HSM M4F core in TI K3
SoCs like J721S2, J742S2 and J784S4.

Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
Reviewed-by: Udit Kumar <u-kumar1@ti.com>
---
v8: Changelog:
1. None to this patch.

Link to v7:
https://lore.kernel.org/all/20260922084536.2477291-8-b-padhi@ti.com/

v7: Changelog:
1. Included the HSM doc in the applicable board specific files.
2. Carried R/B tag from Udit.

Link to v6:
https://patchwork.ozlabs.org/project/uboot/patch/20260831083347.1168880-8-b-padhi@ti.com/

v6: Changelog:
1. New patch. Adds documentation for loading and booting the TI K3 HSM
   M4F remote processor.

 doc/board/ti/j721s2_evm.rst |   7 ++
 doc/board/ti/j784s4_evm.rst |   7 ++
 doc/board/ti/k3.rst         | 136 ++++++++++++++++++++++++++++++++++++
 3 files changed, 150 insertions(+)

diff --git a/doc/board/ti/j721s2_evm.rst b/doc/board/ti/j721s2_evm.rst
index 21683b90b1a..db932447e63 100644
--- a/doc/board/ti/j721s2_evm.rst
+++ b/doc/board/ti/j721s2_evm.rst
@@ -281,6 +281,13 @@ https://www.ti.com/lit/pdf/spruj68 under the `Bootmode Settings` section.
 
 For SW1, the switch state in the "ON" position = 1.
 
+HSM M4F Loading
+----------------
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_hsm_m4f_loading
+    :end-before: .. k3_rst_include_end_hsm_m4f_loading
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/j784s4_evm.rst b/doc/board/ti/j784s4_evm.rst
index 54b4b6031f0..179d157206d 100644
--- a/doc/board/ti/j784s4_evm.rst
+++ b/doc/board/ti/j784s4_evm.rst
@@ -637,6 +637,13 @@ to the J784S4 endpoint:
 This program copies the boot image to the PCIe endpoint's memory region and
 writes the necessary control words to signal image transfer completion.
 
+HSM M4F Loading
+----------------
+
+.. include::  k3.rst
+    :start-after: .. k3_rst_include_start_hsm_m4f_loading
+    :end-before: .. k3_rst_include_end_hsm_m4f_loading
+
 Debugging U-Boot
 ----------------
 
diff --git a/doc/board/ti/k3.rst b/doc/board/ti/k3.rst
index b918f88ff27..f846ad7e4ed 100644
--- a/doc/board/ti/k3.rst
+++ b/doc/board/ti/k3.rst
@@ -759,6 +759,142 @@ resorts to enabling for the entire DDR region:
     bootph-all;
   };
 
+HSM M4F Loading
+----------------
+
+.. k3_rst_include_start_hsm_m4f_loading
+
+Some K3 SoCs like J721S2, J742S2 and J784S4 have a High Security Module
+(HSM) M4F core in the Wakeup Voltage Domain. The HSM M4 core is loaded at
+R5 SPL stage. Boot flow for HSM M4 core is different than the general
+purpose M4F cores, and is described as below:
+
+1) Request control of HSM M4F remote processor.
+2) Assert Reset on the HSM M4F remote processor.
+3) Load firmware into HSM M4F core's SRAM memory region.
+
+   * For HS devices, request TIFS to authenticate and load the firmware.
+   * For GP devices, load the firmware manually into HSM SRAM.
+
+4) Deassert Reset on the HSM M4F remote processor.
+5) Release control of HSM M4F remote processor.
+
+This User Guide documents how to enable HSM core loading.
+
+How to enable HSM M4F Loading
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+By default, only the HSM demo firmware for HS-SE device type is packed in
+`tispl.bin` FIT image. See the "How to build U-Boot with custom HSM
+firmware" section below to change the default firmware for other device
+types.
+
+R5 SPL supports loading of HSM M4 core for all device types, i.e., HS-SE,
+HS-FS, GP. However, this feature is disabled by default. To enable HSM
+loading, set the ``CONFIG_K3_HSM_FW`` and
+``CONFIG_REMOTEPROC_TI_K3_HSM_M4F`` configs in both
+`<soc>_evm_r5_defconfig` and `<soc>_evm_a72_defconfig` files.
+
+For example, to enable HSM loading on J721S2 device, make the following
+changes:
+
+.. code-block:: diff
+
+  diff --git a/configs/j721s2_evm_r5_defconfig b/configs/j721s2_evm_r5_defconfig
+  index 806c97792f6..ebe100c2278 100644
+  --- a/configs/j721s2_evm_r5_defconfig
+  +++ b/configs/j721s2_evm_r5_defconfig
+  @@ -187,3 +187,4 @@ CONFIG_FS_FAT_MAX_CLUSTSIZE=16384
+   CONFIG_PANIC_HANG=y
+   CONFIG_LIB_RATIONAL=y
+   CONFIG_SPL_LIB_RATIONAL=y
+  +CONFIG_K3_HSM_FW=y
+  +CONFIG_REMOTEPROC_TI_K3_HSM_M4F=y
+  diff --git a/configs/j721s2_evm_a72_defconfig b/configs/j721s2_evm_a72_defconfig
+  index 6db41cb457e..a07e6d63270 100644
+  --- a/configs/j721s2_evm_a72_defconfig
+  +++ b/configs/j721s2_evm_a72_defconfig
+  @@ -198,3 +198,4 @@ CONFIG_UFS=y
+   CONFIG_CADENCE_UFS=y
+   CONFIG_TI_J721E_UFS=y
+   CONFIG_TI_COMMON_CMD_OPTIONS=y
+  +CONFIG_K3_HSM_FW=y
+  +CONFIG_REMOTEPROC_TI_K3_HSM_M4F=y
+
+Proceed to build U-Boot (`tiboot3.bin` and `tispl.bin`). One can verify if
+the HSM binary is packed inside `tispl.bin` FIT image by using following
+command:
+
+.. prompt:: bash $
+
+  mkimage -l <output directory>/a72/tispl.bin
+
+.. code-block:: console
+
+  <...>
+  Image 2 (hsm)
+   Description:  HSM binary
+   Created:      Thu Mar 20 13:26:16 2025
+   Type:         Standalone Program
+   Compression:  uncompressed
+   Data Size:    132694 Bytes = 129.58 KiB = 0.13 MiB
+   Architecture: Unknown Architecture
+   Load Address: 0x82000000
+   Entry point:  0x82000000
+  <...>
+
+The HSM core loading can be verified by checking for the following log at
+R5 SPL stage: 'Successfully loaded and started HSM core'.
+
+.. code-block:: console
+
+  U-Boot SPL 2025.01-00391-ga7a25e886202-dirty (Mar 20 2025 - 11:04:05 +0530)
+  SYSFW ABI: 4.0 (firmware rev 0x000b '11.0.9--v11.00.09+ (Fancy Rat)')
+  Initialized 4 DRAM controllers
+  SPL initial stack usage: 13456 bytes
+  Trying to boot from MMC2
+  Authentication passed
+  Authentication passed
+  Authentication passed
+  Loading Environment from nowhere... OK
+  Successfully loaded and started HSM core
+  Authentication passed
+  Authentication passed
+  Starting ATF on ARM64 core...
+
+How to build U-Boot with custom HSM firmware
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+To pack the firmware for any other device type, one can update the path in
+the SoC binman template to point to the custom binary and re-build U-Boot
+images (`tispl.bin`).
+
+`arch/arm/dts/k3-<soc>-binman.dtsi`
+
+.. code-block:: dts
+
+  hsm {
+     hsm: blob-ext {
+        filename = <path_to_custom_binary>;
+     };
+  };
+
+For example, To pack the HSM demo firmware for J784S4 HS-FS device type,
+make following changes to `arch/arm/dts/k3-j784s4-binman.dtsi`
+
+.. code-block:: dts
+
+  hsm {
+     hsm: blob-ext {
+        filename = "ti-hsm/hsm-demo-firmware-j784s4-hs-fs.bin";
+     };
+  };
+
+A list of all HSM demo firmwares can be found in `ti-linux-firmware
+<https://github.com/TexasInstruments/ti-linux-firmware>`_ repository.
+
+.. k3_rst_include_end_hsm_m4f_loading
+
 .. _k3_rst_refer_openocd:
 
 Common Debugging environment - OpenOCD
-- 
2.34.1

