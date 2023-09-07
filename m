Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4EDEC8738
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 16:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0695686AB9;
	Thu,  7 Sep 2023 17:59:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CWfzjqI7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9767986A74; Thu,  7 Sep 2023 17:59:57 +0200 (CEST)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4539886AF4
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 17:59:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-34c5fec2a95so4500455ab.3
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 08:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694102392; x=1694707192; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gx2DRQbywS6rX9wEPc+7arJ+7R3B4IYonX825w+A/DA=;
 b=CWfzjqI7gDiGCYLnco57dpbCZO+JFgw9v0ocws+ermyM8NvJNLrXzxt2eQAijlobq3
 pM/S0hxbHYlAkrCvVRvoKH/qNGvcgxa8bJHyiRtyJWc74ymrCPIgVruLwZ+I2Ras5SJT
 rJGp38w0EEMu6I/ECcg0hAm7YRMhpKWjVTqc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694102392; x=1694707192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gx2DRQbywS6rX9wEPc+7arJ+7R3B4IYonX825w+A/DA=;
 b=lAwBy/i25VlnDfC6eKw5nJtu6SoFeMZ4Q6QD1eyGLKcX+5orRP3gZsjtNbpAMvBInQ
 PvNaLXRdVMKJqFNsoLACDPjG7iUpOS72THefqgnztZVgI99n+WmW5MG3NpGfVFLk9ruL
 3WxwGGHmK9bAuGZvykd33wlCUSjjhjnUCSqGU+KTsGyYyyAQ5sautcxBGojR5t/QmM6y
 QIENifbgkb5z9V9zF+UaaOxTcy4yAgF9jTj6EjDc+VQZk7UoY5xrlvBbghMMoGEDRCcE
 /ATRO03ZiSGE8J7+3cpdxPc5cWnEM/OB/hAEYSDzwcbeSkSXbXHc9aMYOcjIqSTj219/
 9NFw==
X-Gm-Message-State: AOJu0YwKKipuW8l/nyHsjcGzqmXdQbDWhgnAxLRbccam3gzWkmTmqOrf
 07uZ1OkSDVCZON3J/BhSNjHNIRPCmo2JIOt7JQs=
X-Google-Smtp-Source: AGHT+IG4z+u6s9vyP96espryKBqOXTTIuJQKzUMHEkytTWr17RXC1R/bfntVJGkkdZSjO/ziyA5Dag==
X-Received: by 2002:a05:6e02:11ae:b0:349:3503:253b with SMTP id
 14-20020a056e0211ae00b003493503253bmr102471ilj.17.1694102391920; 
 Thu, 07 Sep 2023 08:59:51 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o18-20020a92d4d2000000b0034989674ad7sm5637727ilm.52.2023.09.07.08.59.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 08:59:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v4 15/22] Kconfig: Move SPL_FIT under FIT
Date: Thu,  7 Sep 2023 09:59:20 -0600
Message-ID: <20230907155933.48511-16-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230907155933.48511-1-sjg@chromium.org>
References: <20230907155933.48511-1-sjg@chromium.org>
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

This option already depends on FIT, so put it under the same umbrella, so
that it appears in the FIT menu.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Kconfig | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index f564cb8dd84c..9b09d636d057 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -140,11 +140,9 @@ config FIT_PRINT
         help
           Support printing the content of the fitImage in a verbose manner.
 
-endif # FIT
-
 config SPL_FIT
 	bool "Support Flattened Image Tree within SPL"
-	depends on SPL && FIT
+	depends on SPL
 	select SPL_HASH
 	select SPL_OF_LIBFDT
 
@@ -195,7 +193,7 @@ config SPL_FIT_RSASSA_PSS
 
 config SPL_LOAD_FIT
 	bool "Enable SPL loading U-Boot as a FIT (basic fitImage features)"
-	depends on SPL && FIT
+	depends on SPL
 	select SPL_FIT
 	help
 	  Normally with the SPL framework a legacy image is generated as part
@@ -243,7 +241,6 @@ config SPL_LOAD_FIT_APPLY_OVERLAY_BUF_SZ
 
 config SPL_LOAD_FIT_FULL
 	bool "Enable SPL loading U-Boot as a FIT (full fitImage features)"
-	depends on FIT
 	select SPL_FIT
 	help
 	  Normally with the SPL framework a legacy image is generated as part
@@ -341,6 +338,8 @@ config VPL_FIT_SIGNATURE_MAX_SIZE
 
 endif # VPL
 
+endif # FIT
+
 config PXE_UTILS
 	bool
 	select MENU
-- 
2.42.0.283.g2d96d420d3-goog

