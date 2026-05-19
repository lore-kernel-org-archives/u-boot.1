Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0745BCD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 07:58:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A8A48460E;
	Tue, 19 May 2026 09:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Cz6wky09";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCEED84659; Tue, 19 May 2026 09:58:25 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8E6A84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:58:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jens.wiklander@linaro.org
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dcdca9aa0bso4589713a34.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 00:58:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779177500; cv=none;
 d=google.com; s=arc-20240605;
 b=YSQWHqKpHyvlA0Q89HkDrgv4eO/lO9YXCxZl9/D1jIMNEUA86kfm2ACQ57O5xeZhRo
 uvoJFFSqJ8GqvE3v46ARz0w7DRheP6QjIW/EU8nK294zezNRekVtIi2F8ZGivw1E+eOq
 uJ+12VQ8dF8+a4LQoQ44eF+/CzTK5yOOqwPgZ7uVcltLBVkCVOkfrs4m0iGfRv7ZRVBe
 7Vw8PjcymOlXm8G6a0MW6lmta3+1vEc3kJZ4D0Bzuudv/K7XKt3NnDvH60tIi50N69tV
 +PS5D8PdAQq3jxzZiPN2vyoDSgFI8HzpHRrpv830iTB6c/GFl5hK2o665MKfisnA+wlL
 rvkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0O7NjoL+R/sxIKqd8QTl9D3WD0q+Tb+G5snzgoV+gXI=;
 fh=+frx1rJ8J2MDpCuYM+gCUtgVSlHTcmPga4Sth4vD60I=;
 b=dYHc7xlsH6GA4M4JVj8ccgmU1yLxaJLEr9ZP2zGNbzAXmGFrsL9sa5wWuqHvX4JQbG
 a+gnjRQPD9yEDuaIaHi64gOG/i8nZGy+L1p8ULHl79nYQf2+EmxUqmPukUyVIMxNPMh2
 o6SwhVgCPnIgcutGy9Xch4rS7Scbu4PZIbonfPZDE6cl2CRMFXqYuXiz6Ww9QqyvgvVQ
 d+qaDFTBu5TIpA90ybpDfhSxAllwlhgwTOxEVyNddvzPMGE0oVJO7maKsThIy9nuBYo3
 jgfx/2bIP3kQ0EdxTL2Wya34wldXqbBXHmt2aB4Lf/JyZyt6EzrL6or4518zKotqEpXW
 6L2g==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779177500; x=1779782300; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0O7NjoL+R/sxIKqd8QTl9D3WD0q+Tb+G5snzgoV+gXI=;
 b=Cz6wky09/lF7wOKcmKalYqAnU2AYXouk5woKP+J+LzyMxHJsi7QoneI7DazFrGvu8M
 6QcNoV++DS1Np8QSD0F0fj9D9auAtxFqXDtWSV1XDTG+w/xCd/2SjCDEpYk/iigqMnPZ
 HlSD3eVNcVGO1s6gOTbfif/FYE+fqEKx01QBpXnZ4GIN/rm2/cWb/nYqR0BZwrYTio3M
 k7sjKrMs7iFMfmY+YNc+/2PowhwahJR5qWYDIQrmjevAONiZRqIfwezEFCsWgzt6XGO/
 LEKzwOa0at4gvybnqMhVcaG+l0aQwNvEjQ+otPjaKLvG5cRFakNuCJTz3Vz2ye7MwA5t
 R3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779177500; x=1779782300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0O7NjoL+R/sxIKqd8QTl9D3WD0q+Tb+G5snzgoV+gXI=;
 b=q0aXjJigHNrVdir3i/eH+9GT1d4KmA3nUycblVaguno+qkSNlFI919Ic31B9JjU+Nz
 KdpAyUxnw8tSKazR+fHvNvzzDgeLvaq4naWN+Vx7WiwRcDKwrjfldwn6djBZ42z1hM4d
 s/g9AOvWvMHmsuuCFI6BJe7yRLpTsGtWR3b5GKSE0xxTEaec7JZV2N9n7a9IXYI04RW1
 0Cof0gD3VNGdITm6TkkNUcYOavtH6AD0vrfK8uLDczgDqppPDpZfZS3jI0fCj+Td3cme
 /fhtKKrh43HFi5ahHtdPzqjERdWKidERqDA/im6nrael1TQ5IeUnLLr051463nreCQYG
 fRWw==
X-Gm-Message-State: AOJu0YwsoTg+ZDPLsCsRL6x1kkqhTUjB7R+dBMFWQxZExYaC+SqSh2Qv
 TeKlpO8RN5+pOXH5+uln21eqF6SZzgsro47Idfdq6UyryYdEearLUTLc2cnEZLb8ISGBRS45UVl
 peg6SWiu3wJQ081n2pK6yqkT/OHzsCyEuHcrgLD7Cqw==
X-Gm-Gg: Acq92OFzTCa6XUJdpGdEuZ3N01ZzwfFKzCK5P0FvpO17D0oBQLrEhGBS50cgseGh+Jq
 14w1+XWntfvLkU/2t+yXvTryC3Q6IzDm37GuqN15AyRT6QB5GhLyf8vdhExMfKoHOnUnqmTGEo4
 j0iYAz/gUHRJ3nUHX9Sfx0APwr7w99g5kLJVb/W4GVirU84EwrsYdV1Y09yTqjS27+HJn+sCBBR
 XN5F9MlTN3dbkTf9uwEQ50vIoqO+HZ4cRtIZq9UN71hl2ADdJyDTMceBzQKiXuf+LY7rT8qgcwB
 /zWByPqwovJxbaQqBuRSnU7MgElXCDb9lUItuA==
X-Received: by 2002:a05:6820:1b05:b0:682:ecb8:c2b with SMTP id
 006d021491bc7-69c5d3b8b7cmr9754640eaf.6.1779177500549; Tue, 19 May 2026
 00:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260507092843.358908-1-jens.wiklander@linaro.org>
 <20260507092843.358908-31-jens.wiklander@linaro.org>
 <CAFLszTgpBA0kHEScDQsA2M6NNkXQ8Yfvmsp_5uG+LdwiX93rkQ@mail.gmail.com>
In-Reply-To: <CAFLszTgpBA0kHEScDQsA2M6NNkXQ8Yfvmsp_5uG+LdwiX93rkQ@mail.gmail.com>
From: Jens Wiklander <jens.wiklander@linaro.org>
Date: Tue, 19 May 2026 09:58:09 +0200
X-Gm-Features: AVHnY4IggbIDrzLxSpI75hYx-dnGlPcS0O_Bly0s-JZJ_nCBTeVWoZPVHDo7I2w
Message-ID: <CAHUa44H1Bwb0SE3mb_W7ZqZ3tOdKjYj4UKBgjnL2mU-oD_rczw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 30/64] usb: dwc3: import from kernel v5.6
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Fri, May 8, 2026 at 5:36=E2=80=AFPM Simon Glass <sjg@chromium.org> wrote=
:
>
> Hi Jens,
>
> On 2026-05-07T09:27:07, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> > usb: dwc3: import from kernel v5.6
> >
> > Sync Linux kernel dwc3 changes from v5.5 to v5.6.
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
> > List of commits: git log --oneline v5.5..v5.6
> > Commits imported:
> > dad2aff3e827 usb: dwc3: gadget: Update chain bit correctly when using s=
g list
> > [...]
> >
> > drivers/usb/dwc3/core.c   |  3 +++
> >  drivers/usb/dwc3/core.h   |  2 ++
> >  drivers/usb/dwc3/debug.h  | 39 +++++++++++++---------------------
> >  drivers/usb/dwc3/ep0.c    |  4 +++-
> >  drivers/usb/dwc3/gadget.c | 54 ++++++++++++++++++++++++++++++++-------=
--------
> >  drivers/usb/dwc3/gadget.h | 14 ++++++++++++
> >  6 files changed, 74 insertions(+), 42 deletions(-)
>
> > diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> > @@ -167,6 +167,9 @@ static void dwc3_ep_inc_enq(struct dwc3_ep *dep)
> >  static void dwc3_ep_inc_deq(struct dwc3_ep *dep)
> >  {
> >       dwc3_ep_inc_trb(&dep->trb_dequeue);
> > +     /* set no action before sending new link state change */
> > +     dwc3_writel(dwc->regs, DWC3_DCTL, reg);
> > +
> >  }
>
> This hunk is in the wrong function - it should be dwc3_gadget_set_link_st=
ate()
>
> I'm wondering whether this is intentional, i.e. that you are not too
> worried about the accuracy of these individual commits and are mostly
> just concerned with the final result.

That's right. I'm copying the end result of each kernel version. The
commits listed in the commit message have not been treated
individually. I'm listing them in the commit message because I think
it might help in some cases when searching for something later.

> That seems OK to me, since this
> is just such a large effort, so I will skip past these.

Thanks.

Cheers,
Jens

>
> Regards,
> Simon
