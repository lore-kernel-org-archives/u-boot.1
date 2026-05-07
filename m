Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36723CD3442
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 09:29:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3CF0584A29;
	Thu,  7 May 2026 11:29:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fUyTG6bH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9DAD84A40; Thu,  7 May 2026 11:29:03 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAC6784A17
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 11:28:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5a748d5ece4so519764e87.2
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778146132; x=1778750932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HlVi512RfxiQlBkIO/4co82v6RdZ9TzgrSDQR044eT4=;
 b=fUyTG6bH4CeIVga0Lfn6aaioNrD5Nyi4Zola0FhmidufCi5n5et1XJ3CWsQ29geL86
 YofXAAeFE5mlBNuACISJWvCbXkEhfkEOBAQgbjW750+ijVsXZwtb1/Oan60h+v9E+iCh
 gtbZsgthicPj9VLn5pHKAxbjshkiXy671LN23piTwXa1iS34nGwdToehDdqpGsR8UkG6
 Gd2ZkH9AfdTAacbCfQDqucyYbeXBybdcoYwUVH/Qu2QzH4Gw71QdTzvUYOQjAh0StHBB
 DFcVlZudQSF6Ib1peinupPTbDV8tRjJKP8ON1tSSIJJBc3iHuaSD5zN6hn9oP55UlvsX
 i7WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778146132; x=1778750932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HlVi512RfxiQlBkIO/4co82v6RdZ9TzgrSDQR044eT4=;
 b=q8J3BvZcRr2QxFQErTwAqsa/tq3YBkM7UlltURzhucZuRCfgaUeQPNuh96DtE+Yqos
 kXGFEMYzWkcwdH6kGeP24OilqWNnLNgOm+AL1Wiwe4icMp8y6mPyL4YOuHvd8tC1Sfnd
 c1RJQ/AKAO1sjEQRGc6phq6dyZ76lUO3O31h9fcR8DoTS6Gdvx/oRIPTeRNDJgalytmd
 p7f3iGFn5rQFXD6qyZCH6IrdROUoRoAbObWPtokKLS9DN0+MormevPH/G2Rw3/XK9H7g
 k8Nkaz41KXPxZl1A7mizHkVcYGm/hEy6KbqVwSmcCmnlnwEMvrZaG5ShTzZATu3bxUkh
 eDrw==
X-Gm-Message-State: AOJu0YwnKNpjqiREZG2qaPKUeu4/0kHB3ywWoQ0t/zjAzpwl1nAoTzrM
 KbgW14zWAcvHecDM0m9aXOUvb1e6D9Bsknt+yQ6fMwXjS0uJ2FZNjVUUleQC5FchR/Dxc2E0zJA
 NE0KpUf6xgg==
X-Gm-Gg: AeBDieuBfRRylUf7JH5oC+RxKnXpBp/CtpUR1C76s8+WYWw9m6S/U3TaGqhHz/Sx9cC
 b169f/f3o8ANBun/YpjrdOMP88k1EzxS5c78IjxrAF50TBPpBWCOzdC/zN6uKs3SHD4INpylQS6
 M0zoDyvZu/F68O6PopwuFpPjxQirOqftsvrUG9tYe0O4tbRnc7e4fvZr3+wkyUj3fs3pR02soNB
 1ZpbQIARseZL6xFVLHpydTNz1iIOIPhOV9XDYsYG/z5yewVxJVR1l1qxW7otCo7IQwbDZFuXtkl
 BkITmkUDdXbYWft3wRZIr2bTtY1PVClrt+CLheoWGSUeDvwfIx6bGAyQXBVeyBZ97cxBrYZSmLm
 QzjTz7C5xTQXIuVeu/Tkg1FX4wb9yQ3eUjWSLs5UICiG0Pt0/MRgAOIthZVGlFDOmr1TBLllBkJ
 Aduwx3KdEjy9ncY6r08XWhmR/UaduVVd3gwkL8nWAerQ7L3jxD60KGNmrVo/zS1keVMy7C6CShz
 PFHVO4IL5tZ2Q8JElKxHgkOpQOfgPCwtv5vGgqwJ6Oh1cQ9DA9p8HHpbKpYx/k=
X-Received: by 2002:a05:6512:2247:b0:5a8:8df8:1dca with SMTP id
 2adb3069b0e04-5a88df8291emr1825912e87.29.1778146131914; 
 Thu, 07 May 2026 02:28:51 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8914953d6sm696937e87.73.2026.05.07.02.28.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:28:51 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de,
	Marek Vasut <marex@denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jens Wiklander <jens.wiklander@linaro.org>
Subject: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
Date: Thu,  7 May 2026 11:27:07 +0200
Message-ID: <20260507092843.358908-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.43.0
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

Hi,

This is a follow-up to Jerome's patchset [1], addressing previous feedback
regarding the monolithic nature of the driver update.

The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
to u-boot"). Since then, not many kernel changes have been ported back into
U-Boot.

This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide 
a clear audit trail and maintain bisectability, I have structured the 
series as follows:

1. Restore to Baseline: The first commit reverts U-Boot-specific changes 
   to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
2. Milestone Imports: A sequence of 50+ commits follows, each performing 
   a "snapshot" import of the drivers/usb/dwc3 directory for every major 
   kernel version (v3.19 through v6.16-rc7). 
3. U-Boot Adaptation: The final commits (based on Jerome's original work) 
   re-introduce the necessary glue code, XHCI/UDC updates, and build fixes 
   required for U-Boot integration.

The final diff is identical to [1]. I decided to stick with that for now to
focus on the method of how we import or update the code.

Note that this is compile-tested only. The CI pipeline on source.denx.de
was used as an OK/NOK indicator [2]. 

The previous patchset was tested on xilinx_zynqmp_kria_defconfig and since
this diff is identical to the previous, it should still work on that
platform. With the help of a custom build script [3] and with an additional
patch [4], I could boot the Kria KV260 board and make it detect a USB SSD
plugged into one of its USB 3.0 ports. It certainly doesn't mean all
platforms using the DWC3 driver are still OK, but at least there is some
hope. If this breaks your platform I'd like to know, and if you can send a
fix it's even better.

I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. There
were a few conflicts, even when backing out the original U-Boot patches on
top of the original v3.19-rc1 import. However, the resulting state still
diverged significantly from [1].

Instead, I've imported each new kernel in a separate commit. That way it's
very clear which kernel patches are included. Since there aren't too many
patches for each kernel I'm listing the relevant commits in the U-Boot
commit message for easier reference. I did this with a script so it's easy
to make changes, if the approach is OK but we need to tune it. With this
approach it should be easy to tell if a Fixes patch for the kernel might
also be needed here.

Thanks,
Jens

[1] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[2] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30004
[3] https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/jforissier/zynqmp_kv260_build.sh
[4] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/raw/master/meta-trustedsubstrate/recipes-bsp/u-boot/u-boot/zynqmp-kria-starter/0001-kv260-fix-usb.patch

RFC v1 -> RFC v2:
- Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
  dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
  from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")

Jens Wiklander (60):
  usb: dwc3: restore to original v3.19-rc1 kernel import
  usb: dwc3: import from kernel v3.19
  usb: dwc3: import from kernel v4.0
  usb: dwc3: import from kernel v4.1
  usb: dwc3: import from kernel v4.2
  usb: dwc3: import from kernel v4.3
  usb: dwc3: import from kernel v4.4
  usb: dwc3: import from kernel v4.5
  usb: dwc3: import from kernel v4.6
  usb: dwc3: import from kernel v4.7
  usb: dwc3: import from kernel v4.8
  usb: dwc3: import from kernel v4.9
  usb: dwc3: import from kernel v4.10
  usb: dwc3: import from kernel v4.11
  usb: dwc3: import from kernel v4.12
  usb: dwc3: import from kernel v4.13
  usb: dwc3: import from kernel v4.14
  usb: dwc3: import from kernel v4.15
  usb: dwc3: import from kernel v4.16
  usb: dwc3: import from kernel v4.17
  usb: dwc3: import from kernel v4.18
  usb: dwc3: import from kernel v4.19
  usb: dwc3: import from kernel v4.20
  usb: dwc3: import from kernel v5.0
  usb: dwc3: import from kernel v5.1
  usb: dwc3: import from kernel v5.2
  usb: dwc3: import from kernel v5.3
  usb: dwc3: import from kernel v5.4
  usb: dwc3: import from kernel v5.5
  usb: dwc3: import from kernel v5.6
  usb: dwc3: import from kernel v5.7
  usb: dwc3: import from kernel v5.8
  usb: dwc3: import from kernel v5.9
  usb: dwc3: import from kernel v5.10
  usb: dwc3: import from kernel v5.11
  usb: dwc3: import from kernel v5.12
  usb: dwc3: import from kernel v5.13
  usb: dwc3: import from kernel v5.14
  usb: dwc3: import from kernel v5.15
  usb: dwc3: import from kernel v5.16
  usb: dwc3: import from kernel v5.17
  usb: dwc3: import from kernel v5.18
  usb: dwc3: import from kernel v5.19
  usb: dwc3: import from kernel v6.0
  usb: dwc3: import from kernel v6.1
  usb: dwc3: import from kernel v6.2
  usb: dwc3: import from kernel v6.3
  usb: dwc3: import from kernel v6.4
  usb: dwc3: import from kernel v6.5
  usb: dwc3: import from kernel v6.6
  usb: dwc3: import from kernel v6.7
  usb: dwc3: import from kernel v6.8
  usb: dwc3: import from kernel v6.9
  usb: dwc3: import from kernel v6.10
  usb: dwc3: import from kernel v6.11
  usb: dwc3: import from kernel v6.12
  usb: dwc3: import from kernel v6.13
  usb: dwc3: import from kernel v6.14
  usb: dwc3: import from kernel v6.15
  usb: dwc3: import from kernel v6.16-rc7

Jerome Forissier (4):
  usb: host: re-import xhci-ext-caps.h from kernel v6.16-rc7
  usb: gadget: re-import epautoconf.c from kernel v6.16-rc7
  usb: udc: re-import udc-core.c from kernel v6.16-rc7
  usb: fix build after resync of DWC3 with kernel v6.16-rc7

 drivers/usb/cdns3/ep0.c                |    8 +-
 drivers/usb/common/common.c            |   23 +
 drivers/usb/dwc3/Makefile              |   57 +-
 drivers/usb/dwc3/core.c                | 1780 ++++++----
 drivers/usb/dwc3/core.h                | 1120 +++++--
 drivers/usb/dwc3/debug.h               |  432 +++
 drivers/usb/dwc3/dwc3-omap.c           |    2 -
 drivers/usb/dwc3/ep0.c                 |  737 +++--
 drivers/usb/dwc3/gadget.c              | 4152 ++++++++++++++++--------
 drivers/usb/dwc3/gadget.h              |  124 +-
 drivers/usb/dwc3/glue.h                |   36 +
 drivers/usb/dwc3/io.h                  |   29 +-
 drivers/usb/dwc3/linux-compat.h        |   16 -
 drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
 drivers/usb/dwc3/ti_usb_phy.c          |    2 -
 drivers/usb/gadget/at91_udc.c          |   46 -
 drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
 drivers/usb/gadget/ci_udc.c            |  419 ---
 drivers/usb/gadget/composite.c         |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
 drivers/usb/gadget/epautoconf.c        |  289 +-
 drivers/usb/gadget/ether.c             |   21 +-
 drivers/usb/gadget/f_acm.c             |   20 +-
 drivers/usb/gadget/f_fastboot.c        |   10 +-
 drivers/usb/gadget/f_mass_storage.c    |    5 +-
 drivers/usb/gadget/f_rockusb.c         |   11 +-
 drivers/usb/gadget/f_sdp.c             |   12 +-
 drivers/usb/gadget/f_thor.c            |   19 +-
 drivers/usb/gadget/udc/Makefile        |    1 +
 drivers/usb/gadget/udc/udc-core.c      | 1096 ++++++-
 drivers/usb/host/xhci-dwc3.c           |    4 +-
 drivers/usb/host/xhci-ext-caps.h       |  158 +
 drivers/usb/host/xhci-exynos5.c        |    2 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
 drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
 drivers/usb/musb-new/musb_uboot.c      |   39 -
 include/dm/device_compat.h             |   13 +
 include/dm/read.h                      |   46 +
 include/linux/compat.h                 |   15 +
 include/linux/usb/ch9.h                |   25 +-
 include/linux/usb/gadget.h             |  520 +--
 include/linux/usb/otg.h                |   10 +
 include/linux/usb/phy.h                |   56 +
 43 files changed, 7659 insertions(+), 4091 deletions(-)
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/glue.h
 delete mode 100644 drivers/usb/dwc3/linux-compat.h
 delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
 create mode 100644 drivers/usb/host/xhci-ext-caps.h


base-commit: 0f865ab5d68484b4dc1724809de1be06edc85df1
-- 
2.43.0

