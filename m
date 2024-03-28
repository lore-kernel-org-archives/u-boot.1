Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B87ECD11DF
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 20:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 847908785E;
	Thu, 28 Mar 2024 21:02:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pDFp2/TE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CB9587971; Thu, 28 Mar 2024 21:02:09 +0100 (CET)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 050C086784
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 21:02:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-432bd633207so1613761cf.3
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711656126; x=1712260926; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uqBd2sYQ0O4tALAuXyOIvnamR2MXyUneRbAkwivLRWQ=;
 b=pDFp2/TE13Qxh0Gy4ExZqBRN0rzREJWVg4w6yL/7JgV337buQGuaYrGpzIOEBgmPVJ
 agoWnVK6EL8E4vmqjNqb45HopbGEaQh5EBF6Z40dKiMtd0GCGSDO9eX31raiAmhgTWIT
 83ojP0QmbfuA74LfFfLV8EWp3msWeIVrzdzT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711656126; x=1712260926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uqBd2sYQ0O4tALAuXyOIvnamR2MXyUneRbAkwivLRWQ=;
 b=agQtZxm42YWefg1I2jBhwAXqCoMwalROs+U9Pcw85RCbXQGi717Kb5/NIOXqZPca35
 aclQGvFSQd/IIElUy7aNhAW1pSpMmv08Rufx/L93Qbv9ygf2l4AjbdjaBoJ7JqLc2yr4
 loK8YvPuy90sCkgfLFwYun9oqVdWED8/wfXN+pZx/KBSmLuzk1msJ3+1aQi8s8qMhPYi
 iFQTQZoH40/tgTop2rWnjF+mGZq8jUMH1/0Oa7/Yth+6WHLaFwd1/7X+78JB6wDWMAZz
 4SYH0+slqAN1YffhQRIyZ0NGCRJPLZqLIYLPKr73ZwcZGkPj2q+Nxeoku/yXJFbxTXbp
 2SIg==
X-Gm-Message-State: AOJu0Yx4MJOYtMSKFIepz25pQf+Jfr96ImJpe2AEq8OuCsPbX6Se+NRd
 TpGui7xKgLq4Y9eoN24fgdxP4w38Quww2RvZGjbBiX0AEW+n49Fv4rZ9hGK4KHw=
X-Google-Smtp-Source: AGHT+IFQgk4UtemEuSHRglzIXDyMwUsHrj5RuOURMc0wthMp/LRk1vKSAAIff2rcjPISQfV74P3AOA==
X-Received: by 2002:ac8:5c96:0:b0:431:75e8:f22b with SMTP id
 r22-20020ac85c96000000b0043175e8f22bmr437899qta.31.1711656125811; 
 Thu, 28 Mar 2024 13:02:05 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 l26-20020ac848da000000b0042ee2bda028sm902079qtr.54.2024.03.28.13.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 13:02:05 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:02:03 -0400
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH 0/4] zlib: Address CVE-2016-9841
Message-ID: <20240328200203.GD3442575@bill-the-cat>
References: <cover.1711548887.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UM2T0I9xRwB0cZm6"
Content-Disposition: inline
In-Reply-To: <cover.1711548887.git.michal.simek@amd.com>
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


--UM2T0I9xRwB0cZm6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 03:14:49PM +0100, Michal Simek wrote:
> Hi,
>=20
> it looks like that only CVE-2016-9841 is not fixed and this series is
> trying to address it. The first two patches are just preparation based on
> changes which happened in past. The third one is actual fix and the last
> one is following what has been done in Linux kernel long time ago and don=
't
> use incorrect zlib version string.
>=20
> I tested it with and I can't see any issue.
> ./test/py/test.py --bd sandbox --build -s
>=20
> And gitlab CI is also not showing any issue.

Thanks for taking this on. I've given it a quick spin on some Pi
platforms as well as before/after and I see that it's also reducing the
overall binary size everywhere as well.

--=20
Tom

--UM2T0I9xRwB0cZm6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYFzLgACgkQFHw5/5Y0
tyzuBwv/ebyAMBDEmV7TdibjI0pOtAafe1mhHh+Z5kTo7xFu6cMRlvolCV0EnPl3
9/B42Y8kVsXaySozhQt7M2N46lZcNnUj31WOq4N6lZ8V+1M7f5CTZaugFTWnE6S1
1+WAtTfWo0C3pAwZKZkMuG4g6xAfh/dnyQnu7Jn1DmHE8c9grqI2Kxs4I7+d5hMF
VOGTl9Sx1YE4npID/YQNsKJbH7NZianmX2tH/tBW0hfhyGLCNZZFA/Z38iCoj3Sd
5yDvEjkeHECObJztz0C3bqDPbQDga4hip8+g3y/RW4afBw3+H7th2IH5zBQey47u
gnpsUWNAPgeRRljR0COPbBkC1S1MMCZhs1Q/UPl+7SIZmYyEP3B3A8cYz6YYyRSb
TGpW2m98D97XdmXLSLDHaRzJl/r1gzsYTlw14NbNnb8/l432N6qx+CfgJuU4bh75
z1OGJVt/lZ0kMAIabTnRxJ69ewGDrrzYcPhnOBruzbVFSFBE69atrdSq/2AJ2eFq
ZRE+XtqO
=SZIq
-----END PGP SIGNATURE-----

--UM2T0I9xRwB0cZm6--
