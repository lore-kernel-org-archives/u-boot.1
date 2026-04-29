Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242D4CCFA13
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 17:15:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0026848DA;
	Wed, 29 Apr 2026 19:15:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W+fCu6Nv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0403F848D7; Wed, 29 Apr 2026 19:15:19 +0200 (CEST)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87F3B848D1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 19:15:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-67929ff6dbfso34248a12.2
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777482916; cv=none;
 d=google.com; s=arc-20240605;
 b=ZmvTFlyevq/Uiy3hGnyExihqORruNhXlvfPgVO9/I/xfzj69EAW8EVLqurRT1Zj82v
 C8YMyxC+CCK/ztIlVSmIJ7m4I69Ccw07UCh05os6tz9kx4PT8JmYyfUEHTgbmhKlsbHy
 0E1ruGTcaUuUY7jHxNmONdCj82fDrmxKWq36f6HX9cLNunuJKnHmDpiN39REtASksjVL
 b5DRcNXhoqYO8oTkl4lDk2PS9IOLYCBSXWB8RcOa3xoKMoEdTPP0/J4+x9ucXMnmKwE7
 gWjTpmNN8620bYeWGHiJcgd51dJLlrwMHKjsH9ihUz25iplhEecdI9pMcv9Jh6/xaTNR
 73vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xrYVZgGt2X/jMtx5ZLzsA9yQqKFR1rwtHwv0uQy6CeI=;
 fh=+/pNFDyGYsDJMoXpsFeigOK5l3QyGzKdfAevrQne9bY=;
 b=WfyH+RuopW4qlvcLF2A3A7dTGJhoEdqo4z0vLcjp5mpB5KBvo0fIBV/rtkXiz/jq2a
 Hd84nzeMm9qWwgRxlIQcy2Tp+5TfxpRR5ZKy76YcietZtxqzdCA+d3hoDwr5S9vsRiqE
 j5hJf3apR1ESLBmvT0CEzCJNxe1d4LDyyBw5X+s2i2tDjGcJoIWQZdY4IqCpTPgrtsbM
 GhDCSlCO2GE2TUflR40P0hjsrxAJRa+S9pnAgyQihL8I7oLE5XoOn+gF2jl9iEP0VPiq
 rf5a8YqSztApLyMFmRhDIwYBtCfQNvZ0pZS/4fMQbQ1DKB2isOTtnjOUMHFyrwrlT1BT
 fgyA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777482916; x=1778087716; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xrYVZgGt2X/jMtx5ZLzsA9yQqKFR1rwtHwv0uQy6CeI=;
 b=W+fCu6NvKUJpI2IbZw8hoXzik06WjoeCxxyrZtQoM7FJVQy+MCTlfslE56qJmt8xBM
 nynln3JhQh28Ww6gCSfQvffcY+N9XILu/cXZhq3dyisCFpRwxn/pDwKkvzVYe7bRc9q1
 +HxfrzMJgYEfXrtmLGoFUEYlEh2zLUL3O6KDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777482916; x=1778087716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xrYVZgGt2X/jMtx5ZLzsA9yQqKFR1rwtHwv0uQy6CeI=;
 b=juap39P6UGUy8uVouR6zsLuGdIdyn/hkiI8nGeql4nQ6GTRVp8CH/vPyjJMsKQU70u
 a3vqYWabDPP456AZR9UuAjcLlXCJyRl8CeUNRomhIiAQK9m6bQEAwHvpICg7S5dn3UWZ
 834GGbIn0EuyH1uQfC4hilBLvCb3QSPUuJdZEdUovdjT+2TryzRTvaMGBXR0wEsxN9xU
 vVPKCCS+m1glZqnP/zrUiCvCXif1C3p4DDwO05MfLJZVJ7Cf7zQNM3jbhP1Pkb3g52sU
 9uzshcbm0c9qC8lGjl45i+b9jpr9m4FWqJQ/YySIKSW6boAh6RZZDXl/TmOSQv7UqTwK
 GyWg==
X-Gm-Message-State: AOJu0YwCPyLCBNHlxisA4qgtSdPWNxFgQY6N32ncmgF6n5nu0F7Zlrym
 WofUTVc4WN2v9mc6OGMYTVLsJUyhdcEO9syaVC15/sLp6ZD5vOm1+iNU4D5BMQaSEYPDP5ssttj
 YVwAczMxNJtEKwmFW4otmqwwPOJiDrt5cfEEg/R/A
X-Gm-Gg: AeBDiev0+az0jtCw2tM5gGNGTTvVJzqTeddvTmnGT8UW5QcHa7S8d6NcrsyCNEzlUyb
 shButZDBFGuDdP3c9Y1ciSv37gJytp2NYq8y2D7MvcM1ldLQ0lzJ9DGg2rqHfC9E75cvySkln2v
 Q86CMggXY/qAXiZo0IUTab9c/AdSN0Eg9iDfMAMWdz10B1NsLVM49GJXZ+9dsubl1kGMmcYyHkq
 q8zG45653drSAy/T3nbujZaal7dERdDOruSMlIIU8jZIiORbkn3hPzq65xt/5kI9RTIkoOMTrqO
 KcIoRIM2qrr9jQXWaEITmN5smQPUiLr6AUYzDapP3C0SpD3ri+p8
X-Received: by 2002:a17:907:1c98:b0:b9d:6d06:b78a with SMTP id
 a640c23a62f3a-bb93ce8c877mr297571166b.17.1777482915920; Wed, 29 Apr 2026
 10:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260429-sys_rx_eth_buffer-no-net-v1-0-396ef37ae93c@cherry.de>
 <20260429-sys_rx_eth_buffer-no-net-v1-2-396ef37ae93c@cherry.de>
In-Reply-To: <20260429-sys_rx_eth_buffer-no-net-v1-2-396ef37ae93c@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 30 Apr 2026 05:15:00 +1200
X-Gm-Features: AVHnY4K2zwGjjubQ9IV6nPv1OPmWRY8mNQTB7yQHX_ICa0JIOgUteOy3648-fmg
Message-ID: <CAFLszTgrCEuPBsqfRREZ_qeH69e9Bf9MmGJetC3HJbfqnHGU-Q@mail.gmail.com>
Subject: Re: [PATCH RFC next 2/5] arm: ls102xa: use platform data to check
 Ethernet interface is not SGMII
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tang Yuantian <andy.tang@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Fabio Estevam <festevam@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Benjamin Hahn <B.Hahn@phytec.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-04-29T10:35:00, Quentin Schulz <foss+uboot@0leil.net> wrote:
> arm: ls102xa: use platform data to check Ethernet interface is not SGMII
>
> tsec_private should, as its name suggests, be private. In the next
> commit, it'll be moved from a publicly available header file to the C
> file that requires it. ls102xa currently does not allow us to do that
> because it uses the structure.
>
> The flag is actually set if the Ethernet PHY interface is SGMII in
> drivers/net/tsec.c, so simply replace the current check with the same
> check made in drivers/net/tsec.c to set the flag.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> arch/arm/cpu/armv7/ls102xa/fdt.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
