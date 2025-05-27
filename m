Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842C6C54F30
	for <u-boot@archiver.kernel.org>; Tue, 27 May 2025 13:33:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E7CF83898;
	Tue, 27 May 2025 15:32:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="fC8uzl4a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0456838A3; Tue, 27 May 2025 15:32:57 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FF3A8384E
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 15:32:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-2c76a1b574cso906646fac.2
 for <u-boot@lists.denx.de>; Tue, 27 May 2025 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748352774; x=1748957574; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kMkvsEG9dv5wbRhNRl0bOVJ7xa4uw1ZJ7T6+beiF/38=;
 b=fC8uzl4aemscJjmWtQ5UOyxFZ/Kv7zDSQA/Nw/w9V2whN4/g0SRXtpl5Mn6D9M/i71
 gn5kFWCkSZR0mJW9BCLCHubFveaZ/9b3VpX3pP3JU/0VjZwyhc1lmWDthHSUdyvH0c/n
 GJ7csyarPulsjCGZRxYTQ89qbG8jI77brlIaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748352774; x=1748957574;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMkvsEG9dv5wbRhNRl0bOVJ7xa4uw1ZJ7T6+beiF/38=;
 b=rbRbSkzoueZXDQPqBG3y3bWiUIdQkABN/HNx7Rrg5t/3yqY2R+Du9F+MnrMInP7pf3
 H9dAr0Bh3Ft6eTvnKm26FAGWqkqZz8DPEnssrHw8tQW68qT2oszdo41cZQ385zex9qQV
 JrCWILGk3FUjXWp7WyiJk6ZFppNvbJmUD8slDPxY1qZgFd2mwWAXRD4t8Gt3EQLBVIXv
 1Ip5wm+MqSD3LBerkQTWbstB/PBPFPTB5HeaX6tXGTFxhS4n2E4EuEx1MM4Ttq9e7FOL
 LRENs24Iye6qmp7Pe2BhPhMCXAKCdWEDIXYD/iqhZcfLzguQzRCNuOxlta+NCgTToLra
 KHYw==
X-Gm-Message-State: AOJu0Yxiv9QUlK2YtaCscjty9Ao8zKnRjtseyU0srFijtZM2qF5muy1h
 YWmHaF7XE4cEr2FRvgWzkjwGAhkj6hYQs1rsnZB3d106CjDX7WkKo/iNwCoBnVYo/A4=
X-Gm-Gg: ASbGncuWq5/91jblY480GXgIG8moTwK9QYwz68cjmwgkoLKfNC3gxCQpGSr4J5jmNwy
 oDrdunApiVOmPAHGuz14mB0aYMiWA8HHO1/ecraHOdnJAyPzv7T2OEya6dhYe4Qm5mtGlcNLlTc
 eLaweIJkU21kcRShFYSfmH45ES/lVIIjzNUQZPByraCNuRU4OPGZLmBYyf+WLIHhDAbWgQZwyr2
 qKAl1c2etoPPX+WxMZUpf4RDtg8ZOX0W7CprCSWQTo4/5U/zmzdoy4gZ4a27NZXQt0PC8cwUPYZ
 HUOLaDqe8OLIZekqsfDg74R29LaSk+yAIt3e97BVf6PTifq5qWAOYDKRKsHEnUGHiUt/7NvE/9G
 EBcqmEGDd9OkY
X-Google-Smtp-Source: AGHT+IHx9pLSTwfipGNRqiu63LrB9JTyjfMrXfgajmBJ2VkccisJVMLUY4pLKlADby7VQAdoFxFmUw==
X-Received: by 2002:a05:6871:a482:b0:29e:766d:e969 with SMTP id
 586e51a60fabf-2e861e5f2damr7256953fac.10.1748352773783; 
 Tue, 27 May 2025 06:32:53 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e3c06b0b3csm5293200fac.14.2025.05.27.06.32.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 06:32:52 -0700 (PDT)
Date: Tue, 27 May 2025 07:32:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Bin Meng <bmeng.cn@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Eddie James <eajames@linux.ibm.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Huan Wang <alison.wang@nxp.com>, Janne Grunau <j@jannau.net>,
 Julien Masson <jmasson@baylibre.com>, Leo <ycliang@andestech.com>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Maxim Moskalets <maximmosk4@gmail.com>,
 Michal Simek <michal.simek@amd.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Rick Chen <rick@andestech.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Thomas Chou <thomas@wytron.com.tw>, uboot-snps-arc@synopsys.com
Subject: Re: [PATCH 1/2] bootm: Shorten BOOTM_STATE_
Message-ID: <20250527133249.GH100073@bill-the-cat>
References: <20250527124038.3633270-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4SVnrQwPyGv8Nr9J"
Content-Disposition: inline
In-Reply-To: <20250527124038.3633270-1-sjg@chromium.org>
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


--4SVnrQwPyGv8Nr9J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 27, 2025 at 06:40:34AM -0600, Simon Glass wrote:

> This is quite long at present. Rename it so that fixes better with the
> bootstd naming.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

First of all, sigh, this doesn't apply to mainline. After the last few
days, that starts to feel like bad faith on your part. Second, I feel
like this reduces code clarity. I'm not rejecting the concept, but
shorten + document doesn't feel as useful as "document". Finally, what
"bootstd naming" does this better fit with?

--=20
Tom

--4SVnrQwPyGv8Nr9J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg1vv0ACgkQFHw5/5Y0
tywgqAv+M7boRcNTa2sB5trp3KtBtBoeDR0eX8FthUFPsrZCv3v4ImDqTG8zibnJ
JyGG6Xg92Tmz48Q3ltQLR1znOS7e3aCqSday44vm1Jk2leRd/yN6kqyrmN4r3dmp
4xMP+3l/lcH/Z0CgQB2Lp9cHAFhqgsIP+2YuwTznSFNt/ayinX5OtAtvdXaFF3cH
hMs0XsbaKYlluBGxcqLz+nI9G/zUQdTQPqbAkfo9bWdW6DUgm6MRSHHX/VI8bSdj
QE6n+Z5A50J6fa0f9FThchRGjOiGb4UMvTyl4s8ZXKb//su0xWsvMkJH6Ywe7e8G
vwRfZWKChIsTIyvXpQ5eynl9ixC25DKJwVg43RGdGQPaQE3CUasP3dbSQPAK6Utc
MlG3BtAriDqEhNl5FC6bE4Mx2nOsnnFIhik0ZJiUJmyBjqhFbsiJpZ7RFuKkAo7/
XOtgNR74JkVzFzfI2IB79PDJAEUH8mI33/nTmKJdqAaNGaSs6DPuGZEy8LXFb0vB
ZM4Guud7
=qmmR
-----END PGP SIGNATURE-----

--4SVnrQwPyGv8Nr9J--
