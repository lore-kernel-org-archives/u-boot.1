Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2EF9C982ED
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 20:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 39AB680D85;
	Mon, 21 Sep 2026 20:33:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mg--_fpA7uBy; Mon, 21 Sep 2026 20:33:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 7871C80D36
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790022804;
	b=j/Tk/NpimBarzB7zMwd9swwCe5nVajlwFHsgZsmKJSdVNkoifnGcDJRrTi6YJcbcNaRJ
	 fYrPF0giI82yGOaKkVnWjjL7cfN5NG3CBni2nTyYY6KXl3H8gp6EqI3Bo9nXf1SZEjPFh
	 yOaOuCEXWh5AHDjEIkarRY8oc90vyTPfU3Bf+GcoJgCy/mTSwgUzgmiS6ELDoGFCVbtFQ
	 IWuanVVEzpjVI/xr8PNr1LIQY8nrIdeNckfWNpqxNudrhmVqO9e3MTUx6PZEjZYtd3s8U
	 hOYv9GjYXOwlN5X9D5BvKkOSU/uHvbZz6jg4JkhB0/IrbbSmnAAWgkyVYPduWWKDjKw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790022804;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=cz7wa/9Tl/OnUA76z/I/cd6O4BseVWYieZuftrRooIQ=;
	b=jfRjluYwiqmYnG6GWKkm5K9zidQ3Cn8iNGqVSm01piX8JEeYruEUj4Q2CKQfjM/xvS9J
	 FGrzrflH57Bg4ce+36znWzFO+M31LFrJZg00xnM3fewTivKoQ8b5JO5xF+dOq4l5NlM7t
	 OGfzv+nfO/NDnC9UyvTFyPinMVIGtpU6w7eo1VcFYTMHgBoeBiqycQOL72atPiqaQORUV
	 Y8Z4+M+L5F4pXFY5kVbJharCrwSotFre7BZ4J5R9H4oULGK1GZGhP+otUktrJk2PINae0
	 kNUKGeQbKKzf7yBR5SAkAIig6o89BvMRF59nNz3dMjX8o8o81MZOkZ8li06GEc/Pk9w==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=RObMaL0K;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790022804;
	bh=cz7wa/9Tl/OnUA76z/I/cd6O4BseVWYieZuftrRooIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UCaiZVqkvtFCs7V7WWd5TDWlfiS8A4xf2icSrJjhpaHIDUkeA7PSj9+pra+XnyDMw
	 7nksartGmUnCIFIhWNcpmylxnwJ9q4B4Pfqu2cINFqhjLBuoRLvT2i6vFZKGF/NgUr
	 1CbPLMTsRbG1C6JK8LuBcCrN+eGT7DZ1a17bgb4h1DzZtYPum6Ndse6QREKFPvCHOF
	 /l629pByPhtx1AHwnSIYNvft9OCu1LxAx4QXhSl+xrfpRF1z30Eq/FgWAzAjMDfR5k
	 arrmDNPzlUciNCCdq3gLIWhLgUz3+MksSWObOFVNU8H1Rp5l/qDpCRS0pNp1QxkHcq
	 VczWxrrmzEcrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7871C80D36;
	Mon, 21 Sep 2026 20:33:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id DFC4B224
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:33:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD2D880D21
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:33:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YniOUrC6-Ytl for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 20:33:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EB44380D36
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=74.125.231.76
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790022803;
 b=Ok4penTesSf4GxbkHoJpf7wMaLb905QnojXS4eTK2qDVEflI4V5syyHHdusTJwVH2VMA
 oZJPKCjEsw3KCWki4KnuWqbShllWofat4KkSI+9Rf1W9MwGM66MTZV5XC5X+prP7QXqEt
 GGi0DWXmhWOrMOLa6YncKpzwk41CzdSg25X3fZcIVqJbzVjvLMV8zHsn3QQ5zv1SYDyko
 YsUxrIEMTA/guTA1qcKpE32Pd/AcfB9ntEb8KL7D8727FlDu8b/zYcFVdkz607zfpvuur
 9c5eXGBxGy8EW5olCPEw2MmhWqFaEBzlDLygVqe34wzhp+4c2hgc0RrUVF8g0G7SA8g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790022803;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=cz7wa/9Tl/OnUA76z/I/cd6O4BseVWYieZuftrRooIQ=;
 b=CoVD7Qdt9OxqmW9MyvpBmo27+EfVffIPdrIdADMAHlx1JFx9ukvK0cep1OtYNXHKuVpf
 TEjw1MWVM1gPCC0UoyudI7LnTCduqBFD/ZgiTsKjXjbBQeVUj8pFYJD49AlHXprFc/cm7
 JLf5BRMFyHEcuQjlezxvJdh0wV4G4spRG8q9VtVw76wwEQDoJLHIJl6iKdnXBhCKhiGp5
 jgrOc3VrKyXigvSx7Gb9DWpc4J/y4EJgoT0tnRlBicQ7djtphI+RwRFBVVGENI9JQMacd
 q9kOpo7hCW49RBUVzKdt/8URPcquyfMMtvHDdkzcf6ciPoh1OLzV5xN7CIhZxErvVbg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RObMaL0K; 
 arc=none smtp.remote-ip=74.125.231.76
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=74.125.231.76;
 helo=mail-oa2-f12.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=RObMaL0K
Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com
 [74.125.231.76])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EB44380D36
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 20:33:22 +0000 (UTC)
Received: by mail-oa2-f12.google.com with SMTP id
 586e51a60fabf-46accbdfc20so2757696fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 13:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790022781; x=1790627581;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cz7wa/9Tl/OnUA76z/I/cd6O4BseVWYieZuftrRooIQ=;
 b=RObMaL0KAuz/l8y+XRGbgEeEY8Ylmru3aMlq8w6eOYkMmfSduJXlSsh6fxl8kBMIGZ
 9zM0KhqoZU/ONd1l0CPBw2UVHzFHwND7P2FpL25VUmdjanJZPeKOi4gW7Ur/MenaCWPV
 CVKwCImAYRaFDjbLRNWAxqLrr6zhd2sDi4hVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790022781; x=1790627581;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cz7wa/9Tl/OnUA76z/I/cd6O4BseVWYieZuftrRooIQ=;
 b=AXPuyoom6YyV8KJ0ibZzYJu2oOalgVE5z7u6Oyc4vASY+4ycPy856qqhckbqCV02SA
 1lMgQ7n9YMEa5gJbd5vV3/B8rxnLF5yb0A37wv4rPVrLOpLrI31OeLYMa6bcjEnudd+H
 t7pZwSCj4bJEei0ajXQQq+8BgCsQzLoiaMpBnWDtOvTnWsaiH6xfitRCKya12PbWQqdD
 FDO2GUamWyViKcGJjz04K+hUqvE76fGEGQIHe7O5zFbrhW50IrEDDgZmRI3zvSiH9m1l
 AZxKzG26YKMs8Z8shDqR/TULslqGo1gOjyR+wyoMjf2atL64juxvrE1vPINMNAsWdcLU
 ANFA==
X-Gm-Message-State: AFuF++lYGhaq+IJo7fxxiKKAODIJFJlaM84pj1DYrACdYV5Ruy4dSfNt
 HobzjPOCl9JtKeKxcoTjbh06rq6Xdx7l7W6Fs4IWoZFpsU7xcjIsSa4sabMUMFSmSE8=
X-Gm-Gg: AYBFou2CPWFqCWCPYH9JmKcOenJQTTGSEqWoQtZa1P77WlOdVv1zWNCl/lt6qwpmRGW
 V14w5g3rCYg/+jtI/MZKqffHsjVrs54vkr3Db5l3fAg3L9P+CsGs4UnAAf5wLYtTEFychn0vAPU
 FAlFwr56p7+uOYI1894NfI1wtv5yygnHpqUKVbTOVdZwK83Ww3t/pUl33X9Vrg1mXm0dLfOXDtZ
 9Es90L9NFaPg8nLmDCcSq2MdT0RiYN3bwH7zAyOcSM6E5M1XeBup/2PRt82ETZQXU4V5v6HIp9L
 cccI/wO79UjrbWEUj0pXIYnmudebuzJbvrp/HbcQQPveaVKLcvShSpm+mEgb8gYQ+jba6zRAenu
 7aC7weL0gPw05BLvRCffoRSiEI5U35/5EWP9hlEfzkGDOGQlNVeuPpMc/1gyu13UtOhuQLXSVpe
 Sy1/TMeB5glG/Zv5+JWheXbMauvbJElQeKwtCJFnfaciqbeUnkhwMQZam4z4tebUpRFCmmcxzmb
 iM+9/STEMNhMwK7WT6FUHNDEaYnKmqtldBNPKX5DkE0ISAVkje56fkMp8JvXjE/KV576aqjghzP
 5ubX3t4t2kAgdY348aFsuXp63PTglg==
X-Received: by 2002:a05:6870:c221:b0:457:b657:b084 with SMTP id
 586e51a60fabf-486e6de37c4mr11961896fac.18.1790022781619; 
 Mon, 21 Sep 2026 13:33:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48f6ce755e5sm221990fac.0.2026.09.21.13.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 13:33:00 -0700 (PDT)
Date: Mon, 21 Sep 2026 14:32:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: u-boot@lists.u-boot-project.org, uboot-stm32@st-md-mailman.stormreply.com,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Alexey Charkov <alchark@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 =?iso-8859-1?Q?Jo=E3o?= Marcos Costa <joaomarcos.costa@bootlin.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v3 1/2] spl: mmc: select the boot partition after device
 initialization
Message-ID: <20260921203257.GD858934@bill-the-cat>
References: <20260914-ccaione-upstream-part-dynamic-v3-0-a38c19e74563@baylibre.com>
 <20260914-ccaione-upstream-part-dynamic-v3-1-a38c19e74563@baylibre.com>
 <20260914163557.GA1764417@bill-the-cat> <aqhe4KnMjO2HQiDA@macbook>
 <20260914213307.GJ1764417@bill-the-cat>
 <arGNB4QpzpkZPfib@macbook.homenet.telecomitalia.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2Gf/CVmtAl8oJrUA"
Content-Disposition: inline
In-Reply-To: <arGNB4QpzpkZPfib@macbook.homenet.telecomitalia.it>
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


--2Gf/CVmtAl8oJrUA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 21, 2026 at 10:05:15PM +0200, Carlo Caione wrote:
> On Mon, Sep 14, 2026 at 15:33:07 +0100, Tom Rini wrote:
>=20
> [...]
> > Reviewed-by: Tom Rini <trini@konsulko.com>
>=20
> Hi Tom,
> who should pick this up?

I think I handed this to Peng in patchwork, for the MMC tree.

--=20
Tom

--2Gf/CVmtAl8oJrUA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarGUeQAKCRAr4qD1Cr/k
CkHsAP0fqJWCFB4bQvIxPRnrXlEijKLx37o0VFnUOpVhtd86OgD+Jb4l4ZvrbE72
HfyldH2xEaw/56A4DfjVpREtBZePgg0=
=qmyt
-----END PGP SIGNATURE-----

--2Gf/CVmtAl8oJrUA--
