Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4A2606A31A
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qSND0s5v;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=oYML+OM3;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=oYML+OM3
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ABEEA8104D;
	Wed, 21 Oct 2026 09:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7SVdbQUYwygg; Wed, 21 Oct 2026 09:51:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F1F18101D
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792576313;
	b=Ilcg13UQmNmgir4Hw1SC+YTi0ZOGOO3VT4sJ2Zt2vleVVYQ4Xk8GtjGuhYnOHIr6kdGP
	 XP8rIb39VpCoj800sHDqfaw7eRwOZk4T4j7eHbXiGgUVQQRjdr3h+vg8Z7Cs+ujyy4PiD
	 uJUqb1VMcp5infm1iyndxN6zd6GVqSkI5XR+Z91alNvvEcl0i4jf72zd57cQFbeW5TsfQ
	 JoJ3rs8ZkPdTBl1k296Kz0iBXcFNW8wNQxkxT75vzgsxCvS88MDPOFRyw1qmUuRAKjs7K
	 XC/hUpS3KEURZ3efxRwhwgDeHfx9M8sRA0meO3YgHmiisM8llqs5HSVO01ZdIE/Qmyw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792576313;
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
	bh=0DDLCB87zzxH9IgRz5L1z82Ac7pJQoUleC9+u704NKo=;
	b=NN7f+AZX8cwoGvUwnfzAYXRjbaZl7rvnD33br0q6DtMivLzizn2JD9YGvEfYjEiKeeri
	 bcZt9QfPet29cu3UEUeQ405rDIOUyx+dfkSkqMHFzTNbbuwXRQca+hS+/+UZErtSPXpwK
	 ocP00OVkYXtHSYD2GzNJ6ZuufaBaeiqnft3Rq4KrncvXsAa0996xffhj7voE1VEGzbqdu
	 s0/AYZQqfLB2XY9xyYQZnXpnpzLRbSGV9hUDYNuq31RgAJDO8gAd1kjPUW7Qu19pqE3qd
	 X0y6FvZiqNFzEdjX75ythoYLOvlWplq2Wq+vJuyiMhOXURVfqN6aXCLzaryRXBzXCig==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792576313;
	bh=0DDLCB87zzxH9IgRz5L1z82Ac7pJQoUleC9+u704NKo=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qSND0s5vxXjPRhE/ik5x6cTZiaSW/lREi9DKX2MbpmB8zWc4JVF2pFtQXRqTKtHiD
	 hvI+uIaiX/xlbucYiungTj66wiWFHNFC+tW9ueNg4KJq/FFBFw8IS4RPprb6G4/T79
	 9m3rDuYXYU1Dq+CVQWtBoJKafglUuT5ZTPjJUHD9Q46eYayyj2/UMgU7Eu1I/WVvEv
	 wfDGbo7ac/GH4cUoc9nRT0DVuI/QFMcqqd6mw9An9Af/oyNAlMKBmmx9OIHORVjHvB
	 bG5MhN3/0YdLSXhMq3ZsjhXcUY8PPWvkwwzKJ/fiFsFA3ndVsxQ1yeyut6RnQ5zhXM
	 hg/qzWuXYmHBQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F1F18101D;
	Wed, 21 Oct 2026 09:51:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 230C51E9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 14E73606B6
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mRYNI0lKdjME for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 09:51:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 836DD60661
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c202::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792576311;
 b=Janv21Xq8zMv3yKE9LI2UaT4B/EVzLatv3GjxZqedVlIIMQRaSZrxHaFBoUdKgWJNS3r
 hL3ZiSEQ/bJAWhLHAFfeOg+2sMWqKHWiFcOlV6KlEr/JKQVlnhKycJEXC/4fsAL/kG+gD
 SU0jDkHIEj2YwjEDAD9Sa22xM//VzSbIb3neTPPUqEbR8Ws2hLlx9uhIkZn7XujDiVLuF
 1Thy9Wsn/ZISy/ZJQdV2Y8WYv85PQYU4p3wgFuQGO4O/SVqbFMdo8H3P6NEcmqC5LRgnG
 +2JigTi/jqTyFXOXZ4KTfkSvQSxBZ7LC7BxbCBuUSPaE37LuV4vy+QIgU7qkgf5pkNQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792576311;
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
 bh=0DDLCB87zzxH9IgRz5L1z82Ac7pJQoUleC9+u704NKo=;
 b=P5tBcsx8NQN/ar0XlnEF13Iv8iAtSIB76GMtUn2rZJ8GV/fA+07+a6wuRFH4m3ENvLpr
 56Mxcz593783jpXbcjc8b2pzYZoTAEVFNOHtIhTb8EMLMUCF3PvLK+G3aMeyhm8IQcYF+
 YsGX7PSL/8F60NZK6QjvdFY6p+cCN8Kpn2ZUz3g+MrxcMLfFIW5PcGv4BSo/j6wMZO9c3
 9P7lpfI6DktRV2KO9oMbe0vlGtAKviHaSXZHwU1Tn2XHrN2bLGdNYPlQYCSpWoAS60xlE
 I73wucakm6z53wKsCDkxnHAqXLokiD1QABPtQcy9xa1zW/PD3huiaDQkPk3fzHZ+zaQ==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=oYML+OM3; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=oYML+OM3; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c202::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c202::7;
 helo=gvxpr05cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=oYML+OM3; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=oYML+OM3
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 836DD60661
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 09:51:48 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TI1WlT1fX2d9A072ucS7EgSVvBWZuazZog/hY/lxt+qc4geYY8V6Tmwi7eSDzoTa+SH4WHhF6Te2vPkwTEL0dIDz8iO3cZl9dUoI9nC+2j2FVHCE5NX9q1ktyQaX3N9ucPuxaGYj16ES3xQdO3XkTEtcmNaHBsb6baXJvR8KtFet8lXDFUje+KRkBbtJCqjj5GPOnv0gJAelih9ng6PT8TEVtTbvBzdw2QGxL3TxE04z1VnZ6sWJh9mdLWseAS61n8JmLvnXvHbn2bfZUMHUCtWVWlNu6c/BKO1hmwAAp0eEdyE9jhft+MCd7kuTFcXAfWJ2YRBEwPgiHeAScajy3g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DDLCB87zzxH9IgRz5L1z82Ac7pJQoUleC9+u704NKo=;
 b=mRKgsoqoH6S0/Rw4/PUkerLkPrT0yej4gY4prjkCgkwpgbps/D8XS8lblURQseJY+9mwdKchBJFrm1oCJxHQwLgKqD5buFpJmzRXUd9LKLCClNjEOVBn963+BerzPxJ13Yua7e6mWUi/GuXkNXd8ftKB27WrE14RC/3DTay/VVmWtX77bQCTOJrxYpNnHR/p0xR228zoyE4nyf2CEIkZsXHS3ynQjG7ZXkeCNI8qQviF0j4X+4ThP/42J+Pt5hVPh1ubAH1B3JBrMUSPUOin1lfj8AFSn20QBtQWpuck2JkQFcHmbkYtS2LvHZTddqIQxC9/3tOAYRO8mh43qDhVew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=9elements.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DDLCB87zzxH9IgRz5L1z82Ac7pJQoUleC9+u704NKo=;
 b=oYML+OM3190t2WqoXotiwc/Qa6RbwIKLYrP0bZmckek0ZtAm5YHOYtHlu/oq9cdIqq1aNWwZYu02IuxxKmytMZNhM5qrd67vBelOsgxNbH0XkC94VOsFzWlqZnEOZgeC6OKm1CDuiy7Co6EJSLl7T1yRwM61ATZwpix78izLoXA=
Received: from PA7P264CA0280.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:373::8)
 by PAWPR08MB10044.eurprd08.prod.outlook.com (2603:10a6:102:362::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:42 +0000
Received: from MAD0EPF000008C2.eurprd05.prod.outlook.com
 (2603:10a6:102:373:cafe::68) by PA7P264CA0280.outlook.office365.com
 (2603:10a6:102:373::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 09:51:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MAD0EPF000008C2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 09:51:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G8pI64Z6AQ2i968Xl6l6RoilE9SK80Wqoyfz5OLHCHctXCo5Ex3nUoeC+qLVVFP6v21IvSmSR18pt/6hVsw3mzHCnuotSTuKKbdiuaDjMQ3n4L/lG+FTsv48NjH7x6zOtyH3oUUPu+5j5MIKCik99avgHGha+V+1WyKez26IpD2jP738TYgzUceYsza2FG0PuzyNbd7YMR7lEcTM4yOwovjKApgSKP9+Eos67UWcM0lrIXnpEWf/Gw+P6mw0gUq6WX0c9r0TCRhdg27mxX2bGZtBfMhtNRsprkutVEfvEwcT3x8n50QpfKIV8RwAesJS3/MzuYFR1NWcAp8Xfxf8zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DDLCB87zzxH9IgRz5L1z82Ac7pJQoUleC9+u704NKo=;
 b=v3K0cQh6UazDkR0tUGSQAmOcNMLlgxAWbWxR+c/KMOOfM6hQVPDnqJcqtegoeY+/xtWHUsXy8QaXOijRrT10V0JW3kLilAG8pLJwVPVfDerYdvx+RRfdR3ZuxwZywmMXWcpo6vBlzy8AYK8DWMNTXkD8CCJ75OBwVGWAu9YAwPuwyj0D+yyCktxWU0FOCt6uxfODIGBnaFKK5v1xRZnlCbsgwogjbOqJEOGImsJo7sncg3TiI6e9T9gun11SYfkQcvCLI8poCjy7v8hEG4x3orjZTqPGYHqkIO442wJ0B8cUJ3e12PoRFm+D/fDOQUJTxSKthQDmUQg6PUHxXVdQww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DDLCB87zzxH9IgRz5L1z82Ac7pJQoUleC9+u704NKo=;
 b=oYML+OM3190t2WqoXotiwc/Qa6RbwIKLYrP0bZmckek0ZtAm5YHOYtHlu/oq9cdIqq1aNWwZYu02IuxxKmytMZNhM5qrd67vBelOsgxNbH0XkC94VOsFzWlqZnEOZgeC6OKm1CDuiy7Co6EJSLl7T1yRwM61ATZwpix78izLoXA=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB9977.eurprd08.prod.outlook.com
 (2603:10a6:20b:636::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:08 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:51:08 +0000
Message-ID: <ae79a6aa-7947-4a5e-9d26-e2d294422df3@arm.com>
Date: Wed, 21 Oct 2026 11:51:07 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] net: add HPE GXP UMAC ethernet driver
To: Tan Siewert <tan.siewert@9elements.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Jean-Marie Verdun <verdun@hpe.com>, Nick Hawkins <nick.hawkins@hpe.com>,
 Marcello Sylvester Bauer <marcello.bauer@9elements.com>,
 Michal Gorlas <michal.gorlas@9elements.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, nd@arm.com
References: <20261015-gxp-net-v1-1-df7228020150@9elements.com>
Content-Language: en-US
In-Reply-To: <20261015-gxp-net-v1-1-df7228020150@9elements.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::12) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB9977:EE_|MAD0EPF000008C2:EE_|PAWPR08MB10044:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc9f397-8859-4ca0-f78c-08df2f58e8c0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|10067099003|22082099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 8o2HmdWCSMCSilcAHC9Nd4mI4dSRVbtMSJjLZNMOEuENb187XW/RNo59ncvfJVaFHDzdubodsrjLqarPqytw2km38mHou4J6n5PJlySRuAvD8cmg6+6E8rEuIV9lUAzeHYMqfFnALuBy8g8JRbuZ0BipMnwBarIGo585vafS1XJvohZRBCsgjDTPh35OF81MCAZEW7vWJ9Y3fQm4CIfGlu+uS1h0kTuRs3N0jphf5LEMwCAi2BTWK7YLMa5o19lEthCcDLkHeJAWZeclBAjzuysSiXvNKUB6NC7ULSip7LOmUkGe45LRFGyQGf1OIOyK7x0snEBuj4uKyAjjBb95487Xk3bR9vzhRLKXhkpuZfXWLLpPadBh7NJRZI4nL37kMXxgHRvLRKw5SlcRuGGK3KNZGBkajtdQ2ecXfbq4/iGJ0p+A6dnGaxQboe9cVfs/RzohR28nKKY46zk9DSCKtCdmrv+eyx5Nc01trWYaBOnp01VhDwD0tksFVwLH44gxYNyfFbQ4CrgW7r+9n9KsbNLhI4sxdzyQ+KfCx5ufah9tILDJpztJaOxEqQWy9hmLPrwR0IWbcaggawYdadvPPo1SMTw3Ruha1rImrmjSQl0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Nk0MQZ7LXuESFAM+zP5WgyYLloRfhMrdO8PNYvwI/4r+vVmLcXzjm/Lu5//Yyo9M47mDPDjGMeIz+EpO6HM7nt6aKGGISmpPQFbildJfaPCI33qb/pbFGHwFhZ1uK0j8v26156B0VgFd9UzPaxeVKOa+F8PMNWSejdJ1x2t2ZEdIAKyyK/jHC8H590d/ZpOcNPdtBcFUES5Z9wdfMgPj0biJ/VODKMDAysdxz0bU7PPyy1KlI42V8btZY/gCb0kKCu9/+dw9eHaOuUwKD/VhuHoVDscmPqAeCCiskfP5oX6uLSD3dDfyJtuECh80dm7n0cX52bXxAHC0HKvVPfTK+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9977
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e640e0a0-5c34-4279-0859-08df2f58d4e2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|14060799003|23010399003|36860700016|35042699022|1800799024|376014|22082099003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ye/unGDcnk96wgFZBamcLQjsthwWMhWmkK6rx3OxiJ0UVMA8uY0uTMyx+2otIwVrONiK1/I+XwVh4kIXWMMNHGMB0Lfh3+EuxujwBV4orjG/lODifAyrmij3AgqSkCF9+KEC3XlqymvALXnEM5uMORbQhD2B635KgmYz/LvxVWxGpFJBcW+GSGceSZvIgVE4Knr3ymZADFZx2JBkglVCXd0LrFcvINAFpJ1FxDfn2vInOBCOGWlRThoP9rrKWhs7JUq797box/4gIefeAR4QulbQJ7tO83LKFRkV1j0LioCxNLW+F071J/Wj5pDLMqnQxHsMh6QliAgz0II7ZEXReWjbWetFWRC5vEhooE8f3oOl9os2ClJmttU+jwcISGIRM6fS2r7OSdzrqUAkntL++aSmgbOErEf/KhN77DinlaaFs8vviKg9gAW02NO7Mlq/sTkp+brZsJA4dwxLgif2BnjrKdm5O99gHEtLxbum06TIdjTJynxLeGa/EIdKs7OLGfY/nuTzBrJIF775FUfO66PdeVYO4T16nHXItKl1OlPgPrpk3Bjmsd2Js3WyjDG0+FFcSDcN7EZyBodnI76cYWb9aU53NtUcciA5xQ7354qy4bT+c5ZFgVxCeYndEb7AgQTbyymoCVOJnmnYgKdgpA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(14060799003)(23010399003)(36860700016)(35042699022)(1800799024)(376014)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oa/NUAFRcfCw4ebvtMVviOWL0R29RSpX0XDwWG8sqQCKFGQaye+2rMQ/7B8jqFZPn/if8vSoXL5mLU+xf8NbVCS4wkvGrc3JwbLJuZ3NwK7Tt9zDDrZD2By9OYMnftEUVUKtS9mbIHebg1Mf3jYN5dyQOP6TxXZP8qQ0Wdif2AZTv+HireRoXkrgokwd0wip7j4FtnxGYrXervBqE6/vD5M4ezXNl+QfukiWr2eoN97VLmgf5aimsPr658kPR4vEgMcaj1KeF2PHp/M9ohjUx6gU163H2C3fFi/aTgGJq7yetw7yTI28mxsLSz+FELE/qgY9HgyPDzi6E84RudKFdfcpz08MhOzS/YqfmgreXjHXaARkOOrxQxM3igEFvlT0jXhlr/YYGH5+WOze11ZWEPuTxtb45x71G627RUy0Y48pbwNDxJhe2PbGAK6q1TH2
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 09:51:41.6447 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc9f397-8859-4ca0-f78c-08df2f58e8c0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MAD0EPF000008C2.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB10044
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
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> From: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
>
> Add ethernet driver for the UMAC controller found on HPE GXP SoCs.
> This controller is connected to an external Marvell 88E1415 PHY via an
> SGMII interface.
>
> Co-developed-by: Jean-Marie Verdun <verdun@hpe.com>
> Signed-off-by: Jean-Marie Verdun <verdun@hpe.com>
> Signed-off-by: Marcello Sylvester Bauer <marcello.bauer@9elements.com>
> Signed-off-by: Tan Siewert <tan.siewert@9elements.com>
> ---
>  MAINTAINERS                      |   2 +
>  arch/arm/dts/hpe-gxp-u-boot.dtsi |  24 ++
>  arch/arm/dts/hpe-gxp.dtsi        |  42 +++
>  configs/gxp_defconfig            |   7 +
>  drivers/net/Kconfig              |   9 +
>  drivers/net/Makefile             |   1 +
>  drivers/net/gxp_umac.c           | 572 +++++++++++++++++++++++++++++++++++++++
>  drivers/net/gxp_umac.h           | 136 ++++++++++
>  8 files changed, 793 insertions(+)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/1] net: add HPE GXP UMAC ethernet driver
      commit: 0d44fb722858541486f71d3c89cf3b70d6a72ce9

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
