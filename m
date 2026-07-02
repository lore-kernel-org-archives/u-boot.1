Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E38C8C43602
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:52:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3298684A04;
	Thu,  2 Jul 2026 22:52:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h/wrlzcg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1799484A75; Thu,  2 Jul 2026 22:05:19 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9E98849F0
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:05:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-698aa7ba320so2044720a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022716; cv=none;
 d=google.com; s=arc-20260327;
 b=lYJ7H1wqkXs2hE+DLkHrYx27MNf8bYb1VNiv83UOheFelL/4CtQVk/Gq0OoKYqAhPH
 PzYSzj+1CmQZjTCkwnVNEicK1Kw4ztnAfrUCYxXPXS8TYh0zwRMVdv/xccZBKRGvSX/b
 uO7QqJNOrulKVNGtGyeJjoYVFKvk8vri8Im8rvnxnfWhE25ZJpIy1qymqDZ8xOpffN9L
 dzQEiEWJV4A2JQ6lITMaXQZ1ykFCMzW32W9Xu8rXR8FBr1SIqQiGaahV0IjyJRjE0zRA
 aaKjhGcpZn5eFjB6Y0bWHWB/9Qmxld4kzOomIGIatoDD//uYavP5b0sN6tTxyv2MxqLq
 2Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2/xlT/HWRGck7i4dM3lIph/3hLkivxqF5uWoErRMoOs=;
 fh=CQVajNCqmba0EKhASaL/e5B5SwG4RAZVyDpBDmUgfwY=;
 b=DGtIOyxBRlpchfswLKWIBlMSGXCt1Ytx7b7/m1IA9ltug+WqSXea6QZ9sWNNYhOhOo
 FF7fejkI8l49ZPDQX5IpMg7wzfPNpcOrN6YhNzb/S1rCBzvjeeE85Z4oB7sGrpSax1bw
 xRWG2qyP2BXFSiF4ay37QB5wNJWOiObdBJTf/qrPpMJI/aMbZCcontc52Y5uo/A6My+v
 pJgOZDFCaf15imRDGTErQ2ZUjxaxASylEu4vRdwS3RPL+utgXuUtU6mxHqACHJOJW7pT
 i8ddjFcloHr1olbSjyUIxWp7yl7mqnstcDzqu/lVH4oPAM2UlGdbJqD91O29U1k/QcWS
 wlow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022716; x=1783627516; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2/xlT/HWRGck7i4dM3lIph/3hLkivxqF5uWoErRMoOs=;
 b=h/wrlzcgtbrqpy5hlRFmO+bWbkc8v6XWk1T4l6iIMpipJceFCAiI8b/CYzzkjkKD69
 u64SrWKcfgVRoPcnyzazBFwQVEM2VYFFuDaxx4miLtbNtbNPlXCyQiY1zARwEB9u1EsC
 7kPLp8BA5zOVezEUFN4HOhgbpnw7sKmMPINFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022716; x=1783627516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/xlT/HWRGck7i4dM3lIph/3hLkivxqF5uWoErRMoOs=;
 b=qzgSF49YyOAHPNX0KYTmH8KoOgGpZygds4/9hygSxTLCe4aqAsMa6yGWCZQIC8UDLj
 DtJzaBy1FkBQ4BbzI50cr3WI9DK3sChRO/aeBZ9Kw9aZzwo3pdEtNU8wWUgt3A0bWM/9
 EcHo/nhY14xJ9rE4vmmYNG7FojnEQixF+gK6RK+gavpA+pbh5EouIPAEQygnFoOJioKo
 yJ6TqCVLt2SAEBJGAj+Tcmr+ltrxbvtQ9GPG6JgDKchZP1mRtgatHbJj+CxX/aHb2dAz
 oyGPx15ypNIG+srRCgsXAgaXRhvFJkoIyupgEN0TcwJCpRyjR/8aG2IXr4rBmqDaoX2C
 jVvw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrquL8sCW3G2Te3tYEbHSUKdwP/FVMwEnJc7d+G7xnJ/+W8ouZeynGMNaG0oAL4nvlw7fwqWWQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxTUa5oBF3Ls/XWEbyZ0Ldtey5GDKcONvIhEM7Z5giW+HHVhQt4
 3gA/q6y/xff0JT5c6y7UiM3ugnJQw/EgZv6rHroeBGnkzShxuAy/sJxvwZokJH+d2IWVCiFck8/
 6XULwnKhlLXVLxuAAT/PsntsVimjtznkZ3QESxOSv
X-Gm-Gg: AfdE7clEfD/FXbYFqP+cVponA/M25hbciUAtdJv/TfrsOAUS9R6DCz70vbpa1mOfJgW
 g5kGud4SGGbRMdK3+NnQdJC4OMqgE9nyTRy4ZzOpe4Y82my9K3knhtq0FqagSR0YZlbd68TrEdo
 ygTdZLtJukyhp6+XdmWLI4yoWj8BeBd2tVkKKVGQpS0kM/AyowI3JHcqjO9cl79JtFp29gXUXpo
 yaeT/Buu0rwhzDPyWUpT/0/VnPvqjqVEgyw5kGadmdiy6M+EywCg4+0wejE7tDpcdG0dIteIpVp
 /+Z8OmOd
X-Received: by 2002:a05:6402:344f:b0:698:8857:9ff0 with SMTP id
 4fb4d7f45d1cf-698c10c4e63mr412843a12.16.1783022716358; Thu, 02 Jul 2026
 13:05:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
 <CAFLszTiMJDrOhGcJtsr6JKQYu8NZTRWZF+3aQ0yO0CGMVZAfEA@mail.gmail.com>
 <DJL8ONJL18S7.3MUBPJW6U56QR@ti.com>
In-Reply-To: <DJL8ONJL18S7.3MUBPJW6U56QR@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:05:03 +0100
X-Gm-Features: AVVi8CfkMRgZnSqeq9nWY4cdR0US8FBTKTUat9J68k-chJ1uxJAxLJr1VQAg4Z0
Message-ID: <CAFLszTj+od=JXpDvzoyTCYKLP5PE429THu2Wj_A4Xvm4LD8FEg@mail.gmail.com>
Subject: Re: [PATCH] treewide: Kconfig: use bool instead of tristate
To: Anshul Dalal <anshuld@ti.com>
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Heiko Schocher <hs@nabladev.com>,
 Dinesh <dinesh.maniyam@altera.com>, 
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Marek Vasut <marex@denx.de>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Nick Hu <nick.hu@sifive.com>, Jimmy Ho <jimmy.ho@sifive.com>, 
 Michal Simek <michal.simek@amd.com>,
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Peter Korsgaard <peter@korsgaard.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Justin Swartz <justin.swartz@risingedge.co.za>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Jonathan Stroud <jonathan.stroud@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Mateus Lima Alves <mateuslima.ti@gmail.com>, 
 Jamie Gibbons <jamie.gibbons@microchip.com>, Daniel Palmer <daniel@thingy.jp>, 
 Angelo Dureghello <angelo@kernel-space.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 "Lucien.Jheng" <lucienzx159@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Beiyan Yun <root@infi.wang>, Weijie Gao <weijie.gao@mediatek.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Romain Gantois <romain.gantois@bootlin.com>, 
 Alice Guo <alice.guo@nxp.com>, Tien Fong Chee <tien.fong.chee@altera.com>, 
 Ralph Siemsen <ralph.siemsen@linaro.org>,
 Boon Khai Ng <boon.khai.ng@altera.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Alexey Charkov <alchark@gmail.com>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 02 Jul 2026 22:52:37 +0200
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

On Mon, 29 Jun 2026 at 05:14, Anshul Dalal <anshuld@ti.com> wrote:
>
> On Thu Jun 25, 2026 at 7:12 PM IST, Simon Glass wrote:
> > Hi Anshul,
> >
> > On Thu, 25 Jun 2026 at 04:18, Anshul Dalal <anshuld@ti.com> wrote:
> >>
> >> U-Boot does not support modules, so having tristate options is useless.
> >>
> >> Therefore this patch does a blind replace of all tristate options to
> >> bool tree-wide.
> >>
> >> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> >> ---
> >> CI: https://github.com/u-boot/u-boot/pull/998
> >> ---
> >>  board/st/common/Kconfig      | 2 +-
> >>  cmd/Kconfig                  | 4 ++--
> >>  drivers/cache/Kconfig        | 2 +-
> >>  drivers/clk/Kconfig          | 2 +-
> >>  drivers/firmware/Kconfig     | 2 +-
> >>  drivers/i2c/Kconfig          | 6 +++---
> >>  drivers/i2c/muxes/Kconfig    | 6 +++---
> >>  drivers/i3c/Kconfig          | 2 +-
> >>  drivers/i3c/master/Kconfig   | 2 +-
> >>  drivers/memory/Kconfig       | 2 +-
> >>  drivers/misc/Kconfig         | 2 +-
> >>  drivers/mmc/Kconfig          | 4 ++--
> >>  drivers/mtd/nand/Kconfig     | 2 +-
> >>  drivers/net/phy/Kconfig      | 4 ++--
> >>  drivers/spi/Kconfig          | 2 +-
> >>  drivers/ufs/Kconfig          | 2 +-
> >>  drivers/usb/cdns3/Kconfig    | 6 +++---
> >>  drivers/usb/musb-new/Kconfig | 2 +-
> >>  drivers/usb/tcpm/Kconfig     | 4 ++--
> >>  19 files changed, 29 insertions(+), 29 deletions(-)
> >
> > I don't see this in patchwork but it looks like you sent it correctly.
>
> I seems to be up now:
> https://patchwork.ozlabs.org/project/uboot/patch/20260625-tristate_fix-v1-1-95e16153d752@ti.com/

Thanks, found it.

Regards,
Simon
