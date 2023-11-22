Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBF3C61D97
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 20:52:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A479586F5C;
	Wed, 22 Nov 2023 21:50:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PNE2Mq/I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F8F8803AE; Wed, 22 Nov 2023 21:50:44 +0100 (CET)
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com
 [IPv6:2607:f8b0:4864:20::b2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF5DF876B4
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 21:50:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-da30fd994fdso1096251276.1
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 12:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700686239; x=1701291039; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8WFKuztmgCdYcmLOYCIvFFGpcsOcsBkFN2uC4p/MKXw=;
 b=PNE2Mq/IQlRmaHtbcQVZZDg0izgrkc1RpDk3vpiTXI000SXqM+ahPWkwHMphYjKpKf
 gSPksGYc7R43YzgjZ5iPETPNxWKxFs+AI9N4N3Jz0fvspQmN7gpi0hs/WsP+Qi9cWcMj
 aFPcHnkbYK22p7p86JY8io42T3LqYOg0JIG7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700686239; x=1701291039;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8WFKuztmgCdYcmLOYCIvFFGpcsOcsBkFN2uC4p/MKXw=;
 b=ggGexoLv9NwTT+oh1cBi4u0n0C1lsuUqIghwn3re4bCmgecR/q1rZHMYVaMQQw4oV3
 b2t31DtxUvL7TCp65/H4jGmKsq+cagNLce0zhUuCuOG1V/o7hymQeXR3qYDB1rpszgd/
 gDuAuFa4poPjcz/36M8HcHJsSEgth2ndAL7citUaA7t4wmZ+hSHhvjMGHcfNh8hdUG0H
 2PCznzj/dxk/V0OcuPhLDTD9PkZYOiYeP1fHct7rBxWpggMnI79O60Ccv499wbLZbESA
 fsnm7A+MZ/pd62aHRI/vLHe0po7pbgNU5XlkIBZmmprP4FMnsoz+ihJs1i+AUyeV9yjX
 TbpA==
X-Gm-Message-State: AOJu0YzywIp7Aow/fF4uLmQjUug6FAREzJg0Zq3+KiYYNRL+UH3Juqb8
 tSsysJ7RvKufjeR0BzPsKrOHquIy+6kWgatJX11aUA==
X-Google-Smtp-Source: AGHT+IHdUzNmGCjTkBgPBngJVnCIf9aJCjqcpLVyM/F1uIaKHWy+2oywpRANebCLC5npc/q4JcFhRw==
X-Received: by 2002:a25:3d06:0:b0:db2:4e11:d52 with SMTP id
 k6-20020a253d06000000b00db24e110d52mr769326yba.2.1700686239518; 
 Wed, 22 Nov 2023 12:50:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-999e-39fe-b112-e0fa.res6.spectrum.com.
 [2603:6081:7b00:6400:999e:39fe:b112:e0fa])
 by smtp.gmail.com with ESMTPSA id
 a11-20020a5b0ecb000000b00da086d6921fsm1530558ybs.50.2023.11.22.12.50.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Nov 2023 12:50:39 -0800 (PST)
Date: Wed, 22 Nov 2023 15:50:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, nm@ti.com
Subject: Re: [PATCH 1/2] board: phytec: am62x: Add PHYTEC phyCORE-AM62x SoM
Message-ID: <20231122205037.GQ2513409@bill-the-cat>
References: <20231031133732.265589-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="WSK6bl7iYViyWkt1"
Content-Disposition: inline
In-Reply-To: <20231031133732.265589-1-w.egorov@phytec.de>
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


--WSK6bl7iYViyWkt1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 31, 2023 at 02:37:31PM +0100, Wadim Egorov wrote:

> Add basic support for PHYTEC phyCORE-AM62x SoM.
>=20
> Supported features:
>   - 2GB DDR4 RAM
>   - eMMC Flash
>   - OSPI NOR Flash
>   - external uSD
>   - Ethernet
>   - debug UART
>=20
> Product page SoM: https://www.phytec.com/product/phycore-am62x
>=20
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>

For clarity, please rebase this on top of current -next as there's been
a number of updates just now for K3 SoCs in general, thanks.

--=20
Tom

--WSK6bl7iYViyWkt1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVeaZ0ACgkQFHw5/5Y0
tyzGeAv6AyvqHnAdchwm2/SWv+sBXTZthoXEprVKzxDp93nE3MlDDqSvi2UUGy0h
walnkoZ1V3CxgdRs/6ORQtavah5+MCDj8wTHyUxyZoy5XbMr6YcrQJ+jVZl5dfDm
bGpFKdlvyiNWXpRspcMJNYDmjD4SjeJR8bIovtAk2BIgIXT2sFpuj5mW1UwppZrk
kqrFdtaSdS8/2vvh/T79r3Uf0r9zV2NjvMUkA9Dg9e+PFln6+/chRk0rHhoh+Znp
gX5U/td5wNR2nIQyH/Uml6wL9WhYBcV3tFfyrcUP3fx08brCQkor22yqYbAg4jIy
NhnUiSJB0EM/uhIs+NHEdNC+ZmwUVFlNIc3t6h7yc0IcjJBcD1fGToxKSShTvss7
d9MeiVNCAI/OdHZ288i2RjIHiyrm1P3CDhxD4OsVXEcjTQty779VDXzz5mpILFRk
dctH9GzWZUv8QAeJVEjokYHyKLsi6VD2AOTihlPAJ7+QVWX55qp9SflGmPhzk1/e
+cplAFHg
=ItHv
-----END PGP SIGNATURE-----

--WSK6bl7iYViyWkt1--
