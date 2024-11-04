Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F18AD1BDF3
	for <u-boot@archiver.kernel.org>; Mon,  4 Nov 2024 21:05:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED0F588F41;
	Mon,  4 Nov 2024 22:05:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="tWiFi2oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8A1088F33; Mon,  4 Nov 2024 22:05:46 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96F7388F08
 for <u-boot@lists.denx.de>; Mon,  4 Nov 2024 22:05:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-460dce6fff9so35685441cf.1
 for <u-boot@lists.denx.de>; Mon, 04 Nov 2024 13:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730754343; x=1731359143; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KlxGeEnJOXa97SZSpAtixu9kMKw/4hIc8ct04a/ocF4=;
 b=tWiFi2oeeK8D3qGSt/v1VitlonaZ6841QoS3GqkgJ7T+NiVk6EJzi6kcc7R8UkWodj
 d66Zd5d6XL8AltJ+dhg2lmDpGk6g0bjrVUNCAeOCntrdAEX0GUeC5wRfhXEIfzBgBow+
 hRU5FJg8fVdkV+gpHI7ySVhJZXUkvq7Bq0F2Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730754343; x=1731359143;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KlxGeEnJOXa97SZSpAtixu9kMKw/4hIc8ct04a/ocF4=;
 b=mghFPCIxZqEmydkXU6XWBzVXw4lAZ9ZyWezUh/B7RDahJ5htSYuQn7b9boEudG48aK
 n0b68H0Z2f3UEkvdPELlXGOFJtw4OajjT4ULjBC3tXyMlFo5CZ2cfanjZu6XvnnRs2m6
 FP2Xa96q+Mk7y3k02PTEWkkvX8If7VLyMuRwxzpPhYjZTm0m+ClJMIfw5v1gwGhs7WL5
 q6IroHGZ7sEc/ls/wVKExEMSR+UOAZova0DEceQmAdMg2W6iQU2AHNscvwXr2xoVCgSn
 zCFO/sHmsODQMMhyOgJ3wHO9SjKY//F9zXF0YUM267mpUzXfU5F5RnA6uswakVvb8wh3
 ONHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVU7LHhTDKlYJ5Lw4g51A31gOW8VVP332xpnJr0HSIFuEDHYaldg16FraICmIhIUrfGmqU8sFc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz/VC9KDSu0Wz7vi8ilIoSFoxtoqm5d+iWnN3wFvakbO+U9brFt
 f4Uq4pbXpb8M/6v2NuPnL7M52hSeB/2vN4P3y6PwtWEYKMQ+9kmH3tkLvt4HVL4=
X-Google-Smtp-Source: AGHT+IFJL9n/c/327JrV2946UhpF5OqOMIrgHyBSFCTkNgK54KsotRN77BMij6ggB8AvSdQf3dE40w==
X-Received: by 2002:ac8:5d49:0:b0:460:a928:696f with SMTP id
 d75a77b69052e-462b86a7c5fmr188008501cf.29.1730754343164; 
 Mon, 04 Nov 2024 13:05:43 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad083f3asm51720441cf.1.2024.11.04.13.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Nov 2024 13:05:42 -0800 (PST)
Date: Mon, 4 Nov 2024 15:05:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Janne Grunau <j@jannau.net>
Cc: Mark Kettenis <kettenis@openbsd.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 2/4] lmb: cosmetic: reorder functions and global LMB
 variable
Message-ID: <20241104210539.GU3600562@bill-the-cat>
References: <20241101-io_lmb_apple_dart_iommu-v1-0-fe4b9a74d47c@jannau.net>
 <20241101-io_lmb_apple_dart_iommu-v1-2-fe4b9a74d47c@jannau.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="VEspB7KD6CdHifPG"
Content-Disposition: inline
In-Reply-To: <20241101-io_lmb_apple_dart_iommu-v1-2-fe4b9a74d47c@jannau.net>
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


--VEspB7KD6CdHifPG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 11:15:52AM +0100, Janne Grunau wrote:

> Low lovel LMB functionality will be used to manage IOVA space in the
> Apple dart iommu driver. This reordering ensures that those function
> can not access the global LMB memory map variable.
>=20
> Signed-off-by: Janne Grunau <j@jannau.net>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--VEspB7KD6CdHifPG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcpNyMACgkQFHw5/5Y0
tyyVqgwAgPYTTmN6V9svXiBO55c9t+xxQrZGwzgHr/c40hf45aO8mM+3UhWUKMSc
qES0HgmtA5G7dymIpngvPMky5eNugrezGPgXeQoNZkWQYH7DT6RN+hedtDexRLTS
DuY5s+PMOePRrJTYF5YwCnPEy+PpXiBHyMRB1Lc9cmSFFIVqZ2JzzNv5kBPcyy1b
B2lMf098SEkPkjIxzqW2i+V4pUIURt4pxmote81Zcqbk7g0DZpEHio/Wcrwy3XdI
WPZ/+DtgmVtk3Piwu5x6m5ciKqNKTSD/Zy7Fe+09d36A2j+i+fwjK0CWofAD7oY3
CnpX3ROhudgA2sB4753rhai7U6ceaYbrnq3k8i26z70DRn6DJ4cUXo4hi+d6Mhk0
v4UekLC68Ki0Y5/Q2Fc6CDLlL4zZZMXRgtRnzz/0NI6FFD2PhCJUSFKVZSiavBl0
bJb1N3vfkJ1F573Nv3O32/s0S6T4ee5WUDgQai+q4+4Jx/aSbOXkP4gylVOi1FnL
jPcnMLXD
=J9x7
-----END PGP SIGNATURE-----

--VEspB7KD6CdHifPG--
