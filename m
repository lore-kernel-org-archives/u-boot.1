Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8499C7EE39
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 10:32:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65A9B8206E;
	Mon, 30 Jun 2025 12:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="r0oXmuSE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2B8F82E27; Mon, 30 Jun 2025 12:32:22 +0200 (CEST)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E871981FEE
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 12:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-714078015edso19680607b3.2
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 03:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751279537; x=1751884337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uFoqnT29rCMC9kVMzzk9h4jBbGy2AOUXflYR2YzoP6I=;
 b=r0oXmuSEXDSRquiqZMtDLBHo2iWZ16uG1Vq+1cc7HLXPPwV+RedVXDXKsiwCNe7mES
 t3/YF7APZBiNvuVefT+EYIjfjvuj3jg5c6W3lCCyF5xy+dVeuOn8FW3hI9qN5J6qFipS
 hWORP1W6ey7I1A/QaM5QndCF1ge0qnGTEDE26RX42NAtzFr/KShSWYW3RgAIqD6eHNbH
 aUy1a67HdmMLXB0jQWGnyDi7SSP29Zei02wVGxLSSeIj4GiUwoSHnrRYBVBABPr7SONi
 9ui2uwTXQ7pmCGlh++Ovx7yK8hkyvPaiIz9zmrGi2hml+e+F0Kn0mahJSokFlW/iiiyP
 GUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751279537; x=1751884337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uFoqnT29rCMC9kVMzzk9h4jBbGy2AOUXflYR2YzoP6I=;
 b=YH+n53SIUgIKhy2cXkwSTqTjr1On+izaaQmSx4V9LG0i4I6FOfiukcUhdWqkx9uZfM
 mfnVm4Bk8LkqO/qjOY/lN+z2l5gaLXbbjUHRK66zK4y3l9gqbs3/3GtT8PV0acNDNLLm
 mRgzu6sWWMiBhevAkhNeSAG8ESucN+6Vpk/Z2sGPeq5y1ZAhqE7bNS4k8hAKexFEKwmB
 sMhPo97kKOtVQZfqKc0cVa7W73Hyx4mGHz8byg4m+QRm8YbddzZTL7wZzTzCOFxM+jAA
 KliOWnJejnxVTUTj3LuxGo+EHoLMpDxsjBmGAMRAz6kU7h/OX0FWjbtc2p3dIZS9qZFf
 KeUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaKlwACHPJ9aY5f0gSkGGy+Qt/A9ObnELoaZlSf2ipGn4tG/rpQGUDzvLgOD6Y5RxqVTYCCBw=@lists.denx.de
X-Gm-Message-State: AOJu0YxTUh3odZ+G0RGFPKEljqOLn8T5if2AjRU+l553bft6mvLLiah3
 W/nQGhGtvMJsu7UrO+Bh1hsundBsbLERYNf1tRHOZNmvW7sKJZWYf44Z9g9MNkehndOAGjtVgV3
 3aR+1uXXN8F8fxifIgwjuSwipPayYywtjsU0Fh/c4Wf8LpC5y5JQ8ZBg=
X-Gm-Gg: ASbGncv+627YpnLUvEtCPJRc0le62JQZ0R02dLY4FHlOiSIlUmToQuo3wiVLuQT8wyq
 DvBh+9rzR6hrUzJjcJkBa2Sewb3QTZfrNuhYMqgBUHp/Jm+nbDj90F9ah4JwAHhLZXuZyOrFJ2o
 9dbofrWOwV0azIwXPVgxAEXql+zz1UUs5x7EZDV8jJYhH9
X-Google-Smtp-Source: AGHT+IFnDfY8DgdPdt0OzyravxVftK1Huwx1dpMvXI0Ca8xHVNNeErRcKRZErG6K/QaOmkHJ++xwqfjex2LGuotFWag=
X-Received: by 2002:a05:690c:dc8:b0:714:250:8355 with SMTP id
 00721157ae682-7151714d23emr186600067b3.4.1751279536699; Mon, 30 Jun 2025
 03:32:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250625-tpm_enum-v3-0-9ef117f6a7e4@linaro.org>
 <20250625-tpm_enum-v3-1-9ef117f6a7e4@linaro.org>
In-Reply-To: <20250625-tpm_enum-v3-1-9ef117f6a7e4@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 30 Jun 2025 13:31:40 +0300
X-Gm-Features: Ac12FXwIspon8exPGvZrx2JKedUIi3-0MdVziCa2x9huudI0L42ocamROlphwKA
Message-ID: <CAC_iWjLjuyYNUW4Ds2J3sVgb18wnDx5GEe+d1c=4ALt=tQ_KVw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] cmd: tpm: Fix attempt to return value not in enum
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de
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

Thanks Andrew

On Mon, 30 Jun 2025 at 13:23, Andrew Goodbody
<andrew.goodbody@linaro.org> wrote:
>
> The function tpm2_name_to_algorithm is defined as returning an
> enum for the algorithm specified but it also attempts to return
> an error on failure, but that error is not included in the enum.
> Add the error to the enum so that it can be returned.
>
> This issue was reported by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

> ---
>  include/tpm-v2.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/tpm-v2.h b/include/tpm-v2.h
> index ece422df0c7..f3eb2ef5643 100644
> --- a/include/tpm-v2.h
> +++ b/include/tpm-v2.h
> @@ -20,6 +20,7 @@
>  #define __TPM_V2_H
>
>  #include <tpm-common.h>
> +#include <linux/errno.h>
>
>  struct udevice;
>
> @@ -266,6 +267,7 @@ enum tpm2_return_codes {
>   * TPM2 algorithms.
>   */
>  enum tpm2_algorithms {
> +       TPM2_ALG_INVAL          = -EINVAL,
>         TPM2_ALG_SHA1           = 0x04,
>         TPM2_ALG_XOR            = 0x0A,
>         TPM2_ALG_SHA256         = 0x0B,
>
> --
> 2.39.5
>
