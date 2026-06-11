Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C856FCD98CC
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 14:54:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DFA484874;
	Thu, 11 Jun 2026 16:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WgJnbhkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17AEB84701; Thu, 11 Jun 2026 16:09:42 +0200 (CEST)
Received: from mail-vk1-xa2c.google.com (mail-vk1-xa2c.google.com
 [IPv6:2607:f8b0:4864:20::a2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3C7A83FEC
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 16:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=compholio@gmail.com
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-59ccf81e74bso2885045e0c.3
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 07:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781186978; cv=none;
 d=google.com; s=arc-20240605;
 b=ZovRCWd80T6hX/fo8jtUfE9WUMau/WVJVxUAQcNvV0oaQStkOycJQTuZiJAY063s50
 7h7tAvtSELH5K42djpnyrTHobcjTG6fEFyfBFbxRdW6SPjVouAJGPbtNqhqYtyOPzh97
 YhZ/j6LyUgYBM6V+kXhOchCmulZ+uzHToaqBiA30AK+ys6SGODlghnfz8xcLQCFMIWMg
 npPn6k28kE4eSlLW5pA/GMo22si3s9QWHFlNQXBxdkd1JMDM7X9GFVwQnsV8EJBeoN0s
 kl3NKGpZOZ2ZAo+dWPR0VLBceKv9fVHZGoqzsPYUuPuAO6G8VFRAkK4uKuSWjvpFJ1Ou
 bi6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TA3yPYF8CeG33TwN7xNquOg31Wtl655xPf+qM6bBpwU=;
 fh=oy+soc42QmOg65OujwzLw0RnRzkJFCl6UVNit/QoOi4=;
 b=GvUVzVYoGLtFb4b4+wXGgCRdO/L/r3KNCTwJyu7kijf0daAET/OqGd3H9+JMmVyo1s
 1WR6bzS8tqwC7O/INhNgJGN3421OvSj5rihE9nnFM4LW+AbKyMRdbLJNEtLH8PFe3zyC
 mH3s//yPA/H74LidXSEe8oSniooW12nh6pyncd61Ot0zEXFjdwquDjoIOM/n9d9fLdHC
 VF0vClh5mINo/QUax4Qu8RHzDzft3FsZiJbwAeoT7w/I1w6tZ93Hkdf8cFCqlCoB9U4F
 6ha3b5dI1rSY69ebIQ3fHAAiDVmyARc/CPVQy4FZOUDjZxZERSZGo3W2VEVe9EPMrhv6
 hZbw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781186978; x=1781791778; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TA3yPYF8CeG33TwN7xNquOg31Wtl655xPf+qM6bBpwU=;
 b=WgJnbhkIYKZuJ9dzQKMZpfHigCQrad9T7sdeeMy/6Sa61fwS/ZFmXo4t2WixYIt2F1
 grIeL/H5I2v+Ry1tDoCN8jmTbCcabWVcKVceP3y5eyP746lWtIH9m5DzHFeTcDXFx6lj
 u7tw5jYZwbMw0zr//p63PWxo/phbWMpvaJoND4AB5vaVZKjaZiCGfHVJ0is2j9CdrNLc
 l8zhm3cI2/c3YEz7oohojQht4aCMEyvHgckxp2vVqdY0hzhYE3UWtcOrS00wA/eU0/Po
 JvcgOMwzrHudy3bFnuWKLl9GwTkMWjw/P0zG2IZkA71wovXyhzeYw3FNEfw460o8z+wr
 Mbjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781186978; x=1781791778;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TA3yPYF8CeG33TwN7xNquOg31Wtl655xPf+qM6bBpwU=;
 b=qoj+O+bjrB6cT6eo0FpgGbxCC3ETNEzaYar/uhvNsMpwdMPGbWmXFYdRDwuU5whYpO
 cA9gUAJPCRkyGXhlfzLTTWlQ38CHXmhzt852i55pfrwVo35xrEltzcgCWEwK+uyXWzEY
 YIJuAWp9x6mYX/isWHGaavIXnFa/V+aUI/qyk7xWgEw5bJaE2VJmVeGm+aJngpR02jzX
 UW2m45Qup2Ahbaocpl9acwmZ0YdAnXIIh6SlvbHWao5BcjhyICQr00w91wojubOCPddD
 D1DYkbVr/JAX8AtWkVzKEDyNBddxJtPc+WmZdKIokcmlZ19y8QfaUrXVRwK0KSEEO3zq
 BwEQ==
X-Gm-Message-State: AOJu0YyfzzDEzlt8b+agVRu6vfM1BczpzSuJ3d7Nv+ikn0tRzPOBpP3e
 ghHqf+2Wo6DFBn1fGqYYKewYYuY/WhHJVi0hWPVGnRrdGsDEYbITrLOYr+EMflZYND1PsSA9KSU
 E5JFtMGZl8Q7ksMQtRJ/Z6JPb+HQzneQ=
X-Gm-Gg: Acq92OEB1xJqPGFM+eHLuCbQ1yCDukFHSFH6YA6Nb4LYoX802xY8dAxjcDJ+ihIjk+k
 YRUUhXP2t94AeN3oSx/oLfX4JwIUHghwStoO1yP0y5bWh8AUh5MzpVxg5R6gmW4eeyqTKTNpTnR
 cSeT5mBgR704wfSEAI9EYmAir2E8Lr+EEz0RVrJsR0YZU00Ik++1FhPYmHcZ/9pQHv3BXdsF1ko
 0bXHiNmbP9LyvwsLdJNI+lNBHtEB/KLbzi4Pu6QylOM59GiOMBl9Dgi1BzAoh0Sq+LctWZYnLhH
 svVJu20rTOcPsXBNxg==
X-Received: by 2002:a05:6122:130c:b0:5a0:9ad4:7016 with SMTP id
 71dfb90a1353d-5bb01178b5cmr1294574e0c.10.1781186978026; Thu, 11 Jun 2026
 07:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260605135747.1814307-1-erich.e.hoover@gmail.com>
 <d36d8742-3345-46ae-9e8d-1c9ed1c49525@amd.com>
In-Reply-To: <d36d8742-3345-46ae-9e8d-1c9ed1c49525@amd.com>
From: "Erich E. Hoover" <erich.e.hoover@gmail.com>
Date: Thu, 11 Jun 2026 08:09:26 -0600
X-Gm-Features: AVVi8CdIh5aCxIo7CHyxXelU-kYeTJwnIqHpo3tGzI2Nb0AO-5taXztCyCpzRUM
Message-ID: <CAEU2+vqO_z7Y+LAEL6AEQ6yuSn4FxjcKbfb8hQc31kCBt3uSxQ@mail.gmail.com>
Subject: Re: [PATCH v2] mkimage: allow zynqmpbif to use a register
 initialization file
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>, 
 Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 11 Jun 2026 16:53:49 +0200
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

On Thu, Jun 11, 2026 at 5:31=E2=80=AFAM Michal Simek <michal.simek@amd.com>=
 wrote:
> On 6/5/26 15:57, Erich E. Hoover wrote:
> > ...
> > options, like so:
> > =3D=3D=3D
> > image : {
> >       [init] fsbl.int
>
> please use different name then fsbl because fsbl is not doing this progra=
mming.
> That's done by bootrom itself.
>
> Topic board is defining it like this.
> board/topic/zynq/zynq-topic-miamiplus/ps7_regs.txt
> but that's for zynq

My apologies, maybe "reginit.int" like the example for the Versal in
UG1283?  I'll remove this line as well, since that's more specific to
what we're doing:
[destination_cpu=3Dnone] fsbl.tcl

> Actually I think would be good to recap format because origin format
> is different compare to what it is used by bootgen right now.
>
> https://docs.amd.com/r/en-US/ug1283-bootgen-user-guide/Initialization-Pai=
rs-and-INT-File-Attribute
> ...

Are you suggesting adding an additional comment to the commit akin to
"This currently uses the same register initialization file format as
zynqmpimage (ASCII text hex values with each line composed of a pair
of register address and value) and is not yet compatible with the
format used by bootgen."?

> >   static const struct bif_flags bif_flags[] =3D {
> > +     { "init", BIF_FLAG_INIT },
> >       { "fsbl_config", BIF_FLAG_FSBL_CONFIG },
> >       { "trustzone", BIF_FLAG_TZ },
> >       { "pmufw_image", BIF_FLAG_PMUFW_IMAGE },
> > @@ -279,7 +280,7 @@ static int bif_add_blob(const void *data, size_t le=
n, size_t *offset)
> >       return 0;
> >   }
> >
> > -static int bif_init(void)
> > +static int bif_initialize(void)
>
> What's the reason for this rename? I don't think you should rename it bec=
ause it
> is just distracting.

I was trying to match nearby behavior with other flags
("bif_fsbl_config" as an example).  How about I change the new
function to "bif_add_reginit" (similar to bif_add_pmufw instead)?

> Anyway I have tested this patch and output looks reasonable. I would obvi=
ously
> prefer to add more features there (like ignoring comments) or unify the f=
ormat
> but that's out of the purpose of this patch.

I would be happy to add some more features to this, would you like
patches for this added as part of a series or submitted separately?

Best,
Erich
