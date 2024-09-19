Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E30CCF3959
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:13:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 948E4891D3;
	Thu, 19 Sep 2024 17:13:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XbT+yIUU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BFF5891DD; Thu, 19 Sep 2024 17:13:52 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B74E891C3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2d87a1f0791so734195a91.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726758828; x=1727363628; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rJ9sji4Wjtapm3GiFFQ5l+9o8uhPBU1ae3rEFsX+iaw=;
 b=XbT+yIUUX2IFJElPV31WI+4J9Ue0WWKlLjjYy6gcY+McxW6z/dcTKHhJHmrfYuyg0p
 GvSWOD8yx/wwWhGD99pMG1Uq0qFH2eKJ6AhZ8lfm+NuJlIEcvM6pDYzSfhKwVEOsp9z2
 fiZNnvKIEG052dzxFBApSbLZpzFwyebbzjv8Un9xzTVRP4MiSTiPOf1KxilyiydEzIWC
 Nebg6n0B5zDARbwt7dADDFj9DAkpuDEXRxH8qmQjf8AbSfnU1WJxI1muBNj9LI2UOXF8
 i+J6gWH7Kf40CmiG9/AyfILNF5lW7/EpyTpEZ08ZYcwhwulL9dDerMv5JHDfJzvodGIL
 u4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726758828; x=1727363628;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rJ9sji4Wjtapm3GiFFQ5l+9o8uhPBU1ae3rEFsX+iaw=;
 b=HDYWOxGp0z20i0xkTpg6N/z8fx4N3PI40tX6tsikakR5ZUKiMncBV3ctaWE8Mz0RI9
 8knjtNOaZUuCEqhM+/IbbSS5OxuWOTG/qumKch76VzpxvHycN2eRt7g9LBu45yV8/rmy
 qNqJyxMLFdUwmPVr3um5NcDjfQacf1jtCh/3pi4NAYbYwSK22MjSJj3r8s4U/jpdXhQt
 JPIpDz++xTqOicDlPCphC4CuU334lUWEm7AARRKXPQhYnhd/hWXw+M+mS69cf6E5OdA7
 F2T7jkCGKvKMXQY4rRMg6+GCVZhJl6r/jt+xk1mvP9YlXsl9rE2foTZzrMIqBVSWO6tE
 yugw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSdWJLJe8Jyxi7sXjRVQlvDooDAjlriKcI+QUjFP8HBuiSbx7srlVNznXjClNLUyb8ZyVZnl8=@lists.denx.de
X-Gm-Message-State: AOJu0YwaAG7Dtjj5mfhsTayTQsJfrnEE+BiaeRPwVgJyDSFMu6tcrZns
 +rcgh2HoQPL0PM9X7TF91nIvhV+0Pgu27u0rH0NGKDYJnkmc9jWar7P2dMEHLOTNDUH8ZXhzKZm
 JjXS9RUgSvnTn73Oz9OEjxDqFmbJHuqCiXDrrww==
X-Google-Smtp-Source: AGHT+IGJC4q/mSlI7JBI6Lv0TmcXlYGC6iW9AymANCAj9a+UsxId1ewABc8Aj1zk6qdoyip66iNLGU8LrH1+NpsDo48=
X-Received: by 2002:a17:90b:4c05:b0:2d3:cf20:80bd with SMTP id
 98e67ed59e1d1-2dbb9e1cf4amr25155804a91.17.1726758828560; Thu, 19 Sep 2024
 08:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
 <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
 <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
In-Reply-To: <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 18:13:37 +0300
Message-ID: <CAC_iWjLY9Oea-AryLyrQJ3zXX+Bihza5B8R5UpXh58K3+Ff=Xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> On 19.09.24 17:00, Simon Glass wrote:
> > Hi,
> >
> > On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> >>
> >> Hi all,
> >>
> >> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
> >> <heinrich.schuchardt@canonical.com> wrote:
> >>>
> >>> On 19.09.24 16:10, Simon Glass wrote:
> >>>> Hi Heinrich,
> >>>>
> >>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> >>>> <heinrich.schuchardt@canonical.com> wrote:
> >>>>>
> >>>>> For measured be boot we must avoid any volatile values in the
> device-tree.
> >>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG
> protocol.
> >>>>
> >>>> Could you explain a bit why this is, and where this is checked?
> >>>>>
> >>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
> >>>
> >>> Measured boot relies on creating hashes of artifacts and writing these
> >>> to TPM. If the hashes don't match the OS will either warn or refuse to
> >>> boot. The device-tree is one of the artifacts that are measured.
> >>>
> >>> If we have random values in /chosen, measured boot will fail.
> >>>
> >>> When an EFI RNG protocol is provided by the firmware, GRUB and the
> >>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
> >>
> >> There's a comment on top of that function that explains what happens as
> well.
> >> In short the EFI stub does not even look at the KASLR seed and never
> >> randomizes the physical placement of the kernel. It only does that
> >> when the EFI_RNG protocol is there.
> >
> > OK thank you. I suppose I am more just wondering why it got added in
> > the first place?
>
> For booting via the legacy Linux entry point adding kaslr-seed allows to
> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
>

Not the kernel physical placement. It randomizes only the virtual placement

Thanks
Ilias

>
> Best regards
>
> Heinrich
>
> >
> > Regards,
> > Simon
> >
> >
> >>
> >> Regards
> >> /Ilias
> >>>
> >>> Best regards
> >>>
> >>> Heinrich
> >>>
> >>>>>
> >>>>> Signed-off-by: Heinrich Schuchardt <
> heinrich.schuchardt@canonical.com>
> >>>>> ---
> >>>>>    include/efi_loader.h          |  2 +-
> >>>>>    lib/efi_loader/efi_dt_fixup.c | 15 ++++++++++-----
> >>>>>    lib/efi_loader/efi_helper.c   |  2 +-
> >>>>>    3 files changed, 12 insertions(+), 7 deletions(-)
> >>>>
> >>>> [..]
> >>>>
> >>>> Regards,
> >>>> Simon
> >>>
>
>
