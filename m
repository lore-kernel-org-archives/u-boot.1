Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D7C0C072A2
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 22:36:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9760687266;
	Wed, 15 Nov 2023 23:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mC3WCMRB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 70C7C87266; Wed, 15 Nov 2023 23:36:40 +0100 (CET)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DAF5187278
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 23:36:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6779fe2b7c6so1017876d6.0
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 14:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700087796; x=1700692596; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9Hj9sAnOVEs9bF6NPZTTzLcbeuffqlK8OVJ6DyW97no=;
 b=mC3WCMRBeEKdeoxe6Ha5L+CaHLy1W02HWQVt2Zs4frudA/v+8Mgl9jmwMO2yV7cPRF
 q8b/KQl4QzLKyhkCdHPl8ijGkyNPvada4lxHojHXSJpm5gpRv5sPPjfY4bL87jbOZNbc
 A5C7U5thQJFG72q70rCVmUZUEIQxthgazlKo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700087796; x=1700692596;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Hj9sAnOVEs9bF6NPZTTzLcbeuffqlK8OVJ6DyW97no=;
 b=g/3SOda+1nxeze+sv2zDyvDYuhK5Z0Cjc5qBExS41Pz5eS1zWxaNGGw3WeafOoJ7Wn
 MUdREjaSbHs218qgKtx5RPvnvBqQc0GkFxWqtAXfKdBIhRyEHyeMiLLmmqu3+MAgqBR8
 WN0iA1I+HL9pNVQePplawt6WGdKANHIyoY4sMCnI2VoRSbBgDJzHIBxd0MyVA121VzKn
 kXUw+GWruPAmmzu8A/0ecJVYr7nLWs4I6/uRlhYZWptQlEIYtIXKn+/t0fj052mBMpjT
 IctPWOH/kaqvGu2GrAHborkCysHXfSwH9yJx4n489z0lyvjzbxbuq+8LfZjTQKNoAgKh
 R7lQ==
X-Gm-Message-State: AOJu0YwzddIS0YrPJLqgpooyqtyWBTtw6kmQbBWuP/r3HS/f6gB4OLm+
 QK3OPd73Jt+YjmEP9Bl3jAB+lQ==
X-Google-Smtp-Source: AGHT+IEOqzk5qXtijhIZR7yTPDc/8DeSNEO58Jn6zUBea38mHgkdVZ8XHANRAVmJYX0Z94GD2ohCUQ==
X-Received: by 2002:a0c:e706:0:b0:66d:299d:e4c with SMTP id
 d6-20020a0ce706000000b0066d299d0e4cmr6549185qvn.20.1700087796698; 
 Wed, 15 Nov 2023 14:36:36 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6602-bbee-fb68-4a56.res6.spectrum.com.
 [2603:6081:7b00:6400:6602:bbee:fb68:4a56])
 by smtp.gmail.com with ESMTPSA id
 f3-20020a05620a12e300b0076e1e2d6496sm3788197qkl.104.2023.11.15.14.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Nov 2023 14:36:36 -0800 (PST)
Date: Wed, 15 Nov 2023 17:36:34 -0500
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Eddie James <eajames@linux.ibm.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>
Subject: Re: [PATCH 09/29] image: Tidy up genimg_get_kernel_addr_fit()
Message-ID: <20231115223634.GQ6601@bill-the-cat>
References: <20231112000923.73568-1-sjg@chromium.org>
 <20231112000923.73568-10-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K1CvZILb1oaalwzY"
Content-Disposition: inline
In-Reply-To: <20231112000923.73568-10-sjg@chromium.org>
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


--K1CvZILb1oaalwzY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 11, 2023 at 05:08:54PM -0700, Simon Glass wrote:

> This function does not modify its first argument, so mark it const. Also
> move the comments to the header file and expand them to provide more
> useful information.
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--K1CvZILb1oaalwzY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVVR/EACgkQFHw5/5Y0
tyxg3gv7Bey1kb2tpLjRHQlXGKVQlseZLPpsmUW7iHZ37BFCawB/v93L/nVc9vFu
463HcVrfpdGWisvygN8tLRUp/Zz3NxnTA6K5nN0HdRHfHq3rBez8O7Digc3o82UI
3Z1FXY/BVq8o0Umsr0NuQFAk9PhFi1tmEsGiJm/2FTWj8PyTzF1BCP3nSy6651Xs
QWRBKoAn+M/wM4SB/qxHE/dbZa93gSILvtr0NmkX5q3SH5JtrWdx6nCt7ry3r5BU
EuMd8a0ugzzVoOBXkoLN6GqwhQTNyRdrVw/KBmxSUpUrAA+b1FuAC1Cy7fR1JdSF
owcvLwVQ7Cq2fKBXS62OGQDvi8jctxAZB4cWDzYbYDW2VAb1Er0hdMviiw/Eoh7t
RLjsyY0YxJr5tRKsEXlmHOBTy2L9jIfxHX6GMKs33iMELlfqHddI2lc5twH2wbmy
d6TXlLSgiJdIsWQb5uX5qMvmq8NwlcvEKMQjuhy7nNO+oPg+7/U3aL306FsQanZu
F89eg7Jd
=p/ZR
-----END PGP SIGNATURE-----

--K1CvZILb1oaalwzY--
