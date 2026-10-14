Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 783AFCC6B19
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 06:44:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F378F80D7C;
	Wed, 14 Oct 2026 06:44:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hPryjRXPjYhf; Wed, 14 Oct 2026 06:44:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 378FF80D6A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791960269;
	b=S4Yygg9tw3NIGJRKih/1oF5jLE89WQd6SHGxwIQVf/K8gs7o0x4DHscpQ3+EsybNnmqI
	 eFaevOrnYQmVlLSCGycGFiJAFudGhjqp+quP192PjJBsBT0poPtO5PJGv6EhJx97he8eR
	 n45/RY2ahFoHGF4TuMNBi4FKZ615HG/vTtpffOBaLmI8In5PEjLUp6i6NtQ4RJw+KSkqA
	 /I/XSYnRyyWU2t8SNgT6RDreciljOZ1yI1vwpXuJHK4RXtTgr1fZo8wsH0dyHKldzhaul
	 dcTIqapXnnzBox+WjYJObs42w+p0IXJD89ZRCUUnkNiknbgpKlBcmQdChqav7rlzQ7w==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791960269;
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
	bh=g0xE6xhsoYpnGQkMOzmtq44GlNO8/6iIY9Wk+mJLdkE=;
	b=nY1DPKbG73Fz35987ur7fbp8bxkz/z03J1yUTasg1CwNeojOuU8crvacDtFiMnM3eBaH
	 s2xtZZjbvkOcWuoNoMloMfDfyiTKgQvoH3k19xM0tznQuFaXo30MutcYs64FBQX6QKsN7
	 wOyeBQlgYndVIV7JPMhXTdkF8QgVgLLuNQVBT/B1EbnZIqFwt7C4WDTmiU0TYwPyuEauH
	 FEqbXsHLt5TjAjZOfwgEbRU4koLa+SCkAkHIVb95Dheso3v2KNecqvVeY4NYSWtwuoJQD
	 Mbtnh2f59BozojYtrhJu2BE6RttYxFkqxWB3t4Vx2s0Oh7BVbtUHLn1pu0qoRRkvnqA==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791960269;
	bh=g0xE6xhsoYpnGQkMOzmtq44GlNO8/6iIY9Wk+mJLdkE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OR9QHuopYKoGWXbr+DYnUumOllcPR9D5Zpg8N75y/kfkMZYFxkushHXQ1ck+MVunM
	 6Sn/8bqxRPB6x3/MvtbZednTDy0Sl7TlkAnhXATji5PStXqJOnEo9yHZFKW3liLi5l
	 WNzy/ab+wUTOn27sAWrBSGc/MATCgSXdnd7HYl3p3F04LkCL3PYaOELN+XXhq/nt2N
	 a+FdGfeQ3DjidB4COdYVaVc+I+zsctdriJLekZil1fQ2gwwWzBkF8Y0ZJMCSDOnCi4
	 bz5FQM3EwMQZ5l+tBKTSsGK19/PD9JdBV6FObPfABcT08v8j+9edAq7ydfAB2H/xDz
	 hEDWoywpEc9iQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 378FF80D6A;
	Wed, 14 Oct 2026 06:44:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7EF852AC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 06:44:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 643E86081A
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 06:44:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ihUD31KqGGVl for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 06:44:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 8E68860816
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791960266;
 b=BTtz66qDbrEUgNOtRIdDJsy7Srt6PvBuo/gJdyw04Uq8ln9JrgUaVDJ60ekoBZMYJWLu
 KVEwadDRg9pxsT0URj6cgE7mu/+LpwCq24E8l8+JTKklg8VZoOilqWbWEiAqTVlec4dYR
 Heyx2/TvZdoBKgEtsVdEyg3/c+mIeQSeB01qdhci4MTN6E2nKM80rMsqjdEGVNy7EaVKp
 mHQNODQ8GAO+UkcfC+KqXgRByPI4aU4E7WVlVFs1rDyiXb3CJkZoLzx9GCX7cQOMShJZx
 rsnEjOmPTPQpMlIln3eP9MJtg0eigXyVJgwxfdaZ0niaCvrZ5llJILEHPQlQOiodHLw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791960266;
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
 bh=g0xE6xhsoYpnGQkMOzmtq44GlNO8/6iIY9Wk+mJLdkE=;
 b=RM/NdqL1f1lp2oNxq7Lw5j+7m2XP1hNslqifuT8vxBD/AuG0rOW38W87ITyQbRO21Y2l
 ez1WB/tKK9N9Q1dUhUlbQmM86pLoPEzVs/uanD5fTJ7Mkrh8qaHy3wvtNGCZNezBb+WHb
 REqDZqyAGvZ1YvcUBs4q+QAFifPtNZ2fkUAwpkXFaZNuZDJuK5C/IKBjDyYeNkrnZEZYk
 iwoTBLtcFnJZsSuEfdxhLY0Iukrz8GzPnUoSvw4QghsQz+gogSBbU8m/g6xB5I8VukIns
 6tRpfRmU5hDeleQ/iNMYnWKkmF0siegpkSBc2+oWLL/I7fDJh87WDQlE9ZdmEaWeddA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=bbLzY8gZ; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=bbLzY8gZ; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=bbLzY8gZ; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=bbLzY8gZ
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 8E68860816
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 06:44:23 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=OgLAH4lEtMYDlZ5UZ9AF6FV+5RsXhQnSrIXOgBIaapi8cirDR+a1UXZlaSE/xCHHGOxWqDLziCYnxzAf63y8PzfoZ8wVlKbUxKmI/eS5LMEzqKleLuMVAdu6bprkKpxdGgbLaR3abMUVNqZ1Xk3Y4HKB9U3JYyx3jv0rrzD9Xwun9q0N6OK9YZ+26WAUFxrDUra1fxrlk1aXFQnGO1wrT1mGkJ7oIhbsA2/r7372hnFhfADP9nOwMT45JFY8deMeMgB2OAkL5bcmbC3HMc/J1H3lovJEeNZRVDVcBmkSog2GCCK+Xl4OZUJyzm2JElYJNAhwduiriS9XdJL2iOgIRA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0xE6xhsoYpnGQkMOzmtq44GlNO8/6iIY9Wk+mJLdkE=;
 b=SrIR8qu791Iq58mDWGLpGZOwDPvIFk36dG2dWh1OZjf0PFto1wisiogJxGsCbv6lJdouF3T6ak1QaD3qBRIbVDo3HVqPKKw4D2HmAaOoWci0fllznCtKIQntuLN60CUez3EbiOjLRIXrRZoGgLVnhkyEHSTuOHj+Sz2R9hgk5Y4t9TZ7f+8X5R/ESAOqEQEqeTjwSW0TA9fW7eTOmn6NHRHeKkwoGHjJ3Y9cz1T/NP1fmiPR8a5AYSeDmPaohKzAf9d4bZMrzQp7PLjDNxb/IFf20/BewIrsse6nrUPKDLZGZi8xUFoRMKZfnI+09LjfZNp9ed/WfK2f/kvH34307A==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0xE6xhsoYpnGQkMOzmtq44GlNO8/6iIY9Wk+mJLdkE=;
 b=bbLzY8gZIQ8oVsZBso0X+hY7G2LWh3TjbrA7O+cDjbUPnNuNrwlXNK7mVRCLuvLw8MHeK0nTywZAxbuZTE8YMLYd18L9/SNlCSHJaM3xCa/d5miZQNkc17paRbqN/o+fh302lpHCaHTiXpQytUTkc/YRZpIT0kGLwme3iSDWQYU=
Received: from PR1P264CA0146.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:346::11)
 by AS4PR08MB8093.eurprd08.prod.outlook.com (2603:10a6:20b:588::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.6; Wed, 14 Oct
 2026 06:44:14 +0000
Received: from MI3PEPF00008482.eurprd02.prod.outlook.com
 (2603:10a6:102:346:cafe::4a) by PR1P264CA0146.outlook.office365.com
 (2603:10a6:102:346::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 06:44:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008482.mail.protection.outlook.com (10.167.240.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Wed, 14 Oct 2026 06:44:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQkmYzETmwWBP08FSo69/QpZs65hUTHiM7BptxAkfYJlcjEXg0DZm6zE/OxO4mc/DAa4z4v9mpYUK3GuXF1qCyvIJDvpze3YGbqfzdz61O9EBQxa5SOePEZbrCt2XKXjrLCU6+TnFdYU67FVGKYkgRMyHwj4wk6JfiUqDLenU44P0v0BLqg399Me2fP2hnwjZ2l/u4S6LepooJP5Pmz+xQSyt7bwnCPE6J2HrdCQZg3vzvtxqWU2Lvm59Jsd1HGfU6O5E0w7Dg3oA3OLocxxSMvx9hbs4z4RvTQMjKeuf2Mbt/w6YJFnDjUKCy52sbEgJPCE1nTRgsOM/RrLJGLe4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0xE6xhsoYpnGQkMOzmtq44GlNO8/6iIY9Wk+mJLdkE=;
 b=jUkTlQ9zjWKakfttrxsQrZMoiXHxxXWx0TanhIscqfwyXmobGeEjg++D1PP/KIBdkk2Ld6g0gGz7A0VJj6J17g98YUpOiZG5lI9tNFQn+VkNtnlXVherKgLZElJHgRmmRQtEzmO+qpiC29Zz3TOFaARAeErn5vRQAljcRRgloETgM73NCdQPGjt6V4Nv7b+5sGLG0YaB72jX/hyQQZtuG1vrCl5TjJ5roxkQ4alFVLDuAzsaZbB6XadvO1iICu+ocDqdCVSKGdGyk41YPe8fEzejlBL5OrnH+oLuxsQhVnJHbwTk1dxyKnOhrgbxU6GgzSEsFmTbTbXiMgDuWblqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0xE6xhsoYpnGQkMOzmtq44GlNO8/6iIY9Wk+mJLdkE=;
 b=bbLzY8gZIQ8oVsZBso0X+hY7G2LWh3TjbrA7O+cDjbUPnNuNrwlXNK7mVRCLuvLw8MHeK0nTywZAxbuZTE8YMLYd18L9/SNlCSHJaM3xCa/d5miZQNkc17paRbqN/o+fh302lpHCaHTiXpQytUTkc/YRZpIT0kGLwme3iSDWQYU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI1PR08MB10146.eurprd08.prod.outlook.com
 (2603:10a6:800:1cf::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.8; Wed, 14 Oct
 2026 06:43:39 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0522.006; Wed, 14 Oct 2026
 06:43:39 +0000
Message-ID: <5c50b662-cb88-48a3-9af6-0281d17dae9c@arm.com>
Date: Wed, 14 Oct 2026 08:43:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: designware: Disable SGMII auto negotiation on NPCM845
To: Jim Liu <jim.t90615@gmail.com>
Cc: JJLIU0@nuvoton.com, trini@konsulko.com, u-boot@lists.denx.de,
 u-boot@lists.u-boot-project.org, Stanley Chu <yschu@nuvoton.com>,
 nd <nd@arm.com>
References: <20260914091613.1194020-1-JJLIU0@nuvoton.com>
 <d354dd07-f33d-4e23-ba81-0a5b2b1030de@arm.com>
 <CAKUZ0+GHDOccujC7389VS3o1r=JgFUhz8-JF4LrLT9HaV-x1Kw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <CAKUZ0+GHDOccujC7389VS3o1r=JgFUhz8-JF4LrLT9HaV-x1Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR1P264CA0015.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:19e::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI1PR08MB10146:EE_|MI3PEPF00008482:EE_|AS4PR08MB8093:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ca5c0c8-6c7e-4c57-c906-08df29be8f7d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|4143699003|261009223027099003|22082099003|10067099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info-Original: jxSng6s0VODZtMHVJo+TeRrj1mfDzo0pDauqP+OtAQryNQdDFeCzObjuz7HlrslWQsk668HVjxPkmVR5mYQCZU0ni69R9REiZSh4BmH/KXEfAjFLZYkk5+6mA/uw4u3FzGKrC+xxM/nyzarP4dHZYS2dhmolDr1A5fug9T8kvfl+h77W1Gjrv2wiPAlpcMrrzGQ9K1c5BhqkiUCbHgMafoT5md5PZsSAuE+JXNdAc3tfeR5GcqQSWEeYsZUh66XrtY2JHn7DsvghOpRoq1O30dXYnDnbBy9pq3Rd0l8fUAqChW1Ku6OLiZ93o96jOlhzwxSiq8JQuetp0oRiQ+rwpdXU7koub4gzzEw9FPGrb9H8FJ7zzvLes77JCNpJQoKrYP3NiOH8WbgaJ/gpLTY+pLaV1xbJsBEhMhgK5SpuEDlIFSbiOl0rjpxgwNv4h8Y9/dudcRdTig42RZNHFXRIKLjoRCfxp6STfbjRpog4sbGzZWJ0YR82I1lbTLqXP6YnXe65gnkQlqROhpRVTTczRFLYQhr4HQbYwP/21t/LEY5YRF2rJTyU36PYpq1YdKx0U3Jd40WlQIojHvzcI7C/HjmjKlzvTB7Tdz8vp1l4Mk+b3GhN2qL9/T5UqxkE/W4qPXW8mjjsnbnj6b2ZphhpoXc+UDeD0EQzGpUcl9EgMUQ=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(261009223027099003)(22082099003)(10067099003)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 09LVH58mhHUPEssExS4gWsYh6u3kuvgRNuJKv/C/l77ra7c8ceCfhK5MulSBswmC5Re+xpy0TzJXw+F0UGLrlCe+wOdvCFw0vNFlsud699NmOhBTFi2F59XEcv7ENMBzMGGxa81eVXJLB7tcNp8x+CaZF7+2Ed5NvjM2+AgxKXCNZyzxMoCxO/A3AIerMsKniQ+hcUxLRZ99kIXKpbHaOI7xYCV1H0dQqkgXkFXZtsnW4oDBtW4TgIh00vKKkL91TH2gtVGqpEwHPDehq9p0tjo2NxCHHqSezDVBopiWYROky0J6JC3ZjmqNa/VXpj7ti77y7CdAzz4kp/sbJ0vZOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10146
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 487e5c08-4581-44de-a428-08df29be7adf
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|35042699022|14060799003|376014|82310400026|23010399003|36860700016|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: lrEuUWTvqrhmaKGcnebwBdFurXYXI3cSGyn2nglJECuyxlIenbjfqW9uID8N4+5ZGzZJDmAhIi6wjHAcpViDwZgjaKe7aN0Kjwp5F4hYzkBR/F2jf8lwg0XPjqHL2Xmr5PNPXfJTtLUOJRyPoBJdRAyxO5HqTbgnqdaPHGn5xxBXQJWRQSorFOby1U3YwSQ6R/pfDnErrdZYfu5ITk/91jExIFPORoeQtAiECK0gpqvuEpoO/uiRZEvdxIxhuvjHGPGvYo9/55IrQ8TVP95PaAcgYge6+2LiQDGXteNdzws5bDNsEfxu4B9MT7kqkhBoNMRTq1Tt+E4aqbKlXszkEE0qV4MvfcPWhOogYYDIgosrTdwDpso68H5ItOriMIWV4375buOTcB4sT6QZIvagMjwduHJshDfjYJZ/NFgE65CRPewLuBpSerWk31pLnIEb+GRIhuWOWz+k4ObIEtN3Rw+scDCRLhrGiwbSXgdlWR75rF2csXDd9Y1w1HIC1AZXPx6oiWtXOEAbQkk27FhsNEc9UfRJOcKUkAqIqKPn8aWtMO8fIAc6Goyu0jsAxpHo0ozpZGuNNVrgZ1mRpY7EXV48ostOCMpjcex38PtaMMS5WWhCHk5qcMizTlNpbdlN/FCEauKuFg4V4TBAvmvzIOleO/RYze/kE+K+idro5rLdW0J7Hl/ya4jjwQAOWPybrgdzHSMssoACFH34hxggWA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(35042699022)(14060799003)(376014)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UzOf32or2z8ltZprtESRUBXVPtNgPxWllkAbruSqESvIgvjf8+k+eypOBxN8kht5fhcwAXTD+ks5HMxsxYHW1wJFoCt4czv3Awr0Bz5FuMly+hVDy5u14GwxJMIIKUCyW6mVAtrH9iLpUxFFeNSI2Y8DxD+2G6FrcxtukD3KChUeyMya+9xaoxYSH/icXEgK6HPYEtkUPveJSbBMauPgkTMWk35gTDNRu9p1tLHIVSm7AsNp3jsRCwYGZcpsaZRz72ESIMLP1kFq4bDYM1hlpWZqMGSCwa8STYiWJ9vG1bpWoHuFoSkkOLEJ2xd6FrEP4M+NGy7zEUv3zsUgCwP4iFO11lnFD0eVBx85aAcL29ke44Jh53kWS1abxz9USJAaJ7kb9EHIbvN/B2dz/+aI1bgw60RRNEV1Wwfgc4vE2podBqbMDoXHG2SwlL7LolQX
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 06:44:13.6134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ca5c0c8-6c7e-4c57-c906-08df29be8f7d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008482.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR08MB8093
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

Hi Jim,

On 14/10/2026 04:07, Jim Liu wrote:
> Hi Jerome
> 
> The changed code is inside the existing "#ifdef CONFIG_ARCH_NPCM8XX"
> block in dw_adjust_link() (added by commit 5354774b6b3 "net: designware:
> Add npcm8xx sgmii pcs support"); the #ifdef line is just outside of the
> diff context. PCS_BA and the SR_MII_MMD/VR_MII_MMD definitions come from
> <asm/arch/gmac.h>, which is only included for NPCM8XX, so other platforms
> using the DesignWare driver are not affected.

Oh, yes. Sorry for the noise. I'm taking this patch.

Thanks,
-- 
Jerome

> 
> Best regards,
> Jim
> 
> On Tue, Oct 13, 2026 at 7:57 PM Jerome Forissier
> <jerome.forissier@arm.com> wrote:
>>
>> Hi Jim,
>>
>> On 14/09/2026 11:16, Jim Liu wrote:
>>> From: Stanley Chu <yschu@nuvoton.com>
>>>
>>> Disable SGMII auto negotiation to avoid link-up timeout on NPCM845.
>>>
>>> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
>>> ---
>>>  drivers/net/designware.c | 33 +++++++++++++++++++++++++--------
>>>  1 file changed, 25 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/designware.c b/drivers/net/designware.c
>>> index 6ed9c6d538a..5ff84c13bf9 100644
>>> --- a/drivers/net/designware.c
>>> +++ b/drivers/net/designware.c
>>> @@ -498,16 +498,33 @@ static int dw_adjust_link(struct dw_eth_dev *priv, struct eth_mac_regs *mac_p,
>>>       if (phydev->interface == PHY_INTERFACE_MODE_SGMII) {
>>>               ulong start;
>>>
>>> -             /* Indirect access to VR_MII_MMD registers */
>>> -             writew((VR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
>>> -             /* Set PCS_Mode to SGMII */
>>> -             clrsetbits_le16(PCS_BA + VR_MII_MMD_AN_CTRL, BIT(1), BIT(2));
>>> -             /* Set Auto Speed Mode Change */
>>> -             setbits_le16(PCS_BA + VR_MII_MMD_CTRL1, BIT(9));
>>>               /* Indirect access to SR_MII_MMD registers */
>>>               writew((SR_MII_MMD >> 9), PCS_BA + PCS_IND_AC);
>>> -             /* Restart Auto-Negotiation */
>>> -             setbits_le16(PCS_BA + SR_MII_MMD_CTRL, BIT(9) | BIT(12));
>>> +             /* Disable SGMII PCS Auto-Negotiation */
>>> +             clrbits_le16(PCS_BA + SR_MII_MMD_CTRL, BIT(12));
>>> +
>>> +             switch (phydev->speed) {
>>> +                 case SPEED_1000:
>>> +                     /* SR_MII_CTRL.SS6=1 */
>>> +                     setbits_le16(PCS_BA, BIT(6));
>>> +                     /* SR_MII_CTRL.SS13=0 */
>>> +                     clrbits_le16(PCS_BA, BIT(13));
>>> +                     break;
>>> +                 case SPEED_100:
>>> +                     /* SR_MII_CTRL.SS6=0 */
>>> +                     clrbits_le16(PCS_BA, BIT(6));
>>> +                     /* SR_MII_CTRL.SS13=1 */
>>> +                     setbits_le16(PCS_BA, BIT(13));
>>> +                     break;
>>> +                 case SPEED_10:
>>> +                     /* SR_MII_CTRL.SS6=0 */
>>> +                     clrbits_le16(PCS_BA, BIT(6));
>>> +                     /* SR_MII_CTRL.SS13=0 */
>>> +                     clrbits_le16(PCS_BA, BIT(13));
>>> +                     break;
>>> +                 default:
>>> +                     break;
>>> +             }
>>>
>>>               printf("SGMII PHY Wait for link up \n");
>>>               /* SGMII PHY Wait for link up */
>>
>> You mention NPCM845 in the commit description, but this applies to all platforms using the
>> DesignWare driver. Could it cause regressions?
>>
>> Thanks,
>> --
>> Jerome

