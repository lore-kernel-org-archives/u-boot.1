Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9857C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 16:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6585E870A2;
	Mon,  6 Nov 2023 17:32:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K8SokcUJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E017870C8; Mon,  6 Nov 2023 17:32:57 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB001870BA
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 17:32:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-66d11fec9a5so25940566d6.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 08:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1699288373; x=1699893173; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0lhx1bHDmrzt5ox6IxsD5pLRpGWB11Z1ycyCSprKuR4=;
 b=K8SokcUJd94jfBkhVKfiQMFvOg8QRoBTdnLqsZyX6VBWaxWVKj8vQaoTXomer3vyhc
 zCdsB2eHwM2I4VTsYO5sBQ4cXbk8/anWe0cw1nIKOrDWV9tm/nDrJ4dvmQo+g3B33nXB
 9Sd8VECGhUIWHLg30ILU0s81EvuJrO6wGo9iM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699288373; x=1699893173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0lhx1bHDmrzt5ox6IxsD5pLRpGWB11Z1ycyCSprKuR4=;
 b=eYn7NDk+HRcfghtoBCrXHb66VcEUHhLeF0PlBckL0PKdBScSg4hdep+jp9IEC4oy+2
 AfFcI65zT9A4gKrpjCcfbwodSMGvgtJmfggMV7nfRrAVDuDJ81VIUcRtjsm652IyaPbw
 DTwxTPS3wbjSHSeqV0M0wIXPxCgCTwlrMjSRFqBcYMBM7yC5/klJe+pha/r9SVm4PdX9
 UZRwAOjV2qwdNNdAS7Z4TakaiqCI7ew1D142lR4CX5pSUz+g5lJjwWgF3qppbWUqo39u
 Evhc7Bu6maCM6gKvDsuqVpBPrLm5eg2xo/DAhVcZtBrbAzVKsyZ/yVnNgZaPBqmcbP7M
 c6ww==
X-Gm-Message-State: AOJu0Yw/h2Hcum8ApkOZih1xnTmJ9Xh4R46BW8f8kg0RXvTOpJURnMsJ
 3q6wda8RzPvZSxGeQfB36o2qayf0JKGsqC2YGkZYVg==
X-Google-Smtp-Source: AGHT+IERwqy1J9e+TMp83fS6S1g2aK3ax2lSmsBCK9X/cGTx86+7DqnznU3+kpQkOZWV2Mb3UYwo+w==
X-Received: by 2002:a05:6214:acb:b0:671:3893:f4df with SMTP id
 g11-20020a0562140acb00b006713893f4dfmr24940370qvi.10.1699288373704; 
 Mon, 06 Nov 2023 08:32:53 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 pr21-20020a056214141500b006710660a548sm3546069qvb.27.2023.11.06.08.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 08:32:53 -0800 (PST)
Date: Mon, 6 Nov 2023 11:32:51 -0500
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] .mailmap: =?iso-8859-1?Q?m?=
 =?iso-8859-1?Q?ap_Pali_Roh=E1r?=
Message-ID: <20231106163251.GB61955@bill-the-cat>
References: <20231106090908.7938-1-xypron.glpk@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="MIaR/XiVXT5f18jJ"
Content-Disposition: inline
In-Reply-To: <20231106090908.7938-1-xypron.glpk@gmx.de>
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


--MIaR/XiVXT5f18jJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 06, 2023 at 01:09:08AM -0800, Heinrich Schuchardt wrote:

> Pali expressed that he does not want to receive mails relating to his past
> contributions.
>=20
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--MIaR/XiVXT5f18jJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVJFTMACgkQFHw5/5Y0
tyy4swv+O+qOvI2teg8srKbYye2IyFaFDd2DNA40Zr5W99MJlqy8dOK+8tWBw5nP
orz3EGFj2u148xx0srZXotD5K2ScpKD6T58GesrZqsMdgO9+a3ljmWLb3qdyRAvg
KhSs/4KVUDiTCoG+foTzzTuSibv/IMA/RcB6uWpBW5nB08J5ClB1dLcAs1ojBiDo
G2eeBRBn3J2TeVQElkfdjiVaDpg+3SEEVoPQrTkSM2zteguCulKFTsxNdxpkDg7l
bG8I9P+WiFpVvb5a/pHyeyEizAlCZ0LOH+eqXMd1zv/55ww9qsJAidw4tEVl8Yyt
dzdQGG72ZWRxOPWUC/thUNYwm3ruGCWJnQKOPD8XknoNNj9jv590ey5LjwN1NfeS
9XIBTBBhNpjMDObzNrvzYpHMtcowDAMr+tlejFsX9KnfcExKWtWu66slbr0E87gQ
fkekZeZCse9SfbDdinRxOKQmCbzH574DaSH5od9V9T5IXGYw6ndhyOhPV38S6hex
ZWfIQ/yw
=NA36
-----END PGP SIGNATURE-----

--MIaR/XiVXT5f18jJ--
