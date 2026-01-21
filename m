Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD83D262AD
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 00:45:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 505658341A;
	Wed, 21 Jan 2026 01:45:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="a+K/dYVF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E63B38341A; Wed, 21 Jan 2026 01:45:05 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58B4C82A9E
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 01:45:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7cfdcae466eso3242826a34.3
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 16:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768956302; x=1769561102; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2/vd6IA6MKHP025U6FVhftOnP77KG1spWj/BYGw02Eo=;
 b=a+K/dYVF2Ylv8G4D7LtFRq9/cch7GIMnF06TpzBzUi91qCSZ6MgIT8zVZELtcI+CJf
 owjSlU+gE4o4WL2LGPvanR0r0MFF/hEm0IDqT815eB/LtNX3FTGlkW9InpiZ4wq9R4+H
 MN1Fh6ORJuQxhQ6/Fcx8/MYkkgCbELcKeXPuM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768956302; x=1769561102;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2/vd6IA6MKHP025U6FVhftOnP77KG1spWj/BYGw02Eo=;
 b=u7M0nlPiehdep9c04bK0xsm9WGwMpXLcVe/Zl0cewOb5GwIR8STMelO8mFUc5mgABi
 iuBkt0Tqmp7qmGlsvqun179pbfsY3CLJSdwlsc6Dx4krBhPrNd2AgrZTyLDjHebu0YAd
 K48FkXfaGB/FvSa83hhdtj4+O1W6YuxOQCmLIZ8LL+xdfMrjPyNALuHX3pv7xS6DfShl
 CZ87PxcEhhl1qATCSR5HQtrcUkN42kdIdDHDWT10uj/KEZ8fXSyoREuYjPKr5XE+TbzM
 cZoPg7HS9U+VMICV/pKdaBmW+KKUIorDso2W1E2BnL8tUhn5lfUzwqKEPp5s3Ius27du
 u+8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/lbUrNwYz0PNMp9Yip5027pgEm9R0hgNQ1fQfEp3SgiQbfpOFacTlfZ1C4bkvga+NzWLMOa4=@lists.denx.de
X-Gm-Message-State: AOJu0YyGOs07G+Z7rR4rozECvd4epLLCHZJEB/VcUoIKe2Iphcr/mrR6
 IqNe0V5oDczTUL6oJkwKyNMOJ3O/qx7r+jhda3gZ0xw19ppIV/u+higSEjP1Qi7B4X0=
X-Gm-Gg: AY/fxX6WbjhlqtdRtl7ZEi0d/XRIqbWrhqw6Ddd4v51t1JYxFuRxVSXus2M8TNo3TCA
 UWHog+snCvj/OmMDWSss+jvkCV8jOZ+UjawWAtjf/nPEwIr2h5j61uwP0gKNKXQz/9MvhgY3fJs
 rUPs1uYpV5sJ/7E1NcaiOA9BM2dsEwpCIkrlhAnW75mrhP3Ko9DOoMKE9GnMLQl9XChvcSbU4wV
 IoOShpp6FvNBl8BMTF6buXfyXLeody0GHvRxm4JxgteWujCaDNckLi0LbvP1PdAcsyAgXWfSPv3
 6Be+0ccQvO0tIN7pmEslypNX6mOzvbmigK3q6aQ6REIUEonDC0nPmQ62CW3X3HWVWHRn1+rdTJs
 jP7lzVJl+CPpklFtbDAGG4Rh8491lMPkrtTs4AJNhOEmU1c/WqdBsxhUgCqJhdDdR7XfYaZ23hU
 x4sRg9wjYr0ld31bSOS5H1GB6QCuDF/8neUaWlbrqv198VW+uC45ctsDgZessn0zT0vzMIjq7Mh
 lB6WqpuJulwwlV5v6389wS6MHR5yInlEDHla60=
X-Received: by 2002:a05:6830:6d2c:b0:7cf:e312:1acc with SMTP id
 46e09a7af769-7d140a39f03mr1954109a34.1.1768956301951; 
 Tue, 20 Jan 2026 16:45:01 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf0d8e05sm9548781a34.6.2026.01.20.16.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 16:45:01 -0800 (PST)
Date: Tue, 20 Jan 2026 18:44:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Gopinath Sekar <gopinath.sekar@oss.qualcomm.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Shmuel Leib Melamud <smelamud@redhat.com>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Sumit Garg <sumit.garg@kernel.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Subject: Re: [PATCH] watchdog: qcom: stop watchdog by default
Message-ID: <20260121004458.GR3416603@bill-the-cat>
References: <20260121003659.69305-1-casey.connolly@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="HZoMZFNuTc2YFEfy"
Content-Disposition: inline
In-Reply-To: <20260121003659.69305-1-casey.connolly@linaro.org>
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


--HZoMZFNuTc2YFEfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 01:36:51AM +0100, Casey Connolly wrote:

> Prevent the Qualcomm watchdog from autostarting and ensure it's stopped
> when the driver probed. In some cases the watchdog is left running by
> a previous bootloader stage. Disable autostart so it isn't left running
> when we boot into the OS, this behaviour can be changed by enabling
> autostart in the board defconfig.
>=20
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--HZoMZFNuTc2YFEfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaXAhhwAKCRAr4qD1Cr/k
CighAP9C9ZwnrMY1Ff8VM/LdF30eGxg0rLB0pPnF0pB/SfzwigEAjGjmN4SNVc/+
28keQ+tpRduF07v5iIFdVNdczyzC/As=
=DvS1
-----END PGP SIGNATURE-----

--HZoMZFNuTc2YFEfy--
