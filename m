Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD9DEE49A6
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 21:24:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B0028701B;
	Sat, 19 Aug 2023 23:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jg2IvzvF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00B9286ED6; Sat, 19 Aug 2023 23:23:27 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4500886EE9
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 23:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-790fc019c62so52617639f.0
 for <u-boot@lists.denx.de>; Sat, 19 Aug 2023 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692480203; x=1693085003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F1woV8r8krwRNYNmEX0yorDZSMHeeoB/U0cAb5edDW8=;
 b=jg2IvzvFyaea+7tFSoj5YfgBIwjxsg/XFg0BAr/xwSPhKFgdlpYoEpgzIIsGz4ebBi
 lxTctJGhUMb2SusJs859G7I9IVtv6TT+/DKUUdYYxEI8CRWBwhLxDp9cFmrzTvFO9iSh
 RhZpRB4c7M5C30ac9LazMIJTI7XYatocV8QL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692480203; x=1693085003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F1woV8r8krwRNYNmEX0yorDZSMHeeoB/U0cAb5edDW8=;
 b=X+dRkanpx3XhnEGaFtUApjx0pqjyMFGRBL4s52fNJEPg7s93Y2qgRQu7AKn3yqmZh/
 RdYxYiEbyD7VOsg1SVLceciVAYWfdMIWTd8kRaqw8LYITzB++n4Nplj/RyLCPrJU6Dwo
 arBZmo35a9bDpbFEI0+qML0syWe2/mu0qjjG4wrjpbWU1e1LQAmAB3ZoteccSCtHIgMv
 nji79MYbpwF0DqfPnUmS3aSXYxkyn+fZEdBTrGmcCTzYt2BwcrPccYgsoG2qyyHTYd6O
 qhIYMA4yTU1enX7pqOVPZsEp4ma+vrerWbKqa+qSC8eR8jOiXbUerlP8gJXsrwFKv5Zp
 C8RA==
X-Gm-Message-State: AOJu0YxnYXIWsWDoO8zTbN0bmE0rLmmHpaCmYhnUvP/PM7vnxW9eyXWl
 XtvvrGXFZY8bvAE64e2crV32jprM7ScfQZWePio=
X-Google-Smtp-Source: AGHT+IGBCO0/9/MBN/RXBnjcgvjraMyaeDVfUmMsnnEUqKFrXwv+2XVmGJ4uhkn00XBFbf/kLulICQ==
X-Received: by 2002:a6b:671b:0:b0:780:c872:5df7 with SMTP id
 b27-20020a6b671b000000b00780c8725df7mr3948985ioc.9.1692480202893; 
 Sat, 19 Aug 2023 14:23:22 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a6bec16000000b00786f5990435sm1507256ioh.7.2023.08.19.14.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Aug 2023 14:23:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 06/19] x86: coreboot: Look for DBG2 UART in SPL too
Date: Sat, 19 Aug 2023 15:22:44 -0600
Message-ID: <20230819212309.1094440-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230819212309.1094440-1-sjg@chromium.org>
References: <20230819212309.1094440-1-sjg@chromium.org>
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

