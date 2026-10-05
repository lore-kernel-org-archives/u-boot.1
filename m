Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4759BCA5FCE
	for <u-boot@archiver.kernel.org>; Mon,  5 Oct 2026 13:38:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0F2804065D;
	Mon,  5 Oct 2026 13:38:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MNAnnBoCRwse; Mon,  5 Oct 2026 13:38:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org DC31D40613
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=4; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791207504;
	b=hXhzrgZHzzkpaAJ8JgGcarcLhCobkF581Udk940LY13+T6ARYzgfLYX5aOHYebUmbClQ
	 1jhqApTHtf2E3yz0h4v4BjoQlukZ3tS8HZuhkSiNcvz/ozDqUchetkotDccn1k3yDpyFa
	 eBugnD3K4CkOEers9B4JzGNgAxfjVTWm8jbvgeFne77vwOBOTUwClptC8h5X13Dw32KGP
	 631pSfAu3ASS3JxprJZiBp61SDLwCo6AqIkNWiXkeBzKC3wFZMuQvBhvMC/pZb3AS1HKt
	 vpqD7agk/UAa1YsdjG3XP36vkvl4eC3dv316e6uyidm0gBPp8bCWo87ez1iPvORhPPQ==
ARC-Message-Signature: i=4; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791207504;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=GFrTeKvQBaYvtUOPNMOrcJa6SVozWFtQdOX8hJzulwI=;
	b=lfHiPJ0ZYOvYflmgJVISJRIBs0jtv0NkeXYWEleOdOVRjcID9ujWseOHzmsjHdoUaAbD
	 Qg+ouiLdnnEjxYK7n0oStnRi6GhBcumoK02kM90PE81VvlPAhXkuYF6XoNQkeA+e2qjrm
	 ExCA93h57V4aPLLcerC13E4F9ZlQIMzPzxunqyqocmyWNcbXZD1FXMiq6wXapUuzualEU
	 XDn++nAT+FEGWYVbulC9srEF/cbuK82IaviY9wX+OKPAGdCeKGK03E4Hi3X3n60Ex+jy3
	 QdN4pXUBXeYI6yDnnKcku8IZESmnlsCpHCsdq9qWOWSSSW7nUni7+xYXpQxQVX5k9Pw==
ARC-Authentication-Results: i=4; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791207504;
	bh=GFrTeKvQBaYvtUOPNMOrcJa6SVozWFtQdOX8hJzulwI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XGoefEjwzf+7pT4bPKLxFExjg625T2GugnWkLfgHZVM4Uu35qAVw2DLqFfy+gv7Rn
	 8vomCEe7j0j91zRx6Tm6NsPygZ/fdKGxYSCeGf/TZaiQ6oLGnHCSgWfB3SRxHVrvxf
	 oVLSeD93JOCIc2XYWoZrTsYgKZlWzQ1fJrxxAamYaswp4Hs+K2XKx+6RtPwM2B7Vy1
	 ACUW63gMIlRQ2IM8fHT16zbAhhl0T+6CHXBHZUQ7UId5m9xI5Mun74XSv6KzbvEiCk
	 vUPJh3X2Mucsx5bIBlZmC8FQLN16jPZp/xzd6OibEjOIPivWD90gOZYXSIppNvJEE2
	 1cmqvssW6WN4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DC31D40613;
	Mon,  5 Oct 2026 13:38:23 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6588A338
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 610CC40184
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:06:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OVNyo74Yk0Tn for <u-boot@lists.u-boot-project.org>;
 Mon,  5 Oct 2026 13:06:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 709D540188
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=2
 smtp.remote-ip="2a01:111:f403:c200::1"
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791205615;
 b=Kde+j2T4lWmTMdL8RQZQvnIkYYP6ex8aE3V1j/nkV8zJmA6PoATH12z52QHfX/5z/Tcp
 0MtqsdSFpv9tmxKzOJgOm0y7qXedFgpgJVs2/yhYge1Q8g8jjW9XwgmujUtUk4f2TV2Ew
 wF4tppX1FTKAt3rlpVYKPoWk6NjqMUZT8+nthoza0zBMgYRPcVcIEpGzYlMoEbUo94Abk
 fTMtIc7ruWQw4WR+416Zj05CHsqpo9lJAbwPIIGy9lXzHSkuA7UZ0AQvW8ZXGXT5gNPXX
 rTkkr+8WgCp/aBvQpQxQ9p68EAbunKvCAijoXaTwbyhAskzaby2VIMK6/xsAv6L27kA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791205615;
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
 bh=GFrTeKvQBaYvtUOPNMOrcJa6SVozWFtQdOX8hJzulwI=;
 b=VgwKvB1QueC++RSjLraV9/I6E6pzLkF7d056yF1u9PK8uPt1uCTz4mc87svKn3jzHHnA
 9icVNd0EThUSszLb7DKeMEq7Wku5YBJJAAAvoiIKUY2RecqLN6weESii7+JpBuQOkXkc0
 AWVuk8vmLHVM2pXa3JKnckP4AYe6x5L1B92jw13+UhhQfGeQACh3sKl0XB2uv0KhUsOxP
 8PKOOtr1nKl6gufvt8al1I3Vfmg0He63a7C1POl3+GF411fuC4Dl8vA5dQ94UOpjZzzsR
 OjbIUSbFWy9KfgDdgc2wiwvffJ6p6ZdsbCOM34v4kKJMhOihA4zZndiR+Q5l+ssHUXA==
ARC-Authentication-Results: i=3; smtp2.osuosl.org;
 dmarc=pass header.from=arm.com; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=VFERIitd; 
 dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256
 header.s=selector1 header.b=VFERIitd; 
 arc=pass header.oldest-pass=2 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=harsimransingh.tungal@arm.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=VFERIitd; 
 dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com
 header.a=rsa-sha256 header.s=selector1 header.b=VFERIitd
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 709D540188
 for <u-boot@lists.u-boot-project.org>; Mon,  5 Oct 2026 13:06:52 +0000 (UTC)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=sb65JmRSY3HieOxfMH8UyiUSOIwqvX6ssuw3DNzzi/lA8dYQic9yVUrTOOd6BStHzsAQxgvJjSX3IfWBqU1rY5dz1vcUxRDsSOxEB/bIkEr8kAivf2MGXlRAWP8CoJ4mcp+2V3JyiMZWk/CiD9+CMFdqNLzIfn3brJzBI21OJ4FdxN6LlJBn6qAc09vZ4Mi3+H4CnvkyZG4MaFfoOzTUEGsTVRXZ2jh+40Kv9/0kxjWq38rVABluVmmaRParqTMm+PaewpNI2k//8iVjqI85iX56T3+kc13Mb5WL0CZVk7gcoHa5RF+3R+vplp2x9Ijpe/i6R9LOVWChbG5+YGdd8Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFrTeKvQBaYvtUOPNMOrcJa6SVozWFtQdOX8hJzulwI=;
 b=yyoDz1rzwUzfT9poXqL4zeUIoQqnn/llLF3f7z7yimHBLV/O2DH3NMsBvhmyLDHGyLZtlAhpZYpqgPgpXF2dFLJHmiJGA2x5x9f0dWziQtdJPOlBEKKI+XDmfAkse6xYeYVU72IiwZqnEYNCFc32o14E4Q6mkuHrzMhk8sjOSmrQlTU43J2Vd5HRtHWtZjwigT3anuIILhuKDIno8a6xzb1zqLSfuycWVCamgJTebI9o9pQ/P2LoXhUZBgcYzKhZjlt/+QZihB9aL9a3JerdMd40/4MSvADis+0R4LssP9nv6OMICqNOas8KdicXfrN4BemT9VQTeoYRG8IZ7e1uMw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linaro.org smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFrTeKvQBaYvtUOPNMOrcJa6SVozWFtQdOX8hJzulwI=;
 b=VFERIitdbgefq+fo22pcQzVGgxM7GVsylUc5838OzZRNCNTkGRBcpDFsRctzcjWkg5b+MMMTWm9m6GML5q4Jq9hNkUNbSLzKznl0GEAOiv2Fb21zrysqFAmL3ph35FvO3A2zOGwjMOctvxgo4xl5DDnpkDx1XGvep4C13pag2FU=
Received: from PAZP264CA0095.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fb::19)
 by DU4PR08MB11080.eurprd08.prod.outlook.com (2603:10a6:10:570::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.14; Mon, 5 Oct
 2026 13:06:43 +0000
Received: from ZR1PEPF0000E6B1.eurprd05.prod.outlook.com
 (2603:10a6:102:1fb:cafe::1a) by PAZP264CA0095.outlook.office365.com
 (2603:10a6:102:1fb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 13:06:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com;
 dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 ZR1PEPF0000E6B1.mail.protection.outlook.com (10.167.241.88) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 5 Oct 2026 13:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pbjx3djyi+q2u4xHlGRgv4V7ORxNY+JnrDC1Yk/xkeMoep7PtlEZgwYXuBBsPW1ZmacyFl6nMQ+yIq2c+71+324QkbNCuGRg5qR5V9o6d5mCdmfTN/ISm+VCsGqmW4r8GmfRppvSsWgLz5Ik55gebshp5ixpJDdYoM/xuFilq5PNg92b6vLr7dQiD2nVCy4oOeIoSqAEw22ym9SfczqRWDKHe/n9HX3FoOQPzEw7PPPNThQTEUY71un3LTBZl8HAUyxQUu2dXCNxtmrJCMCMaxdFuZSIp6orzL7K/zfCheRNYxNlEw0sMz5iO8LP+3LVtBtyZ4BNDGivFAsjvEzYbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GFrTeKvQBaYvtUOPNMOrcJa6SVozWFtQdOX8hJzulwI=;
 b=FtFiRSl1qnFbNOpmPLhBm8ZXdj9HPhxy1JbNvr1ALHuGsLj7I1gb2JwuK1krAW+n9ZHz+vZu6YH4fRgWCUWt/YOZeFnuNCt2j84jSmcpoMcMzgivRAue6Q5uoKitBLw0NnFM1knQYVMkGHkXzIUUkpmh9F4KjFi8SQq3nOgClilaLAb+Bm+h2bV6TcGZk8AgGWRf9J4pq9eRNBbxRJAPDngrqcEy85llwabOZB6bsJLrkVGL87tb1UUc0gKtxFfZG6CMnrc11y1njK3RXc/SHaUTEk6Dctg/hLkNq+b65mseYBoWvUpqQoT9ayJKpxjarF3LN5WwFN+O19pEuiM1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GFrTeKvQBaYvtUOPNMOrcJa6SVozWFtQdOX8hJzulwI=;
 b=VFERIitdbgefq+fo22pcQzVGgxM7GVsylUc5838OzZRNCNTkGRBcpDFsRctzcjWkg5b+MMMTWm9m6GML5q4Jq9hNkUNbSLzKznl0GEAOiv2Fb21zrysqFAmL3ph35FvO3A2zOGwjMOctvxgo4xl5DDnpkDx1XGvep4C13pag2FU=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com (2603:10a6:20b:1c6::23)
 by AS1PR08MB7537.eurprd08.prod.outlook.com (2603:10a6:20b:481::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Mon, 5 Oct
 2026 13:06:08 +0000
Received: from AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad]) by AM8PR08MB5620.eurprd08.prod.outlook.com
 ([fe80::618d:6218:6962:17ad%6]) with mapi id 15.21.0496.010; Mon, 5 Oct 2026
 13:06:08 +0000
Message-ID: <eca5e6ca-ef4a-4e20-9255-f7d20ebe0788@arm.com>
Date: Mon, 5 Oct 2026 14:06:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/22] efi_loader: enable TEE runtime SetVariable()
 over FF-A
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Devaraj Ranganna <Devaraj.Ranganna@arm.com>
References: <20260914110106.1974894-1-harsimransingh.tungal@arm.com>
 <20260914110106.1974894-14-harsimransingh.tungal@arm.com>
 <DLINF8X5LGMM.22DVNGKNPMAM8@linaro.org>
Content-Language: en-GB
From: Harsimran Singh Tungal <harsimransingh.tungal@arm.com>
In-Reply-To: <DLINF8X5LGMM.22DVNGKNPMAM8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P265CA0073.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::6) To AM8PR08MB5620.eurprd08.prod.outlook.com
 (2603:10a6:20b:1c6::23)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM8PR08MB5620:EE_|AS1PR08MB7537:EE_|ZR1PEPF0000E6B1:EE_|DU4PR08MB11080:EE_
X-MS-Office365-Filtering-Correlation-Id: 8858d2d7-51c3-4b7d-6f26-08df22e1803b
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|4143699003|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original: /jKR3S+yVfGy+FXM2lFE9+adnbiwri+n6Deg4tzPPqOOTywWcd8aFyXZh4gFPjyfjfE+pXyRpcWD+CA44bpKILUJ7zecxt8lQW/Gh6knxba7toOAM/tWRvHwpCuUZvx3t2dfFx1dLcQ+rtIICZTxnQNNwxb+tKNrqrLa18BoTEKC1de2Q+CtLHFkAiKwOkGS0FGIVhizF/v9+A0EC8Bv1vjP7H9Ta3IJ1cNInYa6sqjCHbxs29JoCT7JaKC1Iv19SQmuHMdDha7so+nXdH15PA5aCgpdTi9zi/RzIChZ+WUfd9VpVTXcBfYwHw6Xt1E09p6ty07xYXMgD78WTql0t+DiHImSpvluFkJLsuOvnLZAsoL7PI/XinvYA2h8cljWDXdZoknW/ueQ1mC8FR95L1jiW95tasYoo948b/01W0iZ15qvvMtyacRlDEGJ0QqqPt7EGxZHRb6pAIUx2jcq5sankOlR+QTwcaN2FoMaz5Xa/9hYymOXc+0yv3gmuceiwT0V6o3lfjhzUWFxMy0gI6RJvnFnWQ0TMUq+opxKZRu8WJUVR9lHZxbtwYL5mqM5z6ARljFR0H1dB4zR05cI5TzlG6vTKNv8H4SghzubB/4OIAHIlGU+ICnSY0+rxAy8gS55AZA7mfK+p3tI+Z2C/KZDacHLtGKCdRuIkUjK+Bc=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM8PR08MB5620.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-Exchange-RoutingPolicyChecked: Wgvn/QQuZSd1DffCFwMEor42BP3nFM42GH751SDjvc+Pwxau3Mf77VPifRhNAGSnynP8P8/KFOsHXXRA6nrQdJhZtdlkQyd9e5nSgEd9fjm80dI40hrqeSLvNWeGVVwkAAIlVoqpStfsTgZ2dI3swIBq2GoJ1xMDDJdwfAI+ph+6i1pJrczZCLgN44Vcz7xDCrfhunm8UGSlU0xNnTQmRlfsTfjZJbHwmVsEIMnR+lPRIEU9OGN9LoNVYAOCoaUz+W8/+nfxEP369bpy84qcDHSSFEYHLFG8NaDIrnvHgSvs+r8OKibPhZVZiQXpn3yud9xjnsI0faH8Zr4t2gb9Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR08MB7537
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: ZR1PEPF0000E6B1.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 5ebafe14-bbe3-4d14-127a-08df22e16bb2
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|376014|14060799003|23010399003|36860700016|82310400026|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: RqQCviYPNcSV0jDjHX89Al50qxlj+0FtGxVmyZ/CblaI1MoSEyKMEGDAwE/h0Qrwa29edtufOgzj9vlp1uUCZ2vF0QTSWy1u80i2CLMGjizjmop6YpFhUNb/dWOvibouuknuXRrryNGW1avajBe7xXOTcjNLSGkF1CZPVx8EINVrVyJ+m4OmU1aSFeKB+oOZzfvuQlbff9zHHDSx8n9ebTpUlHMd/3YQvZDtooTQ8J8afas/o99feP2PVDrpIBKcqNXQSENFBMbl6ETgw64jGzMus0Fko8vcy/Q7GOt+vpX3wOTd7RaVEt5qpRrGGoJOBcPUAdGXf5NA0HwZkiiCbzafNCb3yHgUeFf//IXPemOgJrtcEtCGXp/2ATPd5peYfMSkuPuaQqm9ifxtyWbLwlP3WL2KC8NsYRnNhalEPf8vwasYIXJEAKy8A/FLpidgbCukCJDuF6pgbnerNSZF72I6GGKH5Z2zb45cGkX5T1sYYUwrNVx8fBgaR5zhNjWWQOc/FE6K4nluI/MeUVczjv4Gg74X7tJm3H+Sb4Q4CykJUZ3p3EAwUTM0C4gA38TM/Ta/c5PVqs0PZRipkug349/YmnUmuY6f946w1SPt4E0vfNsTvUjbjeLZJvrrsVA3l8cpIYG/aoReRTMvBvmEr0TBEIDmJKtjbjILwtyd/yD6m3/CB4k/dSZaROk5rlIk6ZLgR/QUp4OuyJSIZvxYrA==
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(376014)(14060799003)(23010399003)(36860700016)(82310400026)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CF/TW0yvJvpSgcHkzWpqsG/TYC3i3egJ2zcyaXrLaEfRgAmTP68jMR1iRScbALFX1IbS5dUG0M5aRnUm3lRTxdm6no+5Jgui831qLe9376Dqikdml+RhRV1+qOIqf9k1LzERf0wUl0irKpyF2m/yQZvBOsGp3BKbBPptt5GYx3gqp+yckn9xI9LCA3Bfvr8SQhLAelkeCqc9UafOr2Ro2J9qNJgWG2vs+kCeZqYC+qgDGpLQgDmwDh0gygXdak3QiyWMboM8BQcTTqCEWSAH1M1eHtFtcITymBSZWiz8O8PXyWobCjru10xROxgHlp51kzgzlHi7SKFaGr756ZN/yDUKyTfr3lkxg81DC+J5uhonU/3ZVb8AMHZAtSGDZe74+LOS0N/B1+7hw3NCMgqrX6Y8Bm9BKX8NYmSc0emm3VofwIXaSr6kKFcbsPm4MI39
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 13:06:42.2551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8858d2d7-51c3-4b7d-6f26-08df22e1803b
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E6B1.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11080
X-Mailman-Approved-At: Mon, 05 Oct 2026 13:24:22 +0000
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



On 18/09/2026 19:20, Ilias Apalodimas wrote:
> Hi Harsimran
>
>
> [...]
>
>> +                                                       efi_uintn_t name=
_size,
>> +                                                       const efi_guid_t=
 *vendor,
>> +                                                       struct var_check=
_property *var_property)
>> +{
>> +    struct smm_variable_var_check_property *smm_property;
>> +    efi_uintn_t payload_size;
>> +    u8 *comm_buf =3D NULL;
>> +    efi_status_t ret;
>> +
>> +    payload_size =3D sizeof(*smm_property) + name_size;
>> +    if (payload_size > max_payload_size) {
>> +            ret =3D EFI_INVALID_PARAMETER;
>> +            return ret;
>> +    }
>> +    comm_buf =3D setup_mm_hdr((void **)&smm_property, payload_size,
>> +                            SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PR=
OPERTY_SET,
>> +                            &ret);
>> +    if (!comm_buf)
>> +            return ret;
>> +
>> +    efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(*vendor));
>> +    smm_property->name_size =3D name_size;
>> +    efi_memcpy_runtime(&smm_property->property, var_property,
>> +                       sizeof(smm_property->property));
>> +    efi_memcpy_runtime(smm_property->name, variable_name, name_size);
>> +
>> +    ret =3D mm_communicate(comm_buf, payload_size);
>> +
>> +    return ret;
>> +}
>> +
>>  static efi_status_t get_property_int(const u16 *variable_name,
>>                                   efi_uintn_t name_size,
>>                                   const efi_guid_t *vendor,
>> @@ -768,6 +800,49 @@ out:
>>      return ret;
>>  }
>>
>> +static efi_status_t __efi_runtime get_property_int_runtime(const u16 *v=
ariable_name,
>> +                                                       efi_uintn_t name=
_size,
>> +                                                       const efi_guid_t=
 *vendor,
>> +                                                       struct var_check=
_property *var_property)
>> +{
>
> The changes between this and the non-runtime version are limited to a few=
 memcpy/memset calls.
> It's pretty easy to only keep the runtime version and get rid of all the =
duplication. Same
> goes for the set_property_int()
>
>> +    struct smm_variable_var_check_property *smm_property;
>> +    efi_uintn_t payload_size;
>> +    u8 *comm_buf =3D NULL;
>> +    efi_status_t ret;
>> +
>> +    efi_memset_runtime(var_property, 0, sizeof(*var_property));
>> +    payload_size =3D sizeof(*smm_property) + name_size;
>> +    if (payload_size > max_payload_size) {
>> +            ret =3D EFI_INVALID_PARAMETER;
>> +            return ret;
>> +    }
>> +    comm_buf =3D setup_mm_hdr((void **)&smm_property, payload_size,
>> +                            SMM_VARIABLE_FUNCTION_VAR_CHECK_VARIABLE_PR=
OPERTY_GET,
>> +                            &ret);
>> +    if (!comm_buf)
>> +            return ret;
>> +
>> +    efi_memcpy_runtime(&smm_property->guid, vendor, sizeof(smm_property=
->guid));
>> +    smm_property->name_size =3D name_size;
>> +    efi_memcpy_runtime(smm_property->name, variable_name, name_size);
>> +
>> +    ret =3D mm_communicate(comm_buf, payload_size);
>> +    /*
>> +     * Currently only R/O property is supported in StMM.
>> +     * Variables that are not set to R/O will not set the property in S=
tMM
>> +     * and the call will return EFI_NOT_FOUND. We are setting the
>> +     * properties to 0x0 so checking against that is enough for the
>> +     * EFI_NOT_FOUND case.
>> +     */
>> +    if (ret =3D=3D EFI_NOT_FOUND)
>> +            return EFI_SUCCESS;
>> +    if (ret !=3D EFI_SUCCESS)
>> +            return ret;
>> +    efi_memcpy_runtime(var_property, &smm_property->property, sizeof(*v=
ar_property));
>> +
>> +    return EFI_SUCCESS;
>> +}
>> +
>>  efi_status_t efi_get_variable_int(const u16 *variable_name,
>>                                const efi_guid_t *vendor,
>>                                u32 *attributes, efi_uintn_t *data_size,
>> @@ -1001,7 +1076,7 @@ efi_status_t efi_set_variable_int(const u16 *varia=
ble_name,
>>              var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_READ=
_ONLY;
>>              var_property.attributes =3D attributes;
>>              var_property.minsize =3D 1;
>> -            var_property.maxsize =3D var_acc->data_size;
>> +            var_property.maxsize =3D data_size;
>>              ret =3D set_property_int(variable_name, name_size, vendor, =
&var_property);
>>      }
>>
>> @@ -1078,7 +1153,7 @@ efi_query_variable_info_runtime(u32 attributes, u6=
4 *max_variable_storage_size,
>>  }
>>
>>  /**
>> - * efi_set_variable_runtime() - runtime implementation of SetVariable()
>> + * efi_set_variable_int_runtime() - runtime implementation of SetVariab=
le()
>>   *
>>   * @variable_name:  name of the variable
>>   * @guid:           vendor GUID
>> @@ -1088,11 +1163,69 @@ efi_query_variable_info_runtime(u32 attributes, =
u64 *max_variable_storage_size,
>>   * Return:          status code
>>   */
>>  static efi_status_t __efi_runtime EFIAPI
>> -efi_set_variable_runtime(u16 *variable_name, const efi_guid_t *guid,
>> -                     u32 attributes, efi_uintn_t data_size,
>> -                     const void *data)
>> +efi_set_variable_int_runtime(u16 *variable_name, const efi_guid_t *guid=
,
>> +                         u32 attributes, efi_uintn_t data_size,
>> +                         const void *data)
>>  {
>> -    return EFI_UNSUPPORTED;
>> +    efi_status_t ret, mm_communicate_ret =3D EFI_SUCCESS;
>> +    struct var_check_property var_property;
>> +    struct smm_variable_access *var_acc;
>> +    efi_uintn_t payload_size;
>> +    efi_uintn_t name_size;
>> +    u8 *comm_buf =3D NULL;
>> +    bool ro;
>> +
>> +    if (!variable_name || variable_name[0] =3D=3D 0 || !guid)
>> +            return EFI_INVALID_PARAMETER;
>> +
>> +    if (data_size > 0 && !data)
>> +            return EFI_INVALID_PARAMETER;
>> +
>> +    /* Check payload size */
>> +    name_size =3D u16_strsize(variable_name);
>> +    payload_size =3D MM_VARIABLE_ACCESS_HEADER_SIZE + name_size + data_=
size;
>> +    if (payload_size > max_payload_size)
>> +            return EFI_INVALID_PARAMETER;
>> +
>> +    ro =3D !!(attributes & EFI_VARIABLE_READ_ONLY);
>> +    attributes &=3D EFI_VARIABLE_MASK;
>> +
>> +    ret =3D get_property_int_runtime(variable_name, name_size, guid,
>> +                                   &var_property);
>> +    if (ret !=3D EFI_SUCCESS)
>> +            return ret;
>> +
>> +    if (var_property.property & VAR_CHECK_VARIABLE_PROPERTY_READ_ONLY)
>> +            return EFI_WRITE_PROTECTED;
>> +
>> +    comm_buf =3D setup_mm_hdr((void **)&var_acc, payload_size,
>> +                            SMM_VARIABLE_FUNCTION_SET_VARIABLE, &ret);
>> +    if (!comm_buf)
>> +            return ret;
>> +
>> +    /* Fill in contents */
>> +    efi_memcpy_runtime(&var_acc->guid, guid, sizeof(*guid));
>> +    var_acc->data_size =3D data_size;
>> +    var_acc->name_size =3D name_size;
>> +    var_acc->attr =3D attributes;
>> +    efi_memcpy_runtime(var_acc->name, variable_name, name_size);
>> +    efi_memcpy_runtime((u8 *)var_acc->name + name_size, data, data_size=
);
>> +
>> +    /* Communicate */
>> +    ret =3D mm_communicate(comm_buf, payload_size);
>> +    if (ret !=3D EFI_SUCCESS)
>> +            mm_communicate_ret =3D ret;
>> +
>> +    if (ro && !(var_property.property & VAR_CHECK_VARIABLE_PROPERTY_REA=
D_ONLY)) {
>> +            var_property.revision =3D VAR_CHECK_VARIABLE_PROPERTY_REVIS=
ION;
>> +            var_property.property |=3D VAR_CHECK_VARIABLE_PROPERTY_READ=
_ONLY;
>> +            var_property.attributes =3D attributes;
>> +            var_property.minsize =3D 1;
>> +            var_property.maxsize =3D data_size;
>> +            ret =3D set_property_int_runtime(variable_name, name_size, =
guid, &var_property);
>> +    }
>> +
>> +    return (mm_communicate_ret =3D=3D EFI_SUCCESS) ? ret : mm_communica=
te_ret;
>>  }
>>
>>  /**
>> @@ -1129,7 +1262,7 @@ void efi_variables_boot_exit_notify(void)
>>      efi_runtime_services.get_variable =3D efi_get_variable_runtime;
>>      efi_runtime_services.get_next_variable_name =3D
>>                      efi_get_next_variable_name_runtime;
>
>
> All the get_variable*() calls used to point to the function from efi_var_=
common.c.
> By changing this you are breaking the runtime case for OP-TEE since now w=
e will get
> EFI_OUT_OF_RESOURCES.
> There's no easy way to fix this at runtime. For OP-TEE the kernel might r=
eplace this call
> with an internal OP-TEE call if it's part of the firmware and announces i=
t can provide
> EFI runtime services. However, the default uuse case, which we don't supp=
ort SetVariable
> at runtime only needs to keep working.
>
> I'll post a script next week so you can replicate and test this in QEMU w=
ith OP-TEE etc.
>
> Cheers
> /Ilias
>
Hi Ilias,
Can you please share the script, so that I can replicate and test this
in QEMU with OP-TEE?

Thanks
Harsimran Singh Tungal
>> -    efi_runtime_services.set_variable =3D efi_set_variable_runtime;
>> +    efi_runtime_services.set_variable =3D efi_set_variable_int_runtime;
>>      efi_update_table_header_crc32(&efi_runtime_services.hdr);
>>
>>      /* Record that ExitBootServices() has been called */
>

IMPORTANT NOTICE: The contents of this email and any attachments are confid=
ential and may also be privileged. If you are not the intended recipient, p=
lease notify the sender immediately and do not disclose the contents to any=
 other person, use it for any purpose, or store or copy the information in =
any medium. Thank you.
