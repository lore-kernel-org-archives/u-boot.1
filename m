Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B3AD1BDD4
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 17:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7633E88F77;
	Mon,  4 Nov 2024 18:51:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MQzME04h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B74F089000; Mon,  4 Nov 2024 18:51:36 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D25888F33
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 18:51:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-83a9be2c028so160070239f.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 09:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730742692; x=1731347492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EKhIcjVMfXAKRslJ66d+YfkbNUBgL5LHMgvcVlGlgf0=;
 b=MQzME04h9QvJe5IRAKcHcKRqIkRWnCjDvtIJiTD4V2mw3rPIMmcyLZoVJdXHsdXV0D
 p9QbsL8Bzz48xefuh9bXKeBdt/NfVLJlvjfF4daoLYL9Hf1gQROaTnodU1FJQ85Uaw42
 1hcu9b7Js9d28P797TkISBqjvqwfMNvown7EE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730742692; x=1731347492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EKhIcjVMfXAKRslJ66d+YfkbNUBgL5LHMgvcVlGlgf0=;
 b=ntSti0Ijxfrel8rpx8ISxjUIxy3NLgaolr7q6aoMASMe8S5GEnGEK/bI0VTg1E0ca7
 yotRAKjJXyRgSXsFozWV6xRnH28sCWxxjFw9thLIthluBFtSE1/XVwYgg+t2AlM3GnJd
 6sMsqc+JK2JwxUl9L0BL5/3TfnrLGx3r5jkeuy0Iz76bn3qEOZAEEL1WIh2/4ARc1JFE
 05TLz12SuL3Nda8QLs31DhwxBcZ6T8kCtJQmTWhhePaRn9Aw1IPN8yn5Xzzj1CPdiedp
 9f8KvEBMtomOWdGI6zu65mZOxKIrxNs2pS43ntaq4ZkQwUrFkcmVb87I+1sJNbIqB4D5
 c8kQ==
X-Gm-Message-State: AOJu0Yxeb3z7iooWMOkHgZ2pLm4zFIRsbWmY5tYmWQMm+SQ0SVOGDDMP
 dziCxG4XAMlTxdGoxBnTcInMnWdidclya1nCvjkCn6Tm9kL3jB4WWrcTR3ZSJo8HpisnIQMzir4
 =
X-Google-Smtp-Source: AGHT+IELumE7nPN8PkNnb8+Uv7AZzKPqoZM3Yeo1Hbs3B5w2m27r+qYNjYnNoe1FUB/2I2oClIkcSg==
X-Received: by 2002:a05:6602:1508:b0:83a:b33a:5e08 with SMTP id
 ca18e2360f4ac-83b719f3db1mr1246475739f.10.1730742691165; 
 Mon, 04 Nov 2024 09:51:31 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4de04977b30sm2005288173.116.2024.11.04.09.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 09:51:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Shantur Rathore <i@shantur.com>
Subject: [PATCH v3 09/19] bootmeth_efi: Simplify reading files by using the
 common function
Date: Mon,  4 Nov 2024 10:51:00 -0700
Message-Id: <20241104175110.1048449-10-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104175110.1048449-1-sjg@chromium.org>
References: <20241104175110.1048449-1-sjg@chromium.org>
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

The efiload_read_file() does similar things to a common function, so
update it to use that instead.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---

(no changes since v2)

Changes in v2:
- Change the tag to bootmeth_efi

 boot/bootmeth_efi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/boot/bootmeth_efi.c b/boot/bootmeth_efi.c
index 2ad6d3b4ace..f3ddbe71405 100644
--- a/boot/bootmeth_efi.c
+++ b/boot/bootmeth_efi.c
@@ -110,19 +110,14 @@ static void set_efi_bootdev(struct blk_desc *desc, struct bootflow *bflow)
 static int efiload_read_file(struct bootflow *bflow, ulong addr)
 {
 	struct blk_desc *desc = NULL;
-	loff_t bytes_read;
+	ulong size;
 	int ret;
 
 	if (bflow->blk)
 		 desc = dev_get_uclass_plat(bflow->blk);
-	ret = bootmeth_setup_fs(bflow, desc);
-	if (ret)
-		return log_msg_ret("set", ret);
 
-	ret = fs_read(bflow->fname, addr, 0, bflow->size, &bytes_read);
-	if (ret)
-		return log_msg_ret("read", ret);
-	bflow->buf = map_sysmem(addr, bflow->size);
+	ret = bootmeth_common_read_file(bflow->method, bflow, bflow->fname,
+					addr, &size);
 
 	set_efi_bootdev(desc, bflow);
 
-- 
2.34.1

