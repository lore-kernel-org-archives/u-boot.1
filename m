Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14062606A31E
	for <u-boot@archiver.kernel.org>; Sun, 15 Nov 2026 19:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=BZ9nx0zd;
	dkim=pass (1024-bit key, unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WxPBHhzs
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DFB10406AF;
	Sun, 15 Nov 2026 19:02:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PqIaWz1LoNab; Sun, 15 Nov 2026 19:02:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 123074068D
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794769331;
	b=pxedgcrGu5CTvgTRL1IGQcgogpGd3m2aH+LWW5uuJFXFR+fH5aZ267DA3aML2vCs7kk0
	 blg5xw3HVIe3tUvaveWnZkihiGIuGP8eDYd3O0rU+okddGxXM/mOKHHeXEWrYvyfNUXI2
	 3Eq3rLNGlZhPRBP1I6a9N8HSOOP3fCxK9Wz8EiT2TGGSR6k3dQ2YBydt/7lz1IXfD6Ep4
	 T8YnpNyd2Ov+Na/s2Hb7uzIyh7L6t2YL+QG1UfDmxFpQHzqEtyVbNhzDSAwhbA2Zr/hzz
	 poOCVyEnpA1ejICsVG5kWhRTrMSzyTEMSpEsPO8rsfrGISHteYsHZBTx6avHmXDBgsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794769331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=QKFr05QDgM4kb37zlz/7lGsC08z0PqV8Y+zydaj7YEo=;
	b=q1PStPA8Dp47JnwXfhGMyTjElKIeYxnhk/pXOuyuRC7TOx6qZQbit+DgNqN01cFD2MRV
	 J+553H+qT5URK0uGyYZri1346mauAqm1uoC2U8EYYzJmLP3L22KhmIwa13gLvIwGHjInm
	 c+UY/5f+nmL6ipQlwDBJllYziJipM3zNz/Gc+PWJA6YSc0dxT9sUwEFiWV1VQfJWAlhpC
	 P4Qeq4rSE0857n3EBDOm+XkovC0UWGzaMYvktrzduVujJ9JEo1M6hrvmpvvFDJuhPPYKj
	 BThrZOi1OsfYdDeh6AL3kx+pjevjZBN6jwOp1UoOR69D8ky4IfuuagBo2xtYtT16ZcA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=konsulko.com;
	dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256 header.s=google header.b=WxPBHhzs;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794769331;
	bh=QKFr05QDgM4kb37zlz/7lGsC08z0PqV8Y+zydaj7YEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BZ9nx0zdB3nEpEdD96+myWoJ+3S20ZeuLkPGERKHIX9lHxDjyXnnqiTb9tscwTWeo
	 DGiucnOYWXL/0aCUUEIpq9Qxk3KxlsLi/0DC/6TzTIFm9SfGD8NZIbVc6tA8QhPRp7
	 WTRLBu7oGWg21eGOxVF3ltDPaGA5UPjwZqQD3VbM13kqvmNMQ5lcKuWgJWBg5j6lFa
	 AZ8rkMlcf2dVCnQ/QYrZaa0aObiEQG0tZAm+xI/DsHBqLMGbFCE2XyL1CeImR7kd1W
	 N7trLAHb8GQPUbtkNMgLKmL/Him/n6B05HniKEYvWjbjb7B5NxyuA0QXjJMIXfNr/T
	 nWUkZ1kar9CpA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 123074068D;
	Sun, 15 Nov 2026 19:02:11 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id C2B5E28C
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:02:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B413D4068D
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:02:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GY1zUWbkH0vg for <u-boot@lists.u-boot-project.org>;
 Sun, 15 Nov 2026 19:02:09 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org B8CB84066F
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::32f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32f; helo=mail-ot1-x32f.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=WxPBHhzs
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B8CB84066F
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 19:02:07 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-8479f46ecd8so921476a34.0
 for <u-boot@lists.u-boot-project.org>; Sun, 15 Nov 2026 11:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1794769327; x=1795374127;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QKFr05QDgM4kb37zlz/7lGsC08z0PqV8Y+zydaj7YEo=;
 b=WxPBHhzs1FZGDI5kLl2gvTmbOnxkU1+xJeWpO+eEib+eHhq+mvI/y/LH2/neysSRBU
 zpmYj07U6n4IaS3zw3CwzA+8C79ArhfqB/ndbVJxrWV8metcg6nE9geuhPf6YJQccxRJ
 Ln08WSCUwTRbbzD7gEE+t95b39PEBZ/QK/INY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794769327; x=1795374127;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QKFr05QDgM4kb37zlz/7lGsC08z0PqV8Y+zydaj7YEo=;
 b=tnlfCCjA3o9z5XbfR6ElpP5e8AqLQAHKiLRE18nv1HtOgbRxE3RqujakbI6b4nROaR
 Ep8iYBhJWrMYoqYNXTnezYBWlyJwwKughw8IzIZvcXdswfSs6ayhrLbKz2LgKhthLjXT
 qLQJtpdmzdnrhSq+d9Piakky14hWqrEBkn5q2SWLAqsf5SotEaY59pEnwPdcEmtWVynp
 IhoDzDsdFjaK+rIf6RNI8L971AjaDRbYgwT2yNO9ZB3mzyhO1EX/pa4IajgIT7o5303r
 eB+CFKFjHQFya+RLSdY6VaklxyKSb/iVsWuXlEBG/WHnsx8HlGKBhYkjfhK6Jjz408MK
 hsrA==
X-Forwarded-Encrypted: i=1;
 AL+hErEoAAkKoi16XWmrkBv08lrJFd64BpmADS3pDBftoL5vU2IFNhF7dCVH/e6UanNmQgIiJxg2Ezg=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z+i1CjT5qmw/G6OLUGMywFrczh3I4dJ6dnxPWzfWssJALpQUXWE
 rcPTtHxKLkMuV2SONWERhaC5oWFudil6NVGsXqHBnKsojs8Yw/bot/XPMYsT9qo631E=
X-Gm-Gg: AYBFou2MLbjz+P36KbSLK72Mvwjev89Vdo+XXXjkCmiS8q5cSFcALc7q9ku2mBbI91t
 BfYVp0uRGhUkifd36zqOdsN+xX7zTsCzsNbHmgU4miQ+ZL/71yQq4SUiCq8uOBcnazA34z+t9bK
 U5Gf/bFDZPM4ow5PcgxAt5VPCJPlDSqS/Ty3acWDIiYsJyNLP2cKIXQNtzP4o5qclxvIP3sYhID
 nqAfDP/1BqSjjv2S+Pz14xSCBNG5p7g2po+rkGzdLpYdplNkRexQG9z4to+3wqRIZMmXQUR5h4/
 33fiOI9toL+BGEUdUpzEMxhnGidK92W69olqAhQZc3ULN5imda7xMgwfHRfnpjzHySSHRMtWni4
 cuxjgkl1vXWV7+9bwwXmLC/Ejq0zgJztpeMql9+7z0StMwQYTAgclzN1IA1k1PP9Pjn9rYMuZB3
 a47/JXtj/YsqR1fL09lY5HSFJ0OJhaJrvL7dMbahTD5i38Lqriu7YuDKH9W72UHV8f6aaqG5BUC
 YYyXq+FcCUVMVWHlILZaGbyyRa1xLLvACkYhoSN2BnH+fKxEdsCjsee5TYXTgFykxNwBzwhafAb
 5QRjPrukiqUgyegum0+m5jSm4VbD7oxoabER1gwfWhA5eO7WVflBZGNV2FKTtyiqG1lsZcdnb9/
 qF35UnnvRk8AOxuBbrjYDaPWIcg0nD8rbkvTYSQlC79iYi2kmBsSkyT82MaEBtT+Y3GXWvutp+3
 rvbz7LLhK2QrwAcZh4t/kl9CdrPzt5o3c=
X-Received: by 2002:a05:6830:4c0e:b0:862:b2c2:9abb with SMTP id
 46e09a7af769-862b2c29b96mr3426673a34.15.1794769326978; 
 Sun, 15 Nov 2026 11:02:06 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-8628812e44esm8817705a34.15.2026.11.15.11.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 11:02:06 -0800 (PST)
Date: Sun, 15 Nov 2026 13:02:04 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Guinot <simon.guinot@sequanux.org>
Cc: George Kola <georgekola@google.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] configs: netspace_mini_v2: disable default netconsole
Message-ID: <20261115190204.GW554944@bill-the-cat>
References: <CAOTQ16+AbF9iURWBrU6_NOM14KCq5-s1YFbbP9ULe0Ch0hhAZQ@mail.gmail.com>
 <20261115180628.GV554944@bill-the-cat> <avn83NoJA8ZKi1q7@localhost>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hDPeX08L0jiHzir+"
Content-Disposition: inline
In-Reply-To: <avn83NoJA8ZKi1q7@localhost>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--hDPeX08L0jiHzir+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 07:41:32PM +0100, Simon Guinot wrote:
> On Sun, Nov 15, 2026 at 12:06:28PM -0600, Tom Rini wrote:
> > On Sun, Nov 15, 2026 at 09:12:23AM -0800, George Kola wrote:
> >=20
> > > netspace_mini_v2_defconfig runs dhcp and activates netconsole in
> > > CONFIG_BOOTCOMMAND without setting ncip, exposing an unauthenticated
> > > UDP port 6666 console that accepts broadcast packets and drops to an
> > > interactive U-Boot shell over the local network.
> > >=20
> > > Remove dhcp and netconsole activation from CONFIG_BOOTCOMMAND and drop
> > > CONFIG_NETCONSOLE=3Dy so the board boots directly from local USB or S=
ATA
> > > storage by default.
> > >=20
> > > Fixes: 970bf8603b87 ("Convert CONFIG_USE_BOOTCOMMAND et al to Kconfig=
")
> > > Signed-off-by: George Kola <georgekola@google.com>
> >=20
> > This is feature working as intended, presumably.
>=20
> Yes, netconsole is enabled by default on purpose on the LaCie
> Kirkwood-based devices.
>=20
> When installing mainline U-Boot, you need a way to access the U-Boot
> console in order to configure the environment for booting the OS you
> are installing. The serial port is not always an option, since it
> requires opening the case and using a serial adapter (that you may not
> have).
>=20
> Here is a guide describing how to install and configure mainline U-Boot
> on these devices: https://lacie-nas.org/doku.php?id=3Duboot. Much of the
> procedure relies on netconsole being available.
>=20
> Note that you can disable netconsole support either at build time or at
> run time if/when you don't need it. But I think it is better to keep it
> enabled by default.

Thanks for confirming.

--=20
Tom

--hDPeX08L0jiHzir+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCavoBqAAKCRAr4qD1Cr/k
CjH+AQDc11oVWcHgKYNHGAjE3jzdO8ZuXBZn48hf5R+JP3FxdgEA2deDAFNNZIpg
vojufxxtl8zO+IBuCwEzOwg89pdFmg8=
=ea3S
-----END PGP SIGNATURE-----

--hDPeX08L0jiHzir+--
