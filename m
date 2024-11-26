Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82057D65553
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 20:04:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BED0789663;
	Tue, 26 Nov 2024 21:04:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="i1lmkpzO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5722C896EA; Tue, 26 Nov 2024 21:04:41 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 533C789651
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 21:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-aa520699becso661561966b.1
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 12:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732651478; x=1733256278; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rCzSwmaUcE3zuJvq9WX+Gvt9P95/SWHh67tRUIsxxJ0=;
 b=i1lmkpzOyC2HOTHsxEee5dRiTsfIZh0AehzygyNqLPCsYzQCzjZ/urFkpvXniZjq5t
 BDZdN3FQsdM2xAEYjcz2SoWRpPHItxR2r8IRRYcKCSb86zEWoMZE7l6j1WRg849HDTLo
 nyz2IXA1OEMyfX47fQ/IO1YEuImCGhsbTAzyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732651478; x=1733256278;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCzSwmaUcE3zuJvq9WX+Gvt9P95/SWHh67tRUIsxxJ0=;
 b=Y4KZUgTvO+v36xr4vcAKZZsTwu8mcidPufS8GwMZBBc4iP3MTp2mubsyBUwFgT/yAd
 dyEUmTgBj8QwSOeBpWwXyon5rOibfN4EYXm+hXTENHoxFPz6FQWSgWSrplGrJM95TaV/
 zbbHikuXrtcns8xWuimfYo077KEjDbrWGVlgeJUWeJ0s8OtDKsVNt2bk7d1O2VYqxUiQ
 aWDxj7bQbxSMuYK5wApDtGuFxEK9RIZoo7W1A5SKy/0It3xR7hDwGaeB5ad33bC/7tF+
 JJgy0PuEHe8A+mqE/oQqSDiTh9zLgJd+/+6ITWUhUylkS2dSfWTMbRJtQoGrriRubAel
 0J2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZLLB3ZeZDS5ZfTpdZLscYXEDjRWCTNaUg4RwPCGcWHrre2yAilDt9aJ5dtCTrZe896amTS+4=@lists.denx.de
X-Gm-Message-State: AOJu0YzJHL06zMe3se/w/fBEbVmVJlrCBJmE6nBOzRxxdWt3kn1O7Bcv
 qKuJfiGTkT1dHAFp8lmEwN2rlHt1wLqdVkztoFxoHike+CJQozyWgBVs1MWfcA4yYXbAIQFwYyx
 CQ0CACwITGlNu0Kj+CmaWlUwSpeexT/g80Vg5
X-Gm-Gg: ASbGncu6Uv36WsREPf6Exr33P4mXSltYQqTG37H+ze4pCr4EyrxG2OKd1SofLunZ1RL
 q16d6yNNYd/2I8ZnlSv0npLFFNRZbrF4=
X-Google-Smtp-Source: AGHT+IFOir2jlRCYq+4jQAFVynIHxbV3Q5wfSKNZmfIukaOjx71WtLQhcCvTRe1//o8nL36fRMkkUINcUibtcVud/Yg=
X-Received: by 2002:a17:906:5a56:b0:aa5:50b6:a612 with SMTP id
 a640c23a62f3a-aa581093a27mr15941966b.61.1732651477830; Tue, 26 Nov 2024
 12:04:37 -0800 (PST)
MIME-Version: 1.0
References: <20241125204456.1525752-1-sjg@chromium.org>
 <20241125204456.1525752-6-sjg@chromium.org>
 <d415c887-bb0c-47e8-bfd4-d0049f596367@gmx.de>
 <CAFLszTiOp56JkV1u5qOdJUYH2vJ5YHWwpBUmhb8WWiNs2S0B+w@mail.gmail.com>
 <20241126155508.GR3600562@bill-the-cat>
In-Reply-To: <20241126155508.GR3600562@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 26 Nov 2024 13:04:25 -0700
Message-ID: <CAFLszThjgZtYrc707w8D+PZULJQB8qpNxgDYnAV+UoNebaPm8g@mail.gmail.com>
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

On Tue, 26 Nov 2024 at 08:55, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Nov 26, 2024 at 08:37:33AM -0700, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Tue, 26 Nov 2024 at 02:35, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 25.11.24 21:44, Simon Glass wrote:
> > > > Exported functions should be documented in the header file, not the
> > > > implementation. We tend to make such updates on a piecemeal basis to
> > > > avoid a 'flag day'. Move some comments related to memory allocation to
> > > > follow the convention.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > Please, have a look at this line in doc/
> > >
> > > doc/api/efi.rst:78:
> > > .. kernel-doc:: lib/efi_loader/efi_memory.c
> >
> > Hmm, we should not add C files as then we end up with all sorts of
> > internal functions, like checksum(). The help is a bit of a mess on
> > that page IMO and it could use an index at the top or side.
>
> Why? Looking at the linux kernel (where we borrow this framework from
> and lots of developers expect to follow that style) it's extremely
> common to kernel-doc C files. I don't see why documenting internal
> functions (which should be clear as being internal) is a problem.

It depends what you mean by docs. U-Boot puts the documentation for
exported functions in header files.

Putting docs in C files clutters the docs with internal
implementations, when most people just want to see the API. The way
U-Boot does things, it is easy to see the internal (implementation)
docs by looking at the C code and the external functions by looking at
the header files.

Regards,
Simon
