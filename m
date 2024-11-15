Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5551D6DDEA
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 10:02:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C06E3895E0;
	Fri, 15 Nov 2024 11:02:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SmllyqUC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE30489647; Fri, 15 Nov 2024 11:02:17 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B993895AF
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 11:02:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c9404c0d50so1814594a12.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 02:02:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731664935; x=1732269735; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6T0OoGimRjqtK53lxLIJB8v4TeD1NHdIIEhPBve8AIw=;
 b=SmllyqUCN6ciO2Uxv0GxMlkvNGwxHGXYdOoMMqVnezCpmHqcveSztZWXkuYw+6lA8I
 Ew73vrBa20kSQvgOs8fEbb6Bkn6L5xVYxPhbUEuEZusGiKbygliV4ITS10uCQdOa4QVn
 1Pm4Tujvoigl0axBkPznewIOTvSDv4gpHzJk2Ux8MxGWiRJ5cNqdGifMoxUoGAew6rG7
 TOewOddZXRGcbnOmdY59lZrePdmCCM60j71+HOP6e4biR9QO5jJoQBQsmIa93Eo873Nn
 nWJ/RBFRXkjyuRn4urgCo4bxCcUM+kVY5EhHPbFCsd0QmHTsfK+AJtqy660LYFw9mTBL
 Uh7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731664935; x=1732269735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6T0OoGimRjqtK53lxLIJB8v4TeD1NHdIIEhPBve8AIw=;
 b=gwrhhvxxdzNjn5rBX16Bg8Res95QHbchpABP0qB+DBkIbcmb0qgt1NY6tNO7hcecJX
 evdMeiijo+FroWRtLnHzQfd6e9ogeoZoa4cSsaJ/jykiAqINBqH1h1hwQJ39iRLso99k
 o1gHnIx2c/bchIWl5iNm8cKbhx3QCji/KcWZjOBpwOdHc6/je5+H1A0zTNISpLy31meX
 ezDB/2BT/yz1JoPJTAnmYxmW6OBZnNI4+g7p4QPLXbp2rxG86GG12fbtLviLQZ44iirw
 gbuv9dB49bxlK9OM6K9AK6QwIruoNSUD2POprqMyUQU/r2uO4Q+DUqM9F+xqaGKNUEVC
 U6Nw==
X-Gm-Message-State: AOJu0YwvrYpt4myQH+DlyNgEGpG+1lCzktAWI7dFetIqKI43Wj24ey6t
 WjttVgRK0a8NYIw3hL5n06KG0TceIFKrMY1BwD6XwGAfMjgoXUpFYoYASxckPu9fEZN2t9go0V7
 vQqf+WlnBrTHRArQoo1IqhvX6Jkkz22y7
X-Google-Smtp-Source: AGHT+IHQ7fWmkNc/xRSxb1S3rtZ1Btxdy4yZI4nE+KRa15nYfTSc5OJoiCKkaPwwtbzAGE4s8GiOde5EmREyQD4ZAj4=
X-Received: by 2002:a05:6402:34cb:b0:5cf:4040:2933 with SMTP id
 4fb4d7f45d1cf-5cf8fd10873mr1256926a12.29.1731664934621; Fri, 15 Nov 2024
 02:02:14 -0800 (PST)
MIME-Version: 1.0
References: <20241115095617.08c607ae@akair>
In-Reply-To: <20241115095617.08c607ae@akair>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 15 Nov 2024 10:02:03 +0000
Message-ID: <CALeDE9MdfW0gKXf-tqusW7ARbVZMyQr7+jOzR-hbqbH-0yAEVg@mail.gmail.com>
Subject: Re: OMAP4 removal
To: Andreas Kemnade <andreas@kemnade.info>
Cc: u-boot@lists.denx.de
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

Hi Andreas,

> to my horror I found out that omap4 support is removed. I have some
> code waiting for a brush here for the Epson Moverio BT-200. There is
> some support for it in postmarketOS. It has a devicetree in mainline
> kernel.
> I did not manage to get hold of the vendor u-boot source, so when I
> distribute sd card images, I use something more u-boot mainline based.
> I have a pandaboard and use it as a known reference.
> Is there any chance to have omap4 removal reverted? What is needed?
> CONFIG_DM_I2C relatev stuff?

So it was removed back in July [1]. what is needed is someone to
actively maintain the SoC, the DM_I2C pieces are likely the first step
but there will be, likely minor, ongoing work needed. Fixing just one
thing is likely straight forward but it's more about an ongoing,
likely quite small, commitment of helping keep the platform up to date
and ensure it's continues to work.

If you're prepared to do that the first step would be to do a patch
set that basically reverts the removal and updates for any changes to
U-Boot since it was dropped in July, which would be at least be for
the early boot rename (SPL/TPL -> XPL) pieces and the DM_I2C
conversion.

Peter

[1] https://lists.denx.de/pipermail/u-boot/2024-July/558846.html
