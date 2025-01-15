Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D3DC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:21:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7CB90800C2;
	Wed, 15 Jan 2025 14:21:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oUP7bIWz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F45580214; Wed, 15 Jan 2025 14:21:14 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDD3580040
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:21:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aaecf50578eso1294164166b.2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947271; x=1737552071; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EIM0hKMTDsUeCqFTJwlRqGhyZych/Mp05sxKUIlt0NI=;
 b=oUP7bIWz4f+XZ1F8MFlqfxBC0/wfg2F9Yra/6nSaNO9x2jzFHvCpoZGSr5uOe+WBpN
 12wkL6Dyc/eamcPupWKh01zuQZwKqk12Sf8nrqyI0qW/Po1CnvxUihBftD+2gU+kkywY
 7+dkMFiG6yuMQvIG0emSOdjQVx//UWpNIZH0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947271; x=1737552071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EIM0hKMTDsUeCqFTJwlRqGhyZych/Mp05sxKUIlt0NI=;
 b=IOiRV52IyLNQbPpwrVHDHTzKAeTnkr6Qg26ifaoizvozLlvpJ0D1X2pE0KkAkikVOi
 Wj3XyCuiAJ1mOzWWGzFI48TnSBR2Y6npMfxSTGeLyn/SZFuN5PKbv+8/0tQNYONjckwB
 HxpyQ5jNe4nym9yUg7lJW7p8pL63tV3Vbl3k2hjG0cCnWVbRocCCoOpY/ZKnbL1r52eQ
 h1b6OCcojKo8Zdc3BqgU1yshJ9RsDJNWPxiNxNKt7xC5XGRGlnGn0bhHN+F3XQClak6G
 RnPKdjSwa6znS+Cco+dcFH/UrAoyDHcza5WZm2gJscnWg7Bk3cC/LAU6nyEs3oJ5MSg7
 UfmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUvgFmL4Fge46l9ZABJBye5xbPpvpTygn9bcsEAA6qm+wM8ZCzgUs2V+1IpZ0slSduGUlhCQw=@lists.denx.de
X-Gm-Message-State: AOJu0YyxErdvM+Q7DqSW/ydMlV/Fkr8XvmU4NSRo5PXxBZ0DM4E+ZHuB
 TSJfRtIOeJ6ufr96w5RYZyNDHaOLmAsHKMTbZewgaSlBprBmnU0CZ7nuMFi1iVyNtheAseoaS75
 yValOG6KNrIkGp3bqGbZmCzbOLN8n6zOCaQLd
X-Gm-Gg: ASbGnct3I6BlMMN5OWOe27Rf65/wXAjiZ+zF4rf2JgusF+vnZw0mawzeSrfqmrsN+4T
 PmHCRzOAtqhTCAeBej6EPOnF1NlauJfSXuXzk5j8=
X-Google-Smtp-Source: AGHT+IEB7//pec6ql2ke5HX8AQdn8pItGMLnhxG8TV+SlNnbM003MMWFJtltPUQg6wOOVqSZ60Ovjy6YH9TzKZv+Ue0=
X-Received: by 2002:a17:907:c0d:b0:aa6:6e02:e885 with SMTP id
 a640c23a62f3a-ab2ab6bfa4fmr2656352466b.47.1736947270829; Wed, 15 Jan 2025
 05:21:10 -0800 (PST)
MIME-Version: 1.0
References: <20241206173033.2403998-1-adriano.cordova@canonical.com>
 <20241206173033.2403998-2-adriano.cordova@canonical.com>
 <9cc4a4e0-1a80-4bdc-9fd7-a04260ff7cb7@gmx.de>
 <CAFLszTiH9+avmapq8CEEr-tqybP9mWZGzqp52mVHsM87FGTfhw@mail.gmail.com>
 <d5f2510a-2a72-4408-8cbf-8d32a3b738ba@gmx.de>
In-Reply-To: <d5f2510a-2a72-4408-8cbf-8d32a3b738ba@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Jan 2025 06:20:59 -0700
X-Gm-Features: AbW1kvapHJKZDEx-FYqMDd1_E0TaADyVALBL7ogMMtzBOoz-ggQ2DaIxHNNroUI
Message-ID: <CAFLszThWKr9FxssVUZnbKvn=UsM34tBgqkBuRJ9u2PZ9Wcsr_A@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com,
 rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, ilias.apalodimas@linaro.org, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Fri, 10 Jan 2025 at 08:13, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 10.01.25 14:40, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Fri, 3 Jan 2025 at 12:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 06.12.24 18:30, Adriano Cordova wrote:
> >>> The command bootefi calls efi_init_obj_list to do the efi set up
> >>> before launching an .efi payload, but efi_init_obj_list is called
> >>> only once. There are some initializations which depend on the
> >>> environment and should be done each time a payload gets launched and
> >>> not only once and can now be done in efi_start_obj_list(). A motivation
> >>> for this change is the following order of events:
> >>>
> >>> 1. Launch an EFI application (e.g. bootefi hello)
> >>> 2. Change the ip address
> >>> 3. Launch another application which uses the pxe protocol
> >>
> >> Hello Adriano,
> >>
> >> Thanks for addressing this issue.
> >>
> >> There are a number of events that can lead to updating the IP address:
> >>
> >> * EFI_PXE_BASE_CODE_PROTOCOL.Dhcp()
> >> * EFI_PXE_BASE_CODE_PROTOCOL.SetStationIp()
> >> * EFI_HTTP_PROTOCOL.Configure()
> >> * command set env ethaddr#
> >> * command dhcp
> >>
> >> All of these events require:
> >>
> >> * Updating the relevant ethaddr* variable.
> >> * Updating any other references to the IP address.
> >>
> >> When not only considering EFI applications but also EFI drivers
> >> installed via the bootefi command all of these events can occur during
> >> the runtime of EFI binaries.
> >>
> >> Function efi_init_obj_list() is used for setups that are needed only
> >> once before accessing the UEFI sub-system. It is not able to handle events.
> >>
> >> If we need to update any internal UEFI data structures, we should do
> >> this instantaneously when the event occurs and not when executing a UEFI
> >> related shell command.
> >>
> >> U-Boot already has callbacks invoked when variables are changed. These
> >> are set up with U_BOOT_ENV_CALLBACK(). There is even a command 'env
> >> callbacks' to list these callbacks.
> >>
> >> You could define a new function to handle changes of the IP address and
> >> invoke it via U_BOOT_ENV_CALLBACK(ipaddr, <function name>) or
> >> U_BOOT_ENV_CALLBACK(netmask, <function name>).
> >>
> >> With lwIP we can have multiple network interfaces. Each has a different
> >> variable ipaddr# assigned to it. We will have to extend the concept of
> >> U_BOOT_ENV_CALLBACK() to allow for wildcard matches by adjusting
> >> find_env_callback(). With CONFIG_REGEX=y regular expressions could be
> >> used for this purpose (cf. include/slre.h) but we should better avoid
> >> the code size increase.
> >>
> >
> > I have been saying for some time that EFI_LOADER should make use of
> > U-Boot's existing tables, rather than creating its own duplicate ones
> > with extra info.
>
> What structures are you referring to concerning this patch?

I gave the example of efi_cout_modes[]. I suspect quite a lot of
structures could be relationalised.

>
> >
> > This seems to have been understood as 'hang the EFI tables onto
> > existing data structures', e.g. efi_disk_create_part(). But this leads
> > to duplication.
>
> We have to present the U-Boot DM devices in a way that an EFI binary can
> consume.
>
> Unless U-Boot's DM-layer is re-implemented via EFI structures we will
> end up with two representations.

I believe we can reduce the amount of duplication, in general. I'm not
just thinking about driver model. The EFI loader was originally
designed to avoid dependence on driver model (I can provide the thread
if you like), so even there, I believe improvement is possible.

>
> >
> > Perhaps the EFI_LOADER init should be quite small, and be done each
> > time an app starts, to deal with the 'current' state of U-Boot?
>
> No, we can load both EFI apps and EFI drivers with the bootefi command.
> In the case of EFI drivers we must not remove the handles and protocols
> representing U-Boot DM devices after the binaries return.

My question is whether these can be generated based on the available
objects, with just a small amount of data kept in the dm struct, or
whether they must be in a separate data structure?

Regards,
SImon
