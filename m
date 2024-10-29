Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECB6D3A697
	for <u-boot@archiver.kernel.org>; Tue, 29 Oct 2024 20:13:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9EA6789197;
	Tue, 29 Oct 2024 21:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GeBj18W0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1800F89185; Tue, 29 Oct 2024 21:13:07 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98CA58919B
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 21:13:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-4613162181dso32713991cf.3
 for <u-boot@lists.denx.de>; Tue, 29 Oct 2024 13:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730232783; x=1730837583; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hbtYrGzPu9LKnLXVxa/EV79yFsAtnNZFWU86/7l9EMU=;
 b=GeBj18W0dNtM53dwP8k/iMnhqW5JsTYYUwyvZ4V/k5uIzoNIT7uRQvouU1sSonkxNr
 zNDCz3aHWBVosscjoA8h5poMmJpr+zA4ZUsW09zR2qUdy7fPYcyticOg2epS7SeiHBzd
 wQfEzyFoS78wIZmimGeaSds0dSeds1I8QBPXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730232783; x=1730837583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hbtYrGzPu9LKnLXVxa/EV79yFsAtnNZFWU86/7l9EMU=;
 b=BfSizIkp2oNFt+NIJlWKNXboQzLWQ7g4mrpOndZCNFw5sxP5lJeV/GpsKyP+uaT78O
 y0pAW2mPwtLNzRJGuNvyywmBAJrYwSXEyY4z6t6bIDSdkX6bNP/bGN9lnF/IzRoQFldy
 iSZacjwzndNTIUD+zK2l0W3roS8KW0X7p5YlDbvLtjRxPwj0r1BGWkvumC2/rk+mj+lR
 rjiFrEPnNaOZY3WX5A+xdoZnqiofjcY+4G52uK8rrx/U9dVFJvNm5fH1s4CBRTMBf59r
 44ysxmkn+l8QOGto9YYsDaJli5WW/vPJJxzOCHKQS6DiVELan7/zmtz69f32KDqcv8VB
 drcw==
X-Gm-Message-State: AOJu0Yzan6RcknHNAQKwgQydnou+oDTFT/+ANQFsy5YmR8J7l6TgOXJh
 c8epm7SmNqT4HPRTxYvz1ELUu8lGIpQO4As+86LOYbUNdoFDEeetpYDoSsZmTrc=
X-Google-Smtp-Source: AGHT+IGNp8fGyHimGXvwFApJehVT6uLgeY2w3gCwV3aGqcP3uc+nNIxXetP2a0iqPSaa9L+N+As23A==
X-Received: by 2002:a05:6214:3a84:b0:6d3:447f:db4c with SMTP id
 6a1803df08f44-6d3447fe633mr16726646d6.43.1730232783339; 
 Tue, 29 Oct 2024 13:13:03 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d1798bde62sm45496816d6.52.2024.10.29.13.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 13:13:02 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:12:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Michal Simek <michal.simek@amd.com>
Subject: Re: [PATCH v9 02/11] efi_loader: Add a test app
Message-ID: <20241029201259.GI4959@bill-the-cat>
References: <20241029192222.362445-1-sjg@chromium.org>
 <20241029192222.362445-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9ZU51QFSJO+a3TRi"
Content-Disposition: inline
In-Reply-To: <20241029192222.362445-3-sjg@chromium.org>
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


--9ZU51QFSJO+a3TRi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 08:22:10PM +0100, Simon Glass wrote:

> Add a simple app to use for testing. This is intended to do whatever it
> needs to for testing purposes. For now it just prints a message and
> exits boot services.
>=20
> There was a considerable amount of discussion about whether it is OK to
> call exit-boot-services and then return to U-Boot. This is not normally
> done in a real application, since exit-boot-services is used to
> completely disconnect from U-Boot. However, since this is a test, we
> need to check the results of running the app, so returning is necessary.
> It works correctly and it provides a nice model of how to test the EFI
> code in a simple way.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

This approach has been specifically rejected with an explained
rationale: It breaks how UEFI applications work and you cannot run
further UEFI tests in sandbox without resetting.

Since as you note, you can't reset in a C-based test, rework this to be
a python test where we can safely reset the system and verify that. I
believe Heinrich even noted that a test which checks ExitBootServices()
working as expected would be helpful as we only have a watchdog test
currently.

--=20
Tom

--9ZU51QFSJO+a3TRi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmchQcgACgkQFHw5/5Y0
tyw9sgv+P1WTz10WiwLkQHuyTYxAm9hsTTzp9HHR8XZ6cCF++WMrgdY5HbcrOjxW
VxuVMiIvYH7Tm5Lz29I094inzVokwEGdoSHgswiN8eyIK1yt9uwwlB2ZSa11Psnl
HHxMM0RcOSTbFh5wmN80R36uglZn+ThhOjd4uclIeo8iwzIvXT2orTAFapaCuyjx
3cZ/u752UslaLOwt7fFYWqgWBrFhrbrJ/W3wcvB0JNg31pfHm32vBgD/2lC9/yBE
R96w39e2ssC5XQcrT6RCfY1n98CEICXj26vX5+AdOgEVIUxeLJpznKx0R5aP3z9b
L0YwjTXUohZlA4EfKs///ML7wDhazfZLJnBLgSz3xesKBpeCfllSQvx1BnDVJdiw
EswoAoAB6vT9CFyARNexSVNcGk6iKYzr234ineQGRP0CzT/exO9pUZBScXDgBMgu
BRMZ0JSbd+TlfqfrGK0suwmYp4JfH/nuMNmGB7juDRdVfyC0UrOecwiiJVZsH+zr
2OUS6FHf
=UG+b
-----END PGP SIGNATURE-----

--9ZU51QFSJO+a3TRi--
