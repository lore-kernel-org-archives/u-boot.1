Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B05606C1AF
	for <u-boot@archiver.kernel.org>; Tue, 20 Oct 2026 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=sr2V2dNs;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ehoqCPjQ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 942FF40888;
	Tue, 20 Oct 2026 13:53:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xYYqxkAIme18; Tue, 20 Oct 2026 13:53:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org BF2F440889
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792504379;
	b=hUZMQ0tWo/MYcEi/yyYt3xkBs8yVnOrdycTOoEj9clu0iDDELjhB/MlaM1cPtgdnV17s
	 TckdSfv6UhyQxJ1TnoSUEctDuBDbV7d0fWJfgj2SQFiMOX0MThhyIYN1kaurR0fPl/iNu
	 pbWDYmVwrcROv7GxlDBuywII9s9d0ZuP+Be02qXFQNGdFljUUQx/Dpg/u9GtjbJoPVHK4
	 076phKS/pEtdp1LcqIIjGGxhPsTTi/HVjdaNaS+lrA5QGsnYeS/VkCERwIBRTiWx5Q7df
	 Vrsl7/QRenXs2iaitR8OqECL78CqgdgS9kqrqfq8kBEvp4SFhhID/ykYDgHcEu3EwNg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792504379;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:Content-Type:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=6I21+WLSmSvAd9edJBegu8VkUP0sMODaNPbRuc22IuY=;
	b=TjhaTLG27u0HCZ+Z1oVcGLamqu2OVmIxhDbrXA9NtE5tZSyMV+TkZWsEFyXbDNTtvpgg
	 mbTgZbwBo988Bi/BDPYQ3k1a5Aoe0xusvk6d84lP2IMq3z0Ux9ngHIJLAukjqX2cQjDYS
	 IU89fOuzZuw27+cUT9hpi0EkVePM1YwOqD9qBQ+jk/TSUVY+HmqdgOm+moXMM0IqOSvKP
	 k2OUeGXqzid2ogm3eoQVoO0pjYE/kWAD5uFHZfubfr5HuQM6yK1jJ6Luz8dPsXtKOgM2F
	 pEZPjoLoZ46yVdeB5Fv1rYf8jgBlMDPixUSElP1lFll+wwtXFAwXvCZqjMtS/w1cmCg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792504379;
	bh=6I21+WLSmSvAd9edJBegu8VkUP0sMODaNPbRuc22IuY=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sr2V2dNs/cq7fK+TaztpAW8Lw+oBIyRnFLKM3mVk62ZZ3SFYJlltMefBBkgedUkol
	 iV5DQELUhYS7x2r8zR8MFB61U5NP1ndrQMGSr3H3WSti2ltcqdCM7VUiI87GHyXcxa
	 oHWZWOm5H+eRwY0NzyAUvtm2NqrhkuSotiIqAJA3M2gQGm3Zgpme0Y7VECeryLiFBy
	 bHj2aKwThNlhhWnETUrJPM62bArlksBc0fcFIg/WrVKLwUBRbOhLvp77+LCsgMmBQc
	 0G+bGpSgnIeqsKKea7Qh5FradyRTv9IDd/tPSy9FY2E45VFmiHlKEJYveHYce21/j9
	 Q4e7397n5Z21A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BF2F440889;
	Tue, 20 Oct 2026 13:52:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8006A1AB
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:52:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 724866076C
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:52:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6DcPLxIcHvj4 for <u-boot@lists.u-boot-project.org>;
 Tue, 20 Oct 2026 13:52:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9FCBF60730
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c101::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792504377;
 b=QxtygUAUrNqtju15e6k/T4KHy6vR0UIW5xtv5dC7hAgkj14xljvcIxc3zPuQADb0pbnG
 JxV4ndUwV75+qZRWzuAUrF8CMTZepFQ3d9JfjNgncxkIR/40o1IODAzK1X08hzieaWGmC
 xNRucfUcNrZnid9AYR+aPMETlDyUV4Vs6OG6uSztUAHlGCA3aO48MVmw/QLGbLbTHXwfY
 SsnCk8EcNRTsChykYF9FhWngIODJaXdLzI0nXoOCpiCZX1VsIKR9u425JXpb/JywxddXI
 Sgu95WXOoraaGlu4AbDrX+y7GMWgnG13l8bEL2okYrk3BRsjlkchreffl4APiSjSgXA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792504377;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 X-Developer-Signature:X-Developer-Key:Content-Transfer-Encoding:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=6I21+WLSmSvAd9edJBegu8VkUP0sMODaNPbRuc22IuY=;
 b=RxpbrsYNW2jEB5lBFjO7sYJOdMb7MtUo3A1LjWjMK4E6wtF/JSFx4ahrnpxg9VyE/J1w
 mEOMrcu/Wwm7Zpe1fooZYy3omuRPh3NLqDdR458Iq7APH5UA9wTGtCfEGJrMk6j5nvQ5D
 +GRQWge8M8IPJ4DXBHuI7rKNji45ZUoKDiSgXZZjlqTp4vDQGKi0Yr2gj9A4Re236wGuT
 zm2ucF1Q4fD95cAVwY2XWJPQ3cfJ2dKqyr6FUU+3NcB7+o/J+3uBw9rx5nXtJWUXJPCrP
 e9LIX5NMfQl7o20NOuIkxbFf/4/zDUiVt12q49qKboaoxRd7Z37sxjGd+rHRWbaeKZA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
 dmarc=pass header.from=amd.com;
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ehoqCPjQ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c101::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c101::7;
 helo=bl0pr03cu003.outbound.protection.outlook.com;
 envelope-from=michal.simek@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=ehoqCPjQ
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9FCBF60730
 for <u-boot@lists.u-boot-project.org>; Tue, 20 Oct 2026 13:52:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d06cubQ81b3LqnkauDD12MQGPY1SEsh/xEYjuANtElK8uT+j4M2TVeZhDrW8zJ0woxop4ZOL9cUYPsMqprkPrDPEEZTUEmj2TN8F9tFK6kOp0SYqdpwSQL1c3EUWdFZ892M8AQy4FhgqPRsR7cQbC404ZgnR1BVv9vxQlBzz1abL/zUSjnPQubai4jF4m8feVhGIDGGLvDPBevdTHZ07Bskh8wpWCOoi6zWfFbeZY3q34g0ymx22/YhIc1AUW6pqlCHg971kPOlWX8/VveFq7uRljuaMLyYvEBBEtVe7cHIa8tGkegP0zfPddWb2gxSZg7gPmSBBxIScIcfS50S0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6I21+WLSmSvAd9edJBegu8VkUP0sMODaNPbRuc22IuY=;
 b=YAmwaAMj4d+Pc43BUr9Eb1kd8j8zbFOk47FJ2Q4r4sMey3BEirnmxNyMw/SNlRvAU88pXyEonlzPUQrD34/9fPBuj9jbBNPNOOWPdcAX0aM0gGuXHEJboMKyUgHHIhDhVAtBIYHD733rM22+fzCcbBK66tk08fHVKPRxUUcfcuCWuC5/jji3Zm8ib5U5uHHmoHm7/X+RdM3AeoBoPPnt23xh0QW1WjGJAzfy8T2JwERP0KjL/+fRXCPi/p61PwdApgABiWyvDZekgZfLrOaS1Pp3kDb1vgwxNxGTlSp6js8xMjmI96wSnp4EtOsqkdiye+EMNdEKH/0TD26CJB6XzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6I21+WLSmSvAd9edJBegu8VkUP0sMODaNPbRuc22IuY=;
 b=ehoqCPjQmItxw6uF/6rTEJ+3InoV6aJh92Cao91Rt3Xo8bhfxjyd/DGCmMyJC12/RN2lG49B2PXsgybch9xSxba5ZkCvAPMfYl/+rvQD/tbsqDNnVyVisuxpGu0NVo76h+nZ9mZGrjiPXE1ykI8MH+JMq6F+B2v9HmEE8o1qRt4=
Received: from SJ0PR03CA0193.namprd03.prod.outlook.com (2603:10b6:a03:2ef::18)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 13:52:51 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::66) by SJ0PR03CA0193.outlook.office365.com
 (2603:10b6:a03:2ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Tue,
 20 Oct 2026 13:52:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 13:52:50 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 20 Oct
 2026 08:52:49 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53 via Frontend
 Transport; Tue, 20 Oct 2026 08:52:49 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.u-boot-project.org>, <git@amd.com>
CC: Padmarao Begari <padmarao.begari@amd.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Simon Glass <sjg@chromium.org>, Tom Rini
 <trini@konsulko.com>, =?UTF-8?q?Vincent=20Stehl=C3=A9?=
 <vincent.stehle@arm.com>
Subject: [PATCH] efi_loader: set dfu_alt_info before FWU alt num lookup
Date: Tue, 20 Oct 2026 15:52:40 +0200
Message-ID: <c07a80c76774c3dcdafcda659fc098278b1bdc96.1792504358.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3208; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=J9HmEuCTh0exT0qBiN1Hav4/qp+gEMVoryH+7ceqFx8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWRdL9Kbk7SX0ZqVseElm7Oxa/Yix8YvykdEo/3tonm4l
 z8Q1T/cUcrCIMbBICumyDKdScdhzbdrS8WWR+bDzGFlAhnCwMUpABNx52P478LrKbHiZJvE07pX
 /n+/uCy/ve6v0hst09jF3aqZ920WnGRkOOG4KKXC3GNuqVb73ZK6J0mz3x7gX2G1vOvW/vgzT19
 v4AUA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af70385-fc83-43ff-88e0-08df2eb16e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|56012099006|11063799006|261009223027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: qOZgAGcR8YWtmFLkp8qxx52kTevAdsRoP4sdFjE9zyScYhDWptAd1ji7sQYWItMuZpLf44sKAYpAw/Q0X/1zLg9S2oR1Jm+vI41+hq8n3ow/mQJEMSBEh5X5/3VGOfXcoZeHvVyz4o6vke30t2nZkVqTYKzn6K1oQubcikRZ9ZssWQUOmfQDhk09vc1TJ3iXPy2YYEJNt1rZ2duHiHwWk14D3HyZZQpHY14KUgjM39BGP8W/xDw6iwea/O8veGCNUOV2z5muNgkTRbOv72ukgk/SH+GVI38DqXkKgMXYDTjSxnGzz06Tgzy5LzPJpg1MQYe4Q95hopp+RivnBVVipEQai8rTp+FXQ7+zdCHhNEdTwEvEcbTuNQ69Mof3d5zw2ofkMrREEGR+0jUWM2DV28s/qsjW4jPoLKX6ADEz8Bb14EvyMC+sTtWrbZIymkyxaauykRlWf4B9ESZESQ8+T/bsxfKvumzp4Y4q1kqPNjhJF3GoMWGXhll1sOJjDi7qmwDHdMwhCLi8TgEmsQlUeQ1L0xbKecD/AGNzo0IlofintvkrfcFrW0jrah47HTCUpbLLjmRM9Fdd116Q7+eug0PwbgXVJpooHW8H7jCp9ejrl0d/MMjFyRNLfPy9gpbk6OHdv/SGFfkUFm5cborjPbFaKfGjxCezY1jNdgphPY1nlMA0eI29fCbs7oL9j9b6oijME/ZOrIrHF3PT0Fnt3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MpuDvtBNwhINUmYsLVJZkMyJyOMG2YWOpVkscIXUmchJmDR8vuXZtKSkQMGk+Yww741WPdJzcMaDYk++9nGjor7srij4mDEjjIixDL6jrJmnJ8ICpQh7sp4CMh1GFH2qucsizP6KUxRgOBkUqF7MXEW84T6HKZ5RSENRFu/8T2SjWSMstjk2Xro6LQQ03tx6p0nSrsxoVZRMgC1J9W1hWFD4isIick5O95KE3ltumAVLbbW1xD8rdihlfV3AXcnWZF/2VSwISZ2RBml1FALgJo1kIkIj83djBjmhAw0lB7VPYOIb6aVLBMdtRWFb6wTQNYib4YpeJ6kqzI6wWhMyQzzQQVfCd+hdCrCyXr/jYFn32mllTOi5INp4oqqhuf0EEVeyNVWXZjTTRKUDAcn94V1YHK3+3O1vpm+JuFVo65oGi8qYlkYriSEiZFdfF/Qg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 13:52:50.8845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af70385-fc83-43ff-88e0-08df2eb16e98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Padmarao Begari <padmarao.begari@amd.com>

efi_firmware_raw_set_image() derives dfu_alt_num from image_index by
calling fwu_get_dfu_alt_num() when CONFIG_FWU_MULTI_BANK_UPDATE is
enabled. fwu_get_dfu_alt_num() calls fwu_plat_get_alt_num(), whose MTD
and GPT backends call dfu_init_env_entities() to parse the
"dfu_alt_info" env variable.

"dfu_alt_info" is set from update_info.dfu_string further down, just
before dfu_write_by_alt(). Boards that do not already have
"dfu_alt_info" in the env hit fwu_get_dfu_alt_num() while it is still
unset:

  "dfu_alt_info" env variable not defined!
  Firmware update failed: <NULL>
  All capsules were not updated. Not updating FWU metadata

Move the "dfu_alt_info" save and set above the dfu_alt_num derivation.
Make the fwu_get_dfu_alt_num() error path goto restore_dfu instead of
returning, so the old value is written back and orig_dfu_env is freed.

Fixes: 546152624f46 ("efi_firmware: set EFI capsule dfu_alt_info env explicitly")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 lib/efi_loader/efi_firmware.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
index 84de95f5c230..346b00c1663a 100644
--- a/lib/efi_loader/efi_firmware.c
+++ b/lib/efi_loader/efi_firmware.c
@@ -765,6 +765,24 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 	if (status != EFI_SUCCESS)
 		return EFI_EXIT(status);
 
+	/*
+	 * "dfu_alt_info" must be set before fwu_get_dfu_alt_num(), which
+	 * parses it through dfu_init_env_entities() to locate the image.
+	 */
+	orig_dfu_env = env_get("dfu_alt_info");
+	if (orig_dfu_env) {
+		orig_dfu_env = strdup(orig_dfu_env);
+		if (!orig_dfu_env) {
+			log_err("strdup() failed!\n");
+			return EFI_EXIT(EFI_OUT_OF_RESOURCES);
+		}
+	}
+	if (env_set("dfu_alt_info", update_info.dfu_string)) {
+		log_err("Unable to set env variable \"dfu_alt_info\"!\n");
+		free(orig_dfu_env);
+		return EFI_EXIT(EFI_DEVICE_ERROR);
+	}
+
 	/*
 	 * dfu_alt_num is assigned from 0 while image_index starts from 1.
 	 * dfu_alt_num is calculated by (image_index - 1) when multi bank update
@@ -779,27 +797,14 @@ efi_status_t EFIAPI efi_firmware_raw_set_image(
 		ret = fwu_get_dfu_alt_num(image_index, &dfu_alt_num);
 		if (ret) {
 			log_debug("Unable to get FWU image_index\n");
-			return EFI_EXIT(EFI_DEVICE_ERROR);
+			goto restore_dfu;
 		}
 	}
 
-	orig_dfu_env = env_get("dfu_alt_info");
-	if (orig_dfu_env) {
-		orig_dfu_env = strdup(orig_dfu_env);
-		if (!orig_dfu_env) {
-			log_err("strdup() failed!\n");
-			return EFI_EXIT(EFI_OUT_OF_RESOURCES);
-		}
-	}
-	if (env_set("dfu_alt_info", update_info.dfu_string)) {
-		log_err("Unable to set env variable \"dfu_alt_info\"!\n");
-		free(orig_dfu_env);
-		return EFI_EXIT(EFI_DEVICE_ERROR);
-	}
-
 	ret = dfu_write_by_alt(dfu_alt_num, (void *)image, image_size,
 			       NULL, NULL);
 
+restore_dfu:
 	if (env_set("dfu_alt_info", orig_dfu_env))
 		log_warning("Unable to restore env variable \"dfu_alt_info\".  Further DFU operations may fail!\n");
 
---

-- 
2.43.0

