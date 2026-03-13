Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49D14105F7BC
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:47:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD271842F4;
	Fri, 13 Mar 2026 16:47:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b0xwsaq6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 007A8843BC; Fri, 13 Mar 2026 16:47:55 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDADE8423D
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-662b5bf4b10so3997134a12.1
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:47:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773416872; cv=none;
 d=google.com; s=arc-20240605;
 b=JUJRAggc7iEkdJnn/8hD36RMkRZmG20Ebdfq3VAL9aXV6uzU4aVsMV6KaD2KU3ewI6
 BuuHXXr1HQ0HYD4mb37GJotQ2eZf4CywhaXBsxrNQjuylT5wPXssMWnvytrW4KQAN24f
 a6qodwCy9moslHUGvyGt4J3KHxSPM8lRJXRlTqDuRh7Jz1wnpB7vN/g/XAn6VdvAeGI0
 38WDrMXd/mKubAhYLssQKPhsX4PqMZFnGS/hXbObD4kQzrFEeJHl2dlHgM07bWVDCLj7
 WVVIkK8wy2sR9DEY8QPBwcBR3C0NPY3e0uDPdAc0GZkEiV8zwFUpko9wh3axgTFIUnq2
 KDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wbO0hvCxDRfd14y1n1IjC1/W4BeAflh+QLT3Sslw7tQ=;
 fh=+tBJv6sSNt/MwyOwu8JfajLQ5ColwPFtsYSkr6JFNTE=;
 b=euI0BBggQQs99naqWy3ktSK8p1N8Sb/mFWXZh37j/rsaVYS9GGBlsW7f8eDbIkLoS0
 qSyUMq7wJ52Qs9Y1v5B2neD5t1oDakx2Dj4GEeJa61bLn4kKfZBTlC68zfIMoyTJ1JQB
 9zqtoRAAgYRzvBvGGry6lLvdD3EzrZ2ZSuPIzJtBkeX2D3oCdLm7shj3W9qaYrPinaAP
 vMXKx0/hq4BUUSv73WtDDInp3Br0UOZ2nvs/0kNr6clcfk6HKT3E7NrkW1b2VYEHKTb8
 DXfVslt/Gf/h15GP88CTQ/28bN/LvbF0Lc5O4wZHfcVACeAdFJ46i4LgyjZGAPgcXyU+
 73uA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773416872; x=1774021672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wbO0hvCxDRfd14y1n1IjC1/W4BeAflh+QLT3Sslw7tQ=;
 b=b0xwsaq6eefICnIBy1mhXsXpK+2BFe0tgQ+CB8X8LVTorlX2X98/U6hnm2X6hSV9Un
 e5BGrSahIzOMfo26tUf0yzSxY0Yajq6X1W7nkq4r3y6SDrxjwFm/+qe7vKw4ONU4OdFg
 k3yacq8S1FtsfeDBPsdsx2WyyEjJHYIcypZgxMQRrfYZt7rOn6EdHq5D+0vkmUkcutrY
 av25DApPGx9QW64trC4ihLJAbQ0Ankf+gXIlLX3or8v9cgQjqu+r0PZQl6a1IXg3f46k
 WmGJ5VZ4a9bGnw6LxCiv9jKSviXVBE865d/hM7ym5y7r9v2zXAW85TFuiktMFUJ+EzJx
 1qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773416872; x=1774021672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbO0hvCxDRfd14y1n1IjC1/W4BeAflh+QLT3Sslw7tQ=;
 b=nDJyuqZBFfotWVKJ2I3/tyQ+VXaBBeVKy1h/5WiLmT98FAL5sRI3N8GBXmE/0fdRk4
 jUv0PjprUZIKnmB8CEoK/er66qvcBk+9SSLjyVeWBXvt+IiYhj2VX4//tPqJwT+3cPO1
 4WLTw92l8LwIKPYeq4s0x986pbO2OVCXdKsQiEDcW7n0gNK1ewOjFXLobhTHlwO3fntt
 vClUfpgEWj0EfuN6UJx4t0X/B+Hhlan0Kb3xs/5oH3jDt1alxooEsX7HRhW2X/byuf0b
 0oRjMhgT51nF+ltHEKClKFV7rf0giv4YkXCAsJrAXN+Lojzo5Mc/GfNMp4XnoeTu1Yo/
 +oAQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrTCYxZldCOAM9XLapFJJUZg9UptZ+Vi+WkDnj0Ekn4+pwBUP0OADW18opnNNVMqJwkRN+wQc=@lists.denx.de
X-Gm-Message-State: AOJu0YyyquzbxG7gpXxPEJm6b88cC8QezLU0f+6aGBeD0sdctcavceIw
 7ABTRR3E1OSy6E3IUY2MKw/AJh/cM67Yb8lpSyRV45nAnWne8Z+eRMNLKUcnIzex/JzRE0KA8Xh
 IDmJt9SnmzERiqIg6TBSKv5zW58bId7Q=
X-Gm-Gg: ATEYQzxxtVh4HUs3NeliyWLP2JzDt4VFZIBM7gWzytaRC7Mw+dtLS2HY45Y02UxJl0j
 UNqiXK9SyzxBmeLjgN86Bted5Brv2iQkInlJSgT4mWSKHyPByTgvTdjygH+S9Wm+sgHz/DCOWA8
 SA8OLaJnAKLKI7eG1D4aKxU6SvJ+9A2VaUAz34ljLYPMQTzuOuGYqm0uQhFPYTkeWdVnfz/rWsR
 7vnJxJ3FLXQQCSIg+G2SEQl7pjXo6a8vzmleC+iRhS/7qBxRDKSqBls/y0ke7agNzo0jxtQWycS
 IrLt1/1MBqdEDIMMNMPltdnr2eRjh06wpprkYoKn9hjzyenOpR+KdBmPR7fBVerHkEFnqe4utzY
 MQhyODA9XnKGFEZCHG8khFi83FGb024eP9q0aK40HHd9J8jqn7dAKHfJdKHw81LyDWfmhztekrW
 mE
X-Received: by 2002:a05:6402:274b:b0:65f:9809:7abe with SMTP id
 4fb4d7f45d1cf-663babfaa12mr2500829a12.16.1773416871973; Fri, 13 Mar 2026
 08:47:51 -0700 (PDT)
MIME-Version: 1.0
References: <e5387628c1d64caf7bcabb5d99d2987bd5bff617.1773150603.git.michal.simek@amd.com>
 <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
In-Reply-To: <CAC_iWjJLfVJb5zy_Jb=-h0d0U7-ui4yz8ihb9=g9f1nKVDRA-A@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 13 Mar 2026 15:47:40 +0000
X-Gm-Features: AaiRm53VKnwJJRHzEf1XVrvlBQGcd1ndkyBmkDi3IJMArPofp-eLCLW6ZoYD5mQ
Message-ID: <CALeDE9NrGF22D=3pA_JDFxmxZ8EiDbmbng9zd0Jr-k+JPx1dPw@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: Allow disabling ANSI console queries via env
 variable
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com, 
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

On Fri, 13 Mar 2026 at 12:55, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Michal
>
> On Tue, 10 Mar 2026 at 15:50, Michal Simek <michal.simek@amd.com> wrote:
> >
> > Commit 4cb724364030 ("efi_loader: Disable ANSI output for tests")
> > introduced efi_console_set_ansi() to suppress ANSI escape sequences
> > during unit tests. Extend this mechanism to be runtime-configurable via
> > the 'no_ansi' U-Boot environment variable.
> >
> > When 'no_ansi' is set to 'yes', efi_console_set_ansi(false) is called
> > at the start of efi_setup_console_size(). This prevents
> > query_console_serial() from sending ANSI escape sequences to the
> > terminal, using default 25x80 dimensions instead. This is useful for
> > platforms where the serial console cannot handle ANSI queries.
>
> I am fine with the patch, but the no_ansi is a bit misleading reading the code.
> It really means don't use ANSI queries to detect the console.  So
> before creating an ABI to the cmd line should we really call it
> "no_ansi" or perhaps "no_detect" and in the future clean up the
> variable names as well?

I wonder whether this should be a Kconfig option too, a maker of a
device likely knows when this is an issue on their device and
explicitly enabling it via a config as opposed to an environment
variable would likely be useful when there's a menu enabled and the
shell possibly disabled?

>
> Thanks
> /Ilias
> >
> > The variable is read using env_get_yesno() which accepts standard
> > boolean values (yes/y/1/true/t).
> >
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > ---
> >
> >  lib/efi_loader/efi_console.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/efi_loader/efi_console.c b/lib/efi_loader/efi_console.c
> > index 068d1a0a7b74..737c2331b56c 100644
> > --- a/lib/efi_loader/efi_console.c
> > +++ b/lib/efi_loader/efi_console.c
> > @@ -365,6 +365,9 @@ void efi_setup_console_size(void)
> >         int rows = 25, cols = 80;
> >         int ret = -ENODEV;
> >
> > +       if (env_get_yesno("no_ansi") == 1)
> > +               efi_console_set_ansi(false);
> > +
> >         if (IS_ENABLED(CONFIG_VIDEO))
> >                 ret = query_vidconsole(&rows, &cols);
> >         if (ret) {
> > --
> > 2.43.0
> >
> > base-commit: f74b8c2aeaf8d14565abff8f6a59625c543169ee
> > branch: debian-sent3
