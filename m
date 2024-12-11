Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3800E77180
	for <u-boot@archiver.kernel.org>; Wed, 11 Dec 2024 15:54:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C76D8032B;
	Wed, 11 Dec 2024 16:54:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UqY0j1JV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA3D18034E; Wed, 11 Dec 2024 16:54:23 +0100 (CET)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88FCD80327
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 16:54:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7fc93152edcso757335a12.0
 for <u-boot@lists.denx.de>; Wed, 11 Dec 2024 07:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733932460; x=1734537260; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ll1aMv8P07yiC9qBFWlSac67VNZchtO9SBnbVcI9oXw=;
 b=UqY0j1JVH2To5Ckzks889LY/G16lgKtedu0IvuxK7V5P0ri+G/OjbjGyO3CWDB4hFD
 TY5U3aMeJWbUiAZKYZ2PIGdXwXK5pAaNUM+53fQn9QUtO5LwrL5Lqff4c0FY4PdcAJ++
 gjYR2rdI3ihtpAwBtBLfue9zEZOvdkYn31jJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733932460; x=1734537260;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ll1aMv8P07yiC9qBFWlSac67VNZchtO9SBnbVcI9oXw=;
 b=eo3Hy/O+qq1SQijup+5xpuvRqQyZrxwBKBJqpE8IzKm5bJVJTKRMddJ2YmtJn9LkuW
 8F9x/2zKLdz/nMRlW/u9IDN4ap8oUL11/fYZDfZvTXeXF3NHABp2DNC2pwq/FvvRn6F+
 NXBOD/qQsh6kiAyUKiGoMNmV0KqCT6sx+VBiEvrUXwh/LemmQj7cMKgIeU223u0D8Z4W
 60RQKPM3hJJTsWvd4X5KjQUqZsAhpBftQce30hYtdQD33EM6Trp8rDaoK8/9hyoTg6Ce
 505maDv6xfFhxYThEu6tcspr84ubgWk771+5f7m5m0ZAaE+zwaWsER9zX272y0cXotl5
 wnPg==
X-Gm-Message-State: AOJu0YyKvADj2aK5RG82XXLiL7jCgJyXtwHwW3H4QX/oAnM9VmpjgoF5
 7LK9tl79TshSi8E9U9c/GfA9vAr9LkRgwVVUnXky5bbqcggS1AW8WwdjdC/CyJcdPaVFyCQq3Pl
 j5MKYP/PpqPtjU1BNwEgwpx344Ot36Jyu/GQx
X-Gm-Gg: ASbGnct9kTpG+tvL9Ius0VRw/1Gg/FU7Y2ICzRemjTfQ8q2Hwyu/0KuP8UdtCiQCnui
 hfiw+MjAS9NOgp0zfv0gr6xDCSJ8nlgVNyNi4
X-Google-Smtp-Source: AGHT+IFLVEeLPxrO6bu3JoE8WTymmiQqF+PHQAP3cPiA0NbXoYaQ4Tp5HVYAkbohRPI3/L8s1pH3d3BSE0SB1fDyUVE=
X-Received: by 2002:a05:6a21:3990:b0:1e1:a75a:c43e with SMTP id
 adf61e73a8af0-1e1c27284cdmr4751904637.22.1733932460035; Wed, 11 Dec 2024
 07:54:20 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-13-sjg@chromium.org>
 <CAC_iWjKt36c6KK7Sv0H8U5zP_i8Wys8v9UDdLxQ-Menh5Bm4pg@mail.gmail.com>
In-Reply-To: <CAC_iWjKt36c6KK7Sv0H8U5zP_i8Wys8v9UDdLxQ-Menh5Bm4pg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Dec 2024 08:53:54 -0700
Message-ID: <CAFLszTjou8eJYbFGm2gMYGY_y+kh5qcU20SOFMEUsKCrC_gqbQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/23] efi_loader: Avoid assigning desc in
 efi_mem_carve_out()
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
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

On Wed, 11 Dec 2024 at 08:15, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Rather than assigning desc and then changing two fields, assign all four
> > fields, for clarity.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > (no changes since v1)
> >
> >  lib/efi_loader/efi_memory.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > index 4c0fd0c5dca..f3aaa0e9288 100644
> > --- a/lib/efi_loader/efi_memory.c
> > +++ b/lib/efi_loader/efi_memory.c
> > @@ -268,9 +268,10 @@ static s64 efi_mem_carve_out(struct efi_mem_list *map,
> >         newmap = calloc(1, sizeof(*newmap));
> >         if (!newmap)
> >                 return EFI_CARVE_OUT_OF_RESOURCES;
> > -       newmap->desc = map->desc;
> > +       newmap->desc.type = map->desc.type;
> >         newmap->desc.physical_start = carve_start;
>
> virtual start needs to be assigned if you want to do that as well. But
> what we have is fine really

At this point in the series, there is no virtual_start - see:
efi_loader: Drop virtual_start from priv_mem_desc

>
> Thanks
> /Ilias
> >         newmap->desc.num_pages = (map_end - carve_start) >> EFI_PAGE_SHIFT;
> > +       newmap->desc.attribute = map->desc.attribute;
> >         /* Insert before current entry (descending address order) */
> >         list_add_tail(&newmap->link, &map->link);
> >
> > --
> > 2.34.1
> >

Regards,
SImon
