Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF8FD13C2F
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 15:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 879EA83B27;
	Mon, 26 Jan 2026 16:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="W+BEQDQ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F030083BDD; Mon, 26 Jan 2026 16:13:37 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B57B83B0B
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 16:13:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-7927b1620ddso67052097b3.0
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 07:13:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769440412; cv=none;
 d=google.com; s=arc-20240605;
 b=VtzvpgjuXXNbc3iug4IaiO0BwtTNwbujIoY2IAiqGSHLEnV/qyVJR4LMrWCOyhDE6G
 ZTJv2UfjEQSZZTEGM8EOse/2CG89cSBNSDlWZi68TdidTcosF5P6lWhqEULgYDyzYhFF
 NrszBkkMYN4qbdv6zrmIBStdc71MQsT0QjQg+iKvDo8npduRW6oJQUvvqbzI4XOuV5u4
 AfM+RbkgBd0ldCsXcA8OrzKA7zDbKXBRXmoFwmz05dg/Qd0/YFP+CK7Ss+XwPFsC2dyS
 0axV8XCZQVJe/yTgWB2IgAgNK9HDP1jVaoGFNJl6+Y4nJVeHWAKKzQcjpROAC3Ti0bxi
 rHTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pIvs5a24QrRXXOVa31491kqKmK3xyw9fMfHeujTFFKQ=;
 fh=mO12P1THv0dM1UOhfk0diPA5r6foQyo8RK7RSsnISfU=;
 b=Wgom/pSqyI6M0OwL99T9Hiwm9gu6IJydgdGH8OuaVcO9xgqyLLxlFJrHtNdVnvR+x1
 l5ty883Y1J2f8djCbJbQl7cC4hmjfoWy2K5CD8aZQA6iYzMgSr99y8E6s+GYd6L7nwtc
 rO8DLz4NxNAG/luXUWGuwf4+piJnvNQWqWXk30/iazoZiwAY2ZGLRvTkY9LXIwdokN4n
 aDvxOqSEkIx0sggpW01zzClEmCmWDeAR97N82glk8wtJCkmQZNAZr40ZuZgnO2gwqM3g
 bWeXvz2sNC6fP5JdnQWgllJP8vi/8wTdn9ZoCUDGY/DZNIvhBtZYz8ZAFTJsJeGpU+51
 IxQg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769440412; x=1770045212; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pIvs5a24QrRXXOVa31491kqKmK3xyw9fMfHeujTFFKQ=;
 b=W+BEQDQ2CQ5daTC/bv3OrauEkdVhyXGHxTDnpI1AVQpL+glv9CCoZBeTuxpTha5JiG
 bUl3+FYaDnMhEAsY9w+GEeSDEsPlGJL58Z8fgFf+yZdy2mXce9PF1yIbsPQr5WjS0+hj
 WC9qDsCyRfbqY8m+cHno3KpGPWMuLdLs9csRWwqPBrrfPZN+sSccW3Rqra4r8fgbJEOz
 htr/C5J//0iGxfDMJTJeKyTurkMS2Gt2wtT6fbLz5/sw3rFtdGsP+A8RjsuqmOr+W6Sk
 aBTJXUTkPoMEEKhswjxXBMPmR6HxFqtdor6y3wyrwjR5TXSriRsPQu40WpBMV0AdIJ/c
 f1Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769440412; x=1770045212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pIvs5a24QrRXXOVa31491kqKmK3xyw9fMfHeujTFFKQ=;
 b=otroj+Dot4Vwt/c8Bme6KMCL9MQy948HXn3W1SkeNz78WMW4p4afl+cLcvL7il5Cio
 459Z3k3ENFF0aWJHdJqdVOsjk65SWP5OQD7UikoDqQXdBWBROzHaqnA55Ml8YLW8A9+S
 Hd9/Wa/oOnxF2rG845jwPMYfRroRo2bYr6/YQgP/IT4UYKzrxI0l5JwsmAdOxDfVXCko
 +lL5ewDuI3FqeT3yuXgpTNoeHortl1NbbFSKwFP7dJ9AVN4NJyNvBtPmZth7BwFIRIDG
 8kB6vsj5PaO+JG/qe9xxO/f+Fwz34WcNENwQtftLTwYlBsVTQSwn4DIHcBf4dpHYQiln
 eA1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUo5emMvEi/OAjTRvSx5SRjhDBcT0TF607gb+oU9GdNeKfRsBvN7uROLzRO5k19h2G9MLHMs+E=@lists.denx.de
X-Gm-Message-State: AOJu0YxaBfLVnqBxuw0exS1xL8HucC6NcszfSiG1qnmQzB6CmNkMjN2p
 H6JYSUSQ7Nv4QvT6h7Pg1uv3i1LrA0I+dkssOLfXI+uT1oDwLYiRI1wzZvqTFqkFZSppd5Gc3Kz
 jWOpMwbgIxIn/919Vw8g9x25fkWupZsny67KmN5oK9w==
X-Gm-Gg: AZuq6aK3flmIY41a/INz+kaJBmj8roJxjDiU+o4qEhHM/nTj+RFlfTSTHghppYKcO+K
 LSPzYW5O1vXr6AhCBQwJYZs9in/3jyyoMbeBtqWHN8J4Q6msN0YIPfNjEKSOF+LwvEiH+dy0NJS
 h7fNnQCRnakW1FLNKX10M0QIPS3wTt58LZL+Y2xJZsAmdFYdRlzbQ17suxmdHQ5BFFy5pcKj6Mz
 NCvGOkV5YRlMVgFsdqC6odJF8iHaRuh/bsSN+G6sxD6v42fuCbl6eIwGnGURhuCZ6BCekKXQS3Y
 OknlAIKbPOUAoE1BpmHe1HHzrORZr8SBZJY1yP31py5DWvTVQiLoBqv2B4AFGD+uU+uealelBFm
 XpvrGmaJ/wXP/xXPqDFS+S0QfLGFabDNbdx3wnTupIyZjawnJMZkTX1oIm/QEZfrHkRnkXV2pWh
 KG7QZGdpJzX7iIzhhmnRo7B43nj1A589Pnh1GWrajL5mRT4dtcXk83RwMk8rXi49RAhwFrCdWHJ
 F4phSKOHRCfitUekoY0ydb3NufnCZRwUlfD0hTFav3is56JD1Lg046GtaMECf3o0m9kf096hRb0
 8N75hJLDzTT1UVN9+xvcgH9PhX5rXrQt3t78lCFhgKc=
X-Received: by 2002:a05:690c:f84:b0:792:72d4:2aad with SMTP id
 00721157ae682-7945ad617e0mr33467667b3.17.1769440411838; Mon, 26 Jan 2026
 07:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20260123161907.392211-1-festevam@gmail.com>
 <20260123201202.GO3416603@bill-the-cat>
 <CAOMZO5DVFO=A6g1CWOrRbqy4VNgL+VcUw0Q5pgELXm30puGz4w@mail.gmail.com>
 <CAC_iWjJ5gVzOP_6cgxEbUJn8a=KRj=-wEFy=Do7Dp8oqH3V+Dg@mail.gmail.com>
 <CAOMZO5D5awN11z8Hxwr4+tunqvhH8fYbUJvU6McES=edi2OR4Q@mail.gmail.com>
In-Reply-To: <CAOMZO5D5awN11z8Hxwr4+tunqvhH8fYbUJvU6McES=edi2OR4Q@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 26 Jan 2026 17:12:56 +0200
X-Gm-Features: AZwV_QhtPlCofVRBtuSaN1HA_kIdqTE7cAKnBhZOP5MA1n0rbEgE7sk7Tf8CSh4
Message-ID: <CAC_iWj+BYi5mhE9+NUWTgByKZiH6E-XYt64G2JBdHRT4XY=bOA@mail.gmail.com>
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

On Mon, 26 Jan 2026 at 14:45, Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Ilias,
>
> On Mon, Jan 26, 2026 at 3:29=E2=80=AFAM Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
>
> > Fabio can you please try this
> > diff --git a/arch/arm/cpu/u-boot-spl.lds b/arch/arm/cpu/u-boot-spl.lds
> > index d780a5060774..af9f3a3c39c0 100644
> > --- a/arch/arm/cpu/u-boot-spl.lds
> > +++ b/arch/arm/cpu/u-boot-spl.lds
> > @@ -51,8 +51,8 @@ SECTIONS
> >                 __rel_dyn_start =3D .;
> >                 *(.rel*)
> >                 __rel_dyn_end =3D .;
> > -               . =3D ALIGN(8);
> >         }
> > +       . =3D ALIGN(8);
> >
> >         _image_binary_end =3D .;
> >         _end =3D .;
>
> Yes, this works. This is a partial revert of 8b0ebe054bb3.

Yea, i don't want to apply this, just verify what I am seeing.
So, Tom the bss size doesn't have to be 8b aligned (look below). It's
worth noting that we  do have some implicit assumptions in our asm
that rel{a}.dyn must be 4b/8b aligned in armv7/v8 respectively, but
that's not what's happening here.

We want _image_binary_end to still be 8b aligned etc. Since ALIGN()
has been moved into the dyn section, we now create a section for .dyn
in SPL that was previously empty. This new section also gets copied by
objcopy. That section will be 0 or 4 bytes depending on the alignment
of the preceding code. That's what blows up on Fabios set up.

We can probably apply the patch you suggested, but we need comments in
the linker script + an update to the commit message

Cheers
/Ilias

>
> Thanks
