Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C15E77160
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 23:50:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23818964A;
	Wed,  4 Dec 2024 00:47:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KOJeXFTr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44B42896F2; Wed,  4 Dec 2024 00:47:28 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1194B88F55
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 00:47:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-8419ef7c2d8so203498639f.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 15:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733269644; x=1733874444; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3zXsbXJlPwih/+3PGs3kgtViG62jYklfxxJ4FA0jmQ=;
 b=KOJeXFTr7K9Z3LpxmYepqyBpnXT4Gucybjf9oXIFJffSgS5u9DRRHMHjtB79zE1667
 7bDTqbQGgpG2zkPc8/a3C91BHJIG63rXHi1x0CHeboEB/uIt381R5D7OX+tw7OUPGv68
 GPufEReDLKwcOhyuqFcJNBstsByWlF59ln9mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733269644; x=1733874444;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3zXsbXJlPwih/+3PGs3kgtViG62jYklfxxJ4FA0jmQ=;
 b=cT/5GmIS1wt+5ye1o4c9bW+iGjaOlm2/M8MIhMKj5+VZdig34C/9JCJ3Ds8Ncqu6b1
 46IsrEtluIYDqT2EVUgAjBoQ+ZQhrx+uv/XCtTacNEJ9lb4gGVV03Yrcts1dXMNFfNhe
 VfqM+Wh2hM4VdhzXMWC3aVRtlMksb1SlThSW4jkdpleRshX1gBhwmJDYkRNfQjoC3+VA
 EB7bl3ViBuI7m4aSoSkWn7lLji4FJJN/8snUGowfyUvzZFz+HfoPmd16mVvLPPABH+m5
 nUma8hzekEop4+neSddPPQz2XNlTby9va8SQDTn00lQh9Lbv6pgNFVa/LMbOKWu+Hx4y
 6Fyg==
X-Gm-Message-State: AOJu0Yy0VKbpArzua98UB39cJ6l8911L0nhrNn3BziKD+pcqgxkywB8d
 oH/GYRY1vVgf0Nof2ZwKFtm+oFKlzHhgQ088ufOr7k/4nG/O41z/L+nwgtjRX6WOtqd2iuOO3FY
 =
X-Gm-Gg: ASbGncvD8VbSnnHmi0ZkdkA5zGZLVOF/B8rB9lp18AJZTDU1UY3a9ohEuLJ5So3Z47y
 jb6zeHZT4NPBDNupjpaFcsiQ8GllRV9CtBgI0l5nlOJMbFSGFwrQ/ul0w4LRFd8okpIdGcOLRpn
 aEyAiM8tuK6Gy59Z/GcitBcKMpZF3px3gHdofDgjfW0YipACt1IgP72udmXPhyesxFuVq/ORovt
 OLJ3PHlsbpzqD0Pi9XJXT7Zw2RU3zPAxELM46MY70wKJxV3vyc1xcACVY+hlIOpMb3OkUKLLVus
 UnwrGCF16vU=
X-Google-Smtp-Source: AGHT+IGrfl/Y9txORH76lObxT9c1dF1wSBbSd30uWdIiVjF+by0vHogIoQXbmGf0Lz+MpGNlLmd8zw==
X-Received: by 2002:a05:6602:6420:b0:82c:d768:aa4d with SMTP id
 ca18e2360f4ac-8445b576592mr484094339f.9.1733269644298; 
 Tue, 03 Dec 2024 15:47:24 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405faf14fsm282349939f.42.2024.12.03.15.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 15:47:22 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v2 26/41] boot: Avoid using the cmdline in bootmeth_pxe and
 pxe cmd
Date: Tue,  3 Dec 2024 16:45:44 -0700
Message-Id: <20241203234559.2938192-27-sjg@chromium.org>
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

Use the new netboot_run() function to avoid building a command line,
when running these network operations.

For the one board which uses lwip, it is not quite clear how to avoid
using the cmdline interface, so produce an error, for now. This can be
figured out later.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_pxe.c | 16 ++++++----------
 cmd/pxe.c           | 21 +++++++--------------
 2 files changed, 13 insertions(+), 24 deletions(-)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index b91e61bcbc4..c6a132b8de2 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -116,21 +116,17 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 				  const char *file_path, ulong addr,
 				  enum bootflow_img_t type, ulong *sizep)
 {
-	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
-	struct pxe_context *ctx = dev_get_priv(dev);
-	char file_addr[17];
 	ulong size;
 	int ret;
 
-	sprintf(file_addr, "%lx", addr);
-	tftp_argv[1] = file_addr;
-	tftp_argv[2] = (void *)file_path;
-
-	if (do_tftpb(ctx->cmdtp, 0, 3, tftp_argv))
-		return -ENOENT;
-	ret = pxe_get_file_size(&size);
+	if (IS_ENABLED(CONFIG_NET_LWIP))
+		return -ENOTSUPP;
+	ret = netboot_run(TFTPGET, addr, file_path, 0, false);
 	if (ret)
 		return log_msg_ret("tftp", ret);
+	ret = pxe_get_file_size(&size);
+	if (ret)
+		return log_msg_ret("tft2", ret);
 	if (size > *sizep)
 		return log_msg_ret("spc", -ENOSPC);
 	*sizep = size;
diff --git a/cmd/pxe.c b/cmd/pxe.c
index 37b8dea6ad6..c69b8130423 100644
--- a/cmd/pxe.c
+++ b/cmd/pxe.c
@@ -29,25 +29,18 @@ const char *pxe_default_paths[] = {
 static int do_get_tftp(struct pxe_context *ctx, const char *file_path,
 		       char *file_addr, enum bootflow_img_t type, ulong *sizep)
 {
-	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
 	int ret;
-	int num_args;
 
-	tftp_argv[1] = file_addr;
-	tftp_argv[2] = (void *)file_path;
-	if (ctx->use_ipv6) {
-		tftp_argv[3] = USE_IP6_CMD_PARAM;
-		num_args = 4;
-	} else {
-		num_args = 3;
-	}
-
-	if (do_tftpb(ctx->cmdtp, 0, num_args, tftp_argv))
-		return -ENOENT;
+	if (IS_ENABLED(CONFIG_NET_LWIP))
+		return -ENOTSUPP;
+	ret = netboot_run(TFTPGET, hextoul(file_addr, NULL), file_path, 0,
+			  ctx->use_ipv6);
+	if (ret)
+		return log_msg_ret("tfp", ret);
 
 	ret = pxe_get_file_size(sizep);
 	if (ret)
-		return log_msg_ret("tftp", ret);
+		return log_msg_ret("tf2", ret);
 	ctx->pxe_file_size = *sizep;
 
 	return 1;
-- 
2.34.1

