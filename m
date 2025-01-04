Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A57DE77188
	for <u-boot@archiver.kernel.org>; Sat,  4 Jan 2025 01:24:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F3278034E;
	Sat,  4 Jan 2025 02:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PzfytTnS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B43EC8036D; Sat,  4 Jan 2025 02:24:50 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D148007D
 for <u-boot@lists.denx.de>; Sat,  4 Jan 2025 02:24:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6d900c27af7so100650586d6.2
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 17:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735953887; x=1736558687; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=IC8llB2bqtACAX5Xe47q3Txx6aSYVpuNtnjjLRApd2c=;
 b=PzfytTnS8wFAGIpjSta/tBdGpmjoKgs4QbMt+nC9W/ZXk5DGj0Dd4cxGmBfXeJYFn4
 lXCc8pHt/8rqssvr/A1l8iqvmQVTgm9GYi3x3x3IunrfHColisONRwR8k7J6R6IllJ1W
 8zTwDq+ldtHopyKZrr4gwMfiSkdrA7iPSpDRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735953887; x=1736558687;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IC8llB2bqtACAX5Xe47q3Txx6aSYVpuNtnjjLRApd2c=;
 b=EQmTW5hmGve2TohcTbxq1jvLRwN7ClsZ0uYjxLVAdIsHN8Vl6Ux48ybl9gESj2LPm8
 eHZRbJ3xT3eppUEvysPVgnr6xdnS2L3J8ObFLeBT2rXlM/jh9lO7ACuteI3XkpQQxkp9
 JSYFEYB6f59kordyIJ20na49ObXMPG0AOcsenIoogARH4oc8FE8Bx1B4FtuQd7wlmlx7
 hmbNaU97MISNmED64MtDqpdzr6p4RUxxIYXvfpk7fh4umD2xPYhjDudZT/sXM4CZCDgC
 Y7dZNH0p6eTIX5/AITqtPi2XYr89Vf6RMbGbYsbfDabcee5BRQbKLw1+PUCBkbtZSxHK
 Pq0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2+U6ft4YiwVk5toLsY9tYOalqA7g5VRJBSNZIPxOnOb+twnpSzWWhjTkqeSpODXtf59dQYWE=@lists.denx.de
X-Gm-Message-State: AOJu0YwinukS0tjoZQTGXdtOMIK1yOkYuKts7MtzbauupWdukFaE+LVx
 /ebnZE3rO1sGzpnGvCqM36d6l9KavJryI9QlccUfC/NW15xuW7BmFXb0tobnB0o=
X-Gm-Gg: ASbGncsSdSQi64OVLb18Artkw3zL9RIGOZIKG+aOvm4ommmpdfl4M13xHRX+vrpaUH7
 sSHx9nVuw5D08P4beUN8z/hUUsLHelvMYb5uHMMZq99DjEQJr18zxzmPjujMEUyIliGFISFrXOD
 kgRw9O9RWeEvusDRg1Fp88HxVM5m7V+s47/Qkrwdh1YHCBW3E2p5t7Lxh5E199oHJzBZ/Iu5S0x
 SFiZpLXzgEDe4huCGVAzuyNz+FcwJQ98Y/elWI+seArnNbdAVJqBsYwIw==
X-Google-Smtp-Source: AGHT+IFJOdQIOrTETS2pRvlb6xKIDY7h0j79WMXVxcwBkR1yjFuit9SXZ4A4Oyq//91Y/AS1oeqQ3A==
X-Received: by 2002:a05:6214:caf:b0:6d8:889c:54ed with SMTP id
 6a1803df08f44-6dd2334d31amr719291516d6.26.1735953887417; 
 Fri, 03 Jan 2025 17:24:47 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb530sm146122966d6.76.2025.01.03.17.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jan 2025 17:24:46 -0800 (PST)
Date: Fri, 3 Jan 2025 19:24:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] fs: eliminate YAFFS2 implementation
Message-ID: <20250104012443.GW3476@bill-the-cat>
References: <20250104003402.8863-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="vge4de7pdYLzo8nJ"
Content-Disposition: inline
In-Reply-To: <20250104003402.8863-1-heinrich.schuchardt@canonical.com>
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


--vge4de7pdYLzo8nJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 04, 2025 at 01:34:02AM +0100, Heinrich Schuchardt wrote:

> Upstream development stopped 2012.
> Linux eliminated YAFFS2 in 2010.
>=20
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--vge4de7pdYLzo8nJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmd4jdIACgkQFHw5/5Y0
tywoOQv5AZVW6d6zy3Gzx6S+YUOoKsCERzU7YjaeMNtjVa2StvdLTspR6jo6boIA
t5X+r8im58JJMklyUg6kELvzIwkWHRPCa5rV0oktspFzpyyEZQ6TOUtdk/SVtrmD
6mvpcFdZL4dsbQsXw5NeHTaX2L0WlauoMNDGtTgddSaaBxPmRL/FuKbWdo2/5QjN
zet4phvT7qwCZmNh4Io6n4Mt/OtfDq7aQEVuNht0XifCNZyRyV6JelBRYU/DScc5
N4mLP1bx6xEyx5jQ4KECmG/bjCeTHcWWpwNxJfk/MSzWlW0BrcZRTTA4795x6y2o
6zgsuHmzFdRgyHlwGoK89nAxbTVgegy1DSDzAeP/hphhe6NxD0zvJTcEkGyj2wEZ
T1CLqVJI3OtgT9WSl8FKKtD/uO3rGE4gsxJO6R9nGynqA2NdyS8MWvWiH/gxMZHN
cOzymCm3IN5p+j6P/McbjnpMRvyLq5oUQWSMycG1SD1Ngqr4PeSVtLYGbdC/0gYd
GqqGHknq
=7NST
-----END PGP SIGNATURE-----

--vge4de7pdYLzo8nJ--
