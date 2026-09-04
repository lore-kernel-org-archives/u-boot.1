Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A085C79F80
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:37:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C296D60708;
	Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AtPt6dYZljn1; Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 95E3060626
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511049;
	b=IWuWxS8WyRIVv7uKBlXC4RMt9Mpl/PDgS0+5wgmz/ll/AqAfzcuc0KDF5grdcd2nRId6
	 hFT6wYoHe1WUrKxvLLEs4jkzPjGSuPzBDNvkINAbs+tL7cDiRHrzy4zwAEsJHZS3Dpzle
	 mcYwQCiviuL8VKtok7l9SbJA7TpAXt/HZYB65gWNBqmPKQH9b/tF6WfH6R8kjzZSxrcSh
	 Yzrvn8XSLNVOlaiJL3j8rjFqmNGVdPR6ufv+BXviTBBPEksScvDV+73EMsxOiGKuTUxL3
	 0ubvgQiJQonSH/GvDTlIwbhqizYy4PC75I6TTJAvVE3j97BmDMcpCwcA3tesgFFHvMA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511049;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:Content-Type:
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
	bh=M8T67GkSjKUrsw58AkhqGPpLhu8awoOyErJcJFWmMn8=;
	b=Vnw+4i0XttQDDcXPnsG27HhvNQcCVZLRWkGsgy3iQvAfnTHRMdUOMd8LYR5YCsgzI5Od
	 vx3hlQ5Sc0jaVN97jjOoVXOPjExHWNWKKBtoCXmrssPPhNoNJaIdz/x/XA3SzX5VMOOzK
	 HTjVL/5ZDgErLppjdKGzUi+CapVuYnSn4isrAWEZkLOuRbz7xL7DeRdS4wOW59f0Pw8Mk
	 fau+O0f63CZAvQ9QENBOC0hybvkTNmZS8w7R0XHGR3B/tS7DHqbAcvCJKZ1+wqifA34XN
	 U8pM5FvqMTBaIKN5p+0024kw0oRkcNXn7Ab/en01WVKMCcKkNKu1piCi03OSMiG4ElQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511049;
	bh=M8T67GkSjKUrsw58AkhqGPpLhu8awoOyErJcJFWmMn8=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qlFDYvYFroddHGMU9ZyiLrMjvDDkm6bTxl+YWLKnomtAcz49GT7Wh00LpFFcnJEFk
	 D1GUF+hgGxPWZOg6xHhKkrXLpdnRWGAGeBtLRIN/f6x/MRWYPVuwdEWvN18mzx6gLo
	 XTRPuz3dEOul0WcR5bsxcy/bhCZNAfACRuZN6FE+VFyHT2g20jDL1lNSW2pPY1/X/U
	 fZFkmAii6YzqizWAnI48MoCjADi8tTRytKF2zB+aZNvIlvStagHICOyDXJHLMvhvGn
	 7IuUAa2VZdbvANAnVvz1meSejvOMA5bclJn0QYJ1aZGV8O2ZGnKJTlSQnVBbq1+fqL
	 ivg6Zu1wkN8UA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95E3060626;
	Fri,  4 Sep 2026 08:37:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9308B3AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9016D81140
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lVhAHe2Dueqo for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5F9458113B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511047;
 b=QbYeiftd/r+1Z3wFNiKrAFmjtCqFCEQZeU24CV8sFTW1pkUtVsEy7wmLOCfuhMBcZvHg
 8fMhThd2Cz6K1DYNQNr8OY3ld1RE1v0u8WGwp4WkybI/19PZZp8IhcelXgM/etjCeapFv
 9tynXJHjEmBWVCLSEKY+owfgRdYOrcES9MUK9eDziP7Np6qsKR9RSHq0t/vaUYi8TPgff
 X+qwXdIywmvUc0QYrbB5VZFDx8V0a/znLyQxdMjnAB/vgw8ptOz/Pk9jxiK1gG8LidO78
 ORxtj6BiyOo9JeslAJHdrsHajtMXBJJDzh6jn15EOe9KDxumJ3AXeAGRX3P/wAZbakA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511047;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
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
 bh=M8T67GkSjKUrsw58AkhqGPpLhu8awoOyErJcJFWmMn8=;
 b=MaGQ4gdoXFngcn6EsU0goWbr1rpnY4hfNffQzT3DpWOjmWswVoi1HbWtXllczBt+glxo
 Rl1OGNQ1V367Hd7aJLfj49xO3sXwgfuZI7r92sQU2a3jNFP+3BF4oqmcwDSZnNjlPEzez
 C30BhOopfBAruwhv7Hhb64rxJsHiiu2fqMBIVz7DHfECfSoNR0FCAHsVtDdvTkdYWAKkO
 J4vxqukzFfhQ9KNhwDnpn6FFCI8stGmFJ7/zUZEqOLkNLyvlrMtooGgTTSszr57FqZW0K
 cxJrqbBu8Ecm4VRSI+8zZIhIxekq0pc76sa0CLPkuQFHqsdHmojJVxkF4LM8vyyC9Iw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=XoLgt1l3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=XoLgt1l3
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5F9458113B
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIl4qFMDq16FDkEDQj4yFz46IdmNuFGPjU6uIZ42LjMUACcqy0L65hXnGUW8f6KuODYROCIO0agXyBTuYbsTJ729jycF2n2jb8eSArp2T4zYZtVL7pqB9Nf6D1Lx2Kdi/I7M6FGjJciwO4Hm0fNmJjSwTgG19FG+hj2zDEydpRGjS530OHU15HZGzXM3tDn0SUztbB9R4ZympCYNhOQ3Mf6S7kGRjQOTfn8jE5y0rglMRdTVVbSLdn27nOlN5ax6U2CBPq1AqSXAclHZwI4Kd1slr5Vq8DwLGiG5Yw9xUj5Z0uAvF4RKe8PXsNeWYRSYo6Cv/7PyO3Swcpd0L+Aicg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8T67GkSjKUrsw58AkhqGPpLhu8awoOyErJcJFWmMn8=;
 b=gmu25+ZqJS/O4BFvp46GHzBndvlPTMudJR+f6nHZ3P0zE0MKUMAPWpVLbaGKefd5LcgRg0oA5tzyWE2EUxFgYCUM0/WvWG/f/j7aqfV89A8BKvKvKY3lJX7YFnawHKoclh8CaEweLc19gIlMxCdOsYz6xBgojlReEzfcjN848UEIgGmimf+MnTA+ghr0pLLQm8dkRE0QQKb+y70vYgP4+jY4r5i4ozOWDTZPLNHmsdboYfAJNo8BCyQr+p7hUpHWkYv1fatyCi/L2YC7ot4fKBYMs7IVINXr9SYm6NEqMRYFwYCJefaRzDQtyok01Fl6c9qKk2vNN7Xy1Oad4wyrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8T67GkSjKUrsw58AkhqGPpLhu8awoOyErJcJFWmMn8=;
 b=XoLgt1l3VCJliQnwkTHJSdQ52sz7jAeNBCZHC4gMMabuUjPUrgEwmj5gFk8jecmvEORch/68SbPsatGs8wWgJTw0NdZEcemmwQ7venrBCLMO3BIw/h7wjE003xiQXxB2zMxuY4KTR6jZZkTKbM95B9LgVIsnIZLXEEuEBizt7Hmh7pf+/8lk7DGy/ox/uY7430jMzCgns3fx0pzdKZDfzfvg26WxtW4E5Sm/uVw3h0srs6PbxNkGskCnkjSpmUhCMCA7R7NqbRnxicoa1OT1TFN6SlL3Q46BLn8y0GfrxSTrO5l2bNCYaeA7Ie3ENMjcjWJeUGP8areSkPwSm0Klfg==
Received: from PR3P189CA0009.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:52::14)
 by PARP264MB5071.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:22 +0000
Received: from PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:52:cafe::34) by PR3P189CA0009.outlook.office365.com
 (2603:10a6:102:52::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA2PEPF00019231.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:21 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id AE1BA20061;
 Fri,  4 Sep 2026 10:37:21 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v10 00/15] add software ecdsa support
Date: Fri,  4 Sep 2026 10:37:04 +0200
Message-ID: <20260904083719.53132-1-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA2PEPF00019231:EE_|PARP264MB5071:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: aeb79456-e258-48c7-d1e6-08df0a5fbd03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|6133799003|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: s5jDyq8LBuziUoaHvuKucvmtIyJSQe2NR3nbwT/U8wzV+r2JOEF8M81W/MW36ulYxTtvOL0uyo/2bhj+k7XbVk5TRhql21oFu9Zj9OLLfdIQO7YLpuSg8yYGlTTyeXiF4Q4ySBhDhF0NvaQLhQHHuveMPVyf61tY1IHg3r+GY6dRY3Pd4dxtzE4TWkFeRY7V2NhtSkOWItshI8crMIxfYK6yfbyOZ0uRnQDguE8es0PM+pv6hJpPId1klwEVT075VhNclOKfqoDppr9FSvh1bklb5bD93B1w2rZtTDQHPUueFv8DGaN+ds9gOiydnWwLfaSdMNczVRY+GyHccCCKN9KDTvLhgp1hOCxguD4f74mU5FcagUEj/7zSibIRxK/g9hLd2r7kOy7Jvj6By0aftxqAWDEdmKppDDrzA+zyPvF9B1W1g8Dnqddfwl3bOuYeUJgDG1iv7YJ1siPPv03Ap9a5LjuJczKec+V7m113f/UmM5eKoT9mkgBNCwUltZhH5psEi5TxTDrHygrxo1tchFyy99GFX/GmQxIAatPYbuZ+kdD7uj/6wMJiSEx1B92ilzuBCuM1bQ93hAQiCGsDFYAgmpXDbMVBHQNoCPSVlVC9Yi/FMXT280ZOHwxcZS3326hg+yF/MeGHsY9+gZLYsN202s/TGJvCp5R/GvOAWI/emW6yMq5JxuhNM3xc6ti/VBqgZ2fK+EIPEqlsGre1SQ==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(6133799003)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TMinnB8lnd2bhErw/Y+g/7RY8aoczwKG0ialGNM7gvRnbUEldQTsx5Yh9+DcTDnmT2rf7ViopfUIrjO16296fMmvgp4ySkHRC0LwQMw0P0TgTf6a6LidFZdo7ZcQEENb28RQd33RGKsGgUWu8Mi2eW7FGNBP/Vb8jgCswMk/iaTRpMIfWS8wkSUNGSwjD7yefNAyYwdNh7+IP/9pPWaEbScfye2QTUmw0yKhOd0Addm8sA2L/T/ioxq3SInIn23mCPkZNKXePL+aRkrTLz6YwXO64Et6X0yaiq6FFS6Z4Kh7GBG/O/msCmDYxfRAtABzGXneLSkAhb7lHBGlZF4hNhCi5vUds6PjvHegI4M5mDlCJUF35X3vHq6vtjzqKT9d3LYUHfyorOiZFjXPAYuInwYFe+J4KtpYWH4Tmjk9NhK48YRo0Hi7L9WWSvo18c5t
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:21.8735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb79456-e258-48c7-d1e6-08df0a5fbd03
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA2PEPF00019231.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5071
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

This series adds the support of ecdsa with software
using mbedtls. So boards without ecdsa hardware may
also use signature with ecdsa.

To achieve this goal, several changes are done:
- fix the support of secp521r1
- enable support of ecdsa in mbedtls
- add software ecdsa signature check using mbedtls
- add support of ecdsa for internal fit signature
- add test for ecdsa for internal fit signature in vboot
- add support of ecdsa for pre-load signature
- add test for ecdsa for pre-load signature in vboot
- enable software ecdsa signature check in sandbox


To test this new feature, just follow those steps:

0) build u-boot using sandbox_defconfig and adding those options:

CONFIG_ECDSA_MBEDTLS=y
CONFIG_ECDSA_VERIFY_MBEDTLS=y
CONFIG_ECDSA=y
CONFIG_ECDSA_VERIFY=y

1) add a signature node to an its file
	signature-256 {
		algo = "sha256,ecdsa256";
		key-name-hint = "private-key-256";
	};

2) generate an ecdsa key
openssl ecparam -name prime256v1 -genkey -noout -out private-key-256.pem

3) create the itb file
./tools/mkimage -f <file.its> -k . -K arch/sandbox/dts/test.dtb <file.itb>

4) launch sandbox u-boot

./u-boot -d arch/sandbox/dts/test.dtb

5) on sandbox u-boot prompt, load the itb and launch bootm on it

=> host load hostfs - 1000000 uboot-ecdsa.itb
4628674 bytes read in 1 ms (4.3 GiB/s)
=> bootm 1000000
...
...
   Verifying Hash Integrity ... sha256,ecdsa256:private-key-256+ OK





Changes in v2:
- move ECDSA_MBEDTLS to MBEDTLS_LIB_X509
- rename lib/mbedtls/sw_ecdsa.c to lib/mbedtls/ecdsa.c
- enhance dependencies for ECDSA_MBEDTLS
- fix support of ecdsa521/secp521r1
- add vboot test using ecdsa

Changes in v3:
- do not use _MBEDTLS in mbedtls_def_config.h
- check returns and remove mem leak in lib/mbedtls/ecdsa.c
- remove useless field  *k in struct ecdsa_test_vector_s
- check returns in test/lib/ecdsa.c
- fix third parameter when calling sha*_csum_wd()
- add support of ecdsa in pre-load header

Changes in v4:
- change some dependencies to enable ecc
- use ECDSA_MBEDTLS to build the ecdsa driver
- support ecdsa521 and secp521r1
- add a test calling ecdsa_verify for the ecdsa class
- merge patch 10 and 11 (support ecdsa pre-load for binman and tests)
- several code cleanup

Change in v5:
- fix ecdsa 521 in the first patch (instead of the 5th patch)
- mbedtls: ecdsa is only compiled when ECDSA_MBEDTLS is enabled
- fit_image_setup_sig: required_keynode is initiazed to -1 instead of 0
- avoid hardcoded value for ecdsa sig and point size
- check pointer before using them
- free ecdsa keys when key are not found/used

Change in v6:
- fix dependencies for ecdsa
- ecdsa is no more mandatory for tls
- remove include u-boot/ecdsa.h in ecdsa-sw.c
- do not use fdt_stderror with -1
- 

Change in v7:
- change uint8_t to u8 in test/dm/ecdsa.c
- change info->required_keynode >= 0 in lib/ecdsa/ecdsa-verify.c
- set required_keynode to -1 in test/dm/ecdsa.c

Change in v8:
- check exact size of data read in dtb in function fdt_get_key
- enhance commit message to explain patch 2 (enable ecc)
- no longer use macro CHECK with goto inside macro
- some code cleanup

Change in v9:
- rebase on next
- update cover letter

Change in v10:
- remove empty line at the end of ecdsa-sw.c


Philippe Reynes (15):
  ecdsa: fix support of secp521r1
  mbedtls: enable support of ecc
  ecdsa: initial support of ecdsa using mbedtls
  test: lib: ecdsa: add initial test
  drivers: crypto: add software ecdsa support
  test: dm: ecdsa.c: clean this test as software ecdsa is now
    implemented
  test: py: vboot: prepare integration test for ecdsa
  test: vboot: add test for ecdsa
  tools: fit_image_setup_sig: set required_keynode to -1
  tools: mkimage: pre-load: add support of ecdsa
  tools: binman: pre-load: add support of ecdsa
  boot: pre-load: add support of ecdsa
  tools: preload_check_sign: add support of ecdsa
  test: py: vboot: prepare test for global signature with ecdsa
  test: py: vboot: add test for global signature with ecdsa

 boot/image-pre-load.c                         |  53 +-
 configs/sandbox_defconfig                     |   2 +
 drivers/crypto/Makefile                       |   1 +
 drivers/crypto/ecdsa/Makefile                 |   6 +
 drivers/crypto/ecdsa/ecdsa-sw.c               |  31 ++
 include/crypto/ecdsa-uclass.h                 |  15 +-
 include/crypto/internal/ecdsa.h               |  39 ++
 lib/ecdsa/Kconfig                             |   1 +
 lib/ecdsa/ecdsa-libcrypto.c                   | 104 +++-
 lib/ecdsa/ecdsa-verify.c                      |  73 ++-
 lib/fdt-libcrypto.c                           |   2 +-
 lib/mbedtls/Kconfig                           |  24 +
 lib/mbedtls/Makefile                          |  20 +-
 lib/mbedtls/ecdsa.c                           | 152 ++++++
 lib/mbedtls/mbedtls_def_config.h              |  41 +-
 test/dm/ecdsa.c                               | 107 +++-
 test/lib/Makefile                             |   1 +
 test/lib/ecdsa.c                              | 456 ++++++++++++++++++
 test/py/tests/test_fit_ecdsa.py               |   2 +-
 test/py/tests/test_vboot.py                   | 148 +++---
 .../tests/vboot/sandbox-binman-ecdsa256.dts   |  24 +
 .../tests/vboot/sandbox-binman-ecdsa384.dts   |  24 +
 .../tests/vboot/sandbox-binman-ecdsa521.dts   |  24 +
 ...pss.dts => sandbox-binman-rsa2048-pss.dts} |   0
 ...-binman.dts => sandbox-binman-rsa2048.dts} |   0
 .../vboot/sandbox-u-boot-global-ecdsa256.dts  |  27 ++
 .../vboot/sandbox-u-boot-global-ecdsa384.dts  |  27 ++
 .../vboot/sandbox-u-boot-global-ecdsa521.dts  |  27 ++
 ... => sandbox-u-boot-global-rsa2048-pss.dts} |   0
 ....dts => sandbox-u-boot-global-rsa2048.dts} |   0
 ....its => sign-configs-sha1-rsa2048-pss.its} |   0
 ...sha1.its => sign-configs-sha1-rsa2048.its} |   0
 .../vboot/sign-configs-sha256-ecdsa256.its    |  44 ++
 .../vboot/sign-configs-sha256-ecdsa384.its    |  44 ++
 .../vboot/sign-configs-sha256-ecdsa521.its    |  44 ++
 ... sign-configs-sha256-rsa2048-pss-prod.its} |   0
 ...ts => sign-configs-sha256-rsa2048-pss.its} |   0
 ...56.its => sign-configs-sha256-rsa2048.its} |   0
 ...84.its => sign-configs-sha384-rsa3072.its} |   0
 ...s.its => sign-images-sha1-rsa2048-pss.its} |   0
 ...-sha1.its => sign-images-sha1-rsa2048.its} |   0
 .../vboot/sign-images-sha256-ecdsa256.its     |  42 ++
 .../vboot/sign-images-sha256-ecdsa384.its     |  42 ++
 .../vboot/sign-images-sha256-ecdsa521.its     |  42 ++
 ...its => sign-images-sha256-rsa2048-pss.its} |   0
 ...256.its => sign-images-sha256-rsa2048.its} |   0
 ...384.its => sign-images-sha384-rsa3072.its} |   0
 tools/binman/etype/pre_load.py                |  78 ++-
 tools/binman/ftest.py                         |  50 ++
 tools/binman/test/ecdsa521.pem                |   7 +
 tools/binman/test/security/pre_load_ecdsa.dts |  22 +
 .../security/pre_load_ecdsa_invalid_algo.dts  |  22 +
 .../security/pre_load_ecdsa_invalid_key.dts   |  22 +
 .../security/pre_load_ecdsa_invalid_sha.dts   |  22 +
 tools/image-host.c                            |  93 +++-
 tools/image-sig-host.c                        |   7 +
 tools/preload_check_sign.c                    |  30 ++
 57 files changed, 1892 insertions(+), 150 deletions(-)
 create mode 100644 drivers/crypto/ecdsa/Makefile
 create mode 100644 drivers/crypto/ecdsa/ecdsa-sw.c
 create mode 100644 include/crypto/internal/ecdsa.h
 create mode 100644 lib/mbedtls/ecdsa.c
 create mode 100644 test/lib/ecdsa.c
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-binman-ecdsa521.dts
 rename test/py/tests/vboot/{sandbox-binman-pss.dts => sandbox-binman-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-binman.dts => sandbox-binman-rsa2048.dts} (100%)
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa256.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa384.dts
 create mode 100644 test/py/tests/vboot/sandbox-u-boot-global-ecdsa521.dts
 rename test/py/tests/vboot/{sandbox-u-boot-global-pss.dts => sandbox-u-boot-global-rsa2048-pss.dts} (100%)
 rename test/py/tests/vboot/{sandbox-u-boot-global.dts => sandbox-u-boot-global-rsa2048.dts} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1-pss.its => sign-configs-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1.its => sign-configs-sha1-rsa2048.its} (100%)
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-configs-sha256-ecdsa521.its
 rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its => sign-configs-sha256-rsa2048-pss-prod.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss.its => sign-configs-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256.its => sign-configs-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha384.its => sign-configs-sha384-rsa3072.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1-pss.its => sign-images-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1.its => sign-images-sha1-rsa2048.its} (100%)
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa256.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa384.its
 create mode 100644 test/py/tests/vboot/sign-images-sha256-ecdsa521.its
 rename test/py/tests/vboot/{sign-images-sha256-pss.its => sign-images-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256.its => sign-images-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha384.its => sign-images-sha384-rsa3072.its} (100%)
 create mode 100644 tools/binman/test/ecdsa521.pem
 create mode 100644 tools/binman/test/security/pre_load_ecdsa.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_algo.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_key.dts
 create mode 100644 tools/binman/test/security/pre_load_ecdsa_invalid_sha.dts

-- 
2.43.0

