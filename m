Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E9EC54FB3
	for <u-boot@archiver.kernel.org>; Mon, 26 May 2025 17:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BA1D82E67;
	Mon, 26 May 2025 19:34:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="S0NurIu5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3DEF82E8C; Mon, 26 May 2025 19:34:42 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B81182E37
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 19:34:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6faa19e0661so20572186d6.3
 for <u-boot@lists.denx.de>; Mon, 26 May 2025 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1748280879; x=1748885679; darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2VYG0B+lIUm1mqHprYEhA1RnrbC7X4YygChS0CTIe+U=;
 b=S0NurIu5xB8QrqGpyrIxoGYHIBEZJCclRZbuw5V9kB3d/8HJnlO5lUKB/jOvcg3b/J
 9zAPHAUThYXXph1kC+xbpoSHD9aEtQnQrPozdki3RvWqHHJxExV0w6z1JQHtpEZYF+4U
 AakH9BZr0xdIqYUFPAEPTgR9R/dKD3LMvNNxLIMBJghTmm41atBycHbfaJYsrdnSneh/
 8Was6mIZ9bJzpf7fH8Ox6qZ/bX9ZErLVyNPEJzTn0sIXb5xust2GFzHfxa3GnDrzRbhn
 dCHB2/9zeThRJlsTnvDlk3msl/NJS+SzsH6Z0Zfrqz1vClzsFs3JsMM23C8xpBpwSOn4
 bSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748280879; x=1748885679;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2VYG0B+lIUm1mqHprYEhA1RnrbC7X4YygChS0CTIe+U=;
 b=ISRiU4cNgtEkpPL3ggequ4f78FfRa7m2HVJM7lFEyT+GUR9uV+M3SzuwDNIqwg8bPf
 OW0/rxeyzUBFoj/BcWGFQHHN6a9d9cio2UGGyHRfGyIaU90JMPrAEc5lPU2bS27xmwEF
 Yvr0LArmKyXwVmNOaIvwrNALlhjzMbROh9KynevS/abBoe4ssaVMifqZBeI8fn6srWyT
 nkz9nKbba0Aqrk2IzYFwBFZKKmLwwO43Tg2rPWuNmXIl9Jl3wlszE7RQ6RGZvfOoZRgM
 GOlBSPTpPOr1Hw0vsxSi3qGHH8V/2zcGyA/6NuPs7IY0+HRZs9KhRPz/D/SD2zjs7GWB
 aiPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7Fub/kwRPZmpPPh6GTJfEDIWxUuY/FfKVPtaGohoOLUpnL9TJKfQtzJkG5HQey+9B+AjZTRc=@lists.denx.de
X-Gm-Message-State: AOJu0YwTtzugbkYhHk7zwxxGRA+t7zmVTtvwqZyqbYlsVV4lqU2/4Rk5
 EXAbubbd7XytYl81i2UxAUZIAHrhxhHjdMdnD1y5gTUtY1ZHvOSgUhyPhCdovQGa3w5Ay1lqZFl
 ZcJ50ePpAhElcZt4m20VCQKgkJsgl+hVhULGTO606MQ==
X-Gm-Gg: ASbGncvYJmaEK/VMF794EqO6iXiTudeH2iYq98PRUaUeBZAmW+xnnPHNNBkbBEA1Gm/
 b/2GZL6hjPKqHLTn429H3zsuYt3jwoUuIlvH+rcDyL50zPo5Hmg9nD7dUH5anSWVFGjEOpMEcOo
 /tw+fp6daYxp7vEbgw++RM6oEmj3kXtFy6CnnADMeA3YRSCcd/pTMsa2FzbazNcJKluno=
X-Google-Smtp-Source: AGHT+IFfdxpunVnCOROkAly5IV3HG54TwggRTi1s81RyMumPkZivcqxqskG2Msh3xjKT4pWahLjVcMfVBbsgbIUpVBo=
X-Received: by 2002:a05:622a:59c8:b0:480:7147:1998 with SMTP id
 d75a77b69052e-49f4674dce1mr145431821cf.22.1748280879018; Mon, 26 May 2025
 10:34:39 -0700 (PDT)
MIME-Version: 1.0
References: <aC2hyzxwKzO4k1im@swlinux02>
 <174785279069.2062062.17616710293064147131.b4-ty@konsulko.com>
 <20250522-eradicate-clip-538f48710ad7@spud> <aC9TmaY7w2PL8lbn@pie.lan>
 <CAN37VV4y58GeqbviFaJDCr1vqLc5tKaTcBLg4_PmeHF-As6tAw@mail.gmail.com>
 <20250526-disband-cover-cdc6567452f2@spud>
 <20250526145636.GX100073@bill-the-cat>
In-Reply-To: <20250526145636.GX100073@bill-the-cat>
From: Mayuresh Chitale <mchitale@ventanamicro.com>
Date: Mon, 26 May 2025 23:04:02 +0530
X-Gm-Features: AX0GCFsA12_89ihj3xjpSNUUf5lIYrRyg0MeISSb8PGY6NEsxyjYJkBc-pJrV4s
Message-ID: <CAN37VV6SLVFmfxjbhs8YYEBpzdE8FqjstNh5Xw+DAUx5tC05FQ@mail.gmail.com>
Subject: Re: [GIT PULL] u-boot-riscv/master
To: Tom Rini <trini@konsulko.com>
Cc: Conor Dooley <conor@kernel.org>, Yao Zi <ziyao@disroot.org>, 
 Leo Liang <ycliang@andestech.com>, u-boot@lists.denx.de, rick@andestech.com
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

On Mon, May 26, 2025 at 8:26=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Mon, May 26, 2025 at 10:17:54AM +0100, Conor Dooley wrote:
> > On Mon, May 26, 2025 at 09:02:46AM +0530, Mayuresh Chitale wrote:
> > > On Thu, May 22, 2025 at 10:11=E2=80=AFPM Yao Zi <ziyao@disroot.org> w=
rote:
> > > >
> > > > On Thu, May 22, 2025 at 12:28:18PM +0100, Conor Dooley wrote:
> > > > > On Wed, May 21, 2025 at 12:39:50PM -0600, Tom Rini wrote:
> > > > > > On Wed, 21 May 2025 17:50:03 +0800, Leo Liang wrote:
> >
> > > > > This PR seems to have made my CI blow up, and I'm not entirely su=
re if
> > > > > that's something intentional or not. I've not yet bisected, but s=
ince
> > > > > the error is "Image arch not compatible with host arch", I can on=
ly
> > > > > imagine the patch in question is:
> > > > > | Subject: [PATCH v2 1/3] riscv: image: Add new image type for RV=
64
> > > > > | Date: Fri,  4 Apr 2025 14:48:55 +0000       [thread overview]
> > > > > | Message-ID: <20250404144859.112313-2-mchitale@ventanamicro.com>=
 (raw)
> > > > > | In-Reply-To: <20250404144859.112313-1-mchitale@ventanamicro.com=
>
> > > > > |
> > > > > | Similar to ARM and X86, introduce a new image type which allows=
 u-boot
> > > > > | to distinguish between images built for 32-bit vs 64-bit Risc-V=
 CPUs.
> > > > > |
> > > > > | Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
> > > > > | Reviewed-by: Maxim Moskalets <maximmosk4@gmail.com>
> > > > > | ---
> > > > > |  boot/image.c    | 3 ++-
> > > > > |  include/image.h | 3 ++-
> > > > > |  2 files changed, 4 insertions(+), 2 deletions(-)
> > > > > |
> > > > > | diff --git a/boot/image.c b/boot/image.c
> > > > > | index 139c5bd035a..45299a7dc33 100644
> > > > > | --- a/boot/image.c
> > > > > | +++ b/boot/image.c
> > > > > | @@ -92,7 +92,8 @@ static const table_entry_t uimage_arch[] =3D =
{
> > > > > |     {       IH_ARCH_ARC,            "arc",          "ARC",     =
     },
> > > > > |     {       IH_ARCH_X86_64,         "x86_64",       "AMD x86_64=
",   },
> > > > > |     {       IH_ARCH_XTENSA,         "xtensa",       "Xtensa",  =
     },
> > > > > | -   {       IH_ARCH_RISCV,          "riscv",        "RISC-V",  =
     },
> > > > > | +   {       IH_ARCH_RISCV,          "riscv",        "RISC-V 32 =
Bit",},
> > > > > | +   {       IH_ARCH_RISCV64,        "riscv64",      "RISC-V 64 =
Bit",},
> > > > > |     {       -1,                     "",             "",        =
     },
> > > > > |  };
> > > > > |
> > > > > | diff --git a/include/image.h b/include/image.h
> > > > > | index 07912606f33..411bfcd0877 100644
> > > > > | --- a/include/image.h
> > > > > | +++ b/include/image.h
> > > > > | @@ -138,7 +138,8 @@ enum {
> > > > > |     IH_ARCH_ARC,                    /* Synopsys DesignWare ARC =
*/
> > > > > |     IH_ARCH_X86_64,                 /* AMD x86_64, Intel and Vi=
a */
> > > > > |     IH_ARCH_XTENSA,                 /* Xtensa       */
> > > > > | -   IH_ARCH_RISCV,                  /* RISC-V */
> > > > > | +   IH_ARCH_RISCV,                  /* RISC-V 32 bit*/
> > > > > | +   IH_ARCH_RISCV64,                /* RISC-V 64 bit*/
> > > > > |
> > > > > |     IH_ARCH_COUNT,
> > > > > |  };
> > > > > | --
> > > > > | 2.43.0
> > > > > |
> > > > > since it is changing the existing "riscv" image type to be the 32=
-bit
> > > > > image and requiring the new entry for 64-bit. My CI job uses the =
system
> > > > > mkimage to create the image that U-Boot is loading, so it doesn't=
 know
> > > > > about the new define etc. Maybe it's not considered a problem if =
a new
> > > > > U-Boot cannot boot an old image, but the comment above the enum r=
eads:
> > > > > |/*
> > > > > | * CPU Architecture Codes (supported by Linux)
> > > > > | *
> > > > > | * The following are exposed to uImage header.
> > > > > | * New IDs *MUST* be appended at the end of the list and *NEVER*
> > > > > | * inserted for backward compatibility.
> > > > > | */
> > > > > The overwhelming majority of existing supported boards in U-Boot =
are
> > > > > 64-bit platforms, and the 64-bit platforms are the ones that have=
 been
> > > > > supported for longer, so my thought would be that the compatibili=
ty of
> > > > > 64-bit platforms should be prioritised over 32-bit? Or even add e=
xplicit
> > > > > 32-bit and 64-bit entries and the existing one is a catch-all for
> > > > > compatibility reasons?
> > > >
> > > > I've mentioned entries with bitwidth explicitly specified in my pre=
vious
> > > > reply (and there hasn't been any response).
> > > >
> > > > > I'll consider IH_ARCH_RISCV32 a better idea, instead of implying =
32bit
> > > > > when no suffix attached. We (and the Linux kernel) mix 32-bit and=
 64-bit
> > > > > variants of RISC-V together, thus it's hard to tell the exact bit=
width
> > > > > of "IH_ARCH_RISCV" without inspecting the code around. To me, it =
sounds
> > > > > more like "RISC-V, but no bitwidth specified".
> > > > >
> > > > > It will be nice if we could avoid this kind of ambiguity.
> > > >
> > > > (referring my own reply[1])
> > > >
> > > > I'll second explicit 32-bit and 64-bit entries, and keeping
> > > > IH_ARCH_RISCV for compatibility consideration.
> > > >
> > > Are you suggesting something like this :
> > >
> > > { IH_ARCH_RISCV, "riscv", "RISC-V",},
> > > { IH_ARCH_RISCV32, "riscv32", "RISC-V 32 Bit",},
> > > { IH_ARCH_RISCV64, "riscv64", "RISC-V 64 Bit",},
> > >
> > > I tried to implement it like on ARM64. However the problem is that
> > > while on ARM64 it switches to aarch32 if it encounters an IH_ARCH_ARM
> > > kernel image, there is no equivalent mechanism for Risc-V yet.
> >
> > But we don't even want that, since the current behaviour on a 64-bit
> > system is not to do anything 32-bit related, right? My 64-bit images
> > created with my system mkimage use IH_ARCH_RISCV.
> >
> > > Another
> > > option could be to disable this check in the bootm flow for now until
> > > a similar mechanism is implemented on Risc-V.
> >
> > Why not just allow IH_ARCH_RISCV to retain the current "dumb" behaviour
> > permanently, and only implement the strict checking when the explicit
> > width types are detected?
>
> This seems most reasonable to me for the current situation.

Ok. In that case, I think the patch set needs to be reverted.
>
> --
> Tom
