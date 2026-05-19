Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846DBCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 07:49:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAF448460E;
	Tue, 19 May 2026 09:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DUnmKaJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55B6684659; Tue, 19 May 2026 09:48:59 +0200 (CEST)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A81884119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-439a8366831so1268344fac.3
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:48:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779176935; cv=none;
 d=google.com; s=arc-20240605;
 b=ExHc7o3D3ESS7x7IqcO7EPx42SrBsjsopRrK8jbDq26pCZQ7y0Hn3t8/npZKcOpjoW
 EI1AB7kQbuYis9rbQ1QdsVkLtBeLf7EI66ZAvMEWOdz0dSgG84fUgFUMq8kTFUyBpMO6
 lQCGI+tjzoWZh3q2QSAdNNZEmtEHr35QyVMcT823zgwwS7Xy2K2NJUDzwmxXl86uC5Ct
 xUtLZVxXFeZqQhIpDru59BtAauZgwnqJLrcmlHWQgsIowvZEhQr3iDBvRfymrPO1s0Ix
 gOMax30SDaCoJwDFGdRmuHsptT2GKKolW4c97NP6g+3t+mCU8mIWm0lpShF1r51jQ2C9
 wp1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d1FWSUuMkBPtMzC3IDqOkttvMSiT/soEVKADBj6/RCk=;
 fh=qTZ0pDNnDHgLFAdoAh3wNAp27nzSKiZ4Awv94tizT/w=;
 b=SulSXGUTx+e5DpPmY9O7rQrLYHyLaWktIdC7/V4ZUm4LWzIEBIuDYPJ/gMyGO6Ss6X
 K2cq0G63403kyqDfJHqlDXTmWOw4RA2alPnudL44OF9J6Hi6RuwHuWqx8O9QMATlls0g
 j2K5cgaVtxtSts0Mh05CzNnJKKAy2xdubKXdjpvevHyPbizG86gcbrPOioUIz5O09K9n
 g+GQkOLXCJ04+0O3PTPcZ1Glt8EPJINaxB2Y6T6CMP+JSslFjtUNXC/W57eHrWWIT+1j
 eMLBI8A4Rs3SOI0aX12RCnNnjxcYb2vCYRCWzxfH+9cqoIxAIWWH744HgeDVRTk4VyBY
 vXIw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779176935; x=1779781735; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d1FWSUuMkBPtMzC3IDqOkttvMSiT/soEVKADBj6/RCk=;
 b=DUnmKaJ6ud7q43LZKmIS3GFffYQwTW88KROLMxh7KMDTC23EwqgfyKRzRFD8c8yDL7
 t7IPNQbvrGLinFyQtgSLjO9FAGGV2vvrFWXoDY9UK0VyJb6O6NLYKAcuBtjYEk3zfAhy
 ZAfZPhgElsN2GvWDHUIGRYxnEtAMU2I0L3B1pHEr6z8UN7bh1bJigp2URKx+up86XyZN
 4oMDPlI9/h1kbDsaKElAS+m7vqPMqlKMG/kB8W91b9fPmI6FBTQJ0EBOWGnrIMf1Vn7o
 0RdiE7RfH6ezNj5aaJ3/1iY++jBYvadaiFXG8PkJO9CKbma94TaVqoPB4MIU6Cw4pjc7
 lCWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779176935; x=1779781735;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d1FWSUuMkBPtMzC3IDqOkttvMSiT/soEVKADBj6/RCk=;
 b=I9I1zIEXpodnk3TLpn1q/FZjBujuF+wJR1pr1DIKWNAantYcNTItn2uUqoHfYGzwj+
 U3h4Gm8Ql0cQwjzSJ8i5tbwgia8tYJgSFtg1viKNqd+v51QPKHZ+fBqrxx+i2ukjZYoF
 9yX3ZnVXS9UUc2iF1r7uWt92ps8qjRoMhh36IbTwiEFghf2hNRerJcUuB7R9cscUO5CD
 YFzzhQNfkI4Tb3hmfG01/lgfHPSvicyzJLTGnOMfqruud082j9SKIoz25hI99AL48YIT
 z9t7B6+zmqiy2b3h+VghvI2hecDf93mJgsmYK9KYjmcltykYL/qwlbExsAfonpvw/VyP
 5pZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/nQiZ4diXNqM829OkwDoqeAsxXDyp6VIUeVD6Iy80p8CuA41miDZ9TUw00PAZ4h0C9Lck7HvQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzeyCuvxmTvYV8iQafMIq1Bo548VQgZXBDU6BWlYd+GCGh74MQW
 KccFS5L/7+E2FBE/diwqWDqFPtpIWpqM1YZtjuqzRauQERXT2xBa6lf0K1rnhJ6mvGncWNGGzd9
 V+ghM2ApILtRRnAa08hqBYle7/VqhuxiUEWyKDtZ5RA==
X-Gm-Gg: Acq92OEndic4nLyDO29S+fC3zZb4nsRRqlkG7k5Vma2qxsw6HD6AYVTd94kI6OV0Sfw
 BDHQ8w1DPGCPEsAOS9W9/ixcH6todRumgLO9XdZGK4YVau2s5KKXCXltJ0gG284+dX8wC3FYyUT
 LlC4dYpL4HIABj1uNnUPekeFuC96G/zFawnj3enuFtl01MV0q0dAO9hYi2uOpRKEmyF3c0Twbf9
 LQzjPov2qIP7rlmGOqMvaydN49PCLPukUOhTQUWDs8HItwconAc9utd62oLb5Zuj7aVtosRxGey
 xXNxkDFJ63sdiOpbkm2ai80x9wWCfa07VQnfBg==
X-Received: by 2002:a05:6870:a0b6:b0:430:29f5:285f with SMTP id
 586e51a60fabf-43a2dedb1cdmr12235424fac.35.1779176934651; Tue, 19 May 2026
 00:48:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <CAFLszTgdhUO4nTd57atF__z_ox2VSROdxFKP93kr+f4FyW=5Jw@mail.gmail.com>
 <3dfd103f-3a1d-4887-b64d-727900fd9b6b@amd.com>
In-Reply-To: <3dfd103f-3a1d-4887-b64d-727900fd9b6b@amd.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 19 May 2026 09:48:43 +0200
X-Gm-Features: AVHnY4Kn9jykFc-vm1Imha-il-xQ2IzAaM8lGy02C5YXmfT6bfkTZdmqFQTbrK8
Message-ID: <CAHUa44FQLy8cySJoUgYY1ZXnhFUZ-a_cunkNyRcwkVtDZ6tPrQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
To: Michal Simek <michal.simek@amd.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>, 
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
Content-Transfer-Encoding: quoted-printable
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

On Mon, May 11, 2026 at 8:31=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
>
>
>
> On 5/8/26 17:42, Simon Glass wrote:
> > Hi Jens,
> >
> > On Thu, 7 May 2026 at 03:28, Jens Wiklander <jens.wiklander@linaro.org>=
 wrote:
> >>
> >> Hi,
> >>
> >> This is a follow-up to Jerome's patchset [1], addressing previous feed=
back
> >> regarding the monolithic nature of the driver update.
> >>
> >> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven =
years
> >> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux ker=
nel
> >> to u-boot"). Since then, not many kernel changes have been ported back=
 into
> >> U-Boot.
> >>
> >> This series synchronizes the DWC3 core with Linux v6.16-rc7. To provid=
e
> >> a clear audit trail and maintain bisectability, I have structured the
> >> series as follows:
> >>
> >> 1. Restore to Baseline: The first commit reverts U-Boot-specific chang=
es
> >>     to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 s=
tate.
> >> 2. Milestone Imports: A sequence of 50+ commits follows, each performi=
ng
> >>     a "snapshot" import of the drivers/usb/dwc3 directory for every ma=
jor
> >>     kernel version (v3.19 through v6.16-rc7).
> >> 3. U-Boot Adaptation: The final commits (based on Jerome's original wo=
rk)
> >>     re-introduce the necessary glue code, XHCI/UDC updates, and build =
fixes
> >>     required for U-Boot integration.
> >>
> >> The final diff is identical to [1]. I decided to stick with that for n=
ow to
> >> focus on the method of how we import or update the code.
> >>
> >> Note that this is compile-tested only. The CI pipeline on source.denx.=
de
> >> was used as an OK/NOK indicator [2].
> >>
> >> The previous patchset was tested on xilinx_zynqmp_kria_defconfig and s=
ince
> >> this diff is identical to the previous, it should still work on that
> >> platform. With the help of a custom build script [3] and with an addit=
ional
> >> patch [4], I could boot the Kria KV260 board and make it detect a USB =
SSD
> >> plugged into one of its USB 3.0 ports. It certainly doesn't mean all
> >> platforms using the DWC3 driver are still OK, but at least there is so=
me
> >> hope. If this breaks your platform I'd like to know, and if you can se=
nd a
> >> fix it's even better.
> >>
> >> I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. =
There
> >> were a few conflicts, even when backing out the original U-Boot patche=
s on
> >> top of the original v3.19-rc1 import. However, the resulting state sti=
ll
> >> diverged significantly from [1].
> >>
> >> Instead, I've imported each new kernel in a separate commit. That way =
it's
> >> very clear which kernel patches are included. Since there aren't too m=
any
> >> patches for each kernel I'm listing the relevant commits in the U-Boot
> >> commit message for easier reference. I did this with a script so it's =
easy
> >> to make changes, if the approach is OK but we need to tune it. With th=
is
> >> approach it should be easy to tell if a Fixes patch for the kernel mig=
ht
> >> also be needed here.
> >>
> >> Thanks,
> >> Jens
> >>
> >> [1] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.foriss=
ier@linaro.org/
> >> [2] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30=
004
> >> [3] https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/j=
forissier/zynqmp_kv260_build.sh
> >> [4] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/raw/master/me=
ta-trustedsubstrate/recipes-bsp/u-boot/u-boot/zynqmp-kria-starter/0001-kv26=
0-fix-usb.patch
> >>
> >> RFC v1 -> RFC v2:
> >> - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("u=
sb:
> >>    dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: =
import
> >>    from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
> >>
> >> Jens Wiklander (60):
> >>    usb: dwc3: restore to original v3.19-rc1 kernel import
> >>    usb: dwc3: import from kernel v3.19
> >>    usb: dwc3: import from kernel v4.0
> >>    usb: dwc3: import from kernel v4.1
> >>    usb: dwc3: import from kernel v4.2
> >>    usb: dwc3: import from kernel v4.3
> >>    usb: dwc3: import from kernel v4.4
> >>    usb: dwc3: import from kernel v4.5
> >>    usb: dwc3: import from kernel v4.6
> >>    usb: dwc3: import from kernel v4.7
> >>    usb: dwc3: import from kernel v4.8
> >>    usb: dwc3: import from kernel v4.9
> >>    usb: dwc3: import from kernel v4.10
> >>    usb: dwc3: import from kernel v4.11
> >>    usb: dwc3: import from kernel v4.12
> >>    usb: dwc3: import from kernel v4.13
> >>    usb: dwc3: import from kernel v4.14
> >>    usb: dwc3: import from kernel v4.15
> >>    usb: dwc3: import from kernel v4.16
> >>    usb: dwc3: import from kernel v4.17
> >>    usb: dwc3: import from kernel v4.18
> >>    usb: dwc3: import from kernel v4.19
> >>    usb: dwc3: import from kernel v4.20
> >>    usb: dwc3: import from kernel v5.0
> >>    usb: dwc3: import from kernel v5.1
> >>    usb: dwc3: import from kernel v5.2
> >>    usb: dwc3: import from kernel v5.3
> >>    usb: dwc3: import from kernel v5.4
> >>    usb: dwc3: import from kernel v5.5
> >>    usb: dwc3: import from kernel v5.6
> >>    usb: dwc3: import from kernel v5.7
> >>    usb: dwc3: import from kernel v5.8
> >>    usb: dwc3: import from kernel v5.9
> >>    usb: dwc3: import from kernel v5.10
> >>    usb: dwc3: import from kernel v5.11
> >>    usb: dwc3: import from kernel v5.12
> >>    usb: dwc3: import from kernel v5.13
> >>    usb: dwc3: import from kernel v5.14
> >>    usb: dwc3: import from kernel v5.15
> >>    usb: dwc3: import from kernel v5.16
> >>    usb: dwc3: import from kernel v5.17
> >>    usb: dwc3: import from kernel v5.18
> >>    usb: dwc3: import from kernel v5.19
> >>    usb: dwc3: import from kernel v6.0
> >>    usb: dwc3: import from kernel v6.1
> >>    usb: dwc3: import from kernel v6.2
> >>    usb: dwc3: import from kernel v6.3
> >>    usb: dwc3: import from kernel v6.4
> >>    usb: dwc3: import from kernel v6.5
> >>    usb: dwc3: import from kernel v6.6
> >>    usb: dwc3: import from kernel v6.7
> >>    usb: dwc3: import from kernel v6.8
> >>    usb: dwc3: import from kernel v6.9
> >>    usb: dwc3: import from kernel v6.10
> >>    usb: dwc3: import from kernel v6.11
> >>    usb: dwc3: import from kernel v6.12
> >>    usb: dwc3: import from kernel v6.13
> >>    usb: dwc3: import from kernel v6.14
> >>    usb: dwc3: import from kernel v6.15
> >>    usb: dwc3: import from kernel v6.16-rc7
> >>
> >> Jerome Forissier (4):
> >>    usb: host: re-import xhci-ext-caps.h from kernel v6.16-rc7
> >>    usb: gadget: re-import epautoconf.c from kernel v6.16-rc7
> >>    usb: udc: re-import udc-core.c from kernel v6.16-rc7
> >>    usb: fix build after resync of DWC3 with kernel v6.16-rc7
> >>
> >>   drivers/usb/cdns3/ep0.c                |    8 +-
> >>   drivers/usb/common/common.c            |   23 +
> >>   drivers/usb/dwc3/Makefile              |   57 +-
> >>   drivers/usb/dwc3/core.c                | 1780 ++++++----
> >>   drivers/usb/dwc3/core.h                | 1120 +++++--
> >>   drivers/usb/dwc3/debug.h               |  432 +++
> >>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
> >>   drivers/usb/dwc3/ep0.c                 |  737 +++--
> >>   drivers/usb/dwc3/gadget.c              | 4152 ++++++++++++++++------=
--
> >>   drivers/usb/dwc3/gadget.h              |  124 +-
> >>   drivers/usb/dwc3/glue.h                |   36 +
> >>   drivers/usb/dwc3/io.h                  |   29 +-
> >>   drivers/usb/dwc3/linux-compat.h        |   16 -
> >>   drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
> >>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
> >>   drivers/usb/gadget/at91_udc.c          |   46 -
> >>   drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
> >>   drivers/usb/gadget/ci_udc.c            |  419 ---
> >>   drivers/usb/gadget/composite.c         |    2 +-
> >>   drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
> >>   drivers/usb/gadget/epautoconf.c        |  289 +-
> >>   drivers/usb/gadget/ether.c             |   21 +-
> >>   drivers/usb/gadget/f_acm.c             |   20 +-
> >>   drivers/usb/gadget/f_fastboot.c        |   10 +-
> >>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
> >>   drivers/usb/gadget/f_rockusb.c         |   11 +-
> >>   drivers/usb/gadget/f_sdp.c             |   12 +-
> >>   drivers/usb/gadget/f_thor.c            |   19 +-
> >>   drivers/usb/gadget/udc/Makefile        |    1 +
> >>   drivers/usb/gadget/udc/udc-core.c      | 1096 ++++++-
> >>   drivers/usb/host/xhci-dwc3.c           |    4 +-
> >>   drivers/usb/host/xhci-ext-caps.h       |  158 +
> >>   drivers/usb/host/xhci-exynos5.c        |    2 +-
> >>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
> >>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
> >>   drivers/usb/musb-new/musb_uboot.c      |   39 -
> >>   include/dm/device_compat.h             |   13 +
> >>   include/dm/read.h                      |   46 +
> >>   include/linux/compat.h                 |   15 +
> >>   include/linux/usb/ch9.h                |   25 +-
> >>   include/linux/usb/gadget.h             |  520 +--
> >>   include/linux/usb/otg.h                |   10 +
> >>   include/linux/usb/phy.h                |   56 +
> >>   43 files changed, 7659 insertions(+), 4091 deletions(-)
> >>   create mode 100644 drivers/usb/dwc3/debug.h
> >>   create mode 100644 drivers/usb/dwc3/glue.h
> >>   delete mode 100644 drivers/usb/dwc3/linux-compat.h
> >>   delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
> >>   create mode 100644 drivers/usb/host/xhci-ext-caps.h
> >>
> >>
> >> base-commit: 0f865ab5d68484b4dc1724809de1be06edc85df1
>
> Why is it based on such a old commit ID?

I wanted to keep the same diff as in Jerome's original patch so that
we can evaluate the method without distractions.
It seems the method is acceptable, so I'll prepare a rebased version.

Cheers,
Jens

>
> Thanks,
> Michal
>
> commit 0f865ab5d68484b4dc1724809de1be06edc85df1
> Author:     Tom Rini <trini@konsulko.com>
> AuthorDate: Mon Oct 20 13:55:08 2025 -0600
> Commit:     Tom Rini <trini@konsulko.com>
> CommitDate: Mon Oct 20 13:55:37 2025 -0600
>
>      spl: Restore args file being default in falcon mode
>
>      When falcon mode is enabled and SPL_OS_BOOT_SECURE is not enabled,
>      restore the previous default behavior of having an args file be
>      expected. Platforms which are using a FIT image here and do not need
>      this can update at their convenience to disable this option now.
>
>      Fixes: b1a3ed068869 ("spl: make args file optional in falcon mode")
>      Signed-off-by: Tom Rini <trini@konsulko.com>
>
>
