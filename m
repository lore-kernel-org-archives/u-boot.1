Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8E9C46CD3
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 08:50:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B939087692;
	Tue, 26 Dec 2023 09:50:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xy58aN3O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 965EA87725; Tue, 26 Dec 2023 09:50:38 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4601887480
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 09:50:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33621d443a7so4362110f8f.3
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 00:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703580635; x=1704185435; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XGP/S7Vn6twYpz0F87DzjncWxmpc1NMofpfvYwGxjpE=;
 b=Xy58aN3OfEJtcJGnyjnFLQCXUi7zWVxBk3IifwvAhkUc0E7M/yQ20voWGfA33sJfm8
 lpXbZv8QeMVqhYtdp1xhAPPI7VO1r0csv9Aju+HGAj5+A68OIJOdNk4UuZiLhuj5kAG0
 eeY+11T5DB4ExkIVycqSFDGLztrsKpBiRwLk2a8ygeMGkPZJv07QM4vyPoh3SVACgNFz
 9q2jvNWTTbz9cLVo0t4pqlX6MXSmUkMh7SSjeEzBjGOOUruumkhv5On3r9C3N+nlXgjZ
 zHNfUfr7nNRV2R55aWzbmXIEpHG1U4uREpxFIWWt0sNhKKz5ATpcsCT0qlBu/3ai0Pj9
 h8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703580635; x=1704185435;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XGP/S7Vn6twYpz0F87DzjncWxmpc1NMofpfvYwGxjpE=;
 b=ZrRIG59c/3/vdtqDOOuBclwbhkSe/eo6DWy3aB0L6ug0jJrLHfr/XP1yzlwn7EOfCD
 ux/2bHKE8wJHf32w93GC+JgBa0laoAdLRNkGvQg5DUg/VAU+700O1n8rfRuc4zN8JbnS
 BrootD0z5Tpb5d7tm8az5bRqsSkMEbJeEScRQscZvubyzGlmjFTeAyEzCbsGwfK6+Myw
 zULPiKh4R232/XsOyNGQCHPILLSGAzOIfVos//mTExA7FWLDI9bll0EA4ESaUIAfXkBS
 a+bskY2iOxvTXByi7Ae9E0iYua8viVm0zzcsrplf2nyY1ShAcO9UNcDpleKPEck+s4oq
 Nysw==
X-Gm-Message-State: AOJu0YxNceHOSYGMsnd3llRnEV/OsomSpN3H+FS9OuQQ++LXAWeK8PU6
 CIgRcqBTstU0N0olzO03Zmdzvpir0RE0n/7syZ754g4ABRE2vg==
X-Google-Smtp-Source: AGHT+IEAwjeDhRvoD0EDakWJCkQpZWrQ0EmS01Q9E9YNqxwZWgAML1yt5bN2H+ePcQmRarBaa7RoprBAXfodsRbqiV4=
X-Received: by 2002:a05:600c:2283:b0:40d:3b09:31c with SMTP id
 3-20020a05600c228300b0040d3b09031cmr3638470wmf.30.1703580635660; Tue, 26 Dec
 2023 00:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-3-maxim.uvarov@linaro.org>
 <a45cbd9a-cfa2-7728-3c5f-1a21ebbcb068@gmail.com>
 <CAD8XO3Z5Ff5u=PS5H6jaxRcdnZGh28+m6wC48A3P_H=bd5GBKQ@mail.gmail.com>
 <6ec77ae5-a05e-a18d-0c65-99f141d3e6cb@gmail.com>
In-Reply-To: <6ec77ae5-a05e-a18d-0c65-99f141d3e6cb@gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Tue, 26 Dec 2023 14:50:23 +0600
Message-ID: <CAD8XO3YRh=TV+u45nNrJJLxn4u54Fb53T7arxFO7zW730XyzoA@mail.gmail.com>
Subject: Re: [PATHv2 2/9] net: sandbox: fix NULL pointer derefences
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com, 
 tien.fong.chee@intel.com, sjg@chromium.org, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, bharat.gooty@broadcom.com, 
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Tue, 26 Dec 2023 at 12:25, Sean Anderson <seanga2@gmail.com> wrote:

> On 12/26/23 01:18, Maxim Uvarov wrote:
> >
> >
> > On Tue, 26 Dec 2023 at 04:43, Sean Anderson <seanga2@gmail.com <mailto:
> seanga2@gmail.com>> wrote:
> >
> >     On 12/25/23 10:39, Maxim Uvarov wrote:
> >      > Add additional checks for NULL pointers.
> >      >
> >      > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org <mailto:
> maxim.uvarov@linaro.org>>
> >      > ---
> >      >   drivers/net/sandbox.c | 3 +++
> >      >   1 file changed, 3 insertions(+)
> >      >
> >      > diff --git a/drivers/net/sandbox.c b/drivers/net/sandbox.c
> >      > index 13022addb6..d91935e032 100644
> >      > --- a/drivers/net/sandbox.c
> >      > +++ b/drivers/net/sandbox.c
> >      > @@ -65,6 +65,9 @@ int sandbox_eth_arp_req_to_reply(struct udevice
> *dev, void *packet,
> >      >       struct ethernet_hdr *eth_recv;
> >      >       struct arp_hdr *arp_recv;
> >      >
> >      > +     if (!priv)
> >      > +             return -EAGAIN;
> >      > +
> >
> >     When can priv be NULL?
> >
> >     --Sean
> >
> >
> > Function
> > struct eth_sandbox_priv *priv = dev_get_priv(dev)
> > can return NULL. If you ask why it doesn't return NULL without lwip
> patches and can return NULL with lwip patch while there is no clear code
> dependency..
> > Then I can not say right now and need additional investigation. But
> anyway the return code of dev_dev_priv() has to be checked I think.
>
> If you set priv_auto to a nonzero value, dev_get_priv will always return
> non-null
> and does not need to be checked. So this is a NACK from me until you can
> justify this.
>
> --Sean
>

Ok. I will remove this patch from v3 patchset and send it separately with a
more detailed description.

BR,
Maxim.
