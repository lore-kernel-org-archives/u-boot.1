Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAA6CD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0F2584ADD;
	Thu,  7 May 2026 17:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P+Bhn0FA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2CD384AFA; Thu,  7 May 2026 17:39:12 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BB8E84A7B
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:39:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67c4aaf76ecso1532046a12.3
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:39:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778168343; cv=none;
 d=google.com; s=arc-20240605;
 b=fVJb44eAal6fREtRkONyUkhztEDGXpTT94cR2R/U7L74J1I3Hv7BxijiaAxKOwjFNr
 5QjyJWPKX5OldHWvFoE7Enh87I/+hhKV1E/vZojCR1oNO9i0r/BxPYDE8fQw3ZmbPk5K
 HqKjDBarHR88G2XsR+clgdbVAjQOqRrUPbiJCiblArs93U1kRE2ZZFxFEWCqO1I1cRhX
 gxCdxNhPv/YErtjalvEaHSO65lUl3OvZbfMvm/jcDo2V2FnREMSDlCVnpUi5IgHaigdA
 1+nczr3LDyD6cv0FTLTNKmNJUGXjl8CIygHzlGoLJNdkh8+e1n9llBcOdxzCIyQX7Ugp
 Qj6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=hzD7dRrtaMnFk2KinUFKuIHU4Q4s9mAWTPpIHP9oxN0=;
 fh=NuYKXQ5QDZsGo45vG6VNNXU3zZlogmZf0+o0hHnR8wE=;
 b=e1Lq80O+DtpeoKSJ+FHhtyOGl53BkcTO381RDbcffKLRCRLUnFDizWfV8udo8U/LqS
 8ZHBza3iaBkqi7XoiSXpUm4jzUJwCt1ymLutsjs9pFUbEW02oWGj/2jEWE4wR3TKFUG5
 Ss4NIfSisZlRAmvCbmMuPkcQooi926y83PDlZZYjdMrrpVs3CC/hsk4y2eZ3lXRq6GIs
 ulZ7Yoms2AcxPYSKmUCVXpskg6GEUsNctAlc60zNdDKs73vCwY7GCEtI5I4r3Nn2i0BK
 JL5cFe06A/gKXKPxC0+H8nVqIUJN1GBLG8A8oqTeCDCa30W9B/YfNoT4talu6LV75/Vo
 f5pg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778168343; x=1778773143; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hzD7dRrtaMnFk2KinUFKuIHU4Q4s9mAWTPpIHP9oxN0=;
 b=P+Bhn0FAm2hJlMeMNp3lwuUTVyZKU73wUbu6WMvgtIucjK86/YhL72rKt6a1qcrTky
 6T0Xhigljk7AmmSPJgkebRrWAbWQ/A1sxn75ZMu+AYz+uxr6dVDfto5U6cC9fwNnXS3C
 Wdd7XR2vSWYV06X8LQMSbroOt4WhR8XGAZ244=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778168343; x=1778773143;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hzD7dRrtaMnFk2KinUFKuIHU4Q4s9mAWTPpIHP9oxN0=;
 b=eewBxhqzKb3E+it5jELgNicEcWlI1euAGPACVcJtvrTQRMJco0X1F3G7ui4kPU+9g2
 DU1E2T6M2AfMSmYT7UQj8L2rj5sVvmWHSu4TNpFyswvU5i/pcYoPIiHEwX5mlVx6CJ2K
 cUFjLP9u4i6rRgm13+N8tvmwZJeeJ6SpHj6x8h2m1tihZb+MlCrov/w75yaqXvJyDyYt
 hL2nFr45zgOxmgM36p5QaRcXdq7IGpTDi45Zcs6p65h+GTe+KIqASAw0hG4X8Z/SGAj6
 ckl/8ZoqEsOL1NF5gkSlSgaMx9gKu4/d6Y/6RqM3AZrIIgK29k9Nm9pAyNr3TLr74stK
 W5FQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NrSVN89YcS0YhXbx2clkLTm3W5Cao+h+Se38Fjq823QT+xxDIQzazRFlfmE/TCSGbpVTTrr0=@lists.denx.de
X-Gm-Message-State: AOJu0YycxnKPdgg7AfS5SLkWv5CRr65RrtbQNcTFPGUT1z3f37kGOUMT
 k/c7EEHWxz1Qpr083+fzwTxfjZwBRXPXLwTlelhp2syxWT2KzJpgmbbrvYev6iqsj1ZWxxfMKh0
 F11mgyE+8pjp7xf6NQHfGtVtIrKbbm5SWr3JN8NRX
X-Gm-Gg: AeBDievM/l19AFlTY/y/BMIFeG42I1NGocZmmzeivtuuUJZm5TpqQPCRQOs5wvrYQDr
 SWKIeYeUUUYsNwEh/Oetj+RslgYenUFZCF6mMz44IMtCj2+up3T4HBTJW6hf7/Lmk5ZY8lotK3y
 XoWVWh9EjObgQoSLS4FURfPOtxP64bdoC0OfJPHfEGPtuX/zzDZQ+Zr/HpFMmd0/8DCr6TMNo4r
 W7Hjzf7b6DKJHPaH/2WR+YYzEUHoLQQMhktDpQN2WmZ7+zQRwKq71R1e1HEWpRs0j9RCAYCnqty
 puziSkhd2VSj6iEF
X-Received: by 2002:a17:907:1c01:b0:bc4:f44f:e145 with SMTP id
 a640c23a62f3a-bc56b82fa60mr493241966b.16.1778168343318; Thu, 07 May 2026
 08:39:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1776302805.git.daniel@makrotopia.org>
 <87wlxxltnc.fsf@prevas.dk> <aeocicfRVu7NuC6T@makrotopia.org>
 <cf943303-9f48-4cb0-b055-0c2115fceeac@mailbox.org>
 <ae4-DA_TIVAEAaC3@makrotopia.org>
In-Reply-To: <ae4-DA_TIVAEAaC3@makrotopia.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:38:51 -0600
X-Gm-Features: AVHnY4JV06jjmTBVJkdF7UZiDustzZKbC6H2fa8XRmMdQW0sTg-MRbW1fG_PDoI
Message-ID: <CAFLszTjDCn+bK+m7MSbhNBipL-Pz5EaP58juUF9TcgFtorU+6A@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] fit: dm-verity support
To: Daniel Golle <daniel@makrotopia.org>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Peng Fan <peng.fan@nxp.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, 
 Aristo Chen <jj251510319013@gmail.com>,
 Ludwig Nussel <ludwig.nussel@siemens.com>, 
 Benjamin ROBIN <dev@benjarobin.fr>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 James Hilliard <james.hilliard1@gmail.com>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 David Lechner <dlechner@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Shiji Yang <yangshiji66@outlook.com>, 
 Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
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

Hi Daniel,

On Sun, 26 Apr 2026 at 10:32, Daniel Golle <daniel@makrotopia.org> wrote:
>
> On Sun, Apr 26, 2026 at 06:20:55PM +0200, Marek Vasut wrote:
> > On 4/23/26 3:20 PM, Daniel Golle wrote:
> > > On Thu, Apr 23, 2026 at 02:59:19PM +0200, Rasmus Villemoes wrote:
> > > > On Thu, Apr 16 2026, Daniel Golle <daniel@makrotopia.org> wrote:
> > > >
> > > > > This series adds dm-verity support to U-Boot's FIT image infrastructure.
> > > > > It is the first logical subset of the larger OpenWrt boot method series
> > > > > posted as an RFC in February 2026 [1], extracted here for independent
> > > > > review and merging.
> > > > >
> > > > > OpenWrt's firmware model embeds a read-only squashfs or erofs root
> > > > > filesystem directly inside a uImage.FIT container as a FILESYSTEM-type
> > > > > loadable FIT image. At boot the kernel maps this sub-image directly from
> > > > > the underlying block device via the fitblk driver (/dev/fit0, /dev/fit1,
> > > >
> > > > Can you show me where that fitblk driver lives, because I can't find
> > > > anything like that in the linux source code. Grepping for 'fitblk' or
> > > > 'dev/fit' turns up nothing.
> > >
> > > The driver is currently downstream, but going to be (re-)submitted upsteam.
> > > See below for more.
> > >
> > > >
> > > > > ...), the goal is that the bootloader never even copies it to RAM.
> > > >
> > > > Hm, how is that achieved? I.e., how do you load and boot the FIT image
> > > > without loading that part, but still reading in e.g. the kernel?
> > >
> > > The next series after this is going to suggest a way for on-demand
> > > loading only the actually necessary FIT images from a storage backend.
> > > See
> > > https://github.com/u-boot/u-boot/pull/870
> >
> > This should be posted on the ML, see .github/pull_request_template.md :
> >
> > "
> > Please do not submit a Pull Request via github.  Our project makes use of
> > mailing lists for patch submission and review.  For more details please
> > see https://u-boot.readthedocs.io/en/latest/develop/sending_patches.html
> > "
>
> I of course had also posted it to the mailing list back then.
> I just thought it'd be easier to look at it on Github than in the list
> archive:
>
> https://lists.denx.de/pipermail/u-boot/2026-February/610274.html

I made a few comments on that. I don't think people will see something
on github, so it would be worth sending the updated series to the
mailing list.

>
> >
> > That said, U-Boot SPL already handles on-demand loading of parts of
> > fitImages generated with mkimage -E (fitImage with external data). There is
> > no need to reinvent the wheel.
>
> This has been discussed in detail already when the RFC series was
> posted:
>
> https://lists.denx.de/pipermail/u-boot/2026-February/611074.html
>
> tl;dr:
> |> So there really isn't much overlap other than the fact that there is a
> |> struct with a priv pointer and a .read callback, and even that uses a
> |> different addressing parameter (sectors vs. bytes).

Regards,
Simon
