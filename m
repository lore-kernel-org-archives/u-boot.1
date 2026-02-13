Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E75EF99E7
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 23:06:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0732B83CB5;
	Sat, 14 Feb 2026 00:06:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YBV46q0u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72E7883CF2; Sat, 14 Feb 2026 00:06:36 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 218E083AA9
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 00:06:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-65941c07fb4so1814865a12.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 15:06:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771023993; cv=none;
 d=google.com; s=arc-20240605;
 b=hRaWNt/Mz+8rw8pEs2FsnNXWJwIh7Ue/u9QxHnc5f/q/EpyUdkxs6RazAWfe4lxIGa
 4kT7bpLGUd7Xk+Bq9nZmJmqiIp4zNagDYrIgnbXgGlAl7jC3H76K/BXItz2IMrECUsev
 PHNvDIy1JOjR+LNR3zdeW0DAzCM/Y65tgJGmYbqQTL08lWWrEHV2R4hcvkZ52AQpyy/F
 pGr2VBaNG8zvF/iyP8qAa9u1WzSqOBNUjxaUN7cMpWwi6oGeyZN8BSDk4NGYaYdn1rSn
 6dLR+FlkSVyyJ4jOLbjxrbpldQ7x/3uU7GKtGheQoDzFoSm8RJLycRdz7lIkcIKLMTew
 VMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=3Gx6Je3ibssy4x82I9IaAWSbAkEVo5yd8VZOOy1Q6zg=;
 fh=cZs8VClJ3VADpCweXCubiiyb+Ie+H2FNCq1AnOnXPxk=;
 b=dOg1VCt7vSWd5GcxspIjhs/936lgcN3Bvvuavtt0LsDYWHn4I2w0tcT8h+zVbZEDcN
 2HzhLMLMBEG/kQ/w0qXgWwMnVO24JkMBe4WUafhWbHZQTwdTrFsp6L3zUFV0y2YixFjl
 sHUsAshC7YPxqrqIXM5AMcTLKgZ1cWpxIbZMWvXWF882uX55HVnRJfIrY960jWrKbM5l
 VSsNnTKWadm7f9BeqAjLUILaw7mkymy57Lz5Tu5TUkHWEGzhrYFNEZxJ7Nz836vnL0Mo
 2CowVfEER4cr3rOljuDquhcVymyKMvvNyVjixoOTYDCru9eseKHiydimkK/VniUJZGaS
 /Pzg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771023993; x=1771628793; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=3Gx6Je3ibssy4x82I9IaAWSbAkEVo5yd8VZOOy1Q6zg=;
 b=YBV46q0unnpsPuvRhXn1+TshczyUwyqYor2KOnq7cnhz3HJCJsjM1CQlMtxuL5+MMc
 OZFaPWwnVZra7gibWKeGkVvIsfvAqXqcfp7ZE0iJ4vcJFSxGCuSskYJ/FkI9QX81k+xk
 eli549BaGuOipqurL/BixPZeK7wBENOJyMQ9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771023993; x=1771628793;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Gx6Je3ibssy4x82I9IaAWSbAkEVo5yd8VZOOy1Q6zg=;
 b=Kf+DzUlOfpH94Nxfxdw87eUJfsb165vZLemS6O+gH2wFTEiaUlJPR9hmXLyWjq4h7c
 6IyZrRlC/oj7ateeU/OA1LQ7xNcOr8HOgIUIg6fY7IKjxuOWA6pnI2nH2kWw4Jj+pZU7
 4fgAgxHlWTlHqeoIVF1zttz15mmBsNJALbtZUQG5C3X0ikcQ+68Nz3QnGRQOE1yLS2tN
 iUescLY/TmnNmmsiuMDl4MdKR0IvxsHaFCrBeB26jKKq60drgXncvKpSI/3GDZdqpj5F
 xU4hE3jJc2shZDhxZQFcb75MEalpOLoPEc2DpIzi0HRce5RArxwXKRFTeFUNeOJ/wClW
 WDuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5AZKR+OdNaPjfzYmy8gO4XWL4y8my80INpkAl49D6kwD+VWTR054/ifsWnsIQ6pf6EribusQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzsHn0wCvZJxqj9Fe8dq62kHF506/75WspHMZqgqvLJuxJSh9Fn
 CN1r+MHSjfctdNdzkNUqXBNBK9UzMf9KJmLLwMBDR4DgpHiMCrX7lQmL6nz+eF+UoMI1Lp7HADC
 RYsdWLrx1MfEV2YfGUtMQ5/AbLSLt2oG1IyHt3OE1NRXuiIGA/uU=
X-Gm-Gg: AZuq6aK37JihZdJcd3hI7o88O6OjWnHhD9G8XULYXj8KMflcGhV4iyM10C1URm8T0GE
 lRKVOuk+8uR2nP78/xD3Xat7IWGJ0mGvAnmSPaN4htjVtm4jbZPbdPep8SZ3J89fcI6HWT+5VkL
 rrYDX3kujsB4JAIH+3BEEes6OXqkft0vPLjdF2piGSO1NWj6TgM1IBCOQr0IBsBfREoLl33ouxF
 hQfp9QXwjr5mJsyryTjzM3JQaYjsko5O1JYxZJoU2eRXiZxAFNP+mpokSnYLDpT/pYF67Jd4bq7
 UQjDYI/OhaytvC7MIZi79QFPtbIVs44DIM7JTl8=
X-Received: by 2002:a17:907:961a:b0:b6d:67b0:ca0b with SMTP id
 a640c23a62f3a-b8fb46764admr172824266b.61.1771023993441; Fri, 13 Feb 2026
 15:06:33 -0800 (PST)
MIME-Version: 1.0
References: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
 <20251209141706.GV303283@bill-the-cat>
 <20260213165658.GJ2747538@bill-the-cat>
 <CAFLszTi2dWCN+rhXDkBX33ph4ww=6RumXAPECY5_MdzkcB3edg@mail.gmail.com>
 <20260213180100.GK2747538@bill-the-cat>
 <CAFLszTgFvec5DTx_c-TF0nAVAitp5MLX6aqgxoCoko0Lw4tqCA@mail.gmail.com>
 <20260213202908.GM2747538@bill-the-cat>
In-Reply-To: <20260213202908.GM2747538@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 16:06:20 -0700
X-Gm-Features: AZwV_QgrogoMrdKtlcFBKQPFNNBnito49Wu4J50iEpLxq1GyS3m-WU7FHBs1BoU
Message-ID: <CAFLszThBPDiFVvKhkThdNgUAGkA+72JCiP0xA+5V4ciA5vCeBg@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi: Add missing free in sf_get_bootflow
To: Tom Rini <trini@konsulko.com>
Cc: Francois Berder <fberder@outlook.fr>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de, 
 Vignesh R <vigneshr@ti.com>
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

On Fri, 13 Feb 2026 at 13:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 13, 2026 at 01:19:54PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 13 Feb 2026 at 11:01, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Feb 13, 2026 at 10:53:25AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Fri, 13 Feb 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Dec 09, 2025 at 08:17:06AM -0600, Tom Rini wrote:
> > > > > > On Tue, Dec 09, 2025 at 12:16:33PM +0200, Tudor Ambarus wrote:
> > > > > > >
> > > > > > >
> > > > > > > On 12/9/25 11:56 AM, Francois Berder wrote:
> > > > > > > > Free buf if spi_flash_read_dm fails.
> > > > > > > >
> > > > > > > > Signed-off-by: Francois Berder <fberder@outlook.fr>
> > > > > > > > ---
> > > > > > > >  drivers/mtd/spi/sf_bootdev.c | 4 +++-
> > > > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootdev.c
> > > > > > > > index 017a74a3016..720faf51a1f 100644
> > > > > > > > --- a/drivers/mtd/spi/sf_bootdev.c
> > > > > > > > +++ b/drivers/mtd/spi/sf_bootdev.c
> > > > > > > > @@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
> > > > > > > >
> > > > > > > >   ret = spi_flash_read_dm(sf, env_get_hex("script_offset_f", 0),
> > > > > > > >                           size, buf);
> > > > > > > > - if (ret)
> > > > > > > > + if (ret) {
> > > > > > > > +         free(buf);
> > > > > > > >           return log_msg_ret("cmd", -EINVAL);
> > > > > > > > + }
> > > > > > >
> > > > > > >
> > > > > > > can we use a devm alloc method to get rid of the extra free handling?
> > > > > >
> > > > > > No, because this isn't the kernel and devm alloc doesn't always free
> > > > > > here. Making that no longer be the case (always freeing) is on my list
> > > > > > to look at doing (drivers that use devm alloc always implys/select'ing
> > > > > > DEVRES).
> > > > >
> > > > > We've since changed so that devm alloc does behave in U-Boot the same as
> > > > > the kernel (except in xPL phases), so Tudor's suggestion is a good one.
> > > >
> > > > I still like the idea of having this patch so that others don't hit
> > > > it. Does it show up as a leak on any code-analysis?
> > >
> > > I'm unsure what you're suggesting. If we can switch these to devm alloc
> > > functions now that we match the expected API of the linux kernel
> > > (outside of xPL where we don't care about leaks) we don't need to
> > > manually track frees here.
> >
> > Yes I understand that. But it still looks like a memory leak. Does
> > coverity flag this as a memory leak?
>
> What we have now, or what devm alloc does?

What we have now.

The code looks like it has a memory leak (without the free()) but I
suspect you are saying that devres doesn't look like an allocation -
that would be devm_kmalloc(), right? So I suspect coverity just
ignores that since it isn't called malloc(), or it knows it is a
special case.

>
> > Also, most boards do in fact leak, if this is correct:
> >
> > ./tools/qconfig.py -f DEVRES DM_DEVICE_REMOVE
> > 132 matches
>
> That is not, no:
> $ ./tools/qconfig.py -f DEVRES DM_DEVICE_REMOVE
> 1389 matches

OK, I wonder why so many boards enable these, given the code-size impact?

- Simon
