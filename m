Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D68C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 09:11:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2106384A1F;
	Tue, 30 Jun 2026 11:11:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kunv/K5t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 606FD84A27; Tue, 30 Jun 2026 11:11:46 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57CB384869
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 11:11:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-7e9483cd614so399600a34.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 02:11:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782810702; cv=none;
 d=google.com; s=arc-20260327;
 b=kLgZ8W7yWma/ovhifLrP7SITvzLuBSimyPR7RWrvhxhbiK9CRDjkxwl1WTD/sKO/xp
 94caogsTQ4eyqZR5y4YukF2m5oCJfWTyW2YeHEgasiPanjW4E/ceLVrEtq04mgz3VZFO
 8OkECxZjobC3tgjZNHvwS682KdNAIR32B8jkQuIcx1CeWaWQFgthmNx+wK75mtW7fz7f
 N3Qi+DT/VmXCY/a1AVoovqIb59HYywKOihM1HDznNimIwio5F2rDxaGfrcSNNKOHHDUB
 nJ46HXH7cjcIHnt4Qe4gEuxFa2NSTYLLEtzqwDRBOcLStPN0szTQb1+v2svcMLNLihFe
 BDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nbPUALf7VGq0fR0vQUQB5kOl4vcIMWJNMG2zdo53JxU=;
 fh=/zObRmlwo2qijiiD9XDPQyCkwHyIo2emU0+TjLh7BCM=;
 b=hepA/213rusgFPun+F0n+XXhNpySlcOayuhN/ooHWQUSvemxvr490oDlD4MKispjZX
 0nVsoaytgYilr6KKexwYNpVI7Q1XlOVoUylQtA7VmyyjjmnDXfgTKkZQ9DMje0Vblu8R
 n8UzvCDjP1HM3hqJchJHdhgJiWaDUVprJqrEYIhU+Z940k2L5Z1Iv/XAWN41eI1IZ1jI
 i1qneyqFiQw6o14DweZ2xzWl5v14lT+jRopvXLEZmOro4MLWrT7mOAwfwH9OBSdMdAhL
 cQKDsmS775MPOt6cDKrSdy9KueD2sDa7i3eV+RCe1AyVfB+Qee9gpmht8dcJRNgztA2D
 F45A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782810702; x=1783415502; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nbPUALf7VGq0fR0vQUQB5kOl4vcIMWJNMG2zdo53JxU=;
 b=Kunv/K5t5LsqtD9RO/RKD6WJSkyo9sP+tGD2os4Y1VjJREjfZ9pgR2B0aeRjzpjf1f
 6hvR+FYui+Dvl4435uJN7sg+naKuMMw1Wga83cwmosq8dsJwxrcMU3uImjTHfW3TiYqV
 uGY+eBcx2aymuLIT6ExBg9ipMluyH8P18rG7r1LDrBQzhojzDAoK+5QyHcwof1L7Ym+2
 WE9O07qvhVBGf6yV4xv6yY8VyqOkMiu9owSaH9X92Bdrn0tY6Dn3c1qmiLcEHw/cCvCA
 1zWZrLohX15lCWOnc/TjLw5y9WkfYZALIeXfFP3+tSuSNxln1SKQfKMvzT8Nm2oPkcrA
 ZtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782810702; x=1783415502;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nbPUALf7VGq0fR0vQUQB5kOl4vcIMWJNMG2zdo53JxU=;
 b=aVih/jwkqaUiiMw0JFe0CXg+cqDKhyUHmEEHzbinDTQZtXmUWuI2mvbZmNfcg7Q4Ei
 y9mDReGNLqNC06bJOR8IGAczJEWcKH6cP58zL05XrMc29l0/spLFBfIzLmnYAnf2Y7cx
 wIDEAEZff2JRHh0LdX257vD6BnMmwX2cdRPfJAAOAeY7lIXeu5g6/NTWBJsWhvxIT/aa
 5zHXbXk5yRMkMhr/qxkP/z8USBNeOR0bqNFdGuqVhUj5x/NuoEEbYYMq8WF3RS1bZZZI
 DZ9kab0kafCVQj2oaUDNKRl/Vfdz4vYqrH9jhgoOEOMH7u4CxXITHm4Tso68DEgUqI3r
 L9oA==
X-Gm-Message-State: AOJu0YxMeEY+441wZDWW5GcGA9Xdmv7UhhT+skh8gmTp2+KQJBBPx41W
 L7C25XootiC839lwT/eFz5q2oJjNczgXvYzW6wiQcuKTnxN32lQi0XuEt3DxZEF/85BBMEvkzJ0
 zeJrs5v9wMKbCcDuDYjzKkq27oYt4Z7YBBb3HohQIYg==
X-Gm-Gg: AfdE7clG6lOAda6mEwX3TeX131/HR43yreSSrveNWgcDVmvqjqMH6eTuqEceJtsFgWG
 VSffF2c0d9+qZ6iUuBMKArLvNQ3HGznwgcHq/W4Xam5lobBUSBN4YxKCa+2iYjAa3gGskwmj0T8
 DLwHjtIF1XXakO7LZtmPKfr/ySh48W9yfBPaP8vaXOK4JSMZIGik5LFBFP2fr2lwQCu9fTtTFp+
 ZsLbCzwL3bJSDTlre29TkSW7zroEJu7jVnTQw3ITdCJa1vLRZujymbuoZy+pzgBc5+NLWl1YH6N
 mka6LnOumTKUUrXl7zMcjcklQR0=
X-Received: by 2002:a05:6820:6ae2:b0:6a0:c657:1648 with SMTP id
 006d021491bc7-6a19222c6fcmr472434eaf.26.1782810701891; Tue, 30 Jun 2026
 02:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-20-jens.wiklander@linaro.org>
 <7dd650b5-2d08-45cc-8d7f-c9bee56de4a8@nabladev.com>
In-Reply-To: <7dd650b5-2d08-45cc-8d7f-c9bee56de4a8@nabladev.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 30 Jun 2026 11:11:29 +0200
X-Gm-Features: AVVi8CewnrpuCuYpjG4goEx8Rw3bhtC-zlb200jDjauaTE_BhRsWQ17O4tarL2c
Message-ID: <CAHUa44FQ6b4siyBnOdEz2cBs9rrRNCgGC=-s0h2gkGG79dLADA@mail.gmail.com>
Subject: Re: [PATCH v4 19/64] usb: dwc3: import from kernel v4.16
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
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
 Jerome Forissier <jerome.forissier@arm.com>,
 Alexey Charkov <alchark@flipper.net>
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

On Tue, Jun 30, 2026 at 11:04=E2=80=AFAM Marek Vasut <marex@nabladev.com> w=
rote:
>
> On 6/29/26 10:43 AM, Jens Wiklander wrote:
> > Sync Linux kernel dwc3 changes from v4.15 to v4.16.
> >
> > The following files are preserved accross the import:
> > Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> > dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> > dwc3-layerscape.c ti_usb_phy.c
> >
> > Skipping unused files:
> > debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> > dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.=
c
> > dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
> >
> > Note that this is a raw import and doesn't build.
> > A fixup commit at the end of the series fixes that.
> >
> > List of commits: git log --oneline v4.15..v4.16
> > Commits imported:
> > 084a804e0120 usb: dwc3: Fix lock-up on ID change during system suspend/=
resume
> > 98112041bcca usb: dwc3: core: Fix ULPI PHYs and prevent phy_get/ulpi_in=
it during suspend/resume
> > b16ea8b9492e usb: dwc3: Fix GDBGFIFOSPACE_TYPE values
> > c49f63055e25 usb: dwc3: omap: don't miss events during suspend/resume
> > c4a5153e87fd usb: dwc3: core: Power-off core/PHYs on system_suspend in =
host mode
> > 00b42170c86f usb: dwc3: Undo PHY init if soft reset fails
> > f035d139ffec usb: dwc3: ep0: Reset TRB counter for ep0 IN
> > 6180026341e8 usb: dwc3: gadget: Set maxpacket size for ep0 IN
> > bff52352e0cc usb: dwc3: of-simple: fix oops by unbalanced clk disable c=
all
> > f1faf88c137b Merge tag 'phy-for-4.16' of git://git.kernel.org/pub/scm/l=
inux/kernel/git/kishon/linux-phy into usb-next
> > 958e052c5448 Merge tag 'usb-for-v4.16' of git://git.kernel.org/pub/scm/=
linux/kernel/git/balbi/usb into usb-next
> > d8c80bb3b55b phy: exynos5-usbdrd: Calibrate LOS levels for exynos5420/5=
800
> > d9e3d899bc7a Merge 4.15-rc4 into usb-next
> > 42bf02ec6e42 usb: dwc3: Allow disabling of metastability workaround
> > 204ec1af6257 usb: dwc3: Make sparse a bit happier
> > 19e0b203bfbd usb: dwc3: ep0: use gadget->isoch_delay for isoch_delay va=
lue
> > 0c5d2954f690 usb: dwc3: debug: decode a few more features
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Tested-by: Alexey Charkov <alchark@flipper.net>
> > ---
> >   drivers/usb/dwc3/core.c   | 93 ++++++++++++++++++++++++++++----------=
-
> >   drivers/usb/dwc3/core.h   | 26 +++++++----
> >   drivers/usb/dwc3/debug.h  |  9 ++++
> >   drivers/usb/dwc3/ep0.c    | 13 +++---
> >   drivers/usb/dwc3/gadget.c |  8 +++-
> >   5 files changed, 106 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index 07832509584f..e94bf91cc58a 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -100,6 +100,8 @@ static void dwc3_set_prtcap(struct dwc3 *dwc, u32 m=
ode)
> >       reg &=3D ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
> >       reg |=3D DWC3_GCTL_PRTCAPDIR(mode);
> >       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> > +
> > +     dwc->current_dr_role =3D mode;
> >   }
> >
> >   static void __dwc3_set_mode(struct work_struct *work)
> > @@ -133,8 +135,6 @@ static void __dwc3_set_mode(struct work_struct *wor=
k)
> >
> >       dwc3_set_prtcap(dwc, dwc->desired_dr_role);
> >
> > -     dwc->current_dr_role =3D dwc->desired_dr_role;
> > -
> >       spin_unlock_irqrestore(&dwc->lock, flags);
> >
> >       switch (dwc->desired_dr_role) {
> > @@ -147,6 +147,7 @@ static void __dwc3_set_mode(struct work_struct *wor=
k)
> >                               otg_set_vbus(dwc->usb2_phy->otg, true);
> >                       phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_=
HOST);
> >                       phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_=
HOST);
> > +                     phy_calibrate(dwc->usb2_generic_phy);
>
> Does this actually compile ? I don't think U-Boot code base contains
> phy_calibrate() function ?

No, I don't expect it does. By the way, it's mentioned in the commit messag=
e.

Cheers,
Jens
