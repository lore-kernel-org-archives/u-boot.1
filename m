Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB59AC5ACAB
	for <u-boot@archiver.kernel.org>; Thu,  6 Aug 2026 17:02:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9554940850;
	Thu,  6 Aug 2026 17:02:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X2ZBOYsVMl5m; Thu,  6 Aug 2026 17:02:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2A76404C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786035776;
	bh=+TQIoL20I0ciArbvZNi2mA6ZmY4cES10YqeJcnp4EWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gMwHFXFZ/85lQQ/lcxcyQb27EnXe8nrOVvXXFuQa5AWogD+AWb0Zg7oAmjZ+0TLZJ
	 ZR1dZUksmrBJ8+iqe+Qk6A/PKS35ebrsD4GxFO56wSL3oE54bgx/R0whr0MCaN85xb
	 s4Kl3Yp6UQR+nMUE7ukR5iu4aeYJnLCYGWbaetuyj9msHXuOzZrYmoEUeP8z7br3sJ
	 cqV/e9gILX9ktgTuNlDaTb9WJMhSf/ow+F26jODoyz67mzMnj2Nxpt8i+YgDO/+rBX
	 VGvXI7w5o9llqhZ93cjTiibunxal95cfWzuBLZOBSICCRBa1+6zXmRivtrfnDhR68G
	 hw1lnFoWI0U7w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2A76404C1;
	Thu,  6 Aug 2026 17:02:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id BAE2E392
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A1065402D2
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:02:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lStgwJ-y1fAw for <u-boot@lists.u-boot-project.org>;
 Thu,  6 Aug 2026 17:02:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9C56A40024
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9C56A40024
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9C56A40024
 for <u-boot@lists.u-boot-project.org>; Thu,  6 Aug 2026 17:02:53 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c2020421077so408240066b.3
 for <u-boot@lists.u-boot-project.org>; Thu, 06 Aug 2026 10:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786035771; cv=none;
 d=google.com; s=arc-20260327;
 b=XzUOVm+foEsxsOCS3zerGPetm8z+U8zCLA/X1pEPPbIGtNfvD6MrYDT0lHLBkJs3vv
 +s/dGX7O9+NigcMXY4vJ7l5Y5RZzqYZV/AKQ4X/8roV0/VvkFJxz/FYLqaStcuheF645
 rWreD0aIxLPjDqHfbGDFRerU40g8gca9Hl3rmDLi962VhkAhYpPoth0YrDsIwfdQkBlq
 nx3uF97ygh3wJH4XwLhaB4M2AbXY7WPVVx7UFek2lQiVS0G+VpCPO2FwvsPzzcOX/kOV
 SfxdBjEMXqgyS3Hzjfd4a5HTXTwanf72j1N55ze1ACpUbFiYoQ/XqpDz5xDTtfZd71Z3
 MKzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+TQIoL20I0ciArbvZNi2mA6ZmY4cES10YqeJcnp4EWk=;
 fh=nYjmZNcNBXjFNBQa2yYx09l5MGyiI3+DRBipPcPatTY=;
 b=C94JW66XTK49+1MetpxHC6P2YQ00eAfpGBkgxjWySRLSsmH9YUHX9z70s5jn05RlQZ
 X2LT2RtbFreHSA8Do9ZUkhBUftxVw8jQqWNWhKNOdbdUsz+bxpfSe8LsuUFXJAbSmb6O
 dRc9NCPsZsX/iP3ckV4XKlAzHcoLjXVjrBbIALnL00uFAIIVYulE7LnFGdxEFTH24xul
 KPn3pt47EtFnnFqOWgsNZaJQbI3tgP1nIbNuSmttYNmxz/GYFuZR+W8kUhY/xlj2CySA
 K49JzECAS4oHKcEq9QsHOkHZubfJrwCPe7LE2D4F2Y75e3QfAQHQqgqbZgaYldJbKxqR
 sk3w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786035771; x=1786640571;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=+TQIoL20I0ciArbvZNi2mA6ZmY4cES10YqeJcnp4EWk=;
 b=KBR7meNiTFMqjiju2fdHS0yaqvcFYFPq+iwtgOHvcxDGNdbXIxSSFZtrLVaqIM67/o
 PPDpLir2schjdOgZyE8ZyuO3H/irfbFVJHUHV8/Sw/R0xeKinEKLYtiW8SZDP04++e3R
 7UDnLBPl2ajNdzaFDf14E6UBUo4wSEttji5JbrOf72z7rtZx5YfLh7X0ho99OQiO1eeI
 OGjoQoD2vs8LTFfIG1QDLh8IHgZTc8JLkx9E62bsbLl9N7b/pzhyAAYV+gJs5hftHtTv
 Sv/wh/om0J4uX7dZCEyrDY4ffQMk3t6UdM1PXdqIIZUE2WJ2k6v4li7yMWL+Afmvl3RH
 MfLA==
X-Gm-Message-State: AOJu0YzQvfCEna4o6FnW+MkxZTSNYm71qwn79TCTJFORFJFnl8VswrBn
 3dfylA0YNcFWg0oJuROEofjpQ+pHMKKos2ge30fv2avIH8RtIYMWDGdyvkyUncP+wQClpEwCjXr
 UqacbN1qlJFYOoPFLIiEPYOybTe8L1IoT7/7C5s85
X-Gm-Gg: AR+sD11zoFl94nrxAYQ/2V0aSi4ydfEF9fyA85CnGAa90UBK2apXBunWISI8EFkM/LT
 Nm6IH8jXuDJj2nbzDMPB5g98Q46VZWVu4tipi3s8SQ5tnDVQrQjuTMKVbBxMlEXJ/+WskVzJT7M
 WUVWCkBS0ersiPElJxQot/dQn794YcYyQBK1EBin3er+DHQv0jHOXRvqx216QtksvOXTX0yVXJG
 eMx/dee5OnKp1kzbGwi4SXpFoT5JswUIpOKe93FvuHsbpX2D9pVE9o7UVp1LlG8/TD8CGCvTFzA
 8pBPIVnWZ6m6AdbZl5sSGmpZVDuTxtXA1MyQyPWkdDM=
X-Received: by 2002:a17:906:4793:b0:c16:4df6:176b with SMTP id
 a640c23a62f3a-c2039c214a2mr832116766b.20.1786035771448; Thu, 06 Aug 2026
 10:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-improve-logging-on-missing-uclass-v1-0-d477f0054f48@baylibre.com>
 <20260806-improve-logging-on-missing-uclass-v1-2-d477f0054f48@baylibre.com>
In-Reply-To: <20260806-improve-logging-on-missing-uclass-v1-2-d477f0054f48@baylibre.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Aug 2026 11:02:39 -0600
X-Gm-Features: AUfX_mwa6FguSArx3QGzcaUpZFUWY2onp9qD5nX59-ONodQQU5CzuV4azPPRYIo
Message-ID: <CAFLszTiTC5KkvsXj6YdE3axWJ47_oTmKyXUbpiijFR6fAcmdvQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] initcall: display error code on error
To: jstephan@baylibre.com
Cc: u-boot@lists.u-boot-project.org, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Simon Glass <sjg@chromium.org>, 
 Tom Rini <trini@konsulko.com>, dlechner@baylibre.com
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786035771; x=1786640571;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+TQIoL20I0ciArbvZNi2mA6ZmY4cES10YqeJcnp4EWk=;
 b=GQjzTKkJV1qnEmUSkRL3fK8B+rf78WCFVV4/Ot0xADwBOptflBRhLAe1Ug4J89NAVv
 aa/cJeYnIHhAI4eE73uhi/WLnfFJaaY1k+oMeVG6I3rnkm7MwGQx8lU1UWtZkD6j0WUZ
 BUo+J0wzqHD+NVhMK8jvf3pmvJpoCd8IHyERo=
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=GQjzTKkJ
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Julien,

On 2026-08-06T13:05:19, Julien Stephan <jstephan@baylibre.com> wrote:
> initcall: display error code on error
>
> Currently when an initcall fails the error code is not displayed.
> Display it, along with the corresponding error string if ERRNO_STR is
> enabled.
>
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
>
> include/initcall.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

> diff --git a/include/initcall.h b/include/initcall.h
> @@ -14,9 +15,10 @@ _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
>
>  #define INITCALL(_call) \
>       do { \
> -             if (_call()) { \
> -                     printf("%s(): initcall %s() failed\n", __func__, \
> -                            #_call); \
> +             int _ret = _call(); \
> +             if (_ret) { \
> +                     printf("%s(): initcall %s() failed (err=%d: %s)\n", \
> +                            __func__, #_call, _ret, errno_str(_ret)); \
>                       hang(); \
>               } \
>       } while (0)

When CONFIG_ERRNO_STR is disabled errno_str() returns an empty string,
so this prints '... failed (err=-19: )' with a dangling ': '. There is
a %dE which will print the error string if available.

> diff --git a/include/initcall.h b/include/initcall.h
> @@ -14,9 +15,10 @@ _Static_assert(EVT_COUNT < 256, "Can only support 256 event types with 8 bits");
>
>  #define INITCALL(_call) \
>       do { \
> -             if (_call()) { \
> -                     printf("%s(): initcall %s() failed\n", __func__, \
> -                            #_call); \
> +             int _ret = _call(); \
> +             if (_ret) { \
> +                     printf("%s(): initcall %s() failed (err=%d: %s)\n", \
> +                            __func__, #_call, _ret, errno_str(_ret)); \

Since you are here, INITCALL_EVT() just below has the same problem -
event_notify_null() returns an error code that would be equally
useful. What do you think about giving it the same treatment in this
patch?

Regards,
Simon
