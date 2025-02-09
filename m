Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15F94C0219D
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:02:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C510080A29;
	Sun,  9 Feb 2025 03:02:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bG8VHGvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79081808E6; Sun,  9 Feb 2025 03:02:07 +0100 (CET)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 74E6980141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:02:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-3d1469adf26so5139685ab.0
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066520; x=1739671320; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kf8ylOqXl7b1+wgxiJRAoemFpGeDbA7ml1e9ftAQ2ck=;
 b=bG8VHGvvCBui8mSxwRpMHNiJLjL1kZqEC+zeq0d26rquZfqBjTDdl77wTEle3BPvhv
 lL9HnLm6ZYDxSJJ9AHLy7CyQxt1Vs56xnO/flcIWpJDPXKAeTH/Qdu3FdtR8uB372POC
 3INtMcT8VxcST+ENcI4Ze1zoBsXVtfiITzk/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066520; x=1739671320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kf8ylOqXl7b1+wgxiJRAoemFpGeDbA7ml1e9ftAQ2ck=;
 b=rA+PieXjDae2GaiE1X+YPwm6/tA7HiCxXTz8pmp3qpQ2IrAT4Otd3+eO3DmlmJM0zS
 /I7anKcZ9Ke5SDYpGvG+9gUhzRmzXnH3En/Ps8fmw6hflOePV2Fbzlln0PZOi6ri0eOB
 nwvbFVu4WR7yiBm84JxBQpZTlal/k3LZaAvMXA8RJs5WsxF4a+AcQWI+T4QG5WmGkRWp
 c+PJVA8ltqznY8FWV3uU/QGhtKu7wCRsjQ7I6B0UZgGlcSsgeoOR1t8asOIjheKsdqNf
 DX54wlrIFo0jkpWtczGTKKlG07GKVCmVad3gWzVv4rW9GB/EIYI7264oC2q0+XEJQZgo
 3pLg==
X-Gm-Message-State: AOJu0YyiGjosR2pr4534ex+v2NuXC7R3TYcLkDsPtZrXiKcjJ9AVBw72
 sQZjnJ9ZhOQTEo2AeklmSsXUiHR20Du7jmIl5v6j0RW/ApBxq2Z0wKsKnk0Igt1/fYF/YrF7Ai0
 =
X-Gm-Gg: ASbGncvSIol3YA1Qh+2oFO03uxhWK+YGfSDTHqlLc4jY+06J9JTDjH/IyThw9XyTjhg
 wCed9323KXkgXVWuNaT26StbDzmHPWNGEadn56NHIuiywbO8aSaEwCdiDbx8KdXtS1MAWMhVNMN
 RXaGtTBEddvP2Pa27nMhkGTjnsvMW5f/j+CuWccRoCckSN68mcQiBobjWn4zfaetgzXJ9XXiUKX
 nKIfKnuFYRJfh0sZcwz8QgVXpMnCuY79KmImKHmD7nGSbDOxpzt5glrdZ4JmSlhic5KrmaboTAq
 qi8+GILXXLvu3hMdwT5mxN3iujMXHPCw/5JC1Wl6gbSfbcFM90qG
X-Google-Smtp-Source: AGHT+IEeYC6mQ54+ONSNFfNXYcsDJ7BVWmgQB7kSvddlAOTP9OtwF+MhWzn9flgmUWrc9Bt8X6BPvQ==
X-Received: by 2002:a05:6e02:190f:b0:3d0:47cf:869c with SMTP id
 e9e14a558f8ab-3d13df2bfb0mr59446985ab.19.1739066520082; 
 Sat, 08 Feb 2025 18:02:00 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.01.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:01:58 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v3 06/29] efi: Allow board/efi Kconfig to be used outside x86
Date: Sat,  8 Feb 2025 19:01:05 -0700
Message-ID: <20250209020136.4108987-7-sjg@chromium.org>
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

So far only x86 supports the EFI app. ARM is going the same way, so
allow these options to be enabled for 64-bit ARM too.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v2)

Changes in v2:
- Drop the word 'Sadly'
- Mention '64-bit ARM' here, rather than just 'ARM'

 arch/Kconfig      | 2 ++
 arch/x86/Kconfig  | 1 -
 board/efi/Kconfig | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 6258788f53f..493c827d74d 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -544,6 +544,8 @@ source "arch/Kconfig.nxp"
 
 endif
 
+source "board/efi/Kconfig"
+
 source "board/keymile/Kconfig"
 
 choice
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 23a1e21b29e..80396a3a2d5 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -100,7 +100,6 @@ source "board/advantech/Kconfig"
 source "board/congatec/Kconfig"
 source "board/coreboot/Kconfig"
 source "board/dfi/Kconfig"
-source "board/efi/Kconfig"
 source "board/emulation/Kconfig"
 source "board/google/Kconfig"
 source "board/intel/Kconfig"
diff --git a/board/efi/Kconfig b/board/efi/Kconfig
index 9027ca8482c..7545f808585 100644
--- a/board/efi/Kconfig
+++ b/board/efi/Kconfig
@@ -1,5 +1,7 @@
 if VENDOR_EFI
 
+if X86
+
 choice
 	prompt "Mainboard model"
 	optional
@@ -33,8 +35,6 @@ config TARGET_EFI_X86_PAYLOAD
 
 endchoice
 
-if X86
-
 source "board/efi/efi-x86_app/Kconfig"
 source "board/efi/efi-x86_payload/Kconfig"
 
-- 
2.43.0

