Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B844FC2A09B
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 19:17:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72F5B812CC;
	Fri,  7 Aug 2026 19:17:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4Swh6JTiyDBB; Fri,  7 Aug 2026 19:17:10 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D90E812DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786130230;
	bh=iWMVoTGinPcRg5DnPH7DTbP5V/Iv4u+BJ/eVi2xe/cA=;
	h=From:Subject:Date:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jvPHvsL+v49eh2Fb6SiJDzOEXle8jAao/henXexMwScuzzl8iLOKHNic+YqDEgYRR
	 tpPnVnqstp9+1RLhJWss11v9H2GK38j4WhNI6wd/+iRE9m5gmpoGuGYMOX0ojp4xim
	 GOpmIxdNG4NZbhSepclPHq3Iq/DJHdBuuRP/UWmcQ4hzsb9LYU4s4xOS8XfAWkgD3G
	 GQptB9wEb5f4ESutgLMA1v5KSAdSlZJdZbIJYdF96pzxo/S+5rw+jIgKYe+73nJ4dc
	 XVxdhZGfVDyf8d9uKAPkOmFccJnZXYgg4Q1u5h+zDOBf8BXQYhmF3v0HLy6n+PWJsb
	 daiITNUcF29zQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7D90E812DE;
	Fri,  7 Aug 2026 19:17:10 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 0E7682F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8ED0812D8
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TjSntXSrPxyW for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 19:17:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::330; helo=mail-ot1-x330.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9AB0B812CC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9AB0B812CC
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9AB0B812CC
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 19:17:08 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7e9f1f24cbcso2284624a34.0
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 12:17:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786130227; x=1786735027;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=iWMVoTGinPcRg5DnPH7DTbP5V/Iv4u+BJ/eVi2xe/cA=;
 b=MWaZWnLCSTAcBz1joMWkH01HlK1dB3dBlmXeI3A37XgFIAh5DLMwL+ggDEB49YgUnM
 oXglhqKDoaWULkitvtZD1N+rxwQuzJU/Wkmf/jpKRMvGJw50cR/g6jzmtbDdHpTD7WpY
 ZBWEyGa9T2wF501Ule/THt7CjN82U5tmRQ4wuYsjWIZQE8u2KGe7RH0nt/28eJPfpuOB
 kwNBnzkUGg0qg/qltPzFWWdx9DQ5nma8lSjMASThIdoeCP/ExVZSKrRrbzRL4lkdW6/m
 EWKsK46Al2aRqgDYsJBYsB0ZXL2q4oyD2e4ND12Gi2A6OYALsbBOpzd+XxCD+GIX7Amv
 D+AQ==
X-Gm-Message-State: AOJu0YxjM/s/PhNvc4oiBlK9R4clRKSmKeE52e/r08D2KW+CRiOSKVq9
 D2bmlZf6i2NFrgB5I2tZFWJRI1vRdlh+COeqhST9g20hMIUp7WLXdZF6Yizd92xHxrOjT2Brx6S
 j3JaWxeU=
X-Gm-Gg: AR+sD11uLn8mcf74e5evKrt4xrvj6XVxoGLTGrzLXek9Gk2kUvAh6lMBsWfWHkPC+Cl
 eYQExMEw0mbIOlWDnG+YYKSy8kpJA4oylop41vlugmz4/7Im+yaRj/OyZeqVdmLgKvyoeWSNrNN
 VmU1uYaBRzQ+6w/h1s3PfujwenVeLWNkrnqzx97pdzT5awITopKJyJT0F3+wRZE3azZN69aQVWh
 VW583m9+55FEDUky5trjJlxQ78O1cVCf4QGI2jYZx2rlmfxBA6WYNMhfWZhGNvaOItEk2aUIk2Q
 IgLDZqVaRClaAYDMV7735YAjkiG7JYiIvDlj9pHA5fvV54bsrnwQR6wllUW/JEXT3aSWmMfqOfB
 jVHtyupmdw5VaSJnyJDUD+IZsA9R+8gibGbNhZmcThi+y0E82Tzs5S1hT1/7XAxciWmFxX7vah4
 5CEU7qJHg+mfhhz0kuD1N/qq4zAsv9lyvzUP28ceeeaIKCkVQnIRL6ko4UZu5KFDd9Q27wOyjbI
 zA=
X-Received: by 2002:a05:6830:82c8:b0:7e7:24f9:55c8 with SMTP id
 46e09a7af769-7f36c165ef3mr279083a34.5.1786130227147; 
 Fri, 07 Aug 2026 12:17:07 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:b714:88c:313d:dee2])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b5acbcbsm1875251a34.11.2026.08.07.12.17.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 12:17:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/4] pinctrl: mediatek: Kconfig cleanup
Date: Fri, 07 Aug 2026 14:16:28 -0500
Message-Id: <20260807-mtk-pinctrl-kconfig-cleanup-v2-0-509a8f833181@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBAAv0J6tqYUBPTkPwyHsmxhBVrSFiIh/
 F3AD3icZDKzMo+O0LNHtDKHM3myZgd5iRi0yjTIqd6ZSSEzUYiED6HjIxkIrucdWKOp4dCjMtP
 Ib1LkaZEonebA9sLoUNPnrL/KH/upeiOEI3kYLflg3XLu5/jw/jvNMRdco461zu51DPCs1NJT5
 fAKdmDltm1f2RXo5tsAAAA=
X-Change-ID: 20260803-mtk-pinctrl-kconfig-cleanup-5207483af47c
To: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Julien Stephan <jstephan@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Tom Rini <trini@konsulko.com>, Sam Shih <sam.shih@mediatek.com>, 
 David Woodhouse <dwmw2@infradead.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mingming lee <mingming.lee@mediatek.com>, 
 Fabien Parent <fparent@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, David Lechner <dlechner@baylibre.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2437; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=aAg9+r4CPb72SXQJ0CHSshzZfsxcAOP/IzuA4whSG/g=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqdi8PDONUFAIMPWyHtB9i32QI93qtDhlYnGorf
 ydezTBv7xSJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCanYvDxYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/AuD4H/iX9ItLbgx4gmoWptkjiU6AbfRzXrjPga4bppws
 3BYtHkPsQcdSawi2amdP0/GogsGoRO+v87f9TVYAYp32ZzAvkzfQdkHB+NbnzLju04mjgvDJTDy
 3FOrHnk5xbIwNCONRZJtwA9VfZqXPHnK5MQ88E89tqncNtCQALO1+gH8QXknmSbCy9V53SU6ns8
 NYeibTPt4J6x+aYCX/8fvoxpoOiU6m9m5rLF9iqp/KV1OqKYmF322Ipp2chk6cBsRtRnqSUkGs9
 lVia2wTUwWd++IFO3Va7EGciuQzKrLosviDbK5HQ83kd1PhtphDmqKo3jQD1SZXFF0pUkCigrAi
 4i4E=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786130227; x=1786735027;
 darn=lists.u-boot-project.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=iWMVoTGinPcRg5DnPH7DTbP5V/Iv4u+BJ/eVi2xe/cA=;
 b=B4tuvvIHitkpxcTk/kPNeB6UhqjsW1JYyt8TdjdHF0EoKn7VCdr5lbvBGUjm7GjMWI
 A2oTtjnFXvUpbH3FpAen1qd6S1cxt2wYJmOi7LTVU83mnpO+0xsJkHYToOyg5SegFinX
 ZaHVxiIlBnrDxt7QZc810SZ1AlxrkK4Igea28boq6dxwjjI+zF1prZrughcz2h87QdWA
 ynO+FoUXY+fH7VyHm4XdlefA+/d1bQVwL5MMEJPJ5T1vKU14STBVav80mepyz7MCKzr/
 KxBAQt1chZQFNcaq0AGVcetKutxuQ2yz9fEVit3Vz4OhHc6FmbVltQp3Djn5CO/uY1Oy
 709A==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=B4tuvvIH
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

This is following up on some suggestions to cleanup the MediaTek pinctrl
Kconfig before we add another new SoC driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Explain in commit message that PINCONF is enabled by default on MT8518 now.
- Remove #if CONFIG_IS_ENABLED(PINCONF) from header file as well.
- Sort targets in Makefile.
- Link to v1: https://patch.msgid.link/20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com

---
David Lechner (4):
      pinctrl: mediatek: select PINCONF
      pinctrl: mediatek: remove PINCONF conditional compilation
      pinctrl: mediatek: simplify Kconfig
      configs: mediatek: drop no longer needed PINCTRL options

 configs/mt7622_rfb_defconfig                  |  2 -
 configs/mt7623a_unielec_u7623_02_defconfig    |  2 -
 configs/mt7623n_bpir2_defconfig               |  2 -
 configs/mt7629_rfb_defconfig                  |  2 -
 configs/mt7981_emmc_rfb_defconfig             |  2 -
 configs/mt7981_rfb_defconfig                  |  2 -
 configs/mt7981_sd_rfb_defconfig               |  2 -
 configs/mt7986_rfb_defconfig                  |  2 -
 configs/mt7986a_bpir3_emmc_defconfig          |  2 -
 configs/mt7986a_bpir3_sd_defconfig            |  2 -
 configs/mt7987_emmc_rfb_defconfig             |  2 -
 configs/mt7987_rfb_defconfig                  |  2 -
 configs/mt7987_sd_rfb_defconfig               |  2 -
 configs/mt7988_rfb_defconfig                  |  2 -
 configs/mt7988_sd_rfb_defconfig               |  2 -
 configs/mt8188.config                         |  2 -
 configs/mt8189.config                         |  2 -
 configs/mt8195.config                         |  2 -
 configs/mt8365_evk_defconfig                  |  2 -
 configs/mt8512_bm1_emmc_defconfig             |  2 -
 configs/mt8516_pumpkin_defconfig              |  2 -
 configs/mt8518_ap1_emmc_defconfig             |  1 -
 drivers/pinctrl/mediatek/Kconfig              | 62 +++------------------------
 drivers/pinctrl/mediatek/Makefile             | 30 ++++++-------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c | 13 ------
 drivers/pinctrl/mediatek/pinctrl-mtk-common.h |  6 ---
 26 files changed, 20 insertions(+), 134 deletions(-)
---
base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
change-id: 20260803-mtk-pinctrl-kconfig-cleanup-5207483af47c

Best regards,
--  
David Lechner <dlechner@baylibre.com>

