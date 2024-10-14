Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2223D1812A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 15:51:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9177589159;
	Mon, 14 Oct 2024 17:50:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Zu/L300I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6DA388DC7; Mon, 14 Oct 2024 17:50:51 +0200 (CEST)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 707F188936
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 17:50:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-460391553ecso42219501cf.1
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 08:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728921048; x=1729525848; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iDvW/WGzRwhzSU3gXVEtCc5mrcNrfZtWGcYUg1s2xqc=;
 b=Zu/L300IDFON8mM9dsSqPh2eBVK3MgeHewAeFi8n+etdG3gxSsMFmwnB5zizHhfJUl
 7hV2tn6DkKyGKspv3x49SzFLwY/g/6vyA/jVeD1fZXKxzArUBpPi218Rl3ag+wrgQGpO
 6DktDttFHD9Ts5SdNZVGSC9/XcFJOj9p7bqVE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728921048; x=1729525848;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iDvW/WGzRwhzSU3gXVEtCc5mrcNrfZtWGcYUg1s2xqc=;
 b=ByYML+opbaP3yPcoJRU8P1ebEKoS/1wfcRyoAIa9tf4s2YfK+Vd1IYf1VcPpK/95Nz
 XQvVUnGm3JBX+o9zlASMRY6o5hCEhkvBWD6aFIZnCY6WKoGa+4SCT7z+NtB5+6t+fqMA
 GpovLVHpJsW6sM1pjHxl+sdxJJ5WNfiNxejOaFkhkYe2yEYcuecLq8PbZuVwdNZz4MxX
 erFDd++FMSvJdd45pwX0xaw57ul8MdasnIzWhoIiL0lXjo+vAP9ZzD+hYW2MDqEDPefk
 A88INPo4KWp+4ZcftL0EzFFcEJ5J5tTqO6HCA91sKCFMZWi1b/dd3V/0Lscm68+lUF1v
 gzWQ==
X-Gm-Message-State: AOJu0YwkmeqMW0tN8qf8d9ufdNosLhxL2H8aSFeV1e/ZcPCVrIgS3Uu1
 GsjRzdsBfNCtK/5Tg1LJnnbRcNTFny4PrenuP9uzbnqZ3+xLOXqVfmWnRjHBPctL4xtsv3+ePg2
 0/r1pECmPYtdwJrweR7/GNb0UA7wBl9A67Y4l
X-Google-Smtp-Source: AGHT+IG8zU0/BRcQ4FunJHwIElYcQAcnJa6znpwJBVSELr8HB/l1gYrFKNzT9dflBqlTzs2ouO/hbi8fdZGjl0BjaqU=
X-Received: by 2002:a05:6214:2f11:b0:6cb:f6a6:55a8 with SMTP id
 6a1803df08f44-6cbf9d4b4d3mr153334466d6.27.1728921047959; Mon, 14 Oct 2024
 08:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241013105522.391414-1-sughosh.ganu@linaro.org>
 <20241013105522.391414-4-sughosh.ganu@linaro.org>
In-Reply-To: <20241013105522.391414-4-sughosh.ganu@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 09:50:37 -0600
Message-ID: <CAFLszTiov914NOS9_5UU4oLi0fCQ84a-Et82BeSEJbts4MEOVQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/15] efi: memory: use the lmb API's for allocating
 and freeing memory
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>, Jonas Karlman <jonas@kwiboo.se>
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

Hi Sughosh,

On Sun, 13 Oct 2024 at 04:55, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> Use the LMB API's for allocating and freeing up memory. With this, the
> LMB module becomes the common backend for managing non U-Boot image
> memory that might be requested by other modules.
>
> Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> ---
> Changes since V2:
> * Use map_to_sysmem() to get the user-visible address to be shared
>   with the lmb API's for sandbox.
>
>  lib/efi_loader/Kconfig      |  1 +
>  lib/efi_loader/efi_memory.c | 77 +++++++++++--------------------------
>  2 files changed, 24 insertions(+), 54 deletions(-)

When efi_init_obj() is called, it should be able to add the lmb memory
to its own tables. There is no need to worry about lmb after that,
since no other images will be loaded, except under EFI's control. Then
perhaps you don't need this patch?

Regards,
Simon
