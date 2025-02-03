Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA56C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:43:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 613E9801DE;
	Mon,  3 Feb 2025 18:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NEbxMk6M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E007F801DE; Mon,  3 Feb 2025 18:43:12 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C779F800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3f314ff6ffdso2672045b6e.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604589; x=1739209389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciimLHl7oreMmj/21lx+N+zw6L/qT0R8BixipyRMjhM=;
 b=NEbxMk6Mpqq0InhBQ0Tw7nQMuskI2lI9ttvBih7q+VvukiWshbHyYivT+rUj3o4Jl3
 aiEQoAE2YLaE06AIWNOL9B1CStgcagXXsxWimYTaSPnpCoPJc628MmXhnNr2pPIAY7NW
 SOO4fJQmCQ261H7DYwV8kutjVgZSvXmLMls1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604589; x=1739209389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ciimLHl7oreMmj/21lx+N+zw6L/qT0R8BixipyRMjhM=;
 b=kXOmjI7ON0rswUbBNuuL/JWpgg9SzC1a/XcNH6dN3RfYPfEoBRXHaaMlwTzGQjH0qa
 5+HbXig7eUdoZ8omkRtGYRiSr47c2WMK1zdngTrEPtmj0YFHviRpFEtPli1RreCIlL5D
 RHmN4vUE+25fCAdX+Um9lQ26Q0RTFiwYfLT3MvKdH2DMQd2b2fsEoUBnP1Agjek9uCSo
 NCUjdkIUyQD/So/HTQqLZOfnS33x8TudW6WkjSjhN8ekpakp47gXgek6/GCqHfN3DpX2
 MvMC9r3MJdH4Wq5QuDjmoaU0AQ4zF1RDeKyQ00490fpZojTzyiCic5yq/X1PE93SVSzS
 rRyQ==
X-Gm-Message-State: AOJu0YzWiFZcwQ3cCjWQ1Sx3sOkY3mY7tf+7vXmqNv8kHnyBNjBa5dS7
 +T/EVAnujUrz7GkG/LWzup/HjxVPC5VnkYbHO9TOx/fgDgdLgcgAm+cwko294Tj5zJV2ozG/b/Q
 =
X-Gm-Gg: ASbGncsYbS3mJlifK/384c7lE8HiCLGo4LyRRaSVGyTSnFEKcQbmjPmzs6Q/RaBzVch
 Y8LCA0FlwwLxD7ZjEcEU1EuYC1g7okiTzZqVCt+MV43t8a73O82WJVvsoeg12eEv3K/DlRTtANm
 uexWF+2Zic9cw1wrzJUvGY4inkvUVP2e8V/gkbj+FS1bBcn7H7dkfKgqIaYAAKHUciWv5Wnu5i4
 u+mbVmW00fVbTyC+d1CUuiwTDSahYWSl3rUNKNc9Rxe8QPQKVr0D9rooR7xbbOa6C29jU2/e97k
 0/byqgYnjcwxsw+Xe0EiOXoWaEQ2gwddan6b+K5O/2/H/JHLMotN
X-Google-Smtp-Source: AGHT+IFznJAuWJtwwX+UF2D489rhMsnOGjOVsaqDNa9vd4Mt+0s54d+MypytdEmKcRgzFCb3t/Pj/g==
X-Received: by 2002:a05:6808:3c88:b0:3e6:63b5:f248 with SMTP id
 5614622812f47-3f3239fb886mr16796735b6e.7.1738604588997; 
 Mon, 03 Feb 2025 09:43:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marex@denx.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 02/32] Makefile: Avoid using TEXT_BASE if not present
Date: Mon,  3 Feb 2025 10:41:55 -0700
Message-ID: <20250203174245.1331464-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

This value is only available if CONFIG_HAVE_TEXT_BASE is enabled. Add
conditions to avoid introducing errors in link scripts when it is not.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Makefile | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 2f7614191a1..3958ea45b9a 100644
--- a/Makefile
+++ b/Makefile
@@ -1050,8 +1050,10 @@ LDFLAGS_u-boot += -z notext $(call ld-option,--apply-dynamic-relocs)
 LDFLAGS_u-boot += --build-id=none
 
 ifeq ($(CONFIG_ARC)$(CONFIG_NIOS2)$(CONFIG_X86)$(CONFIG_XTENSA),)
+ifdef CONFIG_HAVE_TEXT_BASE
 LDFLAGS_u-boot += -Ttext $(CONFIG_TEXT_BASE)
 endif
+endif
 
 # make the checker run with the right architecture
 CHECKFLAGS += --arch=$(ARCH)
@@ -1741,7 +1743,7 @@ quiet_cmd_u-boot-elf ?= LD      $@
 	cmd_u-boot-elf ?= $(LD) u-boot-elf.o -o $@ \
 	$(if $(CONFIG_SYS_BIG_ENDIAN),-EB,-EL) \
 	-T u-boot-elf.lds --defsym=$(CONFIG_PLATFORM_ELFENTRY)=$(CONFIG_TEXT_BASE) \
-	-Ttext=$(CONFIG_TEXT_BASE)
+	$(if $(CONFIG_HAVE_TEXT_BASE),-Ttext=$(CONFIG_TEXT_BASE))
 u-boot.elf: u-boot.bin u-boot-elf.lds
 	$(Q)$(OBJCOPY) -I binary $(PLATFORM_ELFFLAGS) $< u-boot-elf.o
 	$(call if_changed,u-boot-elf)
-- 
2.43.0

