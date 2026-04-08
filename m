Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEDCB10F9973
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 19:12:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 420CA838BB;
	Wed,  8 Apr 2026 21:12:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n8VlR6SZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9139E83CF5; Wed,  8 Apr 2026 21:12:50 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5825D83693
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 21:12:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7dbccf6a23dso103831a34.2
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 12:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775675567; x=1776280367; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0hcnBOagyo4mmUBTBBfuX8gI/u7dF1gRWtS0lgTgEUs=;
 b=n8VlR6SZow0zB7RT7DB3kn2KN/DYmDII3oO45/z3IPpDSyON+LvCvFZFgXT91X/rqB
 eH1ubACG28K4xQwg5Z2yiAH16znwm3bXpP6Glsi7/XAOr91Ws2oUqxMbU9v5UOHPl1r3
 Y/C4n2+mJ8WpTpTfvBbEnKzqvaRRSzNChvnmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775675567; x=1776280367;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0hcnBOagyo4mmUBTBBfuX8gI/u7dF1gRWtS0lgTgEUs=;
 b=Y7ElCx8CTNfsDHtu4bTkrEVcJp4EZ4F7ukl7156JRD5MIDv7Uz+BKeTDG1Q5zOSA10
 AjrKMgy0vXvNQ+yzPGYE3ejJgB1Sl9Hkn6+dc5c8XkNa0H4LgRHSGCe7KEM4M6f9Hboi
 vkbxUbVoO6EQkIsV3/b2FzD5nCewbYt/p5/tAg3GJW/Dc42y9/3BLtoEwrEydcARaZNw
 iS+XK8cNkrDFAqoLiSlVnSVMDpiu8fku2MbDUSSWEFJ88uiRRO+CHEamkvQ5WXyJkoSc
 9r05dnlFSUiQ+YB9aQRIIahRfFRwADOkobLlcD10e/Eur/CpV0+hlemu4090YBQNmlCD
 OBXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVh+BCqkdBUsD7RVTA5eHegk7YKMM9C7f4YbPwEpFEmityMD8Qq34g9tbXCNc6G6EPEDFTUyKQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxBfgyhHVTPUuPjFXktDTxeeJn+ImKz9yJ0YdxdKwOix2TXibgZ
 1DwaztZiNnUoze06SPTxEmxYaFQ3/oZuxbUnZh8TsqDgosO28Ymk/NfXxSnwlEA5jkVk94AJ0LF
 1LT9pa6w=
X-Gm-Gg: AeBDieuY6OR9AJugkDrY4VdNRIwfmf2CSk8s5k/DKepsyTXm6suOnrbR/fmKccaFvuI
 MbJXiXOHn/HgKLwk3bP63s5GtCe0pJnpjnL6vocdY8QDb7I2cEhYr0ROR4CZx1qHlPNZ+iB5SgT
 7KXfoS+ESt+ZdZc/lkNAUxBTyMUYJex67/npCBovwyoKFaL3b4J/TR83XuaNHf0XJ/4W15+wF+e
 kNdf4FrFXLkquR9KwXmpH3AqPp/03fgoR7d0HZjlQB6zY50MP4FvHHTeOAery6rW0xCAEDFm11d
 1ZCFqlIghqReHwmDAj4Idke2pOpCcrokEER3zjaWMIGAkgy3oAMMA4YjhK52BdLJ/vpZSFILtdJ
 peJyXNhctK6PZLPhCQAf1B6svcAz2xign/s4IM4+0JlY9TOp/rEzOhn/fPioKicFgC952f0R3RF
 aSMmhGbontN1sJA2Y6f/ygwytP6fg4v7cL4dLVH82HgTyoeatNYVdmd+20mnCH2KOQZJPV54a22
 PScIQsH0riBsbZ7MNWLYteg/UymaWf7qtM+wctfZqqGka4IKwU=
X-Received: by 2002:a05:6820:2d04:b0:67d:fc49:4b97 with SMTP id
 006d021491bc7-6821cd3bf70mr12417511eaf.13.1775675566959; 
 Wed, 08 Apr 2026 12:12:46 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-422eb42db1bsm19358652fac.17.2026.04.08.12.12.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 12:12:46 -0700 (PDT)
Date: Wed, 8 Apr 2026 13:12:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: christian.poetzsch@kernkonzept.com,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Bin Meng <bmeng.cn@gmail.com>, Adam Lackorzynski <adam@l4re.org>
Subject: Re: [PATCH] virtio: add support for SIZE_MAX & SEG_MAX features
Message-ID: <20260408191244.GA837666@bill-the-cat>
References: <20260327081858.311591-1-christian.poetzsch@kernkonzept.com>
 <CAFLszTjKtFM6RXE_ZoEFbpW1ZGPtLCcqzJeceaLGPYoTfGA9vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IEetXDNZj8JFpTek"
Content-Disposition: inline
In-Reply-To: <CAFLszTjKtFM6RXE_ZoEFbpW1ZGPtLCcqzJeceaLGPYoTfGA9vQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--IEetXDNZj8JFpTek
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 02, 2026 at 01:41:11PM -0600, Simon Glass wrote:
> Hi Christian,
>=20
> On 2026-03-27T08:18:58, Christian P=F6tzsch
> <christian.poetzsch@kernkonzept.com> wrote:
> > virtio: add support for SIZE_MAX & SEG_MAX features
> > virtio: add support for SIZE_MAX & SEG_MAX features
> >
> > Some virtio implementations may forward the virtio requests directly to
> > the underlying hw. The hw may have some restrictions in how many and how
> > big the requests can be. Therefore, the corresponding virtio device will
> > announce this limitations with the SIZE_MAX & SEG_MAX feature.
> >
> > Add support for those features. Split an io request into multiple virtio
> > requests if more than seg_max segments would be used. Also split a
> > single buffer request into multiple segments if the buffer is bigger
> > then size_max.
> >
> > Signed-off-by: Christian P=F6tzsch <christian.poetzsch@kernkonzept.com>
> > Signed-off-by: Adam Lackorzynski <adam@l4re.org>
>=20
> > diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> > @@ -119,7 +145,38 @@ static ulong virtio_blk_do_req(...)
> > +err_free:
> > +     for (i =3D 0; i < seg_cnt + 2; ++i)
> > +             free(sgs[i]);
> > +     free(sgs);
> > +
> > +     return status =3D=3D VIRTIO_BLK_S_OK ? blkcnt : -EIO;
>=20
> The err_free label is reached from both the success path (fall-through
> after virtqueue_get_buf()) and error paths (goto from malloc()
> failure, virtqueue_add() failure, or unknown type). On error paths,
> status is uninitialised, so the final check has undefined behaviour.
> Please can you separate the success path from the error cleanup, e.g.
> with an explicit return before the err_free label.
>=20
> > diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> > @@ -145,38 +145,38 @@ static ulong virtio_blk_do_req(...)
> > +     while (i < blkcnt) {
> > +             u32 blk_per_sg =3D min(blkcnt - i, seg_sec_cnt * priv->se=
g_max);
> > +
> > +             ret =3D virtio_blk_do_single_req(dev, sector + i, blk_per=
_sg,
> > +                                            buffer + i * 512, type);
> > +             if (!ret)
> > +                     return ret;
>=20
> The error check is inverted. virtio_blk_do_single_req() returns blkcnt
> (positive) on success and -EIO on failure, so if (!ret) only triggers
> when ret is zero. I suspect you want if (ret < 0) here.
>=20
> BTW please add a function comment for virtio_blk_do_single_req() so
> all this is clearer.

This is all true, and useful feedback.

> > diff --git a/drivers/virtio/virtio_blk.c b/drivers/virtio/virtio_blk.c
> > @@ -67,50 +74,69 @@ static void virtio_blk_init_data_sg(...)
> > +     // The virtio device may have constrains on the maximum segment s=
ize.
>=20
> U-Boot follows the Linux kernel coding style which prefers /* */
> comments over //. Please can you convert these.

This hasn't been true for a number of years, Linux Kernel nor here.
We've accepted C99-style comments (when not needing to be kernel-doc)
for a long time now.

--=20
Tom

--IEetXDNZj8JFpTek
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCadaoqAAKCRAr4qD1Cr/k
Cj+lAQCXwohF6rLhgWVJziDZDqhIyFpUpYDvWU4VxteWbglBbQEAvFRPR5kb26Ck
XpxGuX/pOZRRKfNrQP9YK/Th49kjTwA=
=W4+W
-----END PGP SIGNATURE-----

--IEetXDNZj8JFpTek--
