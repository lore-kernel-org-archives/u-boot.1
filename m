Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356CBE77173
	for <u-boot@archiver.kernel.org>; Fri,  6 Dec 2024 17:07:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F9989620;
	Fri,  6 Dec 2024 18:07:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YQ7DjE1o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB8D189622; Fri,  6 Dec 2024 18:07:23 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC5BB89616
 for <u-boot@lists.denx.de>; Fri,  6 Dec 2024 18:07:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4668983b04eso16606131cf.1
 for <u-boot@lists.denx.de>; Fri, 06 Dec 2024 09:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733504840; x=1734109640; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JiS0fYDoCZBvlHutqrxcvqlxZr+1vCz8QzMdaRHWWpg=;
 b=YQ7DjE1oqlro2V/ztOJMpuMn/wpYPm46COd6fQcYD8lDjvLjLRIR/q7NDZikObeXGx
 bnwRufBumRtJtohs5/Z9qAreyUlFBlH9IprttmDCttVhueA6v017ync3mWGGcKtsibRB
 v5pH0oIJS1AlLtNIyuiO86n46zk2jHZcrbVB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733504840; x=1734109640;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiS0fYDoCZBvlHutqrxcvqlxZr+1vCz8QzMdaRHWWpg=;
 b=tInRCVk1WSltqusU/DINR/bFnW0Ym/Eh/UOxw/YKG+sQxxaXD+tRkotgKdAyOmuOzO
 1QxUsN6XMOuS7b6G6cRSYd1iC3bGrGcWDgQWwKVTCH792G1SUu1mSG0JLmRaFnh/iMfb
 +ITFW4u8ojJMjyIErwqC/2HkCZc74EGR/FeFMxz8PbZp5QBk+zDRW2hESy9QQO+D1ofK
 ZZfZ/v7sbxUNma0/bqMz5Rf1zi674Y7FPa0r8VYm0yi3SFhho0zOk0i7JGPaWAEO15VC
 fZZUSPtbGX0/2sZOR6ZlJPD9c4YvQxsPI/E0XVRXjnb+vIWE6JlrvFDA6g6FdwaXxQqK
 nInA==
X-Gm-Message-State: AOJu0YxrwU8ZR8KXisWMAPPXDYAyzG8hftNHw9HmJ/VfAxahwuMPLwvh
 50LOTsblwBhTojpVYGddNSNxfyDLIqRC7mGT+tHeNS8S0NtZmRgxUjD0G8mq3nI=
X-Gm-Gg: ASbGncvpAkJ6R89iWI9q/YdDA1bdjpRVa5b5JvqRBniOMYm/HfATzTLAIS9CNh2cm3g
 ILWIawmdCHTkCzdZPRVAE2dQd5/zj8Spcfi4zQDejbIgy4FLdkUVWsXPgmO9q5CflzP1kG+bLgW
 lIhxeAJvYLfTZDISfPkmXkkO1XlHk7zykY8uWHSktqPzmkNSHVnYvY6YLbKF/ZDK86W9uekskZ/
 XLRWjSSOELsCso5bIwdWiotcx2UmRW6fsiZsKt+JZ++r1fK5Q==
X-Google-Smtp-Source: AGHT+IGT1wC38TKN9xuXyKNsn0gnCyG8fYIVya95fmh41RcRcIunRyez2D8lu4If1FDTDA58hX3ykw==
X-Received: by 2002:a05:622a:34b:b0:466:a0e2:ae8e with SMTP id
 d75a77b69052e-46734cc233bmr45622641cf.9.1733504839750; 
 Fri, 06 Dec 2024 09:07:19 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-467297d6bb5sm22893171cf.85.2024.12.06.09.07.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Dec 2024 09:07:18 -0800 (PST)
Date: Fri, 6 Dec 2024 11:07:16 -0600
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH] trace: add support for "trace clear"
Message-ID: <20241206170716.GU2457179@bill-the-cat>
References: <20241206102917.1095207-1-jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="SWfs9umV8Nmq1c8n"
Content-Disposition: inline
In-Reply-To: <20241206102917.1095207-1-jerome.forissier@linaro.org>
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


--SWfs9umV8Nmq1c8n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 06, 2024 at 11:29:16AM +0100, Jerome Forissier wrote:

> Implement a "trace clear" command to delete the currently accumulated
> trace data. This comes handy when someone needs to trace a particular
> command. For example:
>=20
>   =3D> trace clear; dhcp; trace pause
>   =3D> trace stats
>   =3D> trace calls 0x02100000 0x10000000
>   =3D> tftpput $profbase $profoffset 192.168.0.16:trace.bin
>=20
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  cmd/trace.c     | 13 ++++++++++++-
>  include/trace.h |  2 ++
>  lib/trace.c     | 47 +++++++++++++++++++++++++++++++++--------------
>  3 files changed, 47 insertions(+), 15 deletions(-)

We have trace tests already, can they easily be expanded to cover this?

--=20
Tom

--SWfs9umV8Nmq1c8n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdTLzwACgkQFHw5/5Y0
tywBRgv/V96Oz2kseG8q6BKRRfjM+8WSR+SRaGLpZVm6NuHSv67BDnvtpw413u33
zyjIGC2V1rlCjz4XQi4WkKwQCyk2IwyW/7e59GAvTuUoNRIWArBvjpHmDY6M9I3S
uKN+YJb4U9dFPbP2Z+9WlCUR5RLE90d/HPuB0//qVA6dCfOKX4nAO3GSadrFM7yh
OG44pd4Kd6mBDbFsWjNg9DuE+z7u6EMr/ANVtaiPpQOwjeg1O3ubrrbZXAW/fekb
p8on3/B4kWpE7yL2iyv4oL9+pQzCesf03FRD9ms56ifYoG9E1oq5/yqU7CmTFWJ2
uTv4w/0j2BZvDL8Pvb9IQ10kwiNgL5ZnFw+mAuLaLJohyzBJDPO1Z1h/WFewlMrV
o841jHo1EVHLMUM4efSEp1ist2skUR27Ad43LFVSRnWaRgriLD9MH6r15F3MFP5s
WHMT9+CWuMP2csdoVm+5Ig4xnFQTIlqIz5lw+v8rxWnPDCNvq2PFrk5ZNL3f4+Md
UIcGtALu
=4dfF
-----END PGP SIGNATURE-----

--SWfs9umV8Nmq1c8n--
