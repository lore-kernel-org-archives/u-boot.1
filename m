Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA88606A31A
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jTpv352K;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=p+03SP1K;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=p+03SP1K
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 03F7940763;
	Wed, 28 Oct 2026 15:30:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QuWduClHvL0Q; Wed, 28 Oct 2026 15:30:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DE2E8406EE
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1793201442;
	b=K7HtRuUSNFuXEdGzGl/qNtxm5wHoH3NvQwf41SQRJX4hVh/LrI2+4YWq19fJYw13NJAX
	 HFPIVX87EAr6WPDQGAnQwZ7f6056e7meRzatCSdFEEuqtiMbw3m7xzM+6hhFnBx5TOYwn
	 SXut0Nt9lW5Y4GBuYLxuatcctxsgywwhRmvwAMLC5pcQF+E817RtmVKiy64atzy6mrA/B
	 rVedBGrwOV1ZYb4GXVRfX9JM26nOsTD22FeROP4iY39yIwHD2vyhpoQGtsMReJRXz4mOw
	 LNlR8wdGgj1T14k9WGmwu01LZIJxnIiU1mESm0reVOmwpiopwDpEh/HpVHc4MsB7JBw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793201442;
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
	bh=9IrJmaXFf2GCmZPYBpgZmBGBm8wjSrKoF/74LI3c3c8=;
	b=NrFOcv4QmvHzyixChc7Lp9mDVQPRUbgD2vG0jyoWUiJw7/v+V2IoOb9aMuBdr1kihYoe
	 KW18+v5tylN5hGLeIRzFJT62OaPdp2hVMDwVkUipNz1PIDPIm5I9atkqNkuyhyiWGkOo/
	 6riXQR0/KS9XebfU1iHDZrZVseEmzpjdam3wE8m5CiiVsF4O6s4wvixMHSV/tu03mKN4d
	 amC8/vUoMapQzVdPLqNSAYtqmuix4Bgge7M3aqyzWjGG48fRpHsKDiO/OT2Ob0RIheJaT
	 zTo9+Dxx1qay9qiUI6dE8f4Xzjr8IcdWCqiOVEr+HYMGWEx+yXDnZH4NbMu2UEKZ/Vw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; 
	dmarc=pass header.from=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=p+03SP1K;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=p+03SP1K;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793201442;
	bh=9IrJmaXFf2GCmZPYBpgZmBGBm8wjSrKoF/74LI3c3c8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jTpv352KorRhRZdh5c5d2yZHXmVV0JKBBcIJrwT9I3ndPULk4s+KkFZK6apThkv2L
	 lPhwhp/X7xXMR8SyCaMdXMidunOoQ/QPjQsp2jXg2AWFRyARN6gV7HHs+aQOxoqydC
	 x7PvjRyHdcy7rmApaJu3ogyK9dGWwkS+93y22m6wURon5s1xcWuJOcmkFpykFroLNT
	 ul3aQFayMpAzm9vAjojhTTj8pYWBCH4lTlXnqlsjQXf9d+TcssaxmgOxCt7HPvfWZu
	 XTDuQBTGCDIdJYS/xP9g8jxuvzFi8YSiig+qejQ0V8VcwrKdtU7xXxdc6bZALdrvYa
	 dHZntasPd3VDw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DE2E8406EE;
	Wed, 28 Oct 2026 15:30:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B83AD356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:30:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B591140635
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:30:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KVyphMRV_Qmi for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 15:30:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 52C16406FD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20f::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793201439;
 b=D2dnJx47oIUqUpWf3fumuQ2DxPylNBXe2s56K70pJvYtpvZGe1lsT8KogWa36C+dQoSO
 kYEQcwc0XBrDrVCOYhCwUQGXHx7aqgkXy3BQhCSCFcZ9s18OkG1awsAvJZ0OH2+/cqYaP
 yCtoCM5sJytnTT6e8NHOX6E9K1ZiuD0MkwWDWswOc99/OIW50w44S4y+enw+3l3t+QkpW
 nZnKze3POiCEpg+VtDygENjJUC5E2X1m/eIEgyjEt+f4RgX5TqDlaYoCo1QtEqIuVOUsY
 t/oIQ6qi5bj/2r8Cp+Iwlxe72RPvyIAuAv7UQYHpOuvLro2ykwbP/D0HXrDWBweZldg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793201439;
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
 bh=9IrJmaXFf2GCmZPYBpgZmBGBm8wjSrKoF/74LI3c3c8=;
 b=V0q9SZ5PjkAnF2z451jBPRYqsIdJaEtOlUtWTHi9OnUOEBePztjAVWrB/1QLCu55ET+6
 6eUQo8hGxPKU2SgmAyUm6M42aUd3U1Aame4JknmK+4xC3Lm9zH6k+t7tOtgIb8biJvxsJ
 yXSn+oq1WWq6yhLXD9qaZigPsQzi9X0uNj0cZ2NxxJdlZB+Tqu/MpmC3mhsXZj7OOAYoy
 UrtFobBK8LSnpo9p+VGG7M48e8o6SvFauXkoDCPAQILc+4RTQ/g1vFevKlTsti5YsYDa9
 lzsDN00hgQuixFqIgFsdrIJ5I5cNS162pZlGzU1qGiJDyEI2Op8MCNXaT6fswq7IDoA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=p+03SP1K; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=p+03SP1K; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=p+03SP1K; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=p+03SP1K
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 52C16406FD
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 15:30:37 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=NpImRJp9eU6PJoQnBsZeGeXgfMu/MAV/YNcJqadY+DtdAnA8N5MWdhOlRp7SOmKPOfG6dqeowP0UjZZJSasKjror6ZuDXZUTPOo9t7uDtEQME9n4+rn9nRZKr9UqO9Uucde2fvGsIr0y/H6DyT2FTVLXfuHQSMqWd698UkWvuto04za8dTwJo9+INQLurb9/UwXq0wWG4H8xrq7Wd4sEPd+01fVlHpSp6WqpFoBoT5P1Hq2dR7MfqN5YxEGdo9F6QDPOMwM3evO3cqB7YnDTDo8xYuomuQbiZsjzV8MKRRycRoPqNIMzRZ191zU2sdGKmmGIDRmIHt+qWqxRtOsd6w==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IrJmaXFf2GCmZPYBpgZmBGBm8wjSrKoF/74LI3c3c8=;
 b=fVR8hkeew4f+mJf3kTBPXWa5bTSwQR4schjFbZXZSaVH0oauFnBkTWBGXwZYVaGkiHxDpWuw3YpgHj6cc1uAyFbdQ9BC504ZoSsHuvlv6hMbu216942m5K/A4dudn+q+kFEQTYQL7FFTNFAkLSw4ipeJGDOdPmblPbdQ75QTu86+/Y81YDU6+nICVAG60AeFoa1Mm+qnDi7+OzKkr8Y5LYEgX1dzwffXWGY2pAMLD1xuFGzglqOFKRLPF8ZgnTTDmSjqnG55bB7Kr9pdNhciqx/I8fz9ijVvqaiUzzzMgUBsXNYecPHcPsR+6plHx704EGOcSD8loeC9aHDyo3hjcA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=konsulko.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IrJmaXFf2GCmZPYBpgZmBGBm8wjSrKoF/74LI3c3c8=;
 b=p+03SP1K+RzKpjm6Up8P8UsqkdWjH1ppigbuiObCeY3ZAtZA5JOWtUpl047dtC5fZSmO0Uy33OT91KgOxplp8pb15mvBKeKeR+n9yqRJ/4EZ3vlcpa4DuMzXtw6/OSKoLxbM28mCAdxwaEn2lK+ebWlZPct4eTJ8YOJQ/GpcfIU=
Received: from PAZP264CA0078.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fa::22)
 by DB9PR08MB7511.eurprd08.prod.outlook.com (2603:10a6:10:302::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Wed, 28 Oct
 2026 15:30:19 +0000
Received: from MI3PEPF00008496.eurprd03.prod.outlook.com
 (2603:10a6:102:1fa:cafe::53) by PAZP264CA0078.outlook.office365.com
 (2603:10a6:102:1fa::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Wed,
 28 Oct 2026 15:30:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008496.mail.protection.outlook.com (10.167.240.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 28 Oct 2026 15:30:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V5gW3vbHaqaaDhV3xpR4oJviIisVCUmgSmkRrPpCbL45cBeD8njn9xqD9jpQcB1Q9CxdJ7Dehzcz3RcSNLfFaN6KyDPN7YcAeT/DEy8ZWctNxH3t6U6zNuIVzoYIXzih7YJrjtt+6kAV8kQvoxwyj3nHMXj5p2ic0UHP3K4jbo2s5IutXQpNw8rtN+3EYt5PkjN0Yp6QquA+r8BgMklJZVPhaeo9FuXl4Ysi0NH8pK8imdmd6g1S7w3L0Coj8qbsqRFdCIQBNSOuZaBs/jD8o1eXV25+9NarTknJI1RvW827xCRZs5qf9RxOGc4/CU3IfDY1B2AQfLaRg+tvz9QhQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IrJmaXFf2GCmZPYBpgZmBGBm8wjSrKoF/74LI3c3c8=;
 b=loML0tN/iqpVcfycYWz0dGBaRsicf3aB1BQu1lacQejqLKb3LKJCJUrSMjzDQpqfErsUb+3cLMTr/7lAp36FH33ArC+sk7+hBbYQSih65cOaBj9qzOK0ezKYY+PoOkTZG4646uoVoUs2LgD4c6mMcPrmD/K0GSt2T5qAGNvalg2Erma1gjrtId+3YGIhtXyL1xhh8kQoEoflQTus6qpn/lpU0jvRaX2GL3NXLUghG9yOjb6Y7mNvR+Offkyd7Vd4Q0wpNEswfBUjVJ8DD6CVdDfywtOxBN5J3otN7KF7d+bg3o+Moci1k8ULpQO0nRITW5l7zB7FL6R1WYUu5sdJeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IrJmaXFf2GCmZPYBpgZmBGBm8wjSrKoF/74LI3c3c8=;
 b=p+03SP1K+RzKpjm6Up8P8UsqkdWjH1ppigbuiObCeY3ZAtZA5JOWtUpl047dtC5fZSmO0Uy33OT91KgOxplp8pb15mvBKeKeR+n9yqRJ/4EZ3vlcpa4DuMzXtw6/OSKoLxbM28mCAdxwaEn2lK+ebWlZPct4eTJ8YOJQ/GpcfIU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DB9PR08MB7651.eurprd08.prod.outlook.com
 (2603:10a6:10:30e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 15:29:44 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0569.007; Wed, 28 Oct 2026
 15:29:44 +0000
Message-ID: <adc83bf6-2246-4597-9b6f-546598dff093@arm.com>
Date: Wed, 28 Oct 2026 16:29:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: Add helpers to preserve console silence state
To: Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 James Hilliard <james.hilliard1@gmail.com>, nd <nd@arm.com>
References: <93e4e89a-6c3c-4a3b-aa90-bd9090a6daaf@arm.com>
 <20261027173348.GG2177077@bill-the-cat>
 <d5057c79-7e37-469c-a2e7-b14ec4f18f2f@arm.com>
 <20261028150832.GA2677024@bill-the-cat>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20261028150832.GA2677024@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0228.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:372::10) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DB9PR08MB7651:EE_|MI3PEPF00008496:EE_|DB9PR08MB7511:EE_
X-MS-Office365-Filtering-Correlation-Id: 872e6a8c-785a-457e-cb74-08df35085f6c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261026140227099003|10067099003|4143699003|56012099006|261021121427099003|261009223027099003|261022105027099003|11063799006|261022075727099003|18002099003|22082099003|261026121527099003|6133799003|261028144727099002;
X-Microsoft-Antispam-Message-Info-Original: WRYZPORlS9zIHZPGQh4jtluIHe72jd9RMlfpnrlcBAQq4u1W8fClj9kiHt/vAQa6hd6Ndw5CLrYQsqqSac91Fx3O326bvVr5kqDOeE0PGmCc1llSiQ3Mjn8zVTzGSgWTN8T3dXytQJHRK3SeLtzAeuFZrlSGzQ6OThnI0V8fmZnsQFb1nqY439W68Is35yl4p5wV98C/T0NdmW9BzLRD2R2JOZPywM2jZ9uM4I30rzA4yptXjeaGQKze5Y7G9rkwI0QqQiyiYnzw4S1gUQb9YKCtVCizL0szoSTSz7dLu8lFEQgqgTbrEKlCyQH4fU+OFD1cV6h04eb6qlejuUknMSc4q5eKQiUUbyjR9wlZbgi9J+EOZZVGeEyYRcZvcTrRzcxO9vMNtmU2v+Yi2z4q4aG7PoPCEInP8SWygB15Q/8D5kLPSMq9pumdH9p69e9e+fmP11NDF7dhVtpLd9HwEj7pvIl6BT0LaMie/VHd6yH1vYBzWdSx3zBFgdg31R/T8VuxShx3oxXZrvJkMTY+gLe+hhG/c5LuRbgLSoNHPVVUEb1riV0KHQXRLPL796VKr8CjihOn7YDmHYOk398CwZBLboaE3GmH86ktlvA/kFZMH7gSHpNSaoKiBRajY/mA
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261026140227099003)(10067099003)(4143699003)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(11063799006)(261022075727099003)(18002099003)(22082099003)(261026121527099003)(6133799003)(261028144727099002);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: NHHQAnhl2LhnG//irW3G0+JUx4xdfiOP9RVdNK41yN0u2YZjUt6TP+7LIxJj6AZpRZ5348SksoHtggikREjV2ehT6oWTjOshtkf3bBG+kiJmdNFF9Sx8qmjL/IyXDWN/d1kEpaHK38lW0tjs/8/jTYPXA85cb8UX382hsVTLYOfXgOAB8yM4b03z85t6zJGwCNSGnle/ME/ImPwX1WswlK0u/sxpd4Mg0pXEKfIB33sijfWQzE8FLA7Izmxcg7gboOsQDiVdbJWssrG1msbpH6/5yPE8uEjIzeaSzKKe63Kz3PsD4xFY+KHPIL68ZhRqvbOHUxCLOZJfW5fmYYOFfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7651
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: e4c1f038-a6ca-4f19-aff0-08df35084ae3
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|23010399003|14060799003|36860700016|1800799024|82310400026|376014|261009223027099003|261026121527099003|261026140227099003|261021121427099003|13003099007|261022105027099003|261022075727099003|10067099003|4143699003|11063799006|56012099006|261028144727099002|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: sZ5lpNFShz9FXFBuNT+M7uJcZyj1bToz8juuzvdcZkv1l73zFZCZ/QUOdmKI2yIAiVmN3wnKoAtahU1Q4UGkwI2XZv7+GVo80jUSrpia0v4Xh3/TpVTaWSWrhK2jiQr2IPUYJR4P/AWipHbwZP7fny07PZqPlZfr+uMxq2RF4OWWJUt67i1ZnP8L9jL3uKmOHsJhZqUbl0YB4Upp8kvjVVkKEQOF4Ie/ZVm0L7DLGbs65FEEs7ijnbIUPeDtJeXcLgmayHsuSXA93RoBdcRp/eCsB2rDHjD8Q60I533/NYX9QPHKcQxsJv12aaafa6Fdc4Pnm32aNNPwDfMYgFctNVpjb4GFjTaIjrvygpEp52Gsom0xJ1fveYzuovY8GubFeQq0Jlj0NV/wwWT+uEMbzZWVaBuRqfDiG8tHWGiA88M4MWGgr1/vooxEOsmsoqdIFepajPuOaFYQsV1Yne0FZVBED606lpyB6P81Fgf1G5P7ovYLllzXPuJ0bARfigwrRki2zfJZ24vXwBxm1MY51ltx1EPabX/cCrDhw10f/nHL2liAqslRby5CEOXFmtD/lwyXcnt1t/QnXpwzvvLt3C9ORaAit0wLRjCM6L+FG+tfzudVqD3/Vaxq0Dqs4FSNJYN+7tPA8cnikUJ1fTE1tIg4a1h26FxvBC+UzWMFe1Q=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(23010399003)(14060799003)(36860700016)(1800799024)(82310400026)(376014)(261009223027099003)(261026121527099003)(261026140227099003)(261021121427099003)(13003099007)(261022105027099003)(261022075727099003)(10067099003)(4143699003)(11063799006)(56012099006)(261028144727099002)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: t5S55SfLiSMgZZsx6iRybUxADyisyLvgVqZECAHMUJZdPc/BC1Q/qy1NEvA+Wrnlyi3rfWi+GaoaQIVNTmKS4GqhnLG8fdRctn1K+01zabs3YSZwmaZ4Cv/CKH8dE5JupolPqREzna1ZCwDQzURTlpBS/RnEM1xMcihVdKw3CpsSf1qRULBn4JuIQu4ZmNkJIZIy6nZvai4zZcYRbMpkVM+rIT9jyoV+QarTzLaVVpp/OKgm3Q0RUwvPzMruhMVwyUVZeBAPYtEtz+l2HmUVcjjbhUdxALKjCGp7JC1FCTY3MqcqRJMIDyLXNwja9KsluXmi5aWSbaZ9Vi1Yk0Tsp96PH6X55OhD5ESCOzx8O9xtR1WBQHlx7UgVQhhZlKAOYe1BsoOgpgptPNazO3T2EjMaXosNJ/KRiLZ++E+GhvN1n+f9bW/TOKyX8qS3HN7N
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 15:30:18.5152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 872e6a8c-785a-457e-cb74-08df35085f6c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008496.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB7511
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 28/10/2026 16:08, Tom Rini wrote:
> On Wed, Oct 28, 2026 at 10:01:10AM +0100, Jerome Forissier wrote:
>> Hi Tom,
>>
>> On 27/10/2026 18:33, Tom Rini wrote:
>>> On Tue, Oct 27, 2026 at 05:02:12PM +0100, Jerome Forissier wrote:
>>>
>>>> Some tests intentionally trigger diagnostics that the Python console
>>>> parser treats as unexpected errors.
>>>>
>>>> Add helpers that silence these diagnostics while preserving the previous
>>>> console state, allowing tests to hide expected errors without accessing
>>>> global data directly.
>>>>
>>>> Signed-off-by: Jerome Forissier <jerome.forissier@arm.com>
>>>> ---
>>>>  include/test/ut.h | 17 +++++++++++++++++
>>>>  test/ut.c         | 15 +++++++++++++++
>>>>  2 files changed, 32 insertions(+)
>>>>
>>>> I am proposing this patch as a prerequisite to merging the series "net:
>>>> lwip: restore TFTP client and command parity" by James H. [1] which would
>>>> otherwise introduce a CI error [2]. The error is fixed in pipeline 1762
>>>> [3].
>>>>
>>>> [1] https://lore.kernel.org/u-boot/20261024-submit-lwip-tftp-combined-v1-v2-0-0f663f735ee8@gmail.com/
>>>> [2] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/jobs/128187#L3716
>>>> [3] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/pipelines/1762
>>>
>>> Sorry, what's the unexpected error line(s) in 2?
>>>
>>
>> The failed test is tftp_test_protected_autostart(). The unexpected
>> error is:
>>
>>   ## Error: !
>>
>> The test marks "autostart" read-only and then calls the TFTP download
>> helpers, expecting them to fail [4]. The helpers reach netboot_run(),
>> which tries to set "autostart" to "no" [5]. The environment code [6]
>> consequently starts printing:
>>
>>   ## Error: Can't overwrite "autostart"
>>
>> The Python console parser defines "## Error: " as an error pattern [7].
>> It registers that pattern in the list of bad console patterns [8].
>> While waiting for the U-Boot prompt, run_command() matches the bad
>> patterns and raises BootFail [9]. The match occurs as soon as the
>> "## Error: " prefix is received, hence the truncated diagnostic followed
>> by pytest's "!" failure marker.
>>
>> The amended test fixes this by silencing the console only around the
>> calls expected to fail and restoring its previous state afterwards [10].
> 
> Ah. But looking at test/py/tests/test_env.py we have a test doing:
> def test_env_printenv_non_existent(state_test_env):
>     """Test printenv error message for non-existant variables."""
> 
>     var = state_test_env.set_var
>     c = state_test_env.ubman
>     with c.disable_check('error_notification'):
>         response = c.run_command('printenv %s' % var)
>     assert response == '## Error: "%s" not defined' % var
> 
> So can we do something similar for this test?
> 

Absolutely. Simon G. mentioned this too. I will use
disable_check('error_notification') where appropriate in James'
series.

Thanks,
-- 
Jerome
