Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ADEE748ED
	for <u-boot@archiver.kernel.org>; Sun,  1 Oct 2023 15:55:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B64886EC6;
	Sun,  1 Oct 2023 17:55:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rc/MfJSg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265308646E; Sun,  1 Oct 2023 17:55:18 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E945586EC6
 for <u-boot@lists.denx.de>; Sun,  1 Oct 2023 17:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d862533ea85so15943346276.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 08:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696175714; x=1696780514; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=L5fMVNKDHS7PFK/f5Rwn5wqtoqk2hAoqn2hYR/uEzUs=;
 b=rc/MfJSg6NV9qcrfzC7Ik3iyqQnnzXJ95whPYEprlG38rTFHeYXfGvR9CyHFs/Xy7F
 k+bAA++ftvie/j5J025S3UEvQAnLVag3Vtcc/AIq9qpf+rNk6P2kWH2ExJ6T0wbEXpzL
 9kbT+aRTVyxD5/Yp7km86VTWYCH50T/+rkUjE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696175714; x=1696780514;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L5fMVNKDHS7PFK/f5Rwn5wqtoqk2hAoqn2hYR/uEzUs=;
 b=gHpWUZ9BQe8K3vmJfqLj1+vtd117wjy/L+4146Sc1joc63m5mzXdWre+gP8FvJ2rIR
 X2R++z8oBitMA6lIBUlGJ46fceSVErXv9rwq0+xT4wQ5gFRh5W0J+/1rrQOLtTlkvs0Z
 vlnyXhMrf9K0sRlfkV/quhqHZ9yDD1E+jdwFLIqV3Dd/YgxthvYtPCpW4IahYnh7iHBX
 mybJTRoPLPEe9PEUz7RyTPAn4dcoSy2Rikzt2wdXZsifRZ1BOXAN8cpsMkZzJtL9wcJv
 1jVqgsTvA7W5OMM2EBaLWyDY7Q9GUax8FHPcupdaAUFUuMhuBQKkzfUHkMSbsdK55c2D
 7fkQ==
X-Gm-Message-State: AOJu0YwzymPPwWgj49mcbP8HE9Q8xEdSvZEZLYLkAURU7ROGoVZM3amM
 45sHAW+0BcRbMTtJ3veJ6kfJ7Q==
X-Google-Smtp-Source: AGHT+IFi/aIFadL8m+CTfugkIPvcfJYPajW8Gv6obbSBYwOE7a7v7vSfNGBgxLQwAG/OjH7Q26zHhw==
X-Received: by 2002:a25:e6c2:0:b0:d81:504f:f886 with SMTP id
 d185-20020a25e6c2000000b00d81504ff886mr8524225ybh.13.1696175714667; 
 Sun, 01 Oct 2023 08:55:14 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-13fb-ab5b-9ebe-9b3a.res6.spectrum.com.
 [2603:6081:7b00:6400:13fb:ab5b:9ebe:9b3a])
 by smtp.gmail.com with ESMTPSA id
 b15-20020a25ae8f000000b00d7481ed7e45sm6396315ybj.56.2023.10.01.08.55.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 08:55:14 -0700 (PDT)
Date: Sun, 1 Oct 2023 11:55:12 -0400
From: Tom Rini <trini@konsulko.com>
To: Rong Tao <rtoax@foxmail.com>
Cc: Simon Glass <sjg@chromium.org>,
 Maxim Cournoyer <maxim.cournoyer@gmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Rong Tao <rongtao@cestc.cn>, open list <u-boot@lists.denx.de>
Subject: Re: [PATCH] Adjust gitignore for /build
Message-ID: <20231001155512.GB2763665@bill-the-cat>
References: <tencent_055CBAA884BC568E56211618940881653D0A@qq.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qx/AAgUxknvap8Du"
Content-Disposition: inline
In-Reply-To: <tencent_055CBAA884BC568E56211618940881653D0A@qq.com>
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


--qx/AAgUxknvap8Du
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 10:50:04AM +0800, Rong Tao wrote:

> From: Rong Tao <rongtao@cestc.cn>
>=20
> /build-* can't ignore /build.
>=20
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/next, thanks!

--=20
Tom

--qx/AAgUxknvap8Du
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUZlmAACgkQFHw5/5Y0
tyyB9Av/Yh+7LWK3GTvGUWErKcOQj65Ukcf0Bpp+dKqxie3IyY7CT8ZuARJtWkMl
RiXscJWFm1UXu3PL4PgIvcEYTCUd1bLRMEl4KOkxlFzGEnlPXdgZX1JR/wjhLWtV
MK3JIra1Khu7mDl8NH4U8VsD+nUM6CsFTBD/QXbEMm3GiSn8B66Ew6BMqEA1StQA
J7ipPzhwfPMz00iGu0ZyEKrHQ+Os1NjAfyg/omKfK7VVfYuNekUBKyehiL48leoz
vnxVug7GvCK5sfhhg4Q0mNnBTyXFGtg5OszqaxdYqbVSi4YvJXUEbpv8wrlhDjIK
TNI8tBSGUqGgnzkJGYJlEPPxT7CwFpRo2OCX0XkP5SsuAv7+Um2XK0QakgP0g8sG
6wj/B8cVl75+hKrLuVmq/zRGkXwi0d6eg+sS+keUP1EeoOgkcbDw9oFoxmPj9pSf
MsfOq6mUuWFEqh/edXVDtM359To1OBapR+eyECtWDGKy/wGS9fT+sbqdTaHoEuoW
coDGkAoN
=KO8A
-----END PGP SIGNATURE-----

--qx/AAgUxknvap8Du--
