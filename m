Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3536CC46CA2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 17:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A85B987767;
	Tue, 19 Dec 2023 18:46:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VYuktlL1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D726787767; Tue, 19 Dec 2023 18:46:07 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C15BF875B5
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 18:46:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-d9b9adaf291so2498011276.1
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 09:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703007964; x=1703612764; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=P1GFatP/oD1Gz1815BEKcBHCYpWArput3jQQur4jeBg=;
 b=VYuktlL1HaQnQWVtzvvwPcONC1iqbJ0OmXUTpTrBqiMdZ2tlxFgiMDRD9ywucDDCah
 UvuXo6nAUEg/1JXiPYCUpAkEUyFtG0uVwRVZYR2CzRnOMJ+gAXO6LvypQ4rJhacGSF9/
 iJ57J70cQz5+LyAq/dy8fMdCUqfoexyCH10hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703007964; x=1703612764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P1GFatP/oD1Gz1815BEKcBHCYpWArput3jQQur4jeBg=;
 b=E6TtxvdjodatAJiNsQUJ9e0x4eE9k0n0HtFpkWpUGLmnkYlH9qO9J3WOsfpsRnhu3Y
 gYtA6QFwOrU0hFp7UJeFub+XTg3wX2E3EcIFCV5AQFFUnPb0EM3BOhLziSI7WWT4Mzp7
 bJHm3FmkeywGmAz3NkYvKr9Dw7YUc735/TayO4pGhmiZ/ohjEituxhOa9TVy0Zlucjg7
 F4Ws24uH8+9eDuz6e1djbDiry4cMIIqbvNnBCMF/aWQ29bXyh6d3K3pdpzwH6zprRWuV
 V2ZQL/oBJmQPHvAJC4Iw7LjbUm94AeJtZNgZ5dqnAt6PCoRWih3PNptrqbAW3yAhoM4a
 74aQ==
X-Gm-Message-State: AOJu0Yw+f8xyECpWHYglEmF1cwCw4hOx3zcpm6uZ1CVwICQe7inUWGdV
 xfmdspAIP0RX59tSp5vONAkUVg==
X-Google-Smtp-Source: AGHT+IGOr8J3iPXdKF4Xmn+7H21kvsQYn+pFzh5nxWr8qxQZuJLqNUQu4WjUPlOQSLr09qv2NnN9DQ==
X-Received: by 2002:a5b:184:0:b0:dbd:6c4:357d with SMTP id
 r4-20020a5b0184000000b00dbd06c4357dmr2307218ybl.63.1703007964450; 
 Tue, 19 Dec 2023 09:46:04 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-923c-ac63-6854-a688.res6.spectrum.com.
 [2603:6081:7b00:6400:923c:ac63:6854:a688])
 by smtp.gmail.com with ESMTPSA id
 n66-20020a252745000000b00d9c7bf8f32fsm8804678ybn.42.2023.12.19.09.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Dec 2023 09:46:03 -0800 (PST)
Date: Tue, 19 Dec 2023 12:46:01 -0500
From: Tom Rini <trini@konsulko.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Maxime Ripard <mripard@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Roger Quadros <rogerq@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, srk@ti.com,
 r-gunasekaran@ti.com
Subject: Re: [RFC PATCH 10/16] arm: dts: k3-am65-main: Add ICSSG IEP nodes
Message-ID: <20231219174601.GA2513409@bill-the-cat>
References: <20231219103418.3445886-1-danishanwar@ti.com>
 <20231219103418.3445886-11-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4ktM7gnBbtouwn1s"
Content-Disposition: inline
In-Reply-To: <20231219103418.3445886-11-danishanwar@ti.com>
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


--4ktM7gnBbtouwn1s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 04:04:12PM +0530, MD Danish Anwar wrote:

> The ICSSG IP on AM65x SoCs have two Industrial Ethernet Peripherals (IEPs)
> to manage/generate Industrial Ethernet functions such as time stamping.
> Each IEP sub-module is sourced from an internal clock mux that can be
> sourced from either of the IP instance's ICSSG_IEP_GCLK or ICSSG_ICLK.
> Add the IEP nodes for all the ICSSG instances.
>=20
> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
> ---
>  arch/arm/dts/k3-am65-main.dtsi | 36 ++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)

What's the status of all of the DT side of this, upstream?

--=20
Tom

--4ktM7gnBbtouwn1s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWB1tkACgkQFHw5/5Y0
tywY8wv9FDv9uzUNnprjPIPSQ+AWp3JC1AMjiG/IKaO9CiT0M9OrMy0Z6Kxuf1aV
ZV03eKxRAde+U5fQGygpUa1PXDW9ACG68VK21WGuE9LkqIfr0XGIBmhT7zold1H2
PhWNrXwxEgky3otsoOFR4TXd6racRtHgxu+Qk/QXlfYbUfWlXq0u/pVK90AcNHyV
2M5wJKD51fIhCSpqWToB4T6a1/hCGRUXf7cSw9rzcH3TaHXgCA87AtHWN6aguAGh
UA47uIlW94FxqBtWQd3GqYULfjLoC7usoEeFnVSYK2hh6wf8BzGWiGMNf3F/aiW7
6/I2XFg/Y+/ahPDBMVswc8gndH48PI1VldzV9Nl/TDUCf4u/LtJGT9CfeTATlZmN
yWaXXJiWxJ//GrujJEyfAxKMyrMd9ULJbQK+hJGPj/ToMyXtZF6f1s9MX77gOoqa
C1sTipW1uDb1wduNt7mFzk8DlwFDuowETrWOrlD/c93THtRAAmm2w2pZIPdX+tiI
JxrYuxuw
=9Q1O
-----END PGP SIGNATURE-----

--4ktM7gnBbtouwn1s--
