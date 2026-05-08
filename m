Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C861CD3445
	for <u-boot@archiver.kernel.org>; Fri,  8 May 2026 18:00:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B48B584DC5;
	Fri,  8 May 2026 20:00:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cvwb9hA7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D59C84DD1; Fri,  8 May 2026 20:00:43 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92F0684DC4
 for <u-boot@lists.denx.de>; Fri,  8 May 2026 20:00:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-67bc6098640so3593568a12.0
 for <u-boot@lists.denx.de>; Fri, 08 May 2026 11:00:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778263241; cv=none;
 d=google.com; s=arc-20240605;
 b=kCFZauE1kcKagc2IWRAux/GlvmtQv60csj0hJWo/rufe84o4jNmuTV7CceUJr8edVC
 JLNP4GglkU6zsW8r1fSn6ACg/NRbcFSeaIPqwAPPx3bwbftuGr4eJwCotT7yog8b5x9k
 Vmz+NR8eMtRjpycbeHdebcRfGUx82b7Sv+Ceyx+7kL93WENn7Jlc1Cdfmy4+0FdC9thC
 w0oqhyhhC/21IRLsFzdy0upDLpGi897CK9qnrcsl55KpImTc+a3BbcYTLnghZ20dMbTW
 qk2V/taWIIA1nqRppUsYHw2vqyCoebj7H69EuNtjM91HZSqbNWdXEs95bbutewX7b2IY
 KPyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=uHgB0PM/oIeYuL9Apmv93CxN58igKTdog90ZEY8YzpQ=;
 fh=sGQdnWdAHraC1/DPSA4yozf0ENnWEMVR1YzXGpwyI60=;
 b=VD19BzFqiOIxeqy/BrN/8zSZbamyBsrrNrMIUQ64JsZ5r1g98RKFs2IHRCNug97XCv
 S8UyI1iSpdOhzv0aq7MeOU5qKb0XyCtIyDuoIN6yQXq6MEhTkFUfxH66grD1a4GJhuIV
 xNbUvpWwAOy/VTyZJlo1XpOUQgE8Vvpm/gCMz/asieuJHHN24Wi3EZRwz2kXv3QBNhA9
 kHx7NfsSeAQ0PGYUe0L40uxI/EdJ6KOw0PV80G4gx93M5e0nNbnqDP3a2oZztHQbjkk8
 npvdb102yePAcsQLPJOP2EMopEXloDzrtUgWMIPSbHSaslP9C25nIp5Qs+0R0f28BoFJ
 E+SA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778263241; x=1778868041; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=uHgB0PM/oIeYuL9Apmv93CxN58igKTdog90ZEY8YzpQ=;
 b=cvwb9hA7yojzswIbMCus6RDHHrl1PaSz3PZO3r/bKWOQe65HhSkRTn+mqR6jQlrxNr
 J1ow2NjfyuXRB1qF+YiPi1g1NHd/YIxPEn/AUOZbqKYX1iPLwMvkebb7sg2M6EymLsKj
 arb0GpjmGNReIcdlxTAMBhhQB/Dv5cin7QlLTV2IuDySfRIUw6Pxk9/qiduZmnmqT4JC
 dg9UKwOAQbMWTNJTOz+K87DNJM2AJjk9FBnt/paZNBh0AqwnYBnNSGSvt3NEQK69yFKf
 ax2nMni2Nt090Sf2CFxXklV/UK+sasUTdNPZTMSctkMruRMcL9sK2GRMNBclRBWXh6of
 tNfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778263241; x=1778868041;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uHgB0PM/oIeYuL9Apmv93CxN58igKTdog90ZEY8YzpQ=;
 b=YtmvR1S+/sjN3GtFi7T2vpV6NI8xMv5O3cVgCZJps9Q5696xnemlpGYG5hagzW5/Vk
 +xDUZnXG64AVE8vslq6FzQCJbytr8g2zLr8vMOlf6yMGwRMvCXBSgP3sNIrhwNp4SU6i
 eWFD+X987XT64eaq5R86IVbEKFMPY8D3KwTfIZA7HAsmUf1Cj9m4kH9v9T0Ush5gbjzO
 lr+5ikdT3TqWaUI8OJf3Ii9C4pQTVRnY7S8oKgxJt/AiJgR1CyfRVnzD13rbNWr5puGT
 RrS89ETkCFvO+yy00Gsxek1AXjovzGpwrNoTPX9dZoyT1B1HSlIQRtvKcab+4Mx/oZ1j
 ySUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9zd/h1Z9qxgSPwars1xqNlJLmeeG9uNfPpYjC2k2QCPcDkNr2HKihd3mbILzAVX2mpUoq9jdk=@lists.denx.de
X-Gm-Message-State: AOJu0Yy8tlFUjWfgkhDXz1en66j0FNN2SZZded8DZkUSWjdBcbRntGCO
 rhYxl5XPfd+ZSmgM5W9ehAAe5aqD7RsiBpUdMxFINeVO2JfB7fli4H9rVZR2mEzq+hllz5DAnNI
 8xtAq7oo8XHDrXZPJxXPRq27e6IoKi/s=
X-Gm-Gg: Acq92OH6O2NVZPqRqmwyNxDQKJFkITId8PBbBubpzw2JnQDh56r4G3tmqUxITJS8/B0
 hwnk5xLkXMwKKpH2/ewFUVEtPMP6Tj6XHIb9QomggvQTFOwxo58M82pA1o86pfwQxZM2bUYjGQZ
 ZAS9mdhXtoWSOZvsghIFHfVIWA47myF0MMnhlVFKyTqYQExqzEBRh2+xQETRvOZtJQ44ePuR8ma
 msxvvGm4D4EVsU9RMB+ijFeI7bl05GVhtIN9tIr2OmnBk1A5MR35zRZlJI8ZPLMupnUEfcjrpmw
 3l1X3wlADj1gCNcDrnedJnVYu2/bqEZPdgStpqTpXW9DXFGJHJwVBmjtSF3ZhR9Wyo94Z26u4vi
 fIVYhma3BuBVocEIIZ8bD0xHeQtwJARQrlPPegPWJgYG3YjKYtPeo4cWxxovcjP4V4u/tE0BjdD
 0+
X-Received: by 2002:a05:6402:2749:b0:66d:d2f9:520c with SMTP id
 4fb4d7f45d1cf-67d645baa54mr7033007a12.19.1778263240700; Fri, 08 May 2026
 11:00:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260508154108.336B968BEB@verein.lst.de>
 <20260508154248.3532B68C4E@verein.lst.de>
In-Reply-To: <20260508154248.3532B68C4E@verein.lst.de>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 8 May 2026 19:00:28 +0100
X-Gm-Features: AVHnY4IfIuoodoNWOdH7ArgqcK2OtjroI2EYMDpYQXiFFNrx9lediwTw_TGrh1s
Message-ID: <CALeDE9M_ac4nNd1hpfbhk1a13pG2PNByN52ZehGrzDeedWyuMQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] configs: enable NVMe
To: Torsten Duwe <duwe@lst.de>
Cc: Matthias Brugger <mbrugger@suse.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Andrea della Porta <andrea.porta@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, =?UTF-8?B?SmFuIMSMZXJtw6Fr?= <sairon@sairon.cz>,
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

On Fri, 8 May 2026 at 16:42, Torsten Duwe <duwe@lst.de> wrote:
>
> From: Torsten Duwe <duwe@suse.de>
>
> Enable NVMe in the Raspberry Pi 64-Bit default config
>
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>
> Thanks to this series, U-Boot now supports the 64GiB address offset
> used on the Raspberry Pi 5 for those inbound accesses.
>
> Remember that the other prerequisite on Rpi5 is the PCIe support
> for bcm2712.

I am in the process of testing this across my devices, awaiting a PCIe
-> M.2 adapter so I can test on the CM4.

One minor nit, I think we should scan for NVME drives:

-CONFIG_PREBOOT="pci enum; usb start;"
+CONFIG_PREBOOT="pci enum; usb start; nvme scan;"

Peter

> ---
>  configs/rpi_arm64_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/rpi_arm64_defconfig b/configs/rpi_arm64_defconfig
> index 38af5029403..18f8213f3b3 100644
> --- a/configs/rpi_arm64_defconfig
> +++ b/configs/rpi_arm64_defconfig
> @@ -41,6 +41,7 @@ CONFIG_MMC_SDHCI_SDMA=y
>  CONFIG_MMC_SDHCI_BCM2835=y
>  CONFIG_MMC_SDHCI_BCMSTB=y
>  CONFIG_BCMGENET=y
> +CONFIG_NVME_PCI=y
>  CONFIG_PCI_BRCMSTB=y
>  CONFIG_PINCTRL=y
>  # CONFIG_PINCTRL_GENERIC is not set
> --
> 2.54.0
>
