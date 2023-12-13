Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85832C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:43:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E8877878D0;
	Wed, 13 Dec 2023 21:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CTugDGT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60CD1878C2; Wed, 13 Dec 2023 21:39:31 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 405B08789B
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:39:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-40c3984f0cdso60154365e9.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702499969; x=1703104769; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P7cofArPptMnznwnlAFcI5pj8JtLKFPnByfAYCs4RYU=;
 b=CTugDGT82/9rxABKJRdVXaW8g1MMb+Kg31eGy4R2jxj3400gOLHWdEMxPSCwQP/RVp
 DX1+jDgQoMkAKxw2MoTKiOoLBC6pyvjjwUW+MyzZ5Q+R9/kM0FiIiecL5y4yGOUlS2XF
 cqcznbO9z9A+eyc7kKOEy12xmZwP7VrR1Xg8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702499969; x=1703104769;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P7cofArPptMnznwnlAFcI5pj8JtLKFPnByfAYCs4RYU=;
 b=Mz5hvParsBIDHs/c8VNKVVoOMr7FWzt7MZufOPyDPjCVGj9+yh6SHoBl/UCKK8htEP
 GjWx4dTj2kujJqNIXYNyHfJB1/CFaiBJkrHlNhE+vEo/7rmCWAWKOiT/7ceJHpUNMDO2
 AkiRT1g7WDdS5Aq612fuaF/cDI4cCYmAxACHulmrv6AsvSKss3vu5mbAddTay4AIGBYS
 96KXqIj6RuOQmjvBWKYm4+ClokuufpxYL8jKkqEtPzdaFwWYa0Ml6i3T0Gqc45pRYLwN
 Z/XOnERfTkSr3/TaUM0zoP3MbMzYXj8pQPMOf4lW8JVy/qVSItD+SJkHILxiVEkK9dzV
 +sHg==
X-Gm-Message-State: AOJu0Yym7i8z0Hb4ufKV3kOCBnzoVHUJBC/9hooSKpji+M+e3DMvoejo
 UiCe2IjiUlymOkAkfxrzTjAWvhkuGWku9DIwbKHXsA==
X-Google-Smtp-Source: AGHT+IHSQpEByLPlA14r/3u8EGey3Q+dfk7YN0DvhQy/s1dZ8ruaPAXtECCEOwYR69Ri7Kx8/eMBtoLQOxk1x3PvoUw=
X-Received: by 2002:a05:600c:468d:b0:40b:5e59:ccc1 with SMTP id
 p13-20020a05600c468d00b0040b5e59ccc1mr4432596wmo.162.1702499968531; Wed, 13
 Dec 2023 12:39:28 -0800 (PST)
Received: from 480794996271 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 13 Dec 2023 12:39:27 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20231112182255.GF6601@bill-the-cat>
References: <20231112182255.GF6601@bill-the-cat>
 <20231112152754.130399-1-sjg@chromium.org>
 <20231112152754.130399-2-sjg@chromium.org>
Date: Wed, 13 Dec 2023 12:39:27 -0800
X-Google-Sender-Auth: Hw5yu_0bPG8Dgmdf4m7ANJCSy38
Message-ID: <CAPnjgZ0w7e8royzbbsh=JD-jjq=yZtM2_ooO6a9ZgmHVB74pDw@mail.gmail.com>
Subject: Re: [PATCH 1/7] boot: Drop size parameter from image_setup_libfdt()
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Sean Edmond <seanedmond@microsoft.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Eddie James <eajames@linux.ibm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>, 
 Sean Anderson <sean.anderson@seco.com>,
 Tobias Waldekranz <tobias@waldekranz.com>, Simon Glass <sjg@chromium.org>
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

On Sun, Nov 12, 2023 at 08:27:44AM -0700, Simon Glass wrote:

> The of_size parameter is not used, so remove it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Tom Rini <trini@konsulko.com>

-- 
Tom

Applied to u-boot-dm/next, thanks!
