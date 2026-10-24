Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E1F606A31A
	for <u-boot@archiver.kernel.org>; Sat, 24 Oct 2026 14:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jIMfB6Sr;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=g2XNHOsL
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6FB408167E;
	Sat, 24 Oct 2026 14:24:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qWkX0oCnSWzu; Sat, 24 Oct 2026 14:24:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 7B4458156E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792851841;
	b=FlPO9uZseVXu4/y1zh7YJLhvPh4c7Fv7+TvQ/gVA1tViTVy11A3I+QFgu/1ry1+5wmvP
	 XXzjkdjAlbGoCPsShgRz0nzD28Bqeq7INWqOFBsKA94NLPU67o2PjWUBuWBg017fdp1zv
	 Z9uhxNiGqo3sH16Yzm1OVvCSmMeg6oNjXS8sxjuJzmPnX69ym1XyCtn11llDj/BcHJHJt
	 51gXSI+b7sT0s9gN+2sj6TeOJlJSLTSMje0QGBFHbKLnbeFRudyFj7t1m6Ou2qU52qZqN
	 u4RSyJjV5evgG0+//Kj7UA3YK6ghsPn6Za6L65YL7l2dS+XJdVH/fmfiVo7WYKQWqqw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792851841;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=dUxGj88Ma4tlKb76tqSERwqiE+dfcc1J/lAt755N8Pc=;
	b=dts6+AzldlGBKuuhdcUtVTPRX/kgXp/HcYDll74sbSO/p91YCDdgSpbM1mkjLef5PRZx
	 DZkulRqITtl7eOnMWJVadIL9gCAZU+U7eaDpcDqbpG0GHPLUfQ7u8w5h50KS9RUL+TWVu
	 rhaMqu+l5bZ8iD4fSH+xsHs04eXFU5hSODaQeW3cV5fyxfUIAOtG4ietyRgLkKYFk8lQ2
	 AirFWN8hi3ogHbVG9sPhDtosLbQ3W8T5VARCIG08TNJZVxL3GFtp/oP4ObUBA9Ru3YS4T
	 lgEYjrEGZau/8nofNzmdF1/EZAj/U8Md2xGPepfL9BizF2uL45OFljRD7B5Q4+3nmWg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792851841;
	bh=dUxGj88Ma4tlKb76tqSERwqiE+dfcc1J/lAt755N8Pc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jIMfB6Srk2XI9Dtl+wte0CPkY031NDM9DbCVQiAj5fPHBk5Hic+EB3CkD1UY6lMiu
	 0YXUEnS5kkhwCBSDirsaORtvXHNUumuOICrsKeScpGC/SmTPBlYoO9GyHmCcK7Cd6b
	 6/QIk76ciBXbKoj0n3auU8EaNXtxBtEvLXgkocx2W0pV8jC1JJTI5lIK/Ntq9vHsxs
	 05smVdh8UWKNIGmTGPNO7HORw8pRv3ycD+BNySq99bxnRypoIS8BSmrnJyCc1cGdcB
	 X0uMgIbcp6d+mtUDI7Z4E/yrlI4g9tQHieJkYp/3KrIMp8+mVD4XMkASEqgQB7clJH
	 JP6MTtOiIkGgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7B4458156E;
	Sat, 24 Oct 2026 14:24:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 2B2A94D1
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 28C06400AF
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:24:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ny-3Gj-U2s_2 for <u-boot@lists.u-boot-project.org>;
 Sat, 24 Oct 2026 14:23:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 230AA4006B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:32::5"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792851839;
 b=L6hjrsq3OQkyYQJP9JtN0chHf/s9vcAJHVqQ4jp45RlIITIqAOh7Q99IKHxyLqj9euPH
 kYbnvrPdNynEc96c98dXv7LT8bzGNut5zvwKQlWCArHDvDrHsDEbnNyZFXVStonRIXJvL
 slUB+fF3DxZhI/WM33SvHT7b5hFMfGYfBo2Zkdkl7lyXgXq8SBzi6//PZbaHu4DCEbHBw
 jK6kavLbcuptp7DkYnNmX3qjTB8q26UF/UoN7a5xy1gqFFYWZyW27HsYajhDZOC2xRfI9
 u+pi0za3WaV/YzGwMx41AaOSiNeMyjBq1tqJa+y8lRjBOLddlimvKLIZDLEVQxZcrzA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792851839;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=dUxGj88Ma4tlKb76tqSERwqiE+dfcc1J/lAt755N8Pc=;
 b=YLOMrdQOvFWsu8HkwbiMJtmgiloN1mIPUeB+q3uwcAN64IjqJUCndfR3pv4Fis8sYUS4
 hv5WqJKX+Wu2Lsfbok5kHUnAYqR+5McsLpySoi6WmkcLOw25sF62TNZuvES3xe+mxjkDu
 TJYmIJ3PFNUVb5aLkxnExM1g4PS9Nn5PyS0fX7b9E66hu06GOcmDUj4y+bdYDaQGhCra1
 2Er9iPeEXbVWpIv8G2eeiiZTawLPnfpKyVDyGkPK0ePpcyaGf23GAJK2WpKbCd5Ba753m
 2D9Z+jEWvxHkH5NaOxaDmDFTUzsccBnaPPImt4RKNS0eFy7RBbZPDnB/zIo8fazdx+w==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=konsulko.com;
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=g2XNHOsL; 
 arc=none smtp.remote-ip="2607:f8b0:4864:32::5"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:32::5;
 helo=mail-oi2-x05.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=g2XNHOsL
Received: from mail-oi2-x05.google.com (mail-oi2-x05.google.com
 [IPv6:2607:f8b0:4864:32::5])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 230AA4006B
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 14:23:57 +0000 (UTC)
Received: by mail-oi2-x05.google.com with SMTP id
 5614622812f47-4f3f1adebb0so637580b6e.0
 for <u-boot@lists.u-boot-project.org>; Sat, 24 Oct 2026 07:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1792851836; x=1793456636;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dUxGj88Ma4tlKb76tqSERwqiE+dfcc1J/lAt755N8Pc=;
 b=g2XNHOsLgcnq9ulz5pnMyyPgMnmjIIAenQ8mhmro9T4/e09YctyaX5vVkBYah1EJvm
 APIZR8cFho1yzvsJEDhKp8VdlKnUjzfEl+pJQrmR/5TQtkydh/Y7UKjMYrKRAAU9AwHb
 u6UHRz1V1xGLH8tJmL/8ZKSXjaGOPhusq/NhI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792851836; x=1793456636;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dUxGj88Ma4tlKb76tqSERwqiE+dfcc1J/lAt755N8Pc=;
 b=KDUHhsmZG1em+KzjEaLeREiWeF89kOfpM6SlV1XfjiWjPYDqbj8A4OE69rdgx1df0S
 HLXWmX8+MED5ixyWD4Z8IiagP2+RMopYjX0CGkFLFgNRaw8LlmRrDWV5sFAPY7gABAiW
 LciEugtZI3QbGfuz0/iAaYOt3xOk+1I0DxHVJ+4P8Dygg5QnDHtfE0qzjmvFwt4+5JGC
 cnWU7sAQ5e+8AANLvzKFfHhAlDUO6uVkHMLl2zdlL5Kt5bvV4RXkEAzAs1jpWFoG2aeJ
 yizI1ME2rKytlZbIRTaptIXdKg/yJrvXzQ9Kx16HrduKQiL8zNjES6YQRx5t6UAKJzrv
 HL/Q==
X-Gm-Message-State: AFq9FYJKEK+DH46qQOGZjsDHgijcRYmvsPemCMd/gquozEOQX+Zirw6B
 25G35BFIcQM7jF/lh+QU7+3KeEKtk63YK6TN0jJWQ28HOnuvEEyHWpkgCGYriTi6uSk=
X-Gm-Gg: AYBFou332zE2XC0u5bwl6clxyFG/ZjvfdostqX/nvRmjC9f6tilMagnqj6+ZplKWhiU
 rFi9KlJ5rt1JzBVuUF4viTrWdqjaoJYtiQkOyfLguxQ8JBFU4l2GzjnuREzUSee8SSPYJa3rLBw
 hrAw8cbnNHwZFhJgwmwdK9HxVm6M9I5/729ajWbckNUGDnDkyywhASSbD7WW1T6OwZNlgo0JcJV
 0yFPUgDQP/Jmmr6JuWTNjS1wFSIKpEZfJ6OyM5E+AnHmTe9eE9/UKN/0Dvpcrv8t/VmT6Zult5P
 iBRQzP526pCL1c+2z642CqAmop5huuHQLx91Pdv0bDwmpJEYxrbPeZOXI2zakb2Qv7HKFGSnRBF
 iIfW6p52wA/RVxZAeO7FVL9f2HjEeGoNqyEOlrHiQW6lpCj97jGUnHFIGPVHQJbYCLzEYOUJWpU
 /1hih6jpwn+MEAn8mRO16j0kvcs6juMZ3CFI2hdZ779F3lrOkCvIwP5IpfHbGdGi0OfoLBfMaCM
 Nn9Uhp4uSqDTnM3byc9boOuh8DbacgQM4u0Ntu9DfDt7mEw0JulfD7opse4TqJr3jWNnv0DH6cE
 1ZpNeqHkfwISBmOZer/mcv0tLyfRWSBniVuoWsr81L0S65nccWHgAwiBbR781k6AV3Wq8z16EMO
 lOoe7cFq3VPx0eR/sX8cY7llTj/e8hj86nc1i4z1KNu4SCMyF4Of0hMaImA==
X-Received: by 2002:a05:6808:c40a:b0:4f5:c4b9:dbfa with SMTP id
 5614622812f47-55c0030f23amr1302182b6e.48.1792851836588; 
 Sat, 24 Oct 2026 07:23:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-55c042da8c5sm1299351b6e.14.2026.10.24.07.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 07:23:56 -0700 (PDT)
Date: Sat, 24 Oct 2026 08:23:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@nabladev.com>
Cc: u-boot@lists.u-boot-project.org, Alexander Koch <akoch@initse.com>,
 David Lechner <dlechner@baylibre.com>,
 Flaviu Nistor <flaviu.nistor@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Takahiro Kuwano <takahiro.kuwano@infineon.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Indent SF: just like other boot time
 messages
Message-ID: <20261024142353.GA29423@bill-the-cat>
References: <20260611224544.210172-1-marex@nabladev.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ngN3wFeLy97IxIwj"
Content-Disposition: inline
In-Reply-To: <20260611224544.210172-1-marex@nabladev.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--ngN3wFeLy97IxIwj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 12:45:19AM +0200, Marek Vasut wrote:

> From: Alexander Koch <akoch@initse.com>
>=20
> Indent SF: just like other boot time messages. Change the original indent:
>=20
> "
> DRAM:  3.5 GiB
> Core:  310 devices, 34 uclasses, devicetree: separate
> SF: Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, total =
16 MiB
> "
>=20
> to the fixed indent:
>=20
> "
> DRAM:  3.5 GiB
> Core:  310 devices, 34 uclasses, devicetree: separate
> SF:    Detected w25q128jw with page size 256 Bytes, erase size 4 KiB, tot=
al 16 MiB
>     ^^^
> "
>=20
> No functional change.
>=20
> Signed-off-by: Alexander Koch <akoch@initse.com>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
> ---
> Cc: Alexander Koch <akoch@initse.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: Flaviu Nistor <flaviu.nistor@gmail.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> Cc: Takahiro Kuwano <takahiro.kuwano@infineon.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tudor Ambarus <tudor.ambarus@linaro.org>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: u-boot@lists.denx.de
> ---

Sorry for the delay on this patch. It breaks the tests which expect the
current spacing:
https://git.u-boot-project.org/u-boot/u-boot/-/jobs/124896#L292

--=20
Tom

--ngN3wFeLy97IxIwj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaty/dQAKCRAr4qD1Cr/k
CtBRAQCPW+ezSn3pfpw7rzBJgbEr0sR9gCXsZkiBgrM7ScNy8QD8CnywbJ/WikEl
Oyc/2BRR3aDDKBgPiXOVZ5AKDCrr6wE=
=NTTJ
-----END PGP SIGNATURE-----

--ngN3wFeLy97IxIwj--
