Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27DF4C38150
	for <u-boot@archiver.kernel.org>; Fri,  5 Jul 2024 22:40:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D15E8889F8;
	Sat,  6 Jul 2024 00:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="J5Z1MDyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7CBDF889F1; Sat,  6 Jul 2024 00:40:23 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A30C889EF
 for <u-boot@lists.denx.de>; Sat,  6 Jul 2024 00:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-70226277bc0so1291754a34.0
 for <u-boot@lists.denx.de>; Fri, 05 Jul 2024 15:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1720219220; x=1720824020; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=//rnqDLUX+P9mgUV89BuTlJHRU8tqMHI1rk2w3Vn9Tk=;
 b=J5Z1MDyvGve4xYb/rZlgI6DIYpM5yezuQYNgfVu9Oi4wzi69GRWcXZujDEwMbDz07b
 zVlH0ISNpCPW5uTKNiPEmSo8547Uw2tVFFX5vfdHnI+Agrkm0B6HRuoE137w8+rhzQgQ
 DWCCTLVUjP9TfJLO7O94L1VrjpPIUiHGp5qn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720219220; x=1720824020;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=//rnqDLUX+P9mgUV89BuTlJHRU8tqMHI1rk2w3Vn9Tk=;
 b=e62HBp2vxBnSoEYCAXIfjPD0v2SBg7p96l4wfMvAacLfiHQpEVIQHcYSnLsgQaFSIM
 ypOR4r2lrbW9i2dAG/581lE5EdGoYoYUcLQLvvlUYASa399HXeWsoDqm454FLS8UDX6j
 jq3neqyA5D+FeMiUPcB3pSNzHIBvxRba5MxCzOukhnKKWaVTJ6heWkb9AeLspNLSBvcs
 73iQ969KnGunUBsKkVHREMCAirILhFyY2PcrHRrAHzRXePmJPZEzvE/wTs6/iY3vIDQ4
 UIELD7mXvX+WPR/m/0RYwUHIG1niND9JX4zCPvsCUcA30QJfOk0t1FH1JFcRH6FlKQl7
 O9mw==
X-Gm-Message-State: AOJu0YxiNoR1rk88aNEUB/2gO94f1EH9khis2PfzcIxjM0ts8L0+l1VL
 QHhg/GDLy3RS69gVMyhiO7284HDArDzOIN5kJSAiXEBWnKhzR38XvjMb83osTq7yvYR1rof3fuH
 RyXpa2w==
X-Google-Smtp-Source: AGHT+IHwpA2ms3h+Nn4p3kjjO5EcRGHU10SRGZi0dK9kslac5D0EQOQV7H/cqiDGqrPWqpdGfCUkpA==
X-Received: by 2002:a9d:76c6:0:b0:701:b765:ad75 with SMTP id
 46e09a7af769-7034a81a113mr6553515a34.33.1720219220151; 
 Fri, 05 Jul 2024 15:40:20 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-45.totalplay.net.
 [189.203.97.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-702292a18b8sm969174a34.36.2024.07.05.15.40.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 15:40:19 -0700 (PDT)
Date: Fri, 5 Jul 2024 16:40:17 -0600
From: Tom Rini <trini@konsulko.com>
To: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] pci_ids: fix i225 unprogrammed value
Message-ID: <20240705224017.GX38804@bill-the-cat>
References: <20240624194907.81341-1-marjolaine.amate@odyssee-systemes.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RcCS0LWswnZYnoJs"
Content-Disposition: inline
In-Reply-To: <20240624194907.81341-1-marjolaine.amate@odyssee-systemes.fr>
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


--RcCS0LWswnZYnoJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 07:49:07PM +0000, Marjolaine Amate wrote:

> This patch fixes the I225 hardware default value
> at 0x15FD meaning empty flash image
> or the NVM configuration loading failed
>=20
> Signed-off-by: Marjolaine Amate <marjolaine.amate@odyssee-systemes.fr>

Applied to u-boot/master, thanks!

--=20
Tom

--RcCS0LWswnZYnoJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaIdlEACgkQFHw5/5Y0
tyxiCAv/eWC+yUBx/hjh/Zs8V+f0HiKxMsMI/UjgxZSwFlhg1zzxNtT7JAy5PJfe
/acupRoewcM49Q9S5yUZpm+fzzw4zA+YRPyNi6IrZ1CH1lJDy4pTo8YVTjQb9wA4
HLneqicy7hCkQ/6yoWmsF9eaiReiK00L3vgNXrvbyifWcRQ41KL5eAUm2jvXz+QW
+kaxiGs98uNx2kFNLNCuZt2L0NOSLqvIDHjsl4DtEPy5F5x9+n6sh3nQEdp3v4l5
CbpDZQHlvzYR6qa2yzlYtcOVtD/uGuNx0dcycrSvHnUFg58VeM+gkWPk9liTFDOY
LlwNkGAw0t0+Voh/MKq2M4D39Gi0R99TWj3gVHs58/L+X/1MnuBEg2JtjmMJeVlH
s1aPLla2NZgBfcTfwx1rDlzsVX7uXvkDq1TJtBVSxi/yqVyI/qNSAhv0edaddg63
nf0D92ZtB2d+rSGouH+2liArgxfGT18cPuUdQIHJqkbwzlkD0cP4Rfgi8XkdOO9t
OxpxwdId
=CQ2g
-----END PGP SIGNATURE-----

--RcCS0LWswnZYnoJs--
