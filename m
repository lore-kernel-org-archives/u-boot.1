Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89375C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 08:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 375B2608A4;
	Thu,  3 Sep 2026 08:17:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rH_i4Ak9OzoW; Thu,  3 Sep 2026 08:17:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 518CD60B0D
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788423462;
	b=BqP1h1kEkEmiqSyV7PDwVAQXu6V1G+RKarxSTuwFxeG6o8bohmt2t9mlqiz0wRoAqRSx
	 6A2F1VUYCr+bsxFOiJ5pISKY8+rmhd3KKmGhaGX7HJEityyy+y3WXVVP4cb9asbGodZOn
	 PBrnBbWJzEkEOG2NZpWp9xlYlyB8+MoNtPvgGjSbKWHuAlNSJpc9tjRDWZkTL+E+7fb/O
	 52teXY7bltfAEKGaGjMx9zfuoQ+05leVhd0/TrneJcSOy12DmNkAfEo9yZK8uS97llu7v
	 F5tpJRcJV2PcU/0lLAEPK8xD5H7N2tNPelvu4mZLpY/rwogHH02S4zOtNMv9D+ku/wA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788423462;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=BJoVPykgyU95lNOsohc8UczZKGo40zeKV5onL9l4SHQ=;
	b=Ka41GRbIrvNkLHsDxmFXwzssI580sncReUPdsPVUI5vNcZ1EChWLNpqOsenKPA3qgtsZ
	 YLUKfQeF6oAlXpbdWgMXG48yO167BLB1PjAFVH/UedOKX4Hra7IEsrr846T2Zv73Xj8D/
	 ixUmMD9LYFwQPQ1FOr2Ff1+5akGtr1V+dbACd4twyfM8aPdlF2TTqHZ486nbS9kWMzpVJ
	 TFZgtmfBMrPX6Ktl9BiqyRQPnxV72drJI1f464x8ro1rCHXSGg6i9/EAz/Q+pEwy9KlNw
	 AWzqEViebdopzw3FacKzxn5g1kaYDFeaFIkN5dShS84Kkfb3DciWDjtGHTOsf73WqUQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788423462;
	bh=BJoVPykgyU95lNOsohc8UczZKGo40zeKV5onL9l4SHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PIifjWQDMrO4OaHJTBGYLgLzjUdGnhlvbRauiqVx09QZn0CLhDzBe8PP8E4DO9MRt
	 bcdSJmqsGyDQsSvsVMWjjJ1UDDuK2u88fWI6pZlKIAT8MoIA3lLPCe3lG8Ud7glzQW
	 ThkmQJ354oSR/2FubGoHjhFJkq3qyASAqD29P0T7pTc1n3fM3/ayS4pl3bljhuRGv0
	 vbeeC3Ar6JjRnVqHHjhi7XY9J9bGbemDVCZUWI0TZTPXFdp1/CR/yaTe657qIl28Ya
	 XWOCgalVaaWus+I0EyfPCmIvWU5AvrfJAfwxirIQ5oQ/Vi+DueSkiiiIdGH2zHcDdJ
	 s2cjKZEw+YwyA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 518CD60B0D;
	Thu,  3 Sep 2026 08:17:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id ADBA822F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 93B6340A99
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IN4SvmOaxyXm for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 08:17:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A2273406E6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788423442;
 b=D48dCq10Ca/qPjACe93CUvk8sWrDk6vjVN6DcksnDS3fTH4v2nnflomvE613z1TDRynC
 so7qt1q08/9kOzrhP2bfjFGLZrPtlkSQnfeDSB65g7hsOFITGaoMXrCrnrOSjzStr596I
 QnJKjz+hs6z+ifw5L5umX2WVNWiTr8mRUidzk4j/6vrMwez4NQWhYOoNLOEh/ASbCVkb0
 qKHr+/Cz7+JLs5nxL4TQY7wGvwgq8xXC8HGvA00L3UuGHVYlCnX5NB3Jms+pcMrvtRgQF
 jMTr9Ib2LFMWfWwQeDtch43WyrivG/zhV5ot+F2z/q+vLyeAiBnWL/HakfPEGSwlouw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788423442;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
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
 bh=BJoVPykgyU95lNOsohc8UczZKGo40zeKV5onL9l4SHQ=;
 b=crWKYrr/rLxX4QSmmtoqzPb0/55ZyfqzKqRxEqhAPR2xwGSRG4REx8IS9jg9d11SuUbS
 WhjBxVqll5Bm+2OfuJZemY08SskFwnJ5jXXbDXJRx3V1Aq0yoqDHmqqrLoZZ/djChsqjm
 vCMctvLEcG1iNCnrG3MCpkBbv49jhdlcth0Ic3T8H190u1v4Sh1zPfwnqP5WFkjfO0FqQ
 91mB7v8vBapolvBOAuMIEmlEtSfHm7Ox09vA8nENkPrrf+Ii8xjeHmi7akGvMVIxdLUEh
 Le4Q4/h5+7fEM2Y9WsiS9SYCLejIu957BGHaPlXeUiJTS9FDuGewHTgkknFZXw9nGKA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=jlPrrJsI; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=jlPrrJsI
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A2273406E6
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 08:17:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AjICB22OoClemp7htmRyY8gVyb2Bq3wpH5+tm9itZ7cFDiB9nLjSiqnM+/tvkaLUtfwuUeDfwyfJxZeJ3prktdKqeLJDGTv5yC/52Ka1kVqkAEnpvpFBRVVKsh6KFBRNq7IG2HBL02BsmsTpP3WfjfjPc+uH1HKowHh7OybMeSfGrnsVVdA6ss1sAG32ycBFxxUFLdIcwZRy8GKAj9QAWDfcwSnZasvrOZtvMlOkeNMsheHZ4PcltouCIOCUr/yq093+howkGsEUXZ3dyvQvBwPJ/kTNYxzoKb8rHnH1OoN3wwEnLW7q0SHzJINGg2M1hqybiXOY5J9oBu2hwV82aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJoVPykgyU95lNOsohc8UczZKGo40zeKV5onL9l4SHQ=;
 b=hNAyCu6UmkgxylsvrykhUmcraJe0O905skldcozqI7OO+TPW+02WvQ9UI2naAQFpF9BrupoCKSCQO0BIb6brvWCfmXZOqN7a9x4y20mqDEvi1YeZC4oWcd8PX7DOBTYsJeagQj4UTBsYeVZWZoydB/kfvDEF3pDV+AuDU2t8tZ9sUF3xvih+n754pe0y6zPyfUpgNcSrNy7faxI6QvjHGafpm7PDKsSQWlyp7l9Mm0/XdUpD/bIr4WIUmUPfWwAyEUcpnO7ltfv2p+M2X8Sq2sHu0yh8wO05zc1SLDqPIWnHCAu1dIcV4zqbSPKDjfV9cGWTBWbljbRenu/g+t5L+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJoVPykgyU95lNOsohc8UczZKGo40zeKV5onL9l4SHQ=;
 b=jlPrrJsIKtFRQAssRDH3WbbWOYKl/xOv4LkmfMunzePHBoPJg6rC6Z4mSBjE6y5vFjWQYjgSRMpthgL9W5b1959CA+LCIsedGiRZ5mLG8CvQ7EkDnI7NI9P+QEaN7O/4l/rUbuDRFlyTdnAvwGJszNfSPL9zSm7CPr4sPJG9U86z1lJwgB8kB3lEayao47LLvr1vffx4fE9rSnYwXMmZv0jv8AY8MLWJOHOqAN4aCtUzoTdf8FDwNVnxXt0SPhn051qcAe87r16928R17L/ylbHx5OYul+/IU9iIotbhH55AVgwebGrBA1XXO4pWOicNfrnWazqTbDkbyaNw+xZ5Vg==
Received: from MR1P264CA0216.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:56::14)
 by PA0P264MB7443.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:575::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 08:17:17 +0000
Received: from MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56:cafe::58) by MR1P264CA0216.outlook.office365.com
 (2603:10a6:501:56::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 08:17:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 MR1PEPF00000D59.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 08:17:17 +0000
Received: from sah1lpt726.softathome.com (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 3A8D1202C1;
 Thu,  3 Sep 2026 10:17:17 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v9 12/15] boot: pre-load: add support of ecdsa
Date: Thu,  3 Sep 2026 10:17:02 +0200
Message-ID: <20260903081705.12894-13-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260903081705.12894-1-philippe.reynes@softathome.com>
References: <20260903081705.12894-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MR1PEPF00000D59:EE_|PA0P264MB7443:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6946a371-f6b7-484c-42c1-08df0993c4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Mdah2qh4SJM2kBvKv/hml86ZDKG71BgfCTauSMF9FaBFwUby9CfQuhpG0S4kq6k5Wng2SGGTMoc2TjiOvmZElxDmd/gCW9vdb0uagZ1M8SV/2Qrf4nxjWhcC5ciWx9u0z8UpqVSyVRAjEnemrZd3mUGUj5DrZC7xkHVWZhJmLuZfYxDI099SGp/pLZYLbO5/kFmhLoUo4NzIrS7hoCLa84FkEg61HXGIXnF6cm2HT2nFocm0guELORi771ULB5FMdAnkoaUe3ipXen57IkBVYUGyeuY+6jGVDFDvU8lxW2FgUVfRLhDTf1JbUJBo1BiAm7t1d06fSeK0Lwkalk66DHP1m0ouT3ieayB+qkvvOhS4KuH3fWYzLSTd6DT5d56vr7BXxOtDTPBJqe81TjzfuvNgb8U5n+XDLAho7pHAIKplkbgX7cVdDZxILS4wR7UUR0qWKMwri7YLkyML1sOZc5/RqzSePf69o27M3yebboMhLvuAEnafLCkOe9eTG0rTtjZ/UHeHC12ONeaYvLrixwlVZmxwDRYPSMINL/djQHthoIHaDtjr2tv+Q89+HvyxH+cxc3C2Qzfb7yUOtcbYWqSSOnbqwexcCoZIcHiLPVh6Vb1vBgZg5qYA/waKT4CKk3J8jGNua8wxEzNoGr8KTugDkOltmWCgbmIskd2lDiy0GvPXp5c2pxI7e8sUkyMhxKq2Q74a9XQ2dzIDkiPkDw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YV6IwCVJQVI7VAuthQl25X+QrTuwzSW/BADfybLcF8UefJmJfvGueXUf/05virQvY2nCkj5RU+Re+vPosJSG7PSDGvBit0n0pqYou0tg+Csyw50np1tlSQ+66Or/9aOUxfX8pizDBbEvqc5MI94tRVGqwzVhBP/6V/cmuUdc0ozGiB1zbqK8/xNjgWl92+ElzhajfEF9KrqSyxjGBhbfBCBgZR6MzFermSKZFW6qG55NKV5Vh9FenLT034eABHIlnmglsj+wG85/Cs9NWcYid5DvTykMp5PiXMMmcJA4jRcAj9hR0wxYCRG/7fwPBqlytU9WZK4r+PfPznFjUQGc/iLm6gL0rubA5wTNEr7nBoc6DfEaAXo6sSAwLm3xdEqM6VyHc2/sXm2iXlBlFvOq5zJyoaxq7Qyq+piShhpFqmbUf362qV6xg6ksaKuxyhq0
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 08:17:17.4625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6946a371-f6b7-484c-42c1-08df0993c4ba
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: MR1PEPF00000D59.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA0P264MB7443
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

Right now, u-boot can only boot image with a
pre-load header with rsa. We add the support
of ecdsa.

Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v3:
- initial version
v4:
- avoid calling image_get_crypto_algo several times
v5:
- simplify the function is_ecdsa
- re-use already computed crypto in function image_pre_load_sig_setup
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- no change

 boot/image-pre-load.c | 53 +++++++++++++++++++++++++++++++++----------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/boot/image-pre-load.c b/boot/image-pre-load.c
index 2f851ebb28c..af72ea6d547 100644
--- a/boot/image-pre-load.c
+++ b/boot/image-pre-load.c
@@ -70,6 +70,12 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	return 0;
 }
 #else
+
+static int is_ecdsa(struct crypto_algo *crypto)
+{
+	return crypto && !strncmp(crypto->name, "ecdsa", 5);
+}
+
 /*
  * This function gathers information about the signature check
  * that could be done before launching the image.
@@ -86,6 +92,7 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	int key_len;
 	int node, ret = 0;
 	char *sig_info_path = NULL;
+	struct crypto_algo *crypto;
 
 	if (!info) {
 		log_err("ERROR: info is NULL for image pre-load sig check\n");
@@ -114,11 +121,24 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	padding_name = fdt_getprop(gd_fdt_blob(), node,
-				   IMAGE_PRE_LOAD_PROP_PADDING_NAME, NULL);
-	if (!padding_name) {
-		log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
-		padding_name = "pkcs-1.5";
+	crypto = image_get_crypto_algo(algo_name);
+	if (!crypto) {
+		printf("ERROR: can't find a valid crypto algo from %s\n",
+		       (char *)algo_name);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (is_ecdsa(crypto)) {
+		padding_name = NULL;
+	} else {
+		padding_name = fdt_getprop(gd_fdt_blob(), node,
+					   IMAGE_PRE_LOAD_PROP_PADDING_NAME,
+					   NULL);
+		if (!padding_name) {
+			log_info("INFO: no padding_name provided, so using pkcs-1.5\n");
+			padding_name = "pkcs-1.5";
+		}
 	}
 
 	sig_size = fdt_getprop(gd_fdt_blob(), node,
@@ -129,12 +149,17 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 		goto out;
 	}
 
-	key = fdt_getprop(gd_fdt_blob(), node,
-			  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
-	if (!key) {
-		log_err("ERROR: no key for image pre-load sig check\n");
-		ret = -EINVAL;
-		goto out;
+	if (is_ecdsa(crypto)) {
+		key = NULL;
+		key_len = 0;
+	} else {
+		key = fdt_getprop(gd_fdt_blob(), node,
+				  IMAGE_PRE_LOAD_PROP_PUBLIC_KEY, &key_len);
+		if (!key) {
+			log_err("ERROR: no key for image pre-load sig check\n");
+			ret = -EINVAL;
+			goto out;
+		}
 	}
 
 	info->algo_name		= (char *)algo_name;
@@ -152,9 +177,13 @@ static int image_pre_load_sig_setup(struct image_sig_info *info)
 	info->sig_info.name     = info->algo_name;
 	info->sig_info.padding  = image_get_padding_algo(info->padding_name);
 	info->sig_info.checksum = image_get_checksum_algo(info->sig_info.name);
-	info->sig_info.crypto   = image_get_crypto_algo(info->sig_info.name);
+	info->sig_info.crypto   = crypto;
 	info->sig_info.key      = info->key;
 	info->sig_info.keylen   = info->key_len;
+	if (is_ecdsa(crypto)) {
+		info->sig_info.required_keynode = node;
+		info->sig_info.fdt_blob = gd_fdt_blob();
+	}
 
  out:
 	return ret;
-- 
2.43.0

