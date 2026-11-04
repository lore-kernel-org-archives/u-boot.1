Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9089E606A31B
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 10:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0bkfLci1;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oLUuTfC9
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6884A40798;
	Wed,  4 Nov 2026 10:00:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 26s_GJdhC-at; Wed,  4 Nov 2026 10:00:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 0009340775
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793786437;
	b=M3SMZL5UxiJXzt5dwEIBxRTowqsPVSbemClYr7iweTCcq3n/XzcGGqBBfeB7C5r83wze
	 gURIUXVhIZo7CNNTYbjh1sZD1rxs0ucTfTWN7SHz08raBHqevkobEOJgTmC9ez7bjEwOu
	 Aq+ecA/04emVo+1/n/kUkEytWmHDorPJpVrbmFuv4odH6E23XElJhPKtCOcBTpH/TuFAi
	 BMoqmCXURJdcU/2VMrl42BNny8Ax8XesErW0Xf/SiOwEXS3Ug7pEIcLOSxqcLEb7HRwHU
	 HRgEznls9qeGAc4gBkUAY5lQaqBvR4fJViPZ3CL4uQzKf7rHqmGmLa0hMZGDXnolG3w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793786437;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=fVuqVWVYSelKC2bafQE6Q4u37+cZnAgfN3OwAO7RDL4=;
	b=J0YcYoAL/DwmVhwQTNgHBzozCmRkFYEBwY4ARAR95NX3BSSa7CM/E6pL6/UrGLMJyWRf
	 xTu6Tf9zd7a3JwXoctZg4IshEBvk4WetxI5t/+yVtHPoALLzYussWAeNke3h+KXCNj8Vm
	 Cqr+1Myb3p546uZAgQOZeTfCBpaIyivTWlucWlNvUndI0dZ/vcYpCdmnnzO7jxOEkEsIX
	 IyOEigIycLdNOt0TbtVt7O1HCK1X5z5qVMqoqsNn7zjgcifR2cePAKeaZTLVCg1+Eq4mO
	 zIbYRfi66kvcq/VvpN2qXXLeciQ8fUawb9NAoGE27YR/ZUF+hEcEEBOHgLtygJy1/ng==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793786437;
	bh=fVuqVWVYSelKC2bafQE6Q4u37+cZnAgfN3OwAO7RDL4=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=0bkfLci1OJSkQXOc7rSJAwZj58o6OK5GA7FCV4tY2KtVYMSb1S/wSn2S1y08nx1og
	 rCb/fghCQnWYgTMY9Rpo6QtmwePa+lssHFs4PXFyQUPxcUQmDKFBAsftR08LsLO1El
	 eUR3g5XrHdyUYKTzPJ1kt5drrrsLHkAszpihNNB3dEEMbXThAjNpMrS9dEXfYCcoXo
	 MllqAJm7o8Gmnrdw5vErL7F56KVJJnpQ/Y/WN6bsZZJX3NoC/M1x79w5tTOCpwLYU3
	 3RfO1p7k2c5pJ5uwysv5smFAaJw/kJKLGoQym7gm3g8usGjbgPo0cLaWWryPDBz++1
	 rG6I/fte/yMcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0009340775;
	Wed,  4 Nov 2026 10:00:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 86CA3932
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6CC2F400FF
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3vIuAfL8RtQ for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 10:00:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C2F4F4004D
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::3"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793786432;
 b=EuURJ+37MKbbAWDrSI7fV4+6UkuFNi7jC66VoL2XuP+v6HC0V6B13r4HXMyJx2YGVI7c
 a/QF2+JNbbJ30ZhVecQZshv63eKkKBaYRFflpwdu8yKt7vpmG+Nd/B41nk90cySflwI8U
 r6niY7qqBObX76DHvwtUBVDMIYCa95ztWX+n7/DByR/560ecFO+dCOUuu5igRDizdGXVp
 9JU9zyJt0Vqz1u1t7szy+Vs9TPNV5EMyhJIq9eUsdhcPgP29pdor/ccf0xdOuC1f8lGu+
 a1BGckQKTYMgPPE5203TAXcwzfgr2lDVpR+yNZr3KUQFq6/rD6WFaNUPvqD+HFIaoHw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793786432;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:Content-Type:
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
 bh=fVuqVWVYSelKC2bafQE6Q4u37+cZnAgfN3OwAO7RDL4=;
 b=R6jKBdMgoDWB/bndNGEiTbgJCUrewX8iy8fI8tuL+ZTvNLkLd3o4fj9O1JsjtczUKG2m
 naCQJJCuNbQYb66cMkuu6M9zZnXceUKjj+zbXxFu1QX58whmz0u9JBv93QA/XZtJh/hYa
 0uxnjsAl+2lyPgml4RrlPQ1iKzqYyYiTHngAaHfWX1lZAMEvvEr+ZL+Tm9V5QLtmLJh64
 veFf4HDfirqtiB+mGqb2BpvBACztCit1DIeG2yAMDV0a5eeoLQsUyfisCAfYt155j9Z03
 X70o6YW29xZfLCTZIxQ5qvlliK4C0jlrnE+qOVJ6Xoq95fk+MZNu/ipUnv/DPXrRMrQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=oLUuTfC9; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::3;
 helo=sn4pr0501cu005.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=oLUuTfC9
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2F4F4004D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 10:00:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HP5B9jdxXL6fTMzzevOtFXw2TnKXpx8206/w7oZRFQKoWYke4+Xttr9GUtA8Gg/uvi7loEl17od1nxLqoqN5A7lUR8AUokzlcpRHytmjcSzl9r76XlqE8pmyPntcR808JcuZKC0nLVyHr/RvatMfF0kElQeM+yWT5Sl7OFXPcIn137JEnGSg17/+i3R2V8NfLa+pYCNYrTAlLdVUJ9yol3wlHNgo8r4p8k9PMS9cKYtVM+7CI/r1P5gbWJLGX/ysU8rtdfup0TcoYffYF2Z3FWoooIyZy9Iio/v+/YRxe03V/gIXqvxtWlcxqc6kK6II7anM8qkR2uXs3FTk/vVFYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVuqVWVYSelKC2bafQE6Q4u37+cZnAgfN3OwAO7RDL4=;
 b=P8zk0T/UJaj2cAyQDj3HDSt10emBkH7CvHUn/Rsha4wKsLApNZ+8OkG86uOJ765Tr1HBnbPzK3x2uNh8SK70eEaDrV5zUC18jBN/uwOOrMEiozk+DSbrkW8FDYbCk7UJ7zsYdfWC/TJCv+D7QLTHUIuEh+liwhzDud95Y+nE5/0ocEbHjFAAGKT7FpoekLqGoHYNNo0m2TXtgx/6aHXGSvuFdsz00eX3Vjroe9KJ6IcwaeMURjc0TmSt79TlRA8nBtn01rQG2Nnbnl3ycWKkDiSVxWos/CilPazn7Qr4A72sniluxvfnSIariaTogVxT0bxBVVGyz2h6wg6tRhwjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fVuqVWVYSelKC2bafQE6Q4u37+cZnAgfN3OwAO7RDL4=;
 b=oLUuTfC9e5Siq6/LGap3iIZScJdasJ38SDogYHV6XDAHMnmhPXUvfZeAUetdBXA5elUete07UxjTCuV+AhjUMQ1Cu9mQcCoSZGfTnBL6ZuCTr5ZXXUH00otK6rRxPpmWKTjtoIK71SRzqyYr8+1018gVgQY1JgcvVwOg30vk+KE=
Received: from CH0P220CA0021.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::11)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 10:00:25 +0000
Received: from DM3PEPF000265B9.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::d) by CH0P220CA0021.outlook.office365.com
 (2603:10b6:610:ef::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 10:00:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265B9.mail.protection.outlook.com (10.167.23.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 10:00:24 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:14 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 04:00:13 -0600
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53 via Frontend Transport; Wed, 4 Nov 2026 04:00:12 -0600
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>
Subject: [PATCH v2 0/7] mtd: Add MTD virtual concat support via device tree
Date: Wed, 4 Nov 2026 15:29:34 +0530
Message-ID: <20261104100005.4104985-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265B9:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bd429c-c0ba-4f9a-3184-08df3a5a7210
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|18002099003|6133799003|11063799006|261102123227099003|56012099006|261021121427099003|261022075727099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|261009223027099003|261009221227099003|261021123027099003|261022115727099003;
X-Microsoft-Antispam-Message-Info: X30cYGQBk9cBSMnvOKWooCRY/emUGV4aBhsOja/t9VhqAu1M7CvykPoneshDaQyD8cIDFlqNB3zDqc9rNeI5xSho3Ks0W9dADk/cKoooGVW2xoMSHDAt3QqDHtgx5xdq5wLILrKAHj+LM9RfdnjZNnP7dMJIlqoyxHeTc9ojmXMHdKDFB/AEn1fj7RlVMFajPlP4MjZLUk/hN1t1PeODIGQj6iHKYBCKyJ64/FlR6nNoZTIoczZk+ue77lzKH+6Ru3cggBJU67yKsQ1qUArA+hF0ysOfyg8AJE/8buQHnSfCUCQe5HDIXeS4ovn01KOnqDscYcXrUemtIfL4TVjrw1Thb5MtiQxXU3IQpuMgRws4M3W4bDrkkbhBxsWeLqKbLlUyelOA1n3RQlvlktL5gu3CvsN08mXZsHXQt7a41pcFjTRwi/A9kID2mtcIxqatAaKhS7I2nT0CEDzF5c8wzrdsmA4FZdJPEBKb5SclgI94+7nicofj6o6GqtLzhl+u9fS0kQKxpG5h3k+LuOGGwuDHrYcv9dQHFIsJISv3pf8bHTpC3/CnHeMaDyee8lKUC/JKB+d37LOptqcW8LOtFIYF5WbYGVfVH6c/u6dEl4WQYYCkdx42kdjdMe559MxLENauryMjG1qA6zvORmsXAOTIENTL9NuNk86uUGbn0s0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(6133799003)(11063799006)(261102123227099003)(56012099006)(261021121427099003)(261022075727099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(261009223027099003)(261009221227099003)(261021123027099003)(261022115727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5Xq7OD45IHOVaIMQ6HwmQc5IHElZ84yRpb5mV+AcobhyBcJXPc6XHVQwgNgKgX75bbOsqjPuF3oa7JAQYzL5VDxpqNo5mJPBapsNdBehp/LptEGPNfkfiB17HCpCqo+PXR71waz3bsigaibZ3xjAFzK3hPEADCyTW5N1/TgiiHjQaxP9YQ3Fng3nb68CXk4zBZ/zDlSxyqcXyyw5CC8b5kps+mnV9i28IJWjuCeV5nxLrtQM/8aNzD/toVrFB2a2aNMXt+MgCIfrR25O+ELizIi9egK+xNOB8hAof+C2AgNTUvhe8ddze1qCRw4LbSDArzdEwpgsh3cF12m26ocYmzBd5JC5pXZL1F2UIqTTpvZfyZoQf3hnSzqG1yPy0RCpp3MdRxir0B8+xrXmVox+CeMWkRtEhbyzN6wlKIMoNLrPkpq8hbr4yxif46x4kToh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 10:00:24.4575 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bd429c-c0ba-4f9a-3184-08df3a5a7210
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265B9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some boards have two or more flash devices on separate chip selects
(for example QSPI/OSPI flashes) and need a single filesystem or image
to span them. This series adds MTD virtual concatenation, where
partitions on different flash devices are linked in the device tree
with the "part-concat-next" property and exposed as one concatenated
MTD device:


	flash@0 {
		partitions {
			compatible = "fixed-partitions";
			part0: partition@0 {
				label = "flash0-part";
				part-concat-next = <&part1>;
				reg = <0x0 0x800000>;
			};
		};
	};

	flash@1 {
		partitions {
			compatible = "fixed-partitions";
			part1: partition@0 {
				label = "flash1-part";
				reg = <0x0 0x800000>;
			};
		};
	};

With CONFIG_MTD_VIRT_CONCAT enabled, only the concatenated device
("flash0-part-flash1-part-concat") is registered. The member
partitions are not registered individually. Multiple concat groups,
each with two or more partitions, are supported.

This is based on the Linux driver added by
commit 43db6366fc2d ("mtd: Add driver for concatenating devices"):
https://git.kernel.org/torvalds/c/43db6366fc2d

If a group is incomplete, or cannot be joined, a warning is printed
and its partitions are registered individually.

A concatenated device is kept when the partitions are scanned again. It
is destroyed when a flash it uses is removed, e.g. by 'sf probe', or
when mtdparts defines the partitions of that flash instead of the
device tree. It is not destroyed while it is in use: mtdparts is not
applied to its flash then, and removing the flash only prints a warning,
so it should not be in use when its flash is removed.

On ZynqMP, accessing the flash on CS1 needs the GQSPI chip select fix,
which is now sent separately:
"spi: zynqmp_gqspi: Use the device's chip select"
https://patchwork.ozlabs.org/project/uboot/patch/20261104092111.3906459-1-padmarao.begari@amd.com/

Patch 7 enables the option for ZynqMP, Versal, Versal NET and Versal
Gen 2.

On ZynqMP, the board has two mt25qu512a QSPI flashes on CS0 and CS1.
Partition "rootfs_a" (flash@0, 0x1000000-0x4000000) is concatenated
with "rootfs_c" (flash@1, 0x1000000-0x4000000) into a single 96 MiB
device, while the remaining partitions on each flash are registered as
usual:

  ZynqMP> mtd list
  SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB, total 64 MiB
  SF: Detected mt25qu512a with page size 256 Bytes, erase size 64 KiB, total 64 MiB
  (0): "rootfs_a"
  (1): "rootfs_c"
  List of MTD devices:
  * nor0
    - device: flash@0
    - parent: spi@ff0f0000
    - driver: jedec_spi_nor
    - path: /axi/spi@ff0f0000/flash@0
    - type: NOR flash
    - block size: 0x10000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000004000000 : "nor0"
        - 0x000000000000-0x000001000000 : "qspi-fsbl-uboot"
  * nor1
    - device: flash@1
    - parent: spi@ff0f0000
    - driver: jedec_spi_nor
    - path: /axi/spi@ff0f0000/flash@1
    - type: NOR flash
    - block size: 0x10000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000004000000 : "nor1"
        - 0x000000000000-0x000001000000 : "rootfs_b"
  * rootfs_a-rootfs_c-concat
    - type: NOR flash
    - block size: 0x10000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000006000000 : "rootfs_a-rootfs_c-concat"

Erase/write/read-back across the CS0/CS1 boundary at 0x3000000:

  ZynqMP> mtd erase rootfs_a-rootfs_c-concat 0x02F00000 0x00200000
  Erasing 0x02f00000 ... 0x030fffff (32 eraseblock(s))
  ZynqMP> mtd write rootfs_a-rootfs_c-concat 0x200000 0x02F00000 0x1E3200
  Writing 1978880 byte(s) at offset 0x02f00000
  ZynqMP> mw.b 0x5000000 0x00 0x1E3200
  ZynqMP> mtd read rootfs_a-rootfs_c-concat 0x5000000 0x02F00000 0x1E3200
  Reading 1978880 byte(s) at offset 0x02f00000
  ZynqMP> cmp.b 0x200000 0x5000000 0x1E3200
  Total of 1978880 byte(s) were the same

On Versal NET, the board has two mx66uw2g345gx0 OSPI flashes on CS0
and CS1 of the Cadence OSPI controller. Partition "ospi-flash1"
(flash@0, 0x200000-0x8000000) is concatenated with "ospi-flash2"
(flash@1, 0x0-0x200000) into a single 128 MiB device. This test also
used "mtd: spi-nor: Remove SPI_NOR_OCTAL_DTR_READ flag for
mx66uw2g345gx0 flash part", which the flashes on this board need and
which is not part of this series:

  Versal NET> mtd list
  SF: Detected mx66uw2g345gx0 with page size 256 Bytes, erase size 64 KiB, total 256 MiB
  SF: Detected mx66uw2g345gx0 with page size 256 Bytes, erase size 64 KiB, total 256 MiB
  SF: Detected mx25u3235f with page size 256 Bytes, erase size 4 KiB, total 4 MiB
  (0): "ospi-flash1"
  (1): "ospi-flash2"
  List of MTD devices:
  * nor0
    - device: flash@1
    - parent: spi@f1010000
    - driver: jedec_spi_nor
    - path: /axi/spi@f1010000/flash@1
    - type: NOR flash
    - block size: 0x10000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000010000000 : "nor0"
        - 0x000000200000-0x000008000000 : "ospi-flash3"
  * nor1
    - device: flash@0
    - parent: spi@f1010000
    - driver: jedec_spi_nor
    - path: /axi/spi@f1010000/flash@0
    - type: NOR flash
    - block size: 0x10000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000010000000 : "nor1"
        - 0x000000000000-0x000000200000 : "ospi-flash0"
  * nor2
    - device: flash@2
    - parent: spi@f1970000
    - driver: jedec_spi_nor
    - path: /axi/spi@f1970000/flash@2
    - type: NOR flash
    - block size: 0x1000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000000400000 : "nor2"
        - 0x000000000000-0x000000080000 : "spi0-flash0"
  * ospi-flash1-ospi-flash2-concat
    - type: NOR flash
    - block size: 0x10000 bytes
    - min I/O: 0x1 bytes
    - 0x000000000000-0x000008000000 : "ospi-flash1-ospi-flash2-concat"

Erase/write/read-back across the CS0/CS1 boundary at 0x7e00000, then
reading each flash directly to check that each half landed on the
right one:

  Versal NET> mw.b 2000000 cd 200000
  Versal NET> mtd erase ospi-flash1-ospi-flash2-concat 7d00000 200000
  Erasing 0x07d00000 ... 0x07efffff (32 eraseblock(s))
  Versal NET> mtd write ospi-flash1-ospi-flash2-concat 2000000 7d00000 200000
  Writing 2097152 byte(s) at offset 0x07d00000
  Versal NET> mtd read  ospi-flash1-ospi-flash2-concat 3000000 7d00000 200000
  Reading 2097152 byte(s) at offset 0x07d00000
  Versal NET> cmp.b 2000000 3000000 200000
  Total of 2097152 byte(s) were the same
  Versal NET> sf probe 0:0
  SF: Detected mx66uw2g345gx0 with page size 256 Bytes, erase size 64 KiB, total 256 MiB
  Versal NET> sf read 4000000 7f00000 100000
  device 0 offset 0x7f00000, size 0x100000
  SF: 1048576 bytes @ 0x7f00000 Read: OK
  Versal NET> cmp.b 2000000 4000000 100000
  Total of 1048576 byte(s) were the same
  Versal NET> sf probe 0:1
  SF: Detected mx66uw2g345gx0 with page size 256 Bytes, erase size 64 KiB, total 256 MiB
  Versal NET> sf read 5000000 0 100000
  device 0 offset 0x0, size 0x100000
  SF: 1048576 bytes @ 0x0 Read: OK
  Versal NET> cmp.b 2100000 5000000 100000
  Total of 1048576 byte(s) were the same

After 'sf probe' re-probed both flashes, the next 'mtd list' printed
the concatenated device again, as the scan created it again.

Patch 4 fixes concat_write_oob() and concat_read_oob(), which made any
write to a concatenated NAND device fail. It is needed to use the new
support with NAND partitions.

The sandbox tests in patch 5 cover joining, access across the boundary
between the flashes, rescanning, flashes and concatenated devices which
are in use, removing a flash, incomplete groups and a partition which is
out of reach. They also cover patch 4, with a concatenated NAND device.
Patch 3 fixes the existing NAND tests, which otherwise fail when they
run after a test that probes the MTD devices. Patch 6 adds the
documentation, in doc/usage/mtd_concat.rst.

Changes in v2:
- New patch to fix the lengths returned by concat_write_oob() and
  concat_read_oob()
- Drop "mtd: Move struct mtd_concat definition to header file", which
  the driver no longer needs
- New patch to move the DFS helpers to ofnode, with tests
- Register the partitions of incomplete or failed groups individually
  with a warning
- Warn about an invalid part-concat-next property
- Do not concatenate a partition which is out of reach, or which is
  found more than once
- Free the member partitions when a group is freed, and keep a concat
  device that is still in use
- Keep a concat device when the partitions are scanned again, and only
  destroy it when a flash it uses is removed, or when mtdparts replaces
  the partitions of that flash
- Do not apply mtdparts to a flash while a concat device which uses it
  is in use
- Fix mtd_virt_concat_destroy(), which never matched, and call it from
  del_mtd_device() so that every kind of flash is covered
- Drop the IS_ENABLED() checks, and depend on MTD_PARTITIONS but no
  longer on MTD_CONCAT, which also joins NAND and CFI flash chips
- Refer to the merged Linux commit
- Send the ZynqMP GQSPI fix as a separate patch
- New patch to fix the NAND tests when they run after an MTD test
- New patch with sandbox tests
- New patch with documentation
- Do not enable CONFIG_MTD_CONCAT in the defconfigs

Link to v1: https://patchwork.ozlabs.org/project/uboot/list/?series=529258


Padmarao Begari (7):
  dm: core: Add ofnode_find_node_with_property()
  mtd: Add virtual concat support via device tree
  test: dm: nand: Probe the NAND controller in the test
  mtd: concat: Fix the lengths in the concat OOB functions
  test: dm: Add tests for MTD virtual concat
  doc: Add documentation for MTD virtual concat
  arm64: xilinx: Enable MTD virtual concat

 MAINTAINERS                              |   9 +
 arch/sandbox/dts/test.dts                |  23 +
 configs/amd_versal2_virt_defconfig       |   1 +
 configs/sandbox_defconfig                |   1 +
 configs/xilinx_versal_net_virt_defconfig |   1 +
 configs/xilinx_versal_virt_defconfig     |   1 +
 configs/xilinx_zynqmp_virt_defconfig     |   1 +
 doc/usage/index.rst                      |   1 +
 doc/usage/mtd_concat.rst                 | 146 ++++++
 drivers/core/ofnode.c                    |  31 ++
 drivers/mtd/Kconfig                      |  17 +
 drivers/mtd/Makefile                     |   5 +-
 drivers/mtd/mtd_uboot.c                  |  48 +-
 drivers/mtd/mtd_virt_concat.c            | 457 +++++++++++++++++++
 drivers/mtd/mtdconcat.c                  |   5 +-
 drivers/mtd/mtdcore.c                    |  12 +
 drivers/mtd/mtdpart.c                    |  17 +
 include/dm/ofnode.h                      |  23 +
 include/linux/mtd/concat.h               |  86 +++-
 test/dm/Makefile                         |   1 +
 test/dm/mtd_concat.c                     | 543 +++++++++++++++++++++++
 test/dm/nand.c                           |  10 +
 test/dm/ofnode.c                         |  55 +++
 23 files changed, 1488 insertions(+), 6 deletions(-)
 create mode 100644 doc/usage/mtd_concat.rst
 create mode 100644 drivers/mtd/mtd_virt_concat.c
 create mode 100644 test/dm/mtd_concat.c

-- 
2.34.1

