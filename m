Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1E4D116F1
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 14:07:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 54A368457E;
	Fri, 28 Nov 2025 15:07:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="StCvGyzr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4862C84581; Fri, 28 Nov 2025 15:07:53 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1BCB84565
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 15:07:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-64162c04f90so3483884a12.0
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 06:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764338870; x=1764943670; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7npi6mmum1j3+mjyndjNEmM4ueFIHHGsattNJK+Fj6c=;
 b=StCvGyzrQQQdCWPcT8eMpDSRQaIfuIWAiJC4rX0Ts81XfbAI9EQ7WHCz2ywOivDHxx
 eNSJXlHXgkIFUbSANphFO7QdM0pQUr7hJT6tM1rxOntDLguB1hhg81wazKSyNmd7mCkV
 FVUpm+jNJ5Aaw2LcKTljmSqmZkIXZ8eT0OTuo7UYmed6Qv2agYMGzilcOcaaqdHOLlmI
 gkFGo4rF8sEhtdIpnYccKqlSSbxypXx+Jh+PUcngrsTa+6l/ZKP6OF+VIZVPfrJda89p
 XgJZUaUZYcWLC/s4NeYCNBXuzpj46ZbNNuDe83PrGdIE1Rq4ugispZ6J6ky2gykOosy2
 /3Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764338870; x=1764943670;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7npi6mmum1j3+mjyndjNEmM4ueFIHHGsattNJK+Fj6c=;
 b=uZfb67P09sWB2snio6zUxJXEX3+QXAmFAryT6boYdxMGICVvz1pr3MeoP+cp31N6Ap
 AEw6lKQhRS7byYFKyNVLWPxEJjX0uIAhzfYR4tO6Z91ZR4fBLFp9K1+NyaTu8RrC+v36
 T38WWyhoc9WOUimLaMKGXD1nADti8QKz/PUUoHRYKezmqjqg9+lXkdSkGhDTwZhS/anE
 SPJpvcZWbzsGIc+WWtOKPpmCGD0WpoZrTBlBpjMw0XLwBASoR9dYT4hYhXo3IGPQ8WxA
 +Z7TMa2copoSKBWsq8cPMRLzWsiVW8fuNY6zGtjvR4rpq36Q5RJVCJUPMb41MZCTIddq
 X1yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVerYYl16J5abkL6gLfqh7d23KnOm1VJ3ywXtiRz39zvFRRtOjGVRpwDOSlSt2rpC47fUPzJ2A=@lists.denx.de
X-Gm-Message-State: AOJu0YwTKi+G/z5Laxv9aUt9x8PIo1dPD+GXB2x0GN/TmmQ+wV53uAjL
 xT7EzwkWRSNN9rXKfNHhQ3f04H1WqMohw/831mCZ8mYuU0LJ/WMA85SJ8WOzQfWtCJPp0gOJARt
 wY684ZctRfn6j8GNXmBr+G+nTEn/rkMI=
X-Gm-Gg: ASbGncvyLSLFRHr1qH5aMkvr4JlZQxHnsW68E35bwyfYkPCQObtHgWtTYlMfTUZ8umW
 hs3PWTeNMvqcYblJ9bpUnK3Kj21L42um8MJgRK+QKH19VP2cR0NxSicSYTS9BFVUZsv6Mj8IZ1u
 J9OmZpOXD7jB65yyRow3cby6fnt+eqB3vkz8Djon9YCrGTG8Cf6acT6iqW/33EHSbPQZ7K+fR1g
 fMJZ/X9fTSp0TcG59aPW83bFYoTDJ+xsqrlPscluRazWw0TU0zGy94hFYsyZo9/3gphvMPwsOKX
 js+23kqsv27/XZLjCCNqd8NnCjQLrjSgoQIMV3fClr122pbF0LnCdyr9JPFaj4co8ahYNz5b7yw
 zMhgfi7QXNlp99ZiXzPvWIPTb2akZML83GApwpAxxGeXm9FGnCYtb6USL/y94RCVTl5/iF1Dfj9
 8=
X-Google-Smtp-Source: AGHT+IHcNrkchFeyRhtGRH9twpS/rAVP2euQjDkDdXFPMaPoSSkmQ87YGBxTjb4VpS4AFxN3NDk0dxuB4z7aacsYeLs=
X-Received: by 2002:a05:6402:274f:b0:645:cd64:31c5 with SMTP id
 4fb4d7f45d1cf-645cd6431f3mr16169917a12.26.1764338869950; Fri, 28 Nov 2025
 06:07:49 -0800 (PST)
MIME-Version: 1.0
References: <20251125102358.1850991-1-anders.roxell@linaro.org>
 <CALeDE9O4KOsRFsxZcnJxOVTzzJkn62k+bT=vgHa-k__qkjO0Yg@mail.gmail.com>
 <CADYN=9+atsqWkdBa+3jM-EhkNUyV-ZuJdtNqL6bZh6AsnkiSag@mail.gmail.com>
In-Reply-To: <CADYN=9+atsqWkdBa+3jM-EhkNUyV-ZuJdtNqL6bZh6AsnkiSag@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 28 Nov 2025 14:07:38 +0000
X-Gm-Features: AWmQ_bmwSShk9xHm6a3f6QRNNwGGQ5huk5xhTuS_IhLkcpbt92Nkly_mu4JQAe8
Message-ID: <CALeDE9OSBLFTamgmZfPVQgYe=n+-p180aGkE3+xRLx0GRc+h1A@mail.gmail.com>
Subject: Re: [RFC][PATCH] rpi: Fix DRAM size reporting to show total RAM
To: Anders Roxell <anders.roxell@linaro.org>
Cc: mbrugger@suse.com, trini@konsulko.com, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

On Tue, 25 Nov 2025 at 12:47, Anders Roxell <anders.roxell@linaro.org> wrote:
>
> On Tue, 25 Nov 2025 at 13:20, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > On Tue, 25 Nov 2025 at 10:25, Anders Roxell <anders.roxell@linaro.org> wrote:
> > >
> > > The VideoCore mailbox GET_ARM_MEMORY only reports the size of the
> > > first accessible memory region (~947 MiB on RPi4 with 8GB), not the
> > > total RAM. This causes U-Boot to display "DRAM: 947 MiB (total 7.9 GiB)"
> > > instead of "DRAM: 7.9 GiB".
> > >
> > > On Raspberry Pi 4 with 8GB RAM, the memory is split across multiple
> > > non-contiguous banks. The dram_init() function only sets gd->ram_size
> > > to the first bank size reported by the VideoCore firmware, while
> > > fdtdec_setup_memory_banksize() correctly populates all memory banks
> > > from the device tree.
> > >
> > > Fix this by updating gd->ram_size after dram_init_banksize() has
> > > populated all memory banks, so it reflects the actual total RAM
> > > across all banks.
> > >
> > > Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> >
> > Please add details as to why this is RFC? What comments are you actually after?
>
> I don't commit to u-boot that much, so I wasn't sure if this was the
> right thing to do.

Yup, all looked fine, I've applied it.
