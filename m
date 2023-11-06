Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E35C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 02:48:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85B9286F42;
	Mon,  6 Nov 2023 03:31:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BWSCvJHb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3821F86FA5; Mon,  6 Nov 2023 03:28:12 +0100 (CET)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0768A86FF3
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-77774120c6eso253575285a.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237579; x=1699842379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bO4rs3uKwgl+gRuqLvzlcs9nEizjixC8X8yAsaufWLc=;
 b=BWSCvJHbh68w9fjtKEbViA73aCyd1vJBhTnXQdFJXHMnrdKpqJ0zke2fZdZTfycAN9
 ClQJm3va/OJOTN+4Z5zvLhF3f1lk/JNxiYBoyU8C9aRkVySoBLnRwvNgFzhrglRMul5F
 WOkY3fhxJncR+7a7mIWggbPAYORLsFcGOejHG/dKsT2ztdfgouTWbqfkB5t6SE2iFN3e
 pvzMEhbC2KtdEWfoo+/unBaS9+UDIQ6WydhVtTF2CzBL4C8yioHDLF2Jy0ncjg8eE5DC
 zQyfYiVgD1aEDjUkNAbwIk1bIKXD2yLKJaarycy6qgbpWjzF4NXVXWU0ydQynAk3pu33
 tc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237579; x=1699842379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bO4rs3uKwgl+gRuqLvzlcs9nEizjixC8X8yAsaufWLc=;
 b=c1ONzQIommx+9GWAUVZZzcDEe4GZPtOBH+JaLOIzoZdyIhVmx0YLuR3x6XaOPQaM/D
 yL/y08dHVNI6TgV8/zQ2jGhT363UOFn1xl9M+ghw8sARL9y0tHRMKNtCl1ItI6rF1Yl7
 D+QrerY0w7SPn9s4B06npg5uOKU+zFQE0sruFYthS2OaN6upKqY7QfCag49dnqSmwvc3
 687+5PTgt0dtLOEWOIPre+JniVZhJj3+kPp49aaDSCXBzu1wNjABEo49Cx/HWVqeVCL/
 wN/xCfDOm8DIJnwGbLve4DajCt0VBCxljK1YYDTH2PG/dphkDRGHnMZKT6TI3xERZJ2l
 lK8g==
X-Gm-Message-State: AOJu0YxQfuah/A6wfvExL+CyXgZ12DJro9nNR4vvZrFIKf6BcwemK3dt
 OX+9rl/u7v5DQ79dh84Vw+I=
X-Google-Smtp-Source: AGHT+IHwoGFY8lG01aeiO7g7yFgPneRnUXQ2XkfZ33lLJD9GsuVOZVAbb4NyhIEe4gRlq8YETAYAVg==
X-Received: by 2002:ad4:5aa9:0:b0:66d:28a4:5697 with SMTP id
 u9-20020ad45aa9000000b0066d28a45697mr34335475qvg.61.1699237579364; 
 Sun, 05 Nov 2023 18:26:19 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 l17-20020a05620a28d100b007770d47c621sm2895196qkp.66.2023.11.05.18.26.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:19 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v6 11/25] spl: nand: Remove spl_nand_legacy_read
Date: Sun,  5 Nov 2023 21:25:49 -0500
Message-Id: <20231106022603.3405551-12-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

Now that spl_nand_fit_read works in units of bytes, it can be combined with
spl_nand_legacy_read. Rename the resulting function spl_nand_read, since it
is no longer FIT-specific.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- New

 common/spl/spl_nand.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/common/spl/spl_nand.c b/common/spl/spl_nand.c
index 281211b7f24..91fa7674f17 100644
--- a/common/spl/spl_nand.c
+++ b/common/spl/spl_nand.c
@@ -42,29 +42,22 @@ static int spl_nand_load_image(struct spl_image_info *spl_image,
 }
 #else
 
-static ulong spl_nand_fit_read(struct spl_load_info *load, ulong offs,
-			       ulong size, void *dst)
+__weak u32 nand_spl_adjust_offset(u32 sector, u32 offs)
+{
+	return offs;
+}
+
+static ulong spl_nand_read(struct spl_load_info *load, ulong offs, ulong size,
+			   void *dst)
 {
 	int err;
 	ulong sector;
 
-	sector = *(int *)load->priv;
-	offs = sector + nand_spl_adjust_offset(sector, offs - sector);
-	err = nand_spl_load_image(offs, size, dst);
-	if (err)
-		return 0;
-
-	return size;
-}
-
-static ulong spl_nand_legacy_read(struct spl_load_info *load, ulong offs,
-				  ulong size, void *dst)
-{
-	int err;
-
 	debug("%s: offs %lx, size %lx, dst %p\n",
 	      __func__, offs, size, dst);
 
+	sector = *(int *)load->priv;
+	offs = sector + nand_spl_adjust_offset(sector, offs - sector);
 	err = nand_spl_load_image(offs, size, dst);
 	if (err)
 		return 0;
@@ -91,7 +84,7 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 		debug("Found FIT\n");
 		load.priv = &offset;
 		spl_set_bl_len(&load, bl_len);
-		load.read = spl_nand_fit_read;
+		load.read = spl_nand_read;
 		return spl_load_simple_fit(spl_image, &load, offset, header);
 	} else if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
 		   valid_container_hdr((void *)header)) {
@@ -99,16 +92,16 @@ static int spl_nand_load_element(struct spl_image_info *spl_image,
 
 		load.priv = &offset;
 		spl_set_bl_len(&load, bl_len);
-		load.read = spl_nand_fit_read;
+		load.read = spl_nand_read;
 		return spl_load_imx_container(spl_image, &load, offset);
 	} else if (IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT) &&
 		   image_get_magic(header) == IH_MAGIC) {
 		struct spl_load_info load;
 
 		debug("Found legacy image\n");
+		load.priv = &offset;
 		spl_set_bl_len(&load, IS_ENABLED(CONFIG_SPL_LZMA) ? bl_len : 1);
-		load.read = spl_nand_legacy_read;
-
+		load.read = spl_nand_read;
 		return spl_load_legacy_img(spl_image, bootdev, &load, offset, header);
 	} else {
 		err = spl_parse_image_header(spl_image, bootdev, header);
-- 
2.37.1

