Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB1FC27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:54:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E74786433;
	Thu, 24 Aug 2023 15:54:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Kl9o9kAS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3B3486504; Thu, 24 Aug 2023 15:54:47 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0A19863F6
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:54:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-58fc4eaa04fso54827167b3.0
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 06:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692885284; x=1693490084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=33zFg+ISerCZc7+YXTKT5VtdiqdXHxCAxIe5saMFIYI=;
 b=Kl9o9kASXWhPDcXEvGlnNzXGD8GC9N90eOYeUx0jyGSrFqwKtdkjTDNCaiHbcKfDRa
 SCQF4LHVCzO0spnZQ7DO0+CkNtpMvDU2+giDW7M45HtUBRb8Yb9ZpY/sBYmUCMRf2c0C
 i+QCKAxQG6A2toEL3H62tuoVG0nAzedifHnZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692885284; x=1693490084;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33zFg+ISerCZc7+YXTKT5VtdiqdXHxCAxIe5saMFIYI=;
 b=fs14lWuWOTmPbn+0jKOzOPcbUZgQKeCC9Sx5UuoVGvS3MgJhti7ypgWQSLFlcbM+y5
 xsFyNGohsskwxR/2BPW6W3fhY8ppA8w3kH5DevKz5huX0aVLQazuW+MiyZKdNf0A450s
 uyWvqzhqZsz/y1xNW4OUZSaXhCa2NddycMCN8W/fV7dZPcMJuRXejwI95VbR/yLdLLgS
 Mr/c1c0kgcKS6XkMOdiU2bN+Dh4ydGaYvDEbNKlDyuHD0hJhX5aJbxzC7/QXUAu1kQAg
 fW2WdwLiKGIlSFWDeuSzfdDs2FPfmymfu4lCMbDOr6MSK1nR1sA31jEtBOgvpITBlkQO
 laRg==
X-Gm-Message-State: AOJu0YwZC6B6+9jr6VTMpXmYB3En8Gvvs2e1uK39i/r4YXEd1k+mfe6C
 wpb7T8m/PygeLz3N43zYA1Rt6g==
X-Google-Smtp-Source: AGHT+IHWm5a8wTuUzVYE1zFbDoM7jy+VkZoKs/lnauKmnb6S/D/F0xjAiwQnTDwetjHqH+wMEnfwuQ==
X-Received: by 2002:a81:4a56:0:b0:592:5def:5c03 with SMTP id
 x83-20020a814a56000000b005925def5c03mr5176866ywa.22.1692885283761; 
 Thu, 24 Aug 2023 06:54:43 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 w12-20020a0dd40c000000b005463e45458bsm3953158ywd.123.2023.08.24.06.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 06:54:43 -0700 (PDT)
Date: Thu, 24 Aug 2023 09:54:41 -0400
From: Tom Rini <trini@konsulko.com>
To: Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Michael Walle <michael@walle.cc>, u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS: remove Vikas Manocha
Message-ID: <20230824135441.GJ3953269@bill-the-cat>
References: <20230824074436.2929639-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/UdwykLl+gZH4Fdk"
Content-Disposition: inline
In-Reply-To: <20230824074436.2929639-1-michael@walle.cc>
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


--/UdwykLl+gZH4Fdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 09:44:36AM +0200, Michael Walle wrote:

> The mails are bouncing with
>   550 5.1.1 User Unknown (in reply to RCPT TO command)
>=20
> Remove the entry and mark the ARM STM STV0991 arch as Orphan.
>=20
> Signed-off-by: Michael Walle <michael@walle.cc>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> CCing other ST people, maybe someone want to take over instead.
> ---
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 84de9de531..57ede4bea9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -641,8 +641,7 @@ N:	stm32
> =20
> =20
>  ARM STM STV0991
> -M:	Vikas Manocha <vikas.manocha@st.com>
> -S:	Maintained
> +S:	Orphan
>  F:	arch/arm/cpu/armv7/stv0991/
>  F:	arch/arm/include/asm/arch-stv0991/

This misses board/st/stv0991/MAINTAINERS where he's also listed.  So,
someone needs to step up to maintain it all, or we should look at
dropping it.  Thanks!

--=20
Tom

--/UdwykLl+gZH4Fdk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnYRsACgkQFHw5/5Y0
tyxCAgwApfSb+dgyEzItUwU7QAsmOkrFnT2cjbi6Zqhh8BzzOciWIerYcbbM1dq9
xsqD530NvE1o8Mb7fOzqMkNHFGBOQJIlAd7g+BdhtHsZQ1IRBS6zDWN4ubjBdGpj
ssltKj7bxXNKdX7hdVVLpNgOSMoVbnKwwqK0BsBOilL/lHoExEW3qPDtH2fKxYJt
pGvPsfGp9QnRX5SgzaWeRJ8jEmCiWGwYqpjeHuPM4om2zHz7nCmtT3TsodFjWCuW
BshfD8nyfBb+XEdV4tSTtz0lK1a7Tj7JrsaZlXZdSkxWEBKPblKLWahCQusHeRzR
AP+nyLGN6MVl1yCOmdWUweZ3rlzi18YEQzFbynlaPH6KLy0TUQJ3vY+ZldYl8Gj8
z/RO1PO8YidifoC0fBVkXe5uvP1g//pKAJkM9L9J5JHaKiijwhi58yu0p/jR+bNT
eBU0LbOkPFSrKXr8sNuZr71MLC00n++RgFJf3wBJ1NPjCp6LpFO+JbZ7IA2jUvqf
uWigosK/
=X9g/
-----END PGP SIGNATURE-----

--/UdwykLl+gZH4Fdk--
