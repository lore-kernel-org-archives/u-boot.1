Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7008FC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 13:21:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 30E64608E4;
	Tue, 28 Jul 2026 13:21:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ufKOPmMSFTbY; Tue, 28 Jul 2026 13:21:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 57AC7608BE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785244871;
	bh=qPgrzfN3D0oBAbGaDtjiQdNVtlM56gZYWQa+VlSzd1Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CFz2wa4EmEi5bqQthF5Uq+9LJYKIhclQwpuK4+WwKvXZ07Bmi+00WSKkUCSkaao2k
	 78YaYdDGywDznfY1F8Nwgj3N/dPDa9E7sTo82hf+pvtCEbk2IQ62b060H0OevrRlKr
	 xxQzvrVWtCHkIxkEKSipkmbhnIK6pFBe+lugdB9xVnn7e/MSp1KkpKQq96A7WK8mV7
	 raN+SqYhQhAo39TZIoynlJirF2UeGhVimjBgKYLmAy2lvL+b1jTjIlsD0Ck6P5dS3r
	 IOmD7SBADmpleDs8rYvoPH+3ct3eqRI3GbIfhjL8Lr0CvF8iWYPLTQmaYX6129ceCZ
	 0Vjdn9rrld9SQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 57AC7608BE;
	Tue, 28 Jul 2026 13:21:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 883FF4BF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0F4FE405B5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wIKs_VIeR0OC for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 13:21:01 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 22E4540927
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22E4540927
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22E4540927
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 13:21:00 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4955158f26aso24873615e9.3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 06:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785244859; x=1785849659;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qPgrzfN3D0oBAbGaDtjiQdNVtlM56gZYWQa+VlSzd1Y=;
 b=j1O61rYq98gyfANXJG4vCs//eZWF/eu18sTNUUZir0eKWXsdsc9zMKub3eZ9fSlIri
 +JvExOsZigENnlqhQES1BbY8iGXWVsqU6Bnlabf/9sMIuaq52cqUBqyR6CFoy2wWJrlI
 ekTZI6ujoU2BzqnlRnQV1khOrzGi6bnpQph5zDL5Zi6Gm9p1iPLwPixxKqsqj9xGZI9z
 3SQaRi+zSDQLRxO7SgohzKZMj4l5rRF/Q+8gwaqATw5KrP6H0HEBpuKQgw9vMZp5r5Gh
 u5O3Bb0gOGbPOoA8WanhrsvGymrIdlGxypcAeY8abaEXW4xWFhH/wxpA7dfW8I1rzey8
 aLVg==
X-Gm-Message-State: AOJu0YyC+qtcXGudu2X2gkvs0jGhog/1UB9QXV7cWf5RAEwdUl9+4p68
 DQzbgGA7UPOFUHFcWgeGgO+WraEyJabwd7xKxOgodNRDkWAD0A7aRJ0aN3uQctdLV+U=
X-Gm-Gg: AR+sD117w04RUadpIpkXb5mMqjdNYRsH+rqFirilwxO0H0l3jjkiN4H6IefqrFw17YK
 ExXRbMaTfjh88vYa1NiVli3zO6h8r5hD8ZOY51/Hj0uVqqN+91fw7MrZd1QIM7XUMNswetET5Eh
 2QO/Dee9CYo+P1vc8rcij7DU8F9DZqSgpZx8DT6kAmcuOOM2dT+inpHUCwqvdaMKPf+c9ApLDlT
 0uLaLDVyxmS6el2yW5giQJf15/Ct8tlANx/gdvM3YcSbQ4nkqsEHNwvcOQ9oY9FJDKbF1AYMrah
 ynC7nEy/EzeM1XcaxwQTLj86M4jBg5WVPrCaXjrDqKbf0REUKEFmm1JHXkZqgLy+vm8mLZiVksp
 lXj2rrohen2DMoOr3scd947MpAMQSJzfCMhnvt8FQi53w0hUjC3Tw5NB3NbgNQKfvlKp4dsbDPC
 QndFizEBT0poZnOeb7omvnO7mfT13ATc180I239qOTCH0Ke9L5R6N7irtqPpQ=
X-Received: by 2002:a05:600c:8b2e:b0:495:7952:64df with SMTP id
 5b1f17b1804b1-496c659f5a9mr32295115e9.36.1785244858367; 
 Tue, 28 Jul 2026 06:20:58 -0700 (PDT)
Received: from [127.0.0.1] (host-87-0-90-136.retail.telecomitalia.it.
 [87.0.90.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957bd9e980sm306898645e9.0.2026.07.28.06.20.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 06:20:57 -0700 (PDT)
From: Carlo Caione <ccaione@baylibre.com>
Date: Tue, 28 Jul 2026 15:20:44 +0200
Subject: [PATCH v2 2/5] boot: add a firmware-owned devicetree source
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-ccaione-upstream-ebbr-v2-2-4efb529140d6@baylibre.com>
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
In-Reply-To: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
To: u-boot@lists.u-boot-project.org
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Carlo Caione <ccaione@baylibre.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Randolph Sapp <rs@ti.com>, 
 Daniel Golle <daniel@makrotopia.org>, 
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1785244859; x=1785849659;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qPgrzfN3D0oBAbGaDtjiQdNVtlM56gZYWQa+VlSzd1Y=;
 b=bDmINy57ZXnMmU2mUdGHEUb2+6Fb66crXpsox5hBpCzZb3UUQ3g+0SS7y6FdPHOP9e
 Y90/eVgqGKiHRghUc4Y/JUzUt+ROGaerw7ZuC5pPE5H5+4849jit+8LTX1WFw1e+XjZr
 FEcSKGTGo3zPincfF83QglRRuZXkPqXlVtIPIQgztoyerLqWiuvborMLKoxNK12kaN3d
 aIO9ElPFhd0o0mWswLABsZ+N14hY0gzsYLoYvxToQpUn7bARWyKQl1yqgKdzHAU1HM+j
 VGcLwh/kgDmK5NGftinpN3dsr2l9MNr0FCyguDBjCVW+ub4f4RjAmN9WDD9HBXnS/oLK
 m+zg==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bDmINy57
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Platforms following EBBR / Arm SystemReady IR keep the devicetree on a
firmware-owned partition, updated independently of the operating system,
rather than shipping it in the OS image. U-Boot has no generic way to
source and assemble a devicetree from such a partition.

Add firmware_fdt_load(), a loader for a FIT from a firmware-owned
devicetree source. The FIT images hold the base DTB and its overlays,
while each configuration names one valid combination through its standard
'fdt' property. Select an explicit 'fw_fdt_config' when set, otherwise
use compatible best-match against the control devicetree and fall back to
the FIT default.

Describe the source with a standalone control-DT node. This patch
implements the first source backend, 'u-boot,firmware-fdt-block', which
reads the FIT from a filesystem on a GPT partition of a block device:

    firmware-fdt {
        compatible = "u-boot,firmware-fdt-block";
        firmware-fdt-store = <&mmc0>;
        partition-type-uuid =
            "384e979b-eb76-435a-a3a6-1a071dbad91d";
        partition-name = "firmware";
        filename = "fdt.itb";
    };

The 'firmware-fdt-store' phandle points to the media device, and the GPT
type UUID and/or name select the partition. The 'fw_fdt_part' environment
variable can pin an A/B partition.

The compatible suffix identifies the storage backend. Future backends can
load the same fdt.itb from other firmware storage, such as UBI on MTD,
without changing the FIT contract, common verification and assembly, or
its consumers.

The loader is independent of bootstd. Add efi_stage_firmware_fdt() as the
shared policy adapter for its initial EFI consumers: it stages at the
caller's single fdt_addr_r value, enforces the common size limit and
preserves fail-closed semantics.

Make -ENOENT mean only "no source configured". Once a source exists, a
missing partition, FIT or configuration is fatal. Reject load addresses
and external data, require every image to be a flat devicetree and verify
every image before assembly. Reject configuration chaining so the base,
overlay set and ordering remain one authenticated unit.

Signed-off-by: Carlo Caione <ccaione@baylibre.com>
---
 MAINTAINERS                               |   3 +
 boot/Kconfig                              |  24 ++
 boot/Makefile                             |   1 +
 boot/firmware_fdt.c                       | 420 ++++++++++++++++++++++++++++++
 boot/image-fdt.c                          |   3 +-
 boot/image-fit.c                          |   9 +-
 doc/develop/uefi/firmware_fdt.rst         | 112 ++++++++
 doc/develop/uefi/index.rst                |   1 +
 doc/device-tree-bindings/firmware-fdt.txt | 150 +++++++++++
 doc/usage/environment.rst                 |  11 +
 include/firmware_fdt.h                    |  95 +++++++
 include/image.h                           |   4 +-
 12 files changed, 829 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 53034b703df..c8ac95e76f9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -905,8 +905,10 @@ F:	boot/bootdev*.c
 F:	boot/bootflow.c
 F:	boot/bootmeth*.c
 F:	boot/bootstd.c
+F:	boot/firmware_fdt.c
 F:	cmd/bootdev.c
 F:	cmd/bootflow.c
+F:	doc/device-tree-bindings/firmware-fdt.txt
 F:	doc/develop/bootstd/
 F:	doc/usage/bootdev.rst
 F:	doc/usage/bootflow.rst
@@ -916,6 +918,7 @@ F:	include/bootdev.h
 F:	include/bootflow.h
 F:	include/bootmeth.h
 F:	include/bootstd.h
+F:	include/firmware_fdt.h
 F:	net/eth_bootdevice.c
 F:	test/boot/
 
diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba493..764c67a63cb 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -194,6 +194,30 @@ config FIT_BEST_MATCH
 	  If several configurations match equally well, the one named by
 	  the configurations node 'default' property is preferred.
 
+config FIRMWARE_FDT
+	bool "Source the devicetree from a firmware-owned partition"
+	depends on BLK && FIT
+	select EFI_PARTITION
+	select FIT_BEST_MATCH
+	select PARTITION_TYPE_GUID
+	select OF_LIBFDT
+	select OF_LIBFDT_OVERLAY
+	help
+	  Source the devicetree from a firmware-owned partition rather than
+	  from the operating-system image. The partition carries a FIT whose
+	  images hold the base DTB and its overlays, and whose configurations
+	  name the bootable combinations. The assembled devicetree can be
+	  handed to the OS, so it can be updated as part of the firmware,
+	  independently of the operating system.
+
+	  For secure boot, sign the FIT configurations and enable
+	  FIT_SIGNATURE with a required key in the control devicetree; the
+	  standard verified-boot policy then rejects unsigned FITs.
+
+	  EFI consumers use the shared staging helper, but the loader itself is
+	  generic. This is intended for platforms following EBBR / Arm
+	  SystemReady IR. Say N unless you are booting such a platform.
+
 config FIT_IMAGE_POST_PROCESS
 	bool "Enable post-processing of FIT artifacts after loading by U-Boot"
 	depends on SOCFPGA_SECURE_VAB_AUTH
diff --git a/boot/Makefile b/boot/Makefile
index 7fb56e7ef37..23c1de85eb1 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD) += bootstd-uclass.o
 
 obj-$(CONFIG_$(PHASE_)BOOTSTD_MENU) += bootflow_menu.o
 obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
+obj-$(CONFIG_$(PHASE_)FIRMWARE_FDT) += firmware_fdt.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
diff --git a/boot/firmware_fdt.c b/boot/firmware_fdt.c
new file mode 100644
index 00000000000..4e033d55163
--- /dev/null
+++ b/boot/firmware_fdt.c
@@ -0,0 +1,420 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Firmware-owned devicetree source.
+ *
+ * Load a firmware-owned FIT, select and verify one configuration, and
+ * assemble its base devicetree and overlays for consumers.
+ */
+
+#define LOG_CATEGORY LOGC_BOOT
+
+#include <blk.h>
+#include <dm.h>
+#include <env.h>
+#include <firmware_fdt.h>
+#include <fs.h>
+#include <image.h>
+#include <log.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <part.h>
+#include <vsprintf.h>
+#include <dm/ofnode.h>
+#include <linux/libfdt.h>
+#include <linux/string.h>
+
+/* The FIT lives in a filesystem on a GPT partition of a block device */
+#define FW_FDT_COMPAT_BLOCK	"u-boot,firmware-fdt-block"
+
+/* Default FIT filename on the firmware partition */
+#define FW_FDT_FILENAME		"fdt.itb"
+
+/**
+ * fw_fdt_get_source() - find the configured firmware-FDT source node
+ *
+ * Scans the control devicetree for an enabled node with the
+ * "u-boot,firmware-fdt-block" compatible. Disabled nodes are skipped, so a
+ * devicetree may ship the node with status "disabled" and a variant (or a
+ * test) enable it.
+ *
+ * @srcp: returns the source ofnode on success
+ * Return: 0 on success, -ENOENT if no source is configured
+ */
+static int fw_fdt_get_source(ofnode *srcp)
+{
+	ofnode node;
+
+	node = ofnode_by_compatible(ofnode_null(), FW_FDT_COMPAT_BLOCK);
+	while (ofnode_valid(node) && !ofnode_is_enabled(node))
+		node = ofnode_by_compatible(node, FW_FDT_COMPAT_BLOCK);
+
+	if (!ofnode_valid(node))
+		return -ENOENT;
+
+	*srcp = node;
+
+	return 0;
+}
+
+/**
+ * fw_fdt_get_blk() - resolve the block device holding the FIT
+ *
+ * The source node points at its media device (e.g. &mmc0) through the
+ * 'firmware-fdt-store' phandle. The lookup also probes the device, which
+ * the EFI boot-manager path relies on.
+ *
+ * @src: the firmware-FDT source node
+ * @descp: returns the block descriptor on success
+ * Return: 0 on success, -EINVAL if 'firmware-fdt-store' is missing or its
+ * phandle does not resolve, other negative on error
+ */
+static int fw_fdt_get_blk(ofnode src, struct blk_desc **descp)
+{
+	struct udevice *media, *blk;
+	ofnode store;
+	int ret;
+
+	store = ofnode_parse_phandle(src, "firmware-fdt-store", 0);
+	if (!ofnode_valid(store))
+		return log_msg_ret("store", -EINVAL);
+
+	/* a source is configured: remap -ENOENT to -ENODEV to fail closed */
+	ret = device_get_global_by_ofnode(store, &media);
+	if (ret)
+		return log_msg_ret("media", ret == -ENOENT ? -ENODEV : ret);
+
+	ret = blk_get_from_parent(media, &blk);
+	if (ret)
+		return log_msg_ret("blk", ret == -ENOENT ? -ENODEV : ret);
+
+	*descp = dev_get_uclass_plat(blk);
+
+	return 0;
+}
+
+/**
+ * fw_fdt_find_part() - find the firmware partition on @desc
+ *
+ * 'fw_fdt_part', if set, pins an explicit partition number. Otherwise the
+ * first partition matching every configured selector is used: when both
+ * @type_uuid and @name are configured, both must match, so a misprovisioned
+ * disk fails instead of silently selecting whichever same-type (e.g. A/B)
+ * partition comes first. At least one selector must be configured.
+ *
+ * @desc: block device to scan
+ * @type_uuid: GPT type UUID to match, or NULL
+ * @name: partition name to match, or NULL
+ * Return: partition number (>= 1), -EINVAL if 'fw_fdt_part' is set to an
+ * invalid partition number or no selector is configured, or -ENODEV if no
+ * partition matched
+ */
+static int fw_fdt_find_part(struct blk_desc *desc, const char *type_uuid,
+			    const char *name)
+{
+	const char *sel;
+	struct disk_partition info;
+	bool want_type = type_uuid && *type_uuid;
+	bool want_name = name && *name;
+	int p;
+
+	sel = env_get("fw_fdt_part");
+	if (sel && *sel) {
+		char *end;
+		ulong pin;
+
+		pin = dectoul(sel, &end);
+		if (*end || !pin || pin > MAX_SEARCH_PARTITIONS)
+			return log_msg_ret("pin", -EINVAL);
+
+		if (part_get_info(desc, pin, &info))
+			return log_msg_ret("pin", -ENODEV);
+
+		return pin;
+	}
+
+	if (!want_type && !want_name)
+		return log_msg_ret("sel", -EINVAL);
+
+	for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
+		bool type_match, name_match;
+
+		if (part_get_info(desc, p, &info))
+			continue;
+
+		/* UUID text is case-insensitive (RFC 4122) */
+		type_match = !want_type ||
+			!strncasecmp(disk_partition_type_guid(&info), type_uuid,
+				     UUID_STR_LEN);
+		name_match = !want_name ||
+			!strcmp((const char *)info.name, name);
+
+		if (type_match && name_match)
+			return p;
+	}
+
+	return -ENODEV;
+}
+
+/**
+ * fw_fdt_read_fit() - read the FIT into an allocated buffer
+ *
+ * @desc: block device holding the firmware partition
+ * @part: partition number
+ * @fname: FIT filename
+ * @bufp: returns the allocated buffer holding the FIT
+ * @sizep: returns the FIT size in bytes
+ * Return: 0 on success, negative on error
+ */
+static int fw_fdt_read_fit(struct blk_desc *desc, int part, const char *fname,
+			   void **bufp, ulong *sizep)
+{
+	loff_t size;
+	int ret;
+
+	ret = fs_set_blk_dev_with_part(desc, part);
+	if (ret)
+		return log_msg_ret("fs", -EIO);
+
+	ret = fs_size(fname, &size);
+	if (ret)
+		return log_msg_ret("size", -EIO);
+
+	if (!size || size > FIRMWARE_FDT_MAX_SIZE)
+		return log_msg_ret("big", -E2BIG);
+
+	/* fs_size() consumed the mount */
+	ret = fs_set_blk_dev_with_part(desc, part);
+	if (ret)
+		return log_msg_ret("fs2", -EIO);
+
+	ret = fs_read_alloc(fname, size, 0, bufp);
+	if (ret)
+		return log_msg_ret("read", ret);
+
+	*sizep = size;
+
+	return 0;
+}
+
+/**
+ * fw_fdt_check_images() - reject FITs that are not self-contained
+ *
+ * @fit: the FIT
+ * Return: 0 if every image is embedded and has no load address, -EINVAL
+ * otherwise
+ */
+static int fw_fdt_check_images(const void *fit)
+{
+	int images, node;
+
+	images = fdt_path_offset(fit, FIT_IMAGES_PATH);
+	if (images < 0)
+		return log_msg_ret("img", -EINVAL);
+
+	fdt_for_each_subnode(node, fit, images) {
+		if (!fit_image_check_type(fit, node, IH_TYPE_FLATDT))
+			return log_msg_ret("type", -EINVAL);
+
+		if (fdt_getprop(fit, node, FIT_LOAD_PROP, NULL))
+			return log_msg_ret("load", -EINVAL);
+
+		if (fdt_getprop(fit, node, FIT_DATA_OFFSET_PROP, NULL) ||
+		    fdt_getprop(fit, node, FIT_DATA_POSITION_PROP, NULL))
+			return log_msg_ret("ext", -EINVAL);
+	}
+
+	return 0;
+}
+
+/**
+ * fw_fdt_assemble() - load the FIT and assemble the devicetree
+ *
+ * @out: returns the assembled devicetree and its backing buffers
+ * @src: the (validated) firmware-FDT source node
+ * Return: 0 on success, negative on error
+ */
+static int fw_fdt_assemble(struct firmware_fdt *out, ofnode src)
+{
+	struct bootm_headers images;
+	const char *type_uuid, *part_name, *fname, *conf;
+	struct blk_desc *desc;
+	ulong data, len;
+	void *fdt;
+	int part, ret;
+
+	memset(&images, '\0', sizeof(images));
+	images.verify = 1;
+
+	fname = ofnode_read_string(src, "filename");
+	if (!fname)
+		fname = FW_FDT_FILENAME;
+
+	type_uuid = ofnode_read_string(src, "partition-type-uuid");
+	part_name = ofnode_read_string(src, "partition-name");
+
+	ret = fw_fdt_get_blk(src, &desc);
+	if (ret)
+		return ret;
+
+	part = fw_fdt_find_part(desc, type_uuid, part_name);
+	if (part < 0)
+		return log_msg_ret("part", part);
+
+	ret = fw_fdt_read_fit(desc, part, fname, &out->fit, &out->fit_size);
+	if (ret)
+		return ret;
+
+	ret = fit_check_format(out->fit, out->fit_size);
+	if (ret)
+		return log_msg_ret("fit", -EINVAL);
+
+	ret = fw_fdt_check_images(out->fit);
+	if (ret)
+		return ret;
+
+	/*
+	 * boot_get_fdt_fit() verifies the base image and the selected
+	 * configuration, but historically skips an overlay which fails to
+	 * load. Verify every image up front so a bad overlay cannot silently
+	 * turn a signed base-plus-overlay configuration into the base alone.
+	 */
+	if (!fit_all_image_verify(out->fit))
+		return log_msg_ret("verify", -EACCES);
+
+	conf = env_get("fw_fdt_config");
+	if (conf && !*conf)
+		conf = NULL;
+	/*
+	 * boot_get_fdt_fit() accepts '#' to compose several configurations.
+	 * A firmware-owned devicetree must use one configuration so its base,
+	 * overlay set and ordering remain one authenticated unit.
+	 */
+	if (conf && strchr(conf, '#'))
+		return log_msg_ret("chain", -EINVAL);
+
+	ret = boot_get_fdt_fit(&images, map_to_sysmem(out->fit), NULL, &conf,
+			       IH_ARCH_DEFAULT, &data, &len,
+			       &out->fdt_owned);
+	if (ret < 0)
+		return log_msg_ret("conf", ret);
+
+	fdt = map_sysmem(data, len);
+
+	out->fdt = fdt;
+	out->size = len;
+
+	if (len > FIRMWARE_FDT_MAX_SIZE)
+		return log_msg_ret("bigfdt", -E2BIG);
+
+	ret = fdt_check_full(fdt, len);
+	if (ret)
+		return log_msg_ret("chk", -EINVAL);
+
+	out->name = strdup(fname);
+	if (!out->name)
+		return log_msg_ret("name", -ENOMEM);
+
+	return 0;
+}
+
+static int fw_fdt_load_source(struct firmware_fdt *out, ofnode src)
+{
+	int ret;
+
+	memset(out, '\0', sizeof(*out));
+
+	ret = fw_fdt_assemble(out, src);
+	if (ret) {
+		firmware_fdt_free(out);
+
+		/*
+		 * Callers treat -ENOENT as "no source configured" and fall
+		 * back to their normal devicetree. A source IS configured
+		 * here, so remap any downstream -ENOENT (missing FIT,
+		 * missing FIT configuration, ...) to -ENODEV to keep the
+		 * failure fatal (fail closed).
+		 */
+		if (ret == -ENOENT)
+			ret = -ENODEV;
+	}
+
+	return ret;
+}
+
+int firmware_fdt_load(struct firmware_fdt *out)
+{
+	ofnode src;
+	int ret;
+
+	memset(out, '\0', sizeof(*out));
+
+	ret = fw_fdt_get_source(&src);
+	if (ret)
+		return ret;
+
+	return fw_fdt_load_source(out, src);
+}
+
+int efi_stage_firmware_fdt(ulong fdt_addr, ulong *fdt_sizep, char **namep)
+{
+	struct firmware_fdt fw;
+	ofnode src;
+	char *name = NULL;
+	int ret;
+
+	if (namep)
+		*namep = NULL;
+
+	/*
+	 * Check for a configured source before validating the staging address:
+	 * an absent source must remain -ENOENT even on systems which do not
+	 * provide fdt_addr_r.
+	 */
+	ret = fw_fdt_get_source(&src);
+	if (ret)
+		return ret;
+
+	if (!fdt_addr)
+		return log_msg_ret("addr", -EINVAL);
+
+	ret = fw_fdt_load_source(&fw, src);
+	if (ret) {
+		log_err("Failed to assemble the firmware devicetree (err %d)\n",
+			ret);
+		return ret;
+	}
+
+	if (fw.size > FIRMWARE_FDT_MAX_SIZE) {
+		ret = -E2BIG;
+		goto out;
+	}
+
+	if (namep) {
+		name = strdup(fw.name);
+		if (!name) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	memcpy(map_sysmem(fdt_addr, fw.size), fw.fdt, fw.size);
+	*fdt_sizep = fw.size;
+	if (namep)
+		*namep = name;
+	log_debug("Using firmware-owned devicetree\n");
+
+out:
+	firmware_fdt_free(&fw);
+
+	return ret;
+}
+
+void firmware_fdt_free(struct firmware_fdt *fw)
+{
+	if (fw->fdt_owned)
+		free(fw->fdt);
+
+	free(fw->name);
+	free(fw->fit);
+	memset(fw, '\0', sizeof(*fw));
+}
diff --git a/boot/image-fdt.c b/boot/image-fdt.c
index 9e0e0f93edd..1b6b5725873 100644
--- a/boot/image-fdt.c
+++ b/boot/image-fdt.c
@@ -468,7 +468,8 @@ static int select_fdt(struct bootm_headers *images, const char *select, u8 arch,
 				fdt_noffset = boot_get_fdt_fit(images, fdt_addr,
 							       &fit_uname_fdt,
 							       &fit_uname_config,
-							       arch, &load, &len);
+							       arch, &load, &len,
+							       NULL);
 
 				if (fdt_noffset < 0)
 					return -ENOENT;
diff --git a/boot/image-fit.c b/boot/image-fit.c
index ef90c5abd18..fa22a2e08b2 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -2513,7 +2513,7 @@ out:
 
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp)
+		     int arch, ulong *datap, ulong *lenp, bool *ownedp)
 {
 	int fdt_noffset, cfg_noffset, count;
 	const void *fit;
@@ -2533,6 +2533,8 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 #endif
 
 	fit_uname = fit_unamep ? *fit_unamep : NULL;
+	if (ownedp)
+		*ownedp = false;
 
 	if (fit_uname_configp && *fit_uname_configp) {
 		fit_uname_config_copy = strdup(*fit_uname_configp);
@@ -2691,8 +2693,11 @@ int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 
 out:
 #ifdef CONFIG_OF_LIBFDT_OVERLAY
-	if (fdt_noffset >= 0 && base_buf)
+	if (fdt_noffset >= 0 && base_buf) {
 		load = map_to_sysmem(base_buf);
+		if (ownedp)
+			*ownedp = true;
+	}
 #endif
 	if (datap)
 		*datap = load;
diff --git a/doc/develop/uefi/firmware_fdt.rst b/doc/develop/uefi/firmware_fdt.rst
new file mode 100644
index 00000000000..465b0c74b3d
--- /dev/null
+++ b/doc/develop/uefi/firmware_fdt.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+Firmware-owned devicetree
+=========================
+
+Some platforms following EBBR / Arm SystemReady IR treat the devicetree as
+part of the firmware: it lives on a firmware-owned partition and is updated
+independently of the operating system, instead of being shipped in the OS
+image or on the EFI System Partition. U-Boot must read that devicetree,
+assemble it (base plus overlays) and hand it to the OS.
+
+The :c:func:`firmware_fdt_load` helper (``CONFIG_FIRMWARE_FDT``) provides a
+consumer-facing interface independently of standard boot. The source
+compatible identifies the storage backend. The first implemented backend,
+``u-boot,firmware-fdt-block``, reads the FIT from a filesystem on a GPT
+partition of a block device.
+
+Additional source backends may load the same FIT from other firmware storage,
+such as UBI on MTD. They reuse the common FIT configuration selection,
+verification and assembly, as well as the consumers below.
+
+The first consumers are the two EFI launch paths, so the firmware-owned
+devicetree is installed regardless of how the EFI application is started:
+
+  - the per-device EFI bootmeth (``bootmeth_efi``), and
+  - the EFI boot manager (``efi_bootmgr_run()``).
+
+In each case the assembled devicetree is installed into the EFI configuration
+table via :c:func:`efi_install_fdt`, exactly like any other source, so the OS
+cannot tell where it came from.
+
+This replaces vendor-specific firmware-devicetree commands while keeping
+storage discovery behind the source backend.
+
+The FIT
+-------
+
+The firmware partition carries a FIT (by default ``fdt.itb``). Its images
+hold the base DTB and any overlays, and each of its configurations names one
+bootable combination through the standard ``fdt`` property::
+
+    configurations {
+        default = "conf-panel";
+        conf-panel {
+            fdt = "fdt-base", "fdt-panel";
+        };
+    };
+
+The helper selects a configuration, verifies it, loads the base devicetree
+and applies the listed overlays in order (via :c:func:`boot_get_fdt_fit`, the
+same code path ``bootm`` uses). The FIT describes and carries the devicetree
+as one artefact, updated atomically with it.
+
+Images in the FIT must be self-contained flat devicetrees: images that carry
+a ``load`` address and FITs using external data are rejected. With
+``FIT_SIGNATURE`` enabled, node and configuration names must not contain
+``@``.
+
+Configuration
+-------------
+
+The FIT source is described in the control devicetree (see
+``doc/device-tree-bindings/firmware-fdt.txt``). Each source compatible
+defines one storage backend and its locator properties. The currently
+implemented ``u-boot,firmware-fdt-block`` backend points at the media device
+through the ``firmware-fdt-store`` phandle and identifies a GPT partition by
+type UUID and/or name, with an optional ``filename`` for the FIT path. Its
+store phandle follows the FWU metadata (``u-boot,fwu-mdata-*``) pattern.
+
+A future backend may use different locator properties, for example an MTD
+device and UBI volume, while preserving the same FIT contents and the common
+selection, verification, assembly and fail-closed behavior.
+
+Two optional environment variables select among what the FIT ships:
+``fw_fdt_part`` pins a partition number (A/B firmware partitions) and
+``fw_fdt_config`` names the FIT configuration to use. Without an explicit
+configuration, compatible best-match against the control devicetree is used;
+if there is no match, the FIT's ``default`` configuration is used. The
+``fw_fdt_config`` value must name one configuration; configuration chaining
+with ``#`` is rejected so the selected base, overlay set and ordering remain
+one authenticated unit.
+
+If no source is configured, the helper returns ``-ENOENT`` and the caller
+falls back to its normal devicetree source (ESP / built-in control FDT). If a
+source is configured but cannot be assembled, the error is fatal for that EFI
+launch path; this prevents a bad or unauthenticated firmware devicetree from
+being silently replaced by another devicetree source.
+
+A firmware-owned devicetree is the complete, authoritative devicetree: no
+other devicetree source is layered on top of it. In particular,
+extension-board overlays (``extension_scan()``) are intentionally not
+applied, since modifying the assembled (and, in secure mode, signed)
+devicetree would defeat the authenticated-combination model. Boards using
+extension boards should ship each supported combination as a FIT
+configuration and select it with ``fw_fdt_config``.
+
+Secure boot
+-----------
+
+Signing a FIT configuration authenticates the whole combination: the base,
+the overlay set and its ordering are the signed unit, and a tampered selector
+can only pick among combinations the firmware author pre-signed. Sign the
+FIT and inject the public key into U-Boot's control devicetree as
+usual::
+
+    mkimage -f fdt.its -k keys -K u-boot.dtb -r fdt.itb
+
+With ``CONFIG_FIT_SIGNATURE`` enabled and a required key in the control
+devicetree, verification is enforced by the standard verified-boot policy:
+an unsigned or tampered FIT is rejected and, because a configured source
+never falls back, the boot fails closed rather than booting an unverified
+devicetree.
diff --git a/doc/develop/uefi/index.rst b/doc/develop/uefi/index.rst
index e26b1fbe05c..67b100691bd 100644
--- a/doc/develop/uefi/index.rst
+++ b/doc/develop/uefi/index.rst
@@ -14,3 +14,4 @@ can be run an UEFI payload.
    u-boot_on_efi.rst
    iscsi.rst
    fwu_updates.rst
+   firmware_fdt.rst
diff --git a/doc/device-tree-bindings/firmware-fdt.txt b/doc/device-tree-bindings/firmware-fdt.txt
new file mode 100644
index 00000000000..9baf9665430
--- /dev/null
+++ b/doc/device-tree-bindings/firmware-fdt.txt
@@ -0,0 +1,150 @@
+U-Boot firmware-owned devicetree source (firmware-fdt)
+======================================================
+
+Some platforms (EBBR / Arm SystemReady IR) keep the devicetree on a
+firmware-owned partition, updated independently of the operating system,
+rather than shipping it in the OS image or the EFI System Partition. The
+partition carries a FIT: its images hold the base DTB and any
+overlays, and each of its configurations names one bootable combination
+through the standard 'fdt' property. U-Boot selects a configuration,
+verifies it per the usual verified-boot policy, assembles the devicetree
+(base plus overlays, in order) and installs it via the EFI configuration
+table.
+
+The source node's compatible selects the storage backend and its locator
+properties. This document defines the first backend,
+"u-boot,firmware-fdt-block", which reads the FIT from a filesystem on a GPT
+partition of a block device. Additional backends may load the same FIT from
+other firmware storage, for example a UBI volume on MTD, without changing
+FIT selection, verification, assembly or consumers.
+
+For the block backend, a standalone node points at the media device that owns
+the partition by phandle. The node may live anywhere in the control devicetree
+(it is found by compatible); a node with status "disabled" is ignored.
+
+
+firmware-fdt source node
+------------------------
+
+Required properties:
+
+compatible:
+   "u-boot,firmware-fdt-block" - the FIT lives in a filesystem on a
+   GPT partition of a block device. The suffix names the first implemented
+   backend. Sibling compatibles may define other source backends and their
+   storage-specific locator properties later.
+
+firmware-fdt-store:
+   phandle to the media device (UCLASS_MMC, ...) that owns the firmware
+   partition
+
+The partition is selected by the 'fw_fdt_part' environment variable, if set,
+which pins a partition number (for A/B firmware partitions). Otherwise the
+first partition matching every configured selector is used: when both
+'partition-type-uuid' and 'partition-name' are present, both must match (so
+a misprovisioned disk fails closed instead of silently selecting whichever
+same-type partition comes first).
+
+At least one of 'partition-type-uuid' or 'partition-name' must be present.
+
+Optional properties:
+
+partition-type-uuid:
+   GPT partition type UUID (string, case-insensitive) identifying the
+   firmware partition. When A/B firmware partitions share a type UUID,
+   'partition-name' disambiguates between them.
+
+partition-name:
+   GPT partition name (string) identifying the firmware partition. Used to
+   disambiguate, or as a fallback when 'partition-type-uuid' is absent.
+
+filename:
+   Path of the FIT on the partition (default: "fdt.itb").
+
+
+Environment
+-----------
+
+Two optional environment variables select among what the FIT ships:
+
+   fw_fdt_part     pin a specific partition number (A/B firmware partitions)
+   fw_fdt_config   name of the FIT configuration to use; when unset the
+                   best compatible match against the control devicetree is
+                   used, falling back to the FIT's default configuration
+
+``fw_fdt_config`` selects exactly one configuration; U-Boot's ``#`` syntax
+for composing several configurations is rejected so the base, overlay set and
+ordering remain one authenticated unit. Both values only choose among
+combinations the firmware author shipped; with signed configurations a
+tampered value cannot select an unsigned combination.
+
+
+The FIT
+-------
+
+This is a standard FIT image. Every image must be a flat devicetree
+('type = "flat_dt"') without a load address (images carrying a 'load'
+property are rejected), self-contained (no external data). For secure boot,
+sign the configurations and enable FIT_SIGNATURE with a required key in the
+control devicetree. Example source (.its):
+
+	/dts-v1/;
+	/ {
+		description = "Firmware-owned devicetree";
+		#address-cells = <1>;
+
+		images {
+			fdt-base {
+				description = "base board devicetree";
+				data = /incbin/("board.dtb");
+				type = "flat_dt";
+				arch = "arm64";
+				compression = "none";
+				hash-1 { algo = "sha256"; };
+			};
+			fdt-panel {
+				description = "panel overlay";
+				data = /incbin/("panel.dtbo");
+				type = "flat_dt";
+				arch = "arm64";
+				compression = "none";
+				hash-1 { algo = "sha256"; };
+			};
+		};
+
+		configurations {
+			default = "conf-panel";
+			conf-panel {
+				fdt = "fdt-base", "fdt-panel";
+				signature-1 {
+					algo = "sha256,rsa2048";
+					key-name-hint = "fw";
+					sign-images = "fdt";
+				};
+			};
+			conf-base {
+				fdt = "fdt-base";
+				signature-1 {
+					algo = "sha256,rsa2048";
+					key-name-hint = "fw";
+					sign-images = "fdt";
+				};
+			};
+		};
+	};
+
+Note: with FIT_SIGNATURE enabled, node and configuration names must not
+contain the '@' character.
+
+
+Example
+-------
+
+	firmware-fdt {
+		compatible = "u-boot,firmware-fdt-block";
+		firmware-fdt-store = <&mmc0>;
+		partition-type-uuid =
+			"384e979b-eb76-435a-a3a6-1a071dbad91d";
+		partition-name = "firmware";
+		filename = "fdt.itb";
+	};
diff --git a/doc/usage/environment.rst b/doc/usage/environment.rst
index 0143f81f2c0..6515fa47e58 100644
--- a/doc/usage/environment.rst
+++ b/doc/usage/environment.rst
@@ -243,6 +243,17 @@ fdtcontroladdr
     device tree used by U-Boot when CONFIG_OF_CONTROL is
     defined.
 
+fw_fdt_config
+    Name of the configuration to select from a firmware-owned devicetree
+    FIT. If unset, U-Boot uses compatible best-match against the control
+    devicetree, falling back to the FIT's default configuration.
+    Configuration chaining with ``#`` is not supported.
+
+fw_fdt_part
+    Partition number containing the firmware-owned devicetree FIT. This can
+    pin one side of an A/B firmware layout. If unset, U-Boot uses the
+    partition selectors in the ``u-boot,firmware-fdt-block`` control-DT node.
+
 initrd_high
     restrict positioning of initrd images:
     If this variable is not set, initrd images will be
diff --git a/include/firmware_fdt.h b/include/firmware_fdt.h
new file mode 100644
index 00000000000..b6afb3b150e
--- /dev/null
+++ b/include/firmware_fdt.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef __FIRMWARE_FDT_H
+#define __FIRMWARE_FDT_H
+
+#include <linux/errno.h>
+#include <linux/sizes.h>
+#include <linux/types.h>
+
+/* Maximum size of both the firmware FIT and the assembled devicetree */
+#define FIRMWARE_FDT_MAX_SIZE	SZ_4M
+
+/**
+ * struct firmware_fdt - an assembled, firmware-owned devicetree
+ *
+ * @fdt: pointer to the assembled devicetree in memory
+ * @size: size of the assembled devicetree, in bytes
+ * @name: owned FIT filename (for diagnostics)
+ * @fit: internal: buffer holding the FIT
+ * @fit_size: internal: size of the FIT, in bytes
+ * @fdt_owned: internal: true if @fdt is a separate allocation
+ *
+ * All memory is owned by the helper: release it with firmware_fdt_free()
+ * once the devicetree has been consumed (installed or copied).
+ */
+struct firmware_fdt {
+	void *fdt;
+	ulong size;
+	char *name;
+	void *fit;
+	ulong fit_size;
+	bool fdt_owned;
+};
+
+#if CONFIG_IS_ENABLED(FIRMWARE_FDT)
+/**
+ * firmware_fdt_load() - assemble the devicetree from a firmware partition
+ *
+ * Assemble the devicetree (the base DTB with its overlays applied, as
+ * described by the FIT on the configured firmware partition) and
+ * return it in @out, ready to hand to the OS.
+ *
+ * @out: returns the assembled devicetree on success
+ * Return: 0 on success; -ENOENT if no source is configured (the caller may
+ *	   fall back to its normal devicetree); another negative errno if a
+ *	   configured source fails to assemble (the caller must fail, never
+ *	   fall back)
+ */
+int firmware_fdt_load(struct firmware_fdt *out);
+
+/**
+ * firmware_fdt_free() - release the memory behind an assembled devicetree
+ *
+ * Safe to call on a zeroed or already-freed @fw.
+ *
+ * @fw: the assembled devicetree to release
+ */
+void firmware_fdt_free(struct firmware_fdt *fw);
+
+/**
+ * efi_stage_firmware_fdt() - stage a firmware-owned devicetree for EFI
+ *
+ * This is the common policy adapter for EFI consumers. It first checks
+ * whether a source is configured, then assembles and copies its devicetree
+ * to @fdt_addr. Only -ENOENT permits a caller to try another source.
+ *
+ * Callers must read ``fdt_addr_r`` once and pass that value as @fdt_addr.
+ * The same value must be used for any fallback source, so an environment
+ * change cannot make the two paths disagree.
+ *
+ * @fdt_addr: destination address, normally the caller's ``fdt_addr_r`` value
+ * @fdt_sizep: returns the staged devicetree size
+ * @namep: if non-NULL, returns an allocated copy of the FIT filename
+ * Return: 0 if staged; -ENOENT if no source is configured; another negative
+ *	   errno if a configured source cannot be staged
+ */
+int efi_stage_firmware_fdt(ulong fdt_addr, ulong *fdt_sizep, char **namep);
+#else
+static inline int firmware_fdt_load(struct firmware_fdt *out)
+{
+	return -ENOENT;
+}
+
+static inline void firmware_fdt_free(struct firmware_fdt *fw)
+{
+}
+
+static inline int efi_stage_firmware_fdt(ulong fdt_addr, ulong *fdt_sizep,
+					 char **namep)
+{
+	return -ENOENT;
+}
+#endif
+
+#endif /* __FIRMWARE_FDT_H */
diff --git a/include/image.h b/include/image.h
index 4149ebbcce9..0f297ee5d97 100644
--- a/include/image.h
+++ b/include/image.h
@@ -719,12 +719,14 @@ int boot_get_setup_fit(struct bootm_headers *images, uint8_t arch,
  * @param arch		Expected architecture (IH_ARCH_...)
  * @param datap		Returns address of loaded image
  * @param lenp		Returns length of loaded image
+ * @param ownedp	Returns true if the loaded image is separately allocated
+ *			and must be freed by the caller, or NULL
  *
  * Return: node offset of base image, or -ve error code on error
  */
 int boot_get_fdt_fit(struct bootm_headers *images, ulong addr,
 		     const char **fit_unamep, const char **fit_uname_configp,
-		     int arch, ulong *datap, ulong *lenp);
+		     int arch, ulong *datap, ulong *lenp, bool *ownedp);
 
 /**
  * fit_image_load() - load an image from a FIT

-- 
2.55.0

