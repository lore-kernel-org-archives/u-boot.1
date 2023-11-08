Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC787C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1BD1787718;
	Wed,  8 Nov 2023 17:49:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MzMJwLrm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA00C8755C; Wed,  8 Nov 2023 17:49:22 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 354CF86E2F
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-66d093265dfso43458526d6.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462157; x=1700066957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTV8aKgJfsuixiVpqbdXPlBLnCGCi6YmUouOrdiRWk4=;
 b=MzMJwLrmCeAdEojqGEU61SiqJsoC0+mFfFL8gXMV6tKPaxBtoFjORtl9hWn41smzeW
 RDQb4BS4/vWILVLv+JY8FLwT1n4pY+spYPmmwZhgNZVxNSyXCg7uy2fWe/4lYm6EpwBH
 ykUHd9pXe6BXSFdG7lIDcSEky+rQiazP+qQA+Gs0PTz3KwFeOX+iE7eW5KBePYANjhYq
 b79xbRMx0tP//56+zYLpFHnt6zTqyaFWOybxt0DTwej4HraeqkNL9aH/1ZUZdP+mj4fK
 n9pYQ24dnydRRxn3uyVVQ2pJ4qGiOPKq8ZXwUS48AFdx1surG2L9aBUKc/ZwP+UNVbTG
 lYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462157; x=1700066957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RTV8aKgJfsuixiVpqbdXPlBLnCGCi6YmUouOrdiRWk4=;
 b=c/JmFpIPacYigTZziIDFhA/i6ng9+PWhKufjfZ2rD0Y49euokn0MA/RosJRI1YdYLQ
 945NC6T6bOZ22Wq/ZHZkmlNX5SgEAJ+zU11dmYc3VVVB/Yruk1MBXxJ1N4OizNqGTVER
 jWNGMZnhG7rS0UpA8FApWTbJ9gtsW54ZkPNmE0FIMA1/gBEfQqgQJd2l/5Wx89noW27r
 FcdPjXpcVHiDHN/4vqQfjfCjKITKMtjQq7isZ1bMRY08kIm7nwNXC7QPnaRylG/5eVKG
 Z4u7QU0tp/kMj4Ge5tj6dDUcTs71/yiWpNmCJ5N8Cp5nSMsg/ZYXnx6cfPpQ1vOZQIxZ
 0CDQ==
X-Gm-Message-State: AOJu0YxZC/9QjzW1OoLAyNREmtOjkmDrCUPjFJ5923OtLNpcZEyB0bN3
 pXdOS0RuvkRou6f9eLa0Q32JDir0TA0=
X-Google-Smtp-Source: AGHT+IF4LIjNJgKwhmB7SdbWrDYwMkGSJd8sGtkU3i+hTBgp9N3rMqxNhtYSEQPaVygSEoii8dPNPg==
X-Received: by 2002:a05:6214:493:b0:66d:9d84:611a with SMTP id
 pt19-20020a056214049300b0066d9d84611amr3345261qvb.8.1699462157012; 
 Wed, 08 Nov 2023 08:49:17 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 y12-20020a0cec0c000000b006731d3380f1sm1248078qvo.15.2023.11.08.08.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:16 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: [PATCH v7 12/26] spl: nand: Remove spl_nand_legacy_read
Date: Wed,  8 Nov 2023 11:48:44 -0500
Message-Id: <20231108164858.3497420-13-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

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

