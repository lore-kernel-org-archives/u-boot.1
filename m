Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2B7C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 19:59:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6959B8722C;
	Wed, 15 Nov 2023 20:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Jm+NfBdf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F02BA8722C; Wed, 15 Nov 2023 20:59:01 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F16648721D
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 20:58:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41cc75c55f0so10779071cf.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700078339; x=1700683139; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+WVC/yz1CbxK1ChV0GIXyLZcxYCPKHv8C+V36wbzQ3k=;
 b=Jm+NfBdfichZhPC/C8n1NV5me23HcKc7zDe+QzzsAJQ6gpnP/RBzM0BLHfbyXTt8aI
 gmhzSdHe9cWCkKd9uB9LGOYgCzP4m1XRPNNKQFHuZtVY+zrB9ot9vd39+8xvyDWCCIlL
 So29UXpk03LDCdqn+Y8R6SKc+t6eiICEflDis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700078339; x=1700683139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WVC/yz1CbxK1ChV0GIXyLZcxYCPKHv8C+V36wbzQ3k=;
 b=Nw0Om6l+mV6I3ZqjVWAM5lAR8uiF/dbB3TuLTtqX6IpwU16Uw5lf4ZZGe78peH1Vw2
 OYthsJRI5xYTcFotOWk7FDQv1e3dgVOaHbNoQ23vcNxD2izeySPSq3DA+D4aOL+crpcb
 QXPqkZYu6PLlHK8tRKVKCK760WPTncjX9Ei1wvarvokbuXkUE1C6rD7ZbfbBMYueuxwE
 GGGDZvd6xoOV7JLw+LuvQQ8OslKURI1DlnpGlZDvsWx+R7KP1Lph/de/LXExZq09cJf1
 OlHhgOl3ioqoeBJUqJaOaBCuhmBlaCObUSLnUFIng0Z9JrtbRQIBep7kIgpemkLEWSil
 d/+A==
X-Gm-Message-State: AOJu0Yx2VXz3ht73z63AVEsS7Wkrzc7Xq1e/+HrIoRNaBeJkvzZmXnH0
 AUoTCQDfrMrgXsJD4yIvWx9dLQ==
X-Google-Smtp-Source: AGHT+IExha4wwmhoXWcqcWNwYR3aTr+JBzbY6exrtzk+BmGqifUwKEdueu5TE9HaCe4IXEQJ5gmGBQ==
X-Received: by 2002:ac8:5ac7:0:b0:417:953c:ff57 with SMTP id
 d7-20020ac85ac7000000b00417953cff57mr9599583qtd.14.1700078338759; 
 Wed, 15 Nov 2023 11:58:58 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-03f5-0f73-ac9e-a6c1.res6.spectrum.com.
 [2603:6081:7b00:6400:3f5:f73:ac9e:a6c1])
 by smtp.gmail.com with ESMTPSA id
 u16-20020ac87510000000b004033c3948f9sm3770075qtq.42.2023.11.15.11.58.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 11:58:58 -0800 (PST)
Date: Wed, 15 Nov 2023 14:58:55 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Baruch Siach <baruch@tkos.co.il>, Bin Meng <bmeng.cn@gmail.com>,
 Evgeny Bachinin <EABachinin@sberdevices.ru>,
 Fabio Estevam <festevam@gmail.com>,
 Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Qu Wenruo <wqu@suse.com>, Stefano Babic <sbabic@denx.de>,
 linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 03/29] treewide: Tidy up semicolon after command macros
Message-ID: <20231115195855.GM6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-4-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="D6pLJ22zKbOC/++g"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-4-sjg@chromium.org>
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


--D6pLJ22zKbOC/++g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:48PM -0700, Simon Glass wrote:

> The U_BOOT_CMD_COMPLETE() macro has a semicolon at the end, perhaps
> inadvertently. Some code has taken advantage of this.
>=20
> Tidy this up by dropping the semicolon from the macro and adding it to
> macro invocations as required.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--D6pLJ22zKbOC/++g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVIv8ACgkQFHw5/5Y0
tyz5tAv/SHvR/oteVxDtQfeHpteSntQvpMFGu4cIbwCJZaOAZlWKzzZSI2M9+asF
rmuarfPcqOtNQwobXTAchlPWD08Polkb3pWKOixHxcmaXeSA4Onc+CZiBgkJ3mtI
ZWoWswhNIPbg+ivi1ITFGq+l/qScI9nlrW08U5VhxXr2ksybF7pgz0befJCyGw+o
jZdGz+p2NvZi0qodSxdA9pOHeN0Z0s9cwmwdNtbB+ghZDLIbnGLT2gfofLCX1619
apurnOiw5H3KrsNgDGPUkCcsOz/YsGd8YgqmMcLzweZ7CZeWUlxf8q7DAJKvUubd
fdLfLmrQUMEDXudPEAGrpBll/x4qDolQe/6FY/QCUBs0+S+PajiecRuNCTbGm3Cp
Sb8cE4mrPGR3kuMWRnOeh4qMWNnr5vX0wWxP/OGgvh1kFcHcMWaFSDQPVkBkkur4
B4B9CuJOSvMXdEQ8mz6BRJkivJEJNXVLDfpuL0bBzg72rfZGsUgMNTATJupKbLIX
izK1kL2S
=9zlJ
-----END PGP SIGNATURE-----

--D6pLJ22zKbOC/++g--
