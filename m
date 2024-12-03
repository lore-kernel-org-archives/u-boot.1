Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A123E74ACA
	for <u-boot@archiver.kernel.org>; Tue,  3 Dec 2024 19:40:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23DA489691;
	Tue,  3 Dec 2024 20:39:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cOljMEAv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1E0C89685; Tue,  3 Dec 2024 20:39:40 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DBE78967D
 for <u-boot@lists.denx.de>; Tue,  3 Dec 2024 20:39:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-aa530a94c0eso955319566b.2
 for <u-boot@lists.denx.de>; Tue, 03 Dec 2024 11:39:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733254777; x=1733859577; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ljte5WEDbpw+8OwfV16rpDQeGx6ElfeAjMSSLbIMqOM=;
 b=cOljMEAvnOaTXZHELHxWub07COuGAKkjIqIVR9BRi7lxCFQV16XGWeTEPsusnGSs/B
 hdJm7iPqr+YxagBM7phH5V1sXOPzOXPDnEAQik46+cYuTJIHWMiljDwnMTq527JgPU+r
 +GqmA9ExRJgH7ZRimMPPYmKN+Dd59xgkDQ5e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733254777; x=1733859577;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ljte5WEDbpw+8OwfV16rpDQeGx6ElfeAjMSSLbIMqOM=;
 b=i54mo2xV0YJOQ/p0z57ZD5qrQwoz26KsGANEn/7ci1ErdSGGfN3vEo7f2CmVKssQs1
 Ayi/1xasS1QHlH4iMoqBfE5sKCm8bXGBs6TCk/lr7oLEjBfuaKvOzbiKERRbfz3mKTbg
 SR7tUzlVz3R93ftoEKJ5p3c0zE6nK0ZtZ+NSbLH72MIHHNFOFh6/28A8ESrYWe4uUP9H
 F4HU5CRfE8zaAZxdZOjE0MLwmerPvlNeJ1uOEbgJRNITbARjO/TNSPMmNDH+ZaNEuts/
 M65+ExSgePfRrfSRpIhiMLU3tCCdYpudcjHKAwywlu1gnRMZ60Gz46JHiXfE4EbdId7H
 2ueA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLUb1h7NxGGW6v2Fgl82q3/deI6SuS0BK4ubzPb2oUn3ier0p3x/dH1L2stF3JAr6hALQibAc=@lists.denx.de
X-Gm-Message-State: AOJu0YyoPz3AgJurv9YbXDlDxG1BVq1EwzNTgyFVs3MHGbdQEBUynrH6
 JbsQ/kwp8u4GMLoELqiN0Ed2nLyfW4rXgc0YQUwxDfInKdBydnXD23zdoHTj9RSHORo4E5Jtu9s
 RGOLpnWGkghGRNHWd0e5SpPTQi4DX7NkAqkVW
X-Gm-Gg: ASbGncu9BA5QVd3q4/Mo1RmPNO3ZKddxp0HPh0jJSpvt0H1v1/JI9CdYnUl7ml4xyxh
 LN6dUqPn3P4Spp1avQDQCpMCWhuObNLA3
X-Google-Smtp-Source: AGHT+IE2MIdRo4cyla0nx136+4rb/0AWr0Jrb7T9K8SFwuS+TYC9zgklSlswH/1QoglJoFmKkzndnqa4mqd2tNeDP5w=
X-Received: by 2002:a17:906:32c3:b0:aa5:40b4:e9f8 with SMTP id
 a640c23a62f3a-aa5f7cb5803mr290198166b.2.1733254776973; Tue, 03 Dec 2024
 11:39:36 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Dec 2024 19:39:35 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <20241103003322.626036-18-sjg@chromium.org>
References: <20241103003322.626036-18-sjg@chromium.org>
 <20241103003322.626036-1-sjg@chromium.org>
Date: Tue, 3 Dec 2024 19:39:35 +0000
X-Google-Sender-Auth: UzOPDYenXAWOYVv5LhQEXkT23s4
Message-ID: <CAFLszThT6BaNV41aTp5AUcDbz26sdqkreTSjdZcaa86UWgOWhQ@mail.gmail.com>
Subject: Re: [PATCH v3 17/25] igep00x0: Drop unused status_led.h header file
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Javier Martinez Canillas <javierm@redhat.com>, 
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

This header file is not used, so drop it.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---

(no changes since v1)

 board/isee/igep00x0/igep00x0.c | 1 -
 1 file changed, 1 deletion(-)

Applied to ci/master, thanks!
