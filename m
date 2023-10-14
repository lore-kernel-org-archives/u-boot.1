Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70E7ECDB47E
	for <u-boot@archiver.kernel.org>; Sat, 14 Oct 2023 02:16:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB6086EA8;
	Sat, 14 Oct 2023 03:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NRoq4eYr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9F8986DCC; Sat, 14 Oct 2023 03:25:10 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3BE0386EA8
 for <u-boot@lists.denx.de>; Sat, 14 Oct 2023 03:24:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d81dd7d76e0so2796549276.1
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 18:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697246451; x=1697851251; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eXOvcFvbZ7KDwc7rVVC4advHsXwz9OYV83jaje49PeE=;
 b=NRoq4eYr9oQKwlu6RwTJvu/hWUDXLzlxTepH/aUb7oEiOTQH5NSzffDHeW2i+Fm7xu
 79p6qd3Dr4/K7QKyNIdfBz0quQeLJa1B4661wMneh6kDlCphDyCsXJW1d4VLchgCJokB
 H1z58qdOIzHsrtex0mKKhySmyTCwo6poPwgRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697246451; x=1697851251;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eXOvcFvbZ7KDwc7rVVC4advHsXwz9OYV83jaje49PeE=;
 b=ZLmVRgWmqvZNe2XNpQB/CVbHDqvjG5GZAAyQm5YMbADquxnffLHUe2QNAPyiOE8PEF
 kZ9piRy3qjsV4qMG7JVcHTRSnjRT4w1ZZmcn4QwKRtc2TcF7edzMPHxvnDY8E01aoxxx
 WOntNRWawAlCu/qzRC60PpZiS8Zm6zcTIx29zTwK2zWuksIq6HFrsPHtocMTdCAa3NY9
 DniW8z8UuSAyOD5QHjiGhw96S4t+SUnlx6/1XOWZJkBrhJTTWoxFSIfPS8IIaLaMTWUN
 OkejgiTDw3/K3LbqsG2upMGRNlOfJacQdo2/yPpqD6n3h3MZLW9iCSP/h3FnY033fQqJ
 taQg==
X-Gm-Message-State: AOJu0Yyrc3T1aNgxR77HO4g8wSm2m7TsR3qv2OHN/Y3+TeKaUu25De6H
 j6tOxnc7PmCN1M5NjINya2QK5A==
X-Google-Smtp-Source: AGHT+IG56c/LLh8PFKrtFDOLW2i4xkA+tF+ike+ML50sJTwU5V+XGi1YWkQ2BXMNIfN9SEA4mU+0EA==
X-Received: by 2002:a05:6902:4a:b0:d9a:3708:f7f3 with SMTP id
 m10-20020a056902004a00b00d9a3708f7f3mr13788086ybh.42.1697246451572; 
 Fri, 13 Oct 2023 18:20:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-b33e-4d05-2330-607e.res6.spectrum.com.
 [2603:6081:7b00:6400:b33e:4d05:2330:607e])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a25ad4c000000b00d677aec54ffsm859463ybe.60.2023.10.13.18.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 18:20:50 -0700 (PDT)
Date: Fri, 13 Oct 2023 21:20:48 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH 4/4] test: dm: add SCMI power domain protocol test
Message-ID: <20231014012048.GA2472471@bill-the-cat>
References: <20230926070043.738340-1-takahiro.akashi@linaro.org>
 <20230926070043.738340-5-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K8JIcqr2MFRF1RW5"
Content-Disposition: inline
In-Reply-To: <20230926070043.738340-5-takahiro.akashi@linaro.org>
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


--K8JIcqr2MFRF1RW5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2023 at 04:00:43PM +0900, AKASHI Takahiro wrote:

> This ut has tests for the SCMI power domain protocol as well as DM
> interfaces for power domain devices.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
>  test/dm/scmi.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 106 insertions(+), 1 deletion(-)

With v6 of the required series there is no scmi command, so, how do we
test this support now?

--=20
Tom

--K8JIcqr2MFRF1RW5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUp7O0ACgkQFHw5/5Y0
tywVngv9EkQsMujqNzp+BHeIaE7dGWtGGlmjMCOJywFv4s9YkkzPqbja1AgQUI1+
6GbJ7/La2XysVuAzRR9pyx2zPRWQ6fM0xImDurkJ9AHSoZ6w3JZzPJGrnjJJCWqU
YXie10dUdHVwd7UyJVAbakq/89ija5tD1/46jTROpDK/AaB9SWO99ZplSEa9cSd8
zXdg/fRl71Uedhw7+CiRSKEWGVEqZ1C/vGb4wMxsrHalcOWjC1DBekFibKZIgIB5
/4QR/FRyastlpfELvSSzJH1xntYNy+l045N0WO2PFyFuJ52GoJfFWJtP20Rw0XVV
S7t2TjemNkVMEUsTgjTkB+61bfGXclYvLOUaRbOS6AfvqeSpFSe5ArEYpaVOwSxw
bA9vppxfPXJcRvNVR7sutaDB8hnlyOigigCiXekGlACbjwTuuC79Nu9WnD6E3yXU
jsqc+6Cur37qpsCOikAhuSCHr+wT7/rT7OS7bygmbjjPbyHdFtKyVsDxY93Eu04I
WTBOYSno
=LVCF
-----END PGP SIGNATURE-----

--K8JIcqr2MFRF1RW5--
