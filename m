Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7ACEC2BD09
	for <u-boot@archiver.kernel.org>; Thu, 27 Jun 2024 08:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4AE5988580;
	Thu, 27 Jun 2024 10:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZV/SnurR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33C0388572; Thu, 27 Jun 2024 10:30:00 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CDBBA8852D
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 10:29:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-366de090da9so3585513f8f.1
 for <u-boot@lists.denx.de>; Thu, 27 Jun 2024 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719476997; x=1720081797; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4AgDkU3kc+gE9cH9KGK92Fgrg6aAJ0qflIR6mzpaVBA=;
 b=ZV/SnurRwSxhA/72bix6uhMH7qiRp0Qvk6Dv6KkQ5S3uaGPenadaseknTePP3X+6uX
 KSOwoL5DR9C3p5vFG3cQuaZOW8Be9ccMOmqLuuijb/3PnF/l1Z799yRDc3vvThRns1Gk
 QvG/xL3wKHROn8DmCGURUPnVEwlS3jozG4Zh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719476997; x=1720081797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4AgDkU3kc+gE9cH9KGK92Fgrg6aAJ0qflIR6mzpaVBA=;
 b=nZwSGukvZnvfmMClYZaGlCGJkmCjhpBaQfuT0SPpP6WQNXJBXMWPlmTNIafYGJK9jE
 cwQjsGClq2EU01c6fIgnt3qnafyEz1rtFGWLBrIIlAxXQ1jL428rCGdgEbTzj7yhTsuH
 ED/lOeTBy0njbiSk+WJ2kD+GhwR/E4IskjI8aPhYiTa6tVChVgcLqxnMLldCfKhiv7XA
 +IZsP6jqdLL/gyQ+AxPCfybpa3IGC1P53pOp1DF2cM9zFHKTkWQUTBvXlrdhRLnqY2qv
 JCpICyG7IJUhpNez44SHGV9bdzhRms2rqPSImkN9OytMCO2L+EGLd5xFrjMr97gac+Pt
 JNCA==
X-Gm-Message-State: AOJu0YzGzSyMyLZCOztAjpjC5BTnc71wZT6bB+SzbufH2y3vJ5w/IF38
 rI0ZL8jyN8lA8RTrXUjX7CNkvH3CzxBDO3nfYfJ5/GHXXEQtT29R0jU8l1+Ij2F+2yrE3FSrtad
 Lug==
X-Google-Smtp-Source: AGHT+IHET53KxcWwA3ULVzcNEFACGKh5FmTt9KrVkuXLws0sFClKnZkINu51iemf2AsGJ222ZmV3iA==
X-Received: by 2002:adf:e881:0:b0:367:3d12:4ffd with SMTP id
 ffacd0b85a97d-3673d125212mr1458735f8f.18.1719476997139; 
 Thu, 27 Jun 2024 01:29:57 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3674357c1c8sm1106534f8f.9.2024.06.27.01.29.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jun 2024 01:29:56 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v6 2/8] tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
Date: Thu, 27 Jun 2024 09:29:43 +0100
Message-Id: <20240627082949.357089-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240627082949.357089-1-sjg@chromium.org>
References: <20240627082949.357089-1-sjg@chromium.org>
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

It does not make sense to enable all SHA algorithms unless they are
needed. It bloats the code and in this case, causes chromebook_link to
fail to build. That board does use the TPM, but not with measured boot,
nor EFI.

Since EFI_TCG2_PROTOCOL already selects these options, we just need to
add them to MEASURED_BOOT as well.

Note that the original commit combines refactoring and new features,
which makes it hard to see what is going on.

Fixes: 97707f12fda tpm: Support boot measurements
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Put the conditions under EFI_TCG2_PROTOCOL
- Consider MEASURED_BOOT too

 boot/Kconfig | 4 ++++
 lib/Kconfig  | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index 36bdc83b957..4c9d2c0f79a 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
 config MEASURED_BOOT
 	bool "Measure boot images and configuration when booting without EFI"
 	depends on HASH && TPM_V2
+	select SHA1
+	select SHA256
+	select SHA384
+	select SHA512
 	help
 	  This option enables measurement of the boot process when booting
 	  without UEFI . Measurement involves creating cryptographic hashes
diff --git a/lib/Kconfig b/lib/Kconfig
index 189e6eb31aa..568892fce44 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -438,10 +438,6 @@ config TPM
 	bool "Trusted Platform Module (TPM) Support"
 	depends on DM
 	imply DM_RNG
-	select SHA1
-	select SHA256
-	select SHA384
-	select SHA512
 	help
 	  This enables support for TPMs which can be used to provide security
 	  features for your board. The TPM can be connected via LPC or I2C
-- 
2.34.1

