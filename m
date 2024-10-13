Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2FDCF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 19:33:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DBCAA89015;
	Sun, 13 Oct 2024 21:33:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oUQmLw6+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B64A89040; Sun, 13 Oct 2024 21:33:47 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79DA588FEA
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 21:33:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cc03b649f2so8755046d6.3
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 12:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728848024; x=1729452824; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HqS8xIzIkn6WTjPLYuNjGJEZxDFuBRmbjoCx4CyVVgI=;
 b=oUQmLw6+PMq0VA0oMANf+cvZ2qFspncxVf6vhp4h6CqLbYDKAVks6e+gf/CHcPADT7
 eBG4CSU4ajY+XwmYVU5TDzxxo/Sb+DqZ/6SeZi0PSfuhMxyW+JWAf2Pb8riqPTNTMnWc
 JEx3qB0vjbOQxZsjrZJMPkYHOL/sfzgsadYzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728848024; x=1729452824;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HqS8xIzIkn6WTjPLYuNjGJEZxDFuBRmbjoCx4CyVVgI=;
 b=QZtHD5EoS2+khPgAqZYOV/9koa7hiYR4UUn5EP9WsD2n7GlmeUSCW7r3GEbU1Mvs1L
 +i9ssgxqSumoHtAkLWMluBozV2DKSdOhAA5cfu5xKuYrOzOB+XxZvU1FqMCkCLpxiMI/
 ESb5T+rsGB49HBLVC60gfC2Sa74Q8QRLe/Uk/IGJeQj+2gZ995xZG2wy5SKdMpZFmSSh
 WHiaPT+6zxwA725HOe1vYtlQxDQqUeoIrYvSUr718tDuo3EZ2rAMNUJTL4nyfnvpnYmC
 h6kM4M66cs1e79xuqk58+CB5c4AGIPHd18A8I1jE2e9RzZ5eBZ+zKY7bK6p7CSNjwyiu
 pp6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaeecCPvYUp3zZz4NNxYClw0LYIo7UmMsniv0lSlc1WOD1La1e2iDjKn6naoQ1Bk2zHQZcx7c=@lists.denx.de
X-Gm-Message-State: AOJu0YwBn+9qwxceOmDZaKLbDM/6XJwBAWcMJyuYlRPOpgpDU0AsVIWO
 T9AmHb1aLwpK24sjKiJrz5WYUGa8PdheSFdlo0U6feXlrg3Qbd5G12MMnancPuy7Q5kUDgu61X1
 v9wOGqWYj9uf/dkHR8tvura7oyzsRvTw228mZ
X-Google-Smtp-Source: AGHT+IG7szQeXlZAO/y/Mgd0D3G02qzF3fdZeSuMk5xzH6v991YYX6kfW3hoWEalzWT80gg7Zybv+gVNWi9ALgifxWM=
X-Received: by 2002:a05:6214:419d:b0:6cb:eca3:8e53 with SMTP id
 6a1803df08f44-6cbf0095627mr123157986d6.32.1728848024409; Sun, 13 Oct 2024
 12:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240926215950.1265143-1-sjg@chromium.org>
 <20240926215950.1265143-9-sjg@chromium.org>
 <08596845-c0b1-4557-9993-cde57420560d@gmx.de>
 <20241001002442.GC4737@bill-the-cat>
 <79d98f61-7659-47a3-938f-1eb79f402edf@gmx.de>
 <20241001180235.GH4737@bill-the-cat>
 <e02a9912-7260-4e0a-81d8-c7814907a791@gmx.de>
 <CAFLszTj6Zuj0b3kEA4OKOQY_D5XMWmtbn+HJXik+xSrB7LUjLA@mail.gmail.com>
 <20241011222807.GZ14210@bill-the-cat>
In-Reply-To: <20241011222807.GZ14210@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 13 Oct 2024 13:33:32 -0600
Message-ID: <CAFLszTiAdR-LTLqMjpyLgXDT99p+_8KZyDPk1ZJ8hTHGaQd+oA@mail.gmail.com>
Subject: Re: [PATCH v6 08/12] efi_loader: Disable ANSI output for tests
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Fri, 11 Oct 2024 at 16:28, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 11, 2024 at 04:16:28PM -0600, Simon Glass wrote:
>
> > Hi Heinrich, Tom,
> >
> > On Tue, 1 Oct 2024 at 16:18, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> [snip]
> > > The relevant error message is:
> > >
> > >      E   Exception: Bad pattern found on console: spl_signon
> > >
> > > The error occurs because the substring
> > >
> > >      U-Boot SPL 2024.10
> > >
> > > occurs multiple times during the reboot process. This is not expected in
> > > wait_for_boot_prompt().
> > >
> > > The EFI test is resetting the board and then calling restart_uboot()
> > > which by itself does another reset.
> >
> > We had this discussion a while back and I was very-much opposed to
> > restarting U-Boot within a test. It has set a bad precedent and now
> > several tests do it.
> >
> > This is another EFI thing that I would like to resolve at some point.
> > As previously mentioned, I understand we might be one test to check
> > that U-Boot does actually kick up a firmware update when started, but
> > I don't think we should be restarting willy-nilly.
>
> We should indeed not be restarting willy-nilly. And we don't. But the
> test for "can we restart the system" must restart the system. That's the
> test. It's not changing. Testing if we can restart the system by faking
> the restart is not testing restarting the system.

If it were just one test I would be OK with it...but it has spread,
unfortunately. When I run under gdb I constantly have to manually
restart U-Boot.

Regards,
SImon
