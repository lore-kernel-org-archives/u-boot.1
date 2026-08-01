Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93759C55172
	for <u-boot@archiver.kernel.org>; Sat,  1 Aug 2026 16:41:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5809480EC6;
	Sat,  1 Aug 2026 16:41:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HVKiVRYSpOlo; Sat,  1 Aug 2026 16:41:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8B0D780E87
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785602503;
	bh=hYQoEw2vCy1Ekc8kclkft5cIgKYohAvBrAg6sFtCB74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lQmOtezmYYKOkqVxxoEmLig0VfWK630BdPHnNh8aE+q8Xs0NFLdqmieNddJcCO02P
	 g7BqUvVqm2aYdUMF9RcdDnW398RBshRpYCDqS/EAsBREsZF782D5usqA3mI34yEVIn
	 TXBo0RGxo724JcrdseSyb4DRoZdj1APODA9IfGDXyQY/ojUMc85Ms175lrnxcZ1RJD
	 scvHzOm7uoFSVpVcWray54SzLWJUX4okRXaWlHu9pq2TpunaqEUQcyPHZ42UfvVF4z
	 9Yzwt7yiOKvKQb+58q/fze7T3LqAsSafN8HAZrifnfuMLBc48g2OgQbzrpU3Bd18DN
	 NsG3vDMR+aEcg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8B0D780E87;
	Sat,  1 Aug 2026 16:41:43 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A71A32E
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 789E640756
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3o8-odAiFdUd for <u-boot@lists.u-boot-project.org>;
 Sat,  1 Aug 2026 16:41:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org D816E4073F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D816E4073F
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D816E4073F
 for <u-boot@lists.u-boot-project.org>; Sat,  1 Aug 2026 16:41:41 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so1492294a91.2
 for <u-boot@lists.u-boot-project.org>; Sat, 01 Aug 2026 09:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785602501; x=1786207301;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hYQoEw2vCy1Ekc8kclkft5cIgKYohAvBrAg6sFtCB74=;
 b=RaEIyjgyWGRVgrfCI2doH8VmbHLfEDoKGeQRn8KRprfKTKVEo2r9cwzkHMYHOo3G4O
 3ciofw0GE2P/9tX/MWfbYf+s1GfAhs4K16UbmmDXohL7h1uW7XAxNh+V2py58+jl2qE+
 enS4tWWUHHg6vtl8E0OEn51E+aDbPHiWvMBtwdWDUywkNEmNipmSzI+96pkkzwdqW/MO
 7lXvUz089ESdXPwaOrXYi+7TYWq3eFncPLJlHzfLxR2DGtR3zJ7FDzM8qxi6LTcQLQ11
 iMMcxmvMakh7wpOiD3XXz8KcuYk0hMXbOW14lwF8q8LhSS0T2y4s3ZvYqw2mk3j/a2nL
 ip+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rog0YyHL5+/4lCkR54OUCKEKJqLLYuFZFwJggZI+PBRfdA9yD6oaP0div8L+4y0L+enNi5KRFU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzLvUwv/8l1s0mevdiJyIEIQxx6t3XVNYedq0g/sgoeoVlKzNKg
 4sPp9djj8HVu9mRelRa3P3tYpTxf3drquBOKPlwKLXMUEyehb2h+HATNi+M8L/hjv9Y=
X-Gm-Gg: AR+sD13y/H3dUdvkOMhkDaWY1eS2cFNR6uFRoud/G73UkJBSMBSdxgKyNScH47Fp4gS
 Ozdm/epZ16YRKL3d4w+q90RhI93SjmKyTl7jpi2voCFXlApS41hw1ZUkTcKetxlkvwQedB7U3er
 tyVk5eCVasbHoDnRr+robbiJFVmCpuyqMcsLlCvcvqbyMLdCv79/vNAxVm0trvVl1vjeDEsVJoC
 DefZCPwYZ3TXAtVheXvGQodnULwsDyUW2oXbJNgbu6wgt+GetCc0MtOMPKxGMO02csJERKyu3ZU
 8WkaZR40Dz0zm2TpoZ+FlTQkqcqTptxVgNdZGEuImVFS+y3qMjUWlbaJXQkNVvKpLM/n/YN6bnS
 AeD/Ipps6OK8SN+iFG58GOQZ+fMZz0VJ0NzCei/bVZBWaugCZl/3s15wrTxXLRaxHfLKDUS6NKH
 F1rVEMg17Vm0fvUtAXvI+YafYlyaIQwX5ETqIryRZif0QAzV4UmqNSKiKZSwtxFP3MxmfQv6bpQ
 +i2Kk8iH+ilD9gxEzYJtcCl7EBmzE6Z64usRCKgQ6p0Zrebd+0yJQOWZdPDXOW8JpCteCvAhKD9
 1wWXspD/ZachpQWdn1l6FRjNyQ==
X-Received: by 2002:a17:90b:1808:b0:381:28e0:6259 with SMTP id
 98e67ed59e1d1-38fbc3f7effmr3499225a91.9.1785602501128; 
 Sat, 01 Aug 2026 09:41:41 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab132cc4sm14512998c88.2.2026.08.01.09.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 09:41:40 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 02 Aug 2026 00:40:48 +0800
Subject: [PATCH v8 07/11] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-m4-v8-7-e916643205f3@riscstar.com>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
In-Reply-To: <20260802-m4-v8-0-e916643205f3@riscstar.com>
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, Han Xu <han.xu@nxp.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Eric Chung <eric.chung@riscstar.com>
X-Mailer: b4 0.15.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785602501; x=1786207301;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hYQoEw2vCy1Ekc8kclkft5cIgKYohAvBrAg6sFtCB74=;
 b=IZHFrxsw+SemDzO5vLojOhYT1B1J5uCERaRQpEGa8mOreK5H5A2ck3h1Ey76svm5A/
 bihln2tLPAgyu0Vo4pPj2SFeW/AUJkKG9u6h+lj7Ep/MldB4xL2tz25xbmb3DtZ5hWjA
 1NMLhi5t40xyecmgayJrn8nGXFaxL0b3WFHX9f4B+SplMCrjj50qPj3SxMkqwdzGIAes
 mKxGbQmETRlkBdBZdB7w+mv7dk2IZH5nmAH4zCIrZPE8S+aAYoPKS+HDPePdp/iUkFbh
 vyTKpstA9GwygPAqJTDiHuMYW/TBgdF7+Xx1w1/W6CkI6NwTiodBFaUc6l4dYezXTy5q
 ToWw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=IZHFrxsw
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Enable high-speed MMC modes.

Signed-off-by: Eric Chung <eric.chung@riscstar.com>

---
v7:
- Remove mmc driver from MAINTAINERS file.
v5:
- Remove ADMA support since it depends on CMD23 support.
- Enable PINCONF support for related power source setting.
v2:
- Enable ADMA support.
- Enable SYSCON support.
---
 configs/spacemit_k1_defconfig | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/configs/spacemit_k1_defconfig b/configs/spacemit_k1_defconfig
index 0604c2feefc1..c0ee3a29f233 100644
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
@@ -87,9 +90,26 @@ CONFIG_SPI_FLASH_WINBOND=y
 CONFIG_SPI_MEM=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x000a0000
 CONFIG_CMD_SPI=y
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
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y

-- 
2.51.0

