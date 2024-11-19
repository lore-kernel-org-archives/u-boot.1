Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFCE0D44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:23:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C668954F;
	Tue, 19 Nov 2024 14:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hCOCauCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD14895FD; Tue, 19 Nov 2024 14:20:06 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F71C8959C
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-3a7750318a2so5300975ab.2
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022402; x=1732627202; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=82HT/ohfkcYVxPDW5AbJwT0krkEj9+VS58RVt1u0g9U=;
 b=hCOCauCNJ6khWIFiBtG0wguEA2bz/d7BAvfosV3u6WlqmFw1YezXVDfiJ1eG3gnBry
 6YmVLC401V49g+VT5IlgjoACPDWGYiD7w00U3pOZh2yZsTOTsWWWLBr9AY5Klgie2I/I
 Ex5Su5neIpaYypwC/I5gbO4SXmZQkJhj1n3v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022402; x=1732627202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=82HT/ohfkcYVxPDW5AbJwT0krkEj9+VS58RVt1u0g9U=;
 b=vUOJiUxVADitR6zgIfaERDAhIYMPrH8TKb5Dn/MIXKjxfNiqPkFv+NvMBIdEqtKEcY
 v3RjYcphFOuOZ+k9i4aUNH7UjcTVF1k+3MsLUOe5ykwXWmg1MymjuaWi/eCkv7o8YT31
 Q05WTclfX5zqC5BSXPBx0wGBvqKMTA/PINYDbjiPry3i/jC8nVgPfjm6Yyq3GA7bUkUG
 2OTIg6eaTDqmyqodAZdchvoRqMnZSfHGXEZow1CbeA827vyvWgZWdZHj0R7CRSgXSlFC
 rXhaD3pOctZ8cjjEDnNHkAyv5vO+Qnm7YhmlxGY/7qyC336nviwvPyzVIRXxolbbOEcs
 NMyA==
X-Gm-Message-State: AOJu0YwM09ErHVS3T0RtWkEURwzaDw6au8878m2kXPsVV/lIUjQzKUAb
 fDsXnLXFIaB69thTsH6y17joHogOonYrql/09EKjXesOYwL+tdRaXfLlKkcy7s9iTVkEIYTtqpo
 =
X-Google-Smtp-Source: AGHT+IE0kG9W6r2eKC/R3V5gWyAGeT3r2viRco8+Sti2dd5+EK4lYXb3ijpeDBhinF/vYh2rtb1/lw==
X-Received: by 2002:a05:6e02:1687:b0:3a6:b783:3c06 with SMTP id
 e9e14a558f8ab-3a74809275fmr168038785ab.19.1732022401796; 
 Tue, 19 Nov 2024 05:20:01 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:01 -0800 (PST)
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
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 26/39] pxe: Record the bootflow in the PXE context
Date: Tue, 19 Nov 2024 06:18:31 -0700
Message-Id: <20241119131844.4078144-27-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

 boot/bootmeth_extlinux.c | 2 +-
 boot/bootmeth_pxe.c      | 2 +-
 boot/pxe_utils.c         | 3 ++-
 cmd/pxe.c                | 4 ++--
 cmd/sysboot.c            | 2 +-
 include/pxe_utils.h      | 5 ++++-
 6 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/boot/bootmeth_extlinux.c b/boot/bootmeth_extlinux.c
index ac1efa48a91..9cc2032a201 100644
--- a/boot/bootmeth_extlinux.c
+++ b/boot/bootmeth_extlinux.c
@@ -186,7 +186,7 @@ static int extlinux_boot(struct udevice *dev, struct bootflow *bflow)
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
index 8c04f439441..b811406102b 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -1638,7 +1638,7 @@ void handle_pxe_menu(struct pxe_context *ctx, struct pxe_menu *cfg)
 
 int pxe_setup_ctx(struct pxe_context *ctx, pxe_getfile_func getfile,
 		  void *userdata, bool allow_abs_path, const char *bootfile,
-		  bool use_ipv6, bool use_fallback)
+		  bool use_ipv6, bool use_fallback, struct bootflow *bflow)
 {
 	const char *last_slash;
 	size_t path_len = 0;
@@ -1649,6 +1649,7 @@ int pxe_setup_ctx(struct pxe_context *ctx, pxe_getfile_func getfile,
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

