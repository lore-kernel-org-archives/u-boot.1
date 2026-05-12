Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54121CD4F24
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 14:53:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC25838BB;
	Tue, 12 May 2026 16:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flipper.net header.i=@flipper.net header.b="VDobuld/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE0E5838BB; Tue, 12 May 2026 16:53:02 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1EE6D836AC
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 16:53:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@flipper.net
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67bc8609a9bso10331797a12.0
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 07:53:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778597579; cv=none;
 d=google.com; s=arc-20240605;
 b=ixFKB6VJk8EgCMYBDpCCwlF9FrC8l1KOaUiBuBOYRZ537J8Qb92AjEtMAaSqHkN7Qt
 8394FmkQqxjrEu/jWef5eApn+OxDFPcr84F72aEQCCSczhaLmoUpesYkPvliVH9rjNF9
 v0vqNk4YcZ7l6L2xueo/HeIvVDg/juRYkeGLhhP3kmcOdg5dcjvuwz1/1YT1nMtMgBmU
 B8EkknUYGUrQQUaObIie7NGt6NYOXFSzIEKhMy73whV8ifMiixF+Fl2xre1M7zfCEXFL
 tCJv3qrXdkRszCBcFBJnOu/8UC9Rhhb+bRp0/2OKwuLn/FDQVCkp0sT77ESyNAutWQAy
 cfBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jL3T2r9Ap24yxsJytFAi4vCELiQ5F2u7/pzYEEhoRfk=;
 fh=KzXVtgn3nMFX7vG+DNkiW4ml1qZ8UQx8Krr/2kGDix4=;
 b=kamWH75uDxB9/rJx+SKZn/9h0Kdu8ga7f9pB90+3sa/z6d0qO2BdXUqMxXgNFac6On
 Ieb1aEGIdnJVVxCpPkQsr6847VzBqQbUlj1k4h9oFg6KT9kXKDIKawf06NE6kJat/J+M
 KF3NRp2VIkr2zR4CaFtB3fbjq5EszKffm81D3ZXlhsW0yE/epAOHgaRttvcGczJaeFs8
 swn4pwFErT6qU8qq33lLhuTmG2pp9L+LhUJIJKZHLFOakNUpO5kRRStTsqhkUChMJ/H1
 wOQW441bdQB7uTEx+Iww2Za56eg36CPy7NaGNnFbZ5rVcuuz/wkpUvlReiz70+43Sv/B
 cydg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1778597579; x=1779202379; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jL3T2r9Ap24yxsJytFAi4vCELiQ5F2u7/pzYEEhoRfk=;
 b=VDobuld/FYcaB9a6G3w542EgRBVXTbzDcdJGOWX2cYaBVmpSdpfdqoanzbiOE9LXcr
 wM8RMftAlyjEjFJkvOdrhTX0tYBQKHDJbcBiUayg2LgKnRW+/6vgeja1u2MVYl7bBkGM
 OTRtgCV+hcplUSmxnNufoho+vT6aYdAQtB9fPGD84KVMbo7fp8AjYwWyyE7M+uSdSKGa
 qgGrZl5sBE7iSoBOxFrz2y74Nz0E4XE9LYm30FchHGPRv+MX17Al3w7mA5jCXX9Vihkw
 G0XwqO7FZSwbNbPXRacUqilgYAc4Rbzguw9+mtBRxIb0pO7cJKq4EyFzUlyORl8HRSM5
 GEsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778597579; x=1779202379;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jL3T2r9Ap24yxsJytFAi4vCELiQ5F2u7/pzYEEhoRfk=;
 b=gGGf0OTIUaxI7b2uaB0z/I0Kimj6BjovJpyIXr+de3anPgR71BUEWQJNp84ZCNfnlS
 xjwA1xrnFs+GMH9MeY1i/cMgkMUG6l29G+WSTQipJk/EZixCzd23vsHlPUMxwlXRudSi
 08/+N0RliXcRRiaFCgyYfZZiq2tXac4+xD/muqDqdqzYUiYVSuQvnFvWZGg5L2PzVYjD
 pY6emN/9zBXrSoXyKQIRDHnq7J23QCT4Q8BLoLHWQZ4lLWndWI3mFoip7bJDTBnfSw+9
 u6nXn8heL0rnqlMIJ+zS+A0p7NxXHN+KXF8kX+boaJybW51rH/o/tDI0/8TzAdWIvvYR
 C/nA==
X-Gm-Message-State: AOJu0YzUDPd57zTr2gUnhRwo4QZ+L1Lk5DfZ7d/JNWS8y/v4XvCX9S3b
 9lMGk20YgNPYltnS1cnILbYNvns92bG7zgk7cO9mq259oIRBZZrxtT1R+b92Egfy+oXNTnTr/RE
 FZj+qmY0caXDwp+xd0JDuIjzigyYsia40fXNBvdKj1w==
X-Gm-Gg: Acq92OGtPA7KcrG70eWYj/s15WaN+WmQpsTGJKBucZfYgzluLMrQUwXvS81Rxd4dexh
 rw9cQQhFTvUTvg8iA1YV9nf6Zsz4Y4mPKBPmwAs9IX5A9tMZNgec8sGzCesdIdkBEA5VBgHsTQV
 aXyTsLueogkkwPiCa/MKAdSoQs5GWLO6B6rJNXdaEISpEvJMVAWSER5b/GIkQDpLaJQ9eKJnX5M
 wztY6Bw8DQWc7ch0wcik82HMmlrnWd58ypXY9bta8jFXoQYcLCMNk7cYA3ZUSSIsXayh6SMOdqc
 yp238U9sX0xomVJWyvpvQ9CXQQlR6QKc08Y/rt36oOL+hJ/F6n0=
X-Received: by 2002:a17:907:a0c8:b0:ba6:cfb2:c048 with SMTP id
 a640c23a62f3a-bd2901bbd09mr238010766b.43.1778597579401; Tue, 12 May 2026
 07:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-1-jens.wiklander@linaro.org>
From: Alexey Charkov <alchark@flipper.net>
Date: Tue, 12 May 2026 18:52:48 +0400
X-Gm-Features: AVHnY4LGJ5JeA4jpnlXhuwDvPc4Lpgde_GpZS4Ki3v1omgaTVlocbTaiChgijhY
Message-ID: <CAKTNdwE4ydoUt6i=crNnibZV_MQ+BcwfnRbMXsEBtWGc8Myj9w@mail.gmail.com>
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
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>
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

On Tue, May 12, 2026 at 6:44=E2=80=AFPM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi,
>
> This is a follow-up to Jerome's patchset [1], addressing previous feedbac=
k
> regarding the monolithic nature of the driver update.
>
> The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven yea=
rs
> ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kernel
> to u-boot"). Since then, not many kernel changes have been ported back in=
to
> U-Boot.
>
> This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide
> a clear audit trail and maintain bisectability, I have structured the
> series as follows:
>
> 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
>    to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 state=
.
> 2. Milestone Imports: A sequence of 50+ commits follows, each performing
>    a "snapshot" import of the drivers/usb/dwc3 directory for every major
>    kernel version (v3.19 through v6.16-rc7).
> 3. U-Boot Adaptation: The final commits (based on Jerome's original work)
>    re-introduce the necessary glue code, XHCI/UDC updates, and build fixe=
s
>    required for U-Boot integration.
>
> The final diff is identical to [1]. I decided to stick with that for now =
to
> focus on the method of how we import or update the code.
>
> Note that this is compile-tested only. The CI pipeline on source.denx.de
> was used as an OK/NOK indicator [2].
>
> The previous patchset was tested on xilinx_zynqmp_kria_defconfig and sinc=
e
> this diff is identical to the previous, it should still work on that
> platform. With the help of a custom build script [3] and with an addition=
al
> patch [4], I could boot the Kria KV260 board and make it detect a USB SSD
> plugged into one of its USB 3.0 ports. It certainly doesn't mean all
> platforms using the DWC3 driver are still OK, but at least there is some
> hope. If this breaks your platform I'd like to know, and if you can send =
a
> fix it's even better.
>
> I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. The=
re
> were a few conflicts, even when backing out the original U-Boot patches o=
n
> top of the original v3.19-rc1 import. However, the resulting state still
> diverged significantly from [1].
>
> Instead, I've imported each new kernel in a separate commit. That way it'=
s
> very clear which kernel patches are included. Since there aren't too many
> patches for each kernel I'm listing the relevant commits in the U-Boot
> commit message for easier reference. I did this with a script so it's eas=
y
> to make changes, if the approach is OK but we need to tune it. With this
> approach it should be easy to tell if a Fixes patch for the kernel might
> also be needed here.
>
> Thanks,
> Jens
>
> [1] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissier=
@linaro.org/
> [2] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/30004
> [3] https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/jfor=
issier/zynqmp_kv260_build.sh
> [4] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/raw/master/meta-=
trustedsubstrate/recipes-bsp/u-boot/u-boot/zynqmp-kria-starter/0001-kv260-f=
ix-usb.patch
>
> RFC v1 -> RFC v2:
> - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("usb:
>   dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: impo=
rt
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

Hi Jens,

This worked great on a Rockchip RK3576 board. No extra tricks [1] were
needed to initialize USB. Both host and gadget modes work out of the
box (I connected a USB flash drive to the board and exported it to a
computer via `ums 0 usb 0`). Starting, stopping, and restarting works.
Everything looks great.

Tested-by: Alexey Charkov <alchark@flipper.net>

Thanks a lot for your work!

Best regards,
Alexey

[1] https://lore.kernel.org/u-boot/20260427-rk3576-usb-gadget-v1-1-982fd1de=
08db@flipper.net/
