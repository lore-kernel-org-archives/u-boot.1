Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8AC9C02182
	for <u-boot@archiver.kernel.org>; Thu, 23 Jan 2025 06:20:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E689080214;
	Thu, 23 Jan 2025 07:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="P6SJiw0a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E7F580243; Thu, 23 Jan 2025 07:20:08 +0100 (CET)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95C7980137
 for <u-boot@lists.denx.de>; Thu, 23 Jan 2025 07:20:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e3978c00a5aso854232276.1
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 22:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737613204; x=1738218004; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PuxRUI0Cl9aU8eA6ASFQ+w/wjGu1+eOmtV7vCrsNrwQ=;
 b=P6SJiw0aQGEesQT/LSwbPvgO0BFxGRXCMFrEjDjHYDFXP7IJbRwO3X7n4lS8fImU/r
 l3I24F2bDeL0aBMajkFsLElg51r+lPYqVFEtbCMkKWuF6PtVw699cWbqE8KzqxTEOdrY
 YCg8QKZVm+zQ7SesGji4z09i/PokhlbvavNzbR7lJgh+4OCRfFalP2KAM5PRppQa8N9V
 x0ZjAlqywZYeH9BN5Qmi9lgrahVsh5hYBkvZjtRMHbBg5ds6m1crdC3afHbBJsTbUoGV
 IvzpWHdeJLBbu+pXsCbGLQPYYkqRu2EYb3maOlap017/pUJs+j3ogHQ3zvQ9btekCZ3w
 T2Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737613204; x=1738218004;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuxRUI0Cl9aU8eA6ASFQ+w/wjGu1+eOmtV7vCrsNrwQ=;
 b=hCY9KTx0xdFJ4n5Cye7jUTyKCA1/qI02hxlcsuzbrktPK+r21Y724EtwC3Mj0ya4Yf
 206/eSJAe+YI/6mNbjIyC5RyX4S4tql5my9MNwzkOG/lrF0V03GIs7AF4RGQflizjNnT
 nXwDYH2WRyl9J0Lpmx2IJUUS9IumuCYphdbd2aT46NI9vmAoJH0RpRNDxkdRF/k7c58V
 hCZceO5xRtvB058vi+Ets2MvPECrsa40SRg3x6gFhMTj9eCu9lI32NH/Hu/BEWPbDntr
 P9ySCQOjYRtnj7d2oZ7kPTFL/sQ3lTwA+G2Hy0lcQD1AYWvHP9nF+9ue7PnuHrU/xVAR
 fttw==
X-Gm-Message-State: AOJu0YzYeV+L4PSOc7OANSrK7WK/5fhZlwga/rSHp9VlSGNyUpEewN9h
 qT9r/ZhEO7wpLNwU1MJkicsnpVhmCzXPOCnXCoIjCvZ22q17evLA/rqG4oxkmeW8BGx3xvB5KMy
 E1lV56FHHTb5EaLE5sL9ybawQwSalPBPdGbEDLQ==
X-Gm-Gg: ASbGncuH1XSFYs/6pIWMaeHD2Vt6Rx07ZmzCWHLIcdLPmK91AfR8lVETFwZengIdlJp
 73gqDGerA2jD05YsqgURZWrgDG7XNoC3aq4WArsAbdB4u5R8NmkZjeGJ8r5v4DQ==
X-Google-Smtp-Source: AGHT+IGV/GPqBrk8DCyoijvTH4tC/C96I646jzKGTAaLRdLGxiEC82XShUSrA9To+6q56aZGuNx6quKYaBeDAVCqoMs=
X-Received: by 2002:a05:6902:2e01:b0:e58:141d:b6d3 with SMTP id
 3f1490d57ef6-e58141db753mr4203698276.16.1737613204411; Wed, 22 Jan 2025
 22:20:04 -0800 (PST)
MIME-Version: 1.0
References: <20250117164032.88942-1-raymond.mao@linaro.org>
 <20250117164032.88942-6-raymond.mao@linaro.org>
In-Reply-To: <20250117164032.88942-6-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 23 Jan 2025 08:19:28 +0200
X-Gm-Features: AbW1kvbtNPW_LSHb8uB3Mf7CwyUDvXtkIIL_l2xhtsunIJDzw-ZmxZeDP8HgsZI
Message-ID: <CAC_iWj+qYcZgTtN8KAH99aCMH4Es=hmagw76r1oDM9yVAmsqpQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/6] tpm: PCR allocate during PCR extend to disable the
 unsupported algorithms
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 Michal Simek <michal.simek@amd.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>
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

On Fri, 17 Jan 2025 at 18:41, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> During PCR extend process, if any unsupported algorithms are active,
> try to use PCR allocate to inactivate them.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> changes in v2
> - None.
>
>  lib/tpm-v2.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tpm-v2.c b/lib/tpm-v2.c
> index 0e497b2c2a..4995ddc9af 100644
> --- a/lib/tpm-v2.c
> +++ b/lib/tpm-v2.c
> @@ -344,7 +344,10 @@ u32 tpm2_pcr_extend(struct udevice *dev, u32 index, u32 algorithm,
>
>         if (!tpm2_check_active_banks(dev)) {
>                 log_err("Cannot extend PCRs if all the TPM enabled algorithms are not supported\n");
> -               return -EINVAL;
> +
> +               ret = tpm2_pcr_allocate(dev, 0);
> +               if (ret)
> +                       return -EINVAL;
>         }
>         /*
>          * Fill the command structure starting from the first buffer:
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
