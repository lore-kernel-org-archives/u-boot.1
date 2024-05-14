Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA4DC25B79
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 16:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1348F88366;
	Tue, 14 May 2024 18:15:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NQIIhY8N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 045E38832D; Tue, 14 May 2024 18:15:47 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE19587CF8
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 18:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6a1548d65e0so14582516d6.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 09:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715703344; x=1716308144; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I0f13jTgFzPwinrwIClWwoPFL+wz/X2dcz17Cb58I94=;
 b=NQIIhY8NcvXTj7tdNpd44tYW9eNI0C2YWJ5d1/D5yg1700kFbQLRd+r5VDreDEpsBN
 yMc0qk3Yv4+K41kld8mXFJddhT2jC99kUKtWIRJWFjUmRfgr3p4V3BsnSzf12f8Pi2SJ
 qFq9BF1MXtslQHTryCxjn9oqf0hMDTzZxUtbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715703344; x=1716308144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0f13jTgFzPwinrwIClWwoPFL+wz/X2dcz17Cb58I94=;
 b=dd9UitYF7GUoawTpUI3x/XkrnHMj/2erVkl8uMj/1QWsfYGMuR41JyRBePvDpu13n5
 e6kjsykJamrQXufTMb/Zbpyq0eRw3VSbR55nSPFACWUGJ1PUOrcUeSf6B64epyF6tKzh
 tGTgOgvtb/T42um5KhQAx0g4U1CgaLLaYVNf+eUrjYnFgk+xEhb0GgYrffGo85WQqiAv
 6bnKTihh7XqYZnkVzXR0XlIwoM1jPbhiye8Mp7A+JTEtWvCS/9t5QifSs9SDD9RxMInp
 ujtT5L+CJpw0q0uudBgn5Qn9VGhJ6wStcWXSi0N69IlSolMdBWRBZdKUnedqjNsPlaAP
 TGgw==
X-Gm-Message-State: AOJu0YyZTKFylZLr7Jh4yoprP/HYfnWTlL5u9bpstWrx85icopJQ6OKw
 MatTNGzj9gFHWCXtyeB1ubahppflRJvR1Si4bNgt8fivM46g+MSyckjsg9Vy0PE=
X-Google-Smtp-Source: AGHT+IGR46rUtKuGnWjjPBmDPDHs/4bV1kiHRhdp9Kyne5uLPAOPQ2W6erluiAVriDP2lqJbDEGVYw==
X-Received: by 2002:a05:6214:469d:b0:6a0:c9eb:25db with SMTP id
 6a1803df08f44-6a168179d57mr175845126d6.8.1715703343656; 
 Tue, 14 May 2024 09:15:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f185168sm54681356d6.39.2024.05.14.09.15.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 May 2024 09:15:43 -0700 (PDT)
Date: Tue, 14 May 2024 10:15:40 -0600
From: Tom Rini <trini@konsulko.com>
To: Fiona Klute <fiona.klute@gmx.de>
Cc: u-boot@lists.denx.de, Joe Hershberger <joe.hershberger@ni.com>,
 Bin Meng <bmeng.cn@gmail.com>, Rogier Stam <rogier@unrailed.org>
Subject: Re: [PATCH] Init virtio before loading ENV from EXT4 or FAT
Message-ID: <20240514161540.GQ2568172@bill-the-cat>
References: <20240501085409.3457803-1-fiona.klute@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="d9/VuQjGYP+7tJz4"
Content-Disposition: inline
In-Reply-To: <20240501085409.3457803-1-fiona.klute@gmx.de>
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


--d9/VuQjGYP+7tJz4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 01, 2024 at 10:54:09AM +0200, Fiona Klute wrote:

> Specifying a file in an EXT4 or FAT partition on a virtio device as
> environment location failed because virtio hadn't been initialized by
> the time the environment was loaded. This patch mirrors commit
> 54ee5ae84191 ("Add SCSI scan for ENV in EXT4 or FAT") in issue and
> fix, just for a different kind of block device.
>=20
> The additional include in include/virtio.h is needed so all functions
> called there are defined, the alternative would have been to include
> dm/device.h separately in the env/ sources.
>=20
> Checkpatch suggests using "if (IS_ENABLED(CONFIG...))" instead of
> "#if defined(CONFIG_...)", I'm sticking to the style of the existing
> code here.
>=20
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
> CC: Joe Hershberger <joe.hershberger@ni.com>
> CC: Bin Meng <bmeng.cn@gmail.com>
> CC: Rogier Stam <rogier@unrailed.org>

Applied to u-boot/next, thanks!

--=20
Tom

--d9/VuQjGYP+7tJz4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZDjiwACgkQFHw5/5Y0
tyx0rgv7BujsI9rPptOu1IO5bKGJAgDC/H8nUunLQahfmEwtPKqbxsoflWjUdQRe
k1pRrSAULHQ7+7H50tzQ34tQZrUEOu5qA1/SbrxuneBnybgtzHu7ns9KMbQz1lbV
HM4neXHnYKToShTMb/9MIAQoDq+eOFLlSVOn0DxOuZn4AS7AcLt0gvGCmHprPRxi
R1vQm9WdtYcNdKNr2LGFjVh4Dr/Nxk6XHeLz/7dBih/jEKMIMeKoJ3bPgOx1tt4k
zLoc+1isRvMRZ4gYx9tIzQ/mmvsGBNOCbcLAF+XkgiH+BSel2HKUx7eDN1KrCsiZ
5yuNRc1nK+jL43tMF4Y4gtt/Hm16xg9sdMfplTqxHJEpkIAlSPyxYQgXehmMLSl+
yIF66dCLHxIp3loapz2bQLMqoX8wZmav4dqVg0tEoWp/MVWzL1mQIi6qDD1Se6vn
a8uGbBAfAEUkeUrpKWm/eNQf/pYnaLPPxsCKnnvawVTPqmVvQggWkZ6/gfQ0eOBp
wKDAEk7w
=3zz/
-----END PGP SIGNATURE-----

--d9/VuQjGYP+7tJz4--
