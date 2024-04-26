Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B8DCC04FFE
	for <u-boot@archiver.kernel.org>; Fri, 26 Apr 2024 15:51:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9883E8857B;
	Fri, 26 Apr 2024 17:51:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PxTyuFND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1338988300; Fri, 26 Apr 2024 17:51:56 +0200 (CEST)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2D1888648
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:51:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-78f0592309aso151207185a.2
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 08:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714146712; x=1714751512; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bv7D4l3XHHj22q4MKLiMfJuvUYFhFI6ePhnNOcZOtEA=;
 b=PxTyuFNDA6w/hlup/bja9z3SZfudZEBI6P7Qcdq9rg2ysNAfgk2hkMQJTxZWMpHafh
 HmYUziWAfGkiZw+TBQvvYS/zUojuH3oLGnNB+s9l4Uxm5NGMQngDUqZICHbe/o1G66os
 g3UExmpDYjofZ0dVBhhqHZ6kkpVL+CTS4GI/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714146712; x=1714751512;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bv7D4l3XHHj22q4MKLiMfJuvUYFhFI6ePhnNOcZOtEA=;
 b=KHU1T5lx0qER6G4BaNxnFxM+Pur9AA+OlRqsfAPpNLXc74TvdHwvGgZyIjNrdZrJSl
 gzSjO5KuKmacvoaWgIb2nogEAH9UZtr7BFJKbbuPaIXv3fi9P4Kt54hvmKsCwIYdruMt
 /7z1YfmMqXxE2D5e2al4sj9KudIovHeNBuU/l8+JhKxgfLRAXThQAoCySDTdk6q77EUh
 hh9ezwaXsi8TmrnljqKvujes8C1dAvgpAgRQsZDjY2MIJSuFTwkfEj1ElHV+1oyKaGRn
 v2+GTUcK5sPTpC0YxQLZqNrTGJuuRpdXENzswS+Jh7/ApIug52Yw35QL5tcmrTSqRfkh
 pSog==
X-Gm-Message-State: AOJu0YwW30OdRf8n3dgz92I2JPiOLYoikggn5ho6CIDIUxQaf3K5+dtu
 RVtvSNWN7R6zBLTROySnNqM89vUX1KUd+tDeRg+XttcUcgiDONGdwC7hoVZmRczVo3jUZ1A/CSc
 9WyM=
X-Google-Smtp-Source: AGHT+IFK65AXMXTYQol4ZWmATs3sUTDvl5XbQ1ETMbn6sPLA/WGoKTzo2XGLLjg7q4Z3HLkjkdxViw==
X-Received: by 2002:a05:620a:4d4:b0:78e:c0ef:50f with SMTP id
 20-20020a05620a04d400b0078ec0ef050fmr3337912qks.41.1714146712388; 
 Fri, 26 Apr 2024 08:51:52 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 o15-20020a05620a0d4f00b0078ee090baa3sm8041957qkl.10.2024.04.26.08.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Apr 2024 08:51:51 -0700 (PDT)
Date: Fri, 26 Apr 2024 09:51:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: u-boot-rockchip-20240426
Message-ID: <20240426155149.GJ1054907@bill-the-cat>
References: <20240426094458.46701-1-kever.yang@rock-chips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WWvGTysPLQx7Bzxo"
Content-Disposition: inline
In-Reply-To: <20240426094458.46701-1-kever.yang@rock-chips.com>
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


--WWvGTysPLQx7Bzxo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 05:44:58PM +0800, Kever Yang wrote:

> Hi Tom,
>=20
> Please pull the updates for rockchip platform:
> - dts sync for rk3308;
> - sdram: Support getting banks from TPL for rk3568 and rk3588;
> - dts and config clean and sync up for rk3568/rk3588;
> - Other misc fixes;
>=20
> CI:
> https://source.denx.de/u-boot/custodians/u-boot-rockchip/-/pipelines/20543
>=20
> Thanks,
> - Kever
>=20
> The following changes since commit d097f9e1299a3bdb7de468f0d9bbc63932f461=
cd:
>=20
>   Merge tag 'fsl-qoriq-2024-4-24' of https://source.denx.de/u-boot/custod=
ians/u-boot-fsl-qoriq (2024-04-23 17:53:06 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-rockchip.git tags/u-boo=
t-rockchip-20240426
>=20
> for you to fetch changes up to f6114fb871108eb2bad7393191c9983f0b125dc1:
>=20
>   rockchip: rk356x: use DRAM banks from ATAGS (2024-04-26 15:47:06 +0800)
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--WWvGTysPLQx7Bzxo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYrzZUACgkQFHw5/5Y0
tyxc7gv/ct/rCG+9DOgvcUJcs9cJgZ2qsgov3BJwuzoxupe1z4F2CDPGE5yb+asQ
lxUqQfLPYezJMfGqV2KPXoYokX9nB7Yxfs2tvHG0WpfZ3IVOoY2tAxM4853gHI5i
/Jqb+qKqk5Rdm7Sz36Yxy5idOm4RhXwcX4Ey0WySjwDBVX/XiCWaCFlQUTj64sV4
zMXiKZoB7ceQhrgeEGpm7vk1xBwSqS+LxbBFr6aWczVOHmDf6ID1rxgd7rz0p+l7
o++bEXVBtFArnuRXWka9eO29fhYikXimhhschGAcbKIt94yeZ1QE0cvbJ76HTi1E
k2xZO4IYzMyL76k4V20mEaggw1gnyaPcWcXrsl99oauaTa2RuSga2/iaUt6l4Qop
WyEFDYHql4dUGxD1PFwKmr3qb6j8F53Ee5k8HOnm4kTZrhuU8rhYevPUGFDabjXM
y306KGYvRHAW95+k0Xn+RKiqzdmN3AZwLDlYWc8iKCF2stVMwB53lqS3DODQ/HOF
cPLhhVE1
=seG7
-----END PGP SIGNATURE-----

--WWvGTysPLQx7Bzxo--
