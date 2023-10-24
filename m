Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3E7C25B6D
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 310C387A3D;
	Wed, 25 Oct 2023 01:18:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HfS4imBm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 72C7087994; Wed, 25 Oct 2023 01:17:30 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A79A4879B8
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-5a7af20c488so51088247b3.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698189432; x=1698794232; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=32wc22rorHENxfjYnqaQ/1aBFtTmLYxh0ctWmUc9EpA=;
 b=HfS4imBmXshPlUt/A/mp1cBfuX7k8fw24vmBgvVADFJvn1HHuGWQsaDFPPDocA0RNA
 XKm3ZoIG6QDLSCssw8fWOlOMBloZn8H1T2G7h11eLev4XeTWZzuJa2cv0XcJpCi8h2Tj
 LqQE6dxX23MsNu7c+nFJ7/RwJ88+sEk7nA6Rw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698189432; x=1698794232;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32wc22rorHENxfjYnqaQ/1aBFtTmLYxh0ctWmUc9EpA=;
 b=wDs76PuwWHHlgtR+u3l170pPeoy7478ueFrvbdIpDHStEIQeWAp15Sbo5kXRpFGInJ
 YPBqPyB1Qhd0xWEYeIyYa17Kq9SI8gDip5PlMzu/C1BXvDudrCmGX2JkP+8aQLILzP9N
 00FWLZC64Y6SGmUaI5fxvkb5iShgJCQCGkM53AQ6zdnJD2kh4EM/bX3H/juYB2rcArxb
 N1eV+lnJHg93DZc/tmLKuu/nk2ZUJQRWlv5PVmvZ+O684yL3bDxcOkfd/ABjU3s9mwbw
 UhGzxoRtp9vWrEPdmz38CEKuP7YjKe8wYg6m+wp4GnjVkuBObjIgX+GbqRPENZzjMY8f
 C6dQ==
X-Gm-Message-State: AOJu0Yy5YJfi3iFIuo0124CMT3lVDoii3qlEzkBgYf8CyuE5wXxw8s4g
 g7WurTX5XKhcFVKuU7yT3WQDuA==
X-Google-Smtp-Source: AGHT+IHB9dnndsAaV/qcSlVfJzrBVFAF0+75bStbB5kAOgc7av0cHKx3dKrnrcZ9IscFEzc1tGdvgg==
X-Received: by 2002:a81:7354:0:b0:5a8:1973:190a with SMTP id
 o81-20020a817354000000b005a81973190amr14869838ywc.8.1698189432670; 
 Tue, 24 Oct 2023 16:17:12 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-89e7-8c52-372d-17ee.res6.spectrum.com.
 [2603:6081:7b00:6400:89e7:8c52:372d:17ee])
 by smtp.gmail.com with ESMTPSA id
 o207-20020a0dccd8000000b00589c103d00asm4497959ywd.79.2023.10.24.16.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:17:12 -0700 (PDT)
Date: Tue, 24 Oct 2023 19:17:10 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc: sjg@chromium.org, etienne.carriere@st.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/4] power: domain: add SCMI driver
Message-ID: <20231024231710.GG496310@bill-the-cat>
References: <20231016053946.470458-1-takahiro.akashi@linaro.org>
 <20231016053946.470458-3-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nziKoeuIks2BCpoq"
Content-Disposition: inline
In-Reply-To: <20231016053946.470458-3-takahiro.akashi@linaro.org>
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


--nziKoeuIks2BCpoq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2023 at 02:39:44PM +0900, AKASHI Takahiro wrote:

> Add power domain driver based on SCMI power domain management protocol.
>=20
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>

Applied to u-boot/master, thanks!

--=20
Tom

--nziKoeuIks2BCpoq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU4UHYACgkQFHw5/5Y0
tyxtYwv/ZqB9irxLIozcP+7DU71CFkbg3ZLsVMfEKYV/5vPvxQLU5BNgl/nSHv9F
I6Ly5PPf0lz8UVomosXiue/J6bX5KBlU8crJTDeknU/OU+tfpCv4N4xDgyxeTRuG
Yy9D6M6Jti47QUwZjvYHmXmNtSf8Qe6S7FQIdIcVnPNDHmmmJzobE/3GLnAEN9oA
jaYvlrUwKECzO1J5be4AwFTDwUiJKB10DV2/S3l1h/cPuGacKtXtosYJFEkTqwJn
mh2jwMWUD9pJh5tqZ/RodNBdr+T455ivF7/hZGdbA9uYF8e0bJNpwG01HAoKVcl4
GGvqrbfy5FEgjjtx71rM77uecUZjinpZmysQncIzGllZp5MYVYAyiGUawQw93LMh
gPEN0hlIynqE/PZeCicd2QLlJhiDFNxsmC3+HV6tDb1vRWdhicQcCiuEnPrvjZAT
WZxl5tEYrctaKJI2YUAv3f9Xrn7OH+gWtiAq+p7NlljUR8r2NWVOaEt2kXxyVOXO
YxtGKx3C
=ugxb
-----END PGP SIGNATURE-----

--nziKoeuIks2BCpoq--
