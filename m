Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EECE9370C
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 20:26:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A743886D30;
	Thu,  5 Oct 2023 22:25:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SwJzHp1Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 513BA86D31; Thu,  5 Oct 2023 22:25:58 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4884586D28
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 22:25:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-d8673a90f56so1555815276.0
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 13:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696537555; x=1697142355; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JoxwNfBDm36A+XKaizD+zdbfBRb0lHxdnvuzFFYzTs4=;
 b=SwJzHp1YMO7KAYCK1v5zQl48hD2Pmz2AddaXmVqDS/BR8+sO9KNFgXtxleDDEu70JR
 XmGxidE0gvrsK/yCKfbBgZW9DmWMo2zM/HZ2gCnXXnhiq7bgCzy6sVP+r9piP7zxIThU
 3dtXvZ1lrpIjebxp4virEhWAvoey+7/sRFmok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696537555; x=1697142355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JoxwNfBDm36A+XKaizD+zdbfBRb0lHxdnvuzFFYzTs4=;
 b=vhUqlzxXA/8WFsH/vnmrvuTEQGxx6ZKwYO/092MlqALNGn0cBbzJo4BdN0dlqu+qOB
 77SPzLKVSkkIq+a/3UwfoZGDIRe3ovgxL83lxRD8S8S15RcDGkOEreB5O0xGm+uJd9En
 JGivbWp5kAWuL0Z0ZN30aQa98uyv2YH+EMbUj0AifXM7R+CWP+K8x+22r7OE6rzsVuZM
 pU7M9OJqPZFpuhRnZMSFdcqhMROmsZ9vQIKtMzpQawEHEwoT9KdJMoyFuAx91ghCib+J
 2qgFEZAWUrc5wJR9j4SfIq8Wb6iIU2kSR2gzfkVdrPoJP14dV9xANzkIStpwp+P1FIoZ
 7KyQ==
X-Gm-Message-State: AOJu0YzY/BrlPS8zc23Wb2bmnURQygvTQVD0Ie+cI716tBSe8g2nquGK
 YOT4Av7P/a4UmpiO2xCnp+rIfQ==
X-Google-Smtp-Source: AGHT+IEO/i+QVTMC0Bda2vISmMVFQYX8Bs5Jrma0WsqSeIqbnn5NMih3Q6IoW3wS+ZEjUOb64fLNLg==
X-Received: by 2002:a25:b54:0:b0:d81:64e7:2141 with SMTP id
 81-20020a250b54000000b00d8164e72141mr5953284ybl.24.1696537554466; 
 Thu, 05 Oct 2023 13:25:54 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-385b-0a87-6b23-cb7e.res6.spectrum.com.
 [2603:6081:7b00:6400:385b:a87:6b23:cb7e])
 by smtp.gmail.com with ESMTPSA id
 t40-20020a25aaab000000b00d853795d3e6sm612522ybi.9.2023.10.05.13.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 13:25:53 -0700 (PDT)
Date: Thu, 5 Oct 2023 16:25:51 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: vigneshr@ti.com, m-chawdhry@ti.com, sjg@chromium.org, jonas@kwiboo.se,
 afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de,
 Roger Quadros <rogerq@kernel.org>, Neha Francis <n-francis@ti.com>
Subject: Re: [PATCH] arm: dts: k3-j721e-sk/common-proc-board: Fix boot
Message-ID: <20231005202551.GA2227687@bill-the-cat>
References: <20231005181514.4054241-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5EtOKClQLqodqDFT"
Content-Disposition: inline
In-Reply-To: <20231005181514.4054241-1-nm@ti.com>
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


--5EtOKClQLqodqDFT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 01:15:14PM -0500, Nishanth Menon wrote:

> Since commit 9e644284ab81 ("dm: core: Report bootph-pre-ram/sram node
> as pre-reloc after relocation") A53 u-boot proper is broken. This is
> because nodes marked as 'bootph-pre-ram' are not available at u-boot
> proper before relocation.
>=20
> To fix this we mark all nodes in u-boot.dtsi as 'bootph-all'.
>=20
> Fixes: 69b19ca67bcb ("arm: dts: k3-j721e: Sync with v6.6-rc1")
> Cc: Neha Francis <n-francis@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>

Tested-by: Tom Rini <trini@konsulko.com> # J721E-EVM GP

--=20
Tom

--5EtOKClQLqodqDFT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUfG8wACgkQFHw5/5Y0
tyxtkgwAmCPmR1CjXTLMjrD4/7w6+acqH+lqjdvVT8IwwR9OI8CjeVzDgBI+lQj5
Y44htbp+WQt3QIm8+Rcxpg30mktr5Jz5E4UvSCIcRXOr+tuWK7UjOuaQh6dsL6Qx
0b0qZJbGa9gi6gRjtzR3z1T+l7Wi+pcM+oAu28V0MkCakgwP4J6cV6E8ILyF57Dd
+yxxH1J43gY7fUa4syt38siooq3ZG2axdWyGmgvgEwT9qatV4ixxaDKely7J9kj4
8qU0sMpz3gAB8SBuIMnJmWaaqGErAh2EtbfrQSxFw7Pv1V0AI7ik9Yh5j6q7EXu/
Lw7ADAmNmC0qa8b0jz062b3GrpmlIEAGDfOTF0M0MgSejoA7lslKIMtjDIhCuL6Q
ESTDPZ3yfMvQjy+8jJuxf++A217rYmuNTFXw49N7uXstYwhzz0E8v6oss/WqOexL
oN0M8vq+yUlAZ7Iz7dux1TxGtIYjfLpU03HRCfd+C6fIeWsRT6jfpxgbUnU3DnMi
/EEm+Mnm
=S0Ef
-----END PGP SIGNATURE-----

--5EtOKClQLqodqDFT--
