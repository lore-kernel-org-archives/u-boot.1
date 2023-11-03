Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25258C4332F
	for <u-boot@archiver.kernel.org>; Fri,  3 Nov 2023 20:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5787A870BF;
	Fri,  3 Nov 2023 21:01:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="qQt1nSEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8228F874E1; Fri,  3 Nov 2023 21:00:58 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 049F587169
 for <u-boot@lists.denx.de>; Fri,  3 Nov 2023 21:00:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-507bd19eac8so3129264e87.0
 for <u-boot@lists.denx.de>; Fri, 03 Nov 2023 13:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699041646; x=1699646446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lTWTn2tL2czjFmQUjl1Hu0VH5EITXbIdjNYVfpApB1Q=;
 b=qQt1nSEHkYocDSwloztuI5XHK1lhg5VpWtVmQBajF8bKiwj9svB4VnBeNedeoEiUvc
 wcQDv6abo3mFhHdCna3LuXCptTitF9hdqamY1ZlKtrw5TFyNYxGY4RtU4g3EqvYDRUg4
 F9l3Kow0mAmoHuhBqtfyKTZcUKTxPFkg6x8vzJyDMCsIKqqFa0lmu7/4KIgVxDH3jEwZ
 BpCscDUIoeCeZ8Kyo9PwshMrx9XZScuiyAXrrMs+sKzBvkl96ufv59mPX2/pV4MKt9rb
 TZ1j2IBIQXduelcHCjry3JyxR4l9TW5YpaubU7mAui2sNunOanNNC+4R4ZsL/DgSPqZe
 nSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699041646; x=1699646446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lTWTn2tL2czjFmQUjl1Hu0VH5EITXbIdjNYVfpApB1Q=;
 b=Nrvcu9onsRfjwLaO5BCX3QUFFeIDwdw9DdDU2oLz2833QUOewUvrSk/8imEJzqGeLo
 9ZJ58Qj7/TppBPNtGRjACHwoZEI0CVUHLkLrVp1T7SAewwxNGVHO8FuOKLU1hnFIT68u
 UPzCaMPEGu8DZWitKxuzMgDDwixov0Aibd4+5r7iKMnMEwHwmsBecT2ruixPIsNf0myU
 RQ51zdPtRjUZSvwVcOmFsLGUp0ZzqnyMBlI84YbjqD2t1b41k0BW4WjntFITZDwCOKSc
 2ga80J1ZAPTrwS9zM9HR4j6xpIWwljiLc8ljITGc8r0qN1GtbOLrOL+vAwnpJZTwTc7F
 pMOA==
X-Gm-Message-State: AOJu0Yw2pT2WRv4CskyU/hOp2d6tQXJeeSZakJuorkSV7/Zw3fo3vRwg
 5qJLw3K/o5ZGrm2Giqps7slAPQqY27/GqQkyn2hWVQ==
X-Google-Smtp-Source: AGHT+IGJ8YGLVFCx65J5xOyQTpbDZ1YyXOkZAjapdNClPfUDfWr21QFlZnJVJXc96+jJkGpXYXYf9DMW+z6HYv+pVPE=
X-Received: by 2002:a05:6512:3995:b0:509:43cc:18b with SMTP id
 j21-20020a056512399500b0050943cc018bmr7774554lfu.30.1699041646149; Fri, 03
 Nov 2023 13:00:46 -0700 (PDT)
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
Date: Fri, 3 Nov 2023 22:00:10 +0200
Message-ID: <CAC_iWjJZxpQ4mha2nDN8C+UUkErqLvatjHz3adY-1Mh40N4Ciw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] efi_loader: expose the device-tree file name
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Mark Kettenis <mark.kettenis@xs4all.nl>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, dianders@google.com, Simon Glass <sjg@google.com>
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

Hi all,

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

Heinirch perhaps we can use LoadFile2 just like we use it for the
initrd? But expose a different GUID for the DT?

Thanks
/Ilias
>
> We already have the ability to put a DT in the system table. We
> already have a way to package DT into a FIT and allow U-Boot to select
> the correct one.
>
> With something like this it will be impossible for U-Boot to boot a
> distro without using grub, etc. since it won't know what DT to use.
> This information would be held in a script somewhere which no one can
> figure out without executing it.
>
> I think we need to carefully think about the design of this.
>
> Regards,
> Simon
