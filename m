Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49E2FCA6019
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 13:42:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 588F64096B;
	Fri,  9 Oct 2026 13:42:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id K5iPyZNSDRPI; Fri,  9 Oct 2026 13:42:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D618140968
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791553338;
	b=Uwe+x52jBHBB7yJfWt/X2s5LzfSdSkuSu0oNsLLj0Hfo8jErBh3VSx56mPNvDH5hI8cM
	 0v+N1F2QqwebFw0qPeNmD9h+aypd+CliR37svsoe27DHZCLSfLLIpgl8bIGNWQl2lGMrM
	 roHCRk6FTCfIYRskF4c6hvdaEXglOaSU3NahTVHQW79SLZWccbUj9nRH/6ho5MuW5U8Xk
	 toDjwCygu3NDvGPLM0FpSg7UAUwZpANDmqys1S9WKqp093yYMO3VD6qGJCSpPERjnuOU1
	 YE+8Tm5uU9vtTpjo1ze+JS0Msb/KzYBsPUWDCbm40CEH0/vThGFjXIaAQZd5JixVnDw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791553338;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=s7Dku/txaHrH0w1+BklWO2GgxJKICTq9hCEVdWmYIaQ=;
	b=G9GjW4QEgpREH451GHt++mWf5XrmsdLoRK4SljwL9yCiPH/AZKi81WgX5DPVRxDxdlnd
	 V+MTwvDSlwXUXL4PN5hymnFMHYfX/v63iZZDucMI5lj7nBTSwgIhXc8AjgnWQGyj44N3S
	 uT1q7tux8vtvatH+f1JHOALFBoqwQrb64HE0hf9j0v5zv6yS/0399TWyOrslyheaqgpbs
	 B6C8TDAp8KVk9R2WvfIP2y/HQUDTSPke0nD1IZtM24ONbIWfq/ZnXQw85UD24fkpiVxjb
	 NaVBAXoXSAGxGhLq5U6pcTQgNaNGkipmwDbvKCKtWYQw30Ie9nKWogICh9OodTyusnQ==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=o336qBYa;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=o336qBYa;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791553338;
	bh=s7Dku/txaHrH0w1+BklWO2GgxJKICTq9hCEVdWmYIaQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jZUmhiCdeDta1PVF4+MZ0Koacw4ae8NZVbcJbOfJR68HZjpwXWcBt1uMq+YcMy1hM
	 6JFiRHQNiTTc+rZ5sJPg7MAqmb3Km3KsBgE4Cr4q8n/p1Ov89A4AMsy0nowNG3a0jm
	 CJ7ic0FERdx1Zl9bLg17v0MaMmpwW3uFY7C9TsmvpW6IBjn7RCAXtzjhc5d6CfsxtB
	 A9B7UjFvcSysMv15KiElIAv/KUqrzB5Jml/XDZ3GflN4qEZLipTu0sBB3XItsiGJmD
	 OSUBcxdSzRl6tD4R+X826UwmQjM6ndANFi6UWNnMkVmHYRbTLd43/ExnHKBvU5vOLr
	 hteKnAyV8sRfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id D618140968;
	Fri,  9 Oct 2026 13:42:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B7B69356
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:26:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9D58F408C4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:26:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cRZq5pf_pBCx for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 13:26:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 60DCF408B6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::6"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791552364;
 b=W6rFs9yIbd3GPSHS//iM8oEQzIkOVdALrEEVdvJI70QLpdHDBDDn+l3AxUMDyA652M11
 sXCgee/oaJ6G4wzis8BfJKOSx6QbyWEwvFCnGm6VRbsUFBLMSsoDnK3YiBo8GFMoE8+Rb
 XkI1mvaH5Y3aeqfcoZtJGz652nJ7Dplnb68/77l8V2Tsb/tX3rpFHUpu1Q4XTs4qxIR+m
 rygSejmlTpeuFyCPNrBkVGQnmmvjrC3JSXnuUIQLboy1XKLbg+gB4qDEg2p70W7+AOlvW
 qNzQCoJeJ1f/8y0un8cmA9P2QNTwDHsZ298Xy/JktHSnC5s0E1e51MYLErDq61O5/IA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791552364;
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
 bh=s7Dku/txaHrH0w1+BklWO2GgxJKICTq9hCEVdWmYIaQ=;
 b=HlTMZCyZgbrlGcdYx2YoVztJkzvbizp/n8djp3XrNfTgJTGnfBiYmWwj9gjyIBNFqWfy
 uX5PUk4cvulOLoSi8lu5JbdCSTenWRFMz6eCN/N5byyStZg0QtWIVTA55yMfma/J2FK+j
 uzhLN9zTzy43bW9Re09o6Hee87hAJ573AUKNtkezSR+UAZ3NX/UvqhOn3aayt7y9i2KYj
 292kpFj7rFFTLoNtX6BGvRGLJjXQtBV2DcZE+v+1760ltxcf44cSXHNhur5MoZsIpsrMm
 YuIj1S9s0QTE+6u9HFTIv9Nc8E7vuLW8vbyC89ICM5NTjMFX/wyoZW9+d4k62912qlA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=o336qBYa; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=o336qBYa; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=o336qBYa; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=o336qBYa
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 60DCF408B6
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 13:26:02 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=jklGx5aqFp336C3zU0LqdW5ByxKM6NvLe7bNHJewyqgJ5ZTiCwsD86hFF9dPwNb3XdYli3qrb97pr/7Cf63mvvSjErodrMqv+8B3Ri5/1p3OI/Phb7dQSxOPQOrc03RmM1e6H2gkfHf3grh6iDRccUYLpohIYf9KsEgTP20yqYMAsa2/iTcSzR+eXB16lOoJGD3vCh6QxJ8QDdhcUL3EaAVbaG7TY0MGq1p3aiX7TvTTkW2KY4Cwf8h3G9YtKp/tHYmJ5CjH/4wQ6k2c/3Dr3ORLLzG5gH10GgG94oCjeD+oOPrFD2NzsoevYaJXyKZI0egVwqI+76BTP1pXQ52LYQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7Dku/txaHrH0w1+BklWO2GgxJKICTq9hCEVdWmYIaQ=;
 b=ftsfa8/uCPHMrea1HKpFJNGojquGeU9RVWsZwTqOypyOSLR2732sPxZqbLnSj1LDZWmNmGlsMjfHe7N6X5NUeTMf+h+fYJ8MbN6ehIcqD4YPKh6YhSidTknFsk4k9gd5HMr2ejjGpkV6BQhEoE/QQx+Vk0MNyjVzTV3BYMblOKUlUwUh1elrJRirr5mF5HD3hjZW3JW/r8D4WdpioghAsk61PVwkksblTLVlAtdIvAH0bKZkbKHe+Y4bVOTXn8et5VQfILzO0bP9nF1jnQ/ijSIKohnKV+rXy31aScXMRgJCm9NlrEY7sEZj1/RoWxHGkpiEnJTTF/RvEdDP+PCUwA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7Dku/txaHrH0w1+BklWO2GgxJKICTq9hCEVdWmYIaQ=;
 b=o336qBYaykNSx2SU0WDUJnjVMoPWR74MqxRvEAuhozBBKrumHuCzW2pJEqfaS8QdZjep6AE0X6LJquUT3ldqn90ZdQ3inPNJYUMS+YKAk/JxNs6QiANN2AaQxXw5FGJ6kt06mfNUVC67fOda5aLFsDmWb4zp0CqnR4quSqM6wIg=
Received: from AS8P189CA0009.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:31f::19)
 by AS2PR08MB10205.eurprd08.prod.outlook.com (2603:10a6:20b:64e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.6; Fri, 9 Oct 2026
 13:25:54 +0000
Received: from AM7PEPF00000052.EURPRD83.prod.outlook.com
 (2603:10a6:20b:31f:cafe::71) by AS8P189CA0009.outlook.office365.com
 (2603:10a6:20b:31f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 9
 Oct 2026 13:25:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000052.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.0
 via Frontend Transport; Fri, 9 Oct 2026 13:25:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZFunjsRXVTkrt4pwC5sRTCVmw6GWpcy0uXJWJu2IUg+N209127RRRxjtSZjgMsW3nnamjYRWFOfMcEpCNm1Yg9EESXspjde0d5UwWKRNBOz7v51J6udLt6S4NlElmOYYZAqZpC4J8yva4tdzVhPBgPqhYBVTY4JhpmvDAUz9nd1OL9E/0MHUOcA10rOj2YCzutYyTvCRJNUlvB0WJV3lzrfETimABTVT7AmDC+673MldHhIB2d/FS1KB86Jrg7O5Mlu39HWB0j6DRcP8J/JpHUK2N60JVaW+VY4Vz93pbgC5Xq/usIFSjxa0PcPwD/RY6FDAk1fmQHgTcnAUytzu0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7Dku/txaHrH0w1+BklWO2GgxJKICTq9hCEVdWmYIaQ=;
 b=eUNZf8Wq2bkVx2MgCs/7380jH0x4m8MZvu9H+vX04KCgPJzj758uQelJujhYJgLYHQYje42oXCEwOpGbHsfW+PB4EBsm8UaRZbsT0kPRW3C6C0RJugsajsY9xrNtD5oAdiNp4t1mMRvWtvh4HFj8Zh5trLGSGNhe6cPCqchj6AKhSjNOOLuDKX9IwuieDifvDRl+YEKntWrDGChCBfAq/UYzRY4KYNXVc8wukCz4SySQs6Q/4k925txu7DYb5e1G8cJFqM0mx0t0QLCLWpDKEbWtU2zsZDKXlJMIfKXypuvZVxC+Xa/rr0iGGVjluY8knYyonfFymV15hBxkGD/w7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7Dku/txaHrH0w1+BklWO2GgxJKICTq9hCEVdWmYIaQ=;
 b=o336qBYaykNSx2SU0WDUJnjVMoPWR74MqxRvEAuhozBBKrumHuCzW2pJEqfaS8QdZjep6AE0X6LJquUT3ldqn90ZdQ3inPNJYUMS+YKAk/JxNs6QiANN2AaQxXw5FGJ6kt06mfNUVC67fOda5aLFsDmWb4zp0CqnR4quSqM6wIg=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 by DU0PR08MB9533.eurprd08.prod.outlook.com (2603:10a6:10:44f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 13:25:16 +0000
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad]) by AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 13:25:16 +0000
Message-ID: <0a707733-fb3c-4f15-aa4e-07f4129b7096@arm.com>
Date: Fri, 9 Oct 2026 14:25:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/22] efi_loader: enable TEE runtime SetVariable()
 over FF-A
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Devaraj Ranganna <Devaraj.Ranganna@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-14-harsimransingh.tungal@arm.com>
 <DLINF8X5LGMM.22DVNGKNPMAM8@linaro.org>
 <eca5e6ca-ef4a-4e20-9255-f7d20ebe0788@arm.com>
 <CAC_iWj+VHR_vGb8EYqR7tzLXihZLW586BjnjPsKswf9uDnngEw@mail.gmail.com>
 <55e2793e-33fe-43da-a509-8e64aed0c432@arm.com>
 <CAC_iWjKRo7Dm4f7FmMi15fELP9_A5XYmMmBtQN8q8qBFs1e+Sg@mail.gmail.com>
 <8a6f0286-c599-40f0-b113-1621498d2357@arm.com>
 <CAC_iWjLCpN=7YqFOMVC0HZJBB8vRE-D+jzsH+k=GZBWn4JT-tg@mail.gmail.com>
Content-Language: en-GB
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
In-Reply-To: <CAC_iWjLCpN=7YqFOMVC0HZJBB8vRE-D+jzsH+k=GZBWn4JT-tg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PA7P264CA0204.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36d::7) To AM8PR08MB5620.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::23)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM8PR08MB5620:EE_|DU0PR08MB9533:EE_|AM7PEPF00000052:EE_|AS2PR08MB10205:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7ecab7-49c9-4ffb-0f06-08df2608d713
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|4143699003|56012099006|10067099003|22082099003|6133799003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info-Original: XB1vhhfR+vK4r4l2ZfGIW0JfyLUiCVFF0UMtWXZIdZTRCK3KC89MABdCrgFBEnvxxNvlAytsIjqaCczhA3r+FpYgqS2bA42dZx6Ba6wX1lCJ8FyvXLRBH8C36R+A1yZ9E4feJSdwJmkdBOINkDswiE95A3aV7w2Dh5fUE7rN0MtFMtWrXNZ2MSq2ZJ4dhF38NX8YZtQkP7fBY1Oi34q+033CqDTjw9t3hdZNzbMoQdiaq64Ty36rwmD5219aAj9lEm5aJEIiynFGh7jr4cCHkIq3HTPQXHYMOmqhL41nxJoeIYaFc55gs+eaMAof6pq636RMI34QtKdwtpItbvTVzEXQHEI3nqY9q3naBOKBuQol3PvFQFCNk3QbKRKG/k7CF3/8D4/FdHQiYE2MjogOR8qTRc33qL+rXEpmP7LZRTPWjG5NzQlbjJeRFItLRWOrb4du5FVbSLFyFiAfbQ36GDBB5Yh4jixcWwjcLtG+kS4vWnDjDOSaEC/nzkLgCu+B/VEHLo43B9oLE3c/2VGXRgDhJcbmz0io25rs/ovrIlXmNyBmxuWnaCwym3lX+dLlKvY1KExP6JujLP2laKAI54c5gCxBy1Bujua05HgqGZPyKGADPOSa2OWZ0fUgLvqAngtq5dUE4uFb1QmmimLkIvLDoWBlihOLB3cwAhXMTUg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM8PR08MB5620.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(6133799003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Wva2wikTm6D0YkHVmrwpafn/+r/VmpAWit/rPY5MnKap6gvsPHBiOdjnueqLodWTO/tv0/Kr+fh/4+U9CEfCvs3oEj0yaS+QF2ZWIWFXTHo6nHWVrZosMIVUG/CBYCrQUzwoxvq4gAPF8SsdYD16xbQpERP/FgQvctGLi8VMJuqLXxTOOyDdEgMB6r9DYsgq2fOUVvNr5g46PZM43do1SFNZyVV1X/Se/J2ixQU+UgApJ1SZGWAor25I7JPi5EFQK6KK9l9oFc/nSCHR4yyykMeKYV5K3q/8pyZA2ZY4XtMbwsSqjyEE6n6u/xuAHRzk0j8jQFhoaSCnvh8F3aO4+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9533
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2a453b09-e3d3-4679-ee82-08df2608c162
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|14060799003|1800799024|82310400026|35042699022|23010399003|376014|6133799003|22082099003|18002099003|3023799007|10067099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: vqsyPrSeoirH/k4J6YkLdpuKSoVn6TAta/RqpG1hNFuQUQhbS5mvIfDLtSdPCoWiNGaJWZ2RsOmblIpJx+Q9xOTNHWBhGhdp1w7r10k6x6+uC21zA56lYwYE3dcezfEgjVLI1m3dAvC7wV+wzUvZ2e3nmFn/2ICom3RzNBv1re5wBOHHW9zYHStM3RgHqmB0rC+zmYK6GrVCWF0u/AWR9rSb+fs5EsYjuYKWQ/RZzAulX//g8bWVlI/C/rNZ/yEt2q4s3s3REHv4ywqIYU7xeGGJBUyZWxdH7B2mhv9gwQ0ihnmWq/BA4LULqLhhVXMyCyjrQef3wxGbz2nDd/zyi4De/hN38YbnF+g+7svV3x5WK/2djgre7BzInZGwL5gidFvgnihL4T69Ty6JRbK+RsFemwr1LluCRPuuH3YS/lScmUOeaeEhUyowlmyyw/m0kDC5Vmjqu2gto2zz0fSIQMOxX1HyKXycF/ZiSCLaCwMFnfLkrGnd8NvXA2bTIyaG8NBAXcVfEGY8l32osiY0JMcSmhNERkzOuWx0IAC9vJmPcFe8RwDrClsWGCKcW7WC59wdXZs2uSiylgjUNLmw9YcL/brz+z06RPJNb/9smnB0qnN7+gQHVc/JCyPcdkbDpxsGEJGfn7iuoBql+zwyR1tGW8mPiJbG43wZWzAnDrP2H7VxTs37Wr0S6wVK5VhvfKFPca2Wy+mK1fu6ogiVLA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(14060799003)(1800799024)(82310400026)(35042699022)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2ANHgGrFjX5MzyuD1qHC6D7EJOPlkulqF3S+5xgeJl/S+3ej5xBtMgGYMCWSb3EDwhqiNIk+pY8vI28pDjFxUtbRaQFG7vQjnumi9TdtMaOp2RWFuvfzzLVWNehv5SYGklashfWAO0GEbFJ78idzRSxtXUPbAMGtWWfxVgXsoI8ys+5r+2xHbiAT1SaMTY9IzzM8GeBNt6pvlCLQvcU5RjJEE+nJVuiT2X0lgTIOVpjpSoXu9oMdfyhRqmVTtVHPlwm/vElRYT9wLX0n3DNhhpY4THLjjCUur7W35mjUsUV+wbxxZYxX6hVk9ErofveqqAhGfcm+MI5RENhg8UI35R3SmXJyhHgqNEJLJunbVR4QDrfQLKeH9z2uOqivZ6QjW7vWV/sZoD0lPG7t94M0V371R2/lY3bTH4kINpmvZppLKHCkumZEBf9o7vWaR2hj
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 13:25:51.8852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7ecab7-49c9-4ffb-0f06-08df2608d713
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7PEPF00000052.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10205
X-Mailman-Approved-At: Fri, 09 Oct 2026 13:42:07 +0000
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

On 09/10/2026 12:15, Ilias Apalodimas wrote:
> On Fri, 9 Oct 2026 at 14:08, Harsimran Singh Tungal
> <harsimransingh.tungal@arm.com> wrote:
>>
>>
>>
>> On 09/10/2026 09:19, Ilias Apalodimas wrote:
>>> [...]
>>>
>>>>>>>>  /**
>>>>>>>> @@ -1129,7 +1262,7 @@ void efi_variables_boot_exit_notify(void)
>>>>>>>>      efi_runtime_services.get_variable =3D efi_get_variable_runtim=
e;
>>>>>>>>      efi_runtime_services.get_next_variable_name =3D
>>>>>>>>                      efi_get_next_variable_name_runtime;
>>>>>>>
>>>>>>>
>>>>>>> All the get_variable*() calls used to point to the function from ef=
i_var_common.c.
>>>>>>> By changing this you are breaking the runtime case for OP-TEE since=
 now we will get
>>>>>>> EFI_OUT_OF_RESOURCES.
>>>>>>> There's no easy way to fix this at runtime. For OP-TEE the kernel m=
ight replace this call
>>>>>>> with an internal OP-TEE call if it's part of the firmware and annou=
nces it can provide
>>>>>>> EFI runtime services. However, the default uuse case, which we don'=
t support SetVariable
>>>>>>> at runtime only needs to keep working.
>>>>>>>
>>>>>>> I'll post a script next week so you can replicate and test this in =
QEMU with OP-TEE etc.
>>>>>>>
>>>>>>> Cheers
>>>>>>> /Ilias
>>>>>>>
>>>>>> Hi Ilias,
>>>>>> Can you please share the script, so that I can replicate and test th=
is
>>>>>> in QEMU with OP-TEE?
>>>>>
>>>>> https://github.com/apalos/efi_optee_variables
>>>>>
>>>>> make run-fip should give you a QEMU command line. You just have to ad=
d
>>>>> an OS image to test.
>>>>>
>>>>> Cheers
>>>>> /Ilias
>>>>>>
>>>>
>>>> Hi Ilias,
>>>>
>>>> Thank you for sharing the repository and instructions.
>>>> I tried the OP-TEE/non-FF-A QEMU setup from your repository and it
>>>> exposed a regression in my current series.
>>>>
>>>> With CONFIG_EFI_MM_COMM_TEE=3Dy and CONFIG_ARM_FFA_RT_MODE=3Dn, Linux =
hit
>>>> an EFI runtime paging fault when booted through U-Boot EFI. The reason
>>>> was that TEE ExitBootServices() path only installed runtime variable
>>>> callbacks inside the CONFIG_ARM_FFA_RT_MODE path. That kept the FF-A
>>>> case working, but it accidentally stopped the non-FF-A OP-TEE case fro=
m
>>>> switching to the existing cached-variable runtime callbacks.
>>>>
>>>> I tested a fix by keeping the FF-A/MM runtime callbacks only for
>>>> CONFIG_ARM_FFA_RT_MODE=3Dy, and using the common cached-variable runti=
me
>>>> callbacks when CONFIG_ARM_FFA_RT_MODE=3Dn. To make that clean, I plan =
to
>>>> add a small separate commit which moves the common runtime
>>>> QueryVariableInfo() and SetVariable() helpers, plus their shared
>>>> SetVariable() validation helper, from efi_variable.c into
>>>> efi_var_common.c.
>>>
>>> I am not sure I understand the plan. efi_var_common.c already has
>>> callback for the above, it calls the _int variable for each service.
>>>
>>> Thanks
>>> /Ilias
>>
>> Hi Ilias,
>> Thanks, I rechecked the pre-FF-A runtime TEE code and I understand the
>> confusion now.
>>
>>
>>
>>
>>
>>
>>
>> Before the FF-A runtime changes, efi_variable_tee.c already had local
>> runtime callbacks for QueryVariableInfo() and SetVariable(), and both
>> returned EFI_UNSUPPORTED as follows:
>>
>>       static efi_status_t __efi_runtime EFIAPI
>>       efi_query_variable_info_runtime(u32 attributes,
>>                                       u64 *max_variable_storage_size,
>>                                       u64 *remain_variable_storage_size,
>>                                       u64 *max_variable_size)
>>       {
>>               return EFI_UNSUPPORTED;
>>       }
>>
>>       static efi_status_t __efi_runtime EFIAPI
>>       efi_set_variable_runtime(u16 *variable_name,
>>                                const efi_guid_t *guid,
>>                                u32 attributes, efi_uintn_t data_size,
>>                                const void *data)
>>       {
>>               return EFI_UNSUPPORTED;
>>       }
>>
>> The common callbacks from efi_var_common.c covered GetVariable() and
>> GetNextVariableName().
>>
>> The regression was introduced because this series only installed and
>> renamed the TEE runtime callbacks when CONFIG_ARM_FFA_RT_MODE was
>> enabled. That made the FF-A case work, but it skipped the previous
>> OP-TEE/non-FF-A runtime callback setup.
>>
>> I am planning to restore the pre-FF-A TEE behavior when
>> CONFIG_ARM_FFA_RT_MODE=3Dn, and only switch to the new MM/FF-A callbacks
>> when CONFIG_ARM_FFA_RT_MODE=3Dy. The relevant part now looks like below
>> along redefining efi_query_variable_info_runtime() and
>> efi_set_variable_runtime() as before in efi_variable_tee.c returning
>> EFI_UNSUPPORTED:
>>
>>       if (IS_ENABLED(CONFIG_ARM_FFA_RT_MODE)) {
>>               efi_runtime_services.query_variable_info =3D
>>                               efi_query_variable_info_int_runtime;
>
> Don't name these _int. Maybe efi_query_variable_info_ffa_runtime?
>
>>               efi_runtime_services.get_variable =3D
>> efi_get_variable_int_runtime;
>>               efi_runtime_services.get_next_variable_name =3D
>>                               efi_get_next_variable_name_int_runtime;
>>               efi_runtime_services.set_variable =3D
>> efi_set_variable_int_runtime;
>>       } else {
>>               efi_runtime_services.query_variable_info =3D
>>                               efi_query_variable_info_runtime;
>>               efi_runtime_services.get_variable =3D efi_get_variable_run=
time;
>>               efi_runtime_services.get_next_variable_name =3D
>>                               efi_get_next_variable_name_runtime;
>>               efi_runtime_services.set_variable =3D efi_set_variable_run=
time;
>>       }
>>       efi_update_table_header_crc32(&efi_runtime_services.hdr);
>>
>> With this, the OP-TEE/non-FF-A case uses the same callbacks as before
>> the FF-A runtime changes. I tested it with your QEMU OP-TEE setup and it
>> looks fine to me.
>>
>> Does this approach make sense to you?
>
> Yes that's why I thought moving function to the 'common' backend didnt
> make any sense. This looks reasonable
>

Hi Ilias,

I have implemented and tested the changes discussed here.

For CONFIG_ARM_FFA_RT_MODE=3Dn, the TEE backend now keeps the pre-FF-A
runtime callbacks. For CONFIG_ARM_FFA_RT_MODE=3Dy, it switches to the new
FF-A runtime callbacks, now named with the _ffa_runtime suffix.

I tested the OP-TEE/non-FF-A QEMU setup from your repository and it
looks fine to me.

Do you have any further comments, or should I send v6 for review?

Regards
Harsimran Singh Tungal

>>
>>
>>>> Then, efi_variable_tee.c can select either the common
>>>> cached-variable runtime handlers for OP-TEE/non-FF-A, or the new MM/FF=
-A
>>>> runtime handlers for FF-A runtime mode.
>>>>
>>>> With that change, the same QEMU setup boots Linux through bootefi and =
a
>>>> small initramfs, /sys/firmware/efi is present, and efivarfs mounts
>>>> successfully.
>>>>
>>>> Does this direction look reasonable to you?
>>>>
>>>> Regards,
>>>> Harsimran Singh Tungal
>>>>>> Thanks
>>>>>> Harsimran Singh Tungal
>>>>>>>> -    efi_runtime_services.set_variable =3D efi_set_variable_runtim=
e;
>>>>>>>> +    efi_runtime_services.set_variable =3D efi_set_variable_int_ru=
ntime;
>>>>>>>>      efi_update_table_header_crc32(&efi_runtime_services.hdr);
>>>>>>>>
>>>>>>>>      /* Record that ExitBootServices() has been called */
>>>>>>>
>>>>>>
>>>>>> IMPORTANT NOTICE: The contents of this email and any attachments are=
 confidential and may also be privileged. If you are not the intended recip=
ient, please notify the sender immediately and do not disclose the contents=
 to any other person, use it for any purpose, or store or copy the informat=
ion in any medium. Thank you.
>>>>
>>>> IMPORTANT NOTICE: The contents of this email and any attachments are c=
onfidential and may also be privileged. If you are not the intended recipie=
nt, please notify the sender immediately and do not disclose the contents t=
o any other person, use it for any purpose, or store or copy the informatio=
n in any medium. Thank you.
>>
>> IMPORTANT NOTICE: The contents of this email and any attachments are con=
fidential and may also be privileged. If you are not the intended recipient=
, please notify the sender immediately and do not disclose the contents to =
any other person, use it for any purpose, or store or copy the information =
in any medium. Thank you.

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
