Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C537AC02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:05:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 81C4480C96;
	Sun,  9 Feb 2025 03:03:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YC2Sua6u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F04C480934; Sun,  9 Feb 2025 03:02:36 +0100 (CET)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 588FC80834
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-3ce915a8a25so11175415ab.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066551; x=1739671351; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OCde0bQEHfgN7EAeawnv299sbGGKVtzag4sUWemDxFM=;
 b=YC2Sua6uGsKB4tuV7IS5V75GW2xA8lm1v5yXGmzDWaYUVXLcPL231SPVXdX2q1SZNN
 sqfOIAFFtE3ECbxxhPqPeykhE/cjnDWq8wsFPw9RoYFojuZtZrMoXchJ0gqkNTsw91uk
 CLOytVVYRcfF90NlXNOyT1lxI0/pAIaVf7Jp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066551; x=1739671351;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OCde0bQEHfgN7EAeawnv299sbGGKVtzag4sUWemDxFM=;
 b=EWFO4JNATXBbbry5u/jIC5rKE4dILsjY3xtNu+U1DU+jLf1Bz/QYdt68pfvFdrSw20
 uxBhC+16o4azAyH4si7ibCZ3bKyce4L9Tb+eiAjlTwiBre4mvKHLn9R6xWzF6qlmurQZ
 arRoNmbvtH+a7O2zdEgu5LUho6LoSpc7IIhUWf3v7hkzejV26a4QybCAIwmqNj2Z9G+T
 5nXfuj/27uQxhpDpLJc/R+LLRpUZbH9nm1bD4fOYk8KJp2qSgUUd6qGkiKrC/YdZEIjI
 lOKecSHxB4e7utiUpKFECBO8RqWe6X/O4IlkC085ogDVV2DolbT5HqZp/bncWOHKs3Ne
 8P1A==
X-Gm-Message-State: AOJu0YyJAq7OyDiICQbQVDKm3C6by+SikTWT1Cn59LUl8DCPg3aa5Sou
 0Qvd8cuYhg0U/M+AcFla+z5inuMm35IEyAkT+he7nX3EsNWFA9Pf84yn7phfkB3CMQK+b8SF9uk
 =
X-Gm-Gg: ASbGncvlRXOaKguwlkCeEqiglWgl2k2+21Fb8ABTNFJZH7nIglWLwQQcjP6NTRmQceT
 onZ0SUwzkAI5O/q/tBCIhaHHH1oeOXRAzBJw/+NeSfBB9ocaxWbAsH06uySk+nzcTxfOTJ4coyK
 vyvhL6PoH3swf9LXm5YA94px1qLJL3xOHTzaB+nQFMLHHq+3r80aYzs1BbjAoJPuEKzdWsbyiSO
 qSqQC3/RToJB3F2dNild4We5PzJQBL4xt+mAfb1oyGrIDyrnsMj71K/dastX61fI02D8v92NglY
 bAiWf99EU8NhIC79x6Jqrp7KuXjdiPnZ/LIElkXF9yLxWWRfI3u0
X-Google-Smtp-Source: AGHT+IGbAsgxQVe69tETeqUSryzQs0JTlBV3kj66rChk6pfKpq8yvawX8TD8nj9MEwo8GEOggoh4Ow==
X-Received: by 2002:a05:6e02:1909:b0:3d0:1abc:fe03 with SMTP id
 e9e14a558f8ab-3d13df2351bmr80513465ab.15.1739066551607; 
 Sat, 08 Feb 2025 18:02:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:02:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Albert Aribaud <albert.u.boot@aribaud.net>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Greg Malysa <greg.malysa@timesys.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Raymond Mao <raymond.mao@linaro.org>
Subject: [PATCH v3 18/29] efi: arm: Omit the ARM start-up code in the EFI app
Date: Sat,  8 Feb 2025 19:01:17 -0700
Message-ID: <20250209020136.4108987-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

