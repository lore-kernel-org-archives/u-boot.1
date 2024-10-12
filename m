Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E49D0EE1C
	for <u-boot@archiver.kernel.org>; Sat, 12 Oct 2024 01:33:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EA1F88B9F;
	Sat, 12 Oct 2024 03:33:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="j+ggxnEH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A240D88DCC; Sat, 12 Oct 2024 03:33:19 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 88BF188B64
 for <u-boot@lists.denx.de>; Sat, 12 Oct 2024 03:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-7b113cd6d0aso234789585a.2
 for <u-boot@lists.denx.de>; Fri, 11 Oct 2024 18:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728696796; x=1729301596; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oox0FNm1OttdXDi8FBmS61lVja2QI1sqg0W5DIiPnSs=;
 b=j+ggxnEHcj9eObgTMz7UWA35GnvPWW8Rfivob3QkUYi+S/kj2LUUxc60Irg8qi+o0B
 DtE721p++yvVXAPDdK2LUx1fZjudQbiMm5b6aUXXVNR3StBAlubo78ey+RX6gIe/vF4Z
 qEGn5tObqOkktFtEMjCidr780e+ohHCTe9jMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728696796; x=1729301596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oox0FNm1OttdXDi8FBmS61lVja2QI1sqg0W5DIiPnSs=;
 b=mPuzu5l8e/ZAcMH+IcyHWfstZeMRxTk1eGOANQl7+GamGPxNbVq8bgFJMEjWqaQjG/
 ufX/5E+f5bIHAdWZ1eryR9JabD+C6Ij8BvqlAKW2W8O2wgZV5lHo5vrcT98/fpSZYVOs
 QXJ+OTtWquh/vsQJrMvXG2h49gcBjD5ITnvrBJanKMEYCm5dWK+bjTX+nhNEDQKL4k6Z
 JwdrQBzcymMWIf2vuikAluuyq0gDYF4Vk6YwStfO7exgNiyY8k5JU12kbAl0Il63lFeX
 eAhOn1zeAi3xOYjCS1k36rr3MR7f1jskhVSu24mE5G9ou/3blImdkdnvzAsZQUv6h9Eh
 tOmQ==
X-Gm-Message-State: AOJu0Ywj+pyJ5Q3/0D0tHFkpYNR2cNYM+fg1bFNIwwXklp81WQNaR1Qo
 oAtr/m01uEX+uyVfEyctZxr3rNAe740tcQYJwy9C+W2dsc094a78DAtY17EyW1U=
X-Google-Smtp-Source: AGHT+IGGfUDU/mMKirW8CRHFBq4JmDdHXJksNXzmZNGS1ZTEIQVfKgN+ih1rDNZKACPcp2HbUYnglg==
X-Received: by 2002:a05:620a:7209:b0:7b1:14ee:2967 with SMTP id
 af79cd13be357-7b11a3a220emr716994685a.46.1728696796264; 
 Fri, 11 Oct 2024 18:33:16 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4604287dfcbsm20897601cf.77.2024.10.11.18.33.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 18:33:15 -0700 (PDT)
Date: Fri, 11 Oct 2024 19:33:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH v2 2/7] common: Tidy up how malloc() is inited
Message-ID: <20241012013311.GF14210@bill-the-cat>
References: <20241011214032.760072-1-sjg@chromium.org>
 <20241011214032.760072-3-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vW1VD6N7vukEqhlw"
Content-Disposition: inline
In-Reply-To: <20241011214032.760072-3-sjg@chromium.org>
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


--vW1VD6N7vukEqhlw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 03:40:26PM -0600, Simon Glass wrote:

> The call to malloc() is a bit strange. The naming of the arguments
> suggests that an address is passed, but in fact it is a pointer, at
> least in the board_init_r() function and SPL equivalent.
>=20
> Update it to work as described. Add a function comment as well.
>=20
> Note that this does adjustment does not extend into the malloc()
> implementation itself, apart from changing mem_malloc_init(), since
> there are lots of casts and pointers and integers are used
> interchangeably.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vW1VD6N7vukEqhlw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcJ0dcACgkQFHw5/5Y0
tyx7bwwAnvIe8++S7LhQqR1pHpeRdYU0c1zmUwVkQhOOoCMNvgNnOfHGgD+VtRj+
Cqm22VfQkrLa+s2qzHJMA5uBs2tYA+EDGE9jz9wFuZg213rZkXLs8b38V7dhNkpb
Evsa1aROzFG8n4xHuXDmW5Zj8gAeRWXM0YJevhZP8K/vJNdzMI+64hMVVLrvUHGk
crD+ONWm74eRLCJnd08UbT7cSGWPamFB+ZMOZ5qEqcHaDsVXxP0fSG+HGvdarloW
KlBx3zRb8lRCfHfnwMQJcieJjuOuxcrV8K+ecITLuy5TF+1pJFBT19D+1BDgMcSp
NCBRFejkvSP7QDPMdMRS/+e0LsznAMP1L/lJ2oq5jGKMsgER2JfjDnCnAaDFwsqc
tKG53JaFHgCJTa9FXAlc4szg8U/FuxJZshJkE5xtEInRN5dPLUBZPwqDlhMnBxLa
XMlrBhWh4B4qi6pVdayMT/nnrJcUAFjjiQCoIWq1IGcAHmuXh8XFDH+d1u2ebzYn
x/3qtd4Q
=dVwE
-----END PGP SIGNATURE-----

--vW1VD6N7vukEqhlw--
