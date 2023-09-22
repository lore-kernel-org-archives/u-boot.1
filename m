Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BC6CE7A81
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 22:27:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8FB486B34;
	Sat, 23 Sep 2023 00:26:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="bDklLePC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4261986B5E; Sat, 23 Sep 2023 00:26:55 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4471B86B57
 for <u-boot@lists.denx.de>; Sat, 23 Sep 2023 00:26:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d81b42a3108so3375409276.1
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1695421612; x=1696026412; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=935eJXOtqf6+E0TWdE/pVNU8GdlhgnLWswCxtKoEeIU=;
 b=bDklLePCSJZtYgmSaZyCwmM5Mf8oLIUEzsHD/UgU69evxSl1nf2q499RVoVMY2yNvN
 yaHdjJNY/0uZXL+qzBhuW4CHSDYbGoEhXLQibdkwWoFN2O12Vs96jqCvTMoN7I10crTO
 7q/R5hCHKY3D1g16pC7xv8WF1pZe/yPWGkT+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695421612; x=1696026412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=935eJXOtqf6+E0TWdE/pVNU8GdlhgnLWswCxtKoEeIU=;
 b=vapH0Evwe7mcd1BtNFJFtS7oBp55qGJ/F+Cxr5zfSDJ5FInteZsjYnnjqhYu4gETGh
 mvWtqovzI+U2OePJ9TtEYWqRQDxcLr1amBVKq6dyEOhBjl7AKfhrhN1iLMndxMY/qiA5
 e5DBed+b0XeA9EuEsnemvOd9kx1k0oTSQwM/uNtZ3KoivrlB84Ye3ARY6MYB8tf1GljR
 zp6O//BK7saWSDN1hP/LcpC5gK8XgQncpmYlaSNnCKdl+X9dwUWipa4bUG3e0ZmArooY
 lyDFBtBTRVPb0nazh7TBc3YQTsKp6J96Ss8x3sUSQg4ewGi6k5hxoTFNEMWK9OZwsnDw
 Glgw==
X-Gm-Message-State: AOJu0YzKwzLMkiZ3S6fkmTe2VAoLlq+vmn5qZdoFGvI/IdkeSGj6b+g8
 fL0M00x0tSYml3uKMOywK2As8w==
X-Google-Smtp-Source: AGHT+IGieHBARta1MkW0qekdINdBo21kXQtqHcKq2trf+SCa+X9qJVPJjsO3Yv4xCJmcFidhqsh7Nw==
X-Received: by 2002:a0d:cad6:0:b0:586:a68b:4c9a with SMTP id
 m205-20020a0dcad6000000b00586a68b4c9amr956483ywd.2.1695421611997; 
 Fri, 22 Sep 2023 15:26:51 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-c83a-32d9-8f81-ed72.res6.spectrum.com.
 [2603:6081:7b00:6400:c83a:32d9:8f81:ed72])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a0ddb0b000000b0058419c57c66sm1123352ywe.4.2023.09.22.15.26.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 15:26:51 -0700 (PDT)
Date: Fri, 22 Sep 2023 18:26:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Francois Berder <fberder@outlook.fr>
Cc: u-boot@lists.denx.de, hs@denx.de, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com
Subject: Re: [PATCH] drivers: mediatek: Fix error handling in
 mtk_i2c_do_transfer
Message-ID: <20230922222649.GH305624@bill-the-cat>
References: <AM7P191MB06955AC8974FA0226ED937A5DAEDA@AM7P191MB0695.EURP191.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="M+cQhP0OE4dN2LMR"
Content-Disposition: inline
In-Reply-To: <AM7P191MB06955AC8974FA0226ED937A5DAEDA@AM7P191MB0695.EURP191.PROD.OUTLOOK.COM>
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


--M+cQhP0OE4dN2LMR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 08, 2023 at 06:47:46PM +0200, Francois Berder wrote:

> Errors were handled only if an I2C transfer timed out
> and received a NACK which is very unlikely. This commit
> changes the condition such that errors are handled if
> an I2C transfer times out or received a NACK.
>=20
> Signed-off-by: Francois Berder <fberder@outlook.fr>
> Reviewed-by: Heiko Schocher <hs@denx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--M+cQhP0OE4dN2LMR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUOFKkACgkQFHw5/5Y0
tyzOWAv/eOJOjIzMq3lcQpV1RZ8Rbo6w+iSShecCuLn/p5y9Ozh6tdnEB1gjJs7H
8aap1hqyNBoXmuHHfJtlNo0GtRHzo48l3ewyAUgpuFu2rwDey/o0TW5uu8jfOWDN
XbzPiptbJF4lRLVB/Q1ia6kNOoxb71QFo6FynV6i+LfWc5N/34AOpBudWxBpXKRY
2zw2BmKdWPOxcZNtgz/7P8Hc+USNhO9YTW+GIqElGmGV/OigC5/UTzxns2OaWg2t
FBW6dA4HCEkF1uW5BR1K/9Jvn9ndqGvopUHFxR1+UFGJO7NoQfHnSx+oBrAa1Gij
q/aQxleXIm/Re2sZJgVgR81R77G6xSZQWKbIZTHtXRNvNr+S+kSpe8hmxmGvu3dL
zgX4XFRIWvP4hF4M1EVxe6woJrcrPngxLb0EmeCAy73NS2QHzyFa/zM70KWVYs7+
VcI+EbnSyy6pQlmLgRzRhh86RWDSsQ+Fpp7RCjsLBqaCeVyBb7c1VYDgjesFzGdb
mFrjKlQm
=ZyJ5
-----END PGP SIGNATURE-----

--M+cQhP0OE4dN2LMR--
