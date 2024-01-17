Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0590FC47258
	for <u-boot@archiver.kernel.org>; Wed, 17 Jan 2024 14:26:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2BA1487B50;
	Wed, 17 Jan 2024 15:26:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Il4kzlMU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2D8787B61; Wed, 17 Jan 2024 15:26:14 +0100 (CET)
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCE6387B43
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 15:26:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-5f8cf76ef5bso100167147b3.0
 for <u-boot@lists.denx.de>; Wed, 17 Jan 2024 06:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1705501570; x=1706106370; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zizAuZSJ0zsK/7Xo/rAB4aD9eLEYRW/QOQKG35bxxzs=;
 b=Il4kzlMUnllTjVIvvDvpfSyvPUUrGBkB1rFQTQKsf0g4Pk3IRzPOs5l3mqUlNlyAMW
 ZT1JAZQuWqeydfDrCzYSXyDvyUQAXN25nv1fX0G3ie8lXjNY2cM6Nh+0BhQewYF1anga
 jKyY3YMEroieepRsIdiEHb1Tty0enL9V/7/Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705501570; x=1706106370;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zizAuZSJ0zsK/7Xo/rAB4aD9eLEYRW/QOQKG35bxxzs=;
 b=EpOtbQ6aIokGhelVi0fAo9yKTWbQk1kMeyF510MJ3skCL2QyJYEFoa88O9xiVBrQ3o
 U7eXrXkEfmCyW3V5CEJyMEgoUxe1y5W7vM9/BGa1EuIcxjKOqa66lEE4X7gkH4CCR0XY
 jAIFqHSn6hPTi5YhZZ7RP3LnvS82ngwQk40isfumrGNbv8O4KwT5DP2L0Xp4Bj+T/yt3
 ELx8iwZWEjGq6n+Erv94L8hkxhAcYpheDj3c0TqMYbl3DkuVRFDJtqW+HMz7vdMxq5Fo
 NRGOBdL1VrpEHcetbHb9EDFxj+++fTkDjdOPRPUo6gps0mdDuDLofeLj5PLAs12aOqCN
 Sikg==
X-Gm-Message-State: AOJu0Yxnk1jOthtuWT5XH9lvnbQ7muQf9jS9S0erFgGww0tGeCveeayU
 HONxjXMDqox2n8fXwdiI+aU92EMeY9dTpg==
X-Google-Smtp-Source: AGHT+IFU0ZUp1i34yTNj4v8pT7s3EH/2rBym1wXYEzUJzFOFQPOwYS1xctgX7pRS6dPjuvYHkNYeOA==
X-Received: by 2002:a81:b65b:0:b0:5ff:54db:814a with SMTP id
 h27-20020a81b65b000000b005ff54db814amr2614107ywk.61.1705501570518; 
 Wed, 17 Jan 2024 06:26:10 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1002.res6.spectrum.com.
 [2603:6081:7b00:3119::1002]) by smtp.gmail.com with ESMTPSA id
 z188-20020a0df0c5000000b005f900790763sm5915682ywe.49.2024.01.17.06.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 06:26:09 -0800 (PST)
Date: Wed, 17 Jan 2024 09:26:08 -0500
From: Tom Rini <trini@konsulko.com>
To: Love Kumar <love.kumar@amd.com>
Cc: u-boot@lists.denx.de, michal.simek@amd.com, git@xilinx.com,
 rfried.dev@gmail.com, v.v.mitrofanov@yadro.com,
 seanedmond@microsoft.com, emohandesi@linux.microsoft.com
Subject: Re: [UBOOT PATCH v4] test/py: net: Add dhcp abort test
Message-ID: <20240117142608.GH12635@bill-the-cat>
References: <dd44fc9bf39e0debc9d0bc78a5d9215bace26023.1700571693.git.love.kumar@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ioEHYQHg9CcYxh9s"
Content-Disposition: inline
In-Reply-To: <dd44fc9bf39e0debc9d0bc78a5d9215bace26023.1700571693.git.love.kumar@amd.com>
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


--ioEHYQHg9CcYxh9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 06:32:47PM +0530, Love Kumar wrote:

> Abort the dhcp request in the middle by pressing ctrl + c on u-boot
> prompt and validate the abort status.
>=20
> Signed-off-by: Love Kumar <love.kumar@amd.com>
> Reviewed-by: Tom Rini <trini@konsulko.com>

Applied to u-boot/master, thanks!

--=20
Tom

--ioEHYQHg9CcYxh9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWn430ACgkQFHw5/5Y0
tywLYgwAjLlVXPS0mreL/+NvjAms4pXs401ao5DtaPg9hQVH7GBoQTB7Lcq84bHN
c5AmtO0Gdi1cUZbNZWMhIU53RiHJHTEl7LG1m0rT1Qd+0JAa6yc1WHW1tNLK/vdJ
j0HrJAAIQ4PGHoV+YJp7AYkfHXbdozaxbZ1DV7K90JDxdz7kF8RVCv0T/x9o3QER
2lrlqm+Dwu24kn7chZNX9gO+d2slEe3QmCJXESgYPDnpS8Nnkpy5GRi03EpVVWcd
ZGg1w0y+A8TJxeNIRxwJUNLFEFDx7HY2edWVaMXtJM/8zCuVAvJf66hTIQ0FcA86
AjxdN5WVT/juy5v4IoXmddR4ISNX5vOdZehb4DEfIUfqo17WqjEV8ow7gcc4zmRB
Jo4Q5JYdhEOO7lIFE2gZ8E5xE7ag7QCPZua8XSQGUi6DDomRuIGVD2/CfN3avlRF
Wk7CHLY9HBdSZgCuNqBBragPExBWlibsPxBsOwEUvL5DCqw0AqvxLH+qfpIC8bMx
C6eSO4vr
=lpIX
-----END PGP SIGNATURE-----

--ioEHYQHg9CcYxh9s--
