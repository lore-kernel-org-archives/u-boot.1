Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843C0EE14C3
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 01:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90E19869A3;
	Thu,  7 Sep 2023 03:52:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YSM25evI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6CD7A8608A; Thu,  7 Sep 2023 03:52:52 +0200 (CEST)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B656086682
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 03:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-d72cf9156easo450634276.0
 for <u-boot@lists.denx.de>; Wed, 06 Sep 2023 18:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1694051568; x=1694656368; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2tV4xSC8d+etojYg6TmjnrLXinIo1JjK2tSZ/iGC/sQ=;
 b=YSM25evILZQZRTDnJKyZW38pZH8QXg+FEJF0CE96jWXqiYbsl0KDI3Q0ttY3YvJzis
 7KVnUSrocgDu/YEYli+KwDDwx/JiIRX/oYdR54sRDaz+6DU7CWYUAfsthdaHd97lNt9E
 f2GhWQ87zUz9uzex7B6FcFtPRAnqtwukpDUq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694051568; x=1694656368;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tV4xSC8d+etojYg6TmjnrLXinIo1JjK2tSZ/iGC/sQ=;
 b=UjV4v7ubHIDLXJ8ltd2nGkkYvOmXaE86F/CQV27dBk4D5c/KuTVQwtc1qHPOhCd6jQ
 dqFJfK0TFQltFns5Efoun125HdP9sNxtZvAmHGTnRp0v3emClAPHu7nkDS/cuauFu0GP
 lj6q2VWKOgUQL2RRIpMvmI1eNg8nUi+J/1MZAZud/OIxsn+/FpirZwe6boTT3nEUd3nG
 CWOJ1POCtU64vUW69rAomaWQm5JXcCHeNzBHHIrQl2zT3AENgFO9hafEPbu3Z3KYrDlu
 gAgM0DlikJ1R57iu0u9xnBRwZAoUKd2IBRQazxARzhodxGQXCtPTQWksVzXDmBnh3OHm
 awHQ==
X-Gm-Message-State: AOJu0YxfRa7kWafmERzyhy5socd9qAV/IYgipqjxIWMKaKFoCjLRVnWI
 MhPQ0sLsrjucZPHR4RrL4c4btyuAysBs8wY+ZgKskw==
X-Google-Smtp-Source: AGHT+IEsPfd4FjCGvkxZZxSm+AUNDoticZtMO3J3atsWLysg+EZNTvw4I7df/otBipjjRbaU+b9kPQ==
X-Received: by 2002:a0d:e255:0:b0:570:28a9:fe40 with SMTP id
 l82-20020a0de255000000b0057028a9fe40mr17650539ywe.5.1694051568255; 
 Wed, 06 Sep 2023 18:52:48 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-27f1-c90c-e8ad-e559.res6.spectrum.com.
 [2603:6081:7b00:6400:27f1:c90c:e8ad:e559])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a814e09000000b005928d602f44sm4110032ywb.31.2023.09.06.18.52.47
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Sep 2023 18:52:47 -0700 (PDT)
Date: Wed, 6 Sep 2023 21:52:46 -0400
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: Re: [PATCH 3/4] CI: Combine tools-only and envtools jobs
Message-ID: <20230907015246.GM305624@bill-the-cat>
References: <20230820173129.781985-1-trini@konsulko.com>
 <20230820173129.781985-3-trini@konsulko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yJhlNeZt6eS6alXu"
Content-Disposition: inline
In-Reply-To: <20230820173129.781985-3-trini@konsulko.com>
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


--yJhlNeZt6eS6alXu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 20, 2023 at 01:31:28PM -0400, Tom Rini wrote:

> These jobs are to confirm specific build targets, on a Linux host.  We
> can safely combine these two build tests, with a make mrproper in
> between.
>=20
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/next, thanks!

--=20
Tom

--yJhlNeZt6eS6alXu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT5LO4ACgkQFHw5/5Y0
tyxMJAv9GDTSEltNY56rAbR9Ta8P5lBn60HulrcI+l2ATCHYSpOsYnbxFKmzaQZR
3/x4WwbAxzMLT0O7sT6GWIE+FqGEZ4HTdrXiPif8uEOpBXIiYPHOmrXuyATO8Eo6
HDwTn0uBP0I8zdFho3v0kbQwxvniLbGh7UImkbtokLnaY3uYLNOH6O+6cloP/D4L
Ly7JeXjXYsn20yeaGdnBSkpKUQk19HMQtLKTFENPTtl5G1mbsyF/NJDOsHhXc3ci
yH+HuhzX2kUG04ZACdhaFkd8HKXFFE39H/TRVHoWP/EEMwUywqtHIV8mH+CG5Rgc
oSeOX468qGy0oWYPOxCipGUSFsKnn88ONlvB/0l+iqFrGm8dZeZbiPp2sDcEtzXQ
wH/JUcc4DyydmcDifSn2oaIsoEfRwaSsvWexwCZujwbEeWejKZ61COVtkR1aF1b5
Ftvnt3CDBHVLmoFXM1bHob8FgIiiRv1dKYVMMtSypm1iwZgThoKiJb9Kc1R82bp/
jag/1geS
=6z9m
-----END PGP SIGNATURE-----

--yJhlNeZt6eS6alXu--
