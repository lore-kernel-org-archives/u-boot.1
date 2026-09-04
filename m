Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98303C79F83
	for <u-boot@archiver.kernel.org>; Fri,  4 Sep 2026 08:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6182881161;
	Fri,  4 Sep 2026 08:38:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PibHt8uYMY5V; Fri,  4 Sep 2026 08:38:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org E281E8116A
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788511084;
	b=Nw5yfe0z/1JlJA/7Y2WYv46SB2fmXQQAp6WBIpSlKyXQOVX6bzEzhkWgJNtbtbPHFibz
	 d/IiWSFr5YJf+ePW3wN/ZkLPew1uUUWWZnd0Jaj/g6Lylq/N19PHvTj+ZvDBbv5Dixb1o
	 GIzuaPIdGEXs/tutoUaNcEFH+auThiw6Z4r4uXzyJZ3yel5GcUXVsznsbdZLKgvlKS6lK
	 2tMWo1jxL5U0JLrOBpXJ3FkSgGrh/q4vB8+0vNQSpwrZZEwcuhc8y8eMwCxuM+hQaXH4i
	 y9qLXMa4Ftcxhec4+eATXV7heTsma2C7gX8RYVzKFBgTTH8I/FYQFqCaTR3vneIYrTg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788511084;
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
	bh=wj3hyOpnjRLoZ0Ue22XkGJFRaWARAIbqxy1M4wUTqbc=;
	b=RZ8JntwS6Zoi1HYTPlz2tK/wZxdxXmx/B9xcYh8+36+7dyyDSey9+/gqILCDr2e9O0GC
	 BefxUswuPEC+IbATWbkkHtKaz0sgb1KIF12/XHFUTh6bE0Axmd5UEiJzEwsqlaTkEpcdF
	 e6L7xl+d65+kOhGv0xK47p/YkHaE52/rHiGCklJINyeuNnsTtZrYsat/R7YxtPshqFcMI
	 Y0vPqhVISiAXp+88mxJSm0qwXhM/cpfydtN0XhOFiF757ObTrGZsxWeWhJ5wEcj1hX+T/
	 hB+10g3U7qHxSQkFD8yvFwVtn6sZXGGU9r/lF5GXB5sWgAiaElLy2lVz1Up4XSHUAhg==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788511084;
	bh=wj3hyOpnjRLoZ0Ue22XkGJFRaWARAIbqxy1M4wUTqbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OgZw5vZOWJOYwcOcb+BU0l6QzIDDvabzJYaq4S9002fdq431FZhY6D3mzCs9j5BW+
	 TbP6BzGizHMj9Y+LL/b9PAz18yKMPvna0h2Qx5318U2X+A1NVhY2X6p9Wrk/uFiSB9
	 +6RjAU0vtAKg5vdEDmlzQusFVJMT2crMyNT6U5U2uHPXrRQdpa62zw2Zg0oJnN/FeF
	 1rPAPsRmPwcBeMBGSpCCM1ma5rZmQNuU0FKw1j/eJdvmHR5EUowimkW5FSW6j4UPZm
	 t2mjWWrF6//KqmNETIaCyLXWw+SwtPQtHO8rsKLkyFEehycW46VicnCw60Mjc3RRov
	 wbquPuTqWzc/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E281E8116A;
	Fri,  4 Sep 2026 08:38:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 0BF373DA
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 09CAE40B37
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JPMuOm1sElFt for <u-boot@lists.u-boot-project.org>;
 Fri,  4 Sep 2026 08:37:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E867C40ACB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::2"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788511061;
 b=C6CnPTlxPjzhxeEPnewf8AoVVVZOYGDDliGfJUHgovXbUGIA7BzbaZX7TnZ7xFy3V5KD
 3jSvMjXm3wvYC8w8d2bQkXwWCHd4aJt+iCmN/dtnC4P4do+dU5NoF/GAEkbOgFWj2Bkmb
 jmpXacy/Xb8BFs+LwN+q57aAd0VV7xW9TrrCamH591KcSYbAJWzmVNkTMH5UBjsDg4ahV
 nN0/rAIVvJpifIzE6UZ+3HG3vL8niMvXVvaYcXBr2FWRhJ7Q0TTDepE56qBMlOy0VdPuZ
 V147WRcJDOFhgjuxa7YZ8Mm0Z+P5Rd2HnWbbB+sXRJrX4o/RokIuzUDBLsFfTZbQ/5A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788511061;
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
 bh=wj3hyOpnjRLoZ0Ue22XkGJFRaWARAIbqxy1M4wUTqbc=;
 b=ErGr0jfPETDpVuu8+alEtk1+OtbEuNYUfvStA92VmJjfdER8htx675sWG7ZR4zwjQ5Wg
 OzjIwmMDdGpbTA01EwwZwa4+ky33zaXTBu5Esfab3buN3pIDooByNEcpdCzv+p7bxJXBQ
 RmuWA6b9fQvMz7mJ6xgBWuBuIpJ/un+lvUVsQmjVTVN+nJosWUmwwHiBJIlo7BE2iue/C
 rIVRd/InwWy9TYib3Lk8Q+qbWx0gqH7F0W4qQXbPV4L0JgIcH1aCcJyTH1G9BsiqJ2G0f
 ZqG9hqQJjV2FPJLf3/qvRZZYKhK2AmHEls6QuIi6zXcsvHUjH55KJUZd+X7nga9HiMg==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=none header.from=softathome.com; 
 dkim=pass header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=hoSoQZ3C; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::2"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::2;
 helo=paup264cu001.outbound.protection.outlook.com;
 envelope-from=philippe.reynes@softathome.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=softathome1.onmicrosoft.com
 header.i=@softathome1.onmicrosoft.com header.a=rsa-sha256
 header.s=selector1-softathome1-onmicrosoft-com header.b=hoSoQZ3C
Received: from PAUP264CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170110002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::2])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E867C40ACB
 for <u-boot@lists.u-boot-project.org>; Fri,  4 Sep 2026 08:37:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fS0oGHzZrhUx5dOJ+gGB38t5UhS5eGkReWYhFBH5pyJcwCMTDTVqS5szJZGNwff2zgQTGYD06zbG9uBjNULMbsOkQ+MeAi3nlYQdFMfMpBgjE8ip9tRegCxwEOfO5KVbvjhxXna8zhbh4hHEUf/m11jTOemeSDQ0JDmRuiidz/l82NfrF4iaAK9+36I/5e+MXBX3HK25uTWDvVqCLIFgqoMQWTqiRacv3XFmzICSJdT3xmFqfkEVOyWMrrs2DYbmI8hZdasc2W7Rkc1EXIdsRNOrOKgaKYagftgw8+Zq14dGeoipD5gEQAqZ2xIALGmHu+tbpi5EThUfOquQiBOx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wj3hyOpnjRLoZ0Ue22XkGJFRaWARAIbqxy1M4wUTqbc=;
 b=skOYV/t2dMyKozbM9uT7X5/XF/mGcOQSmcM8YixdtqBLPeLh5PAogIxPdp8YSpGHil8KYZRv1wV9FjxGMfrjJ948wcwIHv318TNEWsEnwcuQMphsZntnHACjO2iaSbEpjev7B3JHlXSa+y7B9KNNODh6E7Tvg4GpfZc5uYfDz3NaAhv+o4oPSVLR+k6BANnDGWbw32/QPe6mkevlOFBr7LagbkdclU7Y0v9H88GxmJkwrbj+SP7AoBM+lNo1o1LnMZK3Bn+7lUgXNwNq8M1vrX0/puc6IH/1i8iUw8IszrMNBr3asw3u7cF5K5FxmXEZbaE8c5W3hcXiF3DhTm/NPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.6.166.170) smtp.rcpttodomain=canonical.com smtp.mailfrom=softathome.com;
 dmarc=bestguesspass action=none header.from=softathome.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj3hyOpnjRLoZ0Ue22XkGJFRaWARAIbqxy1M4wUTqbc=;
 b=hoSoQZ3CyFx+u9/ny1sb4kErng9+2ZxQ/5dgW2ZCB64yfrSte/O9PTXxh2zBMECJMlXAYwBe9/IbohVThHj7gHwTWfE60vcE2yPbsXnGLNkhb2AU/9Dw5A5sLsek/sTEHOHbJaU/27nagQat21i8oq+HOOC+wFcQnG6QoT9pIfgkuIKqzJphjFfc8TxNklXwFydE5lfXOVE4eo4Vp117DGBZv7KvfDOwgESmgm6PYbCPgPM9/lP8DmMATU2MG0fsAX40ERuNXIWbHXzdaPJVWRRsz+0dDLSW5kFP5/tuArh+pRoRxiQFrNUzC7GRYqB4DMDFT422zui3SHjYbhkAMg==
Received: from PA7P264CA0217.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:374::18)
 by MR1PPFA016E0A1F.FRAP264.PROD.OUTLOOK.COM (2603:10a6:508:1::2c4)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 08:37:22 +0000
Received: from PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:374:cafe::39) by PA7P264CA0217.outlook.office365.com
 (2603:10a6:102:374::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.12 via Frontend Transport; Fri, 4
 Sep 2026 08:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.6.166.170)
 smtp.mailfrom=softathome.com; dkim=none (message not signed)
 header.d=none;dmarc=bestguesspass action=none header.from=softathome.com;
Received-SPF: Pass (protection.outlook.com: domain of softathome.com
 designates 149.6.166.170 as permitted sender)
 receiver=protection.outlook.com; client-ip=149.6.166.170;
 helo=proxy.softathome.com; pr=C
Received: from proxy.softathome.com (149.6.166.170) by
 PA1PEPF000CC3FB.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Fri, 4 Sep 2026 08:37:22 +0000
Received: from sah1lpt726.home (unknown [192.168.72.32])
 by proxy.softathome.com (Postfix) with ESMTPSA id DC06E202B3;
 Fri,  4 Sep 2026 10:37:21 +0200 (CEST)
From: Philippe Reynes <philippe.reynes@softathome.com>
To: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com,
 trini@konsulko.com, simon.glass@canonical.com
Cc: u-boot@lists.u-boot-project.org,
 Philippe Reynes <philippe.reynes@softathome.com>
Subject: [PATCH v10 02/15] mbedtls: enable support of ecc
Date: Fri,  4 Sep 2026 10:37:06 +0200
Message-ID: <20260904083719.53132-3-philippe.reynes@softathome.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904083719.53132-1-philippe.reynes@softathome.com>
References: <20260904083719.53132-1-philippe.reynes@softathome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA1PEPF000CC3FB:EE_|MR1PPFA016E0A1F:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d4eaef88-3456-4c1a-7f2f-08df0a5fbd25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: UtwQIF3cw0nSPFAt6MBZUW9ik3bz4LR/OG6G1gv1oASiakdetYKvUmS9UqqQQ1MSQ8ycGjvgIvTAiTVGqF4Zuk9ogQKrW45Y+Uun5EyU5FvymVdarDmN/7vzZzouBjZ21l+t7Ib5bwysqO8Gv5u56lRRjD+isw+qCDEE1NwDLUci1UgZd3TurtNm5DGDYdGrL+n6AwQ4HCj8jMc6P3mM/yOnhY15XaaJ/OHR+X6vmQA8BIO/4Cuq6zhqU7nk1BG+oygMCARkkEq1IumrEn8LUwh8U+AM0YygxCbhShBBdbp/Vf1vVaCbYhEyeEBzLIVNP08IpOjQBacZJDT2vmydcv3QNZeA0KGDmiTeOVHQnRsY/VMndPVSe0FzAUY/d2xdzLj7rlAYoVNs0478F9yfL65JYc+h6hVqzBXoq8MLy4haxvzk4IeZGT6WKHk/Su2ouMeaDZQ25q2pMIIOHUFpjY6nygmfD/6H9FQD7959Oua62nJJ0ASSGm9n3kfEYte6G7scOU2PiVy1d1Ul8BZiOFF35cUcdZK1H7Pkmv2iGxMJb6ntbXnVbxpJ/AdX5F2vmQfFi09kd1Is/slhcWie9s9QhRdbhlJIYI3seAILW9tVDFsDGEnXS0gXQoIPM/xtLmUC3t+1FvhBZEk41m/cFxupV1ICWpjdsEmBIpixlp3SLQuG0al2fezo9b1oi1+FOT8oo8OEEtqAOdwhTMCQEw==
X-Forefront-Antispam-Report: CIP:149.6.166.170; CTRY:FR; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:proxy.softathome.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LlK3WWX8vpT127ezOl3ZgnSPnVb5mT5hMNJcc+0i1Qyh8qfxVTeAXfec2TU/KCuim9kL98naWTYsjv6jKs9epDZZG/NQdHLhi12VdKpMxZzRlISlgaws7qnBSaORKFDtMv+GXH3rr3bAi8peBQiaI5oXzPjE1MG+zjznJVlf878IRFyD63FINBgCw5nVIgvpUUJWkzS/h5TWwe9g1oYZpl8kp/eVIC71E2S9yCGvYegOiNpsAdZAg7u1egV4N7Qs2JXZy2rJIOIcuZZ7MrLPsV9qxAE/KerWuHZ47SrwBJ4ZDqJsjNahIeReHBOsfvPmDCVz2LunBpsaN1uPJn5mK3djZx4AqIpwK3hIA2EDUfGrlkfUY8wvwDI3CgEZBmN3owb251nsy99ou7WF7W0hzxLM0qthKECZOdWC6alVOsJmwlzhiUivYZm73oqmqHo9
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 08:37:22.0950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4eaef88-3456-4c1a-7f2f-08df0a5fbd25
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=aa10e044-e405-4c10-8353-36b4d0cce511; Ip=[149.6.166.170];
 Helo=[proxy.softathome.com]
X-MS-Exchange-CrossTenant-AuthSource: PA1PEPF000CC3FB.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1PPFA016E0A1F
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

Prepares the support of ecdsa signature check
using MbedTLS. It introduces the option ECDSA_MBEDTLS
to enable (or not) the support of ecdsa in MbedTLS.

So now, ecdsa is no longer supported by default in the lib TLS.
To get it, the option ECDSA_MBEDTLS must be enabled.

The option ECDSA_MBEDTLS only enables the ecdsa support
in MbedTLS, it doesn't provide any API to use it for
signature check. It will be done in another commit
by adding the option ECDSA_VERIFY_MBEDTLS.

Two internal options are also added BIGNUM_MBEDTLS
and ECC_MBEDTLS. Those options are used to share code
between different option and avoid duplication.

Reviewed-by: Raymond Mao <raymondmaoca@gmail.com>
Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
---
v2:
- move ecdsa to MBEDTLS_LIB_X509
- enhance depencendies
v3:
- do not use _MBEDTLS in mbedtls_def_config.h
v4:
- do not select ECDSA on some configs
- remove duplicated MBEDTLS_ECP_DP_SECP256K1_ENABLED
- change dependencies for ECDSA configs
v5:
- MBEDTLS_LIB_TLS depends en ECDSA_MBEDTLS
- update some configs according to previous change
- build of ecdsa is conditionned by ECDSA_MBEDTLS
v6:
- fix dependencies for ecdsa and ecc on mbedtls
- ecdsa is no longer mandatory for tls
v7:
- no change
v8:
- enhance the commit message
- use /* */ instead of //
v9:
- no change
v10:
- no change

 configs/sandbox_defconfig        |  1 +
 lib/ecdsa/Kconfig                |  1 +
 lib/mbedtls/Kconfig              | 17 +++++++++++++
 lib/mbedtls/Makefile             | 17 +++++++------
 lib/mbedtls/mbedtls_def_config.h | 41 +++++++++++++++++++++-----------
 5 files changed, 56 insertions(+), 21 deletions(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 5c97418783f..b9991d269d9 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -389,6 +389,7 @@ CONFIG_PMBUS=y
 CONFIG_CMD_DHRYSTONE=y
 CONFIG_MBEDTLS_LIB=y
 CONFIG_HKDF_MBEDTLS=y
+CONFIG_ECDSA_MBEDTLS=y
 CONFIG_ECDSA=y
 CONFIG_ECDSA_VERIFY=y
 CONFIG_RSASSA_PSS=y
diff --git a/lib/ecdsa/Kconfig b/lib/ecdsa/Kconfig
index ca13b6bfa1f..dac8bcf23dd 100644
--- a/lib/ecdsa/Kconfig
+++ b/lib/ecdsa/Kconfig
@@ -1,6 +1,7 @@
 config ECDSA
 	bool "Enable ECDSA support"
 	depends on DM
+	select ASN1_DECODER
 	help
 	  This enables the ECDSA (elliptic curve signature) algorithm for FIT
 	  image verification in U-Boot. The ECDSA algorithm is implemented
diff --git a/lib/mbedtls/Kconfig b/lib/mbedtls/Kconfig
index 789721ee6cd..e019f17d6bd 100644
--- a/lib/mbedtls/Kconfig
+++ b/lib/mbedtls/Kconfig
@@ -247,6 +247,12 @@ config MBEDTLS_LIB_X509
 
 if MBEDTLS_LIB_X509
 
+config BIGNUM_MBEDTLS
+	bool
+
+config ECC_MBEDTLS
+	bool
+
 config ASN1_DECODER_MBEDTLS
 	bool "ASN1 decoder with MbedTLS certificate library"
 	depends on MBEDTLS_LIB_X509 && ASN1_DECODER
@@ -264,6 +270,7 @@ config RSA_PUBLIC_KEY_PARSER_MBEDTLS
 	bool "RSA public key parser with MbedTLS certificate library"
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	select ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
 	help
 	  This option chooses MbedTLS certificate library for RSA public key
 	  parser.
@@ -292,6 +299,15 @@ config MSCODE_PARSER_MBEDTLS
 	  This option chooses MbedTLS certificate library for MS authenticode
 	  parser.
 
+config ECDSA_MBEDTLS
+	bool "Enable ECDSA support with MbedTLS certificate library"
+	depends on MBEDTLS_LIB_X509 && ASN1_DECODER_MBEDTLS
+	select BIGNUM_MBEDTLS
+	select ECC_MBEDTLS
+	help
+	  This option enables support of ECDSA with the MbedTLS certificate
+	  library.
+
 endif # MBEDTLS_LIB_X509
 
 config MBEDTLS_LIB_TLS
@@ -301,6 +317,7 @@ config MBEDTLS_LIB_TLS
 	depends on ASYMMETRIC_PUBLIC_KEY_MBEDTLS
 	depends on ASN1_DECODER_MBEDTLS
 	depends on MBEDTLS_LIB
+	select ECC_MBEDTLS
 	help
 	  Enable MbedTLS TLS library. Required for HTTPs support
 	  in wget
diff --git a/lib/mbedtls/Makefile b/lib/mbedtls/Makefile
index c5b445bd85c..0c86c90d15a 100644
--- a/lib/mbedtls/Makefile
+++ b/lib/mbedtls/Makefile
@@ -39,13 +39,21 @@ mbedtls_lib_crypto-$(CONFIG_$(PHASE_)HKDF_MBEDTLS) += \
 # MbedTLS X509 library
 obj-$(CONFIG_$(XPL_)MBEDTLS_LIB_X509) += mbedtls_lib_x509.o
 mbedtls_lib_x509-y := $(MBEDTLS_LIB_DIR)/x509.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECC_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/ecp.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
+	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
+	$(MBEDTLS_LIB_DIR)/pk_ecc.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)ECDSA_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/ecdsa.o
+mbedtls_lib_x509-$(CONFIG_$(PHASE_)BIGNUM_MBEDTLS) += \
+	$(MBEDTLS_LIB_DIR)/bignum.o \
+	$(MBEDTLS_LIB_DIR)/bignum_core.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASN1_DECODER_MBEDTLS) += \
 	$(MBEDTLS_LIB_DIR)/asn1parse.o \
 	$(MBEDTLS_LIB_DIR)/asn1write.o \
 	$(MBEDTLS_LIB_DIR)/oid.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)RSA_PUBLIC_KEY_PARSER_MBEDTLS) += \
-	$(MBEDTLS_LIB_DIR)/bignum.o \
-	$(MBEDTLS_LIB_DIR)/bignum_core.o \
 	$(MBEDTLS_LIB_DIR)/rsa.o \
 	$(MBEDTLS_LIB_DIR)/rsa_alt_helpers.o
 mbedtls_lib_x509-$(CONFIG_$(PHASE_)ASYMMETRIC_PUBLIC_KEY_MBEDTLS) += \
@@ -64,7 +72,6 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/mps_reader.o \
 	$(MBEDTLS_LIB_DIR)/mps_trace.o \
 	$(MBEDTLS_LIB_DIR)/net_sockets.o \
-	$(MBEDTLS_LIB_DIR)/pk_ecc.o \
 	$(MBEDTLS_LIB_DIR)/ssl_cache.o \
 	$(MBEDTLS_LIB_DIR)/ssl_ciphersuites.o \
 	$(MBEDTLS_LIB_DIR)/ssl_client.o \
@@ -82,8 +89,4 @@ mbedtls_lib_tls-y := \
 	$(MBEDTLS_LIB_DIR)/cipher.o \
 	$(MBEDTLS_LIB_DIR)/cipher_wrap.o \
 	$(MBEDTLS_LIB_DIR)/ecdh.o \
-	$(MBEDTLS_LIB_DIR)/ecdsa.o \
-	$(MBEDTLS_LIB_DIR)/ecp.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves.o \
-	$(MBEDTLS_LIB_DIR)/ecp_curves_new.o \
 	$(MBEDTLS_LIB_DIR)/gcm.o \
diff --git a/lib/mbedtls/mbedtls_def_config.h b/lib/mbedtls/mbedtls_def_config.h
index dda3f4dd6e4..d55f31acfda 100644
--- a/lib/mbedtls/mbedtls_def_config.h
+++ b/lib/mbedtls/mbedtls_def_config.h
@@ -62,6 +62,25 @@
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509)
 
+#if CONFIG_IS_ENABLED(BIGNUM_MBEDTLS)
+#define MBEDTLS_BIGNUM_C
+#endif
+
+#if CONFIG_IS_ENABLED(ECC_MBEDTLS)
+#define MBEDTLS_ECP_C
+#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
+#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
+#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
+#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
+#define MBEDTLS_ECP_DP_BP256R1_ENABLED
+#define MBEDTLS_ECP_DP_BP384R1_ENABLED
+#define MBEDTLS_ECP_DP_BP512R1_ENABLED
+#endif
+
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
 #define MBEDTLS_X509_USE_C
 #define MBEDTLS_X509_CRT_PARSE_C
@@ -74,7 +93,6 @@
 #endif
 
 #if CONFIG_IS_ENABLED(RSA_PUBLIC_KEY_PARSER)
-#define MBEDTLS_BIGNUM_C
 #define MBEDTLS_RSA_C
 #define MBEDTLS_PKCS1_V15
 #endif
@@ -89,6 +107,10 @@
 #define MBEDTLS_ASN1_WRITE_C
 #endif
 
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
+#define MBEDTLS_ECDSA_C
+#endif
+
 #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_X509) */
 
 #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS)
@@ -122,7 +144,9 @@
 
 /* ECDSA */
 #if CONFIG_IS_ENABLED(ASN1_DECODER)
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
 #define MBEDTLS_ECDSA_C
+#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
 #define MBEDTLS_ECP_C
 #define MBEDTLS_ECDH_C
 #endif
@@ -130,24 +154,13 @@
 #define MBEDTLS_HMAC_DRBG_C
 
 #define MBEDTLS_CAN_ECDH
+#if CONFIG_IS_ENABLED(ECDSA_MBEDTLS)
 #define MBEDTLS_PK_CAN_ECDSA_SIGN
 #if CONFIG_IS_ENABLED(X509_CERTIFICATE_PARSER)
 #define MBEDTLS_KEY_EXCHANGE_ECDH_ECDSA_ENABLED
 #define MBEDTLS_KEY_EXCHANGE_ECDHE_ECDSA_ENABLED
 #endif
-
-#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP192R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP224R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP256R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP384R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP521R1_ENABLED
-#define MBEDTLS_ECP_DP_SECP192K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP224K1_ENABLED
-#define MBEDTLS_ECP_DP_SECP256K1_ENABLED
-#define MBEDTLS_ECP_DP_BP256R1_ENABLED
-#define MBEDTLS_ECP_DP_BP384R1_ENABLED
-#define MBEDTLS_ECP_DP_BP512R1_ENABLED
+#endif /* #if CONFIG_IS_ENABLED(ECDSA_MBEDTLS) */
 
 #endif /* #if CONFIG_IS_ENABLED(MBEDTLS_LIB_TLS) */
 
-- 
2.43.0

