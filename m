Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CBC8C624DB
	for <u-boot@archiver.kernel.org>; Sat,  5 Sep 2026 09:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DAE0940BED;
	Sat,  5 Sep 2026 09:15:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V3hPLgaalVof; Sat,  5 Sep 2026 09:15:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2BBFC40BA7
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788599713;
	b=JPh2VsqSQQBuk+HlwA7tbxPVMY9RCpKxjXM2tvJwwkutgUcVWqE2NUAl9ax2EpL5+pKE
	 npybyawoUXCsJ0j5KSfKvtdtEgedJx3U58fMbc0UqrqAMXzebyBZsHNXQ5cGvZSOy/hVP
	 itdjLW962QIuMSSkeQt8KK1AhBDXsuud4aUwmgkSSL7CcJDTnIfq+8SFIzwpOdDVhB4j1
	 Ji1gmrvoBNxT6UDCsyxpsOACQgJMiX3zYI3hhljUiF9W/YY3uuJSCcbD0rwm+SrgtLN2f
	 vEt71yi08luPNaiOH2beyjvc4/Yi6imcO1qZs9UNQfHcrL04WAB0cfVJ6jJqchMPDWA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788599713;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
	b=F2LX44t9DTx+4+1siNMvGceA7vPLHdl4Q38gMREdgKItemFYGtUcyjsyZUjao5zPGVdv
	 wY4oXjVMAz5yxzdje7Jq7OD++TB2NaFzV87BxCuEramv/Tbfkm8YLVG3NSpeTNU9UzQNL
	 x+gNsbCCAVA2fNC1J9UUckCqyKvktTSsh4VzR4ycoXb7wwnpehUxIt/pmrKpaak7K8Sm4
	 bF8np2KNOxukQf8JtS+Jsanbyn9f5naZHa/FE/qEEL7l+UykjoEXXoIvLkNbNZXIzjcV8
	 MqXsiWSx13ePRKhhTpRSSkw35V0s88OU1AHvGnIXx88ecSky/C4FvA7+ux9BZJ5WO4w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=KpYAlXVx;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788599713;
	bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0nNaW9DM0JFdeIvRKwAVkzC+OQDLH1RqsU7l7H6uiE21EDI2gRN16T6zHSSFNTcDC
	 AfcXsYViJPcMwSEHaTOppSlLtsWk47oIXLRZV+htE6jZmrlZxYD94gnUDFoUwe7VhF
	 Yg2ZeOgy5tWZWi/vemiwTLDivF+xw2jH0ohycamJ7LRts+Yc0VUl87uyTcPCiwEzO1
	 Q6/u+WBPvU1DYN2c/6FW/mWeOdNyOiYJ4tXgCwGcfP8MEZ9LYA1gafzVpFOmnUvDEZ
	 O+gVN6QxSyu0qjLJLz8npQx+7BiBzE5zGar8C0N8JWurzK3MGc8gutkvTcx+H4q51C
	 1KKN43y/pB1Dg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BBFC40BA7;
	Sat,  5 Sep 2026 09:15:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9EDAFB88
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9111940BFB
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pkyFXegZxbcL for <u-boot@lists.u-boot-project.org>;
 Sat,  5 Sep 2026 09:15:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E69F040A93
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788599711;
 b=pCMna5I1OJzn61kPWqfp1sZHdz7uc8x9Ri4BpwnZHnoEIVwogsAR5CrItW3FhUGfmdU5
 cTdZCs4Byb2SDqiwEpVWQQplc4VSJmv4dw05sMYHgHn+TDlzFoUTVMx0IHpHvC6MdGG8E
 lHdb8EiIjIOxemgDLb6GaPgSgF093+pNcH2PqVmxZmLj6NS1KC3jvDytoR1l0iCiSWEMM
 t0q3nMXdXpUC6Z62i8ZjI2Tlz7Om5M+jCxDvFxVzM9XU/kT0NoI01dkw0CnSXydB9vKMy
 ErSFoh/sDrqW3lUfkG+MP4WRYbxQB907YVXBb2YxcdJruAWE2dbK0i+6aTzYljh8rhg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788599711;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=La349Um/dW8pg0Z+3ieFKTeA4TYCCHWaCpqCr3IbHBuvcWuKU3FhsoQRF7yKZ7BhcX5m
 wphkHbMo2Q4l4gPlRSMA2WtRgSuEGCYXVOleSF7vrgoMVyKqLy2f8Tad5AicgKoCUp8YR
 3CzPbiBqf6jligkGjq2gdeC2eNY9BG+AE+VINfW/jxiDHr0LsHCi1wWtzdgzrjC6iCVQQ
 cFSrEWPV1wnqFyFd7jRdc4Uyv3YJHar4Z+DsSjywwtbz3Wm28goq8qdODSRJe3jIHbZLp
 HjVWiwNwmFzBtiN+bQcwb9L9mHf1OGaBMQCL2VPsU5o9HmRLPdEFAcsTLJk+wYU7PrA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=KpYAlXVx; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=KpYAlXVx
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E69F040A93
 for <u-boot@lists.u-boot-project.org>; Sat,  5 Sep 2026 09:15:08 +0000 (UTC)
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38ea87caafeso1492633a91.3
 for <u-boot@lists.u-boot-project.org>; Sat, 05 Sep 2026 02:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788599707; x=1789204507;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=KpYAlXVxJ7hoYuEsOS4l928NKULjWlr2yPBLERx5I7DwozhBQHs2smKUfyrvNTr2Q2
 CTrz8mhugZZGclXCFN/kl4vtif3OM4RgVveCRGlGICHyaYTB0nMdNyCagrraNNg6bc1A
 okz3G173jeqHrCA88szbDrulkbqdynoztD1LjPsL/OhE9sAkivrNqxHHBVCON4wUhf1+
 X9AX9Fhan4h/7a/vB+ISVX6JxBiZpMbn7sxne5mMBhBa3vYNqpM+yNOwkbxmp1db6exM
 CJR4QxcDo5+RSpx9Jt0vYa9/sD0om+6OBgGUOr0Y1sXEsDpQVOrztlNjhwhAyOSTSkm4
 adUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788599707; x=1789204507;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=UC7rmyQVb9bpmGUHKjtelzj7bFQ29ocflU48TKcaWcMLnfmgKeyf+dZemYb8QpHU22
 wms5PyAGIuZ+79vyvuMwQsLCLU3S+AvudEff56Pc/NWWjRVDy81X2mb1qqJic+PSHXVO
 U0LCGBDy1GZcfCe+2p093ENWiyGqyB70cOOSQjBoGUKWdKtYECIu0h6YH9QKyP1Gp6QC
 QnG8Uxem0rMLqlriBK5c1/Y28hoPmiPSoM6InN+3fbwxBu/AabdEyTIVrYOgLGJj6FHR
 QI/dnO1fpNfTyPd0ui29seG1k1tS1XuRpdbEKgc9BLau33AcasnvtwG9f7HZep1BbI1y
 BUQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZhyQwW5/hgzsFzciGz16zy3aOMxZu6tG8NXbZDmSpUnrDxalPzDWlHV6ei4MjZpHe6h3kg0s=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++n9doitl0rBNqttS4cGOSzY2eQCZMHSWaedk6R9E/Aln3lC4lG2
 R4vNNAtvYwLuUYCNziKGdG4IDHn8BSXsfgYhnDVwsacC2YtkOFH/9eO7jCQyHQurosk=
X-Gm-Gg: AYBFou1wOS3ic9bR2S/ZjYHQdDP0HyXd6Fhyl2ElXH9L1E8+r6ep6yGLTgKrzdlOc4E
 URBuu3IabCXNCMhadnW1Vxvuw5HueOMGuN5R4FRwiI78mDL0HVhkBbFTHmljXJgRSQVQrFKBJdu
 ylauT8viLVhRu93aTaJdhjDruEtZoldwsorOhTg1haKBA7H6TgJhYElHd8k8SENRsn/ffUQdjMQ
 HgomheEps/a93pL3EdUp3Trm6pefeEGEmyxSmSSA9nh8HDGQIpkizlaiEaUscrxSAdfKvNAnSfG
 Ht1ME58Q+mddwFf8euYC21p10siGjEAtDv/VAd9tAjMsM1CxOSxcFZAdFg2e8yR1vLRlvni/zj8
 E/NGNjsi9JSio6yEqs2++w+c+t4UNtb1hn1tVqxBaHSvhZ59W3K2POH+0NAk7xl2hMiXxKdQ2SA
 0tym3/aWd8tw/H1Ncv+AywgetS+rJ/xvjsUZM4moGJ0Koczkem5ESWPK9rQRnUW+ybGgN0Akine
 xxsUE7ZYeAaNwsDGcr+wkDjwYNC/UEazbdinsl09AGcK3GmAZ2j10FJWueXQG/vUo2gQFyctt42
 bT4HFA1Kwjyafay3avU7Onkufw==
X-Received: by 2002:a17:90b:5287:b0:38e:6a44:671b with SMTP id
 98e67ed59e1d1-39b25eeeef9mr18163891a91.0.1788599707323; 
 Sat, 05 Sep 2026 02:15:07 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339aa37dbdsm10991553eec.11.2026.09.05.02.15.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 02:15:06 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sat, 05 Sep 2026 17:13:27 +0800
Subject: [PATCH v11 14/17] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-m4-v11-14-235eacd94fe0@riscstar.com>
References: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
In-Reply-To: <20260905-m4-v11-0-235eacd94fe0@riscstar.com>
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

