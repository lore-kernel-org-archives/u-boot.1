Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35449CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 12:30:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BDEE846E1;
	Wed, 24 Jun 2026 14:30:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WEIzPg6v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94BA848DC; Wed, 24 Jun 2026 14:30:33 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A48484671
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 14:30:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6978f1eeb87so1596787a12.0
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 05:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782304230; x=1782909030; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Zj+MHkyP1C84Qx7cmGF2yRQSnNeHTJdoz4j1fWQfGHs=;
 b=WEIzPg6vIIYKCJdnjWkG+Xc79jOywMspDv02PlXIzp2ocqo5ltp/mnHq2x8BX8udPQ
 ex3Zshw4GkRId+fNNaoY7D4f9SZWPKvEl9ivw5qfoC8pWmP0dK5VUG0VnIiR/INSE5KK
 h1rdJpBMsy07GcNnAlKOG86KK5bFPNsuGV6CKCr7Wwa8g56K0rYZHuDYmk2wLk9t9i2i
 I4Qh/T6x/K3UmXnEKY30mhRwa8MedvWSrDMELZigygLk+qOozu2Ye5vMvqZz1zsx261K
 LYrVlfkeEo0kjzIxM8LAJjTYvfSLxDwrpUZNz2GbbJoizLl2GA5owPD2G+yesQM6hnbR
 hE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782304230; x=1782909030;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zj+MHkyP1C84Qx7cmGF2yRQSnNeHTJdoz4j1fWQfGHs=;
 b=TngjNab2IG91TOaKR15Z/iqwzC0n+P6OHrFAcgt5TAsR3uU7d9nf7Dznf5vidDXF00
 8AGjVIm74HMWD1Yu5yhbr2/X9cbHpWg6rPBRakWnJ79NFrKGKQFaRXIOHl37YlmqH78R
 O60iqBz824HiGknI0I5Bc3wqsO1gRY5RnJ5DCuUVoJu7czspdDv9XI5BDxAHcV0FhVzx
 KoTDrma8Nn/vi50x7PFjSJfqfrxTQDc0/3FbtHZwnX66X+WvnhgwIHKXDcU/VJb9AIsU
 riedIPwWmLXQ1+o3Jx4oNLtNGtIhYMZn0VCnVMv3fA7A6fQQQedEagCTYOPfgVxPEer5
 mPMw==
X-Gm-Message-State: AOJu0YzFsS/u/T5aBOEAoj05bI2mtBqaSdWZH9eOzwrlQw8DMoze3vgY
 e80Gvfx2pQxtW5/fuq/WfuV81skXcQhMMSbw9U195D/6bmie4B54znAOs+mgy3N2RcwWroybg10
 sbjBh/1M=
X-Gm-Gg: AfdE7cnsrCsiFLw+bWcp7zaqzsvHn56UnmgH9sWED7dIzWjtzFegT0O/GJbgM01hYja
 8YQLZW3SxbWc4dy3n6FRP7yuJF9X77+kiHcsC7Dj8Mrvstc2zHu4728wJqjPXvqRJrEgvsP46wK
 eipB92pF0hFeoD6uw8RXPg+f9PdIesOCAKYuCNZIhbjF+D0oUoliznYUvudbrWMC4M7HVlDGiuy
 mC6kMNJgPwauDrFWM1jeLr3T/vYE/1ZNVOQmoptOsdOqgOjdvdECtr9qmQrqIEe+ewjexdIuRro
 Mnk3jR/ywuvokgYlI9ncWpVPD+YPQ8nIQaXsE/K6C1THIY3rllpUeWpOKGZBfV+GbkFJBL5lThD
 J7anAbsAmTwIPp9fCCUoLabxvX8Fi0Q3n3mLhH4bFXyCCUHo1HLoPKE6qcfSY8eQub68DOQxGGH
 dUl2B/mjNnZDRQtTCoNA1ZSPmK3F5xY/CQQViK9v4sDpI4JPLrIDYUuQC4RHGFe0nrCJi5/AjdL
 QzhfLoViA==
X-Received: by 2002:a05:6402:3227:b0:697:edf5:20d1 with SMTP id
 4fb4d7f45d1cf-697f3771108mr1604869a12.6.1782304230185; 
 Wed, 24 Jun 2026 05:30:30 -0700 (PDT)
Received: from rayden (h-79-136-84-34.A175.priv.bahnhof.se. [79.136.84.34])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-697f46e15b1sm1038288a12.16.2026.06.24.05.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:30:28 -0700 (PDT)
Date: Wed, 24 Jun 2026 14:30:25 +0200
From: Jens Wiklander <jens.wiklander@linaro.org>
To: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
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
 Rasmus Villemoes <ravi@prevas.dk>,
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Chintan Vankar <c-vankar@ti.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: [PATCH v3] drivers: usb: dwc3: sync code with Linux v6.16
Message-ID: <20260624123025.GA3245275@rayden>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

This is a follow up on my last patchset [1]. I'm addressing feedback on
the previous post. Since there's quite a few patches I've published a
branch instead as requestsed. Last in this mail follows a summary of the
branch (it looks like a pull request, but I'm only reusing a well-known
format, it's not intended as a pull request at this stage).

The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
to u-boot"). Since then, not many kernel changes have been ported back into
U-Boot.

This series synchronizes the DWC3 core with Linux v6.16. To provide 
a clear audit trail and maintain bisectability, I have structured the 
series as follows:

1. Restore to Baseline: The first commit reverts U-Boot-specific changes 
   to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
2. Milestone Imports: A sequence of 50+ commits follows, each performing 
   a "snapshot" import of the drivers/usb/dwc3 directory for every major 
   kernel version (v3.19 through v6.16). 
3. U-Boot Adaptation: The final commits (based on Jerome's original work [2]) 
   re-introduce the necessary glue code, XHCI/UDC updates, and build fixes 
   required for U-Boot integration.

Note that this is compile-tested only. The CI pipeline on source.denx.de
was used as an OK/NOK indicator [3]. 

Thanks,
Jens

[1] https://lore.kernel.org/u-boot/20260507092843.358908-1-jens.wiklander@linaro.org/
[2] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[3] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30524

RFC v2 -> v3:
- Rebased on v2026.07-rc3
- Configured out a few prints in drivers/usb/gadget/udc/udc-core.c
  to make it build for am335x_evm_defconfig
- Applied provided tags in [1]
- Published as a branch

RFC v1 -> RFC v2:
- Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
  dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
  from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")


The following changes since commit 76d62273bc8a5dc126ed79ed0fb65e5a97359577:

  Prepare v2026.07-rc3 (2026-05-25 11:05:37 -0600)

are available in the Git repository at:

  https://github.com/jenswikl/u-boot tags/usb-dwc3-sync-v3

for you to fetch changes up to 2e3b14270a8e9dc5e6836f0f011fd97d491a89f7:

  usb: fix build after resync of DWC3 with kernel v6.16 (2026-06-24 09:48:03 +0200)

----------------------------------------------------------------
drivers: usb: dwc3: sync code with Linux v6.16

----------------------------------------------------------------
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
      usb: dwc3: import from kernel v6.16

Jerome Forissier (4):
      usb: host: re-import xhci-ext-caps.h from kernel v6.16
      usb: gadget: re-import epautoconf.c from kernel v6.16
      usb: udc: re-import udc-core.c from kernel v6.16
      usb: fix build after resync of DWC3 with kernel v6.16

 drivers/usb/cdns3/ep0.c                |    8 +-
 drivers/usb/common/common.c            |   23 +
 drivers/usb/dwc3/Makefile              |   57 +-
 drivers/usb/dwc3/core.c                | 1710 ++++++++-----
 drivers/usb/dwc3/core.h                | 1060 ++++++--
 drivers/usb/dwc3/debug.h               |  432 ++++
 drivers/usb/dwc3/dwc3-omap.c           |    2 -
 drivers/usb/dwc3/ep0.c                 |  737 +++---
 drivers/usb/dwc3/gadget.c              | 4256 ++++++++++++++++++++++----------
 drivers/usb/dwc3/gadget.h              |  112 +-
 drivers/usb/dwc3/glue.h                |   36 +
 drivers/usb/dwc3/io.h                  |   29 +-
 drivers/usb/dwc3/linux-compat.h        |   16 -
 drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
 drivers/usb/dwc3/ti_usb_phy.c          |    2 -
 drivers/usb/gadget/at91_udc.c          |   46 -
 drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
 drivers/usb/gadget/ci_udc.c            |  470 ----
 drivers/usb/gadget/composite.c         |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
 drivers/usb/gadget/epautoconf.c        |  289 +--
 drivers/usb/gadget/ether.c             |   21 +-
 drivers/usb/gadget/f_acm.c             |   20 +-
 drivers/usb/gadget/f_fastboot.c        |   10 +-
 drivers/usb/gadget/f_mass_storage.c    |    5 +-
 drivers/usb/gadget/f_rockusb.c         |   11 +-
 drivers/usb/gadget/f_sdp.c             |   12 +-
 drivers/usb/gadget/f_thor.c            |   19 +-
 drivers/usb/gadget/udc/Makefile        |    1 +
 drivers/usb/gadget/udc/udc-core.c      | 1099 ++++++++-
 drivers/usb/host/xhci-dwc3.c           |    4 +-
 drivers/usb/host/xhci-ext-caps.h       |  158 ++
 drivers/usb/host/xhci-exynos5.c        |    2 +-
 drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
 drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
 drivers/usb/musb-new/musb_uboot.c      |   39 -
 include/dm/device_compat.h             |   13 +
 include/dm/read.h                      |   46 +
 include/linux/compat.h                 |   15 +
 include/linux/usb/ch9.h                |   25 +-
 include/linux/usb/gadget.h             |  520 +---
 include/linux/usb/otg.h                |   10 +
 include/linux/usb/phy.h                |   56 +
 43 files changed, 7591 insertions(+), 4175 deletions(-)
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/glue.h
 delete mode 100644 drivers/usb/dwc3/linux-compat.h
 delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
 create mode 100644 drivers/usb/host/xhci-ext-caps.h
