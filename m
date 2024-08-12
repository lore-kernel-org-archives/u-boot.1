Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D7BDC3DA7F
	for <u-boot@archiver.kernel.org>; Mon, 12 Aug 2024 18:41:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A89587873;
	Mon, 12 Aug 2024 20:41:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="stvsWoad";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EE7888853; Mon, 12 Aug 2024 20:41:52 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50C5C8785E
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 20:41:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3dc16d00ba6so2934781b6e.0
 for <u-boot@lists.denx.de>; Mon, 12 Aug 2024 11:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723488108; x=1724092908; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9+r1TmS8A8M5k+SfoFtmhZ8HHb0H2t+MWIrKMIX6VYU=;
 b=stvsWoadGYQK6i5bvx1+ly06mc9e7gI+7ORjk7ijGfHfXapSIk+l1G36cjC+qOatuW
 olsRIkJyggMSN/U5adycHyGhl2OJhjd6VxNo7+V1C8wFmFrXQw+esIhq14CcWNB5E4Sa
 y/gUDNB5fw1r0q7smxvR9bpAINXebHo8LCHX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723488108; x=1724092908;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9+r1TmS8A8M5k+SfoFtmhZ8HHb0H2t+MWIrKMIX6VYU=;
 b=wx7ir1/J/rebowPlZYHqNHDQTxnAJVXGX1s+4CdQfYt/YlJsjJDly0q5VI8txVWiFo
 Q3zRQary0YUOTJyKL5Con58DXeIkFAlXoOOj1WNR7XacAIxmp8SpUptmS2/i4DsXRRSt
 3h26yKXK1GmiEQ+jbwlhdmr5RA12FrrDdN2RljkM2ejnqe7tEREODF9CvA6uadWKRZc5
 YZkrKQq5Xm0eSBqPcBmbs1euD9KRprMRIaP2HuKNcz/2gUK/6fBA9XNsQh6dZ/+N+XQj
 R4T8asoJTxWtO7DmEe98Ehdmz8qF1EcWBVTUuqkW+3PgrWZ/AMv5kDjg4KwITD2+gut2
 imgg==
X-Gm-Message-State: AOJu0YzQvgCwbEnXpmvmM+PdNT2TXIDiAJnZUHRsQnWxIXaQ+SUoOZHv
 0X6+3F8DKNPEblcdxkypor8JhBvQ4WKfh8HdEoVeT+HT7iJ9dgZQHyQ+j/rsMRc=
X-Google-Smtp-Source: AGHT+IHESrxZMf0ybUvwlR32NLHBe9IFZTR+gX5HfL542wtrc2TB62lXF0EEimpX5Jzpn5biyJwVQw==
X-Received: by 2002:a05:6808:2dc5:b0:3d9:30a2:f8f7 with SMTP id
 5614622812f47-3dd1edb7e19mr1594845b6e.8.1723488108003; 
 Mon, 12 Aug 2024 11:41:48 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3dd060890d0sm1382885b6e.27.2024.08.12.11.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 11:41:47 -0700 (PDT)
Date: Mon, 12 Aug 2024 12:41:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: Pull request efi-2024-10-rc3
Message-ID: <20240812184144.GD1626301@bill-the-cat>
References: <7617b97a-c22b-417d-9ad1-66f6eb024c32@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n1ziZYU9e+0t9NrE"
Content-Disposition: inline
In-Reply-To: <7617b97a-c22b-417d-9ad1-66f6eb024c32@gmx.de>
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


--n1ziZYU9e+0t9NrE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 11, 2024 at 09:06:35AM +0200, Heinrich Schuchardt wrote:

> Dear Tom,
>=20
> The following changes since commit 7bd2559cb30a4e800db519e88a22a25f13c753=
ec:
>=20
>   Merge tag 'tpm-master-09082024' of
> https://source.denx.de/u-boot/custodians/u-boot-tpm.git (2024-08-09
> 14:00:04 -0600)
>=20
> are available in the Git repository at:
>=20
>   https://source.denx.de/u-boot/custodians/u-boot-efi.git
> tags/efi-2024-10-rc3
>=20
> for you to fetch changes up to 2956a84ba70176333743773c9a2bf0353add65c9:
>=20
>   Makefile: don't use CFLAGS for environment text file (2024-08-11
> 07:54:58 +0200)
>=20
> Gitlab CI showed no issues:
> https://source.denx.de/u-boot/custodians/u-boot-efi/-/pipelines/21972
>=20

Applied to u-boot/master, thanks!

--=20
Tom

--n1ziZYU9e+0t9NrE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma6V2UACgkQFHw5/5Y0
tyywNAv/cfhRpFTGBuo4il0V/mDjH4b8Gx4odx64XeUg+M/x0oWNNnGIwwXbpMjv
JkmoIr4B/t7fbPUNdCdLGUeT6ot/hzBm8nu0bs3NmPgx2X/5iHShGXO9m9Mjl9GA
vpVmrxGk7z4K+zIsG7+9mN5DOxcmaXOED1Zp6dGaBd34RLv3Vo6yqlX+vqFEGYwC
MBHCfaypUrkIr0Q5GvgCotEb2KutuHajCFWsF8I3HyZqdGgFkHm+GIu3fb0TPGEW
VgqMotDsLDCT3V5D5AGF9+esjT0sDe9L8Lv8XyddmhlMHazJjJRgksQj21ZDHe6U
+rb7iXM5NxiGSgxEovsEFcu9BQhac1Xp5RtZ/08Mxy7FPMmM2pbO+KfVcfAj/HAb
Bf7JGixOC5mUu8v+iIGvJJ/RqK4BbCwVgoYnL3wOmfPqhRX3s8FxAiXq7KgabB9M
0e6YcMTDBt1dT44eA2jHGwvDs1PAu1Z1MPkR3VYB3xEwPhzfMYnYT0a4CGaqHiFo
YAku0aos
=3yxC
-----END PGP SIGNATURE-----

--n1ziZYU9e+0t9NrE--
