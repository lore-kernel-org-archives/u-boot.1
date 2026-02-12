Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A379DEEA86E
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 23:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4C1783015;
	Fri, 13 Feb 2026 00:48:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hopDxgil";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3540083015; Thu, 12 Feb 2026 22:32:23 +0100 (CET)
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com
 [IPv6:2607:f8b0:4864:20::e33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05BA380FA1
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 22:32:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-5fa26e497feso116444137.3
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 13:32:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770931940; cv=none;
 d=google.com; s=arc-20240605;
 b=jnGNcf3CgZV/B2wFo3ryUUVC6Ey9nt22k3wCtZCl+E2mvHq/vdhmWTSxilAIlYvuTR
 kyW2mhL3xM8Q4FPdlQ2xus3QBMsGj1It0ms2V6qSiEq8Okgtvc7+JHGRftkfiwctaqOT
 rDczYLv/FLzs4ZTJaYxbkyvdLofP6s8BhfE1p4D6oWMrCX+0cqK3LTrtALsSlorXER6f
 /tNdzooQlA+hRNxG5XS90+UstWrOGf/vvw9JanL6IIIp1NHh2+pVSQbWWrqw6HBydVWc
 2LLbenjWmJkqRwhg1/NluxX9FZU69IdBhEHW6vTN2mzjzJgyQuVFJgnI/OBnVstBssSh
 bk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Vv5xuRvYRzp6IcS1gXOhJgUwVD482Nxjg1REak1VhWU=;
 fh=CZg+trVLT5C7hPiIM0OSJFRG3Myi0YjcN1bp5nRv5F4=;
 b=XtgYBECBn3EpxXTnIk8sPwEd8599sqEbGhMtXp0cNWU5a3fzOG1bxdTvlxHq3Sqplh
 NPJfYsOjYHWph/GwCHCSwrLe/WqvILTCUXZKCL96Dy36QeN5jcJo2unYrZ6lkRelMQz0
 +V49gdWBe2qEYp9LQt/ec/4EkgWiKGEEJPqjJeO3jFXqNP6V9nkEC2z2gjFh9tdNAuMJ
 re66FEc9Q8mTDyHitzPQzt3P5GGxMFfYxHswbrbpOn3k0pEn+EZuJ48ww032Dh0TWtUA
 CXBkrwO910tkrPQLc29xGiOZ1uIY1LHdckfO47ZUCqM0tl6lvdg5xkm+nOBY9E3ZmAAa
 1QVQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770931940; x=1771536740; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vv5xuRvYRzp6IcS1gXOhJgUwVD482Nxjg1REak1VhWU=;
 b=hopDxgildlFhYgBU5AHeoOYsq6D7XXzU44y+iV6Hl2cs0GnlFXAJPZ4b77wRir1EsW
 xotRRO6E6ymsWJ70VUXLTjW4je7d7GqGhbp+qmOvXjQIVln9fn/LzOaemzlCWrmPwP3s
 FPFHabzVr6hIGOeQlNPpssMgOswQyBkEisIKEfhCqSZsDYPQqHSMpGpbSkqbIUTJ5Vvu
 CufLl759bn/XnlLBVpWUpepfuAr36cpdjzHSltbNJcHpioXydELhDA5FBx1hzDtSRozt
 lXb1kpqnf/T1FK5EW1N+cd6MeDbMJcjarUu7+ekaRyVzJtNZ4zMlfjyChPtypmNjdIJS
 UWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770931940; x=1771536740;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Vv5xuRvYRzp6IcS1gXOhJgUwVD482Nxjg1REak1VhWU=;
 b=MaAHt0/5iXgjzNI9WTGBZhsJj7o4O6vIr4OnqrQWMOOXpbATv4vE4gItbhBeEEOJxA
 PwmsJ4MCG8YNLhnvrDLTVINm3pX8pUOkAESmBj9gKhbMJRlkjs5WEsaoLVCdkppv2aYQ
 EC4XvTXxmEFkPWyfsCA+9h0uh7yOZ/l0TaGWVgHlY/cwVrJ1jWFlBCCt6EPRKzD3/egH
 po4R/RLm1qMFYY/m/XoaODopXNCiTgUlBZcPl7ae0caV4LZrrZuNncLbPV7hUlizYW5w
 loNRxSsmWTb9SsU/Ya+eHGWiVLyOs4P8AgPZ6xdLExsNznloJa3ZMcJPeAC6xqRo0VyT
 ALBw==
X-Gm-Message-State: AOJu0YymE0wqBs/aNQ0gIxGdfLaGez/Q5/G2JU7TgiaTf81sJeReaJht
 wRtMHsIx0OLj8bH2YnGN6pq7SX5pth9GWMVqRJC5YiF4JI6VVPVZHwOZ8erdGyOTNIxDJNN+cKT
 mB3v43au3EJkILqLhvFDSXH8BtYJOSB0=
X-Gm-Gg: AZuq6aJAdb95vH2pb9EE1FW+6P1in2dkSwKVXCgLqkNcJ3uIqBU2EXB0bjmxslXaSD8
 ucZ0PtN65TmfubgF7Z+wz2eRuuthu73sm3K2tW4yFEla32DZ0xL4U7y3rIyA5hIK/90ajsSbBFD
 oDnJPoRmg4zJ4lf4iBvfiLOAa0wHQ5VjGNDkUS0lfoiH/9v3qrSQvmvP7z+KZbCVlFdK2VHFCSV
 /Jb25xEXwjM8OKtHXEA0oet1mBcSnQch8k83/8aLZ94hXCHKBF3PjlAa7v801M2C1ptf/i+sHs8
 o/Tl12trW1S72UKx6XQMKlCQZhWjeXPdTVFY00hf95rRLkv0qJfsVzBaZfjwjjGxfoY6GgVZW4I
 ZYOc=
X-Received: by 2002:a05:6102:3a14:b0:5f5:773f:b1e3 with SMTP id
 ada2fe7eead31-5fe16d85cdbmr95979137.11.1770931939696; Thu, 12 Feb 2026
 13:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20260211180645.3313596-1-james.hilliard1@gmail.com>
 <cf72da71-12f3-45ab-b703-6cc776ed28ab@mailbox.org>
 <CADvTj4qtaoyJc9MtbjbpC+t_h3yO=jBXNed_3BAmDWMbDbhRPg@mail.gmail.com>
 <a00c737b-4f8f-4e26-974b-aa14ebbef64b@mailbox.org>
In-Reply-To: <a00c737b-4f8f-4e26-974b-aa14ebbef64b@mailbox.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 12 Feb 2026 14:32:08 -0700
X-Gm-Features: AZwV_QhjnLMq_KPf_eTtK2osBks7SsvLMPnj-zmkwyQhCaI9xvEot7Byqb_msLE
Message-ID: <CADvTj4pXOQ5KKJa2ZmU0WhaqMYYS8k9AXd8xZ6Uv1HvW-H_wpQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] image: fit: Apply overlays using aligned writable
 FDT copies
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Jamie Gibbons <Jamie.Gibbons@microchip.com>, 
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 David Lechner <dlechner@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Fri, 13 Feb 2026 00:48:26 +0100
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

On Thu, Feb 12, 2026 at 1:05=E2=80=AFPM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 2/12/26 8:52 PM, James Hilliard wrote:
> > On Thu, Feb 12, 2026 at 8:26=E2=80=AFAM Marek Vasut <marek.vasut@mailbo=
x.org> wrote:
> >>
> >> On 2/11/26 7:06 PM, James Hilliard wrote:
> >>
> >>> +static int boot_get_fdt_fit_into_buffer(const void *src, ulong srcle=
n,
> >>> +                                     ulong extra, ulong min_dstlen,
> >>> +                                     void **fdtdstbuf, ulong *fdtdst=
lenp)
> >>> +{
> >>> +     const void *fdtsrcbuf;
> >>> +     void *tmp =3D NULL;
> >>> +     void *dstbuf, *newdstbuf;
> >>> +     ulong dstlen, newdstlen;
> >>> +     int err;
> >>> +
> >>> +     /* Make sure the source FDT/DTO is 8-byte aligned for libfdt. *=
/
> >>> +     fdtsrcbuf =3D src;
> >>> +     if (!IS_ALIGNED((uintptr_t)src, 8)) {
> >>> +             tmp =3D memalign(8, srclen);
> >>> +             if (!tmp)
> >>> +                     return -ENOMEM;
> >>> +
> >>> +             memcpy(tmp, src, srclen);
> >>> +             fdtsrcbuf =3D tmp;
> >>> +     }
> >>> +
> >>> +     newdstlen =3D ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
> >>> +     min_dstlen =3D ALIGN(min_dstlen, SZ_4K);
> >>> +     if (newdstlen < min_dstlen)
> >>> +             newdstlen =3D min_dstlen;
> >>> +
> >>> +     dstbuf =3D *fdtdstbuf;
> >>> +     dstlen =3D dstbuf ? *fdtdstlenp : 0;
> >>> +
> >>> +     /*
> >>> +      * If the caller already provided a large enough writable buffe=
r,
> >>> +      * and we're not moving the FDT, nothing to do.
> >>> +      */
> >>> +     if (dstbuf && dstlen >=3D newdstlen && dstbuf =3D=3D fdtsrcbuf)=
 {
> >>
> >> Can $dstbuf ever be NULL ?
> >>
> >>> +             free(tmp);
> >>> +             return 0;
> >>
> >> You could try something like this here, to reduce the duplicate
> >> free(tmp) in the code:
> >>
> >> "
> >> err =3D 0;
> >> goto exit;
> >>
> >> ...
> >>
> >> exit:
> >>     free(tmp);
> >>     return err;
> >> "
> >>
> >>> +     }
> >>> +
> >>
> >> [...]
> >>
> >>> -     load =3D (ulong)of_flat_tree;
> >>> +     len =3D fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base=
_buf);
> >> How does this new length calculation work, can you please clarify that=
 ?
> >
> >  From my understanding, that len is tracking the current packed DTB dat=
a
> > length (up to the end of the strings block), not the allocated buffer s=
ize. We
> > recompute it after each overlay so need =3D len + ovcopylen
> > CONFIG_SYS_FDT_PAD grows from real used bytes instead of
> > accumulated slack. This is roughly the same idea as libfdt=E2=80=99s in=
ternal
> > fdt_data_size_(), and the final returned size is still taken after fdt_=
pack()
> > with fdt_totalsize().
>
> Ah I see, thank you for the clarification, this helped. It would be nice
> to include that as code comment too.

I'll add a comment.

>
> But don't you have to account for the FDT headers too, so wouldn't
> fdt_totalsize() be more appropriate here ?

From my understanding, fdt_off_dt_strings() + fdt_size_dt_strings() is the
packed DTB data size we need for growth calculations, and it already
covers data from the blob start (so headers are implicitly accounted for
via the offset). fdt_totalsize() includes spare/free space, so using it the=
re
would overestimate need and cause unnecessary buffer growth.

>
> >> I don't think this will work for fitImages with external data (generat=
ed
> >> using mkimage -E) , but I might be wrong.
> >
> >  From my understanding, this should still work with mkimage -E, externa=
l
> > data only changes where FIT payload bytes are stored, and
> > fit_image_load()/fit_image_get_data() already resolves that before over=
lay
> > application. At that point we=E2=80=99re operating on a normal copied D=
TB buffer,
> > and the length math is based on DTB-internal layout, not FIT
> > external-data placement.
>
> Clear, you're right.
