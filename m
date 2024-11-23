Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EC20E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:56:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 29A16893D2;
	Sat, 23 Nov 2024 17:56:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="L7/U8UHD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFE96893DA; Sat, 23 Nov 2024 17:56:45 +0100 (CET)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5486A893A5
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 17:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ea45dac86eso2658292a91.3
 for <u-boot@lists.denx.de>; Sat, 23 Nov 2024 08:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732381002; x=1732985802; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xx8WGKMP83xv+w9JYDTv54ji8HIzv8Bui3COGs/j0GU=;
 b=L7/U8UHDhvSTmivePLN62pF3OmRWUVvDR/bNIyLZlEduvDCMQw/yLZBthvAwQVY9X/
 b0b2Qw7G2uZGC8qVp3e9caN9vybvX5zqyqcuhuX+DnyZt0tgnZ3NdY0I/1dviRgBVEoP
 0tF+0knztKaIMT/IuLV7qdLnxPnaiKegiBK9Te/NIrzUSuGKxhfsS8eHiMU/eEbWuo8r
 QsGpy1vPb/ktgiWmQEIPO9ogD0Dsp9E7HFdP+v57l1qIkgg4X2uWr2q24HJ0sTehxGIY
 AJwWjVKMCCoeBS2VQHBDS5wsgioEReJ1BXb54ynu48S+Ha+arMgTvnB/ndZ9aEPX+QWQ
 Hl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732381002; x=1732985802;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xx8WGKMP83xv+w9JYDTv54ji8HIzv8Bui3COGs/j0GU=;
 b=P/8fBGhzuAJ7Wt+d9mxrALJFFE143zxADtvR50VO76t1FDJ170L99Vqi0fMVIMqkpX
 chubJzKGd+J5goOELzJagatdUBseMOfAo/El/oMtEM5XaZckkQXBqH+MBm+i1W0MIGwZ
 gMLRrX8tUVcbZSOrHJ7KHmCXtdoMAFcZ1gXzKqY4D6CCJqFLOKIjidOoz5h2w4/ThO/0
 p79jjjcDLiG/VTCE+xYJMpI9prTDaoHs+GyEsqCl3iF3uW9dyMtaxkgPbUdUreNwuuEh
 4zwVeqsDf+G5/S6EU6MLqnfGX4Th398pXGMtvN/FtJGA3vFzJvzdnqFdberKIo4Q4hrW
 xXkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNyKlNWy0RvsUQkbrfMVzeDmLGaNOdfD1rLM/iVbWsaxZr9STEnSkLQFzD72ONsX16O9Hojlc=@lists.denx.de
X-Gm-Message-State: AOJu0YyLi6Cg395OpOznIlHdWA+3/1EhQzHefQE9jKQgGydiCgkyajFH
 DtEU4YVAPkNQsGX3TIC5kWQFIsvmg/WSM5rE80CQD2wVhaNwOwxhbDigywKq4nZ92YjedAUlzDI
 7Pcd32paOj3RDf4clB09tvhJjdJ9Ku+6L4h6UmQ==
X-Gm-Gg: ASbGncuePB1iAu/IacKfQVNhksoOOEGNJfjI2RuzyZfur7b1o0J4VOUeYLNyYeYn/N4
 DOtz0JASrSlyvsWNFvjZXodSCzjPmIQ==
X-Google-Smtp-Source: AGHT+IGQViTXWvBK+A21oJLKX9UexGqnC1t1aGgSlHcPgAIHuXMJDlEthOOlOZcHaoWxGWqqgKpC9/AEgNr/yXjAHdU=
X-Received: by 2002:a17:90b:3b46:b0:2ea:83a0:47a5 with SMTP id
 98e67ed59e1d1-2eb0e02b647mr8465667a91.4.1732381001861; Sat, 23 Nov 2024
 08:56:41 -0800 (PST)
MIME-Version: 1.0
References: <20241113150938.1534931-1-sjg@chromium.org>
 <20241113150938.1534931-4-sjg@chromium.org>
 <20241113175017.GS3600562@bill-the-cat>
 <CAFLszTjVgz7HxO8jrvVhGORbccGCN6HHMy7fWz=FJYKrfdyQ+g@mail.gmail.com>
 <20241123020802.26cba055@minigeek.lan>
 <3F1F4DAC-39AC-4D17-8C92-A467FE90DA38@gmx.de>
 <20241123130750.10729a5a@minigeek.lan>
In-Reply-To: <20241123130750.10729a5a@minigeek.lan>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Sat, 23 Nov 2024 18:56:05 +0200
Message-ID: <CAC_iWjK_XoqFfZRM5RFwSo9GYHDmPjEapqWSbdNdFDfcO9LNQw@mail.gmail.com>
Subject: Re: [PATCH v5 3/8] efi_loader: bootstd: Drop bootmgr for sunxi
To: Andre Przywara <andre.przywara@arm.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
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

[...]

> > >So while I agree that disabling efi_bootmgr sounds like a hack, it
> > >solves the problem quite elegantly: We keep the (current) boot order,
> > >which prioritises scripts over EFI, but still retain EFI. If people
> > >want EFI first, they can change the order in the environment (I think?).
> > >
> > >Without that patch there is quite a regression for users, because
> > >suddenly any bootaa64.efi files *somewhere* would be booted first, and
> > >there is no way to turn that off.
> > >
> > >This has bitten me actually: for development I put a custom boot.scr on
> > >an SD card which loads a kernel+DTB via TFTP from my box. And I want
> > >that to be first, despite there being a proper EFI setup on the eMMC or
> > >USB drive.
> > >
> > >So I hope that clears that up. I am not a big fan of that patch, but I
> > >would like sunxi to be converted, and Simon seemed to be eager to do
> > >this as well, so in the interest of not blocking this, I am fine with
> > >that.
> >
> > Disabling EFI will break booting for users that rely on it (like me).
>
> So are you using the UEFI BootOrder variables? How do you set them?
> Manually on the U-Boot shell, or via some Linux tool manipulating the
> U-Boot environment file? IIUC those are the only two methods that work
> for sunxi, since the UEFI variable runtime services are not implemented.

I haven't followed the rest of the thread but EFI runtime does work
since commit 00da8d65a3ba.
Yes for now you have to manually dd the file on updates, but this is
supposed to be solved by [0]

>
> In reality I am using UEFI booting as well, but entirely rely on
> bootaa64.efi, hence bootmeth_efi is totally sufficient for me.
>
> > Yes, the introduction of boot standard changed the boot order and specifically deprioritizing scripts is unexpected.
> >
> > The priority sequence used to be
> >
> > scripts
> > extlinux
> > efi
> > pxe
> >
> > bootmeth_efimgr always running before scripts be fixed.
>
> I agree, but with bootmeth_efimgr marked as global this is not gonna work
> easily, at least that's my understanding.
>
> > bootmeth_efi should be removed from the code base as redundant.
>
> I wonder if a solution is to split this up: bootmeth_efimgr is only
> looking at variables - then "glob" would be correct. Then people
> can place bootmeth_efi at the position they want, either before the
> scripts (allowing USB boot) or after. I think this would also solve the
> case where bootaa64.efi is both on an eMMC and an SD card, as it would
> pick the boot media first.
>
> A lot of sunxi use cases are embedded, and people mostly don't
> want to boot from USB on for instance their TV box, just because the
> stick with the movies and some bootaa64.efi was still in the slot when
> they turned the box on. Even more so for truly embedded devices. And
> that's also the default setting for PCs, I think, where USB booting
> would need to be explicitly enabled in the BIOS.
>
> Cheers,
> Andre

[0] https://github.com/rhboot/efivar/pull/267

Cheers
/Ilias
