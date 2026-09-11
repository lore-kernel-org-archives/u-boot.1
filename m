Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA716C88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 887B640820;
	Fri, 11 Sep 2026 13:18:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v8cfOpSxuWSC; Fri, 11 Sep 2026 13:18:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org A151540812
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789132724;
	b=oDeSdUtUTsE1UT0xkVsSKwQwPJ+BsQ0RKu8mLspzn103MeP/XWAu4yJqMiepjf07jr0X
	 MSaxv5RZXMJM8czdpR9k4tpkLcyXnrZGXnZBxpi77pHCvz9jyiwLYrNyKQWZgH7hDFWJh
	 w4QcEKVzINHViWBVzlmd08+BraJE0rY7aMfCHdClLM5j9V6SF4cMY9mTZP40qTGHIC73l
	 J/A9snX2JU72lxeAtXiJzznc88zeHQ2SeJh/qEzKjxPSLFO5/VjIhXMDv7aJMjhTx2eRu
	 cbOEAAhUUR5WgzeOdWsUWxvRky8DZOgMv71CKtmnB4reRUvRyKeK8Yo/U2TnKSv8o8A==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789132724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:From:Subject:To:Cc:
	 References:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 x-checkrecipientrouted:NoDisclaimer:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
	bh=EwUMZ5uN8RlPI27jdN2ZLikAoTY48f8r+R1mSjlgBcg=;
	b=hjz1AhDtqg+yVnBVU6doJRP+QcrynwPkovqJUinRPw7/fADE1WJnPEOZWL0dhjNUcW9w
	 mNdd70zg1aFqLvalH8PrlxSHgBsOAB23bJ87YAvteDqCvwaZRwiPvEmaDkpbCIsIEfb2r
	 Jl7DuHqZwzaufZEDwmvloPk2G/tKe69wCZ8Ia4ufPf/bDD/zVNyZcg4l0iupVm45u5wiL
	 ST9RKGOWjA5hP4qIpvaXvcGYC9DbRTiRrrxQy4fcokB+0qG9jcz+ERbgokjMsmgRNlFkH
	 62/u7LhfiArk8qkduduthNido6GDYtQxGw1bVSuFD4N6zGim77Fje8FmNuvaU+jqzJw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789132724;
	bh=EwUMZ5uN8RlPI27jdN2ZLikAoTY48f8r+R1mSjlgBcg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gh9pvDBj8mpAynVbYEktAisImUN1e7W8FcCpYpS1lL6JHnsroTzlOchM32z4/qxrs
	 tV0X4Sac51yb06qjXd3Lh4pXusd3gsOdml+quFchAKcYGqRjOrmRVBpCJXFxB1eQPw
	 cbQDhPyfDLDraOPfJdNS+WgX3v48RdEfD+KwmMk7l9r/7oWKOfGzHTmkcFnXNV4flT
	 yCNg18CRMb3MXT+7X/NTeOvRKYlZ2XWfrPq4xT8WJOWaHHRznnzY/PdUrNQYx5NxDS
	 s7MlH2dOfp6eAaj+gPHi+5U23tyLkdd539GNy9GVBo88eraHlMjgFUNqwmq0ztBLux
	 JpkhJTCHo1F+Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A151540812;
	Fri, 11 Sep 2026 13:18:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6DCD61EA0
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4F04740480
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rYI1WSJ5da0E for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:18:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 6D8B0401DA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789132722;
 b=FAgehDFmQCCGenUlUw5rpbIms4OPmieHiGnEImfDgo9my91hCFkuNWT0pLViH/5kUgJZ
 s6ey0dvp4hbtC+Ku2VQikoZvFTMFjHVX3G7TM/xth7O/1oqtBxA9jyz+Erf/sOfecWB4M
 M3uin1wJdSZ4r90rk/Ks0r9cxty0V5lt2PrOs4iTf43xFrY3xo4iF1hTaGo4DULo6os9Y
 yXPNX7JcCTo3qj7/3gdYODt93CE+gLekYpffUPlEFjSloqEjE8nlNHdKzhLb1X15lbMz7
 ht2WjLzvmNCEAGeiXHhqlTFeeylYP02vEg6SyuQ1yfuRSHfq1rG7YcFnayAYe7mp4qA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789132722;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:From:Subject:To:Cc:References:
 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
 X-Microsoft-Antispam-Untrusted:
 X-Microsoft-Antispam-Message-Info-Original:
 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
 X-EOPAttributedMessage:
 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
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
 bh=EwUMZ5uN8RlPI27jdN2ZLikAoTY48f8r+R1mSjlgBcg=;
 b=D3KV6LCc9Nx2FCbtP7+pbIpdUEgMR+BZ6RkF7fj6GiqM2CnRu4NacYWWs2BNXuwX3z9b
 cqOtTBKIltd2s13674J7ea1SjElY0DvM7NC/BK3B0fimRR4oWsQ8mh2n6f24Xao+kEi4N
 4zuMv7HldvH7dkpTQ1nQZVS+ivOqb8SPK74c3dzwLdU1as/gwQL5N5wWSZ/iIYP9UUGfQ
 uqHOoXtpsCAprE/Q2R4NGmp5datzST47OcBzewDRaaitLnt7l3H09rzhN3zD1YMcTTMbR
 uZ/sgh66XYJfnZbHZkboOrqgbMkw+iXAf3NcjA5DZIZkojSZdQ8RaVkiEmQx4q5xqig==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=V0RisTWv; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=V0RisTWv; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=V0RisTWv; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=V0RisTWv
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6D8B0401DA
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:41 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Z3ghahiEe40WXb0m5NVeZA9tJ341eaIYtrc/uHZI9+ENm/ZBTn5SQeOPsvQvq9Z9UV6eexPOxzf+m3+HLNAl964Tkh/yV/Q9Dzkzr6+gaRhYA/EaYxhKiQlUSE2DyJ7w5RmpWtGt3Rdecz1dSMd2r35d0taYt5Fh1QaF5SyCSSbTNmH1QOO1fudrhNqBAxVtr+5VT6oU1XvWWZB51bE5YoZlKdqOPFHvYkfu6jnPt89koWLFMCitdKzQn9/vj3glQKm1s1T4B3bopXKTmY07M+thsWfNO2sFDwKNPiq89X22kTwlNIiIMiUvU4yN+nbqKcxpQhzdUrGUevuyUpRjRg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwUMZ5uN8RlPI27jdN2ZLikAoTY48f8r+R1mSjlgBcg=;
 b=dliUn6DOr6zVo2nkDgV3e6hj9uovpkk+O/P3Vuv6Sm6FF6hi4S4hoj7rTTggzitPJCwBn7iPGd9g2n6oSqvfnlZezhSwu8+RQlmU9VYiKs0rEIzOMU2BVEw8083bRDi7IDGLtJlKBDGvFIKmr8Y8fQ727BnrhSE0WLixSkQYfzgVU8h66WzByOQIl8ckth5Yg/O0NsgUPwHbu8r1b4RHRz+S9Qy2J2KjvlZqR4rZuy6SM0MKGnbART640M88s7XF2jD6sdOyDaNq4kphIeBACf5Izodb/QHroQl4g1zLTgJcAFwF8THpxowAfxPPc+5BlsVOpbKcqMT1JuM6oMlr0g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwUMZ5uN8RlPI27jdN2ZLikAoTY48f8r+R1mSjlgBcg=;
 b=V0RisTWvOUPhjOBvAKs7AERK6hJJ5Oc+eSw5AIpjXf27O8RaPG18F5ZQZCmygN2IKh5fCWW3+XwrmzrO7nP2bxtg8dLR0wiX60EGfmJZCeHmi0O26GJpg6KG/ea2zJvj6favvldjxpvGWwtvJsySaRBpTc0jy79AbgN202RRvR4=
Received: from AS9PR06CA0369.eurprd06.prod.outlook.com (2603:10a6:20b:460::21)
 by PA4PR08MB5998.eurprd08.prod.outlook.com (2603:10a6:102:e9::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:18:34 +0000
Received: from AMS0EPF0000056A.eurprd02.prod.outlook.com
 (2603:10a6:20b:460:cafe::4d) by AS9PR06CA0369.outlook.office365.com
 (2603:10a6:20b:460::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF0000056A.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bnTgGM/jl+7QimlDBK601CXxbC+nKzouNIoLmh8iedm+wG5YetrhauHFZIizIu4Xqiu60pf3ZjNTSiHAx4UfWM0uSLfOdYjdNqXjWth9u4uw2jshYbjWa9RkLmcO3pudJVMbKzhBpFksJFshzH+oNPqwE0QBIP+xSYNjR7UVe8O9Mtt6NAUZ0MBLxxJBu0X0yFIyisFMwSTKFwU/NP+7jnaOJTxuLjCCJYmrPKUEXT0iNQwkoPDH8mNIb1/aYsF2lsn1bDyV9aRGmV2pylvKodbvetvpXitqV9xgzAXtN4j5k/k5Hk1VdeJYyrcakeTbiiFp7PApPUV8bWGnjz9E/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwUMZ5uN8RlPI27jdN2ZLikAoTY48f8r+R1mSjlgBcg=;
 b=TTnM/TLWmATLPD4ltSOgKtUfOYkRcdOTTaZWyHkvO5vzGdtsnhz5lSDBK2wPsg0I6XR2tix76iKKLtZbuvdH7ala9yiEOd2Eo51Edi96wefP4CHTEwC139lBeMiSU+EU2c91dL1hv+hlqM+LUpZnefkUwc4iFWXu7kZY8f4FmuGCJ+28d96HrHNRivS5uuGAMC5Sb5VCvL8RLDNU9KOfuHznTdJREWY14qtH0YgcMt8kWxjIR5bD8vXAe2qZOkBXvPRiCM2/jWdIbEK6L9uJAPd8deHPmH2mZtDsftXjQauwT3B/Cd1t6iaDV4BqlHosIJ6cI2+Jqt3a+zRkkWTsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwUMZ5uN8RlPI27jdN2ZLikAoTY48f8r+R1mSjlgBcg=;
 b=V0RisTWvOUPhjOBvAKs7AERK6hJJ5Oc+eSw5AIpjXf27O8RaPG18F5ZQZCmygN2IKh5fCWW3+XwrmzrO7nP2bxtg8dLR0wiX60EGfmJZCeHmi0O26GJpg6KG/ea2zJvj6favvldjxpvGWwtvJsySaRBpTc0jy79AbgN202RRvR4=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PA6PR08MB11584.eurprd08.prod.outlook.com
 (2603:10a6:102:524::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:17:57 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:17:57 +0000
Message-ID: <a353b63a-83e1-4147-b0c7-dc51e6bf454b@arm.com>
Date: Fri, 11 Sep 2026 15:17:56 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH v2] net: sandbox: support raw Ethernet with lwIP
To: u-boot@lists.u-boot-project.org, James Hilliard <james.hilliard1@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Johan Jonker <jbx6244@gmail.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 David Lechner <dlechner@baylibre.com>, nd <nd@arm.com>
References: <20260903-submit-lwip-sandbox-raw-v1-v2-1-206bb597fb4e@gmail.com>
Content-Language: en-US
In-Reply-To: <20260903-submit-lwip-sandbox-raw-v1-v2-1-206bb597fb4e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PA6PR08MB11584:EE_|AMS0EPF0000056A:EE_|PA4PR08MB5998:EE_
X-MS-Office365-Filtering-Correlation-Id: 881f4ebf-38ec-4d54-2942-08df10072e51
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info-Original: Ppdokq5ZYG+sYWnktQqfP1ho5pjpIF5CiDQgG1kgJe0l572++CwLdm1GV3fTNe9aqspuxz8O4nG/euVVRqzrwVkgN17czu+TOthRYMI/kgWH0y2mZKNQk1LXWIN5lgwD89nbf0PAnmYLWS93N3M8Sf0LmQZLc2fbjhtHpaozkQ7MDy2XNcuGx4sXo9eLRdKxuvAIgzwvcD4tq0d9Amc+tZdOMJUdblifUblR0FtcBbot+aJzASfhsjAWYsVuojw3pNkG6sVv2fOzQDpbo+oLLAiTmNFKnBIjeTTEhJz429D2cWXSzj7LB/29NwDlXs4gJ0DKV++FOyLmR7Dw68xF0g3MddvNy1gxJ68A2sAx2B5OyHxfWzp8m0UUWyV9kdS1hKmhVP2tIGhm1PaLtRkbSqvko0VrbPnhPFbs/NFRVgD+C+K9kocqxfg7Fib5l9C3dpyAhVyuDCMRIB5cOQpCC4mPM0eaqFiDQWg6640A9xRm2GZVpVLNxs8oWIqlgT8zIYuXsxFxMxsPguU8IXqrOjvCfh5qK8zeddgrNvR7SMFc7XRgCwlWCV5ludd3nK6XxoYkVAVp99uZFASMpx/8gbcWjZ28zB7RHFLfff10Nw7imJqFvalCUZgJ06bIsrV4zcLqUDtp7Hir8MgffM+odeUHP7D3bLjDGCIeU3LLcMk=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: iItUghyW4FqE3TKcFcM4z/0loeVBgNpPaiarLb/MRwaaP9KpcDFwBPzpC5yLMvFXHtJrqNdmOeQsHNYYvahiQqhqYgbwdqgEk9LCMPGjFSUo9bzbByY3I1NkqnxLN9Zo2l7QeXdqsAOmtAF/Ox7vb4a9ykdg2xxUUr7w8G0SduG4Z8j2wVNvOvUUx1Be/hZ+KQmclQMccs4Of3Rnn0sG3TYS6TePRvC1aKODUNUgBHDZKsMrIqhE0qBogexNuC74iW51zo8EporeeMLDkHhSh0AH46QMRiB4wRW4qSJQPN8Kct4PZWTz5VwHGyO+3GA106PSaAbWIQA3biEZWYYaWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB11584
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF0000056A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: fa118219-fb62-4a0e-634c-08df1007189b
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|14060799003|36860700016|23010399003|1800799024|376014|18002099003|22082099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: nUPh0BBLQpgSNOHb6pqsuN3xf9gY8ws4gmNH0nK1f45hkldKZuc//XhhwkvCH0ZDI/31vgXdt0jebnu7zZLoybhjXVYzs3NZiO5yDpW6a81gD2mRIEE9eKlrVkDoD3OVKISHWh+HfUD+KjzAOx3f+pQMTAUMKrHK/eyh+12necWwNLmJHJSyCmKyeV5qw3SqrGkPYpwmjxqpNSlUz8wAHSU7lRfAjx8eGJ3Qt5VmGuPre1HL6NsAmyT7KxZ961kzQeVACg+TUah2fND0UTUxnk3QqPlaHk1/y0jQQsUOxigFgGjKrRwAcZYgfxfkkAd6ltXwf5nNss4ynURfuOT9yiO0+JJgthHIyr6OYKeRfbo5K9+cqYsR6HtgrxsuyVV+pxzsHppDqxvHszEm8RhzPsB4egfawJCOPNs/ZrrbcIVLWiTCI/cj1H7ffqRxVaI3THwSzRn4aStYmFns5F+YlRlaJPrltvLqZuIUXvi7oRNccdi6vd+vQVmqOIV9vVX+KOSH+aFoG6fW2oIfVLp7C5P62xlksGoNB7tZPAvEHFiEmrmud+KSZxSr4K+9RyI7M19v77ziGwkbObpxSmYXeDQA8OegdAGL5mKmJUMdCrPiGyB7eU3l/qGLGdusLPKVZy9DrBNlCINsaXEvjZ/jeSyn+Au3JfMzirud0v3lKgaX7TojpChflZJloor5Yaa/jc1svdKlDV9cNB1eeynjWQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(14060799003)(36860700016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jkbs7fHpVI9T+9JLdjN4oXOZ4LTYGCXdUl6KEet8o/zZ6wRSQa6a7XlyIykuexPkYg0GJ/esr3uYqx3zcSs4EAXI96wjUq/YyUW+bgF5SdckudWl+Xu2oID/YGtUCLyK7T5fiKKolTPyRNVX1lN24zQC7FY5IsXX0hscf9czyV0rgrJaDu4TA2cYnCul86rccDXoiBAIFWzOGCOQSjGPANQ1Dhf4iCWigqprcT/rXgmrVKbJysEPgRClV1IucJbl8ipNGIlW/eLLquPBApADscXVzuYYoYgNwPTgDbYHiFgMmRjNzDy2wB5n/q2al1SxHXHBQ7ua/8WHjkmMP/pDGEyCD9JF93CnhHBiBB+ujjryWk8NSJv3F5MAjvMD0yQ0nHNUQHWFpXo9ilaCFqnPap20bHuhJldd2TDcvfh4pfu8XrqS5qiXKjnsmlTl1KMn
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:18:33.6836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 881f4ebf-38ec-4d54-2942-08df10072e51
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000056A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5998
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

On Thu, 03 Sep 2026 11:09:25 -0600, James Hilliard wrote:
> ETH_SANDBOX_RAW is restricted to NET_LEGACY despite operating through
> the common Ethernet driver API.
> 
> Make the localhost shim stack-neutral: define the ARP layout locally,
> populate lwIP's per-device ipaddr environment variable, and retain the
> legacy address state when that stack is selected.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[1/1] net: sandbox: support raw Ethernet with lwIP
      commit: 1907207f9a67b59009a3e54dde03b9f268a91a02

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

