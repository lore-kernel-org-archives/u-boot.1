Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CBDEC4332F
	for <u-boot@archiver.kernel.org>; Tue, 31 Oct 2023 07:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C62687AF4;
	Tue, 31 Oct 2023 08:04:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="qH3NrNOh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAE4987AF6; Tue, 31 Oct 2023 08:03:59 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA5487A22
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 08:03:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahiroy@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 337E6B8077F
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:03:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA80C43395
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 07:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1698735835;
 bh=KOt/6Bh0881X6hZfLd45iFiPDRPO/IaJmQQYpuDVKI0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=qH3NrNOh96Z0KT5JpxiiCbHuAKKZVgpNG+8L6k+NNrguvROADqrZbB3itVpz1X+gp
 iczt8jT1rGDuxzIbPidyppB7NqyIfAYSeIvPvXWeBhU+FKNaBkv2NQptJh03VACA+7
 /pJE+B8r5lS2s37CL/BTD5WvLJygnBbd3hzU8KiqSepB4kzV9rL+5NfCwsWvnHL+Fq
 LS+R6gN5Bhg9Ll01u2O/KpqMsR+kaTkA0WqXtx/a9iJVJCRURy+fG9QxiOFNtvIOqU
 PxRYQWwS+kAT3k9vwN5V/aCyF4pFprGqBvSXpYTWav4+q3i6/MhF70NBTpmGQjvo/K
 R4BJOSC7XPLqA==
Received: by mail-oi1-f173.google.com with SMTP id
 5614622812f47-3b2e72fe47fso3490352b6e.1
 for <u-boot@lists.denx.de>; Tue, 31 Oct 2023 00:03:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz6aHwuegG6ePj3u+KoVAHZAW5b+1PpSUQdMXdyxvsMMGCGe4hm
 /vL0zyAZM+MT87RaNS/sQINOOEbetuBCq8f/sak=
X-Google-Smtp-Source: AGHT+IFhQbL2GXvlStOCa9WbIcCqYEWgNQXQ5SvyyYzHaZ0dCtw7TrWnmT++4MnCQr/b51E4av5FWAhY1H0ZF2//3r8=
X-Received: by 2002:a05:6870:4c05:b0:1e9:d158:2465 with SMTP id
 pk5-20020a0568704c0500b001e9d1582465mr14892187oab.17.1698735834939; Tue, 31
 Oct 2023 00:03:54 -0700 (PDT)
MIME-Version: 1.0
References: <20231026072628.4115527-1-sjg@chromium.org>
 <20231026072628.4115527-4-sjg@chromium.org>
 <CAK7LNASATGRaS-6QxzqTEq7qNVkZPXOBE8pfRBg=2bQGyy3=yw@mail.gmail.com>
 <CAFLszThguWT0u0R0EHfpBro0f-pWDwLOGk+5pQZEVhFYNKH8fQ@mail.gmail.com>
 <ZT/NRvLkvR8uuP5+@shell.armlinux.org.uk>
 <20231030161209.GU496310@bill-the-cat>
In-Reply-To: <20231030161209.GU496310@bill-the-cat>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Tue, 31 Oct 2023 16:03:18 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=K9Az9UN0O-tCC6VFwMWgdNJUcHBmmQTn5-Y7_m8OOQ@mail.gmail.com>
Message-ID: <CAK7LNAQ=K9Az9UN0O-tCC6VFwMWgdNJUcHBmmQTn5-Y7_m8OOQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: boot: Support Flat Image Tree
To: Tom Rini <trini@konsulko.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Simon Glass <sjg@chromium.org>, linux-arm-kernel@lists.infradead.org, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Nick Terrell <terrelln@fb.com>, Nicolas Schier <nicolas@fjasle.eu>,
 Will Deacon <will@kernel.org>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Oct 31, 2023 at 1:12=E2=80=AFAM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, Oct 30, 2023 at 03:35:34PM +0000, Russell King (Oracle) wrote:
> > On Sun, Oct 29, 2023 at 05:46:12AM +1300, Simon Glass wrote:
> > > Hi Masahiro,
> > >
> > > Sure, but that is a separate issue, isn't it? We already support
> > > various boot targets in arm64 but not one that includes the DTs, so
> > > far as I can see. The old arm 'uImage' target is pretty out-of-date
> > > now.
> >
> > Does that mean it can be removed? ;)
> >
> > I've NAK'd FIT support on 32-bit Arm in the past, and I remain of the
> > opinion that boot loader specific packaging of the kernel should not
> > be in the kernel but should be external to it - even more so given the
> > multi-platform nature of 32-bit Arm kernels.
>
> I'll point it out here rather than Simon. As part of
> https://github.com/open-source-firmware FIT is a standard and not "boot
> loader specific". And one of the points of a FIT image is that you can
> easily support multi-platform kernels in a single file (without
> optimizing things further, at a cost in tens of milliseconds on a Pi 3
> anyhow) and with user-controlled security.
>
> --
> Tom



It is a copy of the document in U-Boot.

The file was split into two, but the content is the same.


[original in U-Boot]
https://github.com/u-boot/u-boot/blob/v2023.10/doc/usage/fit/source_file_fo=
rmat.rst


[flat-image-tree]
https://github.com/open-source-firmware/flat-image-tree/blob/v0.8/source/ch=
apter1-introduction.rst
https://github.com/open-source-firmware/flat-image-tree/blob/v0.8/source/ch=
apter2-source-file-format.rst





--
Best Regards
Masahiro Yamada
