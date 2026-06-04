Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FE1BCD6E6D
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 15:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30E6284999;
	Thu,  4 Jun 2026 17:31:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="yOD3EctX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 793198484F; Thu,  4 Jun 2026 17:31:35 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E101784979
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 17:31:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so710823f8f.0
 for <u-boot@lists.denx.de>; Thu, 04 Jun 2026 08:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1780587092; x=1781191892; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=26cXWugwaIvD44MHKRLRmV3qox4LHzsXpOSyroQw2eg=;
 b=yOD3EctX6BZzlVXP9/sDmknSfztliZHpCuNaf8vRoiH2VXzhBuCmGZzRr9RwdKOIGJ
 uXzyOGQtOALpS5nd0AZbsFKnOqVRS5JnPsgfGak89GlT8D7yK28LFco4bHcTD8IGUdI8
 wuHezjptxxgIgsRvIb8zBPI2c+9EO+U5eHYZG8cGQ0cY9Zk4Tcz7XAWF52fN5H/WLc11
 PDF9HVB2jl/Niekp6+P7LURj88wGNZ8Dqt6O3WiwDngnKCEz+x7vDLkJWpVpX/o/t7Le
 juxFQU7OHQHe2pAJDLDaF4Ygk+swQsAxaAc8o0Gs+xZbjA0Wd3BMgUOxiXAiDhIlhuT8
 DOhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780587092; x=1781191892;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=26cXWugwaIvD44MHKRLRmV3qox4LHzsXpOSyroQw2eg=;
 b=gzilgAIc3v059XHunu7jj/bCEP2thSeGbT3dKxGwn0CcRKI3dlGN5QiwOM4BA08JbS
 JNZoew+iQVQX1909X0/qJheIsCkGNrTzGuOqxLjw84dc0qJQJt8YPnKEylA6tjPHeM3m
 HLiUPtYehxuNJ1c5REfcUm5ecl1MlnoEaiJrQ5wBcHq8QCrbTW+GXX1uF7rY1luqEZ+i
 SD5PX4Chvl5PGJWKJdHrn5S+tHdZKKTwaUXtHseIfTsLewTJKKU9xpNxciI9+3X2CF8G
 vJxn3QMqElX63DwZkTAK86a/OvcsGBXp4Z1NI5IWsCpUbH4xFNiO0X0Rh08YKh+eGQPO
 a6vg==
X-Gm-Message-State: AOJu0YwCPwvzRv/mZs2fVumWCPizvmjeeoeaet9Z1wYPILP93HtKCRht
 FDOY0ZCvESOmBQKdaBoirxlM0ruj+MwUPohGa9mSmyww2ej51SgyhIVxHlo4jlZIU3+5JFEXRQp
 cUPjBBq0=
X-Gm-Gg: Acq92OGx9d5KvS3zhKRCJZOPwiDqIBzawvKthYOJBOdRgYVTL/yZTvR7cw/Rnaah+J1
 JUw55tBl0SJ4nDdtUf+6VMVLi2uiLLOn4uRcQBa8kWKfKGWZXdj+B1n4q8/1zrYsaFm9I2hGtI3
 a6WnX+QlX6CgMYqId+5jq+A+gR1Unml2J5lkbp2/OJtw8vb9cLe+FzEizQ892ZxduJIRKMxWmNt
 gtu5eQAHnw2tBhuKdBx7GucoOIA8V92yjazHx8t9jxEMf5zSveQtSk9aRe+m3EJ/mt+bA5Z88j8
 0tMMvAt+/d00/cRUGCNDEqCxVAoZKnUaAHVXiChlNxBtnwuPsF8Wj5pfCX6xbqrO3benBEKcE3L
 w7E1WYX1JG2woUtAt4s8lz1RmyUzw74YbSzF2L1OzSux7Rx/sYn9T2OZSt8yF/crNPWJB9fXGQt
 XVa7LnvgsVggr2VccJRuL0GSBOmooXH3miJ1u0kmRk28BEu5J7r80=
X-Received: by 2002:a05:6000:610:b0:45e:f867:39bd with SMTP id
 ffacd0b85a97d-4602197d68cmr14055656f8f.36.1780587092141; 
 Thu, 04 Jun 2026 08:31:32 -0700 (PDT)
Received: from alchark-surface.localdomain ([5.194.92.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f351ac0sm28284932f8f.27.2026.06.04.08.31.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 08:31:31 -0700 (PDT)
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 04 Jun 2026 19:31:12 +0400
Subject: [PATCH 7/7] boot: add a minimal bootmeth for the Boot Loader
 Specification
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260604-bls-v1-7-4ce6d1ee4711@flipper.net>
References: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
In-Reply-To: <20260604-bls-v1-0-4ce6d1ee4711@flipper.net>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Simon Glass <sjg@chromium.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Anshul Dalal <anshuld@ti.com>, 
 Peng Fan <peng.fan@nxp.com>, Martin Schwan <m.schwan@phytec.de>, 
 Daniel Golle <daniel@makrotopia.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Alexey Charkov <alchark@flipper.net>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=12522; i=alchark@flipper.net; 
 h=from:subject:message-id;
 bh=41QCFAz5ohXdy6HYm2/+W2E6N0SUVQtZ1SrRgJL3HR8=; 
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWQpzrJ/oFTRtDm1lK3tYVWHjU+zyYeE148+vdDynDbNT
 rxPV8SqYyILgxgXg6WYIsvcb0tspxrxzdrl4fEVZg4rE8gQaZEGBiBgYeDLTcwrNdIx0jPVNtQz
 NNIx1jFi4OIUgKnOYGVkWP8iP2G+/lcj8VvXJq7JeGd81pCVSecyX8xHpikyjYvPODD8r1ymlXe
 6PHAC4081vzcHJRZJrtgxZ3L5Dak1z5vPZn2SZgIA
X-Developer-Key: i=alchark@flipper.net; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
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

Type #2 BLS (drop-in directory of EFI binaries) is out of scope here;
existing EFI bootmeths cover that use case.

[1] https://uapi-group.org/specifications/specs/boot_loader_specification/

Signed-off-by: Alexey Charkov <alchark@flipper.net>
---
 boot/Kconfig        |  17 +++
 boot/Makefile       |   1 +
 boot/bootmeth_bls.c | 333 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 351 insertions(+)

diff --git a/boot/Kconfig b/boot/Kconfig
index e1114aea843e..fa871da46640 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -636,6 +636,23 @@ config BOOTMETH_EXTLINUX_PXE
 
 	  This provides a way to try out standard boot on an existing boot flow.
 
+config BOOTMETH_BLS
+	bool "Bootdev support for Boot Loader Specification entries"
+	select PXE_UTILS
+	default y
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
index 7fb56e7ef379..0ce6fd1cd050 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_$(PHASE_)BOOTSTD_PROG) += prog_boot.o
 
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX) += bootmeth_extlinux.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EXTLINUX_PXE) += bootmeth_pxe.o
+obj-$(CONFIG_$(PHASE_)BOOTMETH_BLS) += bootmeth_bls.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_EFILOADER) += bootmeth_efi.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_CROS) += bootm.o bootm_os.o bootmeth_cros.o
 obj-$(CONFIG_$(PHASE_)BOOTMETH_QFW) += bootmeth_qfw.o
diff --git a/boot/bootmeth_bls.c b/boot/bootmeth_bls.c
new file mode 100644
index 000000000000..3df4f20a11dd
--- /dev/null
+++ b/boot/bootmeth_bls.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0+
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
+static int bls_getfile(struct pxe_context *ctx, const char *file_path,
+		       char *file_addr, enum bootflow_img_t type, ulong *sizep)
+{
+	struct extlinux_info *info = ctx->userdata;
+	ulong addr;
+	int ret;
+
+	addr = simple_strtoul(file_addr, NULL, 16);
+
+	/* Allow up to 1GB */
+	*sizep = 1 << 30;
+	ret = bootmeth_read_file(info->dev, info->bflow, file_path, addr,
+				 type, sizep);
+	if (ret)
+		return log_msg_ret("read", ret);
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
+ * The spec leaves ordering between prefixes unspecified; comparing full
+ * paths is a deterministic-and-cheap stand-in.
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
+ * @prefixes:	NULL-terminated array of bootstd prefixes to search
+ * @desc:	Block descriptor (used to re-mount per prefix)
+ * @bflow:	Bootflow being populated (used to re-mount per prefix)
+ * @fullp:	Returns the chosen full path (allocated), or NULL if none
+ * Return: 0 on success, -ENOENT if no entry was found, < 0 on other error
+ */
+static int bls_pick_entry(const char *const *prefixes, struct blk_desc *desc,
+			  struct bootflow *bflow, char **fullp)
+{
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
+	struct blk_desc *desc;
+	const char *const *prefixes;
+	struct udevice *bootstd;
+	struct pxe_label *label = NULL;
+	struct pxe_menu scratch = {};
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
+	ret = bootmeth_alloc_file(bflow, SZ_64K, 1, BFI_EXTLINUX_CFG);
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
+	bflow->bootmeth_priv = label;
+	free(fpath);
+
+	return 0;
+
+err:
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
+	struct pxe_label *label = bflow->bootmeth_priv;
+	int ret;
+
+	if (!label)
+		return log_msg_ret("lbl", -ENOENT);
+
+	info.dev = dev;
+	info.bflow = bflow;
+
+	/*
+	 * BLS paths are absolute relative to the filesystem root of the
+	 * partition the entry lives on. allow_abs_path=true honours that;
+	 * passing NULL as the bootfile keeps the prefix empty so absolute
+	 * paths are not rebased.
+	 */
+	ret = pxe_setup_ctx(&ctx, &cmdtp, bls_getfile, &info, true,
+			    NULL, false, false);
+	if (ret)
+		return log_msg_ret("ctx", -EINVAL);
+
+	ret = label_boot(&ctx, label);
+	pxe_destroy_ctx(&ctx);
+	if (ret)
+		return log_msg_ret("boot", -EINVAL);
+
+	return 0;
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
+U_BOOT_DRIVER(bootmeth_2bls) = {
+	.name		= "bootmeth_bls",
+	.id		= UCLASS_BOOTMETH,
+	.of_match	= bls_bootmeth_ids,
+	.ops		= &bls_bootmeth_ops,
+	.bind		= bls_bootmeth_bind,
+};

-- 
2.53.0

