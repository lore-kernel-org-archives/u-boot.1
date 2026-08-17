Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA460C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 13:34:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 46BB040752;
	Mon, 17 Aug 2026 13:34:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YK6a-pHCcZ2c; Mon, 17 Aug 2026 13:34:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5076F4079D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786973661;
	bh=YhFSqWhGTO8lGDu3dLa4Oer6DHFnGwXSq8FQfpIb+Jo=;
	h=Date:Cc:Subject:From:To:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=z3XU43Ub13CPFOQcK4ySJuFiU1Bhmz0d5EhX1ASeAR94fZSMJHY19kKVMWbyJD2mX
	 aXBiT1ReVo6IUlkpNkN6HedKXhpt46TBo6m88zBtK9oXW9HLJyTqLtRfohnaHHBBx4
	 6mM2yepyNgUrbAwhZRYdS/17hIjGJ+Hp4nkPt8/AlZYOoVLrNHFZFhOvnI6QLWoddx
	 DrZtDwUjqj/bw3+jAC2Qc6EdAWR3If4LeetdwW0PynyUEKH0htvZyuAzE9XygIOqB9
	 T45If7AaGnkyCRgkNbGahRmYXxEpFBy4bnhwTLCDglkQjCy98KkDx3V68UjMg4ZwvN
	 fP3cIPpjDS6RQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5076F4079D;
	Mon, 17 Aug 2026 13:34:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 587682EF
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:58:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A663400EC
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:58:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C6kjrRl7UoFq for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 08:58:16 +0000 (UTC)
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=43.155.80.173;
 helo=bg5.exmail.qq.com; envelope-from=troy.mitchell@linux.spacemit.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 5941D40050
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=linux.spacemit.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5941D40050
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=linux.spacemit.com
 header.i=@linux.spacemit.com header.a=rsa-sha256 header.s=mxsw2412
 header.b=dHGRR9ta
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.155.80.173])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5941D40050
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 08:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1786957011;
 bh=YhFSqWhGTO8lGDu3dLa4Oer6DHFnGwXSq8FQfpIb+Jo=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=dHGRR9taphnY2lqus4se1JIEw5XmcDRyS/vWFB6BjxjGZIqOAHC/m/s46LF8A9Etu
 h47wb69SAiYReNgl5l7Qyo9vYpYlrbM/jKyv8HXj1bZRvM/yyNuRJmQxwRFVLWhCmm
 29+GrJ3IPVJLeknq6icwfJrQXXuzvZAZlZ+yueOk=
X-QQ-mid: zesmtpgz8t1786957009t70d1f2e4
X-QQ-Originating-IP: JJRXRnFAf1KT9/gpWDXZOFWtST/ONxwRJAKG0+fw4AU=
Received: from = ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 17 Aug 2026 16:56:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14375860758001431371
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=02cba693a19bb69683ecd64a03bca024618fe83e291e37cf72c857c3a94c;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 17 Aug 2026 16:56:44 +0800
Message-Id: <DKR3E33H0FCK.1O1KN2YJSZSBB@linux.spacemit.com>
Cc: "Heiko Schocher" <hs@nabladev.com>, <u-boot-spacemit@groups.io>,
 <u-boot@lists.u-boot-project.org>, "Huan Zhou" <pericycle.cc@gmail.com>,
 "Guodong Xu" <guodong.xu@oss.qualcomm.com>, "Tom Rini"
 <trini@konsulko.com>, "Raymond Mao" <raymond.mao@riscstar.com>, "Lukasz
 Majewski" <lukma@denx.de>, "Yixun Lan" <dlan@kernel.org>
Subject: Re: [PATCH v2 3/4] i2c: k1: enable both functional and bus clocks
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Junhui Liu" <junhui.liu@pigmoral.tech>
In-Reply-To: <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: MJ0QbbALek+qBrb7kXEpqgYtBf4GYj2/hQp9/QDL/QhvVftpbApDSJkQ
 5TrrNlzWpTZSm9yYFZsf/+f7KAvn8z2OrwMKWd0OQ/kefIScxrUf7brCcb6H46ctG5rYIlx
 /8xf0nGlyFckkiVe14weFBCft7VjuffYw2VOtAzxDm+oBJgPDSaANRMkAf5YexmXPh4wo8O
 o5+qHaI8AnWjOu9ifIIeCcyWsasApRc8NJLNLcYbEHOA5935d8NKg6Kr0YFpumqJRJ8WrkX
 ILGTyY3/H7mftq5HZ4n43HqautyDZdhI4b7cQ5Y/NlIMaBmbOytvkk5qUwbq3lZg3WGFH2f
 CPs09UhqWP197LZkXsy6hLmyU+fshgwQEXal1oO+YAQifmurJbga9GcpqoLk3HwWtvS4FC4
 HYGD6qZLISQ/nJFy/m7iFbc5o2NP6OL28KXeF31jhF4ZbGJHdUNTA573RUObTkBR08+syLu
 7L9sB5jCd9KIeZRFoQCZZ2xgNLTGBslBDxHGeGgXv1+wSGWunDS95FFkq6ZVsYg6S73Eb08
 uz5NnYIpr6QfjP3cpfwNMT0tosIAaHH5PMEeD9foYjcaB9s26SqfVzPis7vc2tLaNSvmud1
 0/p88xQsI7s1Gwz9YZObYrIPEf6e+Lrn0UDqCxG11udkTEZVFYIAcyb0aYjz93crugjkaBm
 wgM3GSs4fLJzl+9LnKPp4mRzgSmrxO5LsHFEQvXCAs4V7+yhbiRi+Rrozrzyy9TPrgDpVyB
 EurcS5PPPDKvY3Ccrj1iKI2CjdAxxuhSoAKEwAQZbX/5tM1QmxT06FqsZ0OXL+IHFM10dUu
 4i2IPIkFUKbJGVpSjfm5V8Di4dZwQ8lKN0+l4Ki+kt8A9nTPCqOmtXCodZ1Agcg/NhWnumK
 g0dCJl5X1OsO7IKlk9uCMThcC75P5sHpLmMRZSrtuWIFF7D8IpRjElSixJmhpb9QV9mkGxS
 lZCIHCQgLtrWnm6wgx0lL2ArmZ14D5ieg0ROn2DLFHq/+bP03OzN5PKCLve2YBMgz1FEtFR
 JrpRWbS/2SxK0+y/EmMIeZbpVLwTm/4sG9QubSh69DWECnyf9D/755wiy3qYBtxUN05GWxh
 Q==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Mon, 17 Aug 2026 13:33:58 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

--02cba693a19bb69683ecd64a03bca024618fe83e291e37cf72c857c3a94c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

> The K1 I2C controller requires both its functional clock and APB bus
> clock to operate. The device tree provides them as "func" and "bus", but
> the driver currently acquires and enables only the first clock.
>
> Acquire both clocks by name and enable them during probe. Use explicit
> named lookups instead of the bulk clock API to align with the K1 Linux
> driver and keep the roles of the two clocks clear if functional clock
> rate configuration is needed later.

[...]

> @@ -487,15 +487,21 @@ static int k1_i2c_probe(struct udevice *bus)
>  		return ret;
>  	}
>
> -	ret =3D clk_get_by_index(bus, 0, &priv->clk);
> +	ret =3D clk_get_by_name(bus, "func", &clk);
>  	if (ret)
>  		return ret;
>
> -	ret =3D clk_enable(&priv->clk);
> -	if (ret && ret !=3D -ENOSYS && ret !=3D -EOPNOTSUPP) {
> -		debug("%s: failed to enable clock\n", __func__);
> +	ret =3D clk_enable(&clk);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_get_by_name(bus, "bus", &clk);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D clk_enable(&clk);
> +	if (ret)
>  		return ret;
> -	}

Once the functional clock has been enabled, failure to acquire or enable
the bus clock returns without disabling the functional clock.

                                            - Troy

--02cba693a19bb69683ecd64a03bca024618fe83e291e37cf72c857c3a94c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCaoLMzA0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQv1WYA/RriFt9wzeumHv2AIJdoQsCpg4RO3Bgl5lGaK7Ds
xLwwAQC1xp8U/7MDvr2EByds6xk1A0qRmHVvmlBQU1yIrrTjDQ==
=zHPJ
-----END PGP SIGNATURE-----

--02cba693a19bb69683ecd64a03bca024618fe83e291e37cf72c857c3a94c--
