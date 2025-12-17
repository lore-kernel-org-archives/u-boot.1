Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F873D65C7C
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 16:45:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A96A483B99;
	Wed, 17 Dec 2025 17:45:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=foss.st.com header.i=@foss.st.com header.b="KC6pX2iV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12F783BC7; Wed, 17 Dec 2025 17:45:38 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C17F83B32
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 17:45:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=patrice.chotard@foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o82nBZxv8MxoiBpZlqhdGelusKJ5QP9gMhoY32IZugbg4e1jGPUiJ22zA4xboBy4UotcFbt/t4djM9w2CzrdxjdmR/n4fNpyDXLy6kRVRsluDioZKtVe73QrQxp3oZs9wiIQcUc2wUWFmODMjsn44c7tA/iHXzCd/u5+Pye3eDOh24sxARdlG1H+3kb96XW1xVjn6MJCkT5Efo2aVM9fe/CCMmI7H4Tq8uhxwHxhcYhrmagMMhHmzWmniZlbqvFYkvnDi1u5TyMhwZ9jB5QkHEWVKndOW6rznw6D4oSaS1XB5Lt6YFJC5Lzj/UubW+9aLWLOj8FLuQdKR90Ce4LaDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLCfmHT2BguxHOBBfpThfyZDPmGZ3nItYu9DsaERnZw=;
 b=I8mXbTomvSwHVaN48/ZvBPyIczXfyMLFoPruYaAjecP/bJYrVviSq34xWCzdNrH5xaA+vXvQnemurikjb7IQfwRXoVqaMhksRiYqDdfN+WrqXHTEKwhxgbj+/rkvmOT2bm5VpngaA3CmkOr5OAW3MPHZ8K/Ji8qlVcY4ZFBcWC2/CfNNYt9nGbBzIFS/jmAMTyUqa0nD+BaIu2edkN8n6iIFO3g+oKKnSm6xvv8ZDXvdDiNxs6YLJe13FMf1uI2VSPVHhq5EUDGmgs/Z602yZb3PRCeptS43d9/pWkzZoQk1FSg5x7U7HBxL3W9pQgG77KOo3TXPrNSJTF9SihiyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=mailbox.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLCfmHT2BguxHOBBfpThfyZDPmGZ3nItYu9DsaERnZw=;
 b=KC6pX2iVFooHkNinQH22QS64H7Hk9VVj+Vo6cdW5Eo/3E3lHtHzGYA8UjlZTavdt2hmXs6OSaoA6xTOGkm+H7JxxPVexfaljEaHiPAL2QWo9tbWLzwxy6pRvMZPOhuby4K1rxjuqmIDlvWJEFCxecyxNdgOUjv/UP2bpKcNZaUNiT9ocgRdieb/khAFDvIxqYQN3NtYxFvzhDjyxHlwfJLKcHy5qgQa6TUWHRYPhZC66I5h1pziNUEPVE+yvG0rh/2MgZO/nsGIaP3HHW+M/cZalkKbxDFO9CVvyUrbvGqU4bRHFHLrX5oCnMiCo99aGCDoC0pOWNEf0Y6pxGb1qxA==
Received: from DU7P194CA0008.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::25)
 by VE1PR10MB3822.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 16:45:33 +0000
Received: from DU2PEPF00028D10.eurprd03.prod.outlook.com
 (2603:10a6:10:553:cafe::37) by DU7P194CA0008.outlook.office365.com
 (2603:10a6:10:553::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 16:45:31 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.60)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D10.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 16:45:32 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:46:17 +0100
Received: from localhost (10.48.87.93) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 17:45:31 +0100
From: Patrice Chotard <patrice.chotard@foss.st.com>
Subject: [PATCH v3 0/3] clk: scmi: various fixes
Date: Wed, 17 Dec 2025 17:45:29 +0100
Message-ID: <20251217-sqqs-v3-0-f3405fb2ad1f@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACneQmkC/12MQQ6CMBBFr2Jmbcl0oCm48h7GRYFWupBKhzQaw
 t0txIW6fD//vQXYRm8ZTocFok2efRgzlMcDdIMZb1b4PjMQkpKEteBpYqHruupb11fOaMjXR7T
 OP/fM5Zp58DyH+NqrSW7rXyBJgYIadKiaypbYnl1gLnguunCHLZHoS5Pqo1HWGiOVIUJNrf7V1
 nV9A3UJhdPRAAAA
X-Change-ID: 20251208-sqqs-7884dbfd4fa7
To: Vinh Nguyen <vinh.nguyen.xz@renesas.com>, <u-boot@lists.denx.de>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, "Peng
 Fan" <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Alice Guo <alice.guo@nxp.com>, "Patrick
 Delaunay" <patrick.delaunay@foss.st.com>, Valentin Caron
 <valentin.caron@foss.st.com>, Kamlesh Gurudasani <kamlesh@ti.com>, "Patrice
 Chotard" <patrice.chotard@foss.st.com>
X-Mailer: b4 0.14.3
X-Originating-IP: [10.48.87.93]
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D10:EE_|VE1PR10MB3822:EE_
X-MS-Office365-Filtering-Correlation-Id: 499fd4ca-492e-41c4-26a2-08de3d8bb1db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWFSV0ZaSHBOMU1mWmRzakZlUkZJenU2UkFuQnZNaUY1bTNhWm11V2JiUFB4?=
 =?utf-8?B?NUp6QU0yM0xOc1gvUzFjT0RjSU51Z3JUVmdiUzd3dlpLakNzODZudXhJLzZT?=
 =?utf-8?B?TFIwUXhjeG9sRFZQeUxTbzVyeUVQcUNyVmNLcUdFR3k4cHJmQU1pZHl5aUpR?=
 =?utf-8?B?NFJ4MVBuV0E4TWtOc1lSZXJ0NGl4YXNWNHo5UjhGOStFSWlFOGJWZG1vYXYx?=
 =?utf-8?B?UTJPV0xUWEZCWjNZd3ViQkZwa0Nhd1VoY1RvTWVBeFB6c1dSLzBhYThMZXpG?=
 =?utf-8?B?eHoyN1VHR3RuZk9pcjFTZXZUdXp4aEo4cVIzUFBEb0F1cmV2KzE1REtSSWxL?=
 =?utf-8?B?VktnejFCd3RQMkNaNCtEb0V6VVF6SDE0Q1ovcXNQekYxUGp5M2F1VkZZS0pX?=
 =?utf-8?B?QS83Ny8xS1ZnUVdRZjgxTmJTeWdsbnFUeXdOc2VuYUcwRTJ1Y00wSEJ0OE5t?=
 =?utf-8?B?U1RKbVdpRE5oWGljTURrM2ZrYVNlVCtjMWU0QTQya01jS2tyelZrTWJuQVJz?=
 =?utf-8?B?MG5YN0pqRkpKR1RvZkVvYjhKVWhwUzV1SldJWFlqMktEM2F2S2NvUnFmRUtJ?=
 =?utf-8?B?WGRuSEFVcUp6aTNqckhpbnhHRS9aVXVSc3o5c0NrZHNPbEhaSm5CeFpOUHM1?=
 =?utf-8?B?RXErTzAxZGpvRXd0Z2F1bmVJc0dpQm0zQm5sVFRSRDkrYjhZd1l0UFF6V1NH?=
 =?utf-8?B?a3RHQUxKM0ZyZkwxUUhWMTVSVWNLRjNzblZzWHVheEExTFUzK3J4ckdZUmcy?=
 =?utf-8?B?T0dyRUZnNkcyUTBHd0FFWW5PRVlsSjV2OUtqdmR4YmRHUjgvQThONXVrVGNS?=
 =?utf-8?B?KzVnak5XQUd5Mm92V003emhBMjZiM3hreFkybHJLdzBxMjc4OElQY0NxZ0Nz?=
 =?utf-8?B?LzNOdCt4bzFzRGxDdXBMdW1YSkkyMmNTK1JsV1d4dmpSbFZTaVpOTTFubmgr?=
 =?utf-8?B?Z0FrUVRrb21xVWxOTmpGWkV2L0FQRDNKSzNvb2FSN3VEQnJzcldLa2E5ejY5?=
 =?utf-8?B?U0NVRG1MTG50V04zK1BneElEcUVGNUZKOU9rVkgveDBPOUxuZGRwaXBaa3Ju?=
 =?utf-8?B?NHM5dXRGUGJ4c0Roa2YxMFM2RmNHV1Nqb2V0TVRmQlVMSENMVzJVY2N5enN6?=
 =?utf-8?B?Z1crTDVtcDZUOFM2Q2tjZDIyYzdpcjkra1p4Tms3NWVmUDFhb05tbUZMbGUx?=
 =?utf-8?B?eHZNV21oRjd2d0laQnZNbXMxOVZKOWMwK0pNVGxZbGtQVThoKzRYb3RsRFNh?=
 =?utf-8?B?NTVMdnVsdCt0aGdrUXBRSHMzSnJrdVZxS0lVT0dZN1NacU5FeCtvaDlyUTMy?=
 =?utf-8?B?c2xRT1dJSVRSK0FoMVNZS1hRbDRQUTZsenN0Q0QyU2RIZXVaU0NNWjVPVEUy?=
 =?utf-8?B?LzhoRk9VWHo4RDRNV3ZFamVFNjJQVjZXQ3JXZWUzL2NpMjJjZkZvT0Y2Uk1N?=
 =?utf-8?B?b0hGN0RjRW9FQUZHbXVtcTFGQnlPYkQvZENyZEpaY0szYWEzSnBONzV1ZytV?=
 =?utf-8?B?TkxENjFCdUlraFJGb3ZaVzh6UWNkWjVSQm80ajkvMXlNdkY5ei9oSzVOTThx?=
 =?utf-8?B?UVAxNlY5Y1NvclNaU0docjNDc1ZiN0ZaNWxWMnQvalhBbXEra0FHNEFLdDVx?=
 =?utf-8?B?dEliRGJoUm9wQ1BTYXhJRVVXQVp4ekFON08yelFxaEFqNitwZ2Vtd1FKSUxR?=
 =?utf-8?B?NzBiaGkxTGVmSzZYSmx6Yy90NE15UlAwMW5zTWJ6d2poa0M2STVvR1JJV3M2?=
 =?utf-8?B?R3gwckZHRElqTlBKbklLQzNnMHZrbWVpK2lha2c2REhIaFRoMFRIWWlDbTJP?=
 =?utf-8?B?dk45T1cyS0FaVU9qWFJKSU5IYmIySmpuRjhiSmtZRzIxQzkyMnJFZklXWXFG?=
 =?utf-8?B?N1RVejZ1SmhKYm1rTTN6SE1tQkgvUnlxbEhHRUJBY1liUUMzMkZFbXdoSFFM?=
 =?utf-8?B?ZzRaV2FId0V3OUVKL0E2b1dpankxczFQUGJpeVVmdGo0aFUvRFIwWkFBYjFR?=
 =?utf-8?B?OWZzcE96cUZ3NTErVE1CQUpOcGlZbUJyMmJQSzhIS0d3SitrTUN4MnBBNDVV?=
 =?utf-8?B?Y2pzSHJGTVdFN2tJRERXdzNYejhSU1pkSng1b3FaME1OLzVHaG5wRHFieDNj?=
 =?utf-8?Q?LLFl+pC2wxo2A5VhJQxcwHM4D?=
X-Forefront-Antispam-Report: CIP:164.130.1.60; CTRY:IT; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:smtpO365.st.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: H4KeS7P35d+FNt3stGlpSH7wWDrrW9snLo5ovL9pf2QNhFhcrjqe1/rdjMX/wUL4CA/rujtd84U/xpF31iz/7qTDjoqR4/Um47NV/yljg9R+pciUkc7Z+toW7yYtf3mm6SPU146oH87Jsye9waBzUeX1jO1yZKVDyYk/u0yBGv46XaLn9HKyH/gf9NTswrKbZ0teHSYEjOrUKREI6I4M7/wLtNZsD1K8r3zp1JP0khQXpE8N/jDcOstgq7dH8vZOxTmTPBMrWYaLNYiWF67aqvWSM3yrM3exVi2BOGsdUTK9aF1WPHSK9fmzYNeigZT1brM1VzgHuTlaE1kAZgVY1I9+4FHGnNR31xIiRtoI38+LVncnyT7SgqTEV00US0+N3VPZ6Z7oJGitto96QNgCnlBDAdL2QocjuiRBRZEKi7cuPy2YVJRpgo2EOE3aCj4fdJp7x7gtQaaCuJM7uUitFnIui1/9vEMBUguNGxQtXOdsV0gDDiCkj0Qcz1+yneQwXKTnQr/1lLF8S9T2O/8FUXZPcFNCjWTy8DQKIRcemK1ARfq8m5LWFpVV/kN3Ok6Y2FvW7/MmisUiHFT6CeBY5VuI+2tC1DJ/9D2xo+DlO4Ww75N+g84IfMM+k8q8t5WgmLkfACiuKLd+UKRCrqCSXyNnu6/G9RIbwoWDrqaauk5wHcel27U1bC9SRuWtHJMWtDivQ/neUbMqyOwdl3xIqQ==
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:45:32.5767 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 499fd4ca-492e-41c4-26a2-08de3d8bb1db
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f; Ip=[164.130.1.60];
 Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D10.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3822
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

- Fix typo scmi_clk_get_attibute.
- Fix priv initialization in scmi_clk_gate() which leads to
  clock_enable() error when CONFIG_CLK_CCF is not set.
- Remove duplicated scmi_generic_protocol_version() call in 
  scmi_clk_probe().
 

Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
---
Changes in v3:
- invert CLK_CCF conditional in scmi_clk_gate().
- Link to v2: https://lore.kernel.org/r/20251215-sqqs-v2-0-9a15a22072b7@foss.st.com

Changes in v2:
- Add Peng Fan's Reviewed-by.
- Add comment in scmi_clk_gate()
- Link to v1: https://lore.kernel.org/r/20251208-sqqs-v1-0-290f0594e30b@foss.st.com

---
Patrice Chotard (3):
      clk: scmi: Fix typo scmi_clk_get_attibute
      clk: scmi: Fix priv initialization in scmi_clk_gate()
      clk: scmi: Remove duplicated scmi_generic_protocol_version() request

 drivers/clk/clk_scmi.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)
---
base-commit: c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9
change-id: 20251208-sqqs-7884dbfd4fa7

Best regards,
-- 
Patrice Chotard <patrice.chotard@foss.st.com>

