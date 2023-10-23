Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF50C25B41
	for <u-boot@archiver.kernel.org>; Mon, 23 Oct 2023 07:03:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B9D987894;
	Mon, 23 Oct 2023 09:03:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="knfAK5YN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E25A87894; Mon, 23 Oct 2023 09:03:03 +0200 (CEST)
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E28AE87893
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 09:03:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1c9b7c234a7so24769205ad.3
 for <u-boot@lists.denx.de>; Mon, 23 Oct 2023 00:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698044579; x=1698649379; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H+xiGU4KGTy10Z4bZhYtnj92lFdxSY8G574nyTXRtLM=;
 b=knfAK5YNH0dV/mW+WCYkWjsuwe+ZXxwRr1NnrH54+1iE9uY13rhAF+UmQql3J62x/+
 4ircni5ahqM/nmyRqZn5oCwS4C8fPPPfE4AVgRuSF+1oixeoQ0cT8MivCjZhZ2jZ9rXn
 F7Mr0hjn2orkd3ZKn7225OigFjOAkM4wm3bs7ragvEKIamsMOfiHolYnlC4d0nQ+U7yr
 1xRufKJRxwNKxXbgfejXkTF+9KzJ06aJhw/t2CXshz3AyHdoAXJgMRzR0cdna4P0h8cg
 hJYp4RSESKXHyQ/A9OKYT9bnFN8nMpAlVwAvYonjNU2mk0eboUBtOMfvVoYF/QouTQ/G
 kgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698044579; x=1698649379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H+xiGU4KGTy10Z4bZhYtnj92lFdxSY8G574nyTXRtLM=;
 b=Nppb1omYMI7spRzNrN0JCVWSf/olSmUietYHfM7cggwJqGx5D+7SKVJM2+BOEiXikV
 zGfcqpzGTeXq6gAJPqfRhth6Qg3MbdtDmtwfQyEa4eBHfP2C5rJuSLRL20XrbsqjD7dN
 FJCGVfU8bWW9Zpf8apt7eAYnhrqpTFgIpc/RsGjouo4Lkb9kbY0/NLJ/1zYdRb/yodDO
 MfOElqQC3oIBoXfntXGDaUdnNJw4H5g2BgZFrMJvEQgAQDFvvddnwhZ0MF27B3gbm8EN
 ANtNojsGEgvFJB8umpFX6tAmxB8Ac7iy09va136UNdg4hs55veKYuHlCNe8hrcdveuYT
 rFfw==
X-Gm-Message-State: AOJu0YxD3tCBF/Ysj0qH+EKHc7CpJ0ReC6a+FxvJp7BtlA1W3TY/1UgD
 KFN6MBfHvWw8pFa4GeEP1+PnhaIaFghBnA==
X-Google-Smtp-Source: AGHT+IH8ZdNjqR+cCwB8KrsfRfG4lacCC4dbrtWbFHSRtn+G+83F1fqMuvJsexcPwLFXBoK3nMDUCA==
X-Received: by 2002:a17:902:ea0e:b0:1ca:20a0:7b08 with SMTP id
 s14-20020a170902ea0e00b001ca20a07b08mr8986568plg.50.1698044579236; 
 Mon, 23 Oct 2023 00:02:59 -0700 (PDT)
Received: from cs20-buildserver.lan ([1.200.144.223])
 by smtp.gmail.com with ESMTPSA id
 13-20020a170902c24d00b001c74876f018sm5368432plg.18.2023.10.23.00.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Oct 2023 00:02:58 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, YSCHU@nuvoton.com, KWLIU@nuvoton.com,
 trini@konsulko.com, jim.t90615@gmail.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v4 4/4] configs: nuvoton: npcm8xx: Disable
 CONFIG_SPI_FLASH_USE_4K_SECTORS
Date: Mon, 23 Oct 2023 15:02:25 +0800
Message-Id: <20231023070225.3142578-5-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
References: <20231023070225.3142578-1-JJLIU0@nuvoton.com>
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

disable this config to improve flash program time

Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Changes for v2:
   - add commit message
Changes for v3:
   - no change
Changes for v4:
   - no change

---
 configs/arbel_evb_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/arbel_evb_defconfig b/configs/arbel_evb_defconfig
index 8c32b4b20d..6cfb5a7d32 100644
--- a/configs/arbel_evb_defconfig
+++ b/configs/arbel_evb_defconfig
@@ -58,6 +58,7 @@ CONFIG_MMC_SDHCI_NPCM=y
 CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SPI_FLASH_WINBOND=y
+# CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
 CONFIG_PHY_BROADCOM=y
 CONFIG_PHY_GIGE=y
 CONFIG_ETH_DESIGNWARE=y
-- 
2.25.1

