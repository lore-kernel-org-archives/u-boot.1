Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E144E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDE58896F8;
	Wed,  4 Dec 2024 00:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KDMz6JaU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAEA188F55; Wed,  4 Dec 2024 00:47:34 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3745F896E9
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-8419ef7c2d8so203500839f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269650; x=1733874450; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5t7xGm9UIfOBvXsTAl+woWHVdKLR0fJi5PGeinfYoeo=;
 b=KDMz6JaUczN0iK51mSoN/ehVpqyyhwJXTS1SkKPsAzKQNS5l2P0PsFgdTNTbpBIiV4
 hxCa5mRzPFgfQoPXwpNKB7ddG8kUe9J0T/uvbII3RYpuZL9mGIqFhXzNOTDFInuF6rHE
 cteLOS13jFLLLc2ZK9EN1D+fbCIVHJ+odq4z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269650; x=1733874450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5t7xGm9UIfOBvXsTAl+woWHVdKLR0fJi5PGeinfYoeo=;
 b=I6fdTsL9E2QikqBQD6pNTq5z9Xf84/QOcyQVD1Nr+QTsTHZds/i7aDk01+AQK4nNTW
 mFOyWuCOJBBFQqyN/MrIvSLAZl5/uq/rhef4cOEMGeU45pVJZAKoWEKca/oRuEMp8TxH
 2AngCQdibwFtb2L70kIAZTb3EU8/gQK81DnTtaej7CJgwm0BjSj6lrkKHJtDZsBfnjWG
 s8aE2JXUSvYgaYfnwAg8nMNJoHSnTC8s+BzUJSMPLhjOHawOsrdN4PYrAcFf5+6Z1uV6
 tSiumoWjb77mEHoBqebIqDhlMsSBPT/mL3eXE5jZS/s0Va3N08WcJcW/tl7G/9z3bFd4
 /AQw==
X-Gm-Message-State: AOJu0Yy8X3U5GiMpMEYsz44P96e0eTJETaOu1UyBnWbuPDMBtQLxlLu4
 mACHVgDrJBlYJA+eHW4AquG6lj5O6XFxMIbPx2jPZAsu4YazHNSs56hhHQVJorAUTrTb/8m3uBk
 =
X-Gm-Gg: ASbGncvql1v7Uf6Jai+l7kHx7YfwA+Zt5qaXapDsdZ8lfXWnhMwl5Qzk9qWIYztlRqs
 gYHNR/qgHq/n4s6WYeIBWEDse41nuIV6YRaVHtoXA2rgyHtSHCqbjY5zElE65FYAOoLX54UBR05
 g3GvqiNJV91JKfCSagVtmWH9Uq6JRXU7QbwhhdVXh/gRgeSLAAn0PMtXmSlieFQokvE0IQgy05p
 LEiGt9QruVSVLyZWpPEOMoYJmYCwncTuPdfzejNa6MZSIK8UeubWoMHtTzbO1sq32ZEdFduKpJ8
 TyScC9aQcck=
X-Google-Smtp-Source: AGHT+IH0fLA2G6d3e7Cbk5GWKL/oIxaPmom87Esve5fJaEOb3x9JYe3k8V/YgukIjyP3ZhY4LlcgLQ==
X-Received: by 2002:a05:6602:6c14:b0:843:e4df:8a51 with SMTP id
 ca18e2360f4ac-8445b5cbee8mr584012739f.11.1733269650434; 
 Tue, 03 Dec 2024 15:47:30 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:29 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 28/41] pxe: Record the bootflow in the PXE context
Date: Tue,  3 Dec 2024 16:45:46 -0700
Message-Id: <20241203234559.2938192-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241203234559.2938192-1-sjg@chromium.org>
References: <20241203234559.2938192-1-sjg@chromium.org>
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

At present the only option with PXE is to boot it and see what happens.

Provide a bootflow, when available, so that PXE will eventually be able
to add some useful information to it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c | 2 +-
 boot/bootmeth_pxe.c      | 2 +-
 boot/pxe_utils.c         | 3 ++-
 cmd/pxe.c                | 4 ++--
 cmd/sysboot.c            | 2 +-
 include/pxe_utils.h      | 5 ++++-
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 4adcaf5654a..569f9d760bf 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -188,7 +188,7 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 	plat = dev_get_plat(dev);
 
 	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &info, true, bflow->fname,
-			    false, plat->use_fallback);
+			    false, plat->use_fallback, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index 59ebf1be83a..f2b9ffaae89 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -148,7 +148,7 @@ static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 	info.dev = dev;
 	info.bflow = bflow;
 	ret = pxe_setup_ctx(ctx, extlinux_pxe_getfile, &info, false,
-			    bflow->subdir, false, false);
+			    bflow->subdir, false, false, bflow);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index b4aa284b1ee..f7bbc1527af 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1632,7 +1632,7 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg)
 
 int pxe_setup_ctx(struct pxe_context *ctx, pxe_getfile_func getfile,
 		  void *userdata, bool allow_abs_path, const char *bootfile,
-		  bool use_ipv6, bool use_fallback)
+		  bool use_ipv6, bool use_fallback, struct bootflow *bflow)
 {
 	const char *last_slash;
 	size_t path_len = 0;
@@ -1643,6 +1643,7 @@ int pxe_setup_ctx(struct pxe_context *ctx, pxe_getfile_func getfile,
 	ctx->allow_abs_path = allow_abs_path;
 	ctx->use_ipv6 = use_ipv6;
 	ctx->use_fallback = use_fallback;
+	ctx->bflow = bflow;
 
 	/* figure out the boot directory, if there is one */
 	if (bootfile && strlen(bootfile) >= MAX_TFTP_PATH_LEN)
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 530d5d9c35b..7728949d14b 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -130,7 +130,7 @@ int pxe_get(ulong pxefile_addr_r, char **bootdirp, ulong *sizep, bool use_ipv6)
 	int i;
 
 	if (pxe_setup_ctx(&ctx, do_get_tftp, NULL, false, env_get("bootfile"),
-			  use_ipv6, false))
+			  use_ipv6, false, NULL))
 		return -ENOMEM;
 
 	if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION) &&
@@ -280,7 +280,7 @@ do_pxe_boot(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 	}
 
 	if (pxe_setup_ctx(&ctx, do_get_tftp, NULL, false, env_get("bootfile"),
-			  use_ipv6, false)) {
+			  use_ipv6, false, NULL)) {
 		printf("Out of memory\n");
 		return CMD_RET_FAILURE;
 	}
diff --git a/cmd/sysboot.c b/cmd/sysboot.c
index 6e899f381ec..384d5e15e3d 100644
--- a/cmd/sysboot.c
+++ b/cmd/sysboot.c
@@ -106,7 +106,7 @@ static int do_sysboot(struct cmd_tbl *cmdtp, int flag, int argc,
 	}
 
 	if (pxe_setup_ctx(&ctx, sysboot_read_file, &info, true, filename, false,
-			  false)) {
+			  false, NULL)) {
 		printf("Out of memory\n");
 		return CMD_RET_FAILURE;
 	}
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index fb057442d5d..e8e03430a81 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -109,6 +109,7 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
  * @use_ipv6: TRUE : use IPv6 addressing, FALSE : use IPv4 addressing
  * @use_fallback: TRUE : use "fallback" option as default, FALSE : use
  *	"default" option as default
+ * @bflow: Bootflow being booted, or NULL if none
  */
 struct pxe_context {
 	/**
@@ -129,6 +130,7 @@ struct pxe_context {
 	ulong pxe_file_size;
 	bool use_ipv6;
 	bool use_fallback;
+	struct bootflow *bflow;
 };
 
 /**
@@ -231,12 +233,13 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len);
  *                       other choice be selected
  *                FALSE : Use "default" option should no other choice be
  *                        selected
+ * @bflow: Bootflow to update, NULL if none
  * Return: 0 if OK, -ENOMEM if out of memory, -E2BIG if bootfile is larger than
  *	MAX_TFTP_PATH_LEN bytes
  */
 int pxe_setup_ctx(struct pxe_context *ctx, pxe_getfile_func getfile,
 		  void *userdata, bool allow_abs_path, const char *bootfile,
-		  bool use_ipv6, bool use_fallback);
+		  bool use_ipv6, bool use_fallback, struct bootflow *bflow);
 
 /**
  * pxe_destroy_ctx() - Destroy a PXE context
-- 
2.34.1

