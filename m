Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95241FEEF55
	for <u-boot@archiver.kernel.org>; Tue,  7 Apr 2026 21:52:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 125BE8405F;
	Tue,  7 Apr 2026 23:52:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LvpGT1Se";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21DC4840AB; Tue,  7 Apr 2026 23:52:19 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFDA58404A
 for <u-boot@lists.denx.de>; Tue,  7 Apr 2026 23:52:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7d7f92bde91so3427295a34.1
 for <u-boot@lists.denx.de>; Tue, 07 Apr 2026 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775598736; x=1776203536;
 darn=lists.denx.de; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=auoWgyYjZ2FyrMc9mi3OiMDcP0LH3B/3LXvnz4AjWPY=;
 b=LvpGT1Se41J3X/Pv5dHBUxrdBpNMGT3FN8WSHtGJGpVXdrDezZoU4aoOwLH8GQpZLa
 McKnJw42aFmi4Y6UsHe9FBnoHzEclidsWQwTeaDH5sC7REnH42n63Me5UpipkOnTMI73
 s8fMnp13630/ov+g0NCEJUMp41TgsdorwBDn7JJYxyI8mG+7bm8++F9Jp+fZzooXzHUJ
 FoVPSyTasEP4vncWpxVSm9O+pkZEoTQ05hS5VUdtWHXBZjxv0MDwSeck54Pwj+u9v3R4
 2US+Zy1MVZkV8ToILaP/2e6y1bCpG/roM1T7vlaxsUH9QhNzPlrB9G2ugFNlz6EwI8Zb
 CJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775598736; x=1776203536;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=auoWgyYjZ2FyrMc9mi3OiMDcP0LH3B/3LXvnz4AjWPY=;
 b=UWBFryaIvkng8BoLZcJCF26qHcAAKMPpS2dPxQK18gimfJ++hxYGi58dVoyeaWlYDG
 VVvPGS92XFbZsknIeichQeA/OL7WDXxe34hmxNae8pRSIRyZ5bURgltUt4Dku7sUYEgF
 H/QKyiCHgQuNm2/GS10tHisn1QlWn3RgsHOnfnhzzm3RStXA1RTQe2es7F3Tax/PMcV/
 NsvSxLEOjLSRhzvI3tFh4tcTuJ2vi31HYpFXDh2+xDyQPPu0zA+Aj3DfSGdDtJd8M15T
 AgFRHl1+yFakB+nYsMCOguvoLqBc+dawOhi9l8PyOvcbrwjReCjltB8U9h0pcCLPT0Le
 TImg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcBisMu+5LrF2GNj1jTsc2BwQJqiNkm+pujfA/IG9WYbiAvWI1BQgA/yDdkZYdwpgHCy3muzE=@lists.denx.de
X-Gm-Message-State: AOJu0YwJx111mSdAXqc14af2VANtpNsLEqNsyvCLvqbMZV35AKXRgvEU
 dZbEVKqE0PUcEkfPgajVxjmDbnyssD6PP3X7hLn5VeBwmSiBZIH4Xd2uhy9I81sj4dg=
X-Gm-Gg: AeBDiet34vAWgURv8P9cYTN3wVZBdtbQggpRpdqs04wHOzivIMV0bmAJpzE7aVoF6dj
 lFOsBrRQw1bwYqu4UxjzNHvJH4XvOqHehe1FPS11/fsggJAsvrVIkf2G4/3VFJpubVUAPHFbJ8O
 hkBBc9BwViBBeoDAh2lRGsZ28CVxuvXi/Uo2peVFVEh8MvBj6UXYdX/eb92yp4Hekzu/MQ4+1U2
 JXU9ls6WtHuuC5phDbPVLMkCHZDAJSHBHP6hNXKXrUo58jYNcPMreUyP+IpgbN8EBkKVRLl1TW3
 6P1k8huLsQxH+xYa5dJcCJohSRxU4PE7zxZn3KZitFtY4wO1zcDMoPa1P9DgHtY7+S2ljtudnSx
 jhIdnLpDvRmHXRR6kDy7hHA6Y4GCmMnhnNMIVx1dmlVWsRFdYe41RMbyW2duCGLXY6Awa4A7XGN
 od/E8Jb2bnFWuEhBjnrH79G+GxzSfVBsvS6VTB+44ebvgJTzIemc7gBCYRF+BXWwB9nNc72O5ex
 atiRLlJIIII
X-Received: by 2002:a05:6820:1907:b0:67e:dab:7d13 with SMTP id
 006d021491bc7-6821db69258mr9814250eaf.21.1775598735662; 
 Tue, 07 Apr 2026 14:52:15 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:f738:1ffd:6365:30a7?
 ([2600:8803:e7e4:500:f738:1ffd:6365:30a7])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42324017960sm10176381fac.7.2026.04.07.14.52.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 14:52:15 -0700 (PDT)
Message-ID: <e3f19f0c-b170-42b5-9d1a-9975fdc44425@baylibre.com>
Date: Tue, 7 Apr 2026 16:52:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: CONTRIBUTE: fix top heading level
To: Tom Rini <trini@konsulko.com>
Cc: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de,
 Julien Stephan <jstephan@baylibre.com>
References: <20260407-contribute-fix-heading-level-v1-1-9b075f01e7b5@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260407-contribute-fix-heading-level-v1-1-9b075f01e7b5@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 4/7/26 4:45 PM, David Lechner wrote:
> Change the top heading level in CONTRIBUTE.rst to a higher level. In
> reStructuredText, each page should have a single top-level heading.
> Otherwise, each section of the page is treated as a separate page in
> any table of contents.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  doc/CONTRIBUTE.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/doc/CONTRIBUTE.rst b/doc/CONTRIBUTE.rst
> index 8ccb3a193da..3f8d422e967 100644
> --- a/doc/CONTRIBUTE.rst
> +++ b/doc/CONTRIBUTE.rst
> @@ -2,7 +2,7 @@
>  .. sectionauthor:: Peter Robinson <pbrobinson@gmail.com>
>  
>  Overview

As an afterthought, I wonder if we should also change "Overview" to an
appropriate page title.

> ---------
> +========
>  
>  This document is a high level contributors overview setting overall expectations,
>  so people can get started quickly, the rest of the documentation goes into the
> 
> ---
> base-commit: c3062edfed295c010f81dd31b9e9cdfaaeaa71a4
> change-id: 20260407-contribute-fix-heading-level-6b98a3c133b0
> 
> Best regards,
> --  
> David Lechner <dlechner@baylibre.com>
> 

