Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D151C4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:08:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 960F28777B;
	Mon, 27 Nov 2023 14:01:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CtZK0oq7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8447687779; Mon, 27 Nov 2023 14:01:27 +0100 (CET)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E8428776D
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-50943ccbbaeso5760091e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090085; x=1701694885; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ja/VvD5k3w7j58PJGQBoKdDTEAU1BpQD+bRuaOZqN1g=;
 b=CtZK0oq7ufcidW/RgpymC8R6Fm1PADbPbEoyyFD+9CJpg8aEzJCjgmZ2M5Qbmb6KZ3
 1/Cr8qZWKgpbjeqJvl1vRYRKekpqv6A6jNzBC6EANIb59V2418/sC9VKslgaqlW7N5HZ
 U34v+fs/KWsEK134To63i4C8kNHk03QJGcf2+a/UhxyoiRtnXy1yQaHMtatdM8qEqfpk
 +ZMjwIrbl9omIR6UjWJoebCsMm7h9CMNXoCyakmWOwrVGRJ2wrBo7Ctrb+9wxkYpeKyb
 P4gB8j37vHZ6Zwjs0pLcYuRsJd7ocZPRAbFonW1rBz47U3FtSANM+FGUF7GqYkaWfSZq
 lWvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090085; x=1701694885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ja/VvD5k3w7j58PJGQBoKdDTEAU1BpQD+bRuaOZqN1g=;
 b=s4d8DeMNig9YLURpFRBpYSudZJjHNdn7bAT+rs9zeIaOlFvAeybXdkbD4tZoBNhsA2
 8uaI5ZvvRwGWIUSqpD6CNFihhOCUnYTXvM75CJtQa1TAMAUNTxA0J7lp/5EMU7WNd8Pr
 9/xwj5dJF36b89Ptb32RF3kqfwRiPJqWdqo/bZuxRAVdDZ7N5TgcXuwSXOEstik+MI16
 NNAC1lQNFUowTLb7zDZGuAGGKCdK3JEY9j9Tx9umne0UvQ4DHE8gnZYZgBacdbEDSBKv
 DGLfbcI/TW5qHVUNyCbORxoWRd4upxSR2LQ3I+fGjsk99l5U8+CPs1p0aT8qQnEzNY8c
 TW2g==
X-Gm-Message-State: AOJu0YzBcvKC/MeMZ5HuNpW/ppX1qvSqYS0x1Eake1j5cPzRF3DeTDoM
 OSd92aIIiLE0F1e3pzYhnM1upiH9n3nu1utKNPX6vA==
X-Google-Smtp-Source: AGHT+IH9/N6a7VK5mozncxjlDeJLrCuqfgiAU4ET0LRvE0upY0CC6peySHSJlXfVDdBt8G6TwNDH2A==
X-Received: by 2002:a05:6512:407:b0:50b:ab60:3d6e with SMTP id
 u7-20020a056512040700b0050bab603d6emr3641402lfk.66.1701090083227; 
 Mon, 27 Nov 2023 05:01:23 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:23 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 32/43] configs/lsxhl_defconfig: LTO + size
Date: Mon, 27 Nov 2023 18:57:15 +0600
Message-Id: <20231127125726.3735-33-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase allowed binary size to fit lwip code.

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/lsxhl_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/lsxhl_defconfig b/configs/lsxhl_defconfig
index d729bcb530..066f8b16b3 100644
--- a/configs/lsxhl_defconfig
+++ b/configs/lsxhl_defconfig
@@ -20,7 +20,7 @@ CONFIG_DEFAULT_DEVICE_TREE="kirkwood-lsxhl"
 CONFIG_IDENT_STRING=" LS-XHL"
 CONFIG_SYS_LOAD_ADDR=0x800000
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=393216
+CONFIG_BOARD_SIZE_LIMIT=409600
 # CONFIG_BOOTSTD is not set
 CONFIG_DISTRO_DEFAULTS=y
 CONFIG_SHOW_BOOT_PROGRESS=y
@@ -68,3 +68,4 @@ CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
+CONFIG_LTO=y
-- 
2.30.2

