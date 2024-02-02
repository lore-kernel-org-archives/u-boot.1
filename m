Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7004C4828E
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 12:32:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0957A87D2F;
	Fri,  2 Feb 2024 13:31:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KV5csvy0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 519B1875B9; Fri,  2 Feb 2024 10:44:48 +0100 (CET)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 313E78756C
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 10:44:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3be3daeff38so1024230b6e.2
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 01:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706867084; x=1707471884; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OznycQGvdXCqrfrTacxYf3U8d/tFu9SYMlMCuFm5DnY=;
 b=KV5csvy0s+ytETN2BPp6Nv0qbL7P1xtIHjxYjN8q8PanPdKjTc7zKU4/UprDsWc5SA
 IcN7lglFmj8JWvjM/GEIFhGrc3kiJVuKqT7bcIeHSG4vGQjyOn24//m1sWZc2k0NmLmP
 PURyWk+AbD7Hik5CUWegceRyJFzFuV3nMU/9rjXTzdLal+fmlaljiSP09FAxd4VpCzr3
 wZSvugMUfw1P5/uVU+drlkQlnazLj3NeGmCzGnW1l3AuIoudd6y/0SxzOt83WsR4A03S
 rj7gREMUhM/wqtbbN7rF/X2O2ilwypDaUc9h/2FkaF6bOOZ0GL7RlxqGL7pRrzP1Jfd1
 6iGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706867084; x=1707471884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OznycQGvdXCqrfrTacxYf3U8d/tFu9SYMlMCuFm5DnY=;
 b=tD2eu1O5t68Y2oKP0z5VjJbpBiaocjiEiKlsHcF6rD67jSzIZ7iADYvcev7D6VIBMp
 hXnLy54v9R9tYFkpH0GkLm3NPYv/DprSRI13xfNjVIAA12dVmbWQnkvt8EYh7AVNaUsR
 W63OJOXagebXEQwIbPxhZC+nNosvJU+d56T40sb3WH6p8lIRHL19ZpY+nRivdqg3Q0zW
 i+JVNXJvEqm5apjGmXkHbggiqiCQVn+DoOdWILr1cxBnBOkXKF4BfY2PUG3SWqXawU6i
 xGvZkmGLlcJ8LCZdp674KElvFq0OpI8nCqLAhjcSezWbHX56EFF2md9zzAeVIw+xSJtl
 yRcg==
X-Gm-Message-State: AOJu0Yxh9hO+w9brfB0A/nw71smhW8v6gKHI+PjFd9jc8hTPOgUnVsXx
 ec+12IrI95+Q7t57lHkDC7+3IwuQosf6RpOq5xvQCe1pyKMQz3O94ieWm+aoFtOjfqlw
X-Google-Smtp-Source: AGHT+IEma4iBBlwd9sG8JH42mIcPgli1DR2Hd168/EdKCQDrZO8lFQ4hslKb2H4zXjVKP/Cy2G7CXw==
X-Received: by 2002:a05:6808:218c:b0:3bf:3856:2ca9 with SMTP id
 be12-20020a056808218c00b003bf38562ca9mr1901613oib.1.1706867083715; 
 Fri, 02 Feb 2024 01:44:43 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCX0DxQRnCzYPrcmYwOwrDhxxQ3bi5O+TN/n1+1Wz7+aEz8y4CuL023Ouyydiq59nZyLit8BJ+ZjNK9yVhD0AiW7lwg=
Received: from localhost.localdomain ([125.126.161.226])
 by smtp.gmail.com with ESMTPSA id
 fn27-20020a056a002fdb00b006dd8985e7c6sm1190979pfb.1.2024.02.02.01.44.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 01:44:43 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/4] configs: milkv_duo: Add SD card configs
Date: Fri,  2 Feb 2024 17:43:36 +0800
Message-ID: <20240202094418.334221-5-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240202094418.334221-1-seashell11234455@gmail.com>
References: <20240202094418.334221-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Feb 2024 13:31:24 +0100
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

Add configs related to sdhci and mmc for Sophgo Milk-V Duo board

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 configs/milkv_duo_defconfig | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index 9eca6abfbc..60eff78ae3 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -11,13 +11,23 @@ CONFIG_TARGET_MILKV_DUO=y
 CONFIG_ARCH_RV64I=y
 CONFIG_RISCV_SMODE=y
 CONFIG_FIT=y
+CONFIG_SYS_BOOTM_LEN=0x4000000
 CONFIG_SUPPORT_RAW_INITRD=y
+CONFIG_SYS_CBSIZE=512
+CONFIG_SYS_PBSIZE=544
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="milkv_duo# "
 CONFIG_SYS_MAXARGS=64
-CONFIG_SYS_CBSIZE=512
-CONFIG_SYS_PBSIZE=544
-CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_MMC=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_CV1800B=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
-- 
2.41.0

