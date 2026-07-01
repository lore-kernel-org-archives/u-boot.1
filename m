Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EB0C43458
	for <u-boot@archiver.kernel.org>; Wed,  1 Jul 2026 17:04:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 62FB384BE0;
	Wed,  1 Jul 2026 19:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uGcL9VOL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE29684C06; Wed,  1 Jul 2026 19:04:03 +0200 (CEST)
Received: from mail-yx1-xb135.google.com (mail-yx1-xb135.google.com
 [IPv6:2607:f8b0:4864:20::b135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EA584BC8
 for <u-boot@lists.denx.de>; Wed,  1 Jul 2026 19:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664a09bc459so1163041d50.1
 for <u-boot@lists.denx.de>; Wed, 01 Jul 2026 10:04:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782925439; cv=none;
 d=google.com; s=arc-20260327;
 b=s7DgD7sy5uzfWrO1NdkawF+U/NhjtayOQjZru/OUaITDf34bo+XjoFOCmffnF1iDto
 tTJbw4BWCTi+DO1gnc7FQLxJbeMAMa9+kE7E9vPFQEUTTYcjpYxtBp4Hy9ZTSyRC872a
 Qj1tMbyp310TBYoxo29dcLtP4FT8Uibz+C8IBZQyWM3/Cx9/MZmfxI0yugNqQvn5788e
 HngX3byOdvMsjgAzxo/588GfA8Fx9aDXne3pBM/wK8lJ+xfufiEZOBENnSCgHPzLU3Ul
 eDQ3yLGdfJVtmPPQCm85lGFbA5soTeq9qBVZXZ0a+9ZHzmJoeKVhcur2/4F7gsap+fav
 tMiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/PAiRMKTZYPFx3nNiYiI1AjNgKa4K2ZsY7raXzbGyXk=;
 fh=pTJUsn3CsjkNNMI4de0zGh4dselXg11/Bdgb81/AsDc=;
 b=fukH9UG/QX55EHvLfzclrJBjCke7OfYy3caUYzJaHqM8/Vb4qo3XABGbQBFMLRg8s4
 /BAqccTIHu9m4BM29ZKaPGaR7Y65PaEnvMlC8+kYTvp8qgmiJnyPsDMnzGTaZhyx02Hj
 I3yR9MXzbDGakvzjGrEmAVy5x6o2omaR/0APN5n5grYilCv9UdjZLSwrzCizzWuga7cY
 MtWMH7vj/1Im8RLjjD5BYKPLZYTxSFFpBSHXnDGZX2RPLldTkS2mzgEIwkNiWuonsq/m
 bE8dLAs2XRKclXdg5dXVsq6S1HAcRvf28NxFluylXTQ6GD3AwP/tMtoEv53H8Rb8Q38u
 4aaQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782925439; x=1783530239; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/PAiRMKTZYPFx3nNiYiI1AjNgKa4K2ZsY7raXzbGyXk=;
 b=uGcL9VOLqe9DjVlMgltUg1T5btGpLG/ft3TYFeBAyBjTS+ei/HVMBhQkdH3vUQpETM
 VDVUc8fAS6xFtgh9/pzlV2xUfJtDfcfVAa4pBX7vj04XYeHTGgMVb41S8VYtO9DCr3LF
 T7xGQucpgjn6VCL0yMpSg3ZyBqen3qrG5bG3Bkk0A1ICPEN9+jltEaP93Vv6Hyc1xbzn
 JtQNnY7NjQSdSWHxCE0IyN72XXiJ7qeHLgcPi7cKNmJw6jJS02lsYaqowFUYN76Zqzk9
 /69srqsvhAMSDJB3WHcBedbfc9XxIHvy1ycTHWdEr+pnyC3+0dBKWsLLw3Rc84HcNqyo
 SbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782925439; x=1783530239;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PAiRMKTZYPFx3nNiYiI1AjNgKa4K2ZsY7raXzbGyXk=;
 b=T99PReBJ+JfngbHBAxqdKHEobaHqIgEPyJ2TpYETdyqR2CmxTlildlzXJfgO5d+KIQ
 v3RVA5jQoJwKcgoInyZxWqoNL7RQvDOHkMoSXKvc5d26dC06AuULNyIdGyV/DzgM+YBR
 dkhZSEWE1+QUOH8JRQsI9NnSpMyZhUGsOTZ+pzRzOrHJPxzap3WwSVxIzBcU1OdnIRiD
 jNqrLT0DSKUPJt9de+yttXx0gdY8J6b7FuhLLpQuiXRY/lAqf0CCne3Q6Mf2NEa80PHo
 sBeWJlFtMU/uWL4sRS3gZxyJ69uFWC7O+5bYrknP8FsX+hgzVLe3YL5o2L58J+GUjqGX
 44QA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp60vVzPn+pyposm8kk71+SOLqMFZFyOMNDIFhWaY2Qz5qI+xcuWRQDlHoPk+Z8lwkh5AY+NAk=@lists.denx.de
X-Gm-Message-State: AOJu0YxDBpJqJlJIkhQ6qK8uub+ygzlhjGkvJqz6kSHRtqOup/PkyWZ4
 LB42ptx4AOgsKHdGVdyGTYAKFda+ZWZF5JIe1+URXwesQ8MbJ5kLaZc+SBd7g9qV3nmkQIksJ+k
 H+6UG+XSacr321Hy/jcQQi2S91GOvAB4hJM2Xqu32BA==
X-Gm-Gg: AfdE7cmbr6/ZLqvGx1x14Nvi4y9bhb+xsng6OaLdi6J2HY0ePMsoRvT7TPG/yawQ7vg
 LLnCZe44fe8KURc0ugZeFMQBspLuGyAqPzwaIJH3S2VY6CaPCLsfENbKWKSvpwakPuiTerrLsUy
 zU07ofuRZjkzbs1h3gZrqvvOwZXqHoduhJqAWEmjtopXTgoOufsgObEQlT4V4NjMTVoAvAML0Wi
 WFRR0RyeThi6ln0dKXwxMEB0w+FWDLNTCCS72IhN8ovOiXx+YF2FVUBtJ+dR8tKf8j2VIojfFDR
 oZXgedqj5HjY0gqfFz1lDKo8wWUMStLiHs40//Eniwd4++tNSFpGJ5ErUYlvJEN3fOGAVBNUYjQ
 wMuccxOtGPgIniclaWO2wE5we+O9QQg0xtin5DoSLQNQfMyyirWjJz11oVclyVnYZdk6orEtCJ/
 5SHekEjbwtRT5wM41KXYnt9kKxhC2a9D2PiEGjSOcPbcA67ljxzkRitTCMD/Lb4ApLoGRCgKpS/
 UNLZpFiZOY89NB9TvMvll/fa0whh7b2JjZitXN/AHKFbiHOpQlTEwk6ZRNokryKGGs9mDe2NoeA
 XeNaUNfznnr1E26gcLrog3TsKDBb+0Yb1p7uimfc7yRi+6Y9mOHW1uppOsiCB+5ZZeGOfp6CxAV
 eUylRh4o=
X-Received: by 2002:a05:690e:134c:b0:664:ae03:5250 with SMTP id
 956f58d0204a3-66521a9a798mr2381078d50.27.1782925438819; Wed, 01 Jul 2026
 10:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260629084507.3254232-1-jens.wiklander@linaro.org>
 <20260629084507.3254232-65-jens.wiklander@linaro.org>
 <81d73d59-c56f-45a2-8db6-8741ea6ab1a5@nabladev.com>
 <87se636kyg.fsf@kernel.org>
In-Reply-To: <87se636kyg.fsf@kernel.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Jul 2026 20:03:22 +0300
X-Gm-Features: AVVi8Cdz_DWaXI1wjskfYtU3A0AbigtYOamec6FBg75ksVGGSV_rPgOdywZMc_4
Message-ID: <CAC_iWjJ88yXAopCqVGOW=Q2i_XX7Ojrkq4e8cfP8tmPz9+jr-g@mail.gmail.com>
Subject: Re: [PATCH v4 64/64] usb: fix build after resync of DWC3 with kernel
 v6.16
To: Mattijs Korpershoek <mkorpershoek@kernel.org>
Cc: Marek Vasut <marex@nabladev.com>,
 Jens Wiklander <jens.wiklander@linaro.org>, u-boot@lists.denx.de, 
 Andre Przywara <andre.przywara@arm.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Anshul Dalal <anshuld@ti.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Eddie Cai <eddie.cai.linux@gmail.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ion Agorria <ion@agorria.com>, Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>, 
 Lukasz Majewski <lukma@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <ravi@prevas.dk>, Ryder Lee <ryder.lee@mediatek.com>,
 Simon Glass <sjg@chromium.org>, 
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Varadarajan Narayanan <quic_varada@quicinc.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Zixun LI <admin@hifiphile.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
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

Hi Mattjis

On Wed, 1 Jul 2026 at 13:52, Mattijs Korpershoek
<mkorpershoek@kernel.org> wrote:
>
> On Tue, Jun 30, 2026 at 12:38, Marek Vasut <marex@nabladev.com> wrote:
>
> > On 6/29/26 10:44 AM, Jens Wiklander wrote:
> >> From: Jerome Forissier <jerome.forissier@linaro.org>
> >>
> >> Fix build errors after the re-sync of the DWC3 driver with the kernel.
> >> U-Boot has different needs than the kernel: buses, interrupts, internal
> >> APIs (DMA, traces, DT...) so many adaptations are required. This commit
> >> re-introduces many of the changes that were done locally after the
> >> initial import of the DWC3 code from kernel 3.19-rc1 11 years ago, as
> >> well as other fixes. This is compile-tested only.
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> >> Tested-by: Alexey Charkov <alchark@flipper.net>
> >> ---
> >>   drivers/usb/cdns3/ep0.c                |    8 +-
> >>   drivers/usb/common/common.c            |   23 +
> >>   drivers/usb/dwc3/Makefile              |   57 +-
> >>   drivers/usb/dwc3/core.c                | 1761 ++++++------------------
> >>   drivers/usb/dwc3/core.h                |   39 +-
> >>   drivers/usb/dwc3/dwc3-am62.c           |  424 +-----
> >>   drivers/usb/dwc3/dwc3-omap.c           |    2 -
> >>   drivers/usb/dwc3/ep0.c                 |  110 +-
> >>   drivers/usb/dwc3/gadget.c              |  786 +++--------
> >>   drivers/usb/dwc3/gadget.h              |    4 +-
> >>   drivers/usb/dwc3/io.h                  |   28 +-
> >>   drivers/usb/dwc3/ti_usb_phy.c          |    2 -
> >>   drivers/usb/gadget/at91_udc.c          |   46 -
> >>   drivers/usb/gadget/atmel_usba_udc.c    |  102 +-
> >>   drivers/usb/gadget/ci_udc.c            |  470 -------
> >>   drivers/usb/gadget/composite.c         |    2 +-
> >>   drivers/usb/gadget/dwc2_udc_otg.c      |  174 +--
> >>   drivers/usb/gadget/epautoconf.c        |    2 -
> >>   drivers/usb/gadget/ether.c             |   21 +-
> >>   drivers/usb/gadget/f_acm.c             |   20 +-
> >>   drivers/usb/gadget/f_fastboot.c        |   10 +-
> >>   drivers/usb/gadget/f_mass_storage.c    |    5 +-
> >>   drivers/usb/gadget/f_rockusb.c         |   11 +-
> >>   drivers/usb/gadget/f_sdp.c             |   12 +-
> >>   drivers/usb/gadget/f_thor.c            |   19 +-
> >>   drivers/usb/gadget/udc/Makefile        |    1 +
> >>   drivers/usb/gadget/udc/udc-core.c      | 1026 +++-----------
> >>   drivers/usb/host/xhci-dwc3.c           |    4 +-
> >>   drivers/usb/host/xhci-exynos5.c        |    2 +-
> >>   drivers/usb/mtu3/mtu3_gadget_ep0.c     |   16 +-
> >>   drivers/usb/musb-new/musb_gadget_ep0.c |   24 +-
> >>   drivers/usb/musb-new/musb_uboot.c      |   39 -
> >>   include/dm/device_compat.h             |   13 +
> >>   include/dm/read.h                      |   46 +
> >>   include/linux/compat.h                 |   15 +
> >>   include/linux/usb/ch9.h                |   25 +-
> >>   include/linux/usb/gadget.h             |  520 ++-----
> >>   include/linux/usb/otg.h                |   10 +
> >>   include/linux/usb/phy.h                |   56 +
> >>   39 files changed, 1351 insertions(+), 4584 deletions(-)
> > This patch needs to be split up, this is unreviewable, sorry.
>
> I agree with Marek, this is quite difficult to review. Can we split it,
> please?

Sure this is reasonable. As long as we all agree that the current
approach of rebasing is acceptable. This will make the 'breakage'
window a little bigger, but as long as it's explicitly mentioned in
the commit messages, I personally don't mind

Thanks
/Ilias

>
