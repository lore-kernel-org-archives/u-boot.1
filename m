Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E7F2CAC5B8
	for <u-boot@archiver.kernel.org>; Thu,  2 Oct 2025 17:04:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C762F828A2;
	Thu,  2 Oct 2025 19:04:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f4k3kuok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D2CA835A2; Thu,  2 Oct 2025 19:03:59 +0200 (CEST)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD9F181D6A
 for <u-boot@lists.denx.de>; Thu,  2 Oct 2025 19:03:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-4248746aabfso4844775ab.2
 for <u-boot@lists.denx.de>; Thu, 02 Oct 2025 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759424635; x=1760029435; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NeqtaCYwtiZnVJi3zGi1R3/t+A2pPy7NeCgYrPwTvBs=;
 b=f4k3kuokc3KQnXOY4mbRopYHWxl5K26VNBHiUOvh+mWpxMns8vVB8d1IHts50I5T2t
 YkG5JC6mDIYwqoXi7VKPLzn1uSLHGU4c5MTdGlyb74LZpLIFcUP43rdqf9RloJoq2bpY
 3fYuwYPoyl0X1ee8lVl5mrd+1MmWWsaMRQfNs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759424635; x=1760029435;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NeqtaCYwtiZnVJi3zGi1R3/t+A2pPy7NeCgYrPwTvBs=;
 b=nJM5i8kBEnEfaGx+z4ZMI97xT30N6grWFEuPt3taEeatFsFz0owfITXzPqigY/PaOt
 fcPBewCzhF/RZWqvKlrki3F/+EjaSl6NrARHIgTCU62DVY/abPMOcZ9cS9KSw8PLRNGs
 3s5uYaKzs0XRiYDsH60BEns+YyQ2oBY4oVhwezXGilagHGfr6HWqRlB6tYIdTHsMR012
 4UvokyxULK22RW9lkoDCbIWiqyXZbTKO/A0th3lED8Y9c2Qoysua9DOhnAKYvJ6I4m6a
 LWHCbdBcsJbEQQGrw2aR2fqV4kypRck/8gvnHHvTTYzL9zq4PJolwdiqM3AyK34wO9Cw
 6sFQ==
X-Gm-Message-State: AOJu0YxceKNbRvRrh1i47Xj35kop1t5Cajaj6phZFbV8s1O+YU5OZat6
 0MPexrfJHMjfDp5BtmByL/VmuIv4/EWJBUhz3iHLYPMVICyxKtpzUQFAZ9SsRXxBl9s=
X-Gm-Gg: ASbGncvHWf9UOi2bJUjA7nffSt/mmi7cosavtB3uIuzJtktNYEMMRqd3uROByJ+tox1
 yhkg9fXPVqSdZVR7RTc5XpLxxCGti+X+uALI25thY/Xx3dfKhv8mEw2/UUIBKe5NFkuyLdOrZ1J
 m+Jqok3sPyjLq68C0y4uERVV5Vdh7yR868viPj9tdg8VsYuHLl2CfN7OO5Qc0YVahD+i3pxmeoq
 Pb2a8dzjoxEdEwYekBaDEr7CXhy4ZZ1xDLloDlodZmLuav+Ctqp1LJPwUF0WPTDtWPFNT12s0Xw
 6EB9U3TfknWjibsSJbK7FFfBX7Ymag8vGCI4r+b1r3YjLZ9sm6eB0DNU2WYH+CqSvgVvoIeOHUw
 Hs/xQxFXMn9zzCE7u+gA/INvWs7vhOVQB+rEZa/Unr6F0/ldspqSnvpDlgBCd+iu8xVdXRX3O1G
 zj5u5fW+AO0A==
X-Google-Smtp-Source: AGHT+IGBRHXMrL6VkLB/F/c+XCuRV0j+ZMm51mwihFLhgBg/gsfy1LwC1wQvzRppNV7rAEhLg0ZCwA==
X-Received: by 2002:a05:6e02:1d94:b0:426:dc47:c8cc with SMTP id
 e9e14a558f8ab-42e7ad9a74fmr3009645ab.23.1759424635466; 
 Thu, 02 Oct 2025 10:03:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42d8b28161bsm11301295ab.28.2025.10.02.10.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Oct 2025 10:03:54 -0700 (PDT)
Date: Thu, 2 Oct 2025 11:03:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] boot: vbe: Make BOOTMETH_VBE_xxx a choice
Message-ID: <20251002170352.GM6093@bill-the-cat>
References: <20251001203059.2828551-1-trini@konsulko.com>
 <CAFLszTg8BFgpeYj7Gz-9ac5TVLaJJ5fs87oSeOfurSNT6dCa3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="XBT08u52j5Acmr9b"
Content-Disposition: inline
In-Reply-To: <CAFLszTg8BFgpeYj7Gz-9ac5TVLaJJ5fs87oSeOfurSNT6dCa3w@mail.gmail.com>
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


--XBT08u52j5Acmr9b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 02, 2025 at 10:29:58AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 1 Oct 2025 at 14:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > It is not valid to enable multiple BOOTMETH_VBE_xxx methods
>=20
> Why is it not valid? That wasn't my intention.

They fail to build because they both declare some of the same binman
syms:
$ grep 'binman_sym_declare(ulong, vpl, size)' boot/vbe*.c
boot/vbe_abrec_fw.c:binman_sym_declare(ulong, vpl, size);
boot/vbe_simple_fw.c:binman_sym_declare(ulong, vpl, size);
$ grep 'binman_sym_declare(ulong, vpl, image_pos)' boot/vbe*.c
boot/vbe_abrec_fw.c:binman_sym_declare(ulong, vpl, image_pos);
boot/vbe_simple_fw.c:binman_sym_declare(ulong, vpl, image_pos);

Enabling both leads to link failures.

--=20
Tom

--XBT08u52j5Acmr9b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaN6wdAAKCRAr4qD1Cr/k
CjHQAQC6bYpH03KKC2ZwuBFwpzYdDIJTlrGhGb+JHR+Jt99Q4gD/UHNPD6jhqHv4
NnijGUgTG4gtvkH1taQS4mEBqdKT0wI=
=Vmnn
-----END PGP SIGNATURE-----

--XBT08u52j5Acmr9b--
