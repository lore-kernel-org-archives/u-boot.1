Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA778CA600D
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 15:54:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 520A8407D8;
	Thu,  8 Oct 2026 15:54:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3ub0QTV5oKmR; Thu,  8 Oct 2026 15:54:19 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 7AF224070A
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791474859;
	b=mIO83JqOyYFE5D42vk/QEiJ5sDKF9JMbxQGp+dosdCeG0Dcgy9b7i5SBkaaFEyL0r/gk
	 WWZ20nOZfAqTvylwCPuxnQrcdPQ2gYH4ODyA1efzwfH+CGFt2pTzIpd8CMD/tEwkpl4ZR
	 1zk81aqxbcU0OXVrZq74sIuoUQhXEl/uM8j67inDRFCsFDJJxDZ8pbZ4Ld1Zzwuqsaj54
	 IRZurm3PQw1b1pJIhia8Xt2NrOAlyRFlyg9OUNmD33ZqR47kDJaLjAH44U3qbyMom733W
	 wS1JFWTupIQVxt+SLvbpyBMS9a35RodGKfFPMZBEwxRCZ6K4n/bpwxbQuo0FvaQMiwA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791474859;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:CC:X-Mailer:X-Originating-IP:X-ClientProxiedBy:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=8zFfAozFpO+LORN0Kb0DIoTNS/IRf00ERdQizT8h5T0=;
	b=Cm5opiGrfMvhvE+mIDgzDlLBJ98gAl+wtWfJHT9keBhbdiN/uhB/tCQsWog5nOCi5oxR
	 du5WFqJxhx3WqQpQwB40DKuAZolTgkJSpWsk8wZZ5ca0nextvN8Y8ZnjjztH2CksfywLT
	 4uHR5FnegfmET4YXhYxYpLbDnm5SyXpDyVYg1sL3Syf+eJJ0WaQRA5Wgqw/1pYBPUl27q
	 dmXNkRK3WYT0F/SV2vXpNft2IqEn6YBeF20vdz2DFdHQQBgo97j1nBm501sIIQuqtZeZx
	 xiKf0W/MPNNy+OeVQTfpqA7wHi4CYgA2K5KRD+Hhsmj9WmjcI9LcpWI1tDZMCh1gWag==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791474859;
	bh=8zFfAozFpO+LORN0Kb0DIoTNS/IRf00ERdQizT8h5T0=;
	h=From:Subject:Date:To:CC:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nqyk5GM7r578s0hvWH2VpZc7T4AHxGOrjeqFWmQCBuCBzBjENzSDBnQWbTrunVahE
	 HpXB6iewDgSnntJStiI2aI28tl5X1tPmMZ6L5QG4FsuVKNgwI1MbnzkvIpC+9iDuTR
	 mhQq39PyKZjuLcpQ/pgHTeSKLcVErvvTZJ+w0sqlaMrsS0m7nefN0RaPUJt58XO0cG
	 8UJ7FxCLE6QADGftrhXTZ0wVDrlLb8vuYN6+ZbJ6wBxAp/9JHnnzOKSgXae2bKr/jx
	 aDm9MVnOvFpeAJNQvnOE1RRoHE3p/yn5AUhiLnj7Mxv6Q/ddsAmTUOfzuRTA9CI2QS
	 GesBKr5ICvn9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7AF224070A;
	Thu,  8 Oct 2026 15:54:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D92F11A6
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 15:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BC89381021
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 15:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mvodwPAzia7D for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 15:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 6FF53807C9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473849;
 b=rP2SpzJQdh7zGNbgkVYq4+a51O/ZdzKwBdQEYzxSPfdYlQjrZl7RkJUuHExZfL0wqwf7
 TKSMW/LauURZB50aIm9mpst60M9AAdhKL21flUMAHatd3Los/TFJZB3jorv0COFCVsvt2
 dnjl7zuloOtd/lc5eq+35H5Z2OxHl8ljoe04VPvahZ6/0PwmemcaReWCpWRsaTI3idyqi
 H5cJAVycypXBEMzh9WgxHYB4qd7lzxRJ2Jo/yKNR40ojkDSyuOuY/0tRr+whrLV6Pi6MI
 j1XvdHfO/w7/PNhrWJkY0LtSD6sYnJk5C+qZ0PTUf0TEmLF6swxYP4IJe85ck2giHlA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791473849;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:CC:X-Mailer:
 X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
 bh=8zFfAozFpO+LORN0Kb0DIoTNS/IRf00ERdQizT8h5T0=;
 b=bkiHM026SSYj3bYS2Mjl/7P0WzoanC4EYD1efy6cb/uAkumyJ1Tet5uwzmdDv6DrqO67
 jw5mY3yLYX05bUv4N143vwLUpGGVyimPn46LMm5+frZFyIcUBXQoOIyUB550+mkxVn3Ep
 SbECelKLDstQ0OyRt5o/GeZU48GsZPLD/kreHqBxsXP+BytKwDrj95FQWTNLiuVKzjWPS
 mBDG4TtBZ6On3Xl99HA6pVToa5p0Mfaih3T4aYXQ9SJxf/NJEhYENHTJkV+xWCVfAznh2
 BYm0jY5RybiDAm3JUMCY8dTvlDc7lT8fGUXeNwY0dmZQZw+aVLTNU0TaHo545C+InIw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=MtnW85ns; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c201::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::1;
 helo=am0pr83cu005.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=MtnW85ns
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FF53807C9
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 15:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wd93h8wdacPsXOBl3kcIo/fwY0whqQGGq0BJ3vsAYSRVh0UNW9ERrzUOpn/6NAFEbYHZVK5YxFR7vhVajcYxgsMnrV+qtd2LZnKXgjLGirie3PD/88Zp0XMyKR8F/0V+m2U+rNn9+1ZzxaFPj5l+w+k/jEmpKcIGY6KgHvFERXbJzQlwDwApqnnSXhF+/fSrcctFKGVaFiutZRitjRK4IkiJ+vTtGfEf3wreYIS59dYH327JksUzdUR7kEiel7rREM75BUT9d40UFHlaaZ3l246cers5xsk04LHhIGoHderx2bl+elHGX4CsqRZcQMrTIc8VliHnw3SqkbLeoxuuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zFfAozFpO+LORN0Kb0DIoTNS/IRf00ERdQizT8h5T0=;
 b=BJpdtGZS2Nb8WQuKS2U0oKWkF4JOl1HKBbsaOvWvp7JvHIfFe9JMJJJm7NUKqGHZgrrXghIMgIM8anM7DzW7aXUfDXnA9STHi8PKU2gGgFDJ2GcStqpW9CycXMw6zkK5VeoEhbc1W/MFOl+pivZKRhJZrvPz6ls8BvO2ouzUxAnDZQgA0bnrCZ3QowNbLH/s1q4gDuPZzY9yfcFkHkdL2P1LKKGVXJbJ7a2U6dk/gPVGVSxFKoBVvPRN6+eZqxN8cnc0ctegFKpH8HdlBWKO6Svr1OOVc2H/ZamOFpwz30oHvpOmf8MAzYd8m6rDi4dT8RCvXt2NkWcB6ta4WJkuXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zFfAozFpO+LORN0Kb0DIoTNS/IRf00ERdQizT8h5T0=;
 b=MtnW85ns82SSCYsV2hvRYM46AdaRH1t0jBsZGD0o8f/kC5TrHXYFPJ03eWe5+ukG/A5P7GU4Xsz+Fh8HQOYl5C1TnowKKR4TZ4CuCg4WWGSDMm/7E5gl4PcKEuqkyHCVgMcNon1/lmcg09MD9l5GmBpjF4YP/SHkKUAAeko86RWaQ/jSICEsTTiHiA//itTJ8QI8E1OycyN6QdxQ1dUFSeUkO/oV3JIlx/uyTgn9pYZBWvhJrJrfyZETacxxvqJKyLyrM5v4veVpVcZO3/tEv5fr1O2jLJzPlJB1+dzycOOkUoUAXXN8zPod7jD8aWhcpdUPgFRWxLeWQhSSQJ74VA==
Received: from DU6P191CA0072.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:53e::25)
 by VI0PR10MB9635.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:325::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 15:37:22 +0000
Received: from DU2PEPF00028CFC.eurprd03.prod.outlook.com
 (2603:10a6:10:53e:cafe::6c) by DU6P191CA0072.outlook.office365.com
 (2603:10a6:10:53e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Thu, 8
 Oct 2026 15:37:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DU2PEPF00028CFC.mail.protection.outlook.com (10.167.242.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 15:37:21 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 17:44:08 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 17:37:21 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Subject: [PATCH 0/2] dwc2: fix debounce timer usage in stm32
Date: Thu, 8 Oct 2026 17:37:06 +0200
Message-ID: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKK4x2oC/yWMQQ7CIBBFr0JmLQnQKNWrGBcVBpwu0DBqmxDu7
 tgu3/t5vwFjJWS4qAYVv8T0LAL2oCA8ppJRUxQGZ9zJGjPquAQnLlLWiVZkfRysP+Pg/WQTSPa
 quA1SXW878+c+Y3j/f6D3H6+5UeF0AAAA
X-Change-ID: 20261008-dwc2-iddig-fixes-53179e377a1f
To: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 <u-boot@lists.u-boot-project.org>, Kongyang Liu <seashell11234455@gmail.com>
CC: Lukasz Majewski <lukma@nabladev.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Marek Vasut <marek.vasut+usb@mailbox.org>, "Tom
 Rini" <trini@konsulko.com>, Patrice CHOTARD <patrice.chotard@foss.st.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 <uboot-stm32@st-md-mailman.stormreply.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-Originating-IP: [10.48.86.251]
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFC:EE_|VI0PR10MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 104aad79-5f87-4661-97db-08df25520b73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|3023799007|18002099003|11063799006|260925021911599003|260925022911599003|260925021311599003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2h1Qhe11JVDCSYmUYSP2lrf/IRm8onqCAZKfZDsj1t1k/gD0VECUVXAWnx+M5gIpo3927cdYPn5v40Qrb2rSTzLs/xUS4ePjjnS9vAf/c3F1Rri7xb4++J6N3jhqT782d4YWm9vrJpHJkFJ8/lGD1g+zPSzkTWrsIU1DkfFGIzyzEiORMeY00mShty/QhFoHI+En52Ez72Li9pf7GL53VU2FtJfBxIkC5RsHruljHs65ByqUIewL/xEksXXQETC63Od5l4aoDOVcX76xiYf3cCexdKIOdrOfpqPXIJGqyBoDoEEjJnOW49FF7wNZiLb3B79bx+0LoIZoW3QD+aChcJe5RHgD2RR/dW/A6KCEA3IltOhPTdIFAqnMI10V00sDu7x8SqxGR/Fh2h7Jrv99IcOvPSDsICtJ9RyfFHwi9ZyrR9p9qVopA74963Dhz6eKSspi7VHwjT+VktJgsR/6RIvASlUno4cIt8E1ICrxi0VXJH/6biHScLB8hClhg0910/6CFgL3FgYf/B6npMm4veM3Zk8iqv1XBXgUMkKOVvkVuFO1n17XtTJc62kCDUiye60nFRc6JIcIy9b8Egqsz/wtQwSE6FQi5wkPIgU/U4Rn0WGMwFDza91kss65TxnpleDw67ycnGIGU3RFOSmDds+ylF49sMGMDvcNy2jTGxsy02RUMg/5q8l1k6Lzr1FFn/RFI30R1FDm3xri7EuOJg==
X-Forefront-Antispam-Report: CIP:164.130.1.59; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(3023799007)(18002099003)(11063799006)(260925021911599003)(260925022911599003)(260925021311599003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R5ITwHL75K78vRliK7S+DwK0OFRg8CjmSv9HBYyWUjoieKvkd3KsF2929pS0rJLJjKfVF897r+IRuNShHJEovSNWifGCWUPzBxjmkp4fsPafTB/e/B11ihAXvCyFxybBOcTl+SpgRV2Nxa+CVmI5MVIwW9Nj4a7lKOjRlKWctVY5HW/mJEA9zA8BX+anQ1TNGCKbPS16RVO+JwdvDDE01JOkjYNm8MmkAkis6TiqaL4dY1+ZfEUqgiZ6fhBz7SDWns1zAX0osoNbif8aBYHOlGipamN/P3d/6tWHKvw9zGg/OAXULsSgeii4GMqoQnWEvwMi/dmten8retlDjfSMezMG5NKHqif3V2pWFJLyJ16U6URx2hZ3xcpTsMO0MCW2DQhI+Q1Fi426+tN6t39QiKnee43TiTZjOqPCPAGfDbKtw2ZsV4PJ4jplpMSQthAA
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:37:21.8388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 104aad79-5f87-4661-97db-08df25520b73
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.59];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFC.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9635
X-Mailman-Approved-At: Thu, 08 Oct 2026 15:54:17 +0000
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

Since upstream has introduced dwc2_core_reset(), commit c5d685b8993c
("usb: dwc2: Unify flush and reset logic with v4.20a support"), upon
init, the debounce timers used in hw to filter signals (Vbus, ID pins)
race with the driver init. This result in the wrong mode (host) being
sampled in dwc2_core_reset(). Then it polls waiting for host mode,
that is never reached, because the IP turns into device mode, during
gadget driver init. When it happens, below log is seen:

dwc2_core_reset: Waiting for GINTSTS_CURMODE_HOST timeout

- First change disables debounce filter when it isn't needed e.g.
  when forcing the session (override Vbus/ID pins HW sampling).
- Second change adds some check to wait for the correct mode to
  establish during init, when the digital filters are used.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Fabrice Gasnier (2):
      usb: gadget: dwc2_udc_otg: bypass debounce filter
      usb: gadget: dwc2_udc_otg: wait for mode when digital filter is active

 drivers/usb/common/dwc2_core.c    | 45 +++++++++++++++++++++++++++++++++++++++
 drivers/usb/common/dwc2_core.h    |  1 +
 drivers/usb/gadget/dwc2_udc_otg.c |  8 +++++--
 3 files changed, 52 insertions(+), 2 deletions(-)
---
base-commit: 5508406582f6f7120dce0c4b3059819a41788db2
change-id: 20261008-dwc2-iddig-fixes-53179e377a1f

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

