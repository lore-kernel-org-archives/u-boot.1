Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8434CC02185
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 17:56:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 737728036F;
	Fri, 17 Jan 2025 18:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="F8GR2bVo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2D1D8069D; Fri, 17 Jan 2025 18:56:26 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6899F8022B
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 18:56:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-7be44a90468so264063285a.3
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 09:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737136583; x=1737741383; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LyZj/VNLJj7Gd4K/aTPEW7Tml9QIy0Lk6QNuakfF8WA=;
 b=F8GR2bVooiJ+k//jS/QOczJR35/gA6DLB+sYA+D+5TRzR16TiQdwK5Hi0vUz3gBX+5
 K0R2OB4S/CHUiaEW0OnTcQjy3uSWB9pO1rB40/vBvoqvINI87JXjR5ESkKbf6pwIs24x
 4wrznAwKSzdNQteSgnhNhTuTt0/6uQbnkw5BQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737136583; x=1737741383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LyZj/VNLJj7Gd4K/aTPEW7Tml9QIy0Lk6QNuakfF8WA=;
 b=ba5pqysngMsyeI9V/rsGsBtO/bLjdgzHWCGVaXiU21VdxuhiurorTLKaeDfxCG5bxV
 wYdbKnJGc+YThfvQoEAhKMnwpf/qaS2zb/us0DSkLQSOQAYKRgXkLCMJDZCeXkq+e4pd
 xo0q1yEWI6go875pu1EnmLSizVdCxPXwNmgRzxBUQbeDfKEJmE6fUoU+njDcdSW3ig+d
 52E+8MtB/AJ5cI8mxuDL0nWSszw+1+/72kgWUpyagXKglCS4rJvwuI2OR6BGKRe7c1uu
 8mE/wGcxmMZoBpy0lC/z7mpW22LEtsNva9ZbTouOJV+pzjU3t+bnotCVQAfWfHHaxPOK
 gHSA==
X-Gm-Message-State: AOJu0YyCQCyhWkFoeWexjHC1Dm+EEg4TP/jVccfTq/YIvvUEtNOynroR
 oa82/OE+cA39CIB9qUKmrNdyLvTXrhQBmhgbXfh7vdL0W7S0lkpHqamgBKLMviCe8oZdOARll3i
 VNhw=
X-Gm-Gg: ASbGncuW8fv7K2twyakQwJQBGpOewd5zpPsk0JhsQyUlSW2le8fw3NbQXMin+Q0nAwU
 FfyW4fw7zdhQR29s6AyfbyLXHhO5ZxAKDtIEhNCyiSmzadcxmfcmzQEypa+L2deUXB5NYFFQgl7
 2YKlEKJXzJMPlJlWBCl6AU0GNQyJHfNbVLANq4mzDIKmU8gXA3/aSHCQPoGmwwLV2zg63QRUCzq
 WapQkxz22xRY/sI8qVJIST/8vl1n4HawRS4BOk+pmQ/8T/s+16UsA==
X-Google-Smtp-Source: AGHT+IF+DeAwqwIESUD0bBWJyAql8/Rv5MYMPj9uaNydavMFhzuLqHnPN2+U/AY/OPSFiCSWD7JFUA==
X-Received: by 2002:a05:620a:6084:b0:7b6:c714:f65c with SMTP id
 af79cd13be357-7be6320bd46mr531842885a.28.1737136583125; 
 Fri, 17 Jan 2025 09:56:23 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be6147500csm135951685a.10.2025.01.17.09.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:56:22 -0800 (PST)
Date: Fri, 17 Jan 2025 11:56:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>
Cc: u-boot@lists.denx.de, rick@andestech.com
Subject: Re: [GIT PULL] u-boot-riscv/master
Message-ID: <20250117175619.GT3476@bill-the-cat>
References: <Z4m4KZ3IS8emTeLT@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="P1mCzTpLL0cMOGjh"
Content-Disposition: inline
In-Reply-To: <Z4m4KZ3IS8emTeLT@swlinux02>
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


--P1mCzTpLL0cMOGjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 09:53:45AM +0800, Leo Liang wrote:

> Hi Tom,
>=20
> The following changes since commit 178f6ecb21fe12ada74a9a1a08093c812b15ee=
a5:
>=20
>   Merge patch series "bootstd: Support recording images" (2025-01-15 19:2=
7:14 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-riscv.git=20
>=20
> for you to fetch changes up to b3ce35900cfa500a31fad652302a92cab604d6b5:
>=20
>   doc: canaan: Add K230 CanMV board (2025-01-16 15:55:27 +0800)
>=20
> CI result shows no issue: https://source.denx.de/u-boot/custodians/u-boot=
-riscv/-/pipelines/24215

Applied to u-boot/master, thanks!

--=20
Tom

--P1mCzTpLL0cMOGjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeKmbkACgkQFHw5/5Y0
tyy/bAv/Zm0RTu07C7MFkCq2fjbHbyUZ4JtHkZu/lWxG0Zyl1721u1HSmzcR2G8D
MpQ1KA5Doxc/bRDThsO3s1jtm9ykAdmJ6uxcrQKveboVbCbYcZPWJvYkOqxpRpjb
82ZJ+b1ve8iJJ2z5vfDxfzKuGGXWCVL3inNsyivUQF60kIZu3YR67nEru2zYU+bZ
xc9rhTeFrJgLr8ARUXESZerfaJNnce5nn7GC5bYF5k8o6UqqwP4Vu8bjlqr60syV
NZ+FRUm5niVbHk+uHjUML5taSfvKJR0z8ivH4z/tgp0DoF7MUrLIe2gGC+3qsj6K
4V6V0R5axqsOIRFxObqO9taCBsdytnGGnH/drs1YbS04rWdm9V57qcMksTrcnGFL
90KZrkOi89ThRulSRMafB73AzijQ628XJZdzGJcuIUsf1KHHqoBFXKxkAuIg38Og
ZhSB2MnUc4SdGxxMgsbEbv99zIV2pf0UpbP+t2VKhMefHNFo/ZsPC4rSHxDzX0/x
acVqrxWZ
=kVmZ
-----END PGP SIGNATURE-----

--P1mCzTpLL0cMOGjh--
