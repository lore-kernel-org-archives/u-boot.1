Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000EACF3185
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 21:55:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 838E288E50;
	Tue,  1 Oct 2024 23:55:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="I/KICxTt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F3688DFB; Tue,  1 Oct 2024 23:55:04 +0200 (CEST)
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com
 [IPv6:2607:f8b0:4864:20::f32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09AF588E97
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 23:55:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf32.google.com with SMTP id
 6a1803df08f44-6c548eb3354so49148916d6.2
 for <u-boot@lists.denx.de>; Tue, 01 Oct 2024 14:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1727819699; x=1728424499; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=VicJ0iieX2yV9KaZsK4uk+Sd+E/VVMErHYz66lFL0aY=;
 b=I/KICxTttzJnmbnsLQ25EC7pnR8QwgfE359jsh69MEAM1DU6N1KUnIqv3d5fx5bYw1
 mUFETNVowSf5aoUrFqqQZdkLDsNUOMe4MRbFlJQB1D+hF4g0mDwI+SGsk/zAzJ1v2kgZ
 ZAd/+z/FXxEFAejFl+6MeRL+cbuFj7bHH3xYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727819699; x=1728424499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VicJ0iieX2yV9KaZsK4uk+Sd+E/VVMErHYz66lFL0aY=;
 b=mQTIASNgRZLXkoWuM1mQ7pIgv+E/38I3Njmw4nWyXC3JOmpZEdaAFtr8cevUghnrBF
 yY9U3OQ2x6zhcbNx3MbBq9/YZFrO4sFF2tHDKeZg+showX/8EhY5RRWikJIot0yDTCky
 ZQ1KIc2fLfUNIPT3kH8Zsq6qCjUpwtNcCK2CkY7tegXRJN1XXNM0U9G0/eV+18cO8lBT
 UBoKaZQq3OkyxMgWqPj8OIWyLPmAtUUnDNeplIIwPktIfc3noOP/K1N+vLpHkIJCK4Ti
 g2J+VfpeWTVct5INa+TZl75+od8g5dldJ63aBoxZHP5VPsy7we9VMeVXEGvUqMCbKXPq
 Sn3w==
X-Gm-Message-State: AOJu0Yxc0VNot2fCJdrhl1l2+EaTvamxbVuP2aX5ETH3gGfbni3xkK16
 6Ao1+YXdX/WXdV23h48hrH244fD0UBjqynmW8d1Z9g4mR6gvOE6zd05u/9JG+Yw=
X-Google-Smtp-Source: AGHT+IGt6nmoxXY3US/yDK1/OAlhQpJORIGr3HwykL5olLuCznVt2+ma9b/T+tXuAfwBBQWSS8farw==
X-Received: by 2002:a05:6214:5b82:b0:6cb:3cea:8441 with SMTP id
 6a1803df08f44-6cb81a791dcmr14290416d6.41.1727819698845; 
 Tue, 01 Oct 2024 14:54:58 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cb3b66b115sm54190246d6.82.2024.10.01.14.54.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 14:54:58 -0700 (PDT)
Date: Tue, 1 Oct 2024 15:54:55 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>, Raymond Mao <raymond.mao@linaro.org>
Subject: Re: [PATCH v3 06/33] stdio: Make use of the SERIAL define
Message-ID: <20241001215455.GM4737@bill-the-cat>
References: <20240930014956.1434060-1-sjg@chromium.org>
 <20240930014956.1434060-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2/MINSEJcCJFmLez"
Content-Disposition: inline
In-Reply-To: <20240930014956.1434060-7-sjg@chromium.org>
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


--2/MINSEJcCJFmLez
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 29, 2024 at 07:49:29PM -0600, Simon Glass wrote:
> This is always enabled for U-Boot proper, so simplify the condition
> in the common Makefile.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>=20
> Changes in v3:
> - Move earlier in the series
>=20
>  include/stdio.h | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/include/stdio.h b/include/stdio.h
> index 7b999a519ba..e7325795533 100644
> --- a/include/stdio.h
> +++ b/include/stdio.h
> @@ -9,10 +9,7 @@ int getchar(void);
>  int tstc(void);
> =20
>  /* stdout */
> -#if !defined(CONFIG_SPL_BUILD) || \
> -	(defined(CONFIG_TPL_BUILD) && defined(CONFIG_TPL_SERIAL)) || \
> -	(defined(CONFIG_SPL_BUILD) && !defined(CONFIG_TPL_BUILD) && \
> -		defined(CONFIG_SPL_SERIAL))
> +#if !defined(CONFIG_SPL_BUILD) || CONFIG_IS_ENABLED(SERIAL)
>  void putc(const char c);
>  void puts(const char *s);
>  #ifdef CONFIG_CONSOLE_FLUSH_SUPPORT

There was, earlier on, reason for this level of complexity but it indeed
seems no longer required.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--2/MINSEJcCJFmLez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmb8b68ACgkQFHw5/5Y0
tyxRhwwAr45AVFNou+UQDBFNSZB59n7uK9FtxvBr9DB71wt4Rm0IhQx7D9C0u0B6
di8YptR0ek8jnCluFKFd23AYCkdmNN2kicxuqSB1Qjb+gm1EGJre0A7ayNNI1hwO
EMRaHeNY14kr0eB9J327YniySjzaGwGlHnP/feYr3PM+2ouGybIGualQlapo6os5
Xw0fgs4V4PUrF3tfFJdhZCSC1obejiRgXyXSBDEWBHipjqZTNhInVSrEAttku45Z
imEvPtaWurT/IqsK0iZfDZb04YZyGL0d4nggt1kmzXR0TzigmiucqGalguR2xw9N
eMAkl3tpB1jtDlScbAm2SG0DG4yUnY3WQ/i1iLjvYJ72UuNp5LFWnRP6zQ7frFkv
g99YqOjDvECyLAcXgsUnFiaiep3MxaJNYaszlMQG9vOqsdNfydwjnWBxbpIOsG1+
mNND1GW1E9l93tvbC6jXtD653HkNjsq7K/SouN2RWNm/fnWpjlV8iQNFv5FcVPBg
0V+vHoZi
=eVxw
-----END PGP SIGNATURE-----

--2/MINSEJcCJFmLez--
