Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538C8CD5BD2
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 01:20:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B90E38491D;
	Wed, 27 May 2026 03:20:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LdpZst6j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A436F84903; Wed, 27 May 2026 03:20:45 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B0DC284940
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 03:20:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-68719234fd8so4789121a12.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:20:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779844843; cv=none;
 d=google.com; s=arc-20240605;
 b=HEXvp0rbLBEpXfGl/ARBVdFhamJKgDZWawkILWFmQJdVad1w+0LKEBj/gkvanu7eje
 vAyKsYNU3qFVmp+OKQNS3u2TV1H0KOvcJtHaqRieyz4LIocO9ov/Vi/7KgdWy2tlNq+4
 UmHVjl7MLRfmiLJPm78DMOzKonCnJljTMVeeCOlJ2furnVL6144g0FTg86K5CB49GyUS
 LLYdkBlyEBxJSUwrbvCMLr5nt7Kg1AijqFh8Y5mdPcL2gDrLjuIjSphcz/4QgJASr4lp
 fRBQBf918mAlJniYtWP9nWE9qHUCIN+drxybmgzok23johWePb8N+yJOkjafcF0eOGTv
 nDMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/Uk4ByqmGxBr7qP7oVhp8iMNe+x0rOqOxh7cQgSvMp0=;
 fh=7HzJ9BBBx4iZa4XdRLXOksY74UmWuqL7h1CjcfaRqlM=;
 b=e4sATv3Oxk5U/WTHIIlGuUMogLYrPT7AyBzORtsZOOaW8LeVdO2ekKpE5UkZ/PbNRq
 xRwlKbO9k2XNXsZf8v9bx9b+HtUeCqSPlxjOoVXJqacQvAr7/WCkLBiFz3X+4N1x6JX/
 2DigIVfzxnGY4xgL2WuAorIfy2NJkMv4lINEq2oZMrl5oMGMPCeda0fA8/HR4D+HRinf
 eTjeWb4pQ1mwzuFt2wljgUI1aKK2S9LWoXYRfUcBfZ11WlYUVnjHqtMYWt8/09YBFFFC
 rAwg/2nawrIZix1IZP44ji4V/vYEf9YTaYQH6gITU0GcfKWXjVU0dS167fWPC21Mb4kQ
 U8sg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779844843; x=1780449643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/Uk4ByqmGxBr7qP7oVhp8iMNe+x0rOqOxh7cQgSvMp0=;
 b=LdpZst6jl6f+FtXG0xpBcSweoexMJEcUe+ukS8SXQuEe5OpuEQXEoZgXNv73dqU8p0
 C/4se8Kt1CW+WS3P25rZQNoS6HDdgU/As40Ns48dCFbTAuU60ubXkjEC/4yirz9rSQok
 2TkHoEJhHBQ9ob6FdGf9UNMiS/v5EVL2FWnkI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779844843; x=1780449643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Uk4ByqmGxBr7qP7oVhp8iMNe+x0rOqOxh7cQgSvMp0=;
 b=WNrHsfM418l4D4vKRDnV6Cc0emt+OOtUJcPnjaBPjbZdKbgRTH08vIaw/Mkx+7cNHp
 jCEqyy0RyChtXqRQYtTQxol41SvjQqx5C7YCGweeFkuYszo+g9Nx0N6IziwLWmioJXG2
 5HzqCrH1cp53aIZbIfTPy0EPR5K5KcVJyGGWM7axIaNdYsBoYF5B1mVbOTXUqI2jX2WC
 T4RhvsClBFIHATBDDwgEvgqWA2aBbnA7VD/HRd7dMgWPWERENThjxAhWWgUm+QW0kJAT
 uThX67f7L0bJAkZ2+xE8ecasVEfXyKvDs436yt28JbeJ2jBk66RhbCZYkEvCGbygkUmj
 RnRg==
X-Gm-Message-State: AOJu0YxtIrUpwCcuFGD53mLIFpKEhU1EYqG2MrA1Cr+G+Bi510ovjxdP
 nXfeL0YpQ3n9HHFsPtGpY7LrH/5ba8tnniTmvG4xsld1zHVMtjHrky/4Ri1MGlhNymO0NFpkZHP
 LfR4oQAXYWkCgE310M/zZcS5gdDdqZWmOKv0aeaZI
X-Gm-Gg: Acq92OGe899rCVO0AZsWFyhhWz8knIQuRvHoxhNLd0iIDoYrnglxohaSzRSDeWTcjkw
 p6oKTy/+nEZ9SYrwA7QmwqTNSeWa0MNjd7paYhil/j/UHcTdMjoLbRZMkNwkr3gpFm1QUPvUoCT
 zxZ6xaWYiOoX4XjroKs/AA3fQVhgYGtSP0cButgv5fmY/+RvCDTEiwgf56bucTjqCyabOfsCxU2
 r3PxZiUJJzfaDwUNAfSpydiSQ4Xh0zYnM6kxRELH7guy7Z/8QO9IoggiUKxB0jwRHgipqedtRSx
 KYN6TgdWYBdWQXxA
X-Received: by 2002:a17:906:ef0c:b0:bc6:2bd3:8176 with SMTP id
 a640c23a62f3a-bdd279d1b58mr1380716466b.35.1779844843054; Tue, 26 May 2026
 18:20:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260526-devfdt-net-v1-0-be3597b85b5e@nxp.com>
 <20260526-devfdt-net-v1-6-be3597b85b5e@nxp.com>
In-Reply-To: <20260526-devfdt-net-v1-6-be3597b85b5e@nxp.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 May 2026 20:20:31 -0500
X-Gm-Features: AVHnY4KbeNJq3qnEDSXatt5oBB7ELl0gf0GUM9HF3QGy5k19Zr0s8YjzZyN4nXo
Message-ID: <CAFLszThr_osXm8kdJr8aXEN0uZwk_-FV9EsB2s=oWqTDbu6cUw@mail.gmail.com>
Subject: Re: [PATCH 6/6] net: mvpp2: convert FDT access to ofnode API
To: peng.fan@oss.nxp.com
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Peng Fan <peng.fan@nxp.com>
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

Hi Peng,

On 2026-05-26T07:25:09, Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
> net: mvpp2: convert FDT access to ofnode API
>
> Convert mvpp2 driver from legacy fdtdec/fdt_* APIs to the ofnode-based
> interfaces.
>
> Replace usage of dev_of_offset(), fdtdec_lookup_phandle(),
> fdtdec_get_int(), fdt_parent_offset(), and related helpers with their
> ofnode equivalents, including dev_ofnode(), ofnode_parse_phandle(),
> ofnode_read_s32_default(), ofnode_get_parent(), and
> ofnode_for_each_subnode().
>
> Remove direct dependencies on gd->fdt_blob.
>
> Main changes:
> - Use ofnode_valid() instead of integer checks for node presence
> - Switch fixed-link detection to ofnode_find_subnode()
> - Replace uclass_get_device_by_of_offset() with
>   uclass_get_device_by_ofnode()
> - Update subnode iteration and device binding to use ofnode
>
> [...]
>
> drivers/net/mvpp2.c | 54 ++++++++++++++++++++++++++---------------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>

> diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
> @@ -5436,15 +5436,14 @@ static struct driver mvpp2_driver = {
>   */
>  static int mvpp2_base_bind(struct udevice *parent)
>  {
> -     const void *blob = gd->fdt_blob;
> -     int node = dev_of_offset(parent);
> +     ofnode node = dev_ofnode(parent);

'node' is now no longer used by the look of it. Do you see a warning?

> diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
> @@ -5478,8 +5477,9 @@ static int mvpp2_base_bind(struct udevice *parent)
>               sprintf(name, 'mvpp2-%d', id);
>
>               /* Create child device UCLASS_ETH and bind it */
> -             device_bind(parent, &mvpp2_driver, name, plat,
> -                         offset_to_ofnode(subnode), &dev);
> +             ret = device_bind(parent, &mvpp2_driver, name, plat, subnode, &dev);
> +             if (ret)
> +                     return ret;

This is a behavioural change - the old code ignored bind failures and
continued, the new code aborts and leaks the already-allocated plat
and name. Probably the right thing, but please mention it in the
commit message (the "No functional changes" claim is not quite
accurate) and free plat/name on the error path.

> diff --git a/drivers/net/mvpp2.c b/drivers/net/mvpp2.c
> @@ -4731,33 +4731,34 @@ static int mvpp2_port_init(struct udevice *dev, struct mvpp2_port *port)
> -             parent = fdt_parent_offset(gd->fdt_blob, phy_node);
> -             ret = uclass_get_device_by_of_offset(UCLASS_MDIO, parent,
> -                                                  &port->mdio_dev);
> +             parent = ofnode_get_parent(phy_node);
> +             if (!ofnode_valid(parent))
> +                     return -ENODEV;

We should be careful returning -ENODEV as it has a special meaning
with DM. This is a small behavioural change versus the old code, which
passed a negative offset straight through. Worth noting in the commit
message, or drop the check since the call below will return an error
anyway.

Regards,
Simon
