Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B95C4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:53:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE5D987576;
	Thu,  2 Nov 2023 15:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TyU62tso";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 99CCC86F8F; Thu,  2 Nov 2023 15:53:28 +0100 (CET)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBA7A86F63
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-77891c236fcso61278085a.3
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698936802; x=1699541602; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4H6brDTt+bLJAnx0ae6dWxTMAghctCQDJdosqmCBjug=;
 b=TyU62tsoWwUa5KxFCfe9hMJNmMmuvyL9JwXGE96e1N6szEuOz0axSUvtnXRM5N7p7U
 cvmQvUgSmLCSNzI4G8BIgiWVV3fRTUB2aQgYdLQLEniAL3abgAPovPhFpvPo7/s8cIQs
 vTYlX1uVs42U4yuXHZL2cNHo43GihUgUz4h0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698936802; x=1699541602;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4H6brDTt+bLJAnx0ae6dWxTMAghctCQDJdosqmCBjug=;
 b=SKcLcdUl9B5fYMzqS/yhbhaw3hb/wRzHoEu4K7dre41Qq9vZ+ljq7rUew7Zd9ZmP9L
 XG7DFSt+jaXwOcgZ8TNFodtQ6mZCrowSVuY3N3V8Y0TYCjPhRDCYDCZNP1lUUrswW+XH
 t2/LFxGn4FxgJho6jU0xmcrZM9oupe7votoEcSLS+Ms9mUpNpAYfzJF3LymZnFSf1SHc
 NEl+9g1SagjarAKZyiCpVwks77LTIXM1TLpxL7vR4enC14fUbA8D7PFpM7dHIZzr991N
 tB+BjtNUhxilCT9GTTGKPpEn+gPtyni0mWB8jngH3yhSECMwKn/9yfglcdXu1olsEoSn
 SC4Q==
X-Gm-Message-State: AOJu0YzzyxPxy08ZHDSZmSoBqhOIZNsqsl8M3sfDUa14WL2gsdGGoQim
 vw3eb+C6oHt3+k3ExcexWAT5/A==
X-Google-Smtp-Source: AGHT+IEq6Q9+4XF1bzB1nYTuW1vnF3yB9mzQ0MHyiFwGIAHpoPFpkKq9kLamAhdHkOWtl8Vol7aVhA==
X-Received: by 2002:a05:6214:1c41:b0:66f:aed2:64de with SMTP id
 if1-20020a0562141c4100b0066faed264demr23353407qvb.5.1698936802678; 
 Thu, 02 Nov 2023 07:53:22 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 g18-20020a0ce752000000b0066d0ab215b5sm9959qvn.13.2023.11.02.07.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 07:53:22 -0700 (PDT)
Date: Thu, 2 Nov 2023 10:53:20 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 2/2] bootstd: cros: Correct condition for read method
Message-ID: <20231102145320.GJ496310@bill-the-cat>
References: <20231024181740.1938934-1-sjg@chromium.org>
 <20231025071736.2.Icae3698db8f3c247e629777903db3a1fdbe374d8@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/BTWh3Ucx334a56t"
Content-Disposition: inline
In-Reply-To: <20231025071736.2.Icae3698db8f3c247e629777903db3a1fdbe374d8@changeid>
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


--/BTWh3Ucx334a56t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 07:17:37AM +1300, Simon Glass wrote:

> This has a typo which makes the method inoperable. Correct it so that
> 'bootflow read' works correctly for ChromeOS.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--/BTWh3Ucx334a56t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVDt+AACgkQFHw5/5Y0
tyzmogv/XG+ToJmqbKnQSQYEo657V09TKLo9ZpaO35yNLTUQSzqCUEFfrwnWRsDz
RG7XUf3I1oFV05T/QR3VjJVTWc/l5qA3B9U/MeiB/T7sB9zrErG12vF4baIVnvCW
Nw5SQwAKzBcl3KOSZEyBjg1o/lI0j3pgAR0Ruiqt6wmHH6cV3IxcHCJqoJk/Zn2O
gI/zEI8zGkYWF4c++tMR32R3QempN8swVMAXPTup+Abyk5oN4DDDlQ53EvCYRtVr
2rTrtbS264SP8n+Z4KOue22AIja/9Y09EUqRxzmyhYB2leABM85G2lqFMIQus8Hw
gV4E5dHjNSXPZ3iP1bupqypUmXCVdBv/g14o6+tEa7cPW0fP8U5kKLc/LelCzjov
Vob4HUeRvWm7aCEExd4wieCgakcN7vb+ytmkrmEhUOxr0IqdPzvlLr5+AQQvYIyq
QupI3Cfts4BJqH4hxWZDz4i/2or8060SFexJ4AA6hU82HHDmNhvroZuEpcSdzm95
ki+4bsA8
=PdHQ
-----END PGP SIGNATURE-----

--/BTWh3Ucx334a56t--
