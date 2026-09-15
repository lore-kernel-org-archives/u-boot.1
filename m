Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE539C88E53
	for <u-boot@archiver.kernel.org>; Tue, 15 Sep 2026 06:24:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0447C4043A;
	Tue, 15 Sep 2026 06:24:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NMNJK54BlYUC; Tue, 15 Sep 2026 06:24:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 356B040402
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789453491;
	b=omzU1tEJ1kn82a8+CulzVRKaPServLBr1y1vkQRUh0KBvlqDuZFj8eqYtH7b0OXGU7FQ
	 tTzg3Yl4bX9tJPtGQ6z4zwkzqtgelxiC4d1D6elFWL2OlPg972MdKWNvdOn5Zz0DKP5kh
	 QzzLsobBKUv7jBUR1c/39oSbagDF40X3V3G6iVVAFLNQN1Bd1OkFnma+3tVAyV2CxP0tc
	 SKVz6Sk8WPviDdyRweiqlvMK+gv0eXuqHbFx/2WHXpnVPUde4OnhXJJhcUdi82qOdclE0
	 7I3i26Eh2NZ2Bdp2szaV6FqECf/TB0SyaKsYOZvFT3TedU5RLYQdk9wnTQDBfNf7ISg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789453491;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:References:
	 Date:Message-ID:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=u0W5FKJkgk8gWy1Sd0UN7lHlgL2flzOQpBOYqfk0G30=;
	b=jGKdIpEWHU3Lwzpn6fUWKAN1Xm00ogZb2YPPY7ObRuZFO0uJR1vklySv2WeBvQAlJCub
	 FWqEflpDy25KZhYPqQAiX0qr4ACyWlek4LjjFcxKg/Jgdi1pvzzSkjMOfr5Jh7eqh2N3D
	 HVOGS4veYNj9OuKpZoounOLaUykZgK3fyo7Q9ZSVtwjN6lul/ukZnTpwtgbjVr1DGS1KF
	 srEmt04xp69/CHDQg5vo2viuCrLYaQyAv1vvYc0viQxHVdDV/hIXgiBYtEzwNWRIeMlb2
	 y587593unrxCZ54Rq8FuNqq6ujeMj4rGQWK5XFj6HbFpw16b0FZ7VKVmLW4Hybm1sEw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789453491;
	bh=u0W5FKJkgk8gWy1Sd0UN7lHlgL2flzOQpBOYqfk0G30=;
	h=Subject:From:To:CC:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M19NZMqrrXJklHFBAyvKA9/wftSD+D1ufyA5B3RAwdJJ5xOCSZaJD/wT5ZmWC9sie
	 nhhzdYXY1LIh0fwD/S958229bPtd5aLjbrX8om52/KtXFofU62bN5ZGZ2eCPGF2Htd
	 loPYqwiqih70uF89okACJRgMb/6Zidd5OxAFwmOOPb/iIbsH4T04tNJVi98H/XaVrQ
	 9ct06isLpta9T88jZWJrE1BtjVW4J6ftsI+aCUhmrHaCMI9Uf5gV9RU41x9B1A0sQO
	 e/k0uRTzMNaEGdqiEOanlrsdSL8/NVOTbncscWkEBjmxkFnCByXQQ2TzAhZmp4pgSe
	 9LRQr2PtxvEzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 356B040402;
	Tue, 15 Sep 2026 06:24:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id E74E5224
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:24:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD427400D0
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:24:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2eeZDe6rqLJH for <u-boot@lists.u-boot-project.org>;
 Tue, 15 Sep 2026 06:24:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org CB31240082
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789453488;
 b=SFzzZxSl/Du9AlXsDvWMdszs3bdoXvNVSSk/wzFeqT6gV39aSTGYQHUESBRl5JYVuxUW
 netI36YsPfeBEUX2z+CkR5R+XTsHzFYgjaaBzbSkgcz7Db5GrDqnRd8Ipt0SGFKNw9mvm
 be/K+aUNmBhHD1kkQk9DpWzy5ZGl86SvYEBI4gLcwlxF9WgDhbs/KGAA3NUS11N9TCu9S
 3obCkdrTIQG0jTX7CiMVbGcgsLPQLegabveN+F6MsKi0TKq7EM8i5DTdD3q4OEl3KvV2h
 5VeqRLTe7KHQ8vBOVN8XbvOGqjrbtc3YWDdR1JvBfUn/ShXYZx8Kx6Sb//fGjKy71qQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789453488;
 h=Received-SPF:Received:DKIM-Signature:Received:DKIM-Signature:
 Received:Received:X-MS-Exchange-Authentication-Results:Received-SPF:
 Received:Received:Received:Received:Received:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Subject:From:To:CC:In-Reply-To:
 References:Date:Message-ID:X-Mailer:X-Developer-Signature:
 X-Developer-Key:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
 X-Proofpoint-Spam-Info:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=u0W5FKJkgk8gWy1Sd0UN7lHlgL2flzOQpBOYqfk0G30=;
 b=hUnkutWYs/bBjEAa1UtpGeA1Q9TbVqt0L9vqnIEQ/r4tp2wi1on/CWq5YLHq9l2MDvhY
 FmiO32ZGNLihxOBR+6BxGr4myNaUit+Kb7I5Kr4t+qAgJs1RX2SgbxSqLj8nzUJ4DK+jp
 ioRHzaLVuMU9AsigGO3gRPtfPH9fwx6mV2Du7pxZArIl8z9fX9YcYSrwfpNFS9R6Yu1Tn
 HfYIWy0u7OMZwa6ll2WWsYSkbNejbLsb4T4q/FGAYMzC9++AI2KcD4uDYk191yRPT2m5B
 3MSbL8ALqj/icQ7P/5tM+sZ4mzm1pT5AjJ17HMpQ0mWipAFnxQuZKwabcZVKXW+L7Xw==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=nkdv0Cs3; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=WM3csS1V; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=anshuld@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b=nkdv0Cs3; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=WM3csS1V
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id CB31240082
 for <u-boot@lists.u-boot-project.org>; Tue, 15 Sep 2026 06:24:45 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68F2m8d93281322; Tue, 15 Sep 2026 01:24:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=u0W5FKJkgk8gWy1Sd0UN7lHlgL2flzOQpBOYqfk0G
 30=; b=nkdv0Cs3v9Q2lZsvN7Rl1zu7WhEPF5FoVpZW0cQddeOEl+zCOy6eJUI7r
 BlTomDlehMZSrfZrxt4aNNSnwaHow7dqn7jKjys11wNG832blN3HyJDjex+pPB2S
 Dwe1lyuiu5ZJ3f9geU8b/yEU6sreh7dcScDWd+YsdV4nNYuBhS28bWbXxc7QBUJk
 se9s6eWeElYzdkYLc6MNrHLk4ipMvIJGJUpErwhrtcyOnKpUON2hBU52NDZCixKF
 ta6Qd1iTO1x6GvFsyJ01OL5Y5FNokudMsYSLc6uq9T5gRQc6ASVWkrMSoWjRorRv
 1ryIpz2cqnf9aP6ZrCvhxTYsif3Ww==
Received: from bl2pr02cu003.outbound.protection.outlook.com
 (mail-eastusazon11011008.outbound.protection.outlook.com [52.101.52.8])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gpvpj9ew5-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Tue, 15 Sep 2026 01:24:43 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0QZWdUsfgCLvt52M5nlNNtX3mwLiN/hnLF0bfs9uafIiVVOnk+rtJrmsL2WfziOL8qufJCT2F07+A3QQoLh/YVMHVvwefUiwGoj7IGHWz4ZiJl0jEp5P0gx2RtJkXu7AZVnP4zB1iy9s4xH6RASfdGnx8yQTkDF2ua6tqc8PzNPYhQ82vEAfJh+WtlzcoFxL9If8QaVNA/9LXC7M1oq4DdGywj7pOriO2CbOLyp4Pxf1/sJ4cs8W66jGLmdMog5qkIZQq8SXJIVT3WQ/B4CmAakaPxKzClE9PqaGA/sUnDsC0FkYUDM/SfQz//BOiHSYK63wD1fgl5Helm6y0cv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0W5FKJkgk8gWy1Sd0UN7lHlgL2flzOQpBOYqfk0G30=;
 b=XOvGzxCJzc2EvXJMAQ7pDtULQFAfzkkC4dkFSDKarGLYl0Hcsci54EHXgLRXBYjt9be2ZTIrbbqHm/NQydXD4rnzwQDo7ua24GU6yj6MPaNED1h3GD/FoICN1xPnpxug0xr7X3QmFsj+T+zFn2ICLrZ3AdsRJjkFuLykYnR0PBZtEdyHJGXY/isEDzpleKZHBWQhjXeV+iRJtaxq9cJjh2wqywv+D7pAsdyJcndZwNBDelw5xSzwfo36GeiJMqBL2TRPnFTVnENZ3tIbQCw5TOitwNNsZhF5bBDl8pSgnxmx2iAfGUs4f0mTV9bzdxCV+7/SufdYnZ6fvioPAZhY+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0W5FKJkgk8gWy1Sd0UN7lHlgL2flzOQpBOYqfk0G30=;
 b=WM3csS1Vfb9e+Xy3AX0/hE73rgxN0XSVPgEo06B/FJ8c346qJxsK09cSZb2o1+PITGo92wKmxLLUBvJ3yjxaGahU0DhVoSOcCxxJ7ughdmq1cQ47SWF30SkouV2dVTQ+EXYdGC0irdqCOxfFNKr/D31RPRkTyRnjrDj7LlvlHSQ=
Received: from SJ0PR13CA0093.namprd13.prod.outlook.com (2603:10b6:a03:2c5::8)
 by PH7PR10MB6106.namprd10.prod.outlook.com (2603:10b6:510:1fa::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 06:24:40 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::8a) by SJ0PR13CA0093.outlook.office365.com
 (2603:10b6:a03:2c5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Tue, 15
 Sep 2026 06:24:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Tue, 15 Sep 2026 06:24:39 +0000
Received: from DFLE209.ent.ti.com (10.64.6.67) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:24:09 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE209.ent.ti.com
 (10.64.6.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 15 Sep
 2026 01:24:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Tue, 15 Sep 2026 01:24:09 -0500
Received: from localhost (ada0543016.dhcp.ti.com [10.24.50.146])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68F6O71p3649356;
 Tue, 15 Sep 2026 01:24:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v4 2/3] arm: k3-binman: add tinospl.bin for direct
 U-Boot boot
From: Anshul Dalal <anshuld@ti.com>
To: Gokul Praveen <g-praveen@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <u-boot@lists.u-boot-project.org>
In-Reply-To: <20260903072805.31010-3-g-praveen@ti.com>
References: <20260903072805.31010-1-g-praveen@ti.com>
 <20260903072805.31010-3-g-praveen@ti.com>
Date: Tue, 15 Sep 2026 11:54:03 +0530
Message-ID: <178945344346.1987229.4970954930485114293.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789453445; l=1861;
 i=anshuld@ti.com; s=20251022; h=from:subject:message-id;
 bh=gr1q8Te/wG/aGLUrgFldmzh67BpeC0uYhKqkm0nfjnc=;
 b=JUREpuPEYUZpAqCt0od9MrQs6bdIirHInkrtsf5dE3QirThud0LLIVXlUNGTMbAKzWp0W4jde
 stMB14snEKFAs9VUg4jeEGp9ALMHTW5ZM+WVGdYIPhoZC/nL0pL/1vu
X-Developer-Key: i=anshuld@ti.com; a=ed25519;
 pk=Kv8FlQElcrR6efyEHmjtE83y8e0HKvqPyvVY+PJ4UFw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|PH7PR10MB6106:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ad8318d-486c-4bcd-03d4-08df12f2057e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: hj7U8B+Figg4c5hKk/hGwttaUqsrrSv7EZqu/ii5KZzthN/eoEK4SdjQvTpL8Q5/00ObsUgt/5aKLdzu6jSI6lNeLh1EL9EuUhoMsYNYtjt+DhjpOCQBy0qY7Sg7KCY5OgKeQsDwZ/5fmHUaBuyeAyrI/wXm13p03JSpHnHjbhGV7BEAA3kXiiOIuksVV1xTN63urjINV9D43qFDQUaH5vBKHTeMsG/tVbo9jHbL0r+heh9Cx9HNPePP5n2FhwMYR1+qPmiOQKtPhA8FCSF8KFaIzgRl0Yi45w86QY2fTpFu30iGG4pq3T/tbNoSyXiYlUWuvGLw79c4sfe5VzYmKhx5h6wNM6tXt665e/9NbF5R8xC+GSOJo0vZiJDcVg1Jr3DtwoKZF9MaphqXHZhy0eRy8Zc1dWfGfSRG/f8TBWQ1G7GxeEgymGrUu4R/vewkNXNf14exOWpFUF+bA/EtPV/gKYqfNSVnGk8K7TRCHadezrlFHeeroRghNtg0pMORu30U52emGIsu4LI5ezw+93MuGNxQxCahsSAYKsshooSWmShWzJgxRA5FpRNHN/9sncvT2RjJcVEE3MfEUFTtHdhh94xn8hRTEzHXZjGHVd7jPk1nVtBB52FiCfPMGWki5N+FcBlWzPPrMZeVeI3QrnKYZcmK96ldZmGLvUIVdrWAeeXE37/5Jst2nXes/Y130pycVHcxMNkz3wfuJn5HZg==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 28wXVsjZOXauuL8isT6Vn+6/Uc8Qor4CeWmszWhkB25tUC7yIj09BxG+JpX1o5eBkFl2rXm4u8CbpZNwwIzZuDRvTg7jNZmlW540Pw5S3z1k2gUTHMJRNLCK/tovurqAbT25GflYK/HwObbmGiRdrQhGmG0QBzByTwWuMrA2lJQP5mzrps5LSeB3AqTZ8doeYzETVUg7yKlrHGrnbZV3483g0y1Gl10bFiKzMMUmNy3MRSRla3DJ7uR+5RDBQnlo7EtldqSYAShzE53lIUPGA3G4RnK5eyDJdj70Ji9xlDVhcDHrF0vTQXNyFiWluZt2E2QooATDinWzL5aR6rpuzK2bZTi8VFo6N3fWBnv4APKAIatXCwGCGgRHx3pdmoTDPGbFFdhTpQXYeNbTd+DZPEZ8KntEQsUOsfSayqZnfalrJl/2k54up75PeOINKsh3
X-Exchange-RoutingPolicyChecked: 30hPvyJ/iI/IXfDSp3qCi5FBfhYXO3Zg9FEQQqf7XqNaAGDqBiu7UqdsUqHMY74Kw+guI3JqGBZi1/G0vOt19PfOf5L8TQHA3ZXC+RJYejE+DPixm5t10Je181LgoGN2mt3DSmwVpGUcuck6jBRWAoNXxzSbTBkSp2fNwbGMT8Phnf8r86BrJmE6gDzHdgJLCM0rjtSOu9nyxLMbTtR9ndqEplGg+Mng9aQTh7cRSP16+Ymh8UC8oCiHuIsMKUe5VVV/7fjXG2a/05tqmtgMDVUr66vLYM6EbYNe+3jRsEElK7Zje55O+0hFhJx8M5P3AXTPsdHyj6MmfdZjXKCZJQ==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 06:24:39.2078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad8318d-486c-4bcd-03d4-08df12f2057e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6106
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDA4OSBTYWx0ZWRfX7Yk+Gr36WpAF
 fcU2c67eOOI7tB9bNZ+cgQwqdJWV61Hqmbq59Fb4y8MjSeNutBLvCmSYAuOJoEczBZDALUycgPs
 L7ZANhTQdFRgXIqShRQRwPpSiRCfoVE=
X-Authority-Analysis: v=2.4 cv=KvnYSmWN c=1 sm=1 tr=0 ts=6aa8e4ab cx=c_pps
 a=56WOIFdoL1k8+DRIoLPNvg==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=fPAWb5peG099m5CrUpKH:22 a=sozttTNsAAAA:8 a=OZWiUaTmlaYCbjSgFtcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6fDKiXmcs-3j4qI1GC9crJBMlFL5had5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDA4OSBTYWx0ZWRfX+3XpL5fSGzkd
 5AEvKEBsUseM4S5CnlIDiuRJ8OFAbjBFTe2rv+lRn0uMg8j5/6WptHSTVEscyZYmX+O6Lv3FAH6
 tZ5O0MGeFNyGc3QSGzBK3X55bll/SnbXLU361QxF1KfF5CgLywPQRHqpxCW1pUQcv2y0s6HxWJg
 vsSkbYYQs7Z412LPFWsCZLoB3dcR4VSb6m3I+jv0N1vRjrhjk6qH1N2Jr+uegdWVX2wB/I4bmrr
 iFIpzEBhGuPzt6ss5ojGUgRZV6Mhp4qttlWsKQem3qFjblaf4DtCrY9M4Ei7GLWYWP+jifJedF9
 G8V1gxSFy6P1bkf1ZdBK2fsmPGyhL5CR+QbUjeU1cDX94iWrf7rw8pbS58Znondfy860mFTM5Ck
 dqcFePGTmCUUPo3zP7VuUKSEov/ldeTmlCo0hUM4tSxWJpEOvpP7jsPOfFmrHLPGh0tYZfJ1g+I
 hZoiRKv4yVNmpO/xY0Q==
X-Proofpoint-GUID: 6fDKiXmcs-3j4qI1GC9crJBMlFL5had5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_01,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150089
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

On Thu, 03 Sep 2026 12:58:04 +0530, Gokul Praveen <g-praveen@ti.com> wrote:
> diff --git a/arch/arm/dts/k3-binman.dtsi b/arch/arm/dts/k3-binman.dtsi
> index ad127663d03b..aa8479bc0f67 100644
> --- a/arch/arm/dts/k3-binman.dtsi
> +++ b/arch/arm/dts/k3-binman.dtsi
> @@ -543,6 +543,53 @@
>  		};
>  	};
>  
> +	ti_nospl_template: template-16 {
> +		filename = "tinospl.bin";

Asides from the filename and fit description, this template looks identical to
the existing 'ti_falcon_template' for AM62 family of SoCs, could we reuse that
here?

> [ ... skip 12 lines ... ]
> +					os = "arm-trusted-firmware";
> +					load = <CONFIG_K3_ATF_LOAD_ADDR>;
> +					entry = <CONFIG_K3_ATF_LOAD_ADDR>;
> +					atf-bl31 {
> +						filename = "bl31.bin";
> +					};

Why don't we have ti-secure nodes here?

> +				};
> +				tee {
> +					description = "OP-TEE";
> +					type = "tee";
> +					arch = "arm64";
> +					compression = "none";
> +					os = "tee";
> +					load = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					entry = <CONFIG_K3_OPTEE_LOAD_ADDR>;
> +					tee-os {
> +						filename = "tee-raw.bin";
> +						optional;
> +					};

No ti-secure node here too?

>
> diff --git a/arch/arm/dts/k3-j784s4-binman.dtsi b/arch/arm/dts/k3-j784s4-binman.dtsi
> index 34b2cc1e681f..0dec4316d6b4 100644
> --- a/arch/arm/dts/k3-j784s4-binman.dtsi
> +++ b/arch/arm/dts/k3-j784s4-binman.dtsi
> @@ -317,4 +317,69 @@
> [ ... skip 16 lines ... ]
> +					description = UBOOT_BOARD_DESCRIPTION;
> +					type = "firmware";
> +					os = "u-boot";
> +					arch = "arm";
> +					compression = "none";
> +					load = <CONFIG_TEXT_BASE>;

A bit of a hack but if we use 'CONFIG_SPL_TEXT_BASE' here, the default defconfig
should produce a functional tinospl.bin too. No config fragments should be
required.

-- 
Anshul Dalal <anshuld@ti.com>
