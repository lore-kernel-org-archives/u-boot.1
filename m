Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E206DE77173
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43CD589589;
	Sun,  8 Dec 2024 16:29:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="UjRD5XC5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D321689578; Sun,  8 Dec 2024 16:29:28 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA8DE8958B
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aa6332dde13so337380866b.1
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671766; x=1734276566; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aQ0IWH+Lm2ASRrR9jlSJk6LOP0SN4aNNJokc1OWQtXA=;
 b=UjRD5XC58QjEBFHM0PoEHW3YKmLmGlm+5X9nrwvdLbdWljAfym+rDYuKdTvIuhzg3/
 zQ9mn/v0vSvhvb6dcAyw1C9jd6uxcjc6yIq8TM+0dRSEEQVwW5AVHQ1uY+jVrSKyJfbE
 QIjOEaBuJ16u41sJ8iqVZKDJBnYivKQfCVyZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671766; x=1734276566;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aQ0IWH+Lm2ASRrR9jlSJk6LOP0SN4aNNJokc1OWQtXA=;
 b=KcxnjfYBOThaYIHz9ukiycelHDW4OlxaTcHeQdKbKbRShsG7Fp3gkzH5KCdiS2ZHpr
 MRJ2DNrAnWctGfUQ9HOsC5pfaQeYfnbwLhylLSm2FhtyXLLG5GQOu4dVw9StRK64ioCq
 cHZAxukLizkC+U4q6mepZX7JzEhS4rkBUIaDwBw+JOXiohYMK0wH8ko04lUQWswincOV
 3xmY5YRRW8mGRNBYznlVPWWFyV/DqnWRTq17n8xc/VBFJ5JCPwqF6TfSToT1HuQksPto
 PPgN2qmg9+3vE7KiGUCrPlpPU+Da8nfLMI1e+UHXT4bIhH+wS7DZEvDuyGe+XnIBs6eI
 QbeA==
X-Gm-Message-State: AOJu0Yyu+L6mzkfXVxZCoIoM7iiIsEJcVoMWufZnxyEZWPvu2sgdHWhp
 pvvG63RL9P/xwyA4lz5a7F1MsLSLrxxiPqMFfb9Tgi7Ir5tWhoY7xgf168TDt+0pizNqDUHqEQU
 sKPXX2cmGxug62tQ5n1s5xNA104fHLTMA2JZO
X-Gm-Gg: ASbGncvrmgg0zsZl9fPabipsGxDqU7+Oeu//UISyrJzFSUq0I6s6NrhDheEQkmFGTWa
 u2jVL30VsUsx8yy/D/6LamkfwTS6OK0TQ
X-Google-Smtp-Source: AGHT+IGo5CqMV1AenoDQDoi3EUFUb6oQKfMj4KSx/aO+YY75YB615+7xwqjqdtyLZBP/fFNX79rKKi9zUnLdLD8YcE4=
X-Received: by 2002:a17:906:3152:b0:aa6:7cae:dba7 with SMTP id
 a640c23a62f3a-aa67caedd78mr222413066b.4.1733671766387; Sun, 08 Dec 2024
 07:29:26 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 07:29:25 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTjCwT9+4KskDDjBYGB=04OTq5BwSyHBG+_Q-s=us_eGow@mail.gmail.com>
References: <CAFLszTjCwT9+4KskDDjBYGB=04OTq5BwSyHBG+_Q-s=us_eGow@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-6-mjg59@srcf.ucam.org>
Date: Sun, 8 Dec 2024 07:29:25 -0800
X-Google-Sender-Auth: 8ATQH1uorVc2tm0CLBe2R8Ozais
Message-ID: <CAFLszTh6XCi4VBiVLAMrRJ1ySYK4E+d15DgSz6=5NhQ-wCkyPA@mail.gmail.com>
Subject: Re: [PATCH 05/10] Add EFI network driver
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Christophe ROULLIER <christophe.roullier@foss.st.com>,
 Gabor Juhos <j4g8y7@gmail.com>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Marek Vasut <marex@denx.de>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Philip Oberfichtner <pro@denx.de>, Ramon Fried <rfried.dev@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Romain Naour <romain.naour@smile.fr>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Matthew Garrett <mjg59@srcf.ucam.org>
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

On Sat, 23 Nov 2024 at 12:57, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> Add a driver that makes use of the UEFI Simple Network Protocol to
> support network access when using the UEFI app implementation, and hook
> up the app code to instantiate it for probed devices.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  drivers/net/Kconfig    |   7 +++
>  drivers/net/Makefile   |   1 +
>  drivers/net/efi_net.c  | 110 +++++++++++++++++++++++++++++++++++++++++
>  include/efi.h          |  12 +++++
>  lib/efi/efi_app_init.c |  67 +++++++++++++++++++++++++
>  5 files changed, 197 insertions(+)
>  create mode 100644 drivers/net/efi_net.c

Reviewed-by: Simon Glass <sjg@chromium.org>

You don't need to include config.h anymore

Applied to ci/master, thanks!
