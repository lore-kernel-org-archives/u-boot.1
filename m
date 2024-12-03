Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A3DE64AA6
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 13:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F6C388E5C;
	Tue,  3 Dec 2024 14:46:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dZcLbhYN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D50D689328; Tue,  3 Dec 2024 14:46:12 +0100 (CET)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 73E1388E35
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 14:46:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5d0cd67766aso4379522a12.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 05:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733233570; x=1733838370; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VegB6AnyX3sIhO3CScGa8b4ip1xSPOR1W+T/QbgZato=;
 b=dZcLbhYN2K4mhsldcojMODzZH3DXtD5OihpR7e/pAQIR/q1mm1SJZnv+X9v4VFIMr0
 c0zrUihSibY+1KhM6PztcS4nzQIqWIwUBpcQd3VC2jA0K4iwtnJlaZG2mAy9RPOL9jt+
 VZ12AjxHoY/qxhP7WA7CKfStNBGjM81sjyQHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233570; x=1733838370;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VegB6AnyX3sIhO3CScGa8b4ip1xSPOR1W+T/QbgZato=;
 b=SXlyBNCaqvnEBaVwTZCZWc4bPw/twCti0qY5dxO7o3wzhPZ+1AzXFR1P+g3oQSg4cU
 Ubumd7QyJ2qdAoy0SjO4AH4CjND2sMeexpkttSlWw2pggkn4XTxXbtutd++woaI/bEvH
 YTierUyzBdKTu3C8yVDo3H6Z07ftT4aj1lPcmYErleCxPFIl6EBienIGSwO2k1Wgov0f
 /fl2LQEALzZWTQMAAebxPufGCWfWgV7hSRpL3zDg/vuSMi0VuPv00aiZlbps6oP3jhQH
 cPjeECSryzNkISspTxfnuJuMi+q714dBFx7K/4neYRMOXfcqDmY/hD2no5RHyVfnJzH4
 Oqig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUI333/6Fg7ZHmQYYzCe8O3skOlxg6SXI+j5TMqMJNUccapwt5nQjFRxns8VwKh++/SDDdLEuM=@lists.denx.de
X-Gm-Message-State: AOJu0YwgJZmbA5iidNq1NxEJ4BTuX+URZgapEWtq4GhT6YDvL8Opy8U6
 lYk27Ht5cZDgh49i1tgt2g9eQtoC++7Hk3ODTHzZABiyqGnOwPoewAHkyePl0RiB2T+J8xparGy
 dQNNZGFhAFml48Xd5EMBIGjtBvMnoE4r5EBAz
X-Gm-Gg: ASbGncunTrc3X+qtqRNlHjoE+GE7BuhoPW4EDyc8mOErI5RWdINij8VU3JibfNjdove
 3Y8e1Ta3oHSNLCpC6eVHLdIePtJh4vy4r
X-Google-Smtp-Source: AGHT+IFXu3a2BmSGMDsdhONTPgvZjYS2VXEXWq5PY5bllKHghjK7O64zdhWW6BixtoounL2fV5teYwKP1mHFUjzeK2w=
X-Received: by 2002:a17:906:cca:b0:a9a:c651:e7d9 with SMTP id
 a640c23a62f3a-aa5f7f006e4mr150793766b.46.1733233569875; Tue, 03 Dec 2024
 05:46:09 -0800 (PST)
MIME-Version: 1.0
References: <20241201152505.1666789-1-sjg@chromium.org>
 <20241201152505.1666789-5-sjg@chromium.org>
 <20241202201832.GH2457179@bill-the-cat>
 <CAFLszTitE4Gq+LUEm64ro2eL4_VME+gDh7s2jEnBTmVvkgX9sg@mail.gmail.com>
 <CAC_iWjLex4Z41CDpx4u07XeCYgjB7H+Ynd8aQYL-wruH7yRmQA@mail.gmail.com>
In-Reply-To: <CAC_iWjLex4Z41CDpx4u07XeCYgjB7H+Ynd8aQYL-wruH7yRmQA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 3 Dec 2024 06:45:58 -0700
Message-ID: <CAFLszTiMi89uydJUmDg740opTJXm0YJ8WUQ5aJPwxPnb+9EGMw@mail.gmail.com>
Subject: Re: [PATCH v4 04/25] efi_loader: Add comments where incorrect
 addresses are used
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Mark Kettenis <kettenis@openbsd.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>
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

On Tue, 3 Dec 2024 at 01:49, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Tue, 3 Dec 2024 at 02:22, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Tom,
> >
> > On Mon, 2 Dec 2024 at 13:18, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Sun, Dec 01, 2024 at 08:24:23AM -0700, Simon Glass wrote:
> > >
> > > > Some functions are passing addresses instead of pointers to the
> > > > efi_add_memory_map() function. This confusion is understandable since
> > > > the function arguments indicate an address.
> > > >
> > > > Make a note of the 8 places where there are problems, which would break
> > > > usage in sandbox tests.
> > > >
> > > > Future work will resolve these problems.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Please just resolve these rather than introducing a patch to then fix
> > > them later. This is something that should have been fixup'd before
> > > posting. Thanks.
> >
> > That was deliberate, as I wanted people to see the problems. It will
> > save discussion on later patches where the problems are fixed, if we
> > can agree that these are actual problems. If people are happy to add
> > review tags to the later patches then I'm happy to redo it.
>
> I am pretty sure Heinrich has repeated this in the past. Why do we
> have to sprinkle around map_sysmem/unmap sysmem for sandbox?
> Polluting the entire u-boot to support a special platform is less than
> ideal. Why can't sandbox limit this internally and do whatever
> mappings it needs when it receives an address?

Tom, I suppose I have made my point.

Ilias, this is documented at [1] and has been the same for 10 years.

See for example the 'md' command, do_mem_md(), which shows how 'md 0'
is implemented in sandbox.

As I have mentioned before, the nice thing is that you can easily make
code work with sandbox just by converting casts from
address-to-pointer into map_sysmem().

Back to this series, if you look at efi_allocate_pages() you'll
currently see three calls (two map_to_sysmem() one map_sysmem(), but
now, with this series, there is none. It also makes it a lot easier to
understand what is going on, IMO.

Regards,
Simon

[1] https://docs.u-boot.org/en/latest/arch/sandbox/sandbox.html#memory-emulation
