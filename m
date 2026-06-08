Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4514ACD8C9D
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 14:27:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9202283EEF;
	Mon,  8 Jun 2026 16:27:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jPa1gDfM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 239F78407D; Mon,  8 Jun 2026 16:27:28 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E229D807C4
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 16:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-7e6cdd78fe6so2275541a34.2
 for <u-boot@lists.denx.de>; Mon, 08 Jun 2026 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780928844; x=1781533644; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1SeM61RhFUwX+F8ABbqheaFFvTAsHrV17Yw3P8eDSxY=;
 b=jPa1gDfMQAJEz97/gfPI3urTOAXnarwpZ58aqdwJ0B3sI0TZytLPvXxyQA6zJ7nZNu
 bneE+EdEHk5F7O5GJhoPKGEy8QbrfKPIccpldtEWDpPbKeJcCVPnu8HC61RmDfmtDZs9
 ifm25e/kcVs6zviBJvod7/xF7C+D57MXSFXJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780928844; x=1781533644;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1SeM61RhFUwX+F8ABbqheaFFvTAsHrV17Yw3P8eDSxY=;
 b=iikrv/QHg1ivCbsfQQhYX5q4EGXdvY0nSWNvdMEVuHP37pHvui82Sa094TRePcJs+H
 2AEiHkH+12Sjuq7rTzOD96Qj5gBGcd5Wq0bAWuKmsFKApH8Yx3IJOj/CIIAOTY/cP1bC
 F4FNktI106xmAqpgzQbJai3S4sPQImhMUX+mOWzd1jPMN9GrYajt9X29ipvwZk/xQvmv
 WIIwG03zKmQQHQP9VFVdlhZYlzcNz4Br3UAIZ61CoaM/UtDkY/lEZfQqRfJa1T8H23eU
 Xi9YJ9M4GL3lTIFkZx88w1aoZ3FA3K8sEgKbklWTU9h/KdRTVLDAFn4kZZmjcUcq3HVv
 3qGQ==
X-Gm-Message-State: AOJu0Yx6/LHjo9TMOwTDLnhEUXYGVHHh05+ql768b1nnKA0/w5bMFzhu
 HHYqAGoB5WlRSZxfs2qHd1JfuzeGl0Gqc57u01hiWNZi+YPZyJ86+K+BMIpctXB/54Q=
X-Gm-Gg: Acq92OFsD9czLWWCibIumpkgDihUBwGWQUSoar2pEBEgTxMIGEpDbMv/7cie26vx9v2
 Uz0rlFtlJDR1qLQn1MHhkUAFUfb/5t7YmztNQTFAJL8S1JD3zS3/NmYf0obq1tlKksYClNBPoOx
 +6CrzumG6+Mz/CSwuwZg7hKu9o3FZymZFG1RG+Puwrk2kV5JP4qeN46MXTU7Ejfd7HD3ad099+C
 SbzRHr8T5MBietef12sAOHj8LtV4Y41adSXS0JDLZM1TCX4gDOo2nEd+7PRWsjUE9+xndCkRg0U
 Y2M4CLSQCuVVm1kNoUepL6bikyhAolXBSWvvXx1JtFSLN2Wa8ur6T2Ua1uu6UoXV7xeK8U0EjVH
 AuxnAldo+TWOl/E1nsSK6VuwstnbaxieBmJboP7mcmx9svZ/TfVkuDJ9vDSOaDtG1OzQLnD0JfO
 NHZBySf464X7YCrrBGXhOoCP6VWumit6OwTgViDp/y2X6BnkXa1+lwE/TOdsYjr9TjFlrZY0RG2
 gqx4C8stS0o+CwpnSd+voA0bQGrii2KCFBp1PP8DuBQi5tE6PZmTAZTQdNXRg==
X-Received: by 2002:a05:6830:64c7:b0:7e6:7dc7:4542 with SMTP id
 46e09a7af769-7e70c7bcfa5mr10148724a34.16.1780928844696; 
 Mon, 08 Jun 2026 07:27:24 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e7468fa7sm11991587a34.1.2026.06.08.07.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:27:24 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:27:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Neil Armstrong <neil.armstrong@linaro.org>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v7 1/6] config.mk: support vendor generic includes
Message-ID: <20260608142721.GA3502663@bill-the-cat>
References: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
 <20260511-b4-qcom-tooling-improvements-v7-1-0c06346e79a9@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/JKVrkVv/DJ0pfc+"
Content-Disposition: inline
In-Reply-To: <20260511-b4-qcom-tooling-improvements-v7-1-0c06346e79a9@linaro.org>
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


--/JKVrkVv/DJ0pfc+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 03:57:43PM +0200, Casey Connolly wrote:

> Currently only board/vendor/$(BOARD)/config.mk is supported, add the
> additional usecase of having a vendor generic config.mk for adding
> functionality like platform-specific build targets.
>=20
> Additionally, fix the ifdef to correctly check for $(BOARDDIR) rather
> than $(BOARD) since that's what is actually used in the include path.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--/JKVrkVv/DJ0pfc+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaibRSQAKCRAr4qD1Cr/k
ChP7AP98pEBQor0/ZHZrmzPRA/o5FhKKZYkGK9Tee2tRMzLWHwEAudEtoXMiXn3Y
Km5XFdp38XiRIGvN4Ftp7c7dbdiX1QU=
=Xihs
-----END PGP SIGNATURE-----

--/JKVrkVv/DJ0pfc+--
