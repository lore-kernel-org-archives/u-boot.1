Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A787C48BF6
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 15:32:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9296188035;
	Mon,  4 Mar 2024 16:29:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k46bG+60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8028D8814E; Mon,  4 Mar 2024 16:29:14 +0100 (CET)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 788038809E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 16:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-78810ba2ff1so112524585a.3
 for <u-boot@lists.denx.de>; Mon, 04 Mar 2024 07:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1709566151; x=1710170951; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JYxJIiImw3eWcombEU3NILaKWXmJ6a742rljDHwlWQ0=;
 b=k46bG+60w4XWY34p5xzO64x6eFCO6yF4LU3t+xbaIbrQ1u5z0OYVq3fwN3aA3Ki++h
 PkFOyJ3PmiJ3a968WoqkO897eJtFODhUpNMAbv3OsiILZLN1I0kNvVQP5iF7Z+VVWRHp
 7mrUSYeS6KrbhtHX8hBwO8FzECZ9XslQ1Zfyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709566151; x=1710170951;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JYxJIiImw3eWcombEU3NILaKWXmJ6a742rljDHwlWQ0=;
 b=tOQrVQh8R1NOHtwVBgKXcf5GRTa6U/BpZI44wMWkjetlq+V9YD/AvibGg7Uwt/x+cm
 Eeo2ReRsR580L7gMXl6liGiL0oXWkUJRwLQo45M6wIyeMgv6z95WeUWMemnu8VE9Or7o
 gvWYjMBWamf0V3J4e3wxFyIp7d9f0LyctaYObj8dMwa4Xf/QBWi0mflPWImhUWHkSCM2
 XXN95lVHopaUeU1wK3RHEEuEc4E2R5LTyfWX3+xoHxzNVmJ2TGRO1ci3HJNOmwrGv7jz
 7YNq4hkaeL/9YveBrwjXxxhNxI9dX4Y5DEGTrreR3LMlpRFJ/5hwl3IK7zmmpaMOKdIh
 x7pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1PraYX3Ua6wcRNUlrljW8MTTXlalZ+l59xZ1bEE2tdZiJdB4tTbJqu7wVlmT/4j9p9rn/Ds7vbCJXafBIRL4mEE54Vw==
X-Gm-Message-State: AOJu0YxjkJC68EN7bZagRFfABeTQot8NgjNzh554nJPBYWCowNJi6Exy
 7LBgpUE3PFfWFt8KRktx9TK8JPhYiUwsFNyp9u6NiOelRtKCIvHuEtvuQle1UR4=
X-Google-Smtp-Source: AGHT+IEWf8MW3CwUsgZ6MgSs8PzB7lx8976fH4EsOea/BM0xCi62QzwWGu9KIVZXECgOYThq+wCqkQ==
X-Received: by 2002:a05:620a:204e:b0:788:263f:426d with SMTP id
 d14-20020a05620a204e00b00788263f426dmr3775983qka.23.1709566151270; 
 Mon, 04 Mar 2024 07:29:11 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-007f-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:7f::1002]) by smtp.gmail.com with ESMTPSA id
 bp15-20020a05620a458f00b007877add9363sm4433490qkb.103.2024.03.04.07.29.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 07:29:10 -0800 (PST)
Date: Mon, 4 Mar 2024 10:29:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Sean Anderson <seanga2@gmail.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Hakgoo Lee <goodguy.lee@samsung.com>,
 Uma Shankar <uma.shankar@samsung.com>,
 Manjunatha C Achar <a.manjunatha@samsung.com>,
 Iqbal Shareef <iqbal.ams@samsung.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] ext4: detect directories in ext4fs_exists()
Message-ID: <20240304152908.GK1523872@bill-the-cat>
References: <20240220115423.61417-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="zA3YWUfoTl5Yffex"
Content-Disposition: inline
In-Reply-To: <20240220115423.61417-1-heinrich.schuchardt@canonical.com>
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


--zA3YWUfoTl5Yffex
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 12:54:23PM +0100, Heinrich Schuchardt wrote:

> While fat_exists() reports directories and files as existing
> ext4fs_exists() only recognizes files. This lead to errors
> when using systemd-boot with an ext4 file-system.
>=20
> Change ext4fs_exists() to find any type of inode:
> files, directories, symbolic links.
>=20
> Fixes: a1596438a689 ("ext4fs ls load support")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Applied to u-boot/next, thanks!

--=20
Tom

--zA3YWUfoTl5Yffex
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXl6MQACgkQFHw5/5Y0
tyzHEAv/fGXpcq1FCz6C86TWGKE2irwLvyxWoJ0SJzOCeEJO88J9Y86nC7SOVp7I
os18RuBFT0N8xrSXYzl6nH/mR5ncQzNJHMgJgTxYMNhO5iL5NwKnYFGCd8G7dMC6
HKywldPK0naX1/8iZdtErJ7Z0f3KOqTzju7aAl2QoxedmZ4avAl8Joad/kWinYkM
/c3mNRfvv1ywPK5nAuOnPRiguWuk0uyldRaShxcHSw+h3Pxk6t2rZhTh+h0Aki5k
2NYMsqR7UTU5OexlNWDBYpANwvu3bf+jdX7ekpN140Gzf3xf00vChuKXgS3z+jqG
bw7mKSQU7AxJyHPxyrqYRmUFQUCfemG/Izb5VBzWJjR1iq+LxJAhwlt6YdWChv7m
CI+kp2YP+GtEPOf/uIlM0dOCNy2iDDCDsb23uAeNxWFI2KeX2z7AjXvy/+cP0NLj
VyiHzGzp+9CNFmn5fZYlkltuvfreU6MOl6esel59fRurMVcXZaF2jbuXcEpKQzfD
lrDJvHeM
=lgUp
-----END PGP SIGNATURE-----

--zA3YWUfoTl5Yffex--
