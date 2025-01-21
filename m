Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E5D7C02182
	for <u-boot@archiver.kernel.org>; Tue, 21 Jan 2025 16:11:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BC30080283;
	Tue, 21 Jan 2025 17:11:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cSi8EQV8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8AC4B80326; Tue, 21 Jan 2025 17:11:08 +0100 (CET)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 616F9801F5
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 17:11:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6d8edad9932so42755606d6.0
 for <u-boot@lists.denx.de>; Tue, 21 Jan 2025 08:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737475864; x=1738080664; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dU6oIW/boJNZUjHYkziQxUGTi5VbqFUaK9oTMjACQYg=;
 b=cSi8EQV8lWb0zsjdY8Rd1RtlmAOqqJt/W0nxe5cPWphMOcuLVm4wvPnlhRXe40vwWp
 9Vxt90K+gRj3vjsr4LooUAUyYv14Amy9CGzVBRZqV+llS2U/nCJ8uHD6KwcD/3Dk2oFB
 8EPNfLdbC1+6iNqJDHQ0jYCqJ2FckEpL2vaQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737475864; x=1738080664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dU6oIW/boJNZUjHYkziQxUGTi5VbqFUaK9oTMjACQYg=;
 b=C9HHX1npeeVLOdcqd3wwqt3WcVPdZ+Xeo+8mbRgOdEj6ZMWspAlJROJdqQQB6LML8Q
 7wzAvh0/2owV3+yx02getrHV+whnt7n81QekYuwA7pWYzSY6z8ymoBt/sFuQ1x/qt8Jy
 k18zTpH3yDz3yuA90dpKKIDunCsoIcxUdYy+6XuTYDB8LbxZHLdCTKVA8ImDI2JLWtf1
 VL7dsTDKJDEYn/v5wLDox7mhN7aMQm3fgatDoptFdp2We9O1YnP93ZohlF6Au6qImVMQ
 8w7FXZqBs/lHEXMsT9Nu1aV57EmphE1WJD5C4lBUnWahlAIORWNtTIVxSPSDCCDa5gNK
 H/nw==
X-Gm-Message-State: AOJu0Yw1u/Ov7yFCwux0tUWWdX08hAQLKwFhygddEpH3d/Nk0L+RxWBe
 jAvHRv9C9kG3Bj0oZNIDQXsIeB8kJvbtCSg3fHDHuuot9Q35uYrPIGr20lrKz5k=
X-Gm-Gg: ASbGnculoxSEfe/M3CsrdKdEad5wnFlTY6+t0toRMEytQfH6r2AIJGMKecSUuXCD+rb
 n74zeyAVxWrwn8Tqr3n1DD2JUhtkY0ANUfc8N01l5s0vHFt0OvGyAVPPd3gGk8OUp6QqL1OCcEj
 dG/SAOjJlRYxiJy3KxEKVnp+EHNl3ASDioE02x3LV5DnfsFJBZBiwQWFLXCy7NrO4BfqXSUevX8
 VxUF2bHC18LOGWs9BXtOGo2usOKaV9SoRCh/oy9OGXszL2+MyF103GcA04XL25+sCk=
X-Google-Smtp-Source: AGHT+IHCtJdfO3PHO2euM9Gnk0Sx2v1N/4ymauCjsiOYPAX0lU8/2kcSnd1N0N38xcxrrUKvkee0Sg==
X-Received: by 2002:a05:6214:230a:b0:6e1:7b35:a0d5 with SMTP id
 6a1803df08f44-6e1b216fddemr308500496d6.7.1737475864227; 
 Tue, 21 Jan 2025 08:11:04 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46e1030e4absm55553251cf.43.2025.01.21.08.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2025 08:11:03 -0800 (PST)
Date: Tue, 21 Jan 2025 10:11:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v4 0/2] Static initcalls
Message-ID: <20250121161100.GI3476@bill-the-cat>
References: <cover.1736174204.git.jerome.forissier@linaro.org>
 <20250117214621.GA2503843@bill-the-cat>
 <d81651a4-f849-4d4b-9e6a-d8fe277b3d03@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kq3n70QNR//ncZCr"
Content-Disposition: inline
In-Reply-To: <d81651a4-f849-4d4b-9e6a-d8fe277b3d03@linaro.org>
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


--kq3n70QNR//ncZCr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 05:05:58PM +0100, Jerome Forissier wrote:
>=20
>=20
> On 1/17/25 22:46, Tom Rini wrote:
> > On Mon, Jan 06, 2025 at 03:40:12PM +0100, Jerome Forissier wrote:
> >=20
> >> This series replaces the dynamic initcalls (with function pointers) wi=
th
> >> static calls, and gets rid of initcall_run_list(), init_sequence_f,
> >> init_sequence_f_r and init_sequence_r. This makes the code simpler and=
 the
> >> binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
> >> bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> >>
> >> Execution time doesn't seem to change noticeably. There is no impact on
> >> the SPL.
> >=20
> > This fails in CI unfortunately:
> > https://source.denx.de/u-boot/u-boot/-/pipelines/24241
>=20
> I found the problem. It was a silly mistake :-/
>=20
> diff --git a/common/board_r.c b/common/board_r.c
> index 74ebbdc7de9..21a8b97d1bc 100644
> --- a/common/board_r.c
> +++ b/common/board_r.c
> @@ -717,7 +717,7 @@ static void initcall_run_r(void)
>  #endif
> 	INITCALL_EVT(EVT_SETTINGS_R);
> 	WATCHDOG_RESET();
> -#if CONFIG_IS_ENABLED(PCI_INIT_R) && CONFIG_IS_ENABLED(SYS_EARLY_PCI_INI=
T)
> +#if CONFIG_IS_ENABLED(PCI_INIT_R) && !CONFIG_IS_ENABLED(SYS_EARLY_PCI_IN=
IT)
> 	/*
> 	 * Do pci configuration
> 	 */
>=20
> Shall I sent a v5?

Yes please, and push it through CI first ;)

--=20
Tom

--kq3n70QNR//ncZCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmePxw0ACgkQFHw5/5Y0
tyzYAwv+MofCoayBjPFnPLAkOYFc5nYvn73QIIHTGuFotIfHNme7DhIWPQuDhEcZ
OndqnjAfNZaRRlE0uQrH9n6XzRe+SHaLHJL1q6lZBtLPqyAIIw31BtUaFc90da8p
cfG5sfLSq5pJrwoDWUvh0xGQJXVouAs41dwstr/cxtoL4i5BqHhfAosDnwuWS9mY
z9zs+iW6LkDEzub1f6nakbFnp51bE9gO7tr7OEfqJeLw6MtcH3FUKzux4n6MX4oG
GRNYBzMbexIfNJimu2CN/DgUoK2rKQxyjLXybMXwfx6dLNseBhOasUophO+6u/jS
5Ihz0XhddwNrdmda79MD0+vCpnBZyTG1zJPSledm7GT0kEkR3aZxolAC6gRt6fOH
FKEE3HIl4sa+7GxX2LQSy+ZJ8x2fkO5vDL/iJJoiUyW55t6pKkdiaTmhMuF25Uaa
NEk8y/4ZEURlmaJGH/LFtv5YEGSCR77o7NqpXd8GSKeg4AaEx6svjGi4+GErQiW5
Khhb9gq2
=1uAx
-----END PGP SIGNATURE-----

--kq3n70QNR//ncZCr--
