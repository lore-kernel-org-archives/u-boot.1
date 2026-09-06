Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17503C79F99
	for <u-boot@archiver.kernel.org>; Sun,  6 Sep 2026 09:11:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D19A080DCA;
	Sun,  6 Sep 2026 09:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uosg149SkbUm; Sun,  6 Sep 2026 09:11:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1F23F80DD9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788685906;
	b=CvDH3VrfREAu9FmbTbhPz6mUXMgak6jPkrYczWumibnnoKzJryVlHy/YFol76JRBFysB
	 mH7m1RwgN8fQe4uJMQhlstPEh6LeLSjBmGDZRNuMvj/NBuEuEdHWHG35hbSWZIhvAf9qA
	 RUOUwoJD1oWwS79w8oS9R/4kg2Y5uuraLIyVguxsBOnYm5dfLcr/OlhHHbe4ziyJ7dBZZ
	 6JlAelBTlidGjlt34y0MkG23NTnJDliwxJpIBBJdLluhqQ7oERQlEhLzARoUeEC4l9WkW
	 QVN4lyTQtV6Ol1N69UTbwo2YWXwUC/++QqUTDHAEKv/fpKkNBARn66GceNPoOwQWamg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788685906;
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
	b=XzlCO+LFYG+fCzDBzkfLBufV5FCDQXfgaix8M+z3efQbf5z6n5vQLMIVCnNQXpQvXjl2
	 5CeF/8RGrIwaLPVwbUXlAhQdQkrQaIWKpr4scVEJMuR+zqEgtZxxdReXlbqY52ownV7C+
	 Efq6h6W30Op7qYVI42e+bDuDrEoHUteSHV6e8DHTbetkuMbqEKyaPWQvUUG7Voqk7zfLi
	 /zlP0LMH5+gM/qqtuP077MAJWLwLMesq+YKkbs0NfK62ZWVAx+p5NHy8+A8aAqPV9YuUw
	 B0Wn2/oZwB8ecdwDPsPETYSG2A2l+uleo480Q4VeWkRAH1KAjpgUjBvGzxy/WsU5YsA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=riscstar.com;
	dkim=pass header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=TivZlY4M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788685906;
	bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SA9Iy63hdhVYVYuZomYWmsPOOQAB2ZUWm2sCaOJzLvBiOcnR6kvPcNGzyUuvsJesE
	 83LNqoYe5CeDhoRyWXnckxT/4o8Ta2lc6S6EOKOw1IpfSQ+nwQVQpFloAyh8QuIjFb
	 4PRrEpQ/pvNx0YnRxtRm6rg80+1IHbKDVmb2tiMQxMZHiMTBCiztUmRreJPEYjEdfZ
	 ZE5zSYeVZbNR4IhRJIlv89vDf1CnX5tCf2sAYWCbJdtYGZXzXwKTzhUdOLorfxdKHv
	 9v6vanIudlDMJHrdV+5bOxg3UZK+39yM/i3NsLx6o/u9BWmUZWcH3QQAftLAfUt9YZ
	 MGc936+/ozvhA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F23F80DD9;
	Sun,  6 Sep 2026 09:11:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D76DD118
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C8F3D80DEC
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oZHnH-O13RBb for <u-boot@lists.u-boot-project.org>;
 Sun,  6 Sep 2026 09:11:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 286FF80DD7
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788685903;
 b=Cf2+oksUjTVB19nsEcwHGAUM2kLHXFodnU2ykDw/KbOWVatxYBVxNsz5fwGxl1gVS9a4
 XFYRxIDYBWjd+EUzyTdkftiBN/jsYVIWygIsvPGAcyYp/AmRE9XjWmq0FbDIY3NEyx/nA
 TfFK2z59r7DzhD8cA6N/HQ73LTTTFTBUj/dwG9l5XZ/oHpEeodmBhEs6/z/7iGemEs1kQ
 APlGqJ8ZZIrW69FaidiVk3A97kN7wJdWGLheW22VJWycjqwC7hMNIf4OofdZelvpSlPCT
 kjj5Vz9O8wFfRZiwYLYBHdsj/H2hWEAFMuAelOwzn3yyx+fX/Bg6AnxMVr+bLd7Hndg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788685903;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=ZrqlCjShAC/HUBhG5oCsCZ3cVhZ2nDlKiG80zLOtt9PiqkvAes9XjhFTVgM7aXVYhTf+
 MDlV98TqJBKz5aOUX691M6VDt2jQshXn+ecW1Gi7G0kfkVRbDvmg9vNF8lu/3zZ9pmic2
 h8RmwKLFQ3BrMoL5njdGRZYKsA/DiXm8y22dc5z/JfnI5zNJaHc2Hng+txWanZBHQyeer
 9jUTo+UCdBqWKGxQ6BKwV3Nd+KCD8Fdk0IgPJwTum+fOUbleWXnTGqUzJg4ls+ljvH4QM
 WdStVgpgDegYxtkIXnc3TtDa2riEdr1jBBDHqrpJzDAN+1o4MP6QxTqZAKLXkYgK1ZQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=riscstar.com; 
 dkim=pass header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=TivZlY4M; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::102f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=TivZlY4M
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 286FF80DD7
 for <u-boot@lists.u-boot-project.org>; Sun,  6 Sep 2026 09:11:42 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-398b1e63c49so3039161a91.0
 for <u-boot@lists.u-boot-project.org>; Sun, 06 Sep 2026 02:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788685902; x=1789290702;
 darn=lists.u-boot-project.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=TivZlY4MN697nsdryH574yjq49+33O3XkZEkeS18H8qKtlWDloYqRAesHpcaIs2h5B
 Y4vvev0v2aDq31KoXnZyf4F6p5epIqMWhxk5T63fmpM+OtdXEQ/kWlsO4LcgOi3INStG
 hIjOzp+tWn5UGCV/q74oEizUflRoEoUQ7MGqM0/8lLEPvANXA3suk02nkX0qSWg4+lgM
 CM3KQj7pRJLKJunRt/XRr4APT2HN7BQEcP9l5iBj+3G6icCQVf1UJDf9BnRGbXJ1lXvC
 eUTRNOM2BOsnX4+bcGpXenPnJMHbWSY7L5FY77RkPMFH/NBZSPz/Hr1Jdt3PzbroewoS
 oRyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788685902; x=1789290702;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/g14dlRUw+v2tpwpdNveaA4tyvugJDl5xjyjAgeFng=;
 b=SCG+AaOgkOYVze6LDWx/3mIx8lowEt9pjMVpYrldsIUHe60dxQbsPgTaqWjGg9eeq9
 Zfb0s5CClH/x+VMoI+ICnT73EwAw9mx6VGW80gaSUs1XRJh/1QYqfET5ako9ieTN8xge
 6hg67CToEk4ZoEl9xio5twsk4Om4JiZ0R1TQNiMH1lRXe1zV+Pz+1prd3dwkMmtILQlo
 7gMOsO+q9RTkXPUppiv4JrKU3WLYoDDutMlyMXQ4GTZwAstRhYMDRxkAMccnU85A0ezq
 F6Q5iPGy50tsxilKnYdwxPOhKtxS268rt6uRAZCoPvgvL0hbDBC6894DHOb91bVqLMM5
 wmGA==
X-Forwarded-Encrypted: i=1;
 AKwUvByJMEJocL1dtjtOxnTwnqjatNM7PusSZT+j62W/hHZZQz1VCLUgsR0dqoHw9tv/TzeqjL2g4uU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lYwPt+7BnfbxmM3MaKZ/RblQpywX6zgZZTusQBt1LwbJ9qgEZM
 dLDv42/w9jPKasRvSgZNlH84BAwp/p+VNbGZ0dZ7QKssvzwVZrqMe8YSJ1kwOTdzFFw=
X-Gm-Gg: AYBFou3VAX0Qxilkm+5AMiBoL0IDh53cW/Rjp8sVp0fQW88MruRiXLfBC4XKHCuEL0T
 8LdtJjMcURjit9I8HG2uyEVUv/B4MW2aBR0cwE4/WCRGuGlwrWCAlIgAHFCxa+ZCArR/TSHA4tn
 yTAHnawqgtgIfALb4F/xiLLLcbUG+AOCCjbLyLhkCtHr3iQw8X/DxnEN2zj0Wg4eMbmgWmeCOM7
 8u0KwuM6z06f4obyyLWThlETke2PZJ0VzM6lPO6nSqH5CvQQVgLPvvLWn8Uzmf+O8afnnTQ/SbA
 n2a95rmM5uec+A8VR8s8soIc1F3r+0/+fme15oeJXF/BUHiwNODozSRnr4RIbRWXqIHb+XGVezW
 t9RFe01RMaxb6fDIf9pKU4iV5JWx2xalvTPM2m50vL5Wx9MQjeiSvnF0XiFYup0h3MxjOW40DXI
 uGI2nVd6nfhuQxiRGh9wTVJakxWiMCwocthj4BIun73FSmcxF31dyzMuKoSwvJS5vcX6lO1UZDh
 30ah6vlp/joDJfSJmkS/gEZWZ9/MeBlkNTX81YV446DqInaGkgYxBGFsFq+njxa7v4B60b72R3w
 LeUcQ0t6RChlJ+wjRvBLeYYsLA==
X-Received: by 2002:a17:90a:e183:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-39b07f305admr25316759a91.5.1788685902245; 
 Sun, 06 Sep 2026 02:11:42 -0700 (PDT)
Received: from [127.0.1.1] ([209.170.101.129])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339b8f44d7sm18845384eec.22.2026.09.06.02.11.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 02:11:41 -0700 (PDT)
From: Eric Chung <eric.chung@riscstar.com>
Date: Sun, 06 Sep 2026 17:11:06 +0800
Subject: [PATCH v12 4/7] configs: k1: enable SD and eMMC support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-m4-v12-4-89eb5a8f879d@riscstar.com>
References: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
In-Reply-To: <20260906-m4-v12-0-89eb5a8f879d@riscstar.com>
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

