Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A36FCF64A4
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 02:07:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF68883E40;
	Thu, 20 Nov 2025 03:07:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oSAOvpfe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C00D83FD9; Thu, 20 Nov 2025 03:07:20 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88C2C83E0E
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 03:07:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-640ca678745so553901a12.2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 18:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763604437; x=1764209237; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HIL9K0xC9qkgEifSt6kMyR0AnTZGcob7H8b6mDOCYMY=;
 b=oSAOvpfe0bJc+zhnp8w5nOG5qakVduajveaej4h5QxxF2CNmxENgTZSlmjy/kVoqKV
 19Px3ZKvmvgnPc4FOo4yRK8Glgj5wcZQ2dJ63EJqYJ4pyniZOm4mgql7URfZg4EKy4Yk
 IOFyS31avGsFL+2VV+FAb5x48C+Nv85fVFAMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763604437; x=1764209237;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HIL9K0xC9qkgEifSt6kMyR0AnTZGcob7H8b6mDOCYMY=;
 b=QINZrDVfNwgfq6vd+nfO0deboW/aveYSL4uyO4+Lh9LrFmp+by4YxMDFuDBGvZXhEM
 avcyUL42lnx7o8wVYRA5eRNPrziiUD3B8Rz2lq9z5sO9fU2xxJ6IK28GPJVduS/u8fY4
 WE2VX8t7WR9vSvlj8bbsoWaSG8ReJdv5Sxdkt67GCjpC9esS69AMosHU07wqZMmrLf6I
 NlMPE1qrvhI3tdM4bpgSwVr4yu3wGKw+tfambaKswsE6oO1dFWs9imDn/D99qRMxl/AV
 HYw4tbbT6F1aslXFr5GoOHW6jtlriPJVFkYjo8L5TuhienRll1hmuqdWHAJlNtvfbKr0
 /PgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIkicOs4k2I+8CKnklQYquWi27g0v+HDXIpJfqPBnu7HjulIhje1wCLQGjOeo9aC7LzyDAld4=@lists.denx.de
X-Gm-Message-State: AOJu0YzgZCCu7xz1v4gs2HTp65Puvhd7/xF+/6lU1MTfnS6uqw5G7jwk
 kqTS0iGGpgzwmZSfSt+OwpI+r7SvNbFDjCvNd9Ks9rGFN3JdamlZYqaBqdwY8ZTlqub8cMcwLOn
 rzUtwq8j0+JL7kdG6ublzOh7CcM7BjiC2wzD5TnQI0BSE/jGYFSeJug==
X-Gm-Gg: ASbGnctN4FWb/0ZM+nGe720vTjExcTsdqaUdeTGDy5hWFyffDj/ssEv7Rys4dSdtfd6
 mZ1Rbf7mj5IKsG8Wl1GbjvgOFS6BPfpr9v/1RWG98y3tVym/wcKfourUXwMnCilYRGvsLqeK96N
 P+YGT28fqi3QC/oZT+/DegqFtQkjA5igeoR1hPiXVpjk89kHuOwSdurN/mtNk5mfYwqT2tajkjm
 N6tz5EsI5/r7U+4q/haWDEEMgkUkFrRrnB+6GVnsRLsJdSWE/5OeAx3+LETS3UwdKh+emCRurd5
 0Ot/
X-Google-Smtp-Source: AGHT+IHHw+XC+lu/o4LBo5FwwwwrPEXtGyiZI4lrNz7OpqZK1lYWUf25RLcWwrex46v2aIO/Bbs+2dRLQDil2Jr6zs8=
X-Received: by 2002:a05:6402:280d:b0:641:66cc:9d91 with SMTP id
 4fb4d7f45d1cf-6453647b7d3mr1306244a12.27.1763604437046; Wed, 19 Nov 2025
 18:07:17 -0800 (PST)
MIME-Version: 1.0
References: <20251113115516.947835-1-marek.vasut+renesas@mailbox.org>
 <CAFLszTg0ByjUGgX4MSbU=i0oG7fuidM4J0J128ER6Aq+r6HW9A@mail.gmail.com>
 <81115588-50c7-4ecc-975e-13994101955f@mailbox.org>
 <CAFLszThNLoS7j0pe_8G93dHtX91j331DCBiUgWpUPXi4Oi2-9w@mail.gmail.com>
 <c5300029-9bab-4a06-b426-ccc443d0928c@mailbox.org>
 <CAFLszTiV2jTWcWU+27QxX82Ap9YnhZNTK1sXrFvF_e53ydc5_g@mail.gmail.com>
 <706283a7-2ba9-4b8c-8cb4-3db42759acc9@mailbox.org>
 <CAFLszTh5MaFqC-pP5z4j8jLs4qmUR-jhS5wYob2kkVTFDQB0Vg@mail.gmail.com>
 <b3c9a624-6574-4be9-a88c-be7acc863d3c@mailbox.org>
In-Reply-To: <b3c9a624-6574-4be9-a88c-be7acc863d3c@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 19:07:05 -0700
X-Gm-Features: AWmQ_bmjdXqJpef4cMT_AirL8tu2x_GLOr0HEPTVqPIiy1eETnL007xWaww0wYo
Message-ID: <CAFLszTgZyzudtPosTZ=fOonTQA8LYCi3rpMAz-5spwqi7efO6w@mail.gmail.com>
Subject: Re: [PATCH] boot: Assure FDT is always at 8-byte aligned address
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
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

Hi Marek,

On Wed, 19 Nov 2025 at 17:20, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 11/18/25 4:47 AM, Simon Glass wrote:
>
> Hello Simon,
>
> >>>> 2294         } else if (load_op != FIT_LOAD_IGNORED && image_type ==
> >>>> IH_TYPE_FLATDT &&
> >>>> 2295                    ((uintptr_t)buf & 7)) {
> >>>> 2296                 loadbuf = memalign(8, len);
> >>>> 2297                 load = map_to_sysmem(loadbuf);
> >>>> 2298                 memcpy(loadbuf, buf, len);
> >>>>
> >>>> ...
> >>>>
> >>>> 2309         /* verify that image data is a proper FDT blob */
> >>>> 2310         if (load_op != FIT_LOAD_IGNORED && image_type ==
> >>>> IH_TYPE_FLATDT &&
> >>>> 2311             fdt_check_header(loadbuf)) { <----------------- this
> >>>> 2312                 puts("Subimage data is not a FDT\n");
> >>>> 2313                 return -ENOEXEC;
> >>>> 2314         }
> >>>>
> >>>>> Perhaps we should deprecate FITs with internal data, too?
> >>>> We cannot break compatibility and stop supporting old fitImage, so this
> >>>> is irrelevant here.
> >>>
> >>> OK, so please create a function which can detect an FDT header without
> >>> it being aligned, like the other code you wrote. Then it will be safe
> >>> to call that here, even if unaligned.
> >> But we actually do want to detect unaligned broken FDT header and either
> >> fix it up or stop processing, we don't want to perpetuate handling of
> >> broken FDTs and pretend that is OK, it shouldn't be I think. Hence this
> >> fixup.
> >
> > The decision as to whether something is an FDT is made a lot earlier
> > than the actual processing of it. For the former there is no need to
> > allocate and copy. For the latter we need to.
>
> The test whether the FDT is valid cannot be done earlier, this place is
> literally the first place when the FDT is decompressed/loaded to the
> target location.

Yes, this is the place where you are testing whether it is valid.

Later, the FDT is actually used.

It just isn't right to allocate memory in fit_image_load() - it is for
loading an image.

>
> > Anyway, you are doing the patches, so do what you think is best. But
> > please create a function for this, rather than lots of little
> > hand-crafted checks around the place.
> I am confused, function for what exactly ?

I believe the code you should patch is in boot_get_fdt_fit(), after
fit_image_load() returns. That is where the processing happens.

That is where the function I suggested (and tried to write) could be
called, to get an FDT that can be used. It also happens to be one of
the places where boot_relocate_fdt() is called, which could mean you
don't need to allocate memory.

Regards,
Simon
