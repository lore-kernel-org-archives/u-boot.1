Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F94ACDB47F
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 19:24:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D04C186BDB;
	Wed, 11 Oct 2023 21:03:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rt11TMSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9611386D80; Wed, 11 Oct 2023 20:40:12 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8EE0E86DC7
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:38:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5a7ac4c3666so1904257b3.3
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 11:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697049472; x=1697654272; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ftQaTLJki4XXPNOJl0z0RFLuuJxGSTtFF282tat+qaY=;
 b=rt11TMSww2IcGKwHcGQ/rF0gDf5FsLVbLtoFyHcapSvnUjbG7lkxDZhXrDzzL4kFeE
 oZlYJyJSufYFjWo3qDGBoMhrYeJAICQvI2tWtVp+9nHDViTFgFR7gA5Qx/ICHFEj5AG2
 beYrI13Fo5Bc8R+gmHaS3JTOc8mQu+pfg0ZxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697049472; x=1697654272;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftQaTLJki4XXPNOJl0z0RFLuuJxGSTtFF282tat+qaY=;
 b=s/zUTWsS3gMG4fiSrZsllRPWH6awN8DC/6wo1NTlVe/EOLk/LodWblfwBOlhmOJluL
 ihOZn/0GlLUnAybsClv+QGWvYZu+bzojZh1dciFjMmiv1rBVR5yPBzMTWrq1B3lHD+GN
 JKtucK0tiUmWXp1S5VqsCytSAZ8DiXozmlqlsh4QGEfe3OKgPVA0KCSxOuLQ3E2uILJc
 /FGANURWnDk8vmTnnBF3D7xIkwUGMx9IImvQMsJpp0ixsLe/WrMD4g2B6oQiDYgFiMpB
 1DlW0e6jx99UbsBeF1Nsi/Z2y4MQANAG2diXpRNjMT2htK6D2sgoNsROnWy1BJp3vLpD
 nhmQ==
X-Gm-Message-State: AOJu0YwvdzprcgKOh2Be+QzZjKuz+5qg9Fl8U7yNuBPTLHflAMb1UBuM
 l1OoZCa3UaOJZKssKgnT8LmKlg==
X-Google-Smtp-Source: AGHT+IE+HNq+apznJKsNYupPLv2ncoCW7cRr9eNORhJ8vgKO2Ju9yeKbW1bluULscmwLP5oFtyhc5A==
X-Received: by 2002:a81:5e02:0:b0:59b:533a:485f with SMTP id
 s2-20020a815e02000000b0059b533a485fmr21665708ywb.52.1697049472234; 
 Wed, 11 Oct 2023 11:37:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-2621-cda6-b3e1-0b3d.res6.spectrum.com.
 [2603:6081:7b00:6400:2621:cda6:b3e1:b3d])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a0de211000000b005a50575b1c8sm5310740ywe.26.2023.10.11.11.37.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 11:37:51 -0700 (PDT)
Date: Wed, 11 Oct 2023 14:37:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] bootstd: Drop some TODOs
Message-ID: <20231011183750.GY3119521@bill-the-cat>
References: <20230825013930.1753078-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hRS36taihE+7dCFc"
Content-Disposition: inline
In-Reply-To: <20230825013930.1753078-1-sjg@chromium.org>
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


--hRS36taihE+7dCFc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 24, 2023 at 07:39:24PM -0600, Simon Glass wrote:

> The existing TODOs are done, so remove them. Add another that came up
> today.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--hRS36taihE+7dCFc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUm630ACgkQFHw5/5Y0
tyw5TAwAog84/vmB9JMtBRYErRnGNHrn4Bd1S07i8Lvsm2qvVaIty7qL+nk5BWVS
BhVzJnItqDfzZCEUyk6ZRxojaoNLPsFM38jVB8qN91qAxKoN1gPSHKArowl1tlcX
JnG6358zwzXi2HX2agBSRd9z1lzDtI787eczkQiLPPSgYzphX976Kf8mp+BnhnF6
bqo0/fsyfyoA2b0Q6EV+qE7atfOfl0ijYJRmNERV/PY6Izx71gs4Cjck5yDGrKbo
sal2cXZLRTMCiVHfQUbA+tfyeBwsC5m/agDpwM343R3jmspAM5gMEV5iJYdd8JDB
LAe+cVr4O1o9eLpMUr++zSuBGm99tSkMc0bFpzlgVjD6R4eTP1BsldsP0hxQcnuk
82lyMZpkpu8nX86fvdjyILA3zjWbHiwLezIbI8U2amWtop9K09eQxBEj+lCSXgzd
0yTQKPjn95IioyAfphttwmMRmHUyoKiGuzuhWDv0PMpvS3vFklT+bcD6uYaQShtK
pEJmhMXz
=bZrJ
-----END PGP SIGNATURE-----

--hRS36taihE+7dCFc--
