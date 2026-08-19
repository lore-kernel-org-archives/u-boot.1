Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904DDC5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 03:57:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 36832808C9;
	Wed, 19 Aug 2026 03:57:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id utb5Uxv3hKd5; Wed, 19 Aug 2026 03:57:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787111850;
	bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j7eTh1C9gad4Wxg0gnyRQoDLd5rpwWFkEbyOzM+0B4Ou3vN8Zxpf8u6zLSMZZcRjl
	 hJeicyvyM8DhsMiY3xiL1mJOUhUGd/+pksUs5iNo5ZApW+du1+69HIe/mprdqvRAf4
	 DT3kSGB7bycSYOhjuqb4rD/pmebsk1xR5XLcKXsbsuz3lDFuffEhwKjnsSQW+jviVZ
	 ezGU9h3H0s8IGQYIu28i6Tu4k1f40iWLqXBP3hWGPX+h+yHjO8z5IjzK6qhOH6NjHA
	 7c5voPqHhbwJv738x2JiQMbK1bQSKK64CZNymIGWf6UFKVQ1t81WV6A3hU2kZthkMr
	 eWsapFsP0KMbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C5C480C31;
	Wed, 19 Aug 2026 03:57:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4FE2223F
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 4D6A880C31
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x_hSojCABWoa for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 03:57:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=acO14jhs
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BB36F808C9
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 03:57:29 +0000 (UTC)
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-cb5b8572b70so551856a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 20:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787111849; x=1787716649;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=acO14jhss0k7oZ17sNL/nQyyC1dutHAcv9WKTxz2f+d1fJVfyj8W501U14kcoyaP1j
 lz/AnE9/ZBqMwuAzTF8pny4aWzvX8IsZKPP5HqGqfdbf5rR5Y7ekGd5QG2F17JBP7hqh
 E8q/U/PCTxVShzdi9diQVNO8GPqynK58Qzc4rU8I/R8hn92qG5lBmkMfKD2b8Ov8qUbA
 ssybK0BfWjURj0uJBlS/ue73VgS5pKmgRtMleqgZnH8+rOALaxt2V5O2ZlTGHeuRT/1Z
 9OBu172eJ7AXWQz8qC9IXaw1DXSrAc9q05nqtGs5AzwrOVp2xTq8FmjhwdcYpXWwTqDy
 IGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787111849; x=1787716649;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=jBxLA360MfJZ19X3iVkBK/AdBXMuhpl73nVbbQrRUmXKULgU848+/AwBSJe2jYA5D9
 PhAbgu+3LmjPWFm8gqOHYfM1nSZcSVmgD3xWzVAVBOxsZSSii8DWJruNaVODzhc/+ImK
 mRuTjPNON4E27JQfG+bFF9bGP00E+pv/Ztys9blzfy0IPTPXBSJcqHVmJBv306Vktovq
 Kr0z0Yp5QEfo7qxEHzgyTxCx2a+pXQbvQXqraADrdKHSCG61Agozyk/bRL0SD+AAov3O
 DlAcnSUdu69oKQuBGdy/WAowZqcwwnSvw/wGP3EBLJ9xJ4jWKk3/gqGtblE+RCVu47dG
 XLOQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmVsTNdX00bcuEYp1YL5rvG8oxRLtXZw1KhiYTzb+ukGops3SfJOtx/DX9g2/2S2+eu78dOsg=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwrVWCH6MPrXess376XhB0SobVdCLSJSKRp7rTOSyRLRWMXREng
 JvUAbbXu5DtZuBCIWCb1HeOvXmDcVpCUCt/AHfnUGRjMcTwLq4Z2oIp8GmgBAYDrdzU=
X-Gm-Gg: AR+sD10e0ZVrNWXqmxy7PTfUqyVwOVGTIu5+XC4gnp7N//3D/tPeLZAnbt8+KbyehuD
 mCBKJlRyHOTJz+kvSECcXS7Mx+rsJTb9gBgPDapBMfL+rGRXWqFcqA9LOIpwy1P8PbJe+Kpm9LZ
 rIflZvFfZI5aWl0PTN7Zmqvzr4G7xsIlTZUbA6qGBFljPloHmR5Vk0zlCOFd2ixXrcJPWFZJZ1x
 kiY9D9YJ3qx79Njq68hclW/eSG8fYzhyuB8/HPEAH5PZgZDTcJzreGQN1pDjjGBnEBzzjyZvA9d
 rNXgJZQD+l80VbpU+Fhy98od3chzIVoatlhGvHEVSnwTpVxmyvSCLl5/56ET5D2cQCzH063kFGY
 FC1rOfv/IML50f1QcSNXmkXtMPt/7xwXkkBssuBt4AA/T+wmwFTWnFcLwIQypk/c2cipKmKWLcq
 xtSErFYCnYan81J7sEnwg7WLYCtSdO7oRDVUqD1eE2Qg6pWuDvHlFX3y+wGuGzZwG04q7Lo3w6Z
 dT3C+Z8BRERF6/rKhx9Ecj2OjRU8XSqiwPi9iJVeUcMbdBGunAKxcPJTXStCcxKrAa8C7ceLmOL
 BqCIp4rfc8eK2/BN+WeoVHy8kQ==
X-Received: by 2002:a05:6a20:2446:b0:3cc:22bb:8911 with SMTP id
 adf61e73a8af0-3cd00e65097mr3078543637.6.1787111848993; 
 Tue, 18 Aug 2026 20:57:28 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad53874sm2912408c88.4.2026.08.18.20.57.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 20:57:28 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 19 Aug 2026 11:54:58 +0800
Subject: [PATCH v9 16/19] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260819-m4-v9-16-6e66016392b9@riscstar.com>
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
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

