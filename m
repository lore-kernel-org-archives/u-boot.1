Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65725E87839
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 14:17:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF69B84262;
	Tue,  3 Feb 2026 15:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jXUXpeEZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7108F842C2; Tue,  3 Feb 2026 15:17:51 +0100 (CET)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 325408423E
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 15:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-40423dbe98bso2510370fac.2
 for <u-boot@lists.denx.de>; Tue, 03 Feb 2026 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1770128268; x=1770733068; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GS+iFi57nKfmrx5pel3mddxb09CqiWEnYjGlliZ4jFs=;
 b=jXUXpeEZgd0M6gsuUdsu2h6hAlhotSDeaHMacgnYCZFFzrshrSlO1/nV77qfg0T6oZ
 QSUHR3Zbx5W5Lfq0LxPyRRPStDuALoRozbrTthZPIa92VDR8YPW4ErLWbjh8cRCz84MY
 w5J/zPJdRAtR+C91WtBEf30Tydq2sj6Ut+H7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770128268; x=1770733068;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GS+iFi57nKfmrx5pel3mddxb09CqiWEnYjGlliZ4jFs=;
 b=gbnpLR8CjZ6vnxyFVHbQQFo14ZtLt1L+A9gQK370bwggqGKtkfmoaCorHu7xvZgjBR
 Hq4DIZ5rQJrfWzQ7blVYoqxVetA8UrxiPCeGGWsreW2UXCfSawUglGd1qP/wR2uGMP/u
 NZvTSQnfVuIR+S38chcppD/kfdPE9ljqj2idWq6dBm1IT0q6Vqm9k8AjhT7M8im7fH0Q
 pMCC02XX0OW77wmb8+tEawgNJx3cLHF84/pTaptv2xcwEeV/2zFObHXyA8nUG1sS95Jd
 C3tnB6C3RKj1J8G99A9JxMAwq39lfeqHA1sRBgXt4hNFPpZqllKdgGaMLGyXpEN3S3Xp
 FiaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWraDhTHwDotKdunATxtW7jd0FR2gemcrH9bgK7cw6+sq42+OhtCs5ALbQycxTLnirqkchTMSw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6wL8XyBLIgTmZLxOk7ju64VWNu99VinLbmtX32lOC9OIgw4l4
 s8xNvHq0ZlQeWbsXHnsFQlIt8+TqtoRYEy0qlOzEvu6wzOYTwugPLQN1kHTCHwSV4Gc=
X-Gm-Gg: AZuq6aImqpMOd1sLVH02VYXLjcOBq1ItY/gQODL7pZhyaCrlZeV7Vcog+8Pg/Mm1wbZ
 qjlR0tqbRvQeI5wW7/ww9+Bm4oorcwZOs8PZ+PI8EP2wJQbhE4r1wTte1Tprdqkee+rWbXzDYsN
 WjLXi7NWGBttHhk5feeH8mYPZMsf6Yf/H9HYWBLpMDzetFHjfBb2lFl6kTD/FmrbuTv8/5B5R2e
 Db15+JaKNvKGSGtrz/p8S8lUG+wd5bq0drFFzYVBw6QG6SKHBUQ46nOI4xmoUoq7xRU7X2GKfmK
 UDsHT2O3KSrFYXX/owd6bZK07YAa06XrhaUh7GbTzJ8YN8orAci8mA4T0wXVQHcA66F08QyGkK7
 GkQeN2kfRjVYRJ+B2hfQQPVYMrBskeAvCt8NLHzmG0z3fgXv1ZGbjlOkp/15y0cVaVmDREoWmK+
 3greQPhChhVZW0bDhKCdGy9OCRy2JjsMWyyYg69otzv0JcKzLAYZzpKAFtRYjTIafdQe6Gflv6M
 G9cFipjVR01if014acLYCg6n693n0yVH/KV4dc=
X-Received: by 2002:a4a:e711:0:b0:664:86ce:df6d with SMTP id
 006d021491bc7-66486cee34dmr3798313eaf.18.1770128267687; 
 Tue, 03 Feb 2026 06:17:47 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-662f9a35b3csm11973501eaf.14.2026.02.03.06.17.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 06:17:46 -0800 (PST)
Date: Tue, 3 Feb 2026 08:17:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 00/14] treewide: Clean up usage of DECLARE_GLOBAL_DATA_PTR
Message-ID: <20260203141630.GG2603314@bill-the-cat>
References: <20260203-cleanup-v1-0-4221c13e7558@nxp.com>
 <PAXPR04MB84594DBC04C4957716EA9C79889BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kzASysvHblo99wyx"
Content-Disposition: inline
In-Reply-To: <PAXPR04MB84594DBC04C4957716EA9C79889BA@PAXPR04MB8459.eurprd04.prod.outlook.com>
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


--kzASysvHblo99wyx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 11:42:04AM +0000, Peng Fan wrote:
> > Subject: [PATCH 00/14] treewide: Clean up usage of
> > DECLARE_GLOBAL_DATA_PTR
>=20
> B4 fails to send the last 2 patches. And I am not sure how to send
> patch 13 and 14 in the same thread. So just resend, but seems
> resend still fails for patch 13 and 14. (:

I like the idea. I suspect 13/14 are just too big or too many on CC and
the mail server rejects it (gmail rejected this at first so I just kept
it to the list). So it might need to get broken down further.

--=20
Tom

--kzASysvHblo99wyx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaYIDiAAKCRAr4qD1Cr/k
Cli0AQCJpBhLjMW74vswfTP7t5KpA/ohE7VYbrx1EiaIjGKHBQD/eyRVdVsGHf0C
+wwzo08778amXNi+OiptLlDQutYqFQ4=
=upxm
-----END PGP SIGNATURE-----

--kzASysvHblo99wyx--
