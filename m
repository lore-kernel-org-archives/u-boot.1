Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 995A4CE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:01:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 552C686C0D;
	Wed, 20 Sep 2023 05:00:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fyTgkOtX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8131586C33; Wed, 20 Sep 2023 05:00:40 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 786E686B27
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-350fbd09d8bso162305ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178837; x=1695783637; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FVjDlaMEGmgrTrgSxx8lH+eKp/yaVMLOYnuPlZOv5yw=;
 b=fyTgkOtX3XlWgas48JLolOY3xMDOi0LWeLzc5FAVK3pLzD6Ov+ryhRyjaDPH/SQRDC
 uBrQDpj378WI4fhQPRmnyzgUt1p6v70vIu+K1Fk/RGrL8hxSTR9B/F2uFmFswl11sh64
 6vVN2EzwzvDdQ8+ZZ7Xgzx0tJRdypj456mkuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178837; x=1695783637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FVjDlaMEGmgrTrgSxx8lH+eKp/yaVMLOYnuPlZOv5yw=;
 b=bjwDIc2loOEnlXBbn1bXUZ2hRJnf3iGBp0ffGAl5rD3cB2vUqb1hJIWnsNG7SE7r0u
 0Ca+sb2A8hP9K39G1oa7O1eiU7EZalez3GR/qqs9Nyq0mRdY6xkOte8hATziwkUk5aCZ
 XZLgxt5nfIcLVhq9vFKxpO4+jT/TvAkRnPeutHo5o1pD+sM+k90PYADKnA7/G0cxw7tl
 ahVGg4QsigOPtKPYMJhoa2HHU3kBypdTproyTLahZOEPZMA1NX6psjxgKnipLLtcq0XM
 rLKwTHL/tM0/jzrFqBnBEMCBqe/eLvRP06npgl1T9jJUE1EEi5YQy8rQQqFV65sGHvfQ
 4+8w==
X-Gm-Message-State: AOJu0YzMl2Sw/GOD+rYjFADsSyk4iOl4RuBP/Yql8mNy5ZgLmEAl2Gzz
 3/3cO5zFzVPIldULJr59RVfjHjacwneDuyclGyU=
X-Google-Smtp-Source: AGHT+IFn1kHvYJyhbd+a0vXZ58MjyH4N62VCKg0/0JOxjHLYY806BhHeZuM2iP3061rV93WlH15MHg==
X-Received: by 2002:a05:6e02:1522:b0:34f:e5cc:43fc with SMTP id
 i2-20020a056e02152200b0034fe5cc43fcmr1999948ilu.17.1695178837120; 
 Tue, 19 Sep 2023 20:00:37 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 06/20] x86: coreboot: Look for DBG2 UART in SPL too
Date: Tue, 19 Sep 2023 21:00:07 -0600
Message-ID: <20230920030027.1385833-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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
Use the DBG2 technique there as well. This allows coreboot64 to boot from
coreboot even if the console info is missing from sysinfo

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

Changes in v5:
- Correct 'teechnique' typo in commit message

 configs/coreboot64_defconfig | 1 +
 drivers/serial/Kconfig       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 5623197f6be2..e8165961c199 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -54,4 +54,5 @@ CONFIG_SYS_64BIT_LBA=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
+CONFIG_SPL_ACPI=y
 # CONFIG_GZIP is not set
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 7ca42df6a7e2..27b4b9d96507 100644
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
2.42.0.459.ge4e396fd5e-goog

