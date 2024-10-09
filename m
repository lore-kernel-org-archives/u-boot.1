Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 498C5CF042B
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:55:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 617598909B;
	Wed,  9 Oct 2024 03:53:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CeEZ5rRI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE0B68909B; Wed,  9 Oct 2024 03:53:06 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E20A8906D
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:53:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71df67c67fcso2490174b3a.2
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438783; x=1729043583; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JOY5HiPIwLJoIP5wbC4dEJl6JKdVKNK4UW6y3rEcKK4=;
 b=CeEZ5rRIO2HICE/40SqRm4HU+qlyPcjeOFRt4LzUWmIoZ9Q0SpuKETbX572kUIHEGy
 1lyzsUnNjUuPPBDvf6+JsJYp3eJakf4jWEdBwCdnSrGlJyd4qHd7tRluT7K/hWsvrbbN
 0cpyYGpu7bR+HY/bJfpp6cg0wZkynX+RNR0+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438783; x=1729043583;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JOY5HiPIwLJoIP5wbC4dEJl6JKdVKNK4UW6y3rEcKK4=;
 b=MS9CeTWMjDfncW35xhF55GVjfjT6++OocNDC9SurlCe6eVTxIrd1werx9UEeeEeOCa
 QaQnC8zSPU8Tpegd9lpnN2pTW3PGAaUlt5SraeLigbLiliwoLzsET/t87sPx7NYUnOEh
 qrye4PSzMNwjpoPwYpv1riaOxNHGGBMePQLVOABV+VIPBIXnZLYRgCwbSuBm2+rmNMAL
 UuBBU97WXYFG8PEXg2SicgZWHxUlrYkJuCtNU8Evg7rxzR6nbsVXOAcOkClHTIKtSTJC
 fF7epI6OKEENythfiOo/DkuHzIbreRpPxtRK4lFuamM1ihuJOyXX+fZqfM8j9AbMKIdN
 pxgg==
X-Gm-Message-State: AOJu0YyQWz+DbueCLoOW0CMsujjIAJH4KK7xh7BHeGXQKjJEjcfRsvbV
 MTEcdFDBpQaQbAVkQIX9WwmBsnEOy2kqN1tLkJaBc4NAWFav1PS80b9dhVk0W0a43kn0gOcch9+
 N8VdV7EbQz0yuwMKfJiJ9FJXXvv19WMMFME/d
X-Google-Smtp-Source: AGHT+IHeN46kZ5wI77QqISXpd2rYb9XQY2AU7hkcGkVk3GQWmc2ju03q5ouBUeGUZp44ViWRji99HVlDhFws1GcuZFc=
X-Received: by 2002:a05:6a00:1406:b0:71e:104d:62fe with SMTP id
 d2e1a72fcca58-71e1dbb5ad8mr1386945b3a.20.1728438783054; Tue, 08 Oct 2024
 18:53:03 -0700 (PDT)
MIME-Version: 1.0
References: <20241003212802.3810-1-ravi@prevas.dk>
 <20241003212802.3810-4-ravi@prevas.dk>
In-Reply-To: <20241003212802.3810-4-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:52:39 -0600
Message-ID: <CAFLszTiTvhbUOkQ7+XMcy_Bznia2H4TX7o9zURzdfhXei6npow@mail.gmail.com>
Subject: Re: [PATCH 03/13] led: include cyclic.h in led_sw_blink.c
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: u-boot@lists.denx.de, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
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

On Thu, 3 Oct 2024 at 15:28, Rasmus Villemoes <ravi@prevas.dk> wrote:
>
> This makes use of the cyclic API but relies on implicitly getting the
> appropriate declarations through some nested include. Include the
> cyclic.h header directly.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> ---
>  drivers/led/led_sw_blink.c | 1 +
>  1 file changed, 1 insertion(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>



> diff --git a/drivers/led/led_sw_blink.c b/drivers/led/led_sw_blink.c
> index 9e36edbee47..6976b84544e 100644
> --- a/drivers/led/led_sw_blink.c
> +++ b/drivers/led/led_sw_blink.c
> @@ -5,6 +5,7 @@
>   * Author: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>   */
>
> +#include <cyclic.h>
>  #include <dm.h>
>  #include <led.h>
>  #include <time.h>
> --
> 2.46.2
>
