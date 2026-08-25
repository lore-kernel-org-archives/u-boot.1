Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9C0C61DBD
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 20:02:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 925EF80D50;
	Tue, 25 Aug 2026 20:02:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qGynF0RoBeQ2; Tue, 25 Aug 2026 20:02:44 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787688164;
	bh=4WdpuRNds4AkQT8CnSFmu9FF0z8n96oiI6koo8AQyCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jGM073KTeZqD4/ivwn7FeA/GcdquqY0IKkDwE2lABa7URJSEtRb2rUyjB1Kt76lWa
	 b60GUrvNvSlfmsESvpsiaskXe8xyCAZa41oTDImhq2dWtdJTzBEMujbJLcoC2+o7vY
	 s4cbV4qRi6hEfj9o6RlJuLIXneiBdH+GHNEGnbJ/2rMDgP4AhLuLvn10aRStMMdpQb
	 RIh96Gq9/FhgVXUiWEPZ4VdTSUSGOwZIQUcMJnYOEElNhn4wi+zvzX459VI7ZLFdjm
	 5/j6oWVqICln6GW1fQQX+qH4GtmMgBKkUDCEMgBqc+BeD8vF3OclbHusPHSeTLGZ0m
	 eW4SSYtMYvZuA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BB85180D3F;
	Tue, 25 Aug 2026 20:02:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id C259439E
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:02:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A8B9F400A8
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:02:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nzD-H9wPFZM9 for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 20:02:42 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::235; helo=mail-oi1-x235.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=KgK/eu6s
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EEC0C40055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 20:02:41 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-4a45b3f0becso243895b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 13:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787688160; x=1788292960;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4WdpuRNds4AkQT8CnSFmu9FF0z8n96oiI6koo8AQyCU=;
 b=KgK/eu6sqf8DAM/Ix+WNZ0iTsvTfNrsjoA5Q2NTqRNK28QPToGB7FAgFqUe3mvbR9i
 ZlIuOj7wCi0BR41gxtfBGStLaoldbR27LCpvOVjP02G79U/KwG13piB+ikBxbgNdnUZ0
 bSYgwb0BoIRxAZ7D7g1kDpY7sf/BBV//YFZj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787688160; x=1788292960;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4WdpuRNds4AkQT8CnSFmu9FF0z8n96oiI6koo8AQyCU=;
 b=A1rP9wby9Vb8OvP2nLouNDY99ebYQSkO0WIqVPGfYkoCY7n7CUQLtMQ6h3I+6od9Hx
 Y3myQguq1kdpunWN7DnYNtU/yghV3ub7cKc1Bt1Y70WD9H0rCOrpkYTdMtqYQ59qIOgt
 RpkTVYGCNdmIba2EPwVPHUHaCC2QCzRbwH/pwuk8PrPz1vp/01cUHjfDU14/3PmcQmcB
 W6Qjq3kU5uVx7Z9a7tF/KSdUlC4tr1XUXo9CpIEPJywzrDUGhdQdlvrYczZ/yE6nyEkb
 SJP7rrb1eHe06IaV4/G3pf/qyjK81f+lAF2OKfNHt1v1bnt++0wqCHEy9mGhA6FAVTiq
 x7pA==
X-Gm-Message-State: AFuF++lO50x5AWk4qzVo4sh8Q1T47cYHio93g97+h5izlU8BX1HhzGcO
 j2usZaUyhmGWhCrMn+ZLWokzAVLY1B8Mm3t9SLTmy2oWzYV0hE3Seval1ovPyDX+Oz3BomxakCk
 oHPZcHGRjbGGh
X-Gm-Gg: AR+sD10oK6BvWqgqwxU3Cjv2Ipv/BDJRY4JzJJhyyOnnByKoy6HBylW/QnN8oEJlJMC
 VHZ2Y9ctjWSbxxDF505U+iJoAJTXgwkN6iJMAZ8XqgsRW84p/jFbtcbdL2lRNUUulDymzoL/JWF
 FfNXGQz2k8JcRcrpWq3OD8kspcZEqCJyujXtpb7F5kAcefDWSNY2vZtJCeKt1FJww34WzFlXKNm
 qVYefXkKU+0bH9thy0ZRD1fJ8D4NASDtVYQQhqI34tB+DNZbYl1lI6eyO7QNj6dB+bmN0B9UBiE
 xKOyzxu86osZCmWAOPJDmNpkFacTNh/KG70CSs/urjW8zSx4MGq/dcxI1W02qY+0wep7mdray7n
 LpqqouO6Ic9kGC1NoevmMNSz/FE9oXXhC1xEcyFK+09ZgoIIGCGObZAKW/ZGsCwg65FU31Sarwi
 W7voYyGuhB5uFYO4dv09mKZ1lhRTOFYn4yFCMfFrlEZUAw/RWkjMAki9KWmcwml96LpOXuUS99t
 hDQVTFLhn+XhfDaygxXEShzeAvRyQ+vh3N8u8TlovDS140dRRCyPqQjPwl/kllXOsyW+kmBvEN7
 r8dYLe8ANg==
X-Received: by 2002:a05:6808:3a10:b0:497:da7f:179a with SMTP id
 5614622812f47-4b366b57fa5mr2421980b6e.21.1787688160310; 
 Tue, 25 Aug 2026 13:02:40 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b367c74d67sm341881b6e.1.2026.08.25.13.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 13:02:39 -0700 (PDT)
Date: Tue, 25 Aug 2026 14:02:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, Junhui Liu <junhui.liu@pigmoral.tech>
Subject: Re: Please pull u-boot-i2c
Message-ID: <20260825200237.GC523975@bill-the-cat>
References: <20260825112101.4107921-1-hs@nabladev.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="b8fBifDnmoRjxrCv"
Content-Disposition: inline
In-Reply-To: <20260825112101.4107921-1-hs@nabladev.com>
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


--b8fBifDnmoRjxrCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 01:21:01PM +0200, Heiko Schocher wrote:

> Hello Tom,
>=20
> please pull from
>=20
> The following changes since commit 2d379a529c257606946831a6dac1c37de6a3f8=
c0:
>=20
>   pinctrl: airoha: sync with linux-7.3 driver (2026-08-22 15:58:30 -0600)
>=20
> are available in the Git repository at:
>=20
>   git@git.u-boot-project.org:u-boot/custodians/hs/u-boot-i2c.git tags/i2c=
-updates-for-2026.10-next

For next time, please edit .git/config to have the https URI for "url"
and then this for "pushurl" so that b4 will see this as valid.

>=20
> for you to fetch changes up to 35c2947b5b217962e8d88e2a0b7f507a037a0676:
>=20
>   clk: spacemit: k1: remove bus gate from TWSI functional clocks (2026-08=
-25 08:22:24 +0200)
>=20

Applied to u-boot/next, thanks!

--=20
Tom

--b8fBifDnmoRjxrCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao302gAKCRAr4qD1Cr/k
CnnZAP4nqnZE+n0HASma/5GEAtwKyyZpfazkrV7BNywwP1VvHgEA8trkgfBjcNSF
4dxJq5jcOEUyDBshCyKuPAUD+fvPlQ4=
=K7at
-----END PGP SIGNATURE-----

--b8fBifDnmoRjxrCv--
