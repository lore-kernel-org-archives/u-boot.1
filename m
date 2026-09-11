Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6D8C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:35:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 68CBD80F64;
	Fri, 11 Sep 2026 13:35:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m0JT58EQAetL; Fri, 11 Sep 2026 13:35:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 84F3880F78
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789133738;
	b=br5Mrqpy/j8D2rt9lqGxUsBI3Htj1mMmbafO+TI7EpiS3g5fSqzvefotD/H4yv0RH0Wy
	 lljNrmh9YZ9zRtO068JMKDCvLZKAzqG9eRPj1Ny16nOZG1YNoalxFW2kSfNjIcKsyWljL
	 vEIfyNeEYPTKM4AIGPmNdeef9K+UylGhRsEQ0oL3+4uRHbRuDZ2uwR0EQAM8iNVJCFJRL
	 6++6XdM7op6a11FZJ31QXkXuMIhJeoMbX2kRekRKEGBd2kOc7mGIYkepxAvyPwbMYl0I/
	 Hc1T/pNiAjxXNE+he9mPFSOIy0JkgdPedbdU3yo/60fcbj72VtcaAuA9LM8llyg3TLA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789133738;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:DKIM-Signature:Authentication-Results-Original:
	 Received:Received:Message-ID:Date:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
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
	bh=WsiF4V9KB0TWYSmjeI0N5OuKy9gkO4f3Z1PwgPgt7dM=;
	b=o7QP2GC3yrvdhK9fEB2BAozvOd2dDQ4ECEOYHlE3X/DByHz1w+khYHGpcrJSKLZ9Uknf
	 R4QYoe7dQMiOcZofgi5odlZecjTcx6BSeuuVebrscW7iTQbEG1+/BRyhngwLb2M60RRD3
	 ECJS3gP2suFh3rMLAtLcZ39+f41/zPVUBMoBO3Ngk9FLo5V0GWE1BAB8a5RE6eul//w/U
	 2pQrfsRn6gsEfbVSXosiTJ4bdQgXUoRfspqht1AUWTFEtdAELiEFiwlL0bT/lAzu61v2c
	 gy8v5gACBgjVzkVYJHJIkiZMM1/oCYk7FXn91BzFi09NkpcuvoOlogeRWnAitJZVxSg==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789133738;
	bh=WsiF4V9KB0TWYSmjeI0N5OuKy9gkO4f3Z1PwgPgt7dM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PCNZyLKzAqWM6COWUdL6p6HsjpL7qKN1e5lsVwocoOeAAkBAndc6GWZxcTWSNNLj0
	 ssu9dDOG88OAwi24qfMG4eWiDOYnRtT5RzwLZNHCWTPuYgdw8eTwUaJUFrRVhu6fmn
	 4kJIIXVbh3APhTfwMO/oVY30WwXqyfC4jPkVlUGxSKMxnvV2dh+8mKCfmymI9Yc4wg
	 HuTHxj+N7Lx5JjkcG9TBjBOZ7MDyf4YMreQrvjovkU0jQ1UM8DwfQ0N8ALRvJiCRIt
	 VdgQH/hGz3tuxWIjmc+ZyKh2o7ejpDOQcU4GBMMqe1hHkGHtWrJGGG7N8SN6y17Jzl
	 ASsniW13i7afA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 84F3880F78;
	Fri, 11 Sep 2026 13:35:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1E79114D
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 103454047A
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Rwk1ncZqkluF for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:35:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org D89ED4006B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789133736;
 b=BEnFNeOqFdCSryZZyuU49ZO6bH66MdpCxz12sucaw6P58iCtyzLWYB8vGPtkIje+WAav
 nvxnS3Ff/77d7r6TjV8tnj1pQEW/Q/lE8PYgA8EnmhxM/FCTK0zurDxKuUp7dyfH3z2dh
 hM4INU38jBGuDLSpWsnJwQj9PEwRfrHuyZipkTICDEMB6LjeezqJrq9DtzAaxnLCHls65
 AxatKyC9KHfD5CCLQI6G0b6PemUPTbc9XC/v/3zH9LKXUmUKUiz3tonIkl0YAODQeGoBF
 0vyiqKsKr7uwApGi5Yi0k6dbm/G3vcpE+0FVnsdKYNE+N0atep0hCr92L7lK1ROeWwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789133736;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
 DKIM-Signature:Authentication-Results-Original:Received:Received:
 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
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
 bh=WsiF4V9KB0TWYSmjeI0N5OuKy9gkO4f3Z1PwgPgt7dM=;
 b=EulfVhRMQe2ui8ulStBZ+u7gK50uJ7qZToIo0fI6Oh7cJA0QTFCG9sW3eCsZVGHxDHsK
 EKNymGuO2l5nVTeJ5LpUkpllA8EtxvhLgWUsqVaJOHFAiEkNWhS0Za5YE3OmuCIBZwwTN
 gm3r2oyiyFNyG0whBX0nPA6LZ5wcQiY4xGRTywVSVzR4ZUVr2yBQGeMDDldMNpFIjnAYs
 x43NOjLG9w/C6B++ZECY4tdS/7pZ7/t+A+krgxznhAJLfD3Y3gLuDx5FKUUJvjj0cVqVG
 JD3edFRplkzULPxztizN7jgYO/fCrO6Ax/3UnI7bt3H595PAFzWu/Y1PTsIFlrQDSoQ==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=h4VWQXbs; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=h4VWQXbs; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=h4VWQXbs; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=h4VWQXbs
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D89ED4006B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:35:35 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BMFwEtp82pjvrqqgIC8k2h1BJ28kA83PYHRHTmQDO1HFjwplRx6PferOoNv7i+389wBhUurIf0QgUQ08RIeyJ3JY45GstND1P6qPwLOkUhbbwrsu0kvt0IQB+4D2dpX8UvXHuK2K/CxP1TQ85pQx3FHYIdo9u5CbbZd+pjwWqvJNVkD4mJS5bwTgnclpyNOrTHa1xi7Dd4vZ+mSPoBzV7WoyDczMYnOE7ABF0a+ln+Hbre7Zpr7mhLDWnSxArZ2SXA6iyrSYT0riCA7KGvOi5hJxRy7aanF9wDcysZ8hykpDBAZRepi7WUzSskfYEwWHsxRnAKO2vF61pzSEFcFG9A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsiF4V9KB0TWYSmjeI0N5OuKy9gkO4f3Z1PwgPgt7dM=;
 b=C4v+BfvTd+PfdtMdk958pmU1NLC7UfbNzkSA5FZmnpHtqNoc4V7ANS4Mfaki9D33+/svIV6IKTv+tOg/xrBs3lZWfvCIGpDieO9zXNrY9os9AO65X/uLxB6t9JkQC8hCDELZZ3S/sn5xlOATS4GEwIJWVf8yF1EyJJ2XTYVGPGk0XAj1TW+8m9UsHx+cwHabureat96nXN77nxFLxBWMimyu4NZnSatcAU876+x7SDEjYJ/6LymOOKvXHHNBjLX1pRDVEGlxEWHcNmElL/lMRzNkAMRNx1E3lTRWn+FAIOJjn6+HRz466vlqIPZLwRFUpp6hz8bf3IaQgnu6lKtdtg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=byteray.co.uk smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsiF4V9KB0TWYSmjeI0N5OuKy9gkO4f3Z1PwgPgt7dM=;
 b=h4VWQXbsQa5qEO/6X8Dj8RkaVVgIWAFBVNBT+5MVGqrzCF0+rZVMe8kFCxRbewnCQu8IKthdB5fCZtOT0uNfS00CMICbC0UqhXPAaZ416RKeWBNySQkd4s4cP/oGnI7TNhYqTrFIbnAfTqnykLl1typy6nZzAdbSKBXq8wDaDUc=
Received: from PR3P193CA0053.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:51::28)
 by PA6PR08MB10705.eurprd08.prod.outlook.com (2603:10a6:102:3c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.7; Fri, 11 Sep
 2026 13:35:28 +0000
Received: from MAD0EPF000008B3.eurprd04.prod.outlook.com
 (2603:10a6:102:51:cafe::5c) by PR3P193CA0053.outlook.office365.com
 (2603:10a6:102:51::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B3.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:35:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/YzhJVJf/p9KBcPt3oruQU5YL0DiVeLXu0XbDnHIPniOCs2ZjSVrweaqxDIsqmSr53NszAjAqIZ0cH9bDSF/i8ChCcti70qCBrK09bPugPpaRqLJ3MciNv5wRyVT5f/6N9hbuHHa/1C0EK+Fn1HGlayNQjOlvRTovnHxAZfGxIhf5CwC4x+uFfXP6vHq6N4WUCNh+kkmboQzWs9jvmIew502cyzt7hT50n+XY0ocmRNZv9jka1TagqHRr5RfUjsN34CWnsY+NAyhpI4n6Hmtek6Sn9cTWNrKP4y9gmFWg8gH+gGPPw3OfBBrif7U3q2NpYp9indS88tY8E5HMRjgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsiF4V9KB0TWYSmjeI0N5OuKy9gkO4f3Z1PwgPgt7dM=;
 b=oCOU5y6tep0ez684v0eOsCve0kgc/gQ5IzwRfFu0n4UzZjQthKd1eGFW+bE+77h0MyqBuAtesIwSZsNgzUW1S6e6Q6CQOeTv0Jj/Ax/x8CzpRQocLMjg0sFL9L+TZwY1OnPNJdzTf4wXGzcySPDAUc6fF8yKIf1hGo8PqSdklhdtNwW7Yl1tAMexGpby83F9EOMQuEQnwdDkrlnLEG+NgSiOiA+NZM13g01FdrYhPUanOFlAaLBEYVpWw6q93Hh0jmIK7+25uzhgsOCVDrnVBCp9NRBIijVs1jKBD9+MXolEJpVBKrUAU0gBcji0WYlv5qMB//aP9TYbcLQd/neDtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WsiF4V9KB0TWYSmjeI0N5OuKy9gkO4f3Z1PwgPgt7dM=;
 b=h4VWQXbsQa5qEO/6X8Dj8RkaVVgIWAFBVNBT+5MVGqrzCF0+rZVMe8kFCxRbewnCQu8IKthdB5fCZtOT0uNfS00CMICbC0UqhXPAaZ416RKeWBNySQkd4s4cP/oGnI7TNhYqTrFIbnAfTqnykLl1typy6nZzAdbSKBXq8wDaDUc=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI1PR08MB5439.eurprd08.prod.outlook.com
 (2603:10a6:803:13b::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 13:34:54 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:34:53 +0000
Message-ID: <ad5e15cb-a29f-48f7-b796-ff3458d1c838@arm.com>
Date: Fri, 11 Sep 2026 15:34:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] net: nfs: bound server-supplied lengths in READ
 and READLINK replies
To: Shahriyar Jalayeri <shahriyar@byteray.co.uk>,
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Sebastian Josue Alba Vives <sebasjosue84@gmail.com>,
 Argus <argus@byteray.co.uk>, nd <nd@arm.com>
References: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260819-nfs-oob-fix-v3-0-7f8158088b80@byteray.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0022.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::27) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI1PR08MB5439:EE_|MAD0EPF000008B3:EE_|PA6PR08MB10705:EE_
X-MS-Office365-Filtering-Correlation-Id: d5347bb2-4541-49b5-d5e9-08df10098a73
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: Tx2QHh4nql3/t2qxk3jvGbTwEuI0ExuCtKT18Mmh5LHGPX8WRe+vkoyD51zSwDsT2eaBQ/PEYArB3WzqEk2aW8hikZ9AP7KiGMvwxiOFZIeI5bhzyn/Luw7DK3X5f4mHI/xDAuDdeLTKyUNte493BfAmHiL+aQCQCuRhnz/slD1P4UqReFtpIR1z339ULgW+0QsrPCU/ydOt/czLX8vrkGCDThzZdPV+E/LnpMpZgb2Ggw0cfNS43tiSIsL7hUIOckO5aqXeqH/CwBVyHIQGk0fLtojgxunNOh4tTa+Gm0SKk6GCdyssQ9nfUDF5sJha+skcP4L1VA7/yom7OBnh8G9kP3575HE2uiJNQHHrSp9yt8hSv1R6yOD8f+a+Er9EWvMFJPuVN1ta1EEdTWgjTkGmdDAMBgTztQc61gDLDpGGceTn49Rut/RQ3+lK6iZVou6xWuztL2/aqQMxdu3ZIakW1sgdqKHMx/rycyB9abVWH6cdPTWJijOHQSvWnEa03zs37b+P29Z1AW8w3ecHM2F/jM208sDBD/DAvkDxWF2s2v6X8+IFYEbNxBkxZ0s/HBHsPIaziHGk0cDcDM6du/6BsSNfXe855SD7d+I5Lvln/cR+0WuOayGpuu5wRg/fLiwBqQp0WGUOgZQhmQNToz3uAla4TEC2ET/Un3XMSPQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: acoHh5q6Q4zXkPa5xYbh9d5eDxo5DJv7RuaznOTQfqk00zdk5KMXYtWU/3Zdy2AAAVXyQs1AATUFF5aBKEJiS+urBwCVyVAxTOZIfQYJpnUUZAaWFOas/KILccUrovCood9iYaAJrJlj92GNUqGJD8KTXkv0YuqRgaaeWZJJq4A8YizQfH0rqp+dd1Hp+8s6XrjDwxtBXEFwpj2m5MBvaNWmfajkedhxMqChqNJ3PQrHkU3xXgKL/EYHu7i1rzbBILSVAO1sKuJ/q6FpiBk+tX6oxUJWkRnlcTHegZREgbx5WLJIAw8cF41E0CoBrhVGQoPwqkYb7DiuvlcMTRzVIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5439
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B3.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e28b0990-e27e-4c84-8bba-08df1009766e
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|35042699022|23010399003|14060799003|36860700016|376014|22082099003|18002099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: y2+CNutUtv41PiG/Hsc2XTmLnM5zutRjGDz7N0mRkE51wVuZZrdMPMMvLzzXVS9/+PUKVAQSbhAVfLY7xCGaWVcY1DI+DpA7eInvW4ZHMtcqpk2vHecjVt4asuWi369W4YoxGaQt1j2VhiFCTZE89BgB5k1um8mF/OomhpXBA83m4GNxj30Mv2JZHTSRtBDnHjoOGup5C4VfAWKPDh+vM0o0Ezw8GLcEaHtPzq4m7TrPR3X67ztLOZzY5K4XdTxtkUNR7z/GzMtHbFG7K4ompWDqxK0aTvs9v3ocVKRT43+1LrqG5tHfes52oilV1YDpp4BD02rxUfI2dJO7LR31VZW39ovvu3x6NitxhhckuI8/yodSXndf17dCscBDey0Vlhlyj3xTf5JawvzlGqgcal/Ie1TD2prNpKR64KCZBoefs7wsRNCFZUdOw9faSNE2H6fZhZ2YdOaGaCIhuVj3i+rHy/buh2O2bVYrAUls1/UZ4zsFu8o8luTlPoQo0fl+iDv41hssOwRi2VTAPGSF/DvQjTrySktXaJQaqoQEObTFx6h680GKR7K/f3HUzBwjEVlJBBqwn5UvpKMZ5+EiBfT5YIDZ05dYH9vHF6i70SdS/t0IcaSAL+M1tvU0Mxwd8R9zuC9/L5/RNJOtV/BzAzzXCQe/LGj0eFqkYGBiHs5a96vDKRUJCt9+8DPHHjsfl/D7eRAs/v6ILOvRweaE9A==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(35042699022)(23010399003)(14060799003)(36860700016)(376014)(22082099003)(18002099003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XSVhLQVy9WJjJQNnJbUWFRGQ1ZAjdVIAzKmi7LoSETIJo0G5b9HOjAFrpeVF6hUFO4j8H86m3P4+CvQlLOqsjz53ycw0pQq8R6cB3JubUnpy5yWsyTJvAZQCI/MxPYIl8VgvGOOdUW6iFVeqcL+Tj7WBV71tSLXuWieUzpz0UGSN99jV10/oPihuDjYdbxqJlvB1f14oddiJr8ZkJUCKawN9e6LmvZhQzdCTWvDcUySkHRoHmAeLHvcwDBPoTXWTqwRl0RNpgUi55E/n+ARSddzjeGlrjOj2wCKw13bHjXxPR8WqnqiWO6N9WWeMQLnb+yxdfMy3xSfMUvtAlvkFcSnOhLmYEQ9badfiU1nedw2KdvMMR5KKxwp7USG2gSi6puy4yQ18beHWhxP9Yfio1iUynPCHKBgVKhgfN0H7Tp7UY1e+tFV6XZ6yQdq98IE7
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:35:27.1891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5347bb2-4541-49b5-d5e9-08df10098a73
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B3.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10705
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



On 19/08/2026 18:40, Shahriyar Jalayeri wrote:
> A malicious NFS server can return replies whose 32-bit lengths are crafted
> to defeat the client's bounds checks.
> 
> nfs_read_reply() keeps the READ length in a signed int. On LP64 a value
> with the top bit set is negative, the bounds check passes, and
> store_block() then hands a ~2 GB length to memcpy(), which reads past the
> 1152-byte reply buffer on the stack and writes past image_load_addr.
> 
> nfs_readlink_reply() has the same signed-length flaw. A length of -1 slips
> past the destination bound as pathlen - 1 and drives a memcpy() off
> nfs_path_buff. The bound is also measured from the reply header rather than
> from the symlink data, so a large positive length reads a few bytes past
> the received reply. A server reaches this handler by answering the READ
> with an ISDIR status, which moves the client into the readlink state.
> 
> Both handlers are shared by the classic and lwIP NFS clients through
> nfs_pkt_recv().
> 
> Patch 1 makes the READ length unsigned and bounds it against the received
> packet and NFS_READ_SIZE. Patch 2 does the same for the readlink length
> and its destination bound. Patch 3 enables CONFIG_CMD_NFS in the sandbox
> config and adds DM regression tests that drive nfs_pkt_recv() with crafted
> replies.
> 
> A reproducer is available on request.
> 
> Signed-off-by: Shahriyar Jalayeri <shahriyar@byteray.co.uk>
> ---
> Changes in v3, all following Jerome Forissier's review:
> - nfs_read_reply() and nfs_readlink_reply(): keep the server-supplied
>   length in an unsigned int and bound it against the received packet with
>   the subtraction ordered so it cannot wrap, dropping the explicit
>   negative check.
> - nfs_read_reply(): take the NFSv3 length from the opaque data_size field
>   that prefixes the returned bytes.
> - test: also set the data length field that nfs_read_reply() now reads.
> 
> Changes in v2:
> - Add a fix for the same signed-length flaw in nfs_readlink_reply(),
>   rejecting a negative length and measuring the bound from the symlink
>   data.
> - Enable CONFIG_CMD_NFS in sandbox_defconfig so the regression tests are
>   built and run under sandbox; the v1 test was skipped in CI.
> - Add a readlink regression test alongside the read one.
> 
> ---
> Shahriyar Jalayeri (3):
>       net: nfs: bound the length of an NFS read reply
>       net: nfs: bound the length of an NFS readlink reply
>       test: dm: nfs: add regression tests for the NFS reply-length checks
> 
>  configs/sandbox_defconfig |  1 +
>  net/nfs-common.c          | 32 ++++++++++-------
>  test/dm/Makefile          |  1 +
>  test/dm/nfs.c             | 91 +++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 113 insertions(+), 12 deletions(-)
> ---
> base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
> change-id: 20260811-nfs-oob-fix-31c433a22c91
> 
> Best regards,
> --  
> Shahriyar Jalayeri <shahriyar@byteray.co.uk>

Applied to u-boot-net branch for-main, with conflicts fixed in "net: nfs: bound
the length of an NFS readlink reply". Thanks!

[1/3] net: nfs: bound the length of an NFS read reply
      commit: 5fd09cde76306869c68b1ac5f62b648fa4689369
[2/3] net: nfs: bound the length of an NFS readlink reply
      commit: b9bc325e71aef0d8cb7de62eaf3a941010dde399
[3/3] test: dm: nfs: add regression tests for the NFS reply-length checks
      commit: c264258c3f266f0fdb83c8de2e6c30d6757908f2

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>


