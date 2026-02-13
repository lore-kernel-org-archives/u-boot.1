Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7776EF99DB
	for <u-boot@archiver.kernel.org>; Fri, 13 Feb 2026 20:20:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A15983AA9;
	Fri, 13 Feb 2026 21:20:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XI5UKE39";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4614B83C4B; Fri, 13 Feb 2026 21:20:12 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C81683015
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 21:20:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b88593aa4dcso149034566b.3
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 12:20:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771014010; cv=none;
 d=google.com; s=arc-20240605;
 b=BebuHmPAdC5/IOGcsCtfORZGWjVKl3Rq5x+LDaO1je19+dhCboziWn02C32xy7Xrx1
 dzOplhw5k3KSrm2HskIkfveda6sYEI+6ELcVivDPZo1ypFuR2JMxbjVm51XZU1xeXdsg
 opdvMLVy6gNOenMTN8mj+7av8qZGl1LoNKbp8I5ry4EHutWnh0To7CWyCpQXdrXWIjgU
 dKUhjaMORStGLoNwFHnfjAkkHh54xeTYkNMXY1YI+llObg4o+GwW3rYt56mT5ZEtSdlU
 WmR9pw8pmYtsuL58FoSKa9djZ3zW2rMEoY4Sezaa0opfuJ3RSNQPCIoXe+cHk0F8v5Y5
 vWSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=SAUdYcuVOUwnf0yyrGYwaFzOG7CPrA4Bu87uLl0vEFw=;
 fh=kd25DCm9SEK4T2XF1Qs0RmfdzVW91dHpY2sZdOl7ZyI=;
 b=DQjc5tqTniJubGqiCTc2qznMjs4wP5IjnB2Y+7u1wBLdP5lpYoNKRffaB8a+RpI7X3
 0Ttn2LQCKXtHAHUsL8xFBvKxQlspInc8t2o/VDGnDyQdUszDnk3Smenp+gfr+nY8rpCn
 XOLr9hz225OpCbHNJCdt/iJsq5eZyhJoJmlEsIh6pTmzsbJgG6yP9j+Tk8Z8Ywx5l79h
 +TdHmoRT8CacaFfoklO6a8XW9basaf6Zdbe3g5KfoZG6tM6M1XPmFpTbc5mYW1j16yer
 vOZ7YmxnXwtG6yfB68XPHCGTF1Gk7kuIAr/dudZFwiCj74VOhNmCHZI41WT5ftc+ottc
 AGqQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1771014010; x=1771618810; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SAUdYcuVOUwnf0yyrGYwaFzOG7CPrA4Bu87uLl0vEFw=;
 b=XI5UKE39u/j7oHOiemf30/UYSSPE538PtmxVlGTtyHEAtCszlJ+JEQwR5G9OdETeBh
 N9s4+9yIM49+Xe1UOuaEUjsbA0KHs4CDvW93jXCc+zzOnOdAyzPb/ZSCXanBgmgI4PiL
 JV1dFZInLqK7XE4neRhd81KIKCrkOQw2frlKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771014010; x=1771618810;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SAUdYcuVOUwnf0yyrGYwaFzOG7CPrA4Bu87uLl0vEFw=;
 b=oTNyo+8Up7Liw0eDSOLQQOCXwo6zUXDj/9DctChT8qZk2D1QJwSeONXaOkaRpQhTZ/
 Ef74wIpmdnaV1aXAkjeI6O2njxsq56L2coVgPFiP9SihitRNq/65HH8RbDdvXHnBVTMb
 SbYFZVin2bAb9iE3wXoShNrvmi271xkoN6AVxKkhqAKFakj7873tgGu5XOoqoYwOzadG
 uc5MCCCgb2u9fFjYNcOqtJZu8RjafOjoS3LU5WpSygsJlTkfMNs+evsPmG/NzOddKqOn
 /cfB4OHdJvu60hrQ/M8tF8GLYHn9KJX/P/m4GRf/1gZ9fQRWLpxWpaFsfZ7Bkk+3AI42
 duRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs/mV71uY7tjVgayBAyWJzKeAqGIba9yIop/mawZbhYoyIO2npF82NzpB6OJ6UGKkL0f896kQ=@lists.denx.de
X-Gm-Message-State: AOJu0YzRPOD8VOXJqasI3pM/3oOjUCFAf3jbylxfKwt04Pc+PJik7K/2
 SGcaQ9bK4pYaKhyrlLfAbzAxLbfgEsr72FM1lvq7HhS5bXn4LHZIHKBhcFcHr9yc3V3QQAJh3nI
 tvZiNIdBJpJHWl+3Vyyg+xGGXgxQKD/Qz4vFvui8D
X-Gm-Gg: AZuq6aJzUxU/0td6rMXhzwAUqh8+ut5/2/RqlikPucRo01TAbizwAH4FK1H+DxrvFwl
 4TyKPWzGHieO8/vEPx19mquipgC+w20Nw4zxzl1nThRPgZRblPb+lkDwgWY4TicmDnDJXAJymlD
 GXi+1BMv/UGS1ZgrSOSZwI9SFuu7HUkwjzv4J9fR8KjUL6CJLU+xUbqeEFcq+rkjo5ndOS0006i
 BVXgduveet2os0CvRiSJyqPu5dHoPQr+jFcHpE+iyzHUQu+TVoGbgfxFHmsURKPxd3lmrEBW+yD
 wbr2
X-Received: by 2002:a17:907:3c89:b0:b87:31:d29 with SMTP id
 a640c23a62f3a-b8fb44d4a25mr154933266b.44.1771014009631; Fri, 13 Feb 2026
 12:20:09 -0800 (PST)
MIME-Version: 1.0
References: <BESP194MB28058C540F0C3D28F4D08541DAA3A@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
 <ffa1bf53-9d40-4297-a30c-ffb9d8113820@linaro.org>
 <20251209141706.GV303283@bill-the-cat>
 <20260213165658.GJ2747538@bill-the-cat>
 <CAFLszTi2dWCN+rhXDkBX33ph4ww=6RumXAPECY5_MdzkcB3edg@mail.gmail.com>
 <20260213180100.GK2747538@bill-the-cat>
In-Reply-To: <20260213180100.GK2747538@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Feb 2026 13:19:54 -0700
X-Gm-Features: AZwV_QhIJtWPT3a2ZZrddxsVP_T-vTIGhrTRfHjMS8FXNb1zOG9mepjAxdRguY4
Message-ID: <CAFLszTgFvec5DTx_c-TF0nAVAitp5MLX6aqgxoCoko0Lw4tqCA@mail.gmail.com>
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

On Fri, 13 Feb 2026 at 11:01, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Feb 13, 2026 at 10:53:25AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 13 Feb 2026 at 09:57, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Dec 09, 2025 at 08:17:06AM -0600, Tom Rini wrote:
> > > > On Tue, Dec 09, 2025 at 12:16:33PM +0200, Tudor Ambarus wrote:
> > > > >
> > > > >
> > > > > On 12/9/25 11:56 AM, Francois Berder wrote:
> > > > > > Free buf if spi_flash_read_dm fails.
> > > > > >
> > > > > > Signed-off-by: Francois Berder <fberder@outlook.fr>
> > > > > > ---
> > > > > >  drivers/mtd/spi/sf_bootdev.c | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/mtd/spi/sf_bootdev.c b/drivers/mtd/spi/sf_bootdev.c
> > > > > > index 017a74a3016..720faf51a1f 100644
> > > > > > --- a/drivers/mtd/spi/sf_bootdev.c
> > > > > > +++ b/drivers/mtd/spi/sf_bootdev.c
> > > > > > @@ -35,8 +35,10 @@ static int sf_get_bootflow(struct udevice *dev, struct bootflow_iter *iter,
> > > > > >
> > > > > >   ret = spi_flash_read_dm(sf, env_get_hex("script_offset_f", 0),
> > > > > >                           size, buf);
> > > > > > - if (ret)
> > > > > > + if (ret) {
> > > > > > +         free(buf);
> > > > > >           return log_msg_ret("cmd", -EINVAL);
> > > > > > + }
> > > > >
> > > > >
> > > > > can we use a devm alloc method to get rid of the extra free handling?
> > > >
> > > > No, because this isn't the kernel and devm alloc doesn't always free
> > > > here. Making that no longer be the case (always freeing) is on my list
> > > > to look at doing (drivers that use devm alloc always implys/select'ing
> > > > DEVRES).
> > >
> > > We've since changed so that devm alloc does behave in U-Boot the same as
> > > the kernel (except in xPL phases), so Tudor's suggestion is a good one.
> >
> > I still like the idea of having this patch so that others don't hit
> > it. Does it show up as a leak on any code-analysis?
>
> I'm unsure what you're suggesting. If we can switch these to devm alloc
> functions now that we match the expected API of the linux kernel
> (outside of xPL where we don't care about leaks) we don't need to
> manually track frees here.

Yes I understand that. But it still looks like a memory leak. Does
coverity flag this as a memory leak?

Also, most boards do in fact leak, if this is correct:

./tools/qconfig.py -f DEVRES DM_DEVICE_REMOVE
132 matches

Regards,
Simon
