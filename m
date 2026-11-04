Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64130606A326
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=a0wSGZum;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V1G48xLJ
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 395758110A;
	Wed,  4 Nov 2026 10:01:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GiROuhYd1sny; Wed,  4 Nov 2026 10:01:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 730238108E
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793786466;
	b=kiQG0Vhlz2bocqh76qKEv+mLUE0OhO2nspPvLU8SVvdCS0u+koa67V3Ko9IWFe/Taa/9
	 zKJpfiZAT+jl9uQODwvxaxdnpr3/jC1Qwy8oyKFUZCP0LbUUCP2A7u91uzPOonopqcrG1
	 YTDjULSrON7/rcdE8AR81D3oe0yEvcPRg7tHJhqhY1c9IICmVpESSVA26te547lg4Ifkj
	 0yA2mPzd4JuAqD6pkSgb0wiXM01GGzKVyMHrm2qn7cGs1dZLY2Nsf+DV3zy6DyO+6Bro4
	 sbg9BjRnXupwgQQ3EmVmpxjHE2sdnV5xudxeU9ZfSELTsKqWYQ6yta4ibUfpwByGCtw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786466;
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
	bh=HTncPV9Y83c1A8aPlDpnlTMdVWSRZvABmZOdqQ9E9Ww=;
	b=ZzQ/Yp+NMmrzxhR1xyacEHGwbKLvqjm0y1ps0Z2SZaGpAvzOmL2+w1Kyt03CLtjDPj7t
	 6FaUiBIzJcpsjkHDPFS7hPg2jEKwyFLR1BKfKfXY6FbCUwS4bU1mz/OEMIAPgyTXff7hm
	 qv6C5uVqSngwgLkawom36rmSy7jq3eMa4QAuqjvwdSUxWNml6HdyEMVrhzJxwIxIcTJSN
	 PJw8KUjNrubEnEAFOcFF8VhHjaqWtCNLODox+lxZosg4wWvhr3QE6jKPj+tDf643Hnu4/
	 ZCxPHpy/0cSyFzSF5Q1VZX1q6mhznQRP9o8vSabpBEwsbaUdaoCeW7Sft/AoDtxt/lQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=V1G48xLJ;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793786466;
	bh=HTncPV9Y83c1A8aPlDpnlTMdVWSRZvABmZOdqQ9E9Ww=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a0wSGZum6VzAYpRLZdI1dsOMnroAyiCLGY7RClAvNpNw/sY1dbnIli3xfE5APJuKS
	 PWEaDjYUEcWc1L97LwXNP3EwiDIv/syU2QUe+f8SyjCOP8KBwWF+D+NYF8qWYZegmw
	 /cEzhHaNpfBFdfOrCDxbqPDvKVazGP6zjIFfV9lWB913OQp36QY+zHHvvw9NlsnSRX
	 5Cx1unFzS5b4o10p8+h684tRmikNsbhQK4VI0idH17tFfEWT8e/qItUEqfxIP4H6Xf
	 TYGGzWggD3qVfoYv8o3b5pf+c97bRt/R73A+CYK1dxz1ugCueQ+pDREh+qXEDmH8Xs
	 Kn2Phg4eqBT/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 730238108E;
	Wed,  4 Nov 2026 10:01:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3713837B
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:01:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1CC2A8108E
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:01:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IHWxe9rcks2q for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:01:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3FFDB80FE8
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10c::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793786462;
 b=q3Ok3j4SHQB60INpNa5Phgw9x0qc1wh0Xi9Tf1T74qs45nXa0QJK4SOHYzxI2rSZ8nUm
 BAcsvP7oO3kgyjJt3I4L0S8F/Jsu3XlLh1SXA6GE+tK/cbOEJtuY12E6Z+nUeFUo6MAY0
 3cPw5av8OMcv0lzn36shlNoiINmkKOkaowk0/rOUPZR6PsLjcSOn8rDPo8RhT0NC3qETW
 JpOUW+rkEA5v2hvFIMLDoE/Vj1EwnFGhFjTVEZPUpVvkivXIaS15RDlOqlSVLad5kCwb4
 Rn3v4ndnw+lNg2TEd70RTayh+09N9efDSrPf3gonsYkFi++r9SytGOzTH0WITzm5Nbg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793786462;
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
 bh=HTncPV9Y83c1A8aPlDpnlTMdVWSRZvABmZOdqQ9E9Ww=;
 b=F28SdqUXFIhgAwr4AiFGqWBlK4bZTkyUhG6+0Msprkyl7TjLmP1YUApN8wDrAxFALhCv
 sfRJ16hp2K95g+ZRa34ZV3cF9Kj3IeCrrp52RTfFugWogMtmcFYZipzdRR/eftJta88oa
 3N+PF7M9XjHTnzDyj/v6CZpuvgzeUq6rd+E/mrgoGgAtuvGHBTKmLc6eEf6YptrvR4918
 eC+l9i+YyOUdIkPhgSu+1Uqxoc7CNMw49/UlcXLKgbYlv4OlFrJlLJ2THVmtcNa9TzGvT
 feSna6rePpgtMO7zYUng542KuUUTIB7g6/7Ed9xZ4K2FNgL14YbPn78pYtYOv0W8rhA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=V1G48xLJ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10c::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10c::1;
 helo=sa9pr02cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=V1G48xLJ
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170130001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10c::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3FFDB80FE8
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:01:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VsXXqrUolI3LFLa4fA2/7VpNFRmlW8mow0XwD1zrwT9hbVoKCtayMk9ZGuzRg5YPBxB8FwFWy1J1SkP3gEUd7hHYar837RADh3bod+xfbE+YclzW6m7z/2xuSNRtSba4/ZSw/tJ8hRpMjoMpLDc6u7caUEQiWo4loSl4IlOnmPd4wBzw/5altP+ubUW+O+waZ6EigMAlOhW8Iciiye1XjbFpbz71Wm3/onUM3EXlWlpMo0TJ0ZvINgO7htSr4fLa9sfXXvZTx46xNOG168kzoConrNLhrGKINaeDIGiXgS4xsZ4L36rwbWTlnhWCKi29LKviRrg3YGNeGabdLI2L2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTncPV9Y83c1A8aPlDpnlTMdVWSRZvABmZOdqQ9E9Ww=;
 b=mu6ajVUV05z77hwmiGsVh7GPjtjy9evX4U7sn7ajNOqGXPfzohtJNicgiA8xXN+4wqPP0fUcCB/kwwX+fSswgFgsqPS6x34jI6a3+DD1HWcisHe8cXpMF0Pu0xeiFPb5obxfvUY7YR/nsaUQsAirqfv2PMM5qkjvvLcfiD9J3Wh0FL3iT7e8DF2ER9S7pGXdhiUJ5qB2rqtmtXHl4GbWdKDT3hzza6FBb4GpXNQc60TkfHjeL2AWA1+Bb0yJt3pAz4VTWkYdQJ4r/oVhH7W1+qBlGv5KTME7+SOqq7nc+bc3PN2V/5jQOKsX7vB048n6AHktMZKG0vy/w6zkP8LCcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTncPV9Y83c1A8aPlDpnlTMdVWSRZvABmZOdqQ9E9Ww=;
 b=V1G48xLJoOS4BRNHFbBiDQLNZweSrVdcKcOmPXjH8V1tJxmDJ2VjGq53tr0GPQKLg/ubAnkD9K0hn37+UPqHJ9djFo3VRbDKmdFKDLhpx+yczcKdlwAsPF6w918NGDedZ0ifqeZZlaBe0hN2/U586573GZVKQjo2+zsjv58OGTQ=
Received: from CH2PR10CA0014.namprd10.prod.outlook.com (2603:10b6:610:4c::24)
 by DS1PR12MB999190.namprd12.prod.outlook.com (2603:10b6:8:495::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 10:00:55 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:610:4c:cafe::5a) by CH2PR10CA0014.outlook.office365.com
 (2603:10b6:610:4c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Wed, 4
 Nov 2026 10:00:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:00:54 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:40 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 04:00:37 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Amit Kumar Mahapatra
 <amit.kumar-mahapatra@amd.com>, Alexey Charkov <alchark@flipper.net>,
 Lucien.Jheng <lucienzx159@gmail.com>, Casey Connolly
 <casey.connolly@linaro.org>
Subject: [PATCH v2 5/7] test: dm: Add tests for MTD virtual concat
Date: Wed, 4 Nov 2026 15:29:39 +0530
Message-ID: <20261104100005.4104985-6-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104100005.4104985-1-padmarao.begari@amd.com>
References: <20261104100005.4104985-1-padmarao.begari@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|DS1PR12MB999190:EE_
X-MS-Office365-Filtering-Correlation-Id: 0447fcae-f4bb-4c26-1610-08df3a5a841c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|6133799003|10067099003|22082099003|18002099003|5023799004|11063799006|56012099006|261022105027099003|261102123227099003|261009223027099003|261021121427099003|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261022075727099003;
X-Microsoft-Antispam-Message-Info: yuYMXmiqlUlkcSzJKYqCT+CBTN5UEtT0O4ET7WIBs7PFitzSNlqpkUqS/Abk64r4zgfhehFOwrLO9rDpW202ijK2WerlBPPrlbfUqDMJ+rPzkwY3Fq5Rh8lV1lX0ADvHoKTYoPJHdC95IfiwvRVOB76dZCKAt0clfhCp5vdbcaH76ObTMSO0rsYTnkE1BJi5GjGcc5WB04C9NhLrX+I0eKIYzF/Pyzynq/ExnKtaRfL1zjzTVGwfFKVub/08NfMr/n6oAb2Yzgs3nbte2JkkbYKzhHADbJjAKnf30GukjEZDLhPbSWL7VsjQFK/igMjDOCk8lgaSEvd2Xy0Vd0v8XUvB+reDVMNd3U2xDtryUHAOeiI9ft/njM3qt23+cP0mJVZV+QjNexn1T1rrqpSRuFQw9updmgbA0bES8Hk4ZS4Y+F1UIqL5U73lALf3oWfLCl9yQENTracmuc4lHneBhmTgqdhXRnhLTD8TfoBVv1pLcFCXu/CdAKui+rl/vkUGxlct1SUOjSaeS8mWHgOfeVb8v9rndyi+NbPgfFpiPCW2LB8MjYYZjDgTPPhBcRh2KdWON5NnLCS5MYu+U43ax0eL2WN+Q2MEZT257JJl9A9cHgsI0xSYK6gmitrGBw1j/jvIWWzL0DsvZpB+e667XbLercHuYDiYUV+i7Pe9LB/1xrmb9vq7+QQpBccYvn2a
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(261022105027099003)(261102123227099003)(261009223027099003)(261021121427099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mDOEFQEoxLX4iNenTNZr80SuIwz47l/iwE6tfOO2BJSWDducAAYc+swmNoMX2c/uQynwGlkmA0l4QozZOBSXMgjyUNuORRTkL0U2Ik3oRAp6Jp74ih7wltbuOy1y+lhqo+F1Anf9OlRYKCSgBA320fssk3q/DmTz6j2RzVROUIn5sRV+a1z0ZJGit+Z8ERHkOoMVtU7rny7Odxgoa0tzfWABIjWs9bV7DAPGGkyYY3468ctDyb4n9Y0mlc+K/UISTbBrj2TULKOPYRMet+S7RRkcs4VgqYsue+IovZRhFEdefqhGccOuAlWlYd9Xtvg25GdLkKZbyVWziewa4X43VmYUkQjnoGpRmqZs/keM8uNnOkBt7RK+jhY2/+9xl6nU7rMNERXerVEsY4fPja3wemYhfdXPZA0eldSrgnvFZA5G0xzL/MEQNkYW567QUaRp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:00:54.7349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0447fcae-f4bb-4c26-1610-08df3a5a841c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR12MB999190
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enable CONFIG_MTD_VIRT_CONCAT for sandbox and concatenate the unused
"nor-spare" partition of spi.bin@0 with a new "nor1-spare" partition on
spi.bin@1. Also concatenate two new partitions of spi.bin@1, "nor1-b1"
and "nor1-b2", with each other. All the flashes use spi.bin, but the
partitions of the first group do not overlap, and the second group is
only used to check which devices exist.

Add tests which check that:

- the partitions are joined into one device, and are not registered on
  their own, while other partitions are
- data written across the boundary between the flashes lands in the
  right place on each flash
- scanning the partitions again keeps the concatenated devices, and
  does not leak memory
- a concatenated device which is in use, or a partition of its flash
  which is in use, does not change when the partitions are scanned, and
  mtdparts is not applied to a flash while its concatenated device is
  in use
- destroying the concatenated devices of a flash carries on past one
  which is in use
- removing a flash destroys its concatenated devices, and the next scan
  creates them again
- the partitions of an incomplete group are registered individually,
  and so is one which is out of reach
- a page can be written to a concatenated device made of NAND devices

Most of the tests need the live tree, since the sandbox NAND devices,
which are also scanned for partitions, refer to it.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
Changes in v2:
- New patch: add sandbox tests

checkpatch reports 'Please use a blank line after
function/struct/union/enum declarations' for each DM_TEST() line.
DM_TEST() is placed directly after its test function, as in the other
tests.

 MAINTAINERS               |   1 +
 arch/sandbox/dts/test.dts |  23 ++
 configs/sandbox_defconfig |   1 +
 test/dm/Makefile          |   1 +
 test/dm/mtd_concat.c      | 543 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 569 insertions(+)
 create mode 100644 test/dm/mtd_concat.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 313f42ad939..0553f4034ee 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1324,6 +1324,7 @@ M:	Amit Kumar Mahapatra <amit.kumar-mahapatra@amd.com>
 S:	Maintained
 F:	drivers/mtd/mtd_virt_concat.c
 F:	include/linux/mtd/concat.h
+F:	test/dm/mtd_concat.c
 
 NETWORK
 M:	Jerome Forissier <jerome.forissier@arm.com>
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 02a9ca29b79..de10e6154ad 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -1685,6 +1685,7 @@
 				partition@100000 {
 					label = "nor-spare";
 					reg = <0x100000 0x100000>;
+					part-concat-next = <&nor1_spare>;
 				};
 			};
 		};
@@ -1695,6 +1696,28 @@
 			sandbox,filename = "spi.bin";
 			spi-cpol;
 			spi-cpha;
+
+			partitions {
+				compatible = "fixed-partitions";
+				#address-cells = <1>;
+				#size-cells = <1>;
+
+				nor1_spare: partition@0 {
+					label = "nor1-spare";
+					reg = <0x0 0x100000>;
+				};
+
+				partition@100000 {
+					label = "nor1-b1";
+					reg = <0x100000 0x80000>;
+					part-concat-next = <&nor1_b2>;
+				};
+
+				nor1_b2: partition@180000 {
+					label = "nor1-b2";
+					reg = <0x180000 0x80000>;
+				};
+			};
 		};
 		eeprom@3 {
 			reg = <3>;
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index a3fa5246082..f425e4c95c6 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -264,6 +264,7 @@ CONFIG_MMC_PCI=y
 CONFIG_MMC_SANDBOX=y
 CONFIG_MMC_SDHCI=y
 CONFIG_DM_MTD=y
+CONFIG_MTD_VIRT_CONCAT=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_SYS_MAX_NAND_DEVICE=8
diff --git a/test/dm/Makefile b/test/dm/Makefile
index 1b3a20aa932..aedd9148f2d 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_DM_MDIO_MUX) += mdio_mux.o
 obj-$(CONFIG_MEMORY) += memory.o
 obj-$(CONFIG_MISC) += misc.o
 obj-$(CONFIG_DM_MMC) += mmc.o
+obj-$(CONFIG_MTD_VIRT_CONCAT) += mtd_concat.o
 obj-$(CONFIG_CMD_MUX) += mux-cmd.o
 obj-$(CONFIG_MULTIPLEXER) += mux-emul.o
 obj-$(CONFIG_MUX_MMIO) += mux-mmio.o
diff --git a/test/dm/mtd_concat.c b/test/dm/mtd_concat.c
new file mode 100644
index 00000000000..7e678b32472
--- /dev/null
+++ b/test/dm/mtd_concat.c
@@ -0,0 +1,543 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Tests for MTD virtual concatenation
+ *
+ * Copyright (C) 2026 Advanced Micro Devices, Inc.
+ */
+
+#include <dm.h>
+#include <env.h>
+#include <malloc.h>
+#include <mtd.h>
+#include <nand.h>
+#include <os.h>
+#include <rand.h>
+#include <spi_flash.h>
+
+#include <dm/device-internal.h>
+#include <dm/test.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/mtd/concat.h>
+#include <linux/mtd/mtd.h>
+#include <linux/sizes.h>
+#include <test/test.h>
+#include <test/ut.h>
+
+/*
+ * In test.dts, "nor-spare" (spi.bin@0, 0x100000-0x200000) is concatenated
+ * with "nor1-spare" (spi.bin@1, 0x0-0x100000), and "nor1-b1" with "nor1-b2"
+ * (spi.bin@1, 0x100000-0x180000 and 0x180000-0x200000). All the flashes use
+ * spi.bin as their backing file, so the second group overlaps the first, but
+ * only the first is used to access data.
+ */
+#define CONCAT_NAME	"nor-spare-nor1-spare-concat"
+#define CONCAT2_NAME	"nor1-b1-nor1-b2-concat"
+#define FLASH_SIZE	SZ_2M
+#define PART_SIZE	SZ_1M
+#define ERASE_SIZE	SZ_64K
+#define BUF_SIZE	SZ_8K
+
+/* Scanning again must not use more memory than this, in bytes, in total */
+#define LEAK_LIMIT	128
+
+/* Number of times to scan again, to see that nothing is lost each time */
+#define RESCANS		8
+
+/* Set in a concat device, to tell it from a new one in the same place */
+#define MARK		0x1234
+
+#define MTDIDS0		"nor0=nor0"
+#define MTDIDS1		"nor1=nor1"
+#define MTDPARTS_NOR0	"mtdparts=nor0:1m(nor0-mtdparts)"
+
+/* Create the backing file and add the MTD devices and DT partitions */
+static int setup_mtd(struct unit_test_state *uts)
+{
+	void *buf;
+
+	buf = calloc(1, FLASH_SIZE);
+	ut_assertnonnull(buf);
+	ut_assertok(os_write_file("spi.bin", buf, FLASH_SIZE));
+	free(buf);
+
+	/*
+	 * mtd_probe_devices() only scans the partitions again when mtdids or
+	 * mtdparts has changed
+	 */
+	ut_assertok(env_set("mtdids", MTDIDS0));
+	ut_assertok(mtd_probe_devices());
+
+	return 0;
+}
+
+/*
+ * Change mtdids, so that the next mtd_probe_devices() scans the partitions
+ * again. Both values have the same length, so that the copy which
+ * mtd_probe_devices() keeps does not change the amount of free memory.
+ */
+static int change_mtdids(struct unit_test_state *uts)
+{
+	const char *mtdids = env_get("mtdids");
+
+	ut_assertnonnull(mtdids);
+	if (!strcmp(mtdids, MTDIDS0))
+		ut_assertok(env_set("mtdids", MTDIDS1));
+	else
+		ut_assertok(env_set("mtdids", MTDIDS0));
+
+	return 0;
+}
+
+/* Undo setup_mtd() */
+static int cleanup_mtd(struct unit_test_state *uts)
+{
+	ut_assertok(env_set("mtdparts", NULL));
+	ut_assertok(env_set("mtdids", NULL));
+
+	/*
+	 * Scan once more, so that mtd_probe_devices() forgets the old values
+	 * and later callers do not scan the partitions again
+	 */
+	ut_assertok(mtd_probe_devices());
+
+	return 0;
+}
+
+/* Check whether an MTD device is registered */
+static int check_mtd(struct unit_test_state *uts, const char *name,
+		     bool expect)
+{
+	struct mtd_info *mtd;
+
+	mtd = get_mtd_device_nm(name);
+	if (!expect) {
+		ut_asserteq_ptr(ERR_PTR(-ENODEV), mtd);
+		return 0;
+	}
+	ut_assertok_ptr(mtd);
+	put_mtd_device(mtd);
+
+	return 0;
+}
+
+/* Get the MTD device of a SPI flash */
+static struct mtd_info *flash_mtd(struct udevice *dev)
+{
+	struct spi_flash *flash = dev_get_uclass_priv(dev);
+
+	return &flash->mtd;
+}
+
+/*
+ * These tests need the live tree, since the sandbox NAND devices, which are
+ * registered at start-up and also scanned for partitions, still refer to the
+ * live tree.
+ *
+ * A device which a test holds must be let go before the test ends, even if a
+ * check fails, since it must not be in use when the driver model is removed.
+ * So such a test makes its checks in a function, and lets go afterwards.
+ */
+
+/* Test that the partitions are joined and can be accessed */
+static int dm_test_mtd_virt_concat(struct unit_test_state *uts)
+{
+	struct udevice *dev0, *dev1;
+	struct erase_info erase;
+	struct mtd_info *mtd;
+	u8 *wbuf, *rbuf;
+	size_t retlen;
+	loff_t offset;
+	int i;
+
+	ut_assertok(setup_mtd(uts));
+
+	mtd = get_mtd_device_nm(CONCAT_NAME);
+	ut_assertok_ptr(mtd);
+	ut_asserteq(MTD_NORFLASH, mtd->type);
+	ut_asserteq(2 * PART_SIZE, mtd->size);
+	ut_asserteq(ERASE_SIZE, mtd->erasesize);
+
+	/* The partitions in the groups are not registered on their own... */
+	ut_assertok(check_mtd(uts, "nor-spare", false));
+	ut_assertok(check_mtd(uts, "nor1-spare", false));
+	ut_assertok(check_mtd(uts, "nor1-b1", false));
+	ut_assertok(check_mtd(uts, "nor1-b2", false));
+	ut_assertok(check_mtd(uts, CONCAT2_NAME, true));
+
+	/* ...but other partitions are */
+	ut_assertok(check_mtd(uts, "nor-fit", true));
+
+	wbuf = malloc(BUF_SIZE);
+	ut_assertnonnull(wbuf);
+	rbuf = malloc(BUF_SIZE);
+	ut_assertnonnull(rbuf);
+	for (i = 0; i < BUF_SIZE; i++)
+		wbuf[i] = i * 7 + 3;
+
+	/* Erase, write and read back across the boundary between flashes */
+	offset = PART_SIZE - BUF_SIZE / 2;
+	memset(&erase, '\0', sizeof(erase));
+	erase.mtd = mtd;
+	erase.addr = PART_SIZE - ERASE_SIZE;
+	erase.len = 2 * ERASE_SIZE;
+	ut_assertok(mtd_erase(mtd, &erase));
+	ut_assertok(mtd_write(mtd, offset, BUF_SIZE, &retlen, wbuf));
+	ut_asserteq(BUF_SIZE, retlen);
+	ut_assertok(mtd_read(mtd, offset, BUF_SIZE, &retlen, rbuf));
+	ut_asserteq(BUF_SIZE, retlen);
+	ut_asserteq_mem(wbuf, rbuf, BUF_SIZE);
+
+	/* Each half must have gone to the right place on its own flash */
+	ut_assertok(uclass_get_device_by_name(UCLASS_SPI_FLASH, "spi.bin@0",
+					      &dev0));
+	ut_assertok(uclass_get_device_by_name(UCLASS_SPI_FLASH, "spi.bin@1",
+					      &dev1));
+	ut_assertok(spi_flash_read_dm(dev0, FLASH_SIZE - BUF_SIZE / 2,
+				      BUF_SIZE / 2, rbuf));
+	ut_asserteq_mem(wbuf, rbuf, BUF_SIZE / 2);
+	ut_assertok(spi_flash_read_dm(dev1, 0, BUF_SIZE / 2, rbuf));
+	ut_asserteq_mem(wbuf + BUF_SIZE / 2, rbuf, BUF_SIZE / 2);
+
+	free(rbuf);
+	free(wbuf);
+	put_mtd_device(mtd);
+	ut_assertok(cleanup_mtd(uts));
+
+	return 0;
+}
+DM_TEST(dm_test_mtd_virt_concat, UTF_SCAN_FDT | UTF_LIVE_TREE);
+
+/* Test that scanning the partitions again keeps the concatenated devices */
+static int dm_test_mtd_virt_concat_rescan(struct unit_test_state *uts)
+{
+	struct mtd_info *mtd;
+	ulong mem;
+	int i;
+
+	ut_assertok(setup_mtd(uts));
+
+	/*
+	 * Mark the device, so that a new one can be told apart from it, even
+	 * if it was allocated at the same address
+	 */
+	mtd = get_mtd_device_nm(CONCAT_NAME);
+	ut_assertok_ptr(mtd);
+	mtd->ecc_stats.corrected = MARK;
+	put_mtd_device(mtd);
+
+	/*
+	 * Scan several times. Each scan creates and frees the other
+	 * partitions, but must not leave anything behind, so check the total
+	 * rather than the exact amount of free memory, which depends on how
+	 * the heap happens to be laid out.
+	 */
+	ut_assertok(change_mtdids(uts));
+	ut_assertok(mtd_probe_devices());
+	mem = ut_check_free();
+	for (i = 0; i < RESCANS; i++) {
+		ut_assertok(change_mtdids(uts));
+		ut_assertok(mtd_probe_devices());
+	}
+	ut_assert(ut_check_delta(mem) < LEAK_LIMIT);
+
+	mtd = get_mtd_device_nm(CONCAT_NAME);
+	ut_assertok_ptr(mtd);
+	ut_asserteq(MARK, mtd->ecc_stats.corrected);
+	put_mtd_device(mtd);
+	ut_assertok(check_mtd(uts, "nor-spare", false));
+	ut_assertok(check_mtd(uts, "nor1-spare", false));
+	ut_assertok(check_mtd(uts, "nor-fit", true));
+
+	ut_assertok(cleanup_mtd(uts));
+
+	return 0;
+}
+DM_TEST(dm_test_mtd_virt_concat_rescan, UTF_SCAN_FDT | UTF_LIVE_TREE);
+
+/* Check that a concat device survives a scan while another partition is in use */
+static int check_busy(struct unit_test_state *uts, struct mtd_info *concat)
+{
+	struct mtd_info *mtd;
+
+	ut_assertok(change_mtdids(uts));
+	ut_assertok(mtd_probe_devices());
+	mtd = get_mtd_device_nm(CONCAT_NAME);
+	ut_asserteq_ptr(concat, mtd);
+	put_mtd_device(mtd);
+	ut_assertok(check_mtd(uts, "nor-spare", false));
+	ut_assertok(check_mtd(uts, "nor1-spare", false));
+	ut_assertok(check_mtd(uts, "nor-fit", true));
+
+	return 0;
+}
+
+/* Check that mtdparts leaves a flash alone while its concat device is in use */
+static int check_busy_mtdparts(struct unit_test_state *uts,
+			       struct mtd_info *concat)
+{
+	struct mtd_info *mtd;
+
+	ut_assertok(env_set("mtdparts", MTDPARTS_NOR0));
+	ut_assertok(mtd_probe_devices());
+	mtd = get_mtd_device_nm(CONCAT_NAME);
+	ut_asserteq_ptr(concat, mtd);
+	put_mtd_device(mtd);
+	ut_assertok(check_mtd(uts, "nor0-mtdparts", false));
+	ut_assertok(check_mtd(uts, "nor-fit", true));
+
+	return 0;
+}
+
+/* Test a concat device which is in use, and a partition which is in use */
+static int dm_test_mtd_virt_concat_busy(struct unit_test_state *uts)
+{
+	struct mtd_info *concat, *fit;
+	int ret;
+
+	ut_assertok(setup_mtd(uts));
+
+	concat = get_mtd_device_nm(CONCAT_NAME);
+	ut_assertok_ptr(concat);
+	fit = get_mtd_device_nm("nor-fit");
+	if (IS_ERR(fit)) {
+		put_mtd_device(concat);
+		ut_assertok_ptr(fit);
+	}
+
+	/* A partition of the same flash in use does not affect the concat */
+	ret = check_busy(uts, concat);
+	put_mtd_device(fit);
+
+	/* With the concat in use, the flash keeps its device tree partitions */
+	if (!ret)
+		ret = check_busy_mtdparts(uts, concat);
+	put_mtd_device(concat);
+	ut_assertok(ret);
+
+	/*
+	 * Once the concat device is free, mtdparts is used, and it replaces
+	 * the concat device. The partition left over from the group is then
+	 * registered on its own.
+	 */
+	ut_assertok(mtd_probe_devices());
+	ut_assertok(check_mtd(uts, CONCAT_NAME, false));
+	ut_assertok(check_mtd(uts, "nor0-mtdparts", true));
+	ut_assertok(check_mtd(uts, "nor1-spare", true));
+
+	/* Without mtdparts, the group is joined again */
+	ut_assertok(cleanup_mtd(uts));
+	ut_assertok(check_mtd(uts, CONCAT_NAME, true));
+
+	return 0;
+}
+DM_TEST(dm_test_mtd_virt_concat_busy, UTF_SCAN_FDT | UTF_LIVE_TREE);
+
+/* Check that the concat devices of a flash go, except one which is in use */
+static int check_destroy(struct unit_test_state *uts, struct udevice *dev)
+{
+	ut_asserteq(-EBUSY, mtd_virt_concat_destroy(flash_mtd(dev)));
+	ut_assertok(check_mtd(uts, CONCAT_NAME, true));
+	ut_assertok(check_mtd(uts, CONCAT2_NAME, false));
+
+	return 0;
+}
+
+/* Test destroying the concat devices of a flash, one of which is in use */
+static int dm_test_mtd_virt_concat_destroy(struct unit_test_state *uts)
+{
+	struct mtd_info *concat;
+	struct udevice *dev;
+	int ret;
+
+	ut_assertok(setup_mtd(uts));
+	ut_assertok(uclass_get_device_by_name(UCLASS_SPI_FLASH, "spi.bin@1",
+					      &dev));
+
+	concat = get_mtd_device_nm(CONCAT_NAME);
+	ut_assertok_ptr(concat);
+	ret = check_destroy(uts, dev);
+	put_mtd_device(concat);
+	ut_assertok(ret);
+
+	/* The one which was destroyed is created again by the next scan */
+	ut_assertok(mtd_probe_devices());
+	ut_assertok(check_mtd(uts, CONCAT_NAME, true));
+	ut_assertok(check_mtd(uts, CONCAT2_NAME, true));
+
+	ut_assertok(cleanup_mtd(uts));
+
+	return 0;
+}
+DM_TEST(dm_test_mtd_virt_concat_destroy, UTF_SCAN_FDT | UTF_LIVE_TREE);
+
+/* Test removing a flash that concatenated devices use */
+static int dm_test_mtd_virt_concat_remove(struct unit_test_state *uts)
+{
+	struct mtd_info *mtd;
+	struct udevice *dev;
+	int idx;
+
+	ut_assertok(setup_mtd(uts));
+
+	/* Both concat devices are above the flash, so find the lowest */
+	mtd = get_mtd_device_nm(CONCAT_NAME);
+	ut_assertok_ptr(mtd);
+	idx = mtd->index;
+	put_mtd_device(mtd);
+	mtd = get_mtd_device_nm(CONCAT2_NAME);
+	ut_assertok_ptr(mtd);
+	idx = min(idx, mtd->index);
+	put_mtd_device(mtd);
+
+	/*
+	 * Removing a flash destroys the concat devices. Check their indexes
+	 * rather than their names, since the list of MTD devices stops at the
+	 * first unused index, which the flash has just freed.
+	 */
+	ut_assertok(uclass_get_device_by_name(UCLASS_SPI_FLASH, "spi.bin@1",
+					      &dev));
+	ut_assertok(device_remove(dev, DM_REMOVE_NORMAL));
+	ut_assertnull(__mtd_next_device(idx));
+
+	/* and the next scan, which probes the flash again, joins them again */
+	ut_assertok(mtd_probe_devices());
+	ut_assertok(check_mtd(uts, CONCAT_NAME, true));
+	ut_assertok(check_mtd(uts, CONCAT2_NAME, true));
+
+	ut_assertok(cleanup_mtd(uts));
+
+	return 0;
+}
+DM_TEST(dm_test_mtd_virt_concat_remove, UTF_SCAN_FDT | UTF_LIVE_TREE);
+
+/* Test that the partitions of an incomplete group are registered */
+static int dm_test_mtd_virt_concat_incomplete(struct unit_test_state *uts)
+{
+	ut_assertok(setup_mtd(uts));
+
+	/* Use mtdparts for nor0, so that its DT partitions are not added */
+	ut_assertok(env_set("mtdparts", MTDPARTS_NOR0));
+	ut_assertok(mtd_probe_devices());
+
+	ut_assertok(check_mtd(uts, CONCAT_NAME, false));
+	ut_assertok(check_mtd(uts, "nor0-mtdparts", true));
+	ut_assertok(check_mtd(uts, "nor1-spare", true));
+
+	ut_assertok(cleanup_mtd(uts));
+
+	return 0;
+}
+DM_TEST(dm_test_mtd_virt_concat_incomplete, UTF_SCAN_FDT | UTF_LIVE_TREE);
+
+/* Test that a partition which is out of reach is not concatenated */
+static int dm_test_mtd_virt_concat_bad_part(struct unit_test_state *uts)
+{
+	struct udevice *dev;
+	__be32 reg[2];
+	ofnode node;
+
+	ut_assertok(setup_mtd(uts));
+	ut_assertok(uclass_get_device_by_name(UCLASS_SPI_FLASH, "spi.bin@1",
+					      &dev));
+	node = ofnode_path("/spi@0/spi.bin@1/partitions/partition@0");
+	ut_assert(ofnode_valid(node));
+
+	/* Move "nor1-spare" beyond the end of the flash, and form the group */
+	reg[0] = cpu_to_be32(SZ_2M + SZ_1M);
+	reg[1] = cpu_to_be32(PART_SIZE);
+	ut_assertok(ofnode_write_prop(node, "reg", reg, sizeof(reg), true));
+	ut_assertok(mtd_virt_concat_destroy(flash_mtd(dev)));
+	ut_assertok(mtd_probe_devices());
+
+	/* Its group is left incomplete, so "nor-spare" is registered alone */
+	ut_assertok(check_mtd(uts, CONCAT_NAME, false));
+	ut_assertok(check_mtd(uts, "nor-spare", true));
+
+	/* Put it back, and the group is joined again */
+	reg[0] = cpu_to_be32(0);
+	ut_assertok(ofnode_write_prop(node, "reg", reg, sizeof(reg), true));
+	ut_assertok(change_mtdids(uts));
+	ut_assertok(mtd_probe_devices());
+	ut_assertok(check_mtd(uts, CONCAT_NAME, true));
+
+	ut_assertok(cleanup_mtd(uts));
+
+	return 0;
+}
+DM_TEST(dm_test_mtd_virt_concat_bad_part, UTF_SCAN_FDT | UTF_LIVE_TREE);
+
+/* Test that a page can be written to a concat device made of NAND devices */
+static int dm_test_mtd_concat_write_oob(struct unit_test_state *uts)
+{
+	struct mtd_info *subdev[2], *concat;
+	struct mtd_oob_ops ops = {};
+	struct erase_info erase;
+	struct udevice *ctrl;
+	size_t retlen, size;
+	u8 *wbuf, *rbuf;
+	int i, ret;
+
+	/* Seed RNG for bit errors, so that the test does the same each time */
+	srand(~0);
+
+	/* Probe the controller, which registers the NAND devices */
+	ut_assertok(uclass_get_device_by_driver(UCLASS_MTD,
+						DM_DRIVER_GET(sand_nand),
+						&ctrl));
+	subdev[0] = get_nand_dev_by_index(0);
+	subdev[1] = get_nand_dev_by_index(2);
+	ut_assertnonnull(subdev[0]);
+	ut_assertnonnull(subdev[1]);
+	ut_asserteq(subdev[0]->writesize, subdev[1]->writesize);
+	size = subdev[0]->writesize;
+
+	wbuf = malloc(size);
+	ut_assertnonnull(wbuf);
+	rbuf = malloc(size);
+	ut_assertnonnull(rbuf);
+	for (i = 0; i < size; i++)
+		wbuf[i] = i * 5 + 1;
+
+	/* Erase the first block of each, so that we can see what is written */
+	for (i = 0; i < 2; i++) {
+		/*
+		 * The first check for a bad block scans for them, and leaves
+		 * the chip deselected, which makes an erase fail if it is
+		 * what does the scan
+		 */
+		ut_assertok(mtd_block_isbad(subdev[i], 0));
+		memset(&erase, '\0', sizeof(erase));
+		erase.mtd = subdev[i];
+		erase.len = subdev[i]->erasesize;
+		ut_assertok(mtd_erase(subdev[i], &erase));
+	}
+
+	concat = mtd_concat_create(subdev, 2, "nand-test-concat");
+	ut_assertnonnull(concat);
+
+	/* Write the first page, which is in the first device */
+	ops.mode = MTD_OPS_PLACE_OOB;
+	ops.len = size;
+	ops.datbuf = wbuf;
+	ut_assertok(mtd_write_oob(concat, 0, &ops));
+	ut_asserteq(size, ops.retlen);
+
+	/* The sandbox NAND adds bit errors, which are corrected on reading */
+	ret = mtd_read(subdev[0], 0, size, &retlen, rbuf);
+	ut_assert(!ret || mtd_is_bitflip(ret));
+	ut_asserteq_mem(wbuf, rbuf, size);
+
+	/* Nothing must have been written to the second device */
+	memset(wbuf, 0xff, size);
+	ret = mtd_read(subdev[1], 0, size, &retlen, rbuf);
+	ut_assert(!ret || mtd_is_bitflip(ret));
+	ut_asserteq_mem(wbuf, rbuf, size);
+
+	mtd_concat_destroy(concat);
+	free(rbuf);
+	free(wbuf);
+
+	return 0;
+}
+DM_TEST(dm_test_mtd_concat_write_oob, UTF_SCAN_FDT);
-- 
2.34.1

