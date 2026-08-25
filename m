Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BB39C61DB9
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 23:00:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 34167407C3;
	Tue, 25 Aug 2026 23:00:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id s8c2oyZxSVWc; Tue, 25 Aug 2026 23:00:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787698851;
	bh=R/zUadyZrw+sjkA3Issk+v6hYKQiWBLEp3Oj47Y3+8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zTVB4WOYCF/n2ce4JTU64CwXXb7oAj+wheItEVwQNZ0zUu4IBNJEsAYbEzgLg5eDX
	 YWHKum1ZhRXlrGcBEq8avBW23CR/VowIUzfryjXsH4NpeYmX4GnxL4+0tY7Xndx3ri
	 EB3GwFqYxzA8wuXttUg+kvoqHkcuORRtapK4qPTW9h8Psje65QL4Y9sUPSAUrrp5Mi
	 KPHin1TE93Fhab+jZJSl7Eg4CUIld4idY70Z1SbV/JWT/VXb/7PQcG9k317NbvgSVx
	 qlxMfrX9cETAYZrLZ87opbnbhrX4W6ngAGOA7AO1IAsYYQXmNkyYjq7hBdQ6YATs1P
	 wnQpDp4fNdyzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFB5F40778;
	Tue, 25 Aug 2026 23:00:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F1B78396
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D78C040055
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z146bVKIWmVY for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 23:00:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::232; helo=mail-oi1-x232.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=o7NZpCay
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 24D2D4000B
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 23:00:48 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4af173320f9so370152b6e.2
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787698847; x=1788303647;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R/zUadyZrw+sjkA3Issk+v6hYKQiWBLEp3Oj47Y3+8A=;
 b=o7NZpCayIiyapC7MoIvxMqxh2RSpEVjB+27ruK0x84WONhESiJlV0GTWxxON/PJG5+
 R97u+jT98SrPS9zwGmWZF+ehM+13Kce90UlZ55e92yIL7ECH0U6OZkW5vLGki5werMG3
 uhJA41uLsMyqVu0KQQsnpOEBnFPBzKELhVTPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787698847; x=1788303647;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R/zUadyZrw+sjkA3Issk+v6hYKQiWBLEp3Oj47Y3+8A=;
 b=iePB/H0wJUu5QK9AHXWyxbVZ3vcrrD4lUaD/Z6SMcB2/+cxGgK2CamNZGTXwy/IM9w
 DnZrzE9KxfHR0CL3+LGJnfi4aWHsanU/n3J5pxY7/1t/SxNS/UKTObXYP1h/sx0aQjAe
 GX8+9F6zwA+SCVNT3nkjfVQTxpf/+Vinhlm6jDcVAnS2mtXDB+ozfOUYGkNWB9mvBO4M
 JIoMTCkGn3e/8qZphYbwqjZ0+I//URk1leUdRBKvSrdPgjxW8gTlJjE0is4YIy2GHvQN
 lpgM5usbmGsHyT5E8aoari9wFRcBqmg1wg4PLGN4sFNFYdjE/EsS4+Ej5AP+ayltR4E/
 a3BA==
X-Gm-Message-State: AFuF++k4BsWysYTlcilNr8oqePBKQlqd4R6+SwTydySK0EuvJVcgX7La
 rwPBU6BtMwIFDUbPmZgjdxmpHw0+cb3+4l1fEcT46qU5neZ1iTFC+dx8oPR9Kfp+P9Q=
X-Gm-Gg: AR+sD13MQfOkMSqXlkaMrKkZciH8SuXR7wISjRaciiUd0Ou0oOQuuDtghWazRtx9Bym
 1woksc/WiEBHZ2EJaZE+qLk1j2bVxA8QRXFQdr/H8RMJmB4XfGSg7eaJJGhtsTudiYYzsoeRWxe
 xEXIXANuv5IyK8heYG0qkkqmv+ayayS+/8aYNlEwxqiRW6qtu5/B+7+vy1d6vGFa+uKecLzr/sS
 hfBO4qqwnUB60DfrO5tZ47w1PNsimCzAhWJypN8xTbdBz2X2dfn5ChYeEizo2iy3TmmoZ81BGL9
 7H4369LZSO82CVmUxGpG8014YyFEJc4hqbW0juAAW95yekX4P09Iftz1RVOCKZGHpOu87z2L7CJ
 7lLORCuCGYnJk74ykjWwa3RLkJD3aqk2OvvMzlB9nkwg5ZgIDTEKH/fCbfKR0B9uwMzEJ/jK7RE
 9Ko7QAxdJvO5kHhhoSbFoE8cq8PDoPe9dwvQOsyw4wScWFyiRm8NnQK2t3pOPZuvOkkD1I5M+ek
 ij3Hlw9kF6aFQsGNngmNL0POEetduNWVFCE4iPxUMxJ95ST1JHlQiHN+YQuPjydTCXOqgOC8jQf
 KEr8BKBVnQ==
X-Received: by 2002:a05:6808:1246:b0:497:df42:1e05 with SMTP id
 5614622812f47-4b366a1883emr2847252b6e.8.1787698847515; 
 Tue, 25 Aug 2026 16:00:47 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4b36abbdb56sm186997b6e.17.2026.08.25.16.00.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 16:00:46 -0700 (PDT)
Date: Tue, 25 Aug 2026 17:00:43 -0600
From: Tom Rini <trini@konsulko.com>
To: AK Sharma <maskachoska@yahoo.com>
Cc: u-boot@lists.u-boot-project.org, Christian Marangi <ansuelsmth@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH v1 11/12] board: econet: add EN7528 board support
Message-ID: <20260825230043.GH523975@bill-the-cat>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <20260825224330.713151-12-maskachoska@yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dQWBxJ8LFot5fRq5"
Content-Disposition: inline
In-Reply-To: <20260825224330.713151-12-maskachoska@yahoo.com>
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


--dQWBxJ8LFot5fRq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 04:12:06AM +0530, AK Sharma wrote:

> Add the EcoNet EN7528 board: board glue, the reference/RAM/tclinux and
> JCOW414 R3-hook defconfigs, board header and default environment.
>=20
> Signed-off-by: AK Sharma <maskachoska@yahoo.com>
[snip]
> diff --git a/defenvs/en7528_jcow414_r3hook_env b/defenvs/en7528_jcow414_r=
3hook_env
> new file mode 100644
> index 00000000..4bc9e278
> --- /dev/null
> +++ b/defenvs/en7528_jcow414_r3hook_env
> @@ -0,0 +1,5 @@
> +ipaddr=3D192.168.1.111
> +serverip=3D192.168.1.166
> +loadaddr=3D0x82000000
> +bootdelay=3D2
> +bootcmd=3Dmtd read spi-nand0 ${loadaddr} 0x100000 0x1000000; bootm ${loa=
daddr}

This should just be in the board directory as other platforms do.

--=20
Tom

--dQWBxJ8LFot5fRq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCao4emwAKCRAr4qD1Cr/k
CjhmAP9QSuRI+aCMEIXnlcVL2R5cVv50Xf6a3UIxEY0C+GbZqgD+LwZ61QZXtUeM
h0iAe0qSOjpCd5tb1OiiWTuXpRTofgc=
=nR62
-----END PGP SIGNATURE-----

--dQWBxJ8LFot5fRq5--
