Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B197EE7717F
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 20:09:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB7E1800D7;
	Fri, 13 Dec 2024 21:09:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ARX8zhP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 591798010B; Fri, 13 Dec 2024 21:09:10 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E53F800D2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 21:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6dcc11444f4so13460766d6.2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 12:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734120546; x=1734725346; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oKqP5fNDdRWl6J52Go39R1OmtvzK57v+w9pKQ0hrWBA=;
 b=ARX8zhP06DderKcWugbG1aaW9HnvMxweOMCZ9/Gcki1c0DUvYp0f8wZcypXjUQrWK/
 /jQzgeNy6x1R2zjlFRJyIjEnfzchmZ+5v/46fuCEl0UaL3D/p/GIZdDWfdyDp07araOd
 UvDJM3C7cIlonxgQRjpeL4EiBUX52vughyv10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734120546; x=1734725346;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oKqP5fNDdRWl6J52Go39R1OmtvzK57v+w9pKQ0hrWBA=;
 b=Y1YVp5wVT+SqBzPuc4R62XDb2EeQqGsi64sJkzZXrs/0DtVgSwFuYg2VcRJ/Pl+/37
 DmZGD1gmg6vLqojkE48qB6kKlDjydgFf3bE+d1gMXFD4paHOR9gRZ/k11B7lzDI9lopO
 eMhfN/qoi+mTXaxs/xWqTOMneQYj5naFyAY3RLR5V0Pkq9wLX3qv+7m2M8oD1kOVOmQO
 IS5+iCAeXwc2EqmiADKYoOxpvcM6Q/L3ox2aLrJ7EgJOBlHa1Ox7P+mYpgruBu2nyhCg
 048j2iIj0x4oE1JZCbKokMpDS8PM0qF/VVqNLBb4d2Ka5f80Pa+I5zwSphLZclT2u/iz
 OwUQ==
X-Gm-Message-State: AOJu0Yw1Pw1zR8e9BN716iJ3SCqP0QS+Evml+KT/8zwrS8OU0Rleh3xE
 ZQEhYJIL+fembzGXfpOLsayY0vbQ86ZNxosZKBQmdSOAIlhd9tF0/QXCi177mdE=
X-Gm-Gg: ASbGnctvdDryqXhB8SldwR0G++RSoPUlivZqzFYJ4wSUNqE3UJGeGxiGGOIizvGtxrd
 C8G3JnmeKW5zO5EiTxqwKvoCE9rSTd5rU7judTKaXVhURc37M1gtfY3IrEOTUl8k5/CtarrmiTc
 kvEyMxXh/1VcnUo+CRCRm8qFUsOoovzuVim7a5idiNL9NO3ARvRTZJA85YvHIi+BerljCN3P1xU
 rQQRD+G84rTVVa1gDPLzkV6L/gqcy78TUoPS/Wb4PR+yRglkbKAHHDz
X-Google-Smtp-Source: AGHT+IFD6fHd9cy+H2UHJTtHCCKpOPXV9/C8hMt2khBKRQviYA+X1KgEQ21eYc1wEQvMInOi69a0sQ==
X-Received: by 2002:a05:6214:2464:b0:6d8:9ef6:5b10 with SMTP id
 6a1803df08f44-6dc8ca93cf8mr59000936d6.23.1734120546000; 
 Fri, 13 Dec 2024 12:09:06 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dccd257297sm726406d6.45.2024.12.13.12.09.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 12:09:05 -0800 (PST)
Date: Fri, 13 Dec 2024 14:09:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de, Ben Dooks <ben.dooks@codethink.co.uk>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 =?iso-8859-1?B?Q3Pza+Fz?= Bence <csokas.bence@prolan.hu>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Prusov <ivprusov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Kongyang Liu <seashell11234455@gmail.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Rick Chen <rick@andestech.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v4 0/4] Select CONFIG_64BIT for sandbox64 and x86_64
Message-ID: <20241213200900.GA1746743@bill-the-cat>
References: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Iuwh/LGB4nUGGkyY"
Content-Disposition: inline
In-Reply-To: <20241125115554.1707080-1-andrew.goodbody@linaro.org>
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


--Iuwh/LGB4nUGGkyY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 25, 2024 at 11:55:50AM +0000, Andrew Goodbody wrote:

> Picking up a series from Dan Carpenter and applying requested
> changes for v2.
>=20
> I had previously set CONFIG_64BIT for arm64.  This patchset does the
> same thing for sandbox and x86_64.  (Mips and riscv were already
> doing it).  This CONFIG option is used in the Makefile to determine
> if it's a 32 or 64 bit system for the CHECKER.
>=20
> Makefile
>   1052  # the checker needs the correct machine size
>   1053  CHECKFLAGS +=3D $(if $(CONFIG_64BIT),-m64,-m32)

Unfortunately this currently fails to build for chromebook_coral
chromebook_samus_tpl qemu-x86_64 and snow platforms.

--=20
Tom

--Iuwh/LGB4nUGGkyY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdclFgACgkQFHw5/5Y0
tyzB3wv+PReVT6utlyrGBwlNGzz5QmchyPErcDTfAarGGQa92xzZFRPU+x0o7d4i
Skhc9/uQLjPonhMWR/A7p8SoaqS3i0OXgQXjH2UpsWMtqoLRqavQHDhmac5uEXHD
xdi3UWO5TBIEeKY7C8S/Ml8YW480WRh5P8f9GUJ3feqHA9/Mm73X0I6itZH0uqlz
R/jIVieEiDCaNGIZvjn2eLVoYI8GquzGac3X7KCf0GYXJmSBmE0kY+hdX0M75hu6
OJJSFsRE5WtLBk8nIiRojZ99Y2XTjpE5x54CwM/I3tZVKMA5rcxxzEy/8yJW3zz3
3gCD3rNF5KShnhJaQsTqoqqhFXMfVQ/EouMrYEujxGHI4mHRV/PjbZr6RESBETY4
THqN3iT5sLSgeFkwyz9kwptGadHnwzEuhlkOi+fjCPtaIkiFJVn6qUyshFbXIkK8
PXeESJdspfHJqC0Ofsj1p2YHKSgEkcTgrEDFWLVtwxSOfsiEtMgmRo0/8rt9X8ZZ
yNDRbkyg
=nYf2
-----END PGP SIGNATURE-----

--Iuwh/LGB4nUGGkyY--
