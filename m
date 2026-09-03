Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC870C61DD3
	for <u-boot@archiver.kernel.org>; Thu,  3 Sep 2026 09:24:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 115AA81066;
	Thu,  3 Sep 2026 09:24:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VT3wRIaMDFV9; Thu,  3 Sep 2026 09:24:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org C8E968100F
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788427470;
	b=G4Yil7rD/7Fs+acc+geADLPEo1Y0tLqODle3gvBXbIzTcl//AE+U+JzWPyCmu/uB3PXk
	 DcH1NGmoPQGzDm8imS7+T8tooGnBb0+QS0TVYNXB5D+J6td78kHngsgji//G+e37wmn/t
	 1hq0UxjtreMXJs/neWhS1GFp8PnE6j9dXPtVfy9qDZrVIJOHXGQwtoE4BAN7H2IFCXXbJ
	 DCED5pWDIQItYKCaSy1C2TbFhpuqmFapeir41DsoKcR80K6x38zaN2OS8OMt5Ckzf71TX
	 BJBH3+alg5apkf9SyQb/SzXgsNp/HpbTzR9GqCeI66ODifaZzyNQv439I5f9+urx+QA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788427470;
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
	bh=+4+4VDOChrmi1AEMUm/vcoXayD3kqfBP16myGPX219w=;
	b=VRnbRX2HZ6HSyOpXkesV8wvQmDDLzs5n6Zm5vHoCooKdKWzris4k8DkyvcXUogx8gpDb
	 ot/5QW46/LdchscwNIo9TY6qlIUL6npuIhX6fwCd0hZstfEVb0T+/FOqdcYnAji9EbYnI
	 /kE/0zAP4UWzaK3Rx6AoayU42Ge4P1dNXqTi7gyLBr87TspbkeK6x7ifGF12HycTEyfyM
	 9KnguyX/k1YpTIw0c2mOiJTtRYJZDAys2gt3U7bwTUdWdCRICC6fbYt33XW2EtJQRjJaN
	 ce+XNAJ4pA3NiJrSz/696YfEuUWm7d7tDT9PxbzmRcrAfdhTnElpNBbYnF+P/pwe2qg==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788427469;
	bh=+4+4VDOChrmi1AEMUm/vcoXayD3kqfBP16myGPX219w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6pVJ8YXw3v6eJek6fmndUOLiJxxcO7hV9UYAsE//91UxriRUM/1M5ak0e7I96MDI
	 GRswNzgDkebDhCHYw4VOgDh37ytgHUpjlF+A7RPcpVRtbZlTJGKbAJa86mu1gHx241
	 SqFSVnOx9wQfc3/kXGSPeDLB5eXcaQ81kGSK0PlhEcgKtZCYy0covT4rZELPEpdcab
	 z9fJMTc8RXWWBDkM3XocbQ+FEh0d+DjTNSZt55SpjWlhpAW5Y8TEtlrG0wWn9YdawW
	 6nnw/5bU8REpMHf2rIeP15Zd9PxejyHqTUVXwr+bavYAa5c6BSbcw91tMv066FnVw8
	 8BiAO6iM89yLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8E968100F;
	Thu,  3 Sep 2026 09:24:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1C0DE363
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:24:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E6735608E7
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:24:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kIENPAzvfAPn for <u-boot@lists.u-boot-project.org>;
 Thu,  3 Sep 2026 09:24:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 016CF6070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c207::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788427466;
 b=MVjKopeG9FPAVeMCKK8JoacbdF/czW6yEoBHtXOaajeA1KOGkGZrvQG9u996I5VFtPRh
 1EfGbD3ZgQ69FnzMbYZ6+U48drLyaWOPNdZ/uA1Z98a7Ak5rV8Waut5uSKpqsn+lXyRVa
 7nAzmB+g4K97BiuK6juBRRAOdQW1tcr/TgwMyAHq6xDHXP50RqChpXYBIiI44cQSejnTy
 3IKpoN4v8jOiYhYjh+r0FHsZI+uj9ULHMf63PWbXhKqogyAQsQGBdoqeX+t/z3c1JzIHe
 7bxYR7mbRzYRvsdR8VOxhbbHSMc5bQs7plVKFpNDoVBbfeUd4UpP6BB0HoLVOxbs30w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788427466;
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
 bh=+4+4VDOChrmi1AEMUm/vcoXayD3kqfBP16myGPX219w=;
 b=gL/4uq0ZHBtyV5LMJttapac/XyTuC5H8scHS8CsBVe8gNygA4LJI7d21e4M2qOTTwajw
 LP8C8JmHHAyzUUmuWNhDbOHSh10kp4Dc4CTMDrhYab0YshO5Z6Bf+2lio8PB6rRcozcdH
 KIbm0Q0kgXsPnC17JEIa2d8quSBWCJKEUXI6uPUBdYcSBnjw+kwUv3hQXVcfXJ44Hz9a5
 s3kBj2m6StliuAUT5+XaZA9L9KjLPOg59lXaR2bUEhK0OOb0t3k0175TN5UJiP3zVVyaC
 YRl+RIj0M3tBtJd+Ei7jpRj2xTFPMaBHVKxlTPycf7HvpDeG34f7NXk/CCzXv7Tcavg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=qUZAZVa1; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=qUZAZVa1; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qUZAZVa1; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=qUZAZVa1
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 016CF6070F
 for <u-boot@lists.u-boot-project.org>; Thu,  3 Sep 2026 09:24:24 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=rLXIaCa0A+fbyRf2bW0V8qmzEbTk4n24UOU5Z8bZFkOk3PhvFXV6eYcERcMYrtQ4j8WB5OYOi/AtDCA2Jz3iAfp2Nps+OPZeGlSpmv5495zjePf45slcmSffSJZtIx8bPoFeNG6vWW17m1kZuTDJswTCiIhwauzVNLsPXEfMRGZbMUv+4vQL7l/gjVsy+5V6aWAJW4aY8h82gbZR6xNn6AYsbXEBafu0e/GlRAYEmGNuA6llLLk5JLDdBLxqJsOWtQvddEqd7PvVlk7P6iRw/Gy+QGCzCobayXUvvBy4hDvfcLwr9oJmh049/26POvDITbj9bGPn7Gy0/zSW93V06A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4+4VDOChrmi1AEMUm/vcoXayD3kqfBP16myGPX219w=;
 b=uoRL4OsolO4CB3pFlTFXiQXB7y3dwW1FzubQep9LEapUQw9faOCJJdAbW+xkOqcWVJt+WKAsdikSMvjkNhyVYx8nMPTvGhftmWvaSmjgcWsMMwc3BDD/NLZVx05aRAR4M6JVSIZ1ObHwxJP6nCjh9IwYFhldToS1qW3taGILAVb98rGQmgpeVGGHa7i4qewNTMF9zU3oe0YIq4aRB0kvJGLAXDRPlJWVWzpzkLpD0ehHi7DKCYJ9S0l7Xa6TjxTzeXBXnka2Brg/L8foqZCHH8Bkob3R3GXQyry2n1IkvLMh8YqWWMS1ZTDAeUoEUlKuBqxMr2kklFAOpxrMYr+FaQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=gmail.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4+4VDOChrmi1AEMUm/vcoXayD3kqfBP16myGPX219w=;
 b=qUZAZVa1kIDmOK02J1RK4m2FgxId7BMV/3vgvYLppQXgDDLjIz+IlnMIODby0DlZXoxrIJ1VuDupWieUEKSxCGfppT4tFO9gAq2NaL9H2iqIiAfQedS+sJBlOjIs33UBZzqypbTcIUcsWIs9cO9UmPmZhFmKuYig9wQzic3d0Zk=
Received: from PA7P264CA0259.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:375::11)
 by DU0PR08MB9910.eurprd08.prod.outlook.com (2603:10a6:10:402::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:24:16 +0000
Received: from MAD0EPF000008B9.eurprd04.prod.outlook.com
 (2603:10a6:102:375:cafe::7b) by PA7P264CA0259.outlook.office365.com
 (2603:10a6:102:375::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Thu, 3
 Sep 2026 09:24:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008B9.mail.protection.outlook.com (10.167.241.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Thu, 3 Sep 2026 09:24:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TLIU3DdOu3K97czDa42afsyyGXqausmOL9UoPNHWfikiSHAq5KfXDecWBfADF6pR96mHty+GsbiuMERnjazHHpZMizw59qwomAiPSaYDiR4uc5oHRkoTMWgvMq/NcT69NFZ99g/zF4SIe+8eJeq504DD2A0RUF1xqAUPms5Y2MyYylIvYEO/CQe0Wi8b6fkV0dv1HXiotYnfWmoquMk3qYfgWTQwDDxdU3uV+D30nio0ucIvmeY5mw607hEdBOBumfHOcKTmvQ6bkHNHgk4Bjos6njU6isUcapIZDx75zv+7gPp0f6Qgdl6EFQfnycvte74uE7NnBR4IbI6ya3wAZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+4+4VDOChrmi1AEMUm/vcoXayD3kqfBP16myGPX219w=;
 b=X482A1VjuuqCxnApMHzHzibdsMU4DIQLP6jY1/YV51rTw0sZqnER2fM9fNB5cc5Ithed9TBgahNEYEZP6TNT3xsSolvS8UzyDAf845K//s6yh1D31cYkU+uW3OUs38JR6Muqkpdrp6bR2EijY+SqRZ4+XWPFPf0hIpf6PxGP+CIWEH/Gp+B78srqlGLijshXUZWqc2+C0g23dULbiikzs+vCzfE3nzPFAdK6G239B+UW0cq86y5FTsL4pcfM3TLtXWqJZEpbjqhrj5A+sb+LIiIdHiPO611mtZgKsHr0lgEI8SFmq8Mox5X/loHk6+Skb3DcXFrmsBnmKSO5NH5WUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4+4VDOChrmi1AEMUm/vcoXayD3kqfBP16myGPX219w=;
 b=qUZAZVa1kIDmOK02J1RK4m2FgxId7BMV/3vgvYLppQXgDDLjIz+IlnMIODby0DlZXoxrIJ1VuDupWieUEKSxCGfppT4tFO9gAq2NaL9H2iqIiAfQedS+sJBlOjIs33UBZzqypbTcIUcsWIs9cO9UmPmZhFmKuYig9wQzic3d0Zk=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AMBPR08MB151637.eurprd08.prod.outlook.com
 (2603:10a6:20b:798::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 09:23:43 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0382.007; Thu, 3 Sep 2026
 09:23:43 +0000
Message-ID: <45cf6b6b-231e-43be-a93d-3ac30510c01c@arm.com>
Date: Thu, 3 Sep 2026 11:23:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: net6: validate IPv6 payload and transport lengths
 on receive
To: "estebancalba@gmail.com" <estebancalba@gmail.com>,
 "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>
Cc: "trini@konsulko.com" <trini@konsulko.com>,
 "rfried.dev@gmail.com" <rfried.dev@gmail.com>,
 "v.v.mitrofanov@yadro.com" <v.v.mitrofanov@yadro.com>,
 "sjg@chromium.org" <sjg@chromium.org>, nd <nd@arm.com>
References: <20260807-net6-len-validation-v1-1-edff271cbf2c@gmail.com>
 <20260821-net6-len-validation-v2-1-29bd39f946e0@gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260821-net6-len-validation-v2-1-29bd39f946e0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0375.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::20) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AMBPR08MB151637:EE_|MAD0EPF000008B9:EE_|DU0PR08MB9910:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4176f5-8106-4977-c4bb-08df099d200d
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|10067099003|3023799007|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info-Original: ruPGCagTGYFuPgoizVPRG+vGVYiY0WzOFEucA0BU5mjZ2FgoWq4m+wFbfTQRlBxywofyS8FtbVorRX5/GOHAVVqasTHPKLo00W+kG7b19Fs44LLmn0ymCIVFi5mJ7Q/VTjEsyeG484GP96gnV4Qjgtey0tUgl9Va8KESdgsAJkd8gtnXUAFCTYVAW3TJIAqw28ILpvb9H2pX4dKgT8sTElFxKXClV7D+zM1R8Q2FC8V4XUqUmzkNuFVoupPqpqEIIGWSZydOCXLw0ZnD0i2x8H74biQ9HUPMCfDP72ESYpqNs31M1sT5EINqVIMt784DTM+D8GlrDqnIEb++ka/bKTWgKI3gmiw0dNUzLI1G4CfvTFnVlAsR4DQPPNT7PiCzKKQ1vnsWKdaAgkonGRUg8Zg0YDkC5kyMCyM38JYdf8zYjrq3EPz7avNeTdSHGcS7MOR7HriLW6JLTpGFuvdW4qgeXwhPTI92Bp8YK35Gpsu787BvrgpaTLjCDC5vj5mVLjp8m7Uld1rcf3+dOMKxq7lEdZJIfk3c6Mo0SQtdb+8RAChOEwMa04xr4p2oKG/Lrwvtgj8e1HXJpHIXNq7fR5oN8geTQLg/VoBNVi6BRkJiAKNu8YkniFXtr3E4PaX1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(10067099003)(3023799007)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: 4WuDFbYG+tD/TjdjZAC8BVZq3t4w3u0uHPmkSZfZFhGlPYz+cdVgqlOkt6iShXmjpOs7D+My4vsG3pp1HBl2xvw76V45AjHE4upX/iMzCGaYItPHr+5ZH8He53wL8w81jHXyH36S5aKjz6PFjvFb1vjrzFzpKjMjFYTF3/HcgVcutX+Q7ELLrAWGVwX34FR3UW388vrpCUVqvzmKMZtjAwN3ooTYhsRWfFmxD2qPql6c9EGUa3iOa7FuTklr/8V4xn6rpZWkyrcj5si94oz+CkMEfuipv29O2zIMtdn2dApq2VpEXYAFxjH8QYR50AlLZuRdj+RPU/3niXkgYxo1gA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR08MB151637
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008B9.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9a8cf523-5232-472b-4094-08df099d0c8c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|23010399003|82310400026|14060799003|36860700016|1800799024|4143699003|6133799003|10067099003|11063799006|18002099003|22082099003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: OSGcGydMznQ0XucK94mduxeBg/QFkAA/FjAlMKLIhB+HZ8P/8eV9f4o5UFUCj76ClbPy44kCn149KcwQUjiU0c74lYci0bJMIVHGlifUmSbiCvmHF+KPFNc3PUzPZOlUu2yXxvvPiisiXnjgXpN73zHDz3Oinut1WNxumGmb6hhoHKmHsUuAuhu+wfezI4cf6T61eBbHG8DjFIa8Sw6I5Xao5Y10emAU4/S9pasLlloWCqYnngzWNrnSz/WC2koOZieev5FqUY9jd/gMCxv1/7FX0lC2Sf2Mx5cCCCtT+2rfp/hwxQ3Wlq0ZW8akaPMd3fKT1tGp6gjXLULUC8o9Eg+tliL2CUUMYVAgUfjVYcer/e33lrQR/Ni8e6KvZ8OWAcYZxNDBPy6gvzEIiNAfP8N8nE1oLSRbjf+koZPz+ZvixcRF1WajAmhjZLQhV/K2EKarVqYXBeT7/QBvHi/Bg5KBsUHxuB3jEFdI4gxFyelUi8nJGkSK91EYXqEFR/3M++uuRSHUAeI4ZDJ5VUp+uuAhSzUXl3ShtFVf+zinNJs/jCYicPAVWgo4ixIh2cp/aR4ulfuBTFwkVW0GBqR3rRceqB7nhoSfxw6KybCpMsOldNpnkdib1YQcUyYrCVlI
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(23010399003)(82310400026)(14060799003)(36860700016)(1800799024)(4143699003)(6133799003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yfy3wG+kFQYJ00Kz9XbFlthVZz4UDgHz/mp3mSy7oAiAqawEeuxVcI685iAAggXdnUVUDFc1d6FcNHKHgblBKi0+7h72U/lTRQRzohlFKFJbnuaNoRH0FhMKsKWWvqTYtmY3HY/aiAN4PrrfFb39DVGZys9NmZEzA6VBKRxQwY/z5iLwjziEP9Pm1VLJE1+cZswGHUuf3St7LYKz+4g03rI7AdBwac4Rk3MT/8F1cBE20ymsSQT2/X2gy8n1PE2nYnwz2uY/yhMaistVDWcgHhioHgTzMeMsAtvCgI90C0VLkX22Zk8cOV+h1zRYAF25FtvIvlu0o8XdIPA3SqB5PCzKClYbmjgMz4Ul1GoXqR6karYNJNQ46lDNA7vTYJ/cYJwOVYO+QtrYDGai6uErurCmwK84BJgkyejBj/lNv/YkXPqsxsmTdnAq7aclqtzJ
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 09:24:16.0595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4176f5-8106-4977-c4bb-08df099d200d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008B9.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9910
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

Hi Esteban,

On 21/08/2026 09:07, Esteban Alba via B4 Relay wrote:
> From: Esteban Alba <estebancalba@gmail.com>
> 
> net_ip6_handler() checks the received length only against IP6_HDR_SIZE and
> then uses length fields from the packet without checking them. The checksum
> is computed over payload_len, but the UDP handler length comes from
> udp_len. A sender can keep payload_len correct so the checksum still
> validates and set udp_len larger than the frame. A handler that trusts that
> length then reads or writes past the receive buffer. The DHCPv6 client
> copies the declared number of bytes and can be made to write past the
> packet buffer from a single link-local ADVERTISE.
> 
> Validate payload_len against the received length and trim len to it before
> protocol dispatch. Validate the ICMPv6 and UDP header sizes before either
> header is dereferenced, and validate udp_len before reading udp_xsum or
> calling the UDP handler.
> 
> Fixes: 1feb697830ce ("net: ipv6: Add implementation of main IPv6 functions")
> Suggested-by: Jerome Forissier <jerome.forissier@arm.com>
> Signed-off-by: Esteban Alba <estebancalba@gmail.com>
> ---
> Validate the IPv6 payload length against the received frame before protocol
> dispatch, then validate the ICMPv6 and UDP transport header sizes and
> udp_len before either header is dereferenced or the UDP handler is called.
> ---
> Changes in v2:
> - Move payload_len reconciliation before protocol dispatch.
> - Validate ICMPv6 and UDP header sizes before dereferencing their headers.
> - Validate udp_len before reading udp_xsum or dispatching to the UDP handler.
> - Link to v1: https://patch.msgid.link/20260807-net6-len-validation-v1-1-edff271cbf2c@gmail.com
> 
> To: u-boot@lists.u-boot-project.org
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Jerome Forissier <jerome.forissier@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Viacheslav Mitrofanov <v.v.mitrofanov@yadro.com>
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  net/net6.c | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/net/net6.c b/net/net6.c
> index 4cff98df15..e1a455748e 100644
> --- a/net/net6.c
> +++ b/net/net6.c
> @@ -392,11 +392,19 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
>  	if (ip6->version != 6)
>  		return -EINVAL;
>  
> +	hlen = ntohs(ip6->payload_len);
> +
> +	if (len < IP6_HDR_SIZE + hlen)
> +		return -EINVAL;
> +	len = IP6_HDR_SIZE + hlen;
> +
>  	switch (ip6->nexthdr) {
>  	case PROT_ICMPV6:
> +		if (hlen < sizeof(struct icmp6hdr))
> +			return -EINVAL;
> +
>  		icmp = (struct icmp6hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
>  		csum = icmp->icmp6_cksum;
> -		hlen = ntohs(ip6->payload_len);
>  		icmp->icmp6_cksum = 0;
>  		/* checksum */
>  		csum_p = csum_partial((u8 *)icmp, hlen, 0);
> @@ -421,9 +429,15 @@ int net_ip6_handler(struct ethernet_hdr *et, struct ip6_hdr *ip6, int len)
>  		}
>  		break;
>  	case IPPROTO_UDP:
> +		if (hlen < UDP_HDR_SIZE)
> +			return -EINVAL;
> +
>  		udp = (struct udp_hdr *)(((uchar *)ip6) + IP6_HDR_SIZE);
> +		if (ntohs(udp->udp_len) < UDP_HDR_SIZE ||
> +		    ntohs(udp->udp_len) > hlen)
> +			return -EINVAL;
> +
>  		csum = udp->udp_xsum;
> -		hlen = ntohs(ip6->payload_len);
>  		udp->udp_xsum = 0;
>  		/* checksum */
>  		csum_p = csum_partial((u8 *)udp, hlen, 0);
> 
> ---
> base-commit: ece349ade2973e220f524ce59e59711cc919263f
> change-id: 20260807-net6-len-validation-cd71efd96a7f
> 
> Best regards,
> --  
> Esteban Alba <estebancalba@gmail.com>

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
