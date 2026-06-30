Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1800FC43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 09:06:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 935C784869;
	Tue, 30 Jun 2026 11:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="p08pgk3q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4EC0184844; Tue, 30 Jun 2026 11:06:33 +0200 (CEST)
Received: from mail-yx1-xb12b.google.com (mail-yx1-xb12b.google.com
 [IPv6:2607:f8b0:4864:20::b12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8BA7F84844
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 11:06:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-66493875766so4778369d50.0
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 02:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782810389; cv=none;
 d=google.com; s=arc-20260327;
 b=mP6JXextC8sWHOqkmbhKMMzwRXqFmKneEVQWbocG9x6n+9MY11K1L+3GldfK5CsETa
 cmteAuXCxAmX+COuBQ831fIK1cSSNeKG4gf7/B4T2vtQ3yurK7YgqDKUp8GBnZMiBWk3
 a/QmheuIQPxHodUbD3lS+8w/e14HyZ8E+SVVonEF2iCqYWgJwWxlSOqE5sfgqZUMrhnF
 KI77lp8MSub0Jb2tn5MNjTXpMsfKyCje199gMx7gzNlrNc8mHfvGT6OyutQ9k4Ykh0Mm
 zAy85Mwd3sbos5OSTKuaytZ9/nUyZAF/xeVvRyz45NZ+tMLSnLk+0FsfiLAzhXK5xSqq
 yiFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ovP6DvMLYwU3Jrjbz2HE1zwnLrqTB/sTGXmppZM/D2w=;
 fh=aZZPPJ/uOVcEqjOTgpM8dyXEJstNVGEKU4PARCCorWc=;
 b=YxJ9Vty4nUt0nWcIxLhdc+c2Wq7sQjpgM60Y4vAj/8cizo73HRdJKkFUdYxZLY3iWG
 f/56vD/+zVhZPV5D77UlfQuYuGbUxanvRqO+HUv5dk2ENUWFWJkAGXAOxkswBhQpfp7o
 slncFUozuz1V66wvMNyAoWNfv4pwsCAQ/DBiVdB3918ozAQ5xjjncJUUUxc2JA9ZVIpE
 Wv0wYruBI+7k319fbKcSFOndiTGI9Eaa9dAeJ3GecZ7osSp6IrAS94ovCjdvlhqd3mKa
 /whBvufYtDPicaq1ej0RDC4H6jp6Wcg5N1QDgZqfkHTLsdWhZan5IZo9v45IfTd0kccO
 a/ig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782810389; x=1783415189; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ovP6DvMLYwU3Jrjbz2HE1zwnLrqTB/sTGXmppZM/D2w=;
 b=p08pgk3qqh/TqFK5Hm00YU6MGEHi/KEl2LPc846ZUsSPisL0Q+lEcF43ixR71K05Dw
 b3kx3rWjkcf94x8ZtpBWjT3CT8N8Xh29b1FpjnAwncV45Z9a1fsB6hTzGG9b9d2oAkGq
 /yvZpFw0bIaayiAF6jBYd31rm9bvBg9ssWcwyjSt/d+3CJ+zY7jjr+5yyxsExTCTXM0o
 vzVikaUIdBGaBgF2cXXphT37A7wIszhCGzw/DHC5tp3NIab7t4BFJxzxnXZWcUHhuJpV
 dtKWlXtUuslZngUZm6VWi3Y83oMnsAV0dRI22sdKR9KZvlpim9PHCb2BUlIk5pDlwi2Y
 +n7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782810389; x=1783415189;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ovP6DvMLYwU3Jrjbz2HE1zwnLrqTB/sTGXmppZM/D2w=;
 b=icPiRhkkqtSF2+GH3GP65+R2TwSBXQN9IlijCJkpbUH9FobxBx9hWLpTJGJQLczmJZ
 BqxKcJAIahnQBRHGEXwfHafMwP1Diw3NWKNVdcVT1yPtHBy65Jk4UyPwFmypWIajPtv6
 8y7UgLo53T8mKEWQOC7XB3SwO+lAaq87ZtLSJcLWymeRgRGcHeWv1Juw1BvEMtz428Hm
 F04xlV5F0XxRhMOhbLt2CUEtlrrTotpkZnA7hpIB4xTrsEdebWtKSkcM75msWLzW1Qor
 pRCPqtw72qdFlD+/goyIiKs9BUNMVLJSl2eGsoOx8YlFl/lnZkbIcN6Oc+9JTYqKRNZJ
 1REg==
X-Forwarded-Encrypted: i=1;
 AHgh+RphOHJEGlPOlKvWbO89AaQyn2p4neebBTkQq6TZ7uo+8OQh9Fp4jQnsFjT4m5c6lE8G43t1sY4=@lists.denx.de
X-Gm-Message-State: AOJu0YxEgTJ1J7v+InESznCvmZlcnaBgij1pYQigRgs+HYgXp+uzaFsM
 5eH9tLtkG7439CT1D57nqO5+sPGAILxTolOp8DsxtGmU/Fh/iRZZJgsXp3dq2teUxQLyiQe6KkL
 0L0o6inJojBuO8If7IOZMln4xTO1XAkv8L272VSSwHw==
X-Gm-Gg: AfdE7cmLvg+nZH0nLHeXBUfw6PpSND8rNbqW3T2u/7G3/8LoBqO6olwI8EaZdGHcS1y
 ssjguF77BgQVLG/XTsrPsBg65sGVJXXLme8zec3cISN5sRfgUBZZZM5ZN+IwHzP/aMJuPtvpRWx
 K39T6xSQT5Dz1k0PsVZbs++tMimmqwmwfKRvofSU2Lw5Jr8tV/U7nTWxkl0CVOEb1/R4gqKo4jK
 zqvzSsXm2fK/lYrdxvi2e/d3n1M2Q06qHiDn5tvBuvrRcVMJIcCbnUZqxsosWoQuOb1uy56tddG
 HMX9kLuOYqgh40MFZdIswwyOpZ6bspRljbB1Z0JEfwnU6o2JdhXyXSc6HMH4swvIlOGqxiDmXmE
 vzBuKoutkKjBU4gDRhRPrOhkba1zu/Z0jCzw0twHOxkxaK80zIZxIOtC8S2NGoiAxfWsIKTd6Oa
 Oi1ptyMoGpKHuN3R5CN6DQps4bJgn1i6UGrcAxuBpA1AP4eUcOp8IaaFvMEEtTMHBol811JTsan
 K3vuKfSrAk9macRzVVgDy+hrnGIM9HXucrIgnwMe5xUpfguaPCetRiGjLY51CysBrh3d0g7C5sf
 qzwQjz1WMZ5WJqOOccuAiaAk1QMY23VIi92wkWq6sJ47bII7SkvDsTqlrpAlqpPB/m1xyCY=
X-Received: by 2002:a05:690e:38b:b0:664:c535:ee27 with SMTP id
 956f58d0204a3-664f9a25c01mr2611798d50.54.1782810389189; Tue, 30 Jun 2026
 02:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-15-jens.wiklander@linaro.org>
 <58b13bf5-8075-4adf-a576-2fbd08229733@nabladev.com>
In-Reply-To: <58b13bf5-8075-4adf-a576-2fbd08229733@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 30 Jun 2026 12:05:53 +0300
X-Gm-Features: AVVi8Cf7FTPaf6B6oUys4tztFDSNGU-Uk1DkEz2IoBW9RytyHNS7M1bJJa7BZuo
Message-ID: <CAC_iWjLsR1VpzBQgXDUND2jQXhG2nzGzmWD75uinFB9FtWSPNA@mail.gmail.com>
Subject: Re: [PATCH v4 14/64] usb: dwc3: import from kernel v4.11
To: Marek Vasut <marex@nabladev.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, 
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

Hi Marek


On Tue, 30 Jun 2026 at 11:59, Marek Vasut <marex@nabladev.com> wrote:
>
> On 6/29/26 10:43 AM, Jens Wiklander wrote:
> > Sync Linux kernel dwc3 changes from v4.10 to v4.11.
> >
> > The following files are preserved accross the import:
> > Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> > dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> > dwc3-layerscape.c ti_usb_phy.c
> >
> > Skipping unused files:
> > debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> > dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> > dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
> >
> > Note that this is a raw import and doesn't build.
> > A fixup commit at the end of the series fixes that.
> >
> > List of commits: git log --oneline v4.10..v4.11
> > Commits imported:
> > de288e36fe33 usb: dwc3: gadget: delay unmap of bounced requests
> > 35b2719e72d3 usb: dwc3: gadget: make to increment req->remaining in all cases
> > 0913750f9fb6 usb: dwc3-omap: Fix missing break in dwc3_omap_set_mailbox()
> > 1551e35ea418 usb: dwc3: gadget: Fix system suspend/resume on TI platforms
> > 73561128eb72 usb: dwc3: Fix incorrect type for utmi mode
> > cf3113d893d4 usb: dwc3: gadget: properly increment dequeue pointer on ep_dequeue
> > 7369090a9fb5 usb: dwc3: gadget: make Set Endpoint Configuration macros safe
> > bc46e23c3425 Merge tag 'usb-for-v4.11' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
> > e42a5dbb8a3d usb: dwc3: host: pass quirk-broken-port-ped property for known broken revisions
> > 28781789051e usb: dwc3: gadget: read IN ep FIFO size from HW
> > 692665c621bb Merge 4.10-rc5 into usb-next
> > ffb80fc672c3 usb: dwc3: gadget: skip Set/Clear Halt when invalid
> > 538967983b88 usb: dwc3: ep0: Fix the possible missed request for handling delay STATUS phase
> > c773bb0b9264 usb: dwc3: omap: Replace the extcon API
> > c6267a51639b usb: dwc3: gadget: align transfers to wMaxPacketSize
> > 905dc04ea796 usb: dwc3: gadget: allocate bounce buffer for unaligned xfers
> > e49d3cf4926a usb: dwc3: gadget: extract __dwc3_prepare_one_trb()
> > 843053093f47 usb: dwc3: gadget: simplify dwc3_prepare_one_trb()
> > 0e4018ff5d12 usb: dwc3: exynos: Remove MODULE_ALIAS()
> > 3e27b3f66a56 usb: dwc3: exynos remove suspend clock unspecified debug message
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> > Tested-by: Alexey Charkov <alchark@flipper.net>
>
> Patch 13/64 seems to be missing ?

I can see it in lore
https://lore.kernel.org/u-boot/20260629084507.3254232-14-jens.wiklander@linaro.org/T/#mbcab024c9ce559586a0a5fec420eefe57746922b
Cheers
/Ilias
