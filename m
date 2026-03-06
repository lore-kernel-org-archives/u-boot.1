Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A398BFCB611
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 15:12:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D367F83FA6;
	Fri,  6 Mar 2026 16:12:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="p1SmNwS8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFC8583FAF; Fri,  6 Mar 2026 16:12:42 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7067839A8
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 16:12:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-409de4132b5so3028803fac.1
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 07:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772809959; x=1773414759; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YgW6+aOulfzgNq4/w+LEZ/Q5PnM3mVWyB8O9S502c20=;
 b=p1SmNwS8vS2eJ/KvAsKsCzVW7/S2PsBvgkuUtwKovTnJg6UdDNwMaSquVm3QIPO/G8
 vZGKsSP6Kqw1JwhVm+qjaYudi5VwqxAW8PFlcN9uW9NH8Wn+21uSqfWpM+jTvfbrrbMu
 i3EBXw7q6sAiL07Swi8vv6Mp5tFeTLtHEgR3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809959; x=1773414759;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YgW6+aOulfzgNq4/w+LEZ/Q5PnM3mVWyB8O9S502c20=;
 b=udRK4/ccjWh021K8uKr4YXtocSQIdCVSjvcnxspSgG0c0hiDLeOe/GI5l6qaK7E6Io
 8MvtRj1hOAGS1i3yYKTWdO/EJrvX+TTnYRlAZzPWm3SPL1nPcZD0t+cixhoWY3DmCQDc
 r+uIM4Qd2krVG4PwBvwAjYC5vgjrwrSrs7bN3eDpWZnvxZD/8eFrPT5h25V8hJx/Xy9M
 CZHamtY9gQE7H7b83fI5h4nAwXVq9XI2gJBBwbvteJFo/1pOs3R5L32rxD3eZInTpfaa
 ACuFU+9GqXHo/o7Qnn7dbvGbwLkvzftOWeeM+FADKoHHIg/CIwxVIkCqFTSsQN4dyYs/
 rybg==
X-Gm-Message-State: AOJu0YwpmlNIaFMM72JMimFQXOkW7phUN0wDhr6p7wCvLBwx7XJ9kNbA
 CGb1w3x41LF9D2kvQF+9F0AhAMLTKKP0xaVyfUeH7J8FkHIBAlIAHV9eiykLQEdDOCk=
X-Gm-Gg: ATEYQzysGzwoIY2v/LrqIVLinM+zMVByO2dfm4eW9Fxy9YhIoMgODz2sH4hFk8vvCsL
 gVISpZ1dt54843Hgw5UXFX4ConKi0G/QNXNExRBt0YJWBuf4WpJpMLHjqugNfR/ZHKo80MXqXi8
 vZM44ZUeWXm3AGJeJ5ZlYrNf5zFCpqt19BVRlZThK6uKPuQcPY8htfZivUdRlGnUbtg4UqA7FLA
 6GspkXKhRCld2AcvXCxMtxgcNiqzG5zf7IeMqebITHHZLNMg4a6/aLerl5e506Drt6BzrVWqLfI
 lzNue/QJvtY31I1dI9oXDcDK3wVXvGsX1fYImvydph+waiizcXyXD83pvCoa8mhgRlTwEuG4V/T
 aAA38HIkPHsuPhvoUz94zYm5u+m5AKwvrawLZ3v+flDGkf9rpGkzPyq1h9jSrp3asKML1zYcK4/
 J9IgV/hHu4/S03i83D3O8r6nRIuCUOE0J1s8av2vSakOcwCAYOo0hvW3KL+AqreWxzAR3Yc8dAy
 R4lkWcGO3KX3QmUQuDFVG7TKdcrXAOboLKh8Ev0YetkcwKVLGc=
X-Received: by 2002:a05:6871:5383:b0:416:5a0:47d3 with SMTP id
 586e51a60fabf-416e3f0cdd7mr1458019fac.13.1772809959430; 
 Fri, 06 Mar 2026 07:12:39 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-416e6560e20sm1532277fac.4.2026.03.06.07.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:12:38 -0800 (PST)
Date: Fri, 6 Mar 2026 09:12:36 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, Vishnu Singh <v-singh1@ti.com>
Subject: Re: [PATCH v4 08/17] arm: Call bootm_final()
Message-ID: <20260306151236.GP1388590@bill-the-cat>
References: <20260306023638.2678886-1-sjg@chromium.org>
 <20260306023638.2678886-9-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="duOgHK85hEAPuRVe"
Content-Disposition: inline
In-Reply-To: <20260306023638.2678886-9-sjg@chromium.org>
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


--duOgHK85hEAPuRVe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 05, 2026 at 07:36:17PM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> The ARM announce_and_cleanup() duplicates the common pre-boot steps.
> Replace it with a call to bootm_final().
>=20
> Drop the ARM weak board_quiesce_devices() definition since it is now
> called from bootm_final() and the generic weak definition in bootm.h
> is used instead.
>=20
> Note that the printf() ordering changes slightly: it now prints before
> bootstage processing rather than after, matching x86 and RISC-V.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
>=20

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--duOgHK85hEAPuRVe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaaru5AAKCRAr4qD1Cr/k
Cs59APwP8Ks8Mny/H6h4SBatpZOgSE5MXX2SKccKHYfEMJ4f1wD/cLNsPCBTe5Yo
G7k5DPzG+fnRAjSwxhCRpqlis8bUgwk=
=sWF3
-----END PGP SIGNATURE-----

--duOgHK85hEAPuRVe--
