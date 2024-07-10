Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A55DC3DA42
	for <u-boot@archiver.kernel.org>; Wed, 10 Jul 2024 21:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AEB08862D;
	Wed, 10 Jul 2024 23:41:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HD/hkpib";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9A6F5885F5; Wed, 10 Jul 2024 23:41:16 +0200 (CEST)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93DD88862D
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 23:41:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a77cc44f8aaso20247166b.3
 for <u-boot@lists.denx.de>; Wed, 10 Jul 2024 14:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720647674; x=1721252474; darn=lists.denx.de;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pgdj7E+WW6yIC4fzci65ToUmEkmLxBD+MZI+42Rvq9I=;
 b=HD/hkpib1D2N4PWMFs0Vf2mW/FKSPIVsD5Ge4iw/cGv9brwKXSlTj15KMLDeudPlvZ
 mtZIYfji1wUXwQKwnEMi+Isoz9WYZ629t2xvdB3TZ8VRhX/DB8QAZB+4XwO5/bE2Yjky
 4q6HdQdpFwCAR6Ikbjh5fZCkjTeJ6GJ6gMRw1HNOfq5nLn1c/iglH2ezTCSCBudLMfyw
 op9+CcHhlrkJOV9DpMr/+z4Kl7hlrhjc1bg7SFZYaaoVCURdHpFVmuOfICdYOINJ3WJ0
 /SWx9X8l2jhFR1M8lRmtq3P44UnZ0AXh37uoAhEORm9K3Nw1GI0ijQjJLcOX6DSY3pHx
 SMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720647674; x=1721252474;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Pgdj7E+WW6yIC4fzci65ToUmEkmLxBD+MZI+42Rvq9I=;
 b=Fk59aCa6WmYBTOZ4DFWFo7n4Y8Kut5Y2kttaIhCzPg7d0eCNyvfEqCms4FB/h4L0uC
 zbMyUPJdngBv6tC3TnvqPWy5Fx68Hm33ouik1kx3IAXCSFbVRcOUVS8mNBMqfMxfV+Gg
 ausIK4Q7z0eO5/2uQakLigQLwbxEYBA7bJ2DL4I7R8f+i3SB+jGOPcTaxdqGtArk7HpG
 zNDSKcgKTd5+0x2LCwiFl0cc71qPOkek73kk/7grtXtwLlLbk+WV5zUsJPr6XTJ9y2v4
 50FAf8UdAbecrn/ZlN5NbI3NmJeQJiCw+KA5wT4ul6BkkSP6+CL69tpKhOW7QaRkrQ36
 e0yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4aD2F/o0k+mj18meklYTTgBRgxeC2UDNuymujOWGgqpMk5hsHv/PtVabP7SFFmhpa3M49KahxZtedR1F0yiEJiAXRAQ==
X-Gm-Message-State: AOJu0Yw3dnX5gXqeeOE03KYhSURPAcYo0Jxq+rjjEI/3Szisuv+Qf+wg
 FIZz7EFlHTwVUzBHap+WnTugzrIatuGnCJaCCWBvXhNgGe5F1aQ9EBMCSDcwZPaJZH4MOOzMao9
 8ht1gK0VDTwtmbxYFkJnAYb1FTGw=
X-Google-Smtp-Source: AGHT+IF/l1cbrIFNV1rlvY2Wh6K9qwMNFdp3qXFarkx7bsD9/uE4Xt9vbhskO0S5qFGJMwdLLglc1jRg5xuB6CqZ3FM=
X-Received: by 2002:aa7:c38d:0:b0:58c:ce91:89b1 with SMTP id
 4fb4d7f45d1cf-594bb181ec2mr5443490a12.17.1720647673891; Wed, 10 Jul 2024
 14:41:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240708043904.5100-1-mibodhi@gmail.com>
 <1866ab7f-eee5-4ae9-b679-70f0d431499f@denx.de>
 <Zo5qPkxGoz6hsbC-@orbyte.nwl.cc>
In-Reply-To: <Zo5qPkxGoz6hsbC-@orbyte.nwl.cc>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 10 Jul 2024 14:41:02 -0700
Message-ID: <CAJaLiFwrqC31+PkHjtm8t_k7EQ9y35KirOtzMxdQvU3P5X8aOg@mail.gmail.com>
Subject: Re: [PATCH v3] arm: mvebu: Enable bootstd and other modernization for
 Synology DS414 (Armada XP) board
To: Phil Sutter <phil@nwl.cc>, Stefan Roese <sr@denx.de>,
 Tony Dinh <mibodhi@gmail.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>
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

Hi Phil & Stefan,

On Wed, Jul 10, 2024 at 4:02=E2=80=AFAM Phil Sutter <phil@nwl.cc> wrote:
>
> On Wed, Jul 10, 2024 at 08:26:12AM +0200, Stefan Roese wrote:
> > On 7/8/24 06:39, Tony Dinh wrote:
> > > - Switch to standard boot (in include/configs/ds414.h and
> > > configs/ds414_defconfig)
> > > - Implement board_late_init() to ensure successful enumeration
> > > of USB3 devices
> > > - Remove unnecessary checkboard()
> > > - Updated IDENT_STRING to indicate this u-boot supports both Synology
> > > DS414 and DS214+ boards
> > > - Add SYS_THUMB_BUILD to reduce binary size
> > > - Add NET_RANDOM_ETHADDR
> > > - Add CONFIG_LBA48 and CONFIG_SYS_64BIT_LBA to support >2TB HDD/SDD
> > >
> > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
>
> Acked-by: Phil Sutter <phil@nwl.cc>
>
> > Reviewed-by: Stefan Roese <sr@denx.de>
> >
> > @Phil, is this ready to be merged from your point of view as well?
>
> I still want to investigate legacy bootstd integration, but that's
> follow-up work anyway.
>
> Tony, thanks for your efforts and the good discussion so far!

It was my pleasure. Thank you both for your review!

All the best,
Tony

>
> Cheers, Phil
