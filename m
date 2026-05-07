Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACE4BCD3439
	for <u-boot@archiver.kernel.org>; Thu,  7 May 2026 15:31:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B54C84A79;
	Thu,  7 May 2026 17:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SBjwGVPT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A27C284A79; Thu,  7 May 2026 17:31:38 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F08584A44
 for <u-boot@lists.denx.de>; Thu,  7 May 2026 17:31:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b8f9568e074so162762066b.0
 for <u-boot@lists.denx.de>; Thu, 07 May 2026 08:31:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778167895; cv=none;
 d=google.com; s=arc-20240605;
 b=YcMuJNRQGx16v0l0nhWV1aQkqrX2Rsgq2ABGxkJRzmeFNGc8xloLWSzlLvEgmTln69
 Bu2M1MY5GlXU1Fitt4WhGIGiSZtmh8uPKn7pXq0oVaLyIQo8J3G2o/J/sk8Vv9EABgT1
 257HoEU878BOvZ4pt1ZTqPx3kOHj8s8Vxx/9MfQi/fSB+sMeFUM/Uu+W8RBO8zKFK+9Y
 YjCD/HUUSdekDssLhM7FtPdS1bThF2/u3KYugoYvMATN78OZs5iLpepbblWXx/w71Twp
 ghEMMKmrqqA2wdMesAso/Lgbrro64RM3B4Opb4xUkAGmNqOLA/B7ZsQZ6bvvVAXrB6FW
 g83Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=frjowt3YYZqI78587FqTHBkWz3F7l0uhhmktBa0IRf0=;
 fh=M/lZEnF34LIG38+i99c9W2rWsmaNqXfiyfyEZUkcoOI=;
 b=Pl2D0GGP5XwMA4VaXNmShKRA+eD/+urcgfq9ciVPAeVaUZ8iOrsqLag26YZ4AEbQIy
 VU3MbIPwA0UXwEbPkTWZqeS95O+6Ixhq0SqNHNzC2iphMo7UaKM3JY+qyunCnH41QGq1
 1QgayAbZDabRODwNaFNbIEGnSBFmYajnxYQE9+ZTxwXvWs85PGGeWhxNwuQCIRg1WS6c
 PUDu53hR0Yz5T8PYEpDGPKVf37WhiXdKSc7ixUy/pSuh6zNLyYZSBREx9B867pJ4JpmC
 XdKJUAt6WbXRx61RYZtdEKX9+R71pobyGN69uDVHBnQ4Sklgly6zp3gS8emH54iuttnZ
 i0TA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778167895; x=1778772695; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=frjowt3YYZqI78587FqTHBkWz3F7l0uhhmktBa0IRf0=;
 b=SBjwGVPTxIKH8kgA3A5c2NlnOrkD6MrucBA6Zq9bXix9noCvht+7+iFA+Ufl04MeBm
 PEddTM3ts8H+hIcP8ARuOGRfkqTyOGhPSmM36j9AC19orvG8EjsEu9RI3FBYd+EmGo/O
 rn/6M2Qx6dY0KpttLwPbjYdltfXxzFisM2IWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778167895; x=1778772695;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=frjowt3YYZqI78587FqTHBkWz3F7l0uhhmktBa0IRf0=;
 b=pR76dLTdu3aaVB+jeozeACj+p73bFc5jLD8kjrh+G16w1GyR9qtkl8/uIARxIAdB0k
 Ymx8U9W4bgZ2mFYG1tGwOkX6sd4upcQqy/puLWWqLvYQ6siArJORKaBN5fQmTPeXRF4w
 UXQsIRmd6ng+1nHddwHw20cWD94L8f8wWOr+YgjmhoPcYkp237X2XyZR6I2UlPxkKCnr
 uoU0Rkrw7/3RydKotmqUijTKEzuqfoqlCQ9lUll7fDW2FYtvGMquieTlSWTsB9P5/Nqv
 0LxPZYNYnOV8LugA89/7UDYyQP+YbJCt1CKqFv1JEF2kkU4RXFOp7DT6Pj/4rgV/JaPr
 cx4Q==
X-Gm-Message-State: AOJu0Yzq+uikM3pgaO6+J3l4fuEzqpV2R9zD0gxvXZhNBkgepDT8hDqA
 M4dPOoMY3quI3OBbzd5QM02ryjnKgV0h2awC26dlG9juwe+pDqOMwWhWA3C1jREpwXsEO7B8YhZ
 I19UABSFKd7P34064DnKzZOoaWe4P/7VhiVfxKsWq
X-Gm-Gg: AeBDieu8Yo+923milJd66DQcowHkjBu5d9iuLAyd0icY/zjTTNcKHaN/nFwAR5Wecwy
 hL/Ore46/jdkfHWhbvPlBVwTTlfpoEc/+HAaHqxYqHKt6S7F19R+leJXgX5eebVxJmJghrfRGXV
 GqRasb3sncgrqbG21BpA5zca1XHQZxub0YHeml5XHo7wUDSpK54bMpf+TfdhqDsE45lBexaJ5tU
 +PW7WVtsI73pstiUJesSOoxvrjWDfEYt8nXXdM7wV949bZ1WES5VogusHKTkNdki7sTWaSyLHTK
 7nEyKWB2ZfKkRGQA
X-Received: by 2002:a17:906:7304:b0:bc2:b212:a593 with SMTP id
 a640c23a62f3a-bc567762b63mr460427866b.0.1778167895211; Thu, 07 May 2026
 08:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260504190531.103295-1-marex@nabladev.com>
In-Reply-To: <20260504190531.103295-1-marex@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 May 2026 09:31:23 -0600
X-Gm-Features: AVHnY4IYrJvKIqjmwSDCuuRun0pvOD_5JKbprazqYQamL2pMHSJi-5B9ivB75_Y
Message-ID: <CAFLszTg+Ak2oZmYo4qy9T8kXpM=Mk1Vv0+dUucW7-xi9MX-Duw@mail.gmail.com>
Subject: Re: [PATCH v4] binman: add CST backend selection for i.MX8M signing
To: marex@nabladev.com
Cc: u-boot@lists.denx.de, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
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

Hi Marek,

On 2026-05-04T19:04:59, Marek Vasut <marex@nabladev.com> wrote:
> binman: add CST backend selection for i.MX8M signing
>
> Add support for setting the CST backend, both via DT property and
> CST_BACKEND environment variable. The CST currently supports two
> backends, 'ssl' and 'pkcs11', with 'ssl' being the default when
> CST tool is invoked without any -b parameter. Keep 'ssl' backend
> as the default, but explicitly pass it via the '-b' parameter,
> unless the user selects 'pkcs11' via either method.
>
> Signed-off-by: Marek Vasut <marex@nabladev.com>
>
> doc/imx/habv4/guides/mx8m_spl_secure_boot.txt | 30 +++++++++++++++++----------
>  tools/binman/etype/nxp_imx8mcst.py            | 19 ++++++++++++++++-
>  2 files changed, 37 insertions(+), 12 deletions(-)

> diff --git a/tools/binman/etype/nxp_imx8mcst.py b/tools/binman/etype/nxp_imx8mcst.py
> @@ -90,6 +97,10 @@ class Entry_nxp_imx8mcst(Entry_mkimage):
> +        self.backend = os.getenv(
> +            'CST_BACKEND', fdt_util.GetString(self._node, 'nxp,cst-backend',
> +                                              'ssl'))
> +

Please add a binman test covering this new feature - see
testNxpImx8mCSTFastAuth in ftest.py and the vendor/nxp_imx8_csf*.dts
fixtures. The missing coverage line for me is 177 (cst_backend =
"pkcs11" )

Are you able to run 'binman test -T' ?

PLMK if you need help.

Regards,
Simon
