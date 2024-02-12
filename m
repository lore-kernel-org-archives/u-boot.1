Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59363C48297
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 16:19:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1B21877D3;
	Mon, 12 Feb 2024 17:19:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="K8Yr+ewZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E691875FA; Mon, 12 Feb 2024 17:19:02 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1951987ED2
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 17:19:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-6077d2b3bb1so616917b3.3
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 08:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1707754739; x=1708359539; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=WrmSwbyI2zSbms8rn4QAFQvnBYWJJNddGWvH6awp5PE=;
 b=K8Yr+ewZC8xU3BTowCh/I6EE4NigeVFim1X7EB0wq0odThHOxRTQvqPexs+7z1/AfN
 hOoTz1K2BeI7ClauivkA+IEtne55/REFn4FcOySNeLJaN0/O0F0n+IDWOVn08lN4o2f7
 Nh50fU/oTMGs63az0XlWbaDttXI0bs/9ctxHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707754739; x=1708359539;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WrmSwbyI2zSbms8rn4QAFQvnBYWJJNddGWvH6awp5PE=;
 b=cQkasq/yWdR5CA9lWZq5/qxzxdMvyLznluDzf0uaafUJ9LtcJ2RboqRk0i4+C3vZoE
 FhZbzeT9J9l0YOwjOdtlOiUrx2SVfu1HhYnChnJYT+lHHLj/3p/Ro0nWTRjOlr1Fsi/W
 hnj60Bxel7MLXqnYBOLCkqgGbc+/ZyTARY2hZ1pPy8NuJ610SdlRaXW10Y2ib3IuxEam
 DygsetiXXc9u41UoWXj8UhGXYpZpvwUv/f+op3TdPZTwF1hb2WAh/cfEw8GNpdmA7Z/M
 fjaJR7JPFUmWFMAM6l85TGvLullSM5e6UQfMLzQbI04K/T5XLjGHsoPpN5EQgiWAz81t
 6Pig==
X-Gm-Message-State: AOJu0YwbMS8rzXLL45bX+1D46463CWsl3yWBBh3CIcCos0vSQ8z24bmi
 AGb7PxdDejiYz4yMKiJ0oMsbSs5/rWhROy0umXy+VuaV0BIZNeC9dDiF9movk4H20SdT/V3Llxj
 v
X-Google-Smtp-Source: AGHT+IHa2HVlLCaBaBtoMB2Fd03+u9knK2Om18JFGy3vojdl6hLXn+Pu7jeN8YvgsTQh/LRK0GEdZg==
X-Received: by 2002:a25:ac5b:0:b0:dc2:4e83:e6be with SMTP id
 r27-20020a25ac5b000000b00dc24e83e6bemr5715144ybd.46.1707754738773; 
 Mon, 12 Feb 2024 08:18:58 -0800 (PST)
Received: from bill-the-cat (065-184-194-195.res.spectrum.com.
 [65.184.194.195]) by smtp.gmail.com with ESMTPSA id
 v124-20020a252f82000000b00dcbbea79ffcsm107502ybv.42.2024.02.12.08.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 08:18:58 -0800 (PST)
Date: Mon, 12 Feb 2024 11:18:56 -0500
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: u-boot@lists.denx.de
Subject: Re: Pull request: Please pull u-boot-imx-master-20240212
Message-ID: <20240212161856.GD3040305@bill-the-cat>
References: <20240212110159.2426827-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nUvXBLVfJs3ilROu"
Content-Disposition: inline
In-Reply-To: <20240212110159.2426827-1-festevam@gmail.com>
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


--nUvXBLVfJs3ilROu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 12, 2024 at 08:01:59AM -0300, Fabio Estevam wrote:

> Hi Tom,
>=20
> Please pull from u-boot-imx, thanks.
>=20
> The following changes since commit d7aaaf4223d0a2f9f8c9eed47d7431860b3116=
d8:
>=20
>   Merge tag 'u-boot-dfu-20240209' of https://source.denx.de/u-boot/custod=
ians/u-boot-dfu (2024-02-09 09:00:42 -0500)
>=20
> are available in the Git repository at:
>=20
>   https://gitlab.denx.de/u-boot/custodians/u-boot-imx.git tags/u-boot-imx=
-master-20240212
>=20
> for you to fetch changes up to fcd377ed6480643b1f79188c7a8fb9280a211b4f:
>=20
>   configs: imx93_var_som: Enable AHAB support (2024-02-10 15:16:13 -0300)
>=20
> u-boot-imx-master-20240212

Applied to u-boot/master, thanks!

--=20
Tom

--nUvXBLVfJs3ilROu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmXKRO0ACgkQFHw5/5Y0
tyyMOwv/TPIxvLLtBgXUnQsNenXON1Weq/46ev1bypixIoybSKbmf6INgNN4bjMM
eSAIlbwwMsJ3yqBq5ZrAZNQRBGj0eIl9yxGAxJtGLYtm5MHLQiizgTswgkFPFMpw
yjGQzyhfO/wtl7GVnW5dEUv66ThauetVKbB7dn/RChA4fKdiLcVHWUoiLjLeL6II
rvFtIWhniZa9h1YAGFdaqnY5+p+f6WxKVnAGspRMaAJ8a8A/9nF0QEF/LyQ7mUgp
0UnQg6MFniD+bY17TiCjPwr3TmLw5q28dXklUGdhCZIxRNX0Rx/fgZM4gBwM7Nfz
s+Nx7d69Mese0jlTJYvEV4QHzqdOrofvGzCBZh7PAh9ue5QrmNk+Dv/3K+LS6Czz
TxV5qN9sD+6/4JjL7RdqsIEB35cOeZV0py4ow7DNBgYLMCiKQb6gKQJnl4Tg5jo9
6Ytgrsm1om4fMrjlUf2WQou/RLtC1sv9R/H19aqOBY2NXOrUJsQNkw4xFCAyI3KM
AR6GUJMK
=5h8b
-----END PGP SIGNATURE-----

--nUvXBLVfJs3ilROu--
