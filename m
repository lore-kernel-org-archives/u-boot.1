Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092E6E7716E
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 02:41:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 199FF8975C;
	Fri,  6 Dec 2024 03:37:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QnNMgtQM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0517F8918C; Fri,  6 Dec 2024 03:37:56 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C236E896BB
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 03:37:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-84183532291so108514239f.2
 for <u-boot@lists.denx.de>; Thu, 05 Dec 2024 18:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733452671; x=1734057471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j3zXsbXJlPwih/+3PGs3kgtViG62jYklfxxJ4FA0jmQ=;
 b=QnNMgtQMUoQOtMCvDaUiZQTsz+TM61Yc7wfA2BM3Fsb+5ZroxBEqgtg1aGcE5WDGdP
 0b3xKMsuHdbFCJx8nVrI/Zm/FCDoUAUW7fO5mG89vZoxGAh+D2YoCgtICafkmlyrkea8
 sBz9wcBlFpxolNWjAmQsz+dDeXg/qH2jcyZsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733452671; x=1734057471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j3zXsbXJlPwih/+3PGs3kgtViG62jYklfxxJ4FA0jmQ=;
 b=Yr3cf6P2cEUIa6Ll0iNAw+8XE8SbPtHQJKJh0GplK3D8T/b3QuaywyAQICtlDdJFQg
 x6uULToNT1HL47YRhvVBX5mjm1l8DleAJN0TR2QQwVW7xSeyR/UHlMCtpMGnDWKOIUpg
 uNa8uwGYHQGk4h/R5Gl0gfqXr4YccfSR2nyCiHWY0YuphTcVg7RMxB4PLQCTZ+WqJALj
 Mklif6wMRZtilVNZbNeJ4ouuDd+sCc9hF9NGOepWuQNHADfF73a3WjQAKY1XqO+HMEcO
 nlJaiF8dxImKX1+hQvsZPX572o30H/tAANntJxgccutWFqI1EtT1m5bC4qeIk1w8gpma
 rlwA==
X-Gm-Message-State: AOJu0YwVOv/63Ivy1p3QXmXHjGHP+rzQ/AiA+qZpljAqfOXtN6yp3Ata
 pS80mW58qGqlf2oWdBNPSg4pvqktaVqnoe0To11r+zaf3RAC3hbvyAsK36rkm0JuXITgWD8OWHY
 =
X-Gm-Gg: ASbGncsDteOI9tJLK/QC0El3j2zU4v59mecsZwZrFcJW61XiK1RwJ1z1IEj8SGoU+7F
 vNSmZPr+4j4MyBKn34ow9GfwG/pHjzkQoaV6NdSWX6Q91vFdrqbRTWGHNiKKj/sSJSDu764TBTM
 eqNETKyfmTMHZC9GK0MBSzWussoFb8V65XCfvgaNM7z9stXujsTF0IYDC+ZFUKux/rmVgCJjNsJ
 vLYjLwcLAhpGE6qEW9o0i0pi6alIg81i4XyJ/Yq6AVbRTR8UuEi/Ds7McjNNxT9ssFm8dPcg39x
 j6wgTro3s1w=
X-Google-Smtp-Source: AGHT+IHdkZDa/f5Ds4R3YjhW1mCFBY3MlH4zyK9YzcZ0oM/yHyO3QVh4Hj31WykQ549EBoKTk3jMaQ==
X-Received: by 2002:a05:6602:6011:b0:842:ff2d:c3d9 with SMTP id
 ca18e2360f4ac-8447e204c01mr214782639f.4.1733452671649; 
 Thu, 05 Dec 2024 18:37:51 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e2861f51bfsm575506173.112.2024.12.05.18.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 18:37:50 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH v3 30/46] boot: Avoid using the cmdline in bootmeth_pxe and
 pxe cmd
Date: Thu,  5 Dec 2024 19:36:09 -0700
Message-Id: <20241206023626.2456858-31-sjg@chromium.org>
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

