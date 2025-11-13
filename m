Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D27CD98CC
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 18:49:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3DA7483FDA;
	Thu, 13 Nov 2025 19:49:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qF8zcWmc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77F3A83FDC; Thu, 13 Nov 2025 19:49:24 +0100 (CET)
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com
 [IPv6:2607:f8b0:4864:20::c2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06EAF83FD3
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 19:49:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-656eb0b1294so513683eaf.2
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 10:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763059760; x=1763664560; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GRo2pmJ9JluFM756HUvOLmHSHJnDlIN46gFuEsbbg/g=;
 b=qF8zcWmcce3435hdrbQ66wHmjEOOWW8lY0K2FcGundfjgW9wGAWmp6ISdxpyG6PHbe
 NKd14h8feJqaZcnlTIrwjrYrRYXvFbclAqaF5f9RcokAN6/AfE5xIfce/J2bSbNUuaXt
 cSx5GWzHixywDqM3j3lg5JSyDRpKP0XTFSFek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763059760; x=1763664560;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GRo2pmJ9JluFM756HUvOLmHSHJnDlIN46gFuEsbbg/g=;
 b=Vyvff3ffpxhDnDTD7ER6+XHCF3n+HuM6Pb3H31VK1+NO9l/ufesY3mmYXxlHz0IcPg
 CLp2kzAD2kZe8Dci4K3WdIBGcsV9yOTef0t6tAmC4HTqrxakeRE8UNOYJauVoLXA0kST
 tqSSop3QUVaRYRgvNlzBIBcS4nhTKhAdILb8d/RznPEKjv5uDHR+KuHAR25pVQ8ppyit
 mmdNx8agX3bxT2MvmP5djrt1I2DLMNWjbQ6EF1uvMcbAs5JK9qqjTJv9c4y7cf2IL/pg
 fW70Ar+trECn9TjG61IMzP8UHjzW4Rjgy3uZkBNvxR47eutPtD3OXbwKdusbiyRlwi/N
 uB0w==
X-Gm-Message-State: AOJu0YwTV6S0i4O5/w8gTA6esRcGIhkE9V/h9y6E34ymZqiSavaIq/jA
 uE6DJsFBEupeN0hawDhrf4zIzlGbYdxlBI5bULhgXpRwB1EXkLjMP3+k5iKKeeu6DHI=
X-Gm-Gg: ASbGncvNWshDYtgME7KiIDVSvtfN4i5+l/sbhxaJgX/Hf6xKp3OfbhZqSgKesL9Z2v4
 TiY9CSxu2533RurZWBWKYgfORYLvpXWJE5NlKQWgkdx4NEjBJfp98E8yUNozabU7LOYC4mx48GZ
 84gfqozwjuhVyEUd8z1xfDDpX8enqYbBPcdpQyaPlDSNxWRRrQoBUoFHre0TMZEyQFhzMZ4foxF
 Qb3zGuSigY07ZfnQPaK/Ynl124/Ov1l6nSFBhMfVohh4AukrWsaqArdaMyFlxrtFoByRxY60OzN
 Ml7/hT6cpbKhVgdQBAHWgAXo4xuBGo3P5jcs9x7FacL3fJ/6eRwNthBFJc+isoDUittS+Nqki/i
 oFASekbFCvbmThPi8Xt1Q9qnpV+LiGKjGmuUyXw0P+Smvj+Ueo1ZmzWe6WycN82cTREzM7epnxg
 Jb0njKkOsnWDod2KOV+zs8nUn2glqXyNkUSveIgdm606PsxQnEhA==
X-Google-Smtp-Source: AGHT+IEQIsqnmA8rUWJgEdZtiL7jpCGJLJJS72ebdTMqBxgGAqeQBmOYenLGi13EFOp35NxF66H2PA==
X-Received: by 2002:a05:6808:444a:b0:44d:bcb0:1413 with SMTP id
 5614622812f47-450974e3938mr140097b6e.46.1763059760633; 
 Thu, 13 Nov 2025 10:49:20 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65724e0055dsm1362507eaf.17.2025.11.13.10.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 10:49:20 -0800 (PST)
Date: Thu, 13 Nov 2025 12:49:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Adriano Cordova <adrianox@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sam Edwards <cfsworks@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/3] Synchronize DTC to 1.7.2
Message-ID: <20251113184917.GN6688@bill-the-cat>
References: <20251113122145.949112-1-marek.vasut+renesas@mailbox.org>
 <20251113175700.GM6688@bill-the-cat>
 <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="O+5Iv72zee1SGVVe"
Content-Disposition: inline
In-Reply-To: <63d6a47c-99cc-48d1-9d71-869c58e2eb69@mailbox.org>
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


--O+5Iv72zee1SGVVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 07:40:29PM +0100, Marek Vasut wrote:
> On 11/13/25 6:57 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > So, taking a look at the test branch you pointed me at, my big concern
> > is size growth. On imx8mp_dhcom_drc02 (where we're already LTO'ing),
> > with the CI gcc-14.2.0 toolchain full U-Boot grows by more than 6KiB and
> > SPL by a bit more than 2KiB. This is a bit of a worst-case, imx8mp_navqp
> > is a bit more than 3KiB / 548 bytes, with the average feeling like
> > ~4KiB/1KiB for aarch64.
>=20
> Do you know why this growth happened ? Is that in libfdt ? How did you fi=
nd
> it ?

Using buildman. To make it easier I put my wrapper around it at:
https://source.denx.de/u-boot/u-boot-extras/-/blob/master/contrib/trini/u-b=
oot-size-test.sh?ref_type=3Dheads
a while ago. I can also send you off-list the world build comparison
(it's 446KiB gzip'd).

> [...]
>=20
> > Rather than a full-resync for the last time we needed a feature found
> > upstream.
>=20
> I really don't want to do partial resync, it will only make it harder to
> maintain obsolete code base going forward. Even this resync was hard due =
to
> that exact current divergence.
>=20
> > There are things we *need* like to be 8-byte aligned and also the
> > phandle resolution thing I believe inspired your investigations here,
> > but I don't know if we can take the whole sync. Or maybe needing to work
> > with upstream to shrink down some parts, I'm unsure.
>=20
> CI does show that no boards went oversize . If there is some growth on
> existing devices, maybe we can shrink that, but maintaining obsolete DTC
> code base going forward and picking random updates into it, that will only
> lead to increasing maintenance pain, so I don't want to do that.

Yeah, it's not an easy spot. But I'm really not happy with growing main
U-Boot almost everywhere by 2KiB - 4KiB, and SPL by ~512 bytes or more
just to keep up. I do see that integratorcp_cm1136 barely grows at all,
so maybe there's something that can be done more widely and just wasn't
clear at first. m68k only grows an average of 500 bytes and MIPS is
~1KiB. PowerPC grows a lot. RISC-V a little.

--=20
Tom

--O+5Iv72zee1SGVVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRYoJgAKCRAr4qD1Cr/k
CruHAP0fR6oPag0x5p2eNzQ/CEIKkQJObIOhHXZHVE7hiXkPPAEAiAORGv4dzZTo
RImoeOGC9uZ1SnySBQZKMKbqEbNvVAU=
=btfz
-----END PGP SIGNATURE-----

--O+5Iv72zee1SGVVe--
