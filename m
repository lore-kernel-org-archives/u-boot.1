Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCC1C197A0
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 13:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BB5C8751B;
	Fri, 17 Nov 2023 14:42:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eg6Q6wfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD154874F6; Fri, 17 Nov 2023 14:42:19 +0100 (CET)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35D7986F5C
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:42:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6cd09663b1cso1183129a34.3
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 05:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700228525; x=1700833325; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xdi5l0eA8JrC3fUWFYEk1+RHkV3Q3oLrfCZbs2waG7Q=;
 b=eg6Q6wfUOfrmsFwzmia+KFltExLRP+sye2Dj9aQ7xsyTRMxxflnRZpI/xTTTvUU6sp
 eh8obSnki1oy9jZPoi4ous9+LmICZqArnoSgxHIpOCdhH8GEHDcESvSB/yVFNj+FlkN3
 qO6LF9DIaQpQJOAwGOYU31vUGQRkZLKleRors=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700228525; x=1700833325;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xdi5l0eA8JrC3fUWFYEk1+RHkV3Q3oLrfCZbs2waG7Q=;
 b=kDK+lBKKUOFFsHXByqKZdfABmvoQ+JJcyiBmFpoi7ZVUVBFj9vgIius2CAMsTFdnu+
 04VUMxbRNyvokeIKWebVegt4oZhf5U9gtnnvaw7hj+9CkED/vKjXj4KVuKYc9i/NeXZx
 ik+wDJAuGqh7sUHKOITtk0Wvs66rkqV2SZqHNQ70yj7DpXlHKXrZwAS/XVU80ho1P8sQ
 dhXUkbe/FYy6yFLNHKZNVsCTD1YJruF7B0BENbitKiT2JGGxSWnhrBjnCrW9krAc39S3
 4ZmBj+YHujb43ImfYxsOccyfZ8ajnVjpIX3vIohjDC/Yr16/RsZTHMiJ3cccyET/d09c
 CPuQ==
X-Gm-Message-State: AOJu0YylkrZmfP7mTzrd0UawtcogpKMPti38WfUB+Qeqp9DevZzowRUi
 TZQwm48gFraFCq+AttI9nvSbig==
X-Google-Smtp-Source: AGHT+IEX90SGbbNwtx1vl9mM4Jc5eRDK7k2JDhbS6i6OpL39inxVkuC7Z9tDsjOvVzlRqs7/EZG5wQ==
X-Received: by 2002:a05:6358:52ce:b0:16b:c486:c315 with SMTP id
 z14-20020a05635852ce00b0016bc486c315mr14965643rwz.3.1700228525730; 
 Fri, 17 Nov 2023 05:42:05 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 o5-20020ac86985000000b0040399fb5ef3sm598869qtq.0.2023.11.17.05.42.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 05:42:05 -0800 (PST)
Date: Fri, 17 Nov 2023 08:42:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: u-boot@lists.denx.de, kernel@sberdevices.ru, prusovigor@gmail.com
Subject: Re: [PATCH 1/3] linux/time.h: Add Linux time conversion defines
Message-ID: <20231117134203.GU170968@bill-the-cat>
References: <20231109171004.193521-1-ivprusov@salutedevices.com>
 <20231109200943.1.I1c2b8677c33d4dd9e8a0963acccebeb5c56118d2@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GGFktFReenSUYnuo"
Content-Disposition: inline
In-Reply-To: <20231109200943.1.I1c2b8677c33d4dd9e8a0963acccebeb5c56118d2@changeid>
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


--GGFktFReenSUYnuo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 09, 2023 at 08:10:02PM +0300, Igor Prusov wrote:

> Currently there are no defines for time conversion in time.h, which
> leads to drivers declaring those locally or not using defines at all, so
> add them from Linux.
>=20
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--GGFktFReenSUYnuo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXbasACgkQFHw5/5Y0
tyytUgv+Ojp1orNY/cYIEQ6Cd+eIEGSx9eWb2dGJ6E8Zjxptz8N2D9wzuYg9XNpB
gSLxeo1SVbvzv+sVsCq2qGvx0CRyrVEP2213KVzX6UnG1ElR0EhYdq9jwZB5QPHc
XyqDPCgrkHYIX3+Y7ADOfTQ+/VLfexxPsSvMiGtGOPEUdt8b/vdIZEGwBpxYNkNg
bNLKykfbccEtpnVjJ/4NXNKhMYQRnA6iLxgeQnQuNuAk/cjVXJN5KFvUPkUKFEnH
2x3Olxw4Pji2hOaCRA1oO54zqEOwZxAtjTSjYKye4tGSWsp5hCFRkB/tM8rWlkKb
2/JI7R4g7MfiaX7L6BSA5PIHXUW9pWAXzK2UpHT6LcwA/nu7wUJR0BjX0xHoDaNA
HLePx7ETFM/Ar4gWiK2N+FpXDnX8s77/v9Hsg5Pu7nZe1ATREdocaPKnwrHxzdS4
91tdSyhY4Ssw6wDVngep81edSfb271auNdJmiZkerF3ydR62PhctFOi9cv3+r6Mp
KNji+E8z
=ulcn
-----END PGP SIGNATURE-----

--GGFktFReenSUYnuo--
