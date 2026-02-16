Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF512E83827
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 19:51:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 863FA83C61;
	Mon, 16 Feb 2026 20:51:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SZRuyvGV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEEA283B8A; Mon, 16 Feb 2026 19:45:17 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D54B58063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 19:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=filip.kokosinski@gmail.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so2623578f8f.2
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 10:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771267515; x=1771872315; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cu/JFWILkmUFL9OKhKZ1+jKaxDVD11zhHPGlTZmadQ=;
 b=SZRuyvGVIIAN5RbTMxYYhkZFD6knZg66XHM3KY0N6Gln0r7yujTbB3d84hlhA1N3UU
 o3PK63qq0sbfYJ1Ti4xeZ8NiMuEje2Z2GdQlr91AKyfz+Oi167ypvJQq0+ZGIr33Yo6J
 Zv8Caw8sCfntIKgYtsxp8ljSElybd6IJb5oq7dLF1TncyZCcyZcI/PMOERTqH2KmAH69
 8Jaa0lAb0DVbCdQWfiPlvuT6Tj46hap7CONEWO1D4zfpgnaPGFkKE/ATekccZy9qO+Ba
 le4PDD6xIkwbe+++GBWf8Ycx19iOB20gE0Gdem992sapS2ALWcS2oYhaErvpazVkRyun
 F6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771267515; x=1771872315;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2cu/JFWILkmUFL9OKhKZ1+jKaxDVD11zhHPGlTZmadQ=;
 b=EDSba+LuzpsXdPwAQrca4AlfDsVN9khVNAvhoUEv0EwHSMHBngyOUcQkR+eVc6i5TD
 m173657eQnjUVyNkvVtdEYY4e7prMJclXtITsEnkhOWin9NCCEzRmpK8X1ph2Z2V/jr2
 NQ4AW3GHwzRmfuzS8JjC0irM6S1Ex59VvmQg+PF7nQ1J6ZiYQkoSiAZS6y/KgBbPilIL
 GlUN+fPT+ZWYhblSUnJHKJ+cY6bhoEZaglGIclkQxyccIlbp2BZi9OfG5PbUI1WKXS/h
 12iwBiiRO7ZdsBHEofSNKjATQaBZNAOKIjN5ltJWFy44HMVtXICqHFFb1NG3BUkicYi6
 Qpwg==
X-Gm-Message-State: AOJu0YwvrobmC1I4CCtMNEic0tN2OGcQn2oKjVMvFOa5G0ESir83MQZt
 bHuIyg3ZgMiZJZCHTDVUW9THyr0eXtiG1DUUyUoJiZWpgzxJb52yE69h79xc2Q==
X-Gm-Gg: AZuq6aJNBaEXs6agL2K9dcGOuWhbsGjrk3Nnn5Nc7B3LrS4qqgCXflD2hUm7KGJQ7d+
 1LuP3p97gFP+m3KRS8Kpll1yd81o88rVuU6I74MajzQhgxD10O84duFhikMHge+DfKhjhwu+Rfg
 NGZEDllVGO5gflrK7qXs1XgUk2yVubaMqouMaB9nrWK6ZiddLjYdLoOglHHMff3LAAidBqHwaVU
 zSWu3qsPhjlGIWkH9FlDDnOQNY4Jzs7OrUKXZvIe409WZDuEoaOarTD2AOxY1SFxpbvpk5BVZGY
 7/z8C9lstDQFBheBXQFkdKhs+3Mu31vjIxMdO6xRYbltFrjqFzOZ53Dsvyqyhsn5nWlHDymA+5w
 +zCcpKO8wu6KguWfRYWQAMNzF0ANKPpNrVdqO7gfAojsO2lAA5UkDveGG0+4EG73mK29mqeOCtL
 L/mQy89Is6kCTVLyeaz4nXz0g4IMMlbdZdtNyiJ2BYH9FTAq0kreVDhpaLa8P4Ljj9ilRHAH7Fr
 Q==
X-Received: by 2002:a05:600c:45c8:b0:480:1b65:b741 with SMTP id
 5b1f17b1804b1-48379b9913cmr147153675e9.15.1771267514984; 
 Mon, 16 Feb 2026 10:45:14 -0800 (PST)
Received: from desktop.home (83.23.200.152.ipv4.supernova.orange.pl.
 [83.23.200.152]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835dd0e327sm449404165e9.14.2026.02.16.10.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 10:45:14 -0800 (PST)
From: =?UTF-8?q?Filip=20Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
To: u-boot@lists.denx.de
Cc: mbrugger@suse.com, pbrobinson@gmail.com,
 =?UTF-8?q?Filip=20Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>
Subject: [PATCH 1/2] board/raspberrypi: add multi-FDT support
Date: Mon, 16 Feb 2026 19:44:51 +0100
Message-ID: <20260216184452.18732-2-filip.kokosinski@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260216184452.18732-1-filip.kokosinski@gmail.com>
References: <20260216184452.18732-1-filip.kokosinski@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Feb 2026 20:51:34 +0100
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

This patch adds support for multiple FDT files per board model. This is
done by adding the FDTFILES macro, which initializes two rpi_model
struct members: fdtfiles and fdtcount.

The new-style revision codes designate LSB bits as board revision; this
value is used to choose between provided FDTs. The first element of the
fdtfiles list is used should no revision match.

Signed-off-by: Filip Kokosiński <filip.kokosinski@gmail.com>
---
 board/raspberrypi/rpi/rpi.c | 93 +++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 41 deletions(-)

diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
index f9b643555dd..1b404b448f3 100644
--- a/board/raspberrypi/rpi/rpi.c
+++ b/board/raspberrypi/rpi/rpi.c
@@ -94,120 +94,125 @@ struct efi_capsule_update_info update_info = {
  */
 struct rpi_model {
 	const char *name;
-	const char *fdtfile;
+	const char * const *fdtfiles;
+	size_t fdtcount;
 	bool has_onboard_eth;
 };
 
+#define FDTFILES(...) \
+	(const char *[]){ __VA_ARGS__ }, \
+	sizeof((const char *[]){ __VA_ARGS__ }) / sizeof(const char *)
+
 static const struct rpi_model rpi_model_unknown = {
 	"Unknown model",
-	DTB_DIR "bcm283x-rpi-other.dtb",
+	FDTFILES(DTB_DIR "bcm283x-rpi-other.dtb"),
 	false,
 };
 
 static const struct rpi_model rpi_models_new_scheme[] = {
 	[0x0] = {
 		"Model A",
-		DTB_DIR "bcm2835-rpi-a.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-a.dtb"),
 		false,
 	},
 	[0x1] = {
 		"Model B",
-		DTB_DIR "bcm2835-rpi-b.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b.dtb"),
 		true,
 	},
 	[0x2] = {
 		"Model A+",
-		DTB_DIR "bcm2835-rpi-a-plus.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-a-plus.dtb"),
 		false,
 	},
 	[0x3] = {
 		"Model B+",
-		DTB_DIR "bcm2835-rpi-b-plus.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b-plus.dtb"),
 		true,
 	},
 	[0x4] = {
 		"2 Model B",
-		DTB_DIR "bcm2836-rpi-2-b.dtb",
+		FDTFILES(DTB_DIR "bcm2836-rpi-2-b.dtb"),
 		true,
 	},
 	[0x6] = {
 		"Compute Module",
-		DTB_DIR "bcm2835-rpi-cm.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-cm.dtb"),
 		false,
 	},
 	[0x8] = {
 		"3 Model B",
-		DTB_DIR "bcm2837-rpi-3-b.dtb",
+		FDTFILES(DTB_DIR "bcm2837-rpi-3-b.dtb"),
 		true,
 	},
 	[0x9] = {
 		"Zero",
-		DTB_DIR "bcm2835-rpi-zero.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-zero.dtb"),
 		false,
 	},
 	[0xA] = {
 		"Compute Module 3",
-		DTB_DIR "bcm2837-rpi-cm3.dtb",
+		FDTFILES(DTB_DIR "bcm2837-rpi-cm3.dtb"),
 		false,
 	},
 	[0xC] = {
 		"Zero W",
-		DTB_DIR "bcm2835-rpi-zero-w.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-zero-w.dtb"),
 		false,
 	},
 	[0xD] = {
 		"3 Model B+",
-		DTB_DIR "bcm2837-rpi-3-b-plus.dtb",
+		FDTFILES(DTB_DIR "bcm2837-rpi-3-b-plus.dtb"),
 		true,
 	},
 	[0xE] = {
 		"3 Model A+",
-		DTB_DIR "bcm2837-rpi-3-a-plus.dtb",
+		FDTFILES(DTB_DIR "bcm2837-rpi-3-a-plus.dtb"),
 		false,
 	},
 	[0x10] = {
 		"Compute Module 3+",
-		DTB_DIR "bcm2837-rpi-cm3.dtb",
+		FDTFILES(DTB_DIR "bcm2837-rpi-cm3.dtb"),
 		false,
 	},
 	[0x11] = {
 		"4 Model B",
-		DTB_DIR "bcm2711-rpi-4-b.dtb",
+		FDTFILES(DTB_DIR "bcm2711-rpi-4-b.dtb"),
 		true,
 	},
 	[0x12] = {
 		"Zero 2 W",
-		DTB_DIR "bcm2837-rpi-zero-2-w.dtb",
+		FDTFILES(DTB_DIR "bcm2837-rpi-zero-2-w.dtb"),
 		false,
 	},
 	[0x13] = {
 		"400",
-		DTB_DIR "bcm2711-rpi-400.dtb",
+		FDTFILES(DTB_DIR "bcm2711-rpi-400.dtb"),
 		true,
 	},
 	[0x14] = {
 		"Compute Module 4",
-		DTB_DIR "bcm2711-rpi-cm4.dtb",
+		FDTFILES(DTB_DIR "bcm2711-rpi-cm4.dtb"),
 		true,
 	},
 	[0x17] = {
 		"5 Model B",
-		DTB_DIR "bcm2712-rpi-5-b.dtb",
+		FDTFILES(DTB_DIR "bcm2712-rpi-5-b.dtb"),
 		true,
 	},
 	[0x18] = {
 		"Compute Module 5",
-		DTB_DIR "bcm2712-rpi-cm5-cm5io.dtb",
+		FDTFILES(DTB_DIR "bcm2712-rpi-cm5-cm5io.dtb"),
 		true,
 	},
 	[0x19] = {
 		"500",
-		DTB_DIR "bcm2712-rpi-500.dtb",
+		FDTFILES(DTB_DIR "bcm2712-rpi-500.dtb"),
 		true,
 	},
 	[0x1A] = {
 		"Compute Module 5 Lite",
-		DTB_DIR "bcm2712-rpi-cm5l-cm5io.dtb",
+		FDTFILES(DTB_DIR "bcm2712-rpi-cm5l-cm5io.dtb"),
 		true,
 	},
 };
@@ -215,87 +220,87 @@ static const struct rpi_model rpi_models_new_scheme[] = {
 static const struct rpi_model rpi_models_old_scheme[] = {
 	[0x2] = {
 		"Model B",
-		DTB_DIR "bcm2835-rpi-b.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b.dtb"),
 		true,
 	},
 	[0x3] = {
 		"Model B",
-		DTB_DIR "bcm2835-rpi-b.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b.dtb"),
 		true,
 	},
 	[0x4] = {
 		"Model B rev2",
-		DTB_DIR "bcm2835-rpi-b-rev2.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
 		true,
 	},
 	[0x5] = {
 		"Model B rev2",
-		DTB_DIR "bcm2835-rpi-b-rev2.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
 		true,
 	},
 	[0x6] = {
 		"Model B rev2",
-		DTB_DIR "bcm2835-rpi-b-rev2.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
 		true,
 	},
 	[0x7] = {
 		"Model A",
-		DTB_DIR "bcm2835-rpi-a.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-a.dtb"),
 		false,
 	},
 	[0x8] = {
 		"Model A",
-		DTB_DIR "bcm2835-rpi-a.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-a.dtb"),
 		false,
 	},
 	[0x9] = {
 		"Model A",
-		DTB_DIR "bcm2835-rpi-a.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-a.dtb"),
 		false,
 	},
 	[0xd] = {
 		"Model B rev2",
-		DTB_DIR "bcm2835-rpi-b-rev2.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
 		true,
 	},
 	[0xe] = {
 		"Model B rev2",
-		DTB_DIR "bcm2835-rpi-b-rev2.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
 		true,
 	},
 	[0xf] = {
 		"Model B rev2",
-		DTB_DIR "bcm2835-rpi-b-rev2.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b-rev2.dtb"),
 		true,
 	},
 	[0x10] = {
 		"Model B+",
-		DTB_DIR "bcm2835-rpi-b-plus.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b-plus.dtb"),
 		true,
 	},
 	[0x11] = {
 		"Compute Module",
-		DTB_DIR "bcm2835-rpi-cm.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-cm.dtb"),
 		false,
 	},
 	[0x12] = {
 		"Model A+",
-		DTB_DIR "bcm2835-rpi-a-plus.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-a-plus.dtb"),
 		false,
 	},
 	[0x13] = {
 		"Model B+",
-		DTB_DIR "bcm2835-rpi-b-plus.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-b-plus.dtb"),
 		true,
 	},
 	[0x14] = {
 		"Compute Module",
-		DTB_DIR "bcm2835-rpi-cm.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-cm.dtb"),
 		false,
 	},
 	[0x15] = {
 		"Model A+",
-		DTB_DIR "bcm2835-rpi-a-plus.dtb",
+		FDTFILES(DTB_DIR "bcm2835-rpi-a-plus.dtb"),
 		false,
 	},
 };
@@ -361,11 +366,17 @@ int dram_init_banksize(void)
 static void set_fdtfile(void)
 {
 	const char *fdtfile;
+	int rev = revision & 0x0f;
 
 	if (env_get("fdtfile"))
 		return;
 
-	fdtfile = model->fdtfile;
+	/* set the first entry as default */
+	fdtfile = model->fdtfiles[0];
+
+	if (rev < model->fdtcount)
+		fdtfile = model->fdtfiles[rev];
+
 	env_set("fdtfile", fdtfile);
 }
 
-- 
2.51.2

