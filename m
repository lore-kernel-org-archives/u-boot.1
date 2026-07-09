Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BCD7C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:05:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A57E384B51;
	Thu,  9 Jul 2026 15:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="dx4bDw8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E312984B2C; Thu,  9 Jul 2026 14:58:03 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 268E684A3E
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 14:58:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493c5220cb7so14486695e9.3
 for <u-boot@lists.denx.de>; Thu, 09 Jul 2026 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783601880; x=1784206680; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ue7lQT6vg/V45+BdcsD7OJ67qwVLOSI0Eq7H3eb75Qs=;
 b=dx4bDw8s94ijPzCEAQZtyR13/jCVNOdcbH4tVECwOj3PwotmAjrVJV8Ipiy4G3LSB6
 YUadZeT9eFhGJTsQyketMLbH663KePAZI+cVo9LqkCrinqlN83Kd/boePCsYazswzL3k
 /O0PlPCCX2G2yIhHFEeKLEeWZHRwDDgVHCD3kSieSSCAHPppCW31ui3EVHddnSVzh4+q
 dly9uGaCxSnedKDt8ISW6JVLJep4r3uAembLZjVYJEBPfbvD1nopUYtjwcbvKykyt/Q4
 1Hp1goaTGXNyRtUQc6YHSKTkx8zoLE663nwuPPlhbktApECdsjy0feozf1QPV485INa9
 n3hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783601880; x=1784206680;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ue7lQT6vg/V45+BdcsD7OJ67qwVLOSI0Eq7H3eb75Qs=;
 b=FNYYGo5dqGBOx8vCrzetiXGMGyWIK2nGTyRFMrhVuCQLVqhaaCY1QHjg2JxyYlnD02
 UD5Z/sk8mWNjuLkuZSFCAe6Dj0pVrFE8A66cOePGI3uayw30pLFrQcrKgeyuq4iByxAh
 a/Dw6nP61h7j9U2z+Yim2u0cz0za6VqT1OZRtX1ELtiX3F4VVNnO9/HeqwPL0r4sAas9
 7avkATr0So2j9mE7se8M2jtx0C6nCt6VziaZYzd9czNaL10/0I2qTH1bikvCVzTsQMlY
 nfouhIbcgY+Fm/TlpIiA5ADZO7AK/HJ6K5WTEkleht0VQkTXmLc4WfzBSSVfGnmmqBwT
 U0ig==
X-Gm-Message-State: AOJu0Yx+x86SnJ5bVihSMzbGBE3qdJIsC5LVYO6mPwkuDB9m/4ByrvRg
 dQxX16uworFYX9L6zWp/vQqmp45/Jzxzmp+opJv0Ox8lDf+DG2jLo2XxdgA21vQeBG4=
X-Gm-Gg: AfdE7clhTyGvV+8oj1vOmk8lYK6VsrAiqlpfewfuq5CvmDSqg4qfNolSWt7bANZ0fy6
 Nhlh6AJukxZiozY+5f5nlq73NmseYQmYerNN2v2RW2DiyZXf/aawFaqqRZ6esZCvxHSYGvInL6b
 YvqhqHnYEfhGpZhHmSMaiwWuS/gSv3AyTTqKFl1w3Rpg6mTXH8vuWeMtknAN6SUe2mlOJhEikJm
 SiRYO6kSBWnQSEGjsIpP1ZKg7LAmsZofAg6peSAS/VghT3zwWOjTNcW8z4fIgiSFKYmKE0/Fnn3
 O37Egy87Vd0rZvh4rF5eQ0QumAGvsHpwnBsDGVTiRm8bHg/X1zjeFhD2m7/gS2rdA5GYC4PC51a
 lJgdyya7OMc/Jd01RzFbU824fip0q9nXgwxiadFpMFSlqeJfZWcQYgMVofZ31DLzN4PcgjRJInA
 xZB86NSuHJt6gsc044AXiqxToO+TdJUxpjx26XbyXgMAqVbgZF81TZlPvKQH26glKh9Nak2um43
 jjDRSsQv5jCvY23N1Ldam8vOfVd5ShviVm3qOliyINnoSRoYgbazOPOecB2svxoTUMmh5T0d/lE
 64RN2g==
X-Received: by 2002:a05:600c:4743:b0:48f:d5b8:5b07 with SMTP id
 5b1f17b1804b1-493e68c4a07mr68524145e9.20.1783601880426; 
 Thu, 09 Jul 2026 05:58:00 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm55165977f8f.37.2026.07.09.05.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 05:57:59 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH v2 00/14] power: domain: mediatek: refactor driver and add
 MT8188 support
Date: Thu, 09 Jul 2026 14:58:06 +0200
Message-Id: <20260709-mt8188-add-power-domain-v2-0-589ace7d30e2@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WQzU7DMBCEXyXymUW2G4jTU98DcfDPpl1ax8FOA
 1WVd2eTlAsS2tNIszPf7l0UzIRF7Ku7yDhRodSz0E+V8CfbHxEosBZa6lfZSA1xNMoYsCHAkL4
 wQ0jRUg+1MZ30OliLQfD2kLGj7zX57X3T5eo+0I9L3MOR8fPKleNmE84WBJ9ipHFfGSUVBv1SN
 2pxRyzFrjhMt8GoXxh/Oa9AkUqh/sg6+TMw1MDH+e4INsGkgGenZOtU2+raHJy9XchlfOZGsSC
 eqIwp39ZfTGolejSZf8/mWAkS2510ddeoGv/EzvP8A1xDzHBkAQAA
X-Change-ID: 20260702-mt8188-add-power-domain-488f0c2daaed
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>, 
 Tom Rini <trini@konsulko.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Brian Sune <briansune@gmail.com>, Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Sam Shih <sam.shih@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, 
 David Woodhouse <dwmw2@infradead.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Marek Vasut <marex@nabladev.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Macpaul Lin <Macpaul.Lin@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Johan Jonker <jbx6244@gmail.com>, Carlo Caione <ccaione@baylibre.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 09 Jul 2026 15:05:30 +0200
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

This series adds power domain support for the MediaTek MT8188 SoC, used
by the Genio 510 (mt8370) and Genio 700 (mt8390) EVKs.

The existing MediaTek scpsys power domain driver is a single file
driver, that supports MT7622/MT7623/MT7629 SoCs.
MT8188 is much more complex and adding it to the current driver will
make it really big and difficult to maintain.

The series is organised as follows:

 - First, some cleanup:
   - drop CONFIG_MTK_POWER_DOMAIN from the defconfigs whose device
     trees have no matching scpsys node. It builds only dead code.
   - remove the enum-based per-SoC dispatch, keeping the per-SoC
     information in the match data.
   - keep the Makefile and Kconfig sorted,

 - Then preparatory refactoring with no functional change:
   - prefix the power_domain_ops callbacks with mtk_,
   - split the monolithic driver into per-SoC drivers
     sharing a common core (selected through a hidden MTK_POWER_DOMAIN
     symbol), and wrap each SoC's domain table in a struct scp_soc_data
     that also carries its size.

 - Extend core driver:
   - rename the flat probe to mtk_scpsys_probe
   - add support for the power-controller model, i.e. per-domain power
     status register offsets, ordered bus-protection steps, per-domain
     clocks and parent domains, and a probe that walks the controller's
     subnodes to build the domain tree.

 - Add the MT8188 power domain driver and enable it on the Genio 510 and
   Genio 700 EVKs.

The existing MT7622/MT7623/MT7629 drivers are functionally unchanged.

Tested on Genio 700 board.

Note: when booting the following warnings are displayed:

  mt8188_power_domain power-controller: power-domain@22: failed to get subsys clk at index 0: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@22
  mt8188_power_domain power-controller: power-domain@30: failed to get subsys clk at index 0: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@30
  mt8188_power_domain power-controller: power-domain@24: failed to get subsys clk at index 0: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@24
  mt8188_power_domain power-controller: power-domain@21: failed to get subsys clk at index 0: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@21
  mt8188_power_domain power-controller: power-domain@13: failed to get clk at index 2: -19
  mt8188_power_domain power-controller: failed to add child domain: power-domain@13

Theses warnings are harmless. They exist because the clock driver is
missing some clock definitions, such as audio. These clock definition can
be added later, when needed.

This series depends on [1] to fix a pericfg-ao clock and on [2] to apply
MAINTAINERS changes properly.

[1]: https://lore.kernel.org/all/20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-v1-1-13109b199248@baylibre.com/

[2]: https://lore.kernel.org/all/20260617024105.152655-1-marek.vasut%2Brenesas@mailbox.org/

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Changes in v2:
- As suggested by David, I used mt7622 naming instead of mt7629 to
  follow the fallback compatible from upstream dt.
- In the same way, I did the same with mt7623 and mt2701
- Link to v1: https://patch.msgid.link/20260708-mt8188-add-power-domain-v1-0-0e930b4f714e@baylibre.com

To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>
Cc: Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Chris-QJ Chen <chris-qj.chen@mediatek.com>
Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Brian Sune <briansune@gmail.com>
Cc: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Cc: Johan Jonker <jbx6244@gmail.com>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Sumit Garg <sumit.garg@oss.qualcomm.com>
Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Sam Shih <sam.shih@mediatek.com>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>
Cc: Weijie Gao <weijie.gao@mediatek.com>
Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
Cc: David Lechner <dlechner@baylibre.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>
Cc: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Raymond Mao <raymond.mao@riscstar.com>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Macpaul Lin <Macpaul.Lin@mediatek.com>
Cc: Carlo Caione <ccaione@baylibre.com>
Cc: Julien Masson <jmasson@baylibre.com>

---
Julien Stephan (14):
      power: domain: keep Makefile and Kconfig sorted
      configs: mediatek: drop unused CONFIG_MTK_POWER_DOMAIN
      power: domain: mediatek: use MT7622 naming instead of MT7629
      power: domain: mediatek: use MT2701 naming instead of MT7623
      power: domain: mediatek: remove enum scp_domain_type
      power: domain: mediatek: prefix internal identifiers with mtk_
      power: domain: mediatek: constify scp_domain_data instances
      power: domain: mediatek: split into per-SoC drivers
      power: domain: mediatek: wrap domain tables in struct scp_soc_data
      power: domain: mediatek: rename mtk_power_domain_probe to mtk_scpsys_probe
      power: domain: mediatek: rename struct mtk_scp_domain to mtk_scpsys
      power: domain: mediatek: add support for the power-controller model
      power: domain: mediatek: add MT8188 power domain driver
      configs: mediatek: enable MT8188 power domain

 MAINTAINERS                                |   1 +
 configs/mt7622_rfb_defconfig               |   2 +-
 configs/mt7623a_unielec_u7623_02_defconfig |   2 +-
 configs/mt7623n_bpir2_defconfig            |   2 +-
 configs/mt7629_rfb_defconfig               |   2 +-
 configs/mt7981_emmc_rfb_defconfig          |   2 -
 configs/mt7981_rfb_defconfig               |   2 -
 configs/mt7981_sd_rfb_defconfig            |   2 -
 configs/mt7986_rfb_defconfig               |   2 -
 configs/mt7986a_bpir3_emmc_defconfig       |   2 -
 configs/mt7986a_bpir3_sd_defconfig         |   2 -
 configs/mt7987_emmc_rfb_defconfig          |   2 -
 configs/mt7987_rfb_defconfig               |   2 -
 configs/mt7987_sd_rfb_defconfig            |   2 -
 configs/mt7988_rfb_defconfig               |   2 -
 configs/mt7988_sd_rfb_defconfig            |   2 -
 configs/mt8188.config                      |   2 +
 drivers/power/domain/Kconfig               |  89 ++--
 drivers/power/domain/Makefile              |  15 +-
 drivers/power/domain/mt2701-power-domain.c |  89 ++++
 drivers/power/domain/mt7622-power-domain.c |  56 +++
 drivers/power/domain/mt8188-power-domain.c | 665 +++++++++++++++++++++++++++++
 drivers/power/domain/mtk-power-domain.c    | 576 ++++++++++++++-----------
 drivers/power/domain/mtk-power-domain.h    | 131 ++++++
 24 files changed, 1352 insertions(+), 302 deletions(-)
---
base-commit: 8101ed2547180109903e9c7a2ecc8e0679c7ec35
change-id: 20260702-mt8188-add-power-domain-488f0c2daaed
prerequisite-message-id: 20260701-mt8188-clk-add-missing-clock-in-pericfg-ao-v1-1-13109b199248@baylibre.com
prerequisite-patch-id: be920ef2f5c93fb8111072d8fb30411d227a52de

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

