Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340D8CD4F3C
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 16:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A9E5D848F3;
	Tue, 19 May 2026 18:25:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gp5cFpc4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25CD680086; Tue, 19 May 2026 18:25:09 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15B65848FB
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 18:25:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-464bba3a9easo2419418b6e.0
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 09:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779207906; x=1779812706; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=j4RFN6HZ501FsMimVqty4mE+A2aSaU3m4XKByC/NYQE=;
 b=gp5cFpc4N8M1w1d5lRjcgLc8UavO0kMWh32ouS6OEANLwqw6uA/bOgTqO+c7j7lr2I
 UD/Wg3+LpjBygtfuXNZKotoWkNFm+YhmM7dhikaC3k6/csy16QYds5jbeoWwwQf8gPr6
 xJprJ7h48fbwY/PjUQgtQ2RheI1ocEKQzi6Ko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207906; x=1779812706;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j4RFN6HZ501FsMimVqty4mE+A2aSaU3m4XKByC/NYQE=;
 b=ky2eI3iRkGmR+buWMTw276go8zOOXJ8t1q70ZiaqroJFGdLp28k1CaR2ZhpnfiPfpM
 e68SLNmcAY2rbyHOgphBCVWdptyAiHdsqf9aEmB83OK/3GGcoTNNN8Z2/ReU1amvP8on
 PLl5Sokd5Qk9wgFMvy++Ol6ChZivxtIQQWgEGAGYRt9oZSdcs6GS0AxKmZ0zHL1u7tc+
 Oqinl/PrBqG1fuc3EIVr6XA9pw+3wvtIJHMdPqeBVt08Q/81heQcOB2wcY1ETrS2f4g0
 kqQGhwzxWMosRjlz+pKf6GO8IFGPAJkhqk3hMimNpGANVzkcngTAF/GVPwJnTVreL3il
 gQ2w==
X-Gm-Message-State: AOJu0Yzxe7wphyXuY6R28jZB9X/9zMdagTd+WNXTZdnx5IPXC0lF2ZHN
 101In6j9NAmBKycY3kfZ+e2YCrIg1LfpgysPPL1M8cfOl6zXitCe0hIKYTdQrGeWfB8=
X-Gm-Gg: Acq92OF7Vy7qXg55bi6tklFvBZHouRTvElUrPrDELm7bPUweXJt4MX0u0WwuMa7QHSe
 9HLhDK3cnQQg1QpxzyfIkgjhQZRO3GzNoOqrNzEUsQ+IV9SV0X7whGop80Dm8SuRLO5XxXDMZbB
 gnsZeRqxq89YiwgPg2u7fjonaP13EyvRkrUW+ALKs75bNwitYtk4fZAI7tqi58HUG/QZjnEilHV
 /ZKCbWNeOopxXfdChakNcXgfiTzIKW5+bSDG3W2EWUlc6KLOHXxIqNcCKcPtkHAfN/uPPwreprr
 smzBrLyWH48TEcJutAL7H/ITqSzXHzk+LVqahkUTkBGf6jnxDfgCmG0G6xyX5OF6TA9vHcnC+9f
 k99gMbAk063lTH2sTTqZ5jmdecGqwaNqsDXk+q3uhVLpHt+nHHzlscpevqqb+onUDdxAl8Gtirr
 mVQKg9vjPTEoNXx9ptFhMX21LVB0ceipRWzVDwgYBoTMlFTNARVMdgn0wU1omdN1Lt3yHfJ4yGe
 w9e0sGeGUAJxMXE3Y9UIzwTsYj6/KrYdG5Tr6eYfGDOncq0n1I=
X-Received: by 2002:a05:6808:c177:b0:47a:14bd:6a11 with SMTP id
 5614622812f47-482e5747272mr13358016b6e.13.1779207905770; 
 Tue, 19 May 2026 09:25:05 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bbd0bd6sm10273223a34.13.2026.05.19.09.25.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 09:25:05 -0700 (PDT)
Date: Tue, 19 May 2026 10:25:02 -0600
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
Subject: Re: [PATCH 1/2] MAINTAINERS: Add myself to the list of NVMe
 maintainers
Message-ID: <20260519162502.GA1858239@bill-the-cat>
References: <20260519-u-boot-pci-nvme-maintainer-v1-0-363593cbbfdc@linaro.org>
 <20260519-u-boot-pci-nvme-maintainer-v1-1-363593cbbfdc@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xc+c4X0HRD8ixGgF"
Content-Disposition: inline
In-Reply-To: <20260519-u-boot-pci-nvme-maintainer-v1-1-363593cbbfdc@linaro.org>
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


--xc+c4X0HRD8ixGgF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 06:08:34PM +0200, Neil Armstrong wrote:

> Adding myself to continue Bin's work to help maintain the
> NVMe support in U-boot.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Acked-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--xc+c4X0HRD8ixGgF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagyO1gAKCRAr4qD1Cr/k
CjMFAQCL3CAK47zv8cnzOiJjAUdoSgzTD45vZjKMhwZQt63hxQEA5h7GNOZMq6vI
8mUW9JDTjQg1xl1PW9OVOwy0o9p08gk=
=+OEk
-----END PGP SIGNATURE-----

--xc+c4X0HRD8ixGgF--
