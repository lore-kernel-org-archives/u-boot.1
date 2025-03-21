Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5994C36002
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 18:38:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7708805C8;
	Fri, 21 Mar 2025 19:38:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HM6efM75";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BD08806D8; Fri, 21 Mar 2025 19:38:42 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA4E1803DF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 19:38:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac339f53df9so486022466b.1
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 11:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742582319; x=1743187119; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=c9yDMf4sdqJUhN539t1FkRgBwGyFeEcFtHS3Kob3lT0=;
 b=HM6efM75ciDfX3gADPBWW1DdQWc+Elha+SKNVCzEFiVu/4cu5ZhB40Al3p+/bfb8Qk
 +VNMHtz0ptEnAykEvNzAove6WuC7jU2Wu6NXpTp7UdvGfIVS8jSC283wlhUJaM/fjgre
 Wan7Ga0QdrMK5oZyPt22IzSL/yGQoW/MbP4Go=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742582319; x=1743187119;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c9yDMf4sdqJUhN539t1FkRgBwGyFeEcFtHS3Kob3lT0=;
 b=KpXdMY7uMzaNKIkXT88SNiy2AUGgrG5dyZrRjCYUA0/bgAO1Rp0XJiMEQvjDAZ/UCS
 c82VYTZk+7prwHXo36GwVvAaC0WOMoRTiOuGRZaoGi6lJwZH+qku6qp/RJVOep3VOt5B
 IBluLB843ELBEbXwMVAIxEVxJAG8g3B84L5kDSJCbMd354ciFhlk1aXlQMOzN58NxGlN
 fTLAuiM0ppeRMd9iibjpT4Mgb0RVkH27WITcnjpnm8lcggSm3h98UT3zP8zmdjKL3GFa
 IsEPbsbMIgCNcXabuRMg9TWArEybppQKp0JPpyi/52h9gGDESYrLgghdwxw3A2+G7S3i
 Vlaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGrZ4ntE49677/3fqE1NYE2AcTPTElAid34IgYiRvv2wyr+zHGncHSoKdSjrgBVuDsOfw0baU=@lists.denx.de
X-Gm-Message-State: AOJu0YwlI9Uypdc5bFYyx0mSyUo6vyRqQnlfHN0A4yHF16DGfAl1Tany
 Gu93A5o39vjdue0v5cf6EDzZh9OrPQLR2Z36ZzYwXQjBWcyNAf0Is7Z87d3uzqIxtboFw33JYCO
 CQfzXlvnGHAU5YdOdM8TpqedPiBs2vOhurbl8
X-Gm-Gg: ASbGncsX271/SZJpxhcRUypr6ZBgSn1bAjck9du5OEDI8JclvpInVMjia4+v0eJ3900
 e18CLHNbRBGfCu1EZBOfis7lc0ZB7haB/wEbxIBpVdOHm2IC9lbi7W4JMLP1wrNx3fmO2mSsORz
 zy07FbVL34u+HWAjfH1I6jx59j
X-Google-Smtp-Source: AGHT+IEtMNkciDs+IY9rVgoAGLHfpAo0DXHaIf9jMvNWOfYPFf3g+yMddcRt4G2LPQie+iq18xOK55zY4GuAmXtG7Os=
X-Received: by 2002:a17:907:720c:b0:ab7:1012:3ccb with SMTP id
 a640c23a62f3a-ac3f20d2423mr395302966b.14.1742582319092; Fri, 21 Mar 2025
 11:38:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250315142643.2600605-1-sjg@chromium.org>
 <20250315142643.2600605-39-sjg@chromium.org>
 <20250318140400.GX2640854@bill-the-cat>
 <CAFLszTgCZSydxeNoeVGrR9SF7-_9pZjU+NBGXVDgXG6WzYyCYA@mail.gmail.com>
 <20250318155256.GA2640854@bill-the-cat>
 <CAFLszTjC47nk3FmEyHw13zaaWwdcEavk3JY5iewKWF65iVqHiA@mail.gmail.com>
 <20250319154047.GM2640854@bill-the-cat>
 <CAFLszThVHKU+nZhmp5ysNxqTnLJ8AMX8E8eO2zvBhDQTZ5LYNw@mail.gmail.com>
 <20250320142240.GR2640854@bill-the-cat>
In-Reply-To: <20250320142240.GR2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Mar 2025 19:38:27 +0100
X-Gm-Features: AQ5f1JqNv7tkzDpi5Hpg8VZvI7OihlGmlOPOMkgNfSZK6vb_Bog3uYWIMWZFHls
Message-ID: <CAFLszTjG1pvSEV-ET+M0S4bV6biJBcS-ZodVOMhuJU7qL7PZ2g@mail.gmail.com>
Subject: Re: [PATCH v5 38/46] boot: Consider non-bootable partitions
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Bin Meng <bmeng.cn@gmail.com>, Guillaume La Roque <glaroque@baylibre.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>, Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>
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

Hi Tom,

On Thu, 20 Mar 2025 at 15:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Mar 20, 2025 at 03:43:36AM +0000, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 19 Mar 2025 at 16:40, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Mar 19, 2025 at 03:03:49PM +0000, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 18 Mar 2025 at 16:53, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Mar 18, 2025 at 03:24:02PM +0000, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 18 Mar 2025 at 15:04, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Sat, Mar 15, 2025 at 02:25:58PM +0000, Simon Glass wrote:
> > > > > > >
> > > > > > > > Any 'bootable' flag in a DOS partition causes boostd to only scan
> > > > > > > > bootable partitions for that media. This can mean that extlinux.conf
> > > > > > > > files on the root disk are missed.
> > > > > > > >
> > > > > > > > Put this logic behind a flag and update the documentation.
> > > > > > > >
> > > > > > > > For now, the flag is enabled, to preserve existing behaviour. Future
> > > > > > > > work may provide a command (or some other mechanism) to control this.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > Isn't this backwards as the existing behavior (prior to bootstd) was to
> > > > > > > scan and use these files, and so that's the behavior we need to preserve
> > > > > > > by default.
> > > > > >
> > > > > > Not so far as I know, but I've already spent too much time trying to
> > > > > > decode those scripts.
> > > > > >
> > > > > > If you look at scan_dev_for_boot_part, that is what I was trying to
> > > > > > replicate with bootstd.
> > > > >
> > > > > The feedback from the community call where this was brought up was that
> > > > > it used to work and now didn't, I thought. Heinrich, I think you had one
> > > > > of the cases here (something about RISC-V and multiple distros?) or am I
> > > > > misremembering?
> > > >
> > > > OK let's see if Heinrich chimes in.
> > > >
> > > > Are there notes for the call? It would help me if they could all be in
> > > > a shared document, like we used to use[1].
> > >
> > > Yes, they're in email.
> >
> > What subject should I search for to find them? I looked for 'community
> > call' and a few other things, but cannot find them.
>
> They're in reply to every announcement email and sent to all three
> lists.

OK, well I can't find them, sorry. I did see the first one you sent
but after that I have no record.

It sounds like you don't want them in a doc for easy reference?

Regards,
Simon
