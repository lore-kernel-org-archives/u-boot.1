Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FC73D4415C
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:22:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B594895F9;
	Tue, 19 Nov 2024 14:20:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QtXxAoHK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 832B48959C; Tue, 19 Nov 2024 14:20:00 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5DB0B8954F
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:19:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a73e045cf3so13722115ab.1
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022396; x=1732627196; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mq3BgmGmgxi1vU0C2llPKfdu0sGxZSceqZJC5l/T3dM=;
 b=QtXxAoHKzicjNccvfNbZg2zmL/6eDLZ8mohlJf1XHUz4S3rJUwYLkwlsN/pPv3o0eB
 g/uThNbbiDZyygI40ZLk7lVq1szGuKk9PuyzqDazfQfgTrRJgL/5u6RTU5Z3dz5OkkqV
 9vgazN7gNdk0glnG6b80ofvAUgq+7+gjp9fh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022396; x=1732627196;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mq3BgmGmgxi1vU0C2llPKfdu0sGxZSceqZJC5l/T3dM=;
 b=St7QehAi2V9ODFqTOcxKCaqOOuIX7bNYNxfjTH/VudKC5tGhKujD5jmH1l3IBu3Pt+
 FZDUbqbe8ygfNdpNlLVktJxiTzw86jAmEm/1Eoy8KdFQ2CK9SC7rT+QW1rfsF3lHLipc
 DiWW8yBIQbISz0yQR1Oi2ucF64fWNwl9GNKrz67qZQqlS3lmRGxYUYUSMfPXy5Hgll4t
 oMFtj2AFHQ/Pj2QjETMSa19Y0j4r6+0s1FDfNWAuyjHfq8und98axRyzUtKG0hzwsf/j
 2EamPg8Pz7YW6wMsCEXCGnrFxaJ+PmS9NxShV2h/Oemco/fkaQ/1przaq5ik1pBuM2id
 s66Q==
X-Gm-Message-State: AOJu0YxB/ve2Dz8Y7xLEu9QW0IYJj5zGx1Obffnf6xP5W3yxBm8MQX0J
 3Gjuf6q9vtucD6sIG3cJ8YEs1LpgSWYcB9HkzsZ9kwZc5GqLKA1CaLW6hIHGoK2NyM7xP2RJeac
 =
X-Google-Smtp-Source: AGHT+IF75YQU/aoQbfh6QC8MIeUfiXG1KoAEE5ER1P0mNm8VCSYy88YssfH3i5xEsr9HLpJc3z3RhQ==
X-Received: by 2002:a05:6e02:1d8d:b0:3a7:6825:409d with SMTP id
 e9e14a558f8ab-3a76825432emr85792295ab.0.1732022396566; 
 Tue, 19 Nov 2024 05:19:56 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:19:55 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 24/39] boot: Avoid using the cmdline in bootmeth_pxe and pxe
 cmd
Date: Tue, 19 Nov 2024 06:18:29 -0700
Message-Id: <20241119131844.4078144-25-sjg@chromium.org>
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

Use the new netboot_run() function to avoid building a command line,
when running these network operations.

For the one board which uses lwip, it is not quite clear how to avoid
using the cmdline interface, so produce an error, for now. This can be
figured out later.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

