Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAEACDB465
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 02:40:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B564686C0B;
	Thu, 12 Oct 2023 04:40:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="n3B6INfq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEC7286C78; Thu, 12 Oct 2023 04:40:45 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D26EA86B0A
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 04:40:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9b275afb6abso349589966b.1
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 19:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697078443; x=1697683243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ckNIVMVnqs8Nx5aDZfh0Rk+BGDnMRDmy4u+wn+D/k8M=;
 b=n3B6INfq9TH1Z8Lgws6Bj9TLQaRnezGktLI0n2zkgP0LrmsD12lslnLK0RCmlsXckL
 ppLsz9Q6DWC4iQkk/KNmJLCKOGZmHboHg8Dr+VOPtC+F2fZ4L8FeNLT6gP8twUnhReEw
 rMsKSrsA6+TuYVCf0zc27O25DJ6QL9nzSXUdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697078443; x=1697683243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ckNIVMVnqs8Nx5aDZfh0Rk+BGDnMRDmy4u+wn+D/k8M=;
 b=fw4Xu+tRAhgLqg3m/m1tlna97mZh8SnDqCkuUcHN5Lf9hogxpDCSNCVDyxOg3S2ZZ6
 mKazjj1wQh8phD7fRD/gKZHJXzwEE1hx/1ks6cLpsSqtQ8npzBWY9mcrR5K9BerYSm+g
 WNfR/3UwybZphK5pAACCI8E+EkCXE3OvCuwThJTTeiLNYyb9odPsjVgIiG4Yyk8/dYki
 TqFstBIzVDkx9tufOkCOpIl5m2c11xiO+OdTyKA08RYq9KWZzfDLbz1pWfDE6ZwEQbCX
 PLrfEpE28AO67XsXgVmjiIG842cGV7xx9DoaE7M0x+6CM643VdFnqbrkVKRtq3EZsEMt
 f7bQ==
X-Gm-Message-State: AOJu0YyTSLWJrrTKrrLCZS0208zefJC004vJEVt1f2QnnUFpdNG2yErf
 Kr2IhXa076lakxtLvaaQWfY2H6aSbU6zSImPCgEhqq09RYZ7E7MbN9w=
X-Google-Smtp-Source: AGHT+IHZtOYrcxYdFXmjHnelFXWv5qwxAm5vpMuUwgpOrcYZOY+dsGS594EYnzWKgwBJ3QcZog4EWEYMLYfk4UmzlUs=
X-Received: by 2002:a17:906:af10:b0:9ad:8a9e:23ee with SMTP id
 lx16-20020a170906af1000b009ad8a9e23eemr16333694ejb.13.1697078443156; Wed, 11
 Oct 2023 19:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230928080257.2650461-1-rasmus.villemoes@prevas.dk>
 <20231011183722.GT3119521@bill-the-cat>
 <5801c81b-8bfa-6e65-6176-f94299520a62@prevas.dk>
 <20231011193325.GJ3119521@bill-the-cat>
In-Reply-To: <20231011193325.GJ3119521@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 19:40:31 -0700
Message-ID: <CAPnjgZ0kCyi4ApVFs+ovP2RBiLQet0+ee+hdQ23vLcDK-wgZyQ@mail.gmail.com>
Subject: Re: [PATCH 5/4] mkimage: update man page and -h output
To: Tom Rini <trini@konsulko.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Sean Anderson <seanga2@gmail.com>
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

On Wed, 11 Oct 2023 at 12:33, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Oct 11, 2023 at 09:07:11PM +0200, Rasmus Villemoes wrote:
> > On 11/10/2023 20.37, Tom Rini wrote:
> > > On Thu, Sep 28, 2023 at 10:02:57AM +0200, Rasmus Villemoes wrote:
> > >
> > >> The man page correctly said that -B was ignored without -E, while the
> > >> `mkimage -h` output suggested otherwise. Now that -B can actually be
> > >> used by itself, update the man page.
> > >>
> > >> While at it, also amend the `mkimage -h` line to mention the
> > >> connection with -E.
> > >>
> > >> The FDT header is a fixed 40 bytes, so its size cannot (and is not)
> > >> modified, while its alignment is a property of the address in RAM one
> > >> loads the FIT to, so not something mkimage can affect in any way. (In
> > >> the file itself, the header is of course at offset 0, which has all
> > >> possible alignments already.)
> > >>
> > >> Reported-by: Sean Anderson <seanga2@gmail.com>
> > >> Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> > >> Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Applied to u-boot/master, thanks!
> > >
> >
> > Thanks, but I'm afraid that was premature.
> >
> > The original series which this was a fixup/followup for hasn't been
> > applied, and Sean had reservations. I'm leaving it to Simon or Tom or
> > whoever has final say to decide if they should eventually go in, but it
> > would probably be good to get a verdict soonish (it really shouldn't be
> > too controversial), and if it's a no, this should just be reverted.
>
> Ugh, thanks.  I'll push the revert with the next round of changes.

My intent was to apply it, but I haven't got to it yet.

Regards,
Simon
