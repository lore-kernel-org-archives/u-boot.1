Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E94EEC4167B
	for <u-boot@archiver.kernel.org>; Mon, 27 Nov 2023 13:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C894877A2;
	Mon, 27 Nov 2023 14:01:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GJpkfRso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A29F7877A6; Mon, 27 Nov 2023 14:01:49 +0100 (CET)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2F2A8778F
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 14:01:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-50ba75e33f3so3099221e87.2
 for <u-boot@lists.denx.de>; Mon, 27 Nov 2023 05:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701090107; x=1701694907; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wS8emmvCMU5NvTrZwE42tTJsOwY0BwQLAa0cBGb2dSA=;
 b=GJpkfRsoXTP0IHmSsSSakapZb8Gq0wSyzX6tGH4vUoMRSzaGoaaY6Zzn3QHbkfNivo
 c6LJZRhE/HoMQfKwdcW0LeciGGLJJcXQIo/HR7xl+Cuw26FhMH8MiPQoXhwEFT2XSJFE
 AK3tZkAEs2cJxWP0uM124IhFG05ZKOYeB1ECZ/Z5zqy8gOXgoX02uCTSquPIJAoBAJTW
 ce1vdH+CztOmyPzSeE34S14KngADivDZh7fGXU/gIlwRZuho3P5i1xVWChKNJ2MdPle+
 FNT3kP0fy0x2nRIGrpgfueprGSbUZBGOSgJ3Ln6r81Ny036a5XdyvNoklxPsatBKtNlz
 S/xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701090107; x=1701694907;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wS8emmvCMU5NvTrZwE42tTJsOwY0BwQLAa0cBGb2dSA=;
 b=P0aZZ6uGuU0ABmL/UUqwzXBOWs1tG2D0P8pJQ+bQVv4yVKaXdWPZ3vueNRfkkbdK86
 X+p1ouaOMQm2/8E8qp1CMb9Y7k1/ShLCmvmJSSiqIOtb5pZperEdQEMbx4b+gLQb7GMe
 fgJJ4HLHq96DQGRqHGwPGlX0ya4PPDhacEikchYCMlBZfK1BqLNorx3usv6eWXbTS7QB
 wOFTLdX+tFciqXDLS3+eUVIEgnr9Nmni0L3g6QmdjH6NxNg9G3Qbz0OZ35x/Qit5p+PS
 USc+xDJSaHV6l0T2uFN324qF51txQT/UnzD1JvrbNGEOufBP56pLbbp0Pwnm0mx+Fscc
 9h7w==
X-Gm-Message-State: AOJu0YzYTyZFlcAnOKFiRFeF8Kf9I2nT9tpi4dK6NSkUdYZVa6gPZoMG
 cqoQkhdzLLI8VIL+yH7DTYXmTGlbT1zslhLwAHMhPA==
X-Google-Smtp-Source: AGHT+IFFucWno3L+lIcniY9/82tEvXI6FTJTm6vLW79MWZycC8I/z6pHthyF7RazWsJd2cxRmE8kig==
X-Received: by 2002:a05:6512:3445:b0:50a:26c:cabd with SMTP id
 j5-20020a056512344500b0050a026ccabdmr4361717lfr.19.1701090106323; 
 Mon, 27 Nov 2023 05:01:46 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 f16-20020a19ae10000000b005092b887ba2sm1482489lfc.201.2023.11.27.05.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 05:01:46 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: pbrobinson@gmail.com, ilias.apalodimas@linaro.org, trini@konsulko.com,
 goldsimon@gmx.de, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv11 42/43] configs/linkit-smart-7688_defconfig: increase board
 limit
Date: Mon, 27 Nov 2023 18:57:25 +0600
Message-Id: <20231127125726.3735-43-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231127125726.3735-1-maxim.uvarov@linaro.org>
References: <20231127125726.3735-1-maxim.uvarov@linaro.org>
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

Increase current board limit to fit new IP stack.
mips:  +   linkit-smart-7688
+u-boot.img exceeds file size limit:
+  limit:  0x87000 bytes
+  actual: 0x87184 bytes
+  excess: 0x184 bytes

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
---
 configs/linkit-smart-7688_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/linkit-smart-7688_defconfig b/configs/linkit-smart-7688_defconfig
index d31f1ab3e0..1b24a70b67 100644
--- a/configs/linkit-smart-7688_defconfig
+++ b/configs/linkit-smart-7688_defconfig
@@ -22,7 +22,7 @@ CONFIG_RESTORE_EXCEPTION_VECTOR_BASE=y
 # CONFIG_MIPS_BOOT_ENV_LEGACY is not set
 CONFIG_MIPS_BOOT_FDT=y
 CONFIG_HAS_BOARD_SIZE_LIMIT=y
-CONFIG_BOARD_SIZE_LIMIT=552960
+CONFIG_BOARD_SIZE_LIMIT=553472
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
-- 
2.30.2

