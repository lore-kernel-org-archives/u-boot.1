Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3BE0FD8773
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 13:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EFB184312;
	Tue, 17 Mar 2026 14:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bNXl4zF8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6ECF184326; Tue, 17 Mar 2026 14:47:42 +0100 (CET)
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com
 [IPv6:2607:f8b0:4864:20::c29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45E3E842E1
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 14:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc29.google.com with SMTP id
 006d021491bc7-67bbea1e090so3090646eaf.3
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 06:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773755259; x=1774360059; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e5ewvlJYxI2VzztikjcU12juvvOqbgbujrO4EHj0Hp0=;
 b=bNXl4zF8oRGy29ifqdXht2kjz7EZ0r9JwmlacODtNuC/chPuHZ2t5/RZ33PAUClUYT
 EW4BLmWLuUaZmg34gOgQ6kJVhjn/gV9+dPQwdlyBezELFlpJMwAwvjjvxKLslTwUNlgC
 zukvhMQWqNywSp3ojTXNzShxiZ4gkRz94TQgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773755259; x=1774360059;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e5ewvlJYxI2VzztikjcU12juvvOqbgbujrO4EHj0Hp0=;
 b=eilSN5tkaSdPDNbBUR8P2cL+6cxrxGOWAgiJ/mYPv9fCluWGQgUiAfRTUCZMekdRyz
 6BVajAjBkt7QJnvOcLABCyU/Eu7lmFbYBrfBXZkz0Y9Q/eRFkuHzctAtQpMce0iE/yWX
 /QQUBxeiT3QBgUxJGLMIHQZ0l55703JF4vVhPbNUKrpxIUi+Db+UQ5LGv1bcHpQMM4kP
 IU/6tKEa+ug0QCctPiBEYe/kpg2TS1ANL6J0srGiBLqMzgrljlbrel+IrdNSRXRRZ5OM
 1Q+Snz9gU7Mq2wtk7a9WYFr+4d5f6XuNMX/HKzc2Phs3Bf3feDCwKnRnTVZ/Tp1JXBgg
 Xakw==
X-Gm-Message-State: AOJu0YwOC+RQtOnq2w5g9M8HAUsV+NHlbiAus8uDg4xsKLKee8keYypD
 cnDOMmmQW+u9KYrxR+rFHadH6ZLl7jxAKm1jhS1G0skPG9NIRW500qMbgF7NmzOXGFo=
X-Gm-Gg: ATEYQzztI10UplUAlocA6J0ujpdIa8DagE6bqO5wSGVO4J5kczA7Dkbl1uf4df/izC0
 BwufdY5exMbzT5mOzORGKZw5avFGyP58oHttYnFm1MRUzIwnVIGEgpRrL0Ep046a0M3+KK8pjWU
 9VAYOqBDDP2Hrnmar3o9eHkhM8mP0Xprr+CYiloeNfPyEKu+0VvMfA7ukfxQM4+c9+uVMGz7Fwr
 VdGVN4X30JW8aRt9LOIXXqXDmXfGtNKT/jp7ZHn1oWeCwBAGOuPlJavm+QkkPKZ/c6rULd+Lca9
 SaYtBRfU5dR3G9x21j5JrHIksuC/dBxI1YtBbjuCowhCkfkJIrleE4p7PLlblsaEIUPcRfxNxUl
 QexhSDjs1djb2kJSre8/kQaeF2+AgYB10GCLbUlFS8ywFvnQYCMq3R+ZMyO1ReHt7U7l9tMyB4k
 dTafYpS7ayrXPrhyzCtaSvauEGYpfzmAsBTk1S4wGtTowPFgndLJ1dpxplTDS+6NWUofHPAC4z6
 uoe3A50Al5k1OtctY1bjzyM48XQF/FbguOk000N2Zyj5ofM
X-Received: by 2002:a05:6820:1008:b0:67b:decf:eef3 with SMTP id
 006d021491bc7-67bdecff00amr7390200eaf.37.1773755258862; 
 Tue, 17 Mar 2026 06:47:38 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67bc8db5156sm11735471eaf.0.2026.03.17.06.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 06:47:38 -0700 (PDT)
Date: Tue, 17 Mar 2026 07:47:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Leo Liang <ycliang@andestech.com>, Uros Stajic <uros.stajic@htecgroup.com>,
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Chao-ying Fu <cfu@mips.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 7/8] libfdt: Allow non-64b aligned memreserve entries
Message-ID: <20260317134736.GV502704@bill-the-cat>
References: <20251224154449.946780-1-uros.stajic@htecgroup.com>
 <20251224154449.946780-8-uros.stajic@htecgroup.com>
 <abkZr1hBcosqgBZd@swlinux02>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="lkI3xG6dJZhbuZHJ"
Content-Disposition: inline
In-Reply-To: <abkZr1hBcosqgBZd@swlinux02>
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


--lkI3xG6dJZhbuZHJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 05:06:55PM +0800, Leo Liang wrote:
> Hi Uros,
>=20
> On Wed, Dec 24, 2025 at 03:47:17PM +0000, Uros Stajic wrote:
> > From: Chao-ying Fu <cfu@mips.com>
> >=20
> > Although memreserve entries in an FDT are 64-bit aligned relative to the
> > start of the FDT, we cannot guarantee that the FDT itself is 64-bit ali=
gned
> > in memory. This is especially common when using a FIT image, where the
> > alignment of the embedded DTB cannot be controlled.
> >=20
> > On systems that do not support unaligned 64-bit memory accesses, this l=
eads
> > to faults when accessing the memreserve section before the FDT is reloc=
ated.
> > To resolve this, copy the 64-bit values into suitably aligned on-stack
> > variables before accessing them.

Yes, and so you must align the device tree first. We should have
addressed all of these problems in current master now. If we have not,
please explain what the use case you're encountering now is.

[snip]
> Hi Tom,
>=20
> Should we accept this patch in u-boot?

No, we cannot, thanks for checking.

--=20
Tom

--lkI3xG6dJZhbuZHJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCablbeAAKCRAr4qD1Cr/k
CvZgAP0UQO34hhVPu2k9R7lpWN/fMJ2dQNWoN0lmUABUITPXSgEA7TCalZozNjbF
/aAmWYDYUrSOIbUaMcApcf7R+Bodegw=
=+KLB
-----END PGP SIGNATURE-----

--lkI3xG6dJZhbuZHJ--
