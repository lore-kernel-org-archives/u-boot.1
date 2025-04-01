Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9582C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 14:44:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D763781782;
	Tue,  1 Apr 2025 16:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mSUl9t/r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2DD981DE3; Tue,  1 Apr 2025 16:44:27 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14BAE80FDA
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 16:44:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-72bbd3a3928so3110658a34.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 07:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743518664; x=1744123464; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xdOm8rneh3H2exGBzJzOHC9aT1nJ9ILcnbVR34DdLRc=;
 b=mSUl9t/rxFws5uzcZSEM4Wuo4Eafs/WAyD0uBim7DfS9z9qxQCFGcnRvgQS5PD8bDi
 6o0kaonmTVEHOWW5sTnWODl6BItbBWf8vIH2Czpjh1cGuBd30Ehm3henIp2HKMObd/X+
 +jTt2ANk3P7IQQHWP22pD7BEyHoGCMj15kMsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743518664; x=1744123464;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdOm8rneh3H2exGBzJzOHC9aT1nJ9ILcnbVR34DdLRc=;
 b=hCMb2GSiWS13L4xeTRf6qZ06lajrJwJPFY8SZGxRVjbrE1ZpWwg9iwtNtyH2cVqlES
 uphMWEi6fGe+b/VXhz+bvo8pCqYoITOqyjVbRe1E+Q1wO8HopliffoSCXyPMI/Y8uoZ+
 jXfUA+k9ffOkfbCCReB1pa7FibxbOE/sLrM0ZevJ9PStlY48mLcUdash4nGP8nE+WKMF
 oJD+MT/zCTyPC+chHX13qTAXvIkO363CBdhEyhPV1V4vBuBT+TPnE4grwT63ZuSXJpW+
 tU2dNzL3T3MoNwW4a9OiomTCXeOoJ+n2f2IpVuH6v0A6bn2T0P+tEaIZESrBrhYWw1tU
 Ydqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXbcezphsy2U8UvWbQPBgEDDwpbxEyhE4fh1eIJW47GtbtBOLVtDpTWc4yE+lySxswqofM+I4=@lists.denx.de
X-Gm-Message-State: AOJu0Yyop1T9kGIKnDUg8Xs5ByYxiHbFVhRg8nDpH+R/mqdfblSe+k2V
 b661iejhOO6FdB4qK56uOBB5fPh9lDjxDQJrPKgj68RNO1JJH3sACK3ufUaV9Go=
X-Gm-Gg: ASbGncu29rGoTXkHB637AIKAccuSvR/7O9qt3eJa1tfFTLvsaxClzPZ2InDnRCoUQXf
 4hBH6dS8SkucFkOSY1fhmQ05/wyOkqddR3xeVyCaijImE5kFq6v21bEKF5QNhu2+sCQ7ObC5Avu
 pWRtdLO/03FFOsdDXiya/xBHkyST7lz0sF7Lv8x4MPW6Ak6SxzG6P7DCE1u4Y443qtIk6F3Ycci
 GdEaLHjymRLoywk+Q4w/GuXMNx0aeJBk9ZFBSYD+xzVFFEkkh2HZ1jcdss8gdSUuqNoViIz3PN/
 Y/r7gtO4I7xSNzhFUi7O5El6ZOmXjKT7a+jYxeybObY7fa2XFwBBLfYSUsHwYpC8LK4+ZFLM2wK
 KE+wmFg==
X-Google-Smtp-Source: AGHT+IElwYWOR4eyeQhllnjbnnTNHxvXmAtHZbnMUnhGEM15qJzO5gPe9BvwNg0ntzjQf/7NZixJGQ==
X-Received: by 2002:a05:6830:40c5:b0:72b:955a:852c with SMTP id
 46e09a7af769-72c63793a19mr7519157a34.11.1743518663647; 
 Tue, 01 Apr 2025 07:44:23 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72c580c8b1dsm1894363a34.28.2025.04.01.07.44.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 07:44:23 -0700 (PDT)
Date: Tue, 1 Apr 2025 08:44:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Simon Glass <sjg@chromium.org>,
 Stephen Boyd <sboyd@kernel.org>, Conor Dooley <conor.dooley@microchip.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH v2 5/6] dt-bindings: clock: drop NUM_CLOCKS define for
 EN7581
Message-ID: <20250401144420.GE5495@bill-the-cat>
References: <20250314185941.27834-1-ansuelsmth@gmail.com>
 <20250314185941.27834-6-ansuelsmth@gmail.com>
 <7923a39a-184c-4774-ad94-4d72563c8b60@linaro.org>
 <67e5659b.df0a0220.19a25c.f830@mx.google.com>
 <37c1455f-8d53-4643-b57e-3a888e5dd23d@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wc15qhXbSuxxK9VZ"
Content-Disposition: inline
In-Reply-To: <37c1455f-8d53-4643-b57e-3a888e5dd23d@linaro.org>
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


--Wc15qhXbSuxxK9VZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2025 at 03:58:52PM +0100, Krzysztof Kozlowski wrote:
> On 27/03/2025 15:50, Christian Marangi wrote:
> > On Thu, Mar 27, 2025 at 03:43:47PM +0100, Krzysztof Kozlowski wrote:
> >> On 14/03/2025 19:59, Christian Marangi wrote:
> >>> Drop NUM_CLOCKS define for EN7581 dts/upstream/src/include. This is n=
ot a binding and
> >>> should not be placed here. Value is derived internally in the user
> >>> driver.
> >>>
> >>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> >>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> Please drop my Ack. I have never acked such patch for uboot. If I did,
> >> it was by mistake - probably you CC-ed me for some reason.
> >>
> >=20
> > Some explaination, uboot introduced the concept of upstream where they
> > "import" linux patch for dts and dt-bindings.
>=20
> I expected OF_UPSTREAM to be taking the sources, not patches.
>=20
> >=20
> > This and the other patch are the exact upstream patch with only the path
> > changed so I keep all the patch commit message with tags and added the
> >=20
> > [ upstream commit ] thing.
> >=20
> > Hope Tom can better suggest how this should be done. You were CC
> > probably because the git send-email included you as present in the
> > different tags.
>=20
> Well, Ack is still not valid because I did not Ack exactly that change.
> It does not matter for the ack, but for Reviewed-by it would matter,
> because it is a statement (of oversight...). I cannot control what you
> put into patches taken out of kernel, but at least do not Cc me on that.

In specifics, yes, we should update doc/develop/devicetree/control.rst
and maybe doc/develop/sending_patches.rst to use --suppress-cc=3Dall for
dts/upstream.

But in general, what do you expect people to be doing with content from
devicetree-rebasing? We're doing some direct cherry-picks in between
merging of the tags. I think it would be weird to be dropping the tags
and un-attributing peoples work.

--=20
Tom

--Wc15qhXbSuxxK9VZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfr+8EACgkQFHw5/5Y0
tyyFAQwAtsamCmmm3UdPTlmgHHXmPybFtN6iFAUqxs+vmxeS0m7S4X3twKURKMot
Khb53w6blhr8yp13+OLOMfOHvOBcFcfA2sMWMZphUMturHgpz90rqXF8vnNNk6WU
MP738hyry+1MtmFib4XiQC5C5vFvkx22vZct6lTKus/CAkjm1j7UOyboUsGPQQ9G
p4bSPdiVmdly+wnguyc5cetvk27lM/QqYmyjUIe12IIqhn//tiBxCGzMfvTF/xPY
Rs1zga5s+jN2Mfqm6K+3lxm9nH8cpZKguq25hNoBneB+4yzAzuWk9cQNlGcLGDMW
hE0fNkU2FbUE2YQuXto59Kq018UBXgZRQArgJRg/KjQGiiG231lAUYB8Xkp0WI9Z
jgvcDiGkUWE7v37AaMEbELsgPxencKbQxK3CduQxPt6FrzOeHU04RzFq/XOt9N3T
Erfy8zKvAUsdbibPK1ICQ71FNptgvQ3EPHjDXTvA2+Sl3ejWTfs7TQX1V4lCOmJu
gTHO55OO
=wXgG
-----END PGP SIGNATURE-----

--Wc15qhXbSuxxK9VZ--
