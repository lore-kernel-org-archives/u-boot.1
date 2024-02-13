Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A254C4829A
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 22:33:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C82FC8798D;
	Tue, 13 Feb 2024 23:33:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="XQQlzLBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09FC687CAB; Tue, 13 Feb 2024 23:33:08 +0100 (CET)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AFBB877D3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 23:33:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-dcc80d6006aso1172417276.0
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 14:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707863582; x=1708468382; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hA27j+3rJPFDJqjHZJ6GUhvYKLpFzRPswGOmSJBHKZg=;
 b=XQQlzLBnxmlprDbxnbVxTGEzfuv6fQwAD3BvwcE9wdG41bnKwQlQ5Rfi3WSgT739/F
 VmumpFPChV3kJ4WgUwrbpDwl3vlCP9YJGZdqlWimV8wscedKCrI1szt46XExtlRqK2yZ
 fQRgGhFdk//cWUaXkwqx1MXnC9AoxLfkCWMKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707863582; x=1708468382;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hA27j+3rJPFDJqjHZJ6GUhvYKLpFzRPswGOmSJBHKZg=;
 b=kBKOEO9jxfzC4+0EdeWijmsIOeqXAMwoMPkFfb9LYNvckMo002ulH82uGbqgiBByh8
 uaXEHe4vVqD81SqgGwWjejXlx3ID2jdPuwAFovbJAhflmMOs667478Yn7KA4D8hR1cI0
 /sLWDDPB2z/UeEnaxCYDZh6hDpQOj32HvipiLH8Mat1sMxR9hoxpzkymu47poG7e5M8a
 cAFVYU9Pj1SF3sVUySqUbzWLLMXoqxbljFut6yS3FVgTBWa+gfFNRQGnpphx2FrUplwI
 Uu5/JkYaLu8LGxZnA4zudITVJIcS0ggV4A4E7avtk6ZVK1x362VI/CtWxg35PUzLUILq
 vzXg==
X-Gm-Message-State: AOJu0YybVI6Z8QjJYXKaL3AKw8gTt/TB9omUcRWwrdGCQANohOQbBeGE
 wKBqPrbHCVl92ib3swtCPZptkfw6erUOCkhSuc+0AS2pXMN/X2WTZx8sv+t5Cpg=
X-Google-Smtp-Source: AGHT+IHqPPfcqLg41sZZAjarp+/iok4z87x0IDwSaKhKq76EtYzoYmCSvIhAGlesJz+uIRkFWuo+qg==
X-Received: by 2002:a25:9c46:0:b0:dcd:551f:1d9 with SMTP id
 x6-20020a259c46000000b00dcd551f01d9mr565611ybo.54.1707863582310; 
 Tue, 13 Feb 2024 14:33:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWLNQuOr1/EDWvWkW/+f53vu/YPOworEHpWDVXr9q3zipfPriLPvysepkDD5CSH04LBiYRNhvjqxu80tWxyJxsE89F+1CtZKxtqOoAoLvxFa3wFg+2ysLkilwbqnQSwfWlMoLMBIV4ofB9PdrDlfCLhblkIdLS6BBMiuLNuRQKn9f84WgPpDuOxBIrUrSgFOw==
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 z2-20020a256642000000b00dc22f4bf808sm1824435ybm.32.2024.02.13.14.33.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 14:33:01 -0800 (PST)
Date: Tue, 13 Feb 2024 17:32:59 -0500
From: Tom Rini <trini@konsulko.com>
To: Igor Opaniuk <igor.opaniuk@foundries.io>
Cc: u-boot@lists.denx.de, Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Shawn Guo <shawn.guo@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Igor Opaniuk <igor.opaniuk@gmail.com>
Subject: Re: [PATCH] poplar: add myself as co-maintainer
Message-ID: <20240213223259.GU3040305@bill-the-cat>
References: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+r1EifRwP5bVfVTi"
Content-Disposition: inline
In-Reply-To: <20240202214429.2185563-1-igor.opaniuk@foundries.io>
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


--+r1EifRwP5bVfVTi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 10:44:29PM +0100, Igor Opaniuk wrote:

> Add myself as co-maintainer for Poplar board, as I'm currently
> working on it (re-testing releases, addressing issues etc).
>=20
> CC: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
> CC: Shawn Guo <shawn.guo@linaro.org>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@foundries.io>
> Acked-by: Shawn Guo <shawn.guo@linaro.org>
> Acked-by: Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>

Applied to u-boot/master, thanks!

--=20
Tom

--+r1EifRwP5bVfVTi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXL7hsACgkQFHw5/5Y0
tyy8ZQv/VL+O08bji+pb1azGwKp7InCpUOnf2DV09YIr5IZGC1k65iEWzjqX/Hm2
EvYQBq1CijwNSBXJ81cl3uDRHtOYoo4vL7yGtQB2GUnhyytFogTksVm5NK3mQRNN
oN7RVG8nqPIqYEOA39+FsbQA+Ek8fswUs/p9kk/gpS95aOmSSd1HcRDmhubwxMly
tCGxHXtVigqsfQytZoxETZDmcvCPp07tswUuxkvda05FU8nNx9trQDimUq5UDB/0
mVLaljE97buH2eOgUO3wTT8NpR1jI5GIYpD3ZVjOYFJTGo533uw1pfrpLdjfFCCx
6W8pgfTAVXjSRPnsRCYd2GMalwNsWy2n9dyfDmFJJE1eFcmT6Ql/OUUwg+JnLqau
REyEQ4LNw8oPjZsQ19WRocFQ2NAnIoT7moPzfNMRkvN5A3kdGsn9HXjMRf5jJDTq
9tTjBaBumic9yUO816POljJXvxJZPM/zIqe8m9opax/WOKyrS2DWu4UA11gqwlnZ
GNh3iu1/
=vzVn
-----END PGP SIGNATURE-----

--+r1EifRwP5bVfVTi--
