Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D80DCD6E43
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 08:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F346B86CC1;
	Wed, 11 Oct 2023 10:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hUKAPkl+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46FB882BBF; Wed, 11 Oct 2023 10:48:46 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85E5386C93
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 10:48:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jim.t90615@gmail.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3af609c3e74so4714912b6e.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 01:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697014111; x=1697618911; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vg7m0cLlj4tZogMdCNWwi8RjCZqAb9cgxkKGJaeEcYs=;
 b=hUKAPkl+jH3jz6BVqJPGsxEOFoaBJaCWmu2AAV6MXrk4EQ8asq1TcGVcqfVg0QYAaa
 mq5EwEmYl7wRNs/Iv9AiVXRn3l3k9NLE/VBw7uvXGQxJQ1ATlBJ0H8Uqj/+TJPIBWdtA
 GgYqkTf9mafueRU+VqaMEE+80knyiPdMG5vw19+AQTXCPiQjYW9+p0H9OwMWJYCydi84
 e9EZUL7N7c33Dw4n+UpmbXmE8VBKBz/xoHEQwQbsKypmddvXhh0ma6jQHogOXEawWyI9
 +z+VFvtq6SOftzMcQ4KL6TobOpeCkUH0fqvjKukLGy91do8TxPPa26xUpFlJ+nMkgc0m
 BIdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697014111; x=1697618911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vg7m0cLlj4tZogMdCNWwi8RjCZqAb9cgxkKGJaeEcYs=;
 b=NWZSh/Q0aQ/s2aFofiddSOg3lgmUI0zXMARnjTXTybwHnSqVMSpfnLGVIamrxXgmS0
 ce0+FOXTfbufdaxeb7mRJ83xd3kbEKEaMXYw536F+95hzjdXKiXDzySJgNrEqMYK5UB/
 V7G2DvAP67hLCuEmP2SJfTpTjjp17thmK+9if/U6IJ9kUzdxXHVAghoVlO90YLw44CoA
 67vqqCmAeSqrWlofNkwTAJnvPVQxZCLAZR8SywZIcRYCqQigdnLQYNzkZffIUVPXd0Wp
 J/j65nS6+bBsqWbyEajI999FeFRNJ09vCxvtIn6wfZnxBP1Rm5qLjFF6PxCt1p6lbXwc
 GsWg==
X-Gm-Message-State: AOJu0YyksYyCDvArmYRNC1aDXHh3S8/pdhfqdKqrB/T/1qGXrASdulbh
 hZ+66jONpVpZHq5jOl/cGmw=
X-Google-Smtp-Source: AGHT+IHCsOezxUHO6qpGXHYawf+anDMYNZRMiTS10hBVO/gPofxsoLCj6ajpg4BzfM/nKUmLrS1Qlg==
X-Received: by 2002:a05:6808:4ce:b0:3af:794c:df98 with SMTP id
 a14-20020a05680804ce00b003af794cdf98mr20456094oie.49.1697014111128; 
 Wed, 11 Oct 2023 01:48:31 -0700 (PDT)
Received: from localhost.localdomain ([1.200.128.112])
 by smtp.gmail.com with ESMTPSA id
 m28-20020a638c1c000000b0059c8fa8f917sm2307940pgd.12.2023.10.11.01.48.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 01:48:30 -0700 (PDT)
From: Jim Liu <jim.t90615@gmail.com>
X-Google-Original-From: Jim Liu <JJLIU0@nuvoton.com>
To: JJLIU0@nuvoton.com, jim.t90615@gmail.com, KWLIU@nuvoton.com,
 YSCHU@nuvoton.com, trini@konsulko.com
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 5/5] configs: nuvoton: npcm8xx: disable
 CONFIG_SPI_FLASH_USE_4K_SECTORS
Date: Wed, 11 Oct 2023 16:45:33 +0800
Message-Id: <20231011084533.2325296-6-JJLIU0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
References: <20231011084533.2325296-1-JJLIU0@nuvoton.com>
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
2.34.1

