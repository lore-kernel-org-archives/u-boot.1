Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4491CC88E50
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 12:38:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E170C40804;
	Fri, 11 Sep 2026 12:38:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sz39ZAArgNjU; Fri, 11 Sep 2026 12:38:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 286E8407FC
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789130314;
	b=UrT58KeNVQsmcbCuGcj+Go+HE9aDg8WktBh4REwxV5mvukgPo6AuqGZ2XEozNR4BXQYz
	 mi5Upxxctk8OJdFnnjLIEzqQNQDswBZNXJ4qfKXcZNH68JoUWpydaWBuVsVQnqOKE3x/F
	 3Jwu6rezq3thlg8S6xMAvxJXnjlHigUEg4fMSkb/oFzBXPJBlaDWoRwOP8T+FPRxFZAyk
	 0lapnpJWOrAN1ItrrDOZSzhtBKtcMuAXfx8AlAq8ZC3JjPALCDfKF90HxgAozD+z05q25
	 M/4LJhpOjk/UFLw5RawOhWAJNgbzGKUlNcly2/76HpqsWUHL872OYZ0NISWIjsJEitQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789130314;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:CC:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
	bh=pek/ibjmNcJVeUhE3h0BEUMdW5UcQF3cOah6tesh6LQ=;
	b=OJIbFj4pNth0d4n1M6gnV1rM0PIWEi9Z1iYYPuJNzfhz9NLEeBhG+pKAr3a4+NztAq9l
	 Wb7VieR9Y5FIPNhftWx58B4KG1f1OphEz5ABWQyK/0ncICP2vVb8Ek3aezR+EAlpt8vTH
	 OxfzCqsTBFQCQeaYdcBHHQgwbgLlagD2g2QvLUy98DLu5tBpUibd6l1nhm+/TLcl2x7Df
	 Z/4nk7Yw7oPpYTIV6Uv81pReXQnXRfuUcMucWNmCq7Rw1arG88zKHaMLdcdRVfQJnVGN/
	 86TOTN+6EGFrRF3FZdtBLgr+hDJ4vePeunoqij2v6RevFvsQZ52IDxOvnpQXZdTejkg==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789130314;
	bh=pek/ibjmNcJVeUhE3h0BEUMdW5UcQF3cOah6tesh6LQ=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c0dw3xZnFcJJQyiBuQiwsN9Jbb0LXyS/IaruT3ScVTWXsoxBP/DAjuulpTzccT2dn
	 WSSY1G+QptTIVpiUmRdBbhRUrTYwuEqC0PkfifDpNypEvkB3iGXdiXqmBmV4GS/E39
	 o8kAW1T2aVXhTAyZrtAwyUhrfwC2OCm+bcA2R/kGmV7SN1ajPbUUR1jMRWp3SlfSQ7
	 Sv8pHCw1MhjAFtXfdG6LKLSpieCOtbwildHSxNo+GTuPZ4PJ3VEo5A4b3LnnvI3vUd
	 mGfcx5VUG2ofE8MOZqm8+aPXYNmyD9tG/tzOagSIrvHsoAn7m3/QlwoP7yBg/n6xDS
	 oRmMrP9b6rU7g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 286E8407FC;
	Fri, 11 Sep 2026 12:38:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F403701
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:38:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2D16C401DA
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:38:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IXXW_NxOsN19 for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 12:38:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5DF4C4006B
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20a::7"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789130312;
 b=bbgEIb+7zSc/Ns1uHTO6Y2SNxipeN1W5pXUUzKZ7CgRWB+g9zZwLZ9JyYgCbo0gqw2kY
 Qk9ymRPieXxhp6fxyVC2kiQg62xxfu9rrJXQgZ/qijd5/lFKi20i/vjQMq51hjQh6qXgg
 5ozpxUHn3OqH28tT70711X01HsAmT6UcsnQkDtAxdlmyuuHRu8xn/Tj5bzEPzat1EPTKa
 VrjO+aGWI/tnNq3Szw+eibPd+OeRACmOpXdnxy6P58KQnXStA5Xlyasb32W3F+UZGuDvY
 imRcc/PvuiGY5OFwsRUJwZgETmemeOTgNlNEzO3SbQHBO78T6xuNlkpO7yP3o27lvvQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789130312;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:CC:
 References:Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy:
 X-EOPAttributedMessage:X-MS-PublicTrafficType:
 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
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
 bh=pek/ibjmNcJVeUhE3h0BEUMdW5UcQF3cOah6tesh6LQ=;
 b=G+bTnbv8Ny2U8ePXs6nyG1PhTyQoZNvHlFvJT+issapqXUq9jiUbMTUwqnhsYxT2U6Er
 3zU5I+AOyVKcqksyyzxPT2I/wY+P2oDeNZuHC+zmCOu/B+1d8wYqufHL2hx19B6MxZwJv
 buojSYoXyZdBpljfVFcGRtuGanU/0Ua+hkKKLvAoJ3sGCc6AKkPUYbM8SHCiZO3UTeXZk
 7xN64F8EkOua6lvFwQUQvvMU5ewFdoKqrfwBOGOy/H3869ijuqLyckWNkLH7ADVmQsZQw
 fFnlYciSkPcHpR+d7obFviEBxe36kDRVFRLBlRLOMAVpUlcOk2/nIJiOhdHK0E8YHTg==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=fKNOTHv5; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c20a::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=fKNOTHv5
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5DF4C4006B
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 12:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jwSFx9M7Joli/gMjMrpUUZKN4Sk04k3imxkPMiDrBps8jBU1dTTmfriHTYs4renImtHVqAIyFTxbiuyo3x0RVigGPrckfRSFC7yiOPICFd7NoJ7q4OXPJ4tzQpHK317jFs3h+yAlJAsgJ9cY5YRByUG+KC+nB2V9EC9Jg/U5xJh4qPxLHIltXdb7xPz6tRlk3moJ8Wl9B/ZYkIIPqZ6CbnoSXJY89DCFgNBbbIoA5XAdcPNkXsw3ZqlEo0fvsPxnGJ91w48fdHSafZnsI+9rs5CRnk3QaqYM9ijRxIGB2ZCVdYO4UvOYEZ5mVbz4tLIyOEjipCYe1h+Mze78xxSIRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pek/ibjmNcJVeUhE3h0BEUMdW5UcQF3cOah6tesh6LQ=;
 b=P/iNoGpMkl4cvZ6rWRfSWNeEfCnAgXnz7TpvIr+1qkeWSgSwmn3sZWExs8EBx+J1i+wTWvqIejpTtjJo9xk6h60iqBnGwWUq6Ja7xMH91q6JNAG/3CZvDEF/rC4+L8Mt7WVCmnBJyNAGxTZAs5PaIAQvZ0UjIEe0pm5Ggfu/wnZhGJrwzzSp06dTvOx5nmBN9FErimJzUi/h9bp45v8gZsjckH/7MpJ+oexI/vcNMZXvpBvGYEcT9V0eWo3+e3DYHvDtu/c6QOr7XBuIWU6tXGSjoppqth1H4zKUNIXEgPZNcMMgzHR32nWCUmbHsqlUPGLR/fcwzXz65ZNdz98Ckg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pek/ibjmNcJVeUhE3h0BEUMdW5UcQF3cOah6tesh6LQ=;
 b=fKNOTHv5dvHg1sM9smgh9tVZSzJvZpGyRx3azoThOwwtcYC/dPSl6ak6IEaJhIogXJDLGb1HWNQpw5iCoyENIHZMJ56CG9xNzOnzP4Vyk7DRFKxi2U6NXcM5IfJakGwzKZT039N5+mRyJDvz54lX6z17QnyCoaSoVnCYni2RTKbMPSud8DTAYu37H3vdbKqbPgyK0Leqb7T3/B63K1PiGJ/l46m/6AZfUiu2bon8FlQC2tqs905JYMrisvbbMBjYif73J6EwWWCHXzUu3njnMxZkocVWi3R5ZV58DfxTVIYIpyOqsPEeVyAmSsHhTNlUeCrD2kV3vYImxf+CLTJcyw==
Received: from AS4P251CA0018.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d3::10)
 by VI1PR10MB7783.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bf::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 12:38:22 +0000
Received: from DB1PEPF000509F8.eurprd02.prod.outlook.com
 (2603:10a6:20b:5d3:cafe::5f) by AS4P251CA0018.outlook.office365.com
 (2603:10a6:20b:5d3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 12:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F8.mail.protection.outlook.com (10.167.242.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 12:38:22 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 14:44:23 +0200
Received: from [10.252.12.102] (10.252.12.102) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 11 Sep
 2026 14:38:21 +0200
Message-ID: <9b29dee6-5a40-43aa-bfd8-4590876b3e67@foss.st.com>
Date: Fri, 11 Sep 2026 14:38:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] usb: gadget: f_mass_storage: Optimize schedule() call
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@denx.de>, Marek Vasut
 <marek.vasut+usb@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20260817-move_schedule_inside_sleep_thread-v1-0-0023194e8c47@foss.st.com>
 <20260817-move_schedule_inside_sleep_thread-v1-2-0023194e8c47@foss.st.com>
 <87fqzltop3.fsf@kernel.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <87fqzltop3.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.12.102]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F8:EE_|VI1PR10MB7783:EE_
X-MS-Office365-Filtering-Correlation-Id: 588e7d11-f262-4d10-60da-08df1001911d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|6133799003|3023799007|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: II1zK44TQ7NktHulWS0f1dEPckQM4YjoDnxVt9qfYY6a8Snw8s7qyjMCbs8iB22JPORXELy0GSdwoFa3tk1EUJpsq6r2nuoom+kfyeuxNDMMkmbh6D/8xM1oRT55HVREjUwUZKC1lgFAQl2gnEeNsaj6uTjZbqvlxatv7r1D7BW4CDAT2wFKF0dKslXF0HfD78lx+FKlOig78YZEyylT+dQQxfdOPcgLezflPd36Fa3iSWtRbGB7P6VEW6dWYdKpDzxsY7JO57bf/SHUQEMAJZIxSn+dWCFz+DXeDDGdhsHpzLxw5yWHiiXR/NLJd6QDPbWncp8skCju+hiTP1wpQE+n+JF/ES7iUgC58596zCU98ZH356Bwj94JHd3jja1eNp/W7qG2sIIDWF01yOuicmwX6inrqLf1d0Qtaj4a/Qh02zr/I9xqF6+DOxBqy+Bn0kTdHpWmaxhAccPoSOx4vr/Awb62m9uhvokThSNdbnTkwfbMsswhIupmY+XxkLgo+Eb3IeN4yjeZQZAXmW751ie96pmFgP99GDTgsnbgEOwJ1FGMSeOxs10PZoDlLzt6EIi2fSvNP9UmIGEysvX4XZY+YRP9MmOD8pbY1GtoK4Jqsf4RoY7EDnfOPIszsFOEB/PCc5z1HJhYwoQoGO471MTcj5aBCVCRQNdk2bMhr8+SpiKxJ/InVxfqHyFVWBzFu4PHSbDyWyseU0CuGyTrVQ==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(6133799003)(3023799007)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Mwjw97yd0V3M2YQICCuyfnEc+EAgAP5l1v/LJtw4gtI6aE3BM+gKj1efBAUPC0lmbgoxBLcbzYQk3ThV2842RvZy4bho9DEzjmZouAWWejZKm4WcuQE+/BNFTTAuGSjMp+3Uq2IcXTIcRie50pkhvwrLzYFFP2qHGaZdqw4LAfFxlOMDR9Uk2V2ZXf1lk7cX7c4IVJWUkYhojXbxb6D/Gsvt3RsvWa2YhpR5Frc557nJuI7V2M8OyDQxV40iGi4e/CqYxW+4WOIxYknwS3QOfDNx+MSE9m6WzG58vzOM0HlUTopncR1Fbzd7jIY8ZQ0twOJWascVuiEqvxEZogYvUxKdpdG1nyk8NZMr+0RlsqFFKdycF/Nl5/WW5mZHR5Iiuidr6o/0qcKZDt4sSicQ2oZc03gr5aWZfTufRB7kQ8olq8U46x7RaOk4oeD9g64Z
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 12:38:22.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 588e7d11-f262-4d10-60da-08df1001911d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F8.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7783
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



On 9/7/26 11:07, Mattijs Korpershoek wrote:
> Hi Patrice,
> 
> Thank you for the patch and sorry for the review delays.
> 
> On Mon, Aug 17, 2026 at 17:41, Patrice Chotard <patrice.chotard@foss.st.com> wrote:
> 
>> schedule was added in sleep_thread() by commit 4b6a3e860878
>> ("usb: gadget: f_mass_storage: Add schedule() in sleep_thread()").
>> to ensure that watchdog is still reset periodically even on platform
>> that doesn't implement g_dnl_board_usb_cable_connected() and in case USB
>> cable is not connected.
>>
>> Instead of calling schedule() for each for() loop iteration, call
>> schedule() only in case g_dnl_board_usb_cable_connected() is not
>> overloaded, in this particular case, g_dnl_board_usb_cable_connected()'s
>> return value is -EOPNOTSUPP.
>>
>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>> ---
>>  drivers/usb/gadget/f_mass_storage.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/usb/gadget/f_mass_storage.c b/drivers/usb/gadget/f_mass_storage.c
>> index 621852080e2..f467693d2cb 100644
>> --- a/drivers/usb/gadget/f_mass_storage.c
>> +++ b/drivers/usb/gadget/f_mass_storage.c
>> @@ -651,6 +651,7 @@ static void busy_indicator(void)
>>  static int sleep_thread(struct fsg_common *common)
>>  {
>>  	int i = 0, k = 0;
>> +	int ret;
>>  
>>  	/* Wait until a signal arrives or we are woken up */
>>  	for (;;) {
>> @@ -673,13 +674,15 @@ static int sleep_thread(struct fsg_common *common)
>>  				return -EPIPE;
>>  
>>  			/* Check cable connection */
>> -			if (!g_dnl_board_usb_cable_connected())
>> +			ret = g_dnl_board_usb_cable_connected();
>> +			if (!ret)
>>  				return -EIO;
>> +			if (ret == -EOPNOTSUPP)
>> +				schedule();
> 
> What happens on boards that override g_dnl_board_usb_cable_connected()
> that return a positive value?
> 
> Per my understanding, schedule() will never be called, and the watchdog
> will be triggered at some point, no?

Hi Mattijs,

In case g_dnl_board_usb_cable_connected() returns 1 (it's currently the case 
on STM32MP157c-DK2 board), we stay inside sleep_thread() for(;;) loop until 
common->thread_wakeup_needed is set to 1 by wakeup_thread(). 

wakeup_thread() is called periodically (around every second, it was what i observed 
during testing) by either bulk_out_complete() or bulk_in_complete().

Then we came back in fsg_main_thread() which was sleep_thread() caller, 
and came back in while(1) loop of do_usb_mass_storage() where schedule() is called.

So watchdog is reset periodically.

Patrice
> 
>>  
>>  			k = 0;
>>  		}
>>  
>> -		schedule();
>>  		dm_usb_gadget_handle_interrupts(udcdev);
>>  	}
>>  	common->thread_wakeup_needed = 0;
>>
>> -- 
>> 2.43.0

