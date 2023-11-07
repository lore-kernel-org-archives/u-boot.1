Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0755CC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 14:49:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 134D086DAF;
	Tue,  7 Nov 2023 15:49:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i91pvZ++";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8915E87045; Tue,  7 Nov 2023 15:49:27 +0100 (CET)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A6A986F44
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 15:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-7a689bd4928so159903039f.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 06:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699368564; x=1699973364; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
 b=i91pvZ++HhzhGFxj3HoMePEGKLSbmpCgZ+E75x7vyjici7zfy3/wobPW4v6Wff7HNt
 kEK9DUzTZnEe2i5mIXGiHDQR2tc+Joh5TwGOsxN2OrvkrWwq1m9s8s2VC7jIvsqs8gKv
 1VysZnuceJ1TxIdgTxDvqjZmpKzhvWFlENG6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699368564; x=1699973364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
 b=pjryEoYL5DUVNLeoLNUj8lLiCRsGo3WANlAsoX6MnLXkSWmVMONIlS92g6ObZ0xmWB
 dksSdbrxRMLAQyfR4un8mW3oFeO6Vx/GJ9/7PJJfVru/wGkdVQ5O0jYcUt5zMx/fKiCm
 G3q01PnKCM0WXUyHJkYmNHmXvhyhIWOQljrJFFNraFSMpdmXtGA+YyueSgosyNjnd8Ek
 dobsL550kePBhDnDeB20NWbLv2EJRW9odTsFTkSE86tx+TKsb1grPe+3dysMJcJn9t90
 VMgMVCMPq7Z64oUtrKpb9nXdHgrrsJzThSHVmdDhwmfYOXwJBq1fN8H/SPZfViuWRvLe
 AfUQ==
X-Gm-Message-State: AOJu0Yz0rKtJDgCt75QJlWJYu5NtJH0aSKPoCq//hOt4FZ15Zn+qjMCm
 otYGTvRDkS9IfD4d2h4rV4sYrw==
X-Google-Smtp-Source: AGHT+IFwrc4laN5WRGczr1HIoLEY3sGt0wG6iwQWSFLgABNJrxoQEvucY/YLmMfcQGEwsAJ+0F9v4Q==
X-Received: by 2002:a05:6e02:1bc3:b0:359:3491:9042 with SMTP id
 x3-20020a056e021bc300b0035934919042mr3014205ilv.9.1699368564218; 
 Tue, 07 Nov 2023 06:49:24 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 b16-20020a05663801b000b0045a66a26208sm2815200jaq.128.2023.11.07.06.49.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Nov 2023 06:49:24 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] kbuild: arm64: Add BOOT_TARGETS variable
Date: Tue,  7 Nov 2023 07:48:49 -0700
Message-ID: <20231107144917.48304-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231107144917.48304-1-sjg@chromium.org>
References: <20231107144917.48304-1-sjg@chromium.org>
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

(no changes since v1)

 arch/arm64/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index 4bd85cc0d32b..7b77b63e978f 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -150,6 +150,10 @@ libs-$(CONFIG_EFI_STUB) += $(objtree)/drivers/firmware/efi/libstub/lib.a
 # Default target when executing plain make
 boot		:= arch/arm64/boot
 
+BOOT_TARGETS	:= Image.gz vmlinuz.efi
+
+PHONY += $(BOOT_TARGETS)
+
 ifeq ($(CONFIG_EFI_ZBOOT),)
 KBUILD_IMAGE	:= $(boot)/Image.gz
 else
@@ -159,7 +163,7 @@ endif
 all:	$(notdir $(KBUILD_IMAGE))
 
 
-Image vmlinuz.efi: vmlinux
+$(BOOT_TARGETS): vmlinux
 	$(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
 
 Image.%: Image
-- 
2.42.0.869.gea05f2083d-goog

