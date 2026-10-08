Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BA9CCA6007
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 13:51:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 32DEB40AF7;
	Thu,  8 Oct 2026 13:51:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id juEIsCKzLN08; Thu,  8 Oct 2026 13:51:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2AA4340AEF
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791467487;
	b=Y49P0XfwKOuwAXFXJGb8Hhw/3qlqVo0kC0drjilScE9ifODMBy+pPsmj9bQLoCeOFExL
	 GwVZ19W4rl/2hJud1VnN7zLU1XkZlIPfTgBaeeX9TWnPlQuH7zinhB1cONQ1whS63WSjS
	 JOHm+Xmt3zhKrR3dlcG3D2yYBuFWaUOzBfE4QmBgF4ostm/cinx80XbpaRWA1JvfO+Fqo
	 E63fMZG8bWGi1Lc7sBkhd7Aesi2a0vXJUnkhZVQtyxdPtkvZWsTx7wsYydjyRP7khBn2S
	 0c3nHkd7uk+fC8iRofQcaBOpVwhSst01o6pr81qt7VghDzPrrFHaT1sb2MGCFlXAzxQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791467487;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=/zXPcfhUaDefoAH8N/rE5MTXXn7WfTPbXgRmO+NPoEE=;
	b=g192HSQkt2Cp77/f3SngFwq0sOun95LcDhS7ffIgRUPiQk4d5+CKJbgzBVJ99NlSDGpr
	 7ELH29JX+ue+mdcXx1G/U4aVIKEXUBiTip4Zu858+aUUWay8GCcIjApm15zOgNXjyI6KN
	 BCRPYmoZ3JYm6TfsZ/H/UqRa2Uq8d6M9CuMXTbPedKfnABHRoQpGDJSRfIfFvwEtD3CF9
	 c/3J6KXDKKQcKHpwHo7PWT8qOZOIFlGPMlV2CLQ4BOhQZZw0yZP//a4vIvf4EHK+BC2T8
	 1P96ro86xegSAV2Z9gn+2D1QA51Or+8Zz6dmbEyZ1ZdtgSQvnL5rDGiVUJVxFeOCLUg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791467487;
	bh=/zXPcfhUaDefoAH8N/rE5MTXXn7WfTPbXgRmO+NPoEE=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zim+D4/mCB4EhReFfrFLgs5FFegLw85yIIkC5UQR/BarBU3wSPHlAJ4aYJY4koRdn
	 sGr3mUOsaIGenGQuYY1D9T21wFk11cVIcnK479sqqm0GSHYt+VkydXqtIbl0YhFloV
	 bky2g61sTHMbxOZHgfy2XrJ/wNPoK3fRDSUnyBcAOdyqiNyryg4aHHIgejLdP8RuCw
	 +r3DTRRkxjeUip7aLfIQUKyqCsiMOhUEXYod21h4b3ErYMYY1PSfs26SQj+wxbQD8+
	 //t0zM4FC7cBSDGYTf273nbf5Rb0+pCOLZ0KPDs3NcwyYV5wcC2faY3qcNaKR9Kqek
	 UGdo8dMKuGKZA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2AA4340AEF;
	Thu,  8 Oct 2026 13:51:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7FA362E0
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:51:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6581160B5D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:51:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bv-QBcmyDi0u for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 13:51:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 598E260B3F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c001::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791467484;
 b=Adm1+PEM2dSjo/WsUt3qdkDQUhXu+b+xKwJNkVoS0uiwFIUaFquyzlAu4aYvvqenqFs2
 pZLavoEygQc9J6/lEV0xR+o5nX6fHNlLDsOxs1FPiJk44pOzuhWA/yjLWycLXpiY5jrD/
 VYRoqUyzvYIhZuF5hNwVtJO3ndvTPTCCBt4FfeAnRtaINDCtsiISPYnSPxnY9U+3ZnEfX
 Cn0o83ySECP3fi5XsJVijpl5bol013DQ34C2ektbzsc7FFX5pDeEDpunk/T9RPFeW298y
 U6NG1fdBx6878inAO7VtEAOLBxUzRhK0nvgPWlklqJ6fQbnCA97Y1tato7m2ThoMwBA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791467484;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 bh=/zXPcfhUaDefoAH8N/rE5MTXXn7WfTPbXgRmO+NPoEE=;
 b=lWrmlKKe39zDgKxkrxJ/sEh1h8CFmX8YdQa4IZ07eo14BhqhziibqDC7f5e/756dq9yk
 D5/Fw6KwPGpG1gy7xPEOx4YBqaftGYa/OnQUh7c/0v4nOtb5HZwLbJFnNLS15jhamWX/k
 nbflVTvmeA6rIqSrMdZgEgD2xLhWcoPNOUxvndGeGlEImBU6Dhu6BZ/2srNRA4x0TED+H
 /E9O2Hm9xVSo6XykMzFt6MQbGRrq7X/pLrbOZNuiGu/kbFiOmOTWhK9C93bwYM7FhOjre
 F67TQ0BJUoH31Xc316lkM52/kHEvAWhjwnI/MJlGurFzU01bJaNjnr3/LaWENIZusgQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mdfv5cQ9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c001::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c001::2;
 helo=sj2pr03cu001.outbound.protection.outlook.com;
 envelope-from=jayaramudu.desapogu@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=mdfv5cQ9
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 598E260B3F
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 13:51:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yk2Iu4X5q5b/R0Y4ZsnYLF50YnKbryrI/5l1OL4l5UBe3xy75YYjPq6PmfO8Jsl38L57v0pQ5hjmWPS4v+ofJZQN4+RtBZBw7r1zJj1mWhw6XB/KztzTVZd0IJTWnvJ66o++EMYnaqmLUXkAiNooIEAL0/bHtT+zHqBj12Wht3GCh4FJVilDd5h/ObbOzXR/QTtUu/9OSqGAoO/QdWyVgBVqsy6MwT1zDrRT/T+ET5opSmacgm6R7t2D5HsHv0zq9sXbPn3PMlVLUwORPEzenrVDYOlBywnkbeYgoO3q/mDh89vE0FrhThQrQJPu+c2cKfuYmH8fqfGwWHNsGR37+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zXPcfhUaDefoAH8N/rE5MTXXn7WfTPbXgRmO+NPoEE=;
 b=pRXRCo5F/VfpS4S/hF2dYAjFcvKUWrH4i09duaTp2hzmhamFteg7OetjzNjzD4mFiPkigzL28FP/+/ksVJAMd/v9HCfOSfQwNKQG2rVOBvCE7YrNmf7GB/Eyix93xM9kPPLkkZ8BTLDUNc9nDBE6NrQ9ojEZzWHfYgyquQ3YbSzYmTsCmO2X/5OtxoJn9Lt2M1AlSVzZwS6P2JZtpPF2VBBjv7PokNJ3YMZKs6sF21LYc2XLYMnjBC0QpQro5DVY5fCl2yQlIcgn4+XQGU+PisUkXUN1aF+perZi/ZjzzcsthnM/jNhl0EOyDMPGV+oEYzzvBfxViElLsFtZ/V8l1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=chromium.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zXPcfhUaDefoAH8N/rE5MTXXn7WfTPbXgRmO+NPoEE=;
 b=mdfv5cQ9bnaeyEzbVMaJa4PoB8rKA+jrXs8el9Wa5o9JhGq/nZNkXSBREAHootM2tI23yOOdbxdIyaJD2QFTI7e1CksXil2pjCqR64LLjb92Ob07l5BAhIJbBx21sPlH4Ygs+n14zaGxd8nf/cyw6AAXYx9+lQWrnE656/2pkSU=
Received: from CH0PR04CA0062.namprd04.prod.outlook.com (2603:10b6:610:74::7)
 by SA1PR12MB6798.namprd12.prod.outlook.com (2603:10b6:806:25a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Thu, 8 Oct
 2026 13:51:14 +0000
Received: from CH01EPF000BE942.namprd02.prod.outlook.com
 (2603:10b6:610:74:cafe::8a) by CH0PR04CA0062.outlook.office365.com
 (2603:10b6:610:74::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 13:51:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE942.mail.protection.outlook.com (10.167.244.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 8 Oct 2026 13:51:14 +0000
Received: from BLRJDESAPOG1.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 08:51:04 -0500
From: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
To: <sjg@chromium.org>, <trini@konsulko.com>
CC: <u-boot@lists.u-boot-project.org>, Desapogu Jayaramudu
 <jayaramudu.desapogu@amd.com>
Subject: [PATCH v5] x86: cpu: x86_64: Detect CPU vendor and device ID using
 cpuid
Date: Thu, 8 Oct 2026 19:20:24 +0530
Message-ID: <20261008135024.13784-1-jayaramudu.desapogu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826113515.137299-1-jayaramudu.desapogu@amd.com>
References: <20260826113515.137299-1-jayaramudu.desapogu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE942:EE_|SA1PR12MB6798:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f84ca83-f8e3-4d19-d4a4-08df254337e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: M6agBQF/aQruxjooDuSlgyzTI+l7YXVtVsttMyhQWPElL2Y0elUmNdXNfhfk02KJhcQ06Ah58EDHxv+K8mD5d87M7u0+YryBfVQ8uAlxIMLllPO4mxQNRGnNyFvpAuGskqO8eEQOAGIuqMS4lE/2SjSnewoqv+zyO3HCO9FlWilORhMyKApaasINdB5cwRRcl/cR7slUTgnSBewzxBWElOSdBIA8f0F92Nv4U0+HP/Mg0la4Y009fiBcmwyMuVu5AqvWW9uAuSPT3257CA7AQIdFcEo9XhKE7103dMmuGNywfnl+w9Sj5bWiurPAC6MD965ZeChTIQx/wjVybCsSUqlIWS0015wBTlOK0gaR0V2h/3rVceQk5Ca/MPa1HmZ8LlvbWZtlIan6VIMqtzutRJo+SKUgaZo5EMqT+2WXROiu46f849fue8DDZGFW3lqoLoI21yqA4AiavUn0uRoO5NqLTsktaJ609+22g/q1wmz6zd0KiUrMlnNS0ZnRsgdhD2GZe0r2spD2p2swGmB783TN0NTjihOeFtgeF8pthoDZvtb1U0LNilTGAhvhxRPQxhaQI+XOiMHG042OXyCOCAieRolE5eCqXhwQqb1zS3AQzMGATS7AMUJqXKUrDaut+wFNv4soT1su0RqOKsSugnVFtuRJqivKAkol2IRx8Uo7OIIu01ldVsOntrZersGmzZgdT9UQtd21ua5V26JUkA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TqWV/gUiRwqIOCOpGcB3nmi0ZlbH5ggiDZGKCWjumoIvH30jX5dirw/vn+yv5JLUaeiuY42t2p6rxV8XkX0yWntrDb+MU9qkMJKWFYX71nCNRSBxeRK92nwZby18rrnQjGxwieKcm64JeWEIXpVOcCP3ekZH86TfyVqom5qb/je11aEZf/CHNlZDowZvmBLaAaZWPUv4dYdN96u/IgoPwwh+G48ndg6mNJ7CfjZzrL/Nce4au3q9u03JjP5Gi8AOoWxDckwg6h0Lm0eJnL6CKlWKrqrgCQSdi3ohx/u8KzkVaKZspubz+uc7dfc3hkdVjwHDr5U3RVXHIp173fOI9ikgns4R7GA1Ost5b/bxREUDCPz4bs5z0ZNzVMaCesyNFDkueKPyO+PQpP3mn/88gQAWXaFj6EWNrzQKHoNhyM5Swm9tr0Pr8S4SbA4mnY6v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:51:14.0243 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f84ca83-f8e3-4d19-d4a4-08df254337e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE942.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6798
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

When U-Boot is configured as a coreboot payload on x86_64, the current
code leaves the CPU identity at the default Intel vendor and device ID
0x0, even on non-Intel platforms.

Read CPUID leaf 0 and build the 12-byte vendor string from EBX:EDX:ECX
to identify the CPU vendor at runtime. Set gd->arch.x86_vendor to Intel/AMD
when matched, with fallback to X86_VENDOR_ANY for unknown vendors. Also
store cpuid_eax(1) in gd->arch.x86_device so later x86 code can use the
detected CPU identity.

This avoids relying on a fixed vendor value and keeps vendor-sensitive
paths (e.g. TSC calibration) aligned with the actual CPU.

Signed-off-by: Desapogu Jayaramudu <jayaramudu.desapogu@amd.com>
---
Changes in v5:
- updated comments in arch/x86/include/asm/u-boot-x86.h
- leaving the function x86_cpu_init_f() as it was.

 arch/x86/cpu/Makefile             |  1 +
 arch/x86/cpu/i386/cpu.c           | 51 ++----------------------------
 arch/x86/cpu/vendor.c             | 52 +++++++++++++++++++++++++++++++
 arch/x86/cpu/x86_64/cpu.c         | 24 ++++++++++++--
 arch/x86/include/asm/u-boot-x86.h | 16 ++++++++++
 5 files changed, 92 insertions(+), 52 deletions(-)
 create mode 100644 arch/x86/cpu/vendor.c

diff --git a/arch/x86/cpu/Makefile b/arch/x86/cpu/Makefile
index 5150edb833f54f..17443c4ffd2df7 100644
--- a/arch/x86/cpu/Makefile
+++ b/arch/x86/cpu/Makefile
@@ -27,6 +27,7 @@ endif
 extra-$(CONFIG_$(PHASE_)X86_16BIT_INIT) += resetvec.o start16.o
 
 obj-y	+= cpu.o
+obj-y	+= vendor.o
 ifndef CONFIG_TPL_BUILD
 obj-y	+= cpu_x86.o
 endif
diff --git a/arch/x86/cpu/i386/cpu.c b/arch/x86/cpu/i386/cpu.c
index ee6dbeb5c48e65..09642b2198f329 100644
--- a/arch/x86/cpu/i386/cpu.c
+++ b/arch/x86/cpu/i386/cpu.c
@@ -63,30 +63,6 @@ struct cpuinfo_x86 {
 	uint8_t x86_mask;
 };
 
-/* gcc 7.3 does not wwant to drop x86_vendors, so use #ifdef */
-#ifndef CONFIG_TPL_BUILD
-/*
- * List of cpu vendor strings along with their normalized
- * id values.
- */
-static const struct {
-	int vendor;
-	const char *name;
-} x86_vendors[] = {
-	{ X86_VENDOR_INTEL,     "GenuineIntel", },
-	{ X86_VENDOR_CYRIX,     "CyrixInstead", },
-	{ X86_VENDOR_AMD,       "AuthenticAMD", },
-	{ X86_VENDOR_UMC,       "UMC UMC UMC ", },
-	{ X86_VENDOR_NEXGEN,    "NexGenDriven", },
-	{ X86_VENDOR_CENTAUR,   "CentaurHauls", },
-	{ X86_VENDOR_RISE,      "RiseRiseRise", },
-	{ X86_VENDOR_TRANSMETA, "GenuineTMx86", },
-	{ X86_VENDOR_TRANSMETA, "TransmetaCPU", },
-	{ X86_VENDOR_NSC,       "Geode by NSC", },
-	{ X86_VENDOR_SIS,       "SiS SiS SiS ", },
-};
-#endif
-
 static void load_ds(u32 segment)
 {
 	asm volatile("movl %0, %%ds" : : "r" (segment * X86_GDT_ENTRY_SIZE));
@@ -247,21 +223,6 @@ static bool has_mtrr(void)
 	return cpuid_edx(0x00000001) & (1 << 12) ? true : false;
 }
 
-#ifndef CONFIG_TPL_BUILD
-static int build_vendor_name(char *vendor_name)
-{
-	struct cpuid_result result;
-	result = cpuid(0x00000000);
-	unsigned int *name_as_ints = (unsigned int *)vendor_name;
-
-	name_as_ints[0] = result.ebx;
-	name_as_ints[1] = result.edx;
-	name_as_ints[2] = result.ecx;
-
-	return result.eax;
-}
-#endif
-
 int x86_cpu_vendor_info(char *name)
 {
 	uint cpu_device;
@@ -290,8 +251,7 @@ int x86_cpu_vendor_info(char *name)
 	} else {
 		int cpuid_level;
 
-		cpuid_level = build_vendor_name(name);
-		name[12] = '\0';
+		cpuid_level = x86_get_vendor_name(name);
 
 		/* Intel-defined flags: level 0x00000001 */
 		if (cpuid_level >= 0x00000001)
@@ -334,17 +294,10 @@ static void identify_cpu(struct cpu_device_id *cpu)
 #ifndef CONFIG_TPL_BUILD
 	{
 		char vendor_name[16];
-		int i;
 
 		cpu->device = x86_cpu_vendor_info(vendor_name);
 
-		cpu->vendor = X86_VENDOR_UNKNOWN;
-		for (i = 0; i < ARRAY_SIZE(x86_vendors); i++) {
-			if (memcmp(vendor_name, x86_vendors[i].name, 12) == 0) {
-				cpu->vendor = x86_vendors[i].vendor;
-				break;
-			}
-		}
+		cpu->vendor = x86_vendor_name_to_id(vendor_name);
 	}
 #endif
 }
diff --git a/arch/x86/cpu/vendor.c b/arch/x86/cpu/vendor.c
new file mode 100644
index 00000000000000..9c972a7db81d71
--- /dev/null
+++ b/arch/x86/cpu/vendor.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Shared x86 CPU-vendor helpers
+ */
+
+#include <linux/types.h>
+#include <asm/cpu.h>
+#include <linux/string.h>
+#include <linux/kernel.h>
+
+static const struct {
+	int vendor;
+	const char *name;
+} x86_vendors[] = {
+	{ X86_VENDOR_INTEL,     "GenuineIntel" },
+	{ X86_VENDOR_CYRIX,     "CyrixInstead" },
+	{ X86_VENDOR_AMD,       "AuthenticAMD" },
+	{ X86_VENDOR_UMC,       "UMC UMC UMC " },
+	{ X86_VENDOR_NEXGEN,    "NexGenDriven" },
+	{ X86_VENDOR_CENTAUR,   "CentaurHauls" },
+	{ X86_VENDOR_RISE,      "RiseRiseRise" },
+	{ X86_VENDOR_TRANSMETA, "GenuineTMx86" },
+	{ X86_VENDOR_TRANSMETA, "TransmetaCPU" },
+	{ X86_VENDOR_NSC,       "Geode by NSC" },
+	{ X86_VENDOR_SIS,       "SiS SiS SiS " },
+};
+
+int x86_get_vendor_name(char *name)
+{
+	struct cpuid_result result;
+	unsigned int *name_as_ints = (unsigned int *)name;
+
+	result = cpuid(0x00000000);
+	name_as_ints[0] = result.ebx;
+	name_as_ints[1] = result.edx;
+	name_as_ints[2] = result.ecx;
+	name[12] = '\0';
+
+	return result.eax;
+}
+
+int x86_vendor_name_to_id(const char *name)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(x86_vendors); i++) {
+		if (!memcmp(name, x86_vendors[i].name, 12))
+			return x86_vendors[i].vendor;
+	}
+
+	return X86_VENDOR_UNKNOWN;
+}
diff --git a/arch/x86/cpu/x86_64/cpu.c b/arch/x86/cpu/x86_64/cpu.c
index 25ae92c702fbca..0d2713a02299d0 100644
--- a/arch/x86/cpu/x86_64/cpu.c
+++ b/arch/x86/cpu/x86_64/cpu.c
@@ -10,6 +10,7 @@
 #include <asm/cpu.h>
 #include <asm/global_data.h>
 #include <asm/processor-flags.h>
+#include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -48,11 +49,28 @@ static void setup_sse_features(void)
 	: : "i" (X86_CR4_OSFXSR | X86_CR4_OSXMMEXCPT) : "eax");
 }
 
-int x86_cpu_reinit_f(void)
+static void setup_identity(void)
 {
-	/* set the vendor to Intel so that native_calibrate_tsc() works */
-	gd->arch.x86_vendor = X86_VENDOR_INTEL;
+	char vendor_name[13];
+	int vendor;
+	int cpuid_level;
+
+	cpuid_level = x86_get_vendor_name(vendor_name);
+	vendor = x86_vendor_name_to_id(vendor_name);
+	if (vendor == X86_VENDOR_UNKNOWN)
+		gd->arch.x86_vendor = X86_VENDOR_ANY;
+	else
+		gd->arch.x86_vendor = vendor;
+	if (cpuid_level >= 0x00000001)
+		gd->arch.x86_device = cpuid_eax(0x00000001);
+	else
+		gd->arch.x86_device = 0x0;
 	gd->arch.has_mtrr = true;
+}
+
+int x86_cpu_reinit_f(void)
+{
+	setup_identity();
 	if (IS_ENABLED(CONFIG_X86_HARDFP))
 		setup_sse_features();
 
diff --git a/arch/x86/include/asm/u-boot-x86.h b/arch/x86/include/asm/u-boot-x86.h
index ed2f6aa38935cf..65d2d1eaed6370 100644
--- a/arch/x86/include/asm/u-boot-x86.h
+++ b/arch/x86/include/asm/u-boot-x86.h
@@ -68,6 +68,22 @@ void cpu_reinit_fpu(void);
  */
 int x86_cpu_vendor_info(char *name);
 
+/**
+ * x86_get_vendor_name() - Read CPUID leaf 0 and return vendor string
+ *
+ * @name: 13-byte area to hold the returned NUL-terminated string
+ * Return: Maximum standard CPUID leaf from EAX
+ */
+int x86_get_vendor_name(char *name);
+
+/**
+ * x86_vendor_name_to_id() - Decode a CPUID vendor string to enum value
+ *
+ * @name: 12-byte CPUID vendor string (optionally NUL-terminated)
+ * Return: One of X86_VENDOR_* values, or X86_VENDOR_UNKNOWN if unknown
+ */
+int x86_vendor_name_to_id(const char *name);
+
 int cpu_init_f(void);
 void setup_gdt(struct global_data *id, u64 *gdt_addr);
 /*
-- 
2.43.0

