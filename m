Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B63CCA5FA7
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 16:34:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A790A83A6A;
	Tue, 20 Jan 2026 17:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zR7qRweU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1417C83A8D; Tue, 20 Jan 2026 17:34:08 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B720F83A2B
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 17:34:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-78c6a53187dso54368437b3.2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 08:34:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768926843; cv=none;
 d=google.com; s=arc-20240605;
 b=bAoiFjBZgzEHHLAArf9JkcgAWZPs48d5fBcvjApjf8179ucActjhMLDQpZxG5s2++1
 Em/KbYvVtezw8AGS87QdvZbGKtfpR/Ah6CDCZC0TM6fAGX9auGAv/WRUNZWJvFt0vNgp
 nQG+PMO5zBlYcK7RVh9vVf8YmW/kZ1cVwa8BFcZ/yYSlJ5Z2dTk7xp6KwHUV230A2PLg
 bSEfm0igjoCdlNHYs7CtEVtc/MdP9DxsN58kLQETAhvy9/GQhlrbI5WLHbDkKa0MF1qp
 6tRLzhT70DRcSV4540lwRDqaPVVs9QWtxjRzD9KVBNb1QrNrtT/LYSo33wiCbgYRotjD
 Ou1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9l6r6JlauA/GCUTuTKqsHjTA48BXK0duI1Lf3OWzqO8=;
 fh=jg9qQ6+mkrXnvuNvMBH40oxnCE7dsMAstE1QDisKpO4=;
 b=S+n/8XK6MHdjRNem2/qQOh5RpkjuqoUxw2DPjgB21mppJS0DWDSL/up3T8GLZIFKQI
 N33daG7S+FFGnSodDmgGRdawsRWTg0gFhvct31VtmBFvztQn+UMh4vdMycmFMzDrnZuU
 k/FBWc0aXVyMGCE5ihiAW/1fH7gnTRsr8kUf5Cw6I2CTeoiobb0fiBdiDVti3boZpmLm
 +E86+bChnvwM8c+VoC8J9OuyUglnu/Vi8GgnL+ohRO/mN6hPHYgfUR0S+S/V/lQNmB74
 oyq3KwKWycZc2bR3jM/hfkEPlJHpZY5MUw0ZN9uzmAYDN1duHGrdMwgtflUjsRURK54K
 YKiQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768926843; x=1769531643; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9l6r6JlauA/GCUTuTKqsHjTA48BXK0duI1Lf3OWzqO8=;
 b=zR7qRweUC2EatphqkExefxzyKDhOjezarrcj5XlBI/OCW0iUngN54g7vveR3uPX2PK
 ioziPLaDU8Hhy7tIn9cSV8+HDtlMToQrEwBhTdeKtpOg9hjoCujS2I+fo9smBMfG7Dhw
 hwCeWMlyNrzEwLJC1gzJKmERtwJ7PjnkK6B0GtlBcBonlutT/0oleUXX9MzUvykDV1xG
 VGntuu85DZvx7CDG0JIkqZmwYe1sopKYNk9jEozoyut19nPmKDwbLmA6uw4xBV1h+WW8
 8+72wt1YHxbB2Pto13cpm9jPm5OMBzP7orwLGxDBqbQwNS6MIfJypWT4M5vY16vBvZJ4
 AhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768926843; x=1769531643;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9l6r6JlauA/GCUTuTKqsHjTA48BXK0duI1Lf3OWzqO8=;
 b=ITYwtVyNH2c4U7ljF+K5mVgczoZehfdq55M+Kyw96Y59QqxA0p30CyIHZFj3SXdPMW
 Ol7P35S0kqYxQ6EQaFeUUcJ3sxM1D081rY4UdRv0h+h9btk24OzdvNmN+RHTlrRZpUIZ
 DWNNU8MhzSXOHO5v0OzLKzPd3ph0gOsmXN1Bl2US6SnOZU6QQ5wy70aoOS8jiYpB3XeN
 qJayk6Nm8G2hAcHLI/EECTsHvecZhZQ3Zo/fpvSKtgxNaf9P2FJdSuKx7a060eKKco5+
 M8DLzFdWDfR6pa5qQL4jBfUnQXnW+rTLyuUFjWHvPnVvLuX5aFaoGnHwrxdB6BBLkJNE
 VfCA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8X7aCemPEUWUUUlziRtjckctAsNmSg6zeupEboZHO+vkeLUNEvI3IQcQzZ+06yOZVUVPc1J4=@lists.denx.de
X-Gm-Message-State: AOJu0YxRE1eZYONg+D//Xuc/osMw7dsPPtCPIgjt3VAMs/PlQJF8cWla
 ccmOuslwAQl/GxPkFG9WHiL3Wgmwb7oiewO26e3LJ/234TglNJ53HZN7HKBgAYg/8xr8NPAE4Y7
 8xzYx0+NFqThN18geIYV4Q8vFWf7aumhjLwcX4nouUw==
X-Gm-Gg: AZuq6aJopLgE9ug71Vq5cfc0s0qVCyDw2g7NrhkQARiYDjCTyiI7vVGQPa3Ke7VWYQV
 ArJSo1VuzPzJWYxbBcN8/EyufcIekdt/+/vMGG0SZ809qZFhjU/DQ41KSuBrZLTUy7rBljfmCKh
 USlW9Dja51P+/Th0AdlBq68LeinlPzv0dwdB2H/MKWZzwBtTE9A8LjKwDSyKTo/pi9qUd9Br/oM
 cZC4w+WHICAX6JLtwnKaAj5kqXqT6+wPlltmhNNVHmI/L8viMAB40+FJ4UB9RKkjeGKCLIAA5+X
 YzSdNoGLqEs7Ljvquzoa8nxrnENPHoJD6fFhBfboqybgbUr88RSCHf9N3DvRD37Fgq8MjHqyyXF
 6xB3UvUqvhB0q5ZZ2ZTlF3IXksyEBxf1V/3jZ0hCkC2hpnaQoCnsWYBzx/RNh5dy6pfvASNUIKj
 unILj3z5neWY3Jv1gg2S8Z6oxgVt4fwKP2DXHUhQlM5ixJWGuIDdv+duvxYRl06WYaGO09pbxK7
 ZGJ5sT3xvyWLqnSLSis5YfALYjzenKITJdZUlRNKaPDkw772227U5clZnZlK+HJuMI3jWJGgR5Y
 mAXMSBE8YTxDVD41piZbrNycOBg8XX4=
X-Received: by 2002:a05:690c:298:b0:794:e8e:745b with SMTP id
 00721157ae682-7940e8e74e3mr14693157b3.70.1768926843207; Tue, 20 Jan 2026
 08:34:03 -0800 (PST)
MIME-Version: 1.0
References: <20260119210925.29185-3-casey.connolly@linaro.org>
 <87ms287hmu.fsf@bloch.sibelius.xs4all.nl>
 <5995c605-0e94-45ed-981e-49506233597f@gmx.de>
 <6922d2ec-207b-48e6-aa77-ca1e30393bc5@linaro.org>
 <20260120155211.GN3416603@bill-the-cat>
 <5e09e65c-f8e4-4a05-b5de-342c74817036@canonical.com>
In-Reply-To: <5e09e65c-f8e4-4a05-b5de-342c74817036@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 20 Jan 2026 18:33:27 +0200
X-Gm-Features: AZwV_QiqblZ8gMTTgs7tC-MeRvzBLuFeThZISf38_kjmofV7-osA5-YX5PmNrqw
Message-ID: <CAC_iWj+3RejoFr71TUmLs5GwM7U9B-2pDCVWa3vc73UF-6P-ZA@mail.gmail.com>
Subject: Re: [PATCH v2] efi: stop hw watchdog during EBS
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Casey Connolly <casey.connolly@linaro.org>, paul.liu@linaro.org,
 adrianox@gmail.com, 
 xypron.glpk@gmx.de, jerome@forissier.org, mkorpershoek@kernel.org, 
 ravi@prevas.dk, me@ziyao.cc, u-boot@lists.denx.de, 
 Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>
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

On Tue, 20 Jan 2026 at 18:08, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> On 1/20/26 16:52, Tom Rini wrote:
> > On Tue, Jan 20, 2026 at 04:12:27PM +0100, Casey Connolly wrote:
> >>
> >>
> >> On 20/01/2026 11:01, Heinrich Schuchardt wrote:
> >>> On 1/20/26 10:33, Mark Kettenis wrote:
> >>>>> From: Casey Connolly <casey.connolly@linaro.org>
> >>>>> Date: Mon, 19 Jan 2026 22:09:25 +0100
> >>>>>
> >>>>> Hardware watchdogs don't currently get stopped as part of
> >>>>> ExitBootServices, this can result in resets during boot if the OS
> >>>>> doesn't have a driver for the watchdog, or if the driver isn't loaded
> >>>>> in time.
> >>>>>
> >>>>> As with the EFI watchdog, stop any hardware watchdogs as well.
> >>>>
> >>>> This has been discussed before and rejected on the grounds that this
> >>>> defeats the purpose of the watchdog.  I think there was some consensus
> >>>> that an OS that doesn't have a driver for the watchdog or doesn't load
> >>>> it in time is broken.  Some folks also pointed out that on some
> >>>> platforms it isn't possible to disable the watchdog.
> >>>>
> >>>> Ultimately, I think EFI needs an API to control the hardware watchdog,
> >>>> such that an OS doesn't need a driver.
> >>>
> >>> The hardware watchdog interrupting an OS if it is hanging is intended
> >>> behavior. It is required for recovering from a failed capsule update.
> >>>
> >>> Some watchdog timers have a maximum timeout that is too short for
> >>> booting (e.g. 16s on some Sunxi boards). To avoid resets these options
> >>> are available:
> >>>
> >>> * Set CONFIG_WATCHDOG_AUTOSTART=n.
> >>> * Use device-tree property u-boot,noautostart.
> >>> * Use the `wdt stop` command in PREBOOT.
> >>
> >> Hmm, thanks for the suggestions. I considered doing this in some
> >> platform-specific way, but I don't think it's correct for U-Boot's
> >> default behaviour to leave watchdogs enabled, I haven't gone digging
> >> through the EFI spec but I would imagine it's not EFI compliant either?
> >
> > We've had some long discussions about this in the past. It's very much
> > intentional that U-Boot leaves watchdogs running. As Heinrich noted (and
> > is a summary of the older threads) some hardware doesn't even let you
> > disable a watchdog. But it otherwise defeats the purpose of one to turn
> > it off. Part of my feedback before was that the EFI spec needs to be
> > addressed if it can't handle this correctly.
> >
>
> The UEFI specification explicitly requires a 5 min watchdog to be
> enabled when starting an EFI binary. It should be disabled when
> returning to the boot manager. See chapter 7.5.1
> EFI_BOOT_SERVICES.SetWatchdogTimer().
>
> In 7.4.6 EFI_BOOT_SERVICES.ExitBootServices() the specification requires
> that "the boot services watchdog timer is disabled".
>
> Both has has been implemented in U-Boot as a software watchdog because
> some hardware watchdogs don't support 5 min intervals.
>
> A watchdog for the phase after ExitBootServices() is not described.
>
> Setting CONFIG_WATCHDOG_AUTOSTART=n would comply with the specification.

I think both approaches have pros and cons.
There's a small period of time between the EFI stub (at least for
linux ) calling EBS and the OS taking over, loading a watchdog driver
and setting up keepalives.
Keeping the watchdog enabled, will obviously revive the board if
something goes wrong between EBS and loading the driver. OTOH if the
hardware watchdog doesn't support big intervals between keepalives,
you might end up rebooting for no reason. As you all mentioned this
has been discussed extensively so I agree not too change the current
behavior after all.

Regards
/Ilias
>
> Best regards
>
> Heinrich
