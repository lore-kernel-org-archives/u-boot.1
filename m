Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653C5C83F35
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 17:48:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 666B086558;
	Thu, 31 Aug 2023 19:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="eoYu8PUV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 814B386558; Thu, 31 Aug 2023 19:48:11 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C307586553
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 19:48:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-58fae4a5285so12883607b3.0
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 10:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693504087; x=1694108887; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=G2r9E78NO/JXqT9qK7KFLPR5XQvHcKMXDijL4aep3II=;
 b=eoYu8PUVMp77Uyoze4ht7+lbPb5K536/fz9qSs4B1suQb9Vp+/xHwhcVIxut5TS3/e
 pCkQJ4dlJBXXO9HnN5wq2FeN9ndBQ30vYhxZjj9lxgBQm+voTlv8V+8YFxr1oGZr9de+
 +GI1lsXaqV83DER1ekz/zsVO/upGl4mpWdHRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693504087; x=1694108887;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2r9E78NO/JXqT9qK7KFLPR5XQvHcKMXDijL4aep3II=;
 b=XpsNma5RAB5/F0jUxRhknTxbJJn5LHGXvovZw4+oMy8m/gphUtFHVUnRvjMFQmi5Vg
 DCXhCL4awbWrGl6zeOcVjfyhDeXBZjwMhA1tyJZ7ociJDhZvfq05TwmIQDpo4gdG8o4O
 s6ALUQ7KJ9udAtHZX5XF/p7kSia+LEyIwn8WRpUQzGyizV0+Hs2kUULlutjesi3Uelto
 S1FSSsIRlsGHOXuinsRKg69Ra8BXWXhxHmhIo8eycD/ZHbGpCZp/MIrscQ32pfAyzbVQ
 bIX3W986R3Uc5EKWOKinCE0BP+USWi2bBXbUONoZcO1CVD+dQgc3XcT9LDBrXTR7nOdx
 XSkw==
X-Gm-Message-State: AOJu0YzvYVYrv6co+pfBF2+QJ+M9d5e6aLKXLBhYABrWsgVeGQeVH6jD
 BdLYvpwQMVy+PUDZRwdeOF8odA==
X-Google-Smtp-Source: AGHT+IGHTE0UerYsH3N7X8Y7pdw5KDhWSfRR+AfsDYkECgylP94A3UM6TpG6js687exFrIzetT/Zmg==
X-Received: by 2002:a0d:cc13:0:b0:57a:5039:aa01 with SMTP id
 o19-20020a0dcc13000000b0057a5039aa01mr177101ywd.22.1693504087562; 
 Thu, 31 Aug 2023 10:48:07 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-1cd4-1a46-fd5d-6cab.res6.spectrum.com.
 [2603:6081:7b00:6400:1cd4:1a46:fd5d:6cab])
 by smtp.gmail.com with ESMTPSA id
 o65-20020a817344000000b00582b239674esm551893ywc.129.2023.08.31.10.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 10:48:07 -0700 (PDT)
Date: Thu, 31 Aug 2023 13:48:05 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mike Frysinger <vapier@chromium.org>,
 Kever Yang <kever.yang@rock-chips.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH 1/2] Allow Python packages to be dropped
Message-ID: <20230831174805.GM3101304@bill-the-cat>
References: <20230831112051.1.I3fe7ac62de70902fd1be093bcda7c53acd43daf8@changeid>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Zb9cLyNNfHF/nbp+"
Content-Disposition: inline
In-Reply-To: <20230831112051.1.I3fe7ac62de70902fd1be093bcda7c53acd43daf8@changeid>
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


--Zb9cLyNNfHF/nbp+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 31, 2023 at 11:20:52AM -0600, Simon Glass wrote:

> When building in a portage chroot, we do not have the environment needed
> to build pylibfdt. It is instead build as a separate package.
>=20
> Provide a build option to tell U-Boot to skip this part of the build. We
> still need it to use binman, etc. but don't need it to build its
> dependencies.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Mike Frysinger <vapier@chromium.org>
> ---
>=20
>  Makefile             | 8 ++++++++

Can we do this via Kconfig instead? It looks like we don't need to do
this part of the build for coreboot, yes?  And so if we can drop it from
other builds as well that might help speed up CI.

[snip]
> +The tools-only build bytes pylibfdt by default. To disable this, use the

"build bytes" should probably be "builds" I suspect.

--=20
Tom

--Zb9cLyNNfHF/nbp+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTw0k4ACgkQFHw5/5Y0
tyw5vAv/dw+TlGNBBGer4bk+qu2MBCXqkSc/oOd5LseZrFXsA2Ad4FRvLwzOog1K
t/NdNSx1ZsXN/AmkpjADqrI7ptGTh95AUs11vLCRgACzddtqMfpdJO06kWhSb0ss
HOT9SGZ8gsx5p6VeS9Jt2Y4DWBvqFOb4sjaWJppEhh1ThCukGRHEz0teaouO2L4c
u6Asssis1n5etPDkIS3OEggxIBAnamt1x3fKbXZbk+QEf4HtRyadPIIBLAHeaJ0z
NMbqzMdt7JD/T1adsw3Q+Btf6wkp6bWjUuTGvjimHWds2S3oCNHUX9WXCj+JBjO6
vhzA5qPA7wOV54GTuSSMECZXmBY+fwUmcHHF7+6huaGRGsci0IBZZvoS9TIHLfQd
Ugil7TltvQAhSgOvuFNHoA1kEDjUysZfJXUG7cLvAVdwdHZLBNf5SJo06xeBRDqz
1vh2EtbC2FAW78wxylNxpwwhSMCgHon4g+6CgTadCsz5WOuDD2tgZF3YnDnuJdQo
64H1wbLS
=3bWu
-----END PGP SIGNATURE-----

--Zb9cLyNNfHF/nbp+--
