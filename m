Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BA1C5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 16:34:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C07D24051D;
	Wed, 26 Aug 2026 16:34:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbJ0hkjeHTps; Wed, 26 Aug 2026 16:34:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787762096;
	bh=TfILfjKwaqrt2Wo5o4HrrnLCUAdzFNpM3vZigmZ4jAw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ll3tUh7fVLqjYXFLcbgK3ztwgGYwkf6hFyY0NEASZVrJAjyQY1ozN935gNKMtOI5J
	 1aqGgdujuaH4399cfEM/nAJGTUSO6EDGSGrPFgdydhcKgI1YcbvQ1IelB2zgaPd+Pv
	 e/0KJLhcO+hy67ypH2QDjO8fZb9k8IE0h4Vh/HJTgvJbdLDkjiNDUidZ52uAe7HHxg
	 r26bymOd67vR3asAGfWQNeUBuN1K/c5WA9Dp4MumTlYw7EhnXq2XlQHgRCTe3sSB5O
	 ODyF+nKHuISjd/Civ76FN+xfJhIyWNvemIrUbeTeUcuchgjbGXsP1+qi/0all2At+2
	 vCGikx/w3owLw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3D16F406A3;
	Wed, 26 Aug 2026 16:34:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1290929B
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ECA1740118
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LA6XQl9A_lRr for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 16:34:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62c; helo=mail-ej1-x62c.google.com;
 envelope-from=alchark@flipper.net; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net
 header.a=rsa-sha256 header.s=google header.b=JUChy0FP
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 29F89400DC
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 16:34:52 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-c1670dad7a8so194725366b.3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1787762091; x=1788366891;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TfILfjKwaqrt2Wo5o4HrrnLCUAdzFNpM3vZigmZ4jAw=;
 b=JUChy0FPilMLVgbMfO3RAJkrnFvoLn5kKhwpJA6PX+3/hy2BqXGKFHY2Xx0JTU8EKA
 Pg1AUHwfwQuRXl2si5u+UZjU7nHFJzfIvlLhLtgMa5TnxA2rGO+2/f6sv6FB6fQukYr9
 haNubKQDFJ6W5GFVBj6XByfkO7/lfQRUijpoc8OkhuUV/y3EtdeQ5ND+QibPlPkqKb2K
 p0CN7b/tk9/yxiCsJ8VBKSB9dXGdbMK6eg2BV0O6pSTIxPuwdOXZLYRHE/DP44IZwEHK
 HGVUxj76oQlRV5uvY2suQE5bzGMaRdmnoWBKSKVTiE8hCztFDX1NAaT+q5wjh2UzFjV9
 hsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762091; x=1788366891;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TfILfjKwaqrt2Wo5o4HrrnLCUAdzFNpM3vZigmZ4jAw=;
 b=bzfwcjp57ZuLKz/bjJFsCT/USYnwzgJuf1eeA7dZaZqA/A2LnV0ls5UrV0xlJrxT7m
 heKJDp8Rjj+TalEgenTI0DoFpoR0wmAdArTgUIfIn/D472ceY3yjo/nWWPZh1kDtCA0n
 Va5vxiA94NfL6evW9Bb9hkM7GywRqS3AWMZcWbYTzxmZ7c0KutLybmoGnp2892ZLfLjL
 74wWHum/K7vJUdl45tfj9roFACrK5Qmw0aSewUVLhRmBS9UVL3ghk7Y+72/SeFlDDwWd
 EJtlKYtwkeAQluVavQ0Fb7z41OV+um9frKG9vw57h3+rFc13qjqSyd2C1gcUbwzqVp2s
 LH7Q==
X-Gm-Message-State: AFuF++nm1XL6rklAOYdQBOL3Q7KV65htazGwzVgn1MW+jjgXkZHUAhnf
 988QKsLLCVKASROzKj8KIfq1TRh7c2fB/9WZKuXCWjx22qzCUKvBY4eU1XCbmOq92fE=
X-Gm-Gg: AR+sD124PDtNw47q0oGpQxSmOWVEdL/j17IaFfB0iAS6YN0YInLeZHI8h/N3inXWdf8
 Sx8Sh33+GNk8/gOdTosvzNSqMo0gCNlooH5ASLLn97lzO3cdz/4vaFY7xEgIzV8PmFweWPRBz+Q
 7z/MLf5BVKl+tw6yZOHZ831i1neGetVX+g+rMbpUitiQyg7Z01oieoZj62RjCovMgXksy82CvOc
 +IU0lGotQ3r7s3pdOIlvJ+XGznOHEfnLESGyKOtSmNIjkKRssIXcPhOpZna34y6xRGr+/YowQvH
 tgKlsO8fYWN9Rxw6gaDzhwgLRpz6wyX1c0JiBmTHoy0HNa0KKtd14N3lQQ8X24rV6Bzkbic27LY
 P9TTpRwDue1JFzhU72kDFZl7rrhdCNzuqUGDJN8j+mYXHnsUveYKlSKA+wEnp8aP4RzDhNhpBRl
 6ydd5xj7qE9iwrWLueHtswvbqi8KGc1XdP7SdIVqf3XHzpVzbI2aXpj/9lo0CUWRjh1scPLDI1Q
 RjsujIB0Nqe1+S+NyRoEvzYaIKshhv7l+zoADSucg==
X-Received: by 2002:a17:906:fd88:b0:c25:437:3dcf with SMTP id
 a640c23a62f3a-c250c3c07fcmr1039272566b.21.1787762090589; 
 Wed, 26 Aug 2026 09:34:50 -0700 (PDT)
Received: from alchark-surface.localdomain (bba-86-98-192-94.alshamil.net.ae.
 [86.98.192.94]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a704e55sm544907666b.21.2026.08.26.09.34.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:34:50 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 26 Aug 2026 20:34:01 +0400
Subject: [PATCH v2 09/13] boot: add a minimal bootmeth for the Boot Loader
 Specification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260826-bls-v2-9-17df3c9548ba@flipper.net>
References: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
In-Reply-To: <20260826-bls-v2-0-17df3c9548ba@flipper.net>
To: u-boot@lists.u-boot-project.org
Cc: Alexey Charkov <alchark@flipper.net>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Daniel Golle <daniel@makrotopia.org>, 
 Johan Jonker <jbx6244@gmail.com>, "Lucien.Jheng" <lucienzx159@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>, 
 Vincent Jardin <vjardin@free.fr>, Denis Mukhin <dmukhin@ford.com>, 
 Aristo Chen <aristo.chen@canonical.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=14198; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=D5Bhl8ZnEyHWQhxA/IG6lVxD4CmibR28dFIYI1sEkBY=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWT1i/Yy9R/f3mA26fv9DRPOahbb1Nz9M/PjrZaEeUsM9
 15+fTDKuGMiC4MYF4OlmCLL3G9LbKca8c3a5eHxFWYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdYxYuDiFICpTprL8N8n2+PbM5vGPzXnk/Z6XWBYoGzkv3bi2TV7mfet5XprppTD8E+zQiw
 zRNwt5HBjh1aLVnGxwMejL0+tbbJ0uLe45f6yJ4wA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Add a bootmeth that finds and boots Boot Loader Specification (BLS)
type #1 entry files [1]. On each block-device partition it scans, the
bootmeth looks for files matching '<prefix>loader/entries/*.conf'
(where <prefix> comes from bootstd_get_prefixes(), typically '/' and
'/boot/'), picks the highest-sorting filename, parses it, and exposes
it as a bootflow.

Implementation reuses the existing pxelinux infrastructure.

For now the entry chosen on a partition is purely the lexicographic
maximum of *.conf filenames; sort-key / version field handling
(spec-mandated tiebreakers) and boot-counting (the '+TRIES_LEFT'
filename suffix) are left as TODOs. Likewise, only the top-sorted entry
is surfaced because the bootstd framework currently allows one bootflow
per (bootmeth, partition); exposing every discovered entry will require
a framework extension.

The driver takes no number prefix, unlike bootmeth_1extlinux and
bootmeth_2script which carry one to pin the ordering the old distro boot
scripts had. BLS has no such legacy to preserve, so leave the choice to
boards via 'bootmeths' or the devicetree.

Type #2 BLS (drop-in directory of EFI binaries) is out of scope here;
existing EFI bootmeths cover that use case.

Link: https://uapi-group.org/specifications/specs/boot_loader_specification/ [1]
Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/Kconfig        |  16 +++
 boot/Makefile       |   1 +
 boot/bootmeth_bls.c | 370 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 387 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index add78a0b965a..02aeefc394cc 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -659,6 +659,22 @@ config BOOTMETH_EXTLINUX_PXE
 
 	  This provides a way to try out standard boot on an existing boot flow.
 
+config BOOTMETH_BLS
+	bool "Bootdev support for Boot Loader Specification entries"
+	select PXE_UTILS
+	help
+	  Enables support for booting via Boot Loader Specification type #1
+	  entry files. The bootmeth scans each filesystem it finds for files
+	  matching 'loader/entries/*.conf' (or '/boot/loader/entries/*.conf')
+	  and boots the highest-sorting entry.
+
+	  The specification is here:
+
+	    https://uapi-group.org/specifications/specs/boot_loader_specification/
+
+	  Type #2 BLS (drop-in directory of EFI binaries) is not handled here;
+	  use BOOTMETH_EFI_BOOTMGR for that.
+
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
diff --git a/boot/Makefile b/boot/Makefile
index a0f6cabcdfcc..1b48a2e9634a 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_PXE_COMMON) += bootmeth_pxe_common.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_BLS) += bootmeth_bls.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
new file mode 100644
index 000000000000..f59951a8d06f
--- /dev/null
+++ b/boot/bootmeth_bls.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0+
+// SPDX-FileCopyrightText: 2026 Flipper FZCO
+/*
+ * Bootmethod for the Boot Loader Specification (type #1 entry files)
+ *
+ * Reuses the pxelinux parser/boot path: each on-disk entry is read into a
+ * struct pxe_label via parse_label_keys() and booted via label_boot().
+ *
+ * Spec: https://uapi-group.org/specifications/specs/boot_loader_specification/
+ *
+ * TODO: a partition typically holds several BLS entries, but the bootstd
+ * framework currently allows only one bootflow per (bootmeth, partition)
+ * pair, so this bootmeth surfaces only the highest-sorting entry. Once the
+ * framework grows a way for a bootmeth to emit multiple bootflows from a
+ * single partition, this should expose every discovered entry so the user
+ * can pick from the standard 'bootflow menu' UI rather than be limited to
+ * the default pick.
+ */
+
+#define LOG_CATEGORY UCLASS_BOOTSTD
+
+#include <asm/cache.h>
+#include <bootdev.h>
+#include <bootflow.h>
+#include <bootmeth.h>
+#include <bootstd.h>
+#include <command.h>
+#include <dm.h>
+#include <extlinux.h>
+#include <fs.h>
+#include <malloc.h>
+#include <mapmem.h>
+#include <pxe_utils.h>
+#include <linux/sizes.h>
+
+#define BLS_DIR		"loader/entries"
+#define BLS_SUFFIX	".conf"
+
+static int bls_check(struct udevice *dev, struct bootflow_iter *iter)
+{
+	int ret;
+
+	/* This only works on block devices */
+	ret = bootflow_iter_check_blk(iter);
+	if (ret)
+		return log_msg_ret("blk", ret);
+
+	return 0;
+}
+
+/**
+ * bls_pick_entry() - Find the highest-sorting *.conf across bootstd prefixes
+ *
+ * Walks ``<prefix>/loader/entries/`` for each prefix in @prefixes and
+ * returns the lexicographically maximum full path seen.
+ *
+ * The spec leaves ordering between prefixes unspecified, as it only deals with
+ * a dedicated boot/XBOOTLDR/ESP partition and not a $BOOT as a directory.
+ * Comparing full paths is a deterministic-and-cheap stand-in.
+ *
+ * The Boot Loader Specification says entries should be sorted by sort-key
+ * (descending), then version (descending), then filename (descending). For
+ * the time being only the filename criterion is implemented, which is
+ * sufficient for most distros that encode kernel version into the filename.
+ *
+ * TODO: implement proper spec-compliant ordering. That requires reading
+ * each candidate entry, parsing its 'sort-key' and 'version' fields (the
+ * latter compared with strverscmp()-style logic), and only falling back to
+ * filename order when those tie.
+ *
+ * The prefix the winning entry was found under is recorded in
+ * @bflow->subdir, so that 'bootflow info' can report where it came from.
+ *
+ * @prefixes:	NULL-terminated array of bootstd prefixes to search
+ * @desc:	Block descriptor (used to re-mount per prefix)
+ * @bflow:	Bootflow being populated (used to re-mount per prefix)
+ * @fullp:	Returns the chosen full path (allocated), or NULL if none
+ * Return: 0 on success, -ENOENT if no entry was found, < 0 on other error
+ */
+static int bls_pick_entry(const char *const *prefixes, struct blk_desc *desc,
+			  struct bootflow *bflow, char **fullp)
+{
+	const char *best_prefix = NULL;
+	char dirpath[256];
+	char *best = NULL;
+	int ret;
+	int i;
+
+	for (i = 0; prefixes && prefixes[i]; i++) {
+		struct fs_dir_stream *dirs;
+		struct fs_dirent *dent;
+
+		/* fs_closedir() below resets the global fs_type. */
+		ret = bootmeth_setup_fs(bflow, desc);
+		if (ret) {
+			free(best);
+			return log_msg_ret("fs", ret);
+		}
+
+		snprintf(dirpath, sizeof(dirpath), "%s%s",
+			 prefixes[i], BLS_DIR);
+		dirs = fs_opendir(dirpath);
+		if (!dirs)
+			continue;
+
+		while ((dent = fs_readdir(dirs))) {
+			size_t len = strlen(dent->name);
+			char *full;
+
+			if (dent->type != FS_DT_REG)
+				continue;
+			if (len <= strlen(BLS_SUFFIX))
+				continue;
+			if (strcmp(dent->name + len - strlen(BLS_SUFFIX),
+				   BLS_SUFFIX))
+				continue;
+
+			full = malloc(strlen(dirpath) + 1 + len + 1);
+			if (!full) {
+				free(best);
+				fs_closedir(dirs);
+				return -ENOMEM;
+			}
+			sprintf(full, "%s/%s", dirpath, dent->name);
+
+			if (!best || strcmp(full, best) > 0) {
+				free(best);
+				best = full;
+				best_prefix = prefixes[i];
+			} else {
+				free(full);
+			}
+		}
+		fs_closedir(dirs);
+	}
+
+	if (!best)
+		return -ENOENT;
+
+	free(bflow->subdir);
+	bflow->subdir = strdup(best_prefix);
+	if (!bflow->subdir) {
+		free(best);
+		return -ENOMEM;
+	}
+
+	*fullp = best;
+
+	return 0;
+}
+
+/*
+ * TODO: BLS entry filenames may carry a boot-counter suffix of the form
+ * '+TRIES_LEFT[-TRIES_DONE]' immediately before the .conf extension (see
+ * the spec section on "Boot counting"). When that is implemented, this
+ * bootmeth should:
+ *   - parse and strip the suffix from the displayed entry name,
+ *   - skip entries whose TRIES_LEFT has reached zero,
+ *   - decrement TRIES_LEFT (renaming the file) on each boot attempt.
+ * For now the suffix is left intact in the entry name and ignored.
+ */
+static int bls_read_bootflow(struct udevice *dev, struct bootflow *bflow)
+{
+	struct pxe_label *label = NULL;
+	struct pxe_menu scratch = {};
+	const char *const *prefixes;
+	struct udevice *bootstd;
+	struct blk_desc *desc;
+	char *fpath = NULL;
+	const char *base;
+	char *body;
+	int ret;
+
+	ret = uclass_first_device_err(UCLASS_BOOTSTD, &bootstd);
+	if (ret)
+		return log_msg_ret("std", ret);
+
+	/* We require a partitioned block device */
+	if (!bflow->blk || !bflow->part)
+		return -ENOENT;
+
+	desc = dev_get_uclass_plat(bflow->blk);
+	prefixes = bootstd_get_prefixes(bootstd);
+
+	ret = bls_pick_entry(prefixes, desc, bflow, &fpath);
+	if (ret)
+		return log_msg_ret("scan", ret);
+
+	base = strrchr(fpath, '/');
+	base = base ? base + 1 : fpath;
+
+	/*
+	 * bls_pick_entry() finished with fs_closedir(), which resets the
+	 * global fs_type. Re-mount the partition so bootmeth_try_file()'s
+	 * internal fs_size() call can find the right filesystem driver.
+	 */
+	ret = bootmeth_setup_fs(bflow, desc);
+	if (ret) {
+		free(fpath);
+		return log_msg_ret("fs", ret);
+	}
+
+	ret = bootmeth_try_file(bflow, desc, NULL, fpath);
+	if (ret) {
+		free(fpath);
+		return log_msg_ret("try", ret);
+	}
+
+	ret = bootmeth_alloc_file(bflow, SZ_64K, ARCH_DMA_MINALIGN,
+				  BFI_EXTLINUX_CFG);
+	if (ret) {
+		free(fpath);
+		return log_msg_ret("read", ret);
+	}
+
+	label = label_create();
+	if (!label) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/*
+	 * BLS files have no 'label NAME' header — derive the label name from
+	 * the basename (without the .conf suffix) so messages are useful.
+	 */
+	label->name = strndup(base, strlen(base) - strlen(BLS_SUFFIX));
+	if (!label->name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	body = bflow->buf;
+	ret = parse_label_keys(&body, &scratch, label, true);
+	if (ret < 0)
+		goto err;
+
+	/*
+	 * scratch is only used to give parse_label_keys() somewhere safe to
+	 * stash menu-level state (e.g. a stray 'menu default' line). BLS
+	 * entry files don't contain such lines but defensively free anything
+	 * that did get allocated.
+	 */
+	free(scratch.default_label);
+
+	/*
+	 * label->menu was populated either from a BLS 'title' line (the
+	 * spec-mandated human-readable name) or from a stray 'menu label'
+	 * the parser may have picked up. Fall back to the filename-derived
+	 * label name when neither is present.
+	 */
+	bflow->os_name = strdup(label->menu ? label->menu : label->name);
+	if (!bflow->os_name) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/*
+	 * Don't retain the parsed label. bflow->bootmeth_priv is freed by the
+	 * bootstd core with a single flat free(), which would leak the label's
+	 * many separately-allocated string members. Worse, a bootflow is
+	 * shallow-copied into the bootflow list (bootstd_add_bootflow()), so a
+	 * retained pointer is shared between the iterator's temporary and the
+	 * stored copy and can be freed twice, corrupting the heap.
+	 *
+	 * The raw config text remains in bflow->buf (owned and freed by the
+	 * core); bls_boot() re-parses it when the entry is actually booted,
+	 * mirroring how bootmeth_extlinux works.
+	 */
+	label_destroy(label);
+	free(fpath);
+
+	return 0;
+
+err:
+	free(scratch.default_label);
+	if (label)
+		label_destroy(label);
+	free(fpath);
+	return log_msg_ret("bls", ret);
+}
+
+static int bls_boot(struct udevice *dev, struct bootflow *bflow)
+{
+	struct cmd_tbl cmdtp = {};	/* dummy */
+	struct pxe_context ctx;
+	struct extlinux_info info;
+	struct pxe_menu scratch = {};
+	struct pxe_label *label;
+	char *body;
+	int ret;
+
+	if (!bflow->buf)
+		return log_msg_ret("buf", -ENOENT);
+
+	label = label_create();
+	if (!label)
+		return log_msg_ret("lbl", -ENOMEM);
+
+	/* Give label_boot() a useful name for its progress messages. */
+	if (bflow->os_name) {
+		label->name = strdup(bflow->os_name);
+		if (!label->name) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	body = bflow->buf;
+	ret = parse_label_keys(&body, &scratch, label, true);
+	if (ret < 0)
+		goto out;
+
+	info.dev = dev;
+	info.bflow = bflow;
+
+	/*
+	 * The spec has paths inside an entry "always relative to the root
+	 * directory of the partition they are referenced from", which is what
+	 * the bootmeth sees regardless of the prefix the entry was found
+	 * under. allow_abs_path=true honours that, and passing NULL as the
+	 * bootfile keeps the prefix empty so the paths are not rebased.
+	 */
+	ret = pxe_setup_ctx(&ctx, &cmdtp, extlinux_getfile, &info, true,
+			    NULL, false, false);
+	if (ret) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = label_boot(&ctx, label);
+	pxe_destroy_ctx(&ctx);
+	if (ret)
+		ret = -EINVAL;
+
+out:
+	free(scratch.default_label);
+	label_destroy(label);
+
+	return ret < 0 ? log_msg_ret("boot", ret) : 0;
+}
+
+static int bls_bootmeth_bind(struct udevice *dev)
+{
+	struct bootmeth_uc_plat *plat = dev_get_uclass_plat(dev);
+
+	plat->desc = IS_ENABLED(CONFIG_BOOTSTD_FULL) ?
+		"Boot Loader Specification" : "bls";
+
+	return 0;
+}
+
+static struct bootmeth_ops bls_bootmeth_ops = {
+	.check		= bls_check,
+	.read_bootflow	= bls_read_bootflow,
+	.read_file	= bootmeth_common_read_file,
+	.boot		= bls_boot,
+};
+
+static const struct udevice_id bls_bootmeth_ids[] = {
+	{ .compatible = "u-boot,bls" },
+	{ }
+};
+
+U_BOOT_DRIVER(bootmeth_bls) = {
+	.name		= "bootmeth_bls",
+	.id		= UCLASS_BOOTMETH,
+	.of_match	= bls_bootmeth_ids,
+	.ops		= &bls_bootmeth_ops,
+	.bind		= bls_bootmeth_bind,
+};

-- 
2.54.0

