Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B486BC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 16 Jul 2024 06:25:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C121288602;
	Tue, 16 Jul 2024 08:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PCewp2gX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1EB488602; Tue, 16 Jul 2024 08:25:25 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C6E788385
 for <u-boot@lists.denx.de>; Tue, 16 Jul 2024 08:25:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-58b966b41fbso6405766a12.1
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 23:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721111123; x=1721715923; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v9cO3x/UGSpFysEJPPfLY6+0nH0UGTS3thAs93+Hy5I=;
 b=PCewp2gXdqp7ENEfTYocCL7pc8oRgihg+goOS1JBNjnFnPfoSuoVOH7zcuzBZcIgUj
 E8Z5/Yqth2kyDjmhsPgXJirg4vcqbhYhH1PPT00umcqnwFSNqwf8ZW6RLSLg2dSdr2U1
 eRy1IXqZFFxxW03mCq4yA0Y58U7kGMzI154c8vQuBOW3f0sO7WHFSLm5r4O9/aGy9IEP
 NgUxXENiab44Uo1pvJEwRM7LlOj8q7tJtbk+MdQCcIIYUE6pNNArmGRUsJEMXXkqdylY
 Jcyx9+ayDK/OfVdrM6U3T0xRbQnOiUc0dczOCVtM4LTtv0VOesNTOTH8j2VJkh3CisRI
 3Kdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721111123; x=1721715923;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v9cO3x/UGSpFysEJPPfLY6+0nH0UGTS3thAs93+Hy5I=;
 b=pUgX3buMAxvAxs2avS3yNEkwewy999XtU3kcJVNSLpxbDwnDSWWglKVyoWa5N60taJ
 P9Dw4K9SpdgZRlJkINAab34lWnGARpfCGEsYv55EoY5Rn67OKl8Li5ZDgR0oB1yEPqmA
 T+sTh87UciWRndtNv8aUnZeAF17yit+HX9y0zHi9DSI5rSt93HnEfl1fUMoxwyerrI1A
 d9n0uSfYbH349WCV9W9VFKzHo/0cPQn/gotCFaTlUsqpJYw8TL7KUnrg1E3Q49z9QaKF
 LKte9uDohZeJ+kt9uPd6JNFveywt6SqhHfipnzZP2Eexh0iuvEaTK4acN0eNPoerfP5/
 jMWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVUSb/ZpVllpvwsx1j4faaanbLL9UpiQncvOc0pifzXUUBmqOncVBp/y0tJ8wJF94OPyXlwyZJhFT0bJdzQNkTV5+oHuA==
X-Gm-Message-State: AOJu0YyWtsShGXSjbL4VVCHrY1QFTesDR/Xi1/ygxGDsLHNz08Ls6wq5
 6cvam7Q5Nk8fVuGVyRtWkaN0yhrF44Q2duVw+WJ7+QfDLTdL3e9Qfx9pZTMG8mLxjsiseaeVWl0
 syOCv7vRWfghxL2gAYnvfeNzkOxiyqodzp3jXZg==
X-Google-Smtp-Source: AGHT+IHVbcGi1x2l78Xsaqw+CikvejQVPXyPlZFKVLOm1OwpQ9P5dZuTjjkMrkTNFqhc60o5Tn+615gOTqK64k3HKdU=
X-Received: by 2002:a50:9512:0:b0:57c:78fb:1a32 with SMTP id
 4fb4d7f45d1cf-59eef14c864mr563846a12.19.1721111122684; Mon, 15 Jul 2024
 23:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240704073544.670249-42-sughosh.ganu@linaro.org>
 <CAFLszTiXtfFh3K8Ft1nTzBizSitk_dyK7n0BsRccNNe6TimFoQ@mail.gmail.com>
 <CADg8p97fwAvebfrANXwWc7At78wU59XXymTFWCvuaFHMGj+9zg@mail.gmail.com>
 <CAFLszTiAHSgkGjV6PWOu2nisKc678rpxBvQKuOZeisqCmeAXSA@mail.gmail.com>
 <20240715190534.GA561963@bill-the-cat>
In-Reply-To: <20240715190534.GA561963@bill-the-cat>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Tue, 16 Jul 2024 11:55:10 +0530
Message-ID: <CADg8p972kWS9DY_xmNm2uBAz5-y_LtSy0dq2eRTf5dJMCranCw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 41/48] efi_memory: add an event handler to update
 memory map
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

On Tue, 16 Jul 2024 at 00:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Jul 15, 2024 at 12:39:32PM +0100, Simon Glass wrote:
> > Hi Sughosh,
> >
> > On Mon, 15 Jul 2024 at 10:39, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > hi Simon,
> > >
> > > On Sat, 13 Jul 2024 at 20:46, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Thu, 4 Jul 2024 at 08:38, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > There are events that would be used to notify other interested modules
> > > > > of any changes in available and occupied memory. This would happen
> > > > > when a module allocates or reserves memory, or frees up memory. These
> > > > > changes in memory map should be notified to other interested modules
> > > > > so that the allocated memory does not get overwritten. Add an event
> > > > > handler in the EFI memory module to update the EFI memory map
> > > > > accordingly when such changes happen. As a consequence, any subsequent
> > > > > memory request would honour the updated memory map and only available
> > > > > memory would be allocated from.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since V1:
> > > > > * Handle the addition of memory to the LMB memory map.
> > > > > * Pass the overlap_only_ram parameter to the efi_add_memory_map_pg()
> > > > >   based on the type of operation.
> > > > >
> > > > >  lib/efi_loader/Kconfig      |  1 +
> > > > >  lib/efi_loader/efi_memory.c | 34 ++++++++++++++++++++++++++++++++++
> > > > >  2 files changed, 35 insertions(+)
> > > > >
> > > >
> > > > This is getting complicated and I don't believe it is needed.
> > > >
> > > > EFI should not be allocating memory 'in free space' until it starts
> > > > up. For the very few (if any) cases where it does, it can do an lmb
> > > > allocation.
> > >
> > > EFI memory module is not allocating memory at all now. This patch is
> > > adding an event handler for updating the EFI memory map, whenever the
> > > LMB memory map changes. All the EFI allocations are now being routed
> > > through the LMB API's.
> >
> > OK
> >
> > >
> > > >
> > > > As to the lmb allocations themselves, EFI can simply call look through
> > > > the lmb list and call efi_add_memory_map_pg() for each entry, when it
> > > > is ready to boot. There is no need to do it earlier.
> > >
> > > So in this case, I believe that rather than adding code in multiple
> > > places where the EFI memory module would have to get the LMB map and
> > > then update it's own, I think it is easier to update the EFI memory
> > > map as and when the LMB map gets updated. Else, we have a scenario
> > > where the EFI memory map would have to be updated as part of the EFI
> > > memory map dump function, as well as before the EFI boot. Any new code
> > > that would be subsequently introduced that might have a similar
> > > requirement would then be needed to keep this point in mind(to get the
> > > memory map from LMB).
> >
> > That doesn't hold water in my eyes. I actually like the idea of the
> > EFI memory map being set up before booting. It should be done in a
> > single function called from one place, just before booting. Well, I
> > suppose it could be called from the memory-map-dump function too. But
> > it should be pretty simple...just add some pre-defined things and then
> > add the lmb records. You can even write a unit test for it.
> >
> > >
> > > This is not an OS file-system kind of an operation where performance
> > > is critical, nor is this event(LMB memory map update) going to happen
> > > very frequently. So I believe that it would be better to keep the EFI
> > > memory map updated along with the LMB one.
> >
> > I really don't like that idea at all. One table is enough for use by
> > U-Boot. The EFI one is needed for booting. Keeping them in sync as
> > U-Boot is running is not necessary, just invites bugs and makes the
> > whole thing harder to test.
>
> Doesn't that ignore the issue of EFI being re-entrant to us? Or no,
> because you're suggesting we only update the EFI map before entering the
> EFI loader, not strictly "booting the OS"? In which case, maybe that
> does end up being both cleaner and smaller? I'm not sure.

And that is my concern here about having to update the EFI map at
multiple call points, instead of keeping it updated -- I feel this is
more prone to being buggy. And to add to this, there might be code
paths added subsequently which might need an updated EFI map where
this gets missed. The only downside to the current design is that it
might be slower since the EFI map gets updated on every change to the
LMB map. But I am not sure if the LMB map changes are going to be that
frequent.

-sughosh

>
> --
> Tom
