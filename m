Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A03BC4707B
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 15:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD7987BA9;
	Thu, 18 Jan 2024 16:06:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DEJxLP+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9DB05878D3; Thu, 18 Jan 2024 16:06:55 +0100 (CET)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com
 [IPv6:2607:f8b0:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8372E87BA8
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 16:06:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-5cdf90e5cdeso1894088a12.1
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 07:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705590412; x=1706195212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcua5DKHfnyz1xVAasRrtvomL5R5XxZHWurDgn+/X6M=;
 b=DEJxLP+zG93e4TWzJ83VsC9QCKoSM1T2nSc0wKIsCZ/eI75zYUkrA1oTnG2uP1+oqL
 OxbRAgu8vdrj0ygdIJZJIcHUIFLeLK7oaDzsWNOsjbjKCYRudVr9sLfuHsxuEJcC/d42
 r1ge5s1YtMQWyg6uQPIoj4H+6pJEAkz6jkv4NytxVHd8NBmFz8Ge9oN3APtff9PneYDZ
 VZ0DYD0hJ2k2jzzanmFteyInZHmAiIFysmEvPxruYw0DTyrtbNMelf+1kkh+MBl36MRb
 L7oYcR08vHQ78ugW7MIZVSn0JNS8B6yPW4kWBIioOdKVqjYx7Pzmox+Rbn583jpatoRL
 4lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705590412; x=1706195212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kcua5DKHfnyz1xVAasRrtvomL5R5XxZHWurDgn+/X6M=;
 b=GrbF4SEupQFHtMfH0l13lfd5Oh+L9eES9brTb5sJse83TR65hwYqlwQ3hi5Txqnzmw
 040TyhdJxbFE5c3x5wMwyGBT1oss/V9VoniRSppENeybl3WL66iTXUYPkPbEpffiyNZS
 aQJBQROCuZELriCMoTZcU/1aCqyHUkaryvWs2RzxVRPsT6iA4cVG5j8Ws4H6ZZhNoDK+
 XKPkFiKHLeJYErrSYrxpUlNoEbD0i38phuz11rHOKbOf/9PdjAWsKy4zrmhALRM2n/xS
 9tjXy68ZNEjymvinbEJxgK7XJOlYhk1zHJC6rSGvtVzW8JAF0T89kuzDChdfcxrqwGCy
 aY4A==
X-Gm-Message-State: AOJu0YwNR8wRvepcYvBzsf2oO/nfP/QjkgQjvUnGZtNgL+jC2Wif8ZId
 xplK4pzwGfmry5zTtzK+MzZ13vWBqSZUN8gAu5alL30WuOVzBrWB
X-Google-Smtp-Source: AGHT+IGBv5Y5KB+G6UMs6pb8nZqjorGzkWpVKvKdheypfQAGxQ5wPz0AihphUSdTmJ4lrJ3+E6zkHg==
X-Received: by 2002:a17:90a:b888:b0:28e:625c:5963 with SMTP id
 o8-20020a17090ab88800b0028e625c5963mr1771244pjr.0.1705590411854; 
 Thu, 18 Jan 2024 07:06:51 -0800 (PST)
Received: from fabio-Precision-3551.. ([2804:14c:485:4b61:a109:42dd:8789:4db3])
 by smtp.gmail.com with ESMTPSA id
 oh12-20020a17090b3a4c00b0028cc9afaae9sm1930417pjb.34.2024.01.18.07.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jan 2024 07:06:51 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: sbabic@denx.de
Cc: uboot-imx@nxp.com, marex@denx.de, thomas.schaefer@kontron.com,
 u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] arm: imx: imx8m: Enable the SError exception
Date: Thu, 18 Jan 2024 12:06:40 -0300
Message-Id: <20240118150640.3802089-2-festevam@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118150640.3802089-1-festevam@gmail.com>
References: <20240118150640.3802089-1-festevam@gmail.com>
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

From: Ye Li <ye.li@nxp.com>

To work with commit 2f3c92060dcd ("imx8m: workaround ROM serror")
we need to enable the SError exception and install vector in SPL.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Reported-by: Thomas Schaefer <thomas.schaefer@kontron.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/mach-imx/imx8m/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 328c3e388051..eb0488a9e8bf 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -13,14 +13,17 @@ config IMX8MQ
 	bool
 	select IMX8M
 	select CLK_IMX8MQ
+	select ARMV8_SPL_EXCEPTION_VECTORS
 
 config IMX8MM
 	bool
 	select IMX8M
+	select ARMV8_SPL_EXCEPTION_VECTORS
 
 config IMX8MN
 	bool
 	select IMX8M
+	select ARMV8_SPL_EXCEPTION_VECTORS
 
 config IMX8MP
 	bool
-- 
2.34.1

