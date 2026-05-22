Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4537CD5BAF
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 05:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0576F8469F;
	Fri, 22 May 2026 07:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="sPGby1Wt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFC97848C5; Fri, 22 May 2026 05:07:37 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A90E5846CA
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 05:07:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aristo.chen@canonical.com
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 4432A3FBDA
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 03:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1779419255;
 bh=mVDX1FFTZNbdqQkoIFAHGSmCFeI7KQ41qMdsHsTIJXQ=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=sPGby1WtXkqhkcsgSwNTwyBF3BKs2sKKmibrfZ29eXgLZ2t18bT7E4AR6HWW2sh62
 GlGO0g4HNnVyJButBoFL/dvkXUSZfjjKg7H2obfHrm144Lq9YjpD0C7W4ernB6OVTA
 nDPhnHs7JvRu26AzUjqTMej2xZeNKcU5MNLHfsIYsD5VoTrw2QBxSWptmhwMFTkNDj
 55gj/cxAQlaYuCBBSQv1J+OEec9RSU5s/BriXb8wRci+1a/WKDH170GL18N/GNf/yR
 MzLqjN+nGGC8vuiN03FfHPv3RLcNgYGkZrHtPSkkwrXqGM3Kr0L2C9gz59XAHzdyfQ
 HBocao1R1MlkI5x26r6oChacA63Yn7f2ut1oUGY/7rv/XnOJNwbpjoOwzj5fPc4Bw/
 PwMU7Zo1dqLx/rkceiQUvnZgZ7nBqsrydmIiEfEEFDu0nBm8E7GBmFfjTxiYlbgivR
 LWrgIJJKeDD1wXblue5dEhB0gxE6CF16TOwoZgbZ1EwzGHHmGgRfplkBxpGbtF92ns
 jhup3QHPVheAzJHsTgas7KaaQrN/x4BadP6aPX4lXnlrQo/i9ie6B2YNgwiQHiC/sj
 PATOeYx25nNtHTvThnRxm3nL27RpkvDvvAQBMc0Jz/rQ7LlDGrMibKAt+AxBLRfLvs
 F9yNhURRi4nOzGu4Kd6blj8A=
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-6870dd95156so2976794a12.1
 for <u-boot@lists.denx.de>; Thu, 21 May 2026 20:07:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779419255; cv=none;
 d=google.com; s=arc-20240605;
 b=cwCuKOTkCZIPUmjC7TIuFc8dOUfbSBt9a43IfF+QVSDteOnORN4zF+5gCrSOaXUtCT
 /ib49dVRgk43WbUNDfB8nlC3+X+lcSHb9nTuhNNbCEWMaqCzOSFPk4zQAZorzs/naFiE
 2CqE89qXXRLJe9JAa7Oe15m7bp2DF1GkpyKY5UKt4i2woYTt1DS+Ui48VN5P8PoTzasu
 G+OWQ3oFRGdKnLmnp9Dku3vdXi7h14UnEBBD6D8gdYFYTJKOiWcsUWZoFKN7LZbYP0DC
 oufFT3wxwfevnx91y7dqsBoouAsVLDofYv8gx05QHHRlWTcdbGan8scCtI19/FHV5GLI
 TnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=mVDX1FFTZNbdqQkoIFAHGSmCFeI7KQ41qMdsHsTIJXQ=;
 fh=E+TNGanFLn1rfaZk0mwORohO1WXxb5JZU5coc0E9leM=;
 b=lVUeWR88uaqrYAi1Id6EnKoscZEVxvZM9Yy92eF1Bl9FLIcE8TfQ6ydfknr1qcjy45
 7apaVSUiVv7OepyB75j4BflPNlJ88z8PNEODsALmyZHpwSpODi/JCjpAWFRwlG5bLY4p
 2GdHeZbCUAXoyedLLz5E6JKYP8Y0Uj6fqAwCaNV8Vc/6Mye6DskL1Lo1BLIAoRExLGtH
 7y4x2p237yFj6hE/UpO/+je0EZazeSFoRIMxCKRo1MlVfv0LS2pjTN3F1knMCrD6F6tu
 p0T2wkXycvXi8h7+kPfdtidtj+N7wOdcSIdwO6SyfirXk0KBK81mWP4Gv8fx5D/wQspl
 XdgA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779419255; x=1780024055;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mVDX1FFTZNbdqQkoIFAHGSmCFeI7KQ41qMdsHsTIJXQ=;
 b=raUPtGLA6Kjucz5Kc3xSFju/jzPPeMZkv3mHfx7XS6Kos4UfkyXaFCgMXvbyR7HPzY
 MxdYNTOye0dWbMcJygGYQy+WYYFbAwrbbROimbDBcdLydqmDdEuCTewrad3DQtCGppKG
 X881bWsAo7HfiH4Yi0LftGijI71QnExYxofpw9Mgap/QosDMcMdZyuNrPhPs6WJeN3wc
 NLaXt1jIW2fvXHLKo4faG58Q0ugZetqvk8tGSpuB32iBgf6KCf80xmf75oQXRV/9eFxt
 nhPKS7441UtYnMGetsXggvy3/XtuZIH5grMTGXOvsFA2Bu7fBad4lERWXY0SSy8FqNSt
 yFSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8sa7M98o74pFQEFZdhv9UAtL0+Zvgin7G3F+wsj4TQ07gp6UhATOW95B55UAcILUHeEkq7YVk=@lists.denx.de
X-Gm-Message-State: AOJu0YxATqK9CIzUBTp6i3MdPKcDD4WTa4L2Z5s0UzMKfOiOo4kUFCAg
 nm/vvZuCnDXl1z83JEdDPxMYUQptcsuEz5CABsKynL+GMM2BuGRZ/KCYekJ6KNsludLCCd+B7Qj
 epJbPk9EbWtU52/rC1zRlgzqk1XUvdrHt4vtk6QK2FrzLW6BEfC0H/uASODXbjMqXIMIfKSqF2F
 d32AR3F/6AqHDmA5dMsgekyo6t6ORgrARURT4i2i/Rp4qeWg==
X-Gm-Gg: Acq92OFNFq2WM8l20yh9VV81PAcQm6gonf6Y5bIvPrC+UmZTTvVNZwSLgy9ZMkp61yp
 upzdIKNDWLiDm1uz8+ML+cNCkA60yrWvwdkCo7A57aN8MnB2sZKWGpB9Fde5IxKiSJipUE24kwb
 GPTMgOni2jtTbQBlUjzLnC7KRambUFOlWj2SELM7aD8jb4bLAnAbXN38/kqqTi8PNdg4N5xKtFG
 K4xNVU=
X-Received: by 2002:a05:6402:11d3:b0:680:c7b7:25bf with SMTP id
 4fb4d7f45d1cf-6889c43c3d9mr736809a12.6.1779419254835; 
 Thu, 21 May 2026 20:07:34 -0700 (PDT)
X-Received: by 2002:a05:6402:11d3:b0:680:c7b7:25bf with SMTP id
 4fb4d7f45d1cf-6889c43c3d9mr736801a12.6.1779419254512; Thu, 21 May 2026
 20:07:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260521023503.29315-1-aristo.chen@canonical.com>
 <cf2f988c-e12e-4dd3-b80e-b58f846a8d71@mailbox.org>
 <b1206a04-9800-4323-bf4a-cb8a14f15f8c@cherry.de>
 <57eda5e0-e82d-43a0-af31-bf2db62eae56@mailbox.org>
In-Reply-To: <57eda5e0-e82d-43a0-af31-bf2db62eae56@mailbox.org>
From: Aristo Chen <aristo.chen@canonical.com>
Date: Fri, 22 May 2026 11:07:23 +0800
X-Gm-Features: AVHnY4ItZdMls-PDQhkUIy7vNhe8D5ofkWufrxhjSgNPcTsAluGoe3d4xqiw2jo
Message-ID: <CAA=k7=kZ7rV6XDwaAZ7-JiseCJZia+3yLzJGr3_TdvrfkLHQ6Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] tools: mkimage: fix get_basename crash on paths
 with dotted directories
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Rasmus Villemoes <ravi@prevas.dk>, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 22 May 2026 07:02:43 +0200
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

On Fri, May 22, 2026 at 12:17=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.o=
rg> wrote:
>
> On 5/21/26 6:12 PM, Quentin Schulz wrote:
>
> Hello Quentin,
>
> >>> +    p =3D strrchr(start, '.');
> >>> +    end =3D p ? p : start + strlen(start);
> >>>       len =3D end - start;
> >>>       if (len >=3D size)
> >>>           len =3D size - 1;
> >>
> >> Why not call basename(3) directly in here ? Why reimplement it ?
> >
> > """
> > Warning: there are two different functions basename() - see below.
> >
> > [...]
> >
> > Notes
> >
> > There are two different versions of basename() - the POSIX version
> > described above, and the GNU version, which one gets after
> >
> >      #define _GNU_SOURCE         /* See feature_test_macros(7) */
> >      #include <string.h>
> >
> > The GNU version never modifies its argument, and returns the empty
> > string when path has a trailing slash, and in particular also when it i=
s
> > "/". There is no GNU version of dirname().
> >
> > With glibc, one gets the POSIX version of basename() when <libgen.h> is
> > included, and the GNU version otherwise.
> >
> > Bugs
> >
> > In the glibc implementation of the POSIX versions of these functions
> > they modify their argument, and segfault when called with a static
> > string like "/usr/". Before glibc 2.2.1, the glibc version of dirname()
> > did not correctly handle pathnames with trailing '/' characters, and
> > generated a segfault if given a NULL argument.
> > """
> >
> > Not very reassuring, tbh.
>
> Writing our own variant with its own set of bugs is worse than using a
> common implementation which has the bugs removed over time due to effort
> of the various users.
>
> If basename(3) is not an option, is there another common alternative ?

I agree with the principle, but IMO get_basename() is not really a
reimplementation of basename(3). It does two things, and basename(3)
covers only one of them.

get_basename() strips the directory and the extension. Per its own comment:

"arch/arm/dts/sun7i-a20-bananapro.dtb"
becomes "sun7i-a20-bananapro"

basename(3) on that path returns "sun7i-a20-bananapro.dtb"; the
extension stays on. So basename(3) would replace only the directory
half, the strrchr('/') scan. The extension half, the strrchr('.') scan
that this crash actually came from, still has to be done by hand.

There is no libc one-shot for "basename without the extension".
U-Boot's own host tooling reflects that: binman does it in two steps
wherever it needs a stem, for example in tools/binman/control.py:

os.path.splitext(os.path.basename(item))[0]
basename() followed by splitext(), because no single call does both.

basename(3) also carries the two-version problem Quentin already
quoted. For mkimage specifically: tools/Makefile builds every host
tool with -D_GNU_SOURCE, and fit_image.c includes <string.h> but not
<libgen.h>. That combination resolves to the GNU basename(), the
const-safe one that leaves its argument alone. But the selection is
implicit: if anyone later adds #include <libgen.h> to this file,
basename() silently becomes the POSIX version that modifies its
argument and segfaults on string literals. That is a sharper footgun
than the small hand-rolled helper, and it would sit in the very
function we are trying to make safe.

So my preference is to keep get_basename() hand-rolled. This patch is
not new logic; it only bounds the existing strrchr('.') scan to the
part after the last '/', which is the minimal fix for the
negative-length crash.

If you would still rather use basename(3), the least fragile form is
GNU basename() for the leaf, then strrchr('.') on that leaf to drop
the extension, with a comment pinning the GNU-version dependency so
nobody includes <libgen.h> later. Either way I will send a v2 (there
are review comments on patch 2/2 to address as well), so just let me
know which direction you prefer for get_basename() and I will include
it there.

Thanks,
Aristo
