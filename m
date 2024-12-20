Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35790E7718A
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 04:02:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4862C8035E;
	Fri, 20 Dec 2024 05:01:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RylkVoZU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB45180087; Fri, 20 Dec 2024 05:01:44 +0100 (CET)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 891D98021A
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 05:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-3a814831760so5011295ab.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 20:01:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734667300; x=1735272100; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YP70HJUN9zKGqSo/D8LpjWOqUVzC2YS3Vzdpo7kxm78=;
 b=RylkVoZU+DR3TOxWek+/C34k/qjupetwcxyp2mkeQLUGnMorc3ctmNjcs6Rbk9br5I
 fYxBpEF4jrFrnZfLjwhw3oD4LTSgXxJGCIpweVMQUzjdYGtggkl82nIlyvK1F7WnI1m8
 fBypgxIB11KtiwEP3Iu1E4q9OgbOSsEXLohYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734667300; x=1735272100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YP70HJUN9zKGqSo/D8LpjWOqUVzC2YS3Vzdpo7kxm78=;
 b=DiD04IyvttuD9HGsCmUmWfUVWxuy9T1vkS4cMY2ZTgwDh36Hag2g153cHhaioYm7V0
 D9pqiWTCVKNz/lEbQKPVFdPhDMqQuut5xNaht9tXNp47s9Wp08/a9MezHPQD5nRahDGV
 Vcllg4XjAY1HY8Olr19G+2iVICk4NXbPEwswQuXxzAz/31yuXIwAqQ6s/ys9UZ3Mshx8
 /qge8dcSB0Y4zBH5QlyelJw0aNeC188MRXn+yO3RMl09Wq1swlvVvk2aGGg1fkog1aHu
 LUBuQdwJkJTN1MxGWL2kNCjguMn1TPLiDIXo7koIzHy594JXYSghu7YqkTCEky/gBgMT
 z9Ng==
X-Gm-Message-State: AOJu0YyCDH9acX5u1YcjIxd3+osQTQS7bxvb/e2BNiIA7JFULHiFSUA1
 yANzzVQE7KReY8jeQo4UdlgJxBtbTNHRR9OGNze8ufJr6D00MPX+gufCfgIQFmDZoSGS8ZEZCmQ
 =
X-Gm-Gg: ASbGncuXbfot5ZS23qOXHPDGu1q3Ivr/Fs1diDJWWeGQSqI6rO7L9j4gFV1YJnqjwzy
 2KXu6A4IpChiCYcjsVurwbgmrG9lwyaGfOhFxeJkIqPSMKBxtIu8vWywBf61hf7zEmU8SRAaZ6J
 viKviH0khmgI7NpZLcM66Y+CGLFLjLpSovKPxw6e+BK4v+Nazp9xWbaeTHRlUdzfleRUSoWZOUj
 H19FUDPh2Ilebn99jeZHq4krMtfDLYvICgNTPRKjZlNnKFvbyTHlQB3IgKgwHjfhz2o5S37/o3l
 Bq5wSy/oVwf7/3L6KQ==
X-Google-Smtp-Source: AGHT+IGrYoPLNcGw2o2Zc/FZPWWMQMqEv1tJVE5a/SUr/dWKeRo2P6WLt5wxVSZVOczQ11hCqymeLA==
X-Received: by 2002:a92:cda6:0:b0:3a7:a738:d9c8 with SMTP id
 e9e14a558f8ab-3c2d14d1839mr13185705ab.2.1734667300410; 
 Thu, 19 Dec 2024 20:01:40 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68c22213asm594723173.155.2024.12.19.20.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 20:01:38 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/5] pxe_utils: Allow the FDT to be missing
Date: Thu, 19 Dec 2024 21:01:18 -0700
Message-Id: <20241220040120.3245610-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241220040120.3245610-1-sjg@chromium.org>
References: <20241220040120.3245610-1-sjg@chromium.org>
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

The devicetree file may not be provided, so avoid a failure in that
case.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/pxe_utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/pxe_utils.c b/boot/pxe_utils.c
index 3a4caa9329a..8bebf4ec925 100644
--- a/boot/pxe_utils.c
+++ b/boot/pxe_utils.c
@@ -799,7 +799,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 		}
 		unmap_sysmem(buf);
 	}
-	if (ctx->bflow)
+	if (ctx->bflow && conf_fdt)
 		ctx->bflow->fdt_addr = hextoul(conf_fdt, NULL);
 
 	if (IS_ENABLED(CONFIG_BOOTSTD_FULL) && ctx->no_boot) {
@@ -819,7 +819,7 @@ static int label_boot(struct pxe_context *ctx, struct pxe_label *label)
 				  ctx->initrd_addr_str, ctx->initrd_filesize,
 				  ctx->initrd_str);
 		}
-		if (!ctx->kernel_addr || !ctx->conf_fdt ||
+		if (!ctx->kernel_addr || (conf_fdt && !ctx->conf_fdt) ||
 		    (initrd_addr_str && (!ctx->initrd_addr_str ||
 		     !ctx->initrd_filesize || !ctx->initrd_str))) {
 			printf("malloc fail (saving label)\n");
-- 
2.34.1

