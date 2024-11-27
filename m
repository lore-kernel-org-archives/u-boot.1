Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DB7D6ACE4
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 14:56:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 493B48961A;
	Wed, 27 Nov 2024 15:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XnwEHDYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2540D89672; Wed, 27 Nov 2024 15:56:26 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0C3E895D2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 15:56:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2ffc3f2b3a9so53372231fa.1
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 06:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732719383; x=1733324183; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Y1NvAE/iQI+xCcJSoo5FWOBj/7lDc3wbFp+sQAoprZM=;
 b=XnwEHDYgDM9EtVHaCVZG0+FigdMDOhqncd3tE4qJOtoV89oqjbxjXmL/TC92cpqZP3
 11+nMpEPLyM3y08o2HSOD/aqnCcJkLoqXcE/7zKtXj0exZddrTnjTjwxnAT5V3scbvzz
 twAmHV3Rt2clFRQC/YnkoYD2/3iTQV6ZxdZl8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732719383; x=1733324183;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y1NvAE/iQI+xCcJSoo5FWOBj/7lDc3wbFp+sQAoprZM=;
 b=SsN6+ybbwjFA5TeUGpuHRAJIQzNL/wKqaFrAiGv/2hXWLzm+rUNzc7AznUT9KwGZ1K
 bSKZQnp3NzeZ3lzVc09X2P86x+Muqxh0FZaeIOfUk2/ihASovOBRRHsS6eaB5dV6s+yL
 M1MR789/a4f8IxIE6e9zmfJXrowss9m72MFYpzb9zEGAZUES1BUmEGtIw3UnI152W31q
 aq/SuSauRP7neHe4+5GJBuk7KeOCp9AHm7y/XycOPrGhGC4fPYU5fVSyM/+7jxnlcXqc
 mNcJXxkiLI1PNvPlBuH9kyva/cBMRLOaL0Pt+KWZkXLKbcLpzWohcbG8XqFQ9lGM/1/1
 LiAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr35TTqU7REpORazhqbZ8g8BCGaTeq48XzgmJEcRjfEy4hH03mIQxGf3ZBJ6B9pcoxr+EEWBU=@lists.denx.de
X-Gm-Message-State: AOJu0YzH5JedaKrmGqkdBBnUcuMKqPVqoC43rTzEp8gJ2wj/y7AdTky4
 GBPs1U3wngz0MxwrfN2Y3XXRDS0gezVS2U7lsKhi1yGhnRSTHJUl0b2XKB6t6edRyTVogKmC3VM
 wIazCub62ludUjevyDX8rDkybxKbQ6O2WUl9pQHlnN9gm30k=
X-Gm-Gg: ASbGncuLQosCu1cHUpp7ht4/lFNZfv1tnI0zdnBB4PvMR96LRwf5FcKNypeUBgQuOT8
 lUQxSvz9G7KgCb1w8mnmvc+zA+lChL00=
X-Google-Smtp-Source: AGHT+IFO7f1q36drffDCMeLEuwkt9ndsB1dF1S7BdUxg+9jmun+atCzFk9tLV6H8QYbOw/pHnz+aVSJ4KNzuqCD1LWQ=
X-Received: by 2002:a2e:b88d:0:b0:2ff:d075:2408 with SMTP id
 38308e7fff4ca-2ffd60f04e7mr28403801fa.40.1732719383115; Wed, 27 Nov 2024
 06:56:23 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-6-sjg@chromium.org>
 <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
 <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
 <20241126155508.GR3600562@bill-the-cat>
 <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
 <20241126223332.GV3600562@bill-the-cat>
 <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
 <20241126233218.GW3600562@bill-the-cat>
 <CAFLszTi1A_672F68q5DYJW2g0T+LGZJcBwSVysXJD7+xG=Shbw@mail.gmail.com>
 <20241127141532.GZ3600562@bill-the-cat>
In-Reply-To: <20241127141532.GZ3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 07:56:11 -0700
Message-ID: <CAFLszTg8L4A0oGLh=K5kc8hR_E+LxFYeC_vNHMZDbV_+ZT8Btg@mail.gmail.com>
Subject: Re: [PATCH 05/13] efi_loader: Move some memory-function comments to
 header
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
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

Hi Tom,

On Wed, 27 Nov 2024 at 07:15, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 27, 2024 at 06:07:58AM -0700, Simon Glass wrote:
> > Hi,
> >
> > On Tue, 26 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Nov 26, 2024 at 11:50:40PM +0100, Heinrich Schuchardt wrote:
> > > > On 11/26/24 23:33, Tom Rini wrote:
> > > > > On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > >
> > > > > > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > > > > > Exported functions should be documented in the header file, not the
> > > > > > > > > > implementation. We tend to make such updates on a piecemeal basis to
> > > > > > > > > > avoid a 'flag day'. Move some comments related to memory allocation to
> > > > > > > > > > follow the convention.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > >
> > > > > > > > > Please, have a look at this line in doc/
> > > > > > > > >
> > > > > > > > > doc/api/efi.rst:78:
> > > > > > > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > > > > > > >
> > > > > > > > Hmm, we should not add C files as then we end up with all sorts of
> > > > > > > > internal functions, like checksum(). The help is a bit of a mess on
> > > > > > > > that page IMO and it could use an index at the top or side.
> > > > > > >
> > > > > > > Why? Looking at the linux kernel (where we borrow this framework from
> > > > > > > and lots of developers expect to follow that style) it's extremely
> > > > > > > common to kernel-doc C files. I don't see why documenting internal
> > > > > > > functions (which should be clear as being internal) is a problem.
> > > > > >
> > > > > > It depends what you mean by docs. U-Boot puts the documentation for
> > > > > > exported functions in header files.
> > > > >
> > > > > I'm sorry, that's a circular definition. And no, there is not a hard and
> > > > > fast rule that we only put kernel-doc style comments in header files
> > > > > (which are consumed by other files and tooling to generate
> > > > > documentation).
> > > > >
> > > > > > Putting docs in C files clutters the docs with internal
> > > > > > implementations, when most people just want to see the API. The way
> > > > > > U-Boot does things, it is easy to see the internal (implementation)
> > > > > > docs by looking at the C code and the external functions by looking at
> > > > > > the header files.
> > > > >
> > > > > Or it makes things harder to understand because the human readable
> > > > > documentation for a given function is separate from the file the
> > > > > implements the function. This is possibly why in the linux kernel, where
> > > > > we borrow "kernel-doc" from, documentation is frequently in the C file
> > > > > which is then included in Documentation files (the type you objected to
> > > > > in the start of this patch) which include additional human-readable
> > > > > explanation of the intention and usage of the API in question.
> > > > >
> > > >
> > > > For static functions we will continue to have function documentation in
> > > > the C files and not in the headers. I personally never looked up the API
> > > > documentation in the HTML docs but always in the source.
> >
> > Same here.
> >
> > > >
> > > > I am not opposed against moving the EFI function documentation into the
> > > > header files. But we should update doc/develop/efi.rst accordingly in
> > > > the same patch series. This is missing here.
> >
> > OK
> >
> > >
> > > My point is that the linux kernel is about 60% C files and 40% header
> > > files being kernel-doc'd in to documentation files and so "U-Boot
> > > doesn't put documentation in to C files" seems like the wrong approach.
> >
> > U-Boot tries to document functions in header files. At the risk of
> > making a blanket statement with thousands of counter-examples, that is
> > not so much the case in Linux.
> >
> > To a large extent, people developing features in U-Boot rely on the
> > header files to see what functions they can call. With the
> > documentation there, they often don't need to look at the source. I
> > certainly don't, unless the header-file comment is inadequate.
>
> I think this is a case of what you do, rather than what everyone else
> does.

That's not my reading of the source tree.

The file we are talking about has some comments in the header and some
in the source file. When you use an lsp client, it doesn't know what
to do.

> We want to be more like the linux kernel here, rather than less
> like the linux kernel, given the number of kernel people also working
> here. If Heinrich is fine with re-arranging everything, OK. But I think
> documentation with the code makes it less likely to get out of date,
> both in terms of intentional changes and bug fixes.

I am not suggesting separating documentation from code. I agree that
makes no sense. What I have consistently done (and asked for in
reviews) is:

- exported functions are documented next to their prototype in the header
- static functions are documented next to their implementation

This makes it easy to read the header file and see what the module is
doing, without having to dive into the implementation, which could be
1000 lines or more. It also makes for more useful kerneldoc, IMO,
since we are showing functions which are exported and therefore more
useful for development. Adding the entire C code of U-Boot into
kerneldoc seems like a bad use of space.

Regards,
Simon
