Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2182DC10F04
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 03:55:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1680C874BA;
	Sat,  2 Dec 2023 04:55:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gOm3+87Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB7F58758A; Sat,  2 Dec 2023 04:55:31 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E0AA87496
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 04:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3b8b2d0db48so22927b6e.3
 for <u-boot@lists.denx.de>; Fri, 01 Dec 2023 19:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701489328; x=1702094128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgkNVr637iddP10kktErFCRYoJ7YouXjWqvHwiDeUcs=;
 b=gOm3+87YReAo6+5dEO8plZJM5GxUdl7YHC3yRryPZQfhJEhgR+ERbkFC4e3ggd+BK6
 ELIuJD9aU7om2aMW3PKUOjYFFY3gN2WZGDCTbCJCYLby4GmcAP+JPKxf8bXNfKrvDAly
 QOZ9hErI/TtgYWeH3iXNU3lziw+YtozduYSSo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701489328; x=1702094128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgkNVr637iddP10kktErFCRYoJ7YouXjWqvHwiDeUcs=;
 b=NmwYF8QP5Pi1jvSVJPtduMyqdW1R4adlXkkUzWm4a+K0etmAr1N1DaZh8Xiq3FXw/I
 yR/AzfZhtav2HK9eEjyVhTmOal9Abae6H38qqvDba272WZCKcKK/cNJtdTEWUgyeH+Pk
 ukN9d6JO/KtQzpokc/5U6tUwu562p+bNwONnYRINyF4O+UtXJKocOJZ/PQByoZOHALew
 HbxROq8+LflTBlQoe/ImlRkACwiWGUpejPi78suIJibOAk1AmG6d7QMRxzKDn52gU9fQ
 7Q/b+oHuynV/FdqXcq351M+Un0TL/8LrIVU1atmaOpjYn9WENNS9qvL6RdWRO4FesEfC
 ZbPg==
X-Gm-Message-State: AOJu0YyQHwfoDw0zFyJgndYu5hrlDme7a/yN+1b1NiBgQ4kHgDUFpF9C
 G9Q8B+NA/6xNZta8x2gbJWgpBQ==
X-Google-Smtp-Source: AGHT+IFgoGP3RdjYMguEz+gFvB+CJ/dknLHJUw0d0IBBZ00hhH7Fobb6d/sWCE0AymKAln1gR9YdLA==
X-Received: by 2002:a05:6808:1506:b0:3b8:b063:504c with SMTP id
 u6-20020a056808150600b003b8b063504cmr850392oiw.77.1701489328310; 
 Fri, 01 Dec 2023 19:55:28 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 t7-20020a62d147000000b006cb60b188bdsm3866565pfl.196.2023.12.01.19.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Dec 2023 19:55:28 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Nicolas Schier <nicolas@fjasle.eu>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/2] arm64: Add BOOT_TARGETS variable
Date: Fri,  1 Dec 2023 20:54:41 -0700
Message-ID: <20231202035511.487946-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231202035511.487946-1-sjg@chromium.org>
References: <20231202035511.487946-1-sjg@chromium.org>
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

Add a new variable containing a list of possible targets. Mark them as
phony. This matches the approach taken for arch/arm

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v7)

Changes in v7:
- Drop the kbuild tag

Changes in v6:
- Drop the unwanted .gz suffix

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 9a2d3723cd0f..1bd4fae6e806 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,6 +150,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
+BOOT_TARGETS	:= Image vmlinuz.efi
+
+PHONY += $(BOOT_TARGETS)
+
 ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
 else
@@ -159,7 +163,7 @@ endif
 all:	$(notdir $(KBUILD_IMAGE))
 
 vmlinuz.efi: Image
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.43.0.rc2.451.g8631bc7472-goog

