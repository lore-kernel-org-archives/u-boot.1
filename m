Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B720AC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:45:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12E9480F53;
	Sun, 26 Jan 2025 19:44:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CySNIgqx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F1EA80FEC; Sun, 26 Jan 2025 19:44:24 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65EB780F53
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3cfce97a3d9so5533485ab.2
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917060; x=1738521860; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sEUI3J9X++6w+hO3Frr5mZgDQaNWWQSREWcxtWi5Ng8=;
 b=CySNIgqxC81+jkkpV4K9HSn+ZA7+r+rukwGjxyyyhRgks/pySYmH2JFAxBkAofmqi6
 +cnFYMacSnpZc3ufX8I1TMQevjaRsc8R2I/M7lk6+xQZjPxMlhHyiJIm4xg2Ka/iFfQi
 0/IL1cbEYeVbJ+i5KgiJT/orq1hI/0EAemasM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917060; x=1738521860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sEUI3J9X++6w+hO3Frr5mZgDQaNWWQSREWcxtWi5Ng8=;
 b=be65fvkHAIxMrVhvyZXrMJnmpXc7rPPeQdFYrdl0NejEs3foftERNZgP7XH67DgL0q
 eFuNT5HOoNHLye1fP3Vv0MlrKEN9FsqSKmrmPJtU2Pw6fsxTIzkJjoQ9kOYVVe490lCp
 q8sP1rF27MaTg5p3C7DjA2nqKTIpHKFh/uXwd4LeMn4ip6Joui2UMx2WY7A5OqMak8pM
 Zga1j0xJPgDRc7kPy327B0Y3/eMAIWQuj2Tds1GBmwvWmBUlfr/80XS/696/tdPnVTQm
 +/PVgcxdvBwuGBCYbE60MlQCoalTabiCuSu5jRzCsL0LsbmpLmhRMJR5JLptI7RNNJml
 qvnA==
X-Gm-Message-State: AOJu0YwL40bGV5cbxdDN1zf+9/5Hqf6h79GeMg//Jw5vnrJAakI1ARWb
 AKJPwmNZO8mGHuUy8Joouwjp+MsI5JGLtBAEKA7AzNdsFvD9MgnonQmacXwERfZKYwHoR3ihWvU
 =
X-Gm-Gg: ASbGncuyt9dnePcQsNjbTgCNCTa1x5IYwkZBD0NkZ071NI7lKyQx3v0asfsKnLgNS8l
 Pzg7JtwBSWP+dQRyQx0ZvLtifrPclNo4RqHCnxcb7yFVgjo1Jb2uWaoPR9h9JCXnJj3Xq7Gxj1C
 gKuBUtJtSPzAbwOfOMbhKtc4Gg+c/wb5xboNIpBpvZQF+wpdCHO6o4mLMbdvFlu0DFQfgUyYEc/
 xtajfdXDluIZe16zUUHBA08gt/qz/YK//XzWLMqtzfw5VxUIaucCfMEfWocKux/OkxZKXbfk4Fa
 HPsr3vQ7nibadUOgTEp8eGgGIbMsK9rgyejjnkQQpA==
X-Google-Smtp-Source: AGHT+IG9sNk2uIRA62TU7PHeG0n/wAaECMLDFefGrEqfF4vJRa74llxsicnyuc7Qhxa8yOnwbru8Bg==
X-Received: by 2002:a92:c245:0:b0:3cf:bc71:94ef with SMTP id
 e9e14a558f8ab-3cfbc719579mr116073185ab.17.1737917060268; 
 Sun, 26 Jan 2025 10:44:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Gary Bisson <bisson.gary@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 15/19] vbe: Support providing a linker script
Date: Sun, 26 Jan 2025 11:43:25 -0700
Message-ID: <20250126184333.4058848-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

Allow a linker script to be provided for VPL as it is for other U-Boot
phases.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/Kconfig.vpl | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/common/spl/Kconfig.vpl b/common/spl/Kconfig.vpl
index 97dfc630152..cf6b36c8e38 100644
--- a/common/spl/Kconfig.vpl
+++ b/common/spl/Kconfig.vpl
@@ -9,6 +9,19 @@ config VPL_BANNER_PRINT
 	  info. Disabling this option could be useful to reduce VPL boot time
 	  (e.g. approx. 6 ms faster, when output on i.MX6 with 115200 baud).
 
+config VPL_LDSCRIPT
+	string "Linker script for the VPL stage"
+	default "arch/arm/cpu/armv8/u-boot-spl.lds" if ARM64
+	default "arch/\$(ARCH)/cpu/u-boot-spl.lds"
+	help
+	  The TPL stage will usually require a different linker-script
+	  (as it runs from a different memory region) than the regular
+	  U-Boot stage.  Set this to the path of the linker-script to
+	  be used for TPL.
+
+	  May be left empty to trigger the Makefile infrastructure to
+	  fall back to the linker-script used for the SPL stage.
+
 config VPL_BOARD_INIT
 	bool "Call board-specific initialization in VPL"
 	help
-- 
2.43.0

