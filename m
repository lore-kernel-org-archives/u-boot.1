Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86214606A32D
	for <u-boot@archiver.kernel.org>; Tue, 24 Nov 2026 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ghapltXh;
	dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=QF1pahIU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5C672607CF;
	Tue, 24 Nov 2026 18:36:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XqWeFKT-t2YF; Tue, 24 Nov 2026 18:36:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A4AE9607DE
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795545371;
	b=NHwQ34YlzJeo6OIInyzIDXp1P9XK409zYOjc2vEu2Bl5xrYEuoXtAO752LQfRZSGxJQP
	 444Fg/trlz/6miBCC6cIPdvQV3kjj6Io2i3qVJc5wu+dIc88E6H4g0astqqXRWeMyNJ8/
	 Q+0plJTBYERz/gQ6XQvfdGg/gTMzmRWse2PeGdBFnHAOY7AVM7tAPb0nfsbqtpyK130QR
	 kmwXXOm9wXg8hp28TsKOqMJedeWLs/TI4oMKz8gSnhzV8vzP9kuKuhAdZCRwj+qFKdAzz
	 NxQFuUdNuJ7SVGuszCgUP5cwxBnIxqGUA73G8ePcJkomP+QqWqTHXBTdXlZye0j3bFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795545371;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=e6tenRyB+Ht+NG6arl8FBnxUIkgqnvtj88J/19FZTy8=;
	b=mB/2Ssv8xydmUb5b7Yk2WD6ZxZFqH0/TaXvCpL/cEKKosNwodwZ+qmPxFv1WhguWVn7n
	 di3furSAN313k5r8VKgHZCLLnBuPY7r3Qnb42GCpWDwCD3szPTjfFrogslThOlbmWmM3R
	 P5nkwuJnSsRDmRwGlg17Toj26hSk/AEJnJEmTfznWE6yMKNy5b3YC7Ym1XLliB9vtFe9R
	 vpfVsazmPvKnJnanlCVhlDyQKoqx7sb6pZxKDqvOw8xrsphZxLJ6L/ZesvH6eWLTpMnlj
	 JnnIvZ4UfU04jfk8K1ROiimxszp+wCVQdstPFYlFQR626diGD9aoPTtOjwivangtiKw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795545371;
	bh=e6tenRyB+Ht+NG6arl8FBnxUIkgqnvtj88J/19FZTy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ghapltXhf6v9CHQ4KGxMesdrtfKiZon8lgX3CdhMI8l2BI3dQ4KYg3AwRSQko9rIK
	 +rIDjlsdFKrEWFqDsPi2n9NHLpOtuzm4ebQsx0fPTB2cVvaooFvoGV2+1juCPDUk+X
	 W9sgAXD8FbFlcEbJ6hXbDJCn0WfbhxnRHlxiIrd80jFPUrRI3m3tMmyM7aedJROagP
	 SgsYTCcTBFTBwRr35uz1JOxVpCO65G5XZ/kyYelHVcP3kineZTtTRGJn9YDh7Ye26K
	 XkvKtzIRrdyy+u6VFOdov9xp2xj/5xExFLXOFGP5u/Y+blB/MZTUgC4+9VJVmuItZ8
	 NO5z6H2C2mBBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A4AE9607DE;
	Tue, 24 Nov 2026 18:36:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 984DF2F5
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:36:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8A091400B3
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:36:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id J83AhUe8rrJj for <u-boot@lists.u-boot-project.org>;
 Tue, 24 Nov 2026 18:36:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org A21FD400AF
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::229"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::229; helo=mail-oi1-x229.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=QF1pahIU
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com
 [IPv6:2607:f8b0:4864:20::229])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A21FD400AF
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 18:36:08 +0000 (UTC)
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-53ec2cc397aso2480715b6e.1
 for <u-boot@lists.u-boot-project.org>; Tue, 24 Nov 2026 10:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1795545367; x=1796150167;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=e6tenRyB+Ht+NG6arl8FBnxUIkgqnvtj88J/19FZTy8=;
 b=QF1pahIUxmFWCEpt3nbwctZi4BHQ+YYRKOLpRL8u63Z+TSIN94Ok5Y16D+K3P5Clsb
 C4kuUVwavDAcp6uVRHl11EsacEBrf9BD2l0mkQUv8OJN4wVNMYKXnakl6Kmepe8MpuML
 0fDRbMJWBcRccXk/ckcwHk/ak/BVwHn98Y3qw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795545367; x=1796150167;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=e6tenRyB+Ht+NG6arl8FBnxUIkgqnvtj88J/19FZTy8=;
 b=Car9v0tSDzscWZLTLhuHJEg9EIsg4SCbzwRtiEP+JMmM/itrv+Y77wVsVY08vztEc7
 GlRdXhHaXrhYL5KvsrYz7gkeLVq6jKdPG6qqohHgakhaRIAGAqa7Wo5jDej0aw7ISV7U
 9DDJfu/zp3E+tveFoyVc2Y3X9SSbDu/fzeZGvQIQc/Jlj62o+it6ouXV1SWM+MqrltZW
 QuMUypDl9cyZZlWtMWipdxHaLWXob/u7kcPOdWJpWurt+VX5tJP8ug0RtT2YlLJ2p53x
 nyNGs2NRHcutiDsz+1LtSreSqlaJohC9zlGgBwsK38ykmfwP05jFbnB1s5Ipm9RL5fq/
 7YZg==
X-Gm-Message-State: APuU4Z8+/9WjCupBY2e7oCLeI7UD5SJDXKHBbfIXqPqBmswEwr4oUSQC
 U5Kg5Z2n4BLDKahh0jMAPVyHKln2JpvO1Gw5srzxdIOGdVegi3Jfazjucogd7IZXTx8=
X-Gm-Gg: AZFdTZf64Vgxks3VaPFT8j8vrz7sEPTzMYg+FukIZmguVg4lF1NSqef0KNHi7pN66QA
 7O7+xTD2tu0v9rY5KZUUTDivIxflle8ozAF9rsMG8xovOml7EyDjwJCaN2JHWDysbdJV6/nZLlH
 3xB3ZCiMOr3z98tsNz2BO5wCOoS9bwlSzDEgUmTnKFSsB97LQfzKxXXzknRYmlZfOlypp4JAYYV
 01cBSTxqRjVi2SNmD2U7mKKRh2QrJzdpksw0GOxwyq2FfbKIUmi84FtuL5Q2t8XK8rC9lbh75pb
 QiLS0EJOkjSU8dkmWJxhWNIMGCOgv6MYrUjR29ld7T10AeONThASOWCTOvrWnJMNq9oQLGZjVT+
 YpRfS+MjD0qFBXAfRuof3GgGPfGPq7nddmBmWqE83ttW3PewMeR++2RNx7GrusFTArGAHNaD6iL
 iPIMutVS9wJ7Kv/bKjWvyuXvXPz0jv7wM1sQXdDkZVu50yxget29t1wVChv0TV6gr4hA9Pd6zSY
 aMZEQ/Hzs+BGrGJIWg1RoN7o9UdvFbHH71RuA17Eb7ib1kYj2gbnLJM5pJWUY5yWhNLuYsoEc/p
 3aW5k5DQe60U+7s/AwlrjFJd//Gv8siemFLbF7vBpmdG2CxZP+fhw5zTyzBYrWsGZiGxJpzXIGa
 8kW2coJlMyObbDVjMZCwlqTIL4JLmgAb0N3cSjszJaqL+CdGTJ5hzcjDQjfEx5v+r0Vz00RMCra
 j7wn6EFvJIGSp0cYoTs3Qu2FGLqluT+0E=
X-Received: by 2002:a05:6808:c211:b0:573:b907:d551 with SMTP id
 5614622812f47-57a0650ba20mr15541487b6e.6.1795545367132; 
 Tue, 24 Nov 2026 10:36:07 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-57a35c5ac5dsm12424176b6e.15.2026.11.24.10.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 10:36:06 -0800 (PST)
Date: Tue, 24 Nov 2026 12:36:02 -0600
From: Tom Rini <trini@konsulko.com>
To: "Richard Genoud (Synaptics)" <richard.genoud@bootlin.com>
Cc: u-boot@lists.u-boot-project.org,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Terry Zhou <terryzhou05@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Michal Simek <michal.simek@amd.com>, Linus Walleij <linusw@kernel.org>,
 Michael Srba <Michael.Srba@seznam.cz>,
 Chris Packham <judge.packham@gmail.com>,
 Adam Ford <aford173@gmail.com>, Marek Vasut <marex@nabladev.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Simon Glass <sjg@chromium.org>, Anshul Dalal <anshuld@ti.com>,
 Junhui Liu <junhui.liu@pigmoral.tech>, Peng Fan <peng.fan@nxp.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Billy Tsai <billy_tsai@aspeedtech.com>,
 David Lechner <dlechner@baylibre.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Torsten Duwe <duwe@suse.de>, Ryan Chen <ryan_chen@aspeedtech.com>,
 Guodong Xu <guodong@riscstar.com>, Yixun Lan <dlan@kernel.org>,
 Jisheng Zhang <jszhang@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 8/8] configs: sl2619: enable basic drivers and commands
Message-ID: <20261124183602.GY3176972@bill-the-cat>
References: <20261123-sl2619_base-v2-0-9e3b28c77cda@bootlin.com>
 <20261123-sl2619_base-v2-8-9e3b28c77cda@bootlin.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cQEOTuEpoQUCirjP"
Content-Disposition: inline
In-Reply-To: <20261123-sl2619_base-v2-8-9e3b28c77cda@bootlin.com>
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--cQEOTuEpoQUCirjP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 03:22:07PM +0100, Richard Genoud (Synaptics) wrote:

> Enable working drivers for Synaptics sl2619 RDK board:
> - system controller
> - clock controller
> - reset controller
> - pin controller
> - i2c controller
>=20
> And commands:
> - dm
> - clk
> - i2c
>=20
> Signed-off-by: Richard Genoud (Synaptics) <richard.genoud@bootlin.com>
> ---
>  configs/synaptics_sl2619_defconfig | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Things should be re-ordered so that the defconfig is added as complete
at the end. And related, the SYSCON note I made in my last email applies
to the other drivers using it too, to be clear, I just hadn't gotten
there yet. Thanks!

--=20
Tom

--cQEOTuEpoQUCirjP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCawXZEgAKCRAr4qD1Cr/k
Ci70AP4z24hUWUFo8PGHpgMBlrUDTZSSBK/mcn/zfGB5TpnMPwD7Bz6GERvxHQY7
jJatN7zBizEF47EqXncxfrf5pP9rFg4=
=CqRn
-----END PGP SIGNATURE-----

--cQEOTuEpoQUCirjP--
