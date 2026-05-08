Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3180CD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 15:36:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57C4B84CFD;
	Fri,  8 May 2026 17:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BYOGPnW5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00DCC84D42; Fri,  8 May 2026 17:36:32 +0200 (CEST)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5EFCE84CF2
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 17:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c70c112cb61so1552580a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 08:36:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778254588; cv=none;
 d=google.com; s=arc-20240605;
 b=Ehd4lG3rt8Kgy4Yu/hrE66JtJLYXRgTTgcJQ/BG0IICo12A3KHUlrepjBy9KEh6Wn3
 CfxpzPKN/T/JsGvKAoON6AN65AmmL+IP86D7de+wmVySMmuP8GWsRR4z4oEXJncN2cvC
 qzFhCxbmo7GFMRM+0Q/JfTwW3MJMcJrrhUlNRz723CyG7A/Hy72mT+K4uVYFHleEcfza
 xty0effnigNQlBsAtFh7A5AgEuoKzQ/lyVVczQqMHKp8C5KJyXL3eegR3J7soEwPRj/4
 43mTbjVUW5n5JWFlcmDNYUb1QG6UFZYw+Sy3hQTenyQqfYuHF5Fs0429KKWYWcABLsKF
 31Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=VLGjHXZKHTUrDq4U9TLFelMFc7ode/3o1rhq3nWhZYM=;
 fh=cXLM2xWHT98EMji+CvqvFHfrMeoAXhLsVQYbWE9nUP8=;
 b=B7kV++wGykWPfbO1GBPHtsJXcCpxGMfZGy1aYydynqf/xNZOlDHdr9w3JUUP53c/HZ
 8Ow189MrLRFVyRA4gLuXnFQSkanD7ECZ6c482TWzE9/AoU6T9buxYbmsZwJbFU50KbzG
 M6hhN32laBbQtShocfyJMKj2grcAit1mF7JBlGAUoFlAGEM/w/VtAW8CXlES3kVoPLN4
 gI/M6PtzcT1i6NVOn7WJ2WjpLIaFudYVCQDLuEeEza7xIzF5iHpXZJkCEmVbwTInQlti
 US9Ahbxlf1MWWnSaOlZZoj4J8hnvamKqFMoK+Orpdhb3CV0HD4sc9eI6H88Iog1iBJa4
 QZoQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778254588; x=1778859388; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VLGjHXZKHTUrDq4U9TLFelMFc7ode/3o1rhq3nWhZYM=;
 b=BYOGPnW54r6HOYX9JphOSPPRoWjXiMNGiFaKGN0vpTXBnTU0FWymBmlzdYiBXu60l5
 XfmFBZyX7W7BEaN3yRrBgFx0DxxsE33T+maT8qZIHIkHiI5vnW4eUOrb/lnwYdNCqHCC
 mPBac3ySPd0/bXiBc/RhzhM01H4EiRyC7+Emk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778254588; x=1778859388;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLGjHXZKHTUrDq4U9TLFelMFc7ode/3o1rhq3nWhZYM=;
 b=YhBi05+BHDaKUVOjq23HTLoUuSrlrjz71zptdcSS/zaxUgQd0FXgVY5gOy/fnG56/D
 vjoaeBur6dJbqnLAGE3nMn1kY8br6h5he83mNr5g6I3VMiGJMzIHXYAzJ7BjTpT9q5xf
 x3Y8p7AvFn+VsimM0SbxqCgkupxoI4JKzv6c6p/vDKkX0YFd5LiBiEMC+iSbfSYNbAja
 6M59zrWtaiEOhT4YGw3t2oxY3CO5JH6XiXrkivdKJG8/KtmykUgXvaGhSMDQJL68MrCf
 nrw0DffXuXKX67PMPRudvy5PzhUclt0IC9Wre5VLQnbUMmmTL7ecNrzXviR2KUCKYQ9e
 0LyA==
X-Gm-Message-State: AOJu0Yxp5OHqwqRVjLiJEJVTndScVO4SGt5ZjseJC1og6Zr3KsxdpJC3
 rzxoKmSXzyw3MaOAHtDVd0tULevmDIfGJq/GWhY7XEpeuYT87YUGrEtq9NJAlyAKvhazhhBpJgg
 CGMTTGlFKnOZDQTnUUYPDiQvp6gfaFdI14lNyI/ja
X-Gm-Gg: AeBDiesnZVKHRpjf1vTtM5Mmh3Ljrp6pPerrmlv9FxPe8fDchs+eCINmmfmcIMhivXS
 MJ16TpdU670L0568yNVUuIHA5p/jQCls9kkEHh3UvoC/i5r0rHG8rgzzz1BDOKhMJt7kStCmaTS
 093ab64f5eJlZ3wHXPy6k1RJWMBRjHO/yZmUT06mWb/829BRzG9G4FyO3R1mWmvTk4l9ZDbmCz/
 HRmDofGfiRjAJrnA7AJtJVVJzmN7iWvZi56ou9/Ro9uqnyzVeUV2gq9xa40WxYE49h+8oEsUPvV
 Kp4ebQ==
X-Received: by 2002:a05:6a21:3291:b0:3a0:b9d8:96b with SMTP id
 adf61e73a8af0-3aa5aad6805mr15096294637.26.1778254587833; Fri, 08 May 2026
 08:36:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-31-jens.wiklander@linaro.org>
In-Reply-To: <20260507092843.358908-31-jens.wiklander@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 09:36:04 -0600
X-Gm-Features: AVHnY4KO5TAJrdLf2XfNm-KPX-40KrLB-qj_vyT6Rj8mP8iQrxZyTQ8KvjXiPYY
Message-ID: <CAFLszTgpBA0kHEScDQsA2M6NNkXQ8Yfvmsp_5uG+LdwiX93rkQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 30/64] usb: dwc3: import from kernel v5.6
To: jens.wiklander@linaro.org
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

On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> usb: dwc3: import from kernel v5.6
>
> Sync Linux kernel dwc3 changes from v5.5 to v5.6.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v5.5..v5.6
> Commits imported:
> dad2aff3e827 usb: dwc3: gadget: Update chain bit correctly when using sg list
> [...]
>
> drivers/usb/dwc3/core.c   |  3 +++
>  drivers/usb/dwc3/core.h   |  2 ++
>  drivers/usb/dwc3/debug.h  | 39 +++++++++++++---------------------
>  drivers/usb/dwc3/ep0.c    |  4 +++-
>  drivers/usb/dwc3/gadget.c | 54 ++++++++++++++++++++++++++++++++---------------
>  drivers/usb/dwc3/gadget.h | 14 ++++++++++++
>  6 files changed, 74 insertions(+), 42 deletions(-)

> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> @@ -167,6 +167,9 @@ static void dwc3_ep_inc_enq(struct dwc3_ep *dep)
>  static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
>  {
>       dwc3_ep_inc_trb(&dep->trb_dequeue);
> +     /* set no action before sending new link state change */
> +     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> +
>  }

This hunk is in the wrong function - it should be dwc3_gadget_set_link_state()

I'm wondering whether this is intentional, i.e. that you are not too
worried about the accuracy of these individual commits and are mostly
just concerned with the final result. That seems OK to me, since this
is just such a large effort, so I will skip past these.

Regards,
Simon
