Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6D4C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 11:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D1E558215E;
	Wed, 30 Apr 2025 13:57:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="eFKN4bET";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC40982B19; Wed, 30 Apr 2025 13:57:07 +0200 (CEST)
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DBC482153
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 13:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-6feab7c5f96so63482337b3.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746014224; x=1746619024; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uaHLWPqbS0Lp5Weo6MKDXHdQomqoIRglrF8enHZ9Qmw=;
 b=eFKN4bETSqSpKejiF6gyb527CjB5F4rXRklZbAEeCg/mvKUWbOtzE1KNhOq8bUWLof
 fnkB/8ndN0M+cubbGa1+3cWymzcT32JTUuMyX5HGMelv93MsOCfkgB9lCZ/SJ1NfbY24
 YvudCoJnD4dwuv1fIUMffABrs0Fxq40zTM2ExiqWXmfbukoTyyujLK7jAtNwP4rEqXTV
 zmDNaye1jWMlvFYpqzalDWjUQekOSnhqCIdfme+cCpokLC9sdy7JLHrYTFQQrrbd/TJq
 RoTBWmfd/0EvXF04n/iZ9EcAQZzGG2CiDL+lSEv3fN8WB7/oFsuiY4XmoEC1IP5aiJpO
 r+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746014224; x=1746619024;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uaHLWPqbS0Lp5Weo6MKDXHdQomqoIRglrF8enHZ9Qmw=;
 b=quMv1btCf5x7ftGBOSItRFBP4ka9/JFdVbOnVywIDy7a/X/4apohzDeP/Y4fb6yv5R
 L3sYLu4wV7S2ITNa/cC5Sbk5Xi7tUFqocqaDw1QsclKLMKHx+AdvIP6Kw8g/93hQkd6T
 jGxD2pVrBk0UI5NeF590Ab52jSSsSz40ps1dNoPdAyXmcqTU3N9NYPK78qYoJTt6GMhz
 HzMUHt5Wr7JUmbzCPF49G9IzORihYX1UTC4RM2mDuzpwnprqFbVfFB5dmr5wJYrrccbQ
 Fzvgm3pJYHBrK4+ZWVkuCvk+t1d16WyfXDLF/COXCmQH9O0dnjyhMeAKfMjapkQAHqtB
 aC+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrQZQwt6aguOc4I/uS+PJnbyArwLuO7jamMiAPHm0mV3ISWL9x7GwUXecGn2iVyqqOGuENHo0=@lists.denx.de
X-Gm-Message-State: AOJu0YxGzkoYw6Q76vwMlYbf7MPEWtIq4MynrMmDpD643mBkReS9NV6v
 MG3cml2paFUwc6Nr1cjQI514fC2MYHvCGsM2tAS7UK1gTihZkVVtiI2mnEFW5LfORN1rgBJYABN
 n24/GklSYK0IB3Oha/Ddu6+1mMhHTXIVvafJkXQ==
X-Gm-Gg: ASbGnctiHc7DssaMFCiwE+9GgyrFXJXHVPdErkgvKMN4LKNPKXCeTXo6zsYKK5jV1PR
 0JTCtVCLcIbxTOsbP/Rt0BA5N1cOj725pcpPWvxmMviWIO2526LVOzT9OV/3+TcW9iFzCQihB4i
 WOazFXr0VDyLx9OzDPQ6bbAJOAynNKPsT0sQ==
X-Google-Smtp-Source: AGHT+IFcGI1+cBjkV3Ia5sxu2wmTeOus1cnxAgDAyhV9yvFv6KrNg8phy1cTQqH2XZcZhQSfwz3gyn1hcqVTrCbFa6Q=
X-Received: by 2002:a05:690c:48ca:b0:706:ca86:d79e with SMTP id
 00721157ae682-708ad61d354mr30105197b3.19.1746014223858; Wed, 30 Apr 2025
 04:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250429132756.2105309-1-adriano.cordova@canonical.com>
 <20250429132756.2105309-2-adriano.cordova@canonical.com>
 <5516429f-074e-4ae6-bd7d-d49f020eae4a@gmx.de>
 <0aba7595-018d-4288-a8d4-a262da9a4580@gmx.de>
In-Reply-To: <0aba7595-018d-4288-a8d4-a262da9a4580@gmx.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 30 Apr 2025 14:56:28 +0300
X-Gm-Features: ATxdqUFUDLR5CTHydkutha1kaEwGD1ZJ47epbHuo1InLdNhvK7l42eqazRMdwE0
Message-ID: <CAC_iWjKKkyT6Yqi8KLMY1R1+A6f+TYcVOdBOvcenRixGpdcPNQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] efi_loader: bootbin: do not load an initrd if none
 is provided
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Adriano Cordova <adrianox@gmail.com>, sjg@chromium.org, trini@konsulko.com,
 o451686892@gmail.com, Adriano Cordova <adriano.cordova@canonical.com>,
 u-boot@lists.denx.de
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

On Wed, 30 Apr 2025 at 14:00, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 30.04.25 09:03, Heinrich Schuchardt wrote:
> > On 4/29/25 15:27, Adriano Cordova wrote:
> >> Do not try to create an initrd device path nor try to register
> >> an initrd with the EFI_LOAD_FILE2_PROTOCOL if none is provided.
> >>
> >> Handle initrd installation in efi_binary_run_dp with
> >> efi_install_initrd, imitating what is done for the fdt.
> >>
> >> Fixes: 36835a9105c ("efi_loader: binary_run: register an initrd")
> >> Reported-by: Weizhao Ouyang <o451686892@gmail.com>
> >> Signed-off-by: Adriano Cordova <adriano.cordova@canonical.com>
> >> Tested-by: Weizhao Ouyang <o451686892@gmail.com>
> >
> > I built and installed U-Boot for the StarFive VisionFive 2 based on
> > origin/master plus this series.
> >
> > I created a FIT images using the its file listed below.
> >
> > I loaded and tried to run the FIT image:
> >
> > StarFive # load nvme 0:1 $kernel_addr_r initrd.itb
> > StarFive # bootm $kernel_addr_r
> >
> > and saw the following failure:
> >
> > ## Transferring control to EFI (at address 00000000) ...
> > Card did not respond to voltage select! : -110
> > Booting /initrd.itb
> > Not a PE-COFF file
> > Loading image failed
> >
> > We use the entry point instead of the load address when transferring
> > control to the EFI sub-system.
> >
> > This bug was introduced by ecc7fdaa9ef1 ("bootm: Add a bootm command for
> > type IH_OS_EFI") and is not related to your patches but we still need to
> > fix it.
>
> Addressed by:
> bootm: pass kernel load address not entry point for IH_OS_EFI
> https://patchwork.ozlabs.org/project/uboot/patch/20250430105546.327442-1-heinrich.schuchardt@canonical.com/
>
> >
> > Afterwards I tried to boot into Ubuntu and got:
> >
> >    Loading Linux 6.14.0-13-generic ...
> >    Loading initial ramdisk ...
> >    error: failed to install protocols.
> >    Loading device tree blob...
> >
> >    Press any key to continue...
> >
> > It seems that U-Boot did not uninstall the LoadFile2 protocol when
> > discovering that the EFI image was invalid. We should have a look at the
> > error handling.
>
> This issue still has to be resolved.
>
> >
> > The initrd for my test case can be created with:
> >
> > echo 'hello world' > hello
> > echo hello | cpio -o -H newc > initrd
> >
>
> Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>

With the same remarks as Heinrich
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
