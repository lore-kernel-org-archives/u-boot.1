Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 277DEC4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 17:52:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5455F87B2B;
	Thu, 14 Dec 2023 18:51:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rqtmzKvv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55A0687A92; Thu, 14 Dec 2023 18:51:43 +0100 (CET)
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com
 [IPv6:2607:f8b0:4864:20::b30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3805B87B4F
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 18:51:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb30.google.com with SMTP id
 3f1490d57ef6-dbcd348f64cso1867436276.2
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 09:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1702576300; x=1703181100; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HnbTr4n9p/dHIspUOznXpLgy0HYmIeiJjzFyaIeWlK4=;
 b=rqtmzKvvzneCgb4CFwzE6mvOyvRoE4hcT93/Aj0ETYbfeqaunTdQP0iOGnE0C5TTMz
 MIrOkRKJ9Dz4V6mIe5yDhPjaN35Cbmex6Enu4rwAic5W/E1vrSHj4lx/2ABR44TVDVdH
 2QPi1q6LHkAE6XvrbNjbh+eypmgzm+O556Awk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576300; x=1703181100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HnbTr4n9p/dHIspUOznXpLgy0HYmIeiJjzFyaIeWlK4=;
 b=vs2m9fCOiDxfHzxyOHREUS+fTeGtYD3TUh5xV2AxyKr8gvt/mcNas/fwFxeG1eKvEO
 oXTpn73/bpxTWE+ZGERtp0xMIIGS2UgVt/OuYSm61zcxU0b79PF+f6QaoenzX+yDX4Ro
 AV7PZg3N57toy4Bz6MuFai3VkSistVcYM2f6PFiVp1Jnz4p3JbIuwQrRgioKnqNLD8HE
 aSS5JpoZwPwr3UeboWYf0Ny5jBBDcCtfyjj8A5fnEewFyJbJlUkk2g67EzOeAmeT4UP9
 OiGXmBQLHDE7dsgX4XETAkEGc8Cfwlxlb8wGW5obuXhSyvqo3qLDBAi4iTUfTqJzQWTS
 7U+w==
X-Gm-Message-State: AOJu0YyRRDBcX89baXM3KrbxFAQnDvM5gEpf/A+Q0lLPi7IOHR2UfD3f
 bxq33TgbzEZ2U+K/OCc4LEzCNQ==
X-Google-Smtp-Source: AGHT+IHCn9SGeYCLtPh+NAnjLBOShOqFAsitHqX12QwKndZnCNU+HoSfVzCp7lDHfIpPGrFE+R1obQ==
X-Received: by 2002:a5b:683:0:b0:dbc:bedb:1fd7 with SMTP id
 j3-20020a5b0683000000b00dbcbedb1fd7mr3240858ybq.123.1702576299962; 
 Thu, 14 Dec 2023 09:51:39 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ef43-b142-0a3d-20b7.res6.spectrum.com.
 [2603:6081:7b00:6400:ef43:b142:a3d:20b7])
 by smtp.gmail.com with ESMTPSA id
 k15-20020a056902024f00b00d89679f6d22sm4803059ybs.64.2023.12.14.09.51.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Dec 2023 09:51:39 -0800 (PST)
Date: Thu, 14 Dec 2023 12:51:37 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: Re: [PATCH v2 15/21] bootm: Rename do_bootm_states() to
 bootm_run_states()
Message-ID: <20231214175137.GJ2513409@bill-the-cat>
References: <20231214165112.2182274-1-sjg@chromium.org>
 <20231214165112.2182274-11-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="IHGgBeusjRUmwnLJ"
Content-Disposition: inline
In-Reply-To: <20231214165112.2182274-11-sjg@chromium.org>
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


--IHGgBeusjRUmwnLJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 09:50:24AM -0700, Simon Glass wrote:

> Rename the function to bootm_run_states() to better indicate ts
> purpose. The 'do_' prefix is used to indicate a command processor,
> which this is now not.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--IHGgBeusjRUmwnLJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmV7QKkACgkQFHw5/5Y0
tyz0bAwAoufopjVWJK0C6w/SzoW8VjBzIZEc+W0RhZYe77O304DjOqC3SXJzebCs
ckk26oR3CIFLvWjJFr5ekHyGuvwCZzKuKxecZggE337k8Q3R2+AlKHyOUYZfnwqW
mSxt+ZyjRGlr6g5Np3ngnuWnGGPoHE2Jde2iLcrFWa0jhC0eGCCqKKpmxdLf7HOD
Ap3H/jFs2gg1+R58V8UW4wh8WfRuMo4fV2hUC/pHZPKUEC1KFLWeXDEEEqRgw06E
j0sGqHhkBiN1shNTv63/dwSSqDsOV9uQtfdOvkkCnf39MCroljkLy5wsl2XCd9Ep
OUkB+niOAvTpFt3dmQA1e8YuMAp4tCxJpX5FasMGZWn1koCqzFqTLBTys5OIzPYm
/6e9rF7wXN+8yJPx25Q1fZqxt50ZzuGi0clAJ3ewtY44dSz1PziUVOdA63wW2ybi
XfZDal4/8RCqmtZarfmHkBNNKb8HgtApQrmCTyBHLDc1UMOTKZrZwRrWlJWCzkIZ
k+jzLuMT
=fIYD
-----END PGP SIGNATURE-----

--IHGgBeusjRUmwnLJ--
