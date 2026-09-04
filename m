Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7C3AC624DE
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:38:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A04B160BD1;
	Fri,  4 Sep 2026 08:38:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RcdT9fPqISIE; Fri,  4 Sep 2026 08:38:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4DEFF60C13
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511081;
	b=XCM+ElqSwidByc4lnZX7TIHl6P0JqB9h/CuImRuYIDvn1BX+wTBHEIHN+z/zzE5C1r43
	 s9xEI3mBR4zREb3cAp7IZDqPoCcA+s4DzM6/P9FyQFhBm5AjrEoydjk1XlR/CDsCc0tk3
	 ndd51XnIG46TJyAY3UbHDabmGyB3aO09dRNlJDQ6QgZuQCr0e6iOLrBUUHxXLCnFI184w
	 LBiP+O/NlfYsbte5xyc6JUqWiFn9QAm5zfZKPWUiw4WL7ggPbUc1I/KQm35nFaoohrmV0
	 Olc0d/Fl1GQsIamFHhe8XhbYxL7WNXrirpmqFE+3D2aspc7KL8mbeziwoMeHZGNKUsg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511081;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
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
	bh=gNhxXAiuyX75WotetN+RFYf661vzvOQ7+NWjlQYCLTY=;
	b=EVcUPW7rT9mb8Lz+1BD1Cy2TiPm74J8tFJzYEka/BhYOMi7RHWXgjab1M351Gk0bmX7n
	 pOcCAUJ2hUCJd7VvD3Y7wK2YoeUUkRBwR98C4v5D2LaFMa4hqJRNDnKcaMhZmlqNpFzUo
	 sehAoWE9vLjreRHyvdtOOxcdzYLgaZN7XHwqF63FVVyb5zoyPMUTLOOftSSFX/R9EZnvG
	 BQ6krudG8gfh8UjJ97yZl3rA74LsJboQY2tAIyYlRVY9SUJiwfcqI2q4+uZ3E28Hh+sna
	 8x7GSfRigCq+kWbNWBHLKEefHSpXJ1AVx+yDK8vMtfil9ofljL2NliggMgUfri5jemA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=none header.from=softathome.com;
	dkim=pass header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-softathome1-onmicrosoft-com header.b=uAqY7jW8;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511081;
	bh=gNhxXAiuyX75WotetN+RFYf661vzvOQ7+NWjlQYCLTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zc6xq64CHEakE/p+eq8FpuK+dK8H+I+Wtt5K0CsZBI9CJ9ANeqV7qnISoXoyKL65S
	 DdKTs6StscZJ5gWcHiY59jnTMC65JQHpK1SdOhWyTzvV9HDrD11imkQd6vEN4TdmMt
	 /uT88zKbbY8l5usoceu//4+JJTnB4bAU8dkpZ5iOc0jsJ0C5TdxEYzUor/RpwbKKKd
	 zYeNnM8TUBUwNVprMUg0ZVxRjd4aCxBXJ0gUyjrknoo4Fqv3NPVaEDTo9F06KCoDTh
	 8iPoEa3gUCh5MoZs8/OCjrlmJ2DYknRgJ3xPY128isiGsLpvYQkw5M6p2w9RHLg9cu
	 vBsPh8Hpp6scw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DEFF60C13;
	Fri,  4 Sep 2026 08:38:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 00EAD3AF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BFB8C607FF
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JIxb4uNq2YmP for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7B92760BB6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511052;
 b=aZvo8pSxY1waaN7ZHK4+S8pN8fD69abMmQP69xmj3PC0xW/YoSMVYuw/r9yYyBdVcWHG
 Va99OMp/GUvkyqX59DWQUTbdcCRZgi7vN99fs2htpNAqR2yU+03uZvrT3QIONS5y7vv5B
 Atqv6cuV7HVJBUR+uccziEz4QfAs8B9mO7iscRhFwQxp8QIwgmj0miZxCAOr4VHFkIbJs
 k8KBTMnl1VYiCkrM6jzqv1fyOWbxOSjWYEPn6jXo7QrKM/7UquAhr0m8jWqFvzYwduCcU
 uEdPVLQFi2WwTDpQPcl5IufyAjDYDqRMCPIX1CvgxeRJd7jqzT1pdAyJrdNFAjqxcrA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511052;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:Content-Type:
 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
 X-MS-Exchange-CrossTenant-Network-Message-Id:
 X-MS-Exchange-CrossTenant-Id:
 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
 X-MS-Exchange-CrossTenant-FromEntityHeader:
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=gNhxXAiuyX75WotetN+RFYf661vzvOQ7+NWjlQYCLTY=;
 b=WIde1/S1XI7MXKm2yxkx99xkCFy4rp81VrEyXsaYoy0Ee8m7BBSAQTS0P50B5b4LV+Jj
 R2dY09x4+bulU1xr9nLBgtTyDphAwXFFqoeu2jQcBwhCsdYhF2ud3JaKaYDHqR165bXh0
 npyjHrSGNfOoHhSU6bAeUt31eLWr8Dr70wYRUJhqWPKmzpGAugADs1Ua4ffngU7RoLm3s
 iPMJJuJBZP3TLsXD0lOmN8hEzzJVtSMOjVQEZQtTGnRSp9XYufKrSpCSz9T1cRsvWlZbM
 Jap8aVhjji04ig8gRFrr5InjSe8fx1Oll/H9sKgtjbpXtX3U5hFKC6WBC83i8wE28/w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=uAqY7jW8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a01:111:f403:c20a::;
 helo=pa5p264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=uAqY7jW8
Received: from PA5P264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7B92760BB6
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJa/tx4jgJU4HXkllOdV+BbSzq+4woxuQ06wInkXCdor077XxbDwlCD6OFFgM+N9Vj+G6+XqVR21HpFoosqgu29BKqu4Y9hI2bvJA7qOjASIXG/AhV4c62eZCx6ClHp+GgEnRx2LE54B9XsEOd0X5sj4IfDROI5+KeG3z9FuSxoXVBg8CnotC/ASe8bO98iwM/dP7NOMkDwwaiL+Bghg+LlWndKinVw4frNuxZ7+eB8l9YKngia+VHVWwRHM3nhIycJTHzq5i6gnJC5BTGEFRY1xIMuMUFlWL/pxc3vygy6nNSNurpGvymyYIAYGs0d4UkSUsejikygv+mKkhdjh3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNhxXAiuyX75WotetN+RFYf661vzvOQ7+NWjlQYCLTY=;
 b=bb01SIA+Mc08pm1f6XG0LzJ+mYt/+76GPiUryOSEjdwf7QHHw0opeGjWsR3BCwPxUikmR/FPIF/7fC5pQl/lH1VsElDwZsq9KZMmqCBFHCN1mAnC/MS7jOQYo0djEq0Kyi/bSCYiQSL63WalzRfIs59ZmpIBrAvx/pZZHUSqrUpGLcQa1G6KuLIrE7pTSwPLGjPQ0jXMrGLC3069H8ElG9aO6zZb2hn5F7VecvlG703vircAVLAb18cbRGFVASc19ete2HgMY9zlFfkF0oUZ1Au1ra3otUJBflJL0+8dukX3i7dBsEivmckTPMvg2eD2cIhycJtPx43LQbxAQKj9ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gNhxXAiuyX75WotetN+RFYf661vzvOQ7+NWjlQYCLTY=;
 b=uAqY7jW85a9+de/D1e5p79uDBGMSVrBZh04RieYSKi8KH6OdDVCZ1gDcvQGPZN5797uN9dhPFHs3fJ9YQ76t/1SQ4JQoeD+fezj2M+LSK57nI8kfuZz5vhut9KGF3F0Ih8LFoxOofhT5lbZkmtWzUpcZRtxmrSF+2i/XqLdiy9jNZlsg//esgyw0V5CvX/hRs5EfNExY1nzqdicTslAATiQK9/Kz03GeKjTq71CS3WCpdTYLMa/IJUQohwgwCkyk57h+D9FdhZaGpvcQnx7MUBqsMvdmd4geA1hlDuhXgnztmDZ0MaktoJEd3t2PYFK2eyW/LohFUw8h9jAgynrNYQ==
Received: from PAYP264CA0031.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11f::18)
 by PR0P264MB3337.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:110::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:22 +0000
Received: from PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:11f:cafe::4) by PAYP264CA0031.outlook.office365.com
 (2603:10a6:102:11f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.13 via Frontend Transport; Fri, 4
 Sep 2026 08:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA3PEPF000089B9.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:22 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id 614E920061;
 Fri,  4 Sep 2026 10:37:22 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v10 07/15] test: py: vboot: prepare integration test for ecdsa
Date: Fri,  4 Sep 2026 10:37:11 +0200
Message-ID: <20260904083719.53132-8-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PEPF000089B9:EE_|PR0P264MB3337:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e130eb9c-42e3-415d-5d1d-08df0a5fbd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|10067099003|6133799003|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 1V2ABAncp6o6gRrKzcziPxKpxBiD86y+CM2FhBwed5L5WtjUw84pth/e96//FYrNtqbPyRzTT6MZhwidlr/RyK3l1EoiDZVpoqe/TAFJOJXWiHax2O9+5A7o0Y1r5dSyh7hp3g7+vp2uTnYAadnuJE6RxTGTUBFCyXAnoeAeQfZDk2rI2J8HXjaZPojE/25WgKXH5DY7FoO2wlZfDzit1ebqePth0pW1w/XgiYDxVBhMUI3BVf8qrPLoQd63w3ptM1M34a6iWhc75SMnKDto82bu/QIbfmP4xWcuh05jGgJTXTeV0b4XQUZ6PdaZLrU+zwxkv9vCiv7HBZcfdAS7shExSjIKf+Gdgj+nGWjgn1biOa5T3H9GyxXFsWHY9Zatic7JsqyxYeXQfDG+YaCxBzwnX05zi2QJjI0ccyU++0i+jQnN2hT4WTUkS80gEGdkJxhl/gK3bqVCVemlvCiVNSFJ54Gb6kb2BYVDye5lN07V/snKgKKzgQnhmmbJdDulm5OgAekIvr7ySyDWhe6JAjBXOAPIRtEEBvqMzyR+BrTLzyZ/6A8dDEmeGvwTbsud4dEn2YGWsIHT4kNR49hdz02Tjdkk4HBozUx1iXWVRMyHh5DBxE9QX8yQbWvLvNisvXfxivrm4jRH1s9q1xCir9sAqr35QDKG97nMUC426tNfb8GtDXgHO54uZXFPHzRwKiO0CQ6rtAjEda8MiHmIXA==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(10067099003)(6133799003)(22082099003)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0uXCkQmQelwnYuUO/ch44YhCm9wl0WRfKIjvLyVHa5k0a/ziFanAw/3gwWeKls0AsEBCSfF/lHGtgvm8Nmw7Pzwt2iHRJjWLx9MmcuUTcDjm3Myz09Pvq3kgUZVlBxyeCFz9PIb+Bg+Qrw9GkUF7kXH265QkUwmlBuWtBuDQKBK6W/nXnLy3O1pDOG9a76A9dxzeDApGVfS5vlGSUknqNQHkv7Tgl1WlIz36Bpok/b77Tsw8289TCJovgeczAWnNhjdheuKECm8P8ZMxRRvzabc5fbkUq3KKuBVPB26R3Mw4D/Be2jJuvZOhLtfPwZKI4jORcRRC4Exlx0ta/vyYo43a+/LzCjk25zzPihKFYcw/fKZfLjvLtxeMXPRdjLDeOrIj+Mk/ZX26HtHObzUPD+JDbeWzNzlj6+BLHjLITzeEubNxQ91asEF6w9A9ygdx
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:22.6207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e130eb9c-42e3-415d-5d1d-08df0a5fbd75
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA3PEPF000089B9.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3337
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

The vboot tests only consider rsa algo for signature.
To prepare the integration of ecdsa test, the signature
algo is now explicit.

Reviewed-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- initial version
v3:
- no change
v4:
- no change
v5:
- no change
v6:
- no change
v7:
- no change
v8:
- no change
v9:
- some minor update to fix rebase on next
v10:
- no change

 test/py/tests/test_fit_ecdsa.py               |   2 +-
 test/py/tests/test_vboot.py                   | 104 +++++++++---------
 ....its => sign-configs-sha1-rsa2048-pss.its} |   0
 ...sha1.its => sign-configs-sha1-rsa2048.its} |   0
 ... sign-configs-sha256-rsa2048-pss-prod.its} |   0
 ...ts => sign-configs-sha256-rsa2048-pss.its} |   0
 ...56.its => sign-configs-sha256-rsa2048.its} |   0
 ...84.its => sign-configs-sha384-rsa3072.its} |   0
 ...s.its => sign-images-sha1-rsa2048-pss.its} |   0
 ...-sha1.its => sign-images-sha1-rsa2048.its} |   0
 ...its => sign-images-sha256-rsa2048-pss.its} |   0
 ...256.its => sign-images-sha256-rsa2048.its} |   0
 ...384.its => sign-images-sha384-rsa3072.its} |   0
 13 files changed, 54 insertions(+), 52 deletions(-)
 rename test/py/tests/vboot/{sign-configs-sha1-pss.its => sign-configs-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha1.its => sign-configs-sha1-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss-prod.its => sign-configs-sha256-rsa2048-pss-prod.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256-pss.its => sign-configs-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha256.its => sign-configs-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-configs-sha384.its => sign-configs-sha384-rsa3072.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1-pss.its => sign-images-sha1-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha1.its => sign-images-sha1-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256-pss.its => sign-images-sha256-rsa2048-pss.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha256.its => sign-images-sha256-rsa2048.its} (100%)
 rename test/py/tests/vboot/{sign-images-sha384.its => sign-images-sha384-rsa3072.its} (100%)

diff --git a/test/py/tests/test_fit_ecdsa.py b/test/py/tests/test_fit_ecdsa.py
index 3e816d68eb6..e59390374af 100644
--- a/test/py/tests/test_fit_ecdsa.py
+++ b/test/py/tests/test_fit_ecdsa.py
@@ -102,7 +102,7 @@ def test_fit_ecdsa(ubman):
     with open(key_file, 'w') as f:
         f.write(key.export_key(format='PEM'))
 
-    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256.its', tempdir)
+    assemble_fit_image(fit_file, f'{datadir}/sign-images-sha256-rsa2048.its', tempdir)
 
     fit = SignableFitImage(ubman, fit_file)
     nodes = fit.find_signable_image_nodes()
diff --git a/test/py/tests/test_vboot.py b/test/py/tests/test_vboot.py
index e9259584e32..33cbcea5c24 100644
--- a/test/py/tests/test_vboot.py
+++ b/test/py/tests/test_vboot.py
@@ -84,21 +84,21 @@ def make_fit(its, ubman, mkimage, dtc_args, datadir, fit):
 # Only run the full suite on a few combinations, since it doesn't add any more
 # test coverage.
 TESTDATA_IN = [
-    ['sha1-basic', 'sha1', '', None, False, True, False, False],
-    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False, False, False, False],
-    ['sha1-pss', 'sha1', '-pss', None, False, False, False, False],
-    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-basic', 'sha256', '', None, False, False, False, False],
-    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss', 'sha256', '-pss', None, False, False, False, False],
-    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False, False, False, False],
-    ['sha256-pss-required', 'sha256', '-pss', None, True, False, False, False],
-    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', True, True, False, False],
-    ['sha384-basic', 'sha384', '', None, False, False, False, False],
-    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False, False, False, False],
-    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', False, False, True, False],
-    ['sha256-global-sign', 'sha256', '', '', False, False, False, True],
-    ['sha256-global-sign-pss', 'sha256', '-pss', '', False, False, False, True],
+    ['sha1-basic', 'sha1', '-rsa2048', '', None, False, True, False, False],
+    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
+    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False, False, False, False],
+    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
+    ['sha256-basic', 'sha256', '-rsa2048', '', None, False, False, False, False],
+    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False, False, False, False],
+    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False, False, False, False],
+    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False, False, False, False],
+    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, True, False, False, False],
+    ['sha256-pss-pad-required', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', True, True, False, False],
+    ['sha384-basic', 'sha384', '-rsa3072', '', None, False, False, False, False],
+    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False, False, False, False],
+    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', False, False, True, False],
+    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False, False, False, True],
+    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False, False, False, True],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
@@ -111,9 +111,9 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.requiredtool('fdtget')
 @pytest.mark.requiredtool('fdtput')
 @pytest.mark.requiredtool('openssl')
-@pytest.mark.parametrize("name,sha_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
+@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,required,full_test,algo_arg,global_sign",
                          TESTDATA)
-def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
+def test_vboot(ubman, name, sha_algo, sig_algo, padding, sign_options, required,
                full_test, algo_arg, global_sign):
     """Test verified boot signing with mkimage and verification with 'bootm'.
 
@@ -287,7 +287,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         utils.run_and_log(ubman, 'openssl req -batch -new -x509 -key %s%s.key '
                           '-out %s%s.crt' % (tmpdir, name, tmpdir, name))
 
-    def test_with_algo(sha_algo, padding, sign_options):
+    def test_with_algo(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
         This is the main part of the test code. The same procedure is followed
@@ -308,7 +308,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT, but don't sign anything yet
         ubman.log.action('%s: Test FIT with signed images' % sha_algo)
-        make_fit('sign-images-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-images-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned images', ' - OK' if algo_arg else 'dev-', True)
 
         # Sign images with our dev keys
@@ -319,7 +319,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         dtc('sandbox-u-boot.dts', ubman, dtc_args, datadir, tmpdir, dtb)
 
         ubman.log.action('%s: Test FIT with signed configuration' % sha_algo)
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         run_bootm(sha_algo, 'unsigned config', '%s+ OK' % ('sha256' if algo_arg else sha_algo), True)
 
         # Sign images with our dev keys
@@ -390,7 +390,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
             run_bootm(sha_algo, 'evil clone', 'Bad Data Hash', False, efit)
 
         # Create a new properly signed fit and replace header bytes
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
         bcfg = ubman.config.buildconfig
         max_size = int(bcfg.get('config_fit_signature_max_size', 0x10000000), 0)
@@ -424,7 +424,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Create a new properly signed fit and replace hashed-strings
         # size property
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
         utils.run_and_log(ubman, 'fdtput -t x %s %s hashed-strings 0' %
                           (fit, sig_node))
@@ -448,7 +448,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
                   'Bad Data Hash', False)
         ubman.log.action('%s: Check in-bounds hashed-strings size' % sha_algo)
 
-    def test_required_key(sha_algo, padding, sign_options):
+    def test_required_key(sha_algo, sig_algo, padding, sign_options):
         """Test verified boot with the given hash algorithm.
 
         This function tests if U-Boot rejects an image when a required key isn't
@@ -470,12 +470,12 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT with prod key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'
-        make_fit('sign-configs-%s%s-prod.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s-prod.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Build the FIT with dev key (keys NOT required). This adds the
         # signature into sandbox-u-boot.dtb, NOT marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit_norequire(sha_algo, sign_options)
 
         # So now sandbox-u-boot.dtb two signatures, for the prod and dev keys.
@@ -487,7 +487,7 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
 
         # Build the FIT with dev key (keys required) and sign it. This puts the
         # signature into sandbox-u-boot.dtb, marked 'required'.
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
         sign_fit(sha_algo, sign_options)
 
         # Set the required-mode policy to "any".
@@ -567,8 +567,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
     dtb = '%ssandbox-u-boot.dtb' % tmpdir
     sig_node = '/configurations/conf-1/signature'
 
-    create_rsa_pair('dev')
-    create_rsa_pair('prod')
+    if sig_algo == "-rsa2048" or sig_algo == "-rsa3072" or sig_algo == "":
+        create_rsa_pair('dev')
+        create_rsa_pair('prod')
 
     # Create a number kernel image with zeroes
     with open('%stest-kernel.bin' % tmpdir, 'wb') as fd:
@@ -587,9 +588,9 @@ def test_vboot(ubman, name, sha_algo, padding, sign_options, required,
         if global_sign:
             test_global_sign(sha_algo, padding, sign_options)
         elif required:
-            test_required_key(sha_algo, padding, sign_options)
+            test_required_key(sha_algo, sig_algo, padding, sign_options)
         else:
-            test_with_algo(sha_algo, padding, sign_options)
+            test_with_algo(sha_algo, sig_algo, padding, sign_options)
     finally:
         # Go back to the original U-Boot with the correct dtb.
         ubman.config.dtb = old_dtb
@@ -616,6 +617,7 @@ def test_vboot_ext_data_bounds(ubman):
     by U-Boot to hold public keys from the signing process.
     """
     sha_algo = 'sha256'
+    sig_algo = '-rsa2048'
 
     def run_bootm(test_type, expect_string):
         """Run a 'bootm' command in U-Boot and expect it to fail.
@@ -684,7 +686,7 @@ def test_vboot_ext_data_bounds(ubman):
         sign_fit() overwrites the FIT, so a new one is built before each test
         case mutates its external-data properties.
         """
-        make_fit('sign-configs-%s.its' % sha_algo, ubman, mkimage, dtc_args,
+        make_fit('sign-configs-%s%s.its' % (sha_algo, sig_algo), ubman, mkimage, dtc_args,
                  datadir, fit)
         sign_fit('-E')
 
@@ -762,21 +764,21 @@ def test_vboot_ext_data_bounds(ubman):
 
 
 TESTDATA_IN = [
-    ['sha1-basic', 'sha1', '', None, False],
-    ['sha1-pad', 'sha1', '', '-E -p 0x10000', False],
-    ['sha1-pss', 'sha1', '-pss', None, False],
-    ['sha1-pss-pad', 'sha1', '-pss', '-E -p 0x10000', False],
-    ['sha256-basic', 'sha256', '', None, False],
-    ['sha256-pad', 'sha256', '', '-E -p 0x10000', False],
-    ['sha256-pss', 'sha256', '-pss', None, False],
-    ['sha256-pss-pad', 'sha256', '-pss', '-E -p 0x10000', False],
-    ['sha256-pss-required', 'sha256', '-pss', None, False],
-    ['sha256-pss-pad-required', 'sha256', '-pss', '-E -p 0x10000', False],
-    ['sha384-basic', 'sha384', '', None, False],
-    ['sha384-pad', 'sha384', '', '-E -p 0x10000', False],
-    ['algo-arg', 'algo-arg', '', '-o sha256,rsa2048', True],
-    ['sha256-global-sign', 'sha256', '', '', False],
-    ['sha256-global-sign-pss', 'sha256', '-pss', '', False],
+    ['sha1-basic', 'sha1', '-rsa2048', '', None, False],
+    ['sha1-pad', 'sha1', '-rsa2048', '', '-E -p 0x10000', False],
+    ['sha1-pss', 'sha1', '-rsa2048', '-pss', None, False],
+    ['sha1-pss-pad', 'sha1', '-rsa2048', '-pss', '-E -p 0x10000', False],
+    ['sha256-basic', 'sha256', '-rsa2048', '', None, False],
+    ['sha256-pad', 'sha256', '-rsa2048', '', '-E -p 0x10000', False],
+    ['sha256-pss', 'sha256', '-rsa2048', '-pss', None, False],
+    ['sha256-pss-pad', 'sha256', '-rsa2048', '-pss', '-E -p 0x10000', False],
+    ['sha256-pss-required', 'sha256', '-rsa2048', '-pss', None, False],
+    ['sha256-pss-pad-required', 'sha256', '-rsa2048' , '-pss', '-E -p 0x10000', False],
+    ['sha384-basic', 'sha384', '-rsa3072', '', None, False],
+    ['sha384-pad', 'sha384', '-rsa3072', '', '-E -p 0x10000', False],
+    ['algo-arg', 'algo-arg', '', '', '-o sha256,rsa2048', True],
+    ['sha256-global-sign', 'sha256', '-rsa2048', '', '', False],
+    ['sha256-global-sign-pss', 'sha256', '-rsa2048', '-pss', '', False],
 ]
 
 # Mark all but the first test as slow, so they are not run with '-k not slow'
@@ -787,8 +789,8 @@ TESTDATA += [pytest.param(*v, marks=pytest.mark.slow) for v in TESTDATA_IN[1:]]
 @pytest.mark.buildconfigspec('fit_signature')
 @pytest.mark.requiredtool('dtc')
 @pytest.mark.requiredtool('openssl')
-@pytest.mark.parametrize("name,sha_algo,padding,sign_options,algo_arg", TESTDATA)
-def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
+@pytest.mark.parametrize("name,sha_algo,sig_algo,padding,sign_options,algo_arg", TESTDATA)
+def test_fdt_add_pubkey(ubman, name, sha_algo, sig_algo, padding, sign_options, algo_arg):
     """Test fdt_add_pubkey utility with bunch of different algo options."""
 
     def sign_fit(sha_algo, options):
@@ -807,7 +809,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
         ubman.log.action('%s: Sign images' % sha_algo)
         utils.run_and_log(ubman, args)
 
-    def test_add_pubkey(sha_algo, padding, sign_options):
+    def test_add_pubkey(sha_algo, sig_algo, padding, sign_options):
         """Test fdt_add_pubkey utility with given hash algorithm and padding.
 
         This function tests if fdt_add_pubkey utility may add public keys into dtb.
@@ -830,7 +832,7 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
                             'rsa3072' if sha_algo == 'sha384' else 'rsa2048'),
                            '-k', tmpdir, '-n', 'dev', '-r', 'conf', dtb])
 
-        make_fit('sign-configs-%s%s.its' % (sha_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
+        make_fit('sign-configs-%s%s%s.its' % (sha_algo, sig_algo, padding), ubman, mkimage, dtc_args, datadir, fit)
 
         # Sign images with our dev keys
         sign_fit(sha_algo, sign_options)
@@ -852,4 +854,4 @@ def test_fdt_add_pubkey(ubman, name, sha_algo, padding, sign_options, algo_arg):
 
     # keys created in test_vboot test
 
-    test_add_pubkey(sha_algo, padding, sign_options)
+    test_add_pubkey(sha_algo, sig_algo, padding, sign_options)
diff --git a/test/py/tests/vboot/sign-configs-sha1-pss.its b/test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha1-pss.its
rename to test/py/tests/vboot/sign-configs-sha1-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-configs-sha1.its b/test/py/tests/vboot/sign-configs-sha1-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha1.its
rename to test/py/tests/vboot/sign-configs-sha1-rsa2048.its
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss-prod.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256-pss-prod.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss-prod.its
diff --git a/test/py/tests/vboot/sign-configs-sha256-pss.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256-pss.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-configs-sha256.its b/test/py/tests/vboot/sign-configs-sha256-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha256.its
rename to test/py/tests/vboot/sign-configs-sha256-rsa2048.its
diff --git a/test/py/tests/vboot/sign-configs-sha384.its b/test/py/tests/vboot/sign-configs-sha384-rsa3072.its
similarity index 100%
rename from test/py/tests/vboot/sign-configs-sha384.its
rename to test/py/tests/vboot/sign-configs-sha384-rsa3072.its
diff --git a/test/py/tests/vboot/sign-images-sha1-pss.its b/test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha1-pss.its
rename to test/py/tests/vboot/sign-images-sha1-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-images-sha1.its b/test/py/tests/vboot/sign-images-sha1-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha1.its
rename to test/py/tests/vboot/sign-images-sha1-rsa2048.its
diff --git a/test/py/tests/vboot/sign-images-sha256-pss.its b/test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha256-pss.its
rename to test/py/tests/vboot/sign-images-sha256-rsa2048-pss.its
diff --git a/test/py/tests/vboot/sign-images-sha256.its b/test/py/tests/vboot/sign-images-sha256-rsa2048.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha256.its
rename to test/py/tests/vboot/sign-images-sha256-rsa2048.its
diff --git a/test/py/tests/vboot/sign-images-sha384.its b/test/py/tests/vboot/sign-images-sha384-rsa3072.its
similarity index 100%
rename from test/py/tests/vboot/sign-images-sha384.its
rename to test/py/tests/vboot/sign-images-sha384-rsa3072.its
-- 
2.43.0

