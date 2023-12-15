Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCF8C35274
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 22:48:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A151787C4D;
	Fri, 15 Dec 2023 23:48:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="QYftzz9E";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCA7A87C3C; Fri, 15 Dec 2023 23:48:21 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4C7787C42
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 23:48:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-77f8dd477fcso76892485a.0
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 14:48:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702680498; x=1703285298; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JbroY3Hjnm3zayCvV0IIqvYTv+owCiYGUbkVcPFphfQ=;
 b=QYftzz9E+47OsvIO7nLrMuODEaGgpDuVKbHmvyVYk5UVw16qayzWvnRdpDHo23RaTG
 vvWNdNUrtiY9pTyja1VrLMzEkd323O8HSY7Hs5y9N/wBdTWIEI3JWpRCiWpPDq08TC7v
 UOBDXEg7Fy02KR22+7ij55Z2BG47ny3KZs8q8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702680498; x=1703285298;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbroY3Hjnm3zayCvV0IIqvYTv+owCiYGUbkVcPFphfQ=;
 b=pmsQA6nrMQSRPPmXEM9ZmGStWn45N5DCYD6UfMlkFATgXfdS7d8GRMYNtqO29duGgr
 +L03YoaP4EEvdFdrG/hZpG13AfZEehThvltbpqYXmdd0WGh3swUVH97fvfiS3osdetQe
 uZIBd9VS4RF0Bjhi/H4ORwiNhjRMYFTX6FJhffFKWchez4Y2aINpXUjSe3MaOwL3k2Qb
 +VCHiJdNJA2WfvvrkLXWcn45dWBlUpH6rSTl9a1nnnBiz4f2KdJmp5BUrhCWSTW+iZzW
 +AkJtoH97jBDZlGlmUlkbNb2oawa6ymH3ONxpsGyL95nAbIol9dV9QsKfVWyHnsILrM8
 2HfA==
X-Gm-Message-State: AOJu0Yxmce8sL9KysmsW5m0AWriFvuv3yfAx5mQP1BQqE60IjsaDqKkH
 SEjxFI6S+R0VErXSuErGzaFtqQ==
X-Google-Smtp-Source: AGHT+IEbHBONpTfR3qfvkwJ14poIQzrt78Ww4HiRsDa/x9gAkDJZFe1E/el0R3BP6M+2LkFXTI0KsA==
X-Received: by 2002:a05:620a:458e:b0:77e:fba3:755b with SMTP id
 bp14-20020a05620a458e00b0077efba3755bmr14315251qkb.83.1702680498444; 
 Fri, 15 Dec 2023 14:48:18 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-4efc-63ef-4955-a8ab.res6.spectrum.com.
 [2603:6081:7b00:6400:4efc:63ef:4955:a8ab])
 by smtp.gmail.com with ESMTPSA id
 qt13-20020a05620a8a0d00b0077d75164ef9sm6425498qkn.124.2023.12.15.14.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Dec 2023 14:48:17 -0800 (PST)
Date: Fri, 15 Dec 2023 17:48:16 -0500
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Neha Malcom Francis <n-francis@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
 Simon Glass <sjg@chromium.org>, Apurva Nandan <a-nandan@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 4/4] arm: mach-k3: Merge initial memory maps
Message-ID: <20231215224816.GG2513409@bill-the-cat>
References: <20231128170528.407707-1-afd@ti.com>
 <20231128170528.407707-5-afd@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+v0LHs8Kezp3OSJC"
Content-Disposition: inline
In-Reply-To: <20231128170528.407707-5-afd@ti.com>
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


--+v0LHs8Kezp3OSJC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 28, 2023 at 11:05:28AM -0600, Andrew Davis wrote:

> The Device vs Normal memory map is the same for all K3 SoCs. Merge
> the SoC specific maps into one.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Nishanth Menon <nm@ti.com>
> Tested-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/next, thanks!

--=20
Tom

--+v0LHs8Kezp3OSJC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV817AACgkQFHw5/5Y0
tyywPwv/QTwxlIb4OohTpwMlnbeF5cJiWs+nesv16PQ3dqXviV339LrpFWFAtCU8
uoP583GRSthNPq7YI5kM9a+jpvnLzHsoeaZuE4wMGnPGXTyq0MkM7hw1PHPkQmBC
RtoWBD4c/L47mKmFMzkIspkxxhQCodv0ehg0VPS6iylNeKVva55aqqKA+tHIegnT
/fwWxBCKUNfxfulEPeNtTeBW8wsIOogukdmB5zUNrivJXzlch1NtDQGUNM38iMxG
Xtv1g4lDPIsuUeQ5tJlTST6efuu0Ne2NQMloe/6ZUr9rvdq5dEscpCV5/HiTxL+k
QDCA+/EHhrZq3+hPmJn5QZxi/WUaraQth/1BSEf5ApO72IjDcvt52FBT4fw8N21F
YShEXMQ/UTnkEfFfnSuUuLP4Gw6vSSM6swriZ071oPreSrlrenWCYovYZpzsd4se
Lmn4n0ZgzwCNx1njrLfGxQ7UdwXXF4cUXtAOxEswDSvXa2EAcAHpjg/KXbdduB6T
UMmQ0o/h
=OiRt
-----END PGP SIGNATURE-----

--+v0LHs8Kezp3OSJC--
