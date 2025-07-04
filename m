Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85055C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 13:03:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 983CD803DF;
	Fri,  4 Jul 2025 15:03:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="euliOGvM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FB578206E; Fri,  4 Jul 2025 15:03:48 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7892D801BE
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 15:03:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4a8244e897fso12523661cf.1
 for <u-boot@lists.denx.de>; Fri, 04 Jul 2025 06:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751634225; x=1752239025; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zGvMgwMx1DhdxxBXy4o1XKq3l5edwL5iw3QOzGKBvjQ=;
 b=euliOGvMBK0q3mv/oNIuumuKExAc1/ALHUcr3sxCW83naE46SY10JmJws4HofOiOg1
 bszv7iB2rLO9F8g3Ig2VAMkOM8SqEq2gocDUmlH6BcAwRSOApF6uAXqTQ1ex+tDI+ic0
 XwyQnAD1B1iSkq2N533v1k4cnrEggta/qzZRfnVLeVYDmLG3959FmSkta90mHHgkxee4
 /SdTPwSynu8E+weKXs2BfI0FK4GSCJBVb0dRSWhdqAMWFGP2PA1hnPpwFQOq8GQpxh1w
 qNlFX1uO9EhNatNEUxU1Pn4hSgUAlOXoV8B5d5H7ODAyexl0/Hqzm+B7lwAgP9ZrUPGc
 k28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751634225; x=1752239025;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zGvMgwMx1DhdxxBXy4o1XKq3l5edwL5iw3QOzGKBvjQ=;
 b=TGuTaMr8/Y92tkp+qgmCzE8LRIVtspxMpRLzsZdzxB15Z7VOpewe6NyoJG+e8u46kP
 MGMA6+uMUv29HXVJ6a+VgQdYDaMQEaZXuCLm1xFtBttMwU18qzUQzkEK5Gbiq1O5pG4S
 mQ03M0/YUvSYZoMOS+n8M3TYCuprt74hJhHG3K1l3P8JZsVKsQxBmfFDbU4qfbd7Bfob
 e+fOq4tqoGben//FQGcFh3mAPeAe7FAtLGsZYsqcSddiG1quRDyhF8TrO+4ES/VQO64R
 E/6GB1vIuYoMZenaHzahjBQ6aJ/bN8Bz/v5qgPlEevjtTG1xSh6J+ZKV7K5836ZCeNW+
 N/cw==
X-Gm-Message-State: AOJu0YzvdFfWejaxnw7leS5vJpPvkXcJQ3IbPfWAHDpX1ED5ZgAI8EF1
 9vK6+E81gpNjSVpX5Qa6odm2Gg+f5Eq62uAwAQrJ6cB3yO8oaF0cJPKLmBHgAw==
X-Gm-Gg: ASbGncv9FxBvj76ZfViTx8Zqdw8qA/DEQfvaRgSMleCLpI5PBfEbcyUCDQBMNKj0vlF
 YJzZ+eQE/LMZ/7CDbYo1ooJ3d4kAl4AAODsxL3CM1T58To692flfJE/0jzCo+Q5oSc7t4TKIx6d
 waJeyVPZSUJSePwyi2JY0YWTa0hmhlrcQf2iZD4pGhV0hGVcji/GQ1iP5OiBNY9zNhHk01G1ftk
 vLY7LiIn0zHEkU/LOaJcpNcZVgoDi7MUaF4qqpm6w8LVpESnBuHNIqhlLaMEkM2mWva3XpFf0vG
 x9BtAlUrENZ3SDsBCC139Ygg/Giwfj0u9Dqb8Ac8y/BgLD0+8mrDNukKP0XWKan9ItI+fmUW01M
 =
X-Google-Smtp-Source: AGHT+IFQKewoyVlP3qIfIxY2I51ElbPyfTkKhVY2BOVU3NTfMvw69jK4fUsb9f5uW2l1jQnJz+TldA==
X-Received: by 2002:a05:622a:1a19:b0:4a7:6e64:ecae with SMTP id
 d75a77b69052e-4a9964eb837mr41412231cf.30.1751634224884; 
 Fri, 04 Jul 2025 06:03:44 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b490:55b4:7a89:ec6])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4a994a3093asm13627001cf.36.2025.07.04.06.03.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 06:03:44 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.denx.de, jerome.forissier@linaro.org, otavio@ossystems.com.br,
 michael@amarulasolutions.com, uboot-imx@nxp.com,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mx6sabresd: Increase CONFIG_ENV_OFFSET to fix boot regression
Date: Fri,  4 Jul 2025 10:03:19 -0300
Message-Id: <20250704130319.3814676-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The CONFIG_ENV_OFFSET value is too low and the imx6dl sabresd board
no longer boots.

There have been attempts to increase CONFIG_ENV_OFFSET in the past, but
the suggestion was to enable LTO, which worked well for some time.

Give more room to CONFIG_ENV_OFFSET so that the board can boot again.

Adjust the CONFIG_BOARD_SIZE_LIMIT to take this into account:

CONFIG_BOARD_SIZE_LIMIT = CONFIG_BOARD_SIZE_LIMIT - 69k = 9779920

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 configs/mx6sabresd_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfig
index f041f1fd1a3b..f66d6f413ee7 100644
--- a/configs/mx6sabresd_defconfig
+++ b/configs/mx6sabresd_defconfig
@@ -8,7 +8,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_SF_DEFAULT_SPEED=20000000
 CONFIG_ENV_SIZE=0x2000
-CONFIG_ENV_OFFSET=0xC0000
+CONFIG_ENV_OFFSET=0x100000
 CONFIG_MX6QDL=y
 CONFIG_TARGET_MX6SABRESD=y
 CONFIG_DM_GPIO=y
@@ -21,7 +21,7 @@ CONFIG_SPL_LIBDISK_SUPPORT=y
 CONFIG_PCI=y
 CONFIG_LTO=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=715766
+CONFIG_BOARD_SIZE_LIMIT=977920
 CONFIG_FIT=y
 CONFIG_SPL_FIT_PRINT=y
 CONFIG_SPL_LOAD_FIT=y
-- 
2.34.1

