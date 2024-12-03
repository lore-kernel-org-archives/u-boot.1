Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E0BE64AA9
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:46:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC7889655;
	Tue,  3 Dec 2024 14:46:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b6WHnzEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3818E89588; Tue,  3 Dec 2024 14:46:33 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DFC8A89666
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:46:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-aa51bf95ce1so280454466b.3
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733233590; x=1733838390; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ccdbku41tuKKIJaMzUqpknL7n59fNtcudDrVG19yDoU=;
 b=b6WHnzEpH02Ftj9jY8KZFxKgPXMuAHSctAvfURawOmlPMmm8bsTjRw8iBzeJpQD6Hc
 xj+2BNceTHMe7lxByQnw+us/JGlj3TC8dPRJUaILGjz57LWQXzzzN2RjkUQwENPey91U
 ZNOMfbv3LAH05vy6cwytc7gwrCAQti6YnNySU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233590; x=1733838390;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ccdbku41tuKKIJaMzUqpknL7n59fNtcudDrVG19yDoU=;
 b=QqmwNb6UtJiTJSjI8p7oefu/IF+85KoYkmb74OVeFHHSvzvZK5N1p1uYcm9J4s8qDr
 1Qz/P5mWUAFnZ8MpYpP8bft/tRUXRgnsgu3TXpk5zJPJSJUznWUkl5cjVld1Zs14B3jY
 mRGxb7UtIQsdoTLJ9GAK3skyEeBpMH+HLxYwJCf52Nf9Hi/cvGSA8bjB+zWITJycgW9U
 sASsdvVfZwww0y5JnBrg/s7A5fbTKZ3bSNnwxGStiKEMZqtgaiu+F01hSS12nY06KM8d
 i8ocSPoD9ieDQC227bkEkLwJGV+qHeP8kYdEgqmFXcGRNce1OcU5Ymepp8gIalxQt1EM
 WbOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6uOBjAVzv9BapHfhBc8DG3W/Q2O0uebwqdcuP1BxYZ3XhzYBU3VM9mp8uAPV2Hn0EDv7UIGQ=@lists.denx.de
X-Gm-Message-State: AOJu0Ywr0FfJTcOQur7uWu88HrnB+37jwGfH+yVpnLhcMgrQDFpbklvc
 SFTS0/qRpnN81WtxGU79NIPw0rDCmkzWZUk55VlKxNitDoxZVmsXCaUSl4RaqStdpkVbPKEKyaG
 irEdeNe2auvTXJvbY4Bh+c1I269w9WqVgcN7W
X-Gm-Gg: ASbGncsencNvTSieD3do7nD2GESYW4+aDgGia97vTO+94l2oPKCfgvo1UhPjBTvyMR1
 nEZ4cXqL+A8G/rQS9HeYlwgKPYcAsNMMb
X-Google-Smtp-Source: AGHT+IG8iYIIQAgUKFy1OfjW/KDoF8Cn427IaEQeLHvvTbKUItwKT6MFjSt8wL3lsFptJUkrmZtc1y/brQprHuKS6pw=
X-Received: by 2002:a17:906:308f:b0:a9e:b5cf:df02 with SMTP id
 a640c23a62f3a-aa6018d936emr28809866b.41.1733233590178; Tue, 03 Dec 2024
 05:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20241126223332.GV3600562@bill-the-cat>
 <aa7134ee-97dc-4fcc-b739-0f97e57817fd@gmx.de>
 <20241126233218.GW3600562@bill-the-cat>
 <CAFLszTi1A_672F68q5DYJW2g0T+LGZJcBwSVysXJD7+xG=Shbw@mail.gmail.com>
 <20241127141532.GZ3600562@bill-the-cat>
 <CAFLszTg8L4A0oGLh=K5kc8hR_E+LxFYeC_vNHMZDbV_+ZT8Btg@mail.gmail.com>
 <20241127221059.GE3600562@bill-the-cat>
 <CAFLszTiP3ika=dGQ9pX3btdY7CWB-n3AsqaSa4DZRPJj9fs0Hg@mail.gmail.com>
 <20241202133507.GB2457179@bill-the-cat>
 <CAFLszTi2g6a9HZNsrMGKiegQSQCLUsJEccHv2OR2DPvb7sXtDA@mail.gmail.com>
 <20241203003503.GL2457179@bill-the-cat>
In-Reply-To: <20241203003503.GL2457179@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 06:46:17 -0700
Message-ID: <CAFLszTiDwoGTEtP83qOO85hSgr60eCgSY96XHmAnDHnSdU197Q@mail.gmail.com>
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

On Mon, 2 Dec 2024 at 17:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Dec 02, 2024 at 05:20:31PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 2 Dec 2024 at 06:35, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sat, Nov 30, 2024 at 01:24:54PM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 27 Nov 2024 at 15:11, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Wed, Nov 27, 2024 at 07:56:11AM -0700, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Wed, 27 Nov 2024 at 07:15, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Wed, Nov 27, 2024 at 06:07:58AM -0700, Simon Glass wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Tue, 26 Nov 2024 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, Nov 26, 2024 at 11:50:40PM +0100, Heinrich Schuchardt wrote:
> > > > > > > > > > On 11/26/24 23:33, Tom Rini wrote:
> > > > > > > > > > > On Tue, Nov 26, 2024 at 01:04:25PM -0700, Simon Glass wrote:
> > > > > > > > > > > > Hi Tom,
> > > > > > > > > > > >
> > > > > > > > > > > > On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > > > > > >
> > > > > > > > > > > > > On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> > > > > > > > > > > > > > Hi Heinrich,
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > On 25.11.24 21:44, Simon Glass wrote:
> > > > > > > > > > > > > > > > Exported functions should be documented in the header file, not the
> > > > > > > > > > > > > > > > implementation. We tend to make such updates on a piecemeal basis to
> > > > > > > > > > > > > > > > avoid a 'flag day'. Move some comments related to memory allocation to
> > > > > > > > > > > > > > > > follow the convention.
> > > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Please, have a look at this line in doc/
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > doc/api/efi.rst:78:
> > > > > > > > > > > > > > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > Hmm, we should not add C files as then we end up with all sorts of
> > > > > > > > > > > > > > internal functions, like checksum(). The help is a bit of a mess on
> > > > > > > > > > > > > > that page IMO and it could use an index at the top or side.
> > > > > > > > > > > > >
> > > > > > > > > > > > > Why? Looking at the linux kernel (where we borrow this framework from
> > > > > > > > > > > > > and lots of developers expect to follow that style) it's extremely
> > > > > > > > > > > > > common to kernel-doc C files. I don't see why documenting internal
> > > > > > > > > > > > > functions (which should be clear as being internal) is a problem.
> > > > > > > > > > > >
> > > > > > > > > > > > It depends what you mean by docs. U-Boot puts the documentation for
> > > > > > > > > > > > exported functions in header files.
> > > > > > > > > > >
> > > > > > > > > > > I'm sorry, that's a circular definition. And no, there is not a hard and
> > > > > > > > > > > fast rule that we only put kernel-doc style comments in header files
> > > > > > > > > > > (which are consumed by other files and tooling to generate
> > > > > > > > > > > documentation).
> > > > > > > > > > >
> > > > > > > > > > > > Putting docs in C files clutters the docs with internal
> > > > > > > > > > > > implementations, when most people just want to see the API. The way
> > > > > > > > > > > > U-Boot does things, it is easy to see the internal (implementation)
> > > > > > > > > > > > docs by looking at the C code and the external functions by looking at
> > > > > > > > > > > > the header files.
> > > > > > > > > > >
> > > > > > > > > > > Or it makes things harder to understand because the human readable
> > > > > > > > > > > documentation for a given function is separate from the file the
> > > > > > > > > > > implements the function. This is possibly why in the linux kernel, where
> > > > > > > > > > > we borrow "kernel-doc" from, documentation is frequently in the C file
> > > > > > > > > > > which is then included in Documentation files (the type you objected to
> > > > > > > > > > > in the start of this patch) which include additional human-readable
> > > > > > > > > > > explanation of the intention and usage of the API in question.
> > > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > For static functions we will continue to have function documentation in
> > > > > > > > > > the C files and not in the headers. I personally never looked up the API
> > > > > > > > > > documentation in the HTML docs but always in the source.
> > > > > > > >
> > > > > > > > Same here.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > I am not opposed against moving the EFI function documentation into the
> > > > > > > > > > header files. But we should update doc/develop/efi.rst accordingly in
> > > > > > > > > > the same patch series. This is missing here.
> > > > > > > >
> > > > > > > > OK
> > > > > > > >
> > > > > > > > >
> > > > > > > > > My point is that the linux kernel is about 60% C files and 40% header
> > > > > > > > > files being kernel-doc'd in to documentation files and so "U-Boot
> > > > > > > > > doesn't put documentation in to C files" seems like the wrong approach.
> > > > > > > >
> > > > > > > > U-Boot tries to document functions in header files. At the risk of
> > > > > > > > making a blanket statement with thousands of counter-examples, that is
> > > > > > > > not so much the case in Linux.
> > > > > > > >
> > > > > > > > To a large extent, people developing features in U-Boot rely on the
> > > > > > > > header files to see what functions they can call. With the
> > > > > > > > documentation there, they often don't need to look at the source. I
> > > > > > > > certainly don't, unless the header-file comment is inadequate.
> > > > > > >
> > > > > > > I think this is a case of what you do, rather than what everyone else
> > > > > > > does.
> > > > > >
> > > > > > That's not my reading of the source tree.
> > > > >
> > > > > So, if we call this point 1 for a moment.
> > > > >
> > > > > > The file we are talking about has some comments in the header and some
> > > > > > in the source file. When you use an lsp client, it doesn't know what
> > > > > > to do.
> > > > >
> > > > > Sounds like a bad client? Because again, we should be following the
> > > > > kernel here.
> > > > >
> > > > > > > We want to be more like the linux kernel here, rather than less
> > > > > > > like the linux kernel, given the number of kernel people also working
> > > > > > > here. If Heinrich is fine with re-arranging everything, OK. But I think
> > > > > > > documentation with the code makes it less likely to get out of date,
> > > > > > > both in terms of intentional changes and bug fixes.
> > > > > >
> > > > > > I am not suggesting separating documentation from code. I agree that
> > > > > > makes no sense. What I have consistently done (and asked for in
> > > > > > reviews) is:
> > > > > >
> > > > > > - exported functions are documented next to their prototype in the header
> > > > > > - static functions are documented next to their implementation
> > > > >
> > > > > So going back to point 1 now, yes. This is what I'm saying. Your
> > > > > preference, expressed through reviews and telling people to change when
> > > > > they do it other ways, is where the current situation comes from.
> > > > >
> > > > > > This makes it easy to read the header file and see what the module is
> > > > > > doing, without having to dive into the implementation, which could be
> > > > > > 1000 lines or more. It also makes for more useful kerneldoc, IMO,
> > > > > > since we are showing functions which are exported and therefore more
> > > > > > useful for development. Adding the entire C code of U-Boot into
> > > > > > kerneldoc seems like a bad use of space.
> > > > >
> > > > > Um, I don't follow you here. If the code doesn't have kerneldoc
> > > > > comments, it's not included. I just made a silly test with a change to
> > > > > include/clk.h. It's not included in the output. And "the code might be
> > > > > so big it needs refactoring" is not a good excuse.
> > > >
> > > > Yes, I see that static functions don't appear by default, so adding C
> > > > files doesn't necessarily result in functions appearing in the doc
> > > > output.
> > >
> > > Only properly formatted comments are used in documentation, yes. So
> > > static functions could be, if it was important to do so.
> > >
> > > > > The kernel is inconsistent here. The first example I went to look for of
> > > > > something that uses both C and header files in a document was
> > > > > Documentation/admin-guide/pstore-blk.rst and both fs/pstore/blk.c and
> > > > > include/linux/pstore_blk.h are kernel-doc'd in and the header describes
> > > > > a public function of the C file while the C file describes other
> > > > > functions too.
> > > >
> > > > Yes, pstore docs seems like a nice way to do things, for docs.
> > > >
> > > > For people working on the code base, I strongly believe that exported
> > > > functions and structs are the main way to understand how to use a
> > > > subsystem, so their docs should be in the header file.
> > >
> > > Sure. But there is no project-wide rule. I strongly believe that the API
> > > should be documented alongside of the code so that it doesn't drift
> > > apart, among other reasons.
> >
> > Again we are reaching the limits of email, I fear, as I am not
> > suggesting that we document the API somewhere other than in the code.
> > It is just that the API should be in the header file, next to the
> > function it relates to. It can't drift apart, since the header-file
> > must match the C function, or it won't compile.
>
> It will certainly drift apart because the comment that documents how the
> function works is separate from the implementation.

Updating function comments is a habit that is hard to get into.

Regards,
Simon
