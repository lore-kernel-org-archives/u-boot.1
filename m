Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1D4D7360A
	for <u-boot@archiver.kernel.org>; Sat, 30 Nov 2024 20:25:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51DCC88ECB;
	Sat, 30 Nov 2024 21:25:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="nCy1RHu3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFE8688E4B; Sat, 30 Nov 2024 21:25:09 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8079288A9D
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 21:25:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa549d9dffdso445101266b.2
 for <u-boot@lists.denx.de>; Sat, 30 Nov 2024 12:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732998307; x=1733603107; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U1m0DXKbvegctlr9YEvSkhD6FfXF9A5IMSfTkVp0cGU=;
 b=nCy1RHu3rwiFK6FRY5HIA1+YYHjgVXp0/6Z0FCXWTOKhKWSnGtM/NXOPsHpSaMVbd9
 1198t0OW6g3jVR+4/N9eHE6W9X0WpHrLqpyzywNzX1P9M0sQK14KnoeIy8Bcd0lVHtGU
 pK444MNl0+iDzmQOXDVrsKtdViJ+u3WWObv7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732998307; x=1733603107;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U1m0DXKbvegctlr9YEvSkhD6FfXF9A5IMSfTkVp0cGU=;
 b=UMGebDm+XDRZrF3QkRfl5Lb4DgsTqyr6JcLbP5BKSIQ3aAEkYDWaJGpz3EAd3LcUWV
 d4lS0yw0scySKTFrUyawpEhUpayfI12SFsBVdef2Nxd2MqX9Te6cBC/UUjpaeP6zLbEC
 lxi2lUngpuLYBTqdo6xkbjAErFQ0qJUIDnDnlK/tS+W0qPbn7ZphbSRqbA4oXf3eRvwH
 Pp8yJ51IbQg73aIFJepbXZadK5P2BwtMYKIMlguiic2UVIOEBM4cAVJY5+fCbESeNx1p
 KbOcIw0qflVuth4WuDE5FHjvxEVf5dJtln8PUTEa+hOIktuQ9Oxd6JctkggSoXXgHlGv
 MtRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPNKt6opGcvUYHQX2C4lTDjoSEW9wpR33DAalDOY+P69eEquQmdN7IdotLoN3/sU8JExVHlZc=@lists.denx.de
X-Gm-Message-State: AOJu0YyGx5iMU+Nzg81vQgLJXKyqPlWM1ENJ7Y2O4yrGHurTTaLn6s/n
 ODmm6gqFHfIFuAEDu5d6IZtZFuSZtGEEPVDHeWJDb8BsI2GWgPuURE3yWveGSfiD46NFyG4cYOk
 9h98Qzd3/DJDkBKtDq+/ncw6BElkB6gyFWN1h
X-Gm-Gg: ASbGncs8Yr2/+s+dgRF35oaQkXb8d0ClieNy9jHshJ/GCN0hbXiCI2UBrp0UZ73zRlb
 wKuwr3Q0DBvoiI7d8qGSHUSncX80va+w=
X-Google-Smtp-Source: AGHT+IGXuyiZK+6hpnGXaIUIwWLuKnyJtR1MlQ6X5zUdF9LE+eVnjpvTI3jeM55CcCw9yIC22G9ZruJBDv7KACKVNqg=
X-Received: by 2002:a17:906:8453:b0:aa5:4d26:8e52 with SMTP id
 a640c23a62f3a-aa581058831mr1544247766b.47.1732998306832; Sat, 30 Nov 2024
 12:25:06 -0800 (PST)
MIME-Version: 1.0
References: <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
 <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
 <20241126155508.GR3600562@bill-the-cat>
 <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
 <20241126223332.GV3600562@bill-the-cat>
 <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
 <20241126233218.GW3600562@bill-the-cat>
 <CAFLszTi1A_672F68q5DYJW2g0T+LGZJcBwSVysXJD7+xG=Shbw@mail.gmail.com>
 <20241127141532.GZ3600562@bill-the-cat>
 <CAFLszTg8L4A0oGLh=K5kc8hR_E+LxFYeC_vNHMZDbV_+ZT8Btg@mail.gmail.com>
 <20241127221059.GE3600562@bill-the-cat>
In-Reply-To: <20241127221059.GE3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 30 Nov 2024 13:24:54 -0700
Message-ID: <CAFLszTiP3ika=dGQ9pX3btdY7CWB-n3AsqaSa4DZRPJj9fs0Hg@mail.gmail.com>
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

On Wed, 27 Nov 2024 at 15:11, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Nov 27, 2024 at 07:56:11AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 27 Nov 2024 at 07:15, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, Nov 27, 2024 at 06:07:58AM -0700, Simon Glass wrote:
> > > > Hi,
> > > >
> > > > On Tue, 26 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Nov 26, 2024 at 11:50:40PM +0100, Heinrich Schuchardt wrote:
> > > > > > On 11/26/24 23:33, Tom Rini wrote:
> > > > > > > On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> > > > > > > > > > Hi Heinrich,
> > > > > > > > > >
> > > > > > > > > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > > > > > > > Exported functions should be documented in the header file, not the
> > > > > > > > > > > > implementation. We tend to make such updates on a piecemeal basis to
> > > > > > > > > > > > avoid a 'flag day'. Move some comments related to memory allocation to
> > > > > > > > > > > > follow the convention.
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > >
> > > > > > > > > > > Please, have a look at this line in doc/
> > > > > > > > > > >
> > > > > > > > > > > doc/api/efi.rst:78:
> > > > > > > > > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > > > > > > > > >
> > > > > > > > > > Hmm, we should not add C files as then we end up with all sorts of
> > > > > > > > > > internal functions, like checksum(). The help is a bit of a mess on
> > > > > > > > > > that page IMO and it could use an index at the top or side.
> > > > > > > > >
> > > > > > > > > Why? Looking at the linux kernel (where we borrow this framework from
> > > > > > > > > and lots of developers expect to follow that style) it's extremely
> > > > > > > > > common to kernel-doc C files. I don't see why documenting internal
> > > > > > > > > functions (which should be clear as being internal) is a problem.
> > > > > > > >
> > > > > > > > It depends what you mean by docs. U-Boot puts the documentation for
> > > > > > > > exported functions in header files.
> > > > > > >
> > > > > > > I'm sorry, that's a circular definition. And no, there is not a hard and
> > > > > > > fast rule that we only put kernel-doc style comments in header files
> > > > > > > (which are consumed by other files and tooling to generate
> > > > > > > documentation).
> > > > > > >
> > > > > > > > Putting docs in C files clutters the docs with internal
> > > > > > > > implementations, when most people just want to see the API. The way
> > > > > > > > U-Boot does things, it is easy to see the internal (implementation)
> > > > > > > > docs by looking at the C code and the external functions by looking at
> > > > > > > > the header files.
> > > > > > >
> > > > > > > Or it makes things harder to understand because the human readable
> > > > > > > documentation for a given function is separate from the file the
> > > > > > > implements the function. This is possibly why in the linux kernel, where
> > > > > > > we borrow "kernel-doc" from, documentation is frequently in the C file
> > > > > > > which is then included in Documentation files (the type you objected to
> > > > > > > in the start of this patch) which include additional human-readable
> > > > > > > explanation of the intention and usage of the API in question.
> > > > > > >
> > > > > >
> > > > > > For static functions we will continue to have function documentation in
> > > > > > the C files and not in the headers. I personally never looked up the API
> > > > > > documentation in the HTML docs but always in the source.
> > > >
> > > > Same here.
> > > >
> > > > > >
> > > > > > I am not opposed against moving the EFI function documentation into the
> > > > > > header files. But we should update doc/develop/efi.rst accordingly in
> > > > > > the same patch series. This is missing here.
> > > >
> > > > OK
> > > >
> > > > >
> > > > > My point is that the linux kernel is about 60% C files and 40% header
> > > > > files being kernel-doc'd in to documentation files and so "U-Boot
> > > > > doesn't put documentation in to C files" seems like the wrong approach.
> > > >
> > > > U-Boot tries to document functions in header files. At the risk of
> > > > making a blanket statement with thousands of counter-examples, that is
> > > > not so much the case in Linux.
> > > >
> > > > To a large extent, people developing features in U-Boot rely on the
> > > > header files to see what functions they can call. With the
> > > > documentation there, they often don't need to look at the source. I
> > > > certainly don't, unless the header-file comment is inadequate.
> > >
> > > I think this is a case of what you do, rather than what everyone else
> > > does.
> >
> > That's not my reading of the source tree.
>
> So, if we call this point 1 for a moment.
>
> > The file we are talking about has some comments in the header and some
> > in the source file. When you use an lsp client, it doesn't know what
> > to do.
>
> Sounds like a bad client? Because again, we should be following the
> kernel here.
>
> > > We want to be more like the linux kernel here, rather than less
> > > like the linux kernel, given the number of kernel people also working
> > > here. If Heinrich is fine with re-arranging everything, OK. But I think
> > > documentation with the code makes it less likely to get out of date,
> > > both in terms of intentional changes and bug fixes.
> >
> > I am not suggesting separating documentation from code. I agree that
> > makes no sense. What I have consistently done (and asked for in
> > reviews) is:
> >
> > - exported functions are documented next to their prototype in the header
> > - static functions are documented next to their implementation
>
> So going back to point 1 now, yes. This is what I'm saying. Your
> preference, expressed through reviews and telling people to change when
> they do it other ways, is where the current situation comes from.
>
> > This makes it easy to read the header file and see what the module is
> > doing, without having to dive into the implementation, which could be
> > 1000 lines or more. It also makes for more useful kerneldoc, IMO,
> > since we are showing functions which are exported and therefore more
> > useful for development. Adding the entire C code of U-Boot into
> > kerneldoc seems like a bad use of space.
>
> Um, I don't follow you here. If the code doesn't have kerneldoc
> comments, it's not included. I just made a silly test with a change to
> include/clk.h. It's not included in the output. And "the code might be
> so big it needs refactoring" is not a good excuse.

Yes, I see that static functions don't appear by default, so adding C
files doesn't necessarily result in functions appearing in the doc
output.

>
> The kernel is inconsistent here. The first example I went to look for of
> something that uses both C and header files in a document was
> Documentation/admin-guide/pstore-blk.rst and both fs/pstore/blk.c and
> include/linux/pstore_blk.h are kernel-doc'd in and the header describes
> a public function of the C file while the C file describes other
> functions too.

Yes, pstore docs seems like a nice way to do things, for docs.

For people working on the code base, I strongly believe that exported
functions and structs are the main way to understand how to use a
subsystem, so their docs should be in the header file.

Regards,
Simon
