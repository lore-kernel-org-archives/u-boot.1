Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1CDCDE03F
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 22:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F99F88FAF;
	Fri, 27 Sep 2024 00:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="j0q3hvrN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3CD688FAF; Fri, 27 Sep 2024 00:41:12 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B748088F75
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 00:41:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4585e250f9dso7656721cf.1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 15:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727390469; x=1727995269; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3qy6QYgZG0mcCXVL3033yauqrIcen+t4Ud7gaeADW6k=;
 b=j0q3hvrNRu1vcEcHGkURibpvNaVfLQlOxVrGBpFAbqeEbQCGLyJiolO55mhcNBzReY
 tTt2yuogwtft9HHJ4ufDT8tkCVShIblVgVADZbGrUsO2oB8/VLe3Ax0bk5Y2CNOjRphR
 FR4sHAM+jhCkg+gnVXRRAtl6WJ4bhbqZ94bu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727390469; x=1727995269;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3qy6QYgZG0mcCXVL3033yauqrIcen+t4Ud7gaeADW6k=;
 b=V4HVdok6M8+wr97ZSn/qJ/ivzwxy0LZPPGdn7goBEbkbiVmspc6Wx6s0/gnk3osFpb
 B+LYHAXUqRoz1ZlL77MK2KJy3uMI3tg4EpvW7TyjRm4vkbxUmECgvvkGIGKBve9x5Tx4
 i56tkfvRLRfUyE6bYkkyew6P53u9edzsNbynbjByRjdQpEASES19O9cbudU9+RyrbJye
 XNxDi1VpDxJ0LXGEpLsa9+83g9Sdcf+FfE45uF7Y5MRBQVgqSFwsPm5d+hKJfet63J7K
 W7hMNuiyrqQ2PL5N2yrLQCGMG9Snk4NP8u2bb1D5xePqCu+zFXJXcWpC3sZXDhho0fuE
 MQcg==
X-Gm-Message-State: AOJu0YzO1+TtjKUp5J+qtSY0EyKHcIvlihKkTxaFgRNaInIMxnE+/b6W
 URPufsVIBXx/ZJ1VOCpDOTDTJAS0lwuwj/xQ4xZIxgrARlk9YS431JKeuxQDNh78o6VU1F/MxRQ
 E9g2kY7I=
X-Google-Smtp-Source: AGHT+IHR2e9qQ9w5+aCZUk41BiAc8lFCTalkW2exyloh7f+1XTdS12AGAaUiq6x1d5UXx2nz56LFoQ==
X-Received: by 2002:a05:622a:551:b0:458:5b86:614a with SMTP id
 d75a77b69052e-45c9f301e31mr12044381cf.43.1727390469494; 
 Thu, 26 Sep 2024 15:41:09 -0700 (PDT)
Received: from chromium.org ([205.220.129.31])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f350fadsm2738461cf.80.2024.09.26.15.41.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2024 15:41:09 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Thierry Reding <treding@nvidia.com>,
 Tom Warren <twarren@nvidia.com>
Subject: [PATCH 09/42] tegra: Use SPL instead of SPL_BUILD
Date: Fri, 27 Sep 2024 00:35:34 +0200
Message-ID: <20240926223814.1276764-10-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240926223814.1276764-1-sjg@chromium.org>
References: <20240926223814.1276764-1-sjg@chromium.org>
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

SPL_BUILD is not a Kconfig symbol so presumably the intent here is to
use SPL instead. Change it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/mach-tegra/tegra124/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-tegra/tegra124/Kconfig b/arch/arm/mach-tegra/tegra124/Kconfig
index fb016aa46c9..61bebc10a97 100644
--- a/arch/arm/mach-tegra/tegra124/Kconfig
+++ b/arch/arm/mach-tegra/tegra124/Kconfig
@@ -21,8 +21,8 @@ config TARGET_CEI_TK1_SOM
 	bool "Colorado Engineering Inc Tegra124 TK1-som board"
 	select ARCH_SUPPORT_PSCI
 	select BOARD_LATE_INIT
-	select CPU_V7_HAS_NONSEC if !SPL_BUILD
-	select CPU_V7_HAS_VIRT if !SPL_BUILD
+	select CPU_V7_HAS_NONSEC if !SPL
+	select CPU_V7_HAS_VIRT if !SPL
 	help
 	  The Colorado Engineering Tegra TK1-SOM is a very compact
 	  (51mmx58mm) board that is functionally almost the same as
-- 
2.43.0

