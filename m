Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF20C4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 21:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B94186053;
	Sat,  4 Nov 2023 22:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nnSVe4dZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAE3786958; Sat,  4 Nov 2023 22:47:55 +0100 (CET)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17C6286053
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 22:47:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-581e106fd25so326917eaf.0
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 14:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699134468; x=1699739268; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4ca4QZE4DLhqNH5nlxCMjVh8Cq6fEL2O97YoAILKcdI=;
 b=nnSVe4dZcNV4LuWw2DKihnShjE8CoN1puDWHzlwb7ivglPdsoYYU/UI0OhQ9f4QPZJ
 kv5R++QIlbgDqIJTfZa55xRaulYKse5EgSBZgTEHGTH/b+wFol87WPwzjwBbS71zthg/
 53+GzIEcDaCBOzWEImiBCrpVxXe+bLRd03U5n0fPJXPx7YhqOfe7aku+oOj5fcHwLr9x
 m+7ubs0GiVOlCDlT05L7h/RlYb36XHg7Kc9YggXE4QXsP8Oj1Kpm8EMJ0MENUelG0Szv
 3vscGDAQn/0mptYnwFJQM+bhIFs+1Az47PWnnpxEnUCUjDrYWVSUaa1Fxai4F9oIyxh2
 hTIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699134468; x=1699739268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4ca4QZE4DLhqNH5nlxCMjVh8Cq6fEL2O97YoAILKcdI=;
 b=lLc3JXbku3pVG+FswBIOWU1IlDTKUDLZ30fFnsXgJa3/TFmbIzPpaAXEzNFBVFCWoY
 QDfO8hEg9wJ6z8c0rylb4uEKhh92NaaM+YYg1asA2EB7VmacskxbdbuXHsD5PfZ7Uux/
 IbcIENjBW7ICqHKIqIlQqrtiDYIpzStXbVjb4HbJGErtCFPRxQE/8K5xc24gJY6P4yvv
 kDKVI3ROvsJNhw8E1r8lB67waXsMfydDaqNb7RvEj+cgvdixqb1y5nld2yOvYIhPzxMk
 Mem8cYV13+jK2NOServGLUpgaEngevMTmpnZ1LJzF0apd4xoA2gRhNvXSyunjX0SP6Lc
 VuFQ==
X-Gm-Message-State: AOJu0YxJnH7hW9jdQm74be1bQbqEuA6+00hVOzwl4cIE+32Lz5IA9lyF
 xw68M+ZWIbydJpB+/BgaptKS8P8tRj4=
X-Google-Smtp-Source: AGHT+IHGB3iEWpye9LYw8d+blKs0sYRMoh0z33N1w9T6eYk191wRKskQwou4/cnIuBHEWoI3TJUngg==
X-Received: by 2002:a05:6359:2a9:b0:169:4a36:5ac9 with SMTP id
 ek41-20020a05635902a900b001694a365ac9mr18527109rwb.0.1699134468299; 
 Sat, 04 Nov 2023 14:47:48 -0700 (PDT)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:b4e9:3424:1f72:d6d3])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a814908000000b00583e52232f1sm2462269ywa.112.2023.11.04.14.47.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 14:47:47 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: u-boot@lists.denx.de,
	Fabio Estevam <festevam@denx.de>
Subject: [PATCH 1/2] pico-pi-imx6ul: Connvert to DM_SERIAL
Date: Sat,  4 Nov 2023 18:47:42 -0300
Message-Id: <20231104214743.308722-1-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
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

From: Fabio Estevam <festevam@denx.de>

The conversion to DM_SERIAL is mandatory, so select this option.

Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 configs/pico-pi-imx6ul_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/pico-pi-imx6ul_defconfig b/configs/pico-pi-imx6ul_defconfig
index 1eee1e6c2ff5..3af968d55128 100644
--- a/configs/pico-pi-imx6ul_defconfig
+++ b/configs/pico-pi-imx6ul_defconfig
@@ -70,6 +70,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_PFUZE100=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_USB=y
 CONFIG_SPL_USB_HOST=y
-- 
2.34.1

