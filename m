Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7464ACD5BD0
	for <u-boot@archiver.kernel.org>; Sat, 30 May 2026 14:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA31684693;
	Sat, 30 May 2026 16:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fgpgIUxu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0307E84671; Sat, 30 May 2026 16:26:05 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6DF84693
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 16:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7dcdd1b492eso14158986a34.1
 for <u-boot@lists.denx.de>; Sat, 30 May 2026 07:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780151160; x=1780755960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BUSrFW5KMV9dGLgZETSc2eAEAxi/tGZjlXAeD2w7k50=;
 b=fgpgIUxuHq0k6D8TbzV7QSov8kl7qP8pB434omXfcFZ11ayYG1prfuU0ra6UkmrYhg
 mWJ1vKQ9KJnRDqZhofa1oZF6nJ4Yg+rq1BmKG2vSsBOvJSqdU/lH+bC4aIDTGr3yU3wU
 KR6b+5ixihS3Bkl72wrjbB1lOjDVOKysaHFAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780151160; x=1780755960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BUSrFW5KMV9dGLgZETSc2eAEAxi/tGZjlXAeD2w7k50=;
 b=etTx98URvDiUhec4KVCp/v5ZyQy47JJI024Ao6oWHjMWf8QwOApArrZjC9V1OpaNSj
 f3ljlFcm9HJ+zVi0oj/AGAHnY0/WnIqUFYEc4T5LtnoqdESOwkX/PYCvkBLWkPn3q5fo
 JeWdISkzsThuF/UD8ddMizSmRN8PtRTqxgTyIlCso2A39T1IOeGhoQdpHNYo+nkTLS0V
 nOV/AeJAQbdOdDsMc/6NYN/ZHqUNTvdty9E/VqxpeTzK76Q1xT0LWl9TrmvHQ7oE0S/B
 Ejyfejvj3S3IBzbLpss0w5cXko39PoUOGqHDrvCtM25NzjSBBowuDMnEN6X5ghzPqO0r
 0N3A==
X-Forwarded-Encrypted: i=1;
 AFNElJ8D5GcXNWR1CMV84UfECC9gOOD89q/fKoGHaZsaEabTNRhZdCwJxjRm1xVXxlk7z14Dv8nZB/E=@lists.denx.de
X-Gm-Message-State: AOJu0Yw1/PpNwWMhyUcW71PxK0/vXhOQ+od430VUS30ODJNrovaU+U1V
 8kpanZG9jNgqXg7IV1Az6GpoLKgk5UJ5wrF3K1e8QiY1+uQTY56wbu5snKGGJqzGdVU=
X-Gm-Gg: Acq92OEMN4b4+ZXkCFTIFqqq6doBotjQMWlOysH3OAdjj/G11bgriDeTug66FXGqF1b
 uqHkpZOWJBOBGM/i335C6I7g/yz/nJA1QnrVXze3+IvRAAFmnx4RrE8MHCXQwbIsiCRkEfilpji
 BcWUs25DIGty8ZXevkCGG/JdQEjVa9Rof2U/lzSlAW4m55yuTC/evpx+qd6HvE4JU3tOV1Cl70W
 Y1mmlzj4rsPqAv63LeE4R9+/XQ0Uee1TwR5eaZZplSiM/butiiYXMzfZDhrsLCyVqB0afbbKwFl
 9tnqLGNVPuS9u7cEUZr7GMZci2h8Kl8FQcCYf3JmFVQfNxDE8qYoV1Or+hg9+UafD/sVvnsWry9
 tK93AY6mNS8uCUwTU9kZs3Zp8vkINdbRFkjCfiyJlZP9YDltfkFjRRiFisv65NyfQbHJJRmFST7
 jzKFaOt7uN/sZRTO/UCZQE0/LGnU4mh2czJWnYEqnndBvJOTMnXZcbtZYL0+4rHc8sXIto+7mLz
 uRlyso/Oj0Ofq1ahjOYyB59EGdlutKRVujZ6yAwYMXIqhbp3dEgRXhO
X-Received: by 2002:a05:6830:210c:b0:7e6:69f:d208 with SMTP id
 46e09a7af769-7e6950b0997mr3708864a34.2.1780151160482; 
 Sat, 30 May 2026 07:26:00 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695bef47fsm3749746a34.12.2026.05.30.07.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 07:25:59 -0700 (PDT)
Date: Sat, 30 May 2026 08:25:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Peter Robinson <pbrobinson@gmail.com>, Gary Guo <gary@garyguo.net>,
 u-boot@lists.denx.de, Matthias Brugger <mbrugger@suse.com>,
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Mark Kettenis <kettenis@openbsd.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, U-Boot <u-boot-bounces@lists.denx.de>
Subject: Re: [PATCH] lmb: Reinstate access to memory above ram_top
Message-ID: <20260530142557.GI627328@bill-the-cat>
References: <20260127234856.1503030-1-marek.vasut+renesas@mailbox.org>
 <177343529761.1131472.9417054395876652663.b4-ty@konsulko.com>
 <DH9MF45X89KK.1CV4WUVTCTUO5@garyguo.net>
 <CALeDE9PARyt0iUvnfbSfz=rSA2RkQ1AcoaJpU=8RgnYivaPNEA@mail.gmail.com>
 <20260529154446.GC627328@bill-the-cat>
 <CALeDE9MAE6r3pFzNRDbwAXkkkWrZo_0gXEMTavmpnGjQBoxrVQ@mail.gmail.com>
 <c9e810ac-6c0e-4a66-bbae-d6557a26197b@mailbox.org>
 <CALeDE9OzEf2RHZSP047hOd4UzikcUpDfTBo0JNFjy8vMZ912Hg@mail.gmail.com>
 <4829e3fd-7db1-496e-92f3-826728283e57@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O5QkJ1iqG2+6cKvr"
Content-Disposition: inline
In-Reply-To: <4829e3fd-7db1-496e-92f3-826728283e57@mailbox.org>
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


--O5QkJ1iqG2+6cKvr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 30, 2026 at 04:22:56PM +0200, Marek Vasut wrote:
> On 5/30/26 3:44 PM, Peter Robinson wrote:
>=20
> > > The revert is wrong as that breaks other things , like use of DRAM ab=
ove
> > > 4 GiB boundary, which is exactly why this change was implemented. If =
RPi
> > > has limitations, then those limitations should be imposed on RPi, not
> > > globally, so add the LMB reservations on RPi.
> >=20
> > I have no idea how LMB works so please send a patch that does that.
>=20
> Try this:
>=20
> // Enable CONFIG_LMB_ARCH_MEM_MAP=3Dy
>=20
> #include <lmb.h>
>=20
> void lmb_arch_add_memory(void)
> {
> 	int i;
> 	phys_addr_t bank_end;
> 	phys_size_t size;
> 	u64 ram_top =3D gd->ram_top;
> 	struct bd_info *bd =3D gd->bd;
>=20
> 	/* Assume a 4GB ram_top if not defined */
> 	if (!ram_top)
> 		ram_top =3D 0x100000000ULL;
>=20
> 	for (i =3D 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> 		size =3D bd->bi_dram[i].size;
> 		bank_end =3D bd->bi_dram[i].start + size;
>=20
> 		if (size) {
> 			/*
> 			 * Reserve memory above ram_top as
> 			 * no-overwrite so that it cannot be
> 			 * allocated
> 			 */
> 			if (bd->bi_dram[i].start >=3D ram_top)
> 				lmb_reserve(bd->bi_dram[i].start, size,
> 					    LMB_NOOVERWRITE);
> 			else if (bank_end > ram_top)
> 				lmb_reserve(ram_top, bank_end - ram_top,
> 					    LMB_NOOVERWRITE);
> 		}
> 	}
> }

I see our last emails crossed, thanks for posting this to help figure
out what's going, Marek.

--=20
Tom

--O5QkJ1iqG2+6cKvr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahrzdQAKCRAr4qD1Cr/k
CrNnAQDZe+iI7inpssGLMnDjcZnz6hXiVAnuIomf7Z6uCrfMvwD7B1f5kyADMpiF
iwNbJsNRSRFAXz21UQ21ontB/79oVA0=
=TgJ3
-----END PGP SIGNATURE-----

--O5QkJ1iqG2+6cKvr--
