Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1DFFC7EE2A
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 18:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3ECEF806D8;
	Fri, 27 Jun 2025 20:09:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="KcFu2Kk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C95128104B; Fri, 27 Jun 2025 20:09:28 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB2EE800C1
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 20:09:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-408e0986303so133744b6e.2
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751047757; x=1751652557; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=yWpOV511mhzqeo9FTTVMxaUFAnEAQ8xSvx2F/Gg+cdE=;
 b=KcFu2Kk2DtMs88E7Md3yv1MnOiLPM2aUB029QPonuJRc2B9Q94a5Re8jlbl/K4dO21
 L7YIFH4T/3pc71f5Slswpw9pXXXToF2Q/7mx1YevMUuPvFJNcVEbi5hZYjtNAuHa66qP
 PCUN0/dl3lygcHwALpghGMTYZ2irib9RYH6WY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751047757; x=1751652557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWpOV511mhzqeo9FTTVMxaUFAnEAQ8xSvx2F/Gg+cdE=;
 b=l8N6bpiK77pMCm4cquYZE2K5kSxQnRPz8eKN8IoHQdAOQOCnHxrIE8xWDh1IPZPmS8
 UxJqQ0K6kc7uh6P14cuQ9Le8c21IX5kMij+vMzWmfG/wlNVHoVkc+s19lblLyR07FdqE
 blWlshqmSvIWLUQ0r9JoiErJ6A9AWvQycdhtIYHqLxxoAra/cDaIJUcSGGhyZipRHd0c
 DjKQlg3WBFfc1Cqp+53kqibg3vXWsmytuXgGflnvEppsIcYOOD/u4u8ldBaGJLTfmxBb
 DScbpZ+S3focZHhlQi7mqzo6rYvclVske86bk5AAzGLllguoqTNn5zPz7nxQrqN7p028
 pcBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN3CDbzJywPUgo2yl6Dio0zu1dPCE9X8w8CP2n2b9nwfQgLG4I7QC2zyO+9xJ6WU6e30mPzR8=@lists.denx.de
X-Gm-Message-State: AOJu0YwDbRb05JDrkZj8k9+/1ePooDuu+xeo779v2VqOxJFBfifZxBAc
 tNd9JXdq0lctGglE2IVV42Nkcwjq+I6bThv8tRy3ub6pdMybQKSfQYiGop0jYIdGD4Q=
X-Gm-Gg: ASbGncsu8rEXJisPMErjUxWgfbtquVztSbMhs39G/67g0XHjVCQ6t1pmBFM7KWl7fD4
 z3OjWcxcb+834vmVRVTDhu9LUJnVAFNrMSFEt9s0PNhtfahFY3+RQv4dui2+i0BWesz23SiTcbc
 b14uYJq7qDlIcc+wNBMZ/uoZR/eR1LePVw47YqzSS26yVSPeugQsy0ZrScWfXHFsurk+C50sBZ5
 SCsBwF36yM9FFLCRCyuAF+wS/IM692VuzNG6MQ2DpjIIy2UlsD2fvZVuWRtI6umVi5b9yVK5ML7
 hZc5CJdm8CFNxmVcOqZN5H8imkk0h89S/njwABlZqadUafNjeib6t7c405lDOlx/JBDC73DivJe
 C4j3b3PKG1QKvcLrqfeEAPAg=
X-Google-Smtp-Source: AGHT+IHRLF/BfQ0mf7xYsy5bDmiLE/v53dHs8q7FvP21HKG0Ivy1MO8i+OigC5duoV4vdlMazm6/sQ==
X-Received: by 2002:a05:6870:8813:b0:29e:74a0:e03f with SMTP id
 586e51a60fabf-2efed7ceee5mr2728134fac.24.1751047755820; 
 Fri, 27 Jun 2025 11:09:15 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4f0f7d4sm973255fac.18.2025.06.27.11.09.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 11:09:14 -0700 (PDT)
Date: Fri, 27 Jun 2025 12:09:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Davis <afd@ti.com>
Cc: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de, vigneshr@ti.com,
 nm@ti.com, bb@ti.com, u-kumar1@ti.com, devarsht@ti.com,
 robertcnelson@gmail.com
Subject: Re: [PATCH v4 1/2] mach-k3: add runtime memory carveouts for MMU table
Message-ID: <20250627180912.GG4003484@bill-the-cat>
References: <20250618124210.1936140-1-anshuld@ti.com>
 <85f6fdb7-73ea-4617-b82a-fb14369315d1@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7/dk35gpFsdEqaiB"
Content-Disposition: inline
In-Reply-To: <85f6fdb7-73ea-4617-b82a-fb14369315d1@ti.com>
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


--7/dk35gpFsdEqaiB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27, 2025 at 01:06:50PM -0500, Andrew Davis wrote:
> On 6/18/25 7:42 AM, Anshul Dalal wrote:
> > In u-boot we only provide a single MMU table for all k3 platforms,
> > this does not scale for devices with reserved memory outside the range
> > 0x9e780000 - 0xa0000000 or for devices with < 2GiB of memory (eg
> > am62-SIP with 512MiB of RAM).
> >=20
> > To properly configure the MMU on various k3 platforms, the
> > reserved-memory regions need to be queried at runtime from the
> > device-tree and the MMU table should be updated accordingly.
> >=20
> > This patch adds the required fixups to the MMU table (during proper
> > U-boot stage) by marking the reserved regions as non cacheable and
> > keeping the remaining area as cacheable.
> >=20
> > For the A-core SPL, the 128MiB region starting from SPL_TEXT_BASE
> > is marked as cacheable i.e 0x80080000 to 0x88080000.
> >=20
> > The 128MiB size is chosen to allow for future use cases such as falcon
> > boot from the A-Core SPL which would require loading kernel image from
> > the SPL stage. This change also ensures the reserved memory regions that
> > all exist past 0x88080000 are non cacheable preventing speculative
> > accesses to those addresses.
> >=20
> > Signed-off-by: Anshul Dalal <anshuld@ti.com>
> > ---
> > Changes for v4:
> >   - Add call to k3_mem_map_init for beagleplay
> >   - Mark reserved regions as non-cacheable
>=20
> In v2 I said you cannot mark any regions as non-caching. How did this
> sneak back in? If the reserved memory region is marked in DT as "no-map"
> it must not be mapped at all. So NAK.

Presumably at the top of your mailbox now that I just pushed it to
-next. Should I revert, or expect a prompt follow-up to clean things up?

--=20
Tom

--7/dk35gpFsdEqaiB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhe3kgACgkQFHw5/5Y0
tywQxwv+NHAuccig3S5sBnIcP7mMJSQUS5uaEg99tEO3uhuRRWfZ6ig2xMNLTu7D
O/oA15RHI9Y3tdJA1oZ0O2mPegC8VSDY/8i1iPxE5dJ4ec86Uj55eB+hq7naQ7Kw
h+/ETxzFNMsm7G4eJfVRC2uC8wW2U89hEiolXYSgMAPtXWzYo4dGdN6vWfl9IuTF
BHIwBRyRvJ+hQJHddoHBYyT/oZDYy9p8tjmSNEQOboocZ8HTpWfsPkLfbk+pe4xm
9r/h0/twK4myTIgDqoI2MzqE/7kdH26AvtAr8NCFplgyrFDrbP+N5S4cnPxPddoe
/vjKqQxvJyfDfAG3+UHPJtj2UrWxb0YZGOOFSQVbuJBqDlKouiRC+uLL6evXl58j
jivH1/9FF9El8d7UbWOvU0YaLWhGHKTzToVC6nvu6TXZ8dHrrpbKDqcx+HKlZ2Y3
XDyN1xQPYr77btotMmwXkKby77IKPDADu51HBBb5YiehSpEugEdjxtMHJDT+M1FR
Ms8YYnHR
=XwkJ
-----END PGP SIGNATURE-----

--7/dk35gpFsdEqaiB--
