Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127FACAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 21:46:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42BEB832F9;
	Mon, 22 Sep 2025 23:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XIIrc6GF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ABF683335; Mon, 22 Sep 2025 23:46:12 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26F038004F
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 23:46:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-77b334ff27fso1870808a34.1
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758577569; x=1759182369; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hxyIQr7CoFMczL49JyXp96EWbRhdBI1WeO8uC8om1E0=;
 b=XIIrc6GFt0DXgBOI5136o8ESL9kf+IRGMunBPJBomNCKrSf4pZOphUPdCCoC5kszqo
 33eJjP9Qq7jes4KsKLfFChYeESJcaco54OY2W/7wxPsVLYtaWol5n8I1bWsr3lfZHbWO
 hTGJgVzM+F8uCZJQunvjW55bs+TSdYCnsb1mg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758577569; x=1759182369;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hxyIQr7CoFMczL49JyXp96EWbRhdBI1WeO8uC8om1E0=;
 b=Oi++jG0F0BZr0M2zA6hdY2zwjFUfVYuHuWvRKU9+w4Grd7hDnaQDMFS3gShDNT/YNd
 GEyci3K35Vuq1I/RTRklG/bDdpND1qu7IE/Ddaeo02LLzbEW95G0TIRbo4xiwSdPY48j
 nJ4SyBtO2rHPSXPFh/9yA3ROawHuBHUmiorjanEi/05Spxr6hRt3+CwRNO9OOnMeV8V/
 pCO1FK94iWn7oxBSRKj8+vxQ/AMHwK5RSB/WHsmsRuxVGp5AMutnTyu/f0scr6EsIhJ6
 y/+IvwJDzVCAofDHFpvwt86hf3mQ222ZngbByxA6f/QSasbbNdHdPqLyF4MKB2AkmynL
 FVFw==
X-Gm-Message-State: AOJu0Yx+FldCma3BI755wda24PfftwLqcBS1+n051K+K4eGMucIImlwU
 A2XeCESHw+FkEXjgOJcchMuWGH2qYxAQKf9aolViI+P8lZW7Ij2Wd90JvGGO46N27os=
X-Gm-Gg: ASbGnctog+4f5kflYGbrRXNhwdB4oTkcQ1wc3dY9lYchiR870KIJ6f5hCHoa91MI3MO
 GEkB6it3liCIScmRRe4DSXskiUqHen6JRALV4piMwfHICxzbDzgM8hDFbSpUyqSq1t2eVD+PPNC
 llpfg3Y+M15jQxd0G/y1BBluj1oQRtn5Mz2aPoah6C6vINToUPIfWkbirJv34H6BZ6ItsZzs5E/
 tHRaDg4+fPhIGNZHIz48vseSmb+LDY4ztZitupwXbW3TsLFG2CUWJ/u1qRrsMi639UVaVY7xmXx
 kfJYn7UPo715RGUMaQauQ3chrUpVXjwn+XRBvdKtk5inpmf9k04pVILPR/zi1j5XhXMJ4TzCEXN
 MvxfpMK+U4o4tIPoI+rppyg0Izmz8i+sB0GLhjkUiDmY0zbAe3gMzNPig
X-Google-Smtp-Source: AGHT+IFD4mG6+X3AHjOV9xaEojUOh7x6NmMz/3jucNuBjXw8gEKfkkS/xlq355yWjvPDD2lNT//ctQ==
X-Received: by 2002:a05:6830:440c:b0:746:d50f:f9c7 with SMTP id
 46e09a7af769-791443dbc46mr129866a34.4.1758577568851; 
 Mon, 22 Sep 2025 14:46:08 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7869342a09dsm1212999a34.24.2025.09.22.14.46.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 14:46:08 -0700 (PDT)
Date: Mon, 22 Sep 2025 15:46:05 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, "Lucien.Jheng" <lucienzx159@gmail.com>,
 Rasmus Villemoes <ravi@prevas.dk>, Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH] linux/kernel.h: Update upper_NN_bits() and
 lower_NN_bits() macros
Message-ID: <20250922214605.GH124814@bill-the-cat>
References: <20250922122948.56748-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TdeOeuloQPdMfoDQ"
Content-Disposition: inline
In-Reply-To: <20250922122948.56748-1-marek.vasut+renesas@mailbox.org>
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


--TdeOeuloQPdMfoDQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 02:29:22PM +0200, Marek Vasut wrote:

> Synchronize upper_NN_bits() and lower_NN_bits() macros with Linux 6.16.7
> commit 118d777c4cb4 ("wordpart.h: Add REPEAT_BYTE_U32()"). This fixes the
> lower_32_bits() macros and assures it works with 64bit systems correctly.
> This also adds 16bit variants of these macros, which will be used by the
> Airoha PHY driver.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

As a small thing for future synchronization, basing on just the initial
release (not point release) or current -rc tag makes it easier later on.
There's no changes between v6.16 and v6.17-rc6 here so there's not any
changes between v6.16 and v6.16.7 here either, so in the end it's fine
and I may or may not reword a tiny bit when applying. Thanks.

--=20
Tom

--TdeOeuloQPdMfoDQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNHDmgAKCRAr4qD1Cr/k
CnNgAP9WM48Ab+YvCruClKiSG1pL3HusqQ/qXuBVG0/jpvH70AEA6yYmdk/5SwkD
dfrlL3lB/q2i+0gn3UQPKXmQKlhX8Qo=
=2mn9
-----END PGP SIGNATURE-----

--TdeOeuloQPdMfoDQ--
