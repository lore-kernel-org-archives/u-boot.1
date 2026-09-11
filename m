Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98816C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:17:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 408E8605EC;
	Fri, 11 Sep 2026 13:17:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id grsi9wvKV4zn; Fri, 11 Sep 2026 13:17:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 82A0260665
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789132667;
	b=pmYoA8Vb9h/7qhJEKw/j3qG/csLel9fVlUiSGvHp5ayjPOjU5ROyKor/fdIRv1/paU/E
	 0U+NPL/1mYmYugP5VrqcrXxZfQXo5u9KJBxcls4Ng8E1Ekho1QjPjLOtQRJlWn9fplNgb
	 xTUdIvCJwh2yi6b1/+VWE80Gr2mQhF8JufwQVIf8V43x1cQY4b4uotaeWJ+169G05vZJO
	 RDYIUm1sR+J1YJLfraXiSsLfl/tdKGYGJ30ksH8jBDdDKWIDYTJm6ovzftcjq1V1zD2dt
	 IwP125jbpIdLdZJ3Pn9qJGhsoV49lBm9SnYptP/00lOcPk4Y1sxuDrJP3FPI2ObjtrA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789132667;
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
	bh=Ckq627lT/cLFOu/w7dlZDYFLh1ClSd8Ys3C7r/wlb90=;
	b=E/nMd6AHax+g7blW+scCCE8wzBrwDYKu8q1jmAxLOUOYa/yZwTGvjkXAbqwbe6E9OKBA
	 LyTip+mRHbgtWEN5qYbN94IEdLH7EJSKKjhUYqIh8i4hxSL/NrPF4jLaDu5tvM7z271nI
	 GOHXEtNjFVeEG6TfLSyi0QQAtReVL3bfPulC39PWrTzidayoxjwctXW8kS2cY3agyeGvP
	 Kr60J4P40o8KyclCdEEs28ZEO8ZpJWuhGvd7yoCsej/TRwowFYWP2Ygcf9qRMdXJUm5Sb
	 QRdmViEq51stJpSgQVxc+EMOJvI7iz4CLtSmc96Wh0WprwERS8EIDKkMy6sdiSTBfng==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789132667;
	bh=Ckq627lT/cLFOu/w7dlZDYFLh1ClSd8Ys3C7r/wlb90=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u0BHm1TO9XnhN+09Doey79KwzdGUIuVFeUQqRBugoeWUY8evD4j5BBx8AnjuFKI7u
	 /VGojpt9ShLSYFTRzJmWZPDaJPhbsioZ3Ctz+32SFQFu7cYZCvzsLvJRjA8+32mcHx
	 tK6WxorT1uFb0G09rSgz/JumnSsjtptMAk0viP9hKUD9Q4k1cRtVwE6dPl/iugZYym
	 9v9y4cSpqUIsueZfUWP1pbQuIe8ztVwFqTCtNrDh8Q3tdY7738rD5yUwElSrE3jhZV
	 WegSFiUgDMxCWooWIjmyOI+j5lAgn6JJo3IW0AoWfL6nMK/b+/6kcnoMnDpM6rGOEH
	 o/3VEmRkF6rsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 82A0260665;
	Fri, 11 Sep 2026 13:17:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id A8702786
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:17:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A465401DA
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:17:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Zzm3bcZi9jE2 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:17:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 0DD1C4006B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789132664;
 b=JdKZG2zYmZu1dBXAusqqwb7zsXznUEVcQrePT2FKT4GLgzR987AsGGKgX40Nes6xTCUg
 XHh1eXlVKIm8kfEIjPw1UDjsfpNpMZxkWl1a8+a0SjP4Yo7DCiJ3fA+WnPRI9CLEdWlCj
 6dHAdHRNQ+0sb1CoWs8on2CLETbiUX8q8tVM8/UzSNynfitIXc92F6CGckZU64eOPbIR/
 K9Juz9a+GZlpmcdJKGAe3VmtZ6pUkSLhTJ/zC9EBK9JiCaLBNIb+yrTcQXRjMqIXTyx+K
 a+zFgycN4DjgyHXorZaMuhtkpXzlMg+AQZkhpNDO+KMl6elqw2fsAzRPYB+TW7+FSsA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789132664;
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
 bh=Ckq627lT/cLFOu/w7dlZDYFLh1ClSd8Ys3C7r/wlb90=;
 b=F8XO7tRnmCJR49mNAsoevPlXSSeSDPrCmX6LmcFQHWeJOdsqy1vD8mcah0vBhEz3t/bg
 9P1QcQN40PsCdS23UCaMNv/kwWL3W1dBicAsZdpCzgmAgPvr0iM3U2+b2ydRC4G2s87Vs
 iRaIhNWF+44ytCXZXz5x5cDF8ghIQlv+k/q18vKb8WQtZ7Ttt31V7zbZyeoCot1AAiU2m
 /bxebN49KcMutluMF78yjE9tu1pN35nrDfrqs6w7PFQ+jQFnhJGp25AX2bLrCvrO52K7J
 S8Zz/qPOEFvMINgl7MVYyFBjKHUgyXc1H4UwSRl51U3ICX0WFLL5Cozs3AxIPf8TRog==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=FeqeJzO5; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=FeqeJzO5; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=FeqeJzO5; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=FeqeJzO5
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DD1C4006B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:17:42 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=qj+L/vLk8mgWW4ovOaSW1oUfFovVDbppVQ+IKAUpUqvQ5uFfBsoyi96iad4CHBMzvVCRpcMV832ph2IYz8ocR8hzal5LWQAue3sxtmtwzGkP0BVX0zrywh29c6gy8WOAC66Ht871EaCIcRipurS8xKHYkkg8VEUrnp42BsbT7AZ5lVFkPgpOQq7SCd/kvWsWwL52/18AQRXYqg7NA7JL064OJwXMj8T6nl63gcRdlyCek1gzVQ+iNBE09NduKayiKxHnOAp94tDwaZQ4zAwu0CLJ+T/9CA3H6SvHNYAsi63fdcRDveDqYe1zR3IxUyyCvrbbGD7VfjJ821MvDKSflg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ckq627lT/cLFOu/w7dlZDYFLh1ClSd8Ys3C7r/wlb90=;
 b=PMXOMYjxgt/FChuTOGxQX62LdNDxdwEY7mvVu/CmlI/hatoOCZhlIie4ilUtiPbV3Y96iTmGRXWmjPcnch4R3gGI6rGGVWqWCZ8+B+31nvY/5Sy+YQhh1JaapEe4TtxWm7m+Fi0ksBTRd5eKhf7Hap74LH/CTnICTTXa3SvnI7vV7oLSuQB8j80a9/UqVTERIJM58hFKUBmqD9LL6pnQnvpV6bkB2bKwqmBBBL9tvB04NEysGefnseSJFD5U1l9sDjVNbQ2U7aofm4bajGZ0QzexZ67kX8WwIpXLgcdfYGnmMfqCra18n3eIqeYpe1cViOVyVMgaRW+D4rGjcCBvtA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ckq627lT/cLFOu/w7dlZDYFLh1ClSd8Ys3C7r/wlb90=;
 b=FeqeJzO5XoUxIJfpEvuMxwoKXq4+2Zbig24uqQ2+JNvkfbKQSh8r6yh6aa9ejW3OtjrZLuA+iPGG64T/ImouyVMVjaud9hxECO8n6OvcV19JLrC+Q3y9VJf0xRF061UGPwiZC51LwlyAO/pII5nK/SeD2pcFNHsMpdzUysab5yE=
Received: from DU2PR04CA0277.eurprd04.prod.outlook.com (2603:10a6:10:28c::12)
 by PA4PR08MB7412.eurprd08.prod.outlook.com (2603:10a6:102:2a4::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:17:34 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:10:28c:cafe::2e) by DU2PR04CA0277.outlook.office365.com
 (2603:10a6:10:28c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 13:17:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqcV9rCqJ5DRGGVftVSUPXz1FH7BGULbReNoT4CIQWrYygjLds9/iIaErjCexqYzMKE4RcQuM2kdOIT6uNAtsAzRijWwsdg3rt7g0tdxQ2EkRD1aV6myQ+grtwb9gGSLUNCFn9cLL6GwVkE3WgR/qowWFZGvrWWF7VwHTeuZ1os8ZoVhEk57EGWeqKIywoNDd9FqNKRLifkOkPqUkwW5Pi89vnQAHmiSWg1gqChSr3ZAzro04zngVYHl+l+9FC170aD59BaZCHZICkmEy5uiZfI3y4wiRM3KMHYgOVr39XHOvsxjt5/S7b1o2ypUC/Jn3nF/1Y7rDbFXgm1eXqxb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ckq627lT/cLFOu/w7dlZDYFLh1ClSd8Ys3C7r/wlb90=;
 b=iOERuXc+u800xY416wzesTl419DxkXatoI82dYcW7I7XXcrntffJcdneYFwAABB4w5KE8N/TNSK/e+2FuNvqPYh326me9nX7VW1hCODFhTHbvoHB19OkzDCVn3mJnoCtmApIdWM5bYwAEBu7D3R6br0FrwYAgSbmShbOeSGeqkbsV6EiORY/JcR61hTtJUF/a57Is3tN6cW/4k4WWtI2yy+aBkZoBLPDvZMPIja+arGJRsKg5Dssgkkj8qtvSq9LSaI8Uasi/Pr2GKqjYfUpsfOarA/p7kMp3V9OKfppo9Ys6xENvu5bVFpi8bEgGsqLAWKEExuP0w6qfXH3KxKTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ckq627lT/cLFOu/w7dlZDYFLh1ClSd8Ys3C7r/wlb90=;
 b=FeqeJzO5XoUxIJfpEvuMxwoKXq4+2Zbig24uqQ2+JNvkfbKQSh8r6yh6aa9ejW3OtjrZLuA+iPGG64T/ImouyVMVjaud9hxECO8n6OvcV19JLrC+Q3y9VJf0xRF061UGPwiZC51LwlyAO/pII5nK/SeD2pcFNHsMpdzUysab5yE=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by PAXPR08MB6557.eurprd08.prod.outlook.com
 (2603:10a6:102:de::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Fri, 11 Sep
 2026 13:16:58 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:16:58 +0000
Message-ID: <4d77e4cb-3f3c-4105-8d04-f83c043246de@arm.com>
Date: Fri, 11 Sep 2026 15:16:47 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] u-boot: fix error check in eth init
To: u-boot@lists.u-boot-project.org, Yuxiao Zhang <yuxiaozhang@google.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 nd <nd@arm.com>
References: <"<CAOOoKeR5oAcouuG1EO2fQNubKsfVB=O5qf0aj-FhSSGJeOH-LQ@mail.gmail.com>
 <20260901175210.482943-1-yuxiaozhang@google.com>
Content-Language: en-US
In-Reply-To: <20260901175210.482943-1-yuxiaozhang@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|PAXPR08MB6557:EE_|DB1PEPF000509F9:EE_|PA4PR08MB7412:EE_
X-MS-Office365-Filtering-Correlation-Id: 1577baee-bd4e-4d18-ccb4-08df100709fb
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info-Original: zIQj+MRGCwLB7pLrhuCJiu9md5GyFYf3PZdg0PgKVPRRyKDSfcMnwSb5u1QuXl8m7IVfRnIzf+7pRoTempbqmkjNgkC9WLrBkHy3GQ+4qoeVZKtLhjBGMyYApOp0JzFrIt+zbYhmw72TDptQR7EDwZ7912v6QeVcr4zYwwZiqwyKztcmZvqy2pJXYeAlCFDQUTh+3PEJjb/rQCDbVXda9/+tboFsyoEw9YcLNXj9p/bzHr8tQc5ozabZ1ujfs97B3EjWiJRep51UAUrOGsOvjOK24Vbn4clMlOgh8IwFZy24wlAyx9ZTMAsC8NKqQVdY/BuPa0PIQ3IBFQ9mfAT7+xvcS9leEXlrJSsKDQ9mUGo6FCYb762cZWtuqw36SGlc/oYi++a4hipoXy9Q1+uo6yD5QKpawEApNMjWkruD12pL450awpKTNxayHksaZ5BuI6KVYFqM/beJIlg2cEDLkNlH418/QWzGTzRktomNIolOMOM7GHRcQgVXpTKVAzn2XjMB9oB2bHuwHZ+fdrZJC92Sg5d9z2vvr7bISlYQTxsaJtBBQOcMBGZmSlRMpFquZIsdoSflHDhS48STds14hc++YM2E/R9P0UTvB6qW+W/g6fdA11v21pAJKl1YsOriKsM1MSDGXriCRNrteyuAGO2iqYkCkjT5b/W5oIhJgug=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: V8kOLdMObPlylSnsY2mDKQxV8VSmcNXgfebrjNVyKURKquC/5XIKusFrGdqYPEMXwWpoEFD2PrTQRbMlM7yJ4LYnPKiJ8gGbEb8A620a4DdRrFZytsI93o9DATCY/OqhoPf44UJ2ipagps+5bzezIqrN3CDFf6ND3kXHb9dR7czQsJGPqN+GuCsAADi+5QkakW0EB2arQbyV4m84htnmc512vcB0Hg8ayqcOkPOLlKPQtIG3NVQMfMNNHfPhUV79te2YAY22sxqMJ/fS5xcPAq9+ArCQaHINN2BRCM0u7AEO0+Yp3kasQUCTlBzRrRjjsFZQfa5J4I0x62f1tfXKVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB6557
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f951832b-7059-43ac-7c48-08df1006f566
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|35042699022|82310400026|36860700016|376014|14060799003|10067099003|18002099003|22082099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: A7/AxLf/Z1ww/OIjNQAvTVqHR9opG5UrEqN+yaskt2sae1ejSfXkab358v0zye08mCGS3e3CTPWznsbKsOd1jz/2c4XW+3pFV+d7s5JXwRFDR6W0X9x1Zi+2BQDrKBA9P8XoqNw5JRr0ISqJEdSmg9NSA8Y9Dpy4cu5eqIJJVfLJfXah+csy/Bl3AHkGCYXv54ibn4M0lS5ZLmltD54FYfTFWSC8oqEXoEqoRHnsu0ll6XMIGdiAmdugylASSMEZT/ho3Vz1IrGW+Vk6SWgm/BU29HrtWPB8rgubedeN6ojDKZ9KiEEbnAQMaJ001FymLbntQLWxWuJAW6JSnMF9KpPCtDd836/oytha+RRruW/VpV7SVm37pBSapZQyNDzRNDhVOUUQyZzMBYqSwNcSnEPGsLJFGTEVTAzqdoi/Jnnlgo0AicDDKC/7rbBWfgD0ow5EPEaHqsL21m7hj8DYkyR2PGwI6LKPxMEu3CbvYoOmtAJSwg8Bc3nvSBBhMn9OfnoIOD5OxG4fEBW+rlprVbet3SQ8MIoiQqd5EVXeUJfsm1FpToHqp9oWS9e5agDnXAG0YiNE9ZnNgwF9jeUPUtP/COxYOdqen77trmqUzOjr/kx8/8TxHmv7d3RQxGbrpMND/0Hls+ZnM3J78eISwtdc/A+5pfCuD8PNJgBWQsaHT0NW36PQ7//yUG6rC8dDFELJx8bqqoCiDUzQ0ku3CQ==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(35042699022)(82310400026)(36860700016)(376014)(14060799003)(10067099003)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oMD009qccNnWjSkPciQ1aKYsNpb5hFpz8hL8AJblZVwKhBErxWeWrfrqf4vpcKHW/EOfNfJLSVOHCWbmUlX2E9cP7mVxsfV1JP1F8+ROvQQJ58OioW3EU05RrLlW2EXCtvUzS8+JB+vkM2q7b7qTCA7IfcXjARLL0NMSqq+6ftJ7G+qrACWGs1hBURCZFGPCJqTxvnp2selUuZtsBN9ASCElOad+EZkRpNJf8utlLiiWFbBUWXgOen+N7JcbgckfyIrx8uKn/rs05exHPSAvmHn1R26XNKBsuS+uL9I0yFmOLd2fh0fXqdZAQXCfcVFSMrXvqEOTtSwukq/u+aCGquqI1B8sAax5Os7mB+OG5JJ/FB47C9i1n7A2ZBL2R0xC+Pd6MHaFbyC7eeupF7zUABj0oP3TwY4m26WHvdWJcpTRJESud5z1C507rmglLrzq
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:17:32.7181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1577baee-bd4e-4d18-ccb4-08df100709fb
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB7412
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

On Tue, 01 Sep 2026 10:51:42 -0700, Yuxiao Zhang wrote:
> eth_start_udev can fail but errno could still be zero which causes the
> function ignores the error silently. This fix catches the error
> properly.
> 
> 

Applied to u-boot-net branch for-main, thanks!

[1/1] u-boot: fix error check in eth init
      commit: 1d48033d57329dad77e5656267b60601258dbb3d

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

