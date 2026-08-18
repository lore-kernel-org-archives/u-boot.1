Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48210C5DF7D
	for <u-boot@archiver.kernel.org>; Tue, 18 Aug 2026 13:06:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF5EB608C7;
	Tue, 18 Aug 2026 13:06:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hHy8VnnXyv98; Tue, 18 Aug 2026 13:06:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47E3C608B9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1787058379;
	bh=9zaZWGD4pHi855qNUIkXWIGkwjwJC7wx2LCJN/R2V5g=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kNSnyiLTOOOj1NB1f22shATqUGKGeZ9iDm0t3qRP65Q4wi+dg/omRvN4PqS09SvdH
	 8ycD1ZmGDouXy5cucuwzif+XdzXHHr/hxVVv4f2N8bPsrFSzEUFVCk+4l7mK4sEElm
	 n6xoR75TrHnwe75jaAoN7CaiQcmNiu6X/uhyDGsbD7g5gVPH3qREnS2DqL25mH3PPb
	 TIiD9Fm5NesmkOCRPKlerbDRAj/q/FP/a+iJzQ9Ikqi1SK2k29zrDZMYsUjtC+SGf+
	 eJNMNHOEWsYLkTUAYjdzuORsx4RwHcOxqaDzkIl75g2qNIsqWnSLu5Nd8LVr/30HIo
	 dchOP1/DUHIiA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 47E3C608B9;
	Tue, 18 Aug 2026 13:06:19 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id D10D223F
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 01:04:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C30C780FB0
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 01:04:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D-SSfv-XUFDs for <u-boot@lists.u-boot-project.org>;
 Tue, 18 Aug 2026 01:04:47 +0000 (UTC)
X-Greylist: delayed 58003 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 18 Aug 2026 01:04:46 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6FF6080F4E
Authentication-Results: smtp1.osuosl.org; dmarc=none (p=none dis=none)
 header.from=linux.spacemit.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6FF6080F4E
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=linux.spacemit.com header.i=@linux.spacemit.com
 header.a=rsa-sha256 header.s=mxsw2412 header.b=fNkAQghK
Received-SPF: Pass (sender SPF authorized) identity=helo;
 client-ip=54.254.200.128; helo=smtpbgsg2.qq.com;
 envelope-from=troy.mitchell@linux.spacemit.com; receiver=<UNKNOWN> 
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6FF6080F4E
 for <u-boot@lists.u-boot-project.org>; Tue, 18 Aug 2026 01:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.spacemit.com;
 s=mxsw2412; t=1787015044;
 bh=9zaZWGD4pHi855qNUIkXWIGkwjwJC7wx2LCJN/R2V5g=;
 h=Mime-Version:Date:Message-Id:Subject:From:To;
 b=fNkAQghKkO27WaAiorqgZEWrb2nTEMFp4bvNr1FUy09EXT4CyvwWM5K8jhVB4zYb3
 4BM0hL53N74eiUFTGR41BLiFwXonnu5AUWuLljjmOnkld3CKxQpi6rAsjNJqGehD0y
 aojPOG4zEbGuZ4n2a86F7Cf97b+/XBjl05JirxM0=
X-QQ-mid: zesmtpgz4t1787015042tef681fe1
X-QQ-Originating-IP: uGo6hjJnr0JZtldwZk41tmjGlztABY6a4cCQZiAF4+Y=
Received: from = ( [120.237.158.181]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 18 Aug 2026 09:04:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8758530987341579553
EX-QQ-RecipientCnt: 11
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=4f7f390a2d430e8dc2a0af40fac90d57573d38c246df004a81b492240c22;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Tue, 18 Aug 2026 09:03:58 +0800
Message-Id: <DKRNYNELFA7H.3838MH2QULHVX@linux.spacemit.com>
Cc: "Junhui Liu" <junhui.liu@pigmoral.tech>, "Heiko Schocher"
 <hs@nabladev.com>, <u-boot-spacemit@groups.io>,
 <u-boot@lists.u-boot-project.org>, "Huan Zhou" <pericycle.cc@gmail.com>,
 "Guodong Xu" <guodong.xu@oss.qualcomm.com>, "Tom Rini"
 <trini@konsulko.com>, "Raymond Mao" <raymond.mao@riscstar.com>, "Lukasz
 Majewski" <lukma@denx.de>
Subject: Re: [PATCH v2 3/4] i2c: k1: enable both functional and bus clocks
From: "Troy Mitchell" <troy.mitchell@linux.spacemit.com>
To: "Yixun Lan" <dlan@kernel.org>, "Troy Mitchell"
 <troy.mitchell@linux.spacemit.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260815-k1-i2c-fix-v2-0-7d2a48607233@pigmoral.tech>
 <20260815-k1-i2c-fix-v2-3-7d2a48607233@pigmoral.tech>
 <DKR3E33H0FCK.1O1KN2YJSZSBB@linux.spacemit.com>
 <20260817091812-GKC571540@kernel.org>
In-Reply-To: <20260817091812-GKC571540@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:linux.spacemit.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: OGPyLxpWWNNm1CWsFgwWfIWYIkj9pMqAbBXbX1KBB4UbqSu7NeBJxWBO
 ptsn+FV49MGl5ohEm5AtleZpWwyaQRVAUofedzUwEFlY9G2t4QA+bVS6ofyi+R8KGXET2xs
 cS2ui7TwOdcXgLcz8QPFeLBmQTnM/gFb92+IIqq5APhLZNVt2dfGWWy7OVCaGgw6adBSq+3
 Q/9s1dgGz7u4kJWLt2ZeXsQZTi1bm+JLWF+6C7Q87lUHGnVz40Xg0C3YtcGR/fhhgHdoRmR
 EpYOiw5kbH1YvH/lL43YUx/gY341tt1A3VBPds+ZOPXMSvOtcmQ9KjZHYUCjlJnUViAnNnn
 ehixI2vqeu/qffs5BGkzlAzF4ZjzQ208XqmMVQnUppJxrm5jCbIKrWEm8vYwFO3j973Y4cR
 qttHLFEbebSA6Qx9WQ/AzFYsKlAcBHbN3orcs7mXufolJp3IY2v0Neai+IupZ95LjqXCeq0
 wO2uDqymKjChlj+cJkhQhkl/Wi0TbJ5l4vaGTAYSaJBWVnrtyeao7JnHZSnUhav/LQtgjt3
 0Oc+yjgSEbigFm47/Ts3taBHOZaqetoVLTRKhBXIDaRCaJL1ENP5tlVFTZQe5YhOAwkGLCZ
 1CrbHyboFaY+k0wlHvy7LCgIjqn4YzytMdrZD5bq10F9xbrVx8j9eyHqJJBOwYwS40/xgBF
 JJEhLMhGiMQmF6yWxOX4S52i2iVYRFuzkHAwh8Wj6KLl07Jg9b7LH92PUFXUP1zpuuYAeJA
 tdxucmN3DGIR3JSugDGbt4Th4Qct5F6VXzUUka041lLpPGMavJVQlODU1wM018RGfiK7PWY
 PfpvoIUSgsu+ggy4yDmNaETybMV+Xw/OHHhp2MFfpcwwH1cGwHoyJWldGbwxIwuF2HogBKj
 3BHeaepmCrzbKN37mHI+dCcTLULRZWY8oZ5Nt6eOt0ooiGbTr4kydUBaNNFY2pcv6/YZ91B
 NUF5oWZGCIEmyLI2TZqQ7De4zMA1CXhyjjs7GQHF0ICuvIOnrQWi0oqK+es56fzYEqyMbbM
 Gw2fjrtFq1keQYIY9yeHaj1Z8QZyZG7tVj8c5Y0/zm2XCuN1olcdXsOKhOrnwTXdqfRvIT8
 09nh/WWaO5U
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0
X-Mailman-Approved-At: Tue, 18 Aug 2026 13:06:17 +0000
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

--4f7f390a2d430e8dc2a0af40fac90d57573d38c246df004a81b492240c22
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Mon Aug 17, 2026 at 5:18 PM +08, Yixun Lan wrote:
> hi Troy,
>
> On 16:56 Mon 17 Aug     , Troy Mitchell wrote:
>> > The K1 I2C controller requires both its functional clock and APB bus
>> > clock to operate. The device tree provides them as "func" and "bus", b=
ut
>> > the driver currently acquires and enables only the first clock.
>> >
>> > Acquire both clocks by name and enable them during probe. Use explicit
>> > named lookups instead of the bulk clock API to align with the K1 Linux
>> > driver and keep the roles of the two clocks clear if functional clock
>> > rate configuration is needed later.
>>=20
>> [...]
>>=20
>> > @@ -487,15 +487,21 @@ static int k1_i2c_probe(struct udevice *bus)
>> >  		return ret;
>> >  	}
>> >
>> > -	ret =3D clk_get_by_index(bus, 0, &priv->clk);
>> > +	ret =3D clk_get_by_name(bus, "func", &clk);
>> >  	if (ret)
>> >  		return ret;
>> >
>> > -	ret =3D clk_enable(&priv->clk);
>> > -	if (ret && ret !=3D -ENOSYS && ret !=3D -EOPNOTSUPP) {
>> > -		debug("%s: failed to enable clock\n", __func__);
>> > +	ret =3D clk_enable(&clk);
>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	ret =3D clk_get_by_name(bus, "bus", &clk);
>> > +	if (ret)
>> > +		return ret;
>> > +
>> > +	ret =3D clk_enable(&clk);
>> > +	if (ret)
>> >  		return ret;
>> > -	}
>>=20
>> Once the functional clock has been enabled, failure to acquire or enable
>> the bus clock returns without disabling the functional clock.
>>=20
> I'd not worry about this, as in uboot it isn't worth the effort to do the
> resouce reclamation, instead I'm more concerned about the error handling.=
.
Reviewed-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>


--=20
Troy Mitchell


--4f7f390a2d430e8dc2a0af40fac90d57573d38c246df004a81b492240c22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iIMEABYKACsWIQSL4Ay2cExaPXAQcU2YCe+A+TM0LwUCaoOvfg0caUB0cm95LXku
b3JnAAoJEJgJ74D5MzQvwg4BAIS1uUyCjrHVjapCPXvliuQ9ZAlWKc3jQItF3pVY
WC4aAQDH2QpwIG2VSgxz8oIN8kEWVqZPBtRRVqcrbOLnVwMnDg==
=ZXt0
-----END PGP SIGNATURE-----

--4f7f390a2d430e8dc2a0af40fac90d57573d38c246df004a81b492240c22--
