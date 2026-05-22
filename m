Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E02CD5BB0
	for <u-boot@archiver.kernel.org>; Fri, 22 May 2026 16:42:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BE6C84882;
	Fri, 22 May 2026 18:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XZvWvCrn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE6A98488D; Fri, 22 May 2026 18:42:14 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6193846F1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 18:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7de44ed7a11so7503249a34.1
 for <u-boot@lists.denx.de>; Fri, 22 May 2026 09:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779468131; x=1780072931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TrCbOdh2tJltdCOinGAOuo9BsvpNqUMp0+qM5JKzFe4=;
 b=XZvWvCrn2CU3mRH/hLBizsHZKNcBM+7lpC+4SyIFo5ai83w4LwKfyrj5oK9pKckHcS
 EXf3dPm8FmI3cruRMA/Ptu5RKlnQ72eJW/EsjW2V77Si6sMIcFabKXYN1dyL2cfPKhKr
 kmJOUlGtLiybie7HmUT0nHN7TpIu1WQslVxT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779468131; x=1780072931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TrCbOdh2tJltdCOinGAOuo9BsvpNqUMp0+qM5JKzFe4=;
 b=lleUAZarqZKAPxZKi2CqKi+spsLBEVyhg1DPRD/+6jki809D5qB/LawgT2SVfWSS+A
 4DybuPagVxGrlvg3c3+w9RrR6YYXAfVvXvS+R5jCFn2VBx2SvVF5Ht6kCiBEurhpzAuV
 WurFvagMazQrNLd5o8JB/774MdVEDKUDAKMW2dXT/bVjgURkpWG8ELwBx6JIbB6JDd+h
 leMWThnGglqijQIkAsWesJ+FlbqSXYAz72qjqW0oB2pfraC4JCAy+c3eIYjj8qANV5On
 t2X3tAYl9+1mwoKIAKflT7s7MutmHG2/sBoPirwc82ZdbQ+p5e2WOEc7Y+Ds7ZSccxjV
 6Svw==
X-Gm-Message-State: AOJu0YxxdIDLSeJnwEpWiRTsQ0UMj1JjMuVmpI7JzOwfzFj6v35W1mIc
 5BY58EEXFYX2SSWcu18CjDvh6W51hWBdwzSvRI2fdsjjlV6npncEzrO9G98vYGd2hs0=
X-Gm-Gg: Acq92OHDOjj75PSYa9qkjwF/AobzpCkXaOS3onp5Eip0zTCkNNJn/A+VrbmIPbTba6R
 rd4yxB5W5t11mVv1Iw6brKuI1S+iuPTQD8IneEFeDl/4dCiOpm1tcmaADsHJb1HniN3+b6TYSxU
 0xUemG0dLq9c6oJF2cyS1rtbdp2JfWxiDzqAmWqEjSyIDoWd3S+nyUEE6fvn04ZgAlSiUCH7ffd
 kWF15CHrraM8ltH5zDHP41dGUj4Gsz+KSKxoxOXVdwOzKIU+F5ALkHXUjX40NKrmZr7y2X0Vvl5
 pnwN5gB+dA2KMB5NI8BCovRbRtwFAJnPI5FCUjLpenjV2v/KIvDUxhQy9+f90rBoc6Qmrxb4lMp
 2XHzvl8xm629/R44xiifoRDGZsKUUI6FqNUKMADJ4NgWw7W+gkHLwt0NMjIhZWztw1TlEHuraHF
 V48HgQehsTTu/oCB3xWQCD8h6dWhqv74xF8/F3qHeNtaQCUsG7UmU/FEQtDi2mPuDIu9PmVJy6V
 7ZVtM037wYvsNvYgR2DM8jNM8KXJzlaSZ7ZlTMZz0II/w==
X-Received: by 2002:a05:6830:40c3:b0:7d7:d60e:650a with SMTP id
 46e09a7af769-7e5ff0355a4mr2358284a34.23.1779468131346; 
 Fri, 22 May 2026 09:42:11 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e6aabsm1345442a34.13.2026.05.22.09.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 09:42:10 -0700 (PDT)
Date: Fri, 22 May 2026 10:42:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Benjamin ROBIN <dev@benjarobin.fr>,
 Ludwig Nussel <ludwig.nussel@siemens.com>
Subject: Re: [PATCH v1 1/2] bootm: fix overflow of the noload kernel
 decompression buffer
Message-ID: <20260522164208.GS1858239@bill-the-cat>
References: <20260520044554.15373-1-aristo.chen@canonical.com>
 <20260520044554.15373-2-aristo.chen@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+hwDUHHJy/tMlyxf"
Content-Disposition: inline
In-Reply-To: <20260520044554.15373-2-aristo.chen@canonical.com>
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


--+hwDUHHJy/tMlyxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 04:45:50AM +0000, Aristo Chen wrote:

> For a compressed kernel_noload image, bootm_load_os() allocates a
> decompression buffer sized to ALIGN(image_len * 4, SZ_1M), assuming the
> kernel compresses by no more than a factor of four. It then passes
> CONFIG_SYS_BOOTM_LEN, rather than the size of that buffer, to
> image_decomp() as the output limit. The decompressors honour the limit
> they are given, so a kernel that decompresses to more than four times
> its compressed size is written past the end of the allocated buffer and
> corrupts adjacent memory.
>=20
> Pass the allocation size to image_decomp() and handle_decomp_error() so
> decompression stops at the buffer boundary and fails cleanly when the
> image is too large, instead of overflowing. The regular non-noload
> paths are unchanged and continue to use CONFIG_SYS_BOOTM_LEN.
>=20
> Fixes: 69544c4fd8b1 ("bootm: Support kernel_noload with compression")
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--+hwDUHHJy/tMlyxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahCHXAAKCRAr4qD1Cr/k
Cq9TAP0dtd+P54GzQgAIKAlBJrDthn/1qrBwRcBs1WOHQkFY9wEA4z8DN7PVgcOr
Hva3OFZ+VZLcUgz5pkIfZK9nLDpyLQc=
=mJB6
-----END PGP SIGNATURE-----

--+hwDUHHJy/tMlyxf--
