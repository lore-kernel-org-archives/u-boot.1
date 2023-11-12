Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 228BFC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:07:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F14A5874A8;
	Sun, 12 Nov 2023 21:03:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HW5lbuX6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9556487475; Sun, 12 Nov 2023 21:03:41 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7198F870FF
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5a7dd65052aso44519937b3.0
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819413; x=1700424213; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=A1vfi6slGslmQQQWohdozx89CbjYL9hx+molbkW8cfY=;
 b=HW5lbuX6K9T5u6btxYWL0cUcjEEQS9VkNXXRi0e6ypXwkvTislngenoyoLCVgUWncr
 LPeaGV418W2Ir9D/VzWEVxGyTYAO/UFtRPq5lJKkfXUt3W+R2BBbNeQWWu9S0M8D8PM6
 HEmgNCjgYhmhhK8a+xl9KEQ6C/wGTYV6d7CGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819413; x=1700424213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=A1vfi6slGslmQQQWohdozx89CbjYL9hx+molbkW8cfY=;
 b=AmcxKar5VDZ4FTqay8kAFgOdpFnhrvEC4Pz5wlMAIRSrsmU9kKBDHf5rY3l/lmig+h
 7eGycR/+vp1o77Ssg8VFA7HqxkHSByxggues07SR/lWs5tP7s6gRN/Esc2Zjd8JHZkKg
 Whtjb3D1SzmtI5iHNkMMNf4/IS2ZGrqN5bdprPVG4Pul2GDPwrgpS82GdSNusJsuwTo2
 qQUfZ+YTPI5urBj1KMVk3WUAiNIx15hQMe4hAPy5f/OL1qDmgyqLBaFeNk0qZo5Pc2LW
 jQBU+EOZxlTs5SIJMRuxt+iwq4+0R7HMMr0a9O767iVM5EUe7jaKrpsJjCBNRQ58soeR
 ds/w==
X-Gm-Message-State: AOJu0Yy4/CTrGDHrv7dKsZp9PsNwybpia+W2YFerEInoJMWjPbkhlXmI
 dhwbhsZe+LGzBWEmi8OnLSqJmlOxGgG80zaWL8nR+g==
X-Google-Smtp-Source: AGHT+IH1uOHe6rz1nYvQ9xSv7prig9Jx0nBAzjVSZBgNSmtSKUeFAQFpRKO2DXQMxfhr03W9denaJF1x/LDluKd1gfE=
X-Received: by 2002:a81:72c5:0:b0:5a7:b8de:390d with SMTP id
 n188-20020a8172c5000000b005a7b8de390dmr4889756ywc.13.1699819413056; Sun, 12
 Nov 2023 12:03:33 -0800 (PST)
MIME-Version: 1.0
References: <20231112155808.135585-1-sjg@chromium.org>
 <20231112155808.135585-4-sjg@chromium.org>
 <44e30885-88c8-4a22-814e-77fcc9ee339d@gmx.de>
In-Reply-To: <44e30885-88c8-4a22-814e-77fcc9ee339d@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 12 Nov 2023 13:01:30 -0700
Message-ID: <CAPnjgZ3927B7sAqX4Vb6Z7jkiT3kd1149zEECH2ygHORBJqWnA@mail.gmail.com>
Subject: Re: [PATCH 3/4] efi: Correct display of table GUIDs
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

On Sun, 12 Nov 2023 at 09:58, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/12/23 16:58, Simon Glass wrote:
> > The printf() %pU option decodes GUIDs so it is not necessary to do this
> > first. Drop the incorrect code.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   cmd/efi_common.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/cmd/efi_common.c b/cmd/efi_common.c
> > index f4056096cd3f..1aa2351fcdfd 100644
> > --- a/cmd/efi_common.c
> > +++ b/cmd/efi_common.c
> > @@ -17,10 +17,8 @@ void efi_show_tables(struct efi_system_table *systab)
> >
> >       for (i = 0; i < systab->nr_tables; i++) {
> >               struct efi_configuration_table *tab = &systab->tables[i];
> > -             char guid_str[37];
> >
> > -             uuid_bin_to_str(tab->guid.b, guid_str, 1);
> > -             printf("%p  %pUl  %s\n", tab->table, guid_str,
> > +             printf("%p  %pUl  %s\n", tab->table, tab->guid.b,
> >                      uuid_guid_get_str(tab->guid.b) ?: "(unknown)");
>
> Please, observe, that we have printf("%pUs", &guid) for printing the
> text representation of a GUID. If the text representation is unknown, it
> will print the numeric representation.

Yes, I understand but this is the output I want:

=> efi tables
bfbd7690  ee4e5898-3914-4259-9d6e-dc7bd79403cf  EFI_LZMA_COMPRESSED
bff27c40  05ad34ba-6f02-4214-952e-4da0398e2bb9  EFI_DXE_SERVICES
bfbd4010  7739f24c-93d7-11d4-9a3a-0090273fc14d  EFI_HOB_LIST
bff283c0  4c19049f-4137-4dd3-9c10-8b97a83ffdfa  EFI_MEMORY_TYPE
bff2892c  49152e77-1ada-4764-b7a2-7afefed95e8b  (unknown)
bfcb6210  060cc026-4c0d-4dda-8f41-595fef00a502  EFI_MEM_STATUS_CODE_REC
bfc80000  eb9d2d31-2d88-11d3-9a16-0090273fc14d  SMBIOS table
bfe67000  eb9d2d30-2d88-11d3-9a16-0090273fc14d  EFI_GUID_EFI_ACPI1
bfe67014  8868e871-e4f1-11d3-bc22-0080c73c8881  ACPI table
be9b9010  dcfa911d-26eb-469f-a220-38b7dc461220  (unknown)

(so I want to show the GUID in all cases, but also indicate which ones
are unknown)

Regards,
Simon
