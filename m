Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D15C02192
	for <u-boot@archiver.kernel.org>; Tue,  4 Feb 2025 02:08:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EA7D800CF;
	Tue,  4 Feb 2025 03:08:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OwITjZt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD76680104; Tue,  4 Feb 2025 03:08:32 +0100 (CET)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62F0C800C1
 for <u-boot@lists.denx.de>; Tue,  4 Feb 2025 03:08:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7b6eeff1fdfso465826585a.2
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 18:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738634909; x=1739239709; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g0FZB9Dksd4tK4uWG/U4ZidaFpjL5uHjXV0bXagG8Z4=;
 b=OwITjZt0oplRMwB53cLPDWrarpFVw+09LEEmTETwRrAVCnQ0bfTXzjKCEfsByk4kLC
 +2h3U7fN7xqkcz1hecDRFWk7mkL2/VdgtX/PL1BCyQdDzVzP/4RaEJml5KaCXaxSu4G0
 jUqCwZrTKYvcscgUkZa9HPAKjwzeXflp1Zy88=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738634909; x=1739239709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g0FZB9Dksd4tK4uWG/U4ZidaFpjL5uHjXV0bXagG8Z4=;
 b=dq+T8AebL1MA8A6nwENZteQSzUj1hxL5vc5di7rTxDtZrEjSmYHlEbYCNxa0oRKfEF
 6xtz1SXdcNSpTxMI9YG+fgf4FdAoGjJhwrZZ3IpFumAR3CIwG3LdKm1k/ehxWHtAHMJp
 XFKD2qX7HcrEborqx1z+++MpWfHrFPPT2vietU01uLyLfvIoxAUlbXfAxacb6e2vkwSy
 dDuzHykJK0OT1n9lVZDvZIZdtNKnklY4rDQvkKlQ8HFU2LIH94Acn5q3c7bAtVIZ+CKX
 PWVaFAss5EuXIz0HDCeIobMHTHb4oUKtJGPdYJzt+yhIHXlEREMlabtFuJuZpLhWqKCu
 Ef4A==
X-Gm-Message-State: AOJu0Yx90oT1QjqwsoyRpwZwm7gczBrXQoTzjRFAOFFfeN2PZv1GBETE
 sgelMk4LrYlUFrE9Dpfm9nrSqPdhpdy32RGgyePWNmBIPuAipDq4RYVDzxeARcI=
X-Gm-Gg: ASbGncuRKLFWOwWBEhqk2JYvp0WPcVEMfRng+Eri0XmoGTlRv93fUeGvN4bjb2OE4mK
 /maraMb7i6OLQDnCv3u/Ho+HcOlrP+eZjtc8EK6SR1EtdbB5nedRB0aoQIHQi4O89qMI6xfps9I
 zdi+UVuHCPH94Osa98ggigHJlLwSBKL7DAeTaPmTIPXbzhcSxE2+QfcYQjMlG3HUC87kMxlReDU
 FQ8QF/TX5IwQt6xyQ7r7tO5S/vuJ+Vz52JDVDmflXfw7SJEmJ4rXtOlmjQ/BlvJIuDLsD+qwCeU
 PdupVzOGmYgJE5g=
X-Google-Smtp-Source: AGHT+IGgAsyiTvlvU8IzY6qpeK0thNfiKfDTnRpfj7t1k6qdfDnBEbDFj19YSi48gvQcQtoaoEiLPw==
X-Received: by 2002:a05:620a:40c6:b0:7b6:f996:c507 with SMTP id
 af79cd13be357-7bffcd7366fmr4065888685a.40.1738634909158; 
 Mon, 03 Feb 2025 18:08:29 -0800 (PST)
Received: from bill-the-cat ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d02bdsm588823885a.46.2025.02.03.18.08.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 18:08:28 -0800 (PST)
Date: Mon, 3 Feb 2025 20:08:24 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Sumit Garg <sumit.garg@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH 11/32] efi: x86: Rework VENDOR_EFI option to permit other
 archs
Message-ID: <20250204020824.GC1233568@bill-the-cat>
References: <20250203174245.1331464-1-sjg@chromium.org>
 <20250203174245.1331464-12-sjg@chromium.org>
 <20250203200847.GG1233568@bill-the-cat>
 <CAFLszTjknAo4CHVpyYNtV3sGHbHFCE-YJEhzaoLB7cSNFpMRPg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hc03ZPLRJyoPCnl7"
Content-Disposition: inline
In-Reply-To: <CAFLszTjknAo4CHVpyYNtV3sGHbHFCE-YJEhzaoLB7cSNFpMRPg@mail.gmail.com>
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


--Hc03ZPLRJyoPCnl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2025 at 05:38:27PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 3 Feb 2025 at 13:08, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Feb 03, 2025 at 10:42:04AM -0700, Simon Glass wrote:
> >
> > > At present only x86 supports the EFI app and (apart from Qualcomm) the
> > > payload. In preparation for supporting ARM more generally, rename the
> > > existing VENDOR_EFI option to VENDOR_EFI_X86, using that to define a
> > > generic VENDOR_EFI which will be enabled for all architectures.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > This looks like things that should just live under
> > BOARD_SPECIFIC_OPTIONS in board/efi/Kconfig instead.
>=20
> I don't really understand what you are getting at there.
>=20
> That directory is for boards, but it seems that EFI is going to grow
> from just being a set of boards, e.g. with board/qualcomm also having
> an EFI-payload build.

We shouldn't need VENDOR_EFI_FOO, we should likely (a) drop VENDOR_ as
that's an x86'ism and then place more things as needed under
lib/efi/Kconfig. Especially if we're going to have (really?) end up with
per-SoC efi app builds for arm64, rather than something generic.

--=20
Tom

--Hc03ZPLRJyoPCnl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmehdpgACgkQFHw5/5Y0
tywIpAv/Q1Adusw9qC6xl3cDE79ykSRi+2RR6gi6NP0nEirDu6/szfmyx5elVytw
RVNbgwVxrWNpNEvpcwpzETklQoNnpBJSJz72FyW93+1op/4Ob7ioLA3WzRWgJpK5
MPA+Ru9khrY/OAHJSwO0SLPTnP5zDJwZ8gnnXZsmKh0hSLx4pQxgrL1YB/ZuvqtM
+NqgrkyM12uwZ+G3WMxVfXs9XOTz3LlRtKrHwEBaWVsZtjJhB+8vqs2rQjerZ8XK
+JNpGfkxShDIxz0cj9QzYVL+VWTvmUsU6euiLjH8AM96gwIGgyxiGEi1mQJbnmwI
mt5IAGO6goVPg9A1PUsFja9i8CWBNWtesjSfhODQu3vhojqxI8LuHlGGGK38uaag
JDMm+j9v9/xkBLI5f+DgDcFSMJM4Q0HbYN74EZDU/aONr3DS5hXmCUSk8sCiw2Pf
xoIwnOL0eLgkC1DeFUXedyCu7B8Yh+mN4qCimokLsaN3aCpxc+JwQu2m20Ha9pKV
/AEMzsLN
=Zt7k
-----END PGP SIGNATURE-----

--Hc03ZPLRJyoPCnl7--
