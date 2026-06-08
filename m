Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3FACD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 15:26:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B19C1846A7;
	Mon,  8 Jun 2026 17:26:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YJkPkARp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D093A838BB; Mon,  8 Jun 2026 17:26:51 +0200 (CEST)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A70F8838BB
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 17:26:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pg1-x52b.google.com with SMTP id
 41be03b00d2f7-c8587427468so1756361a12.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780932408; x=1781537208; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yy2ZFieRrrN+mmpJZRtlOUE10BwbOJubiwhJEo0TetA=;
 b=YJkPkARp0qO/DLt4N4bylgxtbqH+ubyhdIdRhiwyXg7675AfUkbDhmEBHyKUhRI40J
 /zVSRb1+x8ttlN0HCsskK8ZqXSg9nj8YGvJxIj9kGShwecjihu+Rj2v9HRtLrYKgZRi/
 b0zKZEHt1X/IakD6xk+cl+z4LJLj94Q/VoXsOAu2Y4Umeb7twREI5CS3H8T6+zhjgHNY
 2dwBmjvM8qET6j8aL8HWHiahRjPHo0a5fl2kv/Jcc930Bypem56WV/VB8mc4s4O3HsW/
 Aw44OBQ9ESTAec/GHs7PNRobDhHWBV23AWjbm5OBe8JGqQFwnjrnFXm8MNFc/DKV+0bE
 TxoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780932408; x=1781537208;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yy2ZFieRrrN+mmpJZRtlOUE10BwbOJubiwhJEo0TetA=;
 b=GfnRUrieCJSUOVUqIID+XKPY8d0Xu8wYCkuT+8e5BRieGEx2rzV7yNb+SNxlroMjvv
 XaYUNWxoZOcnBEHHE1RqUyOjPZ5De4I5g4s6mfBAV3lq1HDJXlRpk80FEOZTgX0kTRLM
 ysUAcL5EMQ0kbRw785z5mpDO70r9VAIdS4WS1Zf13gEO45elDqLnK8lCEG0PzU28Ts+h
 WKmUtvZxyS2VKucmm/2gIbP9gyVzysGt/l2SiFp59H8+a2y3DXGCGuyXGLngjqkC9953
 XTdYGKFhSpcB6KRbiKhq/6NL9anC/yL5sotirxU5fW31Hyq6uuOx8bff+gJNKyDIL89c
 /4YQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/D0JE5wimRkFO5jWVDutXKj9CaqlsEwwVtHeg4SvfOsQ/WV3Tb4llXwi1H5tx8MP7R9Mywz0I=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3P5FRZgfONVB+XJ/C70OHDizGrYn0GBMkYluoZwKb/CfY6W0C
 ciJh6noe6giycLa6yofVUZlYQnJA58WcyPkZCMk0JZyGDtLmcap70czTZnuXqDbpZYk=
X-Gm-Gg: Acq92OG/bgm8wyIKkOV4R4qzIdk18NTcGqeEq99Jdj1I+h6lrbqdWOPUjafISEyvM2Z
 xE4JWwUiE0OoviMQ7iCKLWfRIxVVn0S9fHxdUNQFWVJkkE1D0qYdtBZUbVZJZkyHA8/BpVA3njr
 3L3GkGRfuOM3FY+DPQRZGteskeK/41REBeLpPy2Vo3ymaU+oVC5t/jd6uBxcoI5pTDCxk8YtQWk
 wx4sf4x0u5c1BBaSaNIczEAq2Iq7qZZ/HiZSUuTFS9+hbVzOkrdXBi1lVn8GfVOjnsoYVtmkQ+h
 3xSD9gwEqgoCo2VYHZ4jksJXQJrSXhrCgfizi95DG7apAPVRtrz5WHg+eCCixLEZpxDM3+rx4HE
 /4r/I4lOztkzawH+HwQKHFNAkPzw8KePriDPRFtl1mkOu/tFAq+r9AfZ5uK7VMLjmYTSK/Z1TZj
 x4QVl95mNIBaf8EUUsl4kJDyXoJ2eywz9UHOwb
X-Received: by 2002:a05:6a20:3282:b0:3b4:6cae:4a51 with SMTP id
 adf61e73a8af0-3b4ccd60b95mr17791003637.11.1780932408025; 
 Mon, 08 Jun 2026 08:26:48 -0700 (PDT)
Received: from google.com ([2402:7500:498:d80a:817d:b994:3a1b:474d])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c85df0b56c5sm16237432a12.27.2026.06.08.08.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 08:26:47 -0700 (PDT)
Date: Mon, 8 Jun 2026 23:26:44 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>
Cc: trini@konsulko.com, u-boot@lists.denx.de
Subject: Re: [PATCH] serial: goldfish: return error when device address is
 invalid
Message-ID: <aibfNE2DwYnh1B7j@google.com>
References: <vgwnt6mnls3lf3zdm6mz5siztzkvppte4ykszbvifjzukvmksf@maaxe5agqpim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vgwnt6mnls3lf3zdm6mz5siztzkvppte4ykszbvifjzukvmksf@maaxe5agqpim>
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

On Sun, Jun 07, 2026 at 09:15:42PM +0530, Naveen Kumar Chaudhary wrote:
> goldfish_serial_of_to_plat() returns success even when dev_read_addr()
> fails to find a valid address. This leaves plat->reg unset and defers
> the failure to probe().
> 
> Return -EINVAL immediately when the address is FDT_ADDR_T_NONE so the
> failure is reported at the of_to_plat stage where it belongs.
> 
> Signed-off-by: Naveen Kumar Chaudhary <naveen.osdev@gmail.com>

Acked-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Thanks for the patch.

When I originally wrote this code, I assumed of_to_plat() would always
be called by the driver core regardless of the instantiation method.
After double-checking how the m68k virt instantiates the driver, I
realize it actually bypasses this function. Furthermore, there are
currently no in-tree users passing a device tree to this driver anyway.

Regards,
Kuan-Wei

> ---
>  drivers/serial/serial_goldfish.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/serial/serial_goldfish.c b/drivers/serial/serial_goldfish.c
> index 91dc040fcf2..732f167caae 100644
> --- a/drivers/serial/serial_goldfish.c
> +++ b/drivers/serial/serial_goldfish.c
> @@ -74,8 +74,10 @@ static int goldfish_serial_of_to_plat(struct udevice *dev)
>  	fdt_addr_t addr;
>  
>  	addr = dev_read_addr(dev);
> -	if (addr != FDT_ADDR_T_NONE)
> -		plat->reg = addr;
> +	if (addr == FDT_ADDR_T_NONE)
> +		return -EINVAL;
> +
> +	plat->reg = addr;
>  
>  	return 0;
>  }
> -- 
> 2.43.0
> 
