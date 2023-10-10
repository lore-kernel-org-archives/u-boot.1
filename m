Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E91CD80CB
	for <u-boot@archiver.kernel.org>; Tue, 10 Oct 2023 13:02:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7618A86E0F;
	Tue, 10 Oct 2023 14:59:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ea9+8Ywg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 078FD86D9D; Tue, 10 Oct 2023 14:59:03 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28B1E86DF6
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 14:58:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d862533ea85so6539494276.0
 for <u-boot@lists.denx.de>; Tue, 10 Oct 2023 05:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696942733; x=1697547533; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ujd0BMcSK200m4WXCLKqpyT1uQ2b5t4LNf8gLEy8Kc4=;
 b=ea9+8YwgMtliN/6M8aSsLzVJ5uMncyqCA+qYXRgJlXRd77bkf+MMpydMlu/+VHgm1X
 ewvkTBL/ghGnKR1kwbqRxIXPIqQwxuNGmji9wNVMFabaZYFwhQuknTrG8XQCNloof6EV
 D4xps9H/4hoSfrbSbK0oZkZtQ3hsGgX27sB3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696942733; x=1697547533;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ujd0BMcSK200m4WXCLKqpyT1uQ2b5t4LNf8gLEy8Kc4=;
 b=ADIjrRIFEJ1UZjC1crdE+FfOzdn4cHdkA7DbvsBjGPGr8/qZfYMBK881bQq8CBB4B5
 r99qcd49fXnG1lxeHxvFxwTYpIw06K8efl8nt+7xBF0/+oqg354Xv/24+MGGtbhf6qjW
 YZSioAUWMYIr/RohmCytKQRT+sZ9HShrl1HrKpzia5YYH9bzNbAvGvYLdSwsU2xsUb+9
 qi997juO6dorivJo3pNRB3XDFoLk8WRdPE7csL2aJzhhpFdcdMdsY1OH7cuGYn+Cf804
 9S1gquG/YAqi8xPFqTYB3HxRkA28UBkVS2pZcoOJVa5IfeW17111aC/ytQfDbrO520O4
 V44w==
X-Gm-Message-State: AOJu0YwGYE/+9LSrqDvfh1x8+c1taa91aX4j1msSWrrMn7/4luXYfbkA
 fDPrBXc0QPvTLs9dROWJrMGzBw==
X-Google-Smtp-Source: AGHT+IEJJTZ4Ks2OgTvROQWd6DMAcJAR5uFHFBrpay4F4TrFKObfVJpKmGVPtLbsddFRNqVKaVwV6w==
X-Received: by 2002:a25:bcc6:0:b0:d9a:4da4:b793 with SMTP id
 l6-20020a25bcc6000000b00d9a4da4b793mr2286173ybm.62.1696942733054; 
 Tue, 10 Oct 2023 05:58:53 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6c43-4eba-c113-e8cd.res6.spectrum.com.
 [2603:6081:7b00:6400:6c43:4eba:c113:e8cd])
 by smtp.gmail.com with ESMTPSA id
 n3-20020a254003000000b00d9a68211990sm281106yba.52.2023.10.10.05.58.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 05:58:52 -0700 (PDT)
Date: Tue, 10 Oct 2023 08:58:50 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Michal Suchanek <msuchanek@suse.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] dm: serial: fix serial_post_probe()
Message-ID: <20231010125850.GE2227687@bill-the-cat>
References: <20230929004717.37413-1-heinrich.schuchardt@canonical.com>
 <20230929004717.37413-2-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="46ypyQrB59QXXOnS"
Content-Disposition: inline
In-Reply-To: <20230929004717.37413-2-heinrich.schuchardt@canonical.com>
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


--46ypyQrB59QXXOnS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 29, 2023 at 02:47:16AM +0200, Heinrich Schuchardt wrote:

> The size of the name of a udevice is not limited.
>=20
> When setting the fixed sized name field of a stdio device we must ensure
> that the target string is NUL terminated to avoid buffer overflows.
>=20
> Fixes: 57d92753d4ca ("dm: Add a uclass for serial devices")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--46ypyQrB59QXXOnS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUlSooACgkQFHw5/5Y0
tyy7+Qv+K7huGzqIhP5OBNU3OCzcVWyR6ALJQ7p3Di1mbNVlmn7npnyuxJjXCdFB
Zw6cArnLjmhphCG5Uhwn7z73FbmnhkUAtZap9u51QWFxwBw51olbpTr15OwqzLSO
mBe5Wta/XiH7l+VzhS3axLh9Bhcs/AJIPfMvxkE2sB24kpMKhT6mB619YwIHbIid
lgA/3+vmj5yD/xf/rxDzixseqxPApJInFYkOe24ZiUSrD2tAq1tQzqMFuE/B02mx
WVI57c+g4EXDQMgeS2HTK8OMgmBHKEaUbngW2DIinaeypm81MjIYbyl9i4hO6Zni
sGzAvqyM69ltwrWWWLo5UKpvZfsSrtpuSH4R0NoabsDSCtI35U38OhYt+SxGQg+A
Ky+t/FuTAh1OGslmA7rMfMl0VofzZp3QryPQfpy0GuesZ/aUxrGGL77zr/FxVmSq
sLVqf0ZQl/f6A7bPnyQW/R3I1u1DtgqmWACLksn/K+4YX9dcdLs+dxbjlbQMswGS
VsmiqYr4
=Fh9O
-----END PGP SIGNATURE-----

--46ypyQrB59QXXOnS--
