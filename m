Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA446E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC0CB896C7;
	Fri,  6 Dec 2024 03:38:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IKUZeAa6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E7389772; Fri,  6 Dec 2024 03:38:03 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3819A89753
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-843e9db3e65so61427139f.1
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452676; x=1734057476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5t7xGm9UIfOBvXsTAl+woWHVdKLR0fJi5PGeinfYoeo=;
 b=IKUZeAa6Bkp30V4/5JkOuoWE8uMNeoVKJ7pP1Eiy7nmAy1g8UQ2xX3/5DoVo9kckrF
 /4mNe9AWJ7J7EVb/LJf4RQg5B2MYGegd2uGDZ35CoUVrMLQkI4yvtwAPLnM9LumRSTGj
 o36MLEnJaXtB0NDzAyasnVaRsXffc+uvcPetU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452676; x=1734057476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5t7xGm9UIfOBvXsTAl+woWHVdKLR0fJi5PGeinfYoeo=;
 b=qHeJySz7JrJVI+aZdelE3RxMtvXk4lds2ZXZ7X4G+oianw1YxH/rmPoAmWOj2cG13x
 1kPNzZn/gc335dur8GKd0mYwO1ETWgzR7H0D03rAOYhjKWyG9CXoZwo2R6LrpguHoj6c
 JWswGPSpcF6j41EsM7LKlAQcPGDmd8LAmwEHQYWMwjkt/eilkw2qpeXT/At/lvktjMVo
 GoWgTL3Fb2khd3Q2ADTj7UUZwLWaLGBSoheaofWy7qIDMSbznrICzcsy9T8qi7S8hQz9
 /kuXGz1In6w8lQXQyRsebGNycT0UJTJem+zeA0NM8sYQeiOTlu7K3ABNJk+57bXpY9ZS
 THpg==
X-Gm-Message-State: AOJu0YyZQA8jMmthhH7VvFPKws/rH0prCxN8PuKPw73Dzy3NbP8timab
 vng3m3eyLvz5xJpjr5yTQqK7afkC/y6PQ/GtIDnpTm4nbOOsPK/g13qZXBYqRIDNFbpH3TW3kfA
 =
X-Gm-Gg: ASbGnct0Jh/LhWUNf89k2I32xd97mpGYWM060jCrgHnsxoiLoof/RBzGxy8094dHK02
 UusSF6dacF2TaT2+7usa5dob/R0wW3H3isCVW3QxSZaVPOL8Ys4UxcEn0UlPuwElA9Z1ARs+rlc
 4ji07g9O8zM7KUuArlNOZrv8mFipWgO3N4KbzmojG3tvcqmmd8uerRxrSgfLWAI3vyHroXiNF3i
 6Pe6s/44dJUtUrGPpgw7+dUT3ExptoMzfQHAoKH2gORA9vklgqpNKNipxv841+DVmdtED0Agiip
 hrzeHXxy5m4=
X-Google-Smtp-Source: AGHT+IEwguCQ5mmqxKh9KYqML6VaTpKl+6VPWvp6T7XoIojxt29os0VI7L+/3Or4dAbHEiwp/v6XXQ==
X-Received: by 2002:a6b:6210:0:b0:844:2ef3:a95a with SMTP id
 ca18e2360f4ac-84471100818mr569269539f.7.1733452676433; 
 Thu, 05 Dec 2024 18:37:56 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:55 -0800 (PST)
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
Subject: [PATCH v3 32/46] pxe: Record the bootflow in the PXE context
Date: Thu,  5 Dec 2024 19:36:11 -0700
Message-Id: <20241206023626.2456858-33-sjg@chromium.org>
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

