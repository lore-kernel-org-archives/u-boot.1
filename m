Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9799AFF4932
	for <u-boot@archiver.kernel.org>; Mon, 30 Mar 2026 09:00:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC38583F5B;
	Mon, 30 Mar 2026 11:00:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PtKIhfuf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF9B83F5B; Mon, 30 Mar 2026 09:59:59 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A22583C5E
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 09:59:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fra.schnyder@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-486fe36cfabso25230655e9.1
 for <u-boot@lists.denx.de>; Mon, 30 Mar 2026 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774857596; x=1775462396; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=98wB78cT0U3iaQkHLmSqdNAYPyR1x6/1ECkXfDw4WS4=;
 b=PtKIhfuf4bJvWkK9Bgd+W8Ugcjojt41j1gEX/bk6k9uePTHO2sKGu4L6i66I9dDE7d
 PibYzYWn58sdbxy9uP0wYQJxf4/kpe6G+y2GrRt1Dc3uzEJmXCTO226gGMhxBcppnaOY
 sKx6+K+50v/FM5DX6fe0sqU9Gx9MvjvaC/Awg1tqj0JOWxFeE7WTx2+J9xXaM+U+YiVb
 cuTsCxcgkanTN9efKy0/7U6pKn05Lm2lS2BcG2GT3XLZhdCleUMqVUoYFVWE8fJBW81Z
 ljDXYk4Lef/egGgFpFyOu9L55gdRDkAImlpYjbNAABiZhqEM36VFJ1K597wT0FwxnDsr
 LfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774857596; x=1775462396;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=98wB78cT0U3iaQkHLmSqdNAYPyR1x6/1ECkXfDw4WS4=;
 b=B1aw0cgxdVLIhSlhOK9Mv5ST6Ueu+Gcm/blbBStA24hbyoBPsh75B9hdtddHtlzty4
 iXsbdysgf8JPQ/B7uiOu4iIHyLdbUyyCm82vqB7LqO1TMBM9ooVMQBXMb22YMZ8uThj6
 14R5qHngTxFxNGcFmfavApCDEmYmBv9UhLh5GM6uhaAP/A63BKZ/GsLisnWPfSo9e2zX
 kKJgOGUqc5LC+zImVbhVapMgg+jz2HYOVzVHixW7teepo3tYwU5Qotg1N5pyOG48cqDV
 lvWHFt0xVTDznjwbeTFW9LW2LdvNEfV76FjGCT0xzckfZ8Yi/9rL5I1etB65k/BJWpD6
 dURw==
X-Gm-Message-State: AOJu0YyFZoGQHiEJZ2ro80NkzY0pfaqDNTNUOxQYOZXdzPV72wXc7QCA
 PAPuktO+udn692WzShg9bDN6tAxMYiktdK+1SJjHSrq3D4t4O2psGKkpJPmmUFN7
X-Gm-Gg: ATEYQzzCmZVP2W1K3aG22YFia1TmE5XP4iGHVdM8Jysl0b+O0nM8r442eB6p3YW09ws
 ixbUzUL/C48w1BTVhtizzKDUT/RLrm1thi5fjg/ivwMeEngcbvSjbHj1mZLMNsMfeelYbQ5mrL+
 uWNSJ3CUgRp9ldqPH0JD94hgpDx0tIw9ldIYao+YB8MqviRgMAaCCVPDVt73ZEn6wdr+FyTlecb
 iSXyTQmmVhLz5O3ERcCl1OHvc4No32F2OXxkIxzdGw4fAGbSUvqSkClyqBGDeUHI2MfWroGKfTD
 wBERqDZsxSp4U618mHnRsMtTiVxkig8UsflRzHQJUNROQ3ie8dgVfUDhko2ugrdl1EnQzYmxw4o
 UybPcXMkNQXlMtwCCJKEGx1gGhCm3JrN1PqT3SNaofwddIfxt+ZtvpVuBplpsd+iCizwfxcKW7F
 S8mJz0VYsVESpz4/PPzkzDz8FqXLazDlP+ZdkW5VYPuxQ6eulUBnTyhSFJO9KebXs68oze5Gu7D
 dsk/ndSb+q3O92HVQ+EYQ48SJ1LcaNGUSCoiUcRypMpd+BMtsPjZCOEuBd8ycb/nGZn5CEUqlDv
X-Received: by 2002:a05:600c:310f:b0:485:3cef:d6ea with SMTP id
 5b1f17b1804b1-4872911bf69mr174311555e9.13.1774857596112; 
 Mon, 30 Mar 2026 00:59:56 -0700 (PDT)
Received: from [127.0.1.1]
 (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch. [83.173.201.248])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d49c18sm257298055e9.14.2026.03.30.00.59.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 00:59:55 -0700 (PDT)
From: Franz Schnyder <fra.schnyder@gmail.com>
Date: Mon, 30 Mar 2026 09:59:42 +0200
Subject: [PATCH 2/2] configs: toradex-smarc-imx95: Add gpio-hog support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-smarc-of-upstream-v1-2-c5b8cab32a22@toradex.com>
References: <20260330-smarc-of-upstream-v1-0-c5b8cab32a22@toradex.com>
In-Reply-To: <20260330-smarc-of-upstream-v1-0-c5b8cab32a22@toradex.com>
To: u-boot@lists.denx.de
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Fabio Estevam <festevam@gmail.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>
X-Mailer: b4 0.14.3
X-Mailman-Approved-At: Mon, 30 Mar 2026 11:00:28 +0200
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

From: Franz Schnyder <franz.schnyder@toradex.com>

On the SMARC iMX95 the WiFI UART and JTAG signals are shared. The
WIFI_UART_EN signal is used to select between these two modes.
Currently, there is no hog present in the device tree but the
configuration needs to be added, as once the device tree comes from
mainline Linux, a hog will drive WIFI_UART_EN high to select by
default the UART function during boot.

Enable CONFIG_GPIO_HOG to apply gpio-hog definitions in the device tree.

Signed-off-by: Franz Schnyder <franz.schnyder@toradex.com>
---
 configs/toradex-smarc-imx95_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/toradex-smarc-imx95_defconfig b/configs/toradex-smarc-imx95_defconfig
index c8da431d1c7..61abeff1afb 100644
--- a/configs/toradex-smarc-imx95_defconfig
+++ b/configs/toradex-smarc-imx95_defconfig
@@ -125,6 +125,7 @@ CONFIG_SPL_FIRMWARE=y
 # CONFIG_SCMI_AGENT_SMCCC is not set
 CONFIG_IMX_SM_CPU=y
 CONFIG_IMX_SM_LMM=y
+CONFIG_GPIO_HOG=y
 CONFIG_IMX_RGPIO2P=y
 CONFIG_DM_PCA953X=y
 CONFIG_SPL_DM_PCA953X=y

-- 
2.43.0

