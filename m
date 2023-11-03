Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC90C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 19:43:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3887587232;
	Fri,  3 Nov 2023 20:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="EQ90qs9Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C59DF87274; Fri,  3 Nov 2023 20:43:18 +0100 (CET)
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com
 [IPv6:2a00:1450:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F56886F67
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 20:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2c6b30aca06so33127351fa.3
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 12:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699040591; x=1699645391; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zBa4BjfxI5HdhNf3j79+ZhdWZQkWY4P/288mCqirBZE=;
 b=EQ90qs9QDz4L2ygsexl9ndy7xzJoVwl/7+vQxkqT5Le1PwE5j1MrNV1fA+pRyFCXH/
 7bj0ZPtQkfKhEPtIDDgUgdABy1fTs7OzwJT3FqwEAMt2g6eTgPOzEasmLyCvH8gX8dKY
 M0mLZPfsaM/mfqvn1ddzkpEm4GjYUYNUpLiXQL2EzrPr7m9YmKYNlLI4i4b+7fVqmhW7
 nfGXUCwq2OSRmomUGpSfxATEXHd5UbgCULwCRBo7Hi3hTo0aoAj6OFt/iewdZOLaz9x4
 T/j2KCfLuXAGPXpFZufGlmkJC12mS7Ky1O2bJf61HNRQHhz303HELAlzklW5Xq3CyKZb
 vxKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699040591; x=1699645391;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zBa4BjfxI5HdhNf3j79+ZhdWZQkWY4P/288mCqirBZE=;
 b=JREXHLaXo4IzhoAGshkMOxv3a7fU6nNBFVo+hkMmyjG/b80T6sTnWTE10TER7GoRmT
 IhK036OmA47C330Uxu9/lRqle4Z356nSY1NMlcweaGfHwA2i9c/F61+wAzn+cdB/V5eA
 xVfxw0XQVAhIEuCG5gI16VGSOpc5Es2fSaSfE4//xVa2oCT50rMSyTl/4h6esfs6u4cm
 CpecAqZizA46C7SCN7YxhsQyi7Fkl8K9hPbymNRIA/AKDf7hKog6ptAs5vTamal1NdX3
 GlXNpA+7Jaw/5iPeHQHHsX9iIZ3vGEehSd6qBtobf9+Fybqwr9OvjUNtiblatEoCIH0k
 tLww==
X-Gm-Message-State: AOJu0Ywi4PC9AZDDeGdwgY7UXY4OIYHOA9LX3b9+Z3T38Mli3YVFOiWb
 uVfwplvywS64U+vWOravqjZFFwtF30jDbKHUS7Sl2A==
X-Google-Smtp-Source: AGHT+IH7l+/pPH1a0La+EyCickWJBMdCJ20ADhMkxTjMRFUj/Hp1mgl8gRgXVS0WN4QMSbJd2O8lwjanL12zQwutAzc=
X-Received: by 2002:a05:6512:6d1:b0:507:c7ae:32cc with SMTP id
 u17-20020a05651206d100b00507c7ae32ccmr20521282lff.41.1699040591492; Fri, 03
 Nov 2023 12:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <0c1abfbc-fd2a-4dd9-8447-53e5ee32ab85@canonical.com>
 <CAPnjgZ18Utd0V7kctaqD6aZqfmNy9Qogg8dw5WaHkAar9C+Dxw@mail.gmail.com>
 <750bac2f-3bcd-4ae1-b5ed-a82e8159846b@canonical.com>
 <CAPnjgZ3KZLTHUWnnQtBsiaeRRXgHjbqdkfw6cW+_+aXZ9zpogA@mail.gmail.com>
 <ea1ba7c2-7f9c-4702-a6da-efb728771e24@canonical.com>
 <20231020162410.GK3119521@bill-the-cat>
 <CAPnjgZ0zwQ+J-17YEhAtTtLhTcK7K9=nqNNqOdNmG5bY+rFrhg@mail.gmail.com>
 <7481371f-657d-46d6-b8e7-74da7a200ee9@canonical.com>
 <CAPnjgZ3_WSS+Z2xsRTvf-7ChPN42OVLgLf8ZvGv=2FVrNuHkhA@mail.gmail.com>
 <87h6mhqri9.fsf@bloch.sibelius.xs4all.nl>
 <20231023163455.GL496310@bill-the-cat>
 <87fs21qnex.fsf@bloch.sibelius.xs4all.nl>
 <CAPnjgZ3Yqf3-9wjVTYh5eR_=rFuf-2eWUvZmfv=U1xDCVEWSXQ@mail.gmail.com>
In-Reply-To: <CAPnjgZ3Yqf3-9wjVTYh5eR_=rFuf-2eWUvZmfv=U1xDCVEWSXQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 3 Nov 2023 21:42:35 +0200
Message-ID: <CAC_iWjLJD36GahKj9Ks_4QMtOn1gatpxwid1paPavvsxeUNBpg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
To: Simon Glass <sjg@google.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>, 
 heinrich.schuchardt@canonical.com, u-boot@lists.denx.de, dianders@google.com
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

Hi Simon

On Fri, 3 Nov 2023 at 21:17, Simon Glass <sjg@google.com> wrote:
>
> Hi,
>
> On Mon, 23 Oct 2023 at 11:06, Mark Kettenis <mark.kettenis@xs4all.nl> wrote:
> >
> > > Date: Mon, 23 Oct 2023 12:34:55 -0400
> > > From: Tom Rini <trini@konsulko.com>
> > >
> > > On Mon, Oct 23, 2023 at 05:37:34PM +0200, Mark Kettenis wrote:
> > > > > From: Simon Glass <sjg@google.com>
> > > > > Date: Mon, 23 Oct 2023 00:08:40 -0700
> > > > >
> > > > > > > fdt_node_check_compatible() does most of the work...then you need to
> > > > > > > check which FDT has the most specific match (i.e. latest in the string
> > > > > > > list). That handles things like board revisions, variants, etc.
> > > > > > >
> > > > > > > My concern is about adding a feature when there is already a defined
> > > > > > > spec and mechanism for this to work. What happens when we load the
> > > > > > > file and the compatible is wrong?
> > > > > > >
> > > > > > > At best, I see the filename as a hint.
> > > > > > >
> > > > > > > [Perhaps this is the wrong time to ask, but why are kernels +DT not
> > > > > > > shipped in FIT on ARM?]
> > > > > >
> > > > > > FIT is U-Boot specific. For Linux distributions it is easier to use a
> > > > > > firmware agnostic method of booting.
> > > > >
> > > > > I'd like to suggest that distros use both. Then U-Boot can work as it
> > > > > was designed and we can avoid these work-arounds.
> > > > >
> > > > > FIT is actually implemented in various other bootloaders. In fact
> > > > > perhaps grub is the only one that doesn't? I can't think of any
> > > > > others.
> > > >
> > > > Simon, please stop pushing this.  OpenBSD's bootloader does not
> > > > support FIT and we have no interest in supporting it.  Our users
> > > > expect to be able to just copy a new kernel in place and use it and
> > > > our OS upgrade procedure depends on this as well.  And this is
> > > > incompatble with FIT.  I've explained this about a dozen times to you
> > > > now.
> > >
> > > In the context of this thread, genuinely, how will OpenBSD (and the rest
> > > of the BSD families) operate? I agree U-Boot doesn't want to have to
> > > know all of the UFSes, so that means the SCT will be populated either by
> > > the DT passed to U-Boot, or the DT we were built with. Is it that since
> > > the next stage is an EFI app, it will check that variable and use that
> > > hint?
> >
> > Yes, that is exactly what I want to do.  Hopefully the DT that is
> > passed to U-Boot or that U-Boot was built with will be good enough in
> > most cases.  But when it isn't users can use the OpenBSD bootloader
> > (which is an EFI app) to load an updated DT.
> >
> > I can't speak for the other BSDs, but I think both FreeBSD and NetBSD
> > have a very similar boot mechanism.
>
> I've been thinking about this patch a bit more, and I have grave misgivings.
>
> I predict that if we take this, it will become an ABI from U-Boot and
> we will not be able to drop it.
>
> Here is what I suggest instead: provide a protocol for U-Boot to
> provide the DT over EFI. Provide any information needed by U-Boot,
> such as the directory containing the files.
>
> We already have the ability to put a DT in the system table. We
> already have a way to package DT into a FIT and allow U-Boot to select
> the correct one.
>
> With something like this it will be impossible for U-Boot to boot a
> distro without using grub, etc. since it won't know what DT to use.
> This information would be held in a script somewhere which no one can
> figure out without executing it.

That's not entirely correct.  If you want to boot an OS with EFI
without GRUB you will boot via the EFI bootmanager. We already have a
way of adding the initrd we need to use in EFI boot options. Adding
the DT in a similar fashion wouldn't be too hard.

Thanks
/Ilias
>
> I think we need to carefully think about the design of this.
>
> Regards,
> Simon
