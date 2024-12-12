Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56670E77182
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:44:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B93C5800D9;
	Thu, 12 Dec 2024 14:44:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UbNQ9QQ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B600801EB; Thu, 12 Dec 2024 14:44:39 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF62B8008A
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d0d32cd31aso757598a12.0
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 05:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734011076; x=1734615876; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PynO8yD0EubFazNqt+NP9wULna2FiFlOLHLiCStiVzw=;
 b=UbNQ9QQ+mVvdNpM7DcCG3mMsQTGqHotGgqMmn0izCACxH1j5otW+4wZ34MmDDtLUAz
 9AndUu+lUl06PQYKD3eAWBkvY1DbNRmFFMYpYjm2Xz9wA5GOiN6/D+ldQeEPO5rLohCl
 WEOMJiFyct/qi1t7NDM6fmftetgxcfwHo35aE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734011076; x=1734615876;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PynO8yD0EubFazNqt+NP9wULna2FiFlOLHLiCStiVzw=;
 b=vOHRHl0mxvnv/aApQLzkfoCu8jp1xL+iNtukeAINo+f81URbVftZafThJ9JZw2eAi9
 vTKkR5JcWIqUzdFXosAEy7KmkwIA8KyoKnTnN+nfDauuquOv8BNQxXo1rTY9uXDSZaZ9
 qigBBmJBfXeuK3PA5eJrpQeY2voQhvdCB3f7nVXFWTo/2bmSdxXS+Df6OW1yflga+Py4
 qMX+5SMIVis+g5Gloj0T+jskwo+p8JWoHx36NZvkQinVSppJscQi/RJxd3zFYu5yknFe
 SG7vxHZq3Wi2b85sCJy8IuNFSrHFDsiOBWYKBuzS6BT3pc+qBKl7sH92iO7DAVlEGeCF
 /zGg==
X-Gm-Message-State: AOJu0YwZd4iWEL5x9FR3sMvwl6fwjI2pV5RMGZTN8SIcQ/rKDsYSMQr/
 eL++Dfa2nxFQlB/fWnq7RQL9p2A1kQD726zJPoiN8HxIGSxfjUgi9VlIszDfhkVplqUHJPRk91q
 8Wa8/ArVPAd31xOmZauLvhi09NzokAwKQF2NWN6J3U0Os0pE=
X-Gm-Gg: ASbGncv14B6TqPWUd+uU6xg9tWgTezQX45Rz3rVTUcg6cyFSGwpnww1bb9QFoxf5cAc
 M4r62zbfbPdjuBBrqUvPqkFVKJjyvpKZFMwKipFw=
X-Google-Smtp-Source: AGHT+IGQ7ka0a0Tg3RoOZvajMZ1n5nNMNw5Tb0WYCQLvOV6cM38Z55BudHf3qtswodEhpM+M+BreRd/9C+PRMEvTj4I=
X-Received: by 2002:a05:6402:27c9:b0:5d0:d818:559d with SMTP id
 4fb4d7f45d1cf-5d63237b183mr591832a12.11.1734011076341; Thu, 12 Dec 2024
 05:44:36 -0800 (PST)
MIME-Version: 1.0
References: <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-19-sjg@chromium.org>
 <CAC_iWj+warnOCWhpp9H4-AUc70Ft-6jRM9tRcZ3yVTKJ1_88FA@mail.gmail.com>
 <CAFLszTgT0tE=fU2W__n1Kz_yoAE32wnMcVOEb99XG4EZCzP3TQ@mail.gmail.com>
 <CAC_iWj+Yjg81CRvgt3hV0wFoudhD_QS4yOBRwBbJ0zq14jb-TQ@mail.gmail.com>
In-Reply-To: <CAC_iWj+Yjg81CRvgt3hV0wFoudhD_QS4yOBRwBbJ0zq14jb-TQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Dec 2024 06:44:24 -0700
Message-ID: <CAFLszTh5465tDrsLWNnS4-xb0sOMRsWf89u2h3_kj=s6Wg3y9A@mail.gmail.com>
Subject: Re: [PATCH v5 18/23] efi_loader: Don't try to add sandbox runtime code
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

On Wed, 11 Dec 2024 at 23:16, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Wed, 11 Dec 2024 at 17:54, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Wed, 11 Dec 2024 at 08:19, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > This cannot work since the code is not present in the emulated memory.
> > > > In any case, sandbox cannot make use of the runtime code.
> > > >
> > > > For now, just drop it from sandbox. We can always adjust things to copy
> > > > it into memory, if needed.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v1)
> > > >
> > > >  lib/efi_loader/efi_memory.c | 26 ++++++++++++++++----------
> > > >  1 file changed, 16 insertions(+), 10 deletions(-)
> > > >
> > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > index 0f149f99c7d..6475b94f951 100644
> > > > --- a/lib/efi_loader/efi_memory.c
> > > > +++ b/lib/efi_loader/efi_memory.c
> > > > @@ -767,16 +767,22 @@ static void add_u_boot_and_runtime(void)
> > > >         runtime_mask = SZ_64K - 1;
> > > >  #endif
> > > >
> > > > -       /*
> > > > -        * Add Runtime Services. We mark surrounding boottime code as runtime as
> > > > -        * well to fulfill the runtime alignment constraints but avoid padding.
> > > > -        */
> > > > -       runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> > > > -       runtime_end = (uintptr_t)__efi_runtime_stop;
> > > > -       runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> > > > -       runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> > > > -       efi_add_memory_map_pg(runtime_start, runtime_pages,
> > > > -                             EFI_RUNTIME_SERVICES_CODE, false);
> > >
> > >
> > > Can sandbox boot an OS? If not there's no point adding this. But if
> > > you insist, I prefer
> >
> > No sandbox can't really boot an OS. The primary reason for this change
> > is to avoid strange things appearing in the EFI memory map (and
> > therefore the EFI log). I found it very confusing.
> >
> > > if (IS_ENABLED(CONFIG_SANDBOX)
> > >     return
> > >
> > > at the top of the function
> >
> > OK
>
> But can't we call ExitBootServices  from sandbox and test some of those?

Yes I'm pretty sure that could be made to work, although I would need
to try it. But we don't have such a test today, so we can worry about
it then.

>
> Thanks
> /Ilias
> >
> > >
> > > Thanks
> > > /Ilias
> > >
> > > > +       if (!IS_ENABLED(CONFIG_SANDBOX)) {
> > > > +               /*
> > > > +                * Add Runtime Services. We mark surrounding boottime code as
> > > > +                * runtime as well to fulfill the runtime alignment constraints
> > > > +                * but avoid padding.
> > > > +                *
> > > > +                * This is not enabled for sandbox, since we cannot map the
> > > > +                * sandbox code into emulated SDRAM
> > > > +                */
> > > > +               runtime_start = (uintptr_t)__efi_runtime_start & ~runtime_mask;
> > > > +               runtime_end = (uintptr_t)__efi_runtime_stop;
> > > > +               runtime_end = (runtime_end + runtime_mask) & ~runtime_mask;
> > > > +               runtime_pages = (runtime_end - runtime_start) >> EFI_PAGE_SHIFT;
> > > > +               efi_add_memory_map_pg(runtime_start, runtime_pages,
> > > > +                                     EFI_RUNTIME_SERVICES_CODE, false);
> > > > +       }
> > > >  }
> > > >
> > > >  int efi_memory_init(void)
> > > > --
> > > > 2.34.1
> > > >
> >

Regards,
SImon
