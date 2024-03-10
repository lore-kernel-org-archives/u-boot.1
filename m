Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB95C54E58
	for <u-boot@archiver.kernel.org>; Sun, 10 Mar 2024 12:11:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C339C87E8E;
	Sun, 10 Mar 2024 13:10:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OUwlAOt1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3163C87E0A; Sun, 10 Mar 2024 06:58:52 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F02487BF4
 for <u-boot@lists.denx.de>; Sun, 10 Mar 2024 06:58:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-221a2d0c5dcso1242830fac.0
 for <u-boot@lists.denx.de>; Sat, 09 Mar 2024 21:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710050328; x=1710655128; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YFvup1fBnqjrjgOnHPVv2fqpvRqIZktzTPiXX7zS3Mg=;
 b=OUwlAOt1bF53qmEM0bd6On/kdUXNsDbX23jIza59QARxs6pVcFXbP73FlFH7VlsJzs
 prLjPaVIhHZ31Bnp+8wpIBxxGkQxrZzeTJOiyp8DT8wnexQC+Cix4aJeE+9wnUsoT21k
 S0NqPiIpIx0zPoaLlgYvcjQZjua7cN4jc/t4+38bKdyvUtWY2Bv3YLe0HKpHvh3XRZcl
 r1iBOkcqSFKdGRYBPaoitSCRc+dIqzOH2kCWKm36lzBMC0ueRP4+sWvWEYtinGkEt3cA
 ExjaSESXsXAtgHAl10coO+nXR+H4/67DfRTI54moeYSbdm6NpEqu1syxdAZGFWiMnAhx
 UMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710050328; x=1710655128;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YFvup1fBnqjrjgOnHPVv2fqpvRqIZktzTPiXX7zS3Mg=;
 b=TVg2vytg8GoiIEU75iIJwHykSyCwBzrNDzEoAjcDmmByqdYCH+Pi6dBk4LYG9aDKhi
 mJcKWkydxy8Ae0DZGqtUnH9aI9WSXKv13tNlKdpov16/z9ymejQEb7GMTWVHnYWeWH9K
 jZScoBoLOb8qn03NjwBB2pWJFkZHUTT5ZmEb8M4iVLJ7Bse1IroSHkHOP9ZyAYzO30AU
 fMlVZFrV3DTnv82pnZncuzVUJ5YB2i8XO3kKtVEfdEAduFTzLemRLAPTpWOztkOZiT9+
 i4IUHaVoIReMWGw3NooGix5IveupFQbkSRkBM4FbVDKSb9nFqZFebfVRq6hLg6w46LoZ
 Q5jA==
X-Gm-Message-State: AOJu0Yx/olrJSAn0ALyYzlUhF0MjcBA/ISBLLUdYnU+w5cVZVcWsaJ8D
 LHjUHMmWLUzrPtyJeQaVBAtjOHRAIXS4AcizDMu5xZ75ZI6TG2i17kpnoJB19NdU7A==
X-Google-Smtp-Source: AGHT+IEfUe+7Ozdu6UEsQC02NI9RoqaWleiixJW64NTixqsUrsNumBG7EUjhvgJkFz7jGnaUodlxzA==
X-Received: by 2002:a05:6870:1707:b0:21f:dc81:1c1a with SMTP id
 h7-20020a056870170700b0021fdc811c1amr3991615oae.16.1710050327661; 
 Sat, 09 Mar 2024 21:58:47 -0800 (PST)
Received: from localhost.localdomain ([117.135.91.249])
 by smtp.gmail.com with ESMTPSA id
 i15-20020aa787cf000000b006e508b6a13dsm2037522pfo.58.2024.03.09.21.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Mar 2024 21:58:47 -0800 (PST)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] configs: milkv_duo: Add ethernet configs
Date: Sun, 10 Mar 2024 13:56:46 +0800
Message-ID: <20240310055816.11575-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240310055816.11575-1-seashell11234455@gmail.com>
References: <20240310055816.11575-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 10 Mar 2024 13:10:19 +0100
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

Add configs related to ethernet and ethernet boot command for Sophgo Milk-V
Duo board

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 configs/milkv_duo_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index e8413d7aa9..f66c4c5358 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -19,14 +19,18 @@ CONFIG_HUSH_PARSER=y
 CONFIG_SYS_PROMPT="milkv_duo# "
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_PXE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_ENV_OVERWRITE=y
+CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_MMC=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_ETH_DESIGNWARE=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
-- 
2.41.0

