Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BB5CA9EBD
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 17:05:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 172C940923;
	Fri,  9 Oct 2026 17:05:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4jBK3oBoJjZR; Fri,  9 Oct 2026 17:05:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 59AF1408CA
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791565509;
	b=lW66xohmh0+/zAW7hBmkiIIfuKbyHVZhjOsUUbRXnC8C5YnSNdHYJXkHa8mY1EZkFcOy
	 PBIRr/pjxPDOTXG5bO2ZE35rzSv1GeV+VyzbpDg7keMaQviesigVqtUgMLCxi90IeEl/r
	 CsO3q6mrMHN7oE9i+xlztOvg6ra730/BVTlQXL37Kf1WpJw9Lqt72/Ayr0XRS8QvV4u81
	 MNI0YDC5mWjzgCE8Xjm8Pa/LfsM1Z2VypmRCA+v8vkurnhVjlPt1fY4qVi3rMvVyRYtDq
	 tDxPCQaVOyYicW5YywYBBNTEoT+cHJKcXhuRu3lcRRdKTvlOvpyFcVvfueNgm1SmBeg==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791565509;
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
	bh=9JOrYf2N/hcwpP6juxHmytj+nP0TAS5/aDY+mZx6qS4=;
	b=n3qis5Z2t1yG5Q/MgwRrx+AZLjVG0k4Uo5mKyiuA2Hm9hz5c1SgbYmyN9rgfnGkHYVH0
	 rdnzFFzrAYOb9LGE4yhRj5TfVE+DXEwdIgGFVCyVUZsct1Y26cHy94FdLXOrW1osihBmE
	 6e5TEedvj9sfYWnXL4sOBCXxTrdZQJuPdUxb8XryvAtbB/BOv++kfHqbvmK/Ixjo8p7oC
	 DeLumw5Yl3v4vHBQ4AlNabMgcU066nBrPbalureORolCcdxADk0E+QnXZMccYB0/ptXJZ
	 1Lkn5J9TvQjc+8Im6I7eyVrpNdqQs09aN2zsttYhfYKpVKXNQB3/C+7rnJjlnAId89Q==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791565509;
	bh=9JOrYf2N/hcwpP6juxHmytj+nP0TAS5/aDY+mZx6qS4=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gbDVqg6+hMreWVR8biK21D+W1F9OOHPxAaHF4gq0/mCnANQidBVehFtj92HQ0ybc9
	 7EjcdNq6cFSoJ8Tiwv/EOJuAifFEObenvVXiE1vs6hbP+x54sZYYFscvLKGABsbV5W
	 bhgc6nIWn2Bs8T6kQrxnX4wwcNp0McDRAdgjnCwRUCGritrz5fQHWaLagcTlEZ6NK0
	 znVWyrEwBl52NjlSHink8VlS4gfzjffIQNBvF8f44PIKPqRfls5O8kVID0LqLGZR3I
	 BrWMCt/yQc7KYUFFm0IuIL8jTABdlIzkAC4wdNcVYwfOEfemTBGsAGeV7r18RXXPHE
	 mne1GLvAVXmmg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 59AF1408CA;
	Fri,  9 Oct 2026 17:05:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 84EF675
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6B4A6400FD
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YcIadLzjqNni for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 17:05:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0DCF840050
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791565506;
 b=PGYC/oi0hMwB1iNEoKFJjKhQI7xbwnstyJ18jLQ8Vj8e+juBPkO/D/HqCYgyrkrT2Pm3
 IqGsUHmsmRcJZROPrLI1TziONVsY9ln/gtQSccZTmyVqzAr8iFRdz7B3KlNhzrP3vUCgp
 0bGR4GzK4IFoqrNw9z81AY4eA0mU4qbCLmIRgBchpNylKzM2RecPteicVmIcb2z/eP1q3
 iOD3GQaTkvvUC0lqpCdLNMiCoPo07l9AwPpkRLKbtRXDWf4kYXZSbCkrgQr4ssSkO5q0l
 /eJoZNacT2BwipPhc2V143U1i1ICBJX8j/MHPBqM7k5M1NolmNltAN6Jt1NzAtiRhQg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791565506;
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
 bh=9JOrYf2N/hcwpP6juxHmytj+nP0TAS5/aDY+mZx6qS4=;
 b=K7HU7JEN/cz/mgkphqwtBnfzOcIugrei6keI38C69Q4ULVJAFOrDvVAGj9SichvGwrCR
 Yt1cdeu8BvqicvtFL5NBFwEmNy9f2HO8vD2NqN3AX/NLkpw9AKgtwszhUKTm2puihpAU8
 oTZMYY18DrV9+BKcAv9pT3Vnq1DWHEcl/hH8pBpqChUg2F4faRkaNae2vBtFpw8MxjhBS
 pGckcE20Fh25/qPqKQDcNJtRWM3YaT7D+K/Adw7tyaFLhUuq06jTA6Gg9xjrhffntVBBD
 uw/9UNrUswfkDvLakSI3Stw2fZ8sJzE3eWg9EaS+53dtO8lMwL3Bu225dSA+2zKfEYg==
ARC-Authentication-Results: i=3; smtp2.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=gl9ZqXLf; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=gl9ZqXLf; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=gl9ZqXLf; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=gl9ZqXLf
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DCF840050
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 17:05:05 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BhELk6aIoT6Krdw5bMoaQH7aclyoc/l0m96yeyfWWb18uPPlzvoada4vTbmdkMZnXh6CkxJvCn3tWZfWegIlVVf85nSvXAVxAmUqha/wyCD0E8ye7N8gjBiA0+WmLu3mRMPOwQJXkjz6Z+PFVygiB5lIxTjBEA+QFH8nt8sdnNr8dyaa+c8UApcKII1dddXN633nWn4+dIZU2YutCxA4DwWO1L9x90b9SCULqasASFr4gLeMuyWGLjku5Zqonh7o4ANdZhhy1hYDMEOMp6z6Ijh2hX5iQiEtD7lhjKMpEo0CULyzMv47UOJSrIaSsvien2qm59+PsQprXSJcEMcveA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JOrYf2N/hcwpP6juxHmytj+nP0TAS5/aDY+mZx6qS4=;
 b=s2aZ0xQ/H4F5amnHtYZzGm9dixVlvGp9K9NhfO73EwYx37h+EorZtuwW0nPtfr6yQSTwJoucWda1C7u+vg00Z31gS49cRgitkfnTDEDjRFwRgU3bZMtdVbp4u2PLbcGEn9a26EYQGLFWJQi0zTjWeK/vO0YckATSMIHj/P5QGRuret1EoaMVaIhyXtCDK/t4HXf5lHeWhtmOaebCCf9p2bjj/Vp2rMIYzgkNo5X4xMsF+J4gaPlXkopM4aF+z7tHf8rvnEPYf+vwGx0o1UMnLmKZENtZtaDOpZ/B9aJWqXz4bY1lrt8zsingU/aiYYHkKBxFJgsK8ZoAoUIFKp1lCA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=arm.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=arm.com; dkim=pass (signature was verified) header.d=arm.com;
 arc=pass (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com]
 dkim=[1,1,header.d=arm.com] dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JOrYf2N/hcwpP6juxHmytj+nP0TAS5/aDY+mZx6qS4=;
 b=gl9ZqXLfeR3QpyKRJfDMmOLzT93xySamG0xZt0vSuNVfDVc5j1L12A/1ez4XBZ6rpvh35ZKB0YXR5GjI6iKhisKEp1Hxs+LYT97aPJHOzrLkriAamT//g/fHCAQvgDTpWemTg6yyUUN4sYLtvjnc0N1nlAnr14dbDnuNuhTpBqs=
Received: from DUZPR01CA0341.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::11) by DU4PR08MB11152.eurprd08.prod.outlook.com
 (2603:10a6:10:570::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.5; Fri, 9 Oct 2026
 17:04:58 +0000
Received: from DB1PEPF000509F7.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::27) by DUZPR01CA0341.outlook.office365.com
 (2603:10a6:10:4b8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Fri, 9
 Oct 2026 17:04:58 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509F7.mail.protection.outlook.com (10.167.242.153) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Fri, 9 Oct 2026 17:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNmzzNvZJbqTl+JOucYb7JYiFJlz5qqyqsOMzmuY7WR4E7HhYMC5NGcVoMp/4D9o0li+I79ZZxZQwX4d3kOEWVIQLVWekdo4/zEhP6RMpKtcoFOZjoxVJzv0+XqiK58JBoZ78FSYqdSAIKRgXEQqarneU268Qrm/SjSU6vePcDDH8i8+/tjgHizNza0iF+s8RLe99sxI4V3WN18eCcCyUI5eno3pE/ff9mxxNwvooJkSpZfg59elwHo1e2qIqxX4X1YGG1hxKh3ZXojDd4JlACWRml0SYaK5DI3MVz2RDl2rTGEdfR8OhuhNrTrxmToeK2P0zTPIdpZDVdl/h0RoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JOrYf2N/hcwpP6juxHmytj+nP0TAS5/aDY+mZx6qS4=;
 b=E49RpMnG9bqmJrRN7htfxVnIwSxO41pWlAWLOx2bEcYbbB5z9SyJbxVzYrssBFwfOH9KeAFifC8PSBZU0hfLJvWXNMXAzP7FjXjm4hmwwqpNGRR5qKG371mvG8Fp/sMeFYnaDLKzRHv6gjlecz1ZOhiwEIIDhX5VYrAnDHdy1wltx6yDBfOCaKNLwPP7+e6tZf9+xXBdQWeJ8MyjtT3TXBx34biRME305zsI5DR3KQfW/sAF/iouTcLR8Y6OwjPspWClrWJa0ihwQxaLRZYmgKzaXiBfHeQg+TYVKgsI1wal6jaNDncG6k6+O7z9yB1vaqcXlsp0Z5jjEuY/FBYrsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JOrYf2N/hcwpP6juxHmytj+nP0TAS5/aDY+mZx6qS4=;
 b=gl9ZqXLfeR3QpyKRJfDMmOLzT93xySamG0xZt0vSuNVfDVc5j1L12A/1ez4XBZ6rpvh35ZKB0YXR5GjI6iKhisKEp1Hxs+LYT97aPJHOzrLkriAamT//g/fHCAQvgDTpWemTg6yyUUN4sYLtvjnc0N1nlAnr14dbDnuNuhTpBqs=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS2PR08MB10251.eurprd08.prod.outlook.com
 (2603:10a6:20b:647::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Fri, 9 Oct
 2026 17:04:24 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0496.010; Fri, 9 Oct 2026
 17:04:24 +0000
Message-ID: <057aab81-4cc0-43c2-9d16-36c36f221e8c@arm.com>
Date: Fri, 9 Oct 2026 19:04:23 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 1/2] net: dwc_eth_qos: bring PHY up before triggering DMA
 soft reset
To: u-boot@lists.u-boot-project.org, kongchen <3305708832@qq.com>
Cc: trini@konsulko.com, quentin.schulz@cherry.de, nd <nd@arm.com>
References: <20260922141641.8624-1-3305708832@qq.com>
 <tencent_945BB774784698678ED0EEF498C60A17E106@qq.com>
Content-Language: en-US
In-Reply-To: <tencent_945BB774784698678ED0EEF498C60A17E106@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0512.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13b::19) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS2PR08MB10251:EE_|DB1PEPF000509F7:EE_|DU4PR08MB11152:EE_
X-MS-Office365-Filtering-Correlation-Id: 9aff79c8-222e-4243-5e13-08df2627722e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|18002099003|22082099003|10067099003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info-Original: o0Lf9GmP7chfCW8DNFlI2F8fGYqJfcFkksPhxd0pfxaKC8uOj/Ls4q4mRORGvc/qjUC7uX1WrheVsjNvtIRToV6nFvw2lgL8OUY5I4VSIVEp4fWfEmmSsQDnnqMypvo6klat4R6qoMzKVkkxVm8mRVWVFA+OvoFVBfOrBX7cXNI56fagdDFjlpfQTt6vjjIHw1d+S4MvHP5I6MYHve22suR9BtKnuP7ZpSjwspeYGmu1sVXy4SNWl03kQVj5UC2qe2UC1A/vQB7C6de0HbpDBIE7VUaoQ7Cgy6vPEA0TpaxqEPX4mb2aL2vvXJuwMOzPk8iwvDHGXfBxip0nMIHmplr8PmcEmy1sAegP89eJUmsRWpwNwuWLSD8JoOjHpXwi4VINedTiRDuY6hsHunf7JsZ2+fINlEh2tgY9YfeAiI/pvQ0zZ1MlrZZrlr7kkHnLqZWd2HiP6aaFGcyMwLn69BRXxZquqt/KMF/HSZKnmuwA78su7Rq0aYZUZwQOZeaLdG/ZOga+49JhRtvEremdvLBKPfsvHJzZSOynLSnQjsTaPxU8734r8P+OAkR99YtFxsMBek11u51CnbaC2sVG2+iD6LeuutpdshA7ZtsobtdQnLTMBt0iNvil6OE1XykrIp0Rkzwr3GD+gCCxEV2Iw36SRH1tBbjEqcTz737K7F0=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: pelCY9ascZVfL/25V0faQU/WnCZXrRQ1PrreTnBuNEuZ1KmZ/j6RAQwxleWsjMdpafuUHFRgejc1LfS6d3uSiC8eC3qFJBkySBqauJmN5H9aqp1/LkIppBciiPQhKDWjOonOrE0//dE1VNBVBVFOpFm/zRHp+ODdhW9Uv8NUf4oZV1Uh21PuLH8U/opxsBq1evuhxd7kfAwbERaaoAbseQm22bKxGwRaoHkGT2xpFjLrsxY5jtRfYaEllzraS9qK2NXDJn22hsrWNkF2GOi6e9Q2Zreuc/zq58vwy5YimtYS3D5thIbjkZYulzMATnej4ssmYWmFu3VJMvFRwQoYOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10251
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8169362f-6920-4bfa-e466-08df26275ec2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|35042699022|36860700016|82310400026|14060799003|23010399003|6133799003|18002099003|10067099003|22082099003|3023799007|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: DtPgSjCrjs66Z3zc22cCDInmIkJHD6YpZysjDCzQsfVoS0H+BP4lDJoYiYMcZ2HQEOw01fPUellVYVeQlvzlUsDVwy3jh9eZXiE4nwdVTUv/MsbZCPbT7UEFgJtozhB73sGz0XVu8R2Ffe0iEsLjd4ECxWp1paPdnNBq/HJUI9R3aBtOiN9NSG5LMmPPYxQ1Wmsku2T6DtIdy3AxAtzsfapJY34kveRLtRF/U/jlhw3+73/m4ysvcD0Hgx4DIpQQ7kAsxD9Rcl/OpgP6qDNBQIf0q4sdlcXafubndd1fRlj2PPtVQSxBhTwgBXlDyPGkBzAGcffGrdw7ut4PZib9qfPiwvXhzqZ0u/RtsuXJI4Jv1rtGqc533GL5K4Uxljti4AzXyyVIOLiDLoO+N1k5Oa4AZVjvgSNlZ4hkArppJnKpatEDVDsbg3DvHG1GzKLw44tEY96+/cgFex09GlvTH/1v3oo3tdEMjE2z58NT+nMDGqmrc3e5YUPFzaBj35sZqMlkFgiPtkO3OhK85/wBO3mj0sUua660LlgTlakf7zrhbIoHYIlj/kEmtw0KeMxP9MXVaYUyNQJA9Nz7fRQYRlHL+4lKVQEC/dGlkF+X/9502ucbKVp2pO9wRq7ncOqoJZEVsK+nP8XpuwTNTAxWBUz6GmZBE05JCQWXo72KLapY2EcGeR466VkaVaYjS2cKW49hB5MrRjkR6bIyFgKrYg==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(35042699022)(36860700016)(82310400026)(14060799003)(23010399003)(6133799003)(18002099003)(10067099003)(22082099003)(3023799007)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AxF+sro8s2Y6+dDfUlcNPrN6m6F4PtywBhlLRe5+pNbALk/SYpTZHWUqGxNvbqSUtyYyvE+GRilbga/dew/S2W9Sjz96RNDMAkgt0qEkl7JHS32oYUx2//vRs90bEJnCY0e6ufAe5uoj28zXuMNApxlhHCCOIUH4ZmQt3vS7smmBaFNvk1ZAAO3lz0pI1wGBitLM4d5ooi0Um8twtVES4dlEV5WdWCrXoVWQW1iwJjDQg9ru6NDpoxSbdOvCoEHL/tEb9l7P8MegKHDvycDWVUVzqqvS0H3PsRQasgPP1XOR/Ix6DknF87+09SSeEyYTUrKmCDPehxGzWysfluQKzlzL1x6wSPyAwoYCJ/YHo+AXZql4YxRhphpD36uoj9whCvQVvVR/9G+hTw6YHX70YyOoKUkGTVNV2bX8u7hKh3xqyfaW7XU14Db/wtqKqsSr
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 17:04:57.0145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aff79c8-222e-4243-5e13-08df2627722e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11152
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

On Tue, 22 Sep 2026 22:16:40 +0800, kongchen wrote:
> DMA_MODE.SWR resets the whole MAC core and only self-clears once all
> of the MAC's clock domains are running.  On SoCs where the RGMII RX
> clock is sourced by the PHY (e.g. Rockchip RK3568), the RX clock
> domain stays dead until the PHY has been brought up: PHYs like the
> Maxio MAE0621A need a vendor-specific init sequence (crystal clock
> mode plus analog tuning) before they start outputting RXC at all.
> 
> [...]

Applied to u-boot-net branch for-next, thanks!

[1/2] net: dwc_eth_qos: bring PHY up before triggering DMA soft reset
      commit: 1a5da2d56fbd9027ceb7977599d5d793ffd1eb7f
[2/2] net: phy: add support for Maxio MAE0621A Ethernet PHYs
      commit: 8f3113936ba37844cf39574ea7914e3fbc723172

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>

