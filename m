Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5553CDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 15:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599AA8746E;
	Thu, 19 Oct 2023 17:01:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="s006q8MB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5ACF28745A; Thu, 19 Oct 2023 17:01:28 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29D098743C
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 17:01:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5a7c7262d5eso101377177b3.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 08:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697727680; x=1698332480; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pii+ilK/8C/sJB44X4gspcJAIz0PQIbgF91TsVKBW7c=;
 b=s006q8MBdt2F2T0i8JmZzLtKTEeEDi95mH8MslSpN7YRJZc+18aUjRSZbYpKMKN6Ql
 q/FOcGPos+9+5ujjjO0CittVVW2fNCwJWLsGrhAgSUgNq1NWwVaoVlWxj9IcxmWI68HB
 I413naEMzcfxXD0uEpnrPdPfFMm0X9YjcU4Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697727680; x=1698332480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pii+ilK/8C/sJB44X4gspcJAIz0PQIbgF91TsVKBW7c=;
 b=YnHjS2a33WMinAOriHPyLUqHdhBVSqdufPrUQz9YrcSmiLPTWo5I+ENYhHOPnvFzNW
 SBZfC3d+YyqREloo39PG1VIHfwjXpUBg8REt1U/z2z+X6Kvoaw4iTg4bwJ54he3JwHEa
 Odqow2WD6eT1RdKKakLbd7OvoMfNAt8dB8yAOEHifSHHG6Y5bqXCYbD6KCm+uW13Un14
 Zft2Mk7z0LKajv/2iQ6rf9EsHP9jRCgNRtWsPHqn/7SLv8b7MtqP+1H+90NA9syQVXbg
 SKmv7xGtl7emZjbs+J/4SCvbrkK+AsTR4rMvimwPcsUtPjc6za3orya6OYLEw/l9Mium
 6Ohg==
X-Gm-Message-State: AOJu0Yz/47tKypjxhQdlb/UzLKGJlK/Wq1AlV0gyyZR/2DO3zaGB8idU
 6NnDS/PfvioYCSOyDgNC2QwUZKXru6Qg72m+SkHO7w==
X-Google-Smtp-Source: AGHT+IGsOjRAMBHOjxS3Pm6gXjNT4HLA+geXSHR/6G32cdy71ZTRH0YfMpywHE5p9mrIL8IRDUQWEw==
X-Received: by 2002:a81:5dc1:0:b0:569:e7cb:cd4e with SMTP id
 r184-20020a815dc1000000b00569e7cbcd4emr2129557ywb.48.1697727679504; 
 Thu, 19 Oct 2023 08:01:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 c11-20020a814e0b000000b005a7c35a1396sm2475077ywb.29.2023.10.19.08.01.18
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 08:01:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v4 12/24] bootmeth: Make BOOTMETH_EFILOADER depend on CMD_BOOTEFI
Date: Thu, 19 Oct 2023 11:00:53 -0400
Message-Id: <20231019150105.714407-12-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231019150105.714407-1-trini@konsulko.com>
References: <20231019150105.714407-1-trini@konsulko.com>
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

Today, the bootmeth for using the EFI loader via bootefi depends on
calling the bootefi command directly, so make this in turn depend on
CMD_BOOTEFI.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 boot/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/boot/Kconfig b/boot/Kconfig
index a01e6cb8aafe..e0ded3249343 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -504,7 +504,7 @@ config BOOTMETH_EXTLINUX_PXE
 
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
-	depends on EFI_LOADER
+	depends on CMD_BOOTEFI
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the
@@ -539,7 +539,7 @@ config BOOTMETH_DISTRO
 	select BOOTMETH_SCRIPT  # E.g. Armbian uses scripts
 	select BOOTMETH_EXTLINUX  # E.g. Debian uses these
 	select BOOTMETH_EXTLINUX_PXE if CMD_PXE && CMD_NET && DM_ETH
-	select BOOTMETH_EFILOADER if EFI_LOADER # E.g. Ubuntu uses this
+	select BOOTMETH_EFILOADER if CMD_BOOTEFI # E.g. Ubuntu uses this
 
 config SPL_BOOTMETH_VBE
 	bool "Bootdev support for Verified Boot for Embedded (SPL)"
-- 
2.34.1

