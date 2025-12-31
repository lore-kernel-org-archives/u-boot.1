Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5BEEE57D7
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 15:08:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF37584081;
	Wed, 31 Dec 2025 16:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l4EekF4p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86DA784097; Wed, 31 Dec 2025 16:08:19 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C9783F6D
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 16:08:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b7633027cb2so1973483266b.1
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 07:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767193696; x=1767798496; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tW6KWRSFI95PuuPG9egiXu+oyV+TJN3dGq8OI8zByzc=;
 b=l4EekF4poAaXJwGsr8UMmptBM6zwCI07EHjd1BBjgvw8Vzic3xhdbwg5ZhMGq7/XjZ
 LmFk9LaQ/Rf+tWLNr2nzaV/LMb/1kgD10OqRU6dJfnzB6WBBLfdm1HsL1uZJlHNPbsXr
 S2TwOEZa9nynZWtNF/EVojfbOJgUIrvxLKFhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767193696; x=1767798496;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tW6KWRSFI95PuuPG9egiXu+oyV+TJN3dGq8OI8zByzc=;
 b=BOFdo52WWGGjrbIZ/nTLS7J+ThMvDaxQediV/Qdg94L/Y1yyTbgiFpMlvLAQwzB8ft
 EaeDpvO64w96wNgZbEQONlzWErtHYVzjju4bHpU4iV7a5AuGUyQSrmQmtGgH7A/bt8ZN
 x6iWM/GvIB7GlSkcz0Kco+SEfBMtwYdL0d3uAd/rGm8E8xF2kH5z6EKNJr1bRCSy+QKK
 RBN+x7kDO5ItdVBjFGhlW4PATeXfHqlZy4RPEYmvKzoKqZiSGVINlzMBcmxZSw6qFs+/
 wrmCoRjxOEJ3YHr+cxFz5O9b9iLHrBf2rTap9DwJotuAEMpooM5A3rXA8E6T1l5lfHfd
 762Q==
X-Gm-Message-State: AOJu0YwMstmEdG1T3WU5LAWxnRQRi4zt3Dm8zsXqn9gmODPxJrT48BNy
 FXw98LagzJJCj14Wm3Pj08OqGVw9EV3VDb2Xx9vJxSbnqPmxHabG2dgfxOKSsw4X2ImB73bC6SV
 XFSMhcF7sPqC2tYWT4glGBIFV5wRemhcGufQq21Zl60JSnPPyzJ8=
X-Gm-Gg: AY/fxX605FYAPhkCuaRepNA+1+wI4AG0FJeFMHuyFmPC9tn3hHUp6cXe7b51bC6PyUy
 oGIwv/b+VtsZc8LsoO0I1B9EgCaI65Fc5cH+o3tM9nfiM1RIzIL6aGxgDGlspxdwcXQ4j3Dux/A
 KXq/GWkcyu29x06YKuP1mRllo3HPSUGeFWDcMoitSf57dBf4dSgoM3S0W8VnSrHCwPZFbJmeAky
 9+KQd8EJBF5evrpBXgNvNG+Db/HFHwycKAhy3V8IsEPjTnsCazLKpqR7KAA0Nu42Bgnbw==
X-Google-Smtp-Source: AGHT+IFM1kDEnz6ORuXSTpHdAnGJjcE522e80TY/hKYGaz8BE8IIz6rAziNrLTyqZhHsPrijnXV6fGqIQQhiTY9oGD8=
X-Received: by 2002:a17:907:2da0:b0:b73:5958:7e6c with SMTP id
 a640c23a62f3a-b8036f0add4mr4082776366b.3.1767193696258; Wed, 31 Dec 2025
 07:08:16 -0800 (PST)
MIME-Version: 1.0
References: <CA+DkFDbQr40f2V8eKD5cSECVTM6aZyeZNxbZMqT4SeQJjMu3fQ@mail.gmail.com>
 <20251216-left-mournful-0bdb19f7c060@thorsis.com>
 <CA+DkFDZAgjL3amMoLqSTQbbKngeBk0EMBTciBDDKrxV-UsP=fg@mail.gmail.com>
In-Reply-To: <CA+DkFDZAgjL3amMoLqSTQbbKngeBk0EMBTciBDDKrxV-UsP=fg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 31 Dec 2025 08:08:04 -0700
X-Gm-Features: AQt7F2rRtZJaeNHJLzmtjRYkTefR9ikzssiUweuxDjLf6BnzISJmWpVQ59ECRU8
Message-ID: <CAFLszThCnj+35+C1s3nFR0Rcofz7jTyymKyP9ofMTZMt2t4uWA@mail.gmail.com>
Subject: Re: Standard Boot integration - script validation before execution
To: Patryk <pbiel7@gmail.com>
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Patryk,

On Wed, 31 Dec 2025 at 07:46, Patryk <pbiel7@gmail.com> wrote:
>
> Hello,
>
> wt., 16 gru 2025 o 15:59 Alexander Dahl <ada@thorsis.com> napisa=C5=82(a)=
:
> > Reminds me on the problems I faced when trying to implement Secure
> > Boot with A/B rootfs.  IIRC there were two things I ended up doing:
> >
> > 1. putting the boot script in a separate volume outside of rootfs and
> > the A/B scheme.
> >
> > 2. use signed FIT image for the boot script instead of the old
> > fashioned U-Boot script, enable CONFIG_FIT_SIGNATURE, and disable (!)
> > CONFIG_LEGACY_IMAGE_FORMAT.
> >
> > Not sure how this plays together with standard boot, but once you
> > instruct U-Boot to only accept signed FIT images, that also applies
> > for scripts put into a FIT image.
> >
> > Greets
> > Alex
>
> As you suggested, I played a bit with the boot script and fit image
> and indeed it's possible to include bootscript only in the fit image
> thus verifying it using a verified boot mechanism. It can also be
> loaded by the bootmeth_script. That solves part of my problem. Thanks
> for that suggestion. I didn't know about it before. However this is
> only part of the problem I'm trying to solve as I said and would be
> grateful for other suggestions as well, but first I will outline what
> I actually want to achieve.
>
> I'm trying to implement firmware and software updates for my board,
> but have some problems on how to approach it.
> As a second stage bootloader (that gets loaded by the BootROM) I'm
> using BL2 from TF-A. Its purpose is to load FIP (Firmware Image
> Package) that contains BL31 (EL3 Runtime Services), BL32 (OPTEE), BL33
> (U-BOOT). Then, once the u-boot is loaded it is supposed to load the
> Linux kernel. Following my requirements I need to be able to update
> almost all components namely: FIP (thus BL31, BL32, BL33), kernel
> image (including bootscript) and rootfs.
>
> TF-A supports something called PSA Firmware Update that allows the
> selection of a FIP bank, just an ordinary A/B scheme where there are
> FIP-A and FIP-B copies, and the selection happens through so-called
> metadata. It also supports a boot counter that allows it to roll back
> when the boot counter reaches max boot attempt. Up to this point
> everything is quite straightforward.
>
> Things get more complicated when the boot process reaches the u-boot
> stage. As I pointed out I need to have two copies of kernel image and
> boot script thus I need the following:
> - bootscript-a
> - fitImage-a (kernel image)
> - bootscript-b
> - fitImage-b (kernel image)
> I am aware that I can embed the bootscript in the fitImage however, as
> I said before my fitImage is stored on the disk in the encrypted form,
> so the bootscript is used to decrypt the kernel image before loading.
> I decided to follow A/B paths for each component thus the TF-A is the
> source of the boot index.
> The information about the boot index selected by TF-A (A or B) is
> propagated to u-boot, so u-boot indeed has such information. The boot
> index can be then used to select bootscript-a/fitImage-a or
> bootscript-b/fitImage-b. However I'm not sure how to do this. I mean
> it's not technically difficult, it's rather a matter of "how it should
> be done correctly". What's more I want to make use of Standard Boot
> instead of old distro boot. Looking at the Standard Boot methods there
> is e.g. bootmeth_script available however I don't see how this could
> work in my case. This bootmeth_script just simply looks for a
> bootscript and if it finds it, then it loads it. As I said in my case
> I have bootscript-a/b, not just a single bootscript. What's even worse
> I cannot make separate boot partitions for boot-a and boot-b as the
> only partitioning scheme available on my SoC is MBR which allows you
> to create up to 4 partitions. I already reached this limit (boot,
> root-a, root-b, data), so the only reasonable solution for me would be
> to put the A/B artifacts in subdirectories under /boot part. To sum
> this up - the only sensible solution that comes to my mind is to
> create my own boot method that will use the TF-A provided boot index,
> then will scan /boot partition looking for e.g. boot-a/boot-b
> subdirectories (depending on the boot index) and the required
> bootscript (wrapped into fit Image so that it can be verified by the
> verified boot mechanism).
> However, to be honest I'm not sure if this is the right solution.
> Would be grateful for some suggestions.

I'm not sure if this will help or not, but there is VBE (Verified Boot
for Embedded) which uses a new phase (VPL) to verify things before
SPL, TF-A, etc. are loaded. It has an A/B/recovery bootmeth. Various
things have been written about it (e.g. [1]) and the docs landing page
is [2]. There is also a conference talk at [3].

While bootstd[4] was about 5 years late, VBE is a little ahead of its
time, but I believe something like it (everything in FIT, a VPL phase)
is where we will land eventually. As you say, you want to update
everything possible - I would add that you cannot update something
which might allow the device to be bricked.

For security I would advise to eventually move away from using scripts
(perhaps in a second generation as it is challenging today). Yes they
can be signed, but there is a lot of code involved in running
them...turning off CMDLINE almost halves the size of U-Boot and
therefore the attack surface.

Regards,
Simon

[1] https://u-boot.org/blog/verified-boot-for-embedded-on-rk3399/?print=3Dp=
rint
[2] https://docs.u-boot.org/en/latest/develop/vbe.html
[3] https://elinux.org/Boot_Loaders#U-Boot
[4] https://docs.u-boot.org/en/latest/develop/bootstd/index.html
