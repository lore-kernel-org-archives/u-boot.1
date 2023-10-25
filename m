Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6611C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 12:38:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D41E087937;
	Wed, 25 Oct 2023 14:38:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XyCYlIbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1C80879D6; Wed, 25 Oct 2023 14:38:36 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2B9687488
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:38:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-507c91582fdso8315129e87.2
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698237514; x=1698842314; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ziqyJhN+GxlPYSY+gLugWy2G4/rGG7c6xUe9cX6ta7Y=;
 b=XyCYlIbhSbemmxtoFriJ01EGPEqXesEmXbJZYBdeSEi2Dl+tPgv8qwpUjonHu5vnmI
 QPXSGVeITUHYOGy1ow0rtcCxp4xlBNfiuvAIrCSxsz8e17ymMuQgym5siLqKHncMRTDG
 0FDBy1/Gg/ldPyBJOvuQRlpWEGMBZihLAQKOwr1XRiTx1lwTSsTUxKg0yr+fHGr3TwfT
 BHlm4sByw6k2P+DDN1lg5NLLGc8xCe3aCXGhxhvKG/HujHo9LEjMQyjijCfjNZ6lEgEQ
 m9MAxCZwH6YqzQsUg+3LQzdUK5AylLHp/y9CO7W9b4LiYFwlFZjtnEkoBmzx7yEeuDLI
 8wWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698237514; x=1698842314;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ziqyJhN+GxlPYSY+gLugWy2G4/rGG7c6xUe9cX6ta7Y=;
 b=qCZt5Jc1f5Q16vpvBn4LFVWtJi2NCpv5YfbELvKt8zlgY2BmzeB3ywetis2iSdET8w
 V+00/RdeqVkt91Zol2Ksnt5yqp6W4Tsc2+mOXop3c5KTGHz7RscrmWlqa+nHGlrUGX2y
 Ah+Z1RKwS4G+ivvTrjqn/Hx6aranPlCRBII07xA1WQSczJSEpPUdGo0e51alB0Mwm20U
 LaXxsu1xEVyIIOdbUrXlcYbQRqaOYhwkezFLd0ElTPdbkbNuDH/rXfNhUlp/OwkTEkXS
 0pWYDyFryltuh47WFHe5FBT1LjIk4q5aNT201Ev9iwc9nIzBLbSkfH6DNFW8EiRVPMMe
 O8oQ==
X-Gm-Message-State: AOJu0YxmamcHWksytFQVLMjWEVyWFsic6jpgL/NnqEtrVdiE1rSWoM8f
 ITrzSVDpx00s3EKqWl5GDW6ttNj+LrQ+R+tLUtnLAw==
X-Google-Smtp-Source: AGHT+IEBlpY4BKTiAOFPy5rMv3/57+6/KAJklxEo6ZWLI3mm8oU6LUGfwu9nFB4VZuomtISMWC5ZbWQ7U0tKtiwXeUY=
X-Received: by 2002:ac2:5294:0:b0:507:9ff3:ae82 with SMTP id
 q20-20020ac25294000000b005079ff3ae82mr9522044lfm.18.1698237513959; Wed, 25
 Oct 2023 05:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20231024154354.197524-1-eajames@linux.ibm.com>
 <20231024154354.197524-7-eajames@linux.ibm.com>
In-Reply-To: <20231024154354.197524-7-eajames@linux.ibm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 25 Oct 2023 15:37:57 +0300
Message-ID: <CAC_iWjLwY1z-F_ASPbY9Gb1YsFGnfZpFeh18T4tuwYKuC_J6nw@mail.gmail.com>
Subject: Re: [PATCH v14 6/8] doc: Add measured boot documentation
To: Eddie James <eajames@linux.ibm.com>
Cc: u-boot@lists.denx.de, sjg@chromium.org, xypron.glpk@gmx.de
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

On Tue, 24 Oct 2023 at 18:44, Eddie James <eajames@linux.ibm.com> wrote:
>
> Briefly describe the feature and specify the requirements.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> ---
> Changes since v12:
>  - Add a bit of detail about OS usage and what pieces are measured
>
>  doc/usage/index.rst         |  1 +
>  doc/usage/measured_boot.rst | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 32 insertions(+)
>  create mode 100644 doc/usage/measured_boot.rst
>
> diff --git a/doc/usage/index.rst b/doc/usage/index.rst
> index 98b4719c40..bf53bb6bda 100644
> --- a/doc/usage/index.rst
> +++ b/doc/usage/index.rst
> @@ -14,6 +14,7 @@ Use U-Boot
>     partitions
>     cmdline
>     semihosting
> +   measured_boot
>
>  Shell commands
>  --------------
> diff --git a/doc/usage/measured_boot.rst b/doc/usage/measured_boot.rst
> new file mode 100644
> index 0000000000..0aad590859
> --- /dev/null
> +++ b/doc/usage/measured_boot.rst
> @@ -0,0 +1,31 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +Measured Boot
> +=====================
> +
> +U-Boot can perform a measured boot, the process of hashing various components
> +of the boot process, extending the results in the TPM and logging the
> +component's measurement in memory for the operating system to consume.
> +
> +By default, U-Boot will measure the operating system (linux) image, the
> +initrd image, and the "bootargs" environment variable. By enabling
> +CONFIG_MEASURE_DEVICETREE, U-Boot will also measure the devicetree image.
> +
> +The operating system typically would verify that the hashes found in the
> +TPM PCRs match the contents of the event log. This can further be checked
> +against the hash results of previous boots.
> +
> +Requirements
> +---------------------
> +
> +* A hardware TPM 2.0 supported by the U-Boot drivers
> +* CONFIG_TPM=y
> +* CONFIG_MEASURED_BOOT=y
> +* Device-tree configuration of the TPM device to specify the memory area
> +  for event logging. The TPM device node must either contain a phandle to
> +  a reserved memory region or "linux,sml-base" and "linux,sml-size"
> +  indicating the address and size of the memory region. An example can be
> +  found in arch/sandbox/dts/test.dts
> +* The operating system must also be configured to use the memory regions
> +  specified in the U-Boot device-tree in order to make use of the event
> +  log.
> --
> 2.39.3
>
I will extend this for UEFI since measured boot was already supported
there for a couple of years
Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
