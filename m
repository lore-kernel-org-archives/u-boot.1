Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EE6C3DA49
	for <u-boot@archiver.kernel.org>; Thu, 18 Jul 2024 17:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0584388B5F;
	Thu, 18 Jul 2024 19:36:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lesLqwtK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC46388B42; Thu, 18 Jul 2024 19:36:45 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 959BF88B28
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 19:36:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-427b1d4da32so3906265e9.0
 for <u-boot@lists.denx.de>; Thu, 18 Jul 2024 10:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721324200; x=1721929000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oQWD0XbYpzivUrX+9+8siVQWZcY+/agG+WeL7lk+mD4=;
 b=lesLqwtKSLyO/NG/yy6Qf7ntVUz4ILjLYgy8F+t3SoZy39NsCiVZWjOJcpY3rWh1lr
 cms0sZr0zW3Tk6EH5T90FkJfY8Rnzh+GqpGJvKRy/CEdYJq1KZl59mwM6FWl4gPIxoZ7
 8F3+VjVpOigET3//MwgVJs/J3JdeENpOe0YeU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721324200; x=1721929000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oQWD0XbYpzivUrX+9+8siVQWZcY+/agG+WeL7lk+mD4=;
 b=jLCOj6yZwUZhE/FRszfCMJj0p2Oa0cEty00TXteY+soY8MFpm+g47VZIERiTmlweSx
 KbnO03Rec3O5HLVbBGDsNTjaxeN5j2qv9uDCGQBis5oKarmMaAZhVbnbUP1nac1BGNko
 jiWfbEfE6hH1VffhTHkFlWXkwGgU/hparf+geYO+oQUh2U11LGzDaKTikzMQF39FaEDR
 /03A8QWXn3vdFvrmgKZczmaeivgzw9ip9Otm4E8MyMm/ZZDpIgsX/zaXu4XZQ5Bq/Czz
 D1pTRSIEe7mI8Vu0F6ASLLbJX6j8ag7rrV8YoK4qcxbwojSD0s7+zvhm5uR53QJCRyEC
 JvnA==
X-Gm-Message-State: AOJu0YyFYHa+k5RGpTMzmOedThAS1UCHRfqFz+9ssstaAFXe6CXRMspy
 cMhO7p6n3+EIn9kQ+yPkYLej+rY+7cQqyrF1mxzKLlNiNfTRma/QkxRJy/kjGjtR+tK8b6bVLKY
 =
X-Google-Smtp-Source: AGHT+IF+OXj9zIDBWlznUXaAhvCBvHX3KAG6wnguecnc3Hi+NHHrp8MqQtRXp/V8NKMp1OfxuViPkg==
X-Received: by 2002:a05:600c:19d3:b0:426:676a:c4d1 with SMTP id
 5b1f17b1804b1-427d2b3a890mr13776455e9.8.1721324199764; 
 Thu, 18 Jul 2024 10:36:39 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427d2b29396sm20950715e9.32.2024.07.18.10.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 10:36:39 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Priyanka Jain <priyanka.jain@nxp.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Wasim Khan <wasim.khan@nxp.com>
Subject: [PATCH 06/20] armv8: ls2085a: Drop CMD_DATE
Date: Thu, 18 Jul 2024 18:35:57 +0100
Message-Id: <20240718173611.4014274-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718173611.4014274-1-sjg@chromium.org>
References: <20240718173611.4014274-1-sjg@chromium.org>
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

These boards use pre-driver model code and it is several years since the
migration deadline. Disable the 'date' command so that this old code can
be removed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 configs/ls2080aqds_nand_defconfig | 1 -
 configs/ls2080aqds_qspi_defconfig | 1 -
 configs/ls2080ardb_nand_defconfig | 1 -
 3 files changed, 3 deletions(-)

diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index 06e41546d67..0066414f0f5 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -61,7 +61,6 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls2080aqds_qspi_defconfig b/configs/ls2080aqds_qspi_defconfig
index 0b54bc999e7..44a1459749f 100644
--- a/configs/ls2080aqds_qspi_defconfig
+++ b/configs/ls2080aqds_qspi_defconfig
@@ -43,7 +43,6 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 # CONFIG_ISO_PARTITION is not set
 CONFIG_OF_CONTROL=y
 CONFIG_OF_EMBED=y
diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_defconfig
index f1009e1738b..cbc8d6a5cf4 100644
--- a/configs/ls2080ardb_nand_defconfig
+++ b/configs/ls2080ardb_nand_defconfig
@@ -68,7 +68,6 @@ CONFIG_CMD_PCI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
-CONFIG_CMD_DATE=y
 CONFIG_OF_CONTROL=y
 CONFIG_ENV_OVERWRITE=y
 CONFIG_ENV_IS_IN_NAND=y
-- 
2.34.1

