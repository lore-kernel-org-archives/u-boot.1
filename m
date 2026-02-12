Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A586EEA84F
	for <u-boot@archiver.kernel.org>; Thu, 12 Feb 2026 20:38:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980E583CB5;
	Thu, 12 Feb 2026 21:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TrkQjx77";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 923DB83CB5; Thu, 12 Feb 2026 20:52:17 +0100 (CET)
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com
 [IPv6:2607:f8b0:4864:20::933])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 760E583015
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 20:52:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=james.hilliard1@gmail.com
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-948aec218a2so63597241.0
 for <u-boot@lists.denx.de>; Thu, 12 Feb 2026 11:52:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770925934; cv=none;
 d=google.com; s=arc-20240605;
 b=kNoStn6fN/WSWk37CQR75uJiSwkdUBqE9pF+4qOQkJgtJlW1qZYtug9yKFYdEJ8YV9
 RbHxGKmT1mgFThfPB5IfMTLEJCxkrJvtRyBwbggtJCM7Aan8N/6vm2O/hN56/XSclyNi
 Lx5fWJnvns6MD3zefo7qLqQsKM1QYaogGNuNQW1DqCbXlp18ktOg1cPDZ+TKp0M+hdEB
 qpmaMKzVSDNrWw/9S3wTTJ8RbfaK5MNBB4ptc1fw15WJHwZJzohK11Qvh56qs0c6wU6I
 IBdps8tdEFy8wrWg59We2TT+UAQPOvoC6yJHAg4TGNLJIuhe/StkaHmg7EFj6WLdpCPC
 W3gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=NZjFxy3k6j4JoNnrMmHWKkMMwkvjdEAOhi+mWaiGb8w=;
 fh=CZg+trVLT5C7hPiIM0OSJFRG3Myi0YjcN1bp5nRv5F4=;
 b=Tb2vWaa3HX+DJLxK0A0JedelOO4w5VAMooP4tAW6s+PIJ2NHq7XF33dMmO/Us/hdHJ
 qgwO0Es8wuGH/nR2MwHt+jbdy7UDm2o0+1uXH6UMHJOvbU6Xp712IFaeYJRpSVBtAZJy
 t1uJop74H/Xn7D2p13eNGKq14IPVbjAHkDE3SfFyfi3nLDbBqPP1WC1LOReMUIyaiTtJ
 7sdz23BePZLy0jy81RGAukPHcMPCsrIJ2VS3OKlZjE7ee2QXXDr1IXtDEKpOAer8yfYo
 0jSjEUKBOeySeod7PBMKFPjSDf0hGXHRC2kmhv5w9DXZykMxIYzwPbzT6RaGSZ9VGsPd
 XRaw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770925934; x=1771530734; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NZjFxy3k6j4JoNnrMmHWKkMMwkvjdEAOhi+mWaiGb8w=;
 b=TrkQjx77+8AeO3xhc35m5aOqEkqlGrpG1Ar7GR1MCVvfh40poL44PHV3fz+eEDHA2q
 WdWlFe0BUiGkuW2cjZOfWSmxU34NH8HONaSJLr2kGsdinmCGlfG0S2aGlFBsNzN0Yk4D
 KhRRIF7cs2drzkLWyNJb8hGuxxGqAVKmY7Xd4+3dPvGXMZpX9Fpsn3xNd2+lezxOFT7k
 kekGaIdhPXE8FMITFX9sX58Y9s2LHPhs7m5r1fLvIpgUVqPEnbIkK8w5U8sfGnNkPrf3
 SZshFlJnCuKlUXaSefWqFQfIOjKrOW0Afz7IFcOY1hW2Ty7pj3X/2tbOeB+vaoMzRal9
 RVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770925934; x=1771530734;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NZjFxy3k6j4JoNnrMmHWKkMMwkvjdEAOhi+mWaiGb8w=;
 b=LPW8ufVyn4BddqBNKHmzTP8hdObvIumrVmLoU0J8EaEyW+R3y0/tZ4QCsVlbAb/z9i
 7DUSPcnZyzRsReEBy5/raOj+kKNXQl8gzuT6IXhbw/dD2KRVxt/+4wm0fxAoBAEipvqs
 hEdG2aKAEESYyUDE20ORs2TIgK838YBnsbWqQoECIFsxX1HOA3etTwPRslnXUhapaZcn
 6qBP9vXT3JAveUqt1KdTqnWrvNP/rsss1hQgTcw5ca7sZqg8r7vw+meLciXJJo1YMnqT
 pBVboVl+54L7Wy83V2b1zQDUNk7hK+JkKh56174t9CtIUilbxew5qshC7Ew98lvR5lRh
 qoUw==
X-Gm-Message-State: AOJu0Yx3xHiLcbNxzgn4EUxq1meJ9jcOtJjkBGc/E866UmJO5jVf1akz
 YnMT+gRqyR8gAM9X/zvxKW5so+1N4HMBgq/kJlZCnwQUbHbLNZoYsd1bBSQomFdHhZMzbS0KXis
 Te8pkzNPGHB2dikKxSparsC9c+Nm5uZo=
X-Gm-Gg: AZuq6aJ5vdkCVu84MJICop1b8mu6b05ouMPXcPIbngVqzP3g7QBSc8GCuG/WK7dfneX
 JMeVIN8l78w7EUR8FpnBKi6I64tTnalRqTncAWIf4U7P35yo/T0aVrrnGG8ZAqU5MQXxWoDEzfq
 ik/chbAuJjUBIeDEizUqYc1U/To/nhEg1Gh3hkDXdqvKPwgQ4DlFx+uV8viGJnNzamdTv/s6b/q
 bv5/vJ3Xwb+sAZWG53v8+FMQJcH3EKzoWbpVGoA2Zt1y3V8eDz7tN8gVls0ofGbuM3ksmeSfPYh
 3Ty7sGtaC6IKHyE1qlkzojNFHc+4bv+Em+G2ahxjm76ttPKVOAievN1tJ4RtT/fS0rpy7ZVkqG6
 BEUI=
X-Received: by 2002:a05:6102:2acb:b0:5f5:7791:c2cb with SMTP id
 ada2fe7eead31-5fdfbe3a63amr1140569137.41.1770925934264; Thu, 12 Feb 2026
 11:52:14 -0800 (PST)
MIME-Version: 1.0
References: <20260211180645.3313596-1-james.hilliard1@gmail.com>
 <cf72da71-12f3-45ab-b703-6cc776ed28ab@mailbox.org>
In-Reply-To: <cf72da71-12f3-45ab-b703-6cc776ed28ab@mailbox.org>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 12 Feb 2026 12:52:04 -0700
X-Gm-Features: AZwV_QjYgolakMxp8r53NK4lyRHEI-XnmHeUI54wmN1Q5CtdIcwMr2Xu7hU99Bc
Message-ID: <CADvTj4qtaoyJc9MtbjbpC+t_h3yO=jBXNed_3BAmDWMbDbhRPg@mail.gmail.com>
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
X-Mailman-Approved-At: Thu, 12 Feb 2026 21:38:32 +0100
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

On Thu, Feb 12, 2026 at 8:26=E2=80=AFAM Marek Vasut <marek.vasut@mailbox.or=
g> wrote:
>
> On 2/11/26 7:06 PM, James Hilliard wrote:
>
> > +static int boot_get_fdt_fit_into_buffer(const void *src, ulong srclen,
> > +                                     ulong extra, ulong min_dstlen,
> > +                                     void **fdtdstbuf, ulong *fdtdstle=
np)
> > +{
> > +     const void *fdtsrcbuf;
> > +     void *tmp =3D NULL;
> > +     void *dstbuf, *newdstbuf;
> > +     ulong dstlen, newdstlen;
> > +     int err;
> > +
> > +     /* Make sure the source FDT/DTO is 8-byte aligned for libfdt. */
> > +     fdtsrcbuf =3D src;
> > +     if (!IS_ALIGNED((uintptr_t)src, 8)) {
> > +             tmp =3D memalign(8, srclen);
> > +             if (!tmp)
> > +                     return -ENOMEM;
> > +
> > +             memcpy(tmp, src, srclen);
> > +             fdtsrcbuf =3D tmp;
> > +     }
> > +
> > +     newdstlen =3D ALIGN(fdt_totalsize(fdtsrcbuf) + extra, SZ_4K);
> > +     min_dstlen =3D ALIGN(min_dstlen, SZ_4K);
> > +     if (newdstlen < min_dstlen)
> > +             newdstlen =3D min_dstlen;
> > +
> > +     dstbuf =3D *fdtdstbuf;
> > +     dstlen =3D dstbuf ? *fdtdstlenp : 0;
> > +
> > +     /*
> > +      * If the caller already provided a large enough writable buffer,
> > +      * and we're not moving the FDT, nothing to do.
> > +      */
> > +     if (dstbuf && dstlen >=3D newdstlen && dstbuf =3D=3D fdtsrcbuf) {
>
> Can $dstbuf ever be NULL ?
>
> > +             free(tmp);
> > +             return 0;
>
> You could try something like this here, to reduce the duplicate
> free(tmp) in the code:
>
> "
> err =3D 0;
> goto exit;
>
> ...
>
> exit:
>    free(tmp);
>    return err;
> "
>
> > +     }
> > +
>
> [...]
>
> > -     load =3D (ulong)of_flat_tree;
> > +     len =3D fdt_off_dt_strings(base_buf) + fdt_size_dt_strings(base_b=
uf);
> How does this new length calculation work, can you please clarify that ?

From my understanding, that len is tracking the current packed DTB data
length (up to the end of the strings block), not the allocated buffer size.=
 We
recompute it after each overlay so need =3D len + ovcopylen
CONFIG_SYS_FDT_PAD grows from real used bytes instead of
accumulated slack. This is roughly the same idea as libfdt=E2=80=99s intern=
al
fdt_data_size_(), and the final returned size is still taken after fdt_pack=
()
with fdt_totalsize().

> I don't think this will work for fitImages with external data (generated
> using mkimage -E) , but I might be wrong.

From my understanding, this should still work with mkimage -E, external
data only changes where FIT payload bytes are stored, and
fit_image_load()/fit_image_get_data() already resolves that before overlay
application. At that point we=E2=80=99re operating on a normal copied DTB b=
uffer,
and the length math is based on DTB-internal layout, not FIT
external-data placement.
