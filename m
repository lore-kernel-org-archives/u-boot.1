Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC281C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:43:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CA7586936;
	Mon,  4 Sep 2023 16:41:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GFj7W9za";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C72869F2; Mon,  4 Sep 2023 16:41:56 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E78538693D
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34e1c1405easo5612215ab.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693838512; x=1694443312; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCgdVSZ4lcVmHkdlPCX7Hew26Mfrfxr2+YwH7KS63rY=;
 b=GFj7W9za4NW0OzEtelIuiSif5yuRPcL6+fbYQHNkd//bzynz3IEU2A35v8BMMi3v3u
 cGaZARlWotDYtfOFnR8wV0eapo0xYVELQamnjawiXOw+rJlcJDiMiSo6AL1Uae9Q1DUL
 X2NXZKWW435P0dQKrMUyAb5cqqyNFy9lfgDOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838512; x=1694443312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wCgdVSZ4lcVmHkdlPCX7Hew26Mfrfxr2+YwH7KS63rY=;
 b=BlrDepGja1l8L5GkSR+jAzs+FZeb2cz9xo+WzryPnFu6hIhvHaJBJIWqgEl9kQpOri
 QLPdrN1hWx17iOraGJKYPsk+e27IN1p7CR0DKFQi1V+umeqjIkxHq/mgx3bWt97mrNRb
 tnO+88Q3q+ZwnH9syzqjYmy6V9QLRJmfqep2SvSLSVDMIRgqR9C5JALjtXuNAokq77cv
 B6PzgDcqT8CDWUQf65mDRQ/NyTW4SQU5LhQcgYtYiYc+IZcz4+wYODlrIEXoZ02wTi3i
 Nch0o8EDsE0DkD9Ja9KyBeQQ+umLcxasqMVZbqbVidNpXSC3Eoe5O0XmuGLclDrxT+lx
 X98Q==
X-Gm-Message-State: AOJu0YyHpnMkgHJDNISZ971UWSWx2Yu/SKU11wO662y96npLI0qBDeU8
 gm2yd4Yn8AFzNoxqi25oJdrpQB67jddkw7u+oWQ=
X-Google-Smtp-Source: AGHT+IG76NMNNWsFnMSu8ifNP2EMoctaWDfkiWWOcT1mGhfTBQi4Or5OvQyk3dbXvAOBVWTsM9qK+A==
X-Received: by 2002:a92:cb4e:0:b0:34c:d86f:46e9 with SMTP id
 f14-20020a92cb4e000000b0034cd86f46e9mr10756675ilq.12.1693838512615; 
 Mon, 04 Sep 2023 07:41:52 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 r16-20020a92d990000000b00345d6297aa7sm3364860iln.16.2023.09.04.07.41.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:41:51 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Simon Glass <sjg@chromium.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH v3 13/20] Kconfig: Move SPL_FIT under FIT
Date: Mon,  4 Sep 2023 08:41:16 -0600
Message-ID: <20230904144131.2699824-14-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
In-Reply-To: <20230904144131.2699824-1-sjg@chromium.org>
References: <20230904144131.2699824-1-sjg@chromium.org>
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
index 467bca706782..c9b7d3f710b6 100644
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

