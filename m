Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B727C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 17:11:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 86A268312C;
	Tue, 27 May 2025 19:11:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gd6i689g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49C258312E; Tue, 27 May 2025 19:11:34 +0200 (CEST)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CCF830AB
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 19:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-47688ae873fso33072461cf.0
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 10:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748365890; x=1748970690; darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mZavGpfKZXYqfMA+AjaTOA5VMR3z9mi+OCjWUKebQnY=;
 b=gd6i689gtJczIb81rl86QNmRB1n57gyNNVYHTZTF8k+JKBv7EYHJERbBbYgN1rcCi7
 Xz76xtFsT2GfJCsa/wGNSUYCidzu4byUyNaGpoqpJmcNf4gWGF5JXalKuUV9ULvqR5k/
 UP1mCHVn0qmDBku70maXKBqbwG+9kBUS5tMPFhmv5m/wzUktD+xbOYWiVG5i+rY3dLq4
 pGN7X0tEW6lkygZjhZq8SRdZdpbuAKLuMcYjDOvEuUR8KNQgT+QzWlUwywN4ePhgy3Yo
 Ad9ObtgPUgNgHWtDch30yuwx1wVRlzUqrrs4vSxvTJ8U5pCAZp0xNPsoVhpj+n2SCcOW
 ffUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748365890; x=1748970690;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZavGpfKZXYqfMA+AjaTOA5VMR3z9mi+OCjWUKebQnY=;
 b=hrhzgKqhvEmbaTK2S+TaUfkNPpoXwlw9qpfheIv3kxpNdeXkQjN/7RJlzWIXjKo1v7
 /dMtzL77wnrh61/RZVc8EphAVX0AMF6snkV5ceKUfyw5QKhk36ascanRYZdl5tuSiESd
 YGy/H7631g4AslJ3hxfHy/1QqUx1Uny6irmh+CYCUdEV8BmoqM+RW5Ji4Eq/DPUFnJvK
 8HYipFvSlodnd5TQP+QBhOE2JWhlnMhvsVhdxv94dLNqCmuPJfwZBKPjx7CaB5VqtiBl
 CfHafdhaJkvev8QZXMs/VTodO3HKiDfv/P35A0tQ9LN7qDFI7OFi7HmrFN9kEt5NQJUA
 9lNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8leVaKzVaU7hZq5wDHkOuj56HsaeEqoFlPsxsOKpXiEY5l4n3ReWACB2VhmqezyHJXybopPQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yz5ba3XhUPWmFcZoWNJ3OzeHpYL03UL5OkuM63YGNjixIlC+sjU
 pNBCdTzG4QZnPBA+EaAq9gUK86/aWcUmosN/jkOzglowFBeRC6pz8L7aW2cgmEKK44bpIl5/o7q
 k6p7E5WZ6bogellotJwhnCtwbEyrV7LFnYPUtkeiSIA==
X-Gm-Gg: ASbGnctLd6bPpYAuat090bJHfmGV7azRIHNTke/kraiymPB3vDUE1xQIJcztgLbr/HD
 8+WZJtheYb0mXvGNYbwA7QIWSyPYsPjI1Ffv9BbiM0VRzR6J2jjjgRZccK8oJCtbuZANlaB6bIy
 7mFAK1fVi5rS225u5dYr917WcQnsFULxnIB3/sk26QSUzrptvjKzygRmWS46+Z4SUCZg0=
X-Google-Smtp-Source: AGHT+IGs4nfF/Ej6BaouAZly7LrSXNDK/M5mYpYqLpIErPsoS0uXPMw3ofOp+FciiMlQInjBQOzXK+zgC2s/pvQ5Jsc=
X-Received: by 2002:a05:622a:5e13:b0:476:909b:8287 with SMTP id
 d75a77b69052e-49f46e45f6fmr244209491cf.20.1748365889655; Tue, 27 May 2025
 10:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud> <aC9TmaY7w2PL8lbn@pie.lan>
 <CAN37VV4y58GeqbviFaJDCr1vqLc5tKaTcBLg4_PmeHF-As6tAw@mail.gmail.com>
 <20250526-disband-cover-cdc6567452f2@spud>
 <20250526145636.GX100073@bill-the-cat>
 <CAN37VV6SLVFmfxjbhs8YYEBpzdE8FqjstNh5Xw+DAUx5tC05FQ@mail.gmail.com>
 <20250526181631.GA100073@bill-the-cat>
In-Reply-To: <20250526181631.GA100073@bill-the-cat>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Tue, 27 May 2025 22:40:53 +0530
X-Gm-Features: AX0GCFsvmd6rpIeWQ63Dmw7Jr3mX7bKxdtkQnsCdL_vB0vKZhUPtq9qC1tamYw0
Message-ID: <CAN37VV5q16APZnaS4cEwHaZRUTw7H_NZAMWYc0Wt6CaMzVpjUQ@mail.gmail.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, Yao Zi <ziyao@disroot.org>, 
 Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de, rick@andestech.com
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

On Mon, May 26, 2025 at 11:46=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Mon, May 26, 2025 at 11:04:02PM +0530, Mayuresh Chitale wrote:
> > On Mon, May 26, 2025 at 8:26=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Mon, May 26, 2025 at 10:17:54AM +0100, Conor Dooley wrote:
> > > > On Mon, May 26, 2025 at 09:02:46AM +0530, Mayuresh Chitale wrote:
> > > > > On Thu, May 22, 2025 at 10:11=E2=80=AFPM Yao Zi <ziyao@disroot.or=
g> wrote:
> > > > > >
> > > > > > On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> > > > > > > On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > > > > > > > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
> > > >
> > > > > > > This PR seems to have made my CI blow up, and I'm not
entirely sure if
> > > > > > > that's something intentional or not. I've not yet bisected,
but since
> > > > > > > the error is "Image arch not compatible with host arch", I
can only
> > > > > > > imagine the patch in question is:
> > > > > > > | Subject: [PATCH v2 1/3] riscv: image: Add new image type
for RV64
> > > > > > > | Date: Fri,  4 Apr 2025 14:48:55 +0000       [thread
overview]
> > > > > > > | Message-ID: <
20250404144859.112313-2-mchitale@ventanamicro.com> (raw)
> > > > > > > | In-Reply-To: <
20250404144859.112313-1-mchitale@ventanamicro.com>
> > > > > > > |
> > > > > > > | Similar to ARM and X86, introduce a new image type which
allows u-boot
> > > > > > > | to distinguish between images built for 32-bit vs 64-bit
Risc-V CPUs.
> > > > > > > |
> > > > > > > | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > > > > > > | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> > > > > > > | ---
> > > > > > > |  boot/image.c    | 3 ++-
> > > > > > > |  include/image.h | 3 ++-
> > > > > > > |  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > > > > |
> > > > > > > | diff --git a/boot/image.c b/boot/image.c
> > > > > > > | index 139c5bd035a..45299a7dc33 100644
> > > > > > > | --- a/boot/image.c
> > > > > > > | +++ b/boot/image.c
> > > > > > > | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[]
=3D {
> > > > > > > |     {       IH_ARCH_ARC,            "arc",          "ARC",
         },
> > > > > > > |     {       IH_ARCH_X86_64,         "x86_64",       "AMD
x86_64",   },
> > > > > > > |     {       IH_ARCH_XTENSA,         "xtensa",
"Xtensa",       },
> > > > > > > | -   {       IH_ARCH_RISCV,          "riscv",
 "RISC-V",       },
> > > > > > > | +   {       IH_ARCH_RISCV,          "riscv",        "RISC-V
32 Bit",},
> > > > > > > | +   {       IH_ARCH_RISCV64,        "riscv64",      "RISC-V
64 Bit",},
> > > > > > > |     {       -1,                     "",             "",
        },
> > > > > > > |  };
> > > > > > > |
> > > > > > > | diff --git a/include/image.h b/include/image.h
> > > > > > > | index 07912606f33..411bfcd0877 100644
> > > > > > > | --- a/include/image.h
> > > > > > > | +++ b/include/image.h
> > > > > > > | @@ -138,7 +138,8 @@ enum {
> > > > > > > |     IH_ARCH_ARC,                    /* Synopsys DesignWare
ARC */
> > > > > > > |     IH_ARCH_X86_64,                 /* AMD x86_64, Intel
and Via */
> > > > > > > |     IH_ARCH_XTENSA,                 /* Xtensa       */
> > > > > > > | -   IH_ARCH_RISCV,                  /* RISC-V */
> > > > > > > | +   IH_ARCH_RISCV,                  /* RISC-V 32 bit*/
> > > > > > > | +   IH_ARCH_RISCV64,                /* RISC-V 64 bit*/
> > > > > > > |
> > > > > > > |     IH_ARCH_COUNT,
> > > > > > > |  };
> > > > > > > | --
> > > > > > > | 2.43.0
> > > > > > > |
> > > > > > > since it is changing the existing "riscv" image type to be
the 32-bit
> > > > > > > image and requiring the new entry for 64-bit. My CI job uses
the system
> > > > > > > mkimage to create the image that U-Boot is loading, so it
doesn't know
> > > > > > > about the new define etc. Maybe it's not considered a problem
if a new
> > > > > > > U-Boot cannot boot an old image, but the comment above the
enum reads:
> > > > > > > |/*
> > > > > > > | * CPU Architecture Codes (supported by Linux)
> > > > > > > | *
> > > > > > > | * The following are exposed to uImage header.
> > > > > > > | * New IDs *MUST* be appended at the end of the list and
*NEVER*
> > > > > > > | * inserted for backward compatibility.
> > > > > > > | */
> > > > > > > The overwhelming majority of existing supported boards in
U-Boot are
> > > > > > > 64-bit platforms, and the 64-bit platforms are the ones that
have been
> > > > > > > supported for longer, so my thought would be that the
compatibility of
> > > > > > > 64-bit platforms should be prioritised over 32-bit? Or even
add explicit
> > > > > > > 32-bit and 64-bit entries and the existing one is a catch-all
for
> > > > > > > compatibility reasons?
> > > > > >
> > > > > > I've mentioned entries with bitwidth explicitly specified in my
previous
> > > > > > reply (and there hasn't been any response).
> > > > > >
> > > > > > > I'll consider IH_ARCH_RISCV32 a better idea, instead of
implying 32bit
> > > > > > > when no suffix attached. We (and the Linux kernel) mix 32-bit
and 64-bit
> > > > > > > variants of RISC-V together, thus it's hard to tell the exact
bitwidth
> > > > > > > of "IH_ARCH_RISCV" without inspecting the code around. To me,
it sounds
> > > > > > > more like "RISC-V, but no bitwidth specified".
> > > > > > >
> > > > > > > It will be nice if we could avoid this kind of ambiguity.
> > > > > >
> > > > > > (referring my own reply[1])
> > > > > >
> > > > > > I'll second explicit 32-bit and 64-bit entries, and keeping
> > > > > > IH_ARCH_RISCV for compatibility consideration.
> > > > > >
> > > > > Are you suggesting something like this :
> > > > >
> > > > > { IH_ARCH_RISCV, "riscv", "RISC-V",},
> > > > > { IH_ARCH_RISCV32, "riscv32", "RISC-V 32 Bit",},
> > > > > { IH_ARCH_RISCV64, "riscv64", "RISC-V 64 Bit",},
> > > > >
> > > > > I tried to implement it like on ARM64. However the problem is tha=
t
> > > > > while on ARM64 it switches to aarch32 if it encounters an
IH_ARCH_ARM
> > > > > kernel image, there is no equivalent mechanism for Risc-V yet.
> > > >
> > > > But we don't even want that, since the current behaviour on a 64-bi=
t
> > > > system is not to do anything 32-bit related, right? My 64-bit image=
s
> > > > created with my system mkimage use IH_ARCH_RISCV.
> > > >
> > > > > Another
> > > > > option could be to disable this check in the bootm flow for now
until
> > > > > a similar mechanism is implemented on Risc-V.
> > > >
> > > > Why not just allow IH_ARCH_RISCV to retain the current "dumb"
behaviour
> > > > permanently, and only implement the strict checking when the
explicit
> > > > width types are detected?
> > >
> > > This seems most reasonable to me for the current situation.
> >
> > Ok. In that case, I think the patch set needs to be reverted.
>
> Please post a revert and Link: to this thread, thanks!
Ok. I am wondering how this problem can be solved as there would always be
older versions of tools or images etc which won't be compatible with this
change.
>
> --
> Tom
