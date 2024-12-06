Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63480E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:41:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7876F89771;
	Fri,  6 Dec 2024 03:37:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YHsh5ucF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35EBC89639; Fri,  6 Dec 2024 03:37:58 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D68AB89756
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-84198253281so100260239f.0
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452673; x=1734057473; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QbQTnlorlo8HeLSxopeHPSZBzVoPlqaLk5bDAWwbqc=;
 b=YHsh5ucFG0KN+sLx7xACK5DgltLYPOW9caCYnfJgmz8pE6atQ1iY/xeHg9lkQlojR6
 U8XJ/YAhHfKBNp9G6kDoaXeaxh62Gaf+W0NQhsugMRu1k1AipdpVvWRL6zHK54wfH/YT
 Rrp+VUTHgO+6mtXSwdevNz4FLhFWp3ZXtkM30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452673; x=1734057473;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4QbQTnlorlo8HeLSxopeHPSZBzVoPlqaLk5bDAWwbqc=;
 b=j8tQHGGfjs86BnQ7E1qj+mysh87ae0aIG06Fw9W0i1bmPtcPu/FdXevmHMCzO2FXcL
 AVzpF8p+E1Y6Pastn6yw6NLOm9wPLcXZE0i4Kn6kl6BfcjbZffPtH1Pnx6ovILxn13l0
 VQioMG2aPyQQugu281TqPQ/Ip4+9l0NAqmIuTqI7B4e8NiSlvvEwyEWaBCG1UotEiquS
 3VNDuTqVpDcnekQMFe/CtS7O9wjOigbSJZJV3bljIuxdmmSP2T38ufoea1WqgRo1rr49
 HYHWxvBSOwA8PAKqRlKonE6jksy6++ltyMyysLOyGDSpHNHurFETAua807vQ4/6NqkTP
 v3XQ==
X-Gm-Message-State: AOJu0Yz2IWKzeEnZx9jvXEZuIfImRzz4rZF7DgMDGLQvy247/OBMGKKC
 3cukeXVW2Icc6V9YClgNDYsI3dIUbplkSlEmC1RX+0bLW6ty1VknirYIvEv/Hnq3xKaNT71tMJQ
 =
X-Gm-Gg: ASbGnct9icQXj+nv9VntMtl9eg4wCZguYm1fbCaqby3zRljVRCM8mn12aEafR+URyek
 5u3kca/ukgL93vWORx9BYl5tG6IoFZTEFH+DtgRCFWC54FLqAZyjsUGDNE3jnRm1vc4AFZZleXO
 kmktkWamXG7B3yM0m8zDO1xz9SzATs4nlkkJzeO94nHU/8f8EKYP0mUgmPkPYWRglFr9KGbm19F
 ZXSlhUX4vPdbUkKoN/RSsGRpsAByhgkTWUAOdk0TgyUk6bXknAo+f73xzYyE9UJRbmXbOmmgbVn
 b9JIPAEycV4=
X-Google-Smtp-Source: AGHT+IHoZkOS0gnDni07tJa9ec7SrFDGxcpxgJfKWrf7gmntnACC4PmdwPsnpyHZfqvH1UF7vN/ijg==
X-Received: by 2002:a05:6602:15ca:b0:843:e9a6:fd1 with SMTP id
 ca18e2360f4ac-8447e1f99ffmr191865439f.1.1733452673443; 
 Thu, 05 Dec 2024 18:37:53 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:52 -0800 (PST)
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
 Nam Cao <namcao@linutronix.de>, Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH v3 31/46] pxe: Drop the cmdline parameter
Date: Thu,  5 Dec 2024 19:36:10 -0700
Message-Id: <20241206023626.2456858-32-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241206023626.2456858-1-sjg@chromium.org>
References: <20241206023626.2456858-1-sjg@chromium.org>
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

Now that PXE can operate without the command line, drop the parameter
throughout the code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_extlinux.c |  5 ++---
 boot/bootmeth_pxe.c      |  4 +---
 boot/pxe_utils.c         |  8 +++-----
 cmd/pxe.c                |  9 ++++-----
 cmd/sysboot.c            |  4 ++--
 include/extlinux.h       |  1 -
 include/pxe_utils.h      | 10 +++-------
 7 files changed, 15 insertions(+), 26 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index 17c6cebd2f4..4adcaf5654a 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -175,7 +175,6 @@ static int extlinux_read_bootflow(struct udevice *dev, struct bootflow *bflow)
 
 static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 {
-	struct cmd_tbl cmdtp = {};	/* dummy */
 	struct pxe_context ctx;
 	struct extlinux_info info;
 	struct extlinux_plat *plat;
@@ -188,8 +187,8 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
 
 	plat = dev_get_plat(dev);
 
-	ret = pxe_setup_ctx(&ctx, &cmdtp, extlinux_getfile, &info, true,
-			    bflow->fname, false, plat->use_fallback);
+	ret = pxe_setup_ctx(&ctx, extlinux_getfile, &info, true, bflow->fname,
+			    false, plat->use_fallback);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
 
diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index c6a132b8de2..59ebf1be83a 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -140,7 +140,6 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 {
 	struct pxe_context *ctx = dev_get_priv(dev);
-	struct cmd_tbl cmdtp = {};	/* dummy */
 	struct extlinux_info info;
 	ulong addr;
 	int ret;
@@ -148,8 +147,7 @@ static int extlinux_pxe_boot(struct udevice *dev, struct bootflow *bflow)
 	addr = map_to_sysmem(bflow->buf);
 	info.dev = dev;
 	info.bflow = bflow;
-	info.cmdtp = &cmdtp;
-	ret = pxe_setup_ctx(ctx, &cmdtp, extlinux_pxe_getfile, &info, false,
+	ret = pxe_setup_ctx(ctx, extlinux_pxe_getfile, &info, false,
 			    bflow->subdir, false, false);
 	if (ret)
 		return log_msg_ret("ctx", -EINVAL);
diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index a91372407eb..b4aa284b1ee 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1630,16 +1630,14 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg)
 	boot_unattempted_labels(ctx, cfg);
 }
 
-int pxe_setup_ctx(struct pxe_context *ctx, struct cmd_tbl *cmdtp,
-		  pxe_getfile_func getfile, void *userdata,
-		  bool allow_abs_path, const char *bootfile, bool use_ipv6,
-		  bool use_fallback)
+int pxe_setup_ctx(struct pxe_context *ctx, pxe_getfile_func getfile,
+		  void *userdata, bool allow_abs_path, const char *bootfile,
+		  bool use_ipv6, bool use_fallback)
 {
 	const char *last_slash;
 	size_t path_len = 0;
 
 	memset(ctx, '\0', sizeof(*ctx));
-	ctx->cmdtp = cmdtp;
 	ctx->getfile = getfile;
 	ctx->userdata = userdata;
 	ctx->allow_abs_path = allow_abs_path;
diff --git a/cmd/pxe.c b/cmd/pxe.c
index c69b8130423..530d5d9c35b 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -126,12 +126,11 @@ static int pxe_ipaddr_paths(struct pxe_context *ctx, unsigned long pxefile_addr_
 
 int pxe_get(ulong pxefile_addr_r, char **bootdirp, ulong *sizep, bool use_ipv6)
 {
-	struct cmd_tbl cmdtp[] = {};	/* dummy */
 	struct pxe_context ctx;
 	int i;
 
-	if (pxe_setup_ctx(&ctx, cmdtp, do_get_tftp, NULL, false,
-			  env_get("bootfile"), use_ipv6, false))
+	if (pxe_setup_ctx(&ctx, do_get_tftp, NULL, false, env_get("bootfile"),
+			  use_ipv6, false))
 		return -ENOMEM;
 
 	if (IS_ENABLED(CONFIG_BOOTP_PXE_DHCP_OPTION) &&
@@ -280,8 +279,8 @@ do_pxe_boot(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
 		return 1;
 	}
 
-	if (pxe_setup_ctx(&ctx, cmdtp, do_get_tftp, NULL, false,
-			  env_get("bootfile"), use_ipv6, false)) {
+	if (pxe_setup_ctx(&ctx, do_get_tftp, NULL, false, env_get("bootfile"),
+			  use_ipv6, false)) {
 		printf("Out of memory\n");
 		return CMD_RET_FAILURE;
 	}
diff --git a/cmd/sysboot.c b/cmd/sysboot.c
index 93d4a400830..6e899f381ec 100644
--- a/cmd/sysboot.c
+++ b/cmd/sysboot.c
@@ -105,8 +105,8 @@ static int do_sysboot(struct cmd_tbl *cmdtp, int flag, int argc,
 		return 1;
 	}
 
-	if (pxe_setup_ctx(&ctx, cmdtp, sysboot_read_file, &info, true,
-			  filename, false, false)) {
+	if (pxe_setup_ctx(&ctx, sysboot_read_file, &info, true, filename, false,
+			  false)) {
 		printf("Out of memory\n");
 		return CMD_RET_FAILURE;
 	}
diff --git a/include/extlinux.h b/include/extlinux.h
index 721ba46371c..6747fe01dda 100644
--- a/include/extlinux.h
+++ b/include/extlinux.h
@@ -18,7 +18,6 @@
 struct extlinux_info {
 	struct udevice *dev;
 	struct bootflow *bflow;
-	struct cmd_tbl *cmdtp;
 };
 
 #endif
diff --git a/include/pxe_utils.h b/include/pxe_utils.h
index 0378f2889f7..fb057442d5d 100644
--- a/include/pxe_utils.h
+++ b/include/pxe_utils.h
@@ -100,7 +100,6 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
 /**
  * struct pxe_context - context information for PXE parsing
  *
- * @cmdtp: Pointer to command table to use when calling other commands
  * @getfile: Function called by PXE to read a file
  * @userdata: Data the caller requires for @getfile
  * @allow_abs_path: true to allow absolute paths
@@ -112,7 +111,6 @@ typedef int (*pxe_getfile_func)(struct pxe_context *ctx, const char *file_path,
  *	"default" option as default
  */
 struct pxe_context {
-	struct cmd_tbl *cmdtp;
 	/**
 	 * getfile() - read a file
 	 *
@@ -222,7 +220,6 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len);
  * pxe_setup_ctx() - Setup a new PXE context
  *
  * @ctx: Context to set up
- * @cmdtp: Command table entry which started this action
  * @getfile: Function to call to read a file
  * @userdata: Data the caller requires for @getfile - stored in ctx->userdata
  * @allow_abs_path: true to allow absolute paths
@@ -237,10 +234,9 @@ int format_mac_pxe(char *outbuf, size_t outbuf_len);
  * Return: 0 if OK, -ENOMEM if out of memory, -E2BIG if bootfile is larger than
  *	MAX_TFTP_PATH_LEN bytes
  */
-int pxe_setup_ctx(struct pxe_context *ctx, struct cmd_tbl *cmdtp,
-		  pxe_getfile_func getfile, void *userdata,
-		  bool allow_abs_path, const char *bootfile, bool use_ipv6,
-		  bool use_fallback);
+int pxe_setup_ctx(struct pxe_context *ctx, pxe_getfile_func getfile,
+		  void *userdata, bool allow_abs_path, const char *bootfile,
+		  bool use_ipv6, bool use_fallback);
 
 /**
  * pxe_destroy_ctx() - Destroy a PXE context
-- 
2.34.1

