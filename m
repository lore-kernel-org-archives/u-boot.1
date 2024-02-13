Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2BCAC48260
	for <u-boot@archiver.kernel.org>; Tue, 13 Feb 2024 23:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3AE7A87DB0;
	Wed, 14 Feb 2024 00:17:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="LlblBXfj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A58F587D1A; Wed, 14 Feb 2024 00:17:51 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A9B87DB0
 for <u-boot@lists.denx.de>; Wed, 14 Feb 2024 00:17:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6047a616bfeso42996827b3.3
 for <u-boot@lists.denx.de>; Tue, 13 Feb 2024 15:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707866260; x=1708471060; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/eUn3xMcUWKN2JEPZkZIdPeWmO29dFOfMEu8pM7KoHc=;
 b=LlblBXfjZ7ZClJbBrEHw9C8AQbljUj7Le96T8u8NVJqI/9ZdbCid0bBgUjhxzhe/md
 Km8h/RD2C9idWH7bU3MyVL+4iBl5zENYf067zIS1enbFqZqkooMN1k6xUSQBNljidZBp
 ByptMjT2aT+LMKiT+/tAQHDR8TNnoFsHAJjAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707866260; x=1708471060;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/eUn3xMcUWKN2JEPZkZIdPeWmO29dFOfMEu8pM7KoHc=;
 b=vU8yperkn496FjyAlMhlnU7aRl+fdPh/w9ChYgh/mvb2TgjSkYORy4G/6Yx9ttWTOh
 ntbRCv1jhZEpkIIFVo1osbWBsj08R71DFohJVjKT/XaEwaDIfAzGBMpoPCeb7z/D0oAR
 LQwtZLAErkaiUpl2xXUhiPYllCNLx7WFmmAA4B4N0i6nF/06Uzr8CjkvVZsXazdWd2Zw
 R+qKbkykuGulPWIKKmBcX6iPGd2LN9PSoJtHuiS0jJv3Zb90ZNQMFXDaMdu1zQP+zIjS
 RfTlnKQqcmpY/60Sp0BC6/YCgd7Zm99ny/uOc3pyaGukQ4BBS0Trc2tObiyn3YQFjXeY
 yPVg==
X-Gm-Message-State: AOJu0YwkMYJsCTkWkbTQoLukjEunJoqK84mCJcoVxaK5thfZW0Hnx7u8
 gNS2mI8R08JDAQ3ABdZBY8vnPCxI1PnhfHAzdYrjd76vK9Wf7icCGph0Zju2Lh+UgewXzkm6Knb
 J
X-Google-Smtp-Source: AGHT+IGZNpSUCu0nwdBDDmTP3LcYzMsoNIh4mhLOhH73oyG/QyJ4Ywj1fndNa1h4QuRDGj/c6b9KLQ==
X-Received: by 2002:a0d:d102:0:b0:604:5be:7163 with SMTP id
 t2-20020a0dd102000000b0060405be7163mr888312ywd.41.1707866260179; 
 Tue, 13 Feb 2024 15:17:40 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVupBdl2ZENl7dxLaVlORIUGFVY5hVKnvCFJV8Yd2U/CpKIQ0uq3ssZ1Xx94ijh8nis5jXFuJcDbGzIYNp+rCub8ePCMMPFwUiXdlcrl/FBvlsFBBgCgjDPzW/GN42moZkeEzo=
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 h185-20020a816cc2000000b00607a627451asm44023ywc.87.2024.02.13.15.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Feb 2024 15:17:39 -0800 (PST)
Date: Tue, 13 Feb 2024 18:17:35 -0500
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2024.04-rc2 released
Message-ID: <20240213231735.GY3040305@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="27snTsqfeGkLf2dY"
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


--27snTsqfeGkLf2dY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

I'm a day late as I missed my calendar reminder, but here's -rc2 now. I
am hopeful really just about everything that needs to come in, is now
in, but I also know I have at least one more series to grab for TI
platforms. And I'll grab the series I posted today that should fix the
current CI failure that's related to not being able to download a file
=66rom Google drive.

In terms of a changelog,=20
git log --merges v2024.01-rc1..v2024.04-rc2
contains what I've pulled but as always, better PR messages and tags
will provide better results here.

I hope to get back on schedule and that means the rest of the rcs every
other Monday, and with final release on Tuesday, April 2nd, 2024. Thanks
all!

--=20
Tom

--27snTsqfeGkLf2dY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXL+I8ACgkQFHw5/5Y0
tyyIwAv+JESZB6/TGNZy40VRFHja+M+lpc8aW7XGAG0s9TGA6AB+BAVFxNYJPEHe
NfEFKHiwVubbnYEjeDwDLMux5C4kd0UygLiEmF946vEoby17Q9jxsQgkL8DgUvfl
TC1NYTDbwT4F4SXAGxcp5s9wVe5kpVE/tZtSWRLtUwmNlFcwtaiPSffWYQb1TCO6
FGgxhzqqOi7wx7PwFYWA/N+4DvZgKIrdYRUT1AvKmBb2YXNZG+cba3wSleJ11CZd
VzGf93T0WNd8WVFJecHucR7UBFLz7oRwu8dwq9CgviCDywiXVvh4BuqY7I6ixrQM
UGX0FmsjyEDYa5vKPKnZx4jS0+gw5wXMMs+ysKjVpIWo2Rfqam4iR2emrsymhdFH
cGoJTXV2nL333Wl3r4IEtaANCmBwHpZwM1rtWB1dy4LHeB04QsFO4VircfkkgZv6
hZeuRW1t/BMV3nJsjtzl2kfwF9k1K8UadiWC2ijUAUO18qTIkMl2JoqaYTDMahkX
LNz59Xrw
=lcHh
-----END PGP SIGNATURE-----

--27snTsqfeGkLf2dY--
