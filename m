Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AACB7C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 22:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFCD3881A9;
	Sat,  4 May 2024 00:21:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="oVPc3vzR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5FB3E8818B; Sat,  4 May 2024 00:21:54 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87C48884F9
 for <u-boot@lists.denx.de>; Sat,  4 May 2024 00:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-439dfa27003so621181cf.2
 for <u-boot@lists.denx.de>; Fri, 03 May 2024 15:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714774910; x=1715379710; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=e7CkVZilGofsfPXkEkLEiHImKt0Vq6/jtH5I5VywEno=;
 b=oVPc3vzR9bErh9znTbiiWuQL89KCgiqwHFMdNQIKAI/kw+V/1Eo13YU3RRK/wd9QRc
 gtyllMEVwZvHgioW0DMQuvPC9Ud0JOr2jCNI/A96sJloHS3bVPS0o++7SCxGr8PbNz6d
 3Tmpg4xwsnIi0XM0faAuBjEy3pSHGfJFKzyrM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714774910; x=1715379710;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e7CkVZilGofsfPXkEkLEiHImKt0Vq6/jtH5I5VywEno=;
 b=o/ZAZvn9gYWk8T9EhZU+fxZ35ZEVgq2EDVUFOedQRtRxjBkv2Qgt0TWzCAT/HpbLCD
 Ih3OPx7HgtfZLG4r7ayKt1yDTxgonmS+xk1+Ck4MqaCNpus9tbVYmC9EGVnPqK8Orz7A
 s3oOzI0iNkPbeaS9cAgyudyZTGDeAmdFC8s6WkbU6iJr8WKaAv1mpdeRofVxVRujTHKu
 KvUxLbb45eLoVxNxPk9LRvXiTwdjZ8tTKqgyr12Kuf/UuxMCP7fEDXZ69xqPeXptIyt+
 Xg7x16bu6Y/GZec5jq0ugM14X1mAs8C7yAVVtCSwhtVtD1KtRbBs2yWWqZ+XZW9W5/dB
 KIZQ==
X-Gm-Message-State: AOJu0Yz+pYoEQt6HxmzSSFx3jUgoiqCcfk0o0yVhrDJEdAmrAGzNMK8P
 fmJXx7Ed6mGg01pU1GkhXWFPhHhsOJnSVi/W98pZ473KAdclKhDSfL9MlJ9hGpw=
X-Google-Smtp-Source: AGHT+IHVRAKLZSXNnsqvrsP3Z0mGRcExrm1k1yOlPCh+ctMq2l4pNiE5T1TsPcOa8w3f2YFg3zzYbA==
X-Received: by 2002:ac8:5a83:0:b0:43c:56c6:b489 with SMTP id
 c3-20020ac85a83000000b0043c56c6b489mr4269107qtc.59.1714774910242; 
 Fri, 03 May 2024 15:21:50 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 cd14-20020a05622a418e00b0043791f7d831sm2002204qtb.63.2024.05.03.15.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 May 2024 15:21:49 -0700 (PDT)
Date: Fri, 3 May 2024 16:21:47 -0600
From: Tom Rini <trini@konsulko.com>
To: Judith Mendez <jm@ti.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] configs: am62x_evm_r5: Increase size of malloc_simple
 heap after relocation
Message-ID: <20240503222147.GK2568172@bill-the-cat>
References: <20240429214936.15187-1-jm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="3rEWUCmWf3K8gvoI"
Content-Disposition: inline
In-Reply-To: <20240429214936.15187-1-jm@ti.com>
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


--3rEWUCmWf3K8gvoI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:49:36PM -0500, Judith Mendez wrote:

> On AM62x SK we can see a boot failure with signature "alloc space
> exhausted", so fix by increasing size of SPL_STACK_R_MALLOC_SIMPLE_LEN.
>=20
> Fixes: 128f81290b ("arm: dts: k3: binman: am625: add support for signing =
TIFSSTUB Images")
> Signed-off-by: Judith Mendez <jm@ti.com>
> Tested-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> Reviewed-by: Bryan Brattlof <bb@ti.com>

Applied to u-boot/master, thanks!

--=20
Tom

--3rEWUCmWf3K8gvoI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmY1Y3sACgkQFHw5/5Y0
tyzEYwv/b7tSxQCMqW9gezl+P+/dxTdX+l7msJZSVvZI/BSrFifjyPuhQFJbOG3X
I+O29P4cTpu+3KW/pjEyBaS7UjzP6mNbz9z3Kg1htYWtP4r09kpRWDSywSoPo+st
AvwKHdUOUg/MJweBK70KSn3MT4b5tVQW6RHuONTqaSK+RLlsbI8A2buVbeVEznb1
ToiM78pqTD/c2J1Y2y1IoPPJBWgZNyBJYvyM/dPqubsQDXafZQjODRrJBTO5lm/0
dK2dylwdYoAGG7FW5mEgmNmoystDt0dzPZoaHjp97jWleeOczwBOOsGtAWtr3DPq
oRXBXSJ0tBgpMFMZ4RBFAN+K4eRAigokVf79Uf2MvXTkd2fbPaMWLIT8wYLGXrtg
PLO387J9zJZvpwyxc2psZCqONE7MdPvJSWvJ5bqVbo2zNeZ3tLzgMQLti0rHoidh
SWaV3RTHtGHOIw8xkxTu91tMmhrLnhI+ziUhNCiyI10TlFzbL8FkoVwRHM5ESKK0
31P2Re/3
=+vSZ
-----END PGP SIGNATURE-----

--3rEWUCmWf3K8gvoI--
