Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B8FD735F3
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 06:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB52F89435;
	Sat, 30 Nov 2024 07:14:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WpoPPhGK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 136DE894A5; Sat, 30 Nov 2024 07:14:05 +0100 (CET)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3DE4589270
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 07:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-6eeca49d8baso20164157b3.0
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 22:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732947240; x=1733552040; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TZvH2tpUI/7nlkMQTQgLKkfPGdHNy6OspG9aCogtJzM=;
 b=WpoPPhGKp9eNH38mT7KNMbIRBHwNGO6RJnvY3dJ1kXoNrh+4bVZcU3J6hP01N0aU0W
 s5SCNDS7SEfBwqfNlxQhSYdaf6f+uJi6iNvQRU1/0UnhnBHYhvstm+7P5XD7y5S8rbLI
 hCobLiOqKit9eHiBdiY9wtIEL5mRWZYy0C0QDtWTK0Mi8nXNGyH7Vnm/v1PrGuGr0UUL
 /A2Sv3wH+jTWpJahNzUeJw5rdLTnT/Tyv9Xg792o3qnBCoAR5h4SK62WnOd5lCQamUUI
 kBGiGNpOo//2xNJaVaMHl7z4gBgcEczmCiQWFD8+8Ddm87e0FjswNTVSaX196GFYWz6u
 T8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732947240; x=1733552040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZvH2tpUI/7nlkMQTQgLKkfPGdHNy6OspG9aCogtJzM=;
 b=qxSy2CgSD+zUxfcQJOm+tgwzovwxLZmI6Fdrt+6w8CnISusyP/kc46jeALCv2aIsxF
 hQ+XXDyMrAngF1jsxlHPVXCN6uCWejb/tyX3+B/gkD+2wswiJi8JLwGL1+ohKl1oPHBF
 sjauV1wf0lB4Ze5KWn6EfywPFtM6qyGYifL6/ZLr/z8yhbFuuV5mXTXdFv5f8D/9LKdr
 o7ttkoyYUFB0Yf1Gt88DlpjH1D1l3xlDSmVUj9Uyv8v+IhLevc5iWg89e5sbwQDzEJ8t
 h5qDzQnAn3PuhLbaMUWT2ku4zLu55NdfQtUNcMj/DC+e/CyCZ8ow6n0AhtemyrVKARBU
 dnGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXSNhKuSGbNkab0tPBJ4oTqpQPdouSE+0Sfuy/Py02dW8MwwPrjgoaUoWDou7iXHQovPMOdnTo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz02Ol3fimpC3aMKyRdUQU/cbhn97FNkFN0pbtyVjZUeWghML84
 8HX1vMoyGMLX3ScaMKBEX1jfGTMfmVlMbOAcZ3ORypOAHwx38XaW541P/1CIaaUGfpxBrVQzV/Z
 thOf0ldM29MY1/R652tfRaKpUhwXMa+u7ZQeEIg==
X-Gm-Gg: ASbGncsXHcGt3pwfrhsaI9ikHCSM6ph/IXyjJ/vr2sBwghKrMWETimfr4ePiRUm/Zup
 1CtnDnxwexi2nZ0bZIOuS7QXXeKorvQ==
X-Google-Smtp-Source: AGHT+IE2OHG41XurFiL8SFqh4gUZIQc/pq4CQRRDs/qlvCZX0gEubYwOObU6LC9fn7urz0tbk7ocvhfY40Pbhqlp6dU=
X-Received: by 2002:a05:690c:4883:b0:6e2:fcb5:52fa with SMTP id
 00721157ae682-6ef4a0fe282mr97742507b3.9.1732947239807; Fri, 29 Nov 2024
 22:13:59 -0800 (PST)
MIME-Version: 1.0
References: <20241129170814.768438-1-ilias.apalodimas@linaro.org>
 <CADg8p97prO=W-Qx2vqwZCnHFXhLvw2dy69UEB9f2rMH3CNZpPw@mail.gmail.com>
 <CAFLszTixsaUG1LeyWycdER5tU_=9tUpLMt0XZ78P4p8kH03iRw@mail.gmail.com>
 <CAFLszThi51_bB8821kTdk7txP6z+0RpaQ47BFb=UTBkK4Ohpxw@mail.gmail.com>
 <20241130034217.GO3600562@bill-the-cat>
In-Reply-To: <20241130034217.GO3600562@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 30 Nov 2024 08:13:24 +0200
Message-ID: <CAC_iWjJPQ9xUY40xsNHZ-7htwm=2uh3YtvWJK=YEjgeA5nyLJw@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Add U-Boot memory to the EFI memory map
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 xypron.glpk@gmx.de, u-boot@lists.denx.de
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

Hi Tom

On Sat, 30 Nov 2024 at 05:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 29, 2024 at 04:27:40PM -0700, Simon Glass wrote:
> > (Sorry, that was supposed to be sent to Ilias)
> >
> > - Simon
> >
> > On Fri, 29 Nov 2024 at 15:26, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Sughosh,
> > >
> > > On Fri, 29 Nov 2024 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > >
> > > > On Fri, 29 Nov 2024 at 22:38, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > This reverts commit ("commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
> > > > > This code was removed when the EFI subsystem started using LMB calls for
> > > > > the reservations. In hindsight it unearthed two problems.
> > > > >
> > > > > The e820 code is adding u-boot memory as EfiReservedMemory while it
> > > > > should look at what LMB added and decide instead of blindly overwriting
> > > > > it. The reason this worked is that we marked that code properly late,
> > > > > when the EFI came up. But now with the LMB changes, the EFI map gets
> > > > > added first and the e820 code overwrites it.
> > > > >
> > > > > The second problem is that we never mark SetVirtualAddressMap as runtime
> > > > > code, which we should according to the spec. Until we fix this the
> > > > > current hack can't go away, at least for architectures that *need* to
> > > > > call SVAM.
> > > > >
> > > > > More specifically x86 currently requires SVAM and sets the NX bit for
> > > > > pages not marked as *_CODE. So unless we do that late, it will crash
> > > > > trying to execute from non-executable memory. It's also worth noting
> > > > > that x86 calls SVAM late in the boot, so this will work until someone
> > > > > decides to overwrite/use BootServicesData from the OS.
> > > > >
> > > > > Notably arm64 disables it explicitly if the VA space is > 48bits, so
> > > > > doesn't suffer from any of these problems.
> > > > >
> > > > > This doesn't really deserve a fixes tag, since it brings back a hack to
> > > > > remedy a situation that was wrong long before that commit, but in case
> > > > > anyone hits the same bug ...
> > > > > Simon sent the original revert in the link, but we need a proper
> > > > > justification for it.
> > > > >
> > > > > Link: https://lore.kernel.org/u-boot/20241112131830.576864-1-sjg@chromium.org/
> > > > > Fixes: commit a68c9ac5d8af ("efi_memory: do not add U-Boot memory to the memory map")
> > > > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > > > ---
> > > >
> > > > Acked-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > >
> > > > Like you mention in the commit message, I don't think it warrants a Fixes tag.
> > > >
> > > > -sughosh
> > > >
> > > > > Apologies for sending v2 so fast but we need this in for the release
> > > > > Changes since v1:
> > > > > - reword the commit message and fix spelling
> > > > >
> > > > >  lib/efi_loader/efi_memory.c | 11 ++++++++++-
> > > > >  1 file changed, 10 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/lib/efi_loader/efi_memory.c b/lib/efi_loader/efi_memory.c
> > > > > index e493934c7131..edd7da7d8c6e 100644
> > > > > --- a/lib/efi_loader/efi_memory.c
> > > > > +++ b/lib/efi_loader/efi_memory.c
> > > > > @@ -814,7 +814,16 @@ static void add_u_boot_and_runtime(void)
> > > > >  {
> > > > >         unsigned long runtime_start, runtime_end, runtime_pages;
> > > > >         unsigned long runtime_mask = EFI_PAGE_MASK;
> > > > > -
> > > > > +       unsigned long uboot_start, uboot_pages;
> > > > > +       unsigned long uboot_stack_size = CONFIG_STACK_SIZE;
> > > > > +
> > > > > +       /* Add U-Boot */
> > > > > +       uboot_start = ((uintptr_t)map_sysmem(gd->start_addr_sp, 0) -
> > > > > +                      uboot_stack_size) & ~EFI_PAGE_MASK;
> > > > > +       uboot_pages = ((uintptr_t)map_sysmem(gd->ram_top - 1, 0) -
> > > > > +                      uboot_start + EFI_PAGE_MASK) >> EFI_PAGE_SHIFT;
> > > > > +       efi_add_memory_map_pg(uboot_start, uboot_pages, EFI_BOOT_SERVICES_CODE,
> > > > > +                             false);
> > > > >  #if defined(__aarch64__)
> > > > >         /*
> > > > >          * Runtime Services must be 64KiB aligned according to the
> > > > > --
> > > > > 2.45.2
> > > > >
> > >
> > > Thank you for digging into this. It is helpful to add more things to
> > > the commit message, but please redo your patch with a 'git revert' so
> > > we get the correct subject and body, as my patch did.
>
> I don't have a preference about the subject, but the body above is
> correct. It says "This reverts commit ..." and then explains _why_ we
> need to revert it.

Yes, we agree and although we are in bikeshedding territory now, I
don't mind sending a new one with a changed subject. Just let me know.
In any case feel free to merge this as
Revert "efi_memory: do not add U-Boot memory to the memory map"

Cheers
/Ilias
> --
> Tom
