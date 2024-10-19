Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CF87D3C91A
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:26:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD91289319;
	Sat, 19 Oct 2024 17:23:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TFQX9ogu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CE0E89334; Sat, 19 Oct 2024 17:23:04 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2EA3A8932C
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:23:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a3bd664ebaso10660385ab.2
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351381; x=1729956181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pFXbH39aA9Fd5uLoNMggvXZ87N0r5w/dF/0FQ5pN91c=;
 b=TFQX9oguYNE0OxVcqWlZ8ARNiciBNwecNqPQIlL2EOjJLBg/yHrzumGwKLd1xT36Re
 M4dGdfz1HMIQM3D0thGfXisTZ10XSpB4edbaBlzqX8BTwHDxZJKmtj46SotYJsP0Kg5a
 KZDMn5WyuhzuDp+6bm6m4/5hSqKTOtUs95Q3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351381; x=1729956181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pFXbH39aA9Fd5uLoNMggvXZ87N0r5w/dF/0FQ5pN91c=;
 b=KLEzFHOLTDJt+f6mK36pI1zVY0+auQpmsuGyWWU9/Y6QrCPPeO8vcu4/9IjAsZmeZF
 PU5pvimgVhDVltFqJm8BdvvXymI1reMwDO3a2kVq6m3yUZ1WxWvoWLZ38/577I5T5Anb
 g43XsMI+r6H2GtMXfdkamARid1r9g9DqVlKNSNrYKwRv1zicyaDZVWqnPrT/tiqFFPNA
 /uoPsi/xqgLEq8tmYRi599uFIMfPBbWg4NwCvwAsDxXUt31JZa9uGdebbc4EOMwVaCSa
 RWgkXi/2ACRB79NSnn72IFGYV3RePcnhnlgM4BK+CnrZvx43nM++S9Pylsf3ZcD1oLSR
 1ksw==
X-Gm-Message-State: AOJu0YzfxdfoVpCTLd6dNv/2WhnjOCX5qTpTk5kGhiwXICgu8hFJ/4HH
 a2tP6EcRe56WTi76K1kUKIKLSP5I+QLfoERdb//Ac5fN9lIvCz6retFHzX4FbVJ4+jl2T/hIdPE
 =
X-Google-Smtp-Source: AGHT+IGVwmc/mKW6BsEpCxIInOjWxIkDuFNZWd4YtCWmy5S+/PKblXbkQ+9uneKpV4atdw9diBE/LA==
X-Received: by 2002:a05:6e02:3c08:b0:3a0:8d2f:2914 with SMTP id
 e9e14a558f8ab-3a3f40b73camr55641795ab.23.1729351380795; 
 Sat, 19 Oct 2024 08:23:00 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:23:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>
Subject: [PATCH v2 27/31] boot: Update pxe bootmeth to record images
Date: Sat, 19 Oct 2024 09:22:07 -0600
Message-Id: <20241019152211.1014896-28-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241019152211.1014896-1-sjg@chromium.org>
References: <20241019152211.1014896-1-sjg@chromium.org>
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

Record images loaded by this bootmeth.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootmeth_pxe.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/boot/bootmeth_pxe.c b/boot/bootmeth_pxe.c
index b2873075ba5..d7b30d1c745 100644
--- a/boot/bootmeth_pxe.c
+++ b/boot/bootmeth_pxe.c
@@ -118,7 +118,8 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 {
 	char *tftp_argv[] = {"tftp", NULL, NULL, NULL};
 	struct pxe_context *ctx = dev_get_priv(dev);
-	char file_addr[17];
+	char file_addr[17], *fname;
+	struct bootflow_img *img;
 	ulong size;
 	int ret;
 
@@ -135,6 +136,17 @@ static int extlinux_pxe_read_file(struct udevice *dev, struct bootflow *bflow,
 		return log_msg_ret("spc", -ENOSPC);
 	*sizep = size;
 
+	fname = strdup(file_path);
+	if (!fname)
+		return log_msg_ret("pxf", -ENOMEM);
+	img = alist_add_placeholder(&bflow->images);
+	if (!img)
+		return log_msg_ret("pxi", -ENOMEM);
+	img->fname = fname;
+	img->type = type;
+	img->addr = addr;
+	img->size = size;
+
 	return 0;
 }
 
-- 
2.34.1

