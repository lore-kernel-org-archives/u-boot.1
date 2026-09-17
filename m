Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8505AC982CF
	for <u-boot@archiver.kernel.org>; Thu, 17 Sep 2026 13:28:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3DDBE608B5;
	Thu, 17 Sep 2026 13:28:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id p33JJxxnSXwy; Thu, 17 Sep 2026 13:28:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 68831608A8
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789651723;
	b=Qj4cSgmzcH/bhL0ugzznH3FJf1HYib5FbkCvtlC4vQ4DJrkcwchdyoAmJwZ0lBjgENMF
	 4seWlrWI2OYx4DD1eOfRjcdP40VFqcLC86Mo8L8IfzRhtHVHCHDRv1Mx1Wrvrrp8Ra24K
	 HEE0LxXj8grFDAJu7ICo17/y32/q+9QH0i6xnvzB4A+/mbKvtjHTlLgsSBOGURZNpCR4G
	 NAjaDnJjS5teA/PEb9gVs3ioKgZA3OkZSzda0QtrnicQaFUa4VZGWQ0aDR2ILC1m5WstE
	 VThZgoVrtna7eYYTuq5tdX8TQdAEAZiMs+N0mWD3Nbb88uc6bURQOITD5WJPSI3T2XA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789651723;
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
	bh=9Igt7RgBztvxU5CuV4bCicwAyKqYvjAzw4gpCM955hg=;
	b=d+BtbbiY2/Bw7gjrgLTWDR2WIrRU82GETg1akADQM/deBE/3WmCdbIChv9ZPa0VZitz6
	 VvJmdY+pWxLuFvj6B0lRx1E2/QwwQLTG+GPYBgk1NUl3/Si3IAsXd2HcNbMkcZqkGLbZv
	 04w5q9uaokE5DKLhg7PJFN1IOtjT9HhEJdf+ivHGvzFoXnaY3ktRc4J09dcNi0Uvd1IAA
	 sRPHwMpDeDG/ca4ZgOxTFtp+HBppFSvKYAUsateQrk9vukP+JyfOMKTCukqrgg766eF2k
	 YAeyhd04zzQpjFWCCm8gXf/1UR0/bp2BQP45flWppMmsXXKPWs+fzL+SLEdxP7elryg==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789651723;
	bh=9Igt7RgBztvxU5CuV4bCicwAyKqYvjAzw4gpCM955hg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Fb4UOOR08XblSEdwYNuGoUu7nTYSBHO/3izW4Y+ms7Apv3l8s3zREQf79/uLJiEX7
	 zuRocFIPJdHp4EQtrb7k1YojZtOu55xfgkr9zqZmxF4DvJCz0zzzUCjrhpbg5BfYEH
	 uRt53TWT42cWx3vIE+EL4CSF+70Fd/yYtSUXrx7cwFUPo68oQFKe6hHQL0CoboQbSE
	 pz9W4Xs1jfrdg1N7wDCPdrkd/K3CZG3EI5gpdKrLm7I73sqGyZnFD+CWXaBugO9yih
	 aS3h/BJgLK/+240gq/CT8MbulwYtyRwiUFKSDWe96VhPWEuXyZacpMwCQlt0CknpSe
	 RpQ46gVVcJxxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 68831608A8;
	Thu, 17 Sep 2026 13:28:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 76D3529B
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:28:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5BF0140346
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:28:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6jOrY5SSl3jE for <u-boot@lists.u-boot-project.org>;
 Thu, 17 Sep 2026 13:28:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org B4F164027C
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789651721;
 b=V8v/TCYpeQI0HsXVWgHoY8Q+3i3FK/XTYPoVHAaYA3I13igIeXmTA08gMWFalwTTZXjw
 oE0qNc2CZL1ZIqha72kqbDn3YRAngqaIte2EeKeicJhGNzcGsf5UIUJtFtA3WDNnsdimV
 Yln5gQ3yu8BwoTpqClkVY/30CKnB9ob9tPoIaLyYiB06Bm5MGn82swqmgzATKNPBcO8Rz
 Vn6u4ozBb5ea90T3/mqWwgY3okQCNztC7BEVLZ4xJnDHDn40QT8SBo7pTYbjnHFDR5muJ
 ckWqT0vwFK0PLzbYZxjHDqgodalIb4h1BP7/qDs/37iV34gkeBAp70WfTf9X7wkU5XA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789651721;
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
 bh=9Igt7RgBztvxU5CuV4bCicwAyKqYvjAzw4gpCM955hg=;
 b=CgD2/prG8NKWgNYhDgvh61En+d5DOeyGXy5xnPvFKQ8QrtVmuawV4mPd0XjTgiWlk6zn
 wPZ/TbqKmwqTsV7oawtO0mmj/ZMI2MvC1AO+LEsE4wVvmrfJgUzxRhgCw3pUEO3fPC7nS
 I7NPH2oWfl+DoS1BcuzU2kt5DPm+NcTcNzvi7zqiQTYZc4ZSXfXPsBMBKxd15sCKukyMl
 0Rlc+JVabpFqW3NfeRZYslydZsJU7vwiCw4YumBX3yqCFaI5CnVZ8svdmNopblY94Q8uN
 nYPNaZNzKwcnoQ/Vjmbbtf8VfdU21G61SiE2EaIrvqx+UVf16zwCLz9kEtxLXgd36YQ==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=cVrMxD9C; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=cVrMxD9C; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=cVrMxD9C; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=cVrMxD9C
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B4F164027C
 for <u-boot@lists.u-boot-project.org>; Thu, 17 Sep 2026 13:28:39 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UyfeItl9HFFOeDYZ1gwTgLAyU40lZgxFycZoNB3f3HGY3QLeiuW0GiR0xiNMmQ/kdaf75aY0GMZDorhV1jwONrKKUSWBMxOzLeFFpIBFlpzNfQiLlcMAOGjxPPsrg1tXUzpA3/mwyCwqQ2Jpvbs4SgzgusTM8nW0G/eveQajbPIBmz+a8nUDiDrVg2mm9qf+kVxSaxtQaiu6ltsdbpELNrR9AgbxEnMXppLpzeyNGP+5qeOptR4IxAl7NqzR0ojynOoixdRdVqI9QXc2DKnfC8KgmJ9U8xzI46L1JiNHZm9flr2vHVKo0cSFJ8x9itzJjINOG/0vDw6qkBpUO60uXg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Igt7RgBztvxU5CuV4bCicwAyKqYvjAzw4gpCM955hg=;
 b=M85uWpTIAa9MbAdxNCE9+B4Hf6CoB0Fywar6qH/C7iHW0EUyBxHsASwRmyTXkIAOYQmTh7W+VoKPRNlXe3Ms4Hq/LcN+ls8ztoR+Z0uq7NpRa1tc04cUSD/r8d/shuaVqqirLa6n2QlsT0mX5V3T3pdkuVzKl7863edBDYTG3u5D+HiGOpvhouM2ihTcVn0LbDZ0yBj83XkEcJcRG1dhuk8FVBLHgm9W7UBzlNNFbiHiRZDmjKve326178YYz14u6CVcxWQ9Q9uEZjQaSlEH3B+hu1/Fdskhi0+Cn/CuHUtxhp4QLttSTBYEB4AzAo1sDjJqE/XNaS1fXLRWUyq5QQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=google.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Igt7RgBztvxU5CuV4bCicwAyKqYvjAzw4gpCM955hg=;
 b=cVrMxD9C940S/gQeGg1AqrIXY7qKmRYvIHuDSByIzWa4ohL6ET+s/YeK1gL2nqVu2Ct78RUwyy80voAD7WQmB1aO7ZUuyhnQswade9U8qhRa2XP/y795U3/JniyppZ3P5oRkhRgrQ2WlOeysbh4v9sa776VB0+V3HQ35C2W0/2s=
Received: from PAZP264CA0085.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::8)
 by GVXPR08MB11094.eurprd08.prod.outlook.com (2603:10a6:150:1fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.8; Thu, 17 Sep
 2026 13:28:28 +0000
Received: from ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
 (2603:10a6:102:1fa:cafe::51) by PAZP264CA0085.outlook.office365.com
 (2603:10a6:102:1fa::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Thu,
 17 Sep 2026 13:28:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B3.mail.protection.outlook.com (10.167.241.90) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.8
 via Frontend Transport; Thu, 17 Sep 2026 13:28:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAhOGylDGwdKjOEmmCAjKCmxXg7m0lybjASxT/I1KtsD0ixd2ivAq/sVzZDhzhd9m9/AuSaYswGD60NIMN46aemowr+6U/PmHj8Ha6+3IjklYlamvEq2ANRn7PRA57AKTF+6PMhD41WjkTBV3GYmHqEK1x11U2ZjbjwfAcvREL3cb7mgOHQz1wZLKvRf1hO0jnVIlMC0o3TFmebcgar0QiKacHDxlyV3ctiAp82TZkCfKVvVGT9BgSv5ZOfNFbh9tY+3VMhBZ54tA5f0wakm8IC5Hhs6f7mNfG4v0vHRddJoBwQ7ahwpQki6ebKMD7s8sBpA2YWLqAYFeV9Z4PGqZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Igt7RgBztvxU5CuV4bCicwAyKqYvjAzw4gpCM955hg=;
 b=r9IKktqwkvaNdqtq0zcU/t0TAnT4S9+i/JbrLZ7vLOt/eSGT3j411gKHVf+xjBWa92cP0A5DBBXgRmdTTLU8hc7yInZG/B5oga2nbMwYbgZ7i81PV2ttLtqWUnXfNHqnm0qRnNKzbOuJZ1T9d1HbUEYuVp24nGBYQRc6AAzJEIlGIdeQHgVl/N4qZXJoF6ujKd4sJpzZZSyGqDlZzWpL1WFa+NSq8j7zS1cPzDL3jxwoEFDkxE9toYRjafCEfYtO5sBCUXedcz0w15GXPHHQQu4qCR8vetiR2OPmr9Q1kaIILTRsEpDrkA86p0CxjEypABwlT85ol39aQ3BSFDmHyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Igt7RgBztvxU5CuV4bCicwAyKqYvjAzw4gpCM955hg=;
 b=cVrMxD9C940S/gQeGg1AqrIXY7qKmRYvIHuDSByIzWa4ohL6ET+s/YeK1gL2nqVu2Ct78RUwyy80voAD7WQmB1aO7ZUuyhnQswade9U8qhRa2XP/y795U3/JniyppZ3P5oRkhRgrQ2WlOeysbh4v9sa776VB0+V3HQ35C2W0/2s=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB9PR08MB11922.eurprd08.prod.outlook.com
 (2603:10a6:10:601::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.5; Thu, 17 Sep
 2026 13:27:54 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0451.004; Thu, 17 Sep 2026
 13:27:54 +0000
Message-ID: <7d673713-eddc-4807-90e5-873b572a9497@arm.com>
Date: Thu, 17 Sep 2026 15:27:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: dhcp6 use link local address
To: Yuxiao Zhang <yuxiaozhang@google.com>, u-boot@lists.denx.de
Cc: Joe Hershberger <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, nd <nd@arm.com>
References: <20260910153255.1.I1473cc3e9adc7793245927386e6fb0278d9ae4af@changeid>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260910153255.1.I1473cc3e9adc7793245927386e6fb0278d9ae4af@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0066.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::11) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB9PR08MB11922:EE_|ZR1PEPF0000E6B3:EE_|GVXPR08MB11094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1430fe23-778e-475d-1125-08df14bf8e94
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|10067099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info-Original: ZeCU9QTQo48tqhwt+4VZzyjF+9cqbh0HL5oQU67FAEdMJuQPNrJ4+HCSRHDpAnnhE462SDxtrceR/eK8SGJboBJhaEAjD/ag4T+IGTulGaK+LiwyL4ziXMoM69nQAfunpd+mhyj7oGDPLHnLZDjrotYCsCbJM0oEltIcHR8CLdA/Fy/QGruWzDyFVsWnh5rWrZgifjjKDWBLN/TqZS8kGODpeqkcSNkw2Q1TDh0Vc0fKCmgIuasjWjbxC9FzdqxFtUCG/jSD6riMuz7xfwtGx00XphDLqUMnid/79vYdVVSb1UWFXZZbG7szlGFNq9rQTCzNGEClD2pUgPHJnvMbqEjWNdkLVhxLT0X1HRiEw57X0iilk6t3uN6aKHizpI8838pnzNiSo5JaWow3P3FvbIj/I5dEq7QKlH5Zqt5twV+NaAsb/B6zkDsKITtw89++5P7hMoVSy+sQMke+PqHsO7KCakYV+DdhAeCes9s2Qtu23lHAN/4pVlUPOrJihn2q3ly3XkOxhijhggyY+gFISlTm7veul70B1VgsAUq6QhiUZY4O3/0Z3hbGGuLaxhMVREblXobWhrmpnC0q1CTPHB93Twza3eWIb3W4W+1ZL3i/eXXSnEwilMeGchnLNTrfMnFvweILlxktHzonCCreGXJDYRa9Bgsxa9wILpDahHg=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(10067099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Zu5iZI+dyghzc8mR+VVSA3hNs6YZ9rqi/gnIGVkLPPqDTCc8654y6Jzq0ptH4dRZfUMCtrS5d87bEv8/zMS8H/WibJo8G18mx1pjWD2+VrKhLvRceWdIB4oIwLu2j61v8ib4Nfydi1tEJMk9yTiebCZfVARd9bdv/lDD4fWFQIrtBIpUqEAAAGm5k2k8S0u8kO7p34W3m8Y9BjEH1QWtOZzWopFK4GkwvApgO2yr4Q+sSsSqSfvr9QzhRCrzq/WMXb1fVeVn1BLakjHFOIKajkevgzwHstNQnuUZjrTozU7+eSlni4Ox31VMvRa0s08cAXvdB+H0xP3t8mo0lHKKqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB11922
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 02f2d60b-b191-4755-e8a8-08df14bf7ac5
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|35042699022|1800799024|14060799003|36860700016|82310400026|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: qeA59hDk3Zp6/8X+qiBnZVPNay+LKrDRPOHLX23g6BIePIEDywVForMryGM8cUc8TZudFRIiQOyD/gqbnrDcACezKgwkWGCMGCrwoTluhNDYJJIqPRqcMDyvB9OSkCe2Eo7qQAmcyhzKFKaU6V+T0hb86kXH2lLfQs20oPXsURzFTW/zVWH08QaP435LH8RFrhXMqIeDM1D/gtHjQj40XNuv5ftmVfeoT9o4dxm5h/wF2JdrCOkbCcaTt6VcO+689/DjuksxnB47xLy6BI3Fvkdp8g1MqxNVNukPkCiFNEIYMhzlYZQgCL4Grguh5em1Crj7Dfe/iBDcGqGUm7XFXlXyqhI4766PrI6pMq96dHz3dLU8z4PH7j8/wp5oKEF1R/N0frYGjZa011C5XhLhL7Vw0gvxA24GUWcfsdfVx3WkFGeGjSGHmPR2Cmo2yNCEdGPN/XX8Q1VGcxaapfMLp9HOvYUWFifFvuXM0B7VIl7qsIHFY++EJxUVWGohLq7sRs6jlBU1veji1/YhZNwWmddif9fYMxs0akScOYvs1J07ysVhV0v+Um7pTth+zaSP4MACLATCm7sXVc2OCxiU8J08m+jZyHuAN3cWB0L9Yq+vz6whPYCuITwoME6gpn9lrd/yFW5G7IHR7E/IPpXKBYwzyoW0NNBnzQEkOBGz/VUJxG0bJHFoZ9+oqFIbSZeQt9Fs26TFzC6OzT6tjjEbjg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(35042699022)(1800799024)(14060799003)(36860700016)(82310400026)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OkPSVUpj+DskLN3Chh9PbcXeZ/A1TzXnzCnaxcnQnCCT6uKymlhdTnFuFc1yfQ9Ek879WqgSlM9FiThTmR9L8uFQ4MOFXJxg5/sHofS52PG5nmvg8mOAIzxYKesXvygn2JqJO0Sc2uFTKV7QLWHANU1X+FLsMoYGW3cSEVGvwx1nqXO/Xekz8aoR/VprJuA744yfGRYyreH2ZigvjwPOAZ8xWcRPVmLtrSVjgehIq1G2wnnndjJ1JeXbCyYgCfU1yniivtyEkby4L94xS3riqZr2r/9pXk8TVJ2ofDJRiUxkmPaCRg/PWmXLhkhPTVRGp3c6H2WS6CAOEtZkJmL5L7K7u02bndXHWYh6OnbZh4dIuYkLKi4Bzr7IZkTJJuIhh0IPdh6KSirVrfhso1+DLUyhLOJ0rD+XlMM9l85kKEN6PJUR0M/pOd3ZFh9RZHMr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:28:27.1725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1430fe23-778e-475d-1125-08df14bf8e94
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11094
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

Hi Yuxiao,

On 11/09/2026 00:32, Yuxiao Zhang wrote:
> dhcpv6 is a special UDP traffic and should always use link local
> addresses. Only pick net_ip6 if it is not empty and if it is not dhcp6.
> 
> Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> ---
> 
>  net/net6.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/net/net6.c b/net/net6.c
> index 4cff98df15c..18072bd9f49 100644
> --- a/net/net6.c
> +++ b/net/net6.c
> @@ -330,6 +330,10 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
>  	uchar *pkt;
>  	struct udp_hdr *udp;
>  	u16 csum_p;
> +	struct in6_addr *src =
> +		(dport == 547 || ip6_is_unspecified_addr(&net_ip6)) ?
> +			&net_link_local_ip6 :
> +			&net_ip6;

Rather than special-casing DHCPv6 based on dport == 547, I think this
should be based on the destination address scope.

For a link-local multicast destination, RFC 6724 source-address selection
prefers a link-local source address, so something like:

struct in6_addr *src =
	(ip6_is_unspecified_addr(&net_ip6) ||
	 ip6_is_link_local_multicast(dest)) ?
	&net_link_local_ip6 : &net_ip6;

with:

static bool ip6_is_link_local_multicast(const struct in6_addr *addr)
{
	return addr->s6_addr[0] == 0xff &&
	       (addr->s6_addr[1] & 0xf) == 0x2;
}

This should fix DHCPv6 while keeping the source-address selection in the
IPv6 layer rather than making generic UDP code aware of DHCP port numbers.

What do you think?

>  	udp = (struct udp_hdr *)((uchar *)net_tx_packet + net_eth_hdr_size() +
>  			IP6_HDR_SIZE);
> @@ -341,7 +345,7 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
>  	/* checksum */
>  	udp->udp_xsum = 0;
>  	csum_p = csum_partial((u8 *)udp, len + UDP_HDR_SIZE, 0);
> -	udp->udp_xsum = csum_ipv6_magic(&net_ip6, dest, len + UDP_HDR_SIZE,
> +	udp->udp_xsum = csum_ipv6_magic(src, dest, len + UDP_HDR_SIZE,
>  					IPPROTO_UDP, csum_p);
>  
>  	/* if MAC address was not discovered yet, save the packet and do
> @@ -353,8 +357,8 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
>  
>  		pkt = net_nd_tx_packet;
>  		pkt += net_set_ether(pkt, net_nd_packet_mac, PROT_IP6);
> -		pkt += ip6_add_hdr(pkt, &net_ip6, dest, IPPROTO_UDP, 64,
> -				len + UDP_HDR_SIZE);
> +		pkt += ip6_add_hdr(pkt, src, dest, IPPROTO_UDP, 64,
> +				   len + UDP_HDR_SIZE);
>  		memcpy(pkt, (uchar *)udp, len + UDP_HDR_SIZE);
>  
>  		/* size of the waiting packet */
> @@ -370,8 +374,7 @@ int net_send_udp_packet6(uchar *ether, struct in6_addr *dest, int dport,
>  
>  	pkt = (uchar *)net_tx_packet;
>  	pkt += net_set_ether(pkt, ether, PROT_IP6);
> -	pkt += ip6_add_hdr(pkt, &net_ip6, dest, IPPROTO_UDP, 64,
> -			len + UDP_HDR_SIZE);
> +	pkt += ip6_add_hdr(pkt, src, dest, IPPROTO_UDP, 64, len + UDP_HDR_SIZE);
>  	(void)eth_send(net_tx_packet, pkt - net_tx_packet + UDP_HDR_SIZE + len);
>  
>  	return 0;	/* transmitted */
> ---
> base-commit: b4ac71db13a33c4e6532c60a781ddf34b7f4375a
> branch: main
> 

Thanks,
-- 
Jerome
