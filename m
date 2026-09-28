Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C00C9833E
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 07:31:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AD3460641;
	Mon, 28 Sep 2026 07:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b-qNX6dUcJt7; Mon, 28 Sep 2026 07:31:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 2844F6064E
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1790580663;
	b=h6mw9TfoDYDXp9EZye6nng9cgJSnXBCGBU2T5+E0qFyja/5jAXXCbmQsZDBY4UiK4aC1
	 M1AFKlGGZLlNjmDQ8YSjxNNlNW4JfhJmcCAIrXzdZDZ28Mz3/gdBRPpEzg/caHQdckCzn
	 FZkLQW+wxpUUfXyJZ5sGP7T4Ld/TTphCfQb2HYGanMlXBuhAXJHhQ+lIWO83iN4a4CeNq
	 7yUmih3AY4n9OZZbiNkGbho2yrHKzGC56RLx8dB4KwokNVVsMxD/zJZ8KP5QASHSRwJB0
	 F1Jo2N2shz8F91K+MkkNxpLLodL9KyxX0oCFV5NJE5Y5b0Gxic+X1imi99lO9l16T+Q==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790580663;
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
	bh=sH8rVNq5hysT8wW2ZvjBSj3IMvPCMO0ajUzaD4YiOWs=;
	b=pn+e9MBveyrw4yuq7gnJ2lTrPBbBdAoqks4m76PQPIgDhHxkVbXkUcE/8zqm5nkTh5wd
	 Sl5VrT/qtRSh0+F6sqd7M+AkuOjwPXwlR0YrI2qbf8RkzPmLOumeJAPXDtcnjhiBF8wVG
	 v/1L/tTCK0Z1bLpNjLiyq94mrdjl0Y0jbPLd9UYQoQ9ouBnd2XG/Ln2sz1qel0kqO+RGa
	 1ElEv6GA1Sg64CPYp2NiynlI5ZYEvP6d8iYN++gc6ENQcduALS6ak37oUFm/uQzYfNeHl
	 6L5HQC5SDGvm9wRUbqFeRIySvn1RjKaCs3jfhQBRm8F9910VhO0NGxP9HXnNZsCeRIg==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790580663;
	bh=sH8rVNq5hysT8wW2ZvjBSj3IMvPCMO0ajUzaD4YiOWs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IuQJQNaJPGSGVhD/7Md2nLkdZU5tZsYj0dwQKnEVQeY6iJrz59Kz9ZN6SatGtLUtG
	 TvWiTryxyIxvArqmVC9XD/7Qnzi+lcrs7Npa7tyK/xxZMiuKDfHvqsYK1xNLL3BITi
	 aebxc6ljhwougbOrzONp0v5RvN1vDE/r7la44++F4kAs8OBSZOiqRJjnXxDW52989M
	 hWRYdMf1mBOwRZdtC33GKnBB7Rr0CMJOq1AwWQUBVdzS/zL7Ft8ojoCVqjv+VK8hmy
	 osdeI+msY9bfnwJwF66z2h5ZAHTbdKPhCN3JByWCdUhT4VVtTIMt937KGjrjMG0fYz
	 QBgr+s5oWYqdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2844F6064E;
	Mon, 28 Sep 2026 07:31:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 65A3624E
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:31:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 47C59400E0
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 79ndkF5Z_Gns for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 07:31:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org A91AB400AF
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790580661;
 b=Xqir/L0U9roRX5LNVNEL2BVjtRcOceCtJ+cYTrsQxcAsTVwVWY2BHakMm3tDw1s6wkO2
 3piwbtQv9NiJBA8PIByk5CkjhzUvOcTKIUXk8wgz9N77dHT+516bRTgL6DMwKRBoCUHIU
 SVpVOFQJHyOqjj4n0bNzKm6tI2KM2z+rYPEcL5OIUxDSrFDLQ2RayfHytrqkeaLLFlMIl
 8ppaLxqarePUWpT5gHc7IKEoGIZqOOTt0WlsD3Q2sc7aPnpo745zH3uv5KDhBx4eQpOpI
 YELWQxbdPBSvgqnrzvhgODoI/FpakAO643mXaC+k/G3E9lDJvKJLV33Dx0B82hQgmkQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790580661;
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
 bh=sH8rVNq5hysT8wW2ZvjBSj3IMvPCMO0ajUzaD4YiOWs=;
 b=M175on1DVZjoQjY3eCkugrPeiEZJAOXrMRy+/DU+t7IKL9k4G3nVf3OUOcjtPFbi08aN
 ko5Fo/jK7opH//WcKHU777mmYyE8hIpw+atQ9VAiHcuM7pKnh+fWOvfVvWGDugOLHl9Kr
 Cz/uiHxViEkx0aarwq0tF4jwaC+xXzYDCe1UzL050ARZoM2JfXEh7fE8KjKotb6mL4Nl7
 lvxOOyd2Ti8t2ywR8gEIwlGiasPmfttlO82bY6PYmmNWlMV0tGw8wD1CpKPpK5rZHF+WL
 I55R22dYuPghFDswfYv8MoZc08tvYIn2A4yoRlozoqfXX+ai5KZRoLbIUcw4pOLRigQ==
ARC-Authentication-Results: i=2; smtp2.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=oWhoGw+J; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=patrice.chotard@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=oWhoGw+J
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A91AB400AF
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 07:30:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CK1JQJfyT3WgsmIKcbvfa3fiSPuGmYVB/hGJBRwvm3mndlCiBJ9iGpUuxWcxrKyqSdfwXR/ZBZzmMfDJti0BYUouR4W6OAHBM0y2Ym3E+UIitYKA0eRiHxzky8FPaAcDoUyAUs4+seSNeci10nAVWGr3tD7OpQUPPd2EEA19ttaAoewg4y9ceputTq8A5vFnfhjZJVj/gX4aH9JUwk/ZQtIu416LLmFzEUPiqAA8Um/GjuAB5n57+OA1H5/LErNSGl6R4ByvT4OOBfMfvzBLtdgOz/QA97QC0WBtbXGa6LJFSztVbn+SAqw/jJfcGrE7NY1V4gUCL6oc9FA/wVtKOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sH8rVNq5hysT8wW2ZvjBSj3IMvPCMO0ajUzaD4YiOWs=;
 b=sx+09tz9H081Njb1w/Vpd04I/xxy3Vnbdh+qD0ZVA3Bgi3Q9W36OrJ0PnY2ye7dP61LkSncoNXVDwFw23WGA2TDlP1lbiE2c9uQSdqhLPrgKE0e3JhjiqFD4sJWspXxpD/sSi04AGLf3h6+KVVZtKL1d8V93HCRbOkauBr7QDCgLtPDV+dif8WZ8bOThh15opB7tNgtEHGvW0E17zEbB4OtFPx/mckafLxyLHsaWueFNn/CJRrUTXnpZCIx67Sf8ArciegCwmjjP91lqh+g8TSmqr3eHiL/reR5Yp0tED22UA9PTdI0JYjk70gi5Q/PnkgOByxfV8Ehr3CYFYB5mJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sH8rVNq5hysT8wW2ZvjBSj3IMvPCMO0ajUzaD4YiOWs=;
 b=oWhoGw+JQlPSFkhk9h14Niotcw9M8kcDjuwoksCc0r+7m2QPxBUgDqjxX6ke+tkc4f60xcb/xAEJ08Ckpg3ZdM0KAkvhBTD4oKi4HXA8boCCCxxj+rE+isk21Fxb2zY8Cbdalcfo2Ojr3urukshEHH74gDbXi9BbJtgABrXIx2eOr5rFmwisLQFJ3JCT9CtbirBdMe8P9Huu1SbcgeH9tb+Sho6KNQwWjm3EtDWtcjS6EyM+kTS0/GBvLzHJdjtur4JsJ3TB8T0JFHtPchI3oBCuolALCnng5ai67OCEWr50lHuYy1A4+6OEx8KsbWKSDAP2FICET+QZZtubs6zteQ==
Received: from VIXP296CA0029.AUTP296.PROD.OUTLOOK.COM (2603:10a6:800:36e::10)
 by PA2PR10MB8876.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:422::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 07:30:53 +0000
Received: from WA1PEPF000099D2.eurprd04.prod.outlook.com
 (2603:10a6:800:36e:cafe::7) by VIXP296CA0029.outlook.office365.com
 (2603:10a6:800:36e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 07:30:53 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF000099D2.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 07:30:52 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 28 Sep
 2026 09:37:23 +0200
Received: from [10.48.87.93] (10.48.87.93) by STKDAG1NODE1.st.com
 (10.75.128.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 28 Sep
 2026 09:30:51 +0200
Message-ID: <d9a28eda-6765-489c-a09f-1e34e07a08ef@foss.st.com>
Date: Mon, 28 Sep 2026 09:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: gadget: f_mass_storage: Optimize CTRL-C
 responsiveness
To: Marek Vasut <marek.vasut@mailbox.org>, <u-boot@lists.u-boot-project.org>
CC: Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, "Tom
 Rini" <trini@konsulko.com>
References: <20260917-ums_increase_ctrl-c_responsiveness-v1-1-95305f044ec2@foss.st.com>
 <d5d00e93-e803-44e8-9f20-915e324395c1@mailbox.org>
 <c5c115c6-dc8e-484c-a802-673b46be8174@foss.st.com>
 <5ff54e77-59b8-4a61-82c4-923242f9d82b@mailbox.org>
Content-Language: en-US
From: Patrice CHOTARD <patrice.chotard@foss.st.com>
In-Reply-To: <5ff54e77-59b8-4a61-82c4-923242f9d82b@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF000099D2:EE_|PA2PR10MB8876:EE_
X-MS-Office365-Filtering-Correlation-Id: c64d43a7-5a42-402d-a987-08df1d326d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|6133799003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yMus6Rq0syCrWZ7HtORDZVEQT5oYOW6orLUjTz2W8Y2ZmZhzW4lWilEGbh/wbARBYHBkPWOFzWvj9IB0rxXyyHHqeIoFyGFilSURzrcLQBqm33ME5SJIe/XgY5+wMeGKQNbwpCe6ew9bho3wAlrw/RVb6nKeS39xKZXtebnmQLuKMxaUU3/URszqeq6nwAHujktIuXWhfYSvQ9anp2B1bmpAlnHwCYKohynNVwX0CWkh8x1DDo6HbO1LbB5g2Syinc5jJN2kxpdGJFBQeFZWIn5VJXffkvwBuIARkrvPS1CR1DRKXrbPrnlRxhn0f23Rl7frn1l8d2CZfxERPCdr6K//5iPM4i3UOeYqZ/8OnTihWuglv4yXNXEe4I1w1GQAftxFrI6sOYrLwOE0/4D3xAcgXaZ9rrRo5mzK56meLFTMkBKhTYmbM45HDyo/ZMs4P0zafvkvCfxDn7Ppvq6G+ySy4Hr+0DpAwQZqBT2kTJNswtgqW8RleZ43QOy5X3JkWbWYmXCGYNreB1bMJTFWnw7CghFYOLUqlq8tjDTYMeH1Q8LjA5rDqhvxENpsQ2o+WQD/rCm1GJzkVAHkzjdUqnf2uAiYnlm/mOmlCqxoSgtirGUwpQEt/SmKaFnuc4J9waNTkzHE2eNA3s+E2wCHHGU11wg85nhTJC8Ul8yCYFwTbYrPHY/gzw7r7tqtOApZ1mFy8zPegNLIgJBc9XxzdA==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9fcke6dAPE2niUkVIjhQPQqGIPIkwgSvFzXzILXYPVTujoBbnbvzmsztL7psNGeM6T2qAsC/ckqjf52dA56GM97f7LOriYNSfxxTZ6r/02bPUcjLwwUxNGD9rtgYNjocVK1zMxDJ7OmqKvsApuewO4bqM7cS7zSFHS13C0hAd63pLQ+AKeQtW7bkVKmW9OzHwWew97KCQXLZvw7l+lSxxAMb0QMSNw4GEOqMK6AkXWpZh+BQi/hntMuSc4WE+zu5kSuAe9G9k6sWt+5RiVcH67ra0eYv9hCK4rVwGStSMkBln9QFELotFT4JvTkx1LexM1kssFzaSoUpN/i1uqshh9LSR9Jru5WQxX2qjlXMQ9M/iMyvUwa6vcS5NKko0dOz4UXEG8pmaBEaMcVa51P4kY9A02xjC1cRr3LBNj50kExAUUhl28O/xP+un5TfISI4
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 07:30:52.7215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64d43a7-5a42-402d-a987-08df1d326d3f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: WA1PEPF000099D2.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8876
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



On 9/27/26 19:55, Marek Vasut wrote:
> On 9/25/26 6:17 PM, Patrice CHOTARD wrote:
>>
>>
>> On 9/17/26 16:26, Marek Vasut wrote:
>>> On 9/17/26 10:58 AM, Patrice Chotard wrote:
>>>> On STM32MP157C-DK2, when aborting the command "ums" using CTRL-C
>>>> it may take a while to get the control back on the console,
>>>> sometimes around 1 second.
>>>>
>>>> By removing the if (k == 10) test, it increases the CTRL+C responsiveness.
>>>>
>>>> Tested on STM32MP157C-DK board.
>>> I still have two questions:
>>>
>>> First, do you have actual timing figures here -- how long did it take from one ctrl_c() invocation to the next ctrl_c() invocation. Use e.g. get_timer_us() to time this.
>>>
>>> Second, does this increase in break condition checking impact throughput of the UMS ?
>>
>> Hi Marek
>>
>> Time between 2 ctrl_c() invocation is around 100us, way to fast in my opinion.
>>
>> UMS throughput is slightly impacted :
>> before : 7.35 MB/s
>> after : 7.17 MB/s
>>
>> A better balance can be obtained with the following update :
>>
>> static int sleep_thread(struct fsg_common *common)
>>   {
>>       int    rc = 0;
>> -    int i = 0, k = 0;
>> +    int i = 0;
>>         /* Wait until a signal arrives or we are woken up */
>>       for (;;) {
>>           if (common->thread_wakeup_needed)
>>               break;
>>             if (++i == 20000) {
>>               busy_indicator();
>>               i = 0;
>> -            k++;
>> -        }
>>   -        if (k == 10) {
>>               /* Handle START-STOP UNIT */
>>               if (common->eject)
>>                   return -EPIPE;
>>                 /* Handle CTRL+C */
>>               if (ctrlc())
>>                   return -EPIPE;
>>                 /* Check cable connection */
>>               if (!g_dnl_board_usb_cable_connected())
>>                   return -EIO;
>> -
>> -            k = 0;
> 
> If k is not reset here, then the ++i==20000 above triggers only once ?

variable k is no more used, everything is triggered when ++i==20000.

> 
>>           }
>>           schedule();
>>           dm_usb_gadget_handle_interrupts(udcdev);
>>       }
>>
>> Time between 2 ctrl_c() invocation is around 28ms.
>> UMS throughput is not impacted (still around 7.35 MB/s)
>>
>> I will send a v2.
>>
>> Patrice
> 
> 

