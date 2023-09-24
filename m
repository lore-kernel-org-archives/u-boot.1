Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA893CE7A8C
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 20:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B109286C35;
	Sun, 24 Sep 2023 22:40:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U/IHMVAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F20D86C33; Sun, 24 Sep 2023 22:40:42 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F3C986BB8
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 22:40:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-79f9f5135f8so133892139f.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 13:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695588039; x=1696192839; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nillZNPmNxT4UDXbUDGedaBYYb0bJyjHZpvnvJFcKgE=;
 b=U/IHMVAS27FSLvFm8/I1y7FLyWfX/qvKU2VW47JoNcpz1gicNF7v0nnMiL8DTZJYcQ
 Qji0MGSx0fwFBaiayPkjimuhtUKNheu3IFrU8Q+GtcVpE04WVtl9Q3IapCYl7xcf4CLq
 tQBLtf3fve3uShCot9glKq2ZGTJVAx5cHfSSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695588039; x=1696192839;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nillZNPmNxT4UDXbUDGedaBYYb0bJyjHZpvnvJFcKgE=;
 b=DVOv2nDdMGvAsPms8CssdlXjmeeXTuAM+3B87UGCokjax/lYkJ3TKQIyAXXWX0ln0Z
 U0TGZ7S1mryvNTOanrXSTw7TZ9J+sk2yrWFed4i7BC7Uud7ggYnDH5z2jmYPOQduIeKg
 LSnygHsNDK96pJExRHTKbNTuvEXzLswQFsnLG3cbNSs98ei2TByHtA1B02Q5TWaoiHng
 YB/OuERrU6FqB5K4Ad9JtKgEL+VtL1K7JpWino/oCW2xaBwVLsh7Q218N9jZ6evvw5DM
 hDVjABGLtsQSOaDVYvoeEkdj3WhyqeamsNyDOiZ3VCb/rWoFFY4386QnY4yvCBNUzMdU
 ROEw==
X-Gm-Message-State: AOJu0Yz1XB0iyk6cPadoUOLbK98WfzucM0QPGW73G5jCfLqawW9Aj1UE
 d2pCsDH4vnofWQmWosNwPd7C0chdTlRq+XutKng=
X-Google-Smtp-Source: AGHT+IEJ54GoUxJn9g1AtuPgYVj4nEdA4a5kTw66UuO3GaohTbMqFc/Me8ohU1s7pGNMfOpF3LTyUA==
X-Received: by 2002:a5d:9314:0:b0:791:385c:f8b0 with SMTP id
 l20-20020a5d9314000000b00791385cf8b0mr5015787ion.3.1695588038805; 
 Sun, 24 Sep 2023 13:40:38 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 m11-20020a02cdcb000000b0043a1b74a0e3sm2311705jap.90.2023.09.24.13.40.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 13:40:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH 22/25] efi: Depend on CMDLINE for efi_loader
Date: Sun, 24 Sep 2023 14:39:40 -0600
Message-ID: <20230924203953.1829820-23-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924203953.1829820-1-sjg@chromium.org>
References: <20230924203953.1829820-1-sjg@chromium.org>
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

This features currently requires the command line, so make this
explicit. Future work could adjust this, but it needs effort within
the booting support first, like the bootm command.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index 621ed5e5b0fb..2aef9336034e 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -12,6 +12,7 @@ config EFI_LOADER
 	depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
 	depends on BLK
 	depends on !EFI_APP
+	depends on CMDLINE
 	default y if !ARM || SYS_CPU = armv7 || SYS_CPU = armv8
 	select CHARSET
 	# We need to send DM events, dynamically, in the EFI block driver
-- 
2.42.0.515.g380fc7ccd1-goog

