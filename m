Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B66D6ACCA
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 13:08:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 448C6897E0;
	Wed, 27 Nov 2024 14:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lx4MWpxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED0A9897F8; Wed, 27 Nov 2024 14:08:16 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C8442897D6
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 14:08:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53de7321675so3462853e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 05:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732712894; x=1733317694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zczpIOcNd1KlKjEJVb8UznL6vcf6i/avx13M96regp8=;
 b=lx4MWpxjGjUzMaC+k/1UbosjtF/5d8JsJotDJXKL1P6lorqkYNTjAlPBeYNI62vjOA
 eYlBtjiI4w4XdTVl3cH1hRnv2X/2PHFV/9iXyCgY7dwz4mTg8NDsUr1upohgSnoh0nxs
 xY3PfDkNlmKHnD2I3pxIGJbnn9so14EtNA/cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732712894; x=1733317694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zczpIOcNd1KlKjEJVb8UznL6vcf6i/avx13M96regp8=;
 b=TGgx7iglNrsxpGvYFnJ/RC0Vg19KrAzxZEA+kybDE1L3FgqwNl7H6DZNKpYsiAgUjR
 ADZ3u6G4dPMZHjmNdFz8YC/Z8Jy3WOnEFr7zxCPWHMtfMOkCTh0hzRqfFRwCjqW0qqeA
 hgtrztkg2MXPK+MupXOXl683KNh7t53WLcnTeUEScVxMrJ6aCcQEvUiCq8zXdbZB+5yU
 7Cpmd5SQB8EVvEKbp4R7sYHsWoxk9UN9+WMSfwo82XmqtlBvASuQM/aTIMLzygzYIk17
 GMeJwUXLYtCw78eZiP6a4gkg06kPZpvlddaLcs5CPHTqLYaBPLJCfBBPJsUXHiTE9D95
 PEIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuBwb3xyXJRqIov9aBMnkY8L1llh9apzaVWGcXaPVjSlG8ZQw1vz747XQ/PnvTp+UG6JSHlLM=@lists.denx.de
X-Gm-Message-State: AOJu0Yw5K4xw0utfvhAUimpgzcrEXwst4J5jLiraEUOCPEo4VcR+SVgE
 /X1Fg/NSW0ED099DQemaB5p+9Mb2cNz2OaNYAIbtUrGAm/YjV594ZxCe1hVkusVhc4R8evY+ZVy
 GKS83fcC1tougdwC07auH1onmbFd2DeeRSylg
X-Gm-Gg: ASbGncsX6MMFwKmvu/EMQymWgAt7GMkJ5ODoGnLM7/jT7u/+CKsi/ZDp0Eg3lvXNP5x
 UoacZk3RU1u8QWNd9A6aOAgwK4ZJzFns=
X-Google-Smtp-Source: AGHT+IE2MXxceZTUdk5L3PR57f+wVZUnFtntEwzTn/pZKKjt+2iUdRr4KxMzzGYrn9axSyTIMS7LyCkwQi/KQxu204Y=
X-Received: by 2002:a05:6512:124e:b0:53d:d3ff:7309 with SMTP id
 2adb3069b0e04-53df00d9e96mr1876419e87.32.1732712893367; Wed, 27 Nov 2024
 05:08:13 -0800 (PST)
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
In-Reply-To: <20241126233218.GW3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 27 Nov 2024 06:07:58 -0700
Message-ID: <CAFLszTi1A_672F68q5DYJW2g0T+LGZJcBwSVysXJD7+xG=Shbw@mail.gmail.com>
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

Hi,

On Tue, 26 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 26, 2024 at 11:50:40PM +0100, Heinrich Schuchardt wrote:
> > On 11/26/24 23:33, Tom Rini wrote:
> > > On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > >
> > > > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > > > Exported functions should be documented in the header file, not the
> > > > > > > > implementation. We tend to make such updates on a piecemeal basis to
> > > > > > > > avoid a 'flag day'. Move some comments related to memory allocation to
> > > > > > > > follow the convention.
> > > > > > > >
> > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > >
> > > > > > > Please, have a look at this line in doc/
> > > > > > >
> > > > > > > doc/api/efi.rst:78:
> > > > > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > > > > >
> > > > > > Hmm, we should not add C files as then we end up with all sorts of
> > > > > > internal functions, like checksum(). The help is a bit of a mess on
> > > > > > that page IMO and it could use an index at the top or side.
> > > > >
> > > > > Why? Looking at the linux kernel (where we borrow this framework from
> > > > > and lots of developers expect to follow that style) it's extremely
> > > > > common to kernel-doc C files. I don't see why documenting internal
> > > > > functions (which should be clear as being internal) is a problem.
> > > >
> > > > It depends what you mean by docs. U-Boot puts the documentation for
> > > > exported functions in header files.
> > >
> > > I'm sorry, that's a circular definition. And no, there is not a hard and
> > > fast rule that we only put kernel-doc style comments in header files
> > > (which are consumed by other files and tooling to generate
> > > documentation).
> > >
> > > > Putting docs in C files clutters the docs with internal
> > > > implementations, when most people just want to see the API. The way
> > > > U-Boot does things, it is easy to see the internal (implementation)
> > > > docs by looking at the C code and the external functions by looking at
> > > > the header files.
> > >
> > > Or it makes things harder to understand because the human readable
> > > documentation for a given function is separate from the file the
> > > implements the function. This is possibly why in the linux kernel, where
> > > we borrow "kernel-doc" from, documentation is frequently in the C file
> > > which is then included in Documentation files (the type you objected to
> > > in the start of this patch) which include additional human-readable
> > > explanation of the intention and usage of the API in question.
> > >
> >
> > For static functions we will continue to have function documentation in
> > the C files and not in the headers. I personally never looked up the API
> > documentation in the HTML docs but always in the source.

Same here.

> >
> > I am not opposed against moving the EFI function documentation into the
> > header files. But we should update doc/develop/efi.rst accordingly in
> > the same patch series. This is missing here.

OK

>
> My point is that the linux kernel is about 60% C files and 40% header
> files being kernel-doc'd in to documentation files and so "U-Boot
> doesn't put documentation in to C files" seems like the wrong approach.

U-Boot tries to document functions in header files. At the risk of
making a blanket statement with thousands of counter-examples, that is
not so much the case in Linux.

To a large extent, people developing features in U-Boot rely on the
header files to see what functions they can call. With the
documentation there, they often don't need to look at the source. I
certainly don't, unless the header-file comment is inadequate.

Regards,
SImon
