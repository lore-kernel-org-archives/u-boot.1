Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB322CA9ED2
	for <u-boot@archiver.kernel.org>; Tue, 13 Oct 2026 11:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1FB2060679;
	Tue, 13 Oct 2026 11:23:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 91_BsWe00o7g; Tue, 13 Oct 2026 11:23:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 52A126060C
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791890636;
	b=c/P/khmCEU9YCZpszrlCqnTatBgAdg4AGAIlZInHmIj68h5jYMHF20LfaCLaShPjrnp+
	 UfrPmv1Rm8qHkgTAhiu99eCj9lizt/VJYc1Vtyozvqbc3WEPIQGbEPh8SKXF7TOYqZCQ2
	 suNYd7obKVgqWEvm+Z7Fimy0rF/QxwHKZcChqY0c/R7QZYxdLz1yRTXCkj9c/J/dcsQt0
	 yGx9desABaBPg+Ca+E+iXzYyjovy96Y394PVrfi0qSE6dhGsRGX5WEzt7Dd8i18oKZ3du
	 a3x2WyKTo6bGFAULcmp4dWNTVi5k8RsSpDIFggffV0wcaWa5+dH0EytZGevjUVtJ9XA==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791890636;
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
	bh=XU0y5qRaWePR30DONTBTzgYR7NwYFpWgfrrpG+XxcN0=;
	b=WtWZhCE9K2+HtKl3aFgl59+Pj9mrzZuCJ9sMgyEzeAFc2bc1PKAxkZIWhx+6r7Q3PR9P
	 x2TNG1WZS5CH95y1U+ieEInytcnSzkfDv22FErVFf1XTEudJiA+56inLJ71tKyPEYOcTC
	 v30A479OY5MbsMTtKff5RVwFXvjsMBmVIEXQjZ4e1GY4Z4Dzl7RIutWUPjUj2cqZGINoE
	 Uc5ZRP4X3BrEl8fqw8wK1sw0Rx9+Um4WEX7vtQY5VhExoSpPBC3bOSdDoWMdtaUrXYwK6
	 XlmmmKTEF3WBRwAheuov45EpEBPdorG5CXF4PVUuMR84yJ0Z3C7mGnIn1ImWk6PEAwA==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791890636;
	bh=XU0y5qRaWePR30DONTBTzgYR7NwYFpWgfrrpG+XxcN0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oYepzixIulCxBsktTkQCj+lOTa3zhRBsNxpSPKaT5l6ugQNwz8tvD/RTiT32IWQIS
	 tpncl2cOd53gqxBDe+l8Vx7ttMV+KnbiHvatnTpWHjm5E/kGNlh+mcUxMDK4zQoN8o
	 UTYA0cKANAW20ucjgrLz20IJopN4wsbfOne5QIuPRXICFAdTkwSYNnZ51VsHsrKs7v
	 HQax5hEKVWeSG8yjazQDoJCU457+c274S5CQD+gdAZsviKAqsJEO85C2smz8SWazES
	 Jb6QAGjnQhVPhCO9d3JnBL23GI/ONm/vqFSgJDbxCjx7l52+l8EKG2/wtK9LVCvT3x
	 Z4AlVgD8rC8RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 52A126060C;
	Tue, 13 Oct 2026 11:23:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85F96DE0
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:23:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6BCEA40433
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:23:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PQ8vqv-ixk-T for <u-boot@lists.u-boot-project.org>;
 Tue, 13 Oct 2026 11:23:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3029F403FC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791890633;
 b=ZxDXqvbGGvF+OgTc5SrAUKtXCqmgHtt2tGuxEe38A1j/KK/97fEZBbKCtnk50WZL9uo8
 lOHdvRd1Tm4qRRp8WYKcfc/Law6tUA4dQFNTydPcf57hGu2wzWzaQeKXzgEzeYEq04CYk
 T+EZoj6nlMvuactf7xyB9JdhsAtK4+uJgr7JsiLC5PbmYN6iPK2jLKx9EDDrjQS3BC4Ta
 Evin0dEkBYusFs8rEKaoQD4TxKHtnMAJJTnFEmoYngKNJYWVbSZ4XhHACh9OXy6kQmIOL
 161/yVCeAIHSO8bmZJX2lDrgVi485ZiBMF9EdVIFpf5tOzQr7lag3Qp0FaFinFpbXcQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791890633;
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
 bh=XU0y5qRaWePR30DONTBTzgYR7NwYFpWgfrrpG+XxcN0=;
 b=i7x5M8FLkIRQqUT7bZCutHA8JW1EIbNHE+Px5oqFRE1wI9qWSPCOcmyxQiQdFSi5SDwr
 fSAKG8rln/pn4buF+ocbbM1vm6jutSNGlv3O9Dr417RIxR0V6UxwY4Q+eLn3UxuSuUxMh
 6o89j+QLVSSwhqnh1o5P/6r7aN0do6M0dc+9LTXkm5gA5R0uAzQ1N0d5ajnBIA8f2Kx7Q
 yG4lC+/46SUkyoNX4GiN7tFYr//CtRpBb0+a4JwSofO9FJ3phiXbeAmlYLuGg3fppqsJd
 UqnI2j+SHpGpqW9v1VWEo784GjyBERf7VUrTvjmrS8a8ZpkeVF8NyXUMHzqWQT6wLAA==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=RtgBLiHi; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=RtgBLiHi; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=RtgBLiHi; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=RtgBLiHi
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3029F403FC
 for <u-boot@lists.u-boot-project.org>; Tue, 13 Oct 2026 11:23:52 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=txEjBytWnsbuUR7fpaUbOe3rosSBmJX/HRFxFwqFSvfmaIiW8CVSfCytrir+j6D3OaIuThKmAE//lipUzdzP6b+APovW3GWvO2NjJO44QdQcxAuGz9z1FpDmokJENUCaDHiCFYH9lC+ys84057I9/Oq6o/iNnEsi+vtJul8n30AqwsIXWzvcol3Lz/qWu/CFVYZwWCEGvjkJj1FrLvr810jQpRE3B/yp80PrZ2ZXEqTeSztsz65xy/aKeywCclBuktcB+Z0wgxoo0tcfFTHbPkeJNfc2xfcGG6sBVWtbLiYGBqITWq8jO4oWSREuBPDaddYR5qmKdEItG1Z5nhin1g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU0y5qRaWePR30DONTBTzgYR7NwYFpWgfrrpG+XxcN0=;
 b=F+vcI84GOofvQslQBrAjBgl9znYmFUEPgt7IyufaEIlGJF3ulyhRfwdvL3N+rqe52J3w6BIrkd1RxAQwujh+TplGnH1vhUw1jUAiDTAL0HHFEmouyzaXDIBItqhpzGL8mKIQLaafmUdEnWDk4tB1Xbv2o7T4aO8baoaZHWTkKDiyY3edJdwpRzji0Q9oEqDrBSddaBBmZsHaV47bqogqATuXrpy1LZckIRgzhnW8viIbOPnaJx2ofjFDL0k9IqrSKAnDQs+Zq44ox4UBuDKucPtxZy9wHGap77Nn1DgqV/jfDO/zMfOL5KKBskjgn5Zw6nqWF+LTbrA4ZGgJgDomhQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.microsoft.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU0y5qRaWePR30DONTBTzgYR7NwYFpWgfrrpG+XxcN0=;
 b=RtgBLiHioii38pHsufBzimB8NyfpEl41S3V6K09n7TNRf3j3hErHZE092XQBzusoxX4/krW447yKc1yrJMS8NC/A1ISGLv8L1NqkSOOaxVZZxhmvg1GMjbg0Hd4fwMxJLUE1puk3zf/kYlx0m8lq6lq07jUOAcCU2yIt/qBKSGs=
Received: from PA7P264CA0413.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:39b::25)
 by AS8PR08MB6694.eurprd08.prod.outlook.com (2603:10a6:20b:39e::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:23:45 +0000
Received: from MI3PEPF00008485.eurprd02.prod.outlook.com
 (2603:10a6:102:39b:cafe::25) by PA7P264CA0413.outlook.office365.com
 (2603:10a6:102:39b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Tue, 13
 Oct 2026 11:23:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 MI3PEPF00008485.mail.protection.outlook.com (10.167.240.132) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.6
 via Frontend Transport; Tue, 13 Oct 2026 11:23:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuhDvYWz6m4pxOG1ove6ThpSJDKECGZhEPG4CvfK/5x3TCRSv5wEFFSWrR3SdWDuznBseE6M/m1CohAMTLY9Vq/GG5cq1N82h+j7LJEkAhPZwP7Ea8p8HWx4Jh6GJC18Py0mqmSUZqByV8EzSQs9+jK2GgxtPOUPCLT5mDhDWRPsk6ZAqBubfI5I5Qe7UTuDKDK9fMFnBHlEjDJ8/y+w7+GFo6k8iVKsXczVOv7gThjbX5ahwxWA2vpa7YUw3v/XIAQi3YIJg+fdfVcipAavrElIQBDoirlfwXrtfRvrgUEOWqHPAYNhFqOulJjnBMzusCuyYI+NN83Ozcl+4v1UDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XU0y5qRaWePR30DONTBTzgYR7NwYFpWgfrrpG+XxcN0=;
 b=FnsXJqHML97wNItuDp+Apr5/NikJdQAxM+/z2pzoVV8ri8v19YVuzIjRs9BdueN8aF6C1a3FNksHBszE+NEQll1vouq8NY/PJ7oAeS2hpd1+J1OWKOTo49jtlql4llO78NX67enX3zj45WpJ8VPWhQOm2hqpwQUcN7LNUoK8J2KWTt8QD40MP8rxFjk270N3130TIRtk9GqvOh0weUM6QkNZ/QhvBZ1Cb4X0oMtWh7lCQVGkTxw+i+0ilGn3H8dwz/4kvyJubX/j3rWyc1cYQJ7TqUxa4jS4a2BMdVxMsljk8X9BkGyWvxqWeOwiOKxusVoKD6vqkggZocHbldUmWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XU0y5qRaWePR30DONTBTzgYR7NwYFpWgfrrpG+XxcN0=;
 b=RtgBLiHioii38pHsufBzimB8NyfpEl41S3V6K09n7TNRf3j3hErHZE092XQBzusoxX4/krW447yKc1yrJMS8NC/A1ISGLv8L1NqkSOOaxVZZxhmvg1GMjbg0Hd4fwMxJLUE1puk3zf/kYlx0m8lq6lq07jUOAcCU2yIt/qBKSGs=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by VI0PR08MB11325.eurprd08.prod.outlook.com
 (2603:10a6:800:2fb::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 11:23:11 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0522.006; Tue, 13 Oct 2026
 11:23:11 +0000
Message-ID: <41c99e7d-f228-4551-af6d-f2e761c612dc@arm.com>
Date: Tue, 13 Oct 2026 13:23:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v2 0/3] Bounds hardening in NFS, TFTP and ext4
To: Sriram Sriram <sriramsriram@linux.microsoft.com>,
 Tom Rini <trini@konsulko.com>
Cc: "u-boot@lists.u-boot-project.org" <u-boot@lists.u-boot-project.org>,
 Drew Kluemke <ankluemk@microsoft.com>, Daniel Munic
 <v-dmunic@microsoft.com>, nd <nd@arm.com>
References: <20260909192016.217183-1-sriramsriram@linux.microsoft.com>
 <20260915205210.260404-1-sriramsriram@linux.microsoft.com>
 <179081761139.570197.9802971587834247609.b4-ty@konsulko.com>
 <ar6Ag0tw4KYUrgev@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <as0zB9XpmfOK7CtP@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20261012200131.GH3722450@bill-the-cat>
 <as1Llpz//mM2B8Gc@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <as1PAnqpeFKZddk2@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <as1PAnqpeFKZddk2@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0110.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::7) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|VI0PR08MB11325:EE_|MI3PEPF00008485:EE_|AS8PR08MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 19a23a1d-a966-4154-6c60-08df291c7139
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|11063799006|4143699003|18002099003|22082099003|261009223027099003;
X-Microsoft-Antispam-Message-Info-Original: D09C86pFbntVtilOcQgMKHuVhjvIyCv5l3LhNnB5EA1rxT3ykCdy957ScnmRHvYPpWJIE+81hnJojgUoRj69T4I9toBJKPy5FRY1J3gM5vhE8ARAImGekbzQRAAa1HwJkjNe2M1qppiaMGCquhnW5f7Z/uiUfb3ACEUsiBDQ5E+dABrgti8uEynAvAar3iScob37eB4gMyU/eCkgX4kaVMdURTylzD6N66Wn8oDgT3MsxD+m1tsVKzCvzPlc12WcfczyHvt9XKHopNwLWQZ/HKHoTvHXJfSMPhZ+6zf0w5hpqfUZr5ugEVPkrAFL9s4sC4KekbK1Zq2qMw4tdPXGeJRHXsdyAhlluzjeUwlGqjVzJUnqjTSZYyFdiHfdWFCAVXb9SBHDaG9qh/prVOzt5zaS0l2t/+92GGQTV2M7TmT/ow3MptfMA7F3KT0h8hvXgbf54uCFtXQciFekeQ01bFCtLqH0cGtOd5auER5hMzZpP4ymu5NfuUfpkrRDzNKUh5oIUBz4Z1l3pW+7zztrh+t3eHLrlbtl1D2dpeu5Ukx7KjiTULkGYJKcCy142nxr6YSPanxQ/6Kj1/tu2p9BjYDjdQhD/5HQ4fRYW6W/HoL2712vOo8fD+LiJYRRQduf82FXEhq/YS5nSiubHY3Yma+XZtTtXRXETda7Y7QMnMA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: BqYDbA7rMWHqezrqFgEfo7aOGTYnwVGCOU8sn1TJ9EO7GT22PKd+ZRCTdwH8Hx5gDq1UkMJ+Jgyfk+x7Vz1gbl2Euf8lZrP1p8d9NUDgRZasNSX2Ja2RGt9hyIc9U+JXqpEOMimgUOedlk+suDOkix4epHPvVT8ZeNnzrv+JnNxlj0htDjPm0Edcs1EWn1EcG4a0/3xdd/6NFQm1RctTOwkj90eyB4ANvDQVDRIOxBJufpHPumVOvPZxknsJAwKP1pFLn9IJGCs5T12+xpDmb914LsvoIHA5u3+9glvE4nSnLTFbyPxeeSfb1iJvof1GkmMAVxvJCSUTq1MmQgDcxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR08MB11325
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: MI3PEPF00008485.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 09ae1d7a-3b67-4efa-75f8-08df291c5d79
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|35042699022|82310400026|36860700016|1800799024|14060799003|23010399003|18002099003|22082099003|10067099003|11063799006|4143699003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: FjpfszxDv3erDGCINKsQ7CeGV2jObeo98Wml2TiRIsivYYmvqMmM7l4qeQAgfTNRaYErSDbuGL4nhL50/tkoBVKg+ROJ2nOhYk2pDKwPT81egAF4JXmPfybgK1D5PqpyWhIoTnAY34gJAUsAwDll7oUvLipZb9JfGM8KZwzDe47CnKU2Iz5TlzQkWTLEP0GgJlYAzxkyv55dvtAlAQVdn+zIYrsns5I2Gb0l4XMB6NSd0/ajQT9X5vYIRtsZG9EsnoB+0xDJbavVwPVtpZbaQLEcspBcJYStKZJB8gqnH+GvoXrrjyx1+fmJ2JcQV6S0zytFL/l5dPrdSowtRtpcGY9t6ntpZKbTV8aT3/iaDsZpvoIlv4dEVSnmLQgGVwQRmMiXwYMMN0IUyHEglt+KWxmezuSZR8FB+QNKs31x6wn4ZdovCjObVoYU/oma5vt9wxl7cOQ3UdIuiGDxOQkiA2hM7PD/2sE9w313LE6V/dvDTxN4JbpTXs3bvFiQoDgTEaR1R+sJrN7yQxzBhk/awJSV0lMSlRSYCGRLPCynXOECc1e4Snqx37oT/7ddEOFjue9dC925GqjCMJ78RMa+q9EfBVanofuQoCbhr5rxgcbyN6R+wYcOUzogtGbvRXb8X0UxlFhHEbCbHR3DglCi750ar0CY7+8MUBRpNnRE/byaprhk7Qn0vKl1Q2GP2v9VRlMTROkJXA2zDzqLQq7aSw==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(35042699022)(82310400026)(36860700016)(1800799024)(14060799003)(23010399003)(18002099003)(22082099003)(10067099003)(11063799006)(4143699003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LQJUF7+l1/3niaqP9kgWDbjrbE1EGr4JC9abTIVjjRj85aOwsaJXEgXS8GAdfawi4yvbV/xNBK7ss6QcWQDdej03zA7zFIuPc274Y9WpynOA7FbyRyzZtl/2Eap+Kp20GMzvLHPyTVXnJijLWJzMwkt4liJPEq0KUwlpsgSeuOdvRKEjD7zbTQT71Sf10ie7VsroDCFaIgMoOFeCGEo45T+bd7apHBusBbqJ3CkYtEMghsVU9XbbRja/B4FbfQkYmrEyPhs3H4Wj1rg/c3Wlr30W1AsLoEuK9fXbDR8R2k38BtM4F6h/SfmMKZ9f59OdIhXyXntdMYmIVfVfAq+fAS7DwfdrzyEOSJmn5UKxxHyatJpNkrU3eVd4V5I/GHtZ4Fcx8gFO/KPIoAr//+geLhxZysqTWIIXq3m/o4by0gV5Hvf86NOJt4coTDVSUWxh
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:23:44.3434 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19a23a1d-a966-4154-6c60-08df291c7139
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008485.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6694
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

Hi Sriram,

On 12/10/2026 23:20, Sriram Sriram wrote:
> On Mon, Oct 12, 2026 at 02:05:26PM -0700, Sriram Sriram wrote:
>> On Mon, Oct 12, 2026 at 02:01:31PM -0600, Tom Rini wrote:
>>> On Mon, Oct 12, 2026 at 12:20:39PM -0700, Sriram Sriram wrote:
>>>> On Thu, Oct 01, 2026 at 08:47:15AM -0700, Sriram Sriram wrote:
>>>>> On Wed, Sep 30, 2026 at 07:20:11PM -0600, Tom Rini wrote:
>>>>>> On Tue, 15 Sep 2026 13:52:07 -0700, Sriram Sriram wrote:
>>>>>>
>>>>>>> Three independent hardening fixes found by internal static analysis and
>>>>>>> code review. They do not depend on each other.
>>>>>>>
>>>>>>> Changes in v2:
>>>>>>>  - Dropped "boot: image-fit: add overflow guard for FIT decompression
>>>>>>>    buffer" (2/4 in v1). As Tom pointed out, max_decomp_len is used both
>>>>>>>    as the allocation size and as the unc_len bound handed to
>>>>>>>    image_decomp(), so a wrapped multiply cannot leave the bound larger
>>>>>>>    than the buffer, and image_decomp() already fails cleanly on a bound
>>>>>>>    that is too small. The claim in that commit message was wrong, so the
>>>>>>>    patch is withdrawn rather than reworded.
>>>>>>>  - net: tftp: replaced the four bounded strncasecmp() comparisons with a
>>>>>>>    single check that the packet ends in a NUL, per Tom's review. It is
>>>>>>>    smaller (+16 bytes of .text on am335x_evm_defconfig instead of +24)
>>>>>>>    and it also covers the dectoul() calls, which v1 left unbounded.
>>>>>>>    Retitled to match.
>>>>>>>  - Rebased onto current master (a44f46af0aa).
>>>>>>>  - No change to the NFS and ext4 patches.
>>>>>>>
>>>>>>> [...]
>>>>>>
>>>>>> Applied to u-boot/next, thanks!
>>>>>>
>>>>>> [3/3] fs: ext4: widen ext4fs_update() block-group loop counter
>>>>>>       commit: 1c1b6c2b2ae03912007ed2ffd361f43b7c2e5401
>>>>>> -- 
>>>>>> Tom
>>>>>>
>>>>> Great! Thank you.
>>>>>
>>>>> Regards,
>>>>> Sriram
>>>>>
>>>> Hi Tom,
>>>>
>>>> Just following up on the other two patches. I see that Jerome reviewed
>>>> them on Sep 17th, but they haven't been applied yet. Is anything else
>>>> needed for those patches?
>>>
>>> Since they're both networking ones, I'm expecting Jerome to pick them
>>> up.
>>>
>>> -- 
>>> Tom
>> Thanks Tom.
>>
>> Hi Jerome,
>>
>> Anything else needed for these patches?
>>
>> Regards,
>> Sriram
> Hi Jerome,
> 
> Sorry, there was a typo in the previous email. Anything else needed for
> these patches?

No, that was an oversight on my part. Sorry about that. I’ll pick them up
for the next net PR.

Thanks,
-- 
Jerome

> 
> Regards,
> Sriram

