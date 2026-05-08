Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F482CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E88784D5B;
	Fri,  8 May 2026 18:03:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LXzpfSRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E25E84D66; Fri,  8 May 2026 18:03:20 +0200 (CEST)
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com
 [IPv6:2607:f8b0:4864:20::243])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B430784CAD
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x243.google.com with SMTP id
 5614622812f47-45f053b7b90so1295526b6e.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778256196; x=1778860996; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mwgfAGt64TXHU2LW2ya0pgji9+5KUB4Xehtu4KOO24I=;
 b=LXzpfSRnHLW/4vP2IS4xIfHATCbX24Tq6h6iD89ESn6YZrTpIFzjLYskcWhx4xNcgq
 ljBCYSddwlz/hk29Cuna8+XjUoWavpZy8jJB+sOivz7k7uchjH1evWzTHQOkpnEc1eLH
 dfjeGEHCTRdyUlwQfCgwczSercMaAun+q5Qbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778256196; x=1778860996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mwgfAGt64TXHU2LW2ya0pgji9+5KUB4Xehtu4KOO24I=;
 b=HmOouKZhl2vRdcFlj14paKc/iqKuFVMwo6nsYYuYj5WKPIWWesIxxADutSRc/d2m3t
 gcX/TsieNMcubisnXT7RgzEOQTC+p1E1sWhJ85jppxx0ZHUrWw6ZehPboFtKvSAfSAEg
 4khAvGQz3TOFX1B/KilBCq327QrthMgjoQHG6zczp9sVCj4tWpXuelEVamvXHMCIByeS
 ybbgqegx0nGDyqakmHl62qbdSIMTLH00fF5ZLO68QXjLcxbz6toS6bnv3GGV8N/BSDpP
 XBDzC4GKM5ytVCOTAGct0pQVWK6lM6X35V8cp6wxhPfqLddGDm3WhInb413dW96ObxU4
 8blA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9OkyVcp7/gdECDDn8AGGOb192jWzKBul4pGqz+ea58YLoWLH4UvRkTW9Z9GKyxBlX1OludSKc=@lists.denx.de
X-Gm-Message-State: AOJu0YxTe7BbWhVSvxzmmHx0in5+PS0/Y2immvL0jZp8f+G1vqj6eyZC
 dPO3y0SF/RUc18dJ/Pt4ZS1hWWK7+2bOQ7caSvh2TfUBFTXIuhZVYFz04PtwP92Xs/E=
X-Gm-Gg: AeBDievSaVX7YnWzNcboErgyIjf8btwbhtvEHhn0iYIpOQiU9ChSg7D4UVykS02J8p+
 HUfAtNP9U3JCGYRYb2rTUIgMUelVoqyV2iQeHCxldnbDLi0dCOo8JyFnon3EJV0hvQoycZqn5Au
 B7hnEMOtq3dCM5YbFsl+eSC5kxA/zyGtCKtVnhAM4pCRfo5bcccAaLQK1wRDN1E31yi6280IEPf
 DGwLgjSgUMcfZzhQAZeMlTHX13I97ppVp+tqVQOvvbUABBz/Mretv1F2pp2/SjP9rMtttWN+Sxc
 +QA9BC/tQ2QTwAQw3PNCCYHS2VEiGZCb2vBj1aHqrOrZ0ZaUUwd4BPewsh3V509M2xl57GtZggB
 LhIObMKOkPSsFGruHK1KpNO/ewffg32GpJ44ff802ldLm7FDpMWpejZ1Dao6gT5WMpEelah9GHc
 f4K+OhR1LInNOb+bZdirynfQfPkOPl8Uf3Q0RAO6IdUwESzLe9QS0e9EM31TCE9QgJeTwnKGTYQ
 25+1dWsbsvY99BBkFBKLdoGkpHKkvKJozu1/SylUgmICL9ohk9jobt8Q6Uj6A==
X-Received: by 2002:a05:6808:178d:b0:467:49c0:5f6d with SMTP id
 5614622812f47-4804247a9d2mr7151398b6e.23.1778256187577; 
 Fri, 08 May 2026 09:03:07 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-47c769ca2a6sm14702861b6e.18.2026.05.08.09.03.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:03:06 -0700 (PDT)
Date: Fri, 8 May 2026 10:03:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [RFC PATCH v2 00/64] drivers: usb: dwc3: sync code with Linux
 v6.16-rc7
Message-ID: <20260508160302.GV1614990@bill-the-cat>
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <CAFLszTgdhUO4nTd57atF__z_ox2VSROdxFKP93kr+f4FyW=5Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="60WiFT3YqM9KKBN7"
Content-Disposition: inline
In-Reply-To: <CAFLszTgdhUO4nTd57atF__z_ox2VSROdxFKP93kr+f4FyW=5Jw@mail.gmail.com>
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


--60WiFT3YqM9KKBN7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2026 at 09:42:40AM -0600, Simon Glass wrote:
> Hi Jens,
>=20
> On Thu, 7 May 2026 at 03:28, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
> >
> > Hi,
> >
> > This is a follow-up to Jerome's patchset [1], addressing previous feedb=
ack
> > regarding the monolithic nature of the driver update.
> >
> > The DWC3 USB driver was forked from the Linux kernel v3.19-rc1 eleven y=
ears
> > ago by commit 85d5e7075f33 ("usb: dwc3: add dwc3 folder from linux kern=
el
> > to u-boot"). Since then, not many kernel changes have been ported back =
into
> > U-Boot.
> >
> > This series synchronizes the DWC3 core with Linux v6.16-rc7. To provide
> > a clear audit trail and maintain bisectability, I have structured the
> > series as follows:
> >
> > 1. Restore to Baseline: The first commit reverts U-Boot-specific changes
> >    to drivers/usb/dwc3 to return the directory to a clean v3.19-rc1 sta=
te.
> > 2. Milestone Imports: A sequence of 50+ commits follows, each performing
> >    a "snapshot" import of the drivers/usb/dwc3 directory for every major
> >    kernel version (v3.19 through v6.16-rc7).
> > 3. U-Boot Adaptation: The final commits (based on Jerome's original wor=
k)
> >    re-introduce the necessary glue code, XHCI/UDC updates, and build fi=
xes
> >    required for U-Boot integration.
> >
> > The final diff is identical to [1]. I decided to stick with that for no=
w to
> > focus on the method of how we import or update the code.
> >
> > Note that this is compile-tested only. The CI pipeline on source.denx.de
> > was used as an OK/NOK indicator [2].
> >
> > The previous patchset was tested on xilinx_zynqmp_kria_defconfig and si=
nce
> > this diff is identical to the previous, it should still work on that
> > platform. With the help of a custom build script [3] and with an additi=
onal
> > patch [4], I could boot the Kria KV260 board and make it detect a USB S=
SD
> > plugged into one of its USB 3.0 ports. It certainly doesn't mean all
> > platforms using the DWC3 driver are still OK, but at least there is some
> > hope. If this breaks your platform I'd like to know, and if you can sen=
d a
> > fix it's even better.
> >
> > I tried cherry-picking all the 1000+ patches in v3.19-rc1..v6.16-rc7. T=
here
> > were a few conflicts, even when backing out the original U-Boot patches=
 on
> > top of the original v3.19-rc1 import. However, the resulting state still
> > diverged significantly from [1].
> >
> > Instead, I've imported each new kernel in a separate commit. That way i=
t's
> > very clear which kernel patches are included. Since there aren't too ma=
ny
> > patches for each kernel I'm listing the relevant commits in the U-Boot
> > commit message for easier reference. I did this with a script so it's e=
asy
> > to make changes, if the approach is OK but we need to tune it. With this
> > approach it should be easy to tell if a Fixes patch for the kernel might
> > also be needed here.
> >
> > Thanks,
> > Jens
> >
> > [1] https://lore.kernel.org/all/20251121153812.2076440-1-jerome.forissi=
er@linaro.org/
> > [2] https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/300=
04
> > [3] https://source.denx.de/u-boot/u-boot-extras/-/raw/master/contrib/jf=
orissier/zynqmp_kv260_build.sh
> > [4] https://gitlab.com/Linaro/trustedsubstrate/meta-ts/-/raw/master/met=
a-trustedsubstrate/recipes-bsp/u-boot/u-boot/zynqmp-kria-starter/0001-kv260=
-fix-usb.patch
> >
> > RFC v1 -> RFC v2:
> > - Split the v1 ("usb: dwc3: re-import from kernel v6.16-rc7") into ("us=
b:
> >   dwc3: restore to original v3.19-rc1 kernel import"),  ("usb: dwc3: im=
port
> >   from kernel v3.19)..("usb: dwc3: import from kernel v6.16-rc7")
> >
> > Jens Wiklander (60):
> >   usb: dwc3: restore to original v3.19-rc1 kernel import
> >   usb: dwc3: import from kernel v3.19
> >   usb: dwc3: import from kernel v4.0
> >   usb: dwc3: import from kernel v4.1
> >   usb: dwc3: import from kernel v4.2
> >   usb: dwc3: import from kernel v4.3
> >   usb: dwc3: import from kernel v4.4
> >   usb: dwc3: import from kernel v4.5
> >   usb: dwc3: import from kernel v4.6
> >   usb: dwc3: import from kernel v4.7
> >   usb: dwc3: import from kernel v4.8
> >   usb: dwc3: import from kernel v4.9
> >   usb: dwc3: import from kernel v4.10
> >   usb: dwc3: import from kernel v4.11
> >   usb: dwc3: import from kernel v4.12
> >   usb: dwc3: import from kernel v4.13
> >   usb: dwc3: import from kernel v4.14
> >   usb: dwc3: import from kernel v4.15
> >   usb: dwc3: import from kernel v4.16
> >   usb: dwc3: import from kernel v4.17
> >   usb: dwc3: import from kernel v4.18
> >   usb: dwc3: import from kernel v4.19
> >   usb: dwc3: import from kernel v4.20
> >   usb: dwc3: import from kernel v5.0
> >   usb: dwc3: import from kernel v5.1
> >   usb: dwc3: import from kernel v5.2
> >   usb: dwc3: import from kernel v5.3
> >   usb: dwc3: import from kernel v5.4
> >   usb: dwc3: import from kernel v5.5
> >   usb: dwc3: import from kernel v5.6
> >   usb: dwc3: import from kernel v5.7
> >   usb: dwc3: import from kernel v5.8
> >   usb: dwc3: import from kernel v5.9
> >   usb: dwc3: import from kernel v5.10
> >   usb: dwc3: import from kernel v5.11
> >   usb: dwc3: import from kernel v5.12
> >   usb: dwc3: import from kernel v5.13
> >   usb: dwc3: import from kernel v5.14
> >   usb: dwc3: import from kernel v5.15
> >   usb: dwc3: import from kernel v5.16
> >   usb: dwc3: import from kernel v5.17
> >   usb: dwc3: import from kernel v5.18
> >   usb: dwc3: import from kernel v5.19
> >   usb: dwc3: import from kernel v6.0
> >   usb: dwc3: import from kernel v6.1
> >   usb: dwc3: import from kernel v6.2
> >   usb: dwc3: import from kernel v6.3
> >   usb: dwc3: import from kernel v6.4
> >   usb: dwc3: import from kernel v6.5
> >   usb: dwc3: import from kernel v6.6
> >   usb: dwc3: import from kernel v6.7
> >   usb: dwc3: import from kernel v6.8
> >   usb: dwc3: import from kernel v6.9
> >   usb: dwc3: import from kernel v6.10
> >   usb: dwc3: import from kernel v6.11
> >   usb: dwc3: import from kernel v6.12
> >   usb: dwc3: import from kernel v6.13
> >   usb: dwc3: import from kernel v6.14
> >   usb: dwc3: import from kernel v6.15
> >   usb: dwc3: import from kernel v6.16-rc7
> >
> > Jerome Forissier (4):
> >   usb: host: re-import xhci-ext-caps.h from kernel v6.16-rc7
> >   usb: gadget: re-import epautoconf.c from kernel v6.16-rc7
> >   usb: udc: re-import udc-core.c from kernel v6.16-rc7
> >   usb: fix build after resync of DWC3 with kernel v6.16-rc7
> >
> >  drivers/usb/cdns3/ep0.c                |    8 +-
> >  drivers/usb/common/common.c            |   23 +
> >  drivers/usb/dwc3/Makefile              |   57 +-
> >  drivers/usb/dwc3/core.c                | 1780 ++++++----
> >  drivers/usb/dwc3/core.h                | 1120 +++++--
> >  drivers/usb/dwc3/debug.h               |  432 +++
> >  drivers/usb/dwc3/dwc3-omap.c           |    2 -
> >  drivers/usb/dwc3/ep0.c                 |  737 +++--
> >  drivers/usb/dwc3/gadget.c              | 4152 ++++++++++++++++--------
> >  drivers/usb/dwc3/gadget.h              |  124 +-
> >  drivers/usb/dwc3/glue.h                |   36 +
> >  drivers/usb/dwc3/io.h                  |   29 +-
> >  drivers/usb/dwc3/linux-compat.h        |   16 -
> >  drivers/usb/dwc3/samsung_usb_phy.c     |   77 -
> >  drivers/usb/dwc3/ti_usb_phy.c          |    2 -
> >  drivers/usb/gadget/at91_udc.c          |   46 -
> >  drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
> >  drivers/usb/gadget/ci_udc.c            |  419 ---
> >  drivers/usb/gadget/composite.c         |    2 +-
> >  drivers/usb/gadget/dwc2_udc_otg.c      |  174 +-
> >  drivers/usb/gadget/epautoconf.c        |  289 +-
> >  drivers/usb/gadget/ether.c             |   21 +-
> >  drivers/usb/gadget/f_acm.c             |   20 +-
> >  drivers/usb/gadget/f_fastboot.c        |   10 +-
> >  drivers/usb/gadget/f_mass_storage.c    |    5 +-
> >  drivers/usb/gadget/f_rockusb.c         |   11 +-
> >  drivers/usb/gadget/f_sdp.c             |   12 +-
> >  drivers/usb/gadget/f_thor.c            |   19 +-
> >  drivers/usb/gadget/udc/Makefile        |    1 +
> >  drivers/usb/gadget/udc/udc-core.c      | 1096 ++++++-
> >  drivers/usb/host/xhci-dwc3.c           |    4 +-
> >  drivers/usb/host/xhci-ext-caps.h       |  158 +
> >  drivers/usb/host/xhci-exynos5.c        |    2 +-
> >  drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
> >  drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
> >  drivers/usb/musb-new/musb_uboot.c      |   39 -
> >  include/dm/device_compat.h             |   13 +
> >  include/dm/read.h                      |   46 +
> >  include/linux/compat.h                 |   15 +
> >  include/linux/usb/ch9.h                |   25 +-
> >  include/linux/usb/gadget.h             |  520 +--
> >  include/linux/usb/otg.h                |   10 +
> >  include/linux/usb/phy.h                |   56 +
> >  43 files changed, 7659 insertions(+), 4091 deletions(-)
> >  create mode 100644 drivers/usb/dwc3/debug.h
> >  create mode 100644 drivers/usb/dwc3/glue.h
> >  delete mode 100644 drivers/usb/dwc3/linux-compat.h
> >  delete mode 100644 drivers/usb/dwc3/samsung_usb_phy.c
> >  create mode 100644 drivers/usb/host/xhci-ext-caps.h
> >
> >
> > base-commit: 0f865ab5d68484b4dc1724809de1be06edc85df1
> > --
> > 2.43.0
> >
>=20
> This makes me wonder what USB tests we have. Some boards use USB for
> Ethernet, but are there any storage tests, etc.?

We've had test/py/tests/test_usb.py for two years now, and so yes, we
have some hardware tests for USB functionality. I haven't tried getting
them enabled in the sage labe, but it's on the TODO list. Along with our
DFU tests, again.

--=20
Tom

--60WiFT3YqM9KKBN7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaf4JMgAKCRAr4qD1Cr/k
CpYgAP9aGqxW4kRNtaZmRAgGkXLbFefZttbIVJ6Q4mp9oibSIwD/SENVqs1HXDVx
ZEKx44AB2SqJUibC5wlfZFNVnO2aqgc=
=ZdsO
-----END PGP SIGNATURE-----

--60WiFT3YqM9KKBN7--
