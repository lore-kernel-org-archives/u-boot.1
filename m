Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA05CC43458
	for <u-boot@archiver.kernel.org>; Fri, 10 Jul 2026 14:12:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB44F84B14;
	Fri, 10 Jul 2026 16:12:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="Hf6n2Wp4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED8B484B07; Fri, 10 Jul 2026 16:12:53 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D55F984A7A
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 16:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-493ba701891so8425375e9.3
 for <u-boot@lists.denx.de>; Fri, 10 Jul 2026 07:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1783692771; x=1784297571; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FzuR13hgSYW2ims78E2KXWubmp82cbkhGwVRO4NoZN8=;
 b=Hf6n2Wp4sgDYSwyDlMVuDfLkC+SOViHfp2EPChDYUFRGvEu7IMxOGTTnC/+2dWix2p
 y3RM7/rm2FyjMyRJBtQYWqm7arOfhG3BLT+gzszx/x+N63BvyKV8J5hKa4/iPvmzfdOX
 2r92YSJ2+dDCqLfLErVgpTTzpeXSuj/HvR7q/Svhdqupv+kfnnwnRkGxqI2j5vUUr8hU
 0LX4LFDPTPLu7haG9+kiAt47EHyvJPNwjOti5vg7HMYji8OdP4fW7nWsGZEjGOgqxse3
 CgfkHt8euqPiKtKQ5UkfsUcxFyuSBZjRwh/FuvwFti4eezi+RxPhEGE1MvMU25uTW2py
 RvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783692771; x=1784297571;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FzuR13hgSYW2ims78E2KXWubmp82cbkhGwVRO4NoZN8=;
 b=nop2PHtbDvP+MYxEL5DrvSsO3nXYSzY7x1U+tH3Mc15gG5kxetE5ZN7pdr07DpJSsx
 8LaLXdoZPWRhde3SN8OSdNW/A/C1vsK60NfFxjgLciT8XjTff0pj3bhqNJim3d+CDG+B
 l9n1p/dmHQXLHV6kfIe5B/jdTy7N/g5Eg/yCssYAlqZ7Tn+QyuAtBwpAvi2IRGyvBy5R
 690txl4tuyvDnSOpPMsfvN6aWn1JsgWKHpUk19GGxxDJtnBFyXZiTiVhtu0B4JsX/3Oi
 RmmQhsTF44zFdM1FQ86bjZV02xvLpZafwYVYW/4qP6TYiX1NwBf10uztn+awcfD0FpU2
 OYUg==
X-Gm-Message-State: AOJu0YxZH6/eOD6BkcpB66u5WMaCIJ9tFFqcs5WfbUtSdC/5CAOa72ZT
 gaBsAcERSU6jOYAZGaUxO9aJ9K1RRg7l0HPIRMyb8gj9zYuP6r6MB2qAPI2bv5oHGtg=
X-Gm-Gg: AfdE7cl6+lx6MbQ0rEuLyKl5LWEYCEWdw1iypAb/jYzjc2TsQSLQdH+r5XZy8y4XWUq
 LG2H5Sc3kiNvvFI6m8sSh50hkhnNeG3p7K1Bu3H4OCXJhcdSCR7GQXP+Vg/Qx3aj/WE99ALZM1H
 j5xAxhonzqf0FgoNCpiRXmwo2obwUdDYqMw9fcpINXYCuezsUjtx1Lo/WNEb/vy15kJmu3V0ycX
 0V9sXcqHokewIJfJRIgJFG8onbrUX3jWKtVrsbtgK++OoQ03xNvrgz0J6lshri5VsEtPe3SNZMx
 hzccobPMpbMUpQOWYvwSkN/XsYSHaDpD3UPYlGEberpsAg9Lpqysx30Ul95er+I46LvmFPOJS8e
 UvJ4R3O59WPlQMGHpAQ+iiWIsOLbIENhLpgwVtgAUBnaM/teP2DOqUV3zW8XhYamisFjo8hnTeZ
 wVK7MTVj3FZCRw3ieX9YyqMkSMWxF22wzt/1GyBxk/Wl3HVBn45+kGxIcTpIZdrUeOhQkQjujnW
 EwLWp/2U/zI0tATCApvJ4Iof8Q7Rbs+byb+Amnkr45bK1GwKHVB6zF9Gz102i5Cey7MsdM=
X-Received: by 2002:a05:600c:a49:b0:493:ee4d:5c5d with SMTP id
 5b1f17b1804b1-493ee4d60aemr62666505e9.31.1783692771185; 
 Fri, 10 Jul 2026 07:12:51 -0700 (PDT)
Received: from [192.168.1.65]
 (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net.
 [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d88698sm64073205e9.1.2026.07.10.07.12.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:12:50 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Subject: [PATCH 0/9] clk: mediatek: deduplicate clock gate drivers
Date: Fri, 10 Jul 2026 16:12:51 +0200
Message-Id: <20260710-b4-mtk-clk-cleanup-clock-gate-drivers-v1-0-a4b5c491d9bf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWNywrCMBBFf6XM2oEkVC3+irjIY6xjNS0zaRFK/
 91UF5fD2Zy7gpIwKVyaFYQWVh5zFXtoID587gk5VQdn3MmcrcHQ4rsMGF/7yOd5qhzjgL0vhEl
 4IVE0wVnbHZ1PnYXamoTu/Pn9XG9/1zk8KZY9Dtv2BTINwyOJAAAA
X-Change-ID: 20260710-b4-mtk-clk-cleanup-clock-gate-drivers-0b211852ad81
To: u-boot@lists.denx.de
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris Chen <chris-qj.chen@mediatek.com>, 
 Julien Masson <jmasson@baylibre.com>, Daniel Golle <daniel@makrotopia.org>, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.15.2
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

Several MediaTek SoCs expose multiple clock gate controller instances.
In U-Boot, each instance currently requires its own U_BOOT_DRIVER,
mtk_clk_tree, probe() function and compatible table, even though they
all share the same implementation. This results in a significant
amount of duplicated code, and the duplication grows every time a new
clock gate controller is added (for example the ones needed for
upcoming HDMI support on MT8188).

MT8189 already avoids this by using a single generic U_BOOT_DRIVER
shared across all clock gate controller compatibles, with the
SoC-specific gate tables provided through driver data.

This series generalizes that approach. The first patch introduces
struct mtk_gate_clk_data and the MTK_GATE_CLK_DATA() helper in
clk-mtk.h, the second one converts MT8189 to it as the first user, and
the remaining patches convert every SoC that declares more than one
clock gate driver: MT8188, MT7622, MT7623, MT7629, MT7981, MT7988 and
MT8512.

Drivers are only merged when they share the same DM flags and bind()
callback, so device lifecycle (pre-relocation binding/probing, reset
controller binding) is preserved. Controllers that bind a reset
controller keep a dedicated U_BOOT_DRIVER but still share the generic
probe() function.

SoCs with a single clock gate controller (MT7986, MT7987, MT8183,
MT8195, MT8365, MT8516, MT8518) are left untouched since there is no
duplication to remove there.

All conversions are intended to be non-functional changes, with one
exception called out in its commit message: on MT7629 the conversion
fixes an off-by-one in the infracfg gate lookup, whose clock IDs start
at 1 while the driver used a gate offset of 0.

Build-tested using the following command:
./tools/buildman/buildman -b b4/b4-mtk-clk-cleanup-clock-gate-drivers -c 10 -x mips mt7622 mt7623 mt7629 mt7981 mt7986 mt7987 mt7988 mt8183 mt8195 mt8365 mt8512 mt8516 mt8518

Tested on genio-700: clk dump before and after is equivalent (other than
the driver name)

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
Julien Stephan (9):
      clk: mediatek: introduce mtk_gate_clk_data
      clk: mediatek: mt8189: convert to mtk_gate_clk_data
      clk: mediatek: mt8188: convert to mtk_gate_clk_data
      clk: mediatek: mt7622: convert to mtk_gate_clk_data
      clk: mediatek: mt7623: convert to mtk_gate_clk_data
      clk: mediatek: mt7629: convert to mtk_gate_clk_data
      clk: mediatek: mt7981: convert to mtk_gate_clk_data
      clk: mediatek: mt7988: convert to mtk_gate_clk_data
      clk: mediatek: mt8512: convert to mtk_gate_clk_data

 drivers/clk/mediatek/clk-mt7622.c | 113 +++++++++-----------------
 drivers/clk/mediatek/clk-mt7623.c |  67 +++++++---------
 drivers/clk/mediatek/clk-mt7629.c | 109 ++++++++++----------------
 drivers/clk/mediatek/clk-mt7981.c |  66 +++++++---------
 drivers/clk/mediatek/clk-mt7988.c |  74 +++++++-----------
 drivers/clk/mediatek/clk-mt8188.c | 161 ++++++++++----------------------------
 drivers/clk/mediatek/clk-mt8189.c |  26 ++----
 drivers/clk/mediatek/clk-mt8512.c |  52 ++++++------
 drivers/clk/mediatek/clk-mtk.h    |  11 +++
 9 files changed, 252 insertions(+), 427 deletions(-)
---
base-commit: b5fca5f601e5da4955a3ab815f614e1a1300ec2b
change-id: 20260710-b4-mtk-clk-cleanup-clock-gate-drivers-0b211852ad81

Best regards,
--  
Julien Stephan <jstephan@baylibre.com>

