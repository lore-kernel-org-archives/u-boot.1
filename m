Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EC3D3C919
	for <u-boot@archiver.kernel.org>; Sat, 19 Oct 2024 15:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1EDB89330;
	Sat, 19 Oct 2024 17:23:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mtLmKc8v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206068933B; Sat, 19 Oct 2024 17:23:07 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 322DB89319
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 17:23:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-83abe7fc77eso47282539f.0
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 08:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1729351382; x=1729956182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0u7UjAMcGuk6iDyTVd6609g1TaMKZ6K3GAMOoFk6vs=;
 b=mtLmKc8vgzW7QV2iNf+BhbAT05v8xutytjaeywcA9fkmOo524mrdojEOeeuEBJT98P
 zWjDfMsiSr7NRE+90MeTfOPw2h/u2hnd/D4rqXdsA7br7craj+53Bat3P6/xleuHpApw
 NqDSYgk4kwshV82n2iPJ45lr7noiGCJeec30o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729351382; x=1729956182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z0u7UjAMcGuk6iDyTVd6609g1TaMKZ6K3GAMOoFk6vs=;
 b=vEhDhcJKVUNPfaXd/MOtcq2SxCE7jo/bl2kui3pPSss/hUG2l64fm2XX3yYSq6WHeD
 E+ER/xcTi30igWK9+VHnQjGWqthL1GlJoL8hTaoygB+yPNLjVqQSC0giYt4VNfq4dUKX
 TERFmoCEQb7mHkecQyVdKq1uW80/0D3oeI9BUQbXkfW7zykIAFqqABjKCG2lWM9hk+B0
 oNR6x/qgcrsKTSlImi2RCbLrJgJWdX35X5v0MR7r08CyBu6aJlyE175fS66tHYvIZBZI
 WXhbHQGvedUet3mIIAakNLoNj6zUmuvambYc2ls4t5T7flNuAAm567QVKkpMEUJd1HJx
 Otvw==
X-Gm-Message-State: AOJu0Yx6AgaRRn316ro8oSXs9FjwPVMYTGCak5MQBG/atQDoK+3ZG26+
 eULvupGJDiSKOXv59TsHIZvkB5hSlWBdXgNXUYWsZmJgsCLPve3ZENWOCuNWK5xqM76psn3fmlo
 =
X-Google-Smtp-Source: AGHT+IGofa7SlQHCoIzT4m3mWogKtBj6Z4HbMC++ksIRCzLzazAjeK2T8PnHh0dfo7fVWQFOD6/N7g==
X-Received: by 2002:a05:6e02:13ac:b0:3a0:979d:843 with SMTP id
 e9e14a558f8ab-3a3f40531e3mr51790555ab.9.1729351381914; 
 Sat, 19 Oct 2024 08:23:01 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dc10b83faasm1006111173.52.2024.10.19.08.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 08:23:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Julien Masson <jmasson@baylibre.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>
Subject: [PATCH v2 28/31] Update bootmeth_alloc_other() to record images
Date: Sat, 19 Oct 2024 09:22:08 -0600
Message-Id: <20241019152211.1014896-29-sjg@chromium.org>
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

Update this function to add the image to the list.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update to use a new image-type enum in bootflow.h

 boot/bootmeth-uclass.c | 15 ++++++++++++++-
 boot/bootmeth_script.c |  4 ++--
 include/bootmeth.h     |  3 ++-
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/boot/bootmeth-uclass.c b/boot/bootmeth-uclass.c
index e9075701c3c..9a2c1ad487d 100644
--- a/boot/bootmeth-uclass.c
+++ b/boot/bootmeth-uclass.c
@@ -364,9 +364,11 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
 }
 
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 void **bufp, uint *sizep)
+			 enum bootflow_img_t type, void **bufp, uint *sizep)
 {
 	struct blk_desc *desc = NULL;
+	struct bootflow_img *img;
+	char *img_fname;
 	char path[200];
 	loff_t size;
 	void *buf;
@@ -393,6 +395,17 @@ int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
 	if (ret)
 		return log_msg_ret("all", ret);
 
+	img_fname = strdup(fname);
+	if (!img_fname)
+		return log_msg_ret("alf", -ENOMEM);
+	img = alist_add_placeholder(&bflow->images);
+	if (!img)
+		return log_msg_ret("als", -ENOMEM);
+	img->fname = img_fname;
+	img->type = type;
+	img->addr = map_to_sysmem(buf);
+	img->size = size;
+
 	*bufp = buf;
 	*sizep = size;
 
diff --git a/boot/bootmeth_script.c b/boot/bootmeth_script.c
index a2fb2899885..020cb8a7aec 100644
--- a/boot/bootmeth_script.c
+++ b/boot/bootmeth_script.c
@@ -107,8 +107,8 @@ static int script_read_bootflow_file(struct udevice *bootstd,
 	if (ret)
 		return log_msg_ret("inf", ret);
 
-	ret = bootmeth_alloc_other(bflow, "boot.bmp", &bflow->logo,
-				   &bflow->logo_size);
+	ret = bootmeth_alloc_other(bflow, "boot.bmp", BFI_LOGO,
+				   &bflow->logo, &bflow->logo_size);
 	/* ignore error */
 
 	return 0;
diff --git a/include/bootmeth.h b/include/bootmeth.h
index 788d4046ce9..26de593a9a4 100644
--- a/include/bootmeth.h
+++ b/include/bootmeth.h
@@ -384,12 +384,13 @@ int bootmeth_alloc_file(struct bootflow *bflow, uint size_limit, uint align,
  *
  * @bflow: Information about file to read
  * @fname: Filename to read from (within bootflow->subdir)
+ * @type: File type (IH_TYPE_...)
  * @bufp: Returns a pointer to the allocated buffer
  * @sizep: Returns the size of the buffer
  * Return: 0 if OK,  -ENOMEM if out of memory, other -ve on other error
  */
 int bootmeth_alloc_other(struct bootflow *bflow, const char *fname,
-			 void **bufp, uint *sizep);
+			 enum bootflow_img_t type, void **bufp, uint *sizep);
 
 /**
  * bootmeth_common_read_file() - Common handler for reading a file
-- 
2.34.1

