Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37E5C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 23:06:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3661878F6;
	Thu, 14 Dec 2023 00:05:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C+k76jfu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371A3878F1; Thu, 14 Dec 2023 00:05:58 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7945878F1
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 00:05:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e2b8f480b3so467467b3.0
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 15:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702508754; x=1703113554; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HNwqt/CWDhX/3S02pHLa8SIVzOzMS/9escppQCCB6/A=;
 b=C+k76jfu474xPf/xJWsJpKdI36TaoYq+Ece/v3N097Um+hv7gOKenbkW8pH85qmj8b
 nS7tFq5pfoBo1ABUCI63x+LtApxbPIrct4EBjTys1pdr6Jxr1hD256kdhlmRcOnbj8Z7
 OL39Lsg256zihQe0FfBuUgiBymdhwo9oxEX7c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702508754; x=1703113554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HNwqt/CWDhX/3S02pHLa8SIVzOzMS/9escppQCCB6/A=;
 b=KGqhSR5TC22vWY7ms75fkg6aapbDIiJszdo/ovc1nZn66Av7ME6g+qet1C58waSoUC
 zB3KNiPgUsjsFSiCKS/JBR6sll+nUf9MpYNu0iNorS9DynFBMylO29oFfv9pUn6K08TT
 I66Ct+aE8kgew8bbsjOB/CYNiD532WGmMyFsGNOBgD+It804DNcWx/dUs2jk1mT9VlBW
 lmDrN6OToP5doMz1ACfzwZPFvQCOXYSByTg+dHQTm/6vyG9lF6VF3h7jmCI1U/8c9DA7
 YZWi8upIb5MxLX0q/zEpqSyb64sNARaHoTFNdw9F+GJF6A0pd4Uq8nY0nJKSGDYbVQob
 zPEQ==
X-Gm-Message-State: AOJu0YxpSlEjVG+4MZt/dm+aRDBtdUK0wVasV7cciOdN5sOfTbKV9KC0
 yO3q/7cnUj+5R4UdloeFRP+SublDnKX5qkzJjmA=
X-Google-Smtp-Source: AGHT+IG0lXhYiSsgv25HaMctoT3o44cJactpj3PjgCdz1dNzK8SnTE5dwwc82MxhCHhLx2Nh775CHQ==
X-Received: by 2002:a0d:f607:0:b0:5d8:cb1e:f316 with SMTP id
 g7-20020a0df607000000b005d8cb1ef316mr6565408ywf.41.1702508754174; 
 Wed, 13 Dec 2023 15:05:54 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 c85-20020a814e58000000b005e303826838sm624667ywb.56.2023.12.13.15.05.53
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Dec 2023 15:05:53 -0800 (PST)
Date: Wed, 13 Dec 2023 18:05:51 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH] lib/Kconfig: Correct typo about SYSINFO_SMBIOS in help
 message
Message-ID: <20231213230551.GN2513409@bill-the-cat>
References: <20231120201723.619989-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/HHcBsw8sBcHtN20"
Content-Disposition: inline
In-Reply-To: <20231120201723.619989-1-trini@konsulko.com>
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


--/HHcBsw8sBcHtN20
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 03:17:23PM -0500, Tom Rini wrote:

> The correct symbol to enable to have SMBIOS populate fields based on the
> device tree is SYSINFO_SMBIOS and not SMBIOS_SYSINFO.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--/HHcBsw8sBcHtN20
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV6OM8ACgkQFHw5/5Y0
tyz8GAv/VZw7EGECoNQgHpiQbiMyIS8XrdxAYB5YddOVyAQ/q0woYpZOti5XYFOq
oCC0609pT7t6QLUv4cvMkS+BwxupNkfb3We9cBEOHCLGahfkdGet1zAydcLbuQrz
gNH1yPCmRabYf1eDQTGLH5Qc3g6MgZVMc+H7EVR35Yi6cYJc/mky3X4thK+4tHGt
NDM9T2tIz2oEc3dbmByryCJpIf8e/24PaRKcQdnw1abrXUwzVl3sT3TXo6l9L31V
eaYKBsj5819NV+wKgVm23VIlsPxMM1XpWIAV48hRlM4OE0sS/uvfSSYqg7MRZv+r
CrBmsdctSX4N8EGEqQdma+AsnDELGcY+7b9MddnL8ZVSZTAavipXGTA5bodIjGtX
K92ud2stokf2V6HT2TPvR7+SQywaW0AhWSxpABr09sHHbjdG5QSy7jSif+RpwMcj
cUcIKPXiL7RgnnRSe/ni3mJSqlJEiAQXcTM5ua65npwycIeagtx6OyulQIRlSnCg
nvjryOUK
=7PLX
-----END PGP SIGNATURE-----

--/HHcBsw8sBcHtN20--
