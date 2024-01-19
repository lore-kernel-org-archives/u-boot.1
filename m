Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4648DC4725D
	for <u-boot@archiver.kernel.org>; Fri, 19 Jan 2024 16:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 264D787D74;
	Fri, 19 Jan 2024 17:09:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="piQAGYKg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34E8587D6A; Fri, 19 Jan 2024 17:09:47 +0100 (CET)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2828E87D52
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 17:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-5ec7a5a4b34so9549607b3.0
 for <u-boot@lists.denx.de>; Fri, 19 Jan 2024 08:09:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705680584; x=1706285384; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=boHqDbV0bu1haZ/q5eMzdPCWL9CkGcThVjdUNzbNnOs=;
 b=piQAGYKgS/ICGEwBLjxaW9TktNPX2dVnXWLqme2odSXMY73zZ1qz4Jwp2CzjJq1P3W
 /DfSm3HB41jD/cpFUmoRRvxKcCqwGJsKLB++i5BnSPNaeN4/qw4szmaMd4ax6SWuhPsO
 oyhBhwl79WLwHCID4b/DJxXDx9Ze9jonWKu30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705680584; x=1706285384;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=boHqDbV0bu1haZ/q5eMzdPCWL9CkGcThVjdUNzbNnOs=;
 b=A+40SCrO8sCcmgDyDhiF0UGcBijQf7R8OY6Qt4JiwWUOq0Ud2PGvcxaMnVZgZEaSD6
 HBeDAYvOLj4pypmmEN8UxsQH+URsBmNQS3fcuIZ8H2Zm8lHlTEFZEHWziDM09q3Qi+iO
 a/xPxeQWA+IB/+lcdGW+qXhtmvXvXdWA3CixKFAajhAAl3QoLo64+LmaiIwnFmF5Nojm
 D92DyPi2OIjmPkfsvh5ySQbFRuL6dxN9jCyhteDBV5l3TEit9J2fahJEEZr8/FGRB7sl
 kLyIbO3kEQeLk7O87/MYfR6INs+R8mE0w4/GpYI31/I/vs5bdIzc+9sj7FG77z2cFEre
 LLAA==
X-Gm-Message-State: AOJu0Ywr/bimWYKnm9TnWEQMAlzrvkpsd+PTrObu9Rkayqh2wmjhwBMl
 oRxtIUobm00+i6WxC91oy1JS/sOLe1Vb/yDFKVNJVk4D+NmrpCMLpKag4PWcjLs=
X-Google-Smtp-Source: AGHT+IHTCzRFIzOXo7pRsau035ZVCFKr2S3a+QEuEgP0dtcfm9FhSLufvRBCdwxrnlxz0qerTFvmDg==
X-Received: by 2002:a0d:ca07:0:b0:5fa:f4dc:6504 with SMTP id
 m7-20020a0dca07000000b005faf4dc6504mr93457ywd.50.1705680583935; 
 Fri, 19 Jan 2024 08:09:43 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 i142-20020a816d94000000b005ffa1fbfa7esm339633ywc.101.2024.01.19.08.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jan 2024 08:09:43 -0800 (PST)
Date: Fri, 19 Jan 2024 11:09:41 -0500
From: Tom Rini <trini@konsulko.com>
To: Moritz Fischer <moritzf@google.com>
Cc: bmeng.cn@gmail.com, sjg@chromium.org, wenbin.song@nxp.com,
 u-boot@lists.denx.de, mdf@kernel.org, patrick@blueri.se
Subject: Re: [PATCH v2 RESEND 1/2] nvme: Fix error code and log to indicate
 busy
Message-ID: <20240119160941.GE12635@bill-the-cat>
References: <20240110050448.1441657-1-moritzf@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="AxpXPiyeWCd3bw/K"
Content-Disposition: inline
In-Reply-To: <20240110050448.1441657-1-moritzf@google.com>
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


--AxpXPiyeWCd3bw/K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 05:04:47AM +0000, Moritz Fischer wrote:

> Return -EBUSY if controller is found busy rather than -ENOMEM
> and update the error message accordingly.
>=20
> Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Moritz Fischer <moritzf@google.com>

Applied to u-boot/master, thanks!

--=20
Tom

--AxpXPiyeWCd3bw/K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWqnsUACgkQFHw5/5Y0
tywbKAwAlG6s1y62wKO8813A2Dhj6BfUM1dEDQmEpz4CPkq/HDl9d3CJgG5/4emP
jKJ88FqjLOCfSM/9BzwKCJtmTJ9O0rWuFE1zD4lbRvNCRLgDfrOJdY2oIj+okO89
A8ypVpEuq1HGfB5ZDkYQ6TDzhQB2lbUj0LwPIBY7Wc1FsqPoCceqKp1mrVlveQJf
m6cwYn74BZPBv1rx87lW7rlGMT0aY3j6+S3TLBUD6l7/PcXtNEaKSBXbeM4tmydj
pJa/OXTWeiCJxyXoRbw+unlcAUiTXmeF4hH6u3MvhpomoO/P/j9PyfUnZm6ahJn9
iLhxB2BMfmlrBCh3huYG4R29XuWWhZyOJn3WD5e97diGr34xx5Ute5NRVMsBOHO+
YYTerMS2qPe4xkq2T/FJRZhaMp1gEe6KJMC4/7dQnAi2GC7W7jWmPNYhbmHFVvtI
N3PpEavQF8JqRWXPWC7Oby5ry909BbZzMpH4iauTACXOOG+/l/24UylGtEmgn+PG
/vSmMZ5T
=Pu4S
-----END PGP SIGNATURE-----

--AxpXPiyeWCd3bw/K--
