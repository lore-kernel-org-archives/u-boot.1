Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6D1FF8860
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 18:08:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 532C284564;
	Sat, 25 Apr 2026 20:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D61M6KMk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAFA184319; Sat, 25 Apr 2026 20:02:42 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B42CD80087
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 20:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=micbis.openwrt@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-48374014a77so116062505e9.3
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 11:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777140160; x=1777744960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QybEL3l2wkLhkhqaBAVVBOhgrBGlBSxV/kkk2PXb3yE=;
 b=D61M6KMkKLEn8QimLstgS64AYqLkYEabLfRO4pzVwvWnfn9UzNsguKn8FYM92ALpXD
 rHX7fqXXdeXrYsjP2xY/EXk5x2qG8VjIEt3IOd2PwHenHe9sAWaSZ5CVK0CCXOEzJr3Z
 9nM6E4iTCfPFbCljMdGSctwugZtROWRcoy5dEaa0CDGU1J3K1n7hZV+TjRf7ddb7fEPf
 Imy5WDtjQupCfgNAAU49LSJw0zVmHVqCX3zL5Fd1sX/oGZrQDBV0ED9fj/AXVj7jZLgm
 rDaa+AfmM+sbduyFXYIEQGURt0WM77OFIfhtOd4J+z44Zd4EBxq5vDujw7/dlFUuLpSP
 wi1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777140160; x=1777744960;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QybEL3l2wkLhkhqaBAVVBOhgrBGlBSxV/kkk2PXb3yE=;
 b=oT+rvR9J1MIOb/wAi2gk/xW10GUKi8eiFxRGw6D7bd2FXOxafFxjjGGBiXvWObzrwJ
 ZhW6wnVA8S4fs1fv09zXBYvyq9F0E1zekNr68bzzgC1+uOO4CKU7xBlTvU5se4jxgGPQ
 3p6fnzHzRLu4C0eCnO1p4ms9iBZBjnqGPx/N9HaIij8BlQmNoLH0HwgQlk2Cfbqe5UM2
 qOJI9+55HOd5hIG55dIj8qfOj11TxivSNakX2kZgjgkMGmUC/kmF+IYI333pc+vDuFT6
 oJBHiR/Clt/xkl400kuRa1L0Fu8TeswjUKsA/UE2jK6AsWd3zLZ2NQN/S37hD1dMPgsb
 ZtzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ih7UEEmgAxaAaURH5OK9/aExel6zrbvoyUiJDrJrl4+iy45hgXPCjT8pBm3yhjdHBWQfxnvk=@lists.denx.de
X-Gm-Message-State: AOJu0YwfdEIxFjr9COFiLMoCsNQe2aBL5+u5Vf3JFB8uBUWveF22jX+x
 +JTSFzualjaJe0C71MI2QefanbDw1lbV69AwXx+3jDadDoHbCaIZjXFp1hbauQ==
X-Gm-Gg: AeBDietJumievTnbH1uCokjXcHsCmNPU9GghNiTMNGSFJOy/MTGU1jKcr9/rxrk9ggA
 KtbxpwfPjeZf8rz2NgYzEmGJWGTVl9U1wVnXtoPBBj/VfQrOgNRmrdW2SYBLhlJsn20aQS6D37E
 oQZd5/WLpE8tZs746+EuQNoPnWntcnHIEXZwDEA68iNjyPrZiNsddHWiyzHrs9j2tHmaRi4mbck
 xWp7lTNjBninDPsuZ1qGKzZ4/pwE6bmMeOrnL8J7XaAeRutxIRuvA44ovB9JA22K6uOvG9mIDio
 Aq6XZYLkeFVAGz/j9VyEQzuVBdL9rgR5Spm89J8pPDvMRvHsLkwLB/YJSXNfb0KRXeFso2fnsyk
 Zfs15pRJ7AYsgCzPMptzLcEkhVzTzurYfod55zRJwsI4xx+YpS94jVfljqHHmrrYe1DYydWykfR
 5ek737c26CVWRNvouRYcZDPxNiNLini22MEbdwrro78BILLPaYBi8=
X-Received: by 2002:a05:600c:3546:b0:488:81b1:ae36 with SMTP id
 5b1f17b1804b1-488fb7880camr464761695e9.23.1777046644537; 
 Fri, 24 Apr 2026 09:04:04 -0700 (PDT)
Received: from localhost.localdomain ([151.70.144.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10777csm678783845e9.8.2026.04.24.09.04.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 09:04:04 -0700 (PDT)
From: Michele Bisogno <micbis.openwrt@gmail.com>
To: Marek Vasut <marex@denx.de>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Michele Bisogno <micbis.openwrt@gmail.com>
Subject: [PATCH v6 0/3] usb: gadget: rcar: Add RZ/G2L support and lifecycle
 fixes
Date: Fri, 24 Apr 2026 18:03:13 +0200
Message-Id: <20260424160316.157380-1-micbis.openwrt@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 20:03:18 +0200
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

This series adds support for the Renesas RZ/G2L (R9A07G044) USBHS
controller. During development, several lifecycle and resource 
management issues were identified and addressed to satisfy RZ/G2L 
hardware requirements and prevent resource leaks across the driver.

The series is split into three logical parts to ensure bisectability:
1. A bugfix for the gadget deletion sequence during driver remove.
2. The addition of reset controller infrastructure and proper 
   clock/reset teardown logic.
3. The RZ/G2L specific hardware parameters, SYSCFG logic, and 
   compatible strings.

Changes in v6:
- Fixed teardown order in usbhs_udc_otg_remove() to ensure PHY shutdown 
  occurs before reset assertion and clock disablement.
- Added explicit reset_release_bulk() and clk_release_bulk() to both 
  the remove path and the probe error paths.
- Sorted header inclusions alphabetically as requested.
- Fixed a bug in the clock enable error path where resources were 
  not properly released.
- Carried over the Reviewed-by tags

Changes in v5:
- Simplified usbhs_probe() signature to only take struct udevice *dev,
  deriving private data internally as requested.
- Fixed resource leak in usbhs_udc_otg_probe() error paths by adding 
  reset_assert_bulk() to the teardown sequence.
- Standardized resource management by ensuring the probe error path 
  perfectly mirrors the removal path.

Changes in v4:
- Split the monolithic patch into a 3-patch series as requested.
- Added usb_del_gadget_udc() to fix resource leak on driver remove.
- Implemented bulk reset controller support (required for RZ/G2L).
- Improved error handling in probe() to ensure clocks are disabled 
  if reset initialization or deassertion fails.
- Moved reset and clock handles to private data to ensure persistence.
- Reorganized hunks to ensure each patch in the series compiles 
  independently (bisectability).


Michele Bisogno (3):
  usb: gadget: rcar: Fix gadget registration lifecycle in remove
  usb: gadget: rcar: Add support for reset controller
  usb: gadget: rcar: Add support for RZ/G2L (R9A07G044)

 drivers/usb/gadget/rcar/common.c      | 65 +++++++++++++++++++++++----
 drivers/usb/gadget/rcar/renesas_usb.h |  1 +
 2 files changed, 58 insertions(+), 8 deletions(-)

-- 
2.34.1

