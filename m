Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1AA2C5B559
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 12:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22D0E80050;
	Wed,  4 Jun 2025 14:16:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ikThl4KE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B28F480AE1; Wed,  4 Jun 2025 14:16:45 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20723.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::723])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C4C780050
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 14:16:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=M.Schwan@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gztgmwVpTuXgNc+1UP+Qxg8ravbNLglh98VJ0FAHTmurm/8HUF7KALkSvHGd93DNqgOjx2rm6Ev1XiAXLISglfW+PAHVJvt/U6wuBfI8W/YVlXzzUTzzzbO57P1SvevWVoRd1BZY5gDIHqJmAbiqaOYmdWqvxO0NMkoxBZC3Lpe20CGlSa21iASuxVsR5zXjpK/HJQkr1753a6uMsYH2Jfdj9wKuXHaB2CDcSrqVHilkwOHwnXjw0VTuvQbhbD/f8tjPlD3Z4k8LnqAy4HoaApLGXGaafH98A828mwI3TRAN9mjmdfz7elcho0jj9R8lJGGjCGm5J9I5gB2ixncfpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibbB5xcU88ZPs7qmNZ/6WAiew35er7iHkvuVn2sKqlo=;
 b=nb6SiDcme1GLlaSxOFXnZd1eSDtyf9rPinDu/PQA6mP9kLF/OtGUvxVovq1KZlGPKJC2VergnlFLD9x1UcVa7VvuS42c1X8WEk4HEthZwO/T4E0Ej+CmH2UtaJzPlHlZsL9S9EPcSf4CLSoDfVLmfHrQIYTrytrm1CGwJPPJaN4w/bz19JOT9YIiSxuOlnFaMiiWnHH1GplwbMRQcc4CaRvr93qIsWUIB3gKX36R834EvrWgi8bZyOfTcn3CgZVmDBUIjYgh6Dr7L5IAF/bVrvwmaQx0hUNnWFiW5XGLa7oASp/Z7pDLluf+LR0bRbQwzoiTps1w6/n7TIO/9ppT9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=chromium.org smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibbB5xcU88ZPs7qmNZ/6WAiew35er7iHkvuVn2sKqlo=;
 b=ikThl4KENQVU10J4vhnbv/ot11RJKU9KyxK9OklghaMn1hnHJJvKABFotPE86rAfXySYLfVsYE9V14APEzsBzipbm6lbjYeRxGYrukz1/gKEXT9D5ofSm1X3WHSws/DjndcI/WAHs3omp+roLpSbEM72iSUeKtyBIvV4Zb9+YRtzb6qJgrB+FNP0V/tVru080FHLt+rY+z6ByKS+dENtjumDmfXkPuq78saz/z7Yi6gqoyn7EVHb8BKYopmz6/HV2fdVMxCgOnKM+nxb2yo7tfQdx4+mCZQ71k4lMkBCGviWACJcQ79LafRVU2cC07PPw3ikjBWHNTqypukQR3mJ0w==
Received: from PA7P264CA0182.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:376::16)
 by AM8P195MB0978.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.33; Wed, 4 Jun
 2025 12:16:40 +0000
Received: from DB5PEPF00014B93.eurprd02.prod.outlook.com
 (2603:10a6:102:376:cafe::c) by PA7P264CA0182.outlook.office365.com
 (2603:10a6:102:376::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Wed,
 4 Jun 2025 12:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Diagnostix.phytec.de (91.26.50.189) by
 DB5PEPF00014B93.mail.protection.outlook.com (10.167.8.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 12:16:40 +0000
Received: from Florix.phytec.de (172.25.0.13) by Diagnostix.phytec.de
 (172.25.0.14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 4 Jun
 2025 14:16:39 +0200
Received: from lws-schwan.phytec.de (172.25.32.87) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 4 Jun
 2025 14:16:39 +0200
From: Martin Schwan <m.schwan@phytec.de>
Subject: [PATCH v3 0/2] bootstd: New bootmeth for RAUC A/B systems
Date: Wed, 4 Jun 2025 14:15:28 +0200
Message-ID: <20250604-wip-bootmeth-rauc-v3-0-f9fad913c57e@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOA4QGgC/33NsQ6CMBDG8VcxN1vTXgGLk+9hHIAetoOUtLVKC
 O9uYdHBOP4v+X43QyBvKcBpN4OnZIN1Qw6530FnmuFGzOrcgBxLLrBmTzuy1rl4p2iYbx4d47I
 tCbVWqi8g70ZPvX1t5uWa29gQnZ+2F0ms139aEoyzSnJFR4m9FMV5NFOk7qAJVi3hR6g4/hIwC
 7VGqQqR96r6FpZleQPb3D6Q9AAAAA==
X-Change-ID: 20250129-wip-bootmeth-rauc-03b5e2dd88f4
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>, Wadim Egorov <w.egorov@phytec.de>, Martin Schwan
 <m.schwan@phytec.de>
X-Mailer: b4 0.14.2
X-Originating-IP: [172.25.32.87]
X-ClientProxiedBy: Diagnostix.phytec.de (172.25.0.14) To Florix.phytec.de
 (172.25.0.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B93:EE_|AM8P195MB0978:EE_
X-MS-Office365-Filtering-Correlation-Id: 0100eb60-1460-40c7-d859-08dda361a93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEhJNlVwQUZTNStyTkZSRzZ1M0hNNnZnTDgxdHl1L0VXZ0ZNZXFvaFNaQ3Mw?=
 =?utf-8?B?ZHNJQWtZbmswSitGcjZMalhVem5QdzM0eC9jSmxZcklId20yUnRxUW1uaFlM?=
 =?utf-8?B?SGFYVU01V25sM2k3U0hoWVNHbDU1a2VwTHFubjRtWGwvR0paVXVFQkVjbVZz?=
 =?utf-8?B?Wno0YU54UzJLQ09ub1dnS1pCMjF4WU5taWpsNnM1N3VEaHVsS3ByVEwvTzBu?=
 =?utf-8?B?TUh5Z3R4ZGpWdVVRbE1WOFpmSVdNYVdpQlB4SjBtQzcyQnpucko5ZEhKN2F4?=
 =?utf-8?B?RjRUUDFPLzFBdDlScWZ3cDFEQTlYMi8wRXI1ckJpVW9TcW4rb0tUL1pRVktj?=
 =?utf-8?B?OWU0dXpxaTVWZUdtemU3SGkzdS9NV1FnYUkwTWxyY3M1WnJCTXlCdkNMUGQx?=
 =?utf-8?B?aGwwbVo2Nmw5MGxnaUVsR0JBSHpxcUJvNk5TZWZKWjcwRW90cmV2UnFpR0hS?=
 =?utf-8?B?Qm8wZFgySmVKdk5UZWlyK0RJUGYrNzZpL0tBY0Z2eFdQYTB4ME1tby9XTXFR?=
 =?utf-8?B?UTlxcUE1YmxrRnpMUXpLOW1EOHV4UFY2RGJOK2lja1NkWFh3dFQwTE9ralgr?=
 =?utf-8?B?VjUyaU1rNEYxWHhhR01GWm5yQlFndFZ3bVVYVEovK2czUDdvb1FtTFdpVDFj?=
 =?utf-8?B?U2ZFeDg3ODFWYUFKd2NodzBIYm5JZ2RvMHd3Tml2alRRY2xodXBtMGQ0NEoz?=
 =?utf-8?B?QnQ4dmZhY2RxZEVkR0lwYXErNTRwb0VEaVErRW1SQ3RHUnBxZHh1eWFnZWF2?=
 =?utf-8?B?czZ3R2JWK0pReGhRdiswaFJ2Nm5HYU9uSmxpTFhTUzRWeGpJZU9qUjdXNU9o?=
 =?utf-8?B?QzVKRmlJYUFjQTBsS3lIWEhuNnROVXR1dE9XWWw1bWlmbmRObUIwL2VFSW9E?=
 =?utf-8?B?K2JQMURvNUxZeXhvdGlQSFhuUUhxZythTjk1R2Y5YUwxQ0hGQWs0VW9qYkFs?=
 =?utf-8?B?M0xBVnlTMExlYlBQcU80Z3ZPS2pHT2xGMmJmVndxSWpLQ1AwOXh2b3ZNcWI4?=
 =?utf-8?B?dUR1RDR2R0VLVVdiZVBkd1FlL0FQUGpQd0ZKSS93c1AvcUgrbmsxNGFUOEF6?=
 =?utf-8?B?OVJyS25qZjJIOCtsY1NaKytianNGWUtEQWpCejB0S3M5S0NYTjJYTjRNV1Zx?=
 =?utf-8?B?YnR1djVMd2h1Skl5TnVhNmtNcXU2RUw5bFJxM0dST2ZYMEpXeU5KNUk5clFr?=
 =?utf-8?B?WEI2b0RRenYzcjlSMlhTS0ltYi9jOExHTUN2NklFUWRPTXhpNW5GbndaTnkz?=
 =?utf-8?B?b3RpcFkrTGkwUTVtcmp4bUI5eVZWakdma0xhakNEVDFTYTZXVUpzQ2NTTDFT?=
 =?utf-8?B?VitnMUFNZHVCM3VWdGxuYjVhMi9EQmlKQWx0TmJJbG52ajQ4NDcrZ2RQa3dT?=
 =?utf-8?B?dlJVbDkzTVFwN3pkQ0luSHVGcXA0cjFIcGdBTG5qWXp5VEwyTmVJVW1QYzdx?=
 =?utf-8?B?Q1lnUVhGb21KckdNeWJPQW1xWkNiQ2lqN2R4R2RvTnFBK3JubkJLSjIwYldk?=
 =?utf-8?B?YWNnekFFaGxWYmdjdnhQN1BNdHhXaCtNaDBkZnBrdW1rU2NUaGhYMzlNelJ4?=
 =?utf-8?B?Mmg2b3dwU2piK3FCKzlRM2F3bklRdkp5TGp5S2U1bWVhZmkwandKMWxkb3Jr?=
 =?utf-8?B?R2QyRTZMMUNiYVgwTHg2OURQTlE1Ny96TlZTS1I0S28xTGlKQTJVZ0RzNVhi?=
 =?utf-8?B?WENCdEttZm5uNzUyTU9yT1dLcm1hOFZnanZVeC9XR21aOFhKODRaUWRHVFlw?=
 =?utf-8?B?WDJTZ3FiV3k2a3lFT21FeFlXTkQrQVJVOWx3QnBQaS8yalVHTjVMa2YxMi9v?=
 =?utf-8?B?QlVIUjdjMEJCZWNleitxa2RwWDN6ay9MRkUycVE2R3JRNjUvS3lZcksyTWcr?=
 =?utf-8?B?SUZtcHFsUXJHRHZRc1lqaFlFZnZ6YTVlUFZpNzZYVG96RmplNTF4NVhxMUx2?=
 =?utf-8?B?dVA2TW05dFM4bjNKQTJVNC85NnNqTGh3Q2RuWDBpajdMelBYNHR3VTYvcFla?=
 =?utf-8?B?cE51Z1FUZEVRPT0=?=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Diagnostix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1102; 
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 12:16:40.2195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0100eb60-1460-40c7-d859-08dda361a93b
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Diagnostix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B93.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P195MB0978
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

This series implements a new bootmeth for RAUC A/B systems. RAUC (Robust
Auto Update Controller) is a lightweight update client, providing "Safe
and Secure OTA Updates for Embedded Linux". See the following links for
more information about RAUC:

  https://rauc.io/
  https://rauc.readthedocs.io/en/latest/

PHYTEC uses RAUC in its Yocto based distribution "Ampliphy" as the
default way of updating embedded devices based on PHYTEC hardware. So
far, the logic selecting the correct partitions and files to boot was
being implemented in the U-Boot environment. While this is a
straightforward way to do it, adding and supporting new platforms became
somewhat tedious and is platform-specific. The introduction of U-Boot's
"Standard Boot" provided a convincing alternative, promising a simpler
and more portable way of booting, even for RAUC systems. This led me to
implement a new bootmeth supporting RAUC A/B systems. Note, that this
new bootmeth is not proprietary to PHYTEC products and is designed to
work on other hardware with a RAUC A/B system, too.

The bootmeth currently only supports symmetric A/B partitioning layouts.
E.g. A/rescue is not (yet) supported. The partition indexes and default
slot tries can be specified via configuration options.

For now, the bootmeth_rauc uses a similar approach for loading the
Kernel and device tree as the bootmeth_script, in that it requires a FIT
containing a U-Boot script loading the desired distro. It could be
possible to support booting without a script and load the Kernel and DT
directly with this bootmeth, but I found the script method to be very
flexible for now, in letting the distro decide what to load.

The bootmeth_rauc was tested on a phyBOARD-Pollux i.MX8M Plus [1] with
BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2 [2].

Supported boot devices are currently only MMC devices, but it should be
possible to add SPI flashes in the future.

To test this patch stack with PHYTEC's phyBOARD-Pollux i.MX8M Plus
board, you need to adjust the boot files to include the boot.scr.uimg
containing the distro's boot script and set "optargs" to "${raucargs}"
in it. Also disable any legacyboot in the U-Boot environment and simply
boot with Standard Boot:

  bootmeth order rauc
  bootflow scan -lb

Regards,
Martin

[1]: https://www.phytec.eu/en/produkte/single-board-computer/phyboard-pollux/
[2]: https://download.phytec.de/Software/Linux/BSP-Yocto-i.MX8MP/BSP-Yocto-Ampliphy-i.MX8MP-PD24.1.2/

---
Changes in v3:
- Invert if-statement check for setting default value of BOOT_*_LEFT env
  variables. This would falsely trigger an error message before.
- Link to v2: https://lore.kernel.org/r/20250602-wip-bootmeth-rauc-v2-0-9d2384131486@phytec.de

Changes in v2:
- Remove LOG_DEBUG from boot/bootmeth_rauc.c
- Reorder asm/cache.h include to be last
- Do not check for RAUC-specific files in the rootfs anymore. This does
  not work on encrypted root filesystems and is not a stable indicator
  for a functioning RAUC system.
- Add a description of the term "slot" in the corresponding private
  struct.
- Remove boot tries left from struct distro_rauc_slot. The boot tries
  are read directly from the environment, as that's the only correct
  source RAUC is relying on.
- Remove the current boot_order from struct distro_rauc_priv, for the
  same reason as above (env is correct source).
- Add function for retrieving a slot struct, to ease finding the right
  one when e.g. iterating or getting by name.
- Fix multiline comments.
- Fix various if-statements which were explicitly comparing to 0 or
  NULL.
- Free various, temporary instances of allocated string lists.
- Set default env values for BOOT_ORDER and associated BOOT_*_LEFT
  variables. These variables are mandatory for RAUC to work.
- Use calloc() instead of malloc() for allocating the private slots.
- Use config options for configuring the partitions and default boot
  order, instead of setting them via the U-Boot env.
- Use bootstd_get_prefixes()'s return value and check all available
  prefixes for the boot script.
- Add a proper boot order selection logic for the rauc bootmeth, similar
  to the previous environment scripting, with fallbacks and slot try
  checks.
- Introduce config option for resetting all slot tries in case they are
  all zero. This may prevent a system from locking up in the bootloader.
- Rename env variable "mmcroot" to "distro_rootpart", to be in line with
  "distro_bootpart".
- Change the bootmeth flag to "global", as the rauc bootmeth does not
  work for individual partitions.
- Update documentation accordingly.
- Link to v1: https://lore.kernel.org/r/20250129-wip-bootmeth-rauc-v1-0-6308e732f314@phytec.de

---
Martin Schwan (2):
      bootstd: Add implementation for bootmeth rauc
      doc: Add description for bootmeth rauc

 boot/Kconfig                     |  51 +++++
 boot/Makefile                    |   1 +
 boot/bootmeth_rauc.c             | 432 +++++++++++++++++++++++++++++++++++++++
 doc/develop/bootstd/index.rst    |   1 +
 doc/develop/bootstd/overview.rst |   1 +
 doc/develop/bootstd/rauc.rst     |  56 +++++
 6 files changed, 542 insertions(+)
---
base-commit: b22a276f039f818d5564bec6637071cfc8a7e432
change-id: 20250129-wip-bootmeth-rauc-03b5e2dd88f4

Best regards,
-- 
Martin Schwan <m.schwan@phytec.de>

