Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF1CF2568
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 13:58:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB8FF88E42;
	Sat, 12 Oct 2024 15:57:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="O30HvAFU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CF9F889C3; Sat, 12 Oct 2024 15:57:32 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5DA088B23
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 15:57:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a99ea294480so61199566b.2
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728741450; x=1729346250; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cd5H1QdPdYTurC7eKdOorF59l0kwIdATGVIexsLuxOE=;
 b=O30HvAFUZv9A1KKWPrvE4N5r/XTw70R4PfmEcwvUb+YPlTsp7TtzuuCAuyJ990SgaJ
 HKlNxB5e1e1Hyv0Cj7B5Z/0RG2Fu1rpVa9ZyqNbJWQMJubY3v0/pVx2sD0FZeTM+OEy2
 UdkpfK826LYl0dtEGHIJ8ikrtGkPvxBBVN4W42damzl03PVkVD2K3lcLW4kFPzlhbW0L
 75xVpvvzfvSbR+36/Zrs9ocbqtIiDgePh556dFDbXrpvUXIWfHDKABPzGYQ3bow8Pxe1
 G0zhI4/bbrFLbMXCVDxoC8CNUwQs8VR2kIV+OpfKLiJv9duCkopyaCCEriq6BMIG85dr
 sT8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728741450; x=1729346250;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cd5H1QdPdYTurC7eKdOorF59l0kwIdATGVIexsLuxOE=;
 b=n7QhHteIX5ig2fWspjcrfZi1LL2nSfXIMAK9yiYyr5XbobyR9KovXKxqy+B85ktPtj
 OroFc8dj6wsJFumgPaBIUPxjtLX4uwMhq/5GxKBYKVH35hiY9Qhkd5X4ddt8hIWt0512
 +7dqGu/y5WEM9nHkN+4p70y94bDR02rGyuBbjVgpCUlJJzpqY3+LuS8nyE3iOqV93QgX
 gZGCQiEiwDPlHe7sAgFo5ypbQv4gDfUwJ8It6LK001xASJWYntBZNfFN+5fFBlhqbvXY
 hmBrYTR+Nt/4vAuDNC9+7yhZvVeqTvsLO4RzvyNljlEwdmCyWAzcy7YJSsyHujeUN5H7
 yiJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKGo+G2XSUK4YEcYvAJDQ/xbQg1Hb5nInME/f7YjhM6ECVpYMWBX+ZD4YPMU8KDM4j/cs35Es=@lists.denx.de
X-Gm-Message-State: AOJu0Yzo8TguuqAFL8+R0Ooi56Thjp/79pvdfvlkTEpgZ5yuUZVEG9Mc
 HDAGdHTycgBW8Txu6t8EigoMg2efmDmtMnygdLl8FIK7PAAnL+Omw65kypWV2N4=
X-Google-Smtp-Source: AGHT+IHaPNYiNfhPkXsptnKH6slI/mEK8Zqagz/lPtxc6q9yxCkUJQbQ80O5aVnRlsdcDnNd7t9QKw==
X-Received: by 2002:a05:6402:4401:b0:5c9:446c:88f8 with SMTP id
 4fb4d7f45d1cf-5c95ac156b3mr4955103a12.10.1728741450035; 
 Sat, 12 Oct 2024 06:57:30 -0700 (PDT)
Received: from cymric.local ([2a02:8109:888d:ff00::2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a7f2c1f4sm324955966b.87.2024.10.12.06.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Oct 2024 06:57:29 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sat, 12 Oct 2024 15:57:20 +0200
Subject: [PATCH v4 4/4] qcom_defconfig: enable capsule update support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-b4-qcom-capsule-updates-v4-4-abd05f15255f@linaro.org>
References: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
In-Reply-To: <20241012-b4-qcom-capsule-updates-v4-0-abd05f15255f@linaro.org>
To: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=E+5vYobahjp/ayl7KfnhRZ4liQ12bdvr/8bB01S6W1U=;
 b=kA0DAAgBBYMxKxlfZLYByyZiAGcKgEOhodznmm58rgcW3oUe8EbwHLGctXQy3ApCz2eaH9pFy
 IkCMwQAAQgAHRYhBLZRoUY8ar7QaQxVzQWDMSsZX2S2BQJnCoBDAAoJEAWDMSsZX2S2uKIP/Rnn
 D8e2xh/9tyU8lgoBn0KdOJqJ4gFAwrY0dwk7kpGuynV0kgP3PHM6LctOzL0iXMumLPaZOyLm+fD
 2bwBTgBxxin75Jp3UJJh2prYvSsgWLNr3lqLOn7hNn2ph9APbYGuIOktsN8REKBaed0n8H+g/Xl
 Swt9T7yD59priFCT4YYUakTtrRKD0naYp1WBcLRXIxho+hrShVAHAI8c5VGvCKeyboOfMRhhgQU
 HbPzGCYfAPhGArzkJyAxMm/1TVYHcKSY0Y5m5IodTg0yd0fQtG6KD0VqUD0z6scBBP48Wcon7zL
 eychlCjDcRXtPbMWlVMQxuiQfmEzX28dY1SqJA00YvqYyMQOWCumBhFJcRtQxHaFna/fksgX06C
 UYUS91MMCkO3Jr4xVhQ+HzEd1wzE1fJ4pt5hZp8TBfbnqyNjnBKkiiW6meCiNkXd+Jx7OBBLae9
 cg/4KUMLaSi2TuC2ZXPlHmAtXW6gOFiBoLMCQsBsbIes1hM7nX9doB6amMAfWci+SzAYl54fKLz
 4HKJvSck+EmiYjI0kOh+NySPUVz1x/1nZdXVT1Zu+7D4AFmHQKnSyuPJjt7vSe62DwCrQ9oZzhN
 lWJMm9jYL87VJ4gr+ouwZHkN5MHwDwx0ayUBRcymXGTZ7cr0pSnG5Pagkyw+PgCPG+LaOu4Xnry
 Icz5j
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

Enable all the necessary options for capsule updates to work, as well as
a few additional EFI features.

Capsule updates themselves are only enabled for the RB3 Gen 2, since the
exact details on where to flash U-Boot (or how to handle multiple boot
methods) has not been finalised for other boards.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 configs/qcm6490_defconfig | 6 ++++++
 configs/qcom_defconfig    | 8 +++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index 5ddc5ab3ef8c..ba26924da161 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -18,4 +18,10 @@ CONFIG_DEBUG_UART_CLOCK=14745600
 CONFIG_TEXT_BASE=0x9fc00000
 CONFIG_REMAKE_ELF=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
+
+# Enable capsule updates
+CONFIG_EFI_RUNTIME_UPDATE_CAPSULE=y
+CONFIG_EFI_CAPSULE_ON_DISK=y
+CONFIG_EFI_IGNORE_OSINDICATIONS=y
+CONFIG_EFI_CAPSULE_FIRMWARE_RAW=y
diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index e7ed03ff0f24..4c8ff0e84372 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -20,21 +20,24 @@ CONFIG_LOG_MAX_LEVEL=9
 CONFIG_LOG_DEFAULT_LEVEL=4
 # CONFIG_DISPLAY_CPUINFO is not set
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_I2C_EEPROM_BUS=2
 CONFIG_SYS_I2C_EEPROM_ADDR_LEN=2
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=5
 # CONFIG_CMD_BIND is not set
 CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_UFS=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CAT=y
 CONFIG_CMD_BMP=y
+CONFIG_CMD_EFIDEBUG=y
 CONFIG_CMD_REGULATOR=y
 CONFIG_CMD_LOG=y
 CONFIG_OF_LIVE=y
 CONFIG_USE_DEFAULT_ENV_FILE=y
@@ -44,15 +47,18 @@ CONFIG_CLK=y
 CONFIG_CLK_QCOM_APQ8016=y
 CONFIG_CLK_QCOM_APQ8096=y
 CONFIG_CLK_QCOM_QCM2290=y
 CONFIG_CLK_QCOM_QCS404=y
-CONFIG_CLK_QCOM_SC7280=y
 CONFIG_CLK_QCOM_SDM845=y
 CONFIG_CLK_QCOM_SM6115=y
 CONFIG_CLK_QCOM_SM8150=y
 CONFIG_CLK_QCOM_SM8250=y
 CONFIG_CLK_QCOM_SM8550=y
 CONFIG_CLK_QCOM_SM8650=y
+CONFIG_CLK_QCOM_SC7280=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_SCSI=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x200000
 CONFIG_MSM_GPIO=y
 CONFIG_QCOM_PMIC_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_QUP=y

-- 
2.46.2

