Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287A7C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 18:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71DDB80DB9;
	Mon, 21 Sep 2026 18:55:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jWwqEmYkcX2u; Mon, 21 Sep 2026 18:55:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 91D0880D2C
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790016931;
	b=LyJ93Z2SVAoLWlF1PvrIWKZyfg99ztq/Faz6Xz9QBwx5EJcvBfOsjtVykWCzWyVM3Rsq
	 zunxYiKNiBQkPRJETplH8ALj9RLfAVH22W8PJ153v0yqreMHG2RM9O5YOVtx0LtR7FwWf
	 ZHs59RvYCg52zUF1WsjX24xAbq0cfK7CNkp3KzWusDDxkhgBix4VGzWsgxerpHNjQab4L
	 1YlL6WfgZLmyXTsdGzaiQuqPgHPjNRUaV8y/xMj+fi7vL3o9D6iRXl0V1WElFJQeRCG5g
	 q0KZEhI2A1Auy1ZiywANDdkWrTCkeDEZIySnIF7NbdUOkIpbihLE2HYD5ADiK5+MWEw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790016931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
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
	bh=UqwQfB1nGpKZPmHfMocJ+AGCFir6YoQWO5gsaO7n81k=;
	b=Px8ntjNONLb13YzVFhwZ46ddPTQFBBs2R4lKbjOq4mFvlG1R/bw0P8U3wVYDYhtVLgxg
	 3dwyGMhqQnqbS0RqWxtjnPM1ddkLJfQnsifeIetJZPmgXwrAGxGcgruSax1nwLsvHFKHP
	 y8OvI+gn8pFkTjOS8NO7L2onwTMDElpv8A2iciyRllH0f3Qhxzu5qtGzuLLE8QLME+vX+
	 d6XrelIPdIDZVooN7rgBBBcRb8h2z3tBv/o4YJoGUq/6R7/yQ7dFuqFOFURMVSesxYxng
	 9qfbIzn1QHZHZp82NPmvsOdfBH+PZiDxt5oU0WdxuE5MaKtDfgp5DJCODUacfh+7r/A==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790016931;
	bh=UqwQfB1nGpKZPmHfMocJ+AGCFir6YoQWO5gsaO7n81k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ohjg+2aZkO0BZ5/QcS0N3PcGdCLtyEOJ8K+0oSACM4uFoBJcHN8gqcCjUuMawdBvh
	 34RqOo8k/EiUKgA9aZIpFGXqG56Kb6tikgrhQfoM+TrvAaqXmJLaHa6K+ag2XJMayZ
	 IEDHGhiGHKdjUopGAvL4smzbSPRaLVInEGHy8wtdBQiyDbjshdkCYVwrGWDISTcIgd
	 5j2zG/FGxAhTOO9epHjQ+oilE8L22dcaGijGFmIkTlfqidB5cSz760HyEmePQ7mbVN
	 WHzGunVxpjz1or9HvMlZ2LlnwOpb1XOg1cWMO7JDdlT/ygL4I+jr8GTJXZ6sCBc/EM
	 cL2X0hsSrdGcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 91D0880D2C;
	Mon, 21 Sep 2026 18:55:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3ECF1224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:55:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3C67F40A20
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:55:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J6oy_4M54zIW for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 18:55:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2D25940A1B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c10d::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790016929;
 b=Kr6ElBxJIOS8qI2N9zTopgvWg2wmsu7eX1EjFA3Zwg414OZ+ZcrCyePTGDSQebn55rTP
 Qny9qI9qj762NxNoK4NzN3t8C3whYJj7znWjo1l0+sJaubf0SznmiUt13YX7EfjMsYLDF
 jIcYlE2xdZI4JcVPCs3CtytCGuOgBqkxGOvIAvz9Goidyhr07RWN+nYJ7DfrKcIneRVOi
 NSp7DODuXnoPidZAqSb7baU9M3v0h7fHVjVOkH6B1mL/v8yze2bS7BAYhOOBC95OgHjfU
 Fwu7fDh13dDAPPkscQm8PMjczziRtg17/KgiuzuUjDNPNZ/3pQ1iriIs4pk44eJETeQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790016929;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
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
 bh=UqwQfB1nGpKZPmHfMocJ+AGCFir6YoQWO5gsaO7n81k=;
 b=Gwcgx/W7ehOb0CN3NLKSU1JZxJeaD56pnPoLT0S1avZyRteZN/QfrBXt2fc0YGAQ1D1Q
 kmN4a+Fr8v50MVm1fh4bXXT/8JfD6LLnCkT/SmzBD73H7JgRIxMgwg9pRaHK/wmuSVsX+
 bkCZ42Pktqb58+H+l3O9UMXVzAb9lZxkHH0XCNmXYenDdsu7BFmdVEXKSPMIs/SezQjjW
 r58WVb0A8MCafOl30ZeQzq/e2ojNdc86YT+fS/riSaWJAOHsyZmAGygTgs2eFYEraVTZM
 GoWIdUdefqxlVvfzgPEN955HDl79SeNs9FyZ+OZrV3YdcaRZ5pM3H2uSgvgDuklFPPg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=amd.com; 
 dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Ac2vULaU; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c10d::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c10d::1;
 helo=sn4pr2101cu001.outbound.protection.outlook.com;
 envelope-from=akshay.belsare@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=Ac2vULaU
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D25940A1B
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 18:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqJZnqwBIqyC8P18nai27PMNIXeUxpMqaoqAutUhs+a6vZe3a77e9ko1rPLEVdb93tCET/xjKiuXDOwaHjkKq+JIHlbSmwkMG0BU6Ts6COoeoyPinBasXaYyW+/1HZWpCdVVhpRIbjh9DMM844nHqG6Ox9SnqWHhsuMF18Lop8XOALb5FpJ5GI8W7N0Kgn1acKWwVRpc4p6olOUCdSPbQraX/A+ajB7dz40htaMEs4N5FlPZ4s4SD3W882tPMvpueNToPyGQdttbgcTj/4JlfT5RL30FM4fMuncshg7P5yJvjovisQpbpP5n12Z1tYfGgkd+ZSWqNHF9ZaG0bUSFlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UqwQfB1nGpKZPmHfMocJ+AGCFir6YoQWO5gsaO7n81k=;
 b=QaIdhv1fvSj816e/Q8XVRc3cTa+0fAH6wy/ywD6RILRZddecVrD3vcJ+5CQ812FjT3+Hevt1ZOELILjx8N201HET/cOKnAH6SVKnH+jQrRyFalm/mieE9DcH6Rh72Ki8fsjwE4+i2qNeui71lDZw1B5MBOh0UigFOg7emigopnfWm3lHRYhuEnI+L9sGeRYCmAKYrq5GgVdzhuRRCdbaJGYeKZw9tATkItd5r4zyhUS2/dsynviD/DhzeLYuh9s6Ky/XPoPgJXSVXMVRRegTAlVMrdlev6aPdnWRB07x+YPMP9ShWyxmptcnsJojUKQx44XjPNzEoDjgYPLYv1MtoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UqwQfB1nGpKZPmHfMocJ+AGCFir6YoQWO5gsaO7n81k=;
 b=Ac2vULaUlW4Gr0nG79OxQ85uTtUAGTI0QoJiF3MjeVNNISw4NM/h/TrLKWzFgCPKMRhP3b/LxSerGWZW41OXJ4FWemmTU3boKxroDPg3jVIih2mzvGT5qnPFn0Hl9n8lcsG7TFJ062LtDNC+coPN4wvjUic9t2g8TZQHLBm8yC0=
Received: from SJ0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:a03:33e::9)
 by SJ0PR12MB6989.namprd12.prod.outlook.com (2603:10b6:a03:448::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:55:19 +0000
Received: from SJ1PEPF000037A3.namprd04.prod.outlook.com
 (2603:10b6:a03:33e:cafe::73) by SJ0PR03CA0034.outlook.office365.com
 (2603:10b6:a03:33e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 18:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A3.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 18:55:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:55:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 13:55:15 -0500
Received: from xhdamitn40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 13:55:07 -0500
From: Akshay Belsare <akshay.belsare@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <Padmarao.Begari@amd.com>, Akshay Belsare
 <akshay.belsare@amd.com>, Tom Rini <trini@konsulko.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, Padmarao Begari
 <padmarao.begari@amd.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: [PATCH 1/6] power: firmware: zynqmp: add shared request_node() helper
Date: Tue, 22 Sep 2026 00:24:10 +0530
Message-ID: <20260921185430.3491195-2-akshay.belsare@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260921185430.3491195-1-akshay.belsare@amd.com>
References: <20260921185430.3491195-1-akshay.belsare@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A3:EE_|SJ0PR12MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: 2cf02a72-e08b-480e-58da-08df1811e20a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|6133799003|10067099003|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: LwE8MFdBHkvYoc5FaartJR6JE92jlfmM84+B8syCzvicVOdvQPDBBqL25u6WD6bQegX+kY0SGiFhCd+7JWQB6nsAEg/j8yEwYKXseQXe66KBP1L8HPPFILWIdUuSBIzE0Df1ezFsHjugb3/LDmZS4eEUumTTDV5vsuzuQqSUfDb0fCXPs2Lk+sA/HtF8oa/LOEQJuk1elEyjxo4hMRys4OChnZu9MGeRblvd01SkLkyddeuAb/QFuU2jS7siKTLg83+C63ynZ7xL5Q+Wk1kAewRl0wp1OKzgdsksrN19CzQZJnoSDYoeGML4vueWD+IKoeeJoFU4u10f1lI5X0qTTPaZiO86xqjqgtFiv33pYrRhVw9SBEy/tvw7Y78Bna+Kq4h4RhYFbTRB/HX3ibz3wsWpFlaxg+foRMTn9+NCyJAjk+MCfaQd15JxjVAtJK8MyNIsA2O0SlcUpwji74roafSFsAsyZAgkEDuuQUmAVGDkh/hdquhHqrXHsQ14QL0EhRK49B8L4OoPEQohiLrgfuSlUnt4w9AqFANiwOJ3rfZEdSly/5LRuX/PFLAFaI/aUHhVrKncKh9MiDxj5ky+N16eAt0d9WsRku3ZAwcAhvKNg3B4EPj0ALOnvCsRPEVVcw79r4stIS7/dyjndGaD9prEeQjmmo2kDlmIN5k4DB4PIcxtw00qub8srk8AA0sm3Uxl/xx7W4ZPIs9V2uX7TA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(6133799003)(10067099003)(11063799006)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v1+L8yWE53aa4q4zYqFTnPWGYxpSfgrV8/d/75ymfwN210G7ufOMd17wNq02s5VJkq0pJqAbNmsgp0ozXxA/ILqBaMTG6aB25XWfF2Nk6GzhayFRZzh4PfzR+3qZuzhOw2ECcc54jztN0cutADw6/57e0L5ZOVaVoUn+KtI6U16zGZXecZJkaS4+64b18lZ4mKprsKayVcdVO4OLyh8DGkEHMkvy9oKDoJ9ruPucMpUATriHnZNNPEsgKU394VVqRyAxJOVox5N/eQa2BG6ZwBvY9fZMqOXrODYJarz4TYdEnCc6IeYAxEUR41rJDtFVgzsOTfb+i+F8e+hMmAY2LaGs2WBDO5tr/ze+yqJb7aMNP4Gj78ONXgQSDqhAa1+19LXxdTXMZ3/ZCFHv2gTQE9z4xiXL/Lwgqins7lzLMpB4I1ymBxIZk1S/z2dQpr0V
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:55:19.4712 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cf02a72-e08b-480e-58da-08df1811e20a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6989
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

drivers/power/domain/zynqmp-power-domain.c currently implements a
private zynqmp_pm_request_node() wrapper for issuing PM node requests.
The same functionality is also needed by SD and OSPI drivers.

Move zynqmp_pm_request_node() into firmware-zynqmp.c as a shared helper
and export it for reuse by other consumers. Remove the duplicate
implementation from the power-domain driver.

Move zynqmp_pm_request_node() outside the CONFIG_ZYNQMP_IPI guard to
match the unconditional xilinx_pm_request() dependency and preserve
ZYNQMP_FIRMWARE=y, ZYNQMP_IPI=n build compatibility.

Signed-off-by: Akshay Belsare <akshay.belsare@amd.com>
---
 drivers/firmware/firmware-zynqmp.c         |  7 +++++++
 drivers/power/domain/zynqmp-power-domain.c |  7 -------
 include/zynqmp_firmware.h                  | 15 +++++++++------
 3 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index fae66ccb3d8..50a7f8c02e7 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -845,6 +845,13 @@ int __maybe_unused xilinx_pm_request(u32 api_id, u32 arg0, u32 arg1, u32 arg2,
 				arg5, ret_payload);
 }
 
+int zynqmp_pm_request_node(const u32 node, const u32 capabilities, const u32 qos,
+			   const enum zynqmp_pm_request_ack ack)
+{
+	return xilinx_pm_request(PM_REQUEST_NODE, node, capabilities, qos,
+				 ack, 0, 0, NULL);
+}
+
 static const struct udevice_id zynqmp_firmware_ids[] = {
 	{ .compatible = "xlnx,zynqmp-firmware", .data = (ulong)smc_call_legacy },
 	{ .compatible = "xlnx,versal-firmware", .data = (ulong)smc_call_legacy},
diff --git a/drivers/power/domain/zynqmp-power-domain.c b/drivers/power/domain/zynqmp-power-domain.c
index 0acfc54e787..27d13769e9a 100644
--- a/drivers/power/domain/zynqmp-power-domain.c
+++ b/drivers/power/domain/zynqmp-power-domain.c
@@ -13,13 +13,6 @@
 
 #include <zynqmp_firmware.h>
 
-static int zynqmp_pm_request_node(const u32 node, const u32 capabilities,
-				  const u32 qos, const enum zynqmp_pm_request_ack ack)
-{
-	return xilinx_pm_request(PM_REQUEST_NODE, node, capabilities,
-				   qos, ack, 0, 0, NULL);
-}
-
 static int zynqmp_power_domain_request(struct power_domain *power_domain)
 {
 	int ret = 0;
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index f753a67ac27..949ef5ec121 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -468,6 +468,15 @@ u32 zynqmp_pm_get_bootmode_reg(void);
 u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
 u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
 
+enum zynqmp_pm_request_ack {
+	ZYNQMP_PM_REQUEST_ACK_NO = 1,
+	ZYNQMP_PM_REQUEST_ACK_BLOCKING = 2,
+	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING = 3,
+};
+
+int zynqmp_pm_request_node(const u32 node, const u32 capabilities, const u32 qos,
+			   const enum zynqmp_pm_request_ack ack);
+
 /* Type of Config Object */
 #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U
 #define PM_CONFIG_OBJECT_TYPE_OVERLAY	0x2U
@@ -485,12 +494,6 @@ u32 zynqmp_pm_get_pmc_global_pggs_reg(u32 reg_addr);
 #define PM_CONFIG_IPI_PSU_CORTEXR5_0_MASK	0x00000100
 #define PM_CONFIG_IPI_PSU_CORTEXR5_1_MASK	0x00000200
 
-enum zynqmp_pm_request_ack {
-	ZYNQMP_PM_REQUEST_ACK_NO = 1,
-	ZYNQMP_PM_REQUEST_ACK_BLOCKING = 2,
-	ZYNQMP_PM_REQUEST_ACK_NON_BLOCKING = 3,
-};
-
 /* Node capabilities */
 #define ZYNQMP_PM_CAPABILITY_ACCESS	0x1U
 #define ZYNQMP_PM_CAPABILITY_CONTEXT	0x2U
-- 
2.25.1

