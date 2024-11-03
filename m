Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B9DD11101
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 14:47:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B973689140;
	Sun,  3 Nov 2024 15:46:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dfHg9hMy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBD7F89137; Sun,  3 Nov 2024 15:46:58 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B39098862E
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 15:46:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a9a156513a1so590620666b.0
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 06:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730645216; x=1731250016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8NeQKfswvL0+myUBOMhKTuBXvi5nJcRIETdOfxZeopQ=;
 b=dfHg9hMyvQ191MVeUgS4dvFf0oZVhbngVcbWukAcdchnIiygpsMVd9JBGiF8/gcfrz
 0DVZ1eUKfNDciVGJ4Z8atQRv5ancL/U2IWCt6fosXsNiXV3gLYaMMO01u1Jz/V/otcXa
 5cCmidg35oibsu/R0yjZrcDgyYI3LkSqwYEG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730645216; x=1731250016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8NeQKfswvL0+myUBOMhKTuBXvi5nJcRIETdOfxZeopQ=;
 b=FMmHkdVDhehNGPEAXvUaQzp/ptiTeHwhvHpVgM4Po+kkuBzQMc5qq9vPTswaafWTZd
 o/GtmwT5vt/H7qGX2YY9WFz/YZ7REGZ9zW7Brt/Y8JzgTxO+zsjtKCWvUmnEZR1HYWCB
 7Vt8woySsz0LgjkKM0EMoD2MucFa5MJCtQ/dhQJ6wl2wd8AicjCQlffnP26T7I+TdSVR
 gvt13buz73MwKR8zZBMCZf9b07o7Wzrvm8NnZEOo9fQUnVU830BxyJmXAlDxpKmSl4Q7
 2mnl18QIbExs0kLlASmkVKiVBjDFsflJqDZqjwAaU/bKACCS1FCJSI4musoghvHtXrTA
 Nj5Q==
X-Gm-Message-State: AOJu0YzW1Gkld0Wjh69hQbD18x2/hLYbKVr6Vnj3WSXFc5HG7px94WSU
 d37YWiipKP2HR45x6R8d0BLVwZZnTiie6Zzv8oQyvFBXSOF1iqEWoG6EBWsVfWqjVIT5uyffMPO
 9cAxmmKALVrh9SLdpMWIMaoZNUnEQYMzAUKir
X-Google-Smtp-Source: AGHT+IFoOY3x+2VH2raVAs/uznaay+nicTzi1tGbouBajFABxHM4ZW5jO57mFBbJCbOLXQynCkYeTaiw2hV+1QUI2Ag=
X-Received: by 2002:a17:907:2d89:b0:a99:33dd:d8a0 with SMTP id
 a640c23a62f3a-a9de5ff9ad3mr2617160166b.38.1730645215946; Sun, 03 Nov 2024
 06:46:55 -0800 (PST)
MIME-Version: 1.0
References: <20241017232531.726559-1-sjg@chromium.org>
 <20241017232531.726559-6-sjg@chromium.org>
 <CAFLszTihCzaut1MCtQJ=LTzYrhwyT+3On8hM2GMgSd0g6dqKBw@mail.gmail.com>
 <20241103103626.0d5c76a6@minigeek.lan>
In-Reply-To: <20241103103626.0d5c76a6@minigeek.lan>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 3 Nov 2024 07:46:44 -0700
Message-ID: <CAFLszThAGC-aBmpk4fDJ0gg+MnNYj+=uJYLQv5kgWjAkaDpyqg@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] sunxi: Move to bootstd
To: Andre Przywara <andre.przywara@arm.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
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

Hi Andre,

On Sun, 3 Nov 2024 at 03:36, Andre Przywara <andre.przywara@arm.com> wrote:
>
> On Sat, 2 Nov 2024 11:35:31 -0600
> Simon Glass <sjg@chromium.org> wrote:
>
> Hi Simon,
>
> > On Thu, 17 Oct 2024 at 17:25, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Drop support for distroboot and move to using bootstd instead.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v2)
> > >
> > > Changes in v2:
> > > - Convert the other DISTRO_DEFAULTS in the Kconfig too
> > >
> > >  arch/arm/Kconfig | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > Could this series be applied, please?
>
> So I played with that a bit:
> - The FEL script boot method works: it has the highest priority, which
>   is what we want, because the script would be deliberately injected by
>   the user to be executed. So thanks for the changes!
> - However the other global boot method (efimgr) takes precedence over
>   other, *higher* priority methods (extlinux.conf/boot.scr). This
>   leads to behavioural regressions, I think, like:
>   - Say there is a bootaa64.efi on some ESP on the eMMC. If you now
>     boot from SD card, with boot.scr or extlinux.conf on there, U-Boot
>     will still find the EFI app first and execute that. I don't think
>     that's what we want?
>   - Similar, if you have a boot script on the eMMC, and boot from
>     there, but with a USB stick carrying a bootaa64.efi plugged in.
>     Then EFI would win as well. This might be intended, but maybe not,
>     and I don't see how one would influence that?
>
> Is there a way to change the bootflow to look for any boot payload on
> the *boot* media first? So when I boot from SD, it checks this first for
> EFI, boot.scr, extlinux.conf, then goes to eMMC and USB. Similarly, when
> booting from eMMC, check there first before considering SD and USB.
> Maybe I am missing something obvious here?
>
> So while I am personally happy with EFI being a prominent citizen, I
> think many sunxi users would still expect more traditional boot methods
> to at least work - at the moment they might be permanently "shadowed" by
> some bootaa64.efi sitting *somewhere*. That actually bites me at the
> moment when working on a new SoC port, where I use an extlinux.conf as
> an override, to load a custom dev kernel and DTB, but bootstd still
> finds that grub on that SD card and uses that first :-(
>
> So I feel like EFI should still be the preferred boot method, but the
> more custom ways should be allowed to override that.
>
> Do you have any ideas how to solve that, or am I holding it wrong?

Given that we are past rc1 the easiest thing might be to revert this:

f2bfa0cb179 bootstd: Make efi_mgr bootmeth work for non-sandbox setups

until we can figure this out.

Can you try that?

Regards,
Simon
