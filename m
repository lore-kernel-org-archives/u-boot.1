Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E5F0C41535
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 13:59:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DACEB870C8;
	Sat,  4 Nov 2023 14:58:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RJelMW0p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B69DB87037; Sat,  4 Nov 2023 14:57:41 +0100 (CET)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64E9F870BC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 14:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-41cd9a71d3cso24982161cf.1
 for <u-boot@lists.denx.de>; Sat, 04 Nov 2023 06:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699106242; x=1699711042; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8CwCYQuV7VWiDRitlTTAq4L9WoZMc8h4o0ucDEWWxqk=;
 b=RJelMW0pvYwl2Ou77MVrVDpKMPGmVD1e5eYPaBlcxf4n5CbVPYi14gbraN0w+HDDg2
 KZNCd7PymSltpqpNKraxmtbcU2VCf9ADptN0uP2B1wjfihkilTxGDA5GHRROwC0DY9d1
 32NCtkHXd1p8HJcfn/Kc17W1ql1bPz6UNxoxc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699106242; x=1699711042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8CwCYQuV7VWiDRitlTTAq4L9WoZMc8h4o0ucDEWWxqk=;
 b=cYyEkfXove8gb6ZrUIkgAy7MT4H6lvjJHdCsl/hFnhUTc2TtP0YZrlMWiffo59Nd2P
 oH6IJdDBMT7Q5JpE0CNKZyhuDKbYKVeNrcoaOJ40b4eiHjlShuMHPksjVRBu3hqctn1u
 cZ2I+z4yPWVM+dIrKPKmWGiBou40DIHcrO+xraHFPpZTaSYl9e9kk0GLpO86fyiiV0K8
 M+VAjW9dpMyIIpY/+FCpq3T8t1tbFoQjICHEGSrI+DuX+zbhXXr6IPMnS3KBERoSlrhm
 kaPuiO6/pzvj90JS44ltfHF/PYXQxYmPhed2jIUhJbrsP+/5A5t6D4u+VEnZAJ/hCSH9
 CDDw==
X-Gm-Message-State: AOJu0YzssrOZZypsxIzafCxcv42IOi84ug1DOUV+m58d23mRATOwWO0X
 d8g0wsJjpNtMn8TWVGS0Xx1d9sZ78OZvXLPMObpVBg==
X-Google-Smtp-Source: AGHT+IHa/xIAWyJL62yK9mar+qok7fysoLZvAjqhwE1RlGlsVT9vIJEQ8bhOLlyaxBclguUKnp8vng==
X-Received: by 2002:a05:622a:199f:b0:41e:3e05:ea00 with SMTP id
 u31-20020a05622a199f00b0041e3e05ea00mr8130272qtc.4.1699106241778; 
 Sat, 04 Nov 2023 06:57:21 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 jy5-20020a05622a818500b004181b41e793sm1637152qtb.50.2023.11.04.06.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Nov 2023 06:57:21 -0700 (PDT)
Date: Sat, 4 Nov 2023 09:57:19 -0400
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v3 01/16] ARM: dts: p1801-t: separate from common
 transformers tree
Message-ID: <20231104135719.GA496310@bill-the-cat>
References: <20231003063647.42770-1-clamor95@gmail.com>
 <20231003063647.42770-2-clamor95@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="z0hvQPngVdMvYjUq"
Content-Disposition: inline
In-Reply-To: <20231003063647.42770-2-clamor95@gmail.com>
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


--z0hvQPngVdMvYjUq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 03, 2023 at 09:36:32AM +0300, Svyatoslav Ryhel wrote:

> P1801-T has significant differences (hdmi panel and backlight,
> own power supply system) which makes use of common transformer
> device tree complicated.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>

For the series, applied to u-boot/master, thanks!

--=20
Tom

--z0hvQPngVdMvYjUq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVGTb8ACgkQFHw5/5Y0
tyxYdgwAjWe2SBs0V6D9a4xyZv0Fuyeg98l9Tq8/QLxTNzOJTYHioAHpJFaAA2WS
gEppZORe7gHTEK01iXMnuLZfT9wZvXdWGbofbBr4SsGdHYoK+TQhSetRp7RG+TTn
5JhLxKsjaGXObQs5vYueQZPyUBsyCvvtul2YiaymuzWMIp9kbTKYI6M713oP3o0K
OwdbErVD/qJI1ziMhYBCBibOvxL1j+kOwEBeRp3ZtiBiTo4K8lhWkvIK5qBKuWv2
a+gfsMPAZ8EBXW/v5n7rNi5xMdDPLBO/cNUfgncxcORH8Tsok9E4eiN6Z6GZ+5cQ
v+LUUTlVtJY0qXgPWE2ghdBNqtWXsdQ+r1JjQX5FfiyAjJjVkIIIj4R4WTUCeCBy
I4QWWwBKuBC2H+o92lz+KKMXkTUDiDTlQ/9PTKzkvJXhpD9g4NfLEOMDfu5eQ5Ms
nsshMfyyurHC4OmSCncHq9R+jhEYtjrzCrMvBzkHeK59UqRL215kb2zcz1/QUfIW
+3Zy9zd+
=UJP3
-----END PGP SIGNATURE-----

--z0hvQPngVdMvYjUq--
