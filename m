Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76160606A31E
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=QpgCLxI5;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dh/bmf5I;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=dh/bmf5I
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 51E9B810E0;
	Wed, 21 Oct 2026 09:52:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ILXzewMx4HfI; Wed, 21 Oct 2026 09:52:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 5D008810C5
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792576322;
	b=OSEJ8LWCT8ND6axqAphAnAUn9/VWPLWd1MGBNPMljmvai82ckm0xC4ucxYxdyHEN5L1Y
	 5ugFg3PXZwbThADzXCkvVh252TWdV86AcbLLaAIhAwDcJTTJmKlwZPd7iH7orT+GYHQY2
	 k/aOtYDUd265P9wESTcDG//xfQkMnnBWBjEXIsrUMS4oaUkPXfhVeHh8O7LjeviALBNLX
	 M6asqc5fat9PHfrSq+uNxN8Sy8zWH/L0cY0Off/akiTlVQ5r5O7SVl/HTqqCATuH48FvN
	 JaFzJYPbzD5PUZ/nckoq3XAYZXtiJaJ9zywJ/+SWiJ3grc0+ER5w52g3nMarl/LggAA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792576322;
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
	bh=qLtDp7k6gXaGc8AHZ13xPzskOfjstmr2de8HIw6D2VI=;
	b=d4v6aRZWyAGz01mMZZNJDoVBLU48h6t2Y/2jOOPqlj0f1khdQVpGwaM/kDYKg1Qjt+KC
	 wKlkTg2XIIm6808vVM8vrmwGqhp8L1OanUkaWNBYDubMV9JQ3iLtcmFjsqkce1p/x5XY9
	 Fy9+jUN0d8vzBtHbIjz6e9NwK6eovwT/Pd/7JyLYGhNrTq5PPwxUiHARtrUSKgTsfzMhA
	 WlCCW/mHhHzZq1ooQUgFKYl1z16kVOky9Hep27KLrhOGsBA2iId+LR4uc5rWRjcOzq0aL
	 7PKrusk3EmKFycsBjmTqHNi9CAnU+hZuSzjIjxiQpB4W9Osg1Ogd1sBRTJ6CoVG4guw==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792576322;
	bh=qLtDp7k6gXaGc8AHZ13xPzskOfjstmr2de8HIw6D2VI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QpgCLxI5aKpuQLgd71l3yClXCzzUyWKJWrxq6pbK7+Cd+wtlsKWLAduKh2BfldIO3
	 f3domimJjg6qaoFcMoY4cR/cYVAyy6yZYRw3/cXooun/p647IJRpy2Hki7geKP3/3C
	 KBperINhTWv59Lu10Lha7BmczaYZRCv2Fqj/HsQyXrQBV8YPeKxbwwjzkBHFPUp1dy
	 aVgPojfc41Asg6X45EYFXxOEnhNT0JHuRD1Er3yq6mFxi+H6btKX7kWfGWqydpOV1T
	 mxjk7T5p9takh0Hzf+wJD/gS6bvFk/P/XKjLNnLNSA7PhVfo8cmy/ot2Z0XGYEAXyB
	 FldgFhsQXCR5g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D008810C5;
	Wed, 21 Oct 2026 09:52:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 89D763A4
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6F918606B6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z4c3_vMOhFRA for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:51:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 0776360661
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792576319;
 b=LmfFe3RhsZ8ZxqpCAgaINqG+dVN+uvyDhwTNi5knV9AQe9m8gk5FK6UeXTV2Tuotz9Xz
 e6+jtzbXzcEicofgLFuydzQaVfKxMDk+xC+sZsZ2fktFa+O2pnoVQBXtHZDxXk1Qpirnj
 BJMUEw0yyAp8SbM/QUEqemB0Ot7bV6NInuPaKJc80A1jrfcVy0QdYL367Jm2EvUh5N0OJ
 MZEnKHSYclyzJ5xsbgDFdQDzAcvWgO+CdHjw/ydIKhdfLMNzMWn517e89Kibkfb7tYXFf
 YM+ork7VLZVOtiRaaJ80ggWcxUL+7auZ8QqgFalS0aSXtGW/Pu1MxFz8RGEOWmpva9w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792576319;
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
 bh=qLtDp7k6gXaGc8AHZ13xPzskOfjstmr2de8HIw6D2VI=;
 b=MIjWpTza3BpNqw/UqpsaxpFBM8vi7LydAZW9awLoTpgPpVFD9XxwXf/vi8UrmXrMyfaE
 yvUOG/uncRPT3pOylLlpmq7cGbNlKXZOSKNKk9yCG72JPTgShMFBnRiJh/d8IWt1K6d6p
 wvKnimkb/GO75pFci0yx9LJH6UoMa2FKFZ74C3kER4tgMcAx6QpUOjHwn4s8igE58vttj
 AVkAHz/QcqHN5Uy//cTv7URHxv2mJ+7xfsCCZtCqcuzx2FKa4CVVGhMI4BGRZkrrJD17L
 3ngcFEcSt4vabQMaPXJb5clDzcnS5GPadJM4hbx8lat6t91+6QuxWMFnejanTSA/d7g==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="dh/bmf5I"; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b="dh/bmf5I"; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=dh/bmf5I; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=dh/bmf5I
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0776360661
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:58 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=C844iH7AI+o+Nc79SZXjZvwbMmeBfRpZDc5K7tMLR0v7pvZ4/b4VTQa944F+W5ncL+l4yGPmbHNYOnlZ2rmizG2ON8+US4VWMT0grccjvtJeorh+VGAgtUa1gQMTw1Q1Q+56E+Zq2v4/cGocCq3S1bh7he3ktLN1M2U9i0j68QY9vos5Qv9e2+N2Qo4jr+JZHIMWDb/c3FmxjlF4NNzHtq+8kt06X7mocI0bkmd6ClqyvnP8mI6qCh/I2rwySyBq2uc+kw2skoKeZd2FoCoVWEHLa//XilgB3V3vyVtQ2kQ3xlF0xyQ6JlUGTegZycsUxSYBXix9OcFw/nDVTroh3A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLtDp7k6gXaGc8AHZ13xPzskOfjstmr2de8HIw6D2VI=;
 b=JBLWSLPpBnZbNOcvbuw6fs2ukuD2+Y8kZAhroVsDGATEka21MmwxCDPTZcEKweKbv4k+mRva0m6mmy6Vv1S+3FXVuNiYjtvgTvt8sy8jrDx/D7sSsmXQ+92NGIQxNL37p4ZJn40/pIiiSnQV0cRCAa8G2FT0PszTN8479VrEQRTEFWUsqP3kEA2EZj8mX5DeClW+hxEIKicLXvcyErMREM2PfM2MvGcvT9DvI35WSyoffF0VoKRQbUe4KXu3sjJ+eIQPVDLdOzicDrgZ23IIs4LA1lxI0ODHSILtlYvEyHwd7/HJoGl9rxfxF1KpIKKW2ZZv3+1DuPzRiee4wXXLkA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=microchip.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLtDp7k6gXaGc8AHZ13xPzskOfjstmr2de8HIw6D2VI=;
 b=dh/bmf5ItkF+LPTDcdtpwJP76Ctn1D7zBe4EgKvEDADGdv86qIyBkcN8lPjR4JZDxac1/X1T2hI98L+Y0fYz5PoUIX6iDmJotgnYsNzHkrOAaXRZvwgwH2qV3uA+R99Hr1rspk9EeOULTd2wm0ZVyPzSBX6MRgcRAdHy/goBKkE=
Received: from DUZPR01CA0187.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::17) by AM8PR08MB6402.eurprd08.prod.outlook.com
 (2603:10a6:20b:363::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:53 +0000
Received: from MAD0EPF000008B0.eurprd04.prod.outlook.com
 (2603:10a6:10:4b6:cafe::4) by DUZPR01CA0187.outlook.office365.com
 (2603:10a6:10:4b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 09:51:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B0.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 09:51:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PjYm67XRdCykv7iqobDpI90RuyAQ9JYIOvwHWChTM3oDcnffevnBR9miF7F3EiE16JliBDfjusX/1sm8p6V5rxYU158PM39IndLH+fwVIE1PbQC6oFiiOrdn766QlJmSFjSSgYqn5J4vKOWATLqDd89V5hTXJPalNHR+1zH1FVURUsuMPbzcFgbTzu//X12ktsOCy5oXMiFFa2kHux18oOTdYYV+FtaF+ECNeD1JSDhXz8hL6wDzN+lcSGVTSF8Hx5X0xWRPzVnsfE6QJRt29jLf+KMsq7A2lrDOLslKO5I4tAR9G0v/+lPqCcIWzwkSVdFTmT5DQ6twpbYoqw8GQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qLtDp7k6gXaGc8AHZ13xPzskOfjstmr2de8HIw6D2VI=;
 b=KShpIVrP5g4tDxKLEhyAZ6VAGEl7YIg90GLgbqZM+ncQCbbPgs377x5Rv7IgrnE0j57RNTF4MoCbpQrgaLjHemJeSwjefPI5odBaU0uXoYe+fLQzF+joY8ycRrDKvospZm62qBQ7EfIleZWqj+jFFLn2CUBejcI4UrGCav4hPV+vyHzea58cVDqVr/vqQqaUJPSke7ygDb3+5AiRe8/1t9aCR2sF8Crn9DzUFj5zYIzRCZla4pm9Z++GnapL2medd2C5N4iwr7u5yhKSy2JYeZmnCxh7YS5el5AaHgcx5qE9RavrV06UJDjNy4ZurTy28jZQ/M/jD5ZtjoC6QjyYdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLtDp7k6gXaGc8AHZ13xPzskOfjstmr2de8HIw6D2VI=;
 b=dh/bmf5ItkF+LPTDcdtpwJP76Ctn1D7zBe4EgKvEDADGdv86qIyBkcN8lPjR4JZDxac1/X1T2hI98L+Y0fYz5PoUIX6iDmJotgnYsNzHkrOAaXRZvwgwH2qV3uA+R99Hr1rspk9EeOULTd2wm0ZVyPzSBX6MRgcRAdHy/goBKkE=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB9977.eurprd08.prod.outlook.com
 (2603:10a6:20b:636::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:19 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:51:19 +0000
Message-ID: <d68eec72-396a-40ec-8630-0b96784765fd@arm.com>
Date: Wed, 21 Oct 2026 11:51:19 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: mdio-pic64hpsc.c: add a driver for PIC64-HPSC/HX
 MDIO controller
To: Charles Perry <charles.perry@microchip.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Robinson <pbrobinson@gmail.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>, nd@arm.com
References: <20261016-mdio-pic64hpsc-v1-1-80210f255d18@microchip.com>
Content-Language: en-US
In-Reply-To: <20261016-mdio-pic64hpsc-v1-1-80210f255d18@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0016.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB9977:EE_|MAD0EPF000008B0:EE_|AM8PR08MB6402:EE_
X-MS-Office365-Filtering-Correlation-Id: a0a6aa84-314e-4ca7-3431-08df2f58ef2f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|18002099003|10067099003|22082099003|11063799006|260925021911599003|260925022911599003|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: dO8xIFeiYCTGRT7uzj7PgE0Ey3zaLtLziKJaAGaI+QsKH9leKUUwOomGwOv651AYxd+7LtB878dCQjXppHL/lDLBhscpHt0vwcJa7on18pyoiAW12p/5Mg/ACt0FzvkLjwYxHG2y6/FWaDZ8syF6dTdB4O2zAYQ/FA0s9NbFFJOVGKZ2D5lgkaBV7GbZSPQ07WYI9VBb99ZcBULv4Rodbb3huhJRvR/9gR753Mss61dTeMU2+kI/OTYWlVBQlGB+qpI13jQWPdD6EDeG/51CVLh3+ka/7H8muHEZHjdiQ9V67SfA3La3Y9gcLg6pgnPbtBRf+d+j3dZYgeleHtPGkm/EWnVs0L8GPAzvXhc4thuT/Q9L3eGCc3a4XxY6KUysw+WkrDxpx8hsyyx7qvMaI83WYAMJZEWXljsmCxUt9k0pWpVlzPdSVa9aSJkGoQsEgFSKZZoKTxyjkBIPt8GFFCQWP+knu7S26Cr6Fut5McOsZsvVNzayhRdzRzOhOM+e4lY5lvm51Z4C6SQfPlUlWMgU+6aS5Jh7vDfUDzpxn1TsYil0W1wWg7OQKXPS+S/F9rx4jsF+6PIZ4kVtI6mlTjhPltobcoG6K8vZ/j2rfCYOBDMx/aCMUBMgMymkvV8S
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(22082099003)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: SD/WRjYswjXj5jguuASAvEykd/Fx3ZnxbZjH4rhYyhhetOVXhejwJI5JKxocbvR9SQZrG+nNIIoAi+sqAUJMo+hLLr7bCZ7jKWr+vE3w2U1SmXzCWYv9DyiQxSZ0vryxVwuKXueds0hMGSPJSurDccJUOlWbDInrfD6eLrbuuQPYhAfuDKvBj6x9DwUP182BoFNpCjyhu7fHByWNOzbnPx5nWnjJHa53sJJyyyNblFFrqJHksjAKNzOzdpA3LOMd3tgP0kt6WAoaSu/cqs+YzwFljc6H99ydtDscxV5oQc2EpguogP1lF4wRquNfIj4H+8MVTJISNg9wcfH3JFYWIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9977
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 45fec235-74d1-4d1e-2815-08df2f58dbaa
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|1800799024|376014|23010399003|36860700016|35042699022|6133799003|10067099003|18002099003|22082099003|13003099007|11063799006|260925021311599003|260925021911599003|260925022911599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: awATryDKlqkzN0JUySQr+EjS1LRg+g0LkKXB1/2v0229Qe/EskxtsvDuVnhnF8pxX7jHofDEir1TvmMUVNUu3iqDYLyE1U8clj2lGcqXF/vvEu9pNoFQUM04JHm8ZtakyyjkdczPVmBVW2E/Iy09CZqtnvLUgGHDBvY6fneVcaRop205lfPoGaNtGGqm4EbC5dQhySwn4S3nF7PBEGhBELqEcQ76EyIJxNbgXhHs+KMxSpBEPaSE/sRWiifhBhdo+9obD9naA8b0BG0wetvyKl1khYHXO7jnCO1Bq9jXCz/XwQftDmpf8FT7rAOcYNzDob8tzpwqY56nVEqx3OIfx+rvLaJziMAyF9OUc5yRtqAiH2YMb4CZXMpf+3Wffe70OETQOx0wKt8+VX6sHw4nBvc74bnkmzdyu5l05Fd3a3hKmGc4r1H0tWUHEnOmmPzMp7YpxUbkky4LXkWg/BnpwQFqfsbkcFAG6r73JG+DLGLNlcZPOlwTis9NNKgEbCYZ28fB2ncenQdbdummw+RCDuLDaxaKc5bVv4oXyIrsK4amHpwSOXrg0MVgZrM0lueNsJyD1eL7U6IQCVSIZ4nmr0fbKnoLFcYSCXU5UgjE+xKElP3guYXZu0PfCCDvliQjd4WtbqbTHcVdPHBrF0mpxA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(35042699022)(6133799003)(10067099003)(18002099003)(22082099003)(13003099007)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D3mOG3EVCaqwtrsCwMqqgwInfdWJ5APaGexkIFVxBTopRHi+9su0CRL6/J22vPbm2uAzTVgw3SrR/rurOGYb9U7qEhTODrzh5Yz7o4z3CPptl9F673Eel3gTpW5I4LiYbP17EmqeIAjc0jxNBGT77Kso+OlDkxzeYUELReICbQC/AlT4sZ0KK/PEWQ+N5C4WWvtVIukGg2XeiMtXr547GvnoNKpTZ8Bc+vgSnre8uAJrNNJI8aEyplkjCR5hVY4z+9Q6t0egtPk59qsYrQ9p9sYh6dK6RbT71bcJeoE8d+GtWaRVMoYAokbvPMcs8uUuXfCbYxhwZsyBVIomBx9CLAcC/gfxFifwMBRtv2OHdhfuK06gr5K2W+szM/KMfkH4jp1n82K5T0Rzp0R57fAfVZZfC6BLT1lTySkPF+RvOF2Njzfwe0uqZPMhjPLdwBVf
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:51:52.4297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0a6aa84-314e-4ca7-3431-08df2f58ef2f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B0.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6402
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> This adds an MDIO driver for PIC64-HPSC/HX. The hardware supports C22
> and C45 but only C22 is implemented in this commit.
>
> This MDIO hardware is based on a Microsemi design supported in U-Boot by
> mdio-mscc-miim.c. However, The register interface is completely
> different with pic64hpsc, hence the need for a separate driver.
>
> The documentation recommends an input clock of 156.25MHz and a prescaler
> of 39, which yields an MDIO clock of 1.95MHz.
>
> The hardware supports an interrupt pin or a "TRIGGER" bit that can be
> polled to signal transaction completion. This commit uses polling.
>
> This was tested on Microchip HB1301 evalkit with a VSC8574 and a
> VSC8541.
>
> A Linux driver is also available for this hardware. See these links:
> https://elixir.bootlin.com/linux/v7.2.10/source/drivers/net/mdio/mdio-pic64hpsc.c
> https://patch.msgid.link/20260408131821.1145334-3-charles.perry@microchip.com
>
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> ---
>  drivers/net/Kconfig          |   8 ++
>  drivers/net/Makefile         |   1 +
>  drivers/net/mdio-pic64hpsc.c | 178 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 187 insertions(+)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: mdio-pic64hpsc.c: add a driver for PIC64-HPSC/HX MDIO controller
      commit: 64fe14b53ccaaf4444617552bc82463fe757b109

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
