Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A59C36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 22:00:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F7CD8311B;
	Tue,  8 Apr 2025 00:00:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZkKjEkBH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCA7082F75; Tue,  8 Apr 2025 00:00:19 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6AC082FB4
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 00:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-72bc3987a05so2615525a34.1
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1744063213; x=1744668013; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DkDp6W9LG4ZX3E6a+WmaFETf32/9t0cz8jMbSxNiB5s=;
 b=ZkKjEkBHwDkv3gY9+6FpU3aQKXhLF2VeIKtJTzreUeI+p6qq923wsdd+1aQ6HnVvjs
 OZFF7uqiMzWZzSZybhTN04941vKseWI9MsKdL/EBa9Ku4v7jXPNgMH6HJtirwVaJ3WSu
 jZNdq8w/kkdsU2X7HybdCDfOWIAa6ywLnxxQE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744063213; x=1744668013;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DkDp6W9LG4ZX3E6a+WmaFETf32/9t0cz8jMbSxNiB5s=;
 b=e0j8K5Ne5nw9hgbFKezT3Ygs82pbrKYkq76Js9fSXct5lPK1SgLI4jkuruprCgBAof
 zGC+R4NivWl5Ge9cOtmeFOfXEF3RwVP2tv+RKUx5IwzVTzzVW/mUYWAmRojSAMRJLISD
 TnFcBDyqzcePD3oVHphnfF5bF7tUHpofomRGyVPUuvHjt4uzvgMPhr1x/PLDkbbYerom
 +isOA1NOKtPAC1o1SzdtXqpInm7Y3U6H0zCuvtYsu8NVDm1uTJAkh9IBtggeCsrUiCSZ
 Z4CjincPBjZlWlCkL5JzXwr2ZJPUCulGXpMhaT2GV/PxCqGh56pB9DSs33V45yrwHhXi
 5B1g==
X-Gm-Message-State: AOJu0YwomUoAAsv8pzunPH1ehr561whCjbgdWWxQ/qERnARR08/PSV7e
 upZFdr3EX4SJgA+eZx+60V1ArM+5W+KNvz3hCoEzBtWG+wfjqBL3nbycFr6Z8vEI/o1bPTHx8za
 V
X-Gm-Gg: ASbGncsKUhxRTLrFSprZCA+GVQDG+rpGQta78/XLT6PaqsrgxTc/OxKgHRwYj3y933w
 cv+QiUi7vYZPJG43ISAlk1yD3vItFEYkQGydGR1jeo19DRW0cWZ/3rPcn8YTqu9QhfpjkcgC5ab
 XatXCoR8VsGFeheiPm0gcw+iBgE9W5x6vcqmFvOWiT7cRLVlbzwbZwY9+VsctPWoBVljPgHgMOX
 w8hbWNSIjj9gMWxAlJkyO3Q/8lZdm4cunYa4nFe790RqPN2C8fDL0/5h34TBYCEFD95apVV4FfI
 FuBWFlk6Ax2qYTS1Y8NcuJV2+LcDFtC/GJgTEoFgDzcLd6kp6yeLaE52J+Tlpb38RATLcd1dpkN
 tbCagqA==
X-Google-Smtp-Source: AGHT+IFxmjqTgikTeJpehE4fI3dy+GCbZEQNQhPzt436eD39R5itJqi7ztpZ4iyYu5CpSs5ylr/mkw==
X-Received: by 2002:a05:6830:4890:b0:71d:e51a:9284 with SMTP id
 46e09a7af769-72e64aca13fmr608325a34.9.1744063213454; 
 Mon, 07 Apr 2025 15:00:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-72e651b2138sm122426a34.41.2025.04.07.15.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 15:00:13 -0700 (PDT)
Date: Mon, 7 Apr 2025 16:00:11 -0600
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: u-boot-custodians@lists.denx.de, u-boot-board-maintainers@lists.denx.de
Subject: [ANN] U-Boot v2025.04 released
Message-ID: <20250407220011.GS5495@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="E8NvxNo/XdMjmqjH"
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


--E8NvxNo/XdMjmqjH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey all,

It's release day and here's v2025.04. We had some last minute issues
reported, but then also resolved.  I want to thank everyone that's
contributed to this release, not just in terms of code, but
documentation, testing and otherwise ensuring things go as smoothly as
they can.

In terms of a changelog,=20
git log --merges v2025.04-rc5..v2025.04
contains what I've pulled since the last RC or:
git log --merges v2025.01..v2025.04
for changes since the last full release. As always, more details in
pull requests (or the tags referenced by them) will result in more
details here.

As is becoming reguarly scheduled, we have a community meeting tomorrow
(for me anyhow). The meeting details itself are:
https://meet.google.com/btj-wgcg-euw
April 7th, 2025. 9am (GMT -06:00)

To join by phone:
https://meet.google.com/tel/btj-wgcg-euw?pin=3D3D1307528552322&hs=3D3D1

The meeting can be added to your calendar via the link on
https://www.u-boot.org/

The merge window is formally open again. I will be merging next in to
master shortly. The v2025.07 release is scheduled for Monday, July 7th,
2025 and the merge window will close and -rc1 will be released on the
28th of April, and then the next window will open with -rc2, two weeks
later. The keen-eyed among you might notice that I fixed some incorrect
-rc1 dates in the future planning section, including for this cycle.

Thanks all!

--=20
Tom
--E8NvxNo/XdMjmqjH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmf0SusACgkQFHw5/5Y0
tyxeYAv/V3XGe2msW51EBW/q2XMWJ0SgfM97oG4cn7VkWi3MJ5OX5Nx3VgFkCTVO
vtNKEJEHT22pQ8Rdjg32EPPtVn9Mv6DQTw5+RBCQpTEpWE/hwjInTa/2KHfAtCDp
XdRlTFuhBP0NZiUBp0p4FYP8NY0R4Dt2TpvyivCgKJXTiUbga7EWgVfVTC+cFW7c
x8EhDO2m4GPioCUhl6VEnABIh6w1StPLBwfO74SkY7iRg4DN70Wqow12D5tGWrR/
wLbjdh3SOssGsledhhIQ4tA4SygU+G+7JOgFctdFtYrODrYXv1BgaUyEronmH8jQ
CDH+B1SWQiMTGR0ELNNAXAZaDv1/Ll3G49HoT5n7JenTXiIHQ4T/M89u7DPNsmyW
8etrmLTwA4rAtamKi0HuQAwqqSxW18MF4Q463I5gO2hZhN8N0mVesizn3Wsm5qls
ENGeaNVg18GhIMmJUycwQ63OwgfYsl/iDBTzclNDIDKmRUDOW7zrepWbPIcvDCQo
HE7P5V/v
=ONU/
-----END PGP SIGNATURE-----

--E8NvxNo/XdMjmqjH--
