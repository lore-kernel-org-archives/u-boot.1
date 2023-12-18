Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 085A5C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 23:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 396EC87536;
	Tue, 19 Dec 2023 00:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RTk75Pv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF2DF8753C; Tue, 19 Dec 2023 00:16:45 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF4A087525
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 00:16:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-dbcdde08dc1so2761434276.1
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 15:16:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702941402; x=1703546202; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5rW1y8iwn3Mn8LVoMv2XYEZFNqRoGPRtI/A7fgath/U=;
 b=RTk75Pv1kNHMPM8shoyvSFTjfPFCXFg7UQxf7elmY+ca0lHHZcyxPUXpLIj6HZ6gBc
 Z+9psG8vc+RAirzkKwwYKQE+hGNDonK9MPIcNoovq1NczrY8yRWt8Ux+zrSY1LlwtF6U
 3nET8OvreZM7gwjWwaSq6WbL7xoec72uSQqgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702941402; x=1703546202;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5rW1y8iwn3Mn8LVoMv2XYEZFNqRoGPRtI/A7fgath/U=;
 b=v8JitvODS3AUgfQevxCJXio7gMxiiw6VKT45FgC1FyPyq9fdU4dY82jT7GzQ9LIIhV
 JUPcNMPeRBi3Fj8x1EwEllZCsfk1+HxqILtAGuhb0oRd5FLPlX1DENM+PTZE/qeoX37k
 Mb2C7cEEGBWJpDC3puNZYbd36sitIUEz05G7LDpyns2Xcoz622tJhyz2Xls32hNT6NuP
 /l0wOPjm1/J6UYVk7+Kddo95EZmNGeFJITeQIOFHx8o6YcqhYslJIhmeEWcTwXPpBO2n
 QPnMoref3O5MP6goQDo4KTDgX6h6KfYRrJYx/IMkTbimBMWEuNWJoJdp9Nd6+CfgEvFP
 whyA==
X-Gm-Message-State: AOJu0YyJDpiGNJjrQ7jbVgVwiLlYk2FO0UrgP49yNFdz7Ls9QWcJAwyi
 STREy+s/og7JN0DUxSXvmxBj9Q==
X-Google-Smtp-Source: AGHT+IGphkLcvySsFG6J/shoIbHp415yvOaD5+D+eVO2wjfN5tU3eaDLzYx/KwYON7YIIIYYnFwyLA==
X-Received: by 2002:a25:d746:0:b0:dbc:d053:7e3a with SMTP id
 o67-20020a25d746000000b00dbcd0537e3amr5562024ybg.23.1702941402482; 
 Mon, 18 Dec 2023 15:16:42 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 c18-20020a25c012000000b00dbcde4d2e4fsm54674ybf.24.2023.12.18.15.16.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Dec 2023 15:16:42 -0800 (PST)
Date: Mon, 18 Dec 2023 18:16:40 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: Proposal: U-Boot memory management
Message-ID: <20231218231640.GO2513409@bill-the-cat>
References: <CAFLszTicT2yzsm+KAjRyqzV3bt1_W2XYJaCExX-LHNZ6+tFUkA@mail.gmail.com>
 <a55d0848-c70e-43a9-9223-60515aea8052@gmx.de>
 <CAPnjgZ0r1xM-bky6VQXV4N-FkBC-YFsX1ibJRiJ_17XXAe5ang@mail.gmail.com>
 <D7A16A62-0C71-4374-AAF6-9D021A6C42A2@gmx.de>
 <CAPnjgZ0YBJ9bN4VHbYkR-r3V8winGmm5TA0UXvh-mBLeRgza3g@mail.gmail.com>
 <3A9B3E83-545B-4CAC-9D65-737BD9D6BE0C@gmx.de>
 <CAPnjgZ1=JBEh49G654DfkYM-fcOEhwh=Xuu1scXTLsNkZk2SNQ@mail.gmail.com>
 <DEECD6D4-58C6-4032-BBF9-28A65B9096DD@gmx.de>
 <20231218224108.GN2513409@bill-the-cat>
 <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="1dTtkvXnB3O2EJNG"
Content-Disposition: inline
In-Reply-To: <3DAFAD12-98E4-46CC-B02E-E8EE40D57AC3@gmx.de>
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


--1dTtkvXnB3O2EJNG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:08:31AM +0100, Heinrich Schuchardt wrote:
>=20
>=20
> Am 18. Dezember 2023 23:41:08 MEZ schrieb Tom Rini <trini@konsulko.com>:
> >On Mon, Dec 18, 2023 at 11:34:16PM +0100, Heinrich Schuchardt wrote:
> >
> >[snip]
> >> Or take:
> >>=20
> >> load host 0:1 $c kernel.efi
> >> load host 0:1 $d initrd.img
> >>=20
> >> How could we ensure that initrd.img is not overwriting a part of kerne=
l.efi without memory allocation?
> >
> >Today, invalid checksum as part of some part of the kernel fails. But
> >how do we do this tomorrow, are you suggesting that "load" perform
> >malloc() in some predefined size? If $c is below $d and $c + kernel.efi
> >is now above $d we can throw an error before trying to load, yes. But
> >what about:
> >load host 0:1 $d initrd.img
> >load host 0:1 $c kernel.efi
> >
> >In that case (which is only marginally contrived, the more real case is
> >loading device tree in to unexpectedly large ramdisk because someone
> >didn't understand the general advice on why device tree is lower than
> >ramdisk address) I'm fine with an error that amounts to "you just
> >corrupted another allocation" and then "fail, reset the board" or so.
> >
>=20
> Our current malloc library cannot manage the complete memory. We need a l=
ibrary like lmb which should also cover the memory management that we curre=
ntly have in lib/efi/efi_memory.c. This must include a memory type attribut=
e for usage in the GetMemoryMap() service. A management on page level seems=
 sufficient.
>=20
> The load command should permanently allocate memory in that lmb+ library.
>=20
> We need an unload command to free the memory if we want to reuse the memo=
ry or we might let the load comand free the memory if exactly the same star=
t address is reused.

Our current way of loading things in to memory does not handle the case
I described, yes. How would what you're proposing handle it?

--=20
Tom

--1dTtkvXnB3O2EJNG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWA0tEACgkQFHw5/5Y0
tyxrngv/V5stAVL8ySyrkygfakox/h3MHc65SRjE4Ui1Zd6mmDsBWVjn4FZjicL7
UuoyJIJ5Kr4S13T5x5SUgJwvkJ5Ca5K4xGRIGDgJNgSi7LCZ8KTd+ZJIlJmAmTaU
2A7iff7ZkXIdU+SghlfCEJaxzM348cKtMqfxZzUPqYq6bUvt6fYq8r7A8TG7p1IT
NnDI54j+c+dwV51LOmFPuPIBMaGcoIjm3mZfKIGZOGkU3pBtvPf7y6jksA6WpJWt
L0Q+KeG41Gy/3Rzkrjl/xgfw5m0us/DUv9IAuNTfw2ujqDlgVC2h0Ak34GSKr523
ZFWCIP1Us/zQwEZegH+nEBYfWdrTo2dCtxXCSkKNTeau1PLySmCNkhBvZ/B8Ldht
35sse3WIkamjPiwYl5NSngpEv+kKP//6M6r5DNzb9N0y/VUWBwSJLmexxVdWYra+
bpyH+71vGG2m7HNDDG48Oz/xztfUPsLI3xs1SPddds5+adJOTOr4DGMETPY6zy3U
JTDhtpmF
=K/Cd
-----END PGP SIGNATURE-----

--1dTtkvXnB3O2EJNG--
