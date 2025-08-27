Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89D8CA0FED
	for <u-boot@archiver.kernel.org>; Wed, 27 Aug 2025 14:32:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A336831BB;
	Wed, 27 Aug 2025 16:32:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OwvOXwgI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1DAD831C2; Wed, 27 Aug 2025 16:32:14 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF2B7831B4
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 16:32:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-74381df8cf1so2327351a34.0
 for <u-boot@lists.denx.de>; Wed, 27 Aug 2025 07:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1756305131; x=1756909931; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=H2QPU/vk+zU9lZHAW50K5zLEdai+LIx0SRi111t/V/I=;
 b=OwvOXwgIyAMjdnPE36WlLMLzM7wrK8VbLUyB0IWqSjmsqEtZQkQ8fo+NdD/onjcMZn
 Nar3ZNlvCrnccCpaITS85l0si3sC+/05kcWIFdK2WOz51ouS1m2DOYP1oip4H8+9c+Kp
 7ydAZ88wunCB9qdtRAsYwcL6iabHW3FC0UqgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756305131; x=1756909931;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H2QPU/vk+zU9lZHAW50K5zLEdai+LIx0SRi111t/V/I=;
 b=PRaBTHXuY8F5KIy7MLomtzL4p2VJzDm/0sJyxikdlJghe4ZEtNTc3cC1RtqupJapcM
 dR1ZR6O9bDekiLRsetH868ISS45hU73qqGYMgT1JRKZLrkdKDpYDXjdbukm/YVLX8koA
 fEUPyGLy/S0NksJyUMu8Ta03IiIhPJQUVAMJ7T5GtyX5dDkPIpXG9CDAXUDPFWsBkttN
 23bk2O7Q4TGXPfeXd4jXBEr1TAVNYPcuczXyo36B+uw6ld2gYHIdBkTKJyUBazC3rLB3
 JQOvw8tNqBXhNopAw1gv1RNDdBVcrSJikkX4H0/6oaGAMJKrmO2IbKB9L5iR3G2Vg6Ps
 u3nA==
X-Gm-Message-State: AOJu0Yz09t08OJmUDmyPEQzVswfundDwyFS1dcivrg7nEziKxThRtMcM
 /rTEyU8/UomwJCDGxwvUnVEGfEEQrg41Gwn9lODk5cVaa/TkohkuM43tpVWKzjg4NFN2r1OME9m
 LhzaDyuI=
X-Gm-Gg: ASbGnctDzCVZsIQmy2rxIMEJ6JveVHcq+fbXKD9U99CtQmEaULFftaJQs+2wcRPLtnc
 0ghB7P3SH8De6Mnz9+f04iP0DmoLrapS8mQLlUCOlI/mUJ52ur5bTLSSKgBupubxmcK8G7bab5G
 MqNAc5TyahEzxd7/AbiNAWOZVVIeaDoKJwL8kqtqB8iEuVjc+1C6z68AZSCLg0eYscLNKiqC1QU
 abVlw3ZuQbJZkPaTdPO6MDRvmxwJ9TuknEc82QzT7PaaWVrJ/vAHrUjbEmIBZXYm47BY2KdrQGG
 ypvFTWVFyczllecYlMRvUGpNtELpKshLCgcp527go+2069vwPr3fMMofKKVLYsW+jbW3UsW6cuz
 2Iu79QXXVkaxF8hgcdNs8TMoeGgpFTJQvcXwmD63Lcr4MWujKX75xt7cqU8ePJnJBzY8=
X-Google-Smtp-Source: AGHT+IFcfxQS/oS5qMk1xCMxpAD2FLH1s0x4O33Yc+r4IYQZXK2qd19LO8GdnNkrN9++y33Jkb+ccQ==
X-Received: by 2002:a05:6830:2992:b0:73a:6d48:dec9 with SMTP id
 46e09a7af769-74500900eaemr12554144a34.4.1756305131378; 
 Wed, 27 Aug 2025 07:32:11 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7450e4738b8sm3004989a34.32.2025.08.27.07.32.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 07:32:10 -0700 (PDT)
Date: Wed, 27 Aug 2025 08:32:08 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH] fs: ext4fs: add CONFIG_EXT4_MAX_JOURNAL_ENTRIES to Kconfig
Message-ID: <20250827143208.GG124814@bill-the-cat>
References: <20250826194537.20788-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="CW21QqWwsuz1kIr5"
Content-Disposition: inline
In-Reply-To: <20250826194537.20788-1-mibodhi@gmail.com>
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


--CW21QqWwsuz1kIr5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 12:45:37PM -0700, Tony Dinh wrote:

> Add maximum ext4 journal entries to Kconfig. It is necessary since the
> number of journal entries is proportional to disk capacity. For example,
> an ext4 4TB HDD partition could require approximately 500 entries.
>=20
> Signed-off-by: Tony Dinh <mibodhi@gmail.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--CW21QqWwsuz1kIr5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaK8W5AAKCRAr4qD1Cr/k
Cr+uAP9/IiHPs51d4l/F6WEhktiWkg6m8zxWxASJjf6B2dlzlgD+IVNqJD8s4VwR
KYRwvxgShTlieuXy7YbJRleQJqpphg0=
=OL2Y
-----END PGP SIGNATURE-----

--CW21QqWwsuz1kIr5--
