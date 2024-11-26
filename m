Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4946AD3B9A7
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 15:38:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFF4F89C8C;
	Tue, 26 Nov 2024 16:38:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VAqMDGHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03E5489C8C; Tue, 26 Nov 2024 16:38:06 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9571588D13
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 16:38:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa54adcb894so319652166b.0
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 07:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732635478; x=1733240278; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sOglckqpzSGB7kgyGp8eifrMe7Q8QHYO+OCIsWCYw9g=;
 b=VAqMDGHJlusGQ1L3OJhNZolnuDkgxSgFmWwwktZEe1R3boIy12N6k5DsbpZSq8+nc6
 rKGuPKI83jmWmjC3V2/nnJgY96VUD627f/DfGwlLLrRUdgkjl47p34LV+9xonmKxr+Md
 MG5gvjJsoIRFjP+It0uF4jrXaRpaNfc1TCqTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732635478; x=1733240278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sOglckqpzSGB7kgyGp8eifrMe7Q8QHYO+OCIsWCYw9g=;
 b=qwrukZmm2mgwAtrycNZT2tdRaG9TjJukOpLPzgUPzm/mJGmzj6B/c4P7UbngEQkpw4
 p6UuHbHMu+e7B1Qm2a4+Dtkt6zVg/VcgVy5SGWl0GgUprDmkjY0aNpdOw7EHVsLj4NQx
 OUuZuQaKun3XGmYQU4qYTVXZqGIfTD5FdFK514HyvDim+npwYa/0jQsNRbroLTKEngPz
 VNNMnnbsGO2EHD2nFCBCYww8ScwzRX+iuHxie5Vf6PDI9kE5fDJYAwMy+nGJQfWmefDZ
 LmqpM7qKEd/Oafs7Nfy7HXGg2omUtYJUcKz0Wo134gPW+Ln5PCTqUM/cFK/06XRpWMIv
 wCrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTRloDOdtcatqYR/ZMpRBugvcEpprxdbTxTJ3z1cnd11a0ewl2OVhP4dbp/1BshwPKq6CxRcU=@lists.denx.de
X-Gm-Message-State: AOJu0YxVps2d/Pxi8jy0gWqP6TMYC2o+EO3FNinDyCHWZdF72HXin4Or
 0U/3d5akImeHvOTkf+eM6rY/0U8D5vEEZQNVC3c12EtSQWKvlDspNduMQynms9L5l5ZoZx1hIHf
 dDRvXaNDZ3lhFqSaQqnAJK6NNfPb7rI7bbeiu
X-Gm-Gg: ASbGncupB/dxhygwMggK33oy2Kvtw/KG4nhXbDj4eJGw84JVQlo1AbwblUnRcR2cQg2
 i2qY0mePAOC8A0QmF3U4qdx5gH9n4c6Y=
X-Google-Smtp-Source: AGHT+IGQfrqdHueC1xgwqz0s0W7V4CGP/ESKDngAgzcglRm3ORvhIEMyrMI6ngl9oe/FtDSlvEhdwOXe/CMQ1LmfetA=
X-Received: by 2002:a17:906:cc11:b0:a9a:a5c:e23b with SMTP id
 a640c23a62f3a-aa509e7bb6amr1551488066b.58.1732635477958; Tue, 26 Nov 2024
 07:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-7-sjg@chromium.org>
 <5976a08e-a242-4665-85e6-410f48776229@gmx.de>
In-Reply-To: <5976a08e-a242-4665-85e6-410f48776229@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 08:37:45 -0700
Message-ID: <CAFLszThWDNCNhZ6wAaG3omKpT-ZEDkK-R1W-9DWyMuth8Vd55Q@mail.gmail.com>
Subject: Re: [PATCH 06/13] efi_loader: Use the enum for memory type
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Janne Grunau <j@jannau.net>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Moritz Fischer <moritzf@google.com>, 
 Patrick Wildt <pwildt@google.com>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On Tue, 26 Nov 2024 at 02:44, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 25.11.24 21:44, Simon Glass wrote:
> > Rather than an integer, it is better to use the enum provided, when
> > referring to an EFI memory-type. Update existing uses.
>
> The C standard provides no definition of the size of the integer used to
> implement enums. It could use u8, u16, u32, or u64.
>
> As EFI applications may be compiled using a different compiler we need
> to control the width used for passing parameters in the API interface.
>
> We should have used u32 instead of int here. We could use a typedef for
> more verbosity though that is frowned upon in U-Boot.

Yes, the ext function is debatable. The rest seem OK to me, though, as
they are internal functions, See also [1].

>
> Best regards
>
> Heinrich
>
> >
> > Call the value 'mem_type' consistently. Fix up one instance of
> > upper-case hex.
> >
> > Fix up the calls in struct efi_boot_services so that they use the same
> > enum, adding the missing parameter names and enum efi_allocate_type.
> >
> > While we are here, rename the 'memory' parameter to 'memoryp' so that it
> > is clear it is a return value.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   include/efi_api.h                |  6 ++++--
> >   include/efi_loader.h             | 28 ++++++++++++++-------------
> >   lib/efi_loader/efi_boottime.c    | 13 +++++++------
> >   lib/efi_loader/efi_device_path.c |  4 ++--
> >   lib/efi_loader/efi_memory.c      | 33 ++++++++++++++++----------------
> >   5 files changed, 45 insertions(+), 39 deletions(-)
> >

Regards,
SImon

[1] https://stackoverflow.com/questions/4879286/specifying-size-of-enum-type-in-c/4879350#4879350
