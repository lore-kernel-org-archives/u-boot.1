Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83558C4167D
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 13:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5AE287702;
	Thu,  2 Nov 2023 14:50:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m8ZHqWk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 564518758A; Thu,  2 Nov 2023 14:50:08 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 834DE87702
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 14:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-507a29c7eefso1121611e87.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698933002; x=1699537802; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bve3ilxgivvp/liLMwyWo9dPFQSnNNhOES9b0SRCTto=;
 b=m8ZHqWk2WDlvJ9l934I56tjq5bwhmFzWPnf9Kku42P9Haw9+MUmUuAt+Kizk93js0q
 TChRKUzca/fiT8XC5tm1TEht/IIqfqhw3rJup8igv1VO4IxxiztECtpUDccY6ijmBAsL
 Qh7Zn7YBtHyZHU2aBMDavKLyFfw0Kln4CF5/C2QumiOWm0JB/IZx4qY3mZskzkLNZuqG
 zhbfhm+kti0ULLBdOgBH1i4X3svgTefGyNR32Nk5xCIoXuN6I9LZdWgG0fDWXzWBvwNj
 WDNi2J5VOOvviGiZ35RPauhGgq9DLiBHGkjOhIfIcZP3jeM8FtzvX1KuEYOPOUxIsiXH
 7Zqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698933002; x=1699537802;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bve3ilxgivvp/liLMwyWo9dPFQSnNNhOES9b0SRCTto=;
 b=rL9bD6ygxLvlJcPuQIGceCLpv9V8ZWht6y3NuDPNE+r6IcCelnLZdJdQzd1rodvm2k
 G6z6KuIWQecyYQOjVb8cub8FOtJ3M9Ketc9lX//epSto/PKm5fPiPwLTMHKnZ//jNbqn
 x7NfLRwDs4QJjsyvjEdPCwFbkfmNe7wZeQXbfpJ0UEcCjXWTXm5Nqvga0wyqPja7Ak/7
 GnKs29A0H1yrsar2OMHvCyVJceDdLn+RjhCUvzBIdf7dVkdzPOTmqMmh1NNO3CzFYbPj
 pkrecz67gzv+nowdBn7/fu5OdxiSs2WisFiTXfpbdxPIUTgwI65C/FcinuKjib8kgJWc
 1baw==
X-Gm-Message-State: AOJu0YxioTc2Z1h3SuMYOywoOmRxRjppbREWAgHCFrZ4M6CUghRKVeR9
 0+fY78OPXHwhMUc4QcRMQvv9iQ==
X-Google-Smtp-Source: AGHT+IHbiS+DQRWd5u1hPP6jEPfTOmtwD3OzDZGoh1C3oNmeK26CmPOar8xPdUEaHQyoUi/oPYhD7w==
X-Received: by 2002:ac2:5928:0:b0:504:3499:7c37 with SMTP id
 v8-20020ac25928000000b0050434997c37mr13737824lfi.60.1698933002543; 
 Thu, 02 Nov 2023 06:50:02 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:982:cbb0:4ac1:f109:811c:51be])
 by smtp.gmail.com with ESMTPSA id
 z19-20020a05600c079300b003fe23b10fdfsm2952913wmo.36.2023.11.02.06.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 06:50:02 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 02 Nov 2023 14:49:58 +0100
Subject: [PATCH] ARM: configs: libretech-ac: enable USB_DFU like in meson64.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231102-libretech-ac-fix-dfu-v1-1-112379165028@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAWpQ2UC/x2MQQqAIBAAvxJ7bkENofpKdDB3q4Ww0Iog/HvSc
 RhmXkgchRP01QuRb0myhwK6rsCvLiyMQoXBKNNorQxuMkU+2a/oPM7yIM0X0kStVh1ZawhKekQ
 u6t8OY84f7GhPd2YAAAA=
To: u-boot@lists.denx.de, u-boot-amlogic@groups.io
Cc: Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=912;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=mspt5Mz3KjcfMXyYuluNmxzIZK8UcxqMxfjBtNJeHOE=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBlQ6kGxcwzwFMHWAAPP2cCMby9s11ShzivKke8B
 5bOeHx7c0iJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZUOpBgAKCRB33NvayMhJ
 0fjEEACnPdku66thkBuf1OPxUhBIBfN8Y3eBvK05KM2GRgmKw6h4EpXHh+Jkh/j7NS2sfXZ1qMq
 48lU06yFbLNwrye8iTKGWY/Srgryuc8VQKgvUAOP3v5Wv7SfkFYB69pu1NZ722pjKsGIv3pTzhg
 ac8EpV8337KmwX7mPsSHYiIlp9ef1FqFZIhS6/O6AGS0sNHYFt/ULVAWH5paRvpR8RIyia6dC+h
 o/A0tm+IJg+ZjYqtrjCdyaZ2jvWZtRkuwoUZaIUts0bnr2n25lVA5lt9tmc0TMe12FSM0vZ5R/W
 adzHOmshLMHtG/M3CH21udoTxv9R+L5sfT73fMgf4NkxPawEZKR0wC3wjVXxEh7SunlSc78cyOU
 K50Wp7d2qAGzBvfvDvndMV6idmyaUPu+27753qZ0dX5bDVG9Qpq3UvVTOvarsirnRU+u+oGaJs4
 htYUZTCOzRHB/tJVvXNRm84SZfYdozICIYQW/rFeqYSZNoWBGEPVW4EBDgCGWP5FAH7TjKTd3pk
 16e96t6xK9rMqxQ23EbFqUrX4YeswSSGej4KpLnEi6fnbiKyaaFk4fPLCnSmFzq2lVC7s2Cu1Zk
 T1n2Vnd1S9MAb0KidhqRt5bCL0EepEuTvhc/mXgEKoaaV7m3DbBFVfosNV468Y8DZESV+i8qq+C
 jvGKDVVO2qkK62w==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

USB_DFU was added in meson64.h but is missing in libretech-ac.h,
fix this to enable DFU RAM boot for libretech-ac.

Fixes 4aa027b3f8 ("configs: meson64: add alternate USB DFU boot target")

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 include/configs/libretech-ac.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/configs/libretech-ac.h b/include/configs/libretech-ac.h
index bf20d31543..16239f2520 100644
--- a/include/configs/libretech-ac.h
+++ b/include/configs/libretech-ac.h
@@ -11,6 +11,7 @@
 
 #define BOOT_TARGET_DEVICES(func) \
 	func(ROMUSB, romusb, na)  \
+	func(USB_DFU, usbdfu, na)  \
 	func(MMC, mmc, 0) \
 	BOOT_TARGET_DEVICES_USB(func) \
 	func(PXE, pxe, na) \

---
base-commit: a803f87202aa48974bdff4d8100464a8288931e4
change-id: 20231102-libretech-ac-fix-dfu-dbd8109d552d

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

