Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C681DCCF9E3
	for <u-boot@archiver.kernel.org>; Tue,  4 Nov 2025 21:18:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2062E800B6;
	Tue,  4 Nov 2025 22:18:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dZVmBPJX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD96800B6; Tue,  4 Nov 2025 22:18:39 +0100 (CET)
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com
 [IPv6:2001:4860:4864:20::36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C50D8004F
 for <u-boot@lists.denx.de>; Tue,  4 Nov 2025 22:18:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-3d2ea93836bso3394629fac.3
 for <u-boot@lists.denx.de>; Tue, 04 Nov 2025 13:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1762291116; x=1762895916; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=SVC79is9J9DFrwjENUkWyHHxvSetXVfGi19eIrm+bzY=;
 b=dZVmBPJX5nEYinQQ4TQ+Lv+rhCSfXLHMC02N2cPvwPAV9MSua6lWsAPDQinkhA/5V+
 C9Hfly4hVStEe18x6c4uDjNaVHAsYleLfix2umCIfhIWjALJVFG6tsHgTLIF6Lrfznt7
 D5VoJ5IN/JOhPQmE3r2a3Uu1HbXV5voDei6NQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762291116; x=1762895916;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVC79is9J9DFrwjENUkWyHHxvSetXVfGi19eIrm+bzY=;
 b=HHHvkTVdgUNoYJu82mqoJqFhyZLnXcwOmbM7Z0Il1NoaMrYI0gmnkdzeo8XJl9WLV0
 HptnmuxAPiB6g/KcgLLB6l+2zv1aWlpUUjy7H5MqeTLGvBdxYBviBLKwARBv2zOLMXCG
 Go5GLTlkyb9dOWL8Ap2qSxxC5oV4zZEdXOhmpDjno72q/K1zVqJTBgR1y+ojUehZQ6At
 pT2funDzKUnhacUo+rqCKPjfp2Krtr9gyR0Q/sM/nvFn8AMr33VIZKKZdWRmSNUGPmCi
 MA3figs3XrLfFBQwlNZa+ALsJIOnLZ5QRbZ4+XMm+Lkhme/PgdLO0fPNl0U3kG2h622p
 FtDQ==
X-Gm-Message-State: AOJu0Yxl9+w9DCRsD9biVR2K7gdu+HZkg6a9kvvW4cMjF91Su3Rh8zL9
 5z1417oDFRPBDpp2pcBc4gCdSgvwYT+2yOTzWzVfZ6euNWhwGFYHR7DycPkuRW8qF5B0wk88e8w
 sUb+EjfasOA==
X-Gm-Gg: ASbGncvJqBV67GUiObfZsyE0lgKvrehgNeddltx/Up+LO8KxkhCXZEdw/m82/voPslQ
 SW1itEax8/y3yGCD3JEvqk6RIZ+ApusBC71nMt4a418s0yg7brzsTd2TiKl7VuI0RQ9iELMqFbP
 gOYEAmXvCXmY1vPJKZydB4QnzDzmLkq+XjOoiPde8z6nDtrT92y8ydvHkKACkLBC8ckiuff4ilE
 iaFTz7LOnOJbI8h8TvbzvEB8oYfAsDAuc63Bc0n5mw6vue7uT2r8FS24yn/YPyNnwbcUiHiGY8Z
 GpBRlCj8jXBLVaQqSC2OTRafcWhUP4D3Y/GzvzJ6dJTlloKE16CVmcP2+yaWLuyheO6b3/Q89OR
 xiLhAy2VgHXmtU240mayLXSuy65oTjaSsVpOCcPVgHfrcLrBJxORthPptZTdr6UUdpLckXC8QLx
 tAdG1i/bBAwIebguUcc1qZWQN32ssvq4JwBbJwRNw=
X-Google-Smtp-Source: AGHT+IGBcCvAbuFzqgYhCbsOQE8GCAGw57uGH2ufVvpJpdVeGz9V2BUgwKTJHXPops44m/aXiGGisQ==
X-Received: by 2002:a05:6870:c10f:b0:3d3:5fd8:a464 with SMTP id
 586e51a60fabf-3e19b20db55mr371639fac.35.1762291115752; 
 Tue, 04 Nov 2025 13:18:35 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c6d3637067sm90022a34.32.2025.11.04.13.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 13:18:34 -0800 (PST)
Date: Tue, 4 Nov 2025 15:18:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Sune Brian <briansune@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH v6] Add optimized Makefile support for SoCFPGA handoff
Message-ID: <20251104211832.GI6688@bill-the-cat>
References: <20251104010003.525-1-briansune@gmail.com>
 <20251104175123.GE6688@bill-the-cat>
 <CAN7C2SAvyfUyTqy8sqKxPWPG9Bu+aYiXGjMzfVJxR+mc59TD4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="H68/LshY3D5vE2AQ"
Content-Disposition: inline
In-Reply-To: <CAN7C2SAvyfUyTqy8sqKxPWPG9Bu+aYiXGjMzfVJxR+mc59TD4A@mail.gmail.com>
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


--H68/LshY3D5vE2AQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2025 at 04:42:55AM +0800, Sune Brian wrote:
> > This should be able to reside in arch/arm/mach-socfpga/config.mk and so
> > it should be moved there. It might need to be done under "archprepare".
> > That would also let us gate even trying it with an ifeq, like we do
> > currently. I also don't see that you tested this "make O=3D/tmp/somedir"
> > (which is not the HANDOFF_PATH thing) and I expect it doesn't work there
> > as it references ".config" and not "$(objdir)/.config".
>=20
> I am not too familiar with make O=3Dxxxx i never used it.
> I will check what is the issue here.
> Meantime, do .mk is same as Makefile or not?
>=20
> > Finally, since you mentioned AIs in other emails, we do not yet have a
> > formal policy for or against their usage in this project (it is
> > something we need to discuss) but at a minimum the Fedora policy makes
> > sense to me if using one:
> > https://docs.fedoraproject.org/en-US/council/policy/ai-contribution-pol=
icy/
>=20
> I don't think asking general on syntax run cost is a kind of issue.
> Otherwise it will be a huge trouble to include all people or even
> referenced website from the beginning. There are thousand kind
> of syntax that can make things run. I will ignore this policy, sorry.
> Even google these day uses AI supported engine.

I'm sorry, but I don't think that's an appropriate response to me saying
that if you're using an AI to generate any of this then you should
disclose it.

--=20
Tom

--H68/LshY3D5vE2AQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaQptqAAKCRAr4qD1Cr/k
CtGpAP9n9KDaJhSIs7M9mIsHZxZJRbYLKbvhrI7Cw7lyLpibaAEAzGNKydZyvhv0
ugXZvcHOaeJ+tLmh6WgR3LXdbYmbVwI=
=9Lbi
-----END PGP SIGNATURE-----

--H68/LshY3D5vE2AQ--
