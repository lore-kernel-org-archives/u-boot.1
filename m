Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E3CCD38FE4
	for <u-boot@archiver.kernel.org>; Wed, 14 Jan 2026 16:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9099580433;
	Wed, 14 Jan 2026 17:28:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uvpVTfSi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD67E83015; Wed, 14 Jan 2026 17:28:34 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89EF980325
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 17:28:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7cdd651c884so806864a34.1
 for <u-boot@lists.denx.de>; Wed, 14 Jan 2026 08:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768408110; x=1769012910; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=O3bLPhTEakWen6sPeinnqWvFNiM0yAmZYtI9vxiZkVQ=;
 b=uvpVTfSiyKqMDrfCnXkPXazTP9WvvGt9JJc1inM1MtVwod8hbRbDfAYQGXkWT8RbXc
 1YftrawhU+Z29KBGCBHh+TBXjPupVV9ewIElu9SjC4R/rglcGBOD7UgZHwKtraQEkZtu
 7yZOkgXcJwO/ljWgPUrv0iKEGHJAiay/EtTFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768408110; x=1769012910;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3bLPhTEakWen6sPeinnqWvFNiM0yAmZYtI9vxiZkVQ=;
 b=I/KPjyobot0iIsParkOHmSJZhAbI0g1YzLy+lgVG0iRJM+dVMzUSKMqlI1ilwIbWgl
 VBzO0jwCl2COYs6T6niQ9EtKafpj9m3gjYqS0CAbp4kGlmX2BN3QZlGHpybylLqWS6AJ
 BP7dqRc4ya19s9XEIR2SmzflCFcVNad2HCraytl/hbycNyTNheDdL4m+3uDyG8Kkjit0
 81yPnOoZqOkEVjklbOZdj4MbWA9kBuBBTROydYRn/xcq1mA9JKLfpTox/it76VE6IPrv
 oOYQGYhcR3rNDZFh72sICNvDy1bjJlWRB/BSU6/jo8mr7p8RZCKSHxKrdJQRzrtj2aP9
 AbcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJv3FrtBJC7TiHb6S36zMzVzsq1p7uwYmZ8uCeibYkYOM5zzGuTDKsBo3xOo5BkCHoezW2HoA=@lists.denx.de
X-Gm-Message-State: AOJu0YzmDn3FTNwoXECDhta9tKAUlp10MGZB7oZABjzelESfid6uGM7N
 3F2Hwysn9U/MkJ1SjcbjGfX3PuknLbLlkdPJrfkIPl/Z2ZgADcaZJx79CUNKapaqhJmmZTN9AW6
 8PWoE+qY=
X-Gm-Gg: AY/fxX4uGLo9yuxE04fIM/QX1A/u6gNKV8WMhkvGOSZrvcXii70OSKa/HWnuKsl/AgH
 FYbpwtsjAU7vtK10acNnGbkeFa5H9yXCYYbPxdsysor/zvHo08lAHuRu2IGccOK7XThR4DNQCVf
 OeEmYIv0GRzrbjDMdqdwfnPPx/x9Lnl2BoN4FOs+FmXFquUgHR7OrMgDmnLiSLsLHHzDQVc3gf1
 xikmc1TSQD0Xv/xwyNtslxj45TJqWpTuN09MulmwWVZwK78y0rd+wYnpplSKrFiFzx8pEkc9IpS
 ARlFTpmxuFIfaLk+AsgpXdSEWhC2kTDU+QMceZ/dOFN++uyQ6eBdBNthPApAVZfuRUhofO46XfS
 ZwraLmVxCqiK/zwlt5SI0vWuNtBIeF+KDx+W2RKsP6zo0g30SOrZ4Yi4Xw93w6oxLPdxz366LIH
 0lwqculDDYmQH8SRLvCE1xNCqDYXJsDSBKJ2wNbkREz1Bgqp8AwPDAnx44hOOwYUJmoepntjqS7
 XaGioztv7XYAlt8Ft7Xnz603/4jgAPjRPdHJthQ9FKDIth4aw==
X-Received: by 2002:a9d:7f84:0:b0:7c7:5997:c1ee with SMTP id
 46e09a7af769-7cfd45b867bmr3497a34.6.1768408110254; 
 Wed, 14 Jan 2026 08:28:30 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7ce478029a6sm18268459a34.3.2026.01.14.08.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 08:28:29 -0800 (PST)
Date: Wed, 14 Jan 2026 10:28:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome@forissier.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Michal Simek <michal.simek@amd.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Benjamin Hahn <B.Hahn@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v2 1/2] net: lwip: tftp: Do not write past buffer end
Message-ID: <20260114162827.GE3416603@bill-the-cat>
References: <20260114-tftp_fix-v2-0-8de8e6ecf4e8@linaro.org>
 <20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Jhy1Dm4ea5xpzNNP"
Content-Disposition: inline
In-Reply-To: <20260114-tftp_fix-v2-1-8de8e6ecf4e8@linaro.org>
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


--Jhy1Dm4ea5xpzNNP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 14, 2026 at 03:12:09PM +0000, Andrew Goodbody wrote:

> sprintf will add a trailing \0 so manually adding a trailing \0 will
> result in an extra unaccounted for character being written. This
> overwrote the first byte of the following allocation block resulting in
> unexpected behavior.
>=20
> This was found by Running 'pxe get' with no available file resulting in
> multiple attempts, using the default algorithm, to attempt to find a file.
> Eventually there would be a failed assert when free() was called.
> Failing the assert would result in a system reset.
>=20
> Fixes: 27d7ccda94fa ("net: lwip: tftp: add support of blksize option to c=
lient")
> Reported-by: Michal Simek <michal.simek@amd.com>
> Tested-by: Michal Simek <michal.simek@amd.com>
>=20
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Tested-by: Tom Rini <trini@konsulko.com> # Pine64+

--=20
Tom

--Jhy1Dm4ea5xpzNNP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaWfEJwAKCRAr4qD1Cr/k
CkU/AP9ovtVcb3rYsur9kO7upgBOkTGZDpwsjW7oJuyhYnUmSgEA5a056h9fMeNU
cYJChaOSTSh2FtQoVsoR+nFU5fE9XAQ=
=6+N3
-----END PGP SIGNATURE-----

--Jhy1Dm4ea5xpzNNP--
