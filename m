Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1077BC02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 20:20:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61AB3801BE;
	Mon,  3 Feb 2025 21:20:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fS0/dl+z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68274800CF; Mon,  3 Feb 2025 21:20:32 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4BD800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 21:20:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4679eacf2c5so44215571cf.0
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 12:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738614029; x=1739218829; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vR/korIvz9HUavz2tfUZGWGpProf6l1ryIeB0a1Mynk=;
 b=fS0/dl+zUzZImSxMjidinRbJlrr6G5RQwBsFx1U0Syy0Dqkrqv4TRjDOxWjacFltrD
 1qJ5mjqR2UAJnS2sdLwi02bpWvWPan44UDNAl20RAgW0GFC92JC1N9/PuINB9Pug1n1V
 xdzacAoulXNgC05irQnRi1TMzPuSTePl3uuzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738614029; x=1739218829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vR/korIvz9HUavz2tfUZGWGpProf6l1ryIeB0a1Mynk=;
 b=iAGdPV06lKDf2qfYDVH3/ho2XcxCd/911Tam/DKqgR7DdCNdPtwBtGx5bCf1S8jTf/
 rpMlv0qpoz1Z0PpmRDMOi/ZYxXDoXiUM7wu2A+EtH+JU45ZFDtc25xIEucf/wI3XYJsx
 9xVjXsLl9RuJxoo5uoFpRTBIqi9FgZfeAV1okVHbMpySnEJAsapWEMBXZGvstmR5JCQY
 Y89wx/Umko3QR+YPde6q3FH3Qhp6HMQRWHsHmHNxWGDgzWZRnMi2MOxPSEp2ejhVEuqV
 dfpsHfZY+Pes9JnzLmsT524ZMEZ6nk23gUgMhrrtoXjWVXhH/Xlgff52P1RHtuUUcJz5
 FNIQ==
X-Gm-Message-State: AOJu0YwU8ceJlvXYgf0b10swThI9KBdkvFEUN7zg9QJsB8nnEUSLgqv9
 t5WnCpnK0GIY1DmHeXzROOzO0UJLF9vHd1o0iuxnhaKN5q5foUqInf/jbAQc7Sd+HWbz7C891GQ
 Q
X-Gm-Gg: ASbGncuJS/DGzSWZfcOXzXsxZhhseQAhZfG/hWwNEdsFp3yoog1admzMtnwfoAC3ziE
 HBQHcNehQ4BTvzxnTx5LPUs6UKRIXLfWo1lMaihB2B3eCegy98ZnR8TzKI0vuRUaN8+EGtjyCgr
 UR0y2M2TQ6H3O4eVfv919F8o/YKi9Gm8TW1F9skFpWmJd+3beKunuxuOpb4D9EjvFEj8PAVIJFW
 jcD+9Tw3egwXNKLr3n1Pg46En4JNyhPCaSkZ9F7o9z/EYjuM3U5+HGDhkNsgo6k+b/hjCwE3MUd
 6p6x95HfEkQddvQ=
X-Google-Smtp-Source: AGHT+IFNr3UP9oSGZH0S3h2xiVqnXoHbQntXOW+LMUnXZUOF3+5subcoRKXkkZBXSzuu7J7D415FdA==
X-Received: by 2002:a05:6214:268e:b0:6d8:883b:142a with SMTP id
 6a1803df08f44-6e243bef87emr314621986d6.2.1738614029005; 
 Mon, 03 Feb 2025 12:20:29 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e2547f43f7sm53912516d6.9.2025.02.03.12.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 12:20:28 -0800 (PST)
Date: Mon, 3 Feb 2025 14:20:25 -0600
From: Tom Rini <trini@konsulko.com>
To: =?utf-8?B?VG9tw6HFoQ==?= Peterka <tomas.peterka@dronetag.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 =?utf-8?B?VG9tw6HFoSBCZW5lxaE=?= <tomas@dronetag.com>
Subject: Re: [PATCH] Add Kconfig option for altbootcmd when using
 CONFIG_BOOTCOUNT_LIMIT
Message-ID: <20250203202025.GV1233568@bill-the-cat>
References: <DB8P192MB0743F697B33A404BBC96460383E92@DB8P192MB0743.EURP192.PROD.OUTLOOK.COM>
 <20250130164758.GC1233568@bill-the-cat>
 <75e42366-c190-4a57-8f69-b01da25acd19@dronetag.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GsjgT9izUWj71Xtt"
Content-Disposition: inline
In-Reply-To: <75e42366-c190-4a57-8f69-b01da25acd19@dronetag.com>
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


--GsjgT9izUWj71Xtt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 03:56:18PM +0000, Tom=C3=A1=C5=A1 Peterka wrote:

> Hello Tom,
>=20
> sorry for the formatting of the first email. As you might have figured=20
> out, the it was not send using git send-email. I tried to do better=20
> later and I had to use different SMTP server and account=20
> (atheiste@seznam.cz) because our company email provider is too much=20
> ahead in the future.
>=20
> Hope it didn't bring too much confusion and the new patch made it to=20
> your mailing list.

Thanks for posting v2, it looks good. I'll follow up to that with a
patch that does the migration of the existing altbootcmd definitions to
the config files.

--=20
Tom

--GsjgT9izUWj71Xtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehJQkACgkQFHw5/5Y0
tyyo4wv+Kiw7YQDJDaRMy4N1DkyOrbyUWaDDSlm9WFD2UXkPnfjN863vlHlUypRq
to0DZVPrK3gUGfUptbp5dbV3xwSv546KpGAvt6dWC9HLTRm075mNqMc8+p0DEw5i
4oEzt9XpGbImm+ifqLO2nFkcb53j+y448jeP3yCqxCmjVs2oMRkXtZbH82KPYK3s
3ZJwW2VD+YM+JaNee4eEv1RXidJFk7sAy65zkNaH4OJXDTc0eOFLCmASad91UNO+
mH29Z4EhOId2I7inckASmcPiCU+Gb6tp6iVnJIWGbKyBBdddEtN42ZZ3haPgVpYc
8eOsvOi6PvX9aUPehvnWcNi4KKSyffz/Yx8XhddjP5pPcP41gewwx4/oFWwQxWgy
qShMZumNpV1/RO8xS4EMFYrufIv5eBz3RGBqmeblpiLlJTFJay014OBENcA+cbIm
wGlmMGVCBYtZAAmbnITJhfooGzjVrmtrEIVu4KHLRwxRBQTOKSB6BNbb6rXshQoT
BL1tC19s
=a4rw
-----END PGP SIGNATURE-----

--GsjgT9izUWj71Xtt--
