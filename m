Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517CCC43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 08:45:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D8FD841F2;
	Mon, 29 Jun 2026 10:45:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="gkxjPyZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99C96843B6; Mon, 29 Jun 2026 10:45:32 +0200 (CEST)
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com
 [IPv6:2a00:1450:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0713F84105
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 10:45:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-lj1-x236.google.com with SMTP id
 38308e7fff4ca-39664fe2dd8so18134531fa.3
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 01:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782722729; x=1783327529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=d6rIKyCDr3NvVpwOn1VKcr8rDpEfoM4b/0fz8S1NC9o=;
 b=gkxjPyZfzkIeUzSZDh8xxtCBLgoh6ZqAcFYiq2nZptxCupWhDv3WKw4xf3iRqe+av/
 uq8J3Hd1665IDnjEAYP2bL+HH9dVLE1FkZlqo39onLYaMGAm/R/gFr8AlMBV8riU/+m4
 gpfb7Fi7Kq8DI52ZsJzbe5GeZKuXHLgRAVwgx4yeAtoeYQpiA4l/XnJU76NhXDHaLM6W
 te1g97zMmX6Z4s+YUVy5+PWpyjnqMyeBv0rLRUfNymxob40So6XfDssl86vfFt4JvtMy
 NoBTLIZIuWPhp5ABuI1Tne/nZVaL08YDIRqDLkVPRRRXKJRkZH/Q/00oQ1txNz2TNpPD
 Jl4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782722729; x=1783327529;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d6rIKyCDr3NvVpwOn1VKcr8rDpEfoM4b/0fz8S1NC9o=;
 b=J8W6xDj3JcXz7gevnFHLFdcbom8hybVoJWRqpsddOhlyowacD+PR51fQdNpW6naKuC
 NnZU9Qg55pHnH8NEhcSOdfRk6VmkXEAhP6+aixh5OO2J6nQ0DAd4mnn/DeRg3UaBXbXY
 bxXa3l6kiYYaNavTDlNCDonL5qMgWjfU693Dan9J1s8YFL9748fU2I3bm9DXk2cNe9S2
 9hAFt22cFJuLizbd+XX/Zy/m2ej7mmKkw92sRmfo/8OSuYIG6yuQm8g72w/9acXL5fLb
 eCLvrTwLfURfaUqUGtm/wP++UWSD+LKNQJvA16WtYuWomtKul2Sg/RWFXgJIs2QcWZY0
 fHCw==
X-Gm-Message-State: AOJu0YzPzpIwlr7Kkdk35tT6VJxY/pKL+RFrwxq3Bix4kvHQa/ESYe9v
 fyIYFR2c9azy4zinAY0+wFP+0QpGAj2It+ePabsdMfXFsXWl9GIG9Khf1Z6TFZiZ7drHx0/STDD
 K3oOUOd0=
X-Gm-Gg: AfdE7cnOz3mlnBzvQUfIYHHlnyOTGGrPu5/MZbhP1rBgHMwMrHltciB8OouOlMzsNoz
 F7bHRapIWm9AmRKCBYSVZMKK8Hn3gR8Hf3EWIc0lxgxMLbbFvaiO9RR6skJHrDzHoJ3vVZ+UKGw
 agUThaTybJcX+NDvgoTMRFSC7VaVFQEXHbwvFQs31XJFV3GiSCPY5QGFWltOaKiSy17m4vZxCEY
 vzHsLtw4C/ObtOlPQJImMRoVAmb4laU9wmlyeOfNzsocg8jhIBKEOKTbC/QR5AQieQmGXl4/OC0
 6xKNHa6XDhyC/TqVm3Esn2GgOG1HZif+Yh6lfcVnpVhHS8XSudJnBqLgTw8+xPNFEUGyeEdcwNo
 /WABqgYDaDWobWsOSAkIF6B/p7s9lDLLfUW8/PZGW30sjSk/49/+nbwmD5gcsYixzBi5ubipYjC
 yBvjWhHXchx57+Ltlxx80Q04E7HTbaeIKH0mnZaM4h5QjSbJc6j/MTPV0cEh7f3sa1fJifds9OP
 zjpRED9HM4xoo2LEgFv
X-Received: by 2002:a2e:bcd0:0:b0:399:8f2b:c7ba with SMTP id
 38308e7fff4ca-39acb55280fmr33534441fa.5.1782722728832; 
 Mon, 29 Jun 2026 01:45:28 -0700 (PDT)
Received: from rayden.urgonet (h-79-136-84-34.A175.priv.bahnhof.se.
 [79.136.84.34]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3999afc749csm77928251fa.12.2026.06.29.01.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 01:45:27 -0700 (PDT)
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
Subject: [PATCH v4 00/64]  drivers: usb: dwc3: sync code with Linux v6.16
Date: Mon, 29 Jun 2026 10:43:36 +0200
Message-ID: <20260629084507.3254232-1-jens.wiklander@linaro.org>
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

This is a follow up on my last two patchsets [1] [2], where the latter only
with a small change in addition to posting all the patches.

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
3. U-Boot Adaptation: The final commits (based on Jerome's original work [3])
   re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
   required for U-Boot integration.

Note that this is compile-tested only. The CI pipeline on source.denx.de
was used as an OK/NOK indicator [4].

These patches are also available at [5].

Thanks,
Jens

[1] https://lore.kernel.org/u-boot/20260507092843.358908-1-jens.wiklander@linaro.org/
[2] https://lore.kernel.org/u-boot/20260624123025.GA3245275@rayden/
[3] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
[4] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30524
[5] https://github.com/jenswikl/u-boot-1/tree/poc/usb_dwc3_sync_v4

v3 -> v4:
- Restored obj-$(CONFIG_$(PHASE_)USB_DWC3_AM62) for dwc3-am62.o

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
 drivers/usb/dwc3/core.c                | 1710 ++++++----
 drivers/usb/dwc3/core.h                | 1060 ++++--
 drivers/usb/dwc3/debug.h               |  432 +++
 drivers/usb/dwc3/dwc3-omap.c           |    2 -
 drivers/usb/dwc3/ep0.c                 |  737 ++--
 drivers/usb/dwc3/gadget.c              | 4256 ++++++++++++++++--------
 drivers/usb/dwc3/gadget.h              |  112 +-
 drivers/usb/dwc3/glue.h                |   36 +
 drivers/usb/dwc3/io.h                  |   29 +-
 drivers/usb/dwc3/linux-compat.h        |   16 -
 drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
 drivers/usb/dwc3/ti_usb_phy.c          |    2 -
 drivers/usb/gadget/at91_udc.c          |   46 -
 drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
 drivers/usb/gadget/ci_udc.c            |  470 ---
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
 drivers/usb/gadget/udc/udc-core.c      | 1099 +++++-
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
 43 files changed, 7591 insertions(+), 4175 deletions(-)
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/glue.h
 delete mode 100644 drivers/usb/dwc3/linux-compat.h
 delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
 create mode 100644 drivers/usb/host/xhci-ext-caps.h


base-commit: 76d62273bc8a5dc126ed79ed0fb65e5a97359577
-- 
2.43.0

