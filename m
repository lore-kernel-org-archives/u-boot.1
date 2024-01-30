Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8EFC47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 01:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F304C87DBE;
	Tue, 30 Jan 2024 02:54:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hnhtuua3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EBB487DB0; Tue, 30 Jan 2024 02:54:31 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3CB2687DB2
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 02:54:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5ff7ec8772dso36755397b3.0
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 17:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1706579666; x=1707184466; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P01SFwOgMZvO0yCecs7E9eFodY21sejPMCmWvEipYF8=;
 b=hnhtuua3AOm3bC5N3Qpid8gYuVPtqye6oRwLfyj/B1y+lPPa9nDh4v+AYt3IeS5uXr
 0sF44ixMptLttAuS0ow5B3hvBPpbsY8muPPCgMpZ7sSN7zfRWBEoUkkX7/XZz9850PjC
 usHzIHLVSkUpPzT529xpLbgIJyEKj9PswKS5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706579666; x=1707184466;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=P01SFwOgMZvO0yCecs7E9eFodY21sejPMCmWvEipYF8=;
 b=RghBg/bQaZkvA1bE/W1TIrQrINUcF+7A/kUTkndVhALF1x+ZWYfRhEKkSiEwsYpMjg
 b3duLNT/+oa6H1iz22E8A6JRoTEg2Izu6gpKub/H8CrefpCan5XWxSpid+6vDUym2Yqc
 QWUwUDOPp3t/nBiWLbyElwHkMaFWdS+P0fR8ztT9QG5/ElL11THVVMlZiySn/NeBPBuV
 bw4c3nh0Dfdbn52cOzVuLmGBm4/tynxggpWWagzHxsVV7m5ARwdsb8giKDptpG5pE5wb
 KdGX5AcFj4z6Pl+r6Zk53uSjUmc7RKPAn52jgGuefZanbu7mAPFJjIOliaqSuDT62ZsF
 jrDQ==
X-Gm-Message-State: AOJu0YwDfpRF5yCUdPYOhmczg3brWezBzzhZIlaN0B533iBxnctuEFuR
 8jlAdNO0k+gStlNQcftlC2MktXOlbHB4Ws8r22dqewe26wxDA5Oaoqw6xyhaMGuNzK3xpAK/g2r
 E
X-Google-Smtp-Source: AGHT+IElUqE1EqwmL6mtSrDbYBxk6pUEn3sp8AwWZy1PTHEKkIZlOaFJuKNuNVQ77ALgb5goY8NkMg==
X-Received: by 2002:a0d:dbd2:0:b0:603:ebf7:947b with SMTP id
 d201-20020a0ddbd2000000b00603ebf7947bmr1327895ywe.48.1706579666667; 
 Mon, 29 Jan 2024 17:54:26 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1005.res6.spectrum.com.
 [2603:6081:7b00:3119::1005]) by smtp.gmail.com with ESMTPSA id
 fk8-20020a05690c334800b005ffe7b12fe3sm2895726ywb.85.2024.01.29.17.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 17:54:26 -0800 (PST)
Date: Mon, 29 Jan 2024 20:54:24 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.04-rc1 released
Message-ID: <20240130015424.GP1152441@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="W7ZMNFO63vHBDsL5"
Content-Disposition: inline
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


--W7ZMNFO63vHBDsL5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here is -rc1. Looking at my own queue, I think
things are largely set. There's some cleanups, but they can likely wait
until -next to open after -rc3. There's also some PRs I would still like
to see come in.

In terms of a changelog,=20
git log --merges v2024.01..v2024.04-rc1
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to remain on schedule and that means the rest of the rcs every
other Monday, and with final release on Tuesday, April 2nd, 2024. Thanks
all!

--=20
Tom

--W7ZMNFO63vHBDsL5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmW4VtAACgkQFHw5/5Y0
tyyIcQv/UvNx0+oElCYCrp3S468iVsBuQrsf88rFypnrWhSw7/3wWBSQ5P41AwsT
zEkwvKMBytMfYOjBRQOGSAXCinHK8Rup5r55PG9FcclgVPyswFKBa7JabCAqHEBo
bpd7UaQTfTZG1GuiQaqrKc18xuhChDkYxp69g7C68LjQ3LKmxMl162FOVC/OL42U
KvNApjOUIqWYzPhFsf78AZ8P1oFuVHdc7BDqHwL/XJfdgeFnVKEdTlq/Etvnaeu+
BEwEn3T25E8pSeiXB0qWti/13Qqm6B0NwBpnCTIaukNSIbrO+PoVcm5BuT4UQ6H3
vm9Q+7XFH3XuSmVdOmCJ5GWmSYLyImcKh/+3DtYv965Q9a3KzoCBOBwbpFaRy7t9
YriFhXKy6GC2INhrxopXMB64qw1cLU+7aQWsafMRol4yXG6496jdDdEXVQKLx7bl
IzamYUMmz6YMScTkjNNx1v+11BcbI6ZeSCEsORvJd4MxYLu5t36mcxu25WUdSxP9
ilIm76BY
=MSO5
-----END PGP SIGNATURE-----

--W7ZMNFO63vHBDsL5--
