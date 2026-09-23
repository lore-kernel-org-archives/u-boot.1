Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16125C98307
	for <u-boot@archiver.kernel.org>; Wed, 23 Sep 2026 11:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA2B580E60;
	Wed, 23 Sep 2026 11:21:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id T3_Vw7wJVQqP; Wed, 23 Sep 2026 11:21:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1A1FC80EA0
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790162510;
	b=RAcLinXKDNa5iUswH8gs2S9NiJcBVkE9zFyyumL7dfRORHDL8v23YVSGMYvpi07QBwg3
	 cpqmKr0UVZij4DJYLiXGg+Q467BuR2d8Q+9rLLE6tPSdhXT5ZRW12fa7OCaLFXIzvCrOX
	 ye9HJp2xBHwrMj6hLYbPaELmlck85HU9OWK8OXyJNpkuLHnBMU10xo5kSxsm/Xgoda5xb
	 mgaK36JIweBMPV20TzO+KURJ+6doFuGqMO/wXg8QBw4rfgGFJ+oP3MFSn832pmpLqAwqL
	 zpLyz6n+iPJQUIgM4nc2Ffk53IQf0hTCq4l2rq7fQJhv0XjsqxTK8gPPogX9DVRRZ1w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790162510;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wudCfFEE+ap016hjKW/pwYYm40WDwXA63/f9KzL9uJc=;
	b=SVqWpwVOgMcZwgY/cYxc9XUeivLOO5OU/9+3DlTSs/EwKI32TXm9Hp8YfHrD6XpkP2Bz
	 TLEFOdd6WtiWN2hv1/n+tV20xxyahdlBGR/f85gbBnlb0d/4h3+ao/eOyXblnj0SAsTdq
	 9bYbEiVAorWwcOx385qcgvnYQJ5gYWJ0mYY65VbeHy1OKd7ZGyQchpTn0BqQ1PICAMa2C
	 fw7dlQyluXdrQGPSj51udjfZ4qszZETczMcPdoHQ6rtvaXJVlv4nq+rIcndi/zwvlsFKE
	 ZBsJr6oWWnRdzI+ZfaIWxAoAFxEbGdGlo7NgLb/kQT/VPs05YaxlMgMpqgqhyZErYLw==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790162510;
	bh=wudCfFEE+ap016hjKW/pwYYm40WDwXA63/f9KzL9uJc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uuwK/Ob3wppPHqdslZq18TA3BPk51IWKxFz1kSRDSyz6nNxUseSARIcoIrjWLY0QJ
	 5ikyLmN+KpfjXO0KS7pGOZZBbnODZM9/PjB0SB3HTRhPPvFbX2Lm8zeQxup53XIiJu
	 Ow1/H5KDjyumOAyXT2ejyOVijTvls7wlUp9eH/qF/aWZCc1WrboLdx2QBHGSxNMZaj
	 NC8RhUx8LkDSv76ury0tHPof5NnD31Bmh9VYGNG80WPlGw/aX4XY/2RPmV96E1DbLG
	 i5teb8Jdn6X8ju78ibrfbZf/58ih2E2Z6mTb2Da4hodyLSD5OeFv56EWKWjTox4Ozz
	 N3HxPJXFLigbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1A1FC80EA0;
	Wed, 23 Sep 2026 11:21:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 435C412C
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:08:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 297FA4032F
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:08:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mZDdsIO77U2k for <u-boot@lists.u-boot-project.org>;
 Wed, 23 Sep 2026 10:08:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D180D400DB
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=148.163.154.28
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790158092;
 b=duDjqugsJHhQy6LgL/l9U6COm+tJXF5hv4JLWBq2xfFEUsKWc1HH0adyCJCSmCn9GBjW
 q6i5QL3e/Zj0NfCc4DsibF/6bV4qDjxcuiA2JbYEvT+z6n8mBAQUdBNIhC8k3QUMKLp9S
 G/Gme91bt71VWflUALaxPbI1C9Hdof9AhO1qsFTEkVfZzEvOmWF23mcO1lZ8l3onp6Uuy
 oLhRo9x9sxMzDeKu47Ag3fiwPdRYu2p6ezyLs2lGABJeOZuspwVKiTOoLqWBRrQc9L+3M
 IHkgGgKO0R/zsLnB8mVyZhIQpQ6U4xDPomTukhZPW6DAvDPHJf9hQfRH8S9dKvzKt7A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790158092;
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
 bh=wudCfFEE+ap016hjKW/pwYYm40WDwXA63/f9KzL9uJc=;
 b=hBWogPRUVFdPYOhv5WYPFnu1V2/dcZnrB3zIoU7oYcpWExUV5dJ8+kzY9NRZf7iU3NID
 Ak4FiRCm104TB6xMeQlqQQn3MuwLZJ3j3xDKxA0Gj9/qExkTRCyWmJSdE522n3WQbr3ps
 h4PslfhSg9A4rzLlaU5OlLdcVYWYfdA5VAk+PDjAe377HIg18wlGFGycMfvedaEyGPVtm
 Gtpf8bKwF776xYUqXjZIsHB1a9U7YmkvEmw30MfOZp3DaBJGzKJsQUnnK1TTCh5uKXaUZ
 jevPZzOUZG3XuPdso2u42HXsvb0tMVc27tVRm2rVGD7QYoA9Jb5JhX40vhlfoa0eKQQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=ti.com; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=proofpoint-05-2026 header.b="Ilz/UUEr"; 
 dkim=pass header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b="t/8AgrJO"; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.154.28
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.154.28;
 helo=mx0b-0002e601.pphosted.com; envelope-from=a-garg7@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=Ilz/UUEr; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=t/8AgrJO
Received: from mx0b-0002e601.pphosted.com (mx0b-0002e601.pphosted.com
 [148.163.154.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D180D400DB
 for <u-boot@lists.u-boot-project.org>; Wed, 23 Sep 2026 10:08:11 +0000 (UTC)
Received: from pps.filterd (m0374955.ppops.net [127.0.0.1])
 by mx0b-0002e601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68N8JFbv775670; Wed, 23 Sep 2026 05:08:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=wudCfFEE+ap016hjKW/pwYYm40WDwXA63/f9KzL9u
 Jc=; b=Ilz/UUErZuNhd66vpPcwz3vQBJ0+voFDhJKM9doTlqRm04r9cHzEsOJ33
 dHzRkK7MyolPGoUvL0xb1s5/Yf6VZPXaFCQ6exCUjgDP7CM9ei5uMH64h/tvthmD
 ngekmBFxHfWDulDKCVPKF1P/qFR5yK13+eX+qi5lQ6Hyncfe03efIpqeGreDQH9k
 xtxnjoElDScQSCHpgg/n/GvitSKic4zkC1zTa1Tm4xCGkiopDIxmXoQbIaNee4Hm
 qA6XwVeqB7th2Gt65sv6uql8dVr3CpDwhR9dIcqIm8rZOU80QnJDCUSixYntvjFb
 Xojk0LZJOJJ4uEHRK73RhppjZiruw==
Received: from ch4pr04cu002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by mx0b-0002e601.pphosted.com (PPS) with ESMTPS id 4gv2ycu7p9-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 23 Sep 2026 05:08:03 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=La0sgkcLsB7x5O4KT/xSGMZcmCSir7QfXrbBJxM+cwARMHhXZsOuUM61xsRXjuOmYjkupFh70VZpe55zmgmCei1gvj/9fwcIv1bVVgF8IhtNQj+K0ktmBTmoZo5zCY74ZBbu/N2Y6y+cRa5j0P4iUFakFip2Xg8Lch1Vi8JmlKz4+kLEXqhXffY5pCBybBLVskNJE0bZ9oWKZ1iC9QV6BvK3j74H4exF2qsKTMEzpjeHrVPtN8MHd7ujtQhDgFy+knWUVKYAnunqWrMet35p5aKPDZEG/FSbhkm4yEs7I/H1R56AqexRgCVqaD63DJD8EjW4qjlc67zlXfdqIKZKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wudCfFEE+ap016hjKW/pwYYm40WDwXA63/f9KzL9uJc=;
 b=ThzrBko0dTe23OBukp5NELYSTn9nYIncj85noXLKGsGaMeF9Jx+HOpHNrc1Lwwu3V7Te8bLL1cutaoRPeh8XhqAiUsPm32GPyVn8gY266sWAh9lZ24Y+wfxYFCctBJMvXXqk5sj6ukfNvxF9pr6TIqOEqBTEORrOVwex8t6y8Fi6xgUQ7m+6/nsmIPhGSsiDAPsMAPnXqLHXURcGEkLUpXXWMjmB1BK2mWDl3nMpKBmS0y0uZyi0RkPPBR5R1MUyIcAWze9s4v1IU53AfkcbVCQys5IHw62pFY8IIUvHh5murVsxGGSMmzAVFNUKCZYGqb7tUAooVcMGeMLHFtLW3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wudCfFEE+ap016hjKW/pwYYm40WDwXA63/f9KzL9uJc=;
 b=t/8AgrJOm9jLl7VW00jBv0e4uHMTK9iRGYE/hSzZm6OBxoLW4/MQ9TWpxAvv4K5rEhMhay3RavJSI0NGho+ygD/5zshXZCmMK6Sfpzxc/e13OHrts2nxelUQJPi5/vICUytW+d53Bge/yRnnNGG+kWWZNRHkQspOSJbMEGpzGng=
Received: from BY3PR10CA0016.namprd10.prod.outlook.com (2603:10b6:a03:255::21)
 by CY5PR10MB5914.namprd10.prod.outlook.com (2603:10b6:930:2e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.13; Wed, 23 Sep
 2026 10:07:58 +0000
Received: from SJ1PEPF000037AF.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::35) by BY3PR10CA0016.outlook.office365.com
 (2603:10b6:a03:255::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.14 via Frontend Transport; Wed,
 23 Sep 2026 10:07:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 198.47.21.195) smtp.mailfrom=ti.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ1PEPF000037AF.mail.protection.outlook.com (10.167.244.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 10:07:56 +0000
Received: from DFLE201.ent.ti.com (10.64.6.59) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 05:07:07 -0500
Received: from DFLE200.ent.ti.com (10.64.6.58) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 23 Sep
 2026 05:07:07 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 23 Sep 2026 05:07:07 -0500
Received: from a0507033-hp.dhcp.ti.com (a0507033-hp.dhcp.ti.com [10.24.68.129])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 68NA6tOG2700733;
 Wed, 23 Sep 2026 05:07:04 -0500
From: Aksh Garg <a-garg7@ti.com>
To: <trini@konsulko.com>, <casey.connolly@linaro.org>, <dlechner@baylibre.com>,
 <stefan.roese@mailbox.org>, <peng.fan@nxp.com>
CC: <u-boot@lists.u-boot-project.org>, <s-vadapalli@ti.com>,
 <danishanwar@ti.com>, <u-kumar1@ti.com>, <a-garg7@ti.com>
Subject: [PATCH 2/2] configs: j7200_evm_a72_defconfig: Enable config to
 auto-probe the PHY
Date: Wed, 23 Sep 2026 15:36:54 +0530
Message-ID: <20260923100654.610596-3-a-garg7@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923100654.610596-1-a-garg7@ti.com>
References: <20260923100654.610596-1-a-garg7@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AF:EE_|CY5PR10MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: efd96f78-50b9-41b4-7445-08df195a8a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: 74tkN3+naBe+6FD2ZGyArJqn2kLrhVWOu7cw/ABb5hTYfJvCFun6NK0BCn3wksGVTjNPJLW784gls1bm74u549taBBSFftvprlwl60lSy+2G1urY/R04gmtZh9EAm0rR0z1JfztKQeXj/rVVMeZtEpxyMCVRQXNmaSHSEz2UIfrVXSdKtqKvSz+rHd+Zlhn0R3X0JSj3uywGcI8bDhLT/Q4PygobKhKrBFC1EzeS2RZf2Bh0okfgeUKjoWzhzsqbzkyjfcaa8lD2ulBbD0TefbBTbqNA7WA+QY4DI1EtR++aiLOr2NzFBI8/Cuom+96GcfDXv8UHbKsZkRHNH29Qv5CKciiy5Mjtik7TOj/LFe9i9G/m4FY2Ec6AAmDwFiclMM8PpoVMSODdq6hQlObQY4Uk4XjOp46ZoieGeiOUfriW2kTJSZs4cbV8N26KqOyzKCQyJJofdIaFARnlmJH76FU8lIEdsili19lQr0SAZ8buaAbw9pO/o76UOFIgHirK6DX/UCJLPZ7Hi+EB47BzY5qB9wqHBT1HVfX6pAvGaukNhOakxObEYcjtdU3FARg+Nl6BpdKey6aMxHacHdFWGtr5W7L/4iessgvV2X/csmXwN3bxCMnCEO6wCbv/UsYHn2AE5NAGdG8mweNz5Qebk2RcMMhzVLgF4eF1ZGy6pUjogjdlbgni2HkmjcrwL2I4HPMDS1ENfHI8NzX1qVRA9g==
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 19x2sk1MtuG1wgyn9dv1cpkJa0dXeI2gO7ukc1AshMtWQ97iSsSYMFMElQx/thY05Bp6GoW9x2UyZSLwQsHQthsJ1hNaoCpBRzUCVFx3AW38KXGda/m5sgdN0JBjn9N8pZbYbkD8SLfGABCftOyWSGcYwNaMCDS3s/2s8G4CfAS1H8gKfeKQBIuybNtQtAaSjAENs1oHvV3WsQkD3d6lHnF6io+GbvEnaXFuw6kewDErmhHiNoI2CsrEMyMrezZADm1iyFOmCI558RmEHXCs2BCCCpz3HZKyNAoN5eLdxzLtCVigkGZZaiYFjE49VUB/hTd82OmgFUvU01hgDER5sDbuM0h8VXGakWPsZ/ZaMTPfwU6zEUfAiro+M2mqOvtNaGv+dLoLv0d4KdO+s/ZbkbOerJ8/fFz8L8Zj1MyQTLnB9td/TFKAs29xOnlsDc1h
X-Exchange-RoutingPolicyChecked: AgqToxi1LycJGNr1GmpI26GPRTE57u0vwmn+xVHNDa0KARO1AWVmT9g1QKjbw0bid7onV0fAx3OoRgC540W3eHJbKQ0WD8/00rPb43MuuBFds2o7EoIJzYEQqDAAJydf1735tT+iMDi+g5cLdqweIAj/y5FghqqU7aHdVKzTMpZpbdDe4j+LU/R0A3HGu2ADXHICSyYiJJXOfiWO0bcHQSCx14KxxH4VklKglgUUNvYxKKrRYXJWCCvgm1/lZiwPIM7D2M94cwuGbOXLtFkJT/U3s4rZ3j5Zx5FiwkRr2NkUmuj6Q17usdxKP5+VK2ySs4L+3FKeWjY72SQn+Sst+Q==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 10:07:56.7939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd96f78-50b9-41b4-7445-08df195a8a5f
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5914
X-Proofpoint-GUID: UfJ5Q_x3rA7dQeawp7uSy8RIZxoAWQSt
X-Authority-Analysis: v=2.4 cv=WZKZ+EhX c=1 sm=1 tr=0 ts=6ab3a503 cx=c_pps
 a=2HCcruDS7e3rZRcUQV6B1Q==:117 a=tJyPKKxUohctrY4NYmUjkA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=VdqzKS8jKosA:10 a=V5UXEbMT0ywA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22 a=fPAWb5peG099m5CrUpKH:22
 a=sozttTNsAAAA:8 a=BIp-gRo21W86tubAYdcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfX0L9T83WNrkYB
 glsxsI1P1LameDDFAJ9u63ioKsZNQVVCINTE5coIMh+IPnxq5nrV19VLL7CS13VcMj+1wqS7WcS
 T1JlF0jewtmiaYEZh/uXYxTYHd5OU7A87GtRXlz1N8QkMLGz4BgfcTxj2ERcLQBQiQjh+VMoifm
 WdvGssDtOvt7hg0Yej1+gsoT3jAfptEZDJaK+95Oj0DaeEnhE81q45xz3jyAJRdjz0gm9zJOy2/
 KukdFhJiStoocSmMpJ571i0cPuZSsRjShbQe0twC+XK7zCmyr14CpzDgmsFX7a+mr8d9L48+C2e
 6oNjOp/OWShjM7tfmK3aytqXXGXTt3GqTF2XlFiqdN/7Xx9wuvr/VIhznpJ4tPQbgZvoN/YNZNm
 mgFNQdbMUU89TA9phEwAg8RrbCzV1vMwTffr416ChgrT+WjxO5lSA31shup0AJxYtVu5plOtRYX
 /NinMqwbYfxy/+Bcrjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MCBTYWx0ZWRfX2CV2ZnYI8bqP
 BXKzdheMJdjXR1fpfVoVJJ+A6Zqi1BOAwWmW7DdexD2FZZApCm25OfQppl/KSmTGEmyGl6cqJyU
 vojxpRZq/Kmmzlv5L7SyGpKJuuXdp/E=
X-Proofpoint-ORIG-GUID: UfJ5Q_x3rA7dQeawp7uSy8RIZxoAWQSt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230040
X-Mailman-Approved-At: Wed, 23 Sep 2026 11:21:43 +0000
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

TI's J7200 EVM requires U-Boot to configure the PHY unconditionally
after binding. This prevents any rproc firmware to configure the PHY,
preventing multi-core race conditions.

Enable the PHY_CADENCE_TORRENT_AUTO_PROBE config for this purpose.

Signed-off-by: Aksh Garg <a-garg7@ti.com>
---
 configs/j7200_evm_a72_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/j7200_evm_a72_defconfig b/configs/j7200_evm_a72_defconfig
index 8d9d839a267f..8d0c8175517e 100644
--- a/configs/j7200_evm_a72_defconfig
+++ b/configs/j7200_evm_a72_defconfig
@@ -158,6 +158,7 @@ CONFIG_PCIE_CDNS_TI=y
 CONFIG_PHY=y
 CONFIG_SPL_PHY=y
 CONFIG_PHY_CADENCE_TORRENT=y
+CONFIG_PHY_CADENCE_TORRENT_AUTO_PROBE=y
 CONFIG_PHY_J721E_WIZ=y
 CONFIG_PINCTRL=y
 # CONFIG_PINCTRL_GENERIC is not set
-- 
2.34.1

