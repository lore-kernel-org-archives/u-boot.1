Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB91C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 14:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA4A3801BE;
	Thu, 20 Feb 2025 15:00:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QbyxwhEl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B8380C98; Thu, 20 Feb 2025 15:00:40 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D08D78007D
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 15:00:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-abb7a6ee2deso161053666b.0
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 06:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1740060036; x=1740664836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=kklJzdUt+up+DR+AtKpvuS3a28MTtfdnGV6LOA39oOk=;
 b=QbyxwhElckzO2fwmMkAtO63wGxjP6E+G5E6/9FrTBNvEqPa0NIFhsYUJvsEjUl/je+
 ol+KqrvTZk5/QHPj73Hpju+PET8RrjUkpno4NGEHoWVymJf1uoD01zewkIw0MM0eNmzd
 z17GrJ4dhooG29hzFm83rkpJTHbTBPHUNYkBc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740060036; x=1740664836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kklJzdUt+up+DR+AtKpvuS3a28MTtfdnGV6LOA39oOk=;
 b=EpM47F4KeU4iWSGK7OO6HJbmfYxnzULo9xAVH/t5UHWnFPo72CiyWfXgaIs/sLoUDb
 Hn5AYR7KPEhWKLLsHRL8aJZbv3kY25Pro8/ZgNRAT2037sqTMuEQrpa2wgnuVCVR7Dkq
 HLPj8zMLj7UJeZWW9/l4E4G4Atw32xk/ienqduhlUuCEm0/ZIfvJkwz+O/VEOTGKnrV5
 4+ORf8Ag3vS+OpP1itwNtB6QtMxWcNQSHtYl4K9MM8z/yvVN2CalaqwRoP9C5e2mPkUo
 cPLqDZMZDVtqOeSmpMqBl3HNliSIDK+vG380qFqZZ7JUQJphLttOlyU1V5JoAgJaJOJU
 48xg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+JYRAbqqyp2BOkcZqzLeR+n8aE/plVcbrMElQ8seenXvSTAYS07WDSrJLNFJ9JYik4zKGqdo=@lists.denx.de
X-Gm-Message-State: AOJu0YzgdMBlkeSzvI9lDJJmGB0WudL4BzXtrxZtlOT0kFgolabAR7sP
 4eHndRZnW3HKmyXhyO+apKF1HBEEgacbCdi56JlT0CwIMhlE3YXt+DBR6m8PWHg9Tpn3T4TZRHZ
 v/AgZIYJ75BUIhOjDxQuYSbEJ6cdwisfgQc+2
X-Gm-Gg: ASbGncvymP6Yh0SkqBmzbd/scq8ltPFIm/A8K2xNDzUy/Iiz7h9hGsX7iHeUqS2uS2o
 nykLHAkiNy2WHkM4TbP4aTr3xA5w2HnXzJ0rfP6srLSRHHYHXXRQJwwsb7vXKFLp1lwnzt9edVw
 ==
X-Google-Smtp-Source: AGHT+IESNL4cceW8MLaZR3Jmxv0XLfIPHkeLjsmx4HKq8r04pC65dw3pmVL0Ktbfivd32hnJQfvCHOzLoDlFSzj5N+c=
X-Received: by 2002:a17:906:1bb2:b0:ab7:a274:d3df with SMTP id
 a640c23a62f3a-abbcce21171mr677142566b.20.1740060034732; Thu, 20 Feb 2025
 06:00:34 -0800 (PST)
MIME-Version: 1.0
References: <20250210160727.30993-1-pkochanowski@sii.pl>
 <CAC_iWjKLOw9gUxt+KE1iSTVsTawBPDXy40exTH97s7=+Bf3HRQ@mail.gmail.com>
 <6416d1a7-3221-4ea5-a88b-944f26af534f@gmx.de>
 <CAFLszTizFrZnRA49VoGrtgxmWiMSuL7Rip8Yk7tEAZVeNMcpwg@mail.gmail.com>
 <CAC_iWjL-Af-R6k8Pi3UECTja-FYa72B_td_yi5fy9aOmxs-i-w@mail.gmail.com>
In-Reply-To: <CAC_iWjL-Af-R6k8Pi3UECTja-FYa72B_td_yi5fy9aOmxs-i-w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 20 Feb 2025 07:00:23 -0700
X-Gm-Features: AWEUYZkFOHZqZaFqZnOQOcUwFHERaouy3qQ4Jo4_bYCkr7c1ojX9IVY3koEA2EE
Message-ID: <CAFLszThSO2fKPkjv_N_5_fKi6jvOHiQOdm+_856H3M_MXWCBCg@mail.gmail.com>
Subject: Re: [PATCH] efi: Make FDT extra space configurable
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Pawel Kochanowski <pkochanowski@sii.pl>, u-boot@lists.denx.de, 
 Gabriel Nesteruk <gnesteruk@sii.pl>
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

Hi Ilias,

On Thu, 20 Feb 2025 at 06:50, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 20 Feb 2025 at 15:31, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, 20 Feb 2025 at 01:21, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 2/20/25 07:58, Ilias Apalodimas wrote:
> > > > On Mon, 10 Feb 2025 at 18:07, Pawel Kochanowski <pkochanowski@sii.pl> wrote:
> > > >>
> > > >> From: Gabriel Nesteruk <gnesteruk@sii.pl>
> > > >>
> > > >> U-Boot currently reserves only 0x3000 bytes when copying the FDT
> > > >> in `copy_fdt()`, which may not be sufficient if additional nodes
> > > >> (such as FMAN firmware) are added later.
> > > >>
> > > >> This patch introduces a new `CONFIG_FDT_EXTRA_SPACE` Kconfig option
> > > >> to allow users to define the amount of extra space reserved for FDT
> > > >> expansion. The default remains 0x3000.
> > > >>
> > > >> This change prevents potential corruption when resizing FDT after
> > > >> EFI boot, especially when firmware like FMAN requires additional
> > > >> space.
> > > >>
> > > >> Signed-off-by: Gabriel Nesteruk <gnesteruk@sii.pl>
> > > >> Signed-off-by: Pawel Kochanowski <pkochanowski@sii.pl>
> > > >> ---
> > > >>   lib/efi_loader/Kconfig      | 9 +++++++++
> > > >>   lib/efi_loader/efi_helper.c | 2 +-
> > > >>   2 files changed, 10 insertions(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > >> index d4f6b56afaa..bd2cbe995c9 100644
> > > >> --- a/lib/efi_loader/Kconfig
> > > >> +++ b/lib/efi_loader/Kconfig
> > > >> @@ -586,6 +586,15 @@ config BOOTEFI_TESTAPP_COMPILE
> > > >>            No additional space will be required in the resulting U-Boot binary
> > > >>            when this option is enabled.
> > > >>
> > > >> +config EFI_FDT_EXTRA_SPACE
> > > >> +    hex "Extra space to allocate for FDT expansion"
> > >
> > > Hello Pawel,
> > >
> > > Is this problem really EFI specific? Wouldn't you have a similar problem
> > > when booting via booti?
> > >
> > > >> +    default 0x3000
> > > >> +    help
> > > >> +      Defines additional space (in bytes) reserved for expanding the
> > > >> +      Flattened Device Tree (FDT) when passed to the EFI system.
> > > >> +      Increase this value if your firmware (e.g., FMAN) needs to add
> > > >> +      more data to the device tree after U-Boot relocation.
> > > >> +
> > > >>   endif
> > > >>
> > > >>   source "lib/efi/Kconfig"
> > > >> diff --git a/lib/efi_loader/efi_helper.c b/lib/efi_loader/efi_helper.c
> > > >> index 04b2efc4a3b..91b2a5b8653 100644
> > > >> --- a/lib/efi_loader/efi_helper.c
> > > >> +++ b/lib/efi_loader/efi_helper.c
> > > >> @@ -477,7 +477,7 @@ static efi_status_t copy_fdt(void **fdtp)
> > > >>           * needs to be expanded later.
> > > >>           */
> > > >>          fdt = *fdtp;
> > > >> -       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + 0x3000);
> > > >> +       fdt_pages = efi_size_in_pages(fdt_totalsize(fdt) + CONFIG_EFI_FDT_EXTRA_SPACE);
> > >
> > > This is not the only place where the configuration value needs to be
> > > considered:
> > >
> > > lib/efi_loader/efi_dt_fixup.c:171:
> > >                                0x3000;
> > >
> > > Could you, please, send a new revision of your patch.
> > >
> > > Best regards
> > >
> > > Heinrich
> > >
> > > >>          fdt_size = fdt_pages << EFI_PAGE_SHIFT;
> > > >>
> > > >>          ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > > >> --
> > > >> 2.43.0
> > > >>
> > > >
> > > > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >
> >
> > Let's do this instead, as it is generic:
> >
> > https://lore.kernel.org/u-boot/20241206131113.2865416-3-sjg@chromium.org/
> >
> > I believe the copy_fdt() function can just be removed, as the FDT is
> > already in reserved memory. Putting it in the ACPI_RECLAIM region is
> > wrong, too, as it is not an ACPI region.
>
> That's not true. The EFI specification explicitly requests is as such.
> ACPI_RECLAIM is a bit of an unfortunate misnomer, but it's memory the
> OS can reclaim if it wants. IIRC Linux doesn't currently

Got it. Yes it looks like Linux doesn't reclaim it.

Regards,
Simon
