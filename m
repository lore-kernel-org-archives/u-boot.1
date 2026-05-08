Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3097FCD37AA
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 17:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A710B84DA0;
	Fri,  8 May 2026 19:00:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aKqcOEHM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 773AD84DA2; Fri,  8 May 2026 19:00:09 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B11D84D42
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 19:00:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bc1f0f48351so357848166b.1
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 10:00:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778259603; cv=none;
 d=google.com; s=arc-20240605;
 b=LcXQUEEDpqA1PP/utfkwhwVmvYau+czMHvLOEm+tLN25aZnMEgdJMS7c90uZqPmVw6
 DjswMKyqYeyZYJ0hrwBUTrjk9kx+jToZ316IZW1oG1Iy204/gSXum8FBqs8I/lIYoV3t
 0nKJLcvf2Jlvvc6o3PjTB5bcgUtiRCowLHdzY+5q/x08BhkvgG1Q+PGmG3Tb7arlvoCB
 U4VJ/pw9tNRF39vbKm/BXGRYMwn33aqugp1Rw3wIyKctx4+FU6aJVhDKFWIq7n33wh/+
 SaZg39G8CI3mRtH8IHSnXN/w02N+H25qVCGiHZuVhQWL8JyedhR/Dcz+qsaxudlIZrAU
 /aYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ZoX1/zSlIa/jqBca9m4yWvb+AVfccwLgJ44JDDjtlKw=;
 fh=7+NugGQ2fjuifNFbboBIeXRgPjkONDOweWugJxHsSfY=;
 b=cA/xlymqBpbJEC07KgEgi8vKwSIXWRKzlva8s5U4d9rd4xqTdf6V7LcOQljNLYFNW9
 qSnCSaajOBhDUcgXS06L5zNP7dnaX7ALsSI7yYRKN9EoPeQTGvAeWfaNGplwRSTRYTIu
 fgAqlY0yuu2n3/z8oiVJMmTB4DEA/WKYmKo9xD0l43TF3/EKHAAwhiiM6wvXSinoGFPC
 nkWzIpbyUYOSN6+iu0iczsLqqs6SSNgKWPKLVUhwUHCbtwvGLaA2mTqXSd0vfVhFQ1eI
 kHD9Av4UV9AU6G6ipg5CdyqCYfaxuS7xy6QMK+cjYfMNmlEudP2ZJWungj+AN99aeR5U
 uOfQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778259603; x=1778864403; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoX1/zSlIa/jqBca9m4yWvb+AVfccwLgJ44JDDjtlKw=;
 b=aKqcOEHMZQLFkbuM1kRE3ko93RzYOuVcYCGwnzcLuqLj5zalAVxoGXpPhAfzGCih4F
 tzCSAwvDycP238jWFNwJ93TOWPi6IpYbGGb01Ng0iaSV0Ll8ecdD0cVriROnNG+T0VsO
 j0TFcuan6VN7vxg/UGBDKvPOvfOqYiDBp8/fE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778259603; x=1778864403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZoX1/zSlIa/jqBca9m4yWvb+AVfccwLgJ44JDDjtlKw=;
 b=ifM0vqFm61R1Fs+CoW5NjUmo1urruwOKv+6dg+4/l/uD75q6vCIPZH2sR3sbmqUp4X
 eEjWM09ZmageFRq+QWOcJiddAwP7MiRutDveKQKKCMZNN7dSB247QRIcfoKNeSF54bd5
 cjU4OSkU/d3XwhLGcCIUGlSKKKzCBE7lQYEGrDpWIAe3pMmv3act7U3XwhLUNkY0J59J
 Dn9ph2C/vmzDsDYMDOGtw+OGQe9Ikthyb1FQqF61cXh4F2EZ6M8uK+B2mGRjR5A2ZhkZ
 v1F2ToKbomN+/OYNOTzGtMnPIAkMCrSPq7FJIfDWJZunUNC7z6kmt59vuQLTXYCo/EUi
 7Tag==
X-Gm-Message-State: AOJu0YzY6Tt1rcnvI53LYLZ6PPREW4oAutJX3C/hqta3Wkq0HobHmcut
 lTFQYxIAuJp90x1w76k09H9UPTod/6gi6QoHqUASlL+jR05BOhFeJjVOkwVd0Bk5mvfDMYSMtSV
 Q24eD9OoZl73o/CAZoW/DOQVModn9e4mZBlUONVnWT/AqFh6ctlw=
X-Gm-Gg: AeBDievqvxyJJrveWqdH8edeyi+W2AXWHBxEyH82ZtUzCyFLN+60YFkzLjogb/rw8VK
 WQlco6gyPlDZrnOjAx1H+Mk5n+EXuXnZR2JZuU8tsdwyHAfThGzWajnMBR2lFzLsevsrolVHqfQ
 KPkRD29jfWhtJPlBWsvWWdgHtEE/2QxT8K72D3VM79VWmYj6cOjdTkS869zWMGSP+tAnTZL2zrZ
 53hdC5mHgRdaDr68LUQ+866TB+pTJHhoA7ulDKEmRMvbaUWojnZKWYXXY6huv5i42RRBU4RZVv2
 kYEpDQ==
X-Received: by 2002:a17:906:5194:10b0:bca:48de:5cce with SMTP id
 a640c23a62f3a-bca48de5cebmr235016566b.36.1778259602598; Fri, 08 May 2026
 10:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20260507164248.59353-1-marek.vasut+renesas@mailbox.org>
 <20260507164248.59353-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260507164248.59353-2-marek.vasut+renesas@mailbox.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 8 May 2026 10:59:49 -0600
X-Gm-Features: AVHnY4Ix_xdOTJefQDHSvjzgoiMC_PBJJFXAOkBE0b4wZDAUhBU9ELiO6oE7aHk
Message-ID: <CAFLszTjCo1mO6pDCaqMfThToTHBS2a1AeO5eEY1sn0T4pCXJsg@mail.gmail.com>
Subject: Re: [PATCH 2/2] block: rockchip: Staticize and constify driver ops
To: marek.vasut+renesas@mailbox.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
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

On 2026-05-07T16:42:39, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:
> block: rockchip: Staticize and constify driver ops
>
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Acked-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> drivers/block/rkmtd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
