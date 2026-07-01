Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637E0C43327
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:30:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB7BE84C25;
	Wed,  1 Jul 2026 19:30:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TLg/igfN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22AAC84C3C; Wed,  1 Jul 2026 19:30:13 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C322F84C19
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:30:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7eb29ed2bbdso275937a34.2
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782927009; x=1783531809; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NKEx9KEZyRhjXwbqatWlGmTBRkBUaW/8kt945Sa9hH0=;
 b=TLg/igfN/nt0lG69eBauYZzWLjTcr66BLSxZHj+VGTsl+ylcsDusuSVVwyt4elYV06
 Khpp8bpxuUzu0lOZXW1mMbyGSkC+lFlu/cKHnDsARns5XuMqbWycG5Urna0BGsTa1Qb7
 XasEAvXDa9UPnt/3LwiAjvE9or2Hf3TjwWabU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782927009; x=1783531809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NKEx9KEZyRhjXwbqatWlGmTBRkBUaW/8kt945Sa9hH0=;
 b=aR3krTx7ZMaKTO6NmKvtQZg1dDyHNxii2xFndnVyVwryVvYg7A/IrIxK9gUKXD7EGU
 bwHigl3PAo7jK3wEY3TF2K1DDfjq8hiOV/lYQhUOf0uTCYOfe64rBipN+T07k14/r6QQ
 ex4qoW7wnRh6IOR9+b0GyAjxPGfmjfhHRuTYysMdMFv3WJcCdxAEmTOeMNRo1WbS75Am
 LA6sF2xzB2gCY60zwmEpbirqI5evrToNgMYcsDCjTLIdNm0YIbh04UkcmZxHoEZpPTfH
 uhsDdIEHVxE69RIvh25w9DZgsqvolxE+uDah4FEAWYriItI/bdcO9SSaKCHv+9UaCBD2
 U7eA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/49cupSB+/rH0Bz22c1TD26Nh2al6jKcW8404o0bV1gyLctaQBHAfmU0i/AmvE1YMl5z1e1Q8=@lists.denx.de
X-Gm-Message-State: AOJu0YzrV/pYBgNJ86flJDQ6abIu9X/PNwUeYJd5FfKD6chjIxoAw698
 BLtvz4FcAZIIG1hWJjwNZ/XRTe0AHwYQUYWRtUZtab5jNB3pNmVGiMoFBsPaJ73lYtw=
X-Gm-Gg: AfdE7cn+Ee5JgDI/4lAf3TmzuxuD1Um50fO7AiIJGcxpeJqYUPM5QhPEmHSYk4XxhsP
 hueDTEiuGnKv89Plvj15e30tmncixCU3dId5fu5+Dr4GiHUbSxRB3WinettBKC49kMs5hlsOulc
 ZVf6C/5CuHAUfsQPXJ/CAE5PJEURscJo7z61uBUXA6Je3pVY85/DJOrzzXx5HCCYKmanJCd9oWJ
 g6gwbQ502vxrMy2hBnPz1lzdNJDnyDFeHXcRxpNufKTgU7BoHpi1YG1Cd9gOvMf4LfXc2Llq04W
 jlC/EROJO9jemof5ZET+aYKPEzfot9+9qofawLz5Q5GvjAFEDuoMsNGec16WbZKQxPIhB5BAiyv
 n9btT/SZ2l/QSB7BXD/4kQZQERyysgaj+iS5KXxwnM+XLaa+baIKz3AQvSzwNHXUnBE8/iNoeq+
 LvYzAIQP+82zbL7BXKfG/XkBz/Qb5hETgke/B0GBjYOvZpTEbtg/HKkG9GtH4FfHe7J9i2vQfrJ
 oyv57d776GOZxKuTbngWt59a3iWzmLxgzxMuQ==
X-Received: by 2002:a05:6830:488d:b0:7e9:b4cf:683d with SMTP id
 46e09a7af769-7eb4cc98d3bmr1543002a34.29.1782927009094; 
 Wed, 01 Jul 2026 10:30:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7eb542ebf72sm635570a34.9.2026.07.01.10.30.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:30:08 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:30:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Marek Vasut <marex@nabladev.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, Lukasz Majewski <lukma@denx.de>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>,
 Ryder Lee <ryder.lee@mediatek.com>, Simon Glass <sjg@chromium.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Alexey Charkov <alchark@flipper.net>
Subject: Re: [PATCH v4 64/64] usb: fix build after resync of DWC3 with kernel
 v6.16
Message-ID: <20260701173004.GM749385@bill-the-cat>
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-65-jens.wiklander@linaro.org>
 <81d73d59-c56f-45a2-8db6-8741ea6ab1a5@nabladev.com>
 <87se636kyg.fsf@kernel.org>
 <CAC_iWjJ88yXAopCqVGOW=Q2i_XX7Ojrkq4e8cfP8tmPz9+jr-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EgMwLvsaS0//s7RO"
Content-Disposition: inline
In-Reply-To: <CAC_iWjJ88yXAopCqVGOW=Q2i_XX7Ojrkq4e8cfP8tmPz9+jr-g@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--EgMwLvsaS0//s7RO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 01, 2026 at 08:03:22PM +0300, Ilias Apalodimas wrote:
> Hi Mattjis
>=20
> On Wed, 1 Jul 2026 at 13:52, Mattijs Korpershoek
> <mkorpershoek@kernel.org> wrote:
> >
> > On Tue, Jun 30, 2026 at 12:38, Marek Vasut <marex@nabladev.com> wrote:
> >
> > > On 6/29/26 10:44 AM, Jens Wiklander wrote:
> > >> From: Jerome Forissier <jerome.forissier@linaro.org>
> > >>
> > >> Fix build errors after the re-sync of the DWC3 driver with the kerne=
l.
> > >> U-Boot has different needs than the kernel: buses, interrupts, inter=
nal
> > >> APIs (DMA, traces, DT...) so many adaptations are required. This com=
mit
> > >> re-introduces many of the changes that were done locally after the
> > >> initial import of the DWC3 code from kernel 3.19-rc1 11 years ago, as
> > >> well as other fixes. This is compile-tested only.
> > >>
> > >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> > >> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > >> Tested-by: Alexey Charkov <alchark@flipper.net>
> > >> ---
> > >>   drivers/usb/cdns3/ep0.c                |    8 +-
> > >>   drivers/usb/common/common.c            |   23 +
> > >>   drivers/usb/dwc3/Makefile              |   57 +-
> > >>   drivers/usb/dwc3/core.c                | 1761 ++++++--------------=
----
> > >>   drivers/usb/dwc3/core.h                |   39 +-
> > >>   drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
> > >>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
> > >>   drivers/usb/dwc3/ep0.c                 |  110 +-
> > >>   drivers/usb/dwc3/gadget.c              |  786 +++--------
> > >>   drivers/usb/dwc3/gadget.h              |    4 +-
> > >>   drivers/usb/dwc3/io.h                  |   28 +-
> > >>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
> > >>   drivers/usb/gadget/at91_udc.c          |   46 -
> > >>   drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
> > >>   drivers/usb/gadget/ci_udc.c            |  470 -------
> > >>   drivers/usb/gadget/composite.c         |    2 +-
> > >>   drivers/usb/gadget/dwc2_udc_otg.c      |  174 +--
> > >>   drivers/usb/gadget/epautoconf.c        |    2 -
> > >>   drivers/usb/gadget/ether.c             |   21 +-
> > >>   drivers/usb/gadget/f_acm.c             |   20 +-
> > >>   drivers/usb/gadget/f_fastboot.c        |   10 +-
> > >>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
> > >>   drivers/usb/gadget/f_rockusb.c         |   11 +-
> > >>   drivers/usb/gadget/f_sdp.c             |   12 +-
> > >>   drivers/usb/gadget/f_thor.c            |   19 +-
> > >>   drivers/usb/gadget/udc/Makefile        |    1 +
> > >>   drivers/usb/gadget/udc/udc-core.c      | 1026 +++-----------
> > >>   drivers/usb/host/xhci-dwc3.c           |    4 +-
> > >>   drivers/usb/host/xhci-exynos5.c        |    2 +-
> > >>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
> > >>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
> > >>   drivers/usb/musb-new/musb_uboot.c      |   39 -
> > >>   include/dm/device_compat.h             |   13 +
> > >>   include/dm/read.h                      |   46 +
> > >>   include/linux/compat.h                 |   15 +
> > >>   include/linux/usb/ch9.h                |   25 +-
> > >>   include/linux/usb/gadget.h             |  520 ++-----
> > >>   include/linux/usb/otg.h                |   10 +
> > >>   include/linux/usb/phy.h                |   56 +
> > >>   39 files changed, 1351 insertions(+), 4584 deletions(-)
> > > This patch needs to be split up, this is unreviewable, sorry.
> >
> > I agree with Marek, this is quite difficult to review. Can we split it,
> > please?
>=20
> Sure this is reasonable. As long as we all agree that the current
> approach of rebasing is acceptable. This will make the 'breakage'
> window a little bigger, but as long as it's explicitly mentioned in
> the commit messages, I personally don't mind

I also think that while not ideal, but especially if we bring this in as
a merge commit (in other words, b4 shazam -SM it, then include that
merge commit in the USB PR), we can limit the range of bisectability
not being possible. Since you can test commits manually when doing a
bisect, a "git checkout ...tree prior to this merge commit...", test and
confirm this being where the problem is, or isn't. And then if we can
commit to keeping in-sync in the future, we'll be more easily able to
drop in the changes from kernel release N-1 to kernel release N, without
the whole undo-and-redo-U-Boot-support dance.

--=20
Tom

--EgMwLvsaS0//s7RO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCakVOnAAKCRAr4qD1Cr/k
ConvAP49chYAB5liSbP2QCASJBahi17nguH3x15B6rovU3l75QEAnAY0yXlbUSwQ
PVu9HxWE9WR4S9tVcFxE5Vz7OYI/FAU=
=BxRU
-----END PGP SIGNATURE-----

--EgMwLvsaS0//s7RO--
