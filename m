Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A08C54FB9
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 15:43:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ED5F87489;
	Thu, 16 Nov 2023 16:43:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cw1+VV7t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92BCC87483; Thu, 16 Nov 2023 16:43:56 +0100 (CET)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C73887489
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 16:43:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-77897c4ac1fso55049585a.3
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 07:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700149429; x=1700754229; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=dDuU1wNJTn5CHnS7NBgmVvyL0Vf/RP2tF2/HpAPgGDg=;
 b=cw1+VV7trNUJAXk2UXvmxoiGP2ECWV6zChhL9gorZ+TqtGoCk13uJizZoCC4BFJ64D
 2xKe8fB2lrwW3uauIpOaIdia68PFs9fe2XaIO7dB3BAVlvYQUrWwsce0wjFGeR9JgVrl
 q1BaMsfyKFzsT4Ltyw+VDjMPSt/jYGcQz6xos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700149429; x=1700754229;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDuU1wNJTn5CHnS7NBgmVvyL0Vf/RP2tF2/HpAPgGDg=;
 b=jkOUxbbnHdRydLDkRSUiQdKuLC9EkFYDwnnq/h4CG6+EMRScbBjcwgIPk9R3MGHN1O
 G5z36ulvl+2Koul3VenSPWyoS0ur6YlAJZ/0YTKL6u1w9VmJp2UBhLroEFCy0SLuaPgr
 zBR66LGvoc2P5rkzTzHcDQXfzATsqWyukT16/txWpM0Z3XfOQForoyiXTFpMiRHlgMTI
 pJcVHg++8dRqO4e5OBaxpL1tot98lU1O7dFd8Xyvy0n7fvxtKPuGJu2RoAa0Pry3rzkC
 23GaAa0o8R/koGjaaSaKt9BvamtXgNLdkORk8AtZevg9WW8uC11DvQXQd/dToCTQQCsM
 PMRA==
X-Gm-Message-State: AOJu0YwFQp/Sw72YFtsZorrblzFrtSeHS0jXL2w+y0oIlujHuDy1JwUn
 KIosyvdITTUusTudE3c+mBOMpA==
X-Google-Smtp-Source: AGHT+IHKM4k7KUHKj6CB9uoxdtHhIHpNIN/ipULS+WD+XeN7FrRxZuo+UvXiHuX30ZT9CrRoodapUw==
X-Received: by 2002:a05:620a:1791:b0:779:eb01:8390 with SMTP id
 ay17-20020a05620a179100b00779eb018390mr11075442qkb.49.1700149429202; 
 Thu, 16 Nov 2023 07:43:49 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 f17-20020a05620a15b100b007756d233fbdsm4372594qkk.37.2023.11.16.07.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 07:43:48 -0800 (PST)
Date: Thu, 16 Nov 2023 10:43:46 -0500
From: Tom Rini <trini@konsulko.com>
To: Artur Rojek <artur@conclusive.pl>
Cc: Peng Fan <peng.fan@nxp.com>, "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Jakub Klama <jakub@conclusive.pl>,
 Wojciech Kloska <wojciech@conclusive.pl>,
 =?utf-8?B?UmFkb3PFgmF3?= Adamczyk <radoslaw.adamczyk@conclusive.pl>,
 u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] armv8: layerscape: Enable ext4 environment storage
Message-ID: <20231116154346.GL6601@bill-the-cat>
References: <20231116131630.407502-1-artur@conclusive.pl>
 <20231116131630.407502-2-artur@conclusive.pl>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PhBxY1TLonp2wiZb"
Content-Disposition: inline
In-Reply-To: <20231116131630.407502-2-artur@conclusive.pl>
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


--PhBxY1TLonp2wiZb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 02:16:29PM +0100, Artur Rojek wrote:

> From: Jakub Klama <jakub@conclusive.pl>
>=20
> Some boards keep their environment on MMC storage within an ext4
> partition.
>=20
> Signed-off-by: Jakub Klama <jakub@conclusive.pl>
> Signed-off-by: Artur Rojek <artur@conclusive.pl>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--PhBxY1TLonp2wiZb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVWOLIACgkQFHw5/5Y0
tyx5dwwArgPtMzFnsZkKJPo43MZCTfO5jXN3oFCPTkYAImpg9SJr5tukWoHq7vPb
z/H7TYmIoAE92lKa/ZWw6y56Ni6jdsfqCiQM1bqZ++Q2whU9iAtsHtNX/Wth7auW
5oELiaoRxIBqiePF49PGboALvsXQAR2sfan9wlqVfGbskspJT2Md58AAZDMjvwBk
d22CLAuQ5AuSd7eGaLvF0O0B9HdAB8IpP+gTzhDq8rWbb5sgdCXs6m4EO8KTuBmh
c7lk/0bdb8yhCXun4nDxSLzsZk1624T+8xjcSrv9UazX3RtY/XKa03QyBsOyj90J
WClkXeO8VEzmAL+fYaF39OKiNtzADYljlIyCo2f//6MYxhr0ap+8S08oCoG2G6oD
q4VUIMpDC05HDX/tekBVUK8wXlZQHPdnZ+curiRBb2XrnittUy/Ti5dHkmNkdRcG
bNco6PmPazTdqMOdgCJD2KGfw9sjzij3lEUJCB83HVqRf7wv2psN0OWRMndRQAyW
8Yww6btZ
=gW+U
-----END PGP SIGNATURE-----

--PhBxY1TLonp2wiZb--
