Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AB12CF58F5
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 09:06:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F476893A8;
	Fri, 20 Sep 2024 11:06:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JIdpUnKF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0815E893A6; Fri, 20 Sep 2024 11:06:20 +0200 (CEST)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E21A893A7
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 11:06:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bigunclemax@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5365d3f9d34so1886856e87.3
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 02:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726823177; x=1727427977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/9tcTeuFybe1XqzU+oBRy8oBla7aW9mZeoPYlFHJck=;
 b=JIdpUnKF3HMXpf8EJh3MIXB/OrEo72QBgzmsrtytHxkHkCi6EIGszrJ2YoVyYUx0GP
 lzkHbFTMVGRj7KurFuszvFRPh1B1WygTXxJ57qSDSSvcOiFV4LqY3F41qxBTkeWe/u2W
 ZiEYEJlnh9ElNjnWE9gODad1/Nr/1v9RLmMSPadGGPyjGarz1ekKivGi8aiXgbOR0Lse
 H37jePsPVMmAgvgT79HqBek4Zvi6oaWHPz05XNsJo+lA4BwVnygdOK7N2Rx1G4FEpxea
 rchho73ofY3ER9fac+f/r6RhdDsr5ptCLUWudg4TS+cKQbBdFxKA0rFvYYexVOo6M1y8
 COqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726823177; x=1727427977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J/9tcTeuFybe1XqzU+oBRy8oBla7aW9mZeoPYlFHJck=;
 b=qgS3uOqKGfsvi3eAlU/q8BJRPt/kL1hQmfw+XPURVa5kRrA0qd2lopZ1Zg0OTqhFfE
 cgY0rjD3y6NEariW4c/XIqjM7vFPrQvvyKyPyGYf2OoKHQwSklIQK6WRAuR15QCbwcbs
 HUTQbPKXpX+jXC2Cmu3l7IcIrF9YC+gzqDVZ/4NZ1wYejhHSb+OjODBT4r/T+fbz6V71
 8tRbZAWNZgwQ327ST0ExVVPldVswQKE2HBwjbyH0yW400E8KFeWCmVUlvAG8eDyqvPdc
 Yw83ymniB0XGjlClyn49kw+AUgnXGgkuZjz3tjrPmJk01pPJcpVA+5h1sEyHjwT8Jam7
 TrMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdMNe/akzWFzJTNAPpNCkSap6bLyVdKdKDZtFB9tiPyoQMuBS9Op/ZvCDlxSgDnRVmIiUhalk=@lists.denx.de
X-Gm-Message-State: AOJu0YzsfT/S1wH6N/FPJFLDsh6tvEtTZhylXLbZl8mOLDy278giymv8
 3em0bLiTR7DqvR51UYEiqDkDyQ4GSSu4YLGLyL59Zu9wTpluI0nW
X-Google-Smtp-Source: AGHT+IH2PqlQO5EdGqEv1sHrd5+ATkQB12Bn+ci0QXGj2b36KaTMQVSm35zXkTH+rGeSbdUfkkebdA==
X-Received: by 2002:a05:6512:39d4:b0:535:3dae:a14b with SMTP id
 2adb3069b0e04-536ac2d6610mr1112227e87.2.1726823177173; 
 Fri, 20 Sep 2024 02:06:17 -0700 (PDT)
Received: from wpc.. (host-95-152-62-174.dsl.sura.ru. [95.152.62.174])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-536870a88cbsm2088682e87.222.2024.09.20.02.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 02:06:16 -0700 (PDT)
From: bigunclemax@gmail.com
To: 
Cc: bigunclemax@gmail.com, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH v1 2/2] configs: th1520_lpi4a: Enable CMD_GPIO,
 DM_GPIO and DWAPB_GPIO driver
Date: Fri, 20 Sep 2024 12:05:24 +0300
Message-ID: <20240920090532.280504-3-bigunclemax@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240920090532.280504-1-bigunclemax@gmail.com>
References: <20240920090532.280504-1-bigunclemax@gmail.com>
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

From: Maksim Kiselev <bigunclemax@gmail.com>

Enable GPIO command and DWAPB_GPIO driver for LicheePi4A board.

Signed-off-by: Maksim Kiselev <bigunclemax@gmail.com>
---
 configs/th1520_lpi4a_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/configs/th1520_lpi4a_defconfig b/configs/th1520_lpi4a_defconfig
index db80e33870..bcb22730be 100644
--- a/configs/th1520_lpi4a_defconfig
+++ b/configs/th1520_lpi4a_defconfig
@@ -4,6 +4,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x3000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80200000
+CONFIG_DM_GPIO=y
 CONFIG_DEFAULT_DEVICE_TREE="th1520-lichee-pi-4a"
 CONFIG_SYS_LOAD_ADDR=0x80200000
 # CONFIG_SMP is not set
@@ -49,6 +50,7 @@ CONFIG_CMD_BOOTMENU=y
 # CONFIG_CMD_LZMADEC is not set
 # CONFIG_CMD_UNLZ4 is not set
 # CONFIG_CMD_UNZIP is not set
+CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADB is not set
 # CONFIG_CMD_LOADS is not set
 # CONFIG_CMD_ITEST is not set
@@ -60,7 +62,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_VERSION_VARIABLE=y
 # CONFIG_NET is not set
 # CONFIG_BLOCK_CACHE is not set
-# CONFIG_GPIO is not set
+CONFIG_DWAPB_GPIO=y
 # CONFIG_I2C is not set
 # CONFIG_INPUT is not set
 # CONFIG_DM_MMC is not set
-- 
2.45.2

