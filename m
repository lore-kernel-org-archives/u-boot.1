Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDFFBC05052
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 01:52:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 933FD86A6B;
	Thu, 17 Aug 2023 03:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oPAsbn+E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB5DD86A2D; Thu, 17 Aug 2023 03:52:06 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 199ED86A3B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 03:52:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6bc9254a1baso6125925a34.2
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 18:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692237122; x=1692841922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2GxXK78KhD7PrQ4gihBHsh9L9b3dIF8D7r5cnJtySu0=;
 b=oPAsbn+EEbGftGsQJi47WniE6XAkOAll0F/6wFljD2MyeoDRqqzSL1lKT3/lyUzI5/
 afYwATmkYmf0pLKJ3SAczrGpPR4tlsQTNfA43nMpReR6Gx8J4yEWxuHR8yPXK4WM3CKW
 Y2tQu1OlTNROpTJrkfrE/aFaaob9vdG4TxtBQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692237122; x=1692841922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2GxXK78KhD7PrQ4gihBHsh9L9b3dIF8D7r5cnJtySu0=;
 b=T6j5dkTGnKP7d+iua3j+F19kxXfVuv2et4LaYdiqaq1dZHn52N1rWopeQf7g603Ge9
 Dlt61B3U54Z6sLLjK1LmFUr+sqDn/7EKhj7RkZZwd/ebobEDT45Taw5cTN2tX+HW+4Ae
 d2OVrRRGDrZbf1YJYU3Mv1DMpwpeydy1tkrm5P3vnOYskNmQK1m0TMzGyGZbAwgBcED5
 01nNF09hsoRrKJAgVcIUCmhvBBsjsqAjZ+mswHKTpEHKI+FjgH0KIfzzeseEk7m15Ivs
 aghgNNK83UoCSUkfo6WtIH5Gh1fg0iHt0sv5iXFg+GtHdK6enmh7EDu9HHmALo0yoMM5
 GYzA==
X-Gm-Message-State: AOJu0Yxo5WdZvoAAb5VmkVZVjjpIqfn1RFNV1ZZsjpUP/Z9fWRT6YGv4
 LxBq7oCFaw0rlOcM7GaClGjYPA+BOcvJ2FBmi50=
X-Google-Smtp-Source: AGHT+IELo6W3+db5Rn+L+wFEfK+wlae5JK0Ryx8N+UCk75iCA6D1KFe2rV+RRJtn4oOEC8vMDlj6kQ==
X-Received: by 2002:a9d:75c2:0:b0:6b9:a926:4a12 with SMTP id
 c2-20020a9d75c2000000b006b9a9264a12mr3731307otl.28.1692237122711; 
 Wed, 16 Aug 2023 18:52:02 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 l18-20020a0568301d7200b006af9d8af435sm6606854oti.50.2023.08.16.18.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 18:52:02 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Stefan Bosch <stefan_b@posteo.net>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
Subject: [PATCH 4/9] x86: coreboot: Look for DBG2 UART in SPL too
Date: Wed, 16 Aug 2023 19:51:39 -0600
Message-ID: <20230817015149.774847-5-sjg@chromium.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
In-Reply-To: <20230817015149.774847-1-sjg@chromium.org>
References: <20230817015149.774847-1-sjg@chromium.org>
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

 configs/coreboot64_defconfig | 1 +
 drivers/serial/Kconfig       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 55064d1ce66f..9f228420cfa9 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -55,5 +55,6 @@ CONFIG_SYS_64BIT_LBA=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
+CONFIG_SPL_ACPI=y
 # CONFIG_GZIP is not set
 CONFIG_CMD_CBFS=y
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
2.41.0.694.ge786442a9b-goog

