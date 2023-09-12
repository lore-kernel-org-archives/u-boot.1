Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2821CA0EF1
	for <u-boot@archiver.kernel.org>; Tue, 12 Sep 2023 15:17:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CDAC86FD1;
	Tue, 12 Sep 2023 17:17:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BwMFy42p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF5B486F9F; Tue, 12 Sep 2023 17:17:21 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F19F786F63
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 17:17:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-59b4ec8d9c1so49351917b3.0
 for <u-boot@lists.denx.de>; Tue, 12 Sep 2023 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694531837; x=1695136637; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WNNOOEQFLG5XsK3w542k/5EzNqypAkNunOi9dH7S4nQ=;
 b=BwMFy42pIUdcjkKe5FCqSabsrMu9b06XGtjm73xbc6uSMMT1YEP/TCKujsagp9cSW1
 /T6v5EcUhtZBL7/48cipkIUsyEM+ab/c8wum6Mvjm7yHKzIBHVuYlzzt5lPVmRjGLR6N
 D4c5TZzEIwzK1oJeI19n1eU0mBYojCxGXOuzU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694531837; x=1695136637;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNNOOEQFLG5XsK3w542k/5EzNqypAkNunOi9dH7S4nQ=;
 b=R1EavntjzU5CvfvvCs4i9eypeH25ukdQFTH4/PMfZrtPHJh9MkKm/iZOyiUybiVw3D
 t01/vbqzap7+JzvzrNOECfKP5cP+0Pm5Xc4bvBlR2q64s6xrkslU1UBxzjrJk2NyVXWW
 6SsDyGH15r1CEVY5y32aoLKDoKqoDesvvfr6TFrxQHcWelbV8M/dK3TpCrgnSTgav/my
 tNNaOnX7zc43UzT3OwulK87tC01UiJPhYSXy7oTn2g9H6RwKLr//3xQah3V675C6D8rv
 D3VP1U1iiJex2YLj05ol4udmaCZAAB9V1Pv5sh6Y6tNjXYtdsnjhNascnjVOByEBcZ4G
 KkQA==
X-Gm-Message-State: AOJu0Yy0QwSI47qjFThLAECfbPeOIJh5ESaXzdAEcfX54HDPpTgdJLcT
 5ScYkj/j+ggcWngOYkpWBQ93iA==
X-Google-Smtp-Source: AGHT+IE0ZDMliELZjyWpVjAYkZzPC/Jt+wXYvO8lwfjRFwuT8djywYxr9Cvr0eGZ+qAiF6Tdec61Rg==
X-Received: by 2002:a81:470a:0:b0:592:4f93:e831 with SMTP id
 u10-20020a81470a000000b005924f93e831mr13380726ywa.48.1694531837710; 
 Tue, 12 Sep 2023 08:17:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6b32-7765-b6af-dc55.res6.spectrum.com.
 [2603:6081:7b00:6400:6b32:7765:b6af:dc55])
 by smtp.gmail.com with ESMTPSA id
 p139-20020a0de691000000b005865494000dsm2606455ywe.115.2023.09.12.08.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 08:17:17 -0700 (PDT)
Date: Tue, 12 Sep 2023 11:17:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Joshua Watt <jpewhacker@gmail.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 1/4] part: rename disk_partition_type_uuid()
Message-ID: <20230912151715.GH305624@bill-the-cat>
References: <20230902073524.87451-1-heinrich.schuchardt@canonical.com>
 <20230902073524.87451-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5+nEBVS583aFWIE8"
Content-Disposition: inline
In-Reply-To: <20230902073524.87451-2-heinrich.schuchardt@canonical.com>
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


--5+nEBVS583aFWIE8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 02, 2023 at 09:35:21AM +0200, Heinrich Schuchardt wrote:

> Rename disk_partition_type_uuid to disk_partition_type_guid.
>=20
> Provide function descriptions for the getter and setter.
>=20
> Fixes: bcd645428c34 ("part: Add accessors for struct disk_partition type_=
uuid")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

For the series, applied to u-boot/next, thanks!

--=20
Tom

--5+nEBVS583aFWIE8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUAgPsACgkQFHw5/5Y0
tywRZAv/WnxDVCA8AS9d+7S8VdieuQbjAm/bKvXJ3IVRS6PSt9IqM40jllMCfgpF
r4F1szh4y1Z7zVCBWwD6bmZo8/INFcxGeH+TONSJn9gPxoTEmcu/DFdbZOX+jDVw
E3GVDtiPME1630J7J/10Jv4KcuMM+QVNjmqi6+52B7IS6kJGEHCEao60cPabMMhE
LktDaIcFcV9EtUgRCELAupRpOj6MiyTRPNoZEr3492FO1G9lQRhqEGVn+NSQbsK+
I/ByKSr4K4R+XPAKVOYEHNMhBc6lyD+bM/WZJoYIUsZQzUoB+JtSzS+y8s8u8uMx
ueEvhJFsWc1I6VrlDsVNlkpIESdAANBuqpdeiqFWRP7BAeJAzoYu62xWJyq1Pxo8
7smElshftEs7yTwdT5pph/hLYqX3rhW6FCRszU8SMN5VK8cSQiN/f8njP8WkIQbQ
azPxZ4Luhk2WGj1uPX6Ry8sEtfwkykuX1n1U6e/yvK5ftsF2dCHMjgjGTlfzxWcd
jUIRuUvW
=/Spz
-----END PGP SIGNATURE-----

--5+nEBVS583aFWIE8--
