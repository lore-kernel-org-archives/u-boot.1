Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21EBCD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 07:44:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A66683FEC;
	Mon,  8 Jun 2026 09:44:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fAmXEgBv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9FE28405A; Mon,  8 Jun 2026 09:44:46 +0200 (CEST)
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com
 [IPv6:2607:f8b0:4864:20::1130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21F24807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 09:44:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7dfe7712572so37301397b3.1
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 00:44:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780904683; cv=none;
 d=google.com; s=arc-20240605;
 b=CCnDZCfK8/HGox+47nOkS11yVdVQum3E2+LRgoA+hYWPpOLRnWIMLxyCFKmQyFzCYR
 AbNtp4TUPxmB529FW5iwbhvcam/eLjUb9m8YGW8lCP3NNbSAZjIWi0pVHD0dHXH7Hbfj
 8ol8DBD+rB/7rCx1d3WYXAGxANhg9Is0mqDEEzp+5tFZUF8WHBNHI03CZGS9p6qwWoCa
 KVLghsz9qlrb2BWQPFQviVpJPfz7M0Z25gBIvK2iR6plqDbpxEKcDQkweCeCVnBKIrTH
 lj/xBFenZzQ8+yKPEDqMUveCiEuiSkz4oFPWxiA93vBoo9/s1sul0slUPNKXDJwloguT
 2zNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ZqT9X690665YDPdFk1M5g7fSYJbfRbamY4d5Q++oL8Y=;
 fh=KoLvtkb1TT56IqL3jVqQuLC+jyp1v7Pp42eHi1+u9FY=;
 b=SYUewLDLzHwg4QUiwIlKmw9OgcVEWHvInJR+viqc73RnzUDAJFh6Y3JSgpfTBcRY3Y
 /MBTGaW6AhjPNuaS7iW5CMGdQEH6BPSSrGdDO9eiJM/g84HSna0oMIskXImuW/MA5GGe
 lrLTaOydjLU1NYojoVqvoelI1S/oUFdUJYkFzVGe7cpwxwFasEHTgiBpNaTcENdh+4ND
 n6d4KT6VXLhnNCrwVPTDHTT2SvwfM+dwADUpbaF1mW2mNi3qiHzBU6VFC3djldMlpQyA
 r8HFoBn5sdaBp+r1S110XPzFCFcypTGoSn+c+mMkOeQ0QmsoGojhHadq8YVMwj1mWrdh
 zMFQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780904683; x=1781509483; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZqT9X690665YDPdFk1M5g7fSYJbfRbamY4d5Q++oL8Y=;
 b=fAmXEgBvU6phDuaAPn3xCcBkXJbXv1JRf0GiO1Uc/MqZNm5atwXuKkEnI47t8yHWoh
 6V2RpGcv3qkIZOBIIxBS0E7jgqwEwshUamYfTpIDl085pKchNynMwnrndurnGsyVO3RE
 fbIfkyI+T7aD2qAyqJxxHWzbJJgc/qkJ1q5Yvuum5kpjqYOO5IQ4zQV0hmsPr7JSeSLt
 fBuiC2pAyS7fU/vN8eAayi9M90rZiCOb8Xb29jNP2CmfDZINWxwm+qgvTPcWIvsKXmqs
 BfOvPgv6rw3RWMr1LpnwdKcylRaS8+y0YZnPMpa4XNoZvw2K3C5quhibs+Uqs+vPt/vt
 Q2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780904683; x=1781509483;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZqT9X690665YDPdFk1M5g7fSYJbfRbamY4d5Q++oL8Y=;
 b=hpdV3V1CiIAqcGds3onvZMGyasG3REigQF1Gx6Wi391pVWDTHkzUi9L3B89MFNORNJ
 VMNG14boepvmJFxFb3JjBmx+nlnBw+YBlKt/OCy8bAhKyktGaajqJ7Kj3X+z5Dix1ryF
 YitcjUTtCC1HaLV3SDWgvSa7qByrW+r+R9XCDFSgUvUiNJZnAhKA57KxDmxd4TcNSHt+
 r/RGoKnInLo9Bkl26xE2hkh7PRqnpzQ7SU7dwX4IPumOcB2P8xBjnRGxPW4k7tgZ1Idq
 /CrhgGXGpnxifLdEoHWGx48LY7N8ASx3viCqDPCEzjKkiOgCDg3soVz88J1hUWi73nlh
 r1rg==
X-Forwarded-Encrypted: i=1;
 AFNElJ96f/spsOFzKrFPDMP09zwWBfCY6ZN8fD6ft7scamByRCMz83CmzIckZ5BalNJfGH3lTdY8vI0=@lists.denx.de
X-Gm-Message-State: AOJu0YwtiTer8/D2v5Suyb7XGmsvQ+gmBixWv2njLE0W+YaXaUzQ7jjT
 QSfIfWLAivOpOHOwRXsUOj97IDXTfuvBdcoMWnCxVecHFxBccG+859rebJp61zXlTR8tV32PyPO
 J5zYVBThwdphJb7EbfQMNySU/zsjOfv7oXE91J42TNw==
X-Gm-Gg: Acq92OFmrDRNDgFXgyUnRdBvHG4oD/lkTv4biJbh+fZ1ztt3OjhhYBc/dYNrr+rJLi7
 hmrPuUNxlNT4XelqvrHxHeijKYiFLwrfoUT7H+RinSIHqprUaBYZMfHs24UxoP4k8Xxr42t8AAn
 N57doBDZ770zoP8exBKKLa8mbCUOjBTLUaP5n6P2ybMnBUZwtT5oiR8gYdJ6b1zegCL3PmwtpHM
 n2Jw3dmGyjn0/4zMc4shJWLUXXOnj3+AV+rtNAkB550DQacyWTYXg2PHeF0CPeIDPb+Ot1+xw+S
 0lIK4tzK0mvjh9dsQU3/j9vLfyp70loEIego3+H4o5QgvyH1wnZjhCKxzbpAOOyOD78pVKECDW3
 dQ6VdxThR04LWP+ci1lM0ga93+TKv7/dSJYZmUJoFFmOmr7f3WvwvV3CQndX9yLI0Lug3fHt8QA
 14qUHEolZ0uvuc42bkqIyeQzTzSEdxFlhaHxeCJ3uEcunszpTi6Q60c6oLVOAszYTQYGC+UQgjf
 1AT1gf0GbYJIZjo5C+hK7WKcVpFrwVSWI1/Tx+70FFFJdEWsxNiicP8LuDlCyMHExXYvzZi8Chd
 vaQleJp6ZdUOvHP9bbZxRr8CNjKT6IU7g1Ed7A8XZb5gls0qpJo3Rq4QvXuAPTetfv7mOd1umOX
 3+HeF3S/SsVMpuk7+
X-Received: by 2002:a05:690e:1246:b0:660:54e4:5dd2 with SMTP id
 956f58d0204a3-66106dcef06mr11893431d50.11.1780904682862; Mon, 08 Jun 2026
 00:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260604073719.48723-1-ilias.apalodimas@linaro.org>
 <20260604073719.48723-6-ilias.apalodimas@linaro.org>
 <CAFLszThLAkMcDnMurD639y_Cck-n4DkW7VOC+Xzy+k+Xk_ryzw@mail.gmail.com>
In-Reply-To: <CAFLszThLAkMcDnMurD639y_Cck-n4DkW7VOC+Xzy+k+Xk_ryzw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 8 Jun 2026 10:44:07 +0300
X-Gm-Features: AVVi8CcIayWFdIg1VVAv5xDfFjcSXW8ag1Pe-R9YXZ-M28LyYoit0szHsP7zXMw
Message-ID: <CAC_iWjLcLMvjsjJujKSQ=GKvKZb+axQj6-1Ptc9UffBLxic6cQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] common: Add an option to relocate on ram top
To: Simon Glass <sjg@chromium.org>
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org, jonas@kwiboo.se, 
 anshuld@ti.com, u-boot@lists.denx.de
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

Hi Simon,

[...]

>
> I'm just a bit concerned about what this changes...see below.
>
> > diff --git a/common/board_f.c b/common/board_f.c
> > @@ -339,7 +344,24 @@ static int setup_ram_base(void)
> >  static int setup_ram_config(void)
> >  {
> >       debug("Monitor len: %08x\n", gd->mon_len);
> > -#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> > +
> > +     if (CONFIG_IS_ENABLED(RELOC_ADDR_TOP)) {
> > +             int i;
> > +             phys_addr_t top;
> > +
> > +             gd->ram_size =3D 0;
> > +             for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> > +                     top =3D get_mem_top(gd->dram[i].start, gd->dram[i=
].size,
> > +                                       ALIGN(gd->mon_len, SZ_1M),
> > +                                       (void *)gd->fdt_blob);
> > +                     gd->ram_top =3D max(top, gd->ram_top);
> > +                     gd->ram_size +=3D gd->dram[i].size;
> > +             }
> > +             gd->ram_top =3D board_get_usable_ram_top(gd->ram_size);
> > +     } else {
> > +             gd->ram_top =3D gd->ram_base + get_effective_memsize();
> > +             gd->ram_top =3D board_get_usable_ram_top(gd->mon_len);
> > +     }
> >       /*
> >        * Subtract specified amount of memory to hide so that it won't
> >        * get 'touched' at all by U-Boot. By fixing up gd->ram_size
> > @@ -350,10 +372,9 @@ static int setup_ram_config(void)
> >        * memory size from the SDRAM controller setup will have to
> >        * get fixed.
> >        */
> > +#if CONFIG_VAL(SYS_MEM_TOP_HIDE)
> >       gd->ram_size -=3D CONFIG_SYS_MEM_TOP_HIDE;
> >  #endif
> > -     gd->ram_top =3D gd->ram_base + get_effective_memsize();
> > -     gd->ram_top =3D board_get_usable_ram_top(gd->mon_len);
>
> This reorders SYS_MEM_TOP_HIDE relative to the ram_top calculation in
> the non-RELOC_ADDR_TOP path. Previously gd->ram_size was reduced first
> and get_effective_memsize() (which reads gd->ram_size) then yielded a
> ram_top below the hidden region.
>
> After this patch ram_top is computed from the full size and the
> subtraction happens afterwards, so ram_top (and hence relocaddr) now
> lands inside the region SYS_MEM_TOP_HIDE is meant to keep U-Boot out
> of
>
> Quite a few defconfigs still set CONFIG_SYS_MEM_TOP_HIDE (e.g. odroid)
> and look like they would regress here. Please keep the old ordering
> for the else branch, or do the subtraction up front and feed the
> reduced size to both branches.

Yea that's true, however how that's used is weird because
get_effective_memsize() is board specific and it doesn't always use
ram_size.
So perhaps we should deduct the same value from ram_top and keep the
call last ? That way we can keep the functionality for both cases.

>
> > diff --git a/common/board_f.c b/common/board_f.c
> > @@ -339,7 +344,24 @@ static int setup_ram_base(void)
> > +             gd->ram_top =3D board_get_usable_ram_top(gd->ram_size);
> > +     } else {
> > +             gd->ram_top =3D gd->ram_base + get_effective_memsize();
> > +             gd->ram_top =3D board_get_usable_ram_top(gd->mon_len);
> > +     }
>
> The total_size argument to board_get_usable_ram_top() has always been
> gd->mon_len in tree =E2=80=94 that is what the ~40 board overrides expect
> (they typically use it as the minimum headroom needed for the
> relocated monitor). Passing gd->ram_size in the RELOC_ADDR_TOP path
> silently changes the contract for any board that both overrides
> board_get_usable_ram_top() and turns the new option on. I'd keep
> mon_len here, or rename the parameter and check callers if this is
> intended.

That's another unclear option to me, since this function is also board
specific. What I can do though since this is largely untested, is move
the board_get_usable_ram_top() out of the if statements and call it
with mon_len. In the future we can look at all the callsites and
decide what's needed eventually.

>
> > diff --git a/common/board_f.c b/common/board_f.c
> > @@ -339,7 +344,24 @@ static int setup_ram_base(void)
> > +                     top =3D get_mem_top(gd->dram[i].start, gd->dram[i=
].size,
> > +                                       ALIGN(gd->mon_len, SZ_1M),
> > +                                       (void *)gd->fdt_blob);
>
> Perhaps a follow-up but we should be able to avoid the cast by making
> the fdt argument const.

Yea, but let's focus on the adding the functionality for now. There's
a lot of cleanups that we can do once this is applied

Thanks
/Ilias
>
> Regards,
> Simon
