Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C85D3B7F2
	for <u-boot@archiver.kernel.org>; Mon,  8 Dec 2025 15:32:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C10A8838A5;
	Mon,  8 Dec 2025 16:32:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="WcfTL+gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2806E838CE; Mon,  8 Dec 2025 16:32:40 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0ED0E835FD
 for <u-boot@lists.denx.de>; Mon,  8 Dec 2025 16:32:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aw0cquDC018L5gzn+aL9rRnuRa3dhysCqAOwW/6kCNEtRyPKtlCsjJ0tiYhGcISeKLI0w9r7fRYIxNjUX9XR4XCrZvIu2suRcUT1slHxp9Er8ll2qcSvv1E0NGv6i9VqybsdKbRjnK9iwODiu0T/o+zXvxM2N1sE4BWI8WnCaXxBck6Is1w1ETu4FZ+810BUbYNfKb0GKsj7Jg72AbE3HKHkZ5UhyLEGiJehlzhbPGuoqyK6GPydTss68EnSrkxurldxdGCFLNDnLG8KRnWcWO3da8jgAs7XJTWP5cVa/4lzilC3TvHb7VTaKZZvY/t4oUlgvHNlMeZ3anC/Di3Rfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExwkB+I/EAtCGvTO1Z/euqAUcMk/5POD3Y8d7FsIn2c=;
 b=bFWB/5vq4mpZcAZjSHoMN2r0MDzsNbiIfbm/tYbm5DJnUqjsy3L94kLYw376SbXsjsTlOngib055fkcaECjF1G75T5taBRN78X5sJiO6UFx2TmWqzCXtiNAPMkOXcLMp2E1KSHumyF6f+0HuM6H3BKKN00x6pTac+l4dDBjrW5xP0XDx6CNw4butXr4OBHz5MuNGMzAU4RivykjuRzvxdKHuHJYG8G+P6W5Atyos4Irlgk9PurrrfvpeZL1rd/OBLa4ayNwmNHrPf6e8ZaVFUQCJzlF1MTSN7hOx08o0E6ahTUJzRTDPEGU9n30X4mpAEUA4IJNPsMnj8ie8eYQqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=amarulasolutions.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExwkB+I/EAtCGvTO1Z/euqAUcMk/5POD3Y8d7FsIn2c=;
 b=WcfTL+gktj574d1F8spFdtxT/diW790pf3pRBOyJ1MJg8BmQ1eK5676pI64QEvLT08xu/GKeclas+N/4LWD+Zy/fhY622n8plPYaaT3LNjCs9aGZu034QLEXlBlhWoih9MGyrGN+r8xyM5e8R0nikk/ucRcOHrrQvVbsGx/hIuw=
Received: from BN8PR04CA0061.namprd04.prod.outlook.com (2603:10b6:408:d4::35)
 by CO1PR10MB4452.namprd10.prod.outlook.com (2603:10b6:303:6e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 15:32:33 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:d4:cafe::a4) by BN8PR04CA0061.outlook.office365.com
 (2603:10b6:408:d4::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 15:32:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 15:32:33 +0000
Received: from DLEE115.ent.ti.com (157.170.170.26) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.2.2562.20; Mon, 8 Dec
 2025 09:32:26 -0600
Received: from DLEE206.ent.ti.com (157.170.170.90) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 8
 Dec 2025 09:32:26 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 8 Dec 2025 09:32:26 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5B8FWQvh3849756;
 Mon, 8 Dec 2025 09:32:26 -0600
Date: Mon, 8 Dec 2025 09:32:26 -0600
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 "Andrew Goodbody" <andrew.goodbody@linaro.org>, <u-boot@lists.denx.de>,
 "Patrice Chotard" <patrice.chotard@foss.st.com>, Patrick Delaunay
 <patrick.delaunay@foss.st.com>, Miquel Raynal <miquel.raynal@bootlin.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Christian Marangi
 <ansuelsmth@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Marek
 Vasut" <marex@denx.de>, Simon Glass <sjg@chromium.org>, Jonas Karlman
 <jonas@kwiboo.se>, Ye Li <ye.li@nxp.com>, Michael Trimarchi
 <michael@amarulasolutions.com>
Subject: Re: [PATCH v2 0/3] clk: Return value calculated by ERR_PTR
Message-ID: <20251208153226.moktyjv3irmjlg6q@lingo>
References: <20251121-clk_uclass_fix-v2-0-74f4ea10e194@linaro.org>
 <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <176503025989.2523567.16347058613411695182.b4-ty@konsulko.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|CO1PR10MB4452:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c3721bb-1ce4-4ce2-7c1f-08de366f01bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|7416014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h0YcHHIWolC9Gqgyv2SK0EDSSL4TfJhpyD71LgKHRAAwpKgCPS+5jVgS/+m3?=
 =?us-ascii?Q?eSglgNe3M1uyK/VIG3+eBAefEaSmjs/eft3MUr4SRX4e639YRrVGTIwzOEV8?=
 =?us-ascii?Q?reedQ2PUYe7nkKEkImJpG1xeVTN/2lRXDddUqHhRR8EdrBGzaIZ1/8n3a02P?=
 =?us-ascii?Q?zvRKjMIfnL2ib5p2EeL/KQfnwoQa7/Y5DYaB0jK58bVfaTi2DCumatziuW2r?=
 =?us-ascii?Q?tOSR4l1L7fu+qVyykTqa5dFqOJjjlQgmbeJp8Ug0Qv9NNvOf2wzd7J5w8Xhp?=
 =?us-ascii?Q?H/Yd8NX6eoFh6C5utzspfiKu+X1pWL2kjHXaL11NPRSIKRCp1/MzVcrTflxx?=
 =?us-ascii?Q?9UTGCyIHUbq+uxu6+FCbTIiYDFn87EKnB8FihtHmEw1WtA9BJFtHXN+jyTIi?=
 =?us-ascii?Q?R+Ln7av7qC0TSfg+XfOyS2QuYK/j7+arGIyifcxog9LjKEw9yeLR1O2u2FQb?=
 =?us-ascii?Q?uVnNyFUZ1pmrW3NNA5ee2nnxGl2qI7TOaQ0LghciHs5r7iRdNWukgGXYaX4L?=
 =?us-ascii?Q?1tlnn5G4fQvKBs96OktN02hGgRi2mhNcvT+CMAFMoSlheoVxA7lbK0U5Gexi?=
 =?us-ascii?Q?w+w6VMqmBNE6fjINpujEdWl/7hpxDvp6XMzhsUiVSwREshuTh+xzq+pQa1kD?=
 =?us-ascii?Q?WKJF9cL3yjagf0PIyHktQDe4q5OYXRbD8yz+GgtPoWVGRVMMH0Wlr9J3wGb4?=
 =?us-ascii?Q?qx+A2Gqng8B5VL8Xj1928coe5c/UkhJJGhjVCj6ny4DEnGRtf+143CaZLzeM?=
 =?us-ascii?Q?awYsiCDuwRwJhAInimHgW4j04MUMa2wxcd8LDxIy6IHm0a7AtUkX2Mrz5ugg?=
 =?us-ascii?Q?MF/4ek3aG1FIMPn17lFQl53JzZ9/C50RFdENARyIWyyInOzT1isp6xDFMgwz?=
 =?us-ascii?Q?HFeSgOii9XzuZGbAf28t/4OFlzSvqQVRG4bQcrGSrlLdqtbZvJwLef8zjq8Z?=
 =?us-ascii?Q?X7qmn1qsc4vdivfhWBvp5N1HO4iKmxosa0vOSQjYtzUP7uVQ199U5ja2HEvR?=
 =?us-ascii?Q?IL8bpjQMMGdiN2aGynyCC6bjm6qvsNi7gZHn+Mmcs3msGXvMFcgQ0gdNPNnf?=
 =?us-ascii?Q?bWKBbHzB7+GT6DM7T7qtwBXJrkwWVtOGWrZ/xvz1NDYxJA9eGURsneMaFWCj?=
 =?us-ascii?Q?2zpGF0DL9XoUHAwo7aPbaUzfc0vk40uFPb6yFnH/rlLIs2f18OfBsvMLCxP3?=
 =?us-ascii?Q?TQ8rw/kYPXEHPvLEChcv9Tovco6NDEBWwRn8q6YJ+m/YpnCrUgD1EJLKHRug?=
 =?us-ascii?Q?2ivGR+JY3PgJSPNwuOBJ7ftjM0uOHfB2anh08GapujU81I1ZMVcmwiHGYl2k?=
 =?us-ascii?Q?RDjzgT8LUUtNbCIK+O1ovYAikVLDyH692SBXSurt8NbUrhAazJKVkRPgJtHI?=
 =?us-ascii?Q?/7yaL1+CWqzEqYiFLBNTVRFHuctj9I97c3qozH5KclEqNSUh6BM8knQ/p4SX?=
 =?us-ascii?Q?BBiW4HUa8jVxAkJZZh5wttRLTFew4OnBkDpOSs09ST6UNBQtnOZ3eXdnTw1v?=
 =?us-ascii?Q?Ki6fS4jYX+RbXHhXpFm0Oktq8rM+465R+MrzXyqxnJqO3c83VQi2yYdjer5K?=
 =?us-ascii?Q?aK3MVqFbKzE9EpexNxg=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet201.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(7416014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 15:32:33.0591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c3721bb-1ce4-4ce2-7c1f-08de366f01bf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.195];
 Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4452
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

On 08:10-20251206, Tom Rini wrote:
> On Fri, 21 Nov 2025 17:34:30 +0000, Andrew Goodbody wrote:
> 
> > Smatch reported an error where a value calculated by ERR_PTR was not
> > used. Fixing this to return the generated value led to a test failure
> > which meant updating the sandbox clock code so that it would still cause
> > the tests to pass with the above correction.
> > Debugging this problem led to a SIGSEGV which is addressed in 1/3.
> > Possible memory leaks noticed are addressed in 3/3.
> > 
> > [...]
> 
> Applied to u-boot/next, thanks!
> 
> [1/3] clk: Prevent SIGSEGV on debug
>       commit: 1c0a46e2918a1ddf42f51449e45077513dd52417
> [2/3] clk: Return value calculated by ERR_PTR
>       commit: fe780310cfa8bf5a093894b5cd7fe85c6b02fd91

This commit seems to have broken TI platforms in next branch.

u-boot$ git bisect log
git bisect start
# status: waiting for both good and bad commits
# bad: [bc1819331ece7aa4e7d0573c9cdacdb8efbdb067] Merge patch series "clk: Return value calculated by ERR_PTR"
git bisect bad bc1819331ece7aa4e7d0573c9cdacdb8efbdb067
# status: waiting for good commit(s), bad commit known
# good: [384d3785df4dbe452f9fbb4bd9c9c9e986cdc205] Merge patch series "led: remove unused legacy LED code"
git bisect good 384d3785df4dbe452f9fbb4bd9c9c9e986cdc205
# good: [1e8eff6d7a9ad2c605185e5b3d8c22ccd26733dc] board: ti: CAT24C256WI-GT3 require min. 5ms delay (tWR) between write/read
git bisect good 1e8eff6d7a9ad2c605185e5b3d8c22ccd26733dc
# good: [1165e8efcba0ab3efd1ea4ff956d26746fc386b0] reboot-mode: Correct macro name from U_BOOT_DEVICE to U_BOOT_DRVINFO
git bisect good 1165e8efcba0ab3efd1ea4ff956d26746fc386b0
# bad: [fe780310cfa8bf5a093894b5cd7fe85c6b02fd91] clk: Return value calculated by ERR_PTR
git bisect bad fe780310cfa8bf5a093894b5cd7fe85c6b02fd91
# good: [1c0a46e2918a1ddf42f51449e45077513dd52417] clk: Prevent SIGSEGV on debug
git bisect good 1c0a46e2918a1ddf42f51449e45077513dd52417
# first bad commit: [fe780310cfa8bf5a093894b5cd7fe85c6b02fd91] clk: Return value calculated by ERR_PTR

Confirmed by reverting the commit. Looks like
9ed8fafbcde3425d8817ec5953edd428c7508153 revert is needed again?

> [3/3] clk: Prevent memory leak on error
>       commit: 33285945518731ed459680ffb01891c4804fb6c9
> -- 
> Tom
> 
> 

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
https://ti.com/opensource
