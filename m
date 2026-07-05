Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B0F8C43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 10:42:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 456C7846F8;
	Sun,  5 Jul 2026 12:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gZcmW9T4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB92846FD; Sun,  5 Jul 2026 12:42:16 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBF0D846A4
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 12:42:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6986287534eso3433174a12.3
 for <u-boot@lists.denx.de>; Sun, 05 Jul 2026 03:42:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783248134; cv=none;
 d=google.com; s=arc-20260327;
 b=Wa0tz2vjLdE4sYPJtIABB+ngsTv+e5Fc2hIO3Wn6mnHnKThI8qCJRjFpjhAPM2g0iZ
 3taMsLAaa/fM2a/Xs8UyTVsIHwNOLB84vGClwFKpsTv+W+0ppJEg0icTH9Nwwp/kEKS3
 93AkJ+UXzQHjPqsz4xtuEgGae6ctS1OPpKSG52heOAXAg5Hb44Ie17cVudcIy6y9fJQs
 jdmfFxWkRfD6qhhmgpwCc4AMoxTiQcY2oR5gB5UGr7/K7MnvR6NrrEWYWm27hRI9QxGI
 Rhd/uKZSNdwut4eTDNEnCbMxQSyD37BBEJwASyBlNbOtwcIQQJn1hh4eOoVV8D/3hsXF
 +uYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Fn7XRx8RxB7vnICgPVTrXrAYlXvn81oGFSMmKmmX51c=;
 fh=yDxf5wgWmD6WtWAfkwUUamAI6LJSpO6ikX6p6/IOEfI=;
 b=VVqomRk/ZDjN6L2AwBpjJrydrgkwbV3JNhXahugp6jx92sPqCIjYE8MWVK/eUNhrlM
 tNTG2VPgOKBKrKF1fcfDwISrqfV42sCw2AKaDQKrj4lVNCP4iUDCqfCBMhzYU6ox07dy
 rO+ffKHhxH+LSUBd8hthOziZvaVf0WDcznR2rrauvS1TAwiolZqDR2B1Yq9xkVPv9H0n
 jIu64xR21In8lcHwjFoSZTmXwBsSqqEkaZodjDZGgrR7qvA8OfLMKVOoogB8SuxdIeJ0
 u9mmHW8cK8ez0F4yBypUt2b7DVd0U7ULLveajNKfR/kwXatJa0XBFtDvy6tHwhmo/bFY
 1RjA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783248134; x=1783852934; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Fn7XRx8RxB7vnICgPVTrXrAYlXvn81oGFSMmKmmX51c=;
 b=gZcmW9T4fhECMZ72Sr67aZhW4i/fwwWIdzDcSRhJzikQg7+gFiM55y7y9bYhU1rT/r
 tXvQnYVm+YL+Baoq/qeB+c1IDUQLxMdelf4WEqWybKCdM2G0LY57qSRcJ1gaIxQUiwH7
 jNdES4OtDl9X8k2slG1PH2xa4+zTGIcslsYAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783248134; x=1783852934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fn7XRx8RxB7vnICgPVTrXrAYlXvn81oGFSMmKmmX51c=;
 b=E4xNiA/5e3GU9/Hm8iZ9YTOoht6T5Kv3E1/7yGjIdRUynoc6RcwCa3x7C7+Ic2Nkqd
 Nr2dIw+e4q+yrocF2FyY0z51fgf5fOPbXrBorjGPBFaMNk6x4kl9VvkKnhoIRpOH3dYU
 93bzpl/cSAdozR6e5s7i8Ge6/lzrxWq2D2hqakQuuH3EjYwvzyKJilHdPLQpBaPo8AYk
 hWdHYhx+/Qu+VYOILsY2Osv684vRFIJqZ0DpzgZhPPee+UFrvHpVghP8nGoZ4f3Ww/Jx
 kli6EFr3u+BfjhVR/91oGiv8jjTrupXkVytKpDggag970Ud8dYy7Au/i6GO8hDJjXuny
 rXTg==
X-Gm-Message-State: AOJu0YxJEn6rTGkO3qoSOPLeWpHXI5t5PEKGBViBtfqrC/xU749RFK5w
 ypgI6gxtELMch3vUc+r7TW3j9cZ5fHZsOW2w2d0ONQdxKH+RV2h9H1jdcJSkPF7LvdZonitXejb
 djkScUQh7RJniex+Rvp3FtP2qq70zZjHV/AhpydBugr1mMgY0IHf+BQ==
X-Gm-Gg: AfdE7ckgbPgWKKvSBOB+dR+5lYNOWUgzBGNyKhyS1jnyA6WcQ4ZfM/c/JiQWjgJAkK5
 m0M8JJW2AROPI5fsM8+tnkWBSN3aeuJ9d0Tfjx+gyq55S3ic270ph1tRjHv9RszMX/x6REeDEbl
 bxCrmDPusaICJf5ciuF4EvbYK9GqpaH9Mqi19WSzDMCPA41kbf2WvkLIin7DIdcOhmXqPQ8TBXx
 AYnVRn6oAL4RBzKDt8aoTU2TqTP+qJLCR5vbhpuoQ1vMfHUjHGVQSm/52CfpRGE2R2YYHz9hcIC
 Kfj93w==
X-Received: by 2002:a05:6402:3509:b0:699:f957:d367 with SMTP id
 4fb4d7f45d1cf-69a1a26b3c8mr1817587a12.17.1783248134288; Sun, 05 Jul 2026
 03:42:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260616142444.48193-1-sjg@chromium.org>
 <20260616142444.48193-6-sjg@chromium.org>
 <ajJBmmhl1Gk9n4GP@black.igk.intel.com> <ajJCSRepiixmmgO0@black.igk.intel.com>
In-Reply-To: <ajJCSRepiixmmgO0@black.igk.intel.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 5 Jul 2026 04:42:01 -0600
X-Gm-Features: AVVi8CfkHg1fgQ0rnVVYaUO-qz0NxwtgB5Mt0ZLmsyfxqjU7qUnFitDIDcOTrdc
Message-ID: <CAFLszThV=iy_4yObmUv2GqPAL4g-urVjKX=9Md7_v7yxLNnm2g@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] doc: edison: Rewrite the update instructions
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

Hi Andy,

On Wed, 17 Jun 2026 at 00:44, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jun 17, 2026 at 08:41:30AM +0200, Andy Shevchenko wrote:
> > On Tue, Jun 16, 2026 at 08:24:20AM -0600, Simon Glass wrote:
> > > Split the two ways of getting U-Boot onto the board: a plain DFU
> > > transfer into u-boot0 when a working U-Boot is already present, and the
> > > xFSTK mask ROM recovery when it is not. Drop the steps that only applied
> > > to replacing the original 2014 U-Boot, document the 4KB alignment gap
> > > the mask ROM needs and which binman output to flash (rather than the
> > > bare u-boot.bin), note that a bricked board enters DnX without any
> > > straps, and add udev rules for running the tools without sudo.
>
> ...
>
> > > -1. Prepare u-boot.bin as described in chapter above. You still need one
> > > -   more step (if and only if you have original U-Boot), i.e. run the
> > > -   following command::
> > >
> > > -     $ truncate -s %4096 u-boot.bin
> >
> > Still missing this important detail. The DFU on v2014.04 is broken in a way
> > that it requires also the whole binary to be aligned by 4k. The above pads
> > the tail to full 4k (last block).
> >
> > Btw, now I realised that I haven't checked if this is inherited in your binman
> > case. Note, I haven't put that into the Makefile hack as I expected users to
> > do this once, but perhaps if somebody wants to start over (by flashing the last
> > official image), the file size needs to be aligned.
>
> TL;DR: Either we leave this in documentation, or we always have a bigger blob.
> However I don't remember how (current) upstream U-Boot DFU will react on the
> trailing garbage (nulls).

Sorry, a little tardy on this as I have been travelling. But it seems
to work OK for me. I'll send v3.

Regards,
Simon
