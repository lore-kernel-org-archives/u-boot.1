Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC565C4167B
	for <u-boot@archiver.kernel.org>; Thu, 30 Nov 2023 20:34:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43EDB87710;
	Thu, 30 Nov 2023 21:34:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G8QbE7Wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38EA287736; Thu, 30 Nov 2023 21:34:12 +0100 (CET)
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com
 [IPv6:2607:f8b0:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E00A87729
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 21:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x129.google.com with SMTP id
 e9e14a558f8ab-35942cb9ef4so4114915ab.3
 for <u-boot@lists.denx.de>; Thu, 30 Nov 2023 12:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701376448; x=1701981248; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sgkNVr637iddP10kktErFCRYoJ7YouXjWqvHwiDeUcs=;
 b=G8QbE7WtDyIhrstf3WLUSA/1BwBSM30fChZmKBSODqXaGYoa8SLi5p3uvVNtyV1oJO
 bhRmO5q+ncL6LZFbn1zY3mHMEfE0kQT35OekNkgIdIYcrAfrKwUFqnOcK+osqmuS620v
 EDwSowu/m2ywmocEYMw5TWitrz80PZaDRUreo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701376448; x=1701981248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sgkNVr637iddP10kktErFCRYoJ7YouXjWqvHwiDeUcs=;
 b=Zhux08LSQCiEyVi6EKskG8r+mQQ395KeyOXvRFttBUnSJjfTwLWIAVUnFmT/oyOl7j
 0ZQQl+qYYd1pzzZMdydGcScVA9jr3AHR0p1rcwxHbySeEHlZhIl31J3n+sfiq3/Zr8Zq
 XQXaCYrUCGhH8ukb9C7fJqZ9rXXmgCSYUUMngo/M8BrbCNrvmo/dX4d1w+ImtdMMgnNV
 rjnIwb78UNo3Ki+EP4GEOBACn+uCDvdfw/3swZRRhRp2dymbO83YIid1qr1pxPsN8pKZ
 TDrW88sz7G4bRNW6bo3LLWTO9ki6u1ljUnrdXWIsf/CEZvO3QcLnZjATq5zra0XfTgOO
 i4lw==
X-Gm-Message-State: AOJu0YxCgMEd7cR1Hx3JDq+5gRQnTD1MskXcy71MIIHU+UB/xX0IajQh
 I8jhOn/qnTY1ZvDsslaWpsAZIw==
X-Google-Smtp-Source: AGHT+IH+ngzFDU9faV0d7Hcc2/3b486G+AlJvx/x6A8mnmzkSgzG/ZftC3rccgUkt+jcZs/DxZicRg==
X-Received: by 2002:a05:6e02:1748:b0:35d:42e5:f751 with SMTP id
 y8-20020a056e02174800b0035d42e5f751mr3946346ill.15.1701376448283; 
 Thu, 30 Nov 2023 12:34:08 -0800 (PST)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:d134:ced6:d34f:38a6])
 by smtp.gmail.com with ESMTPSA id
 r21-20020a056638101500b004665c3f56ebsm484788jab.15.2023.11.30.12.34.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 12:34:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 lkml <linux-kernel@vger.kernel.org>,
 Ahmad Fatoum <a.fatoum@pengutronix.de>, Nicolas Schier <nicolas@fjasle.eu>,
 Tom Rini <trini@konsulko.com>, Masahiro Yamada <masahiroy@kernel.org>,
 Simon Glass <sjg@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: [PATCH v8 1/2] arm64: Add BOOT_TARGETS variable
Date: Thu, 30 Nov 2023 13:33:54 -0700
Message-ID: <20231130203358.879796-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231130203358.879796-1-sjg@chromium.org>
References: <20231130203358.879796-1-sjg@chromium.org>
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

