Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8380BC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4CCE540753;
	Mon, 24 Aug 2026 08:52:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zr-lzCcBFQZW; Mon, 24 Aug 2026 08:52:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561541;
	bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OJt9MEh7XRYcAHVJFzKAhr3QRYim/ScEwj3OlXZNaUlsQG6q65XJiBPAPS6Vl3FBm
	 4p5jkvTnuuyjU2RkX2Df5NFThMk+3Rv1s+4+MiiJAnScX5A1LTu6IIqBqMV6HCzpaw
	 ZcA3ZFyEeTvf+MX6BWACQiNTHbaqd+oOBma3HnVQN4OBWntpOZn44Pi904bBOx6Kkr
	 pe2d7imizEFULrn3yz60rJt91vIdbGE3AJS6Bfjhc7jiyMZ4xJU9edpdQyEAto72yM
	 EuS3OJHV77GdTvKncCahBbe1N2/8m+uZ4jZcbYm1N1jKPFxyFOV1D678edfwnhX4Hz
	 v0T2yefXaQF2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C446440706;
	Mon, 24 Aug 2026 08:52:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F4F73AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0D21660622
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BZSKIxy7TuDs for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:52:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=hZ9i0lMK
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2A96560650
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:52:18 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-ca80d708489so2057015a12.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 01:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787561538; x=1788166338;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=hZ9i0lMKX/n1OcKAl5+vOsGrYJJuykgwC22S4UfCAu3ORhkfW8oreqA32b5mh4x1T+
 JQXk68uL5X26Ezdrxq4OPaodJaq87qxTBO3Y9jpxKnPJFsl5QGIJUrUoB4NROnmvd+th
 mi2YTdwPkW+yFd5boH8lJfVAADqhrH/F7V3iLZimF/tsYo7OJJ2WAtdMZd/gYUDgexKl
 zamzZpgdRH1ZmSwWHQor0wLTAhVNgKQiqx8dMcNkcuRZwfwG9FxfjXo+Gl7cnGRWepuO
 ZFnECIgBGKmkeShcZL77rP/iCTE3r0fF6zDBBxe/Laf1yDXEuKN93sIndaoH8g9YuTrc
 gJ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561538; x=1788166338;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=g/wHDkmEnsmozla2SKoRloHcB0J3yojbuPI5nu3dnF3H8s5jLc5NteOSy5TL9ejiSl
 G9mFwaxAvmtVkQFPfAfgOKq2Sz2dm2WDnnwjIJrIEOtwprDalup9HqRoTjGltth7LsMv
 utI7I9h5DYFCWzHSmDWRxVOKvfJl0c84y3quVy4xVrTKUa1gyRnqtablZcZSE39+Ri2p
 JYNTiv/4H33OUSnrvqgf79YCiJOfCT41K5uGlorcZED98PPPlZJgR4bl4LExWisX44VZ
 hmxH4NA4oq1nPhAhO2ev3ruabCUlev3o7TfVBDEgG5Mh7rAOXJzvAUt8jcYUKmgA5lLC
 Ws5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqE9RoienOweJuwYsx5LD8ruv+SMIEUAbiHjbAbk6AVmVx4gfbK2wb7XIQ9pxqbAn/HeqBYTR8=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nf0ptiWp20mSMt7zjkkjcKOjAsfGT1kBPNLUXxm3mC2cNxNzJo
 vxwwVntbLeXzGgPMsIUFdYRJuv5BL4BtmCdphw/insSfYRyqFdZygBw+c9BhtyfPhms=
X-Gm-Gg: AR+sD10/3wuvu1UeSHK7aUXOPRSQb+iiwGYB7t9apeAfYjsD5Ic4CAEZSLA3BINzJdp
 SkPaELoCbStgKVKI772VcFDbqgaducv/8uOUPhcvMj/ekXjwdcS3jkyogJPd0YWDogQ8R98YzC9
 KuZ24RGptMCLMX9dWu0Qui6oag2yEMVWBmmK41TDtgbLm/ToZjGvJX+ZXvZ7lcmTzqJn+IeLssQ
 ZuzZnes4aAYhU7yluqdbKG4hxS8KskOXvXtRkH7XKEZuvM1/ANsP/n1PgtUSW+48aCd/HM7cllV
 G0WXw9ORWxSiwKWtiUwdsV54Zz9WXKBanwyvmck70TB4UklgYC8fgyjjmiKNfgOR2IVhISFBQtu
 Ir+oyd4BWXQNVn9JgSX1YaE32WEqtsBBPh4zuuF/MonLsr2z40R1n1cX+HRY6/v1PqiMie8ggsA
 COcGAIzzS47hzT+iPzyqdXnQsXO3RlaqguK8UAomOD1juf6QDAs0XusMU4RnxG90z5GRb4MC/pD
 rgDSPmEE9T04MCe3MQDMGTjZ2yZ1+zsqInLoeQZ4NtlqP8g3mtC4MpyYcvtO7U2cJ99NOwBAO2T
 LSVqQOlh9vFs+sA5xy9903a3WQ==
X-Received: by 2002:a17:90a:e70c:b0:38d:eaed:4adb with SMTP id
 98e67ed59e1d1-395a074d955mr40167229a91.20.1787561538303; 
 Mon, 24 Aug 2026 01:52:18 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d37d9sm26085522eec.14.2026.08.24.01.52.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:52:17 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Mon, 24 Aug 2026 16:50:49 +0800
Subject: [PATCH v10 14/17] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-m4-v10-14-5e0adcb1edb9@riscstar.com>
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>, 
 Wei Fu <wefu@redhat.com>, Huan Zhou <pericycle.cc@gmail.com>, 
 Guodong Xu <guodong@riscstar.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Yixun Lan <dlan@kernel.org>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 Alex Elder <elder@riscstar.com>, Andre Heider <a.heider@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Enable high-speed MMC modes.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Remove the change on MAINTAINERS.
- Force DM to use alias by CONFIG_DM_SEQ_ALIAS. Since the sequence
  of mmc devices in DTS are inverted by alias.
v5:
- Remove ADMA support since it depends on CMD23 support.
- Enable PINCONF support for related power source setting.
v2:
- Enable ADMA support.
- Enable SYSCON support.
---
 configs/spacemit_k1_defconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 0604c2feefc1..5f9923c7f470 100644
--- a/configs/spacemit_k1_defconfig
+++ b/configs/spacemit_k1_defconfig
@@ -23,6 +23,7 @@ CONFIG_DEBUG_UART_BASE=0xd4017000
 CONFIG_DEBUG_UART_CLOCK=14700000
 CONFIG_TARGET_SPACEMIT_K1=y
 CONFIG_ARCH_RV64I=y
+CONFIG_RISCV_ISA_ZICBOM=y
 CONFIG_RISCV_SMODE=y
 CONFIG_SPL_RISCV_MMODE=y
 # CONFIG_SPL_SMP is not set
@@ -48,6 +49,7 @@ CONFIG_SPL_CMD_TLV_EEPROM=y
 CONFIG_OF_UPSTREAM=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_SPL_REGMAP=y
+CONFIG_SYSCON=y
 CONFIG_SPL_SYSCON=y
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
@@ -61,6 +63,7 @@ CONFIG_MISC=y
 CONFIG_I2C_EEPROM=y
 CONFIG_SPL_I2C_EEPROM=y
 CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
 CONFIG_PINCTRL_SPACEMIT_K1=y
 CONFIG_GPIO=y
 CONFIG_DM_GPIO=y
@@ -87,9 +90,28 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_MEM=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
 CONFIG_CMD_SPI=y
+CONFIG_DM_SEQ_ALIAS=y
+CONFIG_MMC=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_SPACEMIT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_HS200_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_PARTITION=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_PARTITION=0x4
+CONFIG_CMD_MMC=y
+CONFIG_CMD_MEMINFO=y
+CONFIG_CMD_MEMINFO_MAP=y
+CONFIG_EFI_PARTITION=y
 CONFIG_SPL_SPI=y
 CONFIG_SPL_DM_SPI=y
 CONFIG_SPL_DM_SPI_FLASH=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SPL_SPI_FLASH_TINY=y
 CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_DM_SEQ_ALIAS=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

