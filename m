Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8B1106F2FE
	for <u-boot@archiver.kernel.org>; Thu, 26 Mar 2026 08:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF55983CF5;
	Thu, 26 Mar 2026 09:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dVbXxOIl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAC9283DA6; Thu, 26 Mar 2026 09:29:07 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D440E838BB
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 09:29:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-66970715adbso1302916a12.3
 for <u-boot@lists.denx.de>; Thu, 26 Mar 2026 01:29:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774513745; cv=none;
 d=google.com; s=arc-20240605;
 b=AGwRZXjxXaBDSkrxnohFaS1N1/kyvGSH/rJko4sPlfGf+TVScdZsDpz+dsbtRf/sT4
 u8yavJCbz+zHq2fS8HNLUnIijV6uVL0/1ZhOeXNUFOGF1KelcNJVbRf0D8U7oBQz883V
 vA1zIqXVBKqNa7ekMo6B2OwRE1wKymWvwvC3XViqUE0JQrD26/1VW98vLrC6jRbfyTsX
 NO9W0aZ+xAWHshrFstyPULZuu5IlcJHoI0aYxImvCXcXzqrp0BiSmw4yY3nFMome7UQo
 BBPGY+1aK9N3frFpT1paGUdgfameC515CUTsoCGGAm4fN/6KOVCeGlSnkhgViRSKHYfb
 r3ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wUkV3leqypFJwBCW/ChAbj7BsTT9Fz3gCriqOcPnntM=;
 fh=PVnhSyy3ycvMPUBco9IQzzpgWdHW0/eY65EufewLhP0=;
 b=lpPrBU/eUryjKSHzdBgdHOJYrmoUYv3O/nhWzWGvk1nB1L53C2FyJmyBX0J6BWTKvm
 RQChvzZtTpHBQ5Tffk9Y+4VIpL6JF/+tzK2Lq/56z7kUYO+Ky3zX56SiLgWRul4fvUyL
 MeLLYF+rqBdqiwWLbcOMgXcLYeRe8VjIP5Vzyt/EMy9FeUpAsOvTRfrQkVStnXidDtd/
 41m39iEW8R7Z1gNlAk4Vvvdlz9qjKyYM2BO0PHauyNfNt3/rRbC/G+lWn8Cf6jNlPGZf
 LPX8UpTdLNVgO6zbi5S0M8sE3ukdD2WB3+oEOe7ltDUJz36xDfCwlC6G+HE7gzZ86zJR
 Juyg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774513745; x=1775118545; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wUkV3leqypFJwBCW/ChAbj7BsTT9Fz3gCriqOcPnntM=;
 b=dVbXxOIlpbsKS/lgklTJs77J/neIKzoMwd6dYG38meERp+u034FqLmRXwjWFQTVW+g
 doVSkuqbUi3WySQQaCb4lvAEAUwEUdliwPf+emNWNb9j/iUz3yv4Y+h94tv4T/QKoZej
 TcMDn98fAgH5rlRCskuUC20cFEvYTjG3IjWlhPQCbxmkfh5iC2Gzk2t7QJ16wmOCyIj9
 pCTzfmj8zL6y9+GmxR3qn7ggFUO46S53cAP/7j+vXOV7jmtnP6IFNMCXZea2zom1ZLw8
 /+z08EiozipWXPHRveTlJ+jW+e9/s3gPUhpUKULQDAmMfttX4L0mnN/aGPzqXgHJYF50
 qDrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774513745; x=1775118545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUkV3leqypFJwBCW/ChAbj7BsTT9Fz3gCriqOcPnntM=;
 b=ePBGO+JxL0ivvu7jq9qYa2Q6dC/+UEpaAfYKsRj3bqQQz4Wo2OfR36jmQHM/XMI08b
 Ypud7Ruic4md5Ab6PM3C7vSyL3JldCezOlTvRB52e5ol87pdoxzbHuu8yM8ff1ag/aaH
 72WnClTW20CmdjWfvefiyZW8vYcLiGW8uZAb2lwJynvgRFTwwuMJ92GNz22SszWNZT0F
 ZKLrkubTSxbXksDH3UitKzLYUC46jb0E+amy5Ri1Q3XZ4ULPyZjA0OyuCkM8Ps8XHlKT
 gvg3epGqGTFQXe6P5evf+CRwp9lL60rbOhuPzSv3gJqaSehcA1Vafb6UYEMtgN5420kD
 FidA==
X-Gm-Message-State: AOJu0YzdFFsv/O4WgvgJxmPYDs3d4QIzZ9KCA7w1nEXKj7zWzbWM0Ybj
 mV5QMWG+5i/4GO+4Ja7LUZUwMKtAgjVoF/rkawo9bZ00nSFfISU9usKjznH03jLt+F51wEyMsAm
 VlHgPzuZ1nLUEY3Ih9hVu1aI1Tcq6lnA=
X-Gm-Gg: ATEYQzxKXWw0LsLM5wh7YN4Bu8LT/3ZjufBZ2pbNgxHmOkoD1EtujYXNG6SfRcTbGth
 VH9J3KpCqaH5T6RK7tgBQFmlPUbRlgf0q7iUJlv4xvqwhxheEkdlUEuAw++dR/xyP7NVJn78Sdm
 28n9dhFXqmsonpBbeF/QMpupvA0zN/H+XjOhOIpK6UlGRz/CotGpwmdjH8xtBflLKSau5hFSjRM
 rUwxM6Bkb5qL3RM0zIIfpsgBxvz38q72ctIDzS/uyHgcO0odCXEQqCKTVRyg/7nOll9xW/WhBcD
 ay+MIUZTAx4XX6+18tGVlXGA+6yFZLv6MBxpPAPBUmHw1OUVWpEbJJfidAuJV5w5nKXKV4/W0cw
 s7G2+x8n3EhlKC/xosA/ozLimSmZz61wQ8H4Ej3R3pmevSiHcaB2ws3OJ6nHmmBFEjSkPIfG8DI
 PYzVFm/dG1QTU=
X-Received: by 2002:a05:6402:4557:b0:665:57e8:66f1 with SMTP id
 4fb4d7f45d1cf-66a8267303fmr3326470a12.21.1774513745020; Thu, 26 Mar 2026
 01:29:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260315235816.305016-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260315235816.305016-1-marek.vasut+renesas@mailbox.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 26 Mar 2026 08:28:53 +0000
X-Gm-Features: AQROBzAMXVpbnobNFqxbVmaAHJxMo3q9qZzK4j0_yjkoklthyt3NognEjPUMbpA
Message-ID: <CALeDE9PeY8V2HjJRv96Cw1CbuXokf9pGfdBhaggWugqJwCwTzA@mail.gmail.com>
Subject: Re: [PATCH] arm: bcm: Include missing errno.h
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
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

On Sun, 15 Mar 2026 at 23:58, Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The msg.c file uses EIO macro defined in errno.h , include errno.h
> to avoid build failure:
>
> "
> arch/arm/mach-bcm283x/msg.c: In function 'bcm2835_power_on_module':
> arch/arm/mach-bcm283x/msg.c:73:25: error: 'EIO' undeclared (first use in this function)
>    73 |                 return -EIO;
>       |                         ^~~
> "
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> ---
> Cc: Matthias Brugger <mbrugger@suse.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>  arch/arm/mach-bcm283x/msg.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/mach-bcm283x/msg.c b/arch/arm/mach-bcm283x/msg.c
> index 4993c0bdb81..05e1a02e80f 100644
> --- a/arch/arm/mach-bcm283x/msg.c
> +++ b/arch/arm/mach-bcm283x/msg.c
> @@ -7,6 +7,7 @@
>  #include <phys2bus.h>
>  #include <asm/arch/mbox.h>
>  #include <linux/delay.h>
> +#include <linux/errno.h>
>
>  struct msg_set_power_state {
>         struct bcm2835_mbox_hdr hdr;
> --
> 2.51.0
>
