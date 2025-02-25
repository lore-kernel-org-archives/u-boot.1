Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E43C6C021A4
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 02:21:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E63A580EC0;
	Tue, 25 Feb 2025 03:21:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="COhuh3Vt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C08780F56; Tue, 25 Feb 2025 03:21:15 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25DB5807B1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 03:21:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cfsworks@gmail.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-aaee2c5ee6eso735636666b.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 18:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740450072; x=1741054872; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U8um7SPz7r8GLvS2SNa7fjyZMCIRhayXx9P/Zl/jipI=;
 b=COhuh3VtpvI92ngeId4CEcTOBvj/OuzBXur2fta6CkNMOLNdh3Y71e7MuE2zgBCJkp
 4DcPscWnAjAmMJZxne7Av73seoNBIr3BlJYYSFFHvWNvkumfGUeBYhgveY2a3vtNIqTy
 CiNyLDZM8vp9S3PEn4OIqT6icaIuPUQ3CswCf9STzyPiddPbFHjW+aY/lroUDw5/+qqq
 T8CcMuce5weD46Zzq6r+bYGbww/XHJxr/WZ2aCwwr75OOwe50ncvo5a9ycEAT9kqhqVC
 U1EpBDCYP1K0kO/UN1uwj31H8EjLIr0M88a7d3PInY+SU+2AQEvzAKYbqEwjgU8OQl0P
 Od1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740450072; x=1741054872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U8um7SPz7r8GLvS2SNa7fjyZMCIRhayXx9P/Zl/jipI=;
 b=SU+V44shk2mOgJHP36PHqZpv0ntH0J+ODCB4A7jRqA6InQdqzeFaAu6Zpp3gPPfffb
 Z012Ti7pdr0q+62jAFnGc5XfvDe+J590MrUnwNUNN6v2cdGEeOVuSErtb090bVawB9mI
 NmEt0FUl6cmoSTZ5M4oiNOp5WpKpI34XlfdPhXttQMSP5SirM9o+qJIf76gjRrkJahtz
 f+TAo7TuAzjRZ4hwepLQhImy8HYMdLPnSBj3OCHohE/mqX/1OY/CHy47JBSb7XCzSkzU
 EeshxCQ4qBULu26q+IlOaPOVmAuILitFMIVtLhI8o5WBs0hvwNG3oMJbhbUwLHYMA2Pw
 MSrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXs0CA9p+RA702X34IywqeE3uvXD1G4HGUMl8OwTZdOI8FMRi9nAoK+3BphZHuMfgqOBQwC/s=@lists.denx.de
X-Gm-Message-State: AOJu0YyDnF0p/jUQEwU982gYj7x3c0vwnTorKOmFT4lSXpxXXDQNIHaL
 ATGulouhDFsiFm823dZI1FszClzUhkx1CqLjanrhaBBUyBh/MSeOqLJ9lHAfvLHm6aSdLqWcb0y
 0K3WQrFA1sWRnpduPyV3rDAs2xZ9GKRHB
X-Gm-Gg: ASbGncs/jcMW/l9nej3XCGWVY8n+HYs29XABQCutn7Bsa3KYOhV+1tXCcpdxolpIkWd
 lU+pt6OQZYk1xAutO1CLdwNG8++pVEkP+P11XQMOOuy12OHAGb41gvVt/xZ0ZKPKV7fdv0NKN/a
 eBJ766sf0AqYTGMHah+ODkcV4/ktilgBlFW4FEj6HN
X-Google-Smtp-Source: AGHT+IGS72GSySggsA43zZJFQs32igdPmydHXF/X2JnrNIvxhw0TWhRQktrYgnvZJ/SqAJCwaNVOkKSupAJDXEYJ474=
X-Received: by 2002:a17:906:2b16:b0:abe:b99f:8f28 with SMTP id
 a640c23a62f3a-abeb99fa9e9mr441122666b.31.1740450072203; Mon, 24 Feb 2025
 18:21:12 -0800 (PST)
MIME-Version: 1.0
References: <20250224055524.1334929-1-CFSworks@gmail.com>
 <20250224055524.1334929-16-CFSworks@gmail.com>
 <87f3793f-19ab-4282-8099-144440b21ad0@gmx.de>
In-Reply-To: <87f3793f-19ab-4282-8099-144440b21ad0@gmx.de>
From: Sam Edwards <cfsworks@gmail.com>
Date: Mon, 24 Feb 2025 18:21:00 -0800
X-Gm-Features: AWEUYZnJhC4fo7c9BDpYiOkN6gZDPA7YznVyiJXSTGdnwGkvOxIEgXUUqyyFbic
Message-ID: <CAH5Ym4i2dfCk4xnR+o66DUdbbwSdaNMAgTZK_1mtzU5zbMoyOg@mail.gmail.com>
Subject: Re: [PATCH 15/17] efi_loader: Remove ENTRY(_start) from linker script
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sumit Garg <sumit.garg@linaro.org>, Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
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

On Mon, Feb 24, 2025 at 1:37=E2=80=AFAM Heinrich Schuchardt <xypron.glpk@gm=
x.de> wrote:
>
> On 2/24/25 06:55, Sam Edwards wrote:
> > The EFI apps are built using ELF only as an intermediate "linker output=
"
> > format, with the final PE header crafted within the ELF to take effect
> > after the objcopy conversion to raw binary. As such, we really don't
> > care what the ELF header indicates as the entry point.
> >
> > Because nothing that uses this linker script even defines a _start
> > symbol, this directive has no effect. On GNU ld, it is silently ignored=
.
> > On certain linkers (e.g. LLVM lld), a warning is logged. But in any
> > case, no entry point is set.
>
> I can understand the first part of your reasoning. But the statement
> about _start is wrong. _start is defined on all EFI architectures, e.g.
>
> arch/arm/lib/crt0_aarch64_efi.S:147:
> _start
>
> arch/riscv/lib/crt0_riscv_efi.S:182:
> _start:
>
> Why does lld complain? Is it because we lack
>
>         .globl _start
>
> on ARM and RISC-V?

Hi Heinrich,

Yeah, pretty much. The .globl _start directive is required to turn
_start into a global symbol, rather than just a local label (which
might as well not even exist, as far as the linker is concerned).

I admit I only grepped in lib/efi* at first, but after looking in
arch/ it doesn't seem like anything creates this entry point for that
linker script to use (x86/64 do, but they have their own lds).

Cheers,
Sam

>
> Best regards
>
> Heinrich
>
> >
> > Therefore, remove it to silence warnings and avoid confusion.
> >
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >   lib/efi_loader/elf_efi.ldsi | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/lib/efi_loader/elf_efi.ldsi b/lib/efi_loader/elf_efi.ldsi
> > index 190a88fb69e..dc4d1a3660e 100644
> > --- a/lib/efi_loader/elf_efi.ldsi
> > +++ b/lib/efi_loader/elf_efi.ldsi
> > @@ -10,7 +10,6 @@ PHDRS
> >       data PT_LOAD FLAGS(3); /* SHF_WRITE | SHF_ALLOC */
> >   }
> >
> > -ENTRY(_start)
> >   SECTIONS
> >   {
> >       .text 0x0 : {
>
