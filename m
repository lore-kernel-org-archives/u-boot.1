Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C691C2FC0E
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:28:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4135E86C37;
	Fri, 18 Aug 2023 02:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IaPeo8av";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA89886B7E; Fri, 18 Aug 2023 02:27:22 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20BD286BFE
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-34bae82b2ffso1364345ab.1
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318438; x=1692923238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1woV8r8krwRNYNmEX0yorDZSMHeeoB/U0cAb5edDW8=;
 b=IaPeo8avVlAdmX1qMHYdzA8zEeGIFpNBrz4LF0NGmtpU0fFNKYV0eJUA1OeuscuDue
 ii0M0YIbU3AOLSV2EeksZnYZtrFO1lTpeUsap7oz76rIMt2a3T3AldP8EidAK9GsTlcC
 vWtl4rx251lWVF+X/5o3nn0DNLyLKoeQqjcEU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318438; x=1692923238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1woV8r8krwRNYNmEX0yorDZSMHeeoB/U0cAb5edDW8=;
 b=U1TMJFQPjI6yOqcPOxqfV12yL3aUb4NktLTqOO4TF5q7KDCtUzeze1PiiW6F/giRTZ
 VTAEntYEoyQijM3lGJphO2qBGw1z9yAKSPvhMrTnLDUeeE4FqpW0cc4Q1UG1vtQdCcWb
 d/h2E/8X7Xk5yE8+C/wQR1YSjXUbD2nnPBfpsKwwKedU/ONaa/XaHpZnHTmT9Qkm5DlL
 aT//YW1JsCCiF7f7r1C4nGro4KNDFrMB1FlHKvBogc6zP25BZqiA+ujXwU23IsqeoIyF
 e0NOiHZCP/n4ezPzueZ3HC2J4TtwPv4Dvz8yrdYLrEc5r7oS5wbCzIRuhZ/hYufmE7of
 hehw==
X-Gm-Message-State: AOJu0YwPYwYOoCU7UALuGzV9Xe58wwiEaudX14vh+U4cCtTd6P5sSeP7
 Oprjg8dC5rZDlUMrMqrz0DvO/ChNIv5yR1HHBhU=
X-Google-Smtp-Source: AGHT+IHcm2lARQH9xIhiEwGVamKRhuV4s5wQzkMqS4MlX+2FwpX/pnfQ3rurlaeieouh7AprsMHxfA==
X-Received: by 2002:a92:60b:0:b0:349:98ec:8ce8 with SMTP id
 x11-20020a92060b000000b0034998ec8ce8mr1308940ilg.10.1692318438770; 
 Thu, 17 Aug 2023 17:27:18 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Coreboot ML <coreboot@coreboot.org>,
 Marek Vasut <marex@denx.de>, Stefan Bosch <stefan_b@posteo.net>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH v2 06/20] x86: coreboot: Look for DBG2 UART in SPL too
Date: Thu, 17 Aug 2023 18:26:45 -0600
Message-ID: <20230818002706.853550-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

If coreboot does not set up sysinfo for the UART, SPL currently hangs.
Use the DBG2 teechnique there as well. This allows coreboot64 to boot from
coreboot even if the console info is missing from sysinfo

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/coreboot64_defconfig | 1 +
 drivers/serial/Kconfig       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 602465175d20..a094a7c24234 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -55,4 +55,5 @@ CONFIG_SYS_64BIT_LBA=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
+CONFIG_SPL_ACPI=y
 # CONFIG_GZIP is not set
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index a1e089962a91..01100b6d93f3 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -672,7 +672,7 @@ config COREBOOT_SERIAL
 config COREBOOT_SERIAL_FROM_DBG2
 	bool "Obtain UART from ACPI tables"
 	depends on COREBOOT_SERIAL
-	default y if !SPL
+	default y
 	help
 	  Select this to try to find a DBG2 record in the ACPI tables, in the
 	  event that coreboot does not provide information about the UART in the
-- 
2.42.0.rc1.204.g551eb34607-goog

