Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAC1C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 18:55:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C85A60752;
	Mon, 21 Sep 2026 18:55:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wpqiCdKh5M83; Mon, 21 Sep 2026 18:55:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 9B01F60738
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790016909;
	b=EuSY0t7qSxhmQwG+vLSpIQwzKSzuDdsdVO73nYF8Ogo14AGms4vZNCdyZ7wcxLSxdWJA
	 gim/UIbSOtRalH7WFk11pqNN08Cpr/NhdXL5/8xBeu5r93ugnbdHD25ZooK4gplGrBlnr
	 VE89JztB95gU1tZ/9HRsUBsmOFWm+Ynsetzp5ufTbhrWHusiRJv7B8/rKlAtyIBGuTEQa
	 nRH9BtdN7aSTYR2DKYRHv90/4KBN9h81sruap7gc1QVSQArjw9W7D6uQx8A+TI+ZtULQg
	 xbPv9m0v3LaebKCjhtZM8Zm0mhxc1xUr1ZxpUgdzbnR1aLHXSZhjGLrbYzXEy4vmTsA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790016909;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
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
	bh=0VqSQo1GLfCw7iYwvZ6pIUkdE7AS6QI7Hni+FLfYlbo=;
	b=thRB0vR3HesJy2Qar0Edo+fuZx993W7CRtPr/VxrgVI2jQCuB5tFDJKOElNCOMd2aUmW
	 Ps4sfCfim6bLSvT/T8qOOL3vvIMSVhXUX6evfoS8OqJxSBXsZ/PomxSjMHr+lzBz91ol4
	 thTBc5hfZkEO9Tl0TwrFooPIwq9aWyLyDSPazmGQO5FR0CxjX88Y7RC7hteeIgcpcCApR
	 9UZUv2OHZ6RjqbEpBKjnFLYMIPdfY9HVEBtZ/3yTzgSOzVch8fD4T/wfzeoVTpg3vyqeJ
	 Rl9mBJcNi00/JEjWHCCv32BbERcgLkgGew9ItWrK864lZEav8UvCQRatMrTbgO0USfg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790016909;
	bh=0VqSQo1GLfCw7iYwvZ6pIUkdE7AS6QI7Hni+FLfYlbo=;
	h=From:To:CC:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Cawb+dvYOG2R0byf9r/ujE8B3BzjKpEOvg/aeu9k5CijEUJAOy+V6GWCrcMDEUkXq
	 GdzJSV3T2y9qoFle1YVbnGUSpJQiGtEZsOTgaDy8oA8J+NPCqmem79I7iVC4a2W2lW
	 hm6dwdWkIzk4kiY1kQpqnCCOsNlS9CJ3McWDARki2nl3vUfMrB9CplC2fDvneoR5BY
	 EEVcR1ExJlfHR9/s0hixCSGZzGNe1Z7BVy/SPEOR4esPvfj/IFvvnJatGtmG262MjM
	 mPyN6Ka9BLa4UKdbUKgKFA9xf297KPachqjh375x1NwgPyqVfVNm8bf7M/YrSKJNE8
	 KklNLoz9Z3x8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9B01F60738;
	Mon, 21 Sep 2026 18:55:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C24F63A9
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:55:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A88BE40A20
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:55:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nfTvOUrc8nrv for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 18:55:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9485740A1B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c007::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790016908;
 b=dqL+bowKT3sQHSCB/anJryfhyGBpowbDH3GS6w+uzpB2QSS4hhIkP/LdtDipTbibOxJG
 +GLQja7DuAFDUxRgHii7pTw4OmVGkGVQo+UPMcfdTIYD19h5jRb1FFgYZGpxU4K8FM5du
 fqBiIzTD/TqfUIktFdhYiUmjRIG3ICBKBEatGMk8m/DtjYnwytmvvd+52nsKO5HxJSl87
 5gtYrPel2lFAXaWc6rS6iLTI/uzuqPjpH7xA7BdGc/UHW3j2oN6bftFzzIQCQh/mavY9a
 /giKj9CobfMkk13FtpnZHcMWlih1L9vhiwoasE3ih/0QeLC1xaNGqwx/rLibvtyBHPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790016908;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=0VqSQo1GLfCw7iYwvZ6pIUkdE7AS6QI7Hni+FLfYlbo=;
 b=kZg2+evUNmDgOnlI/+MJZbJuOXGjPfHTjeLcHsxEy2Qb+/qdP29w//jel4BlGPJeyanK
 spPOKPhsb+dJyA+3J/QvzSthVSdWcMrNRhSXbErxRnb136gNaJKpr+YemTpax15zyDP3x
 Te8WpA6Xfpok8DUfjcRcTsfNWCzpftxiR7oJ7M5jlpkL5VzEolpLodQQreErHtY6REfXU
 6jqF82NmwWlHNV0aEge32S3dWuTf07vpfBV7ZX+dTSR8NtVgiXZJ1JbH8IKnn/D/o+AO/
 yn/diDiBdgM9TXxOIcq/o1/mMMvB7b5c1ZBWDYlyhuYy1PXmojF5555q3Lnzz0NDpjg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=t78Y9JG5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c007::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c007::2;
 helo=mw6pr02cu001.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=t78Y9JG5
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9485740A1B
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:55:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UUoKpQAehl4oKhZ+RRhT+5tdXlzQAGVszDRT+JWd3M3wsc94EPbBBIeQqU6Z+czg01Cw5xDVG/I8232omPgfhZDnBfXbUHazpDXLCkwl9fhT7RwVoLi5YrwoHOgbglG5Vw2yf6yjx1gGXYeWUuu2pVH1GiuFkpSowfiuQHbI09jkIsutQl0x/CLbomLOFZc5MVA78tfnv79t6GYQLRiI83ooTkLco30jenZvOU4EVuavqLlcNPNiGyG1FN8LC14HK+o4xplFWzTGoylIcEYH9NaXDvoMSthnzbRZXEQgn1tBEuRUT1IXOfEryneEKmoX4AY8EOiB30iajbgZmHRL+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VqSQo1GLfCw7iYwvZ6pIUkdE7AS6QI7Hni+FLfYlbo=;
 b=a+zjSzut3DiZ8Rv/hjgXrrDV63MvRb5BBjuJ2tPiXsSWzy4xC7fMItTcC0oxCI8bWwa4C1O2oYW2Wrtnl27nrMkGgh3HyBIIG4mJcN401FoltHXhkO3aND0Vd1spHHm4cVVa318y6g1Eq+9WUS1+Fv58Bs6xwmMi39ncOuaUGxU8/arADaad3zmZ+8TgwkBodBFSQ3NUg7mJEDXIuqyaRywo+EyPEPRQ5sDuY3xAIPoC4pAzR66Zd4FpHgjWrYJm1WnBBL95vKpG2MmtQWocVcvSBhwXamgfdNfbPd7LPXykA8f8r3U+V4CbR230QLctiM2QWbX8gf+yJSIHCQuVcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VqSQo1GLfCw7iYwvZ6pIUkdE7AS6QI7Hni+FLfYlbo=;
 b=t78Y9JG5hVnJyLGI7OJRBWtnruaQ4s7Y046jFqim+gX0mSuj/aQ6BKgiYl9LkIM7mH6+Mvwu/S9ZNF50i2iTGYs2d80kp4iNV8dzm+0u75tWw0lp91La7b6c7moAdglmGXOHokHZoIPM5OlYaRApKdUbfoLpFVVLz0ObbyAyS5A=
Received: from DS7P220CA0052.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::32) by
 MW4PR12MB7191.namprd12.prod.outlook.com (2603:10b6:303:22d::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.16; Mon, 21 Sep 2026 18:55:01 +0000
Received: from DS2PEPF000061C8.namprd02.prod.outlook.com
 (2603:10b6:8:224:cafe::3d) by DS7P220CA0052.outlook.office365.com
 (2603:10b6:8:224::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 18:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C8.mail.protection.outlook.com (10.167.23.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 18:54:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:54:56 -0500
Received: from xhdamitn40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 13:54:55 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <Padmarao.Begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>
Subject: [PATCH 0/6] spi: decouple cadence QSPI/OSPI from direct firmware calls
Date: Tue, 22 Sep 2026 00:24:08 +0530
Message-ID: <20260921185430.3491195-1-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C8:EE_|MW4PR12MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c35f15a-7597-4b56-5a81-08df1811d567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|3023799007|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: +rU4LXb0eKgH5jvPh5/T+ZhzPbRRxbuiJTrWrt6VXBYjKyIWI9qDkpVXeLy/81l90/Ur+YeKnnLqLShySNLTgU+D8uknBDFOr2/D5ne7WPG61Aj0++QtoVafIkKx2MfImvFJMjxCr/qhoJ1CuFG573Vm//oJA+LERmq/pmxqC/eqB8xazkc9VvSfVBrRTD8adcrVIWj405uh0Yz2iXg4EbjFVkkOJ21/W1CFmnm8af8+8Byn+gkKQfEMqje/NtLnSPrUbBEUI92bfRWe0Oj4S/IW8SQYkiePBYPFKxCfVXJvWktNXqiAOOzdbM2XL+5zqFqVJwqwCQKt8EL1t4epdxWulQhSU7hZSaag8bBNJU4UylZvWM0FW1Jv6Mi0pbW0xnlAQhKRoJLmw/BYFRDOzYnA1fHqgLpcIDDOP1xxFM44U0gdbLvsDrhqHU8B/GSSUA4JDBubDy/AvkNsgSAnt+9bHYbtJWzDtrt96gFjQfj/QgEH/NLOQSSdlRSSuS5kJ567FFnVaPnr1NSmIcjFEhISZ4uLKkuEZAvc9TLfeNU/B+JpGhs41vebiGFirkCgBH7n6kgB0PF8K89Lf8ZvwfOiZnlgzviTL7yl7SGrD2horzsmvztZrj2QmPkCiZ8R+eeeFRURg8pEYafqoblMruKBlqjMNwXRYuNz1Re1vcZEEYCsBXNG5dWqo9V7KnpMsd67y+qTf4TSCzEfsyUHTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(3023799007)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QbDvX6+bsu7n5c61godmFGsDZb19oPxXZIPz/sTXrO6F9IOEtaHxiD+CveSYGRwGhArm4QFPoS5tFUopzZuZXTN7KYgDqeTQoxBrwY6teT6JqzKwqtsM1qlXLHFVJeFjaXiAqxyRxQOQRefFZT0V1ZjYU+GTIBqbxXdEfCGywm4OwJrjuK2GI0R7ARhrtoN+1guH7lh4erfOjKZFSSEOYtB+2SzhLRzQgzMJ/MXEG7miNcRXGv35pAAXzuR3IQvwCjxRuSjApeG5uJSgYFGbI3IWeLcTK/v++w/TG9o6sUXIXerry80xG4xnqwNYnzpD3AzqgK23hn8SKPD3jrON7EDuvmtrs+fvDD5MRTnZbPP/d4tQOijFLIeVZ+2hJRwLu+AAhWhjisBUSZpOnYRxw+Bpt/OvYglkkCaAVBitdosGwQEs9IL/dXeH2OVxSLQ2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:54:58.2986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c35f15a-7597-4b56-5a81-08df1811d567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7191
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

cadence_qspi.c and cadence_ospi_versal.c call xilinx_pm_request()
directly in a few places, guarded by IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)
checks. This series replaces those with named weak/strong wrapper
pairs (zynqmp_pm_ospi_init(), zynqmp_pm_ospi_enable_linear_mode(),
zynqmp_pm_ospi_flash_reset()): a no-op or raw-MMIO weak default per
platform, and a firmware-backed override in firmware-zynqmp.c.

Akshay Belsare (6):
  power: firmware: zynqmp: add shared request_node() helper
  spi: cadence_qspi: Abstract PM node requests behind firmware helper
  spi: cadence_ospi_versal: decouple OSPI mux selection from firmware
    calls
  spi: cadence_qspi: propagate mux-select failure instead of only
    logging it
  firmware: zynqmp: add OSPI flash reset IOCTL wrapper
  spi: cadence_ospi_versal: route OSPI flash reset through firmware

 arch/arm/mach-versal-net/cpu.c                | 63 +++++++++++++++
 .../mach-versal-net/include/mach/sys_proto.h  |  8 ++
 arch/arm/mach-versal/cpu.c                    | 63 +++++++++++++++
 arch/arm/mach-versal/include/mach/sys_proto.h |  8 ++
 arch/arm/mach-versal2/cpu.c                   | 63 +++++++++++++++
 .../arm/mach-versal2/include/mach/sys_proto.h |  8 ++
 drivers/firmware/firmware-zynqmp.c            | 38 +++++++++
 drivers/power/domain/zynqmp-power-domain.c    |  7 --
 drivers/spi/cadence_ospi_versal.c             | 77 ++++---------------
 drivers/spi/cadence_qspi.c                    | 12 ++-
 drivers/spi/cadence_qspi.h                    |  3 +-
 drivers/spi/cadence_qspi_apb.c                | 15 +++-
 include/zynqmp_firmware.h                     | 17 ++--
 13 files changed, 298 insertions(+), 84 deletions(-)

--
2.25.1
