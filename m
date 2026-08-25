Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE942C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 23:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 654C940758;
	Tue, 25 Aug 2026 23:06:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfc9UO3AH8yS; Tue, 25 Aug 2026 23:06:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787699198;
	bh=pElZk7rpuNL4/3w4baRs2PFAi6HXJxBlr5UagthSPus=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Rmr2e2Cf5jYNDP4rhCO29O78qN8ecrsNpSvrr49dr8jqutFRKiWOGEpaQvKJrpgsT
	 H8qJnKlMiPSMFIN3QNWoUbX3FMAT1CygHr+GuTEH2RPW9GjC7KD+O44boF8KOtk4/j
	 JlCpBp5/73wU5abekYcItUUEyqwjZDl1CocG7osK+pENoekIQ3n0XxS4x2Vz6dkwbR
	 /hqjd4dt8D0yXQs+TVypMJd3wlWwHJE0jykeo09huQg2UzAUXa67YYzDkgMB8eTTXx
	 sc0SnzC8FW4Owr+4xiC4Qlpah44CGLpsDa+zA9ncgo6Jqo5cJLt43Awi4XlouYSaI3
	 s6ys0d9HMO1lQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6221406EB;
	Tue, 25 Aug 2026 23:06:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C6AB1334
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ACDFD40055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:06:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SmCEGFb771dQ for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 23:06:37 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:4860:4864:20::2b; helo=mail-oa1-x2b.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=AYQk/NIy
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F19A74000B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:06:36 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-44caeb973b3so31620fac.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787699195; x=1788303995;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pElZk7rpuNL4/3w4baRs2PFAi6HXJxBlr5UagthSPus=;
 b=AYQk/NIyCHK0jrFRSGfi7hms7vxtd5PAxAh+uWsKqhNLcOBfAuEcP/HURAjvFg0KWU
 RraMuzW4DsGy+gLlG0k/X4BNr1c00N+ZY6XOTJMJYGAX65MxBdUQsdh80MwUHdPb+oxH
 m+9yluL3EgL4a4JK1/PPToN1d2BqvRdeur5Pg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787699195; x=1788303995;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pElZk7rpuNL4/3w4baRs2PFAi6HXJxBlr5UagthSPus=;
 b=An11zuJV4Gf1dlX4huzjwnI5zfBRTGXFhUgh0a62n69PKwoU3399ZaRLXODP1lLtE4
 u0iaIGfUQqS+/Za7cglwy/FBIrHCqtm/YKwbs3cFBQG+Er74dVDhTZIl61fj/szfHemX
 SwsunGCJ+ihLQ9rVD3lgxaMXIw3PxpJkqJLwHQAbqK0QldFvQ2vS9uublyGH4Jyv3E+7
 Wumihg8vDQgRyjAHr5JEyP899sHDL5sWnNWaDuLgw6jqTCZIudKjcvR71v1mvF7nGOFo
 1ZIUfgGXhsoAMrIdak66p/9HoEvaWeSBwVpCxVPiQHLsxROU/V96PIlWOqyCxTVlvGBP
 dxlg==
X-Gm-Message-State: AFuF++lPljstVKdaqQjPrnyMuzlYUZjJTF3ETmV0NwCBM1K3FeTG43yw
 TFDVmU8j4O+2gpNEyp28PNW07w26ItHc7OjbCmFNqZutIwC2Mn8qQMqoQi1yv5JxwX4=
X-Gm-Gg: AR+sD10c4LR0XcOhE992WjpHbG/NXCT/6ilAgI6j9Rsy3y9Fyt26vydpqYUq+tWBA8B
 0Up08JF5y6UG4DqLemXRi0B2Fa2WOIBA2IKVbaHvKPAPO8eRjj96wp1JoYlXs+xVeKWwIFuIbvk
 LaaNQ8T5WwQeu9UxmUqh7Wl9TtApMElPjWIyH1hZuP0vxRbYp14tyJfzC2/FQBka7VCdZZgpbl6
 BdtFG8DXeSOqHf4huGeIxHq2NQzWV8+TNvAueE0CThAoM3bwB5Y5d6D+I+aHBF33BhkuOLD4ccI
 JIE2kO6nHlf7iTTq+J0TCFa44G44kW0r9ov1XUELl9iuaTMXyTLwWwngn/Tb8MpiJ03xcT4GuX3
 4TlvA33YJJU9q2N4x+3A44lcuwjJcvFoiKlkienXRYIiBioYkpb1kEyv4yY4ZPlBzSAXJXHNTZs
 5lUETqrRZl80/RQGQOnu/C+rLVgX1ywWgMAn3tRL04KsAKUxeh0hskY+e9X32JdfxzDL6z1hVT9
 1eG/SSgIF9NHdmFnw4fJDyxy4wStPBhLFbJPWUAWUqhJsg6pbHO0PBDP/+gQ2QQ5YWJPA041cvk
 PgYbroFY/7qFW2DH93/6
X-Received: by 2002:a05:6870:9f81:b0:441:419:1fea with SMTP id
 586e51a60fabf-46599a255dcmr3775673fac.11.1787699195416; 
 Tue, 25 Aug 2026 16:06:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-465ade707ecsm691540fac.5.2026.08.25.16.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 16:06:34 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:06:32 -0600
From: Tom Rini <trini@konsulko.com>
To: AK Sharma <maskachoska@yahoo.com>
Cc: u-boot@lists.u-boot-project.org, Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v1 07/12] mtd: env, cmd: add EN75 NAND remap handling
Message-ID: <20260825230632.GK523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <20260825224330.713151-8-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Fftx1C7MFy90pd1g"
Content-Disposition: inline
In-Reply-To: <20260825224330.713151-8-maskachoska@yahoo.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org


--Fftx1C7MFy90pd1g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 04:12:02AM +0530, AK Sharma wrote:

> Honour the EcoNet/Airoha NAND "remap" region attribute when reading and
> writing MTD partitions from the env and the mtd command, matching the
> vendor block layout.
>=20
> Signed-off-by: AK Sharma <maskachoska@yahoo.com>
> ---
>  cmd/mtd.c   | 30 ++++++++++++++--
>  env/Kconfig |  2 +-
>  env/mtd.c   | 98 +++++++++++++++++++++++++++++++++--------------------

This is another place where I am concerned about a lot of changes to
generic code to support a specific platform.

--=20
Tom

--Fftx1C7MFy90pd1g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao4f+AAKCRAr4qD1Cr/k
Cjk8AQDVVk0DfqaHiLNM4h6vTc5+UtBzAFDcYDo84DJD9/9v8AD/SiZzxzEzTxcq
A1OPkh6ErV2tuEretsWGk+0ybpG5hws=
=9Ual
-----END PGP SIGNATURE-----

--Fftx1C7MFy90pd1g--
