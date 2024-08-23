Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BF66C5321E
	for <u-boot@archiver.kernel.org>; Fri, 23 Aug 2024 21:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9BC9A88B70;
	Fri, 23 Aug 2024 23:35:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qEzR2JZf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 021B988B9B; Fri, 23 Aug 2024 23:35:46 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3C3E88AA9
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 23:35:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bf6beda0c0so12943906d6.1
 for <u-boot@lists.denx.de>; Fri, 23 Aug 2024 14:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1724448943; x=1725053743; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W6prBHjLIWwZb/xX9nKBmHG7wKsmj6pXGyp2fjJRS0I=;
 b=qEzR2JZfOe34V8n5kyis4srl0yOufM5nZNWjVZT16hmo1KfJxlT3rktb6bUH5yvupU
 r8/LvHd++Po62qKsvyqEsMLphPdiSx6ou9sBqVR79yoSpIM0cp/rFbTASfgncWbB4/P/
 Ev0zNxv5Vp8Hw1l5iyMks64vdS/45KJkqGdqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724448943; x=1725053743;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6prBHjLIWwZb/xX9nKBmHG7wKsmj6pXGyp2fjJRS0I=;
 b=vmDMarUjD8M3t9yJxPFazUGY3L8hJFyDa1p04FU9ggm4wMFi4cVCG4Mu2hVlEtCq2p
 oCA2HnlGB6iMs8SCCw+JERe9ubApW53V3gV+g/PaK/WQL4d9jDglIIvJlvzc2ex9vjex
 wj1vAqYlX/5qVWRRj+1nA0RC6JF3yESkGMCrcSw1b/xf8aIcCzVLBkJdxsd5r7TdRb0+
 2+aDkpwJJ6Dydyl+xvoZrExaww1rLZ3g5ajYXiZXoCXhhaiHP1AKCsgMegQ5FJXOnyrF
 m/jZCwpVBxKfSSXsoonSAqz+yM37L2v94Zulu5XpGtyDMrwC1dOyqzKQIkPHnMiVa5QD
 W4CA==
X-Gm-Message-State: AOJu0YzwIcoolFQxFbPSc5aNGrgqeUQ8QEZd0Kayg+KyWDg8dovBg7f3
 0uw1JEMpkcnCRIeEkeEE3Q5g8uZQavE41eE6fdzm1XsXBNg1X0C8i8Y0bJyFb2k=
X-Google-Smtp-Source: AGHT+IGRb7HBrcX264dNpW7x9r/iLQX/Cwq94DkREeHgdDbgrVOvUTEoFwbpnYPSDXa5goOLn/A+eg==
X-Received: by 2002:a05:6214:451b:b0:6c1:6b0e:8080 with SMTP id
 6a1803df08f44-6c16dc173f5mr40628506d6.1.1724448942535; 
 Fri, 23 Aug 2024 14:35:42 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d494d5sm22585846d6.32.2024.08.23.14.35.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Aug 2024 14:35:41 -0700 (PDT)
Date: Fri, 23 Aug 2024 15:35:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [u-boot-test-hooks PATCH v3 1/2] Create a common file for test
 scripts
Message-ID: <20240823213539.GB2479150@bill-the-cat>
References: <20240823213123.487227-1-sjg@chromium.org>
 <20240823213123.487227-2-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hYJBRs2Dq64imlKX"
Content-Disposition: inline
In-Reply-To: <20240823213123.487227-2-sjg@chromium.org>
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


--hYJBRs2Dq64imlKX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 03:31:22PM -0600, Simon Glass wrote:

> The top part of each of the u-boot-test-* files is common. Put it in
> a common script file to avoid duplication and to allow it to be
> replaced for the Labgrid integration.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--hYJBRs2Dq64imlKX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbJAKsACgkQFHw5/5Y0
tywW+Qv9GcsazbkMTi6p7LSsGSk91vxEBR1wjhvwhlf+Rwa/PiYbkZm/mZjynX4B
/pOrOQCYDaHhT4pUnCScYmLY+7bobfik2ncdq+uVaCfwiGbyqw9bO4HhPfvfR6Dr
+O8hBPa2vQ9rEHaMWTVtaenfQeVsBl4AGMsi9alZbGEdlYNeSCWh5TqXkcEext3+
swu2qgh72ONl0zrdBW4l9OjwnIdoLuJHuwvjeNcNDvBTCGT9KvgD8kYEA8/X4ZZi
8GHCQbNftNqM9LB2wHREMnUO3MqJxW8wPzBXnEY2GrrzoM7VFoCPFPh/15AyiIxi
d4UsLXtFD7W1fgiQDXKG9VT1+X103MmsBeIJg4sXL6sjQMs/9kuB8tO+1xM1dlwf
ltsB4Nzdtf50TYjfPb3yUqO5rxnfA2YV0jS5zapkL9T3bXBrPdkhHoRVp4/wg9Co
bhB18KoDCbltdFfsPK+TvepQnlS7b/MLVnWwwOruf8tpg4uPY6umqBUnKaYq7Key
LjKWp2j9
=kwOy
-----END PGP SIGNATURE-----

--hYJBRs2Dq64imlKX--
