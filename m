Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2131C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1911F8848F;
	Sat,  4 May 2024 00:21:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IHUL8tT6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7528B88263; Sat,  4 May 2024 00:21:21 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DB7588208
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6969388c36fso710596d6.1
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774878; x=1715379678; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=X0ynHbFRXH81JslhcNbeiK1ci5eaS9KUIYuR0x7J8yc=;
 b=IHUL8tT6+IH3XfLbBcbHB61rsc3XK6ggURPKtVlM5wglhC9BFjdRYuRU/7kW8Abz5Y
 bEJTR0s0h/qLt9or/Q06QJVCVD5Avj9sUIRDQXT9K0XiN6J/zFJOZ7jEtacxibBuA7FE
 EGaciDI2XG0hpCtC1VBt6FMzuYAEC09rz0ESo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774878; x=1715379678;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=X0ynHbFRXH81JslhcNbeiK1ci5eaS9KUIYuR0x7J8yc=;
 b=UdbyE5XPbXwEz2tvlsc6IV1R2YrVxP29dPD0ftQ6zhOXn9t4anqOf+RE4Tyl7iw6Az
 FfgHlbZ+lamzhH54Ge6m1ujZOtw+xSTrPJIiDc26gZoyHiYmj5U81Wp0hfMHRFuZzNPq
 n9qYuz3XcLGedrOmdYyqF5ccl+MWxLKC6Q4BnoXSB6Ji2/UZiYB+STrPphYZGVzRgNG/
 Be/hjDfVDxf2ZLu5sZXrUaYXLx/f2YfYzTmbdKl51lZXR5rT/l/Gvk52EphCodDZHp6e
 tJFFS+8jLlMcGCZUkXzq976ar2tuui/B7zw+HfYG5XPlAcDti1nJILHDP6iXqihrom7I
 PQrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjKQrpYP2jS+svjDJSaFKDQ5Ix4CiTg2nC3OQN7j4rkSfBMHmBKyR97Qn01ielDNgxg5dCeuG2ZXylUlTO+4ZE4NmMAg==
X-Gm-Message-State: AOJu0YxDkZlxSmkWXyqd6sUaTwdC53JYiali46+NZkpKjQ2o72cpzjeg
 t03PwzrdPriW3c3sVAy6NGuqs/MB47aHycf9JU4jwx01k1vOfwLo3mET6SBYQmU=
X-Google-Smtp-Source: AGHT+IGVR5fCBD/9fWPbcSuCXSZWXiM3STkytGgVObGUtx+v/mFNbZM1EuiKvbN6nR1BAwK1GPun8Q==
X-Received: by 2002:a05:6214:21c1:b0:6a0:af07:1076 with SMTP id
 d1-20020a05621421c100b006a0af071076mr4148260qvh.60.1714774878280; 
 Fri, 03 May 2024 15:21:18 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 nd12-20020a056214420c00b006a0e73f6971sm1546687qvb.68.2024.05.03.15.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:17 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:15 -0600
From: Tom Rini <trini@konsulko.com>
To: Jim Liu <jim.t90615@gmail.com>
Cc: KWLIU@nuvoton.com, YSCHU@nuvoton.com, jagan@amarulasolutions.com,
 JJLIU0@nuvoton.com, u-boot@lists.denx.de
Subject: Re: [PATCH v1] spi: npcm_pspi: Reset HW in driver probe
Message-ID: <20240503222115.GF2568172@bill-the-cat>
References: <20240423063842.1919456-1-JJLIU0@nuvoton.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RJlcr6Vdo1zPpHRP"
Content-Disposition: inline
In-Reply-To: <20240423063842.1919456-1-JJLIU0@nuvoton.com>
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


--RJlcr6Vdo1zPpHRP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 02:38:42PM +0800, Jim Liu wrote:

> Reset HW to clear old status and use default data mode(8-bit).
>=20
> Signed-off-by: Jim Liu <JJLIU0@nuvoton.com>

Applied to u-boot/master, thanks!

--=20
Tom

--RJlcr6Vdo1zPpHRP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y1sACgkQFHw5/5Y0
tyyBoAv/YMOII02IktYsR0SgeHNtvJP+9sxs6xxcNobfZ8NaU950w8nwXKHBL7v/
aI4gpG2n/ZOp3WKEnn67p3a9rFCNZoEMXVc9vC/zf9OKhi+WjfteME67A396h1yE
Bv6vVO+21oOoa3cmxn5eViS8ftPwqKducUlwF82ZI+4rZBh1RUFDgx1qxx59TTim
+0lFnekitoIqzGf9CMSKrelBeRpdvUz2yOjYju+Fuwy1FazQHWnPtnlIYz/KlI8N
xWvSL7C6XtUzcOY9XkhtuwQ6n8LNFslHpLWf026/dqrM0dIxRAJkTgtghnt/jflF
a6JGEeTcUdMI4eE+8/+dSLuIJze/npU50OeLsESvoVIfxPyzBnUvzq67ZHkQTxsG
Ak0vz3G/ZJR+WRuoBGfeVUPQnFYfG9cxEyt7qTbL/afoZNBWb+hzcQieYkGXMhRf
5J968m0TzKSYaqZbalR/9+klTtm7RvwGZ9LbuFJ4FZ388zFVCHNv2nM7Y08O/FEH
LDUDB0Vb
=FiAA
-----END PGP SIGNATURE-----

--RJlcr6Vdo1zPpHRP--
