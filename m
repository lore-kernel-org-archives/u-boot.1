Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66506C27C75
	for <u-boot@archiver.kernel.org>; Wed, 12 Jun 2024 20:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 378AC8886B;
	Wed, 12 Jun 2024 22:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LbjoPALo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A722F88861; Wed, 12 Jun 2024 22:24:48 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 62AF3885CC
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 22:24:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-6e3741519d7so187545a12.2
 for <u-boot@lists.denx.de>; Wed, 12 Jun 2024 13:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718223885; x=1718828685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TLN8OWHoOAf562jAMksjPHmWWCFtmYCSkbKAT46QIAc=;
 b=LbjoPALol/rk8bjySmkeWDZpeSWST95PWOG8h9WhgOnZEdVzdkYnKkvXYXIGHorxTs
 mt8Eg62vGL0zx3L0XXOiFEEkczCoXPIf0LC9EGz5R2/BXM8SleieYyJWGHqSGbw8kyH5
 2+eSsqPe2/X/9FXTljE46f32w7/7mOLKOCU0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718223885; x=1718828685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TLN8OWHoOAf562jAMksjPHmWWCFtmYCSkbKAT46QIAc=;
 b=ZS3LkJ0hvpPsiGHgfnVMqnnYIVkWNAphK1qbxrR3xQAdN1HOHx+wsrhh22EgkhFmMX
 sQOcHKJyTd6cT8SdLgIxULLPdmSnaMqaum3yW0tXPe1WGxCW/2djSk3S8gMCG2Eeahg4
 Z7agTSsq0lmMoc2cqBXaZHaZXiwPKTSRh71NTsAEctBT/7oNXTlGXOFxrwV1kp7ZaRig
 CTy0vdFmLiv8ZOF6YS0oEMf/XXgNuSBwyUzfmNrwu9d9LqJY176LhQzy93mW4zVKWa1u
 XDTjMFptT4UNcUyJy9jxUGAsthzQOgOx2C04vcu/pYfU35b1ySLbpOyiNQozHnwCLVkn
 E/pQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgfZS8RKZNO3lBzQ88lsBdbp1LsD7aRhVn0tSh5DMQfR8eSSOHAaIoqvrWr9DuB/GMU+ERqauRB+mYfLpnEG9Iz8OJ1A==
X-Gm-Message-State: AOJu0YwonKicEYF9z1whhRSqd6j6JVsjsv7jBiaLhgwWUnHtwtPLtZJZ
 QaYNeokz+fzCA0qGTFZlkVHO4RDNv9cX/QljiqXzw3ZD1KYtEAdYJuZNJN+Hwb2q6sAtWw2UKhl
 ZtrzygdbvRqzhTEejHVbaSQ1rDCZlThPWc5pF
X-Google-Smtp-Source: AGHT+IHzmNqZEbdHNze2VkKJOC+yuirW1jwpRzQBnD2CzmA6iRnO6Ap/NegQx1yn3mHUoq/SdqXxEBAyUDElj/6WSE0=
X-Received: by 2002:a17:90b:214:b0:2c4:aab1:17f2 with SMTP id
 98e67ed59e1d1-2c4aab11960mr2501669a91.37.1718223884921; Wed, 12 Jun 2024
 13:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240605032521.1142768-1-sjg@chromium.org>
 <20240605032521.1142768-3-sjg@chromium.org>
 <21ec4fcf-0a17-46c6-ae18-6787366e99fa@gmx.de>
In-Reply-To: <21ec4fcf-0a17-46c6-ae18-6787366e99fa@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 12 Jun 2024 14:24:30 -0600
Message-ID: <CAFLszTiA4RKUkTxwu528sRmTUa2gbtNN90q_-Y7rteXftqHojA@mail.gmail.com>
Subject: Re: [PATCH 2/9] tpm: Avoid code bloat when not using EFI_TCG2_PROTOCOL
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Sean Anderson <sean.anderson@seco.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
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

Hi Heinrich,

On Tue, 4 Jun 2024 at 22:15, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 6/5/24 05:25, Simon Glass wrote:
> > It does not make sense to enable all SHA algorithms unless they are
> > needed. It bloats the code and in this case, causes chromebook_link to
> > fail to build.
>
> Why would chromebook_link fail to build?

Because U-Boot suddenly grew a lot due to that commit. It broke out of
the bounds of its SPI-flash region.

> Is TPM used by U-Boot on that board at all?

Yes, but only for tests.

>
> >
> > Add a condition to TPM to correct this. Note that the original commit
> > combines refactoring and new features, which makes it hard to see what
> > is going on.
> >
> > Fixes: 97707f12fda tpm: Support boot measurements
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> >   lib/Kconfig | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/lib/Kconfig b/lib/Kconfig
> > index 189e6eb31aa..70b32362ada 100644
> > --- a/lib/Kconfig
> > +++ b/lib/Kconfig
> > @@ -438,10 +438,10 @@ config TPM
> >       bool "Trusted Platform Module (TPM) Support"
> >       depends on DM
> >       imply DM_RNG
> > -     select SHA1
> > -     select SHA256
> > -     select SHA384
> > -     select SHA512
> > +     select SHA1 if EFI_TCG2_PROTOCOL
> > +     select SHA256 if EFI_TCG2_PROTOCOL
> > +     select SHA384 if EFI_TCG2_PROTOCOL
> > +     select SHA512 if EFI_TCG2_PROTOCOL
>
> You need to consider CONFIG_MEASURED_BOOT which allows measured boot in
> the non-UEFI case.
>
> Please, take into account
>
> lib/tpm-v1.c:20:
> #error "TPM_AUTH_SESSIONS require SHA1 to be configured, too"
>
> This #error should be replaced by a Kconfig constraint.
>
> I would prefer the select statements to be in lib/efi_loader/Kconfig
> under EFI_TCG2_PROTOCOL.
>
> @Ilias, Eddie:
>
> Why do we require SHA1 which is considered insecure?
>
> Shouldn't we change tpm2_supported_algorithms[] to include only
> algorithms selected in the configuration? This would allow replacing all
> the select statements in Simon's patch by imply.

I attempted that in v2.

>
> Best regards
>
> Heinrich
>
> >       help
> >         This enables support for TPMs which can be used to provide security
> >         features for your board. The TPM can be connected via LPC or I2C
>

Regards,
Simon
