Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD89FED2FC
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 09:58:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A91184181;
	Thu, 12 Mar 2026 10:57:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="EQTuLo7V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70A928415D; Thu, 12 Mar 2026 10:57:41 +0100 (CET)
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B703884178
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 10:57:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Max.Merchel@ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=bhYTzeRvjr0W1Z4ZIfNjaSeSJF13e3t/1puop25HwEg=; b=EQTuLo7VhPM9UUqO4GEbHonDfd
 1Lu4CWd987IlpFTgqjNGNqxt0c7+zTUZ8wop8QgNqSzka5E68ICtUDg+J37/5vnreukotcaJLOXU9
 Vo+m8ICoHDsQJyPjDFG8zcmz9exQNW3PmtLpuMW4IJs+Qiigz+b3v6nDivfyVTXVV8JEDIs/6qsi4
 /gEBdohWbLii5kpv2AXou48qfJ5BOsIrgBvlrc6Ahn5IKm/fRkkb0Hf8Ptsj8udTMyWomXQhJjZk5
 v15DC5spt9f4sy8eCfiaJSBpl9HARZtHtUSMtHFhCSLYeVj7qJjqYPZhKyAS5I2SQqTp/LGRleoO0
 5HP4etKA==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnQ-0007xR-32; Thu, 12 Mar 2026 10:57:36 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy07.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1w0cnQ-000Fyo-1n; Thu, 12 Mar 2026 10:57:36 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Cc: Markus Niebel <Markus.Niebel@ew.tq-group.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Max Merchel <Max.Merchel@ew.tq-group.com>
Subject: [PATCH 03/13] env: tq: add shareable environment settings
Date: Thu, 12 Mar 2026 10:56:59 +0100
Message-ID: <20260312095711.3219756-4-Max.Merchel@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
References: <20260312095711.3219756-1-Max.Merchel@ew.tq-group.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Markus Niebel <Markus.Niebel@ew.tq-group.com>

Prepares moving boiler plate code out of board confguration header and
prepare to share a lot of things between boards.

Signed-off-by: Markus Niebel <Markus.Niebel@ew.tq-group.com>
Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 include/env/tq/mmc.env           | 82 ++++++++++++++++++++++++++++++++
 include/env/tq/nfs.env           | 51 ++++++++++++++++++++
 include/env/tq/spi.env           | 23 +++++++++
 include/env/tq/tq-imx-shared.env | 38 +++++++++++++++
 include/env/tq/ubi.env           | 47 ++++++++++++++++++
 5 files changed, 241 insertions(+)
 create mode 100644 include/env/tq/mmc.env
 create mode 100644 include/env/tq/nfs.env
 create mode 100644 include/env/tq/spi.env
 create mode 100644 include/env/tq/tq-imx-shared.env
 create mode 100644 include/env/tq/ubi.env

diff --git a/include/env/tq/mmc.env b/include/env/tq/mmc.env
new file mode 100644
index 00000000000..abf561f8467
--- /dev/null
+++ b/include/env/tq/mmc.env
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ *
+ * shared mmc environment for TQ boards
+ */
+
+addmmc=
+	setenv bootargs "${bootargs}"
+	root=/dev/mmcblk"${mmcblkdev}"p"${mmcrootpart}" "${rootfsmode}" rootwait;
+
+get_blockcount=
+	setexpr blkc "${filesize}" + 0x1ff;
+	setexpr blkc "${blkc}" / 0x200;
+
+load_mmc=
+	mmc dev "${mmcdev}"; mmc rescan;
+	load mmc "${mmcdev}":"${mmcpart}" "${kernel_addr_r}" /boot/"${image}";
+	load mmc "${mmcdev}":"${mmcpart}" "${fdt_addr_r}" /boot/"${fdtfile}";
+	fdt address "${fdt_addr_r}";
+        fdt resize 0x100000;
+	for overlay in "${fdt_overlays}"; do
+		load mmc "${mmcdev}":"${mmcpart}" "${fdtoverlay_addr_r}"
+                        /boot/"${overlay}" && fdt apply "${fdtoverlay_addr_r}";
+	done;
+
+mmcargs=run addtty addmmc
+
+mmcboot=
+	echo "Booting from mmc ...";
+	setenv bootargs && run mmcargs &&
+	if run load_mmc; then
+		run boot_os;
+	else
+		echo "ERROR: loading from mmc";
+	fi;
+
+mmcpart=2
+
+mmc_finish_update_uboot=
+	mmc write "${loadaddr}" "${update_start_blk}" "${blkc}";
+	mmc dev "${mmcdev}" 0;
+	setenv update_part;
+	setenv update_start_blk;
+	setenv blkc;
+
+mmc_prepare_update_uboot=
+	echo "Write U-Boot to mmc "${mmcdev}" ...";
+	mmc dev "${mmcdev}"; mmc rescan;
+	run get_blockcount;
+	setenv update_start_blk "${uboot_mmc_start}";
+	setenv update_part 0;
+
+mmc_switch_part=
+	mmc partconf "${mmcdev}" update_part;
+	mmc dev "${mmcdev}" "${update_part}";
+
+mmcrootpart=2
+
+update_uboot_mmc=
+	run check_ipaddr;
+	if tftp "${uboot}"; then
+		run mmc_prepare_update_uboot;
+		if itest "${blkc}" >= "${uboot_mmc_size}"; then
+			echo "ERROR: size to large ...";
+			exit;
+		fi;
+		if itest "${mmcdev}" == "${emmc_dev}"; then
+			run mmc_switch_part;
+			if itest "${update_part}" > 0 ; then
+				if env exists emmc_bootp_start; then
+					setenv update_start_blk "${emmc_bootp_start}";
+				else
+					echo "ERROR: eMMC boot partition block unset";
+					exit;
+				fi;
+			fi;
+		fi;
+		run mmc_finish_update_uboot;
+	fi;
diff --git a/include/env/tq/nfs.env b/include/env/tq/nfs.env
new file mode 100644
index 00000000000..53fcbd0d152
--- /dev/null
+++ b/include/env/tq/nfs.env
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ *
+ * shared nfs environment for TQ boards
+ */
+
+addnfs=
+	setenv bootargs "${bootargs}" root=/dev/nfs rw
+        nfsroot="${serverip}":"${rootpath}",v3,tcp
+
+load_nfs=
+	nfs "${kernel_addr_r}" "${serverip}":"${rootpath}"/boot/"${image}";
+	nfs "${fdt_addr_r}" "${serverip}":"${rootpath}"/boot/"${fdtfile}";
+	fdt address "${fdt_addr_r}";
+	fdt resize 0x100000;
+	for overlay in "${fdt_overlays}"; do
+		nfs "${fdtoverlay_addr_r}"
+		        "${serverip}":"${rootpath}"/boot/"${overlay}" &&
+			fdt apply "${fdtoverlay_addr_r}";
+	done;
+
+load_tftp=
+	tftp "${kernel_addr_r}" "${image}";
+	tftp "${fdt_addr_r}" "${fdtfile}";
+	fdt address "${fdt_addr_r}";
+	fdt resize 0x100000;
+	for overlay in "${fdt_overlays}"; do
+		if tftp "${fdtoverlay_addr_r}" "${overlay}"; then
+			fdt apply "${fdtoverlay_addr_r}";
+		else
+			exit;
+		fi;
+	done;
+
+netargs=run addnfs addip addtty
+
+netloadcmd=load_tftp
+
+nfsboot=
+	echo "Booting from NFS ...";
+	setenv bootargs;
+	run netargs;
+	run check_ipaddr;
+	if run ${netloadcmd}; then
+		run boot_os;
+	else
+		echo "ERROR: loading from NFS";
+	fi;
diff --git a/include/env/tq/spi.env b/include/env/tq/spi.env
new file mode 100644
index 00000000000..47dcfea7d3f
--- /dev/null
+++ b/include/env/tq/spi.env
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ *
+ * shared spi environment for TQ boards
+ */
+
+update_uboot_spi=
+	run check_ipaddr;
+	if tftp ${uboot}; then
+		if itest "${filesize}" >= "${uboot_spi_size}"; then
+			echo "ERROR: size to large ...";
+			exit;
+		fi;
+		echo "Write u-boot image to SPI NOR ...";
+		if sf probe; then
+			run write_uboot_spi;
+		fi;
+	fi;
+
+write_uboot_spi=sf update "${loadaddr}" "${uboot_spi_start}" "${filesize}"
diff --git a/include/env/tq/tq-imx-shared.env b/include/env/tq/tq-imx-shared.env
new file mode 100644
index 00000000000..d4e42f8b536
--- /dev/null
+++ b/include/env/tq/tq-imx-shared.env
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ *
+ * shared environment for TQ imx boards
+ */
+
+#ifdef CONFIG_CMD_SF
+#include "spi.env"
+#ifdef CONFIG_CMD_UBIFS
+#include "ubi.env"
+#endif /* CONFIG_CMD_UBIFS */
+#endif /* CONFIG_CMD_SF */
+
+#ifdef CONFIG_CMD_MMC
+#include "mmc.env"
+#endif
+
+#ifdef CONFIG_CMD_NFS
+#include "nfs.env"
+#endif
+
+addip=
+	run check_ipaddr;
+	setenv bootargs "${bootargs}"
+	ip="${ipaddr}":"${serverip}":"${gatewayip}":"${netmask}":"${hostname}":"${netdev}":off
+
+addtty=setenv bootargs "${bootargs}" "${console}"
+
+check_ipaddr=
+	if test -z "${ipaddr}" || test -z "${serverip}"; then
+		echo "ipaddr or serverip unset, falling back to DHCP...";
+		dhcp;
+	fi;
+
+rootfsmode=ro
diff --git a/include/env/tq/ubi.env b/include/env/tq/ubi.env
new file mode 100644
index 00000000000..01243d2eb53
--- /dev/null
+++ b/include/env/tq/ubi.env
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+/*
+ * Copyright (c) 2024-2026 TQ-Systems GmbH <u-boot@ew.tq-group.com>,
+ * D-82229 Seefeld, Germany.
+ * Author: Max Merchel
+ *
+ * shared ubi environment for TQ boards
+ */
+
+addubi=
+	setenv bootargs "${bootargs}" rootfstype=ubifs ubi.mtd="${ubimtdname}"
+        root=ubi0:"${ubirootfsvol}" "${rootfsmode}" rootwait;
+
+load_spi=
+	if sf probe; then
+                if ubi part "${ubirootfspart}"; then
+			if ubifsmount ubi0:"${ubirootfsvol}"; then
+				ubifsload "${kernel_addr_r}" /boot/"${image}";
+				ubifsload "${fdt_addr_r}" /boot/"${fdtfile}";
+                                fdt address "${fdt_addr_r}";
+				fdt resize 0x100000;
+				for overlay in "${fdt_overlays}"; do
+					ubifsload "${fdtoverlay_addr_r}"
+					/boot/"${overlay}" &&
+					fdt apply "${fdtoverlay_addr_r}";
+				done;
+				ubifsumount;
+			fi;
+			ubi detach;
+		fi;
+	fi
+
+ubiargs=run addubi addtty
+
+ubiboot=
+	echo "Booting from UBI ...";
+	setenv bootargs;
+	run ubiargs;
+	if run load_spi; then
+		run boot_os;
+	else
+		echo "ERROR: loading kernel";
+	fi;
+
+ubimtdname=mtdname
+ubirootfspart=ubi
+ubirootfsvol=root
-- 
2.43.0

