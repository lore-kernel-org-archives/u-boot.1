Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C587C88E57
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 06:29:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9694483DDD;
	Mon, 26 Jan 2026 07:29:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KR2uCXpv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5718383E86; Mon, 26 Jan 2026 07:29:36 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89E7783DB6
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 07:29:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-790992528f6so38798947b3.1
 for <u-boot@lists.denx.de>; Sun, 25 Jan 2026 22:29:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769408972; cv=none;
 d=google.com; s=arc-20240605;
 b=NGIEh/tendTr+dDJ4Fx/+3Li0QQA//Kdy20+MtsDVvPRVmLcoCNi2+AmGOOxYC9MaH
 mebjpNUAEx8GZu632NjXpVqyn1SIgXKxhC8vY2gN5nR/eKxBm5KgqUC9ZfOSS1kg7q8y
 4STm8J6Qg+llMiS/egM01/nKo4w4iH8Ca2AJD/nJZ6M9GUNeSksHDSQRWDPCJQ44HOrf
 iF06A7gCf5VQQ3DOsvLkjRNiPk6zWfQ92do8HPxah+s1++5EnSs6PJ2iDm9EGXFBSvhj
 Xy+odmbgt/shswUubilBBAar9XG2A+rh+BLesS+qM43vxex5+04USpKmVKfZR4AatjAy
 Dm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=vqCe8TqSmE+Mz9p/oyAnaEi/3fL8AGZJstb/J6PVquY=;
 fh=Ke+oIg9tmcIJpCbkXrO47WAkt0VZ2LRx2mW3gltYoZ0=;
 b=MMdnvVMCVB4io6zXysC7GYyjxMY+cBjIxRCqdsEnF+diNTyvabAsyVR9a4qWfwPi+k
 uxDCeqsAOzQ2bufAaQXz5tBjZzRPJqssfC58P1DOxpwC7sf9t7vyBwJvQ/1XKlXGoT65
 QYlD7+LFjM0tytfusk6Or4azO/754tqzJwfNBRAh40P6rjNoeDfS7qMXRN0cfuYUSr7H
 MdStERK6mY1kg6W1QOnIMvWWfVjmQoqyQAo7an4QJk9Fq27nWiOt9PQV09/HteMuBK6n
 +SNgjW1GbqmkRdELSyF10fENCr0anOVl60SBafdAccDiZPcghXu3mPE2u5RijZYdZeui
 3DQA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769408972; x=1770013772; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vqCe8TqSmE+Mz9p/oyAnaEi/3fL8AGZJstb/J6PVquY=;
 b=KR2uCXpvWx17Pgu0nDnSTQs97eMkwoju3ihyyxWkwaxq78RNBPlKjpCM36GfQ4Phy2
 X5PNpJqqLABHgTiOvXWakrchQ29piMgZUZi+j9KQY2fghk/Tx0eAk7xP/thfz0V/9FHD
 eLItTqM9X0nGTmLuTqUjBo7GV7MWVH2cjR0OixBhz8iVSzyfAewq/YLhL2eJQJTGOd0B
 wQLNjZOvQazPYrzaeG3cIfv56QHgMpzQTRyqGuOKRGQ6ZISNKxBm7asGBCi7toV98P6S
 HHPVcCSyemCuiT6NG01Zjh3cM5xGFhqjdFbW23eeqdqAUxKJbO7EpafXtM3QYtxZDKTp
 a9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769408972; x=1770013772;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vqCe8TqSmE+Mz9p/oyAnaEi/3fL8AGZJstb/J6PVquY=;
 b=gL0k6c8ToKgZIGetED3RaHw7AbLJDuPt22+NmG8cB8mZd9CmOxlaRyzLpmI2wJMEoQ
 zry7ToYYQ2mzwRfXQNjAfqBTWVXXYyIagW7EOWpKYchS/1+JQtcpPwxXkQavkjVsXl4b
 o2XLGQD+UxikJIDXYMMz0/SfkwbBwzxs+iavZXBxrw5dx87i4hdPtDn6t/ARZ/x2aOAT
 nsWVre2U88xfm5eSIpwilMN091hdhkRqWt9siYVI4ykbgZuiaY/1uAAI+QKpxbw4CC2G
 GqxotlwrVPRPep96NCsSS5TLHt5nc8n7b8rjwINyprZB4dwyWOyvoX1UjCPhdkG3UK+D
 2XJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUYDu5NAPgRHygU7MH+3ZjGzVqe2OUNZaRwsDRNxdiBpHfPt/hP9vhFLzswEBLb9OB0NO6+y/Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yzl9R4Zx6Hru+72irnTEG268Jkkd6urE3mSQqOM6dvPrpUFJ4b5
 zALdewvCXp7MUNyhm3GKNeTKUmbzENUSKJa5cSymrPEtml1cSUe7en/hXpGNV6y+9zHLvMAgMDJ
 189LJlI0OUDEdkIqhd4Nd0L024qQoN36yEW7R7n5//Q==
X-Gm-Gg: AZuq6aIDO3LrcE+d8wvs1h8nGVFE8/2NYNjY/jWTn5EZ7GXmbN63fDLzBbUcHoC9skk
 wL9I0DDAP5jwAjumPdE859erBtCTZh3JkEW4XKy1yBM5Km6KvenZ5rPqJwMh29T+hqM7gatbM0/
 rvNDcg+EtGMyvzgRIZxU3vZWsfXrUPeZIYt9L1GtJZtOWkkuWznQFkvPkfmdbqlt7vO8vK76y+/
 hJotg239HXN3bQ7YECXLZ+u+4lzGir3iyCY/2B6QP6QCVBaR6cV0tKHbITKlh/O7VHYh9Qn21ik
 GSZRXEGJ5ntvxVFLW2Z4TzQC/Q0hFarILS2rnYuzS72LIYf3h89vOBvIG5pju5km9ubXC8XdD4b
 pKe2+iwJR7TzRpD57AwqvaeVIySS/keWrLitFnQnsxPDQ+gbLeamjq0aQsN2t9GDF9RrcXB9d92
 R9CKwuTQ7or48PmSznM2Uz0BjnTkbHKMVh5cikNBgpCzvZRjSD/AKg0qNoqSxsdbfi5OTwQjB/3
 tGbZFBe4aUHhZL/kH4M0G6INNpOKgVB0+IFlZSnSQfhy+VW9dSTdQ1VdiAg0BJGiNq24EwqB7lb
 QdnFInuJGy2VokkQHYbMRnBuU02z78ch
X-Received: by 2002:a05:690c:90:b0:78c:69fe:eb1d with SMTP id
 00721157ae682-7945a86f8f1mr26661447b3.17.1769408972139; Sun, 25 Jan 2026
 22:29:32 -0800 (PST)
MIME-Version: 1.0
References: <20260123161907.392211-1-festevam@gmail.com>
 <20260123201202.GO3416603@bill-the-cat>
 <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
In-Reply-To: <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Jan 2026 08:28:55 +0200
X-Gm-Features: AZwV_Qj2EffhUhRknCzj4OQPHgCYsxL0FLCEmtBthFggwUfHHmOUM-GfuZ4MXQk
Message-ID: <CAC_iWjJ5gVzOP_6cgxEbUJn8a=KRj=-wEFy=Do7Dp8oqH3V+Dg@mail.gmail.com>
Subject: Re: [PATCH] arm: spl: Fix DTB offset after binman symbol table
To: Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: marek.vasut@mailbox.org, u-boot@lists.denx.de, sjg@chromium.org, 
 Fabio Estevam <festevam@nabladev.com>
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

Hi Tom, Fabio


On Sat, 24 Jan 2026 at 02:13, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Tom,
>
> On Fri, Jan 23, 2026 at 5:12=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
>
> > I've been talking with Ilias for the last few hours. This still isn't
> > right, it just happens to work in some cases, but not others. What's
> > going on is that while we always have u-boot-nodtb.bin 8-byte aligned
> > because while the BSS itself may end 8 byte aligned, we actually care
> > about the size of the BSS being 8 byte aligned. Can you please try:
> >
> > diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> > index d780a5060774..dae8a1ec665b 100644
> > --- a/arch/arm/cpu/u-boot-spl.lds
> > +++ b/arch/arm/cpu/u-boot-spl.lds
> > @@ -58,6 +58,7 @@ SECTIONS
> >         _end =3D .;
> >
> >         .bss __rel_dyn_start (OVERLAY) : {
> > +               . =3D ALIGN(8);
> >                 __bss_start =3D .;
> >                 *(.bss*)
> >                  . =3D ALIGN(8);
> >

I think the reason this is happening is that we *force* thje rel.dyn
alignment now, and as a result we create the section. That section
might be 0 or 4 bytes depending on the layout and that'w hy adding
ALIGN() commands at various places fiorx the problem.
For 'fun',can you force a -dirty compilation of your broken tree? The
update of version_string[], which lives in .rodata will update the
alignment of your bss_end and the binary will start working...

## readelf before 8b0ebe054bb3 (no rel.dyn present)
Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk I=
nf Al
  [ 0]                   NULL            00000000 000000 000000 00      0  =
 0  0
  [ 1] .text             PROGBITS        00000000 001000 0086e0 00  AX  0  =
 0 32
  [ 2] .rodata           PROGBITS        000086e0 0096e0 001d6e 00   A  0  =
 0  4
  [ 3] .data             PROGBITS        0000a450 00b450 000538 00  WA  0  =
 0  4
  [ 4] __u_boot_list     PROGBITS        0000a988 00b988 000798 00  WA  0  =
 0  4
  [ 5] .binman_sym_table PROGBITS        0000b120 00c120 000014 00  WA  0  =
 0  4
  [ 6] .bss              PROGBITS        0000b134 00c134 000054 00   W  0  =
 0  4
  [...]

## readelf after 8b0ebe054bb3

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk I=
nf Al
  [ 0]                   NULL            00000000 000000 000000 00      0  =
 0  0
  [ 1] .text             PROGBITS        00000000 001000 008848 00  AX  0  =
 0 32
  [ 2] .rodata           PROGBITS        00008848 009848 001dfd 00   A  0  =
 0  4
  [ 3] .data             PROGBITS        0000a648 00b648 000530 00  WA  0  =
 0  4
  [ 4] __u_boot_list     PROGBITS        0000ab78 00bb78 000798 00  WA  0  =
 0  4
  [ 5] .binman_sym_table PROGBITS        0000b310 00c310 000014 00  WA  0  =
 0  4
  [ 6] .rel.dyn          REL             0000b324 00c324 000004 08   A  0  =
 0  4
  [ 7] .bss              PROGBITS        0000b324 00c328 000054 00   W  0  =
 0  4
  [...]

Fabio can you please try this
diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
index d780a5060774..af9f3a3c39c0 100644
--- a/arch/arm/cpu/u-boot-spl.lds
+++ b/arch/arm/cpu/u-boot-spl.lds
@@ -51,8 +51,8 @@ SECTIONS
                __rel_dyn_start =3D .;
                *(.rel*)
                __rel_dyn_end =3D .;
-               . =3D ALIGN(8);
        }
+       . =3D ALIGN(8);

        _image_binary_end =3D .;
        _end =3D .;
--=20


Cheers
/Ilias

> > And see if it works at run time? hexdump'ing looks good. If so, I'll do
> > something more broad to catch the SPL_SEPARATE_BSS=3Dn case, and add th=
e
> > ASSERTS that are missing.
>
> This fixes the boot on RV1103, thanks!
>
> When you send a formal patch, feel free to add:
>
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Tested-by: Fabio Estevam <festevam@gmail.com>
>
> Thanks
