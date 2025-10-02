Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE8ACAC5B0
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 10:45:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17FE683526;
	Thu,  2 Oct 2025 12:45:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f9B36vJi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C83A834D4; Thu,  2 Oct 2025 12:45:45 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B3181D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 12:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=glaroque@baylibre.com
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e3cdc1a6aso5657265e9.1
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 03:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759401942; x=1760006742;
 darn=lists.denx.de; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kGF2zAGIh8y59JBq3pJEoHk6DyK5ftWR1GQ9qXmnL/0=;
 b=f9B36vJiSJs2uXUNWVVWfuR7jyE/Af945Ek3V3cx54hqhg+My7i1cAOL6G35wsnDSF
 Im/UEoxpCVuCfiZ8XBoZJSyS5DFjNGtJynFTi03W3sXeeFJpOZwlH0PPSGzmWfYpUrCK
 B+WbnKIUX2KXXX2o3ToCsU7Sy+W/+0lidJGkhQHB9LqHxFU0ySRip9ChprqAn0fAKBop
 rcMdrfHKpnEUgSmpZAUYSXUD7cCBUyPyVMUzWd2XLm3+p/dPe73fx2yuy13Lpmpa7XMX
 Dj/ZbrjzRf3cbIF+LO6HdH++5EJTzv1joPAUcbwpbmp5K60jBwh93Gb7Ik6pit7pk6qC
 JiZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759401942; x=1760006742;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kGF2zAGIh8y59JBq3pJEoHk6DyK5ftWR1GQ9qXmnL/0=;
 b=w3EYvcnQd9hvx8kW9sKzFpI1on3vtLJTElnV4RaA6cR1Ds/dWBxCzrGnvX1BAh+U7s
 u8FVNm8DGg3NuGMxH3wJjnJmHu/Aq8f+ePcFzsRPDchpVNPLfqn2z5x6KpBfNf3Sk5XK
 rXAB88Dwnb/PmMk3Ff2x/PmVrclXMVpDOfU8gWHIP8+WgF8674zLQjBLCXVwcaklyWUl
 XJr8yem4H33KbPkdel9+pDOnLnD06fNSfSXdCJsCr5vCGYCtUbIsR005WfyXFRQRnEMR
 23JUzt/uDRYCI5uEwr5RM/Nvzx3veSz+LUFJSh50w09xdkij3zuU0PlQpw21Vaf1tHdw
 mLAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXR2Ebv6lvNOhT9Yy/bB1hN7YWNyyfkoyrzQ7VkYJtxK0G3A856t/nfMYx2eYf3k0j+gNANEdo=@lists.denx.de
X-Gm-Message-State: AOJu0YxXKtRrCpDJc7KRlhJR/dQfX6HeIkOSF1rUWPvfIp30bC7LMHzH
 Xm862UwWzDa56ygQngWuQ1BfG467Xl93bcpgow4Mvn3DQilycr2atwnPDrfP8xUEr1o=
X-Gm-Gg: ASbGnctnjOItGyii/yTD24gkUPcAAJXZkJWdF/YZ5vDfp7HAyHHYJqi21qlwO+fd1N5
 oDWY4VhxGDIyWgzLoBAhkO3JWs0sNF3MoCr7aykYGnXk/Sr8BfkOggXPVk5PnzCcm+NiXFG20RX
 7wVk5fcxC2yZ2KLCZy2YdUdzRezKGI0jdbt/lxUBzLcyu91yyd4JhsSwoK7jyHq1DdPoHpv07MA
 swmET3IMZpXuS/FvZzJ/8Rr3qYNbP9ADxy3BiYQ4Qm9Q6jaxGWsH8KcqA5sP7deptpBWg/731S3
 UdmpctAbN14iEshcU+40TkvTn5GwbPRp6M4hdcBi7vLoyisbbBi8r2eS4TFqpCGplgOykJ6EZpT
 59qfiwedeaF+3u9NeyMmdNd1ymn4sgP88E6jfw+y+X1bki/pzFg==
X-Google-Smtp-Source: AGHT+IGhJGJ2J+ExGkli4jqk+aKoX1iexSPxpfzTdVHCzLwiTd9y1XgwK21qn0WUhx64PCiP4WytAQ==
X-Received: by 2002:a05:600c:15c5:b0:45b:910c:adf with SMTP id
 5b1f17b1804b1-46e68bef60emr14004255e9.12.1759401942473; 
 Thu, 02 Oct 2025 03:45:42 -0700 (PDT)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860:51a7:9db7:1d49:a8ae])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6bbesm3081583f8f.12.2025.10.02.03.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 03:45:42 -0700 (PDT)
From: "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
Subject: [PATCH tiU25.01 0/2] ANDROID: Add some features link to OPTEE TA AVB
Date: Thu, 02 Oct 2025 12:45:33 +0200
Message-Id: <20251002-avb-v1-0-1f93543822ce@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM1X3mgC/x3MQQqAIBBA0avIrDNGyaDu0SpaqE01GwsNCaS7J
 y0ffH6BRJEpwSgKRMqc+AwVqhHgDxt2krxWg0ZtFKKWNjvZO+pQeRzQINTyirTx819muHnSpkU
 lYHnfD02t/bVgAAAA
To: linux-patch-review@list.ti.com, praneeth@ti.com, u-boot@lists.denx.de
Cc: mfournier@baylibre.com, vishalm@ti.com, khilman@baylibre.com, 
 "Guillaume La Roque (TI.com)" <glaroque@baylibre.com>
X-Mailer: b4 0.14.1
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

This series add some Android features link to Android Verify Boot,
device lock/unlock and keymint TA

- Add support of fastboot flashing lock/unlock  and
lock_critical/unlock_critical with Optee TA AVB if supported or with env
variable (for development only)
- Add support of get root or trust with TA AVB and Keymint TA

This series will be upstream after release.

Signed-off-by: Guillaume La Roque (TI.com) <glaroque@baylibre.com>
---
Guillaume La Roque (TI.com) (2):
      PENDING: fastboot: Implement Android bootloader locking with CONFIG_FASTBOOT_LOCKING
      PENDING: avb: Add automatic Root of Trust integration for Android KeyMint

 boot/bootmeth_android.c       |  15 ++
 cmd/Kconfig                   |  13 +
 cmd/Makefile                  |   1 +
 cmd/avb.c                     |  13 +
 cmd/cmd_avb_rot.c             | 129 ++++++++++
 common/avb_verify.c           | 183 ++++++++++++++-
 drivers/fastboot/Kconfig      |  21 ++
 drivers/fastboot/fb_command.c | 450 +++++++++++++++++++++++++++++++++++
 drivers/fastboot/fb_getvar.c  |  68 ++++++
 include/avb_root_of_trust.h   |  50 ++++
 include/avb_verify.h          |   9 +
 include/fastboot.h            |   5 +
 lib/Kconfig                   |  18 ++
 lib/Makefile                  |   1 +
 lib/avb_root_of_trust.c       | 534 ++++++++++++++++++++++++++++++++++++++++++
 15 files changed, 1503 insertions(+), 7 deletions(-)
---
base-commit: 5b93c3ec7f9d66dc40d062a47a4a880f7d346b7a
change-id: 20251002-avb-6be401c09050

Best regards,
-- 
Guillaume La Roque (TI.com) <glaroque@baylibre.com>

