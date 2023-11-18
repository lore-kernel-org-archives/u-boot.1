Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4CEC2BB3F
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 17:15:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D9FA6874F9;
	Sat, 18 Nov 2023 18:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T1dKybyo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6542586DEE; Sat, 18 Nov 2023 18:12:01 +0100 (CET)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D98987252
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 18:11:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-5a7b3d33663so34148327b3.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 09:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700327505; x=1700932305; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fyD/1pa1XnuJW5HHCkPLB56yHLUPD6KgRPMUvff40/k=;
 b=T1dKybyoeUpDBkjDi7P86fAhYTAINVBF7fgAXWxuiYD4Ar6DxEgTSV9QecK9MpS3xa
 Jih2zXLBNFUrydaGg7bBG9V/VxvgNwKBNjDZhbaNryRjRLh58ZORWHb3orRx76VAS5lb
 59lBqM9I1TLMKjEd6pKXj95V2PbA2U4h/GPs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700327505; x=1700932305;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fyD/1pa1XnuJW5HHCkPLB56yHLUPD6KgRPMUvff40/k=;
 b=LDo8cco5fFuphiaFYNEcn5xA0d3r2a9OtTY5cnfC7YkghMw4XnpBn30Ekbt+I1GeVD
 YMykXOfCdR7Q+vEGJX4KYgvDqbjzi+QgRNj8ihM62TfmcvVb5P70/Jr+Z483AL7c7leg
 X5bu30j45s0oyx61DgBUs4hfZ4bEROt86+15PbAwl5lz6sKzSY5qFJo+EVlbSEkJEmiY
 jAEdWXzUPdikOlQo2pa1fruhcrV/2Q+QCrmXY0hh4xUxL9DYejLzb4OAuEaWjWqg2wFG
 7I2+DgxdEKNeTCVsjSFZx4ulhyvrjtPiLPY5TetPMH6H9fYmXpI7yAqkL9X4aJsS9gKX
 nEGQ==
X-Gm-Message-State: AOJu0Yz+bcux0rAKnVPch0A1Lit7PIjQsQErJXKZgljzR26T2B1AcVa7
 9NUmdDyYIKU5J8ZTojxSr0AdbSNsG3M7cFrVgjnLPA==
X-Google-Smtp-Source: AGHT+IHpx2QnGV9jI9OgHlwPy60SuPQt0hNGqhqevpyX7tin1YNYsELqYk7AqgEfzxKOsnU4ok/eXYj55A9ZmSD8mOk=
X-Received: by 2002:a5b:70d:0:b0:da0:4afd:61f9 with SMTP id
 g13-20020a5b070d000000b00da04afd61f9mr2414891ybq.54.1700327504871; Sat, 18
 Nov 2023 09:11:44 -0800 (PST)
MIME-Version: 1.0
References: <20231112035001.103897-1-sjg@chromium.org>
 <20231111204954.v2.3.Iae1cd9e0e207784e680480ee52021ec5caed877e@changeid>
 <20231114163846.GX6601@bill-the-cat> <20231114180430.GZ6601@bill-the-cat>
In-Reply-To: <20231114180430.GZ6601@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 18 Nov 2023 10:10:11 -0700
Message-ID: <CAPnjgZ3r7m4chK_eC0gkr8m2-9jjx1VbAiuhXDnWy9rU3eCo4g@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] bootm: Allow omitting the load address
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>, 
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, 
 Sean Anderson <sean.anderson@seco.com>
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

Hi Tom,

On Tue, 14 Nov 2023 at 11:04, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 14, 2023 at 11:38:46AM -0500, Tom Rini wrote:
> > On Sat, Nov 11, 2023 at 08:49:55PM -0700, Simon Glass wrote:
> >
> > > The kernel_noload image type indicates that no loading is to be done by
> > > U-Boot. This works well when the image is uncompressed.
> > >
> > > When the image is compressed, loading is of course required. The load
> > > address in the FIT is used for loading.
> > >
> > > However a FIT built from Linux v6.6 supports about 990 boards. Each has
> > > a different memory arrangement, so no one load address is suitable.
> > > Therefore the 'load' address in the kernel node is not useful.
> > >
> > > It would be better in this case to be able to omit the load address and
> > > have U-Boot choose something suitable. The kernel_addr_r environment
> > > variable seems to be a more reliable final address for the kernel. Use
> > > that as a backup when the load address is missing.
> > >
> > > Similarly, use the load address as the entry address when the latter is
> > > omitted.
> > >
> > > Update the FIT documentation accordingly.
> > >
> > > Note that mkimage still requires each image in a FIT to have a load
> > > address, at least for now.
> > >
> > > Another option would be to create a new Kconfig for this, or to use a
> > > region of memory known to be free, e.g. calculated from the DRAM banks.
> > > But in any case we should try to avoid conflicting with the
> > > kernel_addr_r variable. So the approach in this patch seems reasonable
> > > to me.
> > >
> > > It might perhaps be useful to introduce an 'entry-offset' property
> > > which allows the entry to be set as an offset from the load address,
> > > whether that is explicit or calculated.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > OK, so I dug out what I was trying to determine before, and while I
> > might see if I can bisect down to when this regressed, it might be a
> > little hard given that my previously functional image is from 2013.
> >
> > What should happen in the case of kernel_noload, and why the later patch
> > to fail on kernel_noload + compression, is that we don't move the kernel
> > contents of the FIT. We don't need the load address to be set because
> > we're using it where it is. What happened before in the case of the
> > ramdisk, and more importantly device tree, is what I why I want to
> > bisect down to when my image stopped working. But:
>
> Well, it seems I was wrong. I was able to (with only minor difficulty)
> go back to v2013.04, which was just after I made the fitImage I was
> trying to test and it doesn't bootm as-is. So whereas I had thought we
> had a defined and working case for kernel_noload and FIT images as you
> describe them, that does not seem to be the case. So please disregard
> this and I will review the patch again in light of what I've confirmed
> now, sorry for the incorrect feedback here and in the other thread.

OK good. I was surprised too.

Regards,
Simon
