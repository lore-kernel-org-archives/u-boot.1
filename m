Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86273C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 00AA8874DA;
	Fri, 17 Nov 2023 14:41:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nkIwMvDb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04128874BF; Fri, 17 Nov 2023 14:41:24 +0100 (CET)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB5858749E
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:41:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-778a6c440faso105486685a.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228475; x=1700833275; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x3GoM9fLOLLyONz5LJQ6ypaP8wZ2btQRX+e90APk8WQ=;
 b=nkIwMvDbtDFGqSjV0B615gBrIMgODMH++hUxFSdKoe5csj+DuJu/sF9p+zaUTxjBAb
 7GTO7b5WEeJ/hN2RrpyXivusWMwS/Ce7USwN8Yk9jv2ZQOJl9H4mfU7zaDzF5Eg/BxNM
 3gtejhmxglokhMNXGfDRJ4Mqn08YoZWsePIRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228475; x=1700833275;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3GoM9fLOLLyONz5LJQ6ypaP8wZ2btQRX+e90APk8WQ=;
 b=AoWI1eOsS668r2BF7E0rmwa8vcKlAhOgj92jENgoUwHjmGsLCB+SzXnPfY8aRc8KLL
 lf3QnF28YY/2dwxb0OHVFPYn5gJZMltT8L1DxZ3JMciBSE39HY8pY9GiF1hG12pgoSdu
 dLqjf7I+1CbgXDxPYRG5feEpd8gvElj5FDjC5S1+qYvhKh0q7tlzHYBtZ5ZVwMelLKEt
 lUgrzswkosvYaVgMi+brRVG+AGWX9cXN2ZwpY/Khz8JwRRYY7BzeVSm3lfKfjEscbqV1
 DRScjEcCMFOVc/3z9KfUWLV4BxUjSXxYcCMa6CbldobCHqC25vqAl9BB9IA0ZDzEn3ED
 AOLw==
X-Gm-Message-State: AOJu0YyF71sDBmiIxjYaUsNEjQIMh+puyWebwdnJRcCYNB6N+5ZHjDPn
 3QSODUCMj2uLeAAvDCgrb+vz+AAhp8vMQA+yjZ2HBw==
X-Google-Smtp-Source: AGHT+IGSUeeXP5sLoX6t7oIDCBIQ4XRyvfmRhXCYe5vUCFbDelgTEs/oxSDpz95ra2V8ieLnh2e5Cg==
X-Received: by 2002:a05:620a:31a1:b0:77b:bf2e:c084 with SMTP id
 bi33-20020a05620a31a100b0077bbf2ec084mr15021130qkb.50.1700228475721; 
 Fri, 17 Nov 2023 05:41:15 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 qf9-20020a05620a660900b007676f3859fasm609653qkn.30.2023.11.17.05.41.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:41:15 -0800 (PST)
Date: Fri, 17 Nov 2023 08:41:13 -0500
From: Tom Rini <trini@konsulko.com>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] powerpc: mpc8xx: Remove usage of common.h
Message-ID: <20231117134113.GL170968@bill-the-cat>
References: <d8ba310b353395a54222b728a4add87c846a2729.1699294227.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ana6kXz79W0o0/vP"
Content-Disposition: inline
In-Reply-To: <d8ba310b353395a54222b728a4add87c846a2729.1699294227.git.christophe.leroy@csgroup.eu>
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


--Ana6kXz79W0o0/vP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 07:12:04PM +0100, Christophe Leroy wrote:

> Remove inclusion of common.h and add relevant
> includes when necessary.
>=20
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Applied to u-boot/next, thanks!

--=20
Tom

--Ana6kXz79W0o0/vP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbXkACgkQFHw5/5Y0
tywdyAv/WK4/coz559gUnaLIDBZJaopYknX9YMsPpKc6h2aJAtZsKjMv6llX/C7s
A+lD6br6KwrUwpp7W/quZ3WFpaeF5gjnf6IkPKDPc5mE7LhqbulrdznGp+e72ue8
GBuAoyTacPzt1NPiQiWCGYg0Je26EglzoV4WqK9nh8n0Ff7ShWGEk9cLMy/s5bXr
oWDT23RYYeRic5Or9YOw0NyO90lMIRAwDUtFsIjm6UnTLRDYC5B9nkiCrCOP9kwa
PQ4m/7Ekl2oLowHf2nRPl2WCKfll9KafxajpFoFIEeGgcBsvhw+DM8muQ7dhQQ4K
Ysrpn0kGqoVI+X77iNk73/aC8PJvBGykCkz0k8ov5AoTZb2vhi3T/HFJhUwMzKmf
3WVTV/kjozxeMctDdjV1z2bpiDPhnRInk0tCH40sm5BW1s6TAfwIhVy5+bYY0X9L
C7SXH7UAJ7XBbyiNJeIvH7pMa5KO62EmRUQJfvRP1tR7X/PymiSbnvE/VBEXX0X3
M6rvjnhv
=t8ZW
-----END PGP SIGNATURE-----

--Ana6kXz79W0o0/vP--
