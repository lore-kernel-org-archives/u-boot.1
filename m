Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C430CD10F25
	for <u-boot@archiver.kernel.org>; Sun, 17 Nov 2024 17:51:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1344F891CF;
	Sun, 17 Nov 2024 18:51:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kvh43SUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0177891CF; Sun, 17 Nov 2024 18:51:17 +0100 (CET)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1AD89009
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 18:51:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6d419832bf5so9071056d6.1
 for <u-boot@lists.denx.de>; Sun, 17 Nov 2024 09:51:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731865874; x=1732470674; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CjOPbdTXBxyDUpC1X8VN4i/cj50jSjlwBlTrGY6O43U=;
 b=kvh43SUZ93Z5w5BV7htQ/rs595B0L4fvRzGXqB4l+UgkI6lk16+vn7fBUPqSTS4Yhr
 XBtMDlBkrDGlOjorzJoh+VVbtHAXxeS2oeUOz8sYVzdT6Aninqshd7L/ftyCeM6GLOwZ
 npzY1V8i/SFRUb91NjfWz2MdUCKCAhOvhbqH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731865874; x=1732470674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CjOPbdTXBxyDUpC1X8VN4i/cj50jSjlwBlTrGY6O43U=;
 b=HVnAV36b1LPu0DA/Q3OUUvqIsMWUR1TqhLwkGjbboX/O9Qbg6QS1FXD45O7OnAy+qP
 FMCu4LmSZ1dfqRUiNRMT3VkXXJs2PX2nl1tCOYKknc0m1bqCl8t7baJpz4WRuzMJXtsw
 35oXZVSGpzFtaaa+RDXOsm2mCY7fi3353Qx3GF7HmhzwB56LxD8uVZhM6aqsLc6Y+B2z
 1dmI2dYsTNF0Bsasf7ZbUjsLD79hacZemtxNITylH2iAz1aoMfqAGPE798VocUNEDyDl
 7cCVz3DaR41C+SDvWrm5TliYKWmxbPJp2NMD7Sp4HtrFEX5Dx847aR4vjBnSOCvC2fmW
 HnCg==
X-Gm-Message-State: AOJu0YwPaj20CmkRQTWaHk/leAKHwQEPLpOjXB9gYlICpAVu5QBcNfX4
 SRAIiVFJP+Er9dDkpcs6P+uQdPNp4X7Gj/sStIJpmaAw2+sZ4C4oFgc4lMt6qU4=
X-Google-Smtp-Source: AGHT+IEFU+Z3/ZVKbH8hmOi+e6hj+2nC6y/Cc9na3+gx2tPwLzGeBWDJ3M5vR+MhBP0JyXtqpBAglA==
X-Received: by 2002:a05:6214:5690:b0:6d3:4628:9772 with SMTP id
 6a1803df08f44-6d3fb7c7487mr139940426d6.14.1731865874111; 
 Sun, 17 Nov 2024 09:51:14 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d40dd8973dsm23866576d6.108.2024.11.17.09.51.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Nov 2024 09:51:12 -0800 (PST)
Date: Sun, 17 Nov 2024 11:51:09 -0600
From: Tom Rini <trini@konsulko.com>
To: Nick Hainke <vincent@systemli.org>
Cc: u-boot@lists.denx.de, Alexandru Gagniuc <mr.nuke.me@gmail.com>,
 Matthias Pritschet <matthias.pritschet@itk-engineering.de>,
 Simon Glass <sjg@chromium.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Joakim Tjernlund <joakim.tjernlund@infinera.com>
Subject: Re: [PATCH] mkimage: ecdsa: resolve duplicate symbol error on macOS
Message-ID: <20241117175109.GK3600562@bill-the-cat>
References: <20241117165709.24819-1-vincent@systemli.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A9ct/RKrc7PUaoiP"
Content-Disposition: inline
In-Reply-To: <20241117165709.24819-1-vincent@systemli.org>
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


--A9ct/RKrc7PUaoiP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 05:57:04PM +0100, Nick Hainke wrote:
> When building `mkimage` with LibreSSL version 3.7.3 or higher on macOS,
> CI tests in OpenWrt encounter linker errors caused by duplicate symbols.
> Specifically, the `_ecdsa_verify` and `_ecdsa_sign` symbols appear in both
> `ecdsa-libcrypto.o` and `libcrypto.a`, leading to errors such as:
>=20
> ```
> duplicate symbol '_ecdsa_verify' in:
>     openwrt/build_dir/host/u-boot-2024.01/tools/generated/lib/ecdsa/ecdsa=
-libcrypto.o
>     openwrt/staging_dir/host/lib/libcrypto.a[249](libcrypto_la-ecdsa.o)
> duplicate symbol '_ecdsa_sign' in:
>     openwrt/build_dir/host/u-boot-2024.01/tools/generated/lib/ecdsa/ecdsa=
-libcrypto.o
>     openwrt/staging_dir/host/lib/libcrypto.a[249](libcrypto_la-ecdsa.o)
> ld: 2 duplicate symbols
> ```
>=20
> The changes in this commit that address this issue were originally written
> by another developer, Linhui Liu, who decided not to send them upstream,
> instead submitting a downstream patch as a PR for OpenWrt.
>=20
> Given the sensitive nature of cryptographic code, I sought feedback from
> the project maintainers to ensure correctness and encourage the author to
> submit the fix upstream.
>=20
> Because no action was taken and the original author has been absent for
> several months, the OpenWrt project worked around the issue by holding
> back LibreSSL at a version below 3.7.3. However, we now aim to bump
> LibreSSL to a newer version, making it necessary to apply and upstream
> this fix.
>=20
> Link: https://github.com/openwrt/openwrt/pull/12799
> Link: https://github.com/openwrt/openwrt/pull/16901
>=20
> Signed-off-by: Nick Hainke <vincent@systemli.org>
> Cc: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> Cc: Matthias Pritschet <matthias.pritschet@itk-engineering.de>
> Cc: Simon Glass <sjg@chromium.org>

Can we get a bit more build log context please? I'm confused since the
LibreSSL API isn't "ecdsa_sign" and we shouldn't conflict with some
internal function there? A "make V=3D1 tools-only_config tools-only" build
=66rom the failing environment would be very helpful. Thanks.

--=20
Tom

--A9ct/RKrc7PUaoiP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc6LQoACgkQFHw5/5Y0
tyzt0QwAuWfbcdxWxxf8fo2bLlaEwFpHZ/DmkGClUdbqYUmc9t8TsWCf8tjwpKPa
zdZDsX9AL5HEz0Vefakv4xSYHQJPesoyc93buPjWUbxa+hrl+fiXsrwG+AR+qi1T
nOUOJE+betsSzVYmFjoUX7wWgmIMKWvpAoAloMI1ABWheDzqiaSEz2Q9lgeCfDKa
eN5w/a9P+Tg0R2tGHQk5iyEjlllwQ6Fk8Bku91jaSZazZ5SOACM4XNykS9fsR0Yd
tMoqPXiJw0lW/ftrhRakRjD6ltNph+KBB0maWHMgfKhUEhydk4hMyJANSTFpq60p
NG5nxHbdkPPJBjj3ZA+fe0ufVAT1oop+/m9pafdw1VCNFKjiVXz0vt7RivEMTIrR
o+jK8Wmrx/FvTvGwyXHjoUAOTdgScfBHZTUz1POsVLdqcS1hnlwApydfinneszDb
u31zRTRQOhkAJvsY+BPdnVD/R0XleK+QvlsrbufSpFAhcvn8RlyxNMPBhUfEkV6u
5WWZomba
=XQ/S
-----END PGP SIGNATURE-----

--A9ct/RKrc7PUaoiP--
