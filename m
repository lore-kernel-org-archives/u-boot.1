Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592AFCA600C
	for <u-boot@archiver.kernel.org>; Thu,  8 Oct 2026 15:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5186E40B48;
	Thu,  8 Oct 2026 15:54:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zuxIrK0rTVe1; Thu,  8 Oct 2026 15:54:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 53A0440B3F
Authentication-Results: smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1791474861;
	b=tcJxKhDRY/mvur6NIoNhV+78aRkvSa5qxU6v43QYmNxj1HmoK/GmK+Lm4UBh7AM3e+Ag
	 jh/aIZ9Xb50KCKQxaFvVbe65/92R3sTH60tNMRS/UY62HTf4NsuaiC98ZHtqWcJ4eraHb
	 yff24w0krVHHIUFhYzuIyuWp2/oJe+xi02PAA017gn2PW91/EYgCi/SsEYuaqds0zRM8g
	 4iXqMhan3DXj59uUNceahe1jsEeOb8LzFOixo5l05UMXs5mozj1ODb4IrYfiDQ4gtwutk
	 arJ6YdqjO3eUWETZDIud11RdYCzcFNNfpIe3kB+qsgBKWQQo9326SYgNBetzM0iR98w==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791474861;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-ID:
	 References:In-Reply-To:To:CC:X-Mailer:X-Originating-IP:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A/AXIhoSi/PTVVqr9sGEK+ylQW+muR0nRwQRis8iLe0=;
	b=kxjiMvvU7x4zXoCMCy9Zy6XG+r9I5/8OXeW9N4ob+PNPwC906mkZIn31DbjvjrY6nsd3
	 j+Dw2ordSLDbtexGa+HpqyiJdmVoqxxrmxdJ4G03TT37SmE20rp/Tz3fh8t8eB3F5xS45
	 2ADeo7y5azesGGno6VMBBW9Mw5ez4peJo122m77nWsc4eP3YDNZ4Wk1QqoccWlubDQM36
	 XYYWvZ014hLh0cu2zO/iv6THvw7KGV0n76RaZaoaqq2hygDSKxnGV1g7mVXmMYxJNOzd9
	 dYAFJK70rDB1EUFxg6GsSfgvgd3iQmFCBo3OLiJAVytkKZGbjiBa5F2ecEnmJ2Kjz3g==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791474861;
	bh=A/AXIhoSi/PTVVqr9sGEK+ylQW+muR0nRwQRis8iLe0=;
	h=From:Date:Subject:References:In-Reply-To:To:CC:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sv5vh58jLng6wPpfQk8MjaBxXELlQpSPqJ++4PuNx9upVaaeVhaW8AzC6gE1o0XIg
	 J6o4ht0hrXbZgHphWqetdskt7XStmnEiPOEhU9cI0uflE+kc3BUnqZx4LrHa2eu8t2
	 QCQLSheDlpalwDkGArkWqVMhNJWx/APKoxqfZHi6hPzz1h0VA1suR7DwfgTGbyoO67
	 610oCZuzoKCkjYkUsnE6HFLg+rU5Hks2rT5e8vpQXsinkT4lj/tnVuyAxhXZKntRSY
	 xc8WKgP7zYNiFIUy1JO4HKR9Bz6KjNtV97fVwjRAB4u1NHHBLc6RJJM7SiFa+3HI3h
	 mQzTbBOhARTOQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53A0440B3F;
	Thu,  8 Oct 2026 15:54:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DB51F150D
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 15:37:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8D7881087
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 15:37:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2pwBQInOpaJb for <u-boot@lists.u-boot-project.org>;
 Thu,  8 Oct 2026 15:37:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7883180E6B
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791473849;
 b=B0Rcu7FiMwSV6uDljKc4tUbrx9GbajX8FL6t+SvAfWZKOuO+f4hmYKcU5LJ/XFX1atyz
 o38MNlu4sHPilgWksQEt7nWcgZSCq5VPXn++mRzV8hSDVym4sc0Wybl6laFaOezeREb+C
 HjcESF77ec3Ii9XixCpsCamxzOcInItRlf1+pT/aZdciO7IN8Actkm7o2nHQUDi5l6Pl6
 r0SRLGbN31bnSnWYmxZCSB9sXhf8OIcQk5ZgHGX8LGeULZTU8oqBhx4Mz8Q0q2+jbremS
 JPLl7p832PWVemAU69NbUuIPlHWu/ef8SOyPglaUHHjIdDy2obU7m6l+8YQaEMXD9KA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791473849;
 h=Received-SPF:DKIM-Signature:Received:Received:
 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
 Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
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
 bh=A/AXIhoSi/PTVVqr9sGEK+ylQW+muR0nRwQRis8iLe0=;
 b=IPsDzTZ2a4CC2m0nvDRTd65OitrgaAG7DgKEC/uPi8NRuicl8UiQ5kICmhZXA1cS9Ss1
 TcIYwVUBYLeeSpQva5pycfpTmMPQj+qMxi2/ftlmpohhYlSV47/hoB82FczwNraJUyBcI
 s9sSmSHK4ffUAZ/Q6t2iMAe60cv92PI55+HeyQm4oXm5oo4EF5mPR2e3xirCoAEa+YUxf
 6Opa/kRTgQJbPF9fEAeWjHrZHJ+XA4NENT8cy4fRst5Itnk/BD4wUEEy0/SFYuHu4gRsA
 7sseZod6hsQ/7fQHXOqnSlYklynyOql+xmloqF9sBzPi1bgog1q1HRi8NiOry4JcFuQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=foss.st.com; 
 dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=HY0VJl8V; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=fabrice.gasnier@foss.st.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256
 header.s=selector2 header.b=HY0VJl8V
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7883180E6B
 for <u-boot@lists.u-boot-project.org>; Thu,  8 Oct 2026 15:37:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emNMnHtvdKyGXzrQifh0yRwvvC2hIrR8LRnUkgGwClLwewAZd43JkZxPrptAc5rHCgaqsIyYqAKhEXG8YqxJsaUjp4tUCrYaEg3iuJYBC5MrzlGWejzSBPjKwq55vHitUHnKL6xY025dX+qp/Cc6AVgTakxRMO9P2MTks/u77tRbM7J/aerBnljqxlxxmkRvEGGFjj8dueqQgtIiUH7DsOJBNcOS2ZPHlI5MNvSz/+t8DRP5Iv4KbsJ+lNNF0l71yes78ecI02VW6ipmSTmqN1l6Sq8X3dYgNkk7oC940Z8tHZd+sgJM9X2zzQeflA8yPwlF/Z3WeRW9CvEqV8EHZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/AXIhoSi/PTVVqr9sGEK+ylQW+muR0nRwQRis8iLe0=;
 b=QcCnCbUtqOAtNrZ7gxnLEJkxolodak+hGO+FNMiCY7hN7R3FqqucWw4R1M/LbqwkJMxKTXjFo1Zgn/AeGRJX1vLw5RYz2uaa7MKG39o069Ax+PQH16NKz6DB07ikQGxceryhgRwsv15avAjZH2+bOma0T8P29YQYVAotRpaKM/GMVUf9/JS85kw7LrAEtuQF4zS0nlASZ+unItWbQg/ShvF8QYhV+uEEQNMuXuutuQRY5EaDnqDl3iJTuQuEG/YhsiDd2fwy52ZbrkCafPS0uu4zyqGo+URTaL0EvfkmPfQU4zjFGScOBSwORSxsc2UERkASC2YxaB4iD+fuZm/2+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=gmail.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A/AXIhoSi/PTVVqr9sGEK+ylQW+muR0nRwQRis8iLe0=;
 b=HY0VJl8VAJIjvwbgzmBo7HPwfhnGK8gkMsNdeH2WVQpB2slGZTczd69sI1cQnn6LtAN6W0ccwvSeP05EeuQ424Jt5l2jJmtH/jcT85Lx8uEQExZGVa6cYN2yzPhOA1ZHP8lQKa5elySD6Lnsa/OTMTadweE+q+8MF4DK5FgqMj+4ZNQVNebcKqC7tZbOmHr0GA7TMULrvJig1zTVTIU4PJkwEYlZQlR98q9elgfNenf9HsqxZK+oH2F/2gd+lyQs//B2vdXc3AjWd6co11g7CHcrqrNB/m8SqAEngC4AIELCMP9cPoNr1T1VYc6aQyUXNkDzY0yu3P/D2fiNYsqbEQ==
Received: from AS4P190CA0003.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5de::8)
 by AS4PR10MB5918.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:519::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 8 Oct
 2026 15:37:22 +0000
Received: from ZR1PEPF0000E461.eurprd04.prod.outlook.com
 (2603:10a6:20b:5de:cafe::19) by AS4P190CA0003.outlook.office365.com
 (2603:10a6:20b:5de::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 15:37:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E461.mail.protection.outlook.com (10.167.241.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 15:37:22 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 17:43:27 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 17:37:21 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 8 Oct 2026 17:37:07 +0200
Subject: [PATCH 1/2] usb: gadget: dwc2_udc_otg: bypass debounce filter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261008-dwc2-iddig-fixes-v1-1-24c302b8953f@foss.st.com>
References: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
In-Reply-To: <20261008-dwc2-iddig-fixes-v1-0-24c302b8953f@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E461:EE_|AS4PR10MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: ce047e6e-a0d2-485b-623e-08df25520bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|56012099006|6133799003|18002099003|22082099003|3023799007|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: rihFA/x3ljbNTlkhpFZhgSGGEbD2gcYNS0pYoRGCJRtKc7Yi+sBNXSM3s1GqyoAgWDWPiz3ll7rXsBb9ymQ9dlAN7Gkhiusywg2SPGcE8NqJnRrxoE3Jko01k/0s/IbpVRjn0sGuD2JBQwhOoliQTyAuXrUIlaUSs1K5XPAW10QTssA7uK4IOdBAGVnnJFOelRC8JWrVfaRhQBfYrYAxtrXUk4IhalqUt7PLuF4MTDKzvhzWqcw7ijHTDjuyQ70z5l4uyNEGghrD0c7L2unAmOvEpQPzusmRzH69gsB50o0pmRLOuRO+kprLgip35muFa1oMXOYqTUxiwxlYGhlF8kLYWO2TkFlt3Y4DECbmltssxMgVQT2fCaXacCsvn1D3GGLTvQI+KGeuyP/4dT3SLrMvFfxH+Huu45cIM05WI+DmxWC/lvBriRUs9LGTXldKMKB1ltPNL6kTc7TRv6PC5k2Vdi85b3sBaK7tnKiNmHF/uwEJ3dJ317OmNQ62VLpdhMSwuxyUq+TwqtVOy6/Y0OCD7YXf6T4gzkaUr5E8HSIk5bK0kNmEeIZeTxWexKVHsDEMlF3Pc4URTRSdOBD32JcVTxsmDZoSlP0zN+pH8lsvvnLMA/kMyFdDYeKSE9sm9yoOYPrWdbL8dq+eZKI0YoAAESFba/s07YBWqy3tS9BejibM+QZqYEZVRjZHwE1GEgNF6hlMcK9XwKlv+nbvAQ==
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(56012099006)(6133799003)(18002099003)(22082099003)(3023799007)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: n6QFJuUh8WfZoLaX6motcQWUKTU7W+zdkMj9Po12y/cPRgbxnV6/z4QqT8kxqVQQPkx4DMDkClWgxNt0cyMEO3rg0oKszGhSDWju9N5lVFljl15nZkdd4he4p1RRHJttSa7/lhWF7naKjTSdKzKwRGPvrV5tcLYHwS2ikG81CtpgiOJi9fe+65jdy1aIonepyxb1t176R+f+VmdFeWxCeL/aqf6LM31DJ+8RCsoXnSys55HG6k+Mk4NgvNSe0c+BOoqxbs0H8RTtb3VkP2cKiQ5sOrjz8C4GLNfoZryczcUKEndqri6xs/Bw4duFbVSHD76meoyW9Rui2vOyHzyL8soy7H7UMkUjbmynSKVwGTJ7DJIkhxUs1gbrqIPZlJ94/3vE+ufwA6e4h+0Vb64xnQun3IRyagld9upENu0qoLGx2pa5X+p/NfJLoxkerhmi
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 15:37:22.4113 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce047e6e-a0d2-485b-623e-08df25520bc4
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: ZR1PEPF0000E461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5918
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

When using the A/B session valid override bits, also bypass the
debounce filter. There's no points in deboucing, while forcing
session. This solves some connect issue seen on stm32mp1, as forcing
session races with the controller initialization in reconfig_usbd().

Fixes: 5739ef2bcb6d ("usb: dwc2: add "u-boot,force-vbus-detection" for stm32")
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/gadget/dwc2_udc_otg.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/dwc2_udc_otg.c b/drivers/usb/gadget/dwc2_udc_otg.c
index 570fed347c9e..2129bfa1edb6 100644
--- a/drivers/usb/gadget/dwc2_udc_otg.c
+++ b/drivers/usb/gadget/dwc2_udc_otg.c
@@ -1129,7 +1129,8 @@ static int dwc2_udc_otg_probe(struct udevice *dev)
 		if (plat->force_b_session_valid &&
 		    !plat->force_vbus_detection) {
 			/* Override VBUS detection: enable then value*/
-			setbits_le32(&usbotg_reg->global_regs.gotgctl, GOTGCTL_VBVALOEN);
+			setbits_le32(&usbotg_reg->global_regs.gotgctl,
+				     GOTGCTL_VBVALOEN | GOTGCTL_DBNCE_FLTR_BYPASS);
 			setbits_le32(&usbotg_reg->global_regs.gotgctl, GOTGCTL_VBVALOVAL);
 		} else {
 			/* Enable VBUS sensing */
@@ -1139,7 +1140,7 @@ static int dwc2_udc_otg_probe(struct udevice *dev)
 		if (plat->force_b_session_valid) {
 			/* Override B session bits: enable then value */
 			setbits_le32(&usbotg_reg->global_regs.gotgctl,
-				     GOTGCTL_AVALOEN | GOTGCTL_BVALOEN);
+				     GOTGCTL_AVALOEN | GOTGCTL_BVALOEN | GOTGCTL_DBNCE_FLTR_BYPASS);
 			setbits_le32(&usbotg_reg->global_regs.gotgctl,
 				     GOTGCTL_AVALOVAL | GOTGCTL_BVALOVAL);
 		} else {

-- 
2.43.0

