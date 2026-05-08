Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7A7DCD3436
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 16:07:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 579D384D5B;
	Fri,  8 May 2026 18:07:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NzBC5acT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42F8284D68; Fri,  8 May 2026 18:07:55 +0200 (CEST)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D8AA84D17
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 18:07:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-47c35be031dso1325010b6e.3
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778256471; x=1778861271; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2jtMMv8jK6/iGRDO3LnOo0EQkQPE2YuBwOKVE8+UeVY=;
 b=NzBC5acTCO+6tO275oUXtf11HY6XOwJHN24CPWs3RaU/8MThL+d2azOBPjnsU8uZ1K
 UTw4sdn+jMU+OpMcCNULS4beGI10u3F07++TajX1R9RnZIK3LtOkd+M1actBCK9AWbUJ
 jbJK/jcS5YootefraZBQ/zGUMr5W1lC+So/Dc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778256471; x=1778861271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2jtMMv8jK6/iGRDO3LnOo0EQkQPE2YuBwOKVE8+UeVY=;
 b=ZNQplUoaSldm5SN+Rgm+Afd+Breh11hpWDfUTd27XCYi0j/vE511sXIVb/HdWjbFVg
 JK5E2cB9xet071Cn15Urdt3y17ahXD8gnk7AdMNIFIEpVZElgnDp/i0kp0ZaRbLiwu6W
 MR3kcxD/nwDndkLW0ZuUA4Th0X+q9oVymop+Q7inzLyfaovyZJnEHyY5HQ1zewQeG5yl
 8V04KsnV0191/750XXwkdX9lHDNMmtLhpewHJBwvh3v+dVhOOc+jLQv4E/0/Lm6Y6HSL
 Iyv1Q4uQuiwNriqaXnHuofdHwEU/Ma22EmK0oIB7wAqYR1oK8vFcc91vRFIWCrw26Mly
 lU7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gxY9wLNDq4FxumKf66UGa8vW8/nzH3xO8Ik+uf8H2xRfVEcK7bXtbECgu1oz8jYyAPisoG0A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3PN21W1KaTl32ZuBc5MAbNnMMJKlkyQ0P5hZGSzAsZMUPxZe8
 KTYH3sKfWiiZ3nvOOmeXhdkeosuIrq9x7bLdD0mVtBThGCmIFTHcauM1dUSXMrZiclvVmM8lMN5
 vcCCIZNbL43Hi
X-Gm-Gg: AeBDievomtBCLE1IaYH86QuNcLEsF1sTMpNOmhIWc3PZALjSK7SGJ15TRk0uOVmwpT3
 SGNREf/aB17Nb9RD0aFJk/a85/4UjbXqUhAHm4ivRtyuoJXqFPKi8Z+p73xSIkCgx/H8/n1CjkO
 6fdRfbzFS93/lKmM4695Yl0gKQVOBqfeVRoaFnRkgIqWboe5liYXEJDweotI/mxuPFpozi5UWr7
 PPQCSskcn3eDg/jikpVERFrCqnoZqgrL1lDXiQH1BwCtQCcQnQ3ER7kQCDK8dU/Ch6ecd2K7un1
 SQOO74n37UHAF8hdrvsq33R/DH4hVgmdZIB8ZAofgNQq2+kp7BF4a8dSysTGIepYoCzfUJbUoYH
 DoMqBw4TFaiUWjxEVM79PjXIvVr69C1O6YeexqRgwPJr+0OC5/rfooDq1PmFkNton08f6g7BAAX
 kZ5apGzRugnmp0gyZgrzgkU2DAE5yMJ7Pg4qkZFnj/WmJDT8ftXozs+iGeziNobRPVazQo6JFXT
 NsrOzL8RFLZEyMHJ4aCui86KSVEeyfHwv8EDa3WoOzw4h/TIeU1zQNr5ovl9A==
X-Received: by 2002:a05:6808:67c3:b0:46a:72dc:28cc with SMTP id
 5614622812f47-4807fbf813emr1979956b6e.1.1778256470991; 
 Fri, 08 May 2026 09:07:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-435570ac625sm2102866fac.1.2026.05.08.09.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 09:07:50 -0700 (PDT)
Date: Fri, 8 May 2026 10:07:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Mugunthan V N <mugunthanvnm@ti.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] am33xx: don't assume we have a UCLASS_MISC device present
Message-ID: <20260508160748.GW1614990@bill-the-cat>
References: <20260508-dev-am33xx-v1-1-7ec76860021c@codeconstruct.com.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p5jtm8BOJy60OqqZ"
Content-Disposition: inline
In-Reply-To: <20260508-dev-am33xx-v1-1-7ec76860021c@codeconstruct.com.au>
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


--p5jtm8BOJy60OqqZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 08, 2026 at 03:11:32PM +0800, Jeremy Kerr wrote:

> Boot on am33xx without CONFIG_USB will currently fail, as we error-out
> of arch_misc_init() if no UCLASS_MISC device is found. This requirement
> was introduced in commit 3aec2648698d ("am33xx: board: probe misc
> drivers to register musb devices").
>=20
> Instead, only attempt the UCLASS_MISC init if we would expect the MUSB
> TI device to be present. Add a comment to explain why we're doing the
> device lookup (which we immediately discard).
>=20
> Fixes: 3aec2648698d ("am33xx: board: probe misc drivers to register musb =
devices")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--p5jtm8BOJy60OqqZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaf4KUwAKCRAr4qD1Cr/k
Cp0aAP0YGkOi4OPtiM6j6Mavw6B1r0XQ9wfL8UKxJsW8EwyKVwEAyoe8XvXmv5m7
2k3N1f60Bg9tgVr39+EC0p8oVvMNVQU=
=nNKy
-----END PGP SIGNATURE-----

--p5jtm8BOJy60OqqZ--
