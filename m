Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D65CF6D24
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 13:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1645589012;
	Wed,  2 Oct 2024 15:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Y9q67zqG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3A23890BA; Wed,  2 Oct 2024 15:26:46 +0200 (CEST)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74CA188FEC
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 15:26:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=martyn.welch@collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1727875603;
 bh=YmRY9dwEVCGicxB4Ju836kfn3oTgfjgJQV5Ksm7O0MA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y9q67zqG3eJR3EhzC5xhe3UlJSxYvrCuDWZb2UT2IJZBQfJ60bDZqYjWD1xzUzrt4
 5Qhebu+ClZVqcAk5har8ERM+AWfSwFuzf4RxkKSKwS7P+tKRDjeqKPeV4LSaIILhOj
 QTnmrOwwt/xk17Za+LD3hcpYdHRd1FEj2a6knVg9sTzGAyQWnHD6csiwvWOVePdNid
 zZ+dNztJ4xF025Vq54taETBCX0+66IyZXt2UnyyeNKfR/2STc6huFVV69EFeCnMlXC
 8IyFXs3Dhi5oQCdRoPW4XEVAETyzyqqNcEmhvo+/QIfOGAINHE0xa9U7mtlIDvaO3P
 Yru2I95QBqAbA==
Received: from pan.lan (unknown [IPv6:2a00:23c6:c32f:9100::16d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: martyn)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id E31D917E35F0;
 Wed,  2 Oct 2024 15:26:42 +0200 (CEST)
From: Martyn Welch <martyn.welch@collabora.com>
To: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de,
	Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH 2/4] boot: Add logic to enable booting from fallback option
Date: Wed,  2 Oct 2024 14:26:31 +0100
Message-ID: <20241002132633.246942-2-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002132633.246942-1-martyn.welch@collabora.com>
References: <20241002132633.246942-1-martyn.welch@collabora.com>
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

The "fallback" extlinux config option allows us to set an alternative
default boot option for when it has been detected that the default is
failing. Implement the logic required to boot from this option when
desired.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 boot/bootmeth_extlinux.c |  2 +-
 boot/bootmeth_pxe.c      |  2 +-
 boot/pxe_utils.c         | 14 +++++++++++++-
 cmd/pxe.c                |  4 ++--
 cmd/sysboot.c            |  2 +-
 include/pxe_utils.h      | 10 +++++++++-
 6 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index fbb05ef928..26c61a65e2 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -149,7 +149,7 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 	info.dev = dev;
 	info.bflow = bflow;
 	ret = pxe_setup_ctx(&ctx, &cmdtp, extlinux_getfile, &info, true,
-			    bflow->fname, false);
+			    bflow->fname, false, false);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 03d2589c26..05c6bece2c 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -150,7 +150,7 @@ static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 	info.bflow = bflow;
 	info.cmdtp = &cmdtp;
 	ret = pxe_setup_ctx(ctx, &cmdtp, extlinux_pxe_getfile, &info, false,
-			    bflow->subdir, false);
+			    bflow->subdir, false, false);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a80119c9a3..d6a4b2cb85 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1436,6 +1436,16 @@ struct pxe_menu *parse_pxefile(struct pxe_context *ctx, unsigned long menucfg)
 
 	buf = map_sysmem(menucfg, 0);
 	r = parse_pxefile_top(ctx, buf, menucfg, cfg, 1);
+
+	if (ctx->use_fallback) {
+		if (cfg->fallback_label) {
+			printf("Setting use of fallback\n");
+			cfg->default_label = cfg->fallback_label;
+		} else {
+			printf("Selected fallback option, but not set\n");
+		}
+	}
+
 	unmap_sysmem(buf);
 	if (r < 0) {
 		destroy_pxe_menu(cfg);
@@ -1586,7 +1596,8 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg)
 
 int pxe_setup_ctx(struct pxe_context *ctx, struct cmd_tbl *cmdtp,
 		  pxe_getfile_func getfile, void *userdata,
-		  bool allow_abs_path, const char *bootfile, bool use_ipv6)
+		  bool allow_abs_path, const char *bootfile, bool use_ipv6,
+		  bool use_fallback)
 {
 	const char *last_slash;
 	size_t path_len = 0;
@@ -1597,6 +1608,7 @@ int pxe_setup_ctx(struct pxe_context *ctx, struct cmd_tbl *cmdtp,
 	ctx->userdata = userdata;
 	ctx->allow_abs_path = allow_abs_path;
 	ctx->use_ipv6 = use_ipv6;
+	ctx->use_fallback = use_fallback;
 
 	/* figure out the boot directory, if there is one */
 	if (bootfile && strlen(bootfile) >= MAX_TFTP_PATH_LEN)
diff --git a/cmd/pxe.c b/cmd/pxe.c
index ae02c28c07..982e2b1e7e 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -138,7 +138,7 @@ int pxe_get(ulong pxefile_addr_r, char **bootdirp, ulong *sizep, bool use_ipv6)
 	int i;
 
 	if (pxe_setup_ctx(&ctx, cmdtp, do_get_tftp, NULL, false,
-			  env_get("bootfile"), use_ipv6))
+			  env_get("bootfile"), use_ipv6, false))
 		return -ENOMEM;
 
 	if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION) &&
@@ -288,7 +288,7 @@ do_pxe_boot(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (pxe_setup_ctx(&ctx, cmdtp, do_get_tftp, NULL, false,
-			  env_get("bootfile"), use_ipv6)) {
+			  env_get("bootfile"), use_ipv6, false)) {
 		printf("Out of memory\n");
 		return CMD_RET_FAILURE;
 	}
diff --git a/cmd/sysboot.c b/cmd/sysboot.c
index 0ea08fd7b5..8a060780ca 100644
--- a/cmd/sysboot.c
+++ b/cmd/sysboot.c
@@ -105,7 +105,7 @@ static int do_sysboot(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	if (pxe_setup_ctx(&ctx, cmdtp, sysboot_read_file, &info, true,
-			  filename, false)) {
+			  filename, false, false)) {
 		printf("Out of memory\n");
 		return CMD_RET_FAILURE;
 	}
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index a408fb7f13..68ac40b64a 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -96,6 +96,8 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
  *	allocated
  * @pxe_file_size: Size of the PXE file
  * @use_ipv6: TRUE : use IPv6 addressing, FALSE : use IPv4 addressing
+ * @use_fallback: TRUE : use "fallback" option as default, FALSE : use
+ *	"default" option as default
  */
 struct pxe_context {
 	struct cmd_tbl *cmdtp;
@@ -116,6 +118,7 @@ struct pxe_context {
 	char *bootdir;
 	ulong pxe_file_size;
 	bool use_ipv6;
+	bool use_fallback;
 };
 
 /**
@@ -215,12 +218,17 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len);
  *	none
  * @use_ipv6: TRUE : use IPv6 addressing
  *            FALSE : use IPv4 addressing
+ * @use_fallback: TRUE : Use "fallback" option instead of "default" should no
+ *                       other choice be selected
+ *                FALSE : Use "default" option should no other choice be
+ *                        selected
  * Return: 0 if OK, -ENOMEM if out of memory, -E2BIG if bootfile is larger than
  *	MAX_TFTP_PATH_LEN bytes
  */
 int pxe_setup_ctx(struct pxe_context *ctx, struct cmd_tbl *cmdtp,
 		  pxe_getfile_func getfile, void *userdata,
-		  bool allow_abs_path, const char *bootfile, bool use_ipv6);
+		  bool allow_abs_path, const char *bootfile, bool use_ipv6,
+		  bool use_fallback);
 
 /**
  * pxe_destroy_ctx() - Destroy a PXE context
-- 
2.45.2

