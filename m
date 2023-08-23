Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92E7EEE49A3
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:43:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56076864D2;
	Wed, 23 Aug 2023 16:42:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IKW2S7vK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 598ED86467; Wed, 23 Aug 2023 16:42:20 +0200 (CEST)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C50B86403
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-d77ad095e5cso1227041276.0
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801737; x=1693406537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mQ/S1dCHaD2a+Tp49SxYwVU5F7nzXTF0K5lDqQ8/qEU=;
 b=IKW2S7vKWk/n8CB+yeo6OH9VfK7T5CFYgQL/OpEnjfq1WNcYPAxj2DIe0jpGOnJUjG
 ZD59tZ6C/61k97l048g23qstO3efjIhvckrxCiBCnbFjS9V62jUW+5uM/x0DdnX/Xij9
 y84CJJSwyQi6wHnXMQ23b+x5sAk/2dfVZZlOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801737; x=1693406537;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mQ/S1dCHaD2a+Tp49SxYwVU5F7nzXTF0K5lDqQ8/qEU=;
 b=ImOzthonqID/evkAjkTZNBAKUD9NyniPDJN1rPY8JoZ6V/z7Vnwbkz4REE0/QTKilr
 frQmAxRjyOi426VFi/3E4kQ++sgJIRQCEKmBUJZbI6hsRngjvlGPg6z1aloRyROQP7pr
 AUQGM1YlyHK0Sc4+1qGqmO0/KGe6qoTcRZU6fbHlDdV2jGIOzM5uI/DBj8aDuwmjFlqp
 lmZLBvHItErO+OAipvL/lT9pKHcTTvGaq3Kd69O0QhbuiMNfw26h0ZDtk/ttvIsw934X
 p6ar3Z3hULSaEZTusHx/d060uvYrbem2TP/gWs2ps2/DQ6TtBRqG3hWB8sSBVgmd6Zz7
 6moA==
X-Gm-Message-State: AOJu0YwqZBbEIoxH//nEeY9JMaeK8uNF9tkHsoIb1ylV75i42E3/POo1
 tNt74st1gP8+sovqchHn+hz/7Q==
X-Google-Smtp-Source: AGHT+IEJmJbbxkbI8RJQArfiSOglQbzDMRGECbBeQwbch+rBnhA2AQYa6wP7rErJ1RgcAybBq+iwmA==
X-Received: by 2002:a0d:d452:0:b0:56d:2e22:8b31 with SMTP id
 w79-20020a0dd452000000b0056d2e228b31mr13622217ywd.41.1692801737026; 
 Wed, 23 Aug 2023 07:42:17 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 a186-20020a0df1c3000000b005840861b15fsm3370727ywf.13.2023.08.23.07.42.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:42:16 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:42:14 -0400
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glplk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Michal Suchanek <msuchanek@suse.de>, Simon Glass <sjg@chromium.org>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 4/8] disk: Handle partition to block device offset
 conversion
Message-ID: <20230823144214.GV3953269@bill-the-cat>
References: <20230813234648.591083-1-marek.vasut+renesas@mailbox.org>
 <20230813234648.591083-4-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kO+IIpy98WGMVQVr"
Content-Disposition: inline
In-Reply-To: <20230813234648.591083-4-marek.vasut+renesas@mailbox.org>
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


--kO+IIpy98WGMVQVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2023 at 01:46:44AM +0200, Marek Vasut wrote:

> Convert the read/write/erase offset from one within a partition
> to one within a block device, to correctly access the data on
> the block device for both write and erase operations.
>=20
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Applied to u-boot/next, thanks!

--=20
Tom

--kO+IIpy98WGMVQVr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGsYACgkQFHw5/5Y0
tyz3gQwAp5XeUXruON68S0PErErMw35Bf5nh7+Rg+etfkGLSjMVhQJ0sqrLPt0f9
UY4VV4iWtFU4wVqNFHW3pTT0q/NKsK3Mplw2LTnVyIeTYfLGr+cLTUBeiW1sMYQ9
muDdcnbDP+HjqMyas6CbQeC753KMTf+Mbtn07Gph9Ivd5f/WZF8UaKJFrnEPruDN
GjZ93szPgaSrbTnBV9AqmFo8EdC8qRzkloHMbW4IRHjmOxAWbUx/TPTpo3S8ilDy
0DSgM/kyPe4dxrvQ6GR2AivsO6/2YZ1JzBr1nG/wojxZtcr22WIl9asC73kks8BD
Cf/yPl3RowELEI7QPvKZGKNG4+2ym3UNo4bPyBZcq/drOYwB0rOlc6ozxl4KMurL
q3JlX0jLJ2t8JCI8vRAgAjnq0K/9rWZDiNwPHOMJqVVCEvSZphXROv6dF4jObPhb
XI7NiwJfOb7VJcN5I7Zn6+f4VO5jka7r2n9QiNLmNdDh41U+B3ySEy+un4jTPhCb
//uy7/m3
=9MhP
-----END PGP SIGNATURE-----

--kO+IIpy98WGMVQVr--
