Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D127C25B6B
	for <u-boot@archiver.kernel.org>; Thu, 26 Oct 2023 18:35:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2DF4787BBD;
	Thu, 26 Oct 2023 20:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="t0CrXQ+7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B00DD87B51; Thu, 26 Oct 2023 20:32:03 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39FE58763F
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 20:32:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7789cb322deso92889485a.3
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 11:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698345120; x=1698949920; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekCPf4teoD7xOYoQkvGBz4z3Ij4Yl1X7VWc1UYtOiwQ=;
 b=t0CrXQ+71SGVvs6cKZ+FLs4EtUeIxtHMP6ynsyVEBsBRlh5/r/XHSd9YydvJCv4ud8
 M1YQF5T6ZYc4AGnUUl9md0O+MpYwQ/XSOk71SdvNq0cRsPZt8dUaMA3mn4l1eK98sNQE
 XbuQRKzmGm3fE05ISisFSEQxZeAgOKwm/Qe/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698345120; x=1698949920;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ekCPf4teoD7xOYoQkvGBz4z3Ij4Yl1X7VWc1UYtOiwQ=;
 b=Jh19I/aMUdbh/3Ul8E2gg6Bvm6IpHOsPhBut5E2B5H/7vcpV++NuFh6SvWT6/N6k71
 zsf5GQpEo2uqdGvwZDgCq6lZt1+M6Rih2ZaIoOVK6hMobGnopClqCY6obKWI8KRGQ2rY
 FC1bSKOz7ofuwhdf1wL+23Wbq4Cplv8aJAlQSo5PqCzT9epZWpwVDx9KJfodmko7mqrA
 KadPxbL2q5EWCf6CCWbXjkq2hHgUSw46/eDr1Zmfnceb8YP+aKoNnBPEFTEB7MwwMv2g
 TI3jTHx8c3jqPG8c3WKrKMguov1WRslykdxIsuQxSkfX7Ie3RzpkCCGahwGnC7YZcV+Y
 5riA==
X-Gm-Message-State: AOJu0YxJuDftKlPGANxvd+lEEZIUgnZGSlA6JP9i5omlxAQupVD9VQXY
 ZDBtXOSIpwnMIIWXQzcm7wSjw0lT1HHgh+vCcMk3sA==
X-Google-Smtp-Source: AGHT+IGaYO8gE+B9J7L/F69UacOI/9c1fGpWx18dFE/JzYc0v7cs6hbkBB3TdrMmiDpP0GSTX0aJTw==
X-Received: by 2002:a0c:f3cd:0:b0:66d:46ac:2fbe with SMTP id
 f13-20020a0cf3cd000000b0066d46ac2fbemr442636qvm.16.1698345119874; 
 Thu, 26 Oct 2023 11:31:59 -0700 (PDT)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 az39-20020a05620a172700b00777611164c5sm5175623qkb.106.2023.10.26.11.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 11:31:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: AKASHI Takahiro <takahiro.akashi@linaro.org>
Subject: [v5 24/30] block: rkmtd: select CONFIG_RANDOM_UUID explicitly
Date: Thu, 26 Oct 2023 14:31:32 -0400
Message-Id: <20231026183138.636948-24-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231026183138.636948-1-trini@konsulko.com>
References: <20231026183138.636948-1-trini@konsulko.com>
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

From: AKASHI Takahiro <takahiro.akashi@linaro.org>

This option is necessary to compile any way.

Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
---
Changes in v5:
- Take AKASHI Takahiro's RFC and switch to select per my feedback on the
  ML
---
 drivers/block/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 048a6caef00f..b897cf1a3d1b 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -265,6 +265,7 @@ config SYS_64BIT_LBA
 
 config RKMTD
 	bool "Rockchip rkmtd virtual block device"
+	select RANDOM_UUID
 	help
 	  Enable "rkmtd" class and driver to create a virtual block device
 	  to transfer Rockchip boot block data to and from NAND with block
-- 
2.34.1

