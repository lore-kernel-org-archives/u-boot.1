Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A1AC5DF97
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 20:02:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8867040306;
	Wed, 26 Aug 2026 20:02:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gh86Wdy9SoZ8; Wed, 26 Aug 2026 20:02:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787774534;
	bh=VQJN04WsGdaqH0fZYzdI44h5IKjFi1WJoEISpZDfNuE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CjNK+UtE+zMFAmFObXrLquR3ZtJ0UhKtkd6ZINyxiWlZrWpxvneUmAb2QLAMgD+pI
	 ME7HXM7rvkVUeAcrVuVmCPxpFsYZQa+NZUotZShsHDBYfEugVTtyDlac0v4nksBk1N
	 V7oAOrpaA77eU1oyhGF3bDP0shYj3OxecgvDj8NU/5/z/QIOLpwr40Tpx+Bys4mUes
	 ndgetYuPaBHpy5HkEiB7x6IbVeWmqbS+bZ93KqZh2JmJr53wq6mHy23EUs/+gc/XET
	 3QAQsBtGK+j4wXuRdMSkRd2at1tD+M9cNAtTmJ440+3G+dBKUlS026eEPwapLpT/iY
	 gLiNusmvu3/9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 43778402FF;
	Wed, 26 Aug 2026 20:02:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A0A9230
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 20:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C041605F3
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 20:02:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fZwZ-x983_pN for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 20:02:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32d; helo=mail-ot1-x32d.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=SYH1R5c8
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A4DAC605E7
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 20:02:11 +0000 (UTC)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7ec3b429a3aso1177542a34.1
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787774530; x=1788379330;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VQJN04WsGdaqH0fZYzdI44h5IKjFi1WJoEISpZDfNuE=;
 b=SYH1R5c8AkXl83DMTL7v3xDEZwDp0RvRQzVt4Kxlq+7ux0A6xGrn+ZlyJFMaMsGFb/
 zt0Dx2St3qlIZtpG5A5mcSQzo1owvbFPP2YJjatdOHa+EV92sheljj+68k+qEEVFp+aI
 215IpA1pHg0DIXnSNLjklIn1lLviD79/fK3ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787774530; x=1788379330;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VQJN04WsGdaqH0fZYzdI44h5IKjFi1WJoEISpZDfNuE=;
 b=JOUUGHzhBS1HKqqD6ng5uiR3mz6FRLSEbkxEvbbE/cTlr5REnCrT/lagZFaKhZEwPa
 t/LoKnhWGif5Ht+ZP6VMkeMG9soUi/dOdCH3LOmQb5cDi/3TAMWAkL8zN8WWNj/3Gt5m
 0utmtKwsqa31EEwNB2/XWL4NXj8ti6gFWsONvMpmDegYgtQxLisn7RTSzTUrcR+PnjY5
 R4Wln7D/tNN0rCENnPVG716N1cnGySqnLyLHOyYpHCqPlBPxbOomxTcuzheLyTOfU9gM
 CdLcvk2uVbDA+cyYEVFMYF1n941DrJhJotDUOe8Odj/AaSi329VVKCjGEM9QBBrqSotv
 ONZg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2E5VTw7s+Y4S6RSmNAer0RYSsqk6MmuLuxnbkNKoSdX3LUc9gjXAqaIoLNupKIchmbG3h/x4=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lXILDd/sRBfs2QmAmBd49sLdHgxIbxElb0J/06LNaLI2dK/uUl
 3txn0S9M2tQ020sOoOXDIFgtuCnOYNCxum3r7zxeMXN+19tJbqtJJovYTW8cXmHD891F61ETeWu
 BhTwiBSC+x/k7
X-Gm-Gg: AR+sD13WorC+f+gmj0lEyPLeRGzJsBy32JCts8+CWuq1zR+DmGhy1XyIzdc4q2F6III
 uhGFyrpau2cNjPXlvOlgDXGSFb4uUCLvonf4z5s6dUpzh6s8b81rwiA6NgYLKIBdOWopM2PJbZF
 TUpCHdgGxRAcAaLEHp4KciSjC5Chm+Ekl3Il4h8GSCRDIzCO4elFMGfNa2JhJGhAs8FgKYFpfKz
 rInCjxR1FnAzdAxp+5qJ9Xk1LNCuGFQUU1ES992WlVDqWJqEE/8ezPA2ug9p7GmjgcIkYJZPs4a
 GMU+gOfjtWEfb2zu+ffT8S88/+LSazor45t/I8sdc+psn8SP5vUrBGaganTINVlY2qi7PeMPoCW
 +H1hsWFI3uecUkf5+M0CtcjVvSXVKrzE3g9GZCTH8n+/Yz2tAjIzy3UF0onoLaV6IRNUZGOeAh2
 lmrrA5P06NpBjz/OJkVL2MvmnQ8tFnP1PsXuIebfm9Cm1kkTylp+5lppE9iB7kKKINzVii7lPrT
 OSCUM76dM5zjhkyNKhydb4rINTWQ3c133p1tTQNbltUmbUYWcsQzI5V7HZHQwsBm+1SiekDtaTy
 ZNSev2QueA==
X-Received: by 2002:a05:6820:8593:10b0:6b1:3756:f77a with SMTP id
 006d021491bc7-6b1a0389cdcmr7696744eaf.4.1787774530325; 
 Wed, 26 Aug 2026 13:02:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465b03ae31fsm2989034fac.18.2026.08.26.13.02.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 13:02:09 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:02:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Yuxiao Zhang <yuxiaozhang@google.com>
Cc: u-boot@lists.denx.de, Jerome Forissier <jerome.forissier@arm.com>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] u-boot: fix error check in eth init
Message-ID: <20260826200207.GB3959812@bill-the-cat>
References: <20260826181428.1856166-1-yuxiaozhang@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Ucy5FgQDNgmFbher"
Content-Disposition: inline
In-Reply-To: <20260826181428.1856166-1-yuxiaozhang@google.com>
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


--Ucy5FgQDNgmFbher
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 11:14:19AM -0700, Yuxiao Zhang wrote:

> eth_start_udev can fail but errno could still be zero which causes the
> function ignores the error silently. This fix catches the error
> properly.
>=20
> Signed-off-by: Yuxiao Zhang <yuxiaozhang@google.com>
> ---
>=20
>  net/eth-uclass.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/net/eth-uclass.c b/net/eth-uclass.c
> index 5c437143a30..5518268bd68 100644
> --- a/net/eth-uclass.c
> +++ b/net/eth-uclass.c
> @@ -347,12 +347,13 @@ int eth_init(void)
>  			debug("Trying %s\n", current->name);
> =20
>  			ret =3D eth_start_udev(current);
> -			if (ret < 0)
> -				ret =3D eth_errno;
> -			else
> +			if (ret < 0) {
> +				if (eth_errno < 0)
> +					ret =3D eth_errno;
> +				debug("%s start failed (ret=3D%d)\n", current->name, ret);
> +			} else {
>  				break;
> -
> -			debug("FAIL\n");
> +			}
>  		} else {
>  			debug("PROBE FAIL\n");
>  		}

Is it a valid case for eth_start_udev to have failed and not set eth_errno?

--=20
Tom

--Ucy5FgQDNgmFbher
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao9GPwAKCRAr4qD1Cr/k
CjloAQD0KvwH0u5SND3+TBPI0/sjpe84MmoDF9u/85TZ2rmbKwEArPD93k6PHQay
IJCq2DFaBL3BcprNXmK3kjfei3UkNA4=
=g9uH
-----END PGP SIGNATURE-----

--Ucy5FgQDNgmFbher--
