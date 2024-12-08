Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE60E7717F
	for <u-boot@archiver.kernel.org>; Sun,  8 Dec 2024 15:29:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDB75895C2;
	Sun,  8 Dec 2024 16:29:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XgucDE+0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CE5989305; Sun,  8 Dec 2024 16:29:25 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4B6C89348
 for <u-boot@lists.denx.de>; Sun,  8 Dec 2024 16:29:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa629402b53so459501866b.3
 for <u-boot@lists.denx.de>; Sun, 08 Dec 2024 07:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733671763; x=1734276563; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Qde8fI3pXV3bQH+yMRj4B2nbWPmttREBb5Zdx70Lh7w=;
 b=XgucDE+0iLq+uEQwS4ABx0oUZSnK2+KV03QaA9lHDo7Cp4C8uOva6RrvgXDDYNfKWo
 dH1Wy7noCw5k/dlAa3tWK9B8vy/tSCG9MxUyzUNaRTaoIKjBgQjG/HwaUnwFnxtW2nwY
 HsgrtvJGFKj8XLW8P15UA9GZUqV2E2ymQxtDI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733671763; x=1734276563;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qde8fI3pXV3bQH+yMRj4B2nbWPmttREBb5Zdx70Lh7w=;
 b=WEdAuwGalmox7IcBxfIb+jerved1ulSfX//Ceby5ZCc0M6dkxRibAUPYLJNXiapGWd
 c/AdjNhGd8PCeBRCLb2i4RBiPv2AJgIIKJZxyg3BnJ9EIT4daI8wIBjSNd1W6kbPFk1e
 e9LnL4hjm3lR+jfSYlxnoiI3DAuRsdL94CsPZSG14WmDor+uKz2L8bsbd8cDUHrvFq4/
 qWL4oijxC3lNtys7j7NNvvDyqeimERdcT3DXMUx+e662p7VfRYFTH7GHI8j5LtUAtv0p
 c837gTxRY4I9av+Lk6wapykzzRL29iuESn+H0PFmQA9NSK0UvZwNd69TuKqWWbjXqf/2
 8DAQ==
X-Gm-Message-State: AOJu0Yx87ou1XYCS3FmvhvIiwQjjcOVTlGtxyOBsmwu18dMJFIQlyhR8
 ktE7MdewYSyouk9pK2C0mE048jC3NAkQX3ERjSJnCagRkwumqgy1rE7FA9kRHovReTvdxvcDCFv
 +1s9cOvxrTsbhvDb8osl6au1ZSlTNGFRAfaEG
X-Gm-Gg: ASbGncv1YTohn42qfPHIQIWbjn1tOt4asA+jaKFzzW9iMVzrUt4QWk7FkaNGKCzGXKs
 DWZzUNsVaF/KAxEDiwWnFBE353K9RyAot
X-Google-Smtp-Source: AGHT+IEdBAVAiH3jm7ntztMUnxNTwvhcfkIi7UEgS6OS+HbSQad2+dtEfgNby6b4j6gmqwBwpk38MNwwtlK7/YJcbEA=
X-Received: by 2002:a17:907:90d5:b0:aa6:82ea:69d6 with SMTP id
 a640c23a62f3a-aa682ea6a9cmr159550766b.18.1733671763170; Sun, 08 Dec 2024
 07:29:23 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 8 Dec 2024 15:29:21 +0000
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAFLszTimTEbWNJSbm+A+gWZnpGy0wrvqgr6s57q+nOz5W0ARAA@mail.gmail.com>
References: <CAFLszTimTEbWNJSbm+A+gWZnpGy0wrvqgr6s57q+nOz5W0ARAA@mail.gmail.com>
 <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-7-mjg59@srcf.ucam.org>
Date: Sun, 8 Dec 2024 15:29:21 +0000
X-Google-Sender-Auth: KLpB-Pvj6EA25mUhUhQkg0DOqgg
Message-ID: <CAFLszTgtMGa3j37Md5A1FKLLVJShvWSf47mTwZHEvr=1orxxQQ@mail.gmail.com>
Subject: Re: [PATCH 06/10] Add UEFI TPM2 driver
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, 
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

Applied to ci/master, thanks!
