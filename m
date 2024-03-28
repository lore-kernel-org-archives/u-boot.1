Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB4ACD11DD
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 20:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C64D988122;
	Thu, 28 Mar 2024 21:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KuZKZL50";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68BE088176; Thu, 28 Mar 2024 21:47:43 +0100 (CET)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com
 [IPv6:2607:f8b0:4864:20::82a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5AD8087C62
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 21:47:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-42a9c21f9ecso5447351cf.0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 13:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1711658860; x=1712263660; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CEMtV4MC+aHFz8f+0I06bwp64WzZBTsMYVM1ZOOIVX4=;
 b=KuZKZL50f15oCy2k4W9btkcYSQcMYsVkbrDSn6p44eI6YGd0KMk7uaMOk3WWWBLr8Y
 IObbt4yWVPJ5Mlvkaw0qvsNAp4VtQ8N4VpUiNlS/vY7uzmIIRC4fvK3cA/+NrqCDdA+Z
 075R/3Q2wjNM8d9fmlSsvBl9cpo+rYPveLO98=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711658860; x=1712263660;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEMtV4MC+aHFz8f+0I06bwp64WzZBTsMYVM1ZOOIVX4=;
 b=r5iBW5ahW4egbx7mJmOx3n5+QbAEKxilLwFD0TKYqExCgdsBcvKY07ljr7/NTjiOqj
 pW+NdFPWuGDQ9KFFvxbDo4kybD8Kz6ShzK02mjOGl9u300KG6Wt+AE+utvxp1RmCEstY
 c3WSLn3P+QynUUUEU7GQn14n23wxC2B/7obpNXJl+DeqzSZrxHipumUd9fUd+2VWvqPq
 GgHh3QuaKs2/JiAUGqkLQOprzkpYGqSWHBM8dNkj6bExt9EBrr3AlpvHtLVh/0xgngwT
 kCG4wE3l8k8mztnWETRpj+Nn8IbarSmjzFP8ZXAHL+48haqz8N/bjEpTV7O+naPJMqbU
 pwWw==
X-Gm-Message-State: AOJu0YylMdUV0IP9kwRhgcxXYxGiKSgSC77ZiY8vyTP8ruD8hhWWh+nD
 wd74DX8S9So0pMOmloanDIN9MR4NsMbb6Inl1snioLNYwDYB4hrRcPdt5s5TQic=
X-Google-Smtp-Source: AGHT+IFUWlraqGiOOdA1MQffdV3C32/OzqjNbT+3EsEtlTTdsgTOIyLKC4hTE7L4KPekCXxjr0zFXw==
X-Received: by 2002:ac8:5fc2:0:b0:431:816e:9a20 with SMTP id
 k2-20020ac85fc2000000b00431816e9a20mr580847qta.66.1711658860190; 
 Thu, 28 Mar 2024 13:47:40 -0700 (PDT)
Received: from bill-the-cat (065-184-193-066.res.spectrum.com. [65.184.193.66])
 by smtp.gmail.com with ESMTPSA id
 cg6-20020a05622a408600b00430ac228781sm925293qtb.67.2024.03.28.13.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 13:47:39 -0700 (PDT)
Date: Thu, 28 Mar 2024 16:47:37 -0400
From: Tom Rini <trini@konsulko.com>
To: Greg Malysa <greg.malysa@timesys.com>
Cc: u-boot@lists.denx.de, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Subject: Re: Upcoming Analog Devices SoC Support Submission
Message-ID: <20240328204737.GG3442575@bill-the-cat>
References: <CAAjXUar=97omadi8MSLox5V_iCwix+YSUP_fMCGsLhUzUfBpcw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HHi5Be0rnoYAn3hE"
Content-Disposition: inline
In-Reply-To: <CAAjXUar=97omadi8MSLox5V_iCwix+YSUP_fMCGsLhUzUfBpcw@mail.gmail.com>
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


--HHi5Be0rnoYAn3hE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 10:47:30PM -0400, Greg Malysa wrote:

> Hi Tom,
>=20
> I wanted to get a little bit of guidance before dumping some patches
> on the mailing list. I've been preparing to submit support we've
> developed for the Analog Devices SC5xx SoCs including both core SoC
> support and specific device trees and defconfigs for the eval kits
> available from ADI. I've submitted several small patches to touch
> various shared parts of U-Boot that we needed to extend to get this
> hardware running and to get some familiarity with using patman to
> format and submit things, but now I have a roughly 15k line changeset
> consisting of a new mach type and all of the required drivers for the
> system. It's broken down into a bunch of commits: one for the mach
> type support, one per driver we've added, and one per target board
> supported.
>=20
> What is the best way to submit this? Ideally I'd love to get feedback
> on individual drivers from the respective subsystem maintainers, but
> it seems rude to have a 20-element patch series that gets resubmitted
> each time feedback comes in for one component. If we break it down
> into separate patches for each piece, what would be the best way to
> ensure that all of the dependencies are merged in order?

Well, I would first make sure that CI passes for your tree. Then, make
sure that you're using OF_UPSTREAM to get your device trees as well.
Then just submit the SoC core + board (and make sure it's using plain
text environment and standard boot and so on), then start with the
additional drivers.

--=20
Tom

--HHi5Be0rnoYAn3hE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmYF12MACgkQFHw5/5Y0
tyyrkgv+NObqTBFUG4drVwqhqzExmeJsIXBXf1V1S0/752uMA6d8SKgT16XdkZ8z
BQ6dlVza/8BgXaO/yAX+M1m64BTihLR0lYVcjbOI5qPjdnFz22qzdw+kJ+SO4Els
g2eiutJx3t6WNoD4XM5v35d2XuCIWkStuJrhh2DauyKySOIEbk1Qv0uLAVdosE30
zeMUNqXmjZBzidFLaOXWuzDfQhuezMaAPQoILsqV18g6kFwVaFL31rQHJ1zSC6lO
U06y9vePj6813XvDwmJErX0PtLzhdkbAyfsUP11svz/azgO4YE0o+oHE/Uzv/Cwe
z/uvcmPo5plav1vHVkvMABE0Mx09ITcH9gmA5TBLYnjTzI8b6ZGSHgfBsvcQoJYl
yWyB1DCbjry0Rah71DCvAaulSnPzfAlxainy+MTEszwzwwqownpJyySfTUgjia7P
Vu+I6iZq5QsKoXYpuUQ1ZhLoov7aAi0g+iBFqF+C75FowCQ/R3Sw5jGLEvC9EFRm
nyv0h2YP
=EzA5
-----END PGP SIGNATURE-----

--HHi5Be0rnoYAn3hE--
