Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59B87D1D484
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 17:43:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CCA4842B6;
	Thu,  8 Jan 2026 18:43:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="inwKIb1w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 583DF842A2; Thu,  8 Jan 2026 18:43:23 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B78884158
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 18:43:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7bab7c997eeso2651272b3a.0
 for <u-boot@lists.denx.de>; Thu, 08 Jan 2026 09:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1767894199; x=1768498999; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vCNHB3lCIVC67sc2QISk0+5ANY7HH19lb+3n7pNN738=;
 b=inwKIb1whgDbSb5T/Usac9iVASOjDIJdYG8BvBz7OWEzvFlAQC9ba/luzP6YTKWvhe
 FJfqOsUMTdlcl2oPZ4AZfmN7ls8zNOI95SNbgNSrtIdxM+ryvLdmDNvdClDQSCdThXWh
 qdQtqf2Aquw92lEiMEXQFj+K/udW+SBy5ro4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767894199; x=1768498999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vCNHB3lCIVC67sc2QISk0+5ANY7HH19lb+3n7pNN738=;
 b=EyzGIEK6G6xTCQEMES3InjxHKVjU7piwbWJDbm0oiB/xK2crxPrlav8Jrh1xG6mW03
 jr4brxq/HG67AhbPsqy+Ox681C+9Op3jkGTBHNiM5C7vng9RXBB44jmbvuVe1/QyXEs5
 Cb4vK1UQyR2oqco+0h7Wt071xkthZJm9c3tOMth2+WVC5eyq5NofFFWO1/Y7TGTXXbZd
 jAMctFekHwGCXTE4ucYN0T4zFFEpST8/nAZE6ARkJTuXcOUjBNknSKPK/M00Xy92sqy9
 WyyfL6+yMuZHeBMN4V6qhjKiS8PknUADlZpU8L6yzhCsbNuvj4Wl7+VrBNebVJVu+kZR
 07WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZi9te+56eNr520151jYJuqYxUad48CyY4nsqYVztlQxijXFGv87xwffFzuLh8S18QbBOMIQ0=@lists.denx.de
X-Gm-Message-State: AOJu0YxvavY0aLF+OMEmW/KPUhisOKqUSpK4Us8qof7wqtmeNIlWkVhy
 2tOgzlNG0aWZBv7svX/emHqqHO4cexABxBV6rUcW/W47pBOHETsZB8wUuOzDNXAn9S2ro1b8HQj
 kastaGG2d8e7JWGKo1hOr0AXWLa4I54wBE00+nYxD
X-Gm-Gg: AY/fxX4vHj+f2xK4OGNr+rGonXS3qF02svCDoQmlpLXc7EE5a8h50yjnWkl5KnPhUxX
 mnK3gfOq9l3sRjOOW6BSelmEg9E5IEpqelU4PXfFbxfmgXYrJhtp/nhnaBsO6uLTH96P0oN7wS1
 MFxyfnX89J/oDvi51aVKjAUaE3rqej744rkFIuGlF4nloweOPtO/uHcltHa9R+yfTO5XeqaF7oY
 6OmY205XkHX9+MMbrHmv0sbWVR0Oj3LzlCXxi4vSLvYrOQefAo5tjwxHP063YaAKaF4wghRbMsW
 iQgM
X-Google-Smtp-Source: AGHT+IFFi5xC5ddFn0DjhbM5af4f+yeQJYolLLy/wXfDituQyQc/NJOZO/Q3IfIPaZxrtCjn6JSYcF9TOWejlU4OHmg=
X-Received: by 2002:a17:90b:5884:b0:33f:eca0:47c6 with SMTP id
 98e67ed59e1d1-34f68c27d86mr6334495a91.30.1767894199501; Thu, 08 Jan 2026
 09:43:19 -0800 (PST)
MIME-Version: 1.0
References: <20260107-pixel-config-v3-0-02a25e3fdcfa@ixit.cz>
 <20260107-pixel-config-v3-2-02a25e3fdcfa@ixit.cz>
In-Reply-To: <20260107-pixel-config-v3-2-02a25e3fdcfa@ixit.cz>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 8 Jan 2026 10:42:20 -0700
X-Gm-Features: AQt7F2rHm35tMBWaCsi0XYwhBjdfX0PJ8OUZIxci620AxRMyQHhZwuKgpcYTASc
Message-ID: <CAFLszTgJyqYvwyb=KCtPmEtbb-aOP44seR32kufvB8jn53T2Dw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] configs: Add google-pixel fragment config for
 Pixel 3, 3 XL, 5
To: david@ixit.cz
Cc: Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de, 
 Petr Vorel <petr.vorel@gmail.com>, Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Luca Weiss <luca.weiss@fairphone.com>, Petr Hodina <petr.hodina@protonmail.com>,
 Matthew Croughan <matt@croughan.sh>, phone-devel@vger.kernel.org
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

On Wed, 7 Jan 2026 at 13:28, David Heidelberg via B4 Relay
<devnull+david.ixit.cz@kernel.org> wrote:
>
> From: David Heidelberg <david@ixit.cz>
>
> Introduce a fragment config for the Pixel 3, Pixel 3 XL, Pixel 5.
>
> On these devices, U-Boot is chainloaded via fastboot. However, due to
> additional requirements added by google, the image header must have
> a specific value for the text offset.
> This is solved by setting CONFIG_TEXT_OFFSET to 0x80000 in U-Boot.
>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  board/qualcomm/google-pixel.config | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Simon Glass <simon.glass@canonical.com>


>
> diff --git a/board/qualcomm/google-pixel.config b/board/qualcomm/google-pixel.config
> new file mode 100644
> index 00000000000..999d4e45268
> --- /dev/null
> +++ b/board/qualcomm/google-pixel.config
> @@ -0,0 +1,5 @@
> +# Enables chainloading of U-Boot on Google Pixel phones using
> +# newer bootloaders (Android Q/R)
> +# Use for following devices: Pixel 3 (blueline), Pixel 3 XL (crosshatch),
> +# Pixel 5 (redfin)...
> +CONFIG_TEXT_BASE=0x80080000
>
> --
> 2.51.0
>
>
