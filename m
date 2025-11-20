Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB5CCFA459
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 23:41:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2FAB684135;
	Fri, 21 Nov 2025 00:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dk48BDZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2EF584135; Fri, 21 Nov 2025 00:41:19 +0100 (CET)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40CFC84150
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 00:41:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-343d73d08faso763891a91.0
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763682072; x=1764286872; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BlLGUODHtdRyXFfSJNFz+PZUICCbjJxbx/NZtbWM4SI=;
 b=Dk48BDZoTYzAg8YyZJSGSH/f9Hty7pyc5SD/M6jcoHzA182FuWYKo7nqu3gj9dAfZQ
 TQFcbgSO0FUo1l5mzzz45t5p6ssEMU8XZ8/Sieoot/shOjQeGT0k3z7Cx5vOReZRwZcc
 C/MrFnULs7J7CrPYSacZTNb9oXqJKjpwN8X4g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763682072; x=1764286872;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BlLGUODHtdRyXFfSJNFz+PZUICCbjJxbx/NZtbWM4SI=;
 b=WXxUmM0RcWHAq8wSzo5SoKE+fAi5ZlrdLYeK5PKGYXWwnWbNU2yaKAbkgazbyklBfH
 IIvWb5MTztUVeeh7d0+t5omPNj6yj/c8OxxVSl06ioSPrCXeSDcrsFyJd1G4h558Ib9b
 3bo1Yx5TXwbcLxwGNehPv5mGcQE/7QCRdPhSCLNqmwcsamTfCpKeT+Yv0D6zNZeai4hf
 VcHeO+0jlRCRlmFCmR8fUEaMVJct6Cnav9whKphWb0fC9HkByeogWfLr3kyO2G49lQYl
 Df87al5BW6VjoeVm5sJfcL8mQuanfUuy22wgZVoqk300kxHjtweAAWyJa6dWPhOrX36V
 pg6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9E6MXhxmZf/bZavjdNC0mLRDun9IQiCsR6H+0P6e2+njKHO5rF7+gfg0BD6JHj8HdJLvqc1A=@lists.denx.de
X-Gm-Message-State: AOJu0YxUsateuXSao+eNKYw6P2mT+clDLlQiHHzLVZaKWfJRAhEmCA9Y
 JVB7nKda3WwF+HmBOAZQBCqXPz1BjOGXS5Ow2bxwcAzlHqUIjqB8XCJW1NWxomkcssvgvqckGSv
 n68Ni8zocVAHgQYMbEWw8EF7cF3HZxZcTNvK/cORMYJUJ97hn0js=
X-Gm-Gg: ASbGnctWFIynBPmWrF9eycn14kjYl7aP0fdr5vQEinIJYrQg1/oZgl6m3MUwTJmigsf
 jLveSBxuCH7G26HC3ntrPq9gFAYyn1GI5s50lUuOcJ8mduEcCoVDNbVZn6rNykpAcUbF03/ZKMp
 fe6cqKLVqH8HLa1gLAk95WKGEGMhKd3ucuUjNpb3ifc54Q6utZhTpK1gr31HF1lEixqQdOZ1ZTa
 VLWCO0Zn/zKLOg8hMi2mkdxmhJDX3/Rz+BtaJ3ACN/xnC9K4WAfLf8vzou6mo9l11XxTg==
X-Google-Smtp-Source: AGHT+IHP+aQqJ8CbORoId6IruYsMmUHfzoBpX817dBqzTHo+3yUalmG7cYQUIb1MpaGVP/mMYIWJUy4nfDSMdnp0XqA=
X-Received: by 2002:a17:90b:3904:b0:340:e103:bfd4 with SMTP id
 98e67ed59e1d1-347331a77c2mr429075a91.2.1763682072547; Thu, 20 Nov 2025
 15:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20251120041526.817288-1-marek.vasut+renesas@mailbox.org>
 <6a902e2d-b1be-1ba1-5d8b-e0a07ea2aebe@nabladev.com>
 <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
In-Reply-To: <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Nov 2025 16:40:50 -0700
X-Gm-Features: AWmQ_bknS99VDCsROQrqUNcF1atxV7WprMfkoyHkx4i_3LBlBt0QaKjkIv1yI_0
Message-ID: <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Heiko Schocher <hs@nabladev.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
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

On Thu, 20 Nov 2025 at 04:56, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/20/25 10:08 AM, Heiko Schocher wrote:
>
> Hello Heiko,
>
> >> diff --git a/drivers/i2c/i2c-uclass.c b/drivers/i2c/i2c-uclass.c
> >> index 380a9f8f3ad..d0e9dad7202 100644
> >> --- a/drivers/i2c/i2c-uclass.c
> >> +++ b/drivers/i2c/i2c-uclass.c
> >> @@ -749,8 +749,11 @@ static int i2c_post_probe(struct udevice *dev)
> >>   #if CONFIG_IS_ENABLED(OF_REAL)
> >>       struct dm_i2c_bus *i2c = dev_get_uclass_priv(dev);
> >> -    i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
> >> -                         I2C_SPEED_STANDARD_RATE);
> >> +    if (!dev_has_ofnode(dev))
> >> +        i2c->speed_hz = I2C_SPEED_STANDARD_RATE;
> >> +    else
> >> +        i2c->speed_hz = dev_read_u32_default(dev, "clock-frequency",
> >> +                             I2C_SPEED_STANDARD_RATE);
> >>       return dm_i2c_set_bus_speed(dev, i2c->speed_hz);
> >>   #else
> >>
> >
> > This sounds more as a bug of dev_read_u32_default() to me and should
> > be fixed there, else we need to make this check around each call of
> > dev_read_u32_default() ...
> >
> > And looking into u-boot:/drivers/core/read.c there are more
> > candidates for such a fix (all with "default" in function name?)
> >
> > and such a fix would also make the dev_has_ofnode(dev) check in
> > i2c_child_post_bind() obsolete.
> >
> > Or may we fix the default functions in drivers/core/ofnode.c ?
> No, this was the previous implementation which is now superseded by this
> one, see [1] [2]. The goal is to fix the entry points which pass invalid
> content further into U-Boot DT handling code, so the DT validation
> happens only one, on DT input, and not again later.

Do the libfdt functions work correctly with *any* negative numbers? Do
you have a pointer to the libfdt commit which changed this? All of
driver model relies on that behaviour in libfdt:

int fdt_check_node_offset_(const void *fdt, int offset)
{
if ((offset < 0) || (offset % FDT_TAGSIZE)
    || (fdt_next_tag(fdt, offset, &offset) != FDT_BEGIN_NODE))
return -FDT_ERR_BADOFFSET;

return offset;
}

(Note the check for offset < 0)

>
> Also, please wait for feedback on [3] [4] [5] [6] before possibly
> applying this one.

Regards,
Simon


>
> [1]
> https://lore.kernel.org/u-boot/20251113122145.949112-2-marek.vasut+renesas@mailbox.org/
> [2]
> https://lore.kernel.org/u-boot/20251113122145.949112-4-marek.vasut+renesas@mailbox.org/
>
> [3]
> https://lore.kernel.org/u-boot/20251120041439.817233-1-marek.vasut+renesas@mailbox.org/
> [4]
> https://lore.kernel.org/u-boot/20251120041504.817264-1-marek.vasut+renesas@mailbox.org/
> [5]
> https://lore.kernel.org/u-boot/20251120041526.817288-1-marek.vasut+renesas@mailbox.org/
> [6]
> https://lore.kernel.org/u-boot/20251120041613.817311-1-marek.vasut+renesas@mailbox.org/
