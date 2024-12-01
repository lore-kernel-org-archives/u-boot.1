Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C227D49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:14:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65FDC896D9;
	Sun,  1 Dec 2024 17:13:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LlqFMK5C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5353289637; Sun,  1 Dec 2024 17:13:38 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE27982BA7
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:13:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ee8c72b52dso599519a91.0
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069611; x=1733674411; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=raEVFxbKq4QbbOVu6D5u2txGHPB43E+6yTgoUH3Reh4=;
 b=LlqFMK5CjlDwq2s0G77J/w/xq0gkf4nwAvc+5oZmoWr4O9XVik2UghOnFJs7tFygK5
 C8E2yciGVScSWdW+QUJoJZIq3kvio9iKRdzO2wW/kxyzFU2R9HVU/sDbWwfS2WIOyN3M
 FH5r44pAOZ1NwUpIy7PNzK06yZZr8eG0/bduo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069611; x=1733674411;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=raEVFxbKq4QbbOVu6D5u2txGHPB43E+6yTgoUH3Reh4=;
 b=aeFgM9jaqEYiEW0lGndIBcp7u7xbXDjQbwxjJMNBPZrH6pBwBjRu5qItl2Kwngmaed
 AC8zswykgQDU2XHUfcGqVNWbIVhnTMJaIHLBJ4b87GWr4Hq9+qHcxEAvMttawpZ3ARQK
 0l/Y2grItWz6gw3q0ZPDKDS3SKej1ujzC8l2JVNxuLXDBsH/dErC6uZgTt5zOPIoJZ4H
 y+EGru0rZiArqMZJEpc6uuCEEg8lTTszD14AcRaJ/eFadWFB7Jl2tuaKMkcecw5Xf/9P
 vBIjhEvajyanrQG2UhExb6PERFCgOxX5z2w2liPKvu7p0W79RivVr8yCHJuCzrEtQIfO
 AYLw==
X-Gm-Message-State: AOJu0YyDGVBppn63IuLM4pJdM41kH0DxDfEiNkuC5PM1LSn9wjn6Fqmm
 wPZm9mEvAXotrBjg+mKrotu6FSh9pneLbFFuHRFfmxFDdRKwtMKlWBXiqw5w+IeQmYpiHyTACxf
 6rkXux/Xaik3y+KNOfFcgPz3tUi8+r0LpYvm0dTbLIWctIp8=
X-Gm-Gg: ASbGncuj8GPJDgdvhGGcUcTYCZPklafNOlnOq6S6VNoAqC+BPz6XBagUf5rXAuk5dB9
 PJR3jWeJ2bjyWEwcwDKa00/EG9NKpRA==
X-Google-Smtp-Source: AGHT+IEnNnlXbkl6jau337usR6WtgI+4qh3t6CqGdaP3HYn4iHYQ5zTs/g+8EJgV+b/C2qdWEvYkYYb2MXPig+G6FJA=
X-Received: by 2002:a17:90b:380c:b0:2ea:c096:b738 with SMTP id
 98e67ed59e1d1-2ee097bafaemr22359789a91.28.1733069611408; Sun, 01 Dec 2024
 08:13:31 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-7-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-7-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:12:46 -0700
Message-ID: <CAFLszTimTEbWNJSbm+A+gWZnpGy0wrvqgr6s57q+nOz5W0ARAA@mail.gmail.com>
Subject: Re: [PATCH 06/10] Add UEFI TPM2 driver
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, 
 Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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
> Add support for driving a TPM via UEFI firmware provided drivers, and
> bind those devices from the UEFI app.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
> ---
>
>  drivers/tpm/Kconfig    |  7 +++
>  drivers/tpm/Makefile   |  1 +
>  drivers/tpm/tpm2_efi.c | 97 ++++++++++++++++++++++++++++++++++++++++++
>  include/efi.h          | 11 +++++
>  include/efi_tcg2.h     |  1 +
>  lib/efi/efi_app_init.c | 69 ++++++++++++++++++++++++++++++
>  6 files changed, 186 insertions(+)
>  create mode 100644 drivers/tpm/tpm2_efi.c
>

Reviewed-by: Simon Glass <sjg@chromium.org>
