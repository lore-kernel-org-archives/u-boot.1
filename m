Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA07BEC875B
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 21:01:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E328E86998;
	Thu,  7 Sep 2023 23:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KLVo+Uhm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40B29869D6; Thu,  7 Sep 2023 23:01:28 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA9C867F6
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 23:01:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so1937977a12.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 14:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694120485; x=1694725285; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J9DmIBq/OdG3Jl1nHB5ocAvNmXSrRtHC5mOjtsQOX1w=;
 b=KLVo+UhmG3fwXSkE5QfKyMpQi9e5y3dRxRWnRFkMqav6ZwTn70NSvvV3e6lC0dJlXI
 ifL7FFLK6UppWjnQv5exxnlbAwqu3dB5ziVYK5AAx2HLfxkQjbCzQdfLHD9RKdTkFY9V
 KOhCBN84lx2ngGvLbJq11SFkg8/wFjSsejVlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694120485; x=1694725285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9DmIBq/OdG3Jl1nHB5ocAvNmXSrRtHC5mOjtsQOX1w=;
 b=i4uO1bHYzTC2kUtfqUEYvjW+x9tWgdkFzlVMN6yMOhLVIR5tkKL/2Yxfq9/iYw0KCr
 WmKFFykw9/8fzsIsvyUW6NV7Hjp0BxnHKXOI5ZW01wXahRPdbVfL9FQVeBd8lFusZJRS
 X4lFp2A8v+Lwr6Ms8WDi30Wp1/gnxjlUgPh5r/M7sCHQT7XOEyYuM6cOTU+724fN0Fuh
 b/QHUgcWQ67qLWtWTLKFGEFNvY2jctpCxKi/paszNzoa29ZT/1Rp/DXPW/O4x+vNGNhP
 d9A8410uMpULr8SNzqpqMsYARMG4kGul1IPkawoALl8cUl5LyGV/+9luhEu3bxcewZkv
 G8ZQ==
X-Gm-Message-State: AOJu0YwCLAwUBK0Px7GklY+euFGG4pxcpr9ugXxE2HYL+q+BCAFylzmW
 lOr0FqsK2A7DDKv7xlvIl2atGPfzeZZsjgGjOF1L0A==
X-Google-Smtp-Source: AGHT+IHWY/pYItwnZgHl3Olu/RaNX2fguk91tA1Hyb9ME1XE/aJ4RwUKMiV1ggBCBrcxsIeDAfheL7ZeUyJoepIz39w=
X-Received: by 2002:a17:906:51c2:b0:9a5:b8ca:9b76 with SMTP id
 v2-20020a17090651c200b009a5b8ca9b76mr375997ejk.72.1694120484740; Thu, 07 Sep
 2023 14:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230823134209.1450567-1-sjg@chromium.org>
 <20230823134209.1450567-8-sjg@chromium.org>
 <20230823151400.GK3953269@bill-the-cat>
 <CAPnjgZ1VBpE8S7G-eBfAeRNQ6PgNvONbGyLceDYL0JsoNnYMjQ@mail.gmail.com>
 <20230903164244.GY3101304@bill-the-cat>
 <CAPnjgZ3WbCoxx-GGcf-fXA9iU6pzyr7BJGZD5tRvG0+tZ6Frdg@mail.gmail.com>
 <20230903192522.GZ3101304@bill-the-cat>
 <CAPnjgZ3c45YBFoX+by0aybgHnzmEqzrFvv90oeW6cyiLdrwAkw@mail.gmail.com>
 <20230906175755.GI305624@bill-the-cat>
 <CAPnjgZ3LAtZ4V7hwwnBzHBu8=HBroQzTb1XuHV-7aBrkrxS6yg@mail.gmail.com>
 <20230907194047.GZ305624@bill-the-cat>
In-Reply-To: <20230907194047.GZ305624@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 15:01:06 -0600
Message-ID: <CAPnjgZ1=_ufxMCQOCQRzV4ooYP4eR96BNYr8RX8fVb-DV-xSPg@mail.gmail.com>
Subject: Re: [PATCH 7/7] fs: Fix a confusing error about overlapping regions
To: Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Sjoerd Simons <sjoerd@collabora.com>
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

On Thu, 7 Sept 2023 at 13:40, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Sep 07, 2023 at 06:23:06AM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 6 Sept 2023 at 11:58, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Sep 05, 2023 at 12:16:56PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Sun, 3 Sept 2023 at 13:25, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sun, Sep 03, 2023 at 12:06:13PM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Sun, 3 Sept 2023 at 10:42, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Thu, Aug 31, 2023 at 06:15:19PM -0600, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Wed, 23 Aug 2023 at 09:14, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Wed, Aug 23, 2023 at 07:42:03AM -0600, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > When lmb runs out of space in its internal tables, it gives
> > > > errors on
> > > > > > > > > > every fs load operation. This is horribly confusing, as the
> > > > poor user
> > > > > > > > > > tries different memory regions one at a time.
> > > > > > > > > >
> > > > > > > > > > Use the updated API to check the error code and print a helpful
> > > > message.
> > > > > > > > > > Also, allow the operation to proceed.
> > > > > > > > > >
> > > > > > > > > > Update the tests accordingly.
> > > > > > > > > >
> > > > > > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > [snip]
> > > > > > > > > > +     if (ret == -E2BIG) {
> > > > > > > > > > +             log_warning("Reservation tables exhausted: see
> > > > CONFIG_LMB_USE_MAX_REGIONS\n");
> > > > > > > > > > +             return 0;
> > > > > > > > > > +     }
> > > > > > > > >
> > > > > > > > > This isn't the right option.  Everyone has
> > > > CONFIG_LMB_USE_MAX_REGIONS
> > > > > > > > > set.  You would want to increase CONFIG_LMB_MAX_REGIONS.
> > > > > > > > >
> > > > > > > > > But it sounds like what you've found and fixed is an underlying
> > > > problem
> > > > > > > > > as to why 16 regions isn't enough in some common cases now?  So
> > > > we could
> > > > > > > >
> > > > > > > > I don't think I have fixed anything. But I'll send v2 and perhaps it
> > > > > > > > will be clearer what is going on here.
> > > > > > > >
> > > > > > > > > possibly avoid the string size growth here and have a comment
> > > > that also
> > > > > > > > > matches up with the help under LMB_MAX_REGIONS?
> > > > > > > >
> > > > > > > > I don't know, sorry. The size of struct(lmb) on 64-bit sandbox is
> > > > > > > > about 400 bytes. There seems to be a lot of code to save not much
> > > > > > > > memory.
> > > > > > >
> > > > > > > What do you mean here?  The alternative is not unlimited ranges but
> > > > > > > instead to define the limit of memory regions and limit of reserved
> > > > > > > ranges.
> > > > > >
> > > > > > A better alternative would be not to limit the number of regions, IMO,
> > > > > > i.e. have an array of regions that can grow as needed.
> > > > >
> > > > > That's not something that we have in the code today, however.
> > > >
> > > > No, I do have an arraylist thing that I plan to upstream, which could
> > > > handle that.
> > > >
> > > > But for this series, what do you think of the memregion idea? I am still
> > > > unsure of the saming we should use - see Heinrich's comments too.
> > >
> > > My biggest worry here is that we're papering over a real issue, and
> > > should either dig at that and see what's going on (should something be
> > > coalescing adjacent allocations? Were many platforms just right at the
> > > previous limit?) or just bump the default from 16 to "64 if EFI_LOADER"
> > > and then see if anything else really needs tweaking / cleaning up in the
> > > code itself.  I know Heinrich has previously said the LMB system could
> > > be better (or something to that effect, I'm going from memory, sorry if
> > > I'm mis-stating things) and I don't object to replacing what we have
> > > with something more robust/smarter/etc.
> >
> > I am not sure...my series was designed to rename the code to reduce
> > confusion, and print a useful message when we run out of regions. It
> > does not paper over the problem, but actually makes it more visible.
>
> Well, "papering over" maybe wasn't the best choice of words on my part.
> But since the series of events was something like:
> - We nee to use LMB to cover my U-Boot regions to address a handful of
>   CVEs over arbitrarily overwriting U-Boot at run-time.
>   - AFAICT no platforms suddenly ran out of LMB reservation space, but
>     maybe I'm wrong?
> - Someone noted that the EFI subsystem was exposing the same kind of
>   issue.
> - Heinrich adds logic for EFI_LOADER (iirc) to also add allocations
>   there to LMB
> - Assorted platforms start changing the max allocation to 64 to fix the
>   problems that get reported sometimes by booting.
> - Heinrich notes that our memory reservation system (LMB) could be
>   better designed than it is today.
>   - And, iirc, EFI_LOADER or similar has something maybe we can
>     leverage?
>
> Which brings me to what I was trying to say.  I'm not sure it's worth
> cleaning up the code a little, or refactoring/renaming things within it
> without both:
> - Understanding why EFI_LOADER being enabled causes us to run out of
>   allocations and so if the answer is "increase the default" OR "fix
>   some underlying issue such as coalescing being too strict or broken".
> - Understanding if there's a better memory reservation system we can use
>   instead.

Perhaps Heinrich has some thoughts on that and/or the memregion
question. EFI loves memory regions so perhaps it needs more?

But it should report a useful error, not the silly one it shows today.

Regards,
Simon
