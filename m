Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D0CCCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 599F2836F0;
	Mon, 27 Oct 2025 07:14:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s4ZPu4kj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86610836D1; Mon, 27 Oct 2025 07:14:57 +0100 (CET)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com
 [IPv6:2607:f8b0:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC14680422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:14:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oi1-x233.google.com with SMTP id
 5614622812f47-4439ecf6004so3156315b6e.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 23:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761545693; x=1762150493; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xpwy/ZkpIkXljZOqFzZHBRebX/dXexuWIEuLuataqaw=;
 b=s4ZPu4kj3i7G2bMG+CHWxww27lWaa8LlVVWpI/sSKuMconaV9TeFxVLBTIkInRXDv9
 g5BVt2qOiAbg9TyC6XGLOk4vsNhhPAmb2tP+kCTLO98EAyKRctnp7/AC/kwte2dTJmjF
 BREcZX/ameqcWhHmXWZdAIVj/HPb1kbJwwP8/8F1oC/LM2sliVyVR3KBnBtB4OpzCB/V
 4NeiUAl+bGtyiZCqt76WZ7mQYIeADgWENhL8hFUDPxfjKBS+VpNJKEiphXJkx/T3pENN
 JF6I4WeLb6NxlFf/PrBxt0mLxYXhrredkXimj+c5311GUrqgnf1BE2cGZ6uqcthn60ib
 rtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761545693; x=1762150493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xpwy/ZkpIkXljZOqFzZHBRebX/dXexuWIEuLuataqaw=;
 b=LBjSIZ9zkYGU0vXJqvk/To3J2ePKuBlw7PBt9gqTZX23mwRdjVwJ5+/htTgJevhDuc
 XRx2X3vDIgUwcfTnAwGZF+yRakx011SA4fbooZUAhegRWRf9qwl56P8wGKBwv48dbBH9
 5+rErYhAKH9Mdy53NNfubUdaz+j7kb0riFntW99eKQ9KOTsvGjHY8D75iWdzGSh1QPlm
 rlMGai+j162f5Ta5lXWPq7syu3vWJe1iHRgR7lqXn3mABhB+2iFU4688EAcQ9IvKB26h
 1ZGcLD258F50kH9bmzr0mJK5rucSW92088BL3tD5R+csSUM3VfSOGeeWYpLB+wmscIu2
 7Efg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVn7p9xGSJivL177gYalSsAHkNruWxFOVP/Cq/Dcdq1rd9DM67fgnK4IIxrhzNF/J27Pw01VNc=@lists.denx.de
X-Gm-Message-State: AOJu0YxzvMQAetQI9sgTDLVCbzWI024WW9NlOG6iRs9Jwcm0VzEVMlKy
 b8aWeNjDmyQFIq/ECrAV4CjJfBgqXUDqZi34XQ7G0MK2wqCGffQDkTg0bw5+ExSLKCQ=
X-Gm-Gg: ASbGncvshJeR5jS/59fcQ0LfGkawCdbUVOQH4tbJ4ngGwY4nZnp7HCjsezgbUs7goDJ
 p2iz6qlm8JTcyW5dG1DJlNDQLEm7HYBvW7uLFWfxrOEt2Vd5ksg64fylWYcFTq+fG54rnWQ4vEk
 j9mWDeyAgHRd6gnWzMDtqEYqlsEEUJZXvLNobUnHZt+1ynPngyNeOU4or8HhGRCRcTy7T904ucp
 8VZCXd9TSSjnKweyiCsl19s0zUvh7QypKnDCJ8fnxUntWuBR1fuyBY173na+CZSA1+uAGAflTis
 jWK8eo348H/7gM2lGTieFRQkIsH6X8VH5Y24zsqhy0LRQG4Y8l7hPJbnMj1iBrqF90hR/ufOXXj
 Q6eEDZiK946/RTRclEI9Nd3RgD8ni8eiujN9ONFTLUCXmA2qx0GcgpFOhxHpA258AhhHPMNzMZo
 ixzwdrbULt8qnw+Q4Ek87a
X-Google-Smtp-Source: AGHT+IGoO/yIDD/qtn6mYtEwLwHb1g1GMsBST8bVaQeNnySfPkc6ibgWIpoKDifLpux3PxwV3OCI8A==
X-Received: by 2002:a05:6808:d53:b0:444:c761:c091 with SMTP id
 5614622812f47-44d9168da0bmr5398029b6e.10.1761545693494; 
 Sun, 26 Oct 2025 23:14:53 -0700 (PDT)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-654ef2726absm1640582eaf.3.2025.10.26.23.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Oct 2025 23:14:53 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Tom Rini <trini@konsulko.com>,
	Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>,
	u-boot@lists.denx.de
Subject: [PATCH v2 0/5] board: samsung: e850-96: Support USB boot
Date: Mon, 27 Oct 2025 01:14:47 -0500
Message-Id: <20251027061452.21165-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.5
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

When U-Boot is executed during USB boot [1,2] on E850-96 board, two
issues happen:

  1. eMMC fails to initialize
  2. Attempt to use USB PHY driver leads to abort

It was identified that issue #1 happens due to enalbed Flash Memory
Protector bits in MMC block registers during USB boot, and it's handled
in patch series [3].

Issue #2 on the other hand happens because ROM code expects the
bootloader (U-Boot) to download remaining binaries (LDFW and TZSW) over
USB using SMC calls. Before that, the access to USB blocks (USB PHY and
DWC3) is disabled, probably because corresponding TrustZone domains are
configured for access from Secure World only.

This patch series implements downloading LDFW and TZSW firmware over USB
during USB boot, which makes it possible to use U-Boot for flashing
images to eMMC using fastboot and DFU protocols. That in turn simplifies
the U-Boot development, as one can use `dltool' [1] to run U-Boot binary
during USB boot, and update U-Boot on eMMC this way (e.g. using DFU).
It's not possible when using LittleKernel bootloader, as it expects
non-standard Samsung GPT partition, but in case of U-Boot we use the
regular one.

Once this patch series and patch series [3] are applied it'll be
possible to use U-Boot during USB boot. The two series are independent
of each other, and can be applied in any particular order.

Changes in v2:
  - [PATCH 4/5]: Return 0 on success in load_image_usb()

[1] https://gitlab.com/LinaroLtd/e850-96/tools/dltool
[2] https://docs.u-boot.org/en/latest/board/samsung/e850-96.html
[3] https://lore.kernel.org/u-boot/20251026010658.19271-1-semen.protsenko@linaro.org/

Sam Protsenko (5):
  board: samsung: e850-96: Keep public functions together
  board: samsung: e850-96: Add routines for checking boot dev
  board: samsung: e850-96: Split LDFW loading and init
  board: samsung: e850-96: Add routine for loading images over USB
  board: samsung: e850-96: Load firmwares over USB on USB boot

 board/samsung/e850-96/Makefile  |  2 +-
 board/samsung/e850-96/bootdev.c | 99 +++++++++++++++++++++++++++++++++
 board/samsung/e850-96/bootdev.h | 23 ++++++++
 board/samsung/e850-96/e850-96.c | 65 +++++++++++++++++-----
 board/samsung/e850-96/fw.c      | 76 ++++++++++++++++++-------
 board/samsung/e850-96/fw.h      | 10 +++-
 6 files changed, 240 insertions(+), 35 deletions(-)
 create mode 100644 board/samsung/e850-96/bootdev.c
 create mode 100644 board/samsung/e850-96/bootdev.h


base-commit: fd976ff3a233ae7c6a9f5bec790b02bbbf57bb24
-- 
2.39.5

