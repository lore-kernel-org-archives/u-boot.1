Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8FFCC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:42:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69A2C8703A;
	Sat,  4 Nov 2023 20:42:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XPanSjaj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DCE88703A; Sat,  4 Nov 2023 20:42:35 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78DA786487
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:42:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-7a98fdeaac7so116316439f.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 12:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699126950; x=1699731750; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
 b=XPanSjajnltqWWdvWgA7ubne/JT6m4I9qtEpmwPEIV2mVsQENUPUjM5s+997pr7Qct
 iTThXHaJLZf225wxNW/PfFBnqNno5kr1Fc8WJpEkKKMUAB58uBOtejVW0wqljTMbevHl
 dKBGaLZnw7qgzUT2Jcj6YN07Zyn4AAic/mIWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699126950; x=1699731750;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mUczbla/3nICzQP9ZmDHPTBpFCCiTIH02+1QSP6Uf6s=;
 b=nnV6L/opkODtZZboylOL7qLRi5wMVliCQbEPEw/lj9YeMXF59S8a3GgIsxTe33TfLK
 NwTJkYg322a54vIxj5nKH/3sUxstoCoZRifgYbdzuohoI9rVFLV3L+d21ClJ3gmv4UOV
 RqC0Eru9VRcdq/rQfNkHYIy1DsreCY8HEzBeULP7BgpwQfO/Zag8IZOsiKi9fBjU9vUm
 dXiNUY5pw81FL1414rnx2znI6dZeUfpGOyRJQvBMD4ieM9W40TmVBimCygYcdLETkyAZ
 6ZUVTBTxMDKs1IOB3lg0dSKzu2KPvTUCFFDf8QrFDuqU+sLhJ8FdAzP7LDrpmPqCOg5s
 0iyQ==
X-Gm-Message-State: AOJu0YxOcVqdrBNxTm6li088nr9KnAimfBmkNFiau8B4AMSQqBXHrtfv
 2kaPepBHk4kT3frFhHFNAvRBiQ==
X-Google-Smtp-Source: AGHT+IF/fXvPBrPumTSxUQEBjtRyCDMgeyWz6G5jCVwdriNrUNr0MdYxjACyDjlaZtmvTvcGBTB3Yw==
X-Received: by 2002:a05:6602:1592:b0:790:a073:f122 with SMTP id
 e18-20020a056602159200b00790a073f122mr37121229iow.2.1699126950221; 
 Sat, 04 Nov 2023 12:42:30 -0700 (PDT)
Received: from sjg1.united_club.lax.united.com
 (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a6b5a04000000b0079fbb834232sm1293318iob.19.2023.11.04.12.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 12:42:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: linux-arm-kernel@lists.infradead.org
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Simon Glass <sjg@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] kbuild: arm64: Add BOOT_TARGETS variable
Date: Sat,  4 Nov 2023 13:42:02 -0600
Message-ID: <20231104194207.3370542-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231104194207.3370542-1-sjg@chromium.org>
References: <20231104194207.3370542-1-sjg@chromium.org>
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

