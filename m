Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36616C982F1
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 09:20:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D3C7940AAC;
	Tue, 22 Sep 2026 09:20:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7CNNa_1eWF57; Tue, 22 Sep 2026 09:20:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E7ED140A39
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790068839;
	b=Qnn+8Y2Wry6SSIxj8CZcpeZawjAs17wWEN2ZWPoH70pLTQ38I5e9whchWxGepl1Nf8a+
	 EE5FVQxOqaEUATCFdBbLPCZwdky2Hffk+hegtPr8eXZxJFKs4k5nNl2nAQpYu/TMu4bNE
	 HpzTgn5R2A1X6xoN5LZuwJZ1s8O6qombXL8LGDKD9RyHIPWxtde//5MwfusJMZ9B3aLuk
	 Ks57PaVwmC5bRVLfXTiLCKJi5VIYC4OD/R+hlWf6+j52QAH5IsvUbrHjieLrEtJZU73+D
	 GCjlBCgtWjiOv31UBqLCXmSphcMzFb8uJ8DCtLNL4+zvkLWp6ETOu0MOYbeHg/rwBuA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790068839;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Content-Language:From:Subject:To:CC:Content-Type:
	 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
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
	bh=UZ62fWAJyqTe2rlWW0MMV48+9Jn4O4li0iTN3cvy4/8=;
	b=IhS4uiqtQkpy/E7+G+TL8EId/PR0ghYAFNJeWrtzzXa8xMrCzC7P2HKhbYPDHS+TanSv
	 uCQCEK25NDC6mr0jk+EI7qfF3N55BkvYSet+eYtqYte827P8Du+rrALh8KEXJzRCgzZvI
	 hkBrkmjnvuWPLkqFln1XdHXdtjwNayn8GjIuPpif0j0bCEsWMoW1typU+dCvnoT7hBFJZ
	 Gkzt68ArQIt4xQqlpE9Rhd2YLcEsseREg4W6rL2yyrouCp6vRHp/XCJR5WfkK5uJ7blf9
	 FL0IvQfC0FV3Zr4I0glEWMWoemVq/q4wn8AaYrF1LOheQaYMISbfkKBPnIEDRDBgDTw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790068839;
	bh=UZ62fWAJyqTe2rlWW0MMV48+9Jn4O4li0iTN3cvy4/8=;
	h=Date:From:Subject:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=y4YRBw4uKRZuYo0kCrwLIagpnfOBFNCD61qgnlCpkq2HCRCtQL5BC5xpDfKCOV6G0
	 /fZSikSWvVnkVm9gXMkGpMhe/AF4M9ym3e1X5czYOYbfgK3MvA52R7pHnGc7QBMFdg
	 lZ+2+XiX2+ipVDdnXBZ5qo9kTAso0496E+4kORXuu1l4b1z8GT1ln9zLyEJAdUi8aX
	 YEvkBr1AYCAl/GLokHymOjMziNHzwA332v6ernLnfQJRmlQDYn18WKdjQ6+kbYRxam
	 j5+SQtDAxFaejsCkE18Bd/X/EJpMqr2VQfvOPeyUHF2d4Lx7IXSfQU9ADJHlpcPATT
	 FYcN2eGc9N7lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7ED140A39;
	Tue, 22 Sep 2026 09:20:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 9115513B
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:20:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8260880DBD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:20:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k6CIBqxeGAHH for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 09:20:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 0432780D8D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790068836;
 b=GltqZnr+8125r4WF/zuf6bfuDrDPKnyKRWAe7vZnLHpqqPGC8OmpqXHDsSfJGQaXKBi2
 EuGa2/rCNlmo44Hlr28lIMXN9YPyV/f4diU1CeaUCAoxbVP3DJE2CcumboRj1Rp/zlC3k
 nj/Iq1XY2vlZd1dOSsao2JJJi1ICWAjd/LNI9T3cIEfOXyH0blXZ+DUrjcE2QHrxdlu2P
 9kSZltvwnKRfpifI8v22J/R+On3gCnRjnE12LBM9tgOXQAp0t3R0j+Rn9DwCP+F2eDHHV
 3jmwyxSf0H56nyOCg9KEFFqql1jGkI+j82r9sP+tewyMTsNRrsVGqJ17Z/Seen2c5cA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790068836;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Content-Language:
 From:Subject:To:CC:Content-Type:Content-Transfer-Encoding:
 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
 bh=UZ62fWAJyqTe2rlWW0MMV48+9Jn4O4li0iTN3cvy4/8=;
 b=jN4TsaDgQoe90D0+e74FBtlqgIDDXqqj4vSuuXfHgK6fGtMjkDr/dj8rT2cYTmdW6MwB
 JKTj80R3y5n+EJOaEDDJIa/cqudXz9AU2rokvF9pKv3NR6Jr74FlCkrsAkVDtx3M7ndoY
 neP8qci4cEf+9FGbTxb4RIgJwxZzYOKevgsla8v9R1VgWR/a25Ue5htqXl1kQznSuw8VU
 3Z4BcALtXGZwTq/WDQ2GF4c6kGkeQ8UNw/aqoi+eyngWT6My7NZpVoZku6/pCspwL6qXF
 4+prlXnBRaj4EdexvUInpXZv/IDUGsgDEIH5IL6e2A8RA+PsvXZpdryyrzXZqAciZWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=DyuXIMTi; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=DyuXIMTi
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0432780D8D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 09:20:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgzZJL49gKe5xoMb0KpcXWCvM9WdUpWsyb3ZVqd0RO0OiFBw767+5FoWb5GutMW4+eTA4UAWPhJJnTwIW49/+DN4icIEa3sd+4PDeIAp3a7OMdHdtr8/GvXQhRZsvT9RH+vPdTzfhd8gLwG96C7Ii+OZiYPrqQZ+sgoQn/JLaqkPaWFL0eDksaPTTdc2zAxQs6SC8Rm/G5cyy5fh+EEVtygn76QNJH4Ph1W77NFo6/prWDIoK1HsHp+Rr46oFqp72yg5FFbdUMbjZtfF+/nkN5ozrxVBL7SbR08IOB2JIzwwFNwMEWS/vBzUYQWBS623uCZZ0x0XRKEN6w8R7mWh9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZ62fWAJyqTe2rlWW0MMV48+9Jn4O4li0iTN3cvy4/8=;
 b=Ctf35UWO4JLkM+lrS4mhsGFaCZi5E3ncCXj5s+kRIsvkNN4M5jZwk2Kz3EoNCCRKbyBR8ACFgZrBIroeDN4FA4CevrHPVhWrgMuwefeCRSHwI41oQqDuaRyR+C6ihFL9AI4nsgq/n3kgtwhfzSMROmUfja/ezSNF/5kv0fyBCLNpuQGQYk1NMMLE+FOkA+vCYDtIfPC1lev6SDSNn+jMxMz09AopHwZtcGZQkzzyQWcgg/9QKfCLNaO2Hjye4oUvbN8BFNFkLZKNdA7oS7cKVppT1Oy7jPNCUWZVHRobVe8sgs4ne1Iad0H2fDmpvVPyItUKf0rjQBdVe1HEINZtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=konsulko.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZ62fWAJyqTe2rlWW0MMV48+9Jn4O4li0iTN3cvy4/8=;
 b=DyuXIMTi4E54JJXp32hb704A8J9+b16LrUaACcWzbsK4YcB4EODGrwsKoyOGbb5cQGJy4VJQPfMKCWM8E22JRVQDA2Gau4gHlRmnpnLDxSPhMjs/n5cUpYa42B6R/mlxV4NOgPvN3QMK5vS0qqdRZjTtePKT9c5IeNJDmIXspfaZSyjCnOXS9sAUUiwSXcd7cRyag3LV2Mk+RHaRH/xQ71ybKERQlTCD/vleO8mby3OWiWQ8ag5Gbeg857bqpqHrnb+1BjtBDPwo1Pgd1DZAi0Ri3hD/PpCF1MpDIUVn3qK6RY3TrzpBzqN2ZggBLn5kfxN73tNLrS0d9UhTrSVXDQ==
Received: from ZR0P278CA0029.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:1c::16)
 by BESPR10MB9296.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:b10:e9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 09:20:30 +0000
Received: from MI3PEPF00008495.eurprd03.prod.outlook.com
 (2603:10a6:910:1c:cafe::39) by ZR0P278CA0029.outlook.office365.com
 (2603:10a6:910:1c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 09:20:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008495.mail.protection.outlook.com (10.167.240.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 09:20:29 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 22 Sep
 2026 11:26:57 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Tue, 22 Sep
 2026 11:20:28 +0200
Message-ID: <91f7a823-3822-4e2d-b44c-8d29e04277b7@foss.st.com>
Date: Tue, 22 Sep 2026 11:20:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
Subject: [PULL] Pull request for u-boot next / v2027.01 = u-boot-stm32-20260922
To: Tom Rini <trini@konsulko.com>, "u-boot@lists.u-boot-project.org"
 <u-boot@lists.u-boot-project.org>
CC: Patrice Chotard <patrice.chotard@foss.st.com>, Patrick DELAUNAY
 <patrick.delaunay@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008495:EE_|BESPR10MB9296:EE_
X-MS-Office365-Filtering-Correlation-Id: be1d2092-424c-4139-0213-08df188abefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|13003099007|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: O3RKaJPLos1gmQKFTu80haqa2ftMVHI4AkxYmE/TYuquRaOVeH2K737OnJBw1eVU6Gp1nAo22dqF4jLR7MM60zeNBFrepMNAeHR5BDUzMFFy65Sg2+uRgLCcs2aaQugXwxi3tjD8ebVlm7VpMkQQoyNUdJzW7IVOkgs1/kquSt1xiFjK4185Pc8WbTNXAPv65wQnQj5d3FUviMu7TrgoCURnV2lln45LI/H7mz/2wYvnrtsnhH7CSXXM/Y1HX1d8SnoR/AK20xo/4YCJPz7Tzvxp1fbOAJebI6UImrVkl//qq27f6w/wzkg4hCC9fwGmpdpTPZk7Hcs0RkKFo8p7Qx5Rnvaw0+c8icJsmVQgMBneJDAEP9iOiBfRHgo5qJMz/6lK8DKMiXYNpdPkaKjoZhIxSeQeO+NApbVkD5HI4svVEMuoAHOmkz5c2jRLJX+JjK+Hc4+f9/PWG6EEZOyq5vcDNLxjANo593Y8ClF7F3+Mh0IDdKPyt9vPhhqao00LeVolI4cEzlo6ZOew7cMMDn6JvfC+1urZtA0VINN5vwci2NE9+oSG6mazM7zBqN85vFC1vWJX1J66jg7VZ6o9fckzlrSjBIlRirwGqg7l+pdhQvbN4urZSotA+dDMB6tRT2RQSHseRFNppX+TFim92A==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XHRh5Dr3QdVK7N3lDqXNXnc8WGY7TgrsEtvyc96Eef3/Iqpdy8T7n8B8cyxUII0sQv/8vw8VVK7Tc1/TsJmjmEEwYc7h1CtOjueN/lfsIqIbjiFLnltkJbvFea0+LvOTza0eilg4c/gWS9wY5r4M/OJSihS+Ee+kSElNG/+CA1ugzGHqqJk6EJ8aQSxtCJkOFKuKFaTi0UEc9MIYAmfOn17CvPuTjrEqighIuR62g8vSxxWRHHFn0ib0ibEid+tv9FLsjleu6DQ6M3SwAHKI9QOy2s43WyruHJUb0F5xSSgnfhUp/tiaR/UZ584ZbpvV4RNorcsdF67wq7yC1CrmrQnxm9QMrqkINYjDi8IE6aqq/OLfluii6Ar9/fv5siUkmwx/pC9jc4YYQH2ZEC5ecwQUcusmCOT+IZBz+CzqSLg2PmOMZ/9eTQEVxVZEgAcJ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 09:20:29.7272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1d2092-424c-4139-0213-08df188abefc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008495.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BESPR10MB9296
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

Hi Tom

Please pull the STM32 related fixes for u-boot/next, v2027.01: u-boot-stm32_202609022

CI status: https://git.u-boot-project.org/u-boot/custodians/u-boot-stm/-/pipelines/1352

Thanks

The following changes since commit 951132236b9adc592c2e49faadd103c6a355cac3:

  Merge patch series "spi: Convert drivers to dev_read_* APIs" (2026-09-18 11:18:46 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-stm.git tags/u-boot-stm32-20260922

for you to fetch changes up to 675f0923a5f30c72f304f24c577ee9cfdf9c1b0c:

  configs: stm32mp23: Sync config with STM32MP25 one (2026-09-21 11:11:32 +0200)

----------------------------------------------------------------
- Enable CMD_BDINFO_EXTRA flag for stm32mp21_defconfig and stm32mp25_defconfig
- Synchronize stm32mp23_defconfig with stm32mp25_defconfig

----------------------------------------------------------------
Patrice Chotard (3):
      configs: stm32mp25: Enable CMD_BDINFO_EXTRA flag
      configs: stm32mp21: Enable CMD_BDINFO_EXTRA flag
      configs: stm32mp23: Sync config with STM32MP25 one

 configs/stm32mp21_defconfig |  2 +-
 configs/stm32mp23_defconfig | 28 ++++++++++++++++++++++++++--
 configs/stm32mp25_defconfig |  2 +-
 3 files changed, 28 insertions(+), 4 deletions(-)
