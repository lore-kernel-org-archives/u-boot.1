Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AAFC25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:33:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA74587BA0;
	Thu, 26 Oct 2023 20:32:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IHQHepjO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DAD87B23; Thu, 26 Oct 2023 20:31:55 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90A387638
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:31:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-7788f727dd7so91827185a.1
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345111; x=1698949911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Pii+ilK/8C/sJB44X4gspcJAIz0PQIbgF91TsVKBW7c=;
 b=IHQHepjOHE5/vNX3KsK2sEoLNVFS/NUKQHiV45NkLAo9rO9PgC0wuALbfophm5wzrp
 VzbOCEKF/KH6Gz+nPJLRIaU2+X0uEVxAhzaoyu2Be4Llv8Tsr57XfGZ/fcsxLDkxU5E9
 NrLdP8Anx6XKzoRIrMkRhW4hg3mpyld9RXftY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345111; x=1698949911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pii+ilK/8C/sJB44X4gspcJAIz0PQIbgF91TsVKBW7c=;
 b=i5QzfFNO0ZIkWJxmrizAw3giwyayo0ezmaQVB4veekL7LDBnInYVbwVYxGydBPz4kz
 ClM9vwyAlVtj+i2ligq61SqHUpglW21GqISgmcWfp7BVrt0bXwmKk+iAjBKTVsrRZOao
 OrzDXcZ9kG+lbrR5lkQ2fYlK9BhjUrTI5Dwupru/1ubfkwfkuYpRile42buekjV5XLwq
 eYn2mC/h2roTiCaEK8bW4u3N1gNA2vjQqiJiVT7rDdhj229kr7k8yrvNiwAitb7vVCsg
 DfmZ/jd6vBZLuJnzIik12q//98dm91O4muYfrgvrKJo81eGR6QUHkR2MWl78J7hK78go
 TPxg==
X-Gm-Message-State: AOJu0YwOIKId65JvH8kgxS7ieksokIxz71JE4ndaJW18LGgCBf2H1VnE
 FqC7gj5Mv7n+N9sDUsQf5yrpL87ZdeHKuVKvTQhnXg==
X-Google-Smtp-Source: AGHT+IEXPcOJU7qvAag00d2uEBULRMnrFTrgisU/nGMNuUYr7q6jLKlRrqCoORhEXgB8UODdTghbkw==
X-Received: by 2002:a05:620a:bcc:b0:779:cf22:7d1f with SMTP id
 s12-20020a05620a0bcc00b00779cf227d1fmr85672qki.31.1698345111084; 
 Thu, 26 Oct 2023 11:31:51 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.50
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:50 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [v5 13/30] bootmeth: Make BOOTMETH_EFILOADER depend on CMD_BOOTEFI
Date: Thu, 26 Oct 2023 14:31:21 -0400
Message-Id: <20231026183138.636948-13-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

