Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83554C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 09:27:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAFCE84B20;
	Wed,  1 Jul 2026 11:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dGxKJu2E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA1984B45; Wed,  1 Jul 2026 11:27:32 +0200 (CEST)
Received: from mail-yx1-xb133.google.com (mail-yx1-xb133.google.com
 [IPv6:2607:f8b0:4864:20::b133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 108DE84AE9
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 11:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-66493875766so509450d50.0
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 02:27:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782898048; cv=none;
 d=google.com; s=arc-20260327;
 b=WOtMHd34mpee5mOPCBRG1PXDJDHS9H2SZBwnDHBgF8Rp9PpsqIy6VwPxxTfqnbJc4k
 SeTTyqZP3yLpViYYPoLxFyvDsnZSnaDQWeYzdCyEJU/E87rNuOuvzWUMNBQse7Im6B1c
 TcfNjZ4CKTj35+DdTlVq+174qOb46Z9PRZk+MjjKMFRASQpHdTSfnd6OTHSCfpZh3YmE
 n9voFCkKQA/pc9V/QGwSGdTjFNGueOiB0mfYfpSd2X4boZpnc/G+x1IVftqqidMP4cFC
 HU/Hk9K6x3pLnxEdjrSGToPeGGoShiuLVkyNgis7BXGqAoVoxypT6HAOxsytH+a5ii74
 MKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nrIAw9sqMlzsVRZnDO0Bm28DXg97x6dQyXk57hbn1sw=;
 fh=dHxJPKYvgjvlKXtN3bDQA/9b8rJO/Ei1WgGvvZVUVb8=;
 b=AnG2HrJVsARgfzT/6Aad4nY9tXl8VijcNbbMJC4tlFkWS1qnWjz41jxgwtGUNysJTj
 IqitzemoAcStDiCg+Ed3VsDe4Dcvw/zjLunT110a6eL6FkefLllnNoSQNODKA9qAYbzw
 r2a1fnoVVckQTLiQOHd9NVxuZSNHEkju7693Ufxj9AK8RrjLqgQylu0sJjPnSCpXYUuy
 4M13UHnN/nlQm5qwQWt9EqISgYwWo6XH/hPrDztbb5oELizwKnB7/s3MtaIhlIzBUSQ2
 MU9fQstmx5/sn1utlA3DvSLhmuN4s5kWB1NJBq/k/H8Th8Aql6r4Z+oUiliVhBFLXoft
 bOzA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782898048; x=1783502848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nrIAw9sqMlzsVRZnDO0Bm28DXg97x6dQyXk57hbn1sw=;
 b=dGxKJu2EXO7jMYkNYI9tLxA2bKBjrdd4ZmrDPW+tRoZUnx56pLtd1nHaJnbcoSRfk3
 zYYp8lrthLX3GXlKwYEgYik3+TyXSWZckLCH7TyYo7WyuM+0oL14LbRPk2w8wqBjQLUI
 Sc5Bt36eulsCto8cDUhkYOiSEoT4JyiboRosdfVebV7xgoYQ/ej9lxjqNihDFtJv6lhF
 R19RvwOTTDm/ssNWGaQe4Ma+xNCb7ZUY6dYWjltBdcXCcHnLmFPwZrnCWe1tdiyTlH5R
 AfMsHlHF2DheUYbUrFOKNMst0umHZf3Z+DVPp5cqjrhT5gHKFaSjp29RmoVQFdKe3PMd
 xMtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782898048; x=1783502848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nrIAw9sqMlzsVRZnDO0Bm28DXg97x6dQyXk57hbn1sw=;
 b=J7lXDkaj5qB8HtyLFe7ZQ9dqeQbi7AMSOxdrAPnC5/39nfWV4fm9yP52XdcZUf6RAK
 CwmklIusBlVrDPyEfCaiq1HSuMWX5skKiMw6iRNCwWx4wnsr5PzBbPECoWUyWv1w2q7o
 K+qFgoxJVKb5n1s/kiyEwuXes9ugFzvSjAxjMSrVMmExMIZBjdM86bAvYMKXmRdFRw7z
 DNCQaiJAMiV85qTogbp4Q0tqcVHhD9djfXUvV88ZIERD34TBzrud4WMQmDMFi6jhK4HR
 Ddd5ClSd/Z5D0xC2Ay3GX5vHGBw3qefXsosIlPdroknBVut/M1zsvBEb8oRNaSM9ZoeS
 e3/A==
X-Forwarded-Encrypted: i=1;
 AHgh+Roemgj4qSqALfsDsfaIf1eckoBy6CFuhC3l6XFffZWX/+2tpPc6XzMfTFAYuMm+FIGQNrK4Y5g=@lists.denx.de
X-Gm-Message-State: AOJu0YzdmydwIPaVCLzke3RHxMhUKeiMjZxCnRChBd45cgIRpu9G9TXB
 RFBwmsvdnkEI/ei3iUa3jXVescfO6NaPmPUpLYuo8bRS8pSDWFej0NWjyf4QPW5HlqYrxp4MX/e
 GoiLm5/aYSA+fBkUWRP0dLwb7520JsxajFPsXgcaJ9A==
X-Gm-Gg: AfdE7ckUPFGXhiBw1gfmwIXtMoEa31Oq4HUt6hkgE3BzrHh50YvSE5HDqbrNTk1s2kj
 DMSy2yonEVaNms/gdfUeKixf6y8T+sCKFovgmVTKOBLjZIE9jqdZZJtjQ9UPR3IWmRq3ZRCRYY0
 Ic0qCYf4EBCZjpdlViNTBBtu/raRLfxr0SVXfGft8qYAML3mAso0NBpALa/qgkIfFYYPWQb7v8B
 v24Ub0Kwm+nTOyZMQkKxpQo9yz5Yc9DjfiD3iRi5dl1nvbKaUVaS4S2U92Qk220+lmrFHJe0vDG
 qBbYwnlrj7WKm7hLh5RK5s4ste5XRmqArXUD+BsZtxe/kP5XVHfp9yvJe7I15NxNINrZ9f8aspK
 Iw0KESTPjkZQmZSC5bp9suwLnKTeQtGl4jXVMz5YJIHavj1GUKm+yopBKtsPKAIkopn2nh99Sm6
 0iJXR6RtOrVbAdOrdRQ2CBbwmf+wBDF/jqz26v9O1DDpto7nIgrnHTo+1yHgR8WMwI+9udbz13/
 fU4p+sokY+7+XRKpFjJo71SFOkclEMXHT2XsV1Dh5B+gc2XPYb8Kgyz6p3QJNs04nBsh9hAaDBc
 8e6ZQTVDtZaWQ2eBzjb+0f2kgnBZ8NVk1GeM6zBRrpi/IGi4iz+lN1xVpU74H5mwGLgd4I4=
X-Received: by 2002:a05:690e:4805:b0:664:ae68:33a1 with SMTP id
 956f58d0204a3-66521bca8c2mr617287d50.66.1782898047655; Wed, 01 Jul 2026
 02:27:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-20-jens.wiklander@linaro.org>
 <7dd650b5-2d08-45cc-8d7f-c9bee56de4a8@nabladev.com>
 <CAHUa44FQ6b4siyBnOdEz2cBs9rrRNCgGC=-s0h2gkGG79dLADA@mail.gmail.com>
 <df8a9508-b070-4e95-ae6f-23fdc17d0b4c@nabladev.com>
In-Reply-To: <df8a9508-b070-4e95-ae6f-23fdc17d0b4c@nabladev.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 12:26:51 +0300
X-Gm-Features: AVVi8CcZbDkR-7SpQw3z1zUme44yC2x73kNZ32ZpLFiegEzv9_48VgplaoIE7Mk
Message-ID: <CAC_iWjL54osePCfrqWCGUn2DF-1D7eabJjcZ+8Lq0Uco8zEskw@mail.gmail.com>
Subject: Re: [PATCH v4 19/64] usb: dwc3: import from kernel v4.16
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

Hi Marek,

[...]

> >>> diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> >>> index 07832509584f..e94bf91cc58a 100644
> >>> --- a/drivers/usb/dwc3/core.c
> >>> +++ b/drivers/usb/dwc3/core.c
> >>> @@ -100,6 +100,8 @@ static void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
> >>>        reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
> >>>        reg |= DWC3_GCTL_PRTCAPDIR(mode);
> >>>        dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> >>> +
> >>> +     dwc->current_dr_role = mode;
> >>>    }
> >>>
> >>>    static void __dwc3_set_mode(struct work_struct *work)
> >>> @@ -133,8 +135,6 @@ static void __dwc3_set_mode(struct work_struct *work)
> >>>
> >>>        dwc3_set_prtcap(dwc, dwc->desired_dr_role);
> >>>
> >>> -     dwc->current_dr_role = dwc->desired_dr_role;
> >>> -
> >>>        spin_unlock_irqrestore(&dwc->lock, flags);
> >>>
> >>>        switch (dwc->desired_dr_role) {
> >>> @@ -147,6 +147,7 @@ static void __dwc3_set_mode(struct work_struct *work)
> >>>                                otg_set_vbus(dwc->usb2_phy->otg, true);
> >>>                        phy_set_mode(dwc->usb2_generic_phy, PHY_MODE_USB_HOST);
> >>>                        phy_set_mode(dwc->usb3_generic_phy, PHY_MODE_USB_HOST);
> >>> +                     phy_calibrate(dwc->usb2_generic_phy);
> >>
> >> Does this actually compile ? I don't think U-Boot code base contains
> >> phy_calibrate() function ?
> >
> > No, I don't expect it does. By the way, it's mentioned in the commit message.
> Can this be made bisectable ?

I personally don't think it's worth the effort even if it's doable. We
had a similar discussion when we did the Makefile bumps from 4.x to
6.x on a community call and we agreed that the period is way too long
for cherry-picked bisectable commits (and the makefike gap started at
~4.16). Besides, if we try and do this bisectable, we'll end up with
patches that contain the cherry-pick + some fixups per patch.  We are
not bumping the dwc3 support that wasn't updated for 6 months. This is
literally 12 years of missing updates.

The first iteration of the patches had the fixes bundled in 5 patches.
With this approach we can at least track the commits that got
backported + a final patch to bring back the U-Boot code we had on top
of 3.19-rc1 and any fixes that are required. So before we move this
any further, do you have a preferred way to do this? I'm afraid that
expecting 12 years of commits and ~1459 patches (with the u-boot
changed on top) to be bisectable is not realistic.

Thanks
/Ilias
