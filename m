Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED3BFCC076
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 22:23:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C5AD283FC6;
	Fri,  6 Mar 2026 23:23:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="N2LuvpWJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBC1C839A8; Fri,  6 Mar 2026 23:23:15 +0100 (CET)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68A4483FA6
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 23:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7d1959ba05cso4848754a34.2
 for <u-boot@lists.denx.de>; Fri, 06 Mar 2026 14:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772835790; x=1773440590; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sD01MT/wQXtg1LWSIE6bKdHUL8X+nRCzoOkARCBu1+U=;
 b=N2LuvpWJf7x2t7wnG3NFjHPZFMg2vogSHej9KdcEpLI7DUSuFIpErFAP5KF4XYr/Me
 fL/PY9Y+znSgPo9lqc2B35Bh9dzc8WZ7Z3evHsKl8DcUzdScHL7stijpETJTjudAs+CI
 DnHjfb5XZ7XZRcune/QmB26SSnPfUGIZF9pIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772835790; x=1773440590;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sD01MT/wQXtg1LWSIE6bKdHUL8X+nRCzoOkARCBu1+U=;
 b=Ci+cWSBn2WAJrlkEl8T7vh85BHNLdydoClSKD//UF97hkekizEy4FDvDMVGEdvwlBi
 G3GV1rY5bQRGZ1LLaRTW1dWJRonFXEDR9iIM/rvW6a6MPMCn2tkj8l6NfkNT42EbhIAm
 Ll8nTTsIrPfJot6SX7A3Qd3uyirUpI7hEo4BVrdDhldIX0OfY66NzjzOneyyxZlep7lD
 fSJqBSAl1gAjfokWVNnEiBe2KjUx1YzhHtAVh/pyWgq7XPCpgGJNiZN8OykpwGl1dlce
 VauyQyZB5leVPtjYWtODAauv5hxfNhu0FwkQDb2vgYDkBnLjnGTbvxVBqZjW1PKjt1V7
 gxjQ==
X-Gm-Message-State: AOJu0YzK+2H7sc3iXWMXofuyU5ER0Mw/IiQ8dGMEjjNZ9zJj8la2YncH
 KpofNVlNZe180g2CcpRi7vzAMWZUkNNds4Cy6SIIv2V4En9zV3OubIG5Q98MQD2m/04=
X-Gm-Gg: ATEYQzwX1rBw90anIX3aYR0RGH+OtwsoUI2MIauzr6URO3nBo4dsoemp7WB6HGxSaAQ
 A8gnDHQJcuYhefdebP3ezU9l+v9iJKLVmGdFPAAjrUyqvVtV32WR1w98cTz5pFapnCcOcw2VzDV
 yVnMCC954uif2YzJJDd7y5NKNhI9oVhDkZH9ajJgrUNIIJfA6Pg8NMEuXSCyCYZoMsbvSqV9CYq
 P+xS6UxuV31cogiVyeHUQPKukxKo3+xESpU8hmnI/ygJz9IbeJntVIFlGg1py0RaJcL4srexebh
 y0EunQMSUYuWNR6duv7jbKBPy/fZgIdYRAowRXXsOwMk0GmG3EVSXiXC8pixcEeWKYePjKB62Dz
 rWuqjizt2NTg7PcmuIRLtErIbxjl2sxYcaO4dYZRKc3BNK1X+7zE3zfy9cqHvDJQbXbGLnw6Wqs
 bUbFry53p166hS5FubL5I7hi2M/g+HJ70QOt7Ofq176sY+gqRvfM097A8eatKnYhNHaIbr0dy0W
 V3Ft4G3ZwNcuNhB1xAB7FsOMlplP8QYfKd9Zm4omiubK2kRidw=
X-Received: by 2002:a05:6830:2aa1:b0:7c7:6bb4:1197 with SMTP id
 46e09a7af769-7d7270268ebmr2503239a34.24.1772835790132; 
 Fri, 06 Mar 2026 14:23:10 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d42a6dsm1717865a34.26.2026.03.06.14.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 14:23:09 -0800 (PST)
Date: Fri, 6 Mar 2026 16:23:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Simon Glass <simon.glass@canonical.com>,
 Christian Taedcke <christian.taedcke@weidmueller.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Marek Vasut <marex@denx.de>
Subject: Re: [PATCH v3 6/7] test: Add a helper class to create disk images
Message-ID: <20260306222307.GU1388590@bill-the-cat>
References: <20260306190818.3586749-1-sjg@chromium.org>
 <20260306190818.3586749-7-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7gbQBDBhHJDa2rXX"
Content-Disposition: inline
In-Reply-To: <20260306190818.3586749-7-sjg@chromium.org>
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


--7gbQBDBhHJDa2rXX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 12:08:12PM -0700, Simon Glass wrote:

> From: Simon Glass <simon.glass@canonical.com>
>=20
> Provide a way to create disk images which consist of multiple filesystem
> images.
>=20
> Signed-off-by: Simon Glass <simon.glass@canonical.com>
> ---
>=20
> Changes in v3:
> - Remove cur_dir parameter from DiskHelper as suggested by Tom Rini
> - Remove editorialising from commit message
>=20
> Changes in v2:
> - Explain why setup_image() is left to later
>=20
>  test/py/tests/fs_helper.py | 95 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 95 insertions(+)

Can we please move this to a follow-up series? This is harder to follow
in part because test/py/tests/test_ut.py is the only test that calls
fs_helper.setup_image with second_part=3DTrue, but then maybe I'm just
missing it, doesn't do anything with it, we just need an empty partition
to exist?

I'd like to take the first part of this series, then convert the
fs_helper.mk_fs using tests. Then convert test_ut.py (which is
open-coded fallocate/mkfs.vfat/etc calls) to the new class. Then
understand what DiskHelper really needs to do. Perhaps include having a
case where multiple (and non-empty secondary) partitions are used. Then
we'll know we have both the right abstraction and that it works. Thanks.

--=20
Tom

--7gbQBDBhHJDa2rXX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaatTygAKCRAr4qD1Cr/k
CrhAAQDgA0t4TqKG/ELS4qVKAabhd6UOn1orH9OjyyIFx733cAD/Wr2jA8VZKC+P
rUDV6qI+CfgtO13NklDNBExuz+UG1Ak=
=Pvmg
-----END PGP SIGNATURE-----

--7gbQBDBhHJDa2rXX--
