Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FA2C44508
	for <u-boot@archiver.kernel.org>; Wed, 21 Jan 2026 17:00:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7875283015;
	Wed, 21 Jan 2026 18:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eBCBTWjJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 39A2B83946; Wed, 21 Jan 2026 18:00:26 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE48780077
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 18:00:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4801c1ad878so762405e9.1
 for <u-boot@lists.denx.de>; Wed, 21 Jan 2026 09:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1769014823; x=1769619623;
 darn=lists.denx.de; 
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TcL1LwJtGkKKoAPrTXbQ9uQZs49WcpxnkeMkQ4krOVM=;
 b=eBCBTWjJ8X56kQ8AnrDetPOn3+I9Fj7gU0FhtjArWgay8x4zKQ4hAUIUPOk8v7twM+
 2PM+Pozyh3WeddVBtEx3LhXRTLAbh7ibfSjB/7M8ZYQqLPJAY8Tr4EArIiK0H90TTvdK
 kArYaJ3B9OUgHv7XZmnGepkpPNlCpQsGTNQ68ZAINKsO2StwZglahcAg1U75QkgXwtbH
 tALL2Yoq17jsOLpAxzpZBq7Mz5ZShHGFkVyJjBv8ZEyd3wtB8M6JV2z+mDLIiorhoGFG
 HLWqvZZFweTcjn7LJqLZy+YxmzacrzeQA+WtwvTjLdFz3uhUx9Fm4IAixUJgKEqMnUd6
 WLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769014823; x=1769619623;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcL1LwJtGkKKoAPrTXbQ9uQZs49WcpxnkeMkQ4krOVM=;
 b=BSIEC8VbvHVd0oxuG0LV9Mwk/SzoTidGjCb9WhRPtzySd1sCFxrsaMJMFvkB7ed9gw
 E4KAwrr0V/P+VKNoiPfmKT8gfbdwT3Y7sI45bwPb+uSfoboG6QKpv+G0X+DbqygmWcn9
 Yt7mH+bVOi/7NpeecXF/dhyqU6i+5nOMBsRdpSPuIb54+sBATryXtFAf/yXN4DcsBPc9
 G8tTqzWakggdOeV8UzyZYzn5RNcvsNYpCgjX+893diWda9v9p4YDtX569ZRjFNrOKSQa
 Ek9KO0ou1KwJyC+4NFdauXubLwshtxxclQOaXkNNAk1T/68upDWjdG1zL1OVEhqbq0vq
 4Djg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvuV1Jk8PgeSR+y4ulTYj8kH4d9e83O2gAWlXxIS1qFLZGo0iY+X90Xrj7y3ZsdLrKdo738kI=@lists.denx.de
X-Gm-Message-State: AOJu0Yy76LzkIgzOzoxgPRnZxWus7j6fSHrGNem0Rlv0TIOPD6btb9Ue
 CFXSaD/Gy6VsixfKXol/3N/OdUS5lKzISkrjncHTNe6KGWMPEueMW9OTOnPzpa6h0os=
X-Gm-Gg: AZuq6aI6jKsPgv5URjnXnDBEE3DdNIbRxKjKv9WPPqGwljYR44tzD0dPlOhehCkHioB
 hnYIiaeZ3CGBieiMwJWQDP0flW3erZJ15+CuCq5fTZdygRccKJNhIUkgOjcgAxugUDsnVUxNGnm
 DGR+TkKrKuAjT/MiUPDlwZO8UegMPPPji9V9tkzuqWRZRa1Gm78iaPikDtk8UulL+B7YIuBYwZz
 iYl46+cXEWaE7UV246Ql4Gu/9+6872sANRLppD0h/H7MeEIp6o7/S+Kj+0ThD905iHyrA/rVawd
 13o/ngTIPi7xnI1tgye1p6rmKDYJL6SrMw+SzMkHSqSQ8d9i7Wt+MgeuEdGDpliK9sGtxNjFIcj
 GS03eTiRTKKYOPUKrLWkHTadAZ6MD+fi8zo/ZWIdzghYf+mweA/CYflG682ARfQAT6EBy288EM7
 AkAkQ=
X-Received: by 2002:a05:600c:c105:b0:480:20f1:7aa6 with SMTP id
 5b1f17b1804b1-4803e7e8586mr81174845e9.21.1769014821723; 
 Wed, 21 Jan 2026 09:00:21 -0800 (PST)
Received: from localhost ([195.52.31.202]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48042c70121sm25084975e9.19.2026.01.21.09.00.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 09:00:20 -0800 (PST)
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=d0a6276679978591e12e3338ebedcb61b1c033ed0775f42a1f3a0bf5c146;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 21 Jan 2026 18:00:01 +0100
Message-Id: <DFUFESMXOFM3.2HOK8WAVWWSLD@baylibre.com>
Cc: "Simon Glass" <sjg@chromium.org>, "Tom Rini" <trini@konsulko.com>,
 "Marek Vasut" <marex@denx.de>, "Andrew Goodbody"
 <andrew.goodbody@linaro.org>, "Kory Maincent" <kory.maincent@bootlin.com>,
 "Svyatoslav Ryhel" <clamor95@gmail.com>, "Christian Marangi"
 <ansuelsmth@gmail.com>, "Heiko Schocher" <hs@nabladev.com>, "Simon Glass"
 <simon.glass@canonical.com>
Subject: Re: [PATCH v3 3/6] dm: core: Support multiple drivers with same
 compatibles
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, "Mattijs Korpershoek"
 <mkorpershoek@kernel.org>, "Markus Schneider-Pargmann (TI.com)"
 <msp@baylibre.com>, <u-boot@lists.denx.de>
X-Mailer: aerc 0.21.0
References: <20260114-topic-musb-probing-v2026-01-v3-0-ebb8d990b9df@baylibre.com>
 <20260114-topic-musb-probing-v2026-01-v3-3-ebb8d990b9df@baylibre.com>
 <87bjitesqo.fsf@kernel.org> <0d50377b-22dc-41f9-b74f-de1cb97959c0@altera.com>
In-Reply-To: <0d50377b-22dc-41f9-b74f-de1cb97959c0@altera.com>
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

--d0a6276679978591e12e3338ebedcb61b1c033ed0775f42a1f3a0bf5c146
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Dinesh,

On Wed Jan 21, 2026 at 5:45 PM CET, Dinesh Maniyam wrote:
[...]
>>
>> Previously, we were using glue/wrapper driver to support multiple driver=
s
>> with same compatibility.
>>
>> For example:
>>
>> In this file,
>> https://source.denx.de/u-boot/u-boot/-/blob/master/drivers/usb/dwc3/dwc3=
-generic.c
>>
>> look for|dwc3_glue_bind_common, why not use the similar implementation? =
|Why does/core DM /need to know about USB role selection?
>>
>> |lists_bind_fdt()| must remain simple and predictable

I can see dwc3 seems to use the parent devicetree node to bind the glue
driver, right?

Upstream am33xx.dtsi does not have a devicetree parent node that we
could bind to. The parent is of type ti,sysc which is not USB specific.
The uboot am33xx.dtsi did have a devicetree parent that was USB specific
and it was used before to bind the USB glue. But with OF_UPSTREAM I
can't use that anymore.

This is why I developed this patch, to be able let bind() return
-ENODEV. lists_bind_fdt() will remain predictable. Most drivers do not
return -ENODEV and will not be influenced by this change.

Best
Markus

--d0a6276679978591e12e3338ebedcb61b1c033ed0775f42a1f3a0bf5c146
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaXEGERsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlOw
SgEAo9+Msfo0FuxEVh7VPuxT7IdwJkF2yrJaAjl0XSE7AUYA/A4yLL9TIDQbnLr6
0WXb1JasCqrpNHiDc33SQmLyU6UO
=vV/I
-----END PGP SIGNATURE-----

--d0a6276679978591e12e3338ebedcb61b1c033ed0775f42a1f3a0bf5c146--
