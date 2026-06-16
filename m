Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44688CD98E1
	for <u-boot@archiver.kernel.org>; Tue, 16 Jun 2026 16:39:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D26E84869;
	Tue, 16 Jun 2026 18:39:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="h4MOCC6L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DEB1184895; Tue, 16 Jun 2026 18:39:40 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EEC508484C
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 18:39:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7e71dd64ea2so2797743a34.3
 for <u-boot@lists.denx.de>; Tue, 16 Jun 2026 09:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1781627977; x=1782232777; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IS+wUkuWZyyYEQl5GPjQSGoJC0oef5ralxU3WJDHjrM=;
 b=h4MOCC6LoqIzT/9jhCc4SnjxTj489MD48lLEHNHvDYbVdJHvd5y54/v34AGZ2rIeDr
 CY44rwd3K5lbmDJRMuOQ0bJD8oZeYBt3rizhPFOAz6KxaHl0keNrtt53IYIPpEYsrIK3
 Bknn6bZPJ98OK4t3LZiHaeXteGtvyP6lc5BAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781627977; x=1782232777;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IS+wUkuWZyyYEQl5GPjQSGoJC0oef5ralxU3WJDHjrM=;
 b=Zl/WMrvi9fHNtfd5mbUA9BnYqZd8pI2gfTi0uMtWR58MAztsaUBJ2dBDTl6RSoElVp
 Dwl2awPed+FXMnieimbO4wQ0t3Yxj2ZiK2sNDSeah6Xpb8bUTU5OSglbNxLM3wSRh3ar
 +B7UBl9gadWq8OvopqN05gxs9djTpPMdFl9CqdEdNBiktPT7OJWzNMDbH2ZbNojftjmH
 rWNTYbNryfXl5fUNtItHWJHlPhkKsQyBbKbhIDfcEeCL3zNosi0gYEgGKQzxlDKtjjCD
 kIW1qa37RnY1SdLNX78MWmox585P1V0YQuxpnfe8wj1/4VNGRLBXkK81aamLf4Jn6dsY
 qwnw==
X-Gm-Message-State: AOJu0YxQxshUbXMbb8aPhK7H3dS27y+jRx3BtC9q74dRsGkSl0By/vzG
 n+mCTsxhET0fXyRJozSEnfBg9q456Qk+xLvfiFb0N0vo6Zyrkjslmv6EgZTDEQc+vvi4xazEMpp
 pxvmRS5c=
X-Gm-Gg: Acq92OFfmOBsYiRg/uKOJcOSgIchlh21MFkRo7bOX0R8Mwiaf4x2EDWbOzdnpG7YvSR
 zFwsyalLNeocBsdEOakBktBfMu5mXDntM+pYvfFIFR93RnhxxmY7Bha/rumFpEXfCmpJA7gcHzg
 JrGw67Rs7oM3UiB4qf6UfJM4Oz1Jn9ARc+rjRUCuiqO+JkA+7XKDObAyHHpyEqF3ggPD6z8bHeu
 JQdn+1yNqcNVi2dvsevJ5Zzw/UGwmK1zOYQFFfVgRXs0nvTnHjYwmQzXUeKsP6YBGkQyxnfo5Yr
 JHn3+xqgvRj82sRQxMT0m4Eqknlw527bii7Y/m8acdTXprsfrnfuqRUBh+ZKBnHfRgMLHNU3r9g
 NSgcs8X+NLt8VtjBA6Rq6DdVrcRim6YNNfMYey+t1k2R/g1qQwNQ/LqsZl5ToVKS4l7drDw9sha
 RcqOwAxv7WlRZCJaE1n02VU+zqfphYaFo6+MVYcw8gwhwKe8fB/X6vU4EshMPSijze8FzxKe+t3
 NnW7uX/knroKIPphTUD8pAaxGXGQP3RBCBoxLbPcKVl7sSpO/Qwae9A8BM01Q==
X-Received: by 2002:a05:6830:82cf:b0:7e6:f2ef:e232 with SMTP id
 46e09a7af769-7e90b468d1fmr337275a34.19.1781627976668; 
 Tue, 16 Jun 2026 09:39:36 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-245.totalplay.net.
 [187.190.197.245]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e79f451fe7sm6982192a34.0.2026.06.16.09.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 09:39:36 -0700 (PDT)
Date: Tue, 16 Jun 2026 10:39:33 -0600
From: Tom Rini <trini@konsulko.com>
To: anoduck@protonmail.com
Cc: u-boot@lists.denx.de, e@freeshell.de
Subject: Re: RFC: [PATCH] PinetabV device tree file
Message-ID: <20260616163933.GM382693@bill-the-cat>
References: <20260616131946.404766-1-anoduck@protonmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Aiaz3xiuNiekA0tu"
Content-Disposition: inline
In-Reply-To: <20260616131946.404766-1-anoduck@protonmail.com>
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


--Aiaz3xiuNiekA0tu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 01:21:23PM +0000, anoduck@protonmail.com wrote:

> From: anoduck <anoduck@protonmail.com>
>=20
> ---
>  .../src/riscv/starfive/jh7110-pine64-pinetabv.dts   | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>  create mode 100644 dts/upstream/src/riscv/starfive/jh7110-pine64-pinetab=
v.dts

As described at
https://docs.u-boot-project.org/en/latest/develop/devicetree/control.html#r=
esyncing-with-devicetree-rebasing
this is not allowed.

--=20
Tom

--Aiaz3xiuNiekA0tu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCajF8QQAKCRAr4qD1Cr/k
CoaUAQDeZ3xwYJFx7J53sWw+tQ7/gHcS4FWUGf9nvh+p02YI8AD+KTTaEtFbMXT8
i7aEzJ13qTB4Jr2EYSSp2feZuQAn2g0=
=Kfr/
-----END PGP SIGNATURE-----

--Aiaz3xiuNiekA0tu--
