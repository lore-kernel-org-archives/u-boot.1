Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBAD1CCD183
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 17:31:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B792844AE;
	Thu,  9 Oct 2025 19:31:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ELH9BqCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5520D845AB; Thu,  9 Oct 2025 19:30:59 +0200 (CEST)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 358C383F0A
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 19:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7c0e357ab51so1027209a34.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 10:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760031056; x=1760635856; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pvrPWmCd6AMLG0oG/UnyHr1pfclVd5nN/rUS4MUEHCk=;
 b=ELH9BqCALKrvjCvlwclwbdNjqqcBN+gzxCpHdyRjKpiK3GkfGmLLbpXM8Usbpvo71p
 uesluzjmF4MQXZviQJ2XmTWsTHUvuuyReBBcttbeY7zyqOG7xahFuvnntQgGR8slVlE2
 6xNeaK+hoijInWuhFXAV9VaHh0J+0xXDF0lPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760031056; x=1760635856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pvrPWmCd6AMLG0oG/UnyHr1pfclVd5nN/rUS4MUEHCk=;
 b=v96vhPNseIIqFgI1Viy2xUqZJof/aY/hFfNzfoAF23xyKYeP41kYQGM2lXh7dQPCpe
 o3YOSnETz/Asf4FRafgBYN9U/RHJmUJ3+JzEafvGwxuQiAp49pTPUYIGoV7+/JmqsEnq
 3vtZwFL9q9xFH+A87VlCg1j1xZBaWaKQP+peIxkuf97SsmfFaYCnpJdvWPklDbIjHVV6
 DKdwgDBYYorjlUukigKzeeHDwX2cGzc8DMZp2lk1Gxz0u95Ao1x0IuhZnyDoP3w4Uik3
 YGOM2PVBe1SuSh0Fj9QrnmOhdUK2AP5aA9iPiMBIgDwcxYP2OChAKhFSrJqsFv/CMsRV
 FfIA==
X-Gm-Message-State: AOJu0YzIbgmhbhChrhmjTTcCkiNVhcKpXjDwCGiUaIzE+Qws/VtZ1fc9
 1gAg+CV6rXq4XVVZGbyGbwNPsfOURZPOABMTqOZOHhS67jXsKu58N4ZZoKlvQFahsh5iUjh1udO
 RNat9lLY=
X-Gm-Gg: ASbGncuOtX3i/5qmWSKXbXaScNfGPuYXXoCy6Muvb09+5A5kLQ4WBbIioLYueHXMi2h
 z1RXCPCKm8l/XFcoXmPWsejhifb2Oc92KCT5rb0GQg7h3P8KSq1SSwEahe2sb045qeQtYIvokMf
 N+n9pvA8AbtarwcPoinanmVp+N8RG/OkCB4Fq18E/Q2kIn6jqe8/c18But18pzJwCxWeqqtBU87
 fui2DvRgm8b+GG/UZSvrCk+eKB5pTYvNGdIAcn+JmITkDuDU40HykLfwHuBip3KH7tVPjwazP8R
 4lfOYToq/oU2rMUqNw+98H6Sf8SJ9dUPT3dQEYEMcRVhDCJaKrXmtWsd2odtj3pOU5krInvhsaq
 wMCk5kd3MKGxVX1PYvBtnb/aT/5/D4S0YMNl8zb3dy0h8xVEy0o4r1FXq0K4iaRous0AMvD7X5T
 ByZQ3DJtdhhUl6gx4GC46U
X-Google-Smtp-Source: AGHT+IHVHDBL7TXm3KFC/q9AInlQQf+3gsqBEtqdN1/kD7zZl1FAM2+wCdndypJ3JhpuHdIvGcSIwg==
X-Received: by 2002:a05:6808:1596:b0:43f:50a7:3701 with SMTP id
 5614622812f47-4417b3d6e8dmr3481784b6e.33.1760031055719; 
 Thu, 09 Oct 2025 10:30:55 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-44198882921sm7067b6e.1.2025.10.09.10.30.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 10:30:55 -0700 (PDT)
Date: Thu, 9 Oct 2025 11:30:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Peter Robinson <pbrobinson@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: Re: [PATCH v4 3/4] boot: Add more debugging to iter_incr()
Message-ID: <20251009173052.GQ298503@bill-the-cat>
References: <20251009092959.260121-1-sjg@chromium.org>
 <20251009092959.260121-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3HphdTjpNpcn9WXD"
Content-Disposition: inline
In-Reply-To: <20251009092959.260121-4-sjg@chromium.org>
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


--3HphdTjpNpcn9WXD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 09, 2025 at 03:29:54AM -0600, Simon Glass wrote:

> This function is the core of the bootstd iteration. Add some debugging
> for the decisions it makes along the way, to make it easier to track
> what is going on.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> (no changes since v1)
>=20
>  boot/bootflow.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>=20
> diff --git a/boot/bootflow.c b/boot/bootflow.c
> index 78df09f369d..de69e27bec7 100644
> --- a/boot/bootflow.c
> +++ b/boot/bootflow.c
> @@ -193,8 +193,10 @@ static int iter_incr(struct bootflow_iter *iter)
>  	log_debug("entry: err=3D%d\n", iter->err);
>  	global =3D iter->doing_global;
> =20
> -	if (iter->err =3D=3D BF_NO_MORE_DEVICES)
> +	if (iter->err =3D=3D BF_NO_MORE_DEVICES) {
> +		log_debug("-> err: no more devices1\n");
>  		return BF_NO_MORE_DEVICES;
> +	}

Thinking more about what I said in the previous iteration about git
blame history, ones like this should be log_msg_ret (the history on
"when did the test for =3D=3D BF_NO_MORE_DEVICES come from is unchanged, but
now you can have debug statements when enabled).

[snip]
> @@ -228,11 +234,15 @@ static int iter_incr(struct bootflow_iter *iter)
> =20
>  	if (iter->err !=3D BF_NO_MORE_PARTS) {
>  		/* ...select next partition  */
> -		if (++iter->part <=3D iter->max_part)
> +		if (++iter->part <=3D iter->max_part) {
> +			log_debug("-> next partition %d max %d\n", iter->part,
> +				  iter->max_part);
>  			return 0;
> +		}

Shouldn't this be a debug message instead in the caller?

[snip]
> @@ -326,8 +336,13 @@ static int iter_incr(struct bootflow_iter *iter)
>  	}
> =20
>  	/* if there are no more bootdevs, give up */
> -	if (ret)
> +	if (ret) {
> +		log_debug("-> no more bootdevs\n");
>  		return log_msg_ret("incr", BF_NO_MORE_DEVICES);
> +	}

Then do we actually need both a log_debug and a log_msg_ret?

--=20
Tom

--3HphdTjpNpcn9WXD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOfxSwAKCRAr4qD1Cr/k
CghqAP4+n31D5Qx97bifNnlk1fTa+k7BVSrtPosWqreOmfxBIAD/TvDC9I4X7M93
5nPN5uhTjRCDOVccre6ImfcZQAKLbwM=
=jTeH
-----END PGP SIGNATURE-----

--3HphdTjpNpcn9WXD--
