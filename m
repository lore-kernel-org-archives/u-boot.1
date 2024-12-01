Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878B0D49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08F6E8966F;
	Sun,  1 Dec 2024 17:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iG1Bqyuz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CB6D89491; Sun,  1 Dec 2024 17:13:24 +0100 (CET)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com
 [IPv6:2607:f8b0:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14C5D89615
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7250844b0ecso2746462b3a.1
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069596; x=1733674396; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TZOuowSXBc06uIWsjo1LV2J/D1m80+FMWKzR8oAR+1k=;
 b=iG1BqyuzvkDhjhQVlTBoSRDkbFeTlCmnofALysTC43MCz4DTO7/qzwkoDSGUtYpz8z
 6DHeiZ84/d9iK6kvkFAcWbQ1mhNhivbjzwnhBYCJFNFpPwwb/5Sxy1pvmdxSuDFs8ez1
 HOpBENUZJcvUqWOuI0qJPubN++EVU1+cTFwU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069596; x=1733674396;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TZOuowSXBc06uIWsjo1LV2J/D1m80+FMWKzR8oAR+1k=;
 b=oBEflAQRcxyS9q6h+htIodPfsQEJ0/SDY724MVTqg6hZi+eiLjt+zoY/XQM5nCI+0W
 roAcTSRf2lMWvxuEuzbLBTjCGLvPf+aECccQpvD3D4PwEkC1a6t3ao1X2c69GZF1yf1l
 N0sm1n8AGwgA+NeFjsiMFA+wsgqYmvZ4xLYXbAzrnjXV/+sLvc8L1eTosyBp4ptmeyHg
 r/B1YoTgzHVPp+lXm49v+pLmeY2V5UnodBJn7GQ5zAahU+15Ulbuiv7RuEPUQ2yriLdC
 od4AdxyWEiI+eAX6KPMH6C8ERB/FQTc1ljVOOVKb+DaUF36ADjHN729HrLVAZITMcK/U
 89mw==
X-Gm-Message-State: AOJu0YysxWfSSUobgOurAbXOH8bd90jNv12E6eCBjV1uXb2sw8yVQPIE
 odzacoostW2DZRZ8jlKmerSEO98+R4BAOHzSk7t5Msjs42Sdwx8Q0X03caOEymL4OO/8h6/lVO2
 AIAGLpSdrYUETWATzGl8GrpjNJ8gu9+dS9G//
X-Gm-Gg: ASbGncsfNZHQ/EDvPpcw0r2uGjPJ0/2RhxI0Dz0eL36cHr2uO5HEA1AqH9LYVRKBEIP
 f85khIv0SpneFCjuZZiX7by6b+H0dtw==
X-Google-Smtp-Source: AGHT+IHB2EAgXQo5+GqYTe4TYS73hoeOYPxJ9wCFE+zCT6AP5RYu7N+6hN8jcVPR6uqU+lUuU5Z3GKKmaDkgW/Ls8V8=
X-Received: by 2002:a17:90b:2882:b0:2ea:4e67:5642 with SMTP id
 98e67ed59e1d1-2ee097e33abmr25336866a91.33.1733069596577; Sun, 01 Dec 2024
 08:13:16 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-5-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-5-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:12:41 -0700
Message-ID: <CAFLszTge=ZUqn6WbC-ys-qfrc+8=0pJyJTMKCsrLC4ZzMQ62Hw@mail.gmail.com>
Subject: Re: [PATCH 04/10] Hook up EFI env variable support in the EFI app
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Tom Rini <trini@konsulko.com>
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

Hi Matthew,

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> Add simple support for accessing EFI variables when in EFI app mode
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  cmd/Kconfig        |  2 +-
>  lib/efi/Makefile   |  2 +-
>  lib/efi/efi_app.c  |  5 +++++
>  lib/efi/efi_vars.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 51 insertions(+), 2 deletions(-)
>  create mode 100644 lib/efi/efi_vars.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Again this needs doc/ and test/env

Regards,
Simon
