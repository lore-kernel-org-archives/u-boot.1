Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F25CDC19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 18:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 527DF80BAA;
	Wed,  5 Mar 2025 19:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VmQSfI1F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08CB0808A2; Wed,  5 Mar 2025 17:40:56 +0100 (CET)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD95180E94
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 17:40:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ppeter.bme@gmail.com
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-51eb181331bso3452669e0c.0
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 08:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741192852; x=1741797652; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zvwIyzKsF/qGorcxR/SoYV/q236lp9v6SuDUJsow9WE=;
 b=VmQSfI1FXIieHoUt4OpO0eu/H/YlQVgzMsNFSBAp7geiqQWMOTV4Qrnrv/VpeSoGrs
 5H4ram4CkOUyJrzokg2sNL36oITkkxkB9avju0ZKvSerPy/oepsAoiLzCt+cicA38fG2
 5Y872aZRFRfDzKW2MxfLL+M3N8DQbvhv2hoUi2K4k8xiwDyD50+vNqrm/i/HqYEjHXq+
 k9JxWES/OnbMyKTvYlzzW1xTdunmfizy49/XOrN3ayK4F3xkHQXIseZH1dMVNpr5Nyu1
 fekZOvPJ2iuSQeEXS2Ut97J4NtC/CQ9kHNOWwA80VIkSDK0wrDe83nL/PSvJ7mLbL0ww
 Calg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741192852; x=1741797652;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zvwIyzKsF/qGorcxR/SoYV/q236lp9v6SuDUJsow9WE=;
 b=qHOcZa7ko93f09B+x7Oycraj9i1ArdZwcdkG7zKCkHdlPRyoGt0JPv2kqKzonT/eCm
 Z9az13myT0HW+/2BO8UTohWEG041UBvjQCEf4jSmKbCQHpIMd1L3qmQtl/pAdrd7Rqve
 wNlA4j/l3vetfoND3tKNhIp99Zzkhb3rLaU3zfNZwl9yV5hcVEMEUzwJykA7x/cnqU82
 Ien3wjHEJI3B1wQ8s6E/y4+pBAQyl6luslvXzDxSre+svNQKC4hqF8xzw/7lZComsiuU
 DaftXL3w3RmYIW8xEbbr/BvFT0d2hyJdNnqVAm1L695JXZUX6of43pO3ait6IgpYzIaw
 8xag==
X-Gm-Message-State: AOJu0Yys0RL6D18ltTTlrr9GTBnqDXrKZznMt90FTw2sJCWU/GGmxcoM
 Cu8bV2Vjdm/ny94oLZqrlm5XGQtQFonei/8nTnU5szcaApoSw7LIgzFsKJ6dgTeSiMAw7Llcjzw
 aJReKSNsstDDoBgVlwWTeT/h/rbo+CLqrNMY=
X-Gm-Gg: ASbGnctxC2JxFb71S8uOoTfqcGG5wTeb+PQuTLckpM6NiuX7dUPb3LisGhMQl+8ECqw
 B0HgbbG6dYokTDpJ6v4FlRNu5pzY0aNSQLQr/8gX3ETKBxX8OCmnmod66UyqylaCLQgzdvPIXbD
 kad94JyO74Mft/Yae2SfCqHxDfN2osojKpF0TW6NlvZUaT+VYri9VJXzu09A0=
X-Google-Smtp-Source: AGHT+IFd4Z6+4LhanivszTvBS1J5bwoaN/oBp3PbE4wiNfYYOIJgUE0h6gGjr2WUq0eQF3FrFvrU14CKPFpSYE0eIY0=
X-Received: by 2002:a05:6102:f88:b0:4bb:d062:44e with SMTP id
 ada2fe7eead31-4c2e274386fmr2775753137.1.1741192852433; Wed, 05 Mar 2025
 08:40:52 -0800 (PST)
MIME-Version: 1.0
References: <CAF2BDb_g8385y8WpAw0epu-oSE5Wx2Nab0NvQ1mf+=hOVowZmg@mail.gmail.com>
 <5b3c6ca3-c49c-490b-81b3-0b243bfa7af9@canonical.com>
In-Reply-To: <5b3c6ca3-c49c-490b-81b3-0b243bfa7af9@canonical.com>
From: Peter Polgar <ppeter.bme@gmail.com>
Date: Wed, 5 Mar 2025 17:40:41 +0100
X-Gm-Features: AQ5f1JqV1qJm-M0zwCUooZsvlmPw_d8iV-mVC3hJG3WfyAEYK_CM7sz5JIyk08E
Message-ID: <CAF2BDb8dbetu6d8+aP7c9aiR245Ljz951OeEirrbXxdXaBuO0Q@mail.gmail.com>
Subject: Re: [PATCH] Add cross compile dependecy info for ARMv7
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: u-boot@lists.denx.de
X-Mailman-Approved-At: Wed, 05 Mar 2025 19:11:57 +0100
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Heinrich,

Sorry for the late reply, other things were going on so I dropped my U-boot
project for a while.

What you have written totally makes sense. I wasn't aware what the "hf"
stands for in the package name.
Just saw that my architecture was "armhf", so I assumed I needed the
build essentials for that. Which I guess would have been the case if the
project used floating point.

I will update my commit.

Best regards,
Peter

On Wed, 4 Dec 2024 at 10:34, Heinrich Schuchardt <
heinrich.schuchardt@canonical.com> wrote:

> On 28.11.24 17:48, Peter Polgar wrote:
> > This commit adds info about the needed package to cross compile
> > U-Boot to ARMv7 (32 bit) architecture on Debian based distros.
> > ---
> >   doc/build/gcc.rst | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/doc/build/gcc.rst b/doc/build/gcc.rst
> > index d8fcfdc4bf..c552e7b590 100644
> > --- a/doc/build/gcc.rst
> > +++ b/doc/build/gcc.rst
> > @@ -19,6 +19,12 @@ You could install GCC and the GCC cross compiler
> > for the ARMv8 architecture with
> >
> >       sudo apt-get install gcc gcc-aarch64-linux-gnu
> >Tota
> > +For the ARMv7 architecture (32 bit)  use the below command instead
> > +
> > +.. code-block:: bash
> > +
> > +    sudo apt-get install gcc crossbuild-essential-armhf
>
> crossbuild-essential-armhf depends on
> gcc-arm-linux-gnueabihf gcc:armhf, g++-arm-linux-gnueabihf, g++:armhf,
> dpkg-cross
>
> But gcc-arm-linux-gnueabi is all you need for cross-compiling 32-bit ARM
> U-Boot.
>
> Adding an example for every architecture seems too much to me.
>
> Can't we simply update this sentence pointing out the the arm
> cross-compiler has a suffix.
>
> "On Debian based systems the cross compiler packages are named
> gcc-<architecture>-linux-gnu".
>
> E.g. add
>
> "gcc-arm-linux-gnueabi is the 32-bit ARM cross-compiler package."
>
> > +
> >   Depending on the build targets further packages maybe needed
> >
> >   .. code-block:: bash
> > @@ -118,6 +124,12 @@ Assuming cross compiling on Debian for ARMv8 this
> would be
> >
> >       CROSS_COMPILE=aarch64-linux-gnu- make
> >
> > +Also on Debian but for ARMv7 it would be
> > +
> > +.. code-block:: bash
> > +
> > +    CROSS_COMPILE=arm-linux-gnueabihf- make
>
> U-Boot supports  ARM SoCs prior to ARMv7. U-Boot doesn't use floating
> point. So arm-linux-gnueabi is the right choice for all 32-bit ARM boards.
>
> Best regards
>
> Heinrich
>
> > +
> >   Out-of-tree building
> >   ~~~~~~~~~~~~~~~~~~~~
> >
>
>
