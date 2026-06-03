Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7936CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 20:19:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8EF984879;
	Wed,  3 Jun 2026 22:19:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DUvp5eMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A93EE8469D; Wed,  3 Jun 2026 20:48:41 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B0F88056B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 20:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=compholio@gmail.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-59d7db12342so1486812e0c.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 11:48:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780512518; cv=none;
 d=google.com; s=arc-20240605;
 b=Tk7TARknKGCU9OdNkm/XuLbUk2UYIIvjB58fcBTTBR8UcPihgbfgUbLRPmrTwo4Ulo
 33Yk1yD0yK/n0UzQxkmb7TDmdF4Q6Bt6qNANuv0fzZ2usEDs2YcmLfdi0fxAVpQl6rWf
 vEOMR0i9TiFoOxeKPcxYLHpd77v4rNjriwS75ir672wESASiKaHOCOmgd3FiiYwucPyb
 V3BsuKIVL6qD+oKDQN26rAu9aylSPX9A2tvybWtle3nyGmt9vOIs+vaHniyFey0/QQmy
 JT0M+94ODHFUWtAOnCp7ST0bbtMIEYdom49ivKRzGCEGQJIZb3XnMnFIl4qPuVlLzcnj
 AEDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zqDISaeM5jYKI+KpmkM0mhCqOgbLrS3OXyWHIH8VvW8=;
 fh=oc1K78mEQyzoqS6zkPeJ7dptk6HQ3hrenIqmrOeZVo0=;
 b=NBY+mSHeyu0F3PqHx9Nkx9NPhhlGlivnLkwzIZdBU3c72Bfu+orlGMAtqQtvidcKuq
 gjqLywtuZOS2FnVPKEtI2xAUw/pnR5N0GNISmvY0+Zqj8GYKV6ZjpDs9nDii+ZkpAJ+1
 s691LNTCx5WLx9cGBdDmYe6FlX5I6aqSRnhudbI4dc2/6yoTm9OTClnjhlWjrz+k0uEk
 uQxFKHo3FMtk8YBj5krmkuFeA2mhDvMkxakiSEsx+IU0fOpf7ZkQOomno4cy1/NRFeIJ
 dKtFd0IDy/T3gU6dBXbhwqMGWX7XhtnykJgWlIFloOxxpp3DF8WlY3bYufAiDnAkKmen
 kLZw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780512518; x=1781117318; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zqDISaeM5jYKI+KpmkM0mhCqOgbLrS3OXyWHIH8VvW8=;
 b=DUvp5eMfcTyq+7dbw7bs5alm49Re/mLS+YLSY8on35X6oarG9tOmbeiOVAB6WxvaGY
 SGP5vM1wfp9YMCQ7/nxNDXN/Oq3kpijTct92+yu0/r4enETkDOK9RVhVbR4oO1HHLh7N
 phLKVi6B80TGS5inAroRYe/KFQ71SK65v8hyaNmzRCSWR/28pLKMD52CRHiV7APR1/G1
 vGgYMUvKH3A3ROMQsfVi6VDPbpIKQF/YrvISnfthY39Ik0BTEG1Dq9aDs2NseIuGFpGq
 LFaP9pcyLpp2W9bLmTcY4msqZsBrCswdYZ7zsF6+uTUhvkqAWDfKZYScE1rApcJmcFhw
 X/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780512518; x=1781117318;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zqDISaeM5jYKI+KpmkM0mhCqOgbLrS3OXyWHIH8VvW8=;
 b=nx/IK7OZaz6EXdDUUy9DP1cmtkXUf9KFqjb7FF4KN8ruuuB9PU86DKcfR0OCWyavAs
 MvaI8fvr87Dvolc7QRODmMDE0d84CcI04F/NjhJBUfp2DuGBDQqMfCmP8uJq0r+mAfH8
 91PY30UFhSp+hLvuFlFgBxY8jJtrgo7tFgcsfIBDb3beN+lyLrfnnJV9PeTSB9G/ooUD
 +X/g/28WezCr1TMhdEA/p9HhreKk+S8pCgDV4PZTNnVOJ/sBCkJzybwqtjdEtbLJMuEd
 gW1q5t+jB5GINs1kbOA+8TCCaRsVVfg6n/pZoNQ+kj/9hVlqvSFnSH1JjnteEpq2RIDZ
 7Wkg==
X-Gm-Message-State: AOJu0YyZYOSJfgRtpWPy09jwMU+axxeMLSu2ffu2UTZ6iasJKfZND77K
 Y6ddPnwdU0NvLxlYBA2/fCqWeUMxufM5HFqQCTp8xwEnoLYPvF6+kAca5vjAmNpdDeZhuLaRvlK
 7ABog5GXj4AluSzUaG3TDzvlRISAga2QZNLWaK2I=
X-Gm-Gg: Acq92OGjU2j/bHkSa+h9JQnFOSF6LlfUA1o+AZcRS/cQ2SyU5TP1uQA8Be8PV5mfIt/
 0UdvTqrY1usjSnbda13wZgq6sL4kqnAu3GVNRZD5JQb9OWL4XuF+adraeGTgqMFTWUK4x9wLesx
 tpk1NYp/CsCygIwLCKoja4s9NoCIEXhrywuYYt6Jb7Rz6cguGSOyHNdXs0LWlZ0tExjEp+QzCUZ
 6arka4HdLlvTJ32qv5ULy/5NFQYjYJPRuD7Z9GsKNkgF0fQsM++QKyriSl9Cv1tJ7NJ6PdDZ2BY
 CPTXvb4PAFpwKFU3wHqzlfb6GG6m
X-Received: by 2002:a05:6102:6d0:b0:6ae:dfe4:37e2 with SMTP id
 ada2fe7eead31-6ec4327ec3fmr3235262137.17.1780512518345; Wed, 03 Jun 2026
 11:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260602210141.62966-1-erich.e.hoover@gmail.com>
 <0a768686-d9c9-54ee-c101-92077805b504@gmail.com>
 <CAEU2+vrQijegaxRhjGoMr=kKcQ2mbXMh8WD3oEpa+HzDfbUE2w@mail.gmail.com>
 <86b83c9e-2344-542b-8c82-f3106150878d@gmail.com>
 <CAEU2+vrTq-3Xy5MwHAJZ_zjx7bdM1qih=3Tmkp_u758WcXf+YA@mail.gmail.com>
 <1cd5b625-89c5-73cf-93a2-654af3906f60@gmail.com>
 <5103b696-77d0-387a-40a1-29665df6d36f@gmail.com>
In-Reply-To: <5103b696-77d0-387a-40a1-29665df6d36f@gmail.com>
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
Date: Wed, 3 Jun 2026 12:48:27 -0600
X-Gm-Features: AVHnY4JXZw2Fxexp9YQzrAwtthLDxntUBSYIedqTYrOWdw3VLTRtZhB_E10G6j4
Message-ID: <CAEU2+vp7yXkt66vVxyuJFu-9-LQva7+yz215CKpf7BPGiv7xsA@mail.gmail.com>
Subject: Re: mkimage: allow zynqmp to use a register initialization file
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Mike Looijmans <mike.looijmans@topic.nl>, 
 Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 03 Jun 2026 22:19:36 +0200
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

On Wed, Jun 3, 2026 at 11:55=E2=80=AFAM Sean Anderson <seanga2@gmail.com> w=
rote:
> On 6/3/26 13:51, Sean Anderson wrote:
> > ...
> >
> > I used ATF, but this was with SPL. So the boot process went something l=
ike
> >
> > Boot ROM loads zynqmpimage
> > - PMU firmware to PMU RAM
> > - U-Boot SPL to OCRAM
> >
> > U-Boot SPL loads FIT
> > - ATF to OCRAM
> > - U-Boot/DTB to DDR
> > - Bitstream to PL
> >
> > And ATF was configured to jump to DDR after initializing.
> >
> > I guess if you are using FSBL that doesn't work, but IMO FSBL is yet an=
other
> > incompatible bootloader to maintain. I'd rather have a shared codebase
> > (SPL/U-Boot).

We currently have thirteen ZynqMP systems that all have different pin
configurations, so we have a unified FSBL that uses the JTAG
psu_init.tcl (and a small register initialization file) to initialize
the part.  I'm not aware of a clean way to do something similar in the
SPL/U-Boot approach, without having a bunch of different u-boot
builds, but I'm open to other suggestions.

> The other advantage of this is that the FIT is loaded with SPL (which can=
 use
> a faster bus than the boot ROM, although I think FSBL does this too) and =
the
> images (especially the bitstream) can be compressed. Even something like =
LZO
> is very effective at compressing the bitstream and sped up the boot by se=
veral
> seconds.
> ...

We no longer include the bitstream in the boot.bin, so the time to
load the boot.bin is not something that is a major concern for us.
We're mostly trying to manage the complexity of having a bunch of
differently-configured ZynqMP systems.

Best,
Erich
