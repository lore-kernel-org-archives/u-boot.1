Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E643C27C5E
	for <u-boot@archiver.kernel.org>; Mon, 10 Jun 2024 17:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90FE688677;
	Mon, 10 Jun 2024 19:31:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GwdrAve9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D23148867B; Mon, 10 Jun 2024 19:31:04 +0200 (CEST)
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com
 [IPv6:2001:4860:4864:20::31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B7C388676
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 19:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-25488f4e55aso1265040fac.0
 for <u-boot@lists.denx.de>; Mon, 10 Jun 2024 10:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718040661; x=1718645461; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FcSv+2rzJQpzFinV+7T7MiU8JDdwQCzIlg1nUHNXI74=;
 b=GwdrAve9Fx5TAs9wIXBuquSLLmZ4uVp57OEmRlzMnb1b8AAR6sLQ2HakTk5VbkDfrv
 JhSblb5JG+FAlEx2/Sxh5iXTaLPOqjAhs4Co/XxabZ/NG6C7Kwo3BxY7YW5Fb/17sb61
 vPO3VTI741WsiraBpHYfXiY7jHfXKSrWk6sHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718040661; x=1718645461;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcSv+2rzJQpzFinV+7T7MiU8JDdwQCzIlg1nUHNXI74=;
 b=O6GbNSz6uyHu08tVw8wEn2k3bCKCNu93VPnIaHwzkTc0MI7pD1SWDZxSYplKSL1oxo
 dT/pESiRfiNVFdMNYI8O6DPtrfquw8QrIvBuhETmwjZIPmwcDYKfcBGQ+lgxxiWLn9WL
 A/WcdWneOHw0bX33VUlw4ZGakxQ78xu6drmjhePMq7SMQoFmbp+S16C2S7E/lZKC/PX7
 WswjvBX7WCJg+rCdlXsKk0XNvJ+RIihX0EZejMAYDudaBzadxewaz/MQTOhhSYWnyKdo
 5J7huSo/EvK4z5DT9KpJHeyns8RCEqELF+YsmUeJ79a0WlsT13731ztRrUJFd1wwecjn
 89QA==
X-Gm-Message-State: AOJu0YzVtLh6NyDJ1n4CbemYSTWNBe6qw6PW6zGRhwA3CVH0Nt73coY8
 SItMDLZ/oK0+00+DUFGRbzHKVNrxl3Zr04pNtSwsH0Yp4m+LH2/1RUuOGYDQDuw=
X-Google-Smtp-Source: AGHT+IGAg7GHqUwELsnzKWyXmkcrMQ3dllm2acgU6IM9gFY75KVTS6mX+peHuwxIBSL6/lfATYSCew==
X-Received: by 2002:a05:6870:224c:b0:254:c3d7:fbeb with SMTP id
 586e51a60fabf-254c3d8015dmr4428387fac.13.1718040660698; 
 Mon, 10 Jun 2024 10:31:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254b3372725sm894282fac.14.2024.06.10.10.30.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 10:31:00 -0700 (PDT)
Date: Mon, 10 Jun 2024 11:30:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 07/31] lmb: remove lmb_init_and_reserve_range()
 function
Message-ID: <20240610173058.GV68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-8-sughosh.ganu@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="p0ExwflMJGTvAJO6"
Content-Disposition: inline
In-Reply-To: <20240607185240.1892031-8-sughosh.ganu@linaro.org>
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


--p0ExwflMJGTvAJO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 08, 2024 at 12:22:16AM +0530, Sughosh Ganu wrote:

> With the move to make the LMB allocations persistent and the common
> memory regions being reserved during board init, the
> lmb_init_and_reserve_range() API can be replaced with a simple
> lmb_add() call.
>=20
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--p0ExwflMJGTvAJO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZnOFEACgkQFHw5/5Y0
tyyhGgv7Ba5DVUW75B0OPar4qIKM0l6aWEXSt/oSVEcXgYQMIr1/5DuXWHBfXqGG
jFiBYQT5CzxYGuURxVKK+bB/Hv2Y66GowHJfCjTh02km7lrvJFBACkDMiKgcbpNm
05V3UCMPQuLYC7rKByoK2QwkyOkpOdC9DPV/ntZ921xk7d5oeZjVGPciWhHyuD94
rv+MZAeEgltomq7fLZcGofiWcRr4+4jpuE2KmI3f2xVrHx6LnIj8TUvHv9MnRbfY
zsIphcizhIhojq/rprX+pF4hVyi/T0uVNWksgSDKq/GH6SKGhkg28FJd5eB8+sJ/
sV11rkpm4hDIPk8uBmgZ9uMkmkFrjh6N+q1K1LQgB6CmMeEMoOojvfBic4AEOewf
LwD2sFFF2vPViAuxz+ktVCPWtLq9yGdrJarRpw8Fycehv5wjixS5NgS5Nr4m4hf9
yhyEnKWXJfY8g7Pb+s/XRbSbQ3hs5D0tcAiK8BH8eT6dJBmquUp4kO650AZsqXYX
YvAUVs/v
=0iEg
-----END PGP SIGNATURE-----

--p0ExwflMJGTvAJO6--
