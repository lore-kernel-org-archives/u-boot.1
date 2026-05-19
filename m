Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 837F7CD5BAB
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B9D848FC;
	Tue, 19 May 2026 18:25:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DS6vMEev";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2699E848FD; Tue, 19 May 2026 18:25:21 +0200 (CEST)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19EA080086
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:25:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x334.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso3560769a34.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779207918; x=1779812718; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zTYL9CziX2Gl52v1HfZ2BriKK9B8jnaE8XqjOCpFgeY=;
 b=DS6vMEevWCtoHS0jUD0BrrR/4jd08XNkW8kNaxSeYDSYfAsF4E3feOt0cfxJJusRCb
 z/y2+DNgC0/EEGNWZcCRp1oa2nhUAxdk+P6FHYLeTwjUNKQDYgNEqScS6irYONyWsHXJ
 JcczclWK5Ok6zv6hgLuqPM9rCuzsGQhX6+kPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207918; x=1779812718;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zTYL9CziX2Gl52v1HfZ2BriKK9B8jnaE8XqjOCpFgeY=;
 b=UldtL4PK7hLGCqH5nGe9bqsV6p85daghI0EtVJF2zAn3/SKszhEtZlUVwEEvGoRZcY
 Ptb4Bh+qPC14IT0AvkD8dv6bSWLaO+L/C1hLo+PS++JbLpppF5yJHSB4owMTfAD9WMB6
 TzdQQTVCKGRGSs40d/p4QXYM6CIWm/1NOK5Vndgvi9emWhHrfUlgfWOPFlaw2v7AKWN8
 u5r6e3ZEc0vP7WLBKPYsrw01Yob3+A2dDxvsTeziBBdYuT/gd/YTQ+lOHFZu8zw6aV9K
 2/AIwKFx00YdnxZ9Qb/FSEYgFX/gUMtP9Mmz1AVvwHr+fsR/OkdRKPFBVGEC/ATYZDwG
 43Lg==
X-Gm-Message-State: AOJu0YydV36RzFcO8/AiDDX9qdcaEzDYJPIBw0py1Yy05xBlVe0MHKoX
 t9FhiPE5eP4dw5SMiPQAGoV3W13H5DkPpm1YkvnQpMj/Dmekgdv43qgjUZN1q8NBtdo=
X-Gm-Gg: Acq92OGJLcUXCFGBoSA35hOTNfEC6vPuWb1T99ShNVYYtxvUvn8rHf56Ezn4asYntLP
 HGT5SlY6irPZfpOQZqAsIgyCeM5eKmTIIO3CLDJ9qm1aHo4e4AnyaTextz6hHbPuMoCWO5i9vyJ
 EKkN8UFMoqJhW89ER0jojSXlxHWtVVhjqFb9Aakq2UIjzmdiXBmiL5VQdZSIU2Hf1adWffbQzhK
 5QmfqOSr4kthN7BHC5JRqV6GiFsYVynDIbxiXwz7WlHZkWmvoGf1QffcL+NgOPhHDoGojgciJm6
 wx4KJh0vCf3nuq5Rg0htnx/30X/WlpWdlCZvcE6j4K4aVBdtInhnM2NyS7OPuKY5swKrSq3z4p8
 0Wg3c6e5Cuf9ozSwfZg+ZR+hvD7MDa/GZ/39p7cI/7SlMJqsqsPKRiGGa19+xjIAOPAciSfMI9q
 HuKxx/8MAXSTdDnKFzklj28IuRplf2ollM53rV7wLKCOaGQSEsYbFIMtp97Lpvsw6V3a1hABAye
 9X4K37/67g4KOhFFxghmtUdrYb5imEy5Mpg8zBYqW049znv4jcDf42c5EbR4haT2Y0ZOPJf
X-Received: by 2002:a05:6830:6515:b0:7dc:d2ad:fb29 with SMTP id
 46e09a7af769-7e4fa057c32mr13580343a34.24.1779207917822; 
 Tue, 19 May 2026 09:25:17 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b507cbesm10179971a34.0.2026.05.19.09.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:25:17 -0700 (PDT)
Date: Tue, 19 May 2026 10:25:14 -0600
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>, Peng Fan <peng.fan@nxp.com>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>,
 Kuan-Wei Chiu <visitorckw@gmail.com>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Add myself as core PCI maintainer
Message-ID: <20260519162514.GB1858239@bill-the-cat>
References: <20260519-u-boot-pci-nvme-maintainer-v1-0-363593cbbfdc@linaro.org>
 <20260519-u-boot-pci-nvme-maintainer-v1-2-363593cbbfdc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Luj1Lnw9Kj8FXl5w"
Content-Disposition: inline
In-Reply-To: <20260519-u-boot-pci-nvme-maintainer-v1-2-363593cbbfdc@linaro.org>
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


--Luj1Lnw9Kj8FXl5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 06:08:35PM +0200, Neil Armstrong wrote:

> Adding an entry for the PCI subsystem and add myself to the list
> of maintainers to review patches and maintain the PCI subsystem core
> along the ongoing work of the PCI platform maintainers.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--Luj1Lnw9Kj8FXl5w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagyO6gAKCRAr4qD1Cr/k
CgLgAP9puHqHG+cBgRAHrG4sRlV51ZknHfK6J44nq6p3q+c+AgD/bv03uwzhUIEE
iblfn1tfjhiiBE5Gl5/zdznMSOTxDgg=
=S7DQ
-----END PGP SIGNATURE-----

--Luj1Lnw9Kj8FXl5w--
