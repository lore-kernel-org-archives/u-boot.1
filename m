Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B60CD49216
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 12:11:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7869983045;
	Fri, 12 Dec 2025 13:11:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fTmv7+zG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B208B8334F; Fri, 12 Dec 2025 13:11:38 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 46BFC82C7F
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 13:11:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n1Q075D+DKnz7pfVORmsVn2y4oxmkEoKs+MmNesNP5juUizkai7mBLENlMeFhOyqpCMsh86Z+xFrTKxbPxxBwmfesDwi+mUvD4RzJL57zc13spcQ5sRKhBohmUDuyNwmPfLwbzjUfe8uyPgUBFrDhyUeuJn0rB48qHnpBo1GRdXX9Q8ZhLkYSU54hhMspa5lMUebEvruCGmSOC3/BLhmVOtIMRgtcyHGcdbwK17TN4Ye8RPdz3c2FM+G6tfxFF5EvDJcN94RjMtlRICpD64YOmu5FU1ZyW1EdbV7kUIBBEF8dPm4RKHXDzL30O5GQzjZzTf0NEUVBr2vrmSmkfnd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IANpAJ+hRtLw9Ze8D+qmIZNSh2AM3q4PAKS8zkfQ7Vw=;
 b=CrU+b/TiubwnJH29cHxD2m3keG38V9S+NJzhBUtB9FxOf126HMTtvlkETtjpOLTAjZNKP8+YWm1ABD47jvwjRDbuEuMtfrroyytYfJuZoLic8WUdjtkojwqD1jL9Muf7pjH0xYYW9H7M8IHmQwVfVm9gSqQ23Aa9JICkWCL7wqswbXtsaQs+pfAcmpls5iSZ1smwftpwk5soZxQOCo5ZfHu3AFkcS5Kv+/ApQIP9A6VCB7Drz9qwdcxkQHNqxg6K6FJDvDOb1826zZlM4eGCz+L1sJ7dpFDfF2RrBsQVQKTuGATD5NxP0Xh8yGz6oE8z6HYB6s1KUlBgteanVaQ6pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IANpAJ+hRtLw9Ze8D+qmIZNSh2AM3q4PAKS8zkfQ7Vw=;
 b=fTmv7+zGEci32DQdI72nQw2IbC0Ve5hKzcFOEwhP4t+ebZGh+BUTrID9mAfOMfVWQAvwLc7h/TnXJ0leiROS2OxJpng7acqv9yCvZM+JQ1Gt2BaQm/EpIlgGqqJcXk7BKuqM74MrP8I4XgfChdmEFNkfxB4uTFX1FeTWmGSgrl0=
Received: from BN0PR04CA0147.namprd04.prod.outlook.com (2603:10b6:408:ed::32)
 by DS4PR10MB997644.namprd10.prod.outlook.com (2603:10b6:8:319::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 12 Dec
 2025 12:11:32 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::16) by BN0PR04CA0147.outlook.office365.com
 (2603:10b6:408:ed::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.9 via Frontend Transport; Fri,
 12 Dec 2025 12:11:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 12:11:30 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 06:11:25 -0600
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 12 Dec
 2025 06:11:24 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 12 Dec 2025 06:11:24 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5BCCBOtA2187643;
 Fri, 12 Dec 2025 06:11:24 -0600
Date: Fri, 12 Dec 2025 06:11:24 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
CC: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>
Subject: Re: [PATCH] Revert "clk: Return value calculated by ERR_PTR"
Message-ID: <20251212121124.bn7mwvzrx6rqpqsv@disinfect>
References: <20251212011906.865419-1-trini@konsulko.com>
 <0aa60ddd-096a-4cc4-a990-986558bb8fa1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0aa60ddd-096a-4cc4-a990-986558bb8fa1@linaro.org>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|DS4PR10MB997644:EE_
X-MS-Office365-Filtering-Correlation-Id: 6420db6f-4909-43b6-3717-08de39779591
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IBo17Gq50bHJizmH3+5RNbA15kZ+SYfoihjGNvK8GKfVIadgYVEFAc+QtOD9?=
 =?us-ascii?Q?lQjf2mtrvw1n6fyTdJLNttaYSia2Mf69RNSNdnnx3JndqmDUXTtKq/Esi4Gj?=
 =?us-ascii?Q?9TZxAS5S6ycFRJud4lrX4wqaM5VQi2xWjAe0RC2FzcyqzukGWY6Iffk99wLi?=
 =?us-ascii?Q?snX5wIUXASErLzI0+HvP6YPETIQOTp/SH2WRpygmmd1s6JUr1EEt8JMN+CBT?=
 =?us-ascii?Q?94nLYyNFCssHRCovRnehRcfU9oEErY3p+/zUaKti2K1WtvVE0w2zGAHEYjN+?=
 =?us-ascii?Q?qcFXWjCNYPfCkrMpyRf40lYCnTa3ghxYvjdm9r32BdyDaGGpTXd5zoQg2Waa?=
 =?us-ascii?Q?GCfX34Bptgw36Tzl3EOLeROHJ/y2QStw3SG+KzvDK4jElVoryEhA2FRTE0D9?=
 =?us-ascii?Q?wuPQImW/3hyzl1n66TUFZ6DbswoxY82u7OgfzjmM/ATmn9ZX8tfFI0F4ZvSY?=
 =?us-ascii?Q?xUWCcOepPkeRFtwPGXPExXKZWVbB3kMzONlUqwC3NSlAk1X951NlGgzPPCmz?=
 =?us-ascii?Q?SVJLd/RU3hMphk73D8JBwy5Qh86DJFAJ2gI40wglv/fiD7sup/AGYAGQg3Qq?=
 =?us-ascii?Q?qr2SzJikpVyztRN0fBNSfWQxUUxM/Kmsek2HAe62jWJYsCJ9wwzlP6fJ4/sS?=
 =?us-ascii?Q?GtqKGS7PtHT/Jsmnj1BQRXJ1wRW5RVtbhEJ4VrQ1rFaYZAX7pUd3rfcShDFl?=
 =?us-ascii?Q?/2Rf1RatnLBZtKcp5gw87L3RkOuU5lX4UdjyrYbsakMdSBZbxlOIzRKdq3G/?=
 =?us-ascii?Q?JtttA1k3BvU92bSeswf6VZG6Kj+jh3m0rffs1CCb6nOhL4BlfOBskApd1tBN?=
 =?us-ascii?Q?xu/RciuPPEo7CE8xw6aACxpw6voWxGTVogsfTO0Zq0FlTHyk6ZeIjvAT9CaM?=
 =?us-ascii?Q?enkt0VuaVTUYbDlEHaNaIQw7sLhAh9P9Vvd7xKx6aY7GEY8KgOKOjD5luy3+?=
 =?us-ascii?Q?zgAKAKUP1UO/Wrik5t7VU0xO4O8JczPwE7WQNany3hu6DZrLuCoKAepYKllE?=
 =?us-ascii?Q?aE7elMNO0SO7OKrh5oeY7os/lWZd5eKajbg+wdHbBQ1Y1yB+ClHOhXqHSZjw?=
 =?us-ascii?Q?Gd00V0cjMDxXHrjZCVrHrkGahYxzSSMic7KbscXYFW4LQ5hnwXF7/lm9Scfi?=
 =?us-ascii?Q?u6D9RUOsGmyGIpHleRcZZQFIBSG9TlsYh7p4rsJkTW7+hqyUMSVIKQbGzLsx?=
 =?us-ascii?Q?ZEwpgcffAu5Pn3EVyEEQ0UikCqmt4vAkGPE3BHbYAcQSfx3OWkJZjQAL+D5q?=
 =?us-ascii?Q?4lk0sGiDIPJnDJID2orqxbw40NHvIMxbvtlYx7ZBG35OdJPRuSSLhjX6mc0j?=
 =?us-ascii?Q?g8xCCntOeQIi+pmRsnlb2Ndy4S5sDbTFaXUuzRzgljRTdUAogeSOvzwPFLip?=
 =?us-ascii?Q?0/x3Wzj7vZoAPaffTPV7f4u4oIdXESedYGvosMd6WTw5sIOQaTRljubNrvj2?=
 =?us-ascii?Q?xECuurbkLeSPHMXVA2N3UodlGGT6DzwD9nzi41PDhbKznH/s+HZ1yv4G8aCA?=
 =?us-ascii?Q?aQcSnrd1qSe2N/DxGzzg1dDfEqb1o/BNI6lmksJmuKeQR1bA/t9HP+k5BBcK?=
 =?us-ascii?Q?BKPkvPq5C89akHmbOiI=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 12:11:30.5180 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6420db6f-4909-43b6-3717-08de39779591
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR10MB997644
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10:19-20251212, Andrew Goodbody wrote:
> On 12/12/2025 01:19, Tom Rini wrote:
> > While this change was intended to fix a mistake in the code, of calling
> > the ERR_PTR macro but not making use of the result, it seems that
> > functionally platforms depend on the loop not existing here. The TI K3
> > families of platforms for example were broken by this commit.
> > 
> > This reverts commit fe780310cfa8bf5a093894b5cd7fe85c6b02fd91.
> > 
> > Reported-by: Nishanth Menon <nm@ti.com>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
[...]
> 
> Reviewed-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> 

Reviewed-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
