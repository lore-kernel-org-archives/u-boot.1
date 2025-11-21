Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD5D9CFC28A
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 15:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00AF7839A8;
	Fri, 21 Nov 2025 16:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r3rAT34b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08E708393F; Fri, 21 Nov 2025 16:38:32 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3F3B28393F
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 16:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-42b2dc17965so2074889f8f.3
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 07:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763739508; x=1764344308; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=x65YsGCTHJoH0UOxWWyMtcUW2qJhq7EMXfn6o7pxFoQ=;
 b=r3rAT34bZT6n0L1HZccVKzEqw0siD/vVkQ5RMNT4xqMFy0N3gntQZj2TTVwfvWI+jh
 4quthaaOiZfDQm+WSIj8Gto0SkYj/a9cyEjRiOayGPiwm9WUDOi1dscWCkfmL35kGfkm
 +YuTs3bu+hqEm9ko0SwMw6xNc2BNMhDcxAO9oweYogdeFe7eNGlnxgWFv00dpiNlDYHL
 8l48fVn0n72EwKNyb3iKRq+Bi9WKUMYL5nrPO3eJukmA5yRhbahrSMBTbXmBjzb9Ipf1
 ejrbkU3VmSZkXtTSVQJlWl1IHgWJhfm1ZjZdudMi3RzsgP5b9QKi+JcXzLXZ0njHw3Sv
 n99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763739508; x=1764344308;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x65YsGCTHJoH0UOxWWyMtcUW2qJhq7EMXfn6o7pxFoQ=;
 b=RJBnAaiZkUSaGtQz0wDVAw/Db3oxIokAyTT1lLy2mRHd09uRS7kuWbT0Si8E+U0oOJ
 S3B/mjwZ8w5/vr3skeV27y8plvhGGGcfk/SUZn2VP8msWGlj3rPTs9wo8HJYidaag1S8
 rRhQPRDFuVACCYSDSBGpOwAtf8msf9sAdloBZJJox3DedJGs3lJXZhiARkXhg88q4si0
 maczX0DrVURhHt3Vj4xlBV8If2oY5WxbMrw+pf1zoku61hlJ9nbe6eClPg9HSmqJAfp9
 znqty28MGqLrt5ZzQVYlHu8JjcXBI9NgBIzmeMZmnPo3HvNO4pVevJRIG39Hilp1PwtD
 2eMA==
X-Gm-Message-State: AOJu0YyVLG0VPkvwkltIBpNgPvE22aI3EVQaIus6kDCP0XJ1Go52S1o3
 BMxBTz8ZUOWRSiWVkhHR7sCyxzEL5mgK3HRu7mZ64DBElihlZwlK4/WzalfZghdw4CqtUhwbPqL
 8tPgQ
X-Gm-Gg: ASbGncvRwiH3BdHHqE/T40i7jEg2O3jCzWwAjoYD9rsvAJkbNb0l6jR9ibhB7FlFaDR
 s2ZDgTP0I3iLOsTFx4td5zyT/H2IVSpdg3UKbv0bLCh93kQqlqgrrElY79Y9PYN3XgYxRo3qxja
 gnTBgxP9yPtWq4fZsRkj1F++tqI10tSncXTepTvJ9e0LbWDWAIboxTrAXYikyow2Z+oQMnxY7YN
 DbQIzfWKd1/FRazs784z7kPhB5fi6985J2iQOJfI1Nu8GzUPxqJSnYB3oVjD9wrnom4E4HFCL7r
 Yq/mWF+fQZHxYuSzodEWoB58u9bzTc7ie+IwG9IQBn06ZnAS9TICMmDAPmJT2CMa3Ik9lu0D8N1
 b86u1ys9TkDcqnt2yBjbOQBgGZBfpmThqSvv3E/wVeFb1anX7Brvkk77Skk9RVIijkum491sfU8
 Rylsvd28ww6DSijQRqfS0=
X-Google-Smtp-Source: AGHT+IHbRrSQkZwcbqr1VwwfKGAILVG/tw7LUqbQuH/8jZNFBoKWzQx3eHeVR06jPGT07emiydfcPQ==
X-Received: by 2002:a05:6000:40cb:b0:42b:2fc8:18c with SMTP id
 ffacd0b85a97d-42cc1d15526mr2853078f8f.32.1763739508370; 
 Fri, 21 Nov 2025 07:38:28 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:2035:a57d:e702:e09e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fd9b45sm11487964f8f.43.2025.11.21.07.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 07:38:28 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>
Subject: [RFC PATCH 0/5] drivers: usb: dwc3: sync code with Linux v6.16-rc1
Date: Fri, 21 Nov 2025 16:37:49 +0100
Message-ID: <20251121153812.2076440-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.48.1
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

The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven
years ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux
kernel to u-boot"). Since then, not many kernel changes have been ported
back into to U-Boot. This series is an attempt at synchronizing the code
with a somewhat current kernel (namely, v6.16.rc7 which was the latest
released when this effort was started).

- The first three commits ("usb: dwc3: re-import from kernel v6.16-rc7",
  "usb: host: re-import xhci-ext-caps.h from kernel", usb: gadget:
  re-import epautoconf.c from kernel v6.16-rc7" and "usb: udc: re-import
  udc-core.c from kernel v6.16-rc7") replace files with their counterpart
  from the kernel, unmodified.
- The last commit ("usb: fix build after resync of DWC3 with kernel
  v6.16-rc7") makes the necessary changes to adapt to U-Boot and fix the
  build.

Note that this is mostly compile-tested only. The CI pipeline on
source.denx.de was used as a OK/NOK indicator [0]. Only one config was
actually tested on real hardware: xilinx_zynqmp_kria_defconfig. With the
help of a custom build script [1] and with an additional patch [2], I
could boot the Kria KV260 board and make it detect a USB SSD plugged into
one of its USB 3.0 ports. It certainly doesn't mean all platforms using
the DWC3 driver are still OK, but at least there is some hope. If this
breaks your platform I'd like to know, and if you can send a fix it's
even better.

I realize this is a big change and I did it this way essentially to get
going and be able to post this RFC. But I am not saying this is the way
the re-sync has to be done. Feedback is welcome.

[0] https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/28449
[1] https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/jforissier/zynqmp_kv260_build.sh
[2] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/raw/master/meta-trustedsubstrate/recipes-bsp/u-boot/u-boot/zynqmp-kria-starter/0001-kv260-fix-usb.patch


Jerome Forissier (5):
  usb: dwc3: re-import from kernel v6.16-rc7
  usb: host: re-import xhci-ext-caps.h from kernel v6.16-rc7
  usb: gadget: re-import epautoconf.c from kernel v6.16-rc7
  usb: udc: re-import udc-core.c from kernel v6.16-rc7
  usb: fix build after resync of DWC3 with kernel v6.16-rc7

 drivers/usb/cdns3/ep0.c                |    8 +-
 drivers/usb/common/common.c            |   23 +
 drivers/usb/dwc3/Makefile              |   57 +-
 drivers/usb/dwc3/core.c                | 1810 +++++++----
 drivers/usb/dwc3/core.h                | 1112 +++++--
 drivers/usb/dwc3/debug.h               |  432 +++
 drivers/usb/dwc3/dwc3-omap.c           |    2 -
 drivers/usb/dwc3/ep0.c                 |  761 +++--
 drivers/usb/dwc3/gadget.c              | 4114 ++++++++++++++++--------
 drivers/usb/dwc3/gadget.h              |  124 +-
 drivers/usb/dwc3/glue.h                |   36 +
 drivers/usb/dwc3/io.h                  |   29 +-
 drivers/usb/dwc3/linux-compat.h        |   16 -
 drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
 drivers/usb/dwc3/ti_usb_phy.c          |    2 -
 drivers/usb/gadget/at91_udc.c          |   46 -
 drivers/usb/gadget/atmel_usba_udc.c    |  110 +-
 drivers/usb/gadget/ci_udc.c            |  419 ---
 drivers/usb/gadget/composite.c         |    2 +-
 drivers/usb/gadget/dwc2_udc_otg.c      |  186 +-
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
 43 files changed, 7673 insertions(+), 4105 deletions(-)
 create mode 100644 drivers/usb/dwc3/debug.h
 create mode 100644 drivers/usb/dwc3/glue.h
 delete mode 100644 drivers/usb/dwc3/linux-compat.h
 delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
 create mode 100644 drivers/usb/host/xhci-ext-caps.h

-- 
2.48.1

base-commit: 0f865ab5d68484b4dc1724809de1be06edc85df1
branch: usb-dwc3-resync2
