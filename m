Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA690C88E4D
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 13:18:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 99CE6808FC;
	Fri, 11 Sep 2026 13:18:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R7U9dWsZ4TgC; Fri, 11 Sep 2026 13:18:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E37F680F24
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789132711;
	b=UvdHRUBkwD7SItxxjmfJ+k8DZMrTpPVr8tBCv7ASN+TE+gy70QnDj1ZS7b6/vGydldYq
	 gM9jNucUjCBcXuaCwCHOtFOYIDdHdCOxpwawd1/tq7mR1nLTuLLbXPy5CQsHax3Fv7OJE
	 HeHLu5fnXmPPdpaiIJ16anBRrHMAKVSp8B0zXt3vhuG+lOwAzJ0ZH3sGoVV+Rvr0sYUvr
	 OIhNThGkYW9GJQMhqxVIdWEAk4M+iGVP3/7sui+3u5AG8vrDvAjKw80oqqPH3C3hDNLL3
	 Qtna1p4xkoCxC6znogd0qc140XatTcJWH5r+ko1GIMH1vqtxQzltfpvBKRPQg9Q9klw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789132711;
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
	bh=7L+Au+cZQcFsIXueZfNWDxiqoVCOE+fIk6Cbvkswg1g=;
	b=NZWzJHJzclISOdazWAJ/SMP8FPftsOzCX8m63ilpO7kR9ghzBZVQkFKizgjwSZntdfGo
	 V2rRr4GNMZyj40HYiDBg2c7f5E5A69vBLsLHOKSm1CvQLDd9tewEKLhmAGRigZYb9vOke
	 UicVxFBO0EIX14w4wKuiGUdf68yXqGFtbqEQu3VYSUewJnsVxysSlUV3ykCQTgbb4JASF
	 twC4VOZRbzKKTGZPTn+nkf2bzHMt7Xh8dx+PNE/SaJ8nUQ0pFGUBRSc2GvyaIek3Tbzq1
	 rw3vRDbNrcGru6o0aOxJZvS7AGRSWVNJNqQlbv7u8YNkjY1aUP39zyvXRPEnOByvDfA==
ARC-Authentication-Results: i=4; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789132711;
	bh=7L+Au+cZQcFsIXueZfNWDxiqoVCOE+fIk6Cbvkswg1g=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RfjEv3+1Vl9Tk+4Ol6oeX/sJCA7mJ56oxKoo8XVpVhwAHKi3maNgneDPvp7KSry1K
	 9qJzzIgrm2I9joSyPZRxU35EpJ+PnOb9bG8jZP2HLfWg4ADu/9S8c3Sl2hGv93Onrp
	 q8GlmRUKm90sfnWnl8HCSdslzTRgTcgrsF1c3dC39qf5H3D3n7GJfFubqv2bTuzvv9
	 2cLc2lTjfPerEEKSoDKGrYZ09hgh67pemsHWQ+EQdp3kk1LFLQpXWXeIJiB6pA1I1O
	 BKoyaLI3F4dQtY8BVcIk2N8wwMo1kXGYA7xgvq6Zt2XVJAwq9ECYR6iNzvUyYkXaWp
	 YuabdF/TDPe3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E37F680F24;
	Fri, 11 Sep 2026 13:18:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AFD63701
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A1C554080A
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1GO8tc84YFOz for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 13:18:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C82B040812
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789132709;
 b=DZrz5DVtjD7C+kMg4WRNBBuw9P4CbJH9hUfRW9Bw6pWM1X45lVJySpyCleiDsbuTiVWo
 LKh5ohPjDuHw8n1TZ2z4q8b6X62DR8T014eA73XCCFemwI3Cg+DBE5JlnnfXBAiNo02zi
 4xIR3GVazdGPGE0mfr80zxUxJrdiW2b3Y8sy6pFRrUcYnV6/Afy2KHKxDGFYAzEpAwc0K
 AmndL8XIaGkpjjv2cGdmnA60nrh9weQVRV7QU5mplLlQMjUqRmOfCWbu2UM2vHOZ0qmrO
 +Yml8kJuG/dls1v0GcRhH2+k059KOtFULUxvpRY4Y0pjfp0cecp1rOgRMH8+yqfiGRQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789132709;
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
 bh=7L+Au+cZQcFsIXueZfNWDxiqoVCOE+fIk6Cbvkswg1g=;
 b=F4PaQkLC6QzG/fPwTh0RmpcTI3a+VOrrvyh8GmBfqLjOmXJl2pYd+5vEAJfQUQd81zNq
 AVGH1jTivWTcAsnJlhdfarkuBohnWIasaYjYSWeNRZ+EtNx2kfTFVWJrmF7vH/foDZeBT
 aNEXb/55AJHH3odoZYsuHkGp6G+Vev8MJq42kJ6mdM7m/VGJV41CV/+Bj0H7hSF1N714Z
 fMGnd6euuGM/DByH8ac5DkYgMbprHn/9i/toyHMo74o5Le+UX/h1O2jb4V6j8flFDJz+L
 VKJFZRRnQwUe2ntAU3jwE5EnBqARm7RgZGKuDCDQ5TigrHZPUU0CVyPaa3mnzz+gNJg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=XcBlAoa+; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=XcBlAoa+; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=XcBlAoa+; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=XcBlAoa+
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C82B040812
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 13:18:27 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=TMvSQYoRvRMhFIKcQnl08DW5hhWV6Rwe2Dno+nuGAfzMB11RWmAfXIXRiGjGGjCRUJceQOLdVKa389WPuHcYfRSpWqUsgAL0zAiCXbC8RZR2ztAJbYw2XaCyVvZBrZ3yA4/rwtEa/iKy20/LMWxR4kROSK/hFxybMzFVdbdM4qJWIifSplaYs9atg0O3Av1m+eCTu+0CEzfOg1fKER+RDjWRwuTlnZPNwGcjovabTqkd30/wSMRIUlwcL/vA5LzJV7Eo48R/Ol8P0yddM7cDKt8pr4zcRCjeAMK4fGY8xqJuyqoIjgWgdWnjdvnjjf4TfEmHwJdEmjrHWo7qojp6LQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L+Au+cZQcFsIXueZfNWDxiqoVCOE+fIk6Cbvkswg1g=;
 b=gJaA5xy2i3QrC7utUOHxVanx/DjTyu1oso/WAZp9VORVHrr5hpJxCBsOSmzkNnR10sSxOdiJcw+IpohIXehvTfRTLGHtAnB1hVV+GLGZLfcm98ATtsWYRZVDqiT1me49Tk7JuIiZGWGMTx6ayjXChuSibbXTuF1NYd7wD71ikSCut5dNBM6R+0il4szIPo/aotM6g9Ah6zEHQryZnZ3Jzb5lB2RYZ++3wyD5Z3O4W+GZi/MrVWsGdB+nSBlNFMFKZRTLYGElqOMt0eQucxPoJIZp08QmVlGNkTNpRQJ8BQtLPInF+Ce4ItjdKwQyedMzgjPFuRX4Z+qo64IUO7NkxA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L+Au+cZQcFsIXueZfNWDxiqoVCOE+fIk6Cbvkswg1g=;
 b=XcBlAoa+VSSJPYMfx4KBp4h1/o0Z6OHMGKj7Nxmb35REhopff2XtSLF2Vhp7vH8DLcAklGgJFAz++d1MUD60rtdv4CzV+6cEtomTIvdSwz6zLYk7P1XMclzO72U0Umxw9AIVqR1ufcLkHkxbKvKnPAw4rPX298Z167KlLBKWkf0=
Received: from DU6P191CA0001.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::11)
 by DU0PR08MB9822.eurprd08.prod.outlook.com (2603:10a6:10:445::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:18:18 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::51) by DU6P191CA0001.outlook.office365.com
 (2603:10a6:10:540::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 13:18:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 11 Sep 2026 13:18:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib5F5FN6IPzJhHEILOmOAlPYMyhldh1BoFSgpYvLkGTAgTDoecvTKIzbPztoc/EG3lHga0R83y+B9Kr9jZYGsnDy8l5EKcyDGxIyI2pioDREQaE9r1KsgTFW9l57PhAeASmvKZ8gz0qDYSSRgtTpRrhpXmhLYiQ2LKLOohnkqj9DpjInGi7SOIcjCA36D2RDUyimn7jUBW1BKFYwbpusmhgBOrOZImDdhxX5joEsqwu5hVrnu/bvOao3QjnRk5RGkG/hnp5JbOyUBZEq4gBqEYCdV+hteyZbfF65nO0xblOjIq/B42iiXT9Bi7XjD5tFItfRBBV7XcljLJ9M9s60wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7L+Au+cZQcFsIXueZfNWDxiqoVCOE+fIk6Cbvkswg1g=;
 b=LnK2GnSm+CZkSWpEPsZzyJDR1Dzl2H/KEY/HEm8rHd3XozYZyceumcowW3TwHyPqHVR3DnKJj9Hi+IRYD2crPBUba/h98h1qy/y1W4tbRtwnRErz7XTcwcv1yJ313s8Cj+o0r9Iq4R8NFVMsbqJVVVtetY0OP1KcJv4pkDxvdabJogyAWcjaKBlBRD2OXMFNchm/hw8SjAIJrp9oJvL0CxmtpIsWjc8UtvLzqPcTcXn3Q5meJzwJOg7YIZxpmdFrj8qwHVdOrbUyJZ1uxerVXbRVyUCWiuXRfQC398kw8wlNXR4Ov+HcQ8GWqaWxYTHjXqEY/wGxRUbkMuVCb8AXtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7L+Au+cZQcFsIXueZfNWDxiqoVCOE+fIk6Cbvkswg1g=;
 b=XcBlAoa+VSSJPYMfx4KBp4h1/o0Z6OHMGKj7Nxmb35REhopff2XtSLF2Vhp7vH8DLcAklGgJFAz++d1MUD60rtdv4CzV+6cEtomTIvdSwz6zLYk7P1XMclzO72U0Umxw9AIVqR1ufcLkHkxbKvKnPAw4rPX298Z167KlLBKWkf0=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB9224.eurprd08.prod.outlook.com
 (2603:10a6:20b:59c::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Fri, 11 Sep
 2026 13:17:45 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 13:17:45 +0000
Message-ID: <cb8f99df-66fd-4d33-bb50-8c474f8b2458@arm.com>
Date: Fri, 11 Sep 2026 15:17:44 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH] cmd: ethsw: support lwIP
To: u-boot@lists.u-boot-project.org, James Hilliard <james.hilliard1@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Johan Jonker <jbx6244@gmail.com>, nd <nd@arm.com>
References: <20260825-submit-lwip-ethsw-v1-v1-1-fbe6142e5d92@gmail.com>
Content-Language: en-US
In-Reply-To: <20260825-submit-lwip-ethsw-v1-v1-1-fbe6142e5d92@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0015.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB9224:EE_|DB1PEPF000509E9:EE_|DU0PR08MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: d8ea632a-dd96-45de-acaa-08df100724d0
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|3023799007|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: mV0TgTbkPOed7PhvIym9po0MQ/hqswzQafc+WioCDPsgfdlFwsPWnW19hY0g0ICBENdjTaAKIRBqsXdoY6l9WpmmBUQQ2cSiexieayBwu2X3gg07p9nDOm2Ace8DuuKMF7oNZoWD/cMrp7dDzKCVU2TxzUAo4LbkvuFc+TFiMJXOMSqkGQowRq8x8OtD+p2bTsaKPeu9Kv0Epnw/s6moGUZqc42Wk5PRhk9BRB4/f6FCIrZguq/TKSo6BbaCu1ti3gtyazVEfTHKy2xFC4ju8cuCUaf/AnlYemxJGESLihB//DQ79ostypvIbuW4PLhGQZhTRw7wSEcwuITeKVinJLEJ5/YGrJ+4Ga9nSWX0ZIkTrbqCjnpcXazt4lX67oXzj4aENhRDBc8rBKg0v2QNL6jwaPtrETBf+W59MfbdJUzKsyJhbt8Glma9ngYz6LEjbirWKtFrZRB7UOZQmwMyQ+T43lCJaBarhlEZJP44KLM2zWxq6vlX3cJUJlMzTgyb772epAImC8xkZNftNix6NLZ4is08DjW1uQX3A21Hlib4QcdBlYbwgLl8Rs8+LiNrYUcLfHvAHuC2esQ325LIPDvWZLgM9ay1bIWcuqHiWxiA9C9NMKRQ5LqjNWSMPQ5ADqdSRMrr4t11J3CXGw8V5JQ0CWJkNFNjvL4eoED+Rzs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(3023799007)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: gD0FfQWw1vOveD7U8n6lWOSJIupwikmqqe3fWXzmqLs/WkldsY7bR1pMXB8AQmdjFh/2G80wEPxU/CMntUpwxf3iknGM9jZfnmWPPCHNIWxMl5Bj2cTLtm6I9hWDodkWAEKxYV9hJTj+EAvn+/p3W5OIC1Cic/KJevWw49fG9NvwCeu5ZrfjUGbylFdexcUtpBK9bSL0nqjQQJePXmxmx3wKBYCcw0RkgrxJwWjUJoIopRxUlLwld512p6IbPu0Qj3x5kCeaxG+XCMV9J6GZEZyeS4kKGARx8ONNqVY7ZXqjXrNBSSVa69RhJIITxExdjcGCvb9jGpD3tQPQfc/I8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB9224
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 14e9d147-f974-456a-28e4-08df10071125
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|14060799003|36860700016|35042699022|3023799007|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rMuDexJH+xmokl3q4mmY1EsHvGvEErvSHJeu/f7+g2G6Lp4d5SDW2CO9lvsc7amSqn5DmMbBExFTwAp8MnM8hPjtbVka0UmpCVAMrQX9dSTVvDofF200Kv9i7N8S9/LqoZdn9vXnEwPuFLBAHD/hWSQhfGW09AdDCCo05cBZVMwqSE7F8x6jb5F8eJ5G7IZ0SjX+/6Iy3SPU2vl5PqNpvXgFfNVcLc9FzIIoBh+Z/UxconsZ5L3oCcsNtOTKyv6dVIoj8bXKQo1grdnSq2l1/4e+665kYHe9RVPKJM4LIdxd4KLGEe9aKKnnP+FhJPo3wHbm/OhlKE6KDKrKeamBdDoa1RLYZi173E0FmnXfiK0qVBM3CBqL3/8K2ae0z9EAt7G7iKuckYfs4qnwusNFUrhydXLH2Qh31y/m24ZaEBJHey0WQSYb+Jvcjj9sNP2vn3gTnH70OqpGDtrBAs/DDOlUEyxeYrNkuqlAWiURmcZgVFLBahZQvz3wjx0prSitP5/zLLX7K7FfMSK+3Dt8E4IcuAv56xykwNUp4DUZ6b6cKyRYRXL33z0StBNR6xBUdprytTfmYyFyZDwshUiKc0DjqFLg1LyGyWIxzK6Wr/xvzisIq9yVpMNplXoxTOqSK4U2oO7RqXf96RclfoB38CLmgLqHoxhtFrfrjOqcgHO+Mk0VTad/HE9ukq/7C9lJFntJwqNkC9YKrUPr9Y7wyg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(14060799003)(36860700016)(35042699022)(3023799007)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: N13bje6SUouAXwy/oSEuwb25dzVeqeqSGR3haSAmboZpfyZaZlYYzVDY7IS5LNgwrJkeDZVMh2bTu+3K8gONWYCR/B7UxBvd+G0hhEIlrMXEsvfOgEbdcDHEvB0lDL0bbRajx6tCgpHBoLXEMguo1YGaHk6B+lBltWY0sKmmo5WVJuAdPNxBBck7WKLXzvW89WnxEtezlvrqlvjA3T5ufqEx0viR2lqBpLJ5FVT4aWZeNAqNkJDSH+Qo56mcE99G/FzsOPRQHWLz03jz+dyUA/nTLz5nOSJb4ExtaFdcN/kLeeS4AfHMwBnJeZyr5BCLIRiu+r2zsqVie+hCleZ35iS5mWwWsaHlUa+Pcwp9dWgx9vNKq540hcaa/IqhXzgZqS8Ek99iAbTAqArAz3qG1k/FBIMbAf7hno9tKYq9Q8ynRIlId96oCr0eNeBYlK1x
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 13:18:17.7391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ea632a-dd96-45de-acaa-08df100724d0
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9822
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

On Tue, 25 Aug 2026 12:11:38 -0600, James Hilliard wrote:
> The ethsw command controls Ethernet switch drivers through the switch
> API and does not use the network protocol stack. Its Kconfig entry is
> inside the NET_LEGACY block, preventing the command from being enabled
> with lwIP.
> 
> Move CMD_ETHSW outside the legacy-only block.
> 
> [...]

Applied to u-boot-net branch for-main, thanks!

[1/1] cmd: ethsw: support lwIP
      commit: 1979d7e76d4d8b6f6eb62fc26a320a4af24d3fa0

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

