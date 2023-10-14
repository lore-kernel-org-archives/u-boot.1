Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545D5CDB47E
	for <u-boot@archiver.kernel.org>; Sun, 15 Oct 2023 07:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71C1086ECF;
	Sun, 15 Oct 2023 09:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jATJcVoF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE00F86F1B; Sun, 15 Oct 2023 09:15:18 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6930E86FA5
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 09:14:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=judge.packham@gmail.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-405524e6768so33468275e9.2
 for <u-boot@lists.denx.de>; Sun, 15 Oct 2023 00:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697354084; x=1697958884; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q0BMNOwiB3zbq2/uMdIPD0BSOla7R1dXW5DnpXXfJQM=;
 b=jATJcVoFeyVskV28miGEf1X9WQzru6FRseixa39n/cRtthvzl4lKHsoxvUNKySAGys
 /bAn5Z4z9cQC7N34PklkxHmN8XERrmTFLYmTYHFqkRmjDmRzDyiUs8cOWlZeiZbcW8SC
 FWDKOgkVU2hsLUXdCBJSDCrkrkvJTEz4dSAen8S0eClXZw2McxxP7Y7Rw6m8lVPvYNZ7
 iq6HvxHd3YvJfmC0VRwewfVpEc4CL6q515OlROrUob9UoIH2YbCXfTEFJGxcP1rqxOh0
 nPwFaS7r+TLmtdEnpKD8sSDA0MSSLYEDDVIYe7l6D4oe9g5cSmACdyLeL4iLP+8E575O
 DCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697354084; x=1697958884;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q0BMNOwiB3zbq2/uMdIPD0BSOla7R1dXW5DnpXXfJQM=;
 b=XuUmDk1k//jZ5ifX+raE+hm2lnMh+6vURUPMohzVOnFcFE3JQcuzUSAEw5HLbEUYes
 tknhiYDUVY+1xnufO+KhoVS2rhCnkKQjwTdhsILdHT6rNeN04biIBcBa9iK44YCWV0WV
 17EiTh1cA6NNgPcmgDbtP1eByNghBkfItG6Gvi0TjCpUNfovaovV75jjCs7fWCQaoSr6
 RI8lNfAZ1T9fRO4+UZcFL8G7Gr6AfJDn6gEcfiNXVJ5LratgwAzBLSCSfH+M4reEvkuO
 9oC+WbwXmAlbd0Kz+4qZlaSnfdP0yNz8GdWGbPEI5sb7KQdPkAJM764jLUf7JJfISD5v
 8TDg==
X-Gm-Message-State: AOJu0Yy/pxBtOPoB25FFfIFhT8sjWytpkFYTS3vXUI7+OlZ2DRXQALcc
 TQfk9lLNHGNZANoyKUo4JDi3C9G7z1h2ykEv3hw5aCjH
X-Google-Smtp-Source: AGHT+IFbiHLZ6t+2DVCy9IGqq2uT0xt1s0X0+f6frcXe3fkqPhLJ09ibyz/VE2SlXiboDxSXrUnKu6Kh+eacfQ11iN4=
X-Received: by 2002:a17:907:7d8b:b0:9bf:4915:22c9 with SMTP id
 oz11-20020a1709077d8b00b009bf491522c9mr1069718ejc.32.1697318961767; Sat, 14
 Oct 2023 14:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230317162253.1049446-1-paul.liu@linaro.org>
 <20230317162253.1049446-2-paul.liu@linaro.org>
 <CAFOYHZC_Dveax85n0fLr5BFyZcLqsvUssn=J0oHyvN75bTaCUw@mail.gmail.com>
 <fac6ef1747ec318787f90a6d0c81163b@kernel.org>
In-Reply-To: <fac6ef1747ec318787f90a6d0c81163b@kernel.org>
From: Chris Packham <judge.packham@gmail.com>
Date: Sun, 15 Oct 2023 10:29:08 +1300
Message-ID: <CAFOYHZAmWj6cgXib+m3Dy+mABcwEmPWAHLUgxeBe=2JVLsgaYQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] arm64: Use FEAT_HAFDBS to track dirty pages when
 available
To: Marc Zyngier <maz@kernel.org>
Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 u-boot <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, 14 Oct 2023, 11:04 am Marc Zyngier, <maz@kernel.org> wrote:

> On 2023-10-13 03:40, Chris Packham wrote:
> > Hi Marc, Paul,
> >
> > On Sat, Mar 18, 2023 at 5:23=E2=80=AFAM Ying-Chun Liu (PaulLiu)
> > <paul.liu@linaro.org> wrote:
> >>
> >> From: Marc Zyngier <maz@kernel.org>
> >>
> >> Some recent arm64 cores have a facility that allows the page
> >> table walker to track the dirty state of a page. This makes it
> >> really efficient to perform CMOs by VA as we only need to look
> >> at dirty pages.
> >>
> >> Signed-off-by: Marc Zyngier <maz@kernel.org>
> >> [ Paul: pick from the Android tree. Rebase to the upstream ]
> >> Signed-off-by: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org>
> >> Cc: Tom Rini <trini@konsulko.com>
> >> Link:
> >>
> https://android.googlesource.com/platform/external/u-boot/+/3c433724e6f83=
0a6b2edd5ec3d4a504794887263
> >
> > I think this may have caused a regression for the Marvell AC5X
> > board(s). I found that v2023.07 locked up at boot but v2023.01 was
> > fine. The lockup seemed to be in the 'Net:' init probably just as the
> > mvneta driver was being initialised.
> >
> > A git bisect led me to this change although for this specific change
> > instead of the lockup I get a crash so maybe I'm actually hitting a
> > different issue.
> >
> > Any thoughts as to why this may have caused problems?
>
> Not really. What CPUs does this platform have? What is the offending
> driver doing to trigger the issue? Can you provide some level of
> tracing?
>

The Marvell AC5X is a network switch ASIC with an integrated ARMv8 CPU (8.1
specifically I think).

I think there is something that the mvneta driver is doing triggering the
issue. I have another AC5X based board without an Ethernet port that boots
just fine (this is also why I didn't notice earlier).

I'll try and get some more debug out when I'm back in the office


>          M.
> --
> Jazz is not dead. It just smells funny...
>
