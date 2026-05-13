Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06F7CD4851
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:19:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B328583EEF;
	Wed, 13 May 2026 09:19:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VddvVONO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68EF48466C; Wed, 13 May 2026 09:19:22 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0624F845C8
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:19:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JIaNHI9IuR/TmPPXT+LarZn+9EKwa5ITJ3l8iY5/a1PSZtVwBL/+NqHFAsjmXvjLwI2q89cGAQDJZM7Y28MGoCZ5jwa/ezHR8FAynAxzuW/hGfIlk50mNfbp/IsyS2DW3RhgACp+WOaLt8T1e7nYJeQOKgCbIi5O9HvcAeRTAMVb88tsP0dwl658jZhAwrzqgEIIu7bt5jgs0XuORbp2HgeyPjEksxUXraEVblPAdH+WmBGv/hGasC3yh1rIGdvaoh24fRVvj0PDtgtkQ5jBFDlw7/Qk8wYkj+wwMF9mh2efZC9ggf1K5vYLc/FFTQudjZvXuArBxur7r9zOThQNyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StOL7jdciILekJGQrUzX+tiYn4gyuj8I+XRT6kpCkUg=;
 b=JtFgCHKdHgXGNIrUPwo1cAfMOKKkMJghRDX3n6H2JhmsVDfQ9a+d3U+a0AzQIsQ91hjw1P/jqeNWReLoMhop0LR/InsgT3bhvXMDEEeyIzv9HCcBchv6mA7GrPahMHFzYtHR66x4nBb83yzdDwWD7Mby6SOUOwFQeFfISgfd7fTm5pl8S4Nuk+NeRyLlNwBPgtjjdSIbJmMIYidDs03uyrAeNOyadl6XlVB2iMwZNe3tCUtlNGzsiz31tgtX9sIYDfbkixytidru5DJHMEjCm3wxZ8cX/+s9SeQYeL4r5b65kyKnKYepEF0vOUrRH0aa97tg7OT8J3eNASZU0LIFWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StOL7jdciILekJGQrUzX+tiYn4gyuj8I+XRT6kpCkUg=;
 b=VddvVONOYgBCokq9WTlw2NVuN3t1WM3k4zAApTwjB77A12sRYLJMjiMCgVmDBAaehWfh4vSo5XYvMewULXSwYG96fVDvBBRzwm3Ap25xhvQ7J3dtGGsXtcMULncpSJDvVCHKP7TtD5vO7opZPyY5UdzuxxZTk4pBJ/Z8Jp98TiV9DM3MwnYca20+9hOkNuB5gmLKV7vNnXghb97aLnlSJcuEcJHZcfsgtLJKUSzFdyNKGyOQPUSwDDoNEXkBYGuicLVNoPv5C5QXLdBD0DCIGFAdVX8+lZpyQMe74wrvxCESgtz4ofV1+LuWlnWzt+AtEW+y85YYMPJIKXvd4lI6+g==
Received: from AS4P189CA0057.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::6)
 by DB9P195MB2727.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:5eb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 07:19:16 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::ff) by AS4P189CA0057.outlook.office365.com
 (2603:10a6:20b:659::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 07:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:19:16 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 09:19:14 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.haller@phytec.de>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <m.schwan@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 6/7] doc: board: phytec: k3: Document boot flow and watchdog
Date: Wed, 13 May 2026 09:19:04 +0200
Message-ID: <20260513071905.83522-7-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513071905.83522-1-w.egorov@phytec.de>
References: <20260513071905.83522-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DB9P195MB2727:EE_
X-MS-Office365-Filtering-Correlation-Id: 14fe1392-b9a8-40df-445b-08deb0bff163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003|11063799003;
X-Microsoft-Antispam-Message-Info: sn6ukMASPUspXsS77JGs9750jkm78sL5seBssvmtIFJgpp4UmbG1kncYbEC/2/UkOUG58JCTtNp51EbmNeeK9Bw+fTDPBWYKwQoFCDDxQad4MRFGeA8JzD8Y9EhLMWO3p+hUG1grCQ+rsKE8UxCBH8i46w1nlqXGGTiS6VK9rXiZ7olHFamNQAXDJUEuU1FiRcBraPSyjuaSRZ20tJjH0H/eD5Znwuv53N8NDPI+iAUO4OafYc4GI7NKUCiPp8P0CTIhMz1SNsYSydTv7/Byi8xp0KO/cgGbQrRmhIGCEKUvcAYsoqQWJKUpB25gohcDELeATZtHjuxCnwUWqU72J05a9LLZYD/SmX8wZy5np1/5jC2CzZxqoAbTV9lt9oYjpmCvZhGr6hiaJrJjcQvkbt78ljCALn/pHDpc8kqkq2DLFsPeQoyYHLk1NucbUicTnzzcnrmZQmfbR1K1xwte6ZwmAO1KSMf0S3YYep4DpAKg/SD++dvSKvWulc0h44IIMvml6GKlpUv+Q570rl/ksFWnltJjf04GziMoyXtqMcRHp4CQ864IdXDnsGy/0z+L8T0/MQhhLnoSMuEwz+hsAx9sZBLEtNmXznFYU4dHL8tb5iEdC2HuNfyp9zQA6pnRdAWG003Md/8kMoZ7ojn4u0Nbr3dnBauYG/zWYuB5oo4mO9elLZKymh1rnhKACWUpxXImyXyJuT0AI0EZ9gqJVSiwCTBOKykMwdgsKU987kk=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vNcghH52k/XN/VhLEmlomrkatoYjGRmA2/H9nbZmqpODJuP5LCdF0CaXwJ2JvUiBU5bIqg6n8o6hENUX/m3KOJ6KTuhs+3RIfjFJK9pAQvynhCJx4cJGmpBBhWNn7blAgVfmfeMht39yp7KpWzHyy8BlwdmZtEQRV96KbtZQ8RpUXCZzIzkr7zT5BPtC69pX1+bn49IZQWUQOEfkUiCTeWQkWTcGqWVSk/1EoM3IzQlzfehLttvDEcQ1Avp1b/9wjxErtWqLBU+1LR3x6+g1ppg7sirGkULX3c8jphARiaFsAYb6bbhyCzWEEfkiYqiEDnGtH2nEWCKrjRMv/QgrKmBhlhEBcUP4UDA6/mpKj1DmgGRx4nRI/6zt8CqUnThlUYBf8arViKU9m22vIwoUnabqIwCzpjgU0LtCyd7pcnjiYb8Dj7iPFkV1CuDBXEF5
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:19:16.7773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fe1392-b9a8-40df-445b-08deb0bff163
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P195MB2727
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

Add two short sections to the common K3 phyCORE docs.
Describe the default boot flow and its deprecated version.
And write down the use of the watchdog.

Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
---
 doc/board/phytec/k3-common.rst | 47 ++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/doc/board/phytec/k3-common.rst b/doc/board/phytec/k3-common.rst
index ffb50b51ad6..3adb176ea8a 100644
--- a/doc/board/phytec/k3-common.rst
+++ b/doc/board/phytec/k3-common.rst
@@ -1,6 +1,53 @@
 .. SPDX-License-Identifier: GPL-2.0+
 .. sectionauthor:: Wadim Egorov <w.egorov@phytec.de>
 
+Boot Flow
+---------
+
+The default `bootcmd` performs three steps:
+
+.. code-block::
+
+  run start_watchdog; bootflow scan -lb; run ${boot}boot
+
+Boot devices are scanned in the order given by `boot_targets`:
+
+.. code-block::
+
+  mmc1 mmc0 spi_flash dhcp
+
+For each device, U-Boot tries the boot methods listed in `bootmeths`:
+
+.. code-block::
+
+  [rauc] script efi extlinux pxe
+
+The `rauc` bootmeth is only present when `CONFIG_BOOTMETH_RAUC=y` is set in
+the A53 defconfig. RAUC slot selection is handled entirely by the bootmeth;
+no environment-side configuration is required.
+
+The legacy `${boot}boot` chain (`mmcboot`, `spiboot`, `netboot`) is kept for
+backwards compatibility and prints a deprecation warning when run. New
+deployments should rely on the standard boot mechanism (`bootflow`) only.
+
+
+Watchdog
+--------
+
+`bootcmd` runs `start_watchdog` before starting the boot flow. When
+`CONFIG_WATCHDOG_TIMEOUT_MSECS` is set to a non-zero value and the
+`watchdog` environment variable points to a watchdog device, U-Boot enables
+the watchdog with that timeout.
+
+After this point the OS is responsible for servicing the watchdog. If it
+does not feed the watchdog before the timeout expires, the SoC will reset.
+Make sure the watchdog driver is enabled and configured in the kernel and
+userspace before relying on this.
+
+To skip the watchdog start, either build with `CONFIG_WATCHDOG_TIMEOUT_MSECS=0`
+or set `watchdog_timeout_ms=0` in the environment.
+
+
 Environment
 -----------
 
-- 
2.48.1

