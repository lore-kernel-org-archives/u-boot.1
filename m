Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB293C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C167180C96;
	Sat,  8 Feb 2025 18:12:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XL7u3p0b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B10D680C6E; Sat,  8 Feb 2025 18:12:52 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83A9C80821
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3cfc79a8a95so10048645ab.2
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034769; x=1739639569; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCde0bQEHfgN7EAeawnv299sbGGKVtzag4sUWemDxFM=;
 b=XL7u3p0bo/oyLGXssIhO6adSNgsYGorTznlrRrrPa4IAU/au7dAXAtKfUr73BER33c
 KqeKhmAL5em5uV8iJuUogGd/MjXB9peSjvM5DODXSUpBrX8WVf55XEzKnlMDqRWTU47Q
 Z1aBYLNzDPBj8+gxH8AfimvdPwhfISs5hyVaQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034769; x=1739639569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCde0bQEHfgN7EAeawnv299sbGGKVtzag4sUWemDxFM=;
 b=oDTg8FI8K0TViieEf7yOY6B1nBw7JjOigprriSH59FpjgDdm2O5JO9N7Jdsudw9pzL
 NGaSfZ7kucMBeG5gQSXxnXr83ZEaz9prWgGPybXIsmmWk+gZz1/M6WtcoaTNj85thn7V
 AR/tcCFlGohRC+TaVwlY46HE/UurIPvsNY58vBrDGuxH89Ic+T+MWL/KHC+P3moa+O5H
 N7X0VSgjAqopeDR41VB79m8wvFzOE8XYim9gUXfoRfV18++/TZr6NhuvDKLAJ7TxxTKv
 THVUmhcvNqgqCDvMotMAXloxzLJ+ak+JJndoja0fLRByPOegTg2YyThgr7f/HVATNZOO
 G9HQ==
X-Gm-Message-State: AOJu0YzB8b1RCe//qlJDVfD4UkHeF9PMfvboB3uppo78D3Rdf6SJa94j
 FZ0ERMcGtQ+vd2A+9gF5Ft4Obk387RBlMzqpTN2m/rBqKBWIUTIN0uiKPV+fmlmPHVjKjmOCQyk
 =
X-Gm-Gg: ASbGnctHcocnefOL/dLkkL1uDlIHIKa4aZmlM2h+At//46fw/5U1vh8ZoAVAn5XE9vb
 xP+EGqFx8WdzDBJLM0q0GOgNSjwStbMPJw3ntqo2u7/pXszJWZVcNo3sID33dE6mJXBxWrK7+e4
 CBP6JkyoxPSOgVtcBx8dQEyxxddpHwl0mMaXIJVnnIkBZHbhNbb44fPqLVy1TDDlWISbQ0zSCf7
 QH7pwyYf42Vvwm4v3EP1bUZYGlwegurXkVu4qhRBy6q2z7rttALoJ0bkExUCDDjNJkXUggLWuaY
 9OLDBX6/pXGT0B5XoPLkl8Z7oTvGWX3bp2F8Jr+Rn9qz+WOqh4s6
X-Google-Smtp-Source: AGHT+IG+WYnxQvuAzINSd0gAXSkXN6qTta6aYIpQIJ/H/amsLlH3YisX/rMzeJSLQjMATdzO2v2Tpg==
X-Received: by 2002:a05:6e02:310c:b0:3d0:4d76:79ba with SMTP id
 e9e14a558f8ab-3d13df3e69dmr59205055ab.16.1739034768696; 
 Sat, 08 Feb 2025 09:12:48 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:47 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v2 18/29] efi: arm: Omit the ARM start-up code in the EFI app
Date: Sat,  8 Feb 2025 10:11:38 -0700
Message-ID: <20250208171154.1305761-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

This code is not used with the EFI app, since it enters through a call
to efi_main(). Remove start.S and crt files from the build.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 arch/arm/Makefile     | 2 ++
 arch/arm/lib/Makefile | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index cb87a684754..2e569b330d0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -104,7 +104,9 @@ PLATFORM_CPPFLAGS += $(patsubst %,-I$(srctree)/%include,$(machdirs))
 
 libs-y += $(machdirs)
 
+ifndef CONFIG_EFI_APP
 head-y := arch/arm/cpu/$(CPU)/start.o
+endif
 
 ifeq ($(CONFIG_XPL_BUILD),y)
 ifeq ($(CONFIG_SYS_SOC)$(CONFIG_SPL_FRAMEWORK),"mxs")
diff --git a/arch/arm/lib/Makefile b/arch/arm/lib/Makefile
index 14e3990925a..9500ba6fddc 100644
--- a/arch/arm/lib/Makefile
+++ b/arch/arm/lib/Makefile
@@ -7,19 +7,21 @@ lib-$(CONFIG_USE_PRIVATE_LIBGCC) += ashldi3.o ashrdi3.o lshrdi3.o \
 				    lib1funcs.o uldivmod.o div0.o \
 				    div64.o muldi3.o
 
+ifndef CONFIG_EFI_APP
 ifdef CONFIG_CPU_V7M
 obj-y	+= vectors_m.o crt0.o
 else ifdef CONFIG_ARM64
 obj-y	+= crt0_64.o
 else
 obj-y	+= vectors.o crt0.o
-endif
+endif  #  CPU type
 
 ifdef CONFIG_ARM64
 obj-y   += setjmp_aarch64.o
 else
 obj-y   += setjmp.o
-endif
+endif  # ARM64
+endif  # CONFIG_EFI_APP
 
 ifndef CONFIG_XPL_BUILD
 ifdef CONFIG_ARM64
-- 
2.43.0

