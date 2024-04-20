Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ECF2C4345F
	for <u-boot@archiver.kernel.org>; Sat, 20 Apr 2024 10:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC29388679;
	Sat, 20 Apr 2024 12:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IjCgOgUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 115E688126; Sat, 20 Apr 2024 09:09:51 +0200 (CEST)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E986D8811C
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 09:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seashell11234455@gmail.com
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-5d4a1e66750so1886536a12.0
 for <u-boot@lists.denx.de>; Sat, 20 Apr 2024 00:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713596986; x=1714201786; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vF/ICGO+EdrFTosD7rKqAFioRqvYZhpbRPlApnYyr6w=;
 b=IjCgOgUidaTI7n719OmX52Omf5WP5QfIim7ippwlh0YyfmT6/A8uciCEpAKJdjdWE5
 cYGBcfIWHRT6akY/IZtA2qXqUFEuOMaXz3RstlmhwS/YC1RqiLv/RfbwchuDAhNgdhJV
 cYuMM0nnuiORbt3EYZfV76uHfnl1tWrk8xVLlFwQTtgA+K2Inyd7h9hyWr6kvhjZxOoU
 RjRSuz4+TVHhxzD0R0s8LQwN8Cl7qKxQWzY6qFzHFMlKyerFgwK3ZloL2uNeijpx6pyq
 5VNoEpLxwYQrjlLhqb+DbhiJNvgGpgUYAAsg0Dzl0r27IyhfkoxhKqHNVwaBHKFASiRo
 rQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713596986; x=1714201786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vF/ICGO+EdrFTosD7rKqAFioRqvYZhpbRPlApnYyr6w=;
 b=nsE7cxMh4Ap4eTayF+wTqEyD9il2nQOcuDCLn+zpU8jtbgxMj4KZkT1bfnTTxf/BDH
 +ql/y9mRzPOiw9AbwUJfB2czHoUskIBxGD0NH47LGmFyAuLqF1VK+YacCK3YHJ/4SlWC
 pl3SyXZKLvjpdytXKMkBMdmcCyQfGMucjG5DS4EvqcSYzhiI/5zx5B4E22nNP8VM+OdJ
 Q0cZMO6VXjVuBhSeHEE9bKr/IsHsmIO60EauGb05DENe5pFm1gaLdMnKJLmxM96f1OEE
 3GahINObPjjOwEpmDbrTqqL08ebk4GSNDr0ZoZQgNjNzF9cpbYrRTY7lATuTbD2FqoZU
 O0sg==
X-Gm-Message-State: AOJu0YwYF3Su0FPQXMp6Ls7XbN5NB3l2+PHaF4WoQ7pyMUEQDpRSg2ny
 u71/8BNTeBq0T10g2hBGBxeJr3nGBJrrl8/XoxjFLaXplNBiXaTxZafVDRmPG18=
X-Google-Smtp-Source: AGHT+IGuuV2zIgNfAoMHYC1Z3vc9gOZCX0h5mHLbaxafxkVfHMqTKNkMIztSpcvYNQUvsUiycKpBsg==
X-Received: by 2002:a17:902:cf09:b0:1e3:dfdb:ac6b with SMTP id
 i9-20020a170902cf0900b001e3dfdbac6bmr5826080plg.4.1713596986163; 
 Sat, 20 Apr 2024 00:09:46 -0700 (PDT)
Received: from localhost.localdomain ([120.204.189.229])
 by smtp.gmail.com with ESMTPSA id
 p5-20020a170903248500b001e43576a7a1sm4443065plw.222.2024.04.20.00.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Apr 2024 00:09:45 -0700 (PDT)
From: Kongyang Liu <seashell11234455@gmail.com>
To: u-boot@lists.denx.de
Cc: Leo Yu-Chi Liang <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] configs: milkv_duo: Add spi nor configs
Date: Sat, 20 Apr 2024 15:08:25 +0800
Message-ID: <20240420070923.9154-4-seashell11234455@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240420070923.9154-1-seashell11234455@gmail.com>
References: <20240420070923.9154-1-seashell11234455@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 20 Apr 2024 12:11:39 +0200
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

Add configs related to spi nor flash for Sophgo Milk-V Duo board

Signed-off-by: Kongyang Liu <seashell11234455@gmail.com>
---

 configs/milkv_duo_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/milkv_duo_defconfig b/configs/milkv_duo_defconfig
index e8413d7aa9..c69eab5fad 100644
--- a/configs/milkv_duo_defconfig
+++ b/configs/milkv_duo_defconfig
@@ -28,5 +28,8 @@ CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_ADMA=y
 CONFIG_MMC_SDHCI_CV1800B=y
+CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_SYS_NS16550=y
 CONFIG_SYS_NS16550_MEM32=y
+CONFIG_SPI=y
+CONFIG_CV1800B_SPIF=y
-- 
2.41.0

