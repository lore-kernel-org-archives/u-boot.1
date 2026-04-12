Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7870AE937E7
	for <u-boot@archiver.kernel.org>; Sun, 12 Apr 2026 22:05:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE27083B99;
	Mon, 13 Apr 2026 00:05:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=thingy.jp header.i=@thingy.jp header.b="WYaf4QRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 969C183F75; Mon, 13 Apr 2026 00:05:40 +0200 (CEST)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9131839D5
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 00:05:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=daniel@0x0f.com
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-79ab5fd969aso38247667b3.0
 for <u-boot@lists.denx.de>; Sun, 12 Apr 2026 15:05:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776031536; cv=none;
 d=google.com; s=arc-20240605;
 b=YfnZ41IrQVL9vp09/rW/APizmo6SeZS+X5AoYLTjQtKvxsqDAjUkmWvj/dhVKYJY4u
 CcgabFzyNcAF6lKl+QcgjW4WBav6ZG+VivxhziO5Wd++PbOd854a8Ddq6MEJ8Iyo1Q8t
 tDDfULGF/KnRnOLcpXQ7fNMX2fK/bV3SUwz/oQTTOZHX47SPm1Fq7s4ex6kVU2BtT83z
 OmqnWRehpF3KU6tXTlNJp6ykVO6q62Iahj+iKGz9AA5dA0X0w2AlJP82ugJZv5sfwZ54
 R9LCklC28pOWby4hzSjCR0tyUngbECy2chCohpgqNBM2zq7XMwo8f86yxpoX4rr2PXiO
 0KZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dVqpAVw58Z+iGFbipzLEmTykmY/WtjTZTiyUjA1aTUw=;
 fh=AZkfv9O+MwE3AqHevojEB1Pmo7dmYD5K2R0frz0+OCY=;
 b=RVBxhYUbxgUzWsZ7+CzJrBnz/BbaCJpFls8qIXsn5QWHRhvviujlESlAgKnEn1Qr3V
 73+RGkfWn5snXg6z3VPEex8WbH7R/KS/hUmydkcxB8/XEhTsisji9Db+pIt83t5jLNPM
 sDSWE7dMK+yHGn0uxf39k3J4MOh6E2WGnlAbsYOGDpdZzhVX63BDobsfoxI5TOqcdh3M
 IBeiaFg+W6Os8MlNJu/s4M6/juNbEtrWnz7ZBPj0F3mWCDpzmjkBKmDmJNJmcvVNlLHP
 ZkJgZ159ge7LsZ8xHPsK1i5tfPDOjMlWZ2TlyKr7OSEYDWef7p2ehyHxx2/WccfXdd9b
 7p+Q==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=thingy.jp; s=google; t=1776031536; x=1776636336; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dVqpAVw58Z+iGFbipzLEmTykmY/WtjTZTiyUjA1aTUw=;
 b=WYaf4QRnbIvpQUubTNSsPgFieRgaq2AjYVUZMsjRlWuEHPKdP51XSmx6PDz3yWeXWV
 MVcaX+HcrjUMInedAVN9fCOWXXnz/aSptuS80WDG9MsAlTvBn/VsJHM71bVFd5soF/Ek
 OtXKSL1cgiol9ckXY4kpKO+TWVLFmbdl2iVgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776031536; x=1776636336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dVqpAVw58Z+iGFbipzLEmTykmY/WtjTZTiyUjA1aTUw=;
 b=pcE1o+mON5nSOwrsDcxXHuQaXpukjCwvgIxBG9pnThW6Bz1kkGjqbWC5zG/WU9cqcO
 GMwKiofsmIPph8cSK61nP2bHxPTvZwNQCWJWCXcBWVajriO3YTHt1KJjSGlW6bXEfPgA
 Oxh5ZBJf5QZ9xFkT6+OU5N3bN53/G4jjwTJbVVPKRFTZ/2mRHHaPi+OTkM3SOd8v5qck
 9eey9U/DUa2GaidHZPpSeQySgha+SVbBODUrawniDY0Gomzrfab5R27hx4f4Ol3HMUE5
 W2BrhBTIeg8v52i6D0FQICresl+bTxq6KBFuv9YUxVltk+MAd0ns+0OnNuL21AwKD0RP
 9QPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ//YdRbPMmXOk934RMyiWdVSPiuyLEZp8/xFDzx7ir04mkrbSb0I0OYK8X+BKL8eJggdNLAf6o=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4S9DsIR3iCnINgULdHvIVSeElY3euRkSStyqtznY/grabo99U
 EwnTRc/k8wzCX5BgIpht6RaZITta3WqWdIfENAvg6j5kgEVnuV2+vXbWbVv+uLKBqXkNevcptPO
 s4hzMr2ziLXEtPtGA9GNI4SK61ipCSw0Ng16tt5PXEQ==
X-Gm-Gg: AeBDiesaESJEvigLUT/LkmpPpEMQT6hkEVR20j5BcEiUGP+nFRc1YHUXfvN94gweway
 u9U/k9Jwl2NSgA4wceB3QLsA7xRQK6hMObD3ufeqpiSOfPQBHP1GIOTwe2UDmEsN/VfgEjU+9mx
 VhMH7KPdSq1o2t65eiu5VWF/HRTzsoz9GDBDAlOSTLovSo47Ebp8aOe7Hs7qurBsL8b5MD0PNre
 Mlx49gmCZJl8a2QW+58ZFXx5ClnsyIfZquJ7p7E6nLBZW6BPC+F8DKFquKcAv3Llx04b39K6zmo
 y6YkQAxfNG0mk2sCWFeMUAmdfnNzcJP1dBVEwM/A
X-Received: by 2002:a05:690c:d92:b0:79e:62cf:8254 with SMTP id
 00721157ae682-7af6f22b8bemr123191207b3.8.1776031536375; Sun, 12 Apr 2026
 15:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260408220928.3328551-1-daniel@thingy.jp>
 <20260408220928.3328551-5-daniel@thingy.jp>
 <adwP6m1zDjUQWAl0@google.com>
 <CAFr9PXmVeWjFNM8x0rKeLHjvZOFLyvbMyNngt8EpMqkBbugHGw@mail.gmail.com>
 <adwV8fQUTwBlo1sj@google.com>
In-Reply-To: <adwV8fQUTwBlo1sj@google.com>
From: Daniel Palmer <daniel@thingy.jp>
Date: Mon, 13 Apr 2026 07:05:22 +0900
X-Gm-Features: AQROBzB9plD7C0UNJaVsTkRvOco2fPGEMnrJVxCMPU_T8WZnTtBQc_M1GF7UAKc
Message-ID: <CAFr9PXnja5-NrD4Yff2U-Lzp470mF6LYpUKuEPH8NwST42oGdQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] virtio: blk: Fix converting the vendor id to a
 string
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: angelo@kernel-space.org, bmeng.cn@gmail.com, u-boot@lists.denx.de
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

Hi Kuan-Wei,

On Mon, 13 Apr 2026 at 07:00, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> I just took a quick look through the virtio spec, and indeed it never
> mentions that the mmio vendor id should be a string.
>
> Given this, should we even treat qemu as a special case here?
> Perhaps the simplest and most spec-compliant approach is to never
> assume it's a string, and just uniformly print the hex value for all
> devices. What do you think?

I think printing a pretty vendor name makes sense and since it's
basically just QEMU right now the little special case for it isn't too
bad.
I think not confusing people by showing them a bunch of hex where they
are used to seeing QEMU is also worthwhile.

Thanks,

Daniel
