Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE74C624D5
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 10:32:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D32F580F81;
	Wed,  2 Sep 2026 10:32:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h77clVOw0j2k; Wed,  2 Sep 2026 10:32:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788345122;
	bh=fgxyIb+jZojkbAjJs7VezLmyoHttC5nxwSxuuztBk1I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WBC7exo8Mlj23OxXK8CzqX/c+RyB7XYAbIZLyPPQL2S5Nco8eu4ezTo4fapGcKUhh
	 8XXpramwIZ2w5POt++TD/lNw9hmYdkD5BkITq/DnC6YWkw6I+QWX6zDEdQJeL1Z/h0
	 hsOZRU0syhC8l1nhEqoFhEoWjACbTOzkTQBUYp4s1LL3ammUzUEBX2yBBhHmGhaSlr
	 RWr+6zDEiEJ1SE8IYxNsMey6qPWNkTlyYZWAbLblqalBcV8nTlrq8khHorLcUJ2Jkb
	 yXTxJ4KhyEk0c7204yEpbYcjs2egloGTvbRCDxs0RbQv6xBKseps0hBb4DkKRfKTT5
	 VRuxX9AHUhgxA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 67A7480F70;
	Wed,  2 Sep 2026 10:32:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24E68363
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:14:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 15EA180EA7
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:14:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kMG2tOyyYzcx for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 09:14:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.150.75;
 helo=mx0a-0002e601.pphosted.com; envelope-from=g-praveen@ti.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=ti.com header.i=@ti.com
 header.a=rsa-sha256 header.s=proofpoint-05-2026 header.b=gkKtEKmU; 
 dkim=pass (1024-bit key,
 unprotected) header.d=ti.com header.i=@ti.com header.a=rsa-sha256
 header.s=selector1 header.b=LcnR7ZLO
Received: from mx0a-0002e601.pphosted.com (mx0a-0002e601.pphosted.com
 [148.163.150.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F0E8280E85
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 09:14:28 +0000 (UTC)
Received: from pps.filterd (m0380145.ppops.net [127.0.0.1])
 by m0380145.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 6826TwmR1625715;
 Wed, 2 Sep 2026 04:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 proofpoint-05-2026; bh=fgxyIb+jZojkbAjJs7VezLmyoHttC5nxwSxuuztBk
 1I=; b=gkKtEKmUXr/HL2hb3WwGQN3+exzRs2+uqnWtvi97uduWAk8ojqBKYNQed
 NWy1dX3/LF69OCkUi5H8lbNoiYjStiK/HBQSJr+N2JmfJgRbwXNDZYirhJqhfkaT
 Fij2wKNHvhiSoj6Q6jxuRNOzwqZp+iLcou3ChZygHqffvyjaY71Q5WG0jWkfPnsN
 vfslv2Mj34wyI7Zm7ReHqUVfLVPKUntRjd5E5Lh9Q0V4R0B0T9xWL/e2KmwloKsP
 IhuE3D2J2e6RbhC1KchqL2WcDC/2hDbyMNM2maZ7ELcMbB/nVKoueHiTbcOxLjSA
 /IkYgd5IURAluwxDP9txEOK2YJWAw==
Received: from sn4pr2101cu001.outbound.protection.outlook.com
 (mail-southcentralusazon11012038.outbound.protection.outlook.com
 [40.93.195.38])
 by m0380145.ppops.net (PPS) with ESMTPS id 4ge7gqaxh6-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 02 Sep 2026 04:14:26 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ko3VTcn7p5M601ZJ2f74WLaRtIY2oH+ExGsm6cx+HPrsAcOgb/g54F2brSDVJS/SrZnFjrehUMefPM76T0L4v38FcsoQUcZ/CVvJVCj+t65gjZ/KtvTpjXrNOZRl9e6bOYDalgJmq0RtwOmmwOFkylLpmLUVylSp7/3fQbjXu3kuG9V1sHwD34XabaiVtuinOXdq7WvsDjTHwvbhC/ZtWvmsm0DPX5eFUeimlkyHdiuiIzYxhy1SJf7fqKyN1O5nG5ZvpIUSx2vCc3ZI6AcdbAq52uNhxcJUxDIj1OoSeWh9QpGxcxsrCSeYQ7jTxIYhC9bBN87Te7Fa+nRwEiBBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgxyIb+jZojkbAjJs7VezLmyoHttC5nxwSxuuztBk1I=;
 b=aHdNA20ULhsf7FkpOHqhL4JH+VmoXN51/CWkBQhilhRaeFo/iK4iHxnCdZ+dHiK1hi5Y+F8uL94mg7oAL75Kn4DrS/eSCCCCUtOKxCjBjXG3B6Aaz14+IPLxTZRmNJQcb0EeocjIX6HSW30gTc1dSh9k547FIuFPcgRQRP++Z9XBKHDZEmxL8RAj2JI4K3W/s6uxJH1qqpUqnuulqsD/HJloGw5AB7CVqd8OZ6F+f+TM6hzYZzHmlTMzPc+F9fDuxzo+UbBC3zgOOJeNAI5Ik9zof6zDjv8UaGDC57ji16ATbc2QOf9wM3tHlU0eJnNp5lS1iBmBSgPtWElWv1RHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=ti.com; dmarc=pass (p=quarantine sp=none pct=100) action=none
 header.from=ti.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgxyIb+jZojkbAjJs7VezLmyoHttC5nxwSxuuztBk1I=;
 b=LcnR7ZLOjKZCEPw+FqlRjF9cQTy1eV7hGREHSHTFHtKcvKAGENsJ2M6Zd/D4v5FdJI84Cd1PSTxs192b6e0IvD8bBQv6s/FpUCsyWIwt/l5FmKnR9cgyIDILVBWN7byaoA5VqpA15ei0eer2mOa7QAUnIGdP0lCGcYKkNE7SEXI=
Received: from CH0PR03CA0285.namprd03.prod.outlook.com (2603:10b6:610:e6::20)
 by SJ5PPFDE34AA4C5.namprd10.prod.outlook.com
 (2603:10b6:a0f:fc02::7d5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 09:14:20 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:e6:cafe::38) by CH0PR03CA0285.outlook.office365.com
 (2603:10b6:610:e6::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:14:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 09:14:19 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 04:13:39 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 2 Sep
 2026 04:13:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45 via Frontend
 Transport; Wed, 2 Sep 2026 04:13:39 -0500
Received: from [10.24.51.66]
 (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [10.24.51.66])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 6829DbeI317906;
 Wed, 2 Sep 2026 04:13:37 -0500
Message-ID: <a53e3b29-8025-4067-8233-385ec3295696@ti.com>
Date: Wed, 2 Sep 2026 14:43:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] A-core no-SPL Boot Support
To: Bryan Brattlof <bb@ti.com>
CC: <trini@konsulko.com>, <n-francis@ti.com>, <a-nandan@ti.com>,
 <u-boot@lists.u-boot-project.org>, Gokul Praveen <g-praveen@ti.com>
References: <20260819101910.39192-1-g-praveen@ti.com>
 <20260901162303.ccuk2gvcoogftjmy@bryanbrattlof.com>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <20260901162303.ccuk2gvcoogftjmy@bryanbrattlof.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|SJ5PPFDE34AA4C5:EE_
X-MS-Office365-Filtering-Correlation-Id: 3660e6e0-0cdf-4a21-8deb-08df08d29200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|10067099003|18002099003|22082099003|56012099006|4143699003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info: kBZzA8TC93Wh4hmJkYuA7AT7x2iQoXnz3zadOK0dcScMKUCFKE8LXEB3JCZyCrw0fyupRCUbeGLUM5+fNgF/Ddl3Yw1+/fS2J/U84Glhvlm45UHKJ+0l3/zQi0aM5XYAIfpyco9yY6OqbQWjQGBilhG5/eTZJaRNlEtiLihMV+q2kxvyIr5dskYLXAaVNIjIAI/XfpsqOzpHUAw9qKdOyoo1x67Da0r7FZPrlKh0dmNyjCqa6w/3uehtmTDBntFAdbH14NfQey9dlr60Ow13R/mtPHOfNpqeXiIWfY9vP1MmslMbF8xYKd9VwnzzKe6urNupyYp++Kzz6ykKVOLGFHgUvSh6GC+teyt5hpE1rF6jXHHD7W1ST1SAHdlgjHJ2w0/BAFYLzmEPF/42nwzhvZBer+iAe908iRfVr3odD8lt27mR6L6IL4+yv9Z2OmbOSqjG1Ibx6DkFsj3OnjtjTjiKYaDODf/yeI7IbXGmmJM8FSFvx0cxeTXWJKTPW+ofyb/D3gxWCCX0/N4q5AuoVZ+/OMwQXM2M2w8xZZlJm15VvQAhLD68ZFL3sH7AhOB0IhG2Jm3BJU4gskQ43CT55NyFDUTbRk51YpWSvRY58T9hs4C6jMoNh+7B6VJXRQ46WFSTPgTH8uGNmgHCYJbQINEeP9seYm+2QahiQr5xZsTmpXaqGTjFQ6NSfEF68Na3oBkaRIKk7V+igNfqzkLphQ==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(6133799003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bv7wV1buJnL0fPV6nlXq3eHH6NOzRqy5DQHeUvTJy4jPhBljdIzmPjXmL+8sL9AFzmunWzJIaScf6zPmwcUwbJ62ZRi4zx8oLOJA47ldDIXoIqvLKHrPzCrZCg4HbNzJJM8GYZhQc9e15p8DPa8JmGiaOYXYzTe6BEKcSpztO//9SjmfitP0wN5Asdrv+1PSOESSceBrbW+JuIGdJJSRjojLocmQHO0y+yDiUrmdb19qONOBkbgCT+Eu1xqi6oSiVxGEAGFnCRkX13b3v4tAZ2LcEMQRcU95iKvdUvFFxXQAMgC1ZwCwyv7vUCY8B59qIhu9695iX9JMwvwncj+BAKYrlok4V24bmESwcPZ+fPuPAgPI+2ZcS00TXoWBxvz7IELMqIgiLYxpOAsA8lmnhJYieR3evwgkrxnT4R4xT0dBavEGzVC5tXL8Fbmwik5i
X-Exchange-RoutingPolicyChecked: X2Sv4DXDt6qF7nx5Nf3W8c7juNY5NiZC3EX6taotTmplTOmV1iPqTiLuYuOCVIIPTm4+G8PHXbdcOGmMUAkCOhJy5eAamnLxLqzXmRWHlHhhQb2lw0kBAE02JrXzgF7xx4Q+1m7GGNnhXnLiM0CG3zaDyqOkTmeKvFyxDWvtN4P0qsj5/urBiuPyfKSYA9ewXkYSt2k4/CXgrU1ML9XLoxlNjIIgWC1xrfrYojEef+1NMnwAHn8756zr6n2LTiJgYSQMqhrhjHpygCxjzOMo7qddqyuKdNcozCmHfRfRIcCamCJA1U96aNlZ7LVewdQ7MaSuQe+KcNS7TbUjZiLkig==
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:14:19.4856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3660e6e0-0cdf-4a21-8deb-08df08d29200
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDE34AA4C5
X-Authority-Analysis: v=2.4 cv=fZ6dDUQF c=1 sm=1 tr=0 ts=6a97e8f2 cx=c_pps
 a=NYwhZoOBzU3e7w62/nBhxQ==:117 a=iwqwCZQqcuTv3JOpYdM7/Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=V5UXEbMT0ywA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Z8NIEmU8O1QQgoT56wFK:22
 a=gO1vWkAQAl3rybz1DQOp:22 a=VwQbUJbxAAAA:8 a=sozttTNsAAAA:8 a=NEAV23lmAAAA:8
 a=LH9g3_EqUCOKoPq4EDUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: T1J0MxDIhrfvwwsemMP26X4d3qFiUnnM
X-Proofpoint-ORIG-GUID: T1J0MxDIhrfvwwsemMP26X4d3qFiUnnM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4MCBTYWx0ZWRfX91PxN/1BKbkh
 EsonX9RVP1eP+y8Ly2IdjsHtN8+UAON8QWRO+G9LR8W+W+d9cCEG4mXtnxkuowCViHqYvn4DkNw
 shlksYbz1S+peYwyn9YW6FPbGOnsA2k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4MCBTYWx0ZWRfX+pTrV6T/3e8Y
 gvofXAQ7MvBNmsuUCvBScdHfoV3TdtDC5/0cKTwBLCJ6/RplC3Z7Wpb7RYuAH2lRo3ys03hwacj
 yYjnYebpFDVNJUaO7XCpo4qz2Qkonv8KHq4bgvQHyzPXZF6/Q0kmzJN+M2QlG1aOv4d3yl+1OBk
 nyTDU2fmWFJqaGBJV/RigcAUePfJXrW4xPiVxpqdG9TnxdN/To9Ad6s5SD7aeQDQ6bCYunUwbJP
 roRBF0bmDJ8JPw9Asv12D7mgDpJ1Fd9tUmLhh144Kfh2TIdJWPjPsB/fLqn/Sv4F6dGyc9FFppm
 nhwQzFVOTQj/BwU8IS5ngWZ+Emts7LjAsCLEckxSWbDQ7ANIMt5/6xKLwHBKqs59lxs7BUrMhBf
 ppY6VxmhQkr8zVLuCsvc+O5kYv4n2RKASKrCb8Tf+F5Luab8elDHHMmkWGKCCsis9dQlF2+XKt/
 ALve4h2pe6PIgZUnBkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_01,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020080
X-Mailman-Approved-At: Wed, 02 Sep 2026 10:31:56 +0000
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

Hi Bryan,

On 01/09/26 21:53, Bryan Brattlof wrote:
> On August 19, 2026 thus sayeth Gokul Praveen:
>> A-Core no-SPL Mode is a boot approach that bypasses
>> the A Core SPL while retaining U-Boot in the boot flow.
>> This mode provides faster boot times compared to normal boot
>> while maintaining U-Boot's flexibility for kernel loading
>> and system configuration..
>>
>> v3<==> v2
>> ===========
>> * Updated the naming convention used from "no-spl" to "A-core no-spl" to
>> * make it more specific and clear..
>> * Link to v2:https://lore.kernel.org/all/20260818115322.101705-1-g-praveen@ti.com/
>>
>> v2<==> v1
>> ===========
>> * Updated the naming convention used from "semi-falcon" to "no-spl".
>> * Link to v1: https://lore.kernel.org/all/20260814102153.44487-1-g-praveen@ti.com/
>>
>> Boot logs link :
>> https://gist.github.com/GokulPraveen2001/fef407a482e2dad30272006de557627c
>>
>> Gokul Praveen (3):
>>    configs: add A-core no-SPL mode fragment for k3 devices
>>    arm: k3-binman: add tinospl.bin for direct U-Boot boot
>>    doc: ti: document A Core no-SPL boot mode for J784S4 EVM
>>
>>   Makefile                               |   2 +-
>>   arch/arm/dts/k3-binman.dtsi            |  47 ++++++++
>>   arch/arm/dts/k3-j784s4-binman.dtsi     |  65 +++++++++++
>>   arch/arm/dts/k3-j784s4-evm-u-boot.dtsi |  14 +++
>>   configs/k3_a72_nospl.config            |   1 +
>>   configs/k3_r5_nospl.config             |   1 +
> Please make sure to update the board/ti/*/MAINTAINERS entries for these
> config fragments.

Got it, do you recommend creating a separate MAINTAINERS folder

in the board/ti folder and adding my name under some TI BOOTFLOWS 
heading with subheading as

A-Core no-SPL mode or do you instead  recommend adding TI BOOTFLOWS 
heading with subheading as

A-Core no-SPL mode inside all the board/ti/*/MAINTAINERS files.

Best Regards

Gokul Praveen

>
> ~Bryan
