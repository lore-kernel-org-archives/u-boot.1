Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37F5F483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:52:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9959E84172;
	Mon, 23 Mar 2026 20:52:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kZoWf/ws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9C018409A; Mon, 23 Mar 2026 20:52:50 +0100 (CET)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0D598409A
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:52:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22f.google.com with SMTP id
 5614622812f47-46808125d28so351246b6e.1
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295567; x=1774900367; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=yJSlFk/H+NgMJfxGgjJ+fe+c/IS1l8yIU+dTMVUSyfI=;
 b=kZoWf/wsGmpdvmjBsD4aro6PkzqHT9z2lZS8wvsEuIDjZErOaWIvV696rZBm2Vuj1j
 v0sNsiSkzxL8xA9DLfLpVTuDyq/HPM9WL2Yijjhov4i2dOg+OtD55Mc/PNeffGMexV7P
 UXudnneztwpXDRRMCaDpgtKm+2MwsfDdA0O4c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295567; x=1774900367;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yJSlFk/H+NgMJfxGgjJ+fe+c/IS1l8yIU+dTMVUSyfI=;
 b=lhzb5qhKCV3fwwpNwRgsLyyMmV4Wgz/KPITS3HUFbKv9s2NEw/PIlFiR/zG8c8OsKg
 y41fGoaV+EmQO2MDZ8Cts3uUDQVhXDK0cvnTOWy6kVvpw5JfFdXkNPrlbFclE3IUA/kI
 SxuXXRFLaujyrliuZ9Q75EGRm+ikTRgZ2Nl7MkHpBVwEqd4LoyN1b1OZ1KQ5yWf6SxNx
 HLqBHMuJWleSBG5se2/yW0xoZOomo3Ms/PhK0H0e9x+S05IJNlLFe3L6+2VoOUQifxRQ
 /NmxX3RNLD0B04z8rEneYeZ+uc33cyBffhZXdELLTONXJlkMNT6C/4ZD93MYlzROh4e7
 LdmA==
X-Gm-Message-State: AOJu0YxGGIMeiUf1Uum2GIavXIwyZ4YHukX9Z1BadkRkPNFE4Gop/Nv7
 pvB9yBWfNYwN9nPhDcUwN3PavdaPQbeLO563wj6/J+q3W4jlsvMCFeJDjxgXQB7RNvC0gamYuEn
 2c5BZnL4=
X-Gm-Gg: ATEYQzzyouCmGI8GiyaiZaoHNyp3U2vYcf/DjIdQfqvCHFyfvhcZajuyQ5K/CEddAAD
 q6rD6nEOOX8UZvZXh70r3iFboGbSakSNDnulGFzVfQtlr/7fEEGtnizBAasgL7ktrMwrHyopJul
 m8J1+BP9Vg1aHpjBxKmhNzexkN8nvWtvADhWOAazva2ECdN+7HtAUN0k+0AMXX9IgV7yT3NDlPl
 z1hIEi438Z05WvgMDDBzkr3jBBD7XzclbOaVb35SxcbZjVKRnIfcmmUgO4TrM3gN1G03qfWWNwU
 wr+ZNh3oRK5nPNu1JpmWiBe2USXqGN5ztH6GtsvvAIpy13KODczLhO483G2Hst/692JEZnOyCrP
 z0H3DNnv0mKPDd4AOpg/ENrDh/Ct+BxRpJGXSZG9hlQsxM4M8MRUlsg4dJrq954JRCh3IomoDwF
 A3+2cC1oIxXwPjNAwujEvohf+C6SzeiCSWMph06jdaaeoIPkbZstaO3AH2s5FBA1B1kZJH5r3tj
 fcDR4aC58FRE9/q8tc4Zfm5P1lkqccRwL9BkiWbZh8ZObPfNGI=
X-Received: by 2002:a05:6808:144e:b0:455:d5d1:8ac0 with SMTP id
 5614622812f47-467e5fe31c2mr7686330b6e.53.1774295567201; 
 Mon, 23 Mar 2026 12:52:47 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14d63aa9sm10621195fac.10.2026.03.23.12.52.46
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:52:46 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] lmb: Rework the LMB_ARCH_MEM_MAP symbol
Date: Mon, 23 Mar 2026 13:52:45 -0600
Message-ID: <20260323195245.2363420-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

This symbol should not be enabled by the user directly but rather
selected when implemented in a given platform. This converts all of the
current users of this feature and hides the symbol.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/Kconfig                              | 1 +
 arch/arm/cpu/armv8/fsl-layerscape/Kconfig | 1 +
 lib/Kconfig                               | 3 +--
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4c4c070df87b..e28e4c4bce73 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -306,6 +306,7 @@ config X86
 	select DM
 	select HAVE_ARCH_IOMAP
 	select HAVE_PRIVATE_LIBGCC
+	select LMB_ARCH_MEM_MAP
 	select OF_CONTROL
 	select PCI
 	select SUPPORT_ACPI
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig b/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
index 20883fe68250..4c5b38e3b659 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
+++ b/arch/arm/cpu/armv8/fsl-layerscape/Kconfig
@@ -382,6 +382,7 @@ menu "Layerscape architecture"
 config FSL_LAYERSCAPE
 	bool
 	select ARM_SMCCC
+	select LMB_ARCH_MEM_MAP
 
 config HAS_FEATURE_GIC64K_ALIGN
 	bool
diff --git a/lib/Kconfig b/lib/Kconfig
index 46384283c435..4e6a0c6a1b63 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -1277,9 +1277,8 @@ config SPL_LMB
 	  the data structures needed for maintaining the LMB memory map.
 
 config LMB_ARCH_MEM_MAP
-	bool "Add an architecture specific memory map"
+	bool
 	depends on LMB
-	depends on !COMPILE_TEST
 	default y if FSL_LAYERSCAPE || X86
 	help
 	  Some architectures have special or unique aspects which need
-- 
2.43.0

