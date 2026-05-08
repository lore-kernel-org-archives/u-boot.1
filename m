Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EAACD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:43:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0ACB84D74;
	Fri,  8 May 2026 17:42:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="GBlMF/ip";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A5F184D5B; Fri,  8 May 2026 17:42:56 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0019E84D72
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:42:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-67c566cb519so4059249a12.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:42:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254973; cv=none;
 d=google.com; s=arc-20240605;
 b=gs1x73g9VNgxRk6cCQz9QWdTWQbPWbkZxfLfjXS7vKMDZp+FCqL9m6tHUNT9ZjB0wC
 HX7zVRZ5EWr7s09Ct8+H0vb71WM+IR8sjNea/N/75LzphwcDpVnT1O+Jwcru9Mkj4o+6
 dKhuTAGRYLzAON+Y1TbqWGVXOSvJi6CSJ7HJSBzVZWr48RhTHvr+sOBffoUVFcO01zOG
 vRTXzg81hcAC/bQyAFPcj3T7KqKMOTq6yBkg9W92s6twRzJtdSgQ9fYeVY534TCLpGQ8
 76+S2I49O2PRTQReN9lbZv71wch1PxEoBOf4a9O9TNSasL6jq/qebg4/P7u+085XTg6+
 kS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=iZduXr8LEdP88Qov0PBUBX7+MGgX9w1A+fFRq0n7Pjw=;
 fh=4lIJf7IXnpn8Qc1JkkQ3SnyT4EfQxAlWF2VBwUzxZM0=;
 b=EzeqIcC2seXZ4Z0G4uDv651y8v+r0QRoiZFIOphBk1bIuA2d9Y2Dzyg8hUV5cUJdgN
 FQ/O2B8o/pKSvyI7UEt/WnxLBy3aeh9/oJSb4YdwYpbTAiUAL36HFCRdmLqIXg9UAi8n
 1T0JNAG1pkz+rZJse3VmBBxNlLc26AN5vpwUFUDAnfb+QY5wVVVvUMyoRRxWRGH4OVKu
 mD+mOuoiqi7VUOit9Dq40Sg3c0vrW2R8w/BQ8wBJ/Td7lWj5mdaNngnHx6W/7sUEE/T+
 320NK583/S0kERhCHIWLQCY5SExuC6lcrl9GNYohK9tmf4msMhKNY0DoygBJAcpF2RnN
 xwXw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254973; x=1778859773; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iZduXr8LEdP88Qov0PBUBX7+MGgX9w1A+fFRq0n7Pjw=;
 b=GBlMF/ipHBD2nsnBmtiX7U0rqww5JS3/tUjveqS+wIkG6qTYKP/aS+KW4/3MQ0TMmN
 KX6WvpuQCL4vysjzokocyoROH6tK1/y2FhJ4fT37i/NP3oauj/g6UArpPS5ir3fpAbOa
 or6A0Bp3mTIxKNWCq5O5t+P+yGTEC0Pz5JS1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254973; x=1778859773;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iZduXr8LEdP88Qov0PBUBX7+MGgX9w1A+fFRq0n7Pjw=;
 b=GqoDocmaqrE/qBCXekj03PuQ8Dn7ZlN6D4Q6TLkTThsy1UCO4gW1OiGnr/EgnLwLoL
 WBCOnkpW539BQfjBCk0aehhUwXtxXe14ZAqVORhrekAXxod68WBuG79S4WAZtTuYm1mN
 1s6d2Pc0zNW2lN27ZUU7raKr9YN3QNC4sqBjAKQcNILjWnvRRDXD/yu4Ap3pT1YgfTmx
 95R9GqBTPCtrVfEdx5RpKup3uO7Jww7tiy5j0vjaPkzmnZoTOYbFml5sBEIrY4PpMMdh
 5jiNdgkpE3aFT1ChBN9TI/qed67Q7qhr6oMuH4rStgrkNB38pteFmwK5DGaJ3L3SELYx
 9Icw==
X-Gm-Message-State: AOJu0Yxr5INHK0NL0b2s2lJWCMpCQCahIuuAfvlSHWY9n/wx+IaSFxRg
 VLvQ8mQxd/1TT5Q6Ye7aL99H2KVqKSMLi0O2LO87p+0Odn7aOlH2PAxiVqDVUjEVPjXzYXM8lfz
 ntZM/6JU6o/qr2PPcbDze83Ya2ytvtS7MtKdrPIfN
X-Gm-Gg: Acq92OHSSYKc6PTdXDUtm/8BL8sZr+U92+HFe1NrEHcviAlVw9ynq1hi6Dy89gmvwrh
 tYL4hlydj5c6nbBVH9JqLemFVXrv9qcmYC+J8xNDjDmdTjeSjzZYrLJiLGzUZ6q7bUL1ButdkBz
 1kIngrUNDFx0bGjcIncUyRZ61RzulFue1gKSDMUwhOI4UuR3FkBjPfJCuXWhCNU3FK+r1qcImO6
 tq1MWsIth9jbPAnXeEZDc2kB+uXra6fCdoaUgBndaJU9e77oU7MyhNdEqXjIWjsYEflaJTa5ic1
 EYqxdGxSCpP57ceB
X-Received: by 2002:a17:907:1685:b0:bc6:221d:da7e with SMTP id
 a640c23a62f3a-bc6221de068mr716297066b.2.1778254973348; Fri, 08 May 2026
 08:42:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:42:40 -0600
X-Gm-Features: AVHnY4Iuhfiab0ui-p1vXT71JhEG4QWjlboAvPiqijjxQ1Ql62IhUyUaCo9qPwU
Message-ID: <CAFLszTgdhUO4nTd57atF__z_ox2VSROdxFKP93kr+f4FyW=5Jw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Rasmus Villemoes <ravi@prevas.dk>, 
 Ryder Lee <ryder.lee@mediatek.com>,
 Stephan Gerhold <stephan.gerhold@linaro.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, 
 Zixun LI <admin@hifiphile.com>, Jerome Forissier <jerome.forissier@arm.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi Jens,

On Thu, 7 May 2026 at 03:28, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> This is a follow-up to Jerome's patchset [1], addressing previous feedback
> regarding the monolithic nature of the driver update.
>
> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven years
> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> to u-boot"). Since then, not many kernel changes have been ported back into
> U-Boot.
>
> This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide
> a clear audit trail and maintain bisectability, I have structured the
> series as follows:
>
> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
>    to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state.
> 2. Milestone Imports: A sequence of 50+ commits follows, each performing
>    a "snapshot" import of the drivers/usb/dwc3 directory for every major
>    kernel version (v3.19 through v6.16-rc7).
> 3. U-Boot Adaptation: The final commits (based on Jerome's original work)
>    re-introduce the necessary glue code, XHCI/UDC updates, and build fixes
>    required for U-Boot integration.
>
> The final diff is identical to [1]. I decided to stick with that for now to
> focus on the method of how we import or update the code.
>
> Note that this is compile-tested only. The CI pipeline on source.denx.de
> was used as an OK/NOK indicator [2].
>
> The previous patchset was tested on xilinx_zynqmp_kria_defconfig and since
> this diff is identical to the previous, it should still work on that
> platform. With the help of a custom build script [3] and with an additional
> patch [4], I could boot the Kria KV260 board and make it detect a USB SSD
> plugged into one of its USB 3.0 ports. It certainly doesn't mean all
> platforms using the DWC3 driver are still OK, but at least there is some
> hope. If this breaks your platform I'd like to know, and if you can send a
> fix it's even better.
>
> I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. There
> were a few conflicts, even when backing out the original U-Boot patches on
> top of the original v3.19-rc1 import. However, the resulting state still
> diverged significantly from [1].
>
> Instead, I've imported each new kernel in a separate commit. That way it's
> very clear which kernel patches are included. Since there aren't too many
> patches for each kernel I'm listing the relevant commits in the U-Boot
> commit message for easier reference. I did this with a script so it's easy
> to make changes, if the approach is OK but we need to tune it. With this
> approach it should be easy to tell if a Fixes patch for the kernel might
> also be needed here.
>
> Thanks,
> Jens
>
> [1] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier@linaro.org/
> [2] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30004
> [3] https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/jforissier/zynqmp_kv260_build.sh
> [4] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/raw/master/meta-trustedsubstrate/recipes-bsp/u-boot/u-boot/zynqmp-kria-starter/0001-kv260-fix-usb.patch
>
> RFC v1 -> RFC v2:
> - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
>   dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: import
>   from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
>
> Jens Wiklander (60):
>   usb: dwc3: restore to original v3.19-rc1 kernel import
>   usb: dwc3: import from kernel v3.19
>   usb: dwc3: import from kernel v4.0
>   usb: dwc3: import from kernel v4.1
>   usb: dwc3: import from kernel v4.2
>   usb: dwc3: import from kernel v4.3
>   usb: dwc3: import from kernel v4.4
>   usb: dwc3: import from kernel v4.5
>   usb: dwc3: import from kernel v4.6
>   usb: dwc3: import from kernel v4.7
>   usb: dwc3: import from kernel v4.8
>   usb: dwc3: import from kernel v4.9
>   usb: dwc3: import from kernel v4.10
>   usb: dwc3: import from kernel v4.11
>   usb: dwc3: import from kernel v4.12
>   usb: dwc3: import from kernel v4.13
>   usb: dwc3: import from kernel v4.14
>   usb: dwc3: import from kernel v4.15
>   usb: dwc3: import from kernel v4.16
>   usb: dwc3: import from kernel v4.17
>   usb: dwc3: import from kernel v4.18
>   usb: dwc3: import from kernel v4.19
>   usb: dwc3: import from kernel v4.20
>   usb: dwc3: import from kernel v5.0
>   usb: dwc3: import from kernel v5.1
>   usb: dwc3: import from kernel v5.2
>   usb: dwc3: import from kernel v5.3
>   usb: dwc3: import from kernel v5.4
>   usb: dwc3: import from kernel v5.5
>   usb: dwc3: import from kernel v5.6
>   usb: dwc3: import from kernel v5.7
>   usb: dwc3: import from kernel v5.8
>   usb: dwc3: import from kernel v5.9
>   usb: dwc3: import from kernel v5.10
>   usb: dwc3: import from kernel v5.11
>   usb: dwc3: import from kernel v5.12
>   usb: dwc3: import from kernel v5.13
>   usb: dwc3: import from kernel v5.14
>   usb: dwc3: import from kernel v5.15
>   usb: dwc3: import from kernel v5.16
>   usb: dwc3: import from kernel v5.17
>   usb: dwc3: import from kernel v5.18
>   usb: dwc3: import from kernel v5.19
>   usb: dwc3: import from kernel v6.0
>   usb: dwc3: import from kernel v6.1
>   usb: dwc3: import from kernel v6.2
>   usb: dwc3: import from kernel v6.3
>   usb: dwc3: import from kernel v6.4
>   usb: dwc3: import from kernel v6.5
>   usb: dwc3: import from kernel v6.6
>   usb: dwc3: import from kernel v6.7
>   usb: dwc3: import from kernel v6.8
>   usb: dwc3: import from kernel v6.9
>   usb: dwc3: import from kernel v6.10
>   usb: dwc3: import from kernel v6.11
>   usb: dwc3: import from kernel v6.12
>   usb: dwc3: import from kernel v6.13
>   usb: dwc3: import from kernel v6.14
>   usb: dwc3: import from kernel v6.15
>   usb: dwc3: import from kernel v6.16-rc7
>
> Jerome Forissier (4):
>   usb: host: re-import xhci-ext-caps.h from kernel v6.16-rc7
>   usb: gadget: re-import epautoconf.c from kernel v6.16-rc7
>   usb: udc: re-import udc-core.c from kernel v6.16-rc7
>   usb: fix build after resync of DWC3 with kernel v6.16-rc7
>
>  drivers/usb/cdns3/ep0.c                |    8 +-
>  drivers/usb/common/common.c            |   23 +
>  drivers/usb/dwc3/Makefile              |   57 +-
>  drivers/usb/dwc3/core.c                | 1780 ++++++----
>  drivers/usb/dwc3/core.h                | 1120 +++++--
>  drivers/usb/dwc3/debug.h               |  432 +++
>  drivers/usb/dwc3/dwc3-omap.c           |    2 -
>  drivers/usb/dwc3/ep0.c                 |  737 +++--
>  drivers/usb/dwc3/gadget.c              | 4152 ++++++++++++++++--------
>  drivers/usb/dwc3/gadget.h              |  124 +-
>  drivers/usb/dwc3/glue.h                |   36 +
>  drivers/usb/dwc3/io.h                  |   29 +-
>  drivers/usb/dwc3/linux-compat.h        |   16 -
>  drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
>  drivers/usb/dwc3/ti_usb_phy.c          |    2 -
>  drivers/usb/gadget/at91_udc.c          |   46 -
>  drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
>  drivers/usb/gadget/ci_udc.c            |  419 ---
>  drivers/usb/gadget/composite.c         |    2 +-
>  drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
>  drivers/usb/gadget/epautoconf.c        |  289 +-
>  drivers/usb/gadget/ether.c             |   21 +-
>  drivers/usb/gadget/f_acm.c             |   20 +-
>  drivers/usb/gadget/f_fastboot.c        |   10 +-
>  drivers/usb/gadget/f_mass_storage.c    |    5 +-
>  drivers/usb/gadget/f_rockusb.c         |   11 +-
>  drivers/usb/gadget/f_sdp.c             |   12 +-
>  drivers/usb/gadget/f_thor.c            |   19 +-
>  drivers/usb/gadget/udc/Makefile        |    1 +
>  drivers/usb/gadget/udc/udc-core.c      | 1096 ++++++-
>  drivers/usb/host/xhci-dwc3.c           |    4 +-
>  drivers/usb/host/xhci-ext-caps.h       |  158 +
>  drivers/usb/host/xhci-exynos5.c        |    2 +-
>  drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
>  drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
>  drivers/usb/musb-new/musb_uboot.c      |   39 -
>  include/dm/device_compat.h             |   13 +
>  include/dm/read.h                      |   46 +
>  include/linux/compat.h                 |   15 +
>  include/linux/usb/ch9.h                |   25 +-
>  include/linux/usb/gadget.h             |  520 +--
>  include/linux/usb/otg.h                |   10 +
>  include/linux/usb/phy.h                |   56 +
>  43 files changed, 7659 insertions(+), 4091 deletions(-)
>  create mode 100644 drivers/usb/dwc3/debug.h
>  create mode 100644 drivers/usb/dwc3/glue.h
>  delete mode 100644 drivers/usb/dwc3/linux-compat.h
>  delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
>  create mode 100644 drivers/usb/host/xhci-ext-caps.h
>
>
> base-commit: 0f865ab5d68484b4dc1724809de1be06edc85df1
> --
> 2.43.0
>

This makes me wonder what USB tests we have. Some boards use USB for
Ethernet, but are there any storage tests, etc.?

Regards,
Simon
