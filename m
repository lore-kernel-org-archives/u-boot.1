Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E571606A319
	for <u-boot@archiver.kernel.org>; Thu, 22 Oct 2026 01:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=c/S2KbUA;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=Uu05zs1u
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D775C81201;
	Thu, 22 Oct 2026 01:40:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UdxxYB0DBlfV; Thu, 22 Oct 2026 01:40:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2F6D38124D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792633246;
	b=ChvZVkM84vaRQs5MbsYMMsYM2OI2oc+x/QzVvG/xXrDRjgHXqj4hoZwB9qgvxn9z0mkx
	 7aU/TIm6IZPx+VSU3vFnsYQccTcU+0UQSxpfFl1NA6XU71lOB0VrlwRZKcJEEPbEAzu8l
	 yymKHO7+qWT5q0zO44/IoeUOInOpRlKn/7LGzLwhXhzfWdp8dU6Zfv1X4UH9pnHXNVPjE
	 4KMnCw8VOrd3tRScPMiCmfkR/3UHqiTjwn/jGZYLPO2BM2P7yM+N96ktiBMdhLMDX2RP8
	 smTFpbFz28FS5CuBSba52Jw+mccq3Nm5uuhLhfZLmbN8kyXryZsMkyy2V0JM0bjMNiA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792633246;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=y36Bpk7J43IwPzUT89TTNpSWyIw1f8INAl/zCAcTjEU=;
	b=asiAtcIBNTPFas6A3A0tfrVuEa3i/EDR4HJ5mNRIKbRp34fFOOnqpGOuaS6kwrJs4ajq
	 vf8o55cJ18fGxZX9xfjuuImS8fxNBzEkHIt78S9EPe3vjkGWLM+DSpLKR7piOZ9eCiCXf
	 ZN2VIaWfa1WWCEQvhj78cM3f6KCL7jJVkaUBQMt6fxhshIcNinhDU8P6x8DQSoau43WsP
	 X9yT0gkKKXArOpxvbjFz5wPod04kwZOotvOiOvkABxQsmKWqPg54QRsHCvSmCphT8R96U
	 Vy7U95wFBO0HjuaiI1mwkNBHGGmsr4AxPjBANk/gCc5zOEzpkkP2Szs3sNjSsvaOB0A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792633246;
	bh=y36Bpk7J43IwPzUT89TTNpSWyIw1f8INAl/zCAcTjEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c/S2KbUABcsEqK2JvLZIxOzh6IMah75ixfLf/034Kt3rfKaZGRvsq9zyttXRl2kAG
	 vAau6uU5CuZ6kMGF6/94sNEojQ8P6HzUVE+dk+XX9kP446S50ndxUwor1snUf+2CJ4
	 i8HTxk8JB9Zy1zU/G+NXmQ3f0dzP961VhM+3DkzuCpGGNknzYN0pQm+b71Io7xjOPD
	 yh481KmAS3poZCIeKgYUiC8XKbbE8bZNj+ZobGx57/3I2eQgPdrX2PRnUDBlSQL1B8
	 z51wGTYvnToVgdb1A3979AAIXJp2voRdobOJZxT0qP/MVOQu8rfv9wlk40qXASZO9y
	 Lgem2QSPEkaUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2F6D38124D;
	Thu, 22 Oct 2026 01:40:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 7AB2E1AB
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:40:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 60DD240050
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:40:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QRxIu7m7krY5 for <u-boot@lists.u-boot-project.org>;
 Thu, 22 Oct 2026 01:40:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 94D8140042
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792633243;
 b=cSa+Z+R9jBVOhT6gzSSpU2m2xQvD7VZnSRF+e6YDhaL8ZYoybp/pFktNL4hLI4/a3rev
 wDWEBh+LR/OXPYeLQqjrHMnrpRv0LnXSk/BzrOhlaUsZfOKWIF3YbOJCQ+hFAxC28cxWc
 L3+T/jgm0XTPLFRGYlVcUXKnIdjTWDad/9KOF02b9YnCQINi6R2HZyffB3S+GSmFZNjdP
 jIjIn1+GZPcqkgDpwSV2tUuHmYcZMRWb3m+y69wXXoZsuZTvCxcUpfRsg+Qa6KCWiTZIa
 BCdS1D0QsJe8bmWl6r11+eyjcn4jSww2s8RRbglSTA9ie7HJB4BYWp+LsOs+dnCHUeQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792633243;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=y36Bpk7J43IwPzUT89TTNpSWyIw1f8INAl/zCAcTjEU=;
 b=kLOzx1BbBdxiMyI1+/25X282x0CkaQBcEcgptAuXrWOJ2XpOH2FUvm3xPoLAYTcaDTBx
 YV50ch5Yol0XuQZJ5wCUVtjuk0StPRx8y9K1QCSUCQ9ggQCaOfLD0e/WZYciFGAr0hS1u
 0Lxe2z8OQiueZ/6Jjg61y/VtMl/5ArVO0ntxRLV3XCpgl7J2N57z0Y9b1LYcl+K/Ghsj2
 cIb/nDS3cLyHoZ/5/fy51OO1ZjVUSHX2rcbmGxFHe/wMAgtBogTPevrRYA/eST87JyT8j
 FQutir2VqgAnWLctmr9BeqGs3RyxWsMLKGkriirH15Cua179JEeAOU7FifgCf4xLX7A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Uu05zs1u; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Uu05zs1u
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 94D8140042
 for <u-boot@lists.u-boot-project.org>; Thu, 22 Oct 2026 01:40:43 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-843ea301d60so952064a34.0
 for <u-boot@lists.u-boot-project.org>; Wed, 21 Oct 2026 18:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792633242; x=1793238042;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=y36Bpk7J43IwPzUT89TTNpSWyIw1f8INAl/zCAcTjEU=;
 b=Uu05zs1u8qvStCV4k8hGmxlkAnlH3x5I6Z+7WWElNV0fLuEfsbYWrJkQDkrcZS37Em
 u8XWRWqaeI76Iwcx9AsX0jtJPj5W2KrgYbm+aESfAN/YLl2X3gXqlaMM9MhnTTbW637Q
 E+XK7TpaQ1G7LNhn1qVZZR3YkeuLd860ixSkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792633242; x=1793238042;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y36Bpk7J43IwPzUT89TTNpSWyIw1f8INAl/zCAcTjEU=;
 b=td94NgUwWe16cH6HCeE38jK8O8eywivnjp68FBHF5z1lyebfqH/HD+QwqGu2IZmwKf
 GB/KWsP4nRwRbOuF7ipB6/ejGKpXK++e6hUlDgxvQuIuox1BtL8/bx75MLJ7AOoP7jsX
 VewHraGe6YVySlMB6kBs5kUOqO5awvjQDE+UZhTxZ9WB6h3s4s62IqeNhxr6EFDwGgzx
 1MqGXqMzOV89UYFiR1ekmlGJy1vO92G7qdEZJ26b9PZUwQTl5vW9IzTDu9llbZDsuWvb
 EmjfkQtxHd9x3g5FSVpswCoavJCkxJMp1N/0wPwpLTFpNwF6HLypO1y9gLWIG7kHl1Dt
 4ijg==
X-Gm-Message-State: AFq9FYKSEdCePZHteiUrGDFfAPBYZCSXcNXlB1KzheYrykZ6b3MPqYKS
 epryYBocxAH4/d3FNfzqrQ9lzx3q04BVOb7UAi9HKzlPnDEAIuHqj3nb91EIuz8KWho=
X-Gm-Gg: AYBFou29QNUn29W2dms+Mqbrcm6MrO2C2g09riTcEZEmV51P5Wi6NFphxQYOJ+TjxMo
 gL5hfchMD7UkAkgJ60DsBat0k/ANkeH7OcA8ay5YYygiJnr06hsxaDAjJomPf2A9iMX7fS5jRl5
 fKsGiQ0/8Osau8LRN2JifvGGerxKx1IaxNlb5SXZlt6kefJdhyH+ZDMIcdTSDyqZ6yz9h84c+mN
 7Fkp+uhaA1RuYOXpE0LP43fjn1I43XxCP7EHVxl6TP+gsvSvjNmJr21KmTY5+QzFs7S8CiWwg46
 6wrA1oI2mZMILnqMVfWDQsL7LJIfaYout+n3HdcGKHKXTYMnoJkRp8AUMli3X9O0TWQh9uYriqP
 21qj+4lopxY1Akd17lH8uzE8hR8pSEShmnaLPoImsjPb44IlD4sgDtTldYPCqktl2frIiKfMDD9
 7zKe5XHA6CprB9OVYEz1mx9WtustL6eaNmtqRIrk3emVQPEu9S3IMqzYlG4OqHeTOuD5IKMrh0P
 BMQs7l8mY+2TifnoO+O+UT/QY8cZB6W2PVm5NkZJvGnlVU95NMCXabubJvlXqW6hr3iKP2im7hs
 bEgWdNXwXeYijJ3juL25dE4Hpz+vP0Dd9rbuHLZRWRqNsEVnr7fV3y40B6VJGXDp7yPct8SQabG
 /
X-Received: by 2002:a05:6808:3203:b0:4f7:27ba:9db4 with SMTP id
 5614622812f47-5535ce10114mr2473713b6e.60.1792633242173; 
 Wed, 21 Oct 2026 18:40:42 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-552b4104048sm3381887b6e.5.2026.10.21.18.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 18:40:41 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:40:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Advait Dhamorikar <advaitd@mechasystems.com>
Cc: u-boot@lists.u-boot-project.org, clamor95@gmail.com,
 pratham.malaviya@siliconsignals.io,
 Anatolij Gustschin <ag.dev.uboot@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <ravi@prevas.dk>, open list <u-boot@lists.denx.de>
Subject: Re: [PATCH RESEND v5] video: add ChipWealth CH13726A AMOLED panel
 driver
Message-ID: <20261022014038.GA3426442@bill-the-cat>
References: <20260917184524.122806-1-advaitd@mechasystems.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OiiBNdiw5A6aWrD+"
Content-Disposition: inline
In-Reply-To: <20260917184524.122806-1-advaitd@mechasystems.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--OiiBNdiw5A6aWrD+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 18, 2026 at 12:15:21AM +0530, Advait Dhamorikar wrote:

> Add support for AMOLED panels based on the ChipWealth CH13726A
> MIPI DSI display driver IC.
>=20
> The driver configures the MIPI DSI interface for 4 data lanes in RGB888
> video mode, performs the panel reset sequence, sends the vendor-specific
> initialization commands required by the controller, and enables the
> panel using the standard MIPI DCS Sleep Out and Display On commands.
>=20
> This driver is based on an earlier implementation by Pratham Malaviya.
>=20
> Signed-off-by: Advait Dhamorikar <advaitd@mechasystems.com>

Sorry for the delay on this. Please rebase to current main and make sure
this compiles when built for sandbox, it does not currently:
drivers/video/chipwealth-ch13726a.c: In function 'ch13726a_panel_of_to_plat=
':
drivers/video/chipwealth-ch13726a.c:153:23: error: implicit declaration of =
function 'device_get_supply_regulator' [-Werror=3Dimplicit-function-declara=
tion]
  153 |                 ret =3D device_get_supply_regulator(dev, "vdd-suppl=
y",
      |                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~

--=20
Tom

--OiiBNdiw5A6aWrD+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCatlpkgAKCRAr4qD1Cr/k
Ci3PAP0UBp/cXwUaCLUSfqjaZ4wCsWppZRwzM6ymLt2kTTXrKwD/aXfm8uO9+4q0
oUWyVrqOzdYbQnNB20dwMS0yW/T+UgI=
=Yqr/
-----END PGP SIGNATURE-----

--OiiBNdiw5A6aWrD+--
