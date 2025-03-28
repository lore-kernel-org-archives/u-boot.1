Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0709C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 08:15:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3D418144A;
	Fri, 28 Mar 2025 09:15:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XFLonEKE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E9A281DCD; Fri, 28 Mar 2025 09:15:52 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B83781273
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:15:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43948021a45so18548265e9.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 01:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743149749; x=1743754549;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vH+fgdNOoSdWXdWi/D5JtGFXA1M/x4TRSLmdOXb5S60=;
 b=XFLonEKEzYM764x7mI5rLu5RTShf3Mqg+FYqklEJi/I2P5nC7CQhDPsRV//zh8uHfp
 odrZvGjUHiij4C2r/F+0tCu/bJ7IE4ZqH3bZNVinnjlqBw6ESJQycfYzPzviEwA70oEI
 zJS2wtXanSYcGK91tRhTMcerwgk6rqwecuFpY8QE7Pz0Xns7d+760zcDbDllLWfEjqCL
 stNwsaZ66tgL1WZge524Pd/Z3DHVM5pmqIByhv8c6DDFSaIpcfUaS3IEDNPnAWXrh84J
 9sWLGFcUQOYh9inFO7glP676ufovdOW/qAuMqGnqptwetLbtxECDH5l0JOS4oL6Ybamm
 9CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743149749; x=1743754549;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vH+fgdNOoSdWXdWi/D5JtGFXA1M/x4TRSLmdOXb5S60=;
 b=vySaDT+azwDrHaCoNIcJHFjCEdWQdpWv8WwnhLk4RQJMT0YXk69yf4PrmkkH9HUt2u
 IF78+X2cvMGovWGHX+gXHy5k9EBB3ZbtHT2jHmTEbU7GRyHX2Nl6dQtRRTu7a0Apxm9l
 YTBIt/NZPb4s+mHnWniJfwXGWSveiho6oI9ssFGx6L/A6OvvD5bD32gaAcWD0Oj1p0m1
 3Uob8YBuItyC9svBAPvqs7jI953p0vDcZ1s6ktItyOLH6BgKgj4JmWJvuJ9nXd0S2Pt3
 dZ6CwfL6emyvV69HXmAIiQkF+cj+Fjry6pQtNXDpt4PBr5jkKakHvpyCa3T/H5JJya3i
 7aEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd/foWr183jvBLmS5aSTLc4SKZHsrGlj2lG6chqV3Zbh8TRaD+LL8loi6YPZ0fedevibdRlNM=@lists.denx.de
X-Gm-Message-State: AOJu0YwuFFXzCPoGpg+U/zJUZsBdMOa8wbTBMCoxj+enY2KVZfvkrh8F
 P19mjx0I9cRH0C5H2q78U2EBludfjiK0Me58KaF7T9ZJIJYRbav2FggIfy5Ny6g=
X-Gm-Gg: ASbGnctUZ8AqNXqgGVXTc+fkB9GT8TkyXgiiW03wrRLF26xhUzUzXXhtjN3j2N6WJIk
 j+hE3i+n3mj+R/hhAn/Gtl50yY+G7/H9ekjxTjAy2Jvb/YunFUCRLVA3L31S05RVUl54PFpUVhb
 lCrE2/x+bf2jYL5BBkVp2gb7IR+jehG54Fb6M6twZhdDA+PO9e2f3obBRmXFe+bibX9HtWg2Cs7
 pjmiAqrlQnfibRR35CU7j5cxVhBcjLwTuGRYNxQ9nTYppoMV8pLfBhaUTbtwL3XZZEZi+z1apfq
 1a+4cHGxaZfE1R/7fkVrOr7C2Yi0ljf5Z3PRXFypCuaHeOvdRj8TbKEcQzKk8ho=
X-Google-Smtp-Source: AGHT+IEhx+yv3WQc2+8kZ5oRhRFmFNoe/0X+tDHobtUCY7udmCgo0NKFcsmD1fpRCx4gzRD7uDYpDg==
X-Received: by 2002:a05:600c:3ac6:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-43d85096658mr70642515e9.29.1743149748493; 
 Fri, 28 Mar 2025 01:15:48 -0700 (PDT)
Received: from [192.168.1.116] ([2a01:cb19:95ba:5000:2b24:7f52:e3f6:e4ef])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4c29sm20352065e9.5.2025.03.28.01.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 01:15:48 -0700 (PDT)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Subject: [PATCH 0/4] usb: gadget: f_mass_storage: Fix crashes on low memory
 devices
Date: Fri, 28 Mar 2025 09:15:40 +0100
Message-Id: <20250328-ums-gadget-leak-v1-0-3b677db99bde@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKxa5mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDYyNz3dLcYt30xJT01BLdnNTEbF0LS4sUo1Rzc7NUoxQloK6CotS0zAq
 widGxtbUA8P+p+2EAAAA=
X-Change-ID: 20250327-ums-gadget-leak-898d2e776e2d
To: Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Marek Vasut <marex@denx.de>
Cc: Zixun LI <admin@hifiphile.com>, u-boot@lists.denx.de
X-Mailer: b4 0.14.3-dev-94c79
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

Zixun has reported an odd problem in [1].

He encountered a data abort on the 2nd "ums 0 mmc 0" command with
sam9x60-curiosity board:

U-Boot> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
CTRL+C - Operation aborted
U-Boot> ums 0 mmc 0
UMS: LUN 0, dev mmc 0, hwpart 0, sector 0x0, count 0x1d29000
data abort
pc : [<27f93428>]          lr : [<27ef7e80>]
reloc pc : [<23f16428>]    lr : [<23e7ae80>]
sp : 27ef4cf0  ip : a5200000     fp : 23f6915c
r10: deadbeef  r9 : 27ef7e80     r8 : 27f7d2a0
r7 : a5200000  r6 : 00000000     r5 : 00000000  r4 : 27f01668
r3 : 00000000  r2 : 00000000     r1 : 27fe1d88  r0 : 27f01668
Flags: nzCV  IRQs off  FIQs off  Mode SVC_32 (T)
Code: 45ac d017 68c5 4667 (60fd) 60af

I could reproduce this on khadas-vim3_android_ab_defconfig by applying
the following diff:

diff --git a/configs/khadas-vim3_android_ab_defconfig b/configs/khadas-vim3_android_ab_defconfig
index a078c5d363ae..c8d1cc69f1fb 100644
--- a/configs/khadas-vim3_android_ab_defconfig
+++ b/configs/khadas-vim3_android_ab_defconfig
@@ -3,7 +3,7 @@ CONFIG_SYS_BOARD="vim3"
 CONFIG_SYS_CONFIG_NAME="khadas-vim3_android"
 CONFIG_ARCH_MESON=y
 CONFIG_TEXT_BASE=0x01000000
-CONFIG_SYS_MALLOC_LEN=0x08000000
+CONFIG_SYS_MALLOC_LEN=0x81000
 CONFIG_NR_DRAM_BANKS=1
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x20000000

This series fixes the above mentioned crash by introducing proper error
handling and freeing the buffers in the unbind callback.

[1] https://lore.kernel.org/r/all/CA+GyqebHib_N7szGKkR0Ejac1rmoDQp+0a8t7ROng=PE3g9pGA@mail.gmail.com/

Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
---
This should go into next since it's not an urgent fix.
---

---
Mattijs Korpershoek (4):
      usb: gadget: f_mass_storage: Remove kref structure use
      usb: gadget: f_mass_storage: Drop invalid kfree() in fsg_common_release()
      usb: gadget: f_mass_storage: Fix NULL dereference in fsg_add()
      usb: gadget: f_mass_storage: Fix memory leak of fsg buffers

 drivers/usb/gadget/f_mass_storage.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)
---
base-commit: 3f9e0349c3e8afe45d5bdb2328a16512cfbc2ef1
change-id: 20250327-ums-gadget-leak-898d2e776e2d

Best regards,
-- 
Mattijs Korpershoek <mkorpershoek@baylibre.com>

