Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5169107BCE2
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 21:56:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 40E438439C;
	Fri, 13 Mar 2026 22:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="jkIZJVx5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1C488438A; Fri, 13 Mar 2026 22:56:14 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F57B8423C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 22:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d7851e2cc4so1049688a34.3
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773438971; x=1774043771;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=WCc5ZKQIcRmGudNWsSFFmyWdTiXRTylPw8CZ724lRxw=;
 b=jkIZJVx5AJ62iN/JBW19Q3VEfK8vleOTbUIjEsTPo2iynRfShx0CjlFK9G/Vk9GQ44
 HS6aX5fjhs3IiAB2bS74Ht6zi/CgRGbrQ/7ugwWeEM88RDc9rDBjoZv19PZcLKWdUuO1
 VjdBOduFdQuef8EL6sR6BL8ep7RF8a0ypTeQWVpZmFGJSLPxTYelYKMs2MECnCVNUshs
 kb7hxW1AuCPIkI0M479Osu4kcoO7ND+AzrBgct1INRff4f5lVVGxccCdi7Et49TBLuFo
 laoykH/VpmkXMVkMCDULJVZVl0Kyu+/xtxSem9/JBwYGKjUSKvJEqVFb72rW+J/3FRGo
 ZnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773438971; x=1774043771;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WCc5ZKQIcRmGudNWsSFFmyWdTiXRTylPw8CZ724lRxw=;
 b=LI90EUUtjBzms2Ltrv3iIJrHz7L0P8oQY2MpTs/4QH3UMi/HQ33crbq8xKRgPd7tte
 yTqbhs560eKMO1FLy9H1iFNm3Ip8MNqE98Ppt3c3MIUYzoQRXdN8d1FpYb3A4QrCFxc4
 fhv6XyBgk2YwhecLCqO6Hzs++gBGZW9+EAOStKk1uxxqKcbUripXtgm1qzeVZpQn25bc
 IdYNsKjEmv6f2mDrv63eXC/qZcsGC9ecv3bF7KCeza+Lg9XD5rjhDPtDDRZrUDtzJnmX
 XQeToX249X0JUkfWA6n8uSXCyRD9Jj7PS26fSIG/pZTb1k5oFUBO+mlLbT18oGiMCd/8
 byVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkeP9Xtp0k490luw43pjyqEInK/DyongUL2TmVUSbcaqdO2NDLZyNl6BUt9YV4suIujL62jSo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0OsTEetdh0eWRK6vTcEVuwH4GAiaAZvEAuX2Tg3vZY1rCs6Lb
 MW32WfiCNjsYBrP9E6d7QYafOnglvd/+19ACBsJPm7IY/MxKq5ywZ4UIbTW5Dq6tGIPzVaGJD49
 Sgh/s
X-Gm-Gg: ATEYQzx5u27wP7jsMMAdLIRunpBtiRw5WbzfNn3E0bvtO4Pdn4kGWI4uwnApkHBVGqu
 23++S44HutXSOaQB55M3wyd6unKYsIo8oBUdTwruv/fN5xGOSLm+lef+SchFyvp/sPUs7YHkLgn
 79vqYtRD/KJ2846f5GLVqoj1rvq/Eh3eMGUvdBdqugcyQdRb5i/d4S/vg9Jeaw2k5XzWhs3dzQn
 kH97rpN4NXiLE5GbwIg7WR7TEc/EuCRS1TvQhAhaI/JIY9rKLvhS7YHXGZaVQcCB9hDcN20zT5E
 L3EsXap2ZGWP5WLFuoiQ+jCTBt3xKzZzB0+puOHO4w41ehE+auhODtV0WuTl/5YCvDnnB5ZC6Yi
 kQ+UeT6hCjzN3a92HaPGg/WprRMA7jFtvHoGkuCx+Q9pQcsXvWMlJkFvkTyjsJRAnYUoS727YxS
 3DxP//ylKMy3t0BaVnDbU+TjM3munJVHUzpeU=
X-Received: by 2002:a05:6830:6ac7:b0:7cf:cf6c:89a3 with SMTP id
 46e09a7af769-7d78234116amr3471782a34.0.1773438970784; 
 Fri, 13 Mar 2026 14:56:10 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:bf:9982:ff59:466])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ac8e5b4sm7432196a34.12.2026.03.13.14.56.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 14:56:10 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] pinctrl: mediatek: fix mt8189 MSDC and I2C pins
Date: Fri, 13 Mar 2026 16:55:32 -0500
Message-Id: <20260313-pinctrl-mtk-fix-mt8189-v1-0-607dd37fde37@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NTQ6CMBCFr9LM2kYKBpCrGBalTnHUtjgthoRwd
 6u4evny/laIyIQROrEC45siBZ9BHQSYm/YjSrpmhrIo66JSlZzIm8RP6dJDWlqytqo9S2UbY2u
 lbXPSkMsTY3Z/w5d+5zgPdzTpu/ZPML7m/Jj2GAw6ojTBOUqdCEwj+aPHJUG/bR+uEVqVqQAAA
 A==
X-Change-ID: 20260313-pinctrl-mtk-fix-mt8189-1f7cf61af74a
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1335; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=IG+3/26nCoFGQoPm1iRluiprT4j+els4wlAxje8OYi0=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBptIfYBBd7wAzlyRK2rO8TNn/d5S3IAmjWoDi39
 uZzyqHR+z6JAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCabSH2BYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/A/AAH/jQkkg7V27b9YsLoO/DJefs9U9/n8oosptL/DAp
 LPFduooTz7yrzDyNUb2MACB9UkJ72tSD5YdzuZWjuyQNZVeRAQVxwar+tlZjDRPHB+QMNwSMkgV
 +VoCdeYBvN1Oe3Ma1SKblpAO4YvjtRwef5+ALWNM+qvjAbS/GChIzfyQLKoCRsEsbsJajOMd+2u
 rt1yjRvujZJClFU1YCC1I8m6P/wBlm7G05wTMV72pTwCXft2IWs9yhnvSgagqc9CJJkw6WCxEXp
 jPCJFyCuOeIobI6we5SHJn/QgPk+sB3xBPxYi6ejGwaDUCzuRORx27wkyhAXfY3m3Hpfv42uSYM
 IlGg=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

When trying to use the SD card slot on the Genio 720 EVK, we found that
the pin configuration was not working entirely correctly.

It turns out that there are a couple of different ways to set bias
depending on the pin. One requires setting an RSEL register, which
hasn't been seen before in U-Boot, so we add a new pinctrl-mtk-common
function to handle this. Then we can fix the mt8189 driver.

Finally, we add some additional debug functionality to print the bias
registers when printing out the current pinmux state. This can help with
debugging similar issues in the future.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
David Lechner (4):
      pinctrl: mediatek: add handling for RSEL register
      pinctrl: mediatek: mt8189: fix pinconf bias
      pinctrl: mediatek: print bias info along with pinmux
      pinctrl: mediatek: mtk8189: set get_pinconf functions

 drivers/pinctrl/mediatek/pinctrl-mt8189.c     | 416 ++++++++++++++------------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 110 ++++++-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |   7 +
 3 files changed, 347 insertions(+), 186 deletions(-)
---
base-commit: f3bdde84af91b095a3f4ac07232c49b7ff13f7f4
change-id: 20260313-pinctrl-mtk-fix-mt8189-1f7cf61af74a

Best regards,
--  
David Lechner <dlechner@baylibre.com>

