Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33D8606A322
	for <u-boot@archiver.kernel.org>; Wed, 21 Oct 2026 13:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nS4c8VU2;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=azsB2Ji6;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=azsB2Ji6
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7BF5C608B6;
	Wed, 21 Oct 2026 13:05:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hjfXM4VptxVF; Wed, 21 Oct 2026 13:05:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6EB086082B
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1792587907;
	b=n3Vi92Npe81RSZ2FelP2TZnBWQZJeCtskdh8ORxgyEN/92/4cNdIgZnQ9/W7hK1/8Siz
	 YJl2FtiSBBgTd7wB+lJte1xXx9wmCy+T+FXEunfPI+iSac/PD4aQ9IXbLdEJTDtu1diW3
	 gD9c9AZcLI4jMT2ziV5FdM8Bvi+FmmfxBSNHu+rv9XStYlSvHday2PnRqU/F90ZqtEfbb
	 7Ba45cIffYcWyZFykuad4qN/wff8TSXCvHapmW0gmE4qaOqqWXqN/mbP5rjciVtA6gYVT
	 GJVINnp7hhIcNFB7LG4AzVjXTvMZxeHYPQfM7Bl3FDHYN3TEf2z0DVhznk/06PapEjw==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792587907;
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
	bh=tnV7NApONAY5hwf/McTDcq69FhxvkAqryFaUFHoJW48=;
	b=Osv6RLe1LNXUIqDbFfvFEKkjJ1vFaCVqUj3r0KHsyIs8GZAnQyW1S4KKpZ/QwtZYWtlh
	 L8I/w9wGmGDqTXoDk20VVrws2slVf7n4o0jCrJtScVdNPqjP+4hmYjxmA/P1YrCrOG+EN
	 Rxq7m7IAXC7m/CcN1MpjOab48CYJmQA1uYrZf95JwSVR9Egl3GkIRQFMM3LCqOVvbJBVH
	 J4jqdzOnZELjZcIg9D5Oj8ZLBsqyAv61rsasCrusDO6jjImcm3XvhyYAzMqR2acOLZ5lq
	 iYBfH1itOLZBcsaEesv5KPSTJEkaADKJbpiXntJswz5bz2BFNv5D0lPy8E3/UZVsHsw==
ARC-Authentication-Results: i=4; smtp3.osuosl.org; 
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792587907;
	bh=tnV7NApONAY5hwf/McTDcq69FhxvkAqryFaUFHoJW48=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nS4c8VU2OObmsUT3CqH8JR9PT8PYlTB+LsAzoCnikMjqUd/WRgE0LVcNdONOIUdDy
	 Uqv/wMz270xqUEwV2azT22yFrP7/5xmAPKjgn6p5p984owjfuF2/1lTY8arcDV4nWt
	 IvxIxUYVkiHs58A+dl3DeEITu4zOOvAFD6HMDyTRo+6SRDKFByPAfz1SJrRQ9y2oQ4
	 TRaIBN4Pr1v11bqbnpISldA8a+3i0exrb+ZgPOcPTC8YxHx2qsKDkBCoTtEuPxoyGy
	 YmJdWBLm4H7zfvWtyNiyOpdY5JA4X98SnfMrtcep/zLd7lHc1eism1wIvvUdCy3/Sz
	 vyaOzvgmxZmIg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6EB086082B;
	Wed, 21 Oct 2026 13:05:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3C444765
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:05:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 33A6740877
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:05:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZRF7rLVKpZJ for <u-boot@lists.u-boot-project.org>;
 Wed, 21 Oct 2026 13:05:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org CCCB2405D9
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c201::3"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792587905;
 b=rzMwoXWW05sTw191KrM2HMPRIgENK8RDb+NSGnKi3RahRZeaNdXzEllfhgXW9omaJhLD
 CTZdCxCEsHxSQyIFv7HDWIrgN0nFBgi17NiwttTISvTYstNbU3zspF3R0sfvshc9fTmrf
 AfotS2F3NwBKIsYUamnfehsqUjxuAOIzFwLNfe6Qb8uxtq4QkAVKDcj4pNtPZ5q4GDENo
 SWg+l8RpKuFf1vKudXrBYtjz5SNlWOaI9TywJlGmwg6Qun/S26uTcq4Tf5pFH8eB/72at
 EGLLlH9PWaZtbZ+XuI20Iy3+rim5upO/RO53H8/j+/4eicER5GW1MBMK853Y7S+Relw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792587905;
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
 bh=tnV7NApONAY5hwf/McTDcq69FhxvkAqryFaUFHoJW48=;
 b=Ld3HFMW21tNaaZX4tmk9Jj+Sinu3KMHa6gITvNF6Q9HYCt0w5swF6zXJLagi4ItYSQmM
 m75NeKTHW2Y67zavwaMw5un037VliWYc5lCFdXH9Ppbuw2c7ozc33PTpt/rs6pSWAGHJA
 gxCGhH9H/8CWP344E+6VvTR6MOp5rrmPoYQFJqq73EJXg8ltQFiuqYvoh9T8cQp646zhP
 p89Z9dIeRR1Shp2rLBFnEpELgTrvTR1TQPbdOuZfXuSqK4qtmJ3Xson5PxEomLxNN/DFX
 oUDUfnjDZENgJp3lHrIYRlsFstkEIsDlsj+7sfa1Nb4TPhTMjlX1fKBEZsgPcGnG6bw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
 dmarc=pass header.from=arm.com;
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=azsB2Ji6; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=azsB2Ji6; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=jerome.forissier@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=azsB2Ji6; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=azsB2Ji6
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CCCB2405D9
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 13:05:04 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=KDLq6grmNrF7PymFdReaN8AwekU5S5bHUj6J5/XDT0dQBa7Z6S+jLoe8q7X+1d57SpTXcU/heDNa41nCsblOt3ZxEws+s98khPoRX4m6oNE8naM4OcU3i3MwYpJ2BPjAJEVZGhKNejhi77vG1apvK2ENZrRb9rYgci90YoS/BseprfyHL3vCxvl1jy+ZUNHbaHqhyx2DkqAFzK/Esu/Bn7pIs2lLjzJtPUKlgXruHCOT0gCS7uL7hMcDezQN/0q8xe3nDWgGpHFDxT9uWDk1/Ee2or3mUg9xjAPgXnetGc89DcPWwLuRHz9ufjx8bBWwTAD4oNxJkK+2qXsk0R9CLA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnV7NApONAY5hwf/McTDcq69FhxvkAqryFaUFHoJW48=;
 b=X6FutsAQrsodAWQL06OqCgYMZ7B2iMTZvD0t+TZESergbTIfL/lPc4hrh0bzh554ecI+frOlr/pEMS9KY8ftrUmK8dDcAWtIcSXEmTx4r8oUG3uw3Js+6ThTCzpieMwBDNJwroN3viGcGOQj2Av4zjskh+idfZgqi1hlj1qVQ0CKi5dMbDUmbMWtHiQ5jMudSqZJcGmOnHjz9q0B152hupEFAZI8Esx0gvY5fgPOdiiMslRg3O5e4ILh8Y2Gj1ibA2xEG+w9saP3ArQi8VBP4M7BlcjEgaGUNuyYWX5Ad90SNAf+NYp1jTeeojTZ96CsWsafoZ50CVcUjrmLo1f4GQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=sntech.de smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnV7NApONAY5hwf/McTDcq69FhxvkAqryFaUFHoJW48=;
 b=azsB2Ji6Z3CC6eU79UOHRVGmPphojC2m/s4FzpA6274MNL9xb+epG8U9wc308QGZ43nkHnO1EvY/Q2i3v426fukkx9izPJCLGGYkifPt/GVks1XZrHRvfAYbtyoSknQZkOwvusqt2rys1C2TZUDASlryG5ZVVdijYviv56f8sZI=
Received: from BE1P281CA0113.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:7b::11)
 by DU0PR08MB8882.eurprd08.prod.outlook.com (2603:10a6:10:47d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Wed, 21 Oct
 2026 13:04:58 +0000
Received: from WA1PEPF000099D2.eurprd04.prod.outlook.com
 (2603:10a6:b10:7b:cafe::29) by BE1P281CA0113.outlook.office365.com
 (2603:10a6:b10:7b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 13:04:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 WA1PEPF000099D2.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Wed, 21 Oct 2026 13:04:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlZatsj3B0aLrDMFaIy6gpagxfP638ROgxzGebOg1kZLQLmQDNUKHb7y7hZx23IqzJyz+9l5CNNmXtOH/bbrxrjEw5KgfVGCykuxAEJkpU2X+PlT1A/5kQR/I7UrLVCZxTDXmdqgyNX//tiN8VDvOee+sBs+9GfvlKlaa94+ZThiy1KhWTTQ+fMOqJKl01e0climcpe4t5/GG9MPEvRf2hdsDK3xr8/aVa1/j3X5TW/NYv65JypSJ9yPL61rkdjIKV3+DJGTfWwd5SxN2d9+jcuf2/5MsWRDvlneGb7CFKLhcI3iAqHHccZtVoIGwrihAQiz39XgAojus2rJnrWNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnV7NApONAY5hwf/McTDcq69FhxvkAqryFaUFHoJW48=;
 b=UpzWwUHm9hAsFVHikqFZGePxLQVa9pgcGKwGBCV0GGBawoMCw0plQoG0CcQeEWgiKmmWCGGh3CF/fT4UWJ/4uXRYctwA53DFj6iP9xeNjtsFUt9KHQOk7GCCk5QNJSrvvZkyjOmbeCdWJ6pHnfs6Bdq+f/B60h8sQzGRYXpb+NEby+yVi+MKZzI6GaDvOMUNXphFC2sCJDABZeuYr7JbYf9DqHlyXgnXD3rolAWemYfnNukNY/FKWFsyTTjesDZvnUZHLg/8IYWIW3fLPNtMknKdlLGwzR9oj4LwF8BQ6P6PxqtLKjG9BgceXWkZJ1DUqfEyrpJ0sX4lXFzJyGLn+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tnV7NApONAY5hwf/McTDcq69FhxvkAqryFaUFHoJW48=;
 b=azsB2Ji6Z3CC6eU79UOHRVGmPphojC2m/s4FzpA6274MNL9xb+epG8U9wc308QGZ43nkHnO1EvY/Q2i3v426fukkx9izPJCLGGYkifPt/GVks1XZrHRvfAYbtyoSknQZkOwvusqt2rys1C2TZUDASlryG5ZVVdijYviv56f8sZI=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by AS8PR08MB9977.eurprd08.prod.outlook.com
 (2603:10a6:20b:636::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 09:51:46 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%6]) with mapi id 15.21.0546.012; Wed, 21 Oct 2026
 09:51:46 +0000
Message-ID: <572ff54f-0a8a-4fc3-acd8-f1fe316ce411@arm.com>
Date: Wed, 21 Oct 2026 11:51:45 +0200
User-Agent: Mozilla Thunderbird
From: Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 1/8] net: gmac_rockchip: Remove unnecessary
 clk_set_defaults() call
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Quentin Schulz <u-boot@0leil.net>, Kever Yang
 <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Heiko Stuebner <heiko@sntech.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org, nd@arm.com
References: <20261012150542.1182209-1-jonas@kwiboo.se>
 <20261012150542.1182209-2-jonas@kwiboo.se>
Content-Language: en-US
In-Reply-To: <20261012150542.1182209-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P265CA0027.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::13) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|AS8PR08MB9977:EE_|WA1PEPF000099D2:EE_|DU0PR08MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 4113df04-f32f-4fa7-9e27-08df2f73e847
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|10067099003|22082099003|11063799006|4143699003|260925021911599003|260925022911599003|260925021311599003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info-Original: 16bcL/0wVBKayQKmjWD2qcK/XvJ8/CecO4VxGu0apk3VOWWe/RgEPgshBE9XjsjoRm1s5L9Q5hmedovgHNSvaYUjQ/iPqwogSskaiMIR/1UGlfEUF9hbHbumvGywXZIPHor462dxC8jDw8U4enF7+7vzS3GcR9zYfD4da0dBQatC2b+9TBu0ZRadC2y+xoEpF1vimXgtV4BTwYQFwaikxmVrrPOBNornvyaHEQr9wmLduK0IP/DSIZXcLjY0t4NCmr6qX9SUHwO3rwYQGfR0nC+MynrVPlfujFXMS/UZ+RTGxkY+ewcuYPzK+tX2DpUPQ9YfGOaQfgfB50TOdKDwnUMyWip8rAcqs9+NCcmLZXPepQRHLkuNyXUThOoBQEgnezlceyxM0EQI7/cq5WkESW7j6jo0Amu8hj9tswn8w3c4nRxt34QCcm2Vqvn9wvtmhCVJ+dyBR6N/Wo3upgK/9lZ2ewdwmTn1NupxJSztYiD/CNJ/7O9/fiznNZtK5s0z+olxluarlD2uKxsT8EFn3d0c4qYXolnWUh1y/F7Grwq21Ajy/BcbhuSoGIwptP3xHaUxSQ/DjqOOnDF9H25yzPD3zeTnaQsYkRQyHiq2rGXVu0df2MQeLS3HodSkVDwc
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(10067099003)(22082099003)(11063799006)(4143699003)(260925021911599003)(260925022911599003)(260925021311599003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Ncdo6lcBooMUQsiHVb/CjggCjSS1qAoGrHh3Bc6Vyl1nOZri2m3BPL/Zr5ksraUCj/v+R9Kj6tEx+6SbxUJd1YVxBcfBk2Oo7C/pB2x6G/nkiYTnV6eeqqw0kN7sP6k1NRgNraYyuov/6FKd9xwInBB33+ej7zcQf2PX1mHOo5j1vdP14f3TEyBHgLX8P3HSpgm2sNPhZYm/+k/oNJopb6rKA1VtnO6Z16dzSxjCU7VBZUvREsRZ7z0lWQBqtzY2inNDYAIKVNwEhCvwpB8qTXjyjwIXZ9QAXj/c6EufV+FppiPoQiSrFp6FH2GroU7mJDTz3cK1KkRI/Vt6ODDDyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9977
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: WA1PEPF000099D2.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1a9fd551-bd2f-44e6-ab4c-08df2f58eb3c
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|1800799024|23010399003|376014|36860700016|82310400026|35042699022|56012099006|4143699003|260925022911599003|11063799006|260925021911599003|260925021311599003|261009223027099003|22082099003|18002099003|10067099003|13003099007;
X-Microsoft-Antispam-Message-Info: q08SGDRcqmHKSq0pRrGaYoRnHDloI/PVVrlsTH1EEcHh1uq3O99BCd40QnwcBDMAG3tNsX/03cNAzZgyDkz1Ae558npWXMV0YHKypkIsZvX/J/R+3IDpXUnwrKDKDoug34NuQZHeREDdVShKgVitD50vPhv+9Pez+UnkitJQwbsweVbLIv0BzzGuIAOaC9Huro9jVT6oWy+olsVfwEtOiJT+Zzx+bkSSl/ywRGDpt3jh2LG5/F/Pz8/JQ5SOGrDiMj8wGbcmJnTDoCWFjlBlgB1Ft2mBIapCj5uNjsd9DniAJQZNXuXRMjn6e6vBn4yKtAblut87y6bA1oVnZV4VEtoTTS0DEYZWI/GIOZryAph+mRPt1uSpa08hlp3DLRQScjLD+siG3IVhf6AkIkBN677Rz/+5VcacVpYA5in0Dz2BYiWLmG72IuKBgmsIOvfPXELB9eK5XRwKARqL+/behWiu21wFXGA5i0KJjgHkshgemJvP6HTwG1/e4zrJdI6tK7VsSpwbGkwdeJ5oYkiUfGyjginoARNrWNCiMS6UQWcSFcbttEzUHCsn+UOUPgo8YpHdRINlLzUsy8i85eWj5AEx3mw7SEBGMe6b2MAXmXB2MXeXkHj6fD5tgrJT9a2kFTrqkcvU4ufPKTzuJQD/3nvDkeyGW3o4kNkcmo9RHXw=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(14060799003)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(35042699022)(56012099006)(4143699003)(260925022911599003)(11063799006)(260925021911599003)(260925021311599003)(261009223027099003)(22082099003)(18002099003)(10067099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: j7c0oW3lxN6L4Phg1kn9KvltazfQ5UFNB8L2KYXdssKqOt/CBYbiItQImGtpJn3R3+p99F0dwhpOiQALXirNj69hH4jXytWw6B2pH6vu+SYG7k3GN+U0EZ0k1dXaZWEkoLWyHMjTDcFf8M3HTGLbjW2GosUV1LXQTE2aJ6zwkZ3hUHI7j4V7HwcOKBcl1z/sJgGRdkqnLP/Ut+pGY6d+ayJsps9aqhmvki3XIyKInLE5EMoRLT2rA97HqjeEBmYDjBRnRVd2cN+FVkilkZY8xFaGDhPG0KVrccpPOi+JlynMas9leE4KaYoQ1r+cC8btDkVgiYI5J9M7EdPL+fUux1ZXwM8rIL1YTXNDTSgsqnSkgoIN9RFqc9IDTRhcKwXhI1CunTzjHORLtJ5qJ/V6kcfPv79p41xs3M6qfTp14KWU9WckgyTJ697g/4ySY42L
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 13:04:57.2880 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4113df04-f32f-4fa7-9e27-08df2f73e847
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099D2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8882
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

> The device model device_probe() helper calls clk_set_defaults() before
> invoking the driver specific probe() ops.
>
> The call to clk_set_defaults() in gmac_rockchip_probe() re-apply same
> assigned clocks. Remove the call and rely on DM core to apply assigned
> clocks.
>
> Fixes: b07911840025 ("net: gmac_rockchip: add support for px30")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/net/gmac_rockchip.c | 4 ----
>  1 file changed, 4 deletions(-)

Applied to u-boot-net branch for-main [1], thanks!

[1] https://git.u-boot-project.org/u-boot/custodians/u-boot-net/-/commits/for-main

[1/8] net: gmac_rockchip: Remove unnecessary clk_set_defaults() call
      commit: 1834ff73375c747aadb12184332527db3fc686c8

Best regards,
-- 
Jerome Forissier <jerome.forissier@arm.com>
