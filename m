Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA14FCF9C55
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:58:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378CC8888F;
	Fri, 20 Sep 2024 17:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fN5FJdL/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46BCE88A9D; Fri, 20 Sep 2024 17:58:04 +0200 (CEST)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 190B68885D
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-4585e250f9dso11414271cf.1
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726847878; x=1727452678; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tit1ot/Cbv2+yoMidNjaFPeLOhH09nhTqtOzmQ5VeDE=;
 b=fN5FJdL/CL1qbjxKqYL+iILNk2d1WiMt6zJiYU3vBpE3Lr2wchnkcWwCrnk9Z3NaqQ
 PT5+Hc0oMgCuDQZADLGEyyhxwzKYcnnD9A096ZE3Sd0x9YmflPTgqnswrqNIHiTszDyH
 r4QSGskyvWGlL5z/xF8XBkzC1m/r06KXjrjaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726847878; x=1727452678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tit1ot/Cbv2+yoMidNjaFPeLOhH09nhTqtOzmQ5VeDE=;
 b=ukic/i6SObCl90amb54ngVbMhycLCl+R6MkfgQFpYrQGSEtWf1B3+5aDYYqoyhy+OE
 zNLRDHMSrt8A5QLt5iWce+cLOIxNSjuIQ9GxjcIQpZJBVDG+z83bM8yKhmcbc3/HfFaO
 qAuEPCI4AKB9Ug7Y6kCgz/tSQ6xBd+xNh5AQch3i0wJtK0P6Eg/N/jWFsTjtO6vkxB1A
 Cen24ZS+zqFr+iZcMA6TnsEwYAUNsjfeFURiimfZ8/uS9ku7pR5nDgMyOme+2Vrq1BA9
 VWgUpGHjRZ1HJbplXWDKdS+aYNl1StoIyyLlcVQH52IpJpxXX9MOBgjQCXCWGwCPSY1R
 9jkA==
X-Gm-Message-State: AOJu0YxrgbtgI8RFFGoj+O8gyqzGAt5YENKQIMXHlGZSBSxtg/ZrLakf
 An5fqJBCU4xEqunvVF1JK5udrXkC07hHaUucyhQKmhMNU+RaXszvnEwSxOoP9yoygyUk2+P15v3
 7ZHqgjiTzvkJRhP7MJM+TiFypmS8LJTU63Jho
X-Google-Smtp-Source: AGHT+IF7KzXIrNWdJXAWJ0ZYhH2WmjuFHDAcpfM/d5TrLqF60sIp73i4fM0BxPkOqD9F7Avg+0my2SLwXswlPgOw4Rc=
X-Received: by 2002:ac8:5994:0:b0:458:277a:19df with SMTP id
 d75a77b69052e-45b2053d89cmr36492741cf.45.1726847877969; Fri, 20 Sep 2024
 08:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240920090613.76154-1-dse@thaumatec.com>
In-Reply-To: <20240920090613.76154-1-dse@thaumatec.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 17:57:47 +0200
Message-ID: <CAFLszTiq-ugegQ5M3K69fZVXvYMhKD_4boTaVoe6T3AWFcyDAQ@mail.gmail.com>
Subject: Re: [PATCH] rockchip: rk3399: Weaken dependency on SPL serial
To: Daniel Semkowicz <dse@thaumatec.com>
Cc: u-boot@lists.denx.de, Dragan Simic <dsimic@manjaro.org>, 
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, 
 Philipp Tomsich <philipp.tomsich@theobroma-systems.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
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

On Fri, 20 Sept 2024 at 11:06, Daniel Semkowicz <dse@thaumatec.com> wrote:
>
> Allow to disable serial console in SPL. Weak dependency is already used
> with TPL serial.
>
> Signed-off-by: Daniel Semkowicz <dse@thaumatec.com>
> ---
>
>  arch/arm/mach-rockchip/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
