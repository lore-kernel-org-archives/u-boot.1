Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD8ECD59D93
	for <u-boot@archiver.kernel.org>; Tue, 26 Nov 2024 10:32:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3148916D;
	Tue, 26 Nov 2024 11:32:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GerX+EIY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 69DA589C3F; Tue, 26 Nov 2024 11:32:56 +0100 (CET)
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com
 [IPv6:2a00:1450:4864:20::22f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 108E1890BC
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 11:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=lucent@gmail.com
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ffa12ad18cso62022971fa.2
 for <u-boot@lists.denx.de>; Tue, 26 Nov 2024 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732617173; x=1733221973; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PX6uM/lW4yBansHFfULYAmhCWwrj+KBN96kl6DHyHRw=;
 b=GerX+EIYU3nC24wuRpETn/l62heHDxyxHSMRvYJBC2Nblt4QF8xEkjs1MtK6VbYvNZ
 JsSKfLUpnhUONZwB0csk8nYdtHz7tnTZgdr+bqZcUa9fCEswqRrFYXd+MJogepQ1wVI5
 qiL21wAhbDh2LTiLFI+wZQX12QDcxlPIAQmqRIsCa5vVVT1eE8r3Hqgp/iDqNmae6OLH
 cA8vaZCf+530tZOPokKHLfvqjtY5NkHW1bHao48+w8TPmJQHaz30fCNc14Pcs/tQBrK/
 x5KGzscCwjz4XodKPmTgB9j98qjnxuIc8RCgXySJgoJRDYdedD4aY3eYjHT6QW8IFsuk
 tvJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732617173; x=1733221973;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PX6uM/lW4yBansHFfULYAmhCWwrj+KBN96kl6DHyHRw=;
 b=NK2LNiGWbA9+a8ufK0MuHeV+WGz7vp96JE1qNgNRmU4ATrkhcujD8T8W4qC/t/uWko
 Tm7ipXnQBRAve8ZWqqzqOI1KDdq7/sVsMiqzQuekHajSesd6Py/G2aUsj45HUwHrO0Hz
 l2BY/PxLo0a53WKpf8McKFnzXFwEXmeLt/VBvHnLglRmD5UO4y/hr8DhcO1MRMV2xVd3
 6pIzP298+3/balL69SalBBwCVYrrEX0llz7vpHNHu230X6L8lcrwdlTwnYJt9drzXpHe
 RdP9UJk18S512v+tZt5qVc0zvf7pDn9+rGvRcG3SPXknKzdgq53l5aZo8qmPb6yQS8cJ
 C0lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXC/4naRC5/WAYDDW2f/HXwynX4w6+SvA0i3+7VmAWJap5xzXaqoPFL2q53blLdvw+wrIsD78A=@lists.denx.de
X-Gm-Message-State: AOJu0Yyfex6r0yQ+YULvxxLdbBZZH3waY4dHiVDBhaEsJbZZ2xF7tHHn
 WWOYtyCgUnYbhSNYlr+qsDIo0muXizVZFFPGmmiNZ71C4spfUIYRJbkXvvLfxouAch0tP/Kf+dh
 pADYcEDeKZ2NmIpkQk7HSs6IU6T4=
X-Gm-Gg: ASbGncsmeJIUKtp4FbGWv/rrerZqVBxHdeBytNucpuvICF4Rrd59Nq8hwClKJotIZdz
 HBuKbVSoJg8VZ1upSxN8VbssJYG4yC61fLifqrS30wPv5enexjzcrTVhHmZyWX2aSqg==
X-Google-Smtp-Source: AGHT+IFfTCsfY+uYeE0RfRXD3/NE7/2OAO9adoLXom6xKKMvPsK21Qm+l2qjsdpOS4yWwm/BujiU9hOqcscCW6oRJUQ=
X-Received: by 2002:a05:651c:1145:b0:2fb:5014:c963 with SMTP id
 38308e7fff4ca-2ffa7123f4fmr77275121fa.20.1732617173070; Tue, 26 Nov 2024
 02:32:53 -0800 (PST)
MIME-Version: 1.0
References: <20241121142522.59059-1-heinrich.schuchardt@canonical.com>
 <mvmjzcwobi0.fsf@suse.de>
 <e6eadaccaeef3b902d15dba7f634a7225318f1bb.camel@suse.com>
 <CANV2PTNJScKtwS-u3FL6jeZM1xhXnF-+OWn8Z1q8ABRTiLg0Dw@mail.gmail.com>
In-Reply-To: <CANV2PTNJScKtwS-u3FL6jeZM1xhXnF-+OWn8Z1q8ABRTiLg0Dw@mail.gmail.com>
From: E Shattow <lucent@gmail.com>
Date: Tue, 26 Nov 2024 02:32:41 -0800
Message-ID: <CANV2PTMPd14MR2xJ-nAHp+xj-xrtq6qSveq2-BV9Tz-0xrQ2Yw@mail.gmail.com>
Subject: Re: [PATCH 0/2] configs: JH7110: enable EFI_LOADER_BOUNCE_BUFFER
To: Loic Devulder <ldevulder@suse.com>
Cc: Andreas Schwab <schwab@suse.de>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Minda Chen <minda.chen@starfivetech.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Rick Chen <rick@andestech.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Hal Feng <hal.feng@starfivetech.com>,
 Tom Rini <trini@konsulko.com>, Chanho Park <chanho61.park@samsung.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Nam Cao <namcao@linutronix.de>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
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

On Mon, Nov 25, 2024 at 10:32=E2=80=AFPM E Shattow <lucent@gmail.com> wrote=
:
>
> On Fri, Nov 22, 2024 at 6:33=E2=80=AFAM Loic Devulder <ldevulder@suse.com=
> wrote:
> >
> > Hi guys!
> >
> > I played with latest openSUSE TW image [1] for VisionFive2 and I also h=
ad an issue but not exactly
> > the same Andreas had. Booting the OS from an sdcard gave me the grub cl=
i but not the menu. With
> > Heinrich's patch I was able to boot on grub menu as fully boot the OS a=
s well.
> >
> > Tested-by: Loic Devulder <ldevulder@suse.com>
> >
> > --
> > Loic Devulder <ldevulder@suse.com>
> > Senior QA Engineer | SUSE Software Solutions
> >
> > [1] -
> > https://download.opensuse.org/ports/riscv/tumbleweed/images/openSUSE-Tu=
mbleweed-RISC-V-JeOS-starfivevisionfive2.riscv64-2024.11.10-Build1.19.raw.x=
z
> >
> > On Thu, 2024-11-21 at 16:24 +0100, Andreas Schwab wrote:
> > > On Nov 21 2024, Heinrich Schuchardt wrote:
> > >
> > > > Our MMC driver for JH7110 boards only supports reading to the low 4=
 GiB of
> > > > memory. Booting boards with more memory requires EFI_LOADER_BOUNCE_=
BUFFER.
> > >
> > > That doesn't change the situation with the booting problem I have.
> > >
>
> What was this series supposed to do and how to test for it properly?
> I did not see any difference, still just failure on 4GB and 8GB DRAM
> ... is my testing method wrong?
>
> -E

Postscript:  After some discussion with Sughosh we find that yes I am
testing this code path but "the logic of addr_aligned() needs to be
changed". This series is correct but the commit description is
confusing by omission of information: There is a 1GB offset in address
space to DRAM, and so any board with more than 3GB DRAM are affected.
If reading the commit message without knowing this information it
seems like 4GB DRAM board would not be affected but such address space
goes to 5GB. I was hoping for some reply from Heinrich to resolve why
testing results are not consistent and to offer a clearer commit
message before the pull request.

With that, and my thanks to Heinrich for speedy bug fixing,

Tested-by: E Shattow <lucent@gmail.com>
