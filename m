Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE512C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 00:37:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48F8878FC;
	Mon,  4 Dec 2023 01:33:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nv4LadRN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B11D878F6; Mon,  4 Dec 2023 01:33:21 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 292DF878FE
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 01:33:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3b845ba9ba9so2371656b6e.3
 for <u-boot@lists.denx.de>; Sun, 03 Dec 2023 16:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701649997; x=1702254797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wwqLIHwb8sQ0EYJy7Qi0o9oCao4TZnimJG9kjHtnV2U=;
 b=nv4LadRNpCSoIjl3B2+4nffaeCWQhkUx3fAPfVxNXgFGMsdlqbCJ473WJssi3Io9tl
 1Y6C+mtiT2Q1v7PIZGR/2np00tqBQrItMz3xLUPIfzMRhBRLD5fGXd37EIDC14Gw8Tnb
 ovP3uMDkM2LKXXnqbgX8WT+j1uShzynWtI9mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701649997; x=1702254797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wwqLIHwb8sQ0EYJy7Qi0o9oCao4TZnimJG9kjHtnV2U=;
 b=Tc/leIYKhwDfaVkm/6A1oEMOLntpzPEJI5ASjeyAPbha7hY8i/nuKGWVbKzQyKCe5B
 xWwbwAAShmBJc2vsQiDl6gZZjiNJkmeZKx/N+XuszvaCXRmsqSey3DI6nogSHZMkVp3S
 TXXiNCfQkhw5CBn6+XdcQrRd7tFaqxmULIeMhADeHJHiOpq70xlziSFUc3bMoWSODOjM
 SezEIPqPS66+7avHGI33fSmUqZuzAOfKkDeu2jvv6YpJQHxZTHnZsxLUvnvDlhyDyDQO
 YMUTnliD2gbEw5wIBO4rdDQ4XujeWyCNYlMje+FxUROXBBjtdn0bprzF4484eUD4C9eR
 KEfA==
X-Gm-Message-State: AOJu0Yz8jgyHh0kuC1cJV5Vk3O/pqHtN6KeD0y2E1rwK7WJfsaaxj0Ds
 hALSmrkWiqAcaNNBMf06o0uqv8/cTQMw1uef+2zHzg==
X-Google-Smtp-Source: AGHT+IFuSwtgxJRxZvjWhmMUcwTueKMOELHJmFPhlKZLJMJhYrBnwlOfXfPvJW8N6WYz3zO56Nw8Gg==
X-Received: by 2002:a05:6808:f90:b0:3b8:b063:adf9 with SMTP id
 o16-20020a0568080f9000b003b8b063adf9mr4462674oiw.86.1701649997748; 
 Sun, 03 Dec 2023 16:33:17 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 x13-20020aa79a4d000000b006cb9f436232sm6337525pfj.114.2023.12.03.16.33.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Dec 2023 16:33:17 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, Marek Vasut <marex@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ramon Fried <rfried.dev@gmail.com>, Sean Edmond <seanedmond@microsoft.com>
Subject: [PATCH 13/14] pxe: Allow booting without CMDLINE for the zboot method
Date: Sun,  3 Dec 2023 17:31:37 -0700
Message-ID: <20231204003144.899097-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231204003144.899097-1-sjg@chromium.org>
References: <20231204003144.899097-1-sjg@chromium.org>
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

Use zboot_run() to boot rather than the command line. This allows
extlinux to be used (on x86) without CMDLINE being enabled.

Collect any error but do not return it, to match the existing code.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 322ee93a2804..2bfd82e68b9b 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -568,10 +568,8 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 			  char *initrd_addr_str, char *initrd_filesize)
 {
 	struct bootm_info bmi;
-	char *zboot_argv[] = { "zboot", NULL, "0", NULL, NULL };
 	const char *fdt_addr;
 	ulong kernel_addr_r;
-	int zboot_argc = 3;
 	void *buf;
 	int ret;
 
@@ -624,16 +622,10 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	}
 
 	bmi.addr_fit = kernel_addr;
-	zboot_argv[1] = kernel_addr;
 
-	if (initrd_addr_str) {
+	if (initrd_addr_str)
 		bmi.conf_ramdisk = initrd_str;
 
-		zboot_argv[3] = initrd_addr_str;
-		zboot_argv[4] = initrd_filesize;
-		zboot_argc = 5;
-	}
-
 	if (!fdt_addr)
 		fdt_addr = env_get("fdt_addr");
 
@@ -658,8 +650,13 @@ static int label_run_boot(struct pxe_context *ctx, struct pxe_label *label,
 	else if (IS_ENABLED(CONFIG_BOOTM))
 		ret = bootz_run(&bmi);
 	/* Try booting an x86_64 Linux kernel image */
-	else if (IS_ENABLED(CONFIG_CMD_ZBOOT))
-		do_zboot_parent(ctx->cmdtp, 0, zboot_argc, zboot_argv, NULL);
+	else if (IS_ENABLED(CONFIG_ZBOOT))
+		ret = zboot_run(hextoul(kernel_addr, NULL), 0,
+				initrd_addr_str ?
+					hextoul(initrd_addr_str, NULL) : 0,
+				initrd_addr_str ?
+					hextoul(initrd_filesize, NULL) : 0,
+				0, NULL);
 
 	unmap_sysmem(buf);
 
-- 
2.43.0.rc2.451.g8631bc7472-goog

