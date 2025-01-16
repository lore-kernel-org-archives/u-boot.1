Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68945C02188
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 23:02:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65E3680790;
	Fri, 17 Jan 2025 00:01:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Dh7tMSrU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EEA28022B; Fri, 17 Jan 2025 00:01:41 +0100 (CET)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com
 [IPv6:2001:4860:4864:20::34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4A848073D
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 00:01:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2addd5053c0so829884fac.1
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 15:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737068497; x=1737673297; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rrgy3baiLJxl+ZSeXLdCueyRWZTgW85ExpoRH31UxJk=;
 b=Dh7tMSrUm042Vvt5pBLgqPMwoeAHeh+EKQXxRC6sWf9cogth/7w+R8QQ30+K2YoYq1
 Bz0mEymoICcKzEhvSRtz3bCALmcUQT7ulsLM9h/iaGJ98BL9tolt/zmM84pGhU8381Mr
 OrjzWtM+nPFFDXkf3JvFSrZ0XPRtvfYDps7M44abt99GLe6wRwJQ8i8c9346bN4pH2iy
 rf+7JFnZLUlFntUxjMAm1dEpDkjjB9Z/kgQ0P7cJjcywAtFtPS3870V+rl6/JC/ssOzu
 iR3I49reOBg+zUusep2MoAcoReEJ0EWj91usBc7EIYkfZh/emn9SoOCyFKTVdZqpvBTd
 suLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737068497; x=1737673297;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rrgy3baiLJxl+ZSeXLdCueyRWZTgW85ExpoRH31UxJk=;
 b=Ri3ry/NYQxyuJnNtEeZ6T36qTp2wuihh35SP3oVpccTsBFAoRedaleDbWxA00pn6e6
 OnuY81kfoWL3cvT0hCJSJ4czI+hfN2A5RHrKqAGO2YorE3V+DKwkEsbIwzSPQosrI4dw
 r7jf+Na/Q8OjmQe1QMs2chHhGdLh/9olt/313C9ar5BCHaIH22yTr+CUu8Kv9tuHMtdY
 oM5Y/eO9xhAY6b7fO0W4Vn53qt/im+qzPGXLlJq2iT2TnILz5WxNPs1qRqtByHrb2B6y
 8VEVMT6W7UMZtLsg5FrzmJzTYTumTa3ODXJIikCnWwEoaTn1RNUJMGZzpeQ3BUEebfk9
 xCkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIVYupBHBwE5weRqOnBgXTjrUIO0oDle47dkUXATkf06iRgnDXFZVzq+YrmsJodn288RE6spQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzD9yjfVJbActo+4eOauHGb84MvcIJH0U+r7/LgZ7aAyTpSi7kX
 WzglCtVHEmBfDA43euUPIH3kaOXsxhgHIq0Tt3FvHmpecCCTudI5hOCkAOM7HvE=
X-Gm-Gg: ASbGncvp8udmoLxIB2wJTgP6tmCnTU2xvIaWOFPqZBj+xv3z3tkkmOGdB/jht+MZaqy
 3BaonXymjs1sIuuPqFZccBXYqjOwbAOVPh2GBM3wdNuJpLehLuqzBLfjWqXEEU08ttOdvpFlZ+S
 eh1MV25ic67sMYMkA1dBVyOHXyozXi6w7DWeRXMJMeyWGOlc6Zdw1sJAMIjEPf5kIsp5UQNZXwZ
 yEjm+Ftcv07RUD8w/M1Jup1qQnTv1lcWUdA1mXJJdqP+A+x/rZGrl0c9Xh7kul1FcM=
X-Google-Smtp-Source: AGHT+IGkV6SbPs4g16SrmtZYcYUCKZKPC1omJ4wyW1Prz6WKTBNhMFV+//o/xALLv1EZMac4ZPbJPg==
X-Received: by 2002:a05:6871:d10c:b0:295:eb96:9fd4 with SMTP id
 586e51a60fabf-2b1c08bfdddmr396950fac.11.1737068497741; 
 Thu, 16 Jan 2025 15:01:37 -0800 (PST)
Received: from localhost ([2605:a601:a0f4:b000:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2b1b90d0acdsm588976fac.50.2025.01.16.15.01.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 15:01:37 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de
Subject: [PATCH 4/7] configs: e850-96: Enable Standard Boot
Date: Thu, 16 Jan 2025 17:01:27 -0600
Message-Id: <20250116230130.3337-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250116230130.3337-1-semen.protsenko@linaro.org>
References: <20250116230130.3337-1-semen.protsenko@linaro.org>
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

Enable Standard Boot on E850-96 as documented in [1]. Along with
corresponding changes in the default environment and properly prepared
eMMC partitions (ESP and rootfs), it makes it possible to boot Debian
rootfs automatically. All boot methods were tested: efi_mgr, efi,
syslinux and script. The preferred boot method is efi_mgr, which relies
on the configured EFI variables (stored in /ubootefi.var file on ESP
partition), which boots either GRUB from /EFI/debian/grubaa64.efi, or
systemd-boot from /EFI/BOOT/BOOTAA64.EFI. Currently used boot sequence:

  U-Boot -> bootcmd -> 'bootflow scan -lb' -> efi_mgr -> GRUB -> Debian

[1] doc/develop/bootstd/overview.rst

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 configs/e850-96_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/configs/e850-96_defconfig b/configs/e850-96_defconfig
index 1cae252175be..5facd418260c 100644
--- a/configs/e850-96_defconfig
+++ b/configs/e850-96_defconfig
@@ -16,17 +16,15 @@ CONFIG_ENV_OFFSET_REDUND=0x10000
 # CONFIG_PSCI_RESET is not set
 CONFIG_EFI_SET_TIME=y
 CONFIG_ANDROID_BOOT_IMAGE=y
-# CONFIG_AUTOBOOT is not set
+CONFIG_BOOTSTD_FULL=y
 CONFIG_DEFAULT_FDT_FILE="exynos850-e850-96.dtb"
 # CONFIG_DISPLAY_CPUINFO is not set
-CONFIG_HUSH_PARSER=y
 CONFIG_CMD_BOOTEFI_SELFTEST=y
 CONFIG_CMD_ABOOTIMG=y
 CONFIG_CMD_NVEDIT_EFI=y
 CONFIG_CMD_CLK=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_PART=y
 CONFIG_CMD_EFIDEBUG=y
 # CONFIG_CMD_DATE is not set
 CONFIG_CMD_RTC=y
-- 
2.39.5

