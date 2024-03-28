Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA009C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 10:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78CC888155;
	Thu, 28 Mar 2024 11:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+zVedBg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27BF38815C; Thu, 28 Mar 2024 11:30:34 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61F9E8811D
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 11:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ghidoliemanuele@gmail.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-56c1364ff79so896256a12.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 03:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711621829; x=1712226629; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqoHV8cGciX4Ao/8p4+nn/qyhtF2e1hKDNhD04oySek=;
 b=U+zVedBgxqhA/RyOkjd/Oc/U8kZBZlaAnLr3ZsMgV3YkdJQq6PvJZ5TKBr3pEj/KYO
 TbA6auPiAO0GQLCbO1eXANAUKMebh6fUS+fkDCPgH0H2wBy55WBvqTZv41CahAfb/9Yv
 3/WTzxXq61seKz2Mw92+KeelqQMlbb+GtV4vlYnwiWuzUvAiTgvXCIAunLCmnyRGa0kA
 54LULrmLwGqsvJEaZxoNvgLFRYTagS+5BHKlO7tgTyKGeWb6U0iIBAn8e1pnzFO5ZFMe
 q6SVsW/3rzQ5izaUAxS4D1CpajwMmXN0TVAXL5VPd/AXh7MuhotSy30Qke+BGeYM+3wl
 C6fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711621829; x=1712226629;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yqoHV8cGciX4Ao/8p4+nn/qyhtF2e1hKDNhD04oySek=;
 b=m2mMDmAr3WU7XRvIsxFZfGoquXraaoQh4Gw7tClwZcXxQ33wo/aGuYrM2nDUZcdCYL
 uPu/l+qR0X+UByhGTuUnOtIUnIFz41f5UMlD39FDQstkKBSfhuLtqm6zrUC6EWi34Mk0
 JrihepMjgBjOUiQXNrjzLF0nMmbiemweup6bP0IO3/fEziYUeS0ktO/Gofc59vG2CrLZ
 /6T6DHJKGO+2laWG/zpaPbhacWT35+Sh6dEPJPcqhUlCgP/XDFznnkvXuE5N+ShQMXwQ
 Y6BlVbAmNuyt/obbMvxWMThb2KM+74kZJd5gs+5E/G56Vd3mwqachvZdwwMbhCzknTUk
 4YbQ==
X-Gm-Message-State: AOJu0YyU2ghQreQM+xugUEUboMhUglJYjVuLe9rsverpNILYN/31AYJQ
 OctqMwJnJ4SzBG99jOgND1zLbCCbOGaI9arMpC0aPeuPxzybuEfRaMNA+OWQ2xY=
X-Google-Smtp-Source: AGHT+IF1/Xri/u3x44UmL+KjMCLos2Vfh0OaeHyWRcjrP/Q8osAcPD81ffrPdrcwHMUOJBIZ/h/diw==
X-Received: by 2002:a50:d586:0:b0:56b:9b69:2e81 with SMTP id
 v6-20020a50d586000000b0056b9b692e81mr1720104edi.27.1711621828969; 
 Thu, 28 Mar 2024 03:30:28 -0700 (PDT)
Received: from localhost.localdomain ([2001:b07:aac:705d:baf6:ec90:82d5:a261])
 by smtp.gmail.com with ESMTPSA id
 s2-20020aa7cb02000000b0056c0d96e099sm653099edt.89.2024.03.28.03.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 03:30:27 -0700 (PDT)
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
To: u-boot@lists.denx.de, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Gaurav Jain <gaurav.jain@nxp.com>, Fabio Estevam <festevam@gmail.com>,
 Breno Matheus Lima <breno.lima@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Subject: [PATCH v2 3/3] configs: colibri-imx7: allow accessing job-rings from
 non-TrustZone
Date: Thu, 28 Mar 2024 11:30:14 +0100
Message-Id: <20240328101724.127371-4-ghidoliemanuele@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328101724.127371-1-ghidoliemanuele@gmail.com>
References: <20240328101724.127371-1-ghidoliemanuele@gmail.com>
 <20240328101724.127371-2-ghidoliemanuele@gmail.com>
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

From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Set FSL_CAAM_JR_NTZ_ACCESS configuration since colibri-imx7
uses Freescale CAAM Job Ring linux driver

Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
---
 configs/colibri_imx7_defconfig      | 1 +
 configs/colibri_imx7_emmc_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/colibri_imx7_defconfig b/configs/colibri_imx7_defconfig
index 0c6a272ddfc6..16f923b07c22 100644
--- a/configs/colibri_imx7_defconfig
+++ b/configs/colibri_imx7_defconfig
@@ -72,6 +72,7 @@ CONFIG_SERVERIP="192.168.10.1"
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_FSL_CAAM_JR_NTZ_ACCESS=y
 CONFIG_DFU_NAND=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x81100000
diff --git a/configs/colibri_imx7_emmc_defconfig b/configs/colibri_imx7_emmc_defconfig
index 8dd9fe6e6a38..7c6a725ea9a2 100644
--- a/configs/colibri_imx7_emmc_defconfig
+++ b/configs/colibri_imx7_emmc_defconfig
@@ -61,6 +61,7 @@ CONFIG_USE_SERVERIP=y
 CONFIG_SERVERIP="192.168.10.1"
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_FSL_CAAM_JR_NTZ_ACCESS=y
 CONFIG_USB_FUNCTION_FASTBOOT=y
 CONFIG_FASTBOOT_BUF_ADDR=0x81100000
 CONFIG_FASTBOOT_FLASH=y
-- 
2.34.1

