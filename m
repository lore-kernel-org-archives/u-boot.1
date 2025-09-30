Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310DECCA468
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 14:37:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6DAF8349B;
	Tue, 30 Sep 2025 16:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="JzTWLTHl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 806DD834D4; Tue, 30 Sep 2025 16:37:54 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04640802C1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 16:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-90926724bceso379072539f.1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 07:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759243071; x=1759847871; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jKCWLhHgb73l9RKGiBxKvpu1UeL8Bct7W/1hgKS9qeA=;
 b=JzTWLTHlBvhFC+MwsWXLYL1NLaCfHNEvc/XJejFZPzYBZrF9v8eQQv0C35QfozHU3Z
 epFJWBPeEJKmH2wrjstcByyr5eO+P0OyWzGxnoEKMwyHnHedF8AidPQv2BIUa9TFLGeJ
 ctSjfOYJzgD93TCuJVltHUDfT/NWLWbMn1tvA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759243071; x=1759847871;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKCWLhHgb73l9RKGiBxKvpu1UeL8Bct7W/1hgKS9qeA=;
 b=HMd6pkx+I2Syv+qrZ497x2MjPRhnpXGQEw1ZNapl6GbBplU2++jPzVRu/JhOiTLOQe
 BmoGI7Ofc/6N85kjbCQhpKxM8mHJmc8CA02vo0rMYjmeTigR3PzRR0iBYNFkT3ytrpiM
 PewxMmnIa+cqqOGct96PxGsKzHJNQ5uUBr2hO/eVdtKuC5xULIT6Fl9ZhveYCXldJr7W
 vqCr5cYzHtJdsNhgGN1i6QHt7W0bd0Jkj27pSiQEobgls78CH3CVcbDFBsgG7mQS41go
 IFI1MbkT5ta43Q/QryibHd2a1LCa8fUwrbtuKVP57EO/jZl6mQNUrI5pb4VNyFcGcuOO
 S3Fg==
X-Gm-Message-State: AOJu0YzQcjpg5fHjw+NpRJhgtuoMiEchI25tLVw4VhkkvorD4Eec1k6F
 X986PTWHolKPlBA6ujlnoOkSFrR7mZuRvTID1Vq8YIR/PxMY7n/1cDJ9L5KUSL9RKeI=
X-Gm-Gg: ASbGncvMImVXSq9vDzQtx/R2co0YAubH8Zr1O8i+lGtLYmpnXJTaotE/0B3e2hfnYb5
 dOGUcYWhGo9wVi9mkL3aBKVK0oe+sjA0CmTQXHnsiXo25xg7Kuq4xQufVGSmWK3oPnVTniqWSSe
 kjJae42BCY6rw/rdtq0oh1ryOOlTPbDfRJP2G9rrzPvOL9tdyHe8RqWFOGpMcX9CsRYIVUyNXhP
 mV16wQxd5B38yO09SavW4VVYW/z+pSwq+EfcHKOgNtITURHcqNGFSbqJZN6Dm4eLPJvjDbJ81KK
 4IzF0p54Usya21sFJAcbrTDdMtCP21RS/DMTR2qfWK5Gjvumz+thFsHmG6i0jBLcxWfqtfY4Doc
 nwThElTLZVxoV8hKkt+1jasyqL/Gkiaus7oTi+JQW8hmCOjq2irf+Y9Ut3hRbA9H0KxyAWvqP1m
 lMtxTnLsF9jKtSI8U=
X-Google-Smtp-Source: AGHT+IHw2HZhQ/c/9f5Racrs/MYHE/jzLsRzUblCgrcA13lCfhcKCoNy69BxbiDH4PUWCKWsbGhIyA==
X-Received: by 2002:a05:6e02:3804:b0:424:8114:3840 with SMTP id
 e9e14a558f8ab-42d8161d65bmr2033565ab.23.1759243070617; 
 Tue, 30 Sep 2025 07:37:50 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-4282de12fc8sm48762985ab.3.2025.09.30.07.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 07:37:49 -0700 (PDT)
Date: Tue, 30 Sep 2025 08:37:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@amd.com, Anshul Dalal <anshuld@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: Re: [PATCH] xilinx: Replace PHY_VITESSE by PHY_MSCC
Message-ID: <20250930143747.GV6093@bill-the-cat>
References: <0a441e488a29bd1c93677a6f63a4a04a3cc1c9f5.1759216164.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="T8xksdEOmjZPWc1W"
Content-Disposition: inline
In-Reply-To: <0a441e488a29bd1c93677a6f63a4a04a3cc1c9f5.1759216164.git.michal.simek@amd.com>
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


--T8xksdEOmjZPWc1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 09:09:26AM +0200, Michal Simek wrote:

> Enable MSCC phy driver instead of VITESSE. Vitesse driver is much older a=
nd
> is on the way out that's why switch to MSCC driver which covers VSC8531
> which is used on one Versal board.
>=20
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Thanks!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--T8xksdEOmjZPWc1W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNvrOwAKCRAr4qD1Cr/k
ChJZAP9hzPkywcvLYQgTAt+DdwhezFJnO0Ap/IOv8nB6ybz/XwEAveDmJ5a1djWp
BWAuB9a+TvF7g/Ev7Fr2nvVc6qrX6Q4=
=+zO3
-----END PGP SIGNATURE-----

--T8xksdEOmjZPWc1W--
