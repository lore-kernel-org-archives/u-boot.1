Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C719BC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 15:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 810C380B1C;
	Wed, 26 Aug 2026 15:17:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U5D_BegX-NAa; Wed, 26 Aug 2026 15:17:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787757438;
	bh=7nYQg+9Fs5wR/y/4jToXnYY0whiDQEq4G46pAt/dKKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=spJ1FJ4xRgUwIO8KRv1Q6oKiMLYArI9/fFwi4g7J60LHTLd6U6g4zCBjwGRDmL7A+
	 HeN0VBtpl0ue5SNN5pQifTkNqBoDl+qC8JKvkr4f7XhulC9rP2lPyLkHBnKbuifzre
	 5M0f8XpJCsOuSddb1Lggqc7ZxYYcQThNpk/M3J2IPVS/p0aEXqo/EmlbKSb5hX7iux
	 9+4hbS4ArxEMuVLzJ8u2O7nZQ18YzKhB337kflg6Q+3OB5JRen4jaasQ1YP/AjjlUy
	 sUrTxw2CpjnhkyIIYil75fyKpTZHm7qmvYUCi9hwzZVPBpeEziqBHKQPgL3kZHOetW
	 QFyjIvuNXw8cw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9A8F80B0A;
	Wed, 26 Aug 2026 15:17:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 99CF4396
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8C43B80B0C
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:17:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 47I3pNNhcm_r for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 15:17:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::5;
 helo=mail-oi2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=P5lVCAOu
Received: from mail-oi2-x05.google.com (mail-oi2-x05.google.com
 [IPv6:2607:f8b0:4864:32::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DD8C280B0A
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 15:17:15 +0000 (UTC)
Received: by mail-oi2-x05.google.com with SMTP id
 46e09a7af769-7f4d65b4725so47256a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 08:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787757434; x=1788362234;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7nYQg+9Fs5wR/y/4jToXnYY0whiDQEq4G46pAt/dKKs=;
 b=P5lVCAOumKUuSCsB0mE9eQh3IsYh0eEbMFFU/h4gG0hcA+Km5MBxIXFvoslmpePm/R
 jHNq2BJeK4ilJwUbFSXDHNkX2ObmG0LLKzbaBqkBcEp2FhcGXfazd7cYndmyce82i21y
 9l3Z+B8eVQRyk7rYaqQUDAODUiv6FPup7fx00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787757434; x=1788362234;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7nYQg+9Fs5wR/y/4jToXnYY0whiDQEq4G46pAt/dKKs=;
 b=I8roTHagVCHtqtcZp+ndC545MwtuXmElnCC47S8PAFHbCtJ3ZWNLbsGmUN/4F6pyFu
 4UNXKnFSP48LFRaNdw8D67VyZHvKhFA3tZSGtnK+6f2FJ5Ftk/U3SMQPB/QS3ECV9z1u
 0spUsQzRoCwJ9OlOl4JtNNhIif/Nn+4a5iPV09w0jYhBQwSzQ2oqVQiPtbIBZl4V/SMp
 2DohgvBHubk7cFl0xiBflmdIAAibfDVFqG3jpzclClgoF3MQdNbLU/FxAJ9KOsgOQ/DJ
 UPZizZwlwefJItMh+DKdnM2ATHDlgUs12LLqqiaRDvA2HFgzRi3f8tYP/3vrqWz7aZ0g
 /J5A==
X-Forwarded-Encrypted: i=1;
 AHgh+Roz0P+9W2HO3GyLAsGEvnZ/YfpVKRFI44TRP2ySVFE9xJMRHMIKdliFTiSybbM1Jg4dkdi/t48=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++l3ET3/JruihP3dZQgblbgnYUrKrtyu3+ZfjRbQQbWbfyBDuOao
 YuRsnv63I6XwW87HLyMSFGNS5HORDw9vDrKPIyvB2NW43vpUQsZ0poeZfetplRvpHmw=
X-Gm-Gg: AR+sD12l4bCLVA42EE15eqJvJ6xMP8FghOZyp7MsSj/jeD4NecAIvVZ3yAOx/aY0AaA
 rOhKZCEzRXsySKF1rJtHiRw0rXKTc+mad6umwEw1GX/R6V4FIBRG6IYRrq7zMeMTemMUMJe90lU
 iUbKoIhqFkdcu/ies7haN07UL2fvb1r1/Dy+dy0UT6X43IdlsF1/zQkSlQQFJcsnUHUWr5L8i/o
 rjTqWNsGahtkBIItSId25oNE5j9GvD1zohvpoPuE+VtsdKIASXEx8XZ37Ef+vXjhkn9SiF4bOVH
 dmwAMjsNyZhsfFuYIPgFDSdevOGNs3hvCjDOqoCr/DiieX+v1aKOl8iylJSHU5TjzEvIc/oYTDy
 JGpSsT+KBM6JNDmdxfBHSgVbvTV6S7xYvUBBsIOjiRHeN/0XaV9NkCT8+LjzdBnW73HwBkPgGxt
 k9hw1urGZAEVLzmqY3HzLoGChPuIqlwTJxEB6YVA45fRfct+LZrp93e5G0OlYuU7eyIKm6hfmXV
 HqpAroiZOZX6L0vtGRuJ1LllgOXlnsHb0jVvWbRBjWYOkMfq264RSAKeZO6vuC3eBts9avdmUBD
 h+6Fmyjp9qm47JsIrG4P
X-Received: by 2002:a05:6830:3883:b0:7dc:3db6:f02 with SMTP id
 46e09a7af769-7f4c525fcc9mr8712209a34.9.1787757434357; 
 Wed, 26 Aug 2026 08:17:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4c81f7382sm1904551a34.11.2026.08.26.08.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 08:17:13 -0700 (PDT)
Date: Wed, 26 Aug 2026 09:17:11 -0600
From: Tom Rini <trini@konsulko.com>
To: AK Sharma <maskachoska@yahoo.com>
Cc: Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 ansuelsmth@gmail.com, daniel.schwierzeck@gmail.com,
 dario.binacchi@amarulasolutions.com, frieder.schrempf@kontron.de,
 jerome.forissier@arm.com, marex@denx.de,
 michael@amarulasolutions.com, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v1 00/12] mips: add EcoNet/Airoha EN75xx (EN7512/EN7528)
 SoC support
Message-ID: <20260826151711.GN523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <kSKs4kbLRy20mVMgtwFdmg@gmail.com>
 <20260826150536.GM523975@bill-the-cat>
 <4CC9A9FE-CA61-4917-BE28-ED773461DEF9@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C3bTsQT0aXdLNbfZ"
Content-Disposition: inline
In-Reply-To: <4CC9A9FE-CA61-4917-BE28-ED773461DEF9@yahoo.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--C3bTsQT0aXdLNbfZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 08:46:00PM +0530, AK Sharma wrote:

> Please drop this series =E2=80=94 do not apply it. It is derived from Mat=
heus Sampaio Queiroga's GPL-2.0+ work in github.com/sirherobrine23/en7523_u=
-boot (the en751221 branch), which I submitted without crediting him and wi=
thout his agreement; it was also an early draft, not ready for mainline. I =
apologize to Matheus and to the list. If a corrected series is sent later i=
t will carry proper authorship and his sign-off. Sorry for the noise.

Thank you for the responsible follow-up.

--=20
Tom

--C3bTsQT0aXdLNbfZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao8DcwAKCRAr4qD1Cr/k
Cl2RAP9RPoW7ibtuTSPdTTPzjxdpWkIXTnIiIErydYIF/qW+eAD+LS7maENfiGwE
Sr+9VoctBHZEpRv8h83Mw6EtIRlOOAo=
=cZCK
-----END PGP SIGNATURE-----

--C3bTsQT0aXdLNbfZ--
