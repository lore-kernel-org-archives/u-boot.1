Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CF6C982D0
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 09:37:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54BF260857;
	Thu, 17 Sep 2026 09:37:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IuCA4Q8B5I-V; Thu, 17 Sep 2026 09:37:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 939EA60841
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789637863;
	b=a2YGNcBtPJ6rWntS3DB+3BhOXrRdnlPF5f6iuwwBgu34Oauaohg8Jri3fYEadXzhSKB2
	 UzrapffcTGPGuRf0Z77pKmNMAJ6h4gNBh6YD88sRYHdbotwdCRRRqFmb8tqflkWU2CfE2
	 u2ctjjckCi1f2aF4t5fbBygksZ5IGtJrCnFBHQ9LQUPkEyGnHLAOYaawof4YQ9Pe/Imk+
	 08aSv7fpygPCtHZH5xkAs5eDYCnj4rrdourNF9YeGY2VYzU/LlFAmhQG3XKLQB/PZ9xJh
	 VTV4Y/E42Tf3peLuadLxfVUOIHWhboHj4FO0PiwFRXb3OTOyg974w9FpYGBpfcju7NA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789637863;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=OhRVu46RT2jyf46jZyKBrzDTchKCh7hrLFYcf6KAwZY=;
	b=O46OjGxNsI1WzCuSe+HvTZg1zX5nD4kr8wpWaeT5SjRJn1YLft65T0mZciaspEu1oRsT
	 KZFn/k3fOaom9npSenbgeYqkfGAJ7Kf61wSfDQ7YiJ+c21Sgr+YOLq0TmPwSXKiqbaruU
	 JbGbLH/YrN5lDus/5wy8g3Xl8SwJrSpIXhwjBFnf8QlRtncwe9g9RveYS2bYPmo5i1huy
	 SxcuIV2YSkqo2Bjkh3Lt7zIbo9VHDDU7JOAIdlB5NIJm/mfqM69E54m7128Ec46IP2DqB
	 CuTkCyjwbafisuyxOGHafmvMppsM7gHvPC6AAl346on7Jn70L+qwOqnjN09Snw61W0Q==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789637863;
	bh=OhRVu46RT2jyf46jZyKBrzDTchKCh7hrLFYcf6KAwZY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JLQUaEvz+VBdCzGMw4Ei2u2NrnR1qlP8kwK/8Rthf9GWIwL6PSCuGyexhByF/O6rK
	 apydo2Q4URJcT5SNkBNb/mGZoHyxWaBrHf08vdcWy/AKQqTdVQE5+WaSPu1WgvQ6bm
	 cUu2kAGgvZAcWylQeKre8ddWLV524KuilAtwPRS67etqgb2mcYOw9HRJo1ldoekuML
	 XZLLQLE/YzGLEuwYKCsGYZRK7O67qPVqgQTR7ajm6wmsi2AF8AEbGYim7aDqxntZca
	 z+tVkKJkXXjhI8W3hBHlech2kPR7mZxe6OXjFEcNZNchJ+cKTYifbtZU4unwt08dMp
	 /kp4ax6V8JIlQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 939EA60841;
	Thu, 17 Sep 2026 09:37:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 23DE4422
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0831080C98
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:37:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jhd_1IrFliJ3 for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 09:37:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BB3DD807E6
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789637861;
 b=KaCX80+cSX7FzNi6g0gKhw0/r/qqGshoy9JDpZ4mG/TuAnHf/xu+9OyRH2EORlcmGdaM
 P3WX+8EotjcjZr6/BOoPr0fKGLkom5F2NPz+buMq3sw4ijdm0SnTzZqDT+Ny1Z0jQJtb9
 Lh2BxvxFLXUB6kgeosn2+EbL3MJrnN4EexGfVoo8MV+/Dq9EHDKcNccBhnRLCBNMdRpQf
 R2G+0RtGY2ZeiN8xwrMTUNf+4ZJCNyQLVq1pCdwHuK01U6CtNpAK3Fk+AfLfwR7jMyQFj
 tdL/OaMPYC2e8lyq2AVyb6H8uMGgJit15IeOhNzX5z6891WRt0BQ1aeQd2eNacm5PwA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789637861;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=OhRVu46RT2jyf46jZyKBrzDTchKCh7hrLFYcf6KAwZY=;
 b=Yvg82HLDE+X1NPgEKzEw4tNY9RaxPFtdLm78VRKxkBkP5eXIU2tceYbHFm3QY/7Hq/8g
 O+c/TojNjvFz4992W36SYjjeGP65ZA7bBO4wpRp1jqJMVqx9CMENEA9afeMxDyABXKJu0
 KTOP8QkeGe4bpoQY+JWuOyazxj7jRQuaZN0MfJw04jyUlVw+10pn/q8iAXAPqHabqiksc
 MHmFdFB4HBFdl3f4rfgAbv2eND0L9ReG7ZiyjPWa8+N11TUI3JbN9uYFfgR92TvB1bPxf
 tswr+QXi3Rsj75i8XSXotpQGZlx8vWnKy8/y7b3wYt8A5/qLp/2dq9s9MRtqRjOr2gw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=KIijATZW; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=patrick.delaunay@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=KIijATZW
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB3DD807E6
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 09:37:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qLrmpnG1Jt9+PEqyojl/jDb111lOM0IyvTxLs4wRxISqP/EdoIJCVN50SJDrp733tkr4IPLTVc5S5kDRTOrD71wwk/CsSm8bA97EhXM2T3aEg6Pw9m1Hx9Y49AEPHu0q/0nIU7Ck5peChaBwX9fPNKcJzVyCLQhzVSQIoyXYs61ZT3o31mrQaAL5ChQhEfO4VgYMMOQtYDgwztcy8DdfFiBFHZHkfq1jEneDcDRsfx+evcmYJdGXbhwhn14dcV0bpr16IVAs86AqdhTynQqgs/pm4slL4mDeHAEdSwjlV5U+Zx2EwXlBBkeiHy4rDQRcPMV55YWWuZ3+m0vvVflZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhRVu46RT2jyf46jZyKBrzDTchKCh7hrLFYcf6KAwZY=;
 b=q4mOPujv9aH2iVeyf23FVF2696eJ0G1J12rmX/QjNzSUpJUb8s2e0TmMMdHWJaEY0R2Yw/tkrfK0OQXCvb6TOxpD5t5O/xKvrbMwTwFypEUtc9OajWxSgiqPkWsvJaMDUIqJvMneY9RqV00AMRrQEDjFUuEiND8skMhvY3+s6KXSbXTi3a8JCBi8BTvcvBzJasj/SuXWsK6zrmB4HrdhGI7zn6UTlFJ3AmT3MSHhaf4VlkACvJJzTzn2CtzkOBBuWDfyRoEKQDNcReAZra6LsDXSmFvPEjS3slt3bwkRoO/m2PN5/BKht+NqcBHK2CrIW2bqeNBwo0pcsO+40c2zrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhRVu46RT2jyf46jZyKBrzDTchKCh7hrLFYcf6KAwZY=;
 b=KIijATZWkJUAchvzR2H4m5RCTfA8BXCCbr5DCoBWpyBZnRsQMjlXrbf5QaRvDQFUDVhsV9xUNe3uRaEPBI87q1MLb/Ew0mRDntBn5ke3PRkgDGfYbFhe/tjAJtkTxRGDbcP+OLn3aFq3lg1QaNnMi6y9qIIVbUa13/dbYk4IOuDMR95+U2rjLHQysTCVjT6Cttrfg6DnUa1Ch7cZWpR2rIWBrZxhvUi+8rzYXz29wa6huPV/As5GLDfmaaMgYqrDlWoJX2jN82FcU+xV3oQooECO67v1lPJbiZFba86zvSOoMXG5xGeSUeKwySHqfTWE4lTqPATEOXiXrVc4VGLgQA==
Received: from AM8P189CA0008.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::13)
 by GVXPR10MB071129.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3a7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.14; Thu, 17 Sep
 2026 09:37:32 +0000
Received: from DB5PEPF00014B90.eurprd02.prod.outlook.com
 (2603:10a6:20b:218:cafe::8e) by AM8P189CA0008.outlook.office365.com
 (2603:10a6:20b:218::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Thu,
 17 Sep 2026 09:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DB5PEPF00014B90.mail.protection.outlook.com (10.167.8.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 17 Sep 2026 09:37:32 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 11:43:03 +0200
Received: from [10.48.87.100] (10.48.87.100) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Thu, 17 Sep
 2026 11:37:31 +0200
Message-ID: <bd14f3f7-3841-4b99-900d-e9b5e696eeb8@foss.st.com>
Date: Thu, 17 Sep 2026 11:37:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: dts: Add bootph-all in ltdc node for
 sqtm32mp235f-dk-u-boot
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 <uboot-stm32@st-md-mailman.stormreply.com>, <u-boot@lists.u-boot-project.org>
CC: Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>
References: <20260904-upstream_fixes_for_v2026-10-v1-0-f8b96c35004d@foss.st.com>
 <20260904-upstream_fixes_for_v2026-10-v1-2-f8b96c35004d@foss.st.com>
Content-Language: en-US
From: Patrick DELAUNAY <patrick.delaunay@foss.st.com>
In-Reply-To: <20260904-upstream_fixes_for_v2026-10-v1-2-f8b96c35004d@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.87.100]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B90:EE_|GVXPR10MB071129:EE_
X-MS-Office365-Filtering-Correlation-Id: dc9d7693-cd3c-4e24-c0e9-08df149f4c66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|4143699003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: tafGK6RYyAnzur0MHMoZ5pYdRily3HYeKZoDVf/x2LAZKyilZYfDu7ld6hnkqlFnP/tuVZAAOAFA8qmFH9e5cj+v+F/DeL+I5grN3e2dIvSh1NK/Fj9mflWZo1FRxNAWHpPgUPs4NJwxfR9Kovg5PXM4BVrdAQ/WGq1X1dl0TH1Bf9JY1KthP65jyZiGcz+D6zzOO5rzSZl6Wb8bFnZgFtSWuUXPfPoyaoffFVOFidUlkBr6bYwMHVvkfgTWi+qnlOb+eFRwQl0irs3HtKLtsqy3FePBQmFlny0n9VdfiENC0dtEdJk2ycXWAseh/d6eYKWnRi+OPQb5+Q2AQqRJmOXfYXbE9JPQlHVg3rwGTe6JpAxGydeVDCZEQ1+L4AZh+U/2BSVjzq8/ZffpP2uJueh0f7kK8YVwlZkv4LlhxtCP0XkA/pBrAybef7pcISn10auwB06GjGtOHycrSAOchvCqRl2C45y1reb/0UjPrGKeEs64Y4jcC+ETdw4KlOCO3Ea3N0rLd/bYDCnARTK0V6SGOD0bG1fii7C+l+59y9YZQO53TFgvBS0BMRcoi56424mdBeBhV7xf8qkuCrZtgyVnmgKd0QKYmHWF9Ul2OVwloS6PoSI4//+wPz958XM52T1sS/NgYNk2qhPq/LiLpllPZcT8Ed98Mc2FcdklxqSrfSa5Hb13NWFGES1oZYjfohB5waeVrmlFYUIFyVb8sw==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: krzhMeoRpPR52HoMtF6QjXXIyj7sY2XKCsEHWEk/SIfofy5WNNvKCy9eUoTq6+caWQCwif3af7LKUcboNLPchMijcCl1TaQ74VlqlEMghY9/bujkfuiNSfZpS+RkZ6SqpwiV2dKF6Ng4vidBqm5RYULO45xO44IYv70OB50ts18BylSaUfNvqkGcbFey9CpSyikfolAbEhrRBpRB1w1RukT+qjb24k6YHA4iOFfd0h6aSrNTc0CmsROfu8MJ0gqU3gW+Ec0nIM4P5wJU6udKHtOSNF1f3ezvjGC99P+K0f9KAF4vyeFXN/70J3wFgDaCjQBz9MKnJgECjB0KXJfi5g3H8h44CCQHURazBYLL3Cm5QcxooElZwbrJ34dESRPxzdOYVfyPxJJL6N/3s4ElBj/2CPmWkvLk8RyFzmjpgl6SXP5p6sMGePjVs7h8GS0R
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 09:37:32.2897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc9d7693-cd3c-4e24-c0e9-08df149f4c66
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B90.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB071129
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

Hi,

On 9/4/26 12:09, Patrice Chotard wrote:
> Add bootph-all property in ltdc node to fix the following issue:
>
> ...
> DRAM:  2 GiB
> Video device 'display-controller@48010000' cannot allocate frame buffer memory - ensure the device is set up before relocation
> initcall_run_r(): initcall initr_dm() failed
>
> Fixes: d0a838bdc629 ("Subtree merge tag 'v7.1-dts' of dts repo [1] into dts/upstream")
>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
>   arch/arm/dts/stm32mp235f-dk-u-boot.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
> index 2b41bd29cca..16c9bc652a4 100644
> --- a/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
> +++ b/arch/arm/dts/stm32mp235f-dk-u-boot.dtsi
> @@ -19,6 +19,10 @@
>   	};
>   };
>   
> +&ltdc {
> +	bootph-all;
> +};
> +
>   &usart2 {
>   	bootph-all;
>   };
>

Reviewed-by: Patrick Delaunay <patrick.delaunay@foss.st.com>

Thanks
Patrick


