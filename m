Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD64C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 14:49:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5DDE2606CF;
	Wed, 29 Jul 2026 14:49:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y1o6RKJb5TqP; Wed, 29 Jul 2026 14:49:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 615DE60667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785336568;
	bh=hYQoEw2vCy1Ekc8kclkft5cIgKYohAvBrAg6sFtCB74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VPJ5Ri0Y2J1y1S4Y2ZIQJ0bQ3xpOy4FRrS6i9jN/8PPUo4cwZRw8r8u0v/fubePSZ
	 niNz1gL6x/4mpRv0zfU7dn/7aM/E97xZrNY7wDefdUgiwo3eSXce+TMNOasgO1n5u7
	 2L66U4vtxZXHMSK3VU4Pd0QaLG0hzzn5DvM1cLgjEihfTPtnoUfwMeT07X+Zx//RwN
	 8TqJPAFsXaTZCBGuiExTn6w6iXb3UVwbd7wq9OE8OmU7+5xaWruS0ejwgIMiqlTJoZ
	 ekmEYuCilVvW8MIFoh4W3aNvcfqf8UmwSN0B9sLkfFyCkJp0wLVwJzriO1wHCBL7Vd
	 b7F5ikmXPB0gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 615DE60667;
	Wed, 29 Jul 2026 14:49:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DBA5977
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2055D60834
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OizMZUV95yjt for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 14:49:26 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 88FE4606CF
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 88FE4606CF
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 88FE4606CF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 14:49:26 +0000 (UTC)
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2ce7d2adef4so15716605ad.3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 07:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785336566; x=1785941366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hYQoEw2vCy1Ekc8kclkft5cIgKYohAvBrAg6sFtCB74=;
 b=B8tfc8LUjKjYa8EI6eLF/5/qZxfYFYWEeIWrTf25ZEs+mlC6RIJgVb2u29kn7sTfwK
 7uiju2IMAflG4C56X+lq9HWDS7vyMpJDauKYCE1i1c00zT5QAuZziEArWdUYh3/htAs7
 wjilhM1+wdt+ma8OmPNkcx3mu6pvCblD8GqPj2veejBaBNJ48zhO8bbJF1kLFGJuJ9JE
 ZlIonTCrjUEUcmwm6LiD5ZWzirkrLpQEGXTRueJH1Tex6f5BtRVbBl571mbQE0CPq3+c
 0jSUkuUaPjTBiM/Eupjjmn6LNjMfXaBHr92YZ7+fep/1PqJge1fBlG8P/YIRj3k1H8Jx
 Be2g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7k+m7OeOqOdqMRWpLc6gFQy8Y5i6HGp2zXvEFH1no91cGZ977J/fmkqkMr3vrz25Tamy/fww=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwazpLyr4W0vmvuWqN0pAshtMt4ywUvxpQlXvawq4keJcDZxAra
 65e4+Ns4AJSvXtZkElpYueDHFj5GuY9t6svEkYFWXoWUdHPwwe00PtfqB9JSXKoydpE=
X-Gm-Gg: AR+sD11YAhZwaYVnR7EGgSK6/1l4ulKNcazGq1TI++JK0xs2SRwaaISvLv7nk565x53
 kBpUKwoR5+WLRDVkwu2UchQVcDop6SD+1B5DsUzLM5IXDtCkmEifidQFzT56rpjr2vfpWeiLSY0
 3rfS1bk6cOl5jdF6fh267vpYgnZWN5w3LEn9DMfdK6Y4937iE6MpWwR2RDrh8TK/Kz9UYV8BI5a
 tsZjGCZ2IAaBjMjHtCf9uIxa2YNprYQ+itGk3z4kEh/szXnbho68dsXCyf2KOhazL3WcYVC6+34
 VbVeVkg0lzfnmDepYTstQKTKR4LW98EuuUA0sMKS5ynbxnxL1azSUWaLKfW1x7nDIdl0XjHPmqf
 WcEteC9j7BVzuQihavWVJW1ZpuSBy3xf9pdkP7mtwDcdeOXDbCFVd6Dw2a7birAoFMPcMd3Sgsz
 ex07P2KOYAaKtuR+I4T6rYy73LQ7yM+dguT2sbYY2icC5e++LvrZaNbS5WanOtVspNYBxSA6X5I
 S84oNmuZUOhWeRRcrWLl76FLnwpIF8ulq4K5GIzixgD7HSzWaXnn1+eNzlHs7AJEeNnMMSzvrsK
 4dhRcY5GSzi5X5BYlK8YhfiCCuMRNkq1qDNCIQ==
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:6c08:2848 with SMTP id
 adf61e73a8af0-3c8ba613303mr8673223637.55.1785336565815; 
 Wed, 29 Jul 2026 07:49:25 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e7262c23bsm9320192c88.1.2026.07.29.07.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 07:49:25 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 29 Jul 2026 22:48:25 +0800
Subject: [PATCH v7 07/11] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-m4-v7-7-2cb04b4fe389@riscstar.com>
References: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
In-Reply-To: <20260729-m4-v7-0-2cb04b4fe389@riscstar.com>
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
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1785336566; x=1785941366;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hYQoEw2vCy1Ekc8kclkft5cIgKYohAvBrAg6sFtCB74=;
 b=WfSWpILgUgCdkBcrERh0x9rF77TZkwt8hCton4/Sd3zPYtH1PmKRBt7WdpujJBvKMS
 Xo2SqytZw03pINGUE6eVoC6QxGdd6lntGzqbli19cMimFn+KKhbAzrh57DtDgwCd2AH/
 ZbAUQTl06spllMHwKK52Kf9dqnlV/D9Ea7iFW/Tu4nTHRmUKgWU3XGZue5VhLrQ5ylfl
 /ZD+f/05ZDImZBZtrl9aS92t16fNM81IVYkZFgMHh2+FTjkSsdZ3rONOYu4BYv3hWWvb
 Fd7NT0DSag8H800HZxzKio7VoHuhKuXLIQYoUeZ3h41NF1OBaEieFCspmnd8xu+mRDK3
 rbQQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=riscstar.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=WfSWpILg
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

