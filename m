Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC68FFB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:27:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A115842F2;
	Tue, 17 Mar 2026 02:24:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UBUDj0ff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3C98842F4; Tue, 17 Mar 2026 02:24:55 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41868842C7
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-662efd1bdd4so184266eaf.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710692; x=1774315492; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rYLwOJCqUWxoEpWiud0ZX1O7q+CuWA5oaX11R6PNrXE=;
 b=UBUDj0ffZUsT6l5RaEtX920c0OzxTZPRgCPvR553muxi83tsMJaPTFT6uJw1kgZwDZ
 K+owsHiLaYFS6u8kjm+33yqQDKDweuSYmaEEODoTOAQAXGwKWvgIq2TWqndpDDepV1st
 EtYDJyPw4+ycPdWsvKRRL5vNqXCGYnUQuLgtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710692; x=1774315492;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rYLwOJCqUWxoEpWiud0ZX1O7q+CuWA5oaX11R6PNrXE=;
 b=mFvo75lVQs2YR7hZm1+hXm2PycVFRgBJKgvrXSVIagzGwjUuutDdgJUYaCJ82OMO0G
 JNCWd67b9thQ0U8Pc2TokwIf3MAo36PIk3B/53uKjNp7DcXds9c9wuk4CCH4H622XL69
 Mb126xcVAP6IhTI18FLCENatbB50YoZ/mDMNDKixUD7vX8/Gz9wwCOPZdjVNZtbwnrKq
 05U/en5TsmX3CZSuHpAPCWql/RY9Av7qUI6nKfHlJ9A4V3h67XZmQ3INVNlNcj2faFLU
 a7Hcuoo0WfneUnRDqq0bavAYV4axBF5qX5NxTqA8y+K8cjYn8+p6qnpx9cf++hZsOXFL
 t4tQ==
X-Gm-Message-State: AOJu0YypVHG4cCYsY4uE1CNe3Tah/geAo3xzGXaI3lI1Aj0sxf7agJ4C
 QnCaIP2Ow1n9bPl/bPJmN1cp7BH2mi64VQi2NHTfGUv5p7nz5SRxzZFIFSlx+A2mJpQbXOtKxhL
 SBbahMOI=
X-Gm-Gg: ATEYQzwfSdNJKVkkzrGghQ9tLNhtKrrPxuLXAd9W/QhnLJ/FDxr3gdV3vr2d3JosEAZ
 o9D0+Hwv2HCTUHbapdc0Kmwrqc6EdZ1UKj5qla7hc7i3dll5WvnyYCTK+Qw8eldy/AjPFUIsRzW
 AQJa3BqlAxP4gPuXczTsYXpJgDBAwRZq3VU3VSqjxEFaycz40gFw6eUuFgs56LHxxgngCXJBdps
 uTWg8aWPZUUjb01m18NtgYj1F0EAxRvGIc9ReAqcIwCFXkwT4N3fMY3Z12BB8VBjXi/pZsClgr1
 DCHw9aQKDItZBCbyk7gUIi5rcFlbunX6BWDIJ6lBsKsIKt3PvUE7ojLGgDp+BBFlqweXE/xKl7K
 GvW4wURYbtMfqAAiozcmgh4NinA/TD2TzCnHByKkhCOvB78cTg+y5zXh3R6ooukVPW8R/DNi+dt
 ZU+G54p7hgYcavfwP+kir8EZGRQnEcOtnTG+w6veI0Q0XZuM6gwFyp+rBix1qxfKghPMprPceaS
 dEMiC4dCYF0mRhq94VOL5cT3dquMWGThcNYrYCu15ZJd7/Ij+U=
X-Received: by 2002:a05:6820:1889:b0:67b:df8a:6d86 with SMTP id
 006d021491bc7-67c04992757mr894047eaf.23.1773710691803; 
 Mon, 16 Mar 2026 18:24:51 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc9118bc7sm11181202eaf.6.2026.03.16.18.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:51 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] EFI Loader: Correct dependencies for EFI_HTTP_BOOT
Date: Mon, 16 Mar 2026 19:24:49 -0600
Message-ID: <20260317012449.4162666-1-trini@konsulko.com>
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

As exposed by "make randconfig", we have an issue with the dependencies
for EFI_HTTP_BOOT. As this is implemeneted by running commands (as seen
by what it selects) it must depend on CMDLINE as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 lib/efi_loader/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
index b5f81e0ff530..a9b2f813e1d5 100644
--- a/lib/efi_loader/Kconfig
+++ b/lib/efi_loader/Kconfig
@@ -600,6 +600,7 @@ config EFI_BOOTMGR
 config EFI_HTTP_BOOT
 	bool "EFI HTTP Boot support"
 	depends on NET || NET_LWIP
+	depends on CMDLINE
 	select CMD_NET
 	select CMD_DHCP
 	select CMD_DNS
-- 
2.43.0

