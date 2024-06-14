Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9958C27C77
	for <u-boot@archiver.kernel.org>; Fri, 14 Jun 2024 06:04:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAC508896C;
	Fri, 14 Jun 2024 08:04:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XtGilA58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1807F87DD3; Fri, 14 Jun 2024 08:04:00 +0200 (CEST)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9A748896C
 for <u-boot@lists.denx.de>; Fri, 14 Jun 2024 08:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2c2d25b5432so1444325a91.2
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 23:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718345036; x=1718949836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NXvX3tSy7bS4bN3272Ma0e90QCgTzWRN1j+IlnKurrg=;
 b=XtGilA58DUBHP7NLX/hfWo+bbzU3u0Stx/Coyv/zMIOF3FNQCdTngayXiarcPMp2aA
 4WogavT7IIWnFfqYSGFq4HPM9E3sGGUESBBm0jLIMf8Vcv651ommhhpYmZU4DnYPgXZd
 eMT+GF1SfSe6suT88j/2Wp95l2nxa+27uDIVTqhOnB7biAj+dLbmsgPiE/wZUEbA4fQO
 2SMPbDKotYvSc+mRb/EtF/NeTU20IroRjRvHOJlWrYRlXYrGo7b3ygJepFQvq9kcZ8YA
 WMXfR1YLiF5mnVOTO+TxJxWu4MrJwPYGgzDAOhZXpNK053QcWGKp230HqXVB1pEavntv
 Hrvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718345036; x=1718949836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NXvX3tSy7bS4bN3272Ma0e90QCgTzWRN1j+IlnKurrg=;
 b=UDTPTAxtvPMsKbgRvyMp6KVbHWYjJiiNg4yWDkXV5Ow9B9lKh5XCKNmZxs3H/wsRC0
 rH2t30SKw46bDTU5vCVs0x8x7dO7B3lvlsGkFG70ClBms4NYS5ZnH6KLOSaYliFI06ME
 I4cGJmaKlH69eMqT5GCZCxQqS6l2gXEpRLPtBH6+lOoLcRDwWCf0O1PDVJSfcPF8vYie
 3YfJRX7DsQhEz5QWG3gPEoctLCduc3SZCv/8HJYQqFnIVkVza9ucq9/b6cvK82+ffumQ
 RoUC5TwOEZQ5wlhmxdpm2qJ2npdLYvJcSfSrsW2uv1HiEQHlzmkNgOfMdzy1M8eXNd1N
 uAkg==
X-Gm-Message-State: AOJu0YzCX66vaJ3pl4sDyE0StaXm/9Rj3T6T1oL3GijXwC4Z5w4LklP1
 BDclJ6JwdE45Sk5Dlo6NbmSh6xBob02ABTTz6PF9xxg9fPxGwdZLp17+HfCsCvCFWlTAP/E7lZ4
 VZtghvClL360TTtDIO7k0hMUeZs4ysjiFdCRSUg==
X-Google-Smtp-Source: AGHT+IEQWfgTJAX7P8RZ1ThFfiiBMKufMXiQuC4uufi7BdlNhw3gNdw9lShGvHL7PhxDXOuFhXt0Jbz88MNdbjKd2+4=
X-Received: by 2002:a17:90a:a10a:b0:2c4:e2a6:dcdc with SMTP id
 98e67ed59e1d1-2c4e2a6de95mr788430a91.13.1718345036149; Thu, 13 Jun 2024
 23:03:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240610145920.3302001-1-sjg@chromium.org>
 <20240610145920.3302001-3-sjg@chromium.org>
In-Reply-To: <20240610145920.3302001-3-sjg@chromium.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 14 Jun 2024 09:03:19 +0300
Message-ID: <CAC_iWj+fSRt2E3ZcHaXrKjC+Gz7LZu_EWgiegWG3F1MJMJrPNQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Eddie James <eajames@linux.ibm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
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

Hi Simon,

On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.org> wrote:
>
> It does not make sense to enable all SHA algorithms unless they are
> needed. It bloats the code and in this case, causes chromebook_link to
> fail to build. That board does use the TPM, but not with measured boot,
> nor EFI.
>
> Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> add them to MEASURED_BOOT as well.
>
> Note that the original commit combines refactoring and new features,
> which makes it hard to see what is going on.
>
> Fixes: 97707f12fda tpm: Support boot measurements
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Put the conditions under EFI_TCG2_PROTOCOL
> - Consider MEASURED_BOOT too
>
>  boot/Kconfig | 4 ++++
>  lib/Kconfig  | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/boot/Kconfig b/boot/Kconfig
> index 6f3096c15a6..b061891e109 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
>  config MEASURED_BOOT
>         bool "Measure boot images and configuration when booting without EFI"
>         depends on HASH && TPM_V2
> +       select SHA1
> +       select SHA256
> +       select SHA384
> +       select SHA512
>         help
>           This option enables measurement of the boot process when booting
>           without UEFI . Measurement involves creating cryptographic hashes
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 189e6eb31aa..568892fce44 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -438,10 +438,6 @@ config TPM
>         bool "Trusted Platform Module (TPM) Support"
>         depends on DM
>         imply DM_RNG
> -       select SHA1
> -       select SHA256
> -       select SHA384
> -       select SHA512

I am not sure this is the right way to deal with your problem.
The TPM main functionality is to measure and extend PCRs, so shaXXXX
is really required. To make things even worse, you don't know the PCR
banks that are enabled beforehand. This is a runtime config of the
TPM.

 So this would make the TPM pretty useless. Can't you remove something
that doesn't break functionality?

Thanks
/Ilias
>         help
>           This enables support for TPMs which can be used to provide security
>           features for your board. The TPM can be connected via LPC or I2C
> --
> 2.34.1
>
