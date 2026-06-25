Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69AD4CDB479
	for <u-boot@archiver.kernel.org>; Thu, 25 Jun 2026 13:01:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D3F2684A0F;
	Thu, 25 Jun 2026 14:59:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JEMtm6y+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E89D784704; Thu, 25 Jun 2026 14:58:34 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68EBE8460E
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 14:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jjm2473@gmail.com
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-84538597e1fso1541494b3a.1
 for <u-boot@lists.denx.de>; Thu, 25 Jun 2026 05:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782392311; x=1782997111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c6+OATUOshChuzM0DQJkYdoGe7chjEEAdsk2MQJ6Xqo=;
 b=JEMtm6y+kX8t0VoHrN3thee42iSVLNnFeP25srDAwmBrHJBxDutiXPs30bcQPbxaDZ
 436wfaiuoAi6PtvRBnaBRJ9/UxqLAW/Ow2NcgdVq/qJlHLg+qUz+jMmPegtZdGuEMBDC
 1n9Drgpn4njGs9dJ9OF62APWGH8DUMIMSXBsc3z/8dyiEW85tTsLxWJ50OU0bJ19fsT3
 fjYOJ2Ax13VD8bBgbGqYgmi59QxdJeXpJfEdO+U+hikfz2NIpveWsEyz9afD2W9/6Nbm
 88g38Chzz5EELQ2wSFwNAOgMGlQ4TYdvXK9lvJoezkPndmZnoWu6mudvtzPQZuXQn6cg
 YzNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782392311; x=1782997111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c6+OATUOshChuzM0DQJkYdoGe7chjEEAdsk2MQJ6Xqo=;
 b=VDAOu9efzctsZDz/bWDgHlUPrEq9PbbhSFpizrSamkldWHe3A/PLz9IBpqxX/TCakX
 G4KfO4bb2Uppts5uZvXWxlEFTkgf0q+Y52Z1LZSv0Bm+wK6C9gXVpcQISL45aBrNiOuW
 w09lk0+CJ27n2/CnABYQu8IZqlkuCJAOlPKKYahRHgk5Tgdg1AcRRM+4wdkBSkEK3zDc
 1i9k3Bn74fnvNhdkvcdwDhRBmzz3Q2YDuVUnxHTaJx+VhR/i2nQ5fc7wAXv6NP/fQumY
 UjOLtgDq16FT+f9diBYAiU/lMhkzdyR6dOq3Rdp0ehY7N92ck2McXPMtmJG+72V7izqB
 MuLw==
X-Gm-Message-State: AOJu0Yy6WmeL4hIxjpv7VVIR2PGTyX1mn44nrPmd7Ou87LnzoVNKA3wr
 HNfNeSTjtMx/fb+38yBvWTqO2rUl5Xnnwh0+Yaq3n4Jzrrg1zM2JR0me
X-Gm-Gg: AfdE7cniaRR/71jcRsyvNkr6IdjDD29nh2I/CKfq6DWg4zp0qZRZ7Ck3Fywb3yK4oCs
 Jd97JvxRE217wtYoQUEO555LhneytXRHeDdl9TNwKPL7Yw/u83SU9CI6azLkDPe/qPb3XNzmKdh
 aE3cgFn1X5lSBJNZ9nJGRhmL54kGt7963wa2LVsnqqIvzW7MmS28IQsUWjGwnaIm01yl6EdgMJk
 qNUUJbQ6SrmQ5c4u4kZqVMdvi81PojTz6yZGk7WhpoeN0+W2uPadWuU61YXQcxoyaFQ16UWKJHC
 HI6bw8ZqmGyk158geRLdthBi29d0AkAbbVSdIgAH42F1DOb42mV7anhI9yrm/+TJAPFxGPYZH8s
 mzKax9i9sVqmPzLFAOl72mP4k8xQ79+OQF1dcx6dcVmoRkzQPKAdDclYH6QsEjtJl8cYj+n1oW7
 od2ewWkNqo/io4
X-Received: by 2002:a05:6a00:4b50:b0:842:5b63:610f with SMTP id
 d2e1a72fcca58-845b39c493fmr3083557b3a.4.1782392310849; 
 Thu, 25 Jun 2026 05:58:30 -0700 (PDT)
Received: from jjmdeMac-mini.lan ([2a09:bac5:3981:e6::17:359])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-845a3fedaefsm5439730b3a.23.2026.06.25.05.58.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Jun 2026 05:58:30 -0700 (PDT)
From: Liangbin Lian <jjm2473@gmail.com>
To: Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Liangbin Lian <jjm2473@gmail.com>,
 Tom Rini <trini@konsulko.com>, Joseph Chen <chenjh@rock-chips.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>,
 Johan Jonker <jbx6244@gmail.com>, FUKAUMI Naoki <naoki@radxa.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 0/1] rockchip: rk3568: Add support for LinkEase EasePi R1
Date: Thu, 25 Jun 2026 20:58:17 +0800
Message-ID: <20260625125818.18914-1-jjm2473@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jun 2026 14:59:14 +0200
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

LinkEase EasePi R1 [1] is a high-performance mini router.

Specification:
- Rockchip RK3568
- 2GB/4GB LPDDR4 RAM
- 16GB on-board eMMC
- 1x M.2 key for 2280 NVMe (PCIe 3.0)
- 1x USB 3.0 Type-A
- 1x USB 2.0 Type-C (for USB flashing)
- 2x 1000 Base-T (native, RTL8211F)
- 2x 2500 Base-T (PCIe, RTL8125B)
- 1x HDMI 2.0 Output
- 12v DC Jack
- 1x Power key connected to PMIC
- 2x LEDs (one static power supplied, one GPIO controlled)

[1] https://doc.linkease.com/zh/guide/easepi-r1/hardware.html

Signed-off-by: Liangbin Lian <jjm2473@gmail.com>
---
Tested: eMMC boot, USB storage, Rockusb, NVMe, Ethernet

Changes since V1:
 - Removed rk3568-easepi-r1-u-boot.dtsi and corresponding entry in MAINTAINERS, suggested by Quentin Schulz
 - Removed clock-names from CONFIG_OF_SPL_REMOVE_PROPS in easepi-r1-rk3568_defconfig, suggested by Quentin Schulz
 - Link to V1: https://patchwork.ozlabs.org/project/uboot/cover/20260512091532.97256-1-jjm2473@gmail.com/
---

Liangbin Lian (1):
  rockchip: rk3568: Add support for LinkEase EasePi R1

 board/rockchip/evb_rk3568/MAINTAINERS |  5 ++
 configs/easepi-r1-rk3568_defconfig    | 82 +++++++++++++++++++++++++++
 doc/board/rockchip/rockchip.rst       |  1 +
 3 files changed, 88 insertions(+)
 create mode 100644 configs/easepi-r1-rk3568_defconfig


base-commit: f072620dc9ffda00b010783da27c41231c3a439b
-- 
2.54.0

