Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01C2E6BF2F
	for <u-boot@archiver.kernel.org>; Fri, 30 Jan 2026 17:03:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE467844F4;
	Fri, 30 Jan 2026 18:03:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dGW6i/yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABB3B84513; Fri, 30 Jan 2026 18:03:06 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 846BB844F1
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 18:03:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=briansune@gmail.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-7d15b8feca3so2330611a34.3
 for <u-boot@lists.denx.de>; Fri, 30 Jan 2026 09:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769792583; cv=none;
 d=google.com; s=arc-20240605;
 b=H+ZRpbjDK0OJYd3I9r3ogdvuaA4cwVtyQYhgVpJiMK175p2hNLBtT+/fsbRLFKltWC
 wWNviB6QkNru54ohux1osoCT3LX5cL0v/bszRqZpzO18GwL6ewMgiSo915Gp0MpqkjXE
 G1uCAnoJ4l/qrrWpOkEUmFDffZlmX0S0PBNOIDjYZo3JcL7Buv9WjS46bpwjgE1q+DU5
 Fcsblog1dn5x/wbbZ8H1pnQ42dNW5+YZQZRa2qtxnoefBUGwBwd0GdSB1CHSTmTlvF2F
 45TdvCIWYjdp7dgsBDGxmIbRNJ+MKHxpR0MoZUdY0MrfLFZgK/3MdE2LpmFeuQRF+xaV
 3LIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N6yrYkbCg6P/9UrPbMblFPOvM5FGZ1UYOPoY8WP70iA=;
 fh=3cGkqt4Xgv2w9dTeeIJFEJ5AO4AvGobPArcY4WlS1wc=;
 b=gC14DcFoVv/ViewdLMBx0MjE6wa/vhar89LvpF+zUhI/OFsmZvPZhQJH3oixVZeN+N
 zAnqrrnkwb50a2LyfrS4ClL+KLw58p9s2Gaye3b4sklPz1LGCvdimn0UGr4xHkn5yybp
 PlRIcqT/RHOBmq1vOf7k9u5j/gcdIooRoUlfLu1CwUVlfUsSI0PqV1KAT+CfQfQX3T/1
 QehMwHbk5w9uQA+9moq/NPKzBRd6v8B5bSL0spksaFZuj8Rn1S0Fo2hA/CGcavvGEgQQ
 WT0ug6oRrsm74Q8WmMkiyP+vj0JEW8zKjyWOl9Dz0mQixomO/hBFYClwmTMUvUTOiXh5
 9EiA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769792583; x=1770397383; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N6yrYkbCg6P/9UrPbMblFPOvM5FGZ1UYOPoY8WP70iA=;
 b=dGW6i/yhnVNBwR0mdwC1FVms0NMgQVVM+jnLQwD02TT9sqWCGxqZ+v8kZWz1JBbb68
 lFQq5nqxW6xATlnqENzuVovtueF2Z6h2t/znWlYsiG5B9KzSXRXM2Xh5r5D7Mch8Kh84
 9sL2jM9KuHIUK7mQiaw1k/s/NWufAeVOzg4VpTfpkbWYJgZpU5QG0SD5GCovn+XTMWHh
 fHDFrF59Qt0tPJ9DrKQX8yh6swwHY9irEdZxVDFDnUqhROdJOAv3lO8gYz3JiNHe6+/J
 kDurusb1W/l3g9JuV5JzTm4znS2oB7HpINMlUqT87/vmQ6erZWqDIMeAXG+hACBChiUX
 xCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769792583; x=1770397383;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N6yrYkbCg6P/9UrPbMblFPOvM5FGZ1UYOPoY8WP70iA=;
 b=PvaTx/kKA3TaHbJEq5IuC8DBXBTgosk4NIXD2Z0QiA8/e0oRCmTxzz4b8FyRiNGSH5
 /O0Qu2D8FJiAUR7lm40HRAjS9wlK+LeO+6FdC8IG/NGHDLim9VBMgrxeBwFfVjcrXSWq
 qaDx8cH/KrA82/1m+rYNq3uDDsw7HUnkID4xXFuQ2tVqrnwltxTPefdZBdZEyaHPiBVq
 /LOylYqoiaPuKO8D6Fzw9m/Athq+BBafD7JFF0jBMb3sgtEOHxUMnahq5DXHlpr1uX1x
 WcJZ+NKo+xNLa5S+xTofP4bY5WkI9xeTMc2K0NbflctDgHZaE24B8s77o6wUwgfcuM/5
 EfOQ==
X-Gm-Message-State: AOJu0YzAF+I+k5f8dSpwJSaLZk0PcbL0lQLS6eqyqQ7DlICk+BNhKiJe
 YhF8uoYcRRqjtgy6LLkYvJlu41/5dfREqzn8uBDtRyxXBfM/02y9UeibXPXBMMudJVif1kDdqS1
 CrfbPmACfyNERX733CEwznrgd6NGW38GAHUxELYuLhg==
X-Gm-Gg: AZuq6aLz0Neu5XVVTWaZGRPBySCpc+P6tucJTHjp2AVfqkWKOmW6F4DcYth/mFxhUUT
 F0WuyG7IjQU9ykg4H1QhcN6auZoNQKuzsrzowi7phhdgEXt4RwhOAHhq8XyepIc/Y2/PeQm7d7g
 DYFNsqxGoY8qLNSmJ0CZAkf1ECm10eFd4NuyM9R4GzgvdVyIVWbHlK5/1D/9kfb6qcpyZNo+tMZ
 3e9xzH5vrJcgRyBQhe4OMN2B8jFW6DcWZz+h++cmiQVoJXamnHZlPr2eCpC89WY9QGTyQH56FfI
 2fCgTwk=
X-Received: by 2002:a05:6830:4409:b0:7cf:d150:a245 with SMTP id
 46e09a7af769-7d1a52a75e1mr2380587a34.5.1769792583033; Fri, 30 Jan 2026
 09:03:03 -0800 (PST)
MIME-Version: 1.0
References: <20260130031217.998002-1-briansune@gmail.com>
 <20260130145528.GA2421612@bill-the-cat>
In-Reply-To: <20260130145528.GA2421612@bill-the-cat>
From: Sune Brian <briansune@gmail.com>
Date: Sat, 31 Jan 2026 01:02:51 +0800
X-Gm-Features: AZwV_Qiulh1pFPP39HmvUxWtOlbUPqff9eTP1ByAZ5Z_3GgY_whyJGT8paOuh_Q
Message-ID: <CAN7C2SCKKFnQvJ1V3xoVHu_LL_YNBLR+T2btS0hFou7JE455qg@mail.gmail.com>
Subject: Re: [PATCH v1] Fix unbootable ARMv7 devices
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Fri, Jan 30, 2026 at 10:55=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Fri, Jan 30, 2026 at 11:12:17AM +0800, Brian Sune wrote:
>
> > The linker script u-boot-spl.lds now
> > is no longer aligned and -nodtb.bin ending shows
> > the zeros are not 8 byte aligned. This result in
> > the Makefile.xpl simply think the previous file
> > is aligned and do not zero pad. simply fix the
> > data align to 8 can ensure the -nodtb.bin is aligned,
> > hence, the formation of u-boot-spl.bin properly align.
> >
> > Signed-off-by: Brian Sune <briansune@gmail.com>
> > ---
> >  arch/arm/cpu/u-boot-spl.lds | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This fixes your problem in that it results in the device tree being
> aligned still, but doesn't solve the underlying problem of why there

Hi Tom,

Another follow up question here is even making the data node to
8 byte aligned will this create any harm or even fail case from first place=
?
As for testing on a real platform it makes no difference at all.

If "binman_sym_table" is empty then the previous node data is 8 byte aligne=
d.
Where "__u_boot_list" is also gated by 8 byte end aligned unless it could b=
e
empty while "binman_sym_table" does not.

Just wondering and not really too good at these linker scripts.

brian

> were 4 extra bytes. Can you please try:
>
> diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> index c578c3ebf821..5f807323f856 100644
> --- a/arch/arm/cpu/u-boot-spl.lds
> +++ b/arch/arm/cpu/u-boot-spl.lds
> @@ -31,16 +31,16 @@ SECTIONS
>                 *(.data*)
>         }
>
> -       . =3D ALIGN(4);
> -       __u_boot_list : {
> -               KEEP(*(SORT(__u_boot_list*)));
> -       }
> -
>         . =3D ALIGN(4);
>         .binman_sym_table : {
>                 __binman_sym_start =3D .;
>                 KEEP(*(SORT(.binman_sym*)));
>                 __binman_sym_end =3D .;
> +       }
> +
> +       . =3D ALIGN(4);
> +       __u_boot_list : {
> +               KEEP(*(SORT(__u_boot_list*)));
>                 . =3D ALIGN(8);
>         }
>
> As the problem ends up being that when both of these are true:
> - .binman_sym_table is empty of actual .binman_sym* symbols
> - The inner '. =3D ALIGN(8);' increments the linker counter from the
>   previous '. =3D ALIGN(4);' (in other words we were not already 8b
>   aligned).
>
> The linker sets the type for this section to "NOBITS" which in turn
> means that when we later call objcopy to create u-boot-spl-nodtb.bin we
> get a mismatch between our expected size and actual size for creating
> the -pad.bin file.
>
> --
> Tom
