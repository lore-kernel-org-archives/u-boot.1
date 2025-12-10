Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325AED2CE17
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:45:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B32A783655;
	Wed, 10 Dec 2025 08:45:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pHB7R04e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D209A83B4A; Wed, 10 Dec 2025 08:45:17 +0100 (CET)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CB6883106
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:45:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-78c4aa7af99so35101247b3.0
 for <u-boot@lists.denx.de>; Tue, 09 Dec 2025 23:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765352714; x=1765957514; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sf3ZgXYViM3Imfv4T8BwWVJ6sWYdKub0/4Hzx/a1VKg=;
 b=pHB7R04eFDdB8MPc7Y8incMhlxfTe+uCddqoSwp/2sXxTnIrn6HuCskf6buXQ2R/W9
 ARFJuOtgMAqKBwnc6dABQ7aCx6Bgq711NHJSofjctIb5Kq27+ftKSxGdThiAttrPCQFp
 J8bR1qlQ3ECXYbr9DnwhbfdoEEJFYqRfqbljSMTwl4qzVym9xh4D6PzeVg9RLW/Wlkqu
 c9nG57dS1fka1hCTmghpfQ68fsU8rNNhnyJpL1/JNOiuFTOsLwXwgG7sgdsMJNJ/5OOJ
 0j1iFIOSfNY7C5Vf5BYJN+LWckFA9ZCH4Q7T5WxcewhCAfGLnJHpu3gX85B1bxfc43Sy
 Rk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765352714; x=1765957514;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sf3ZgXYViM3Imfv4T8BwWVJ6sWYdKub0/4Hzx/a1VKg=;
 b=lXixnqU9iIKpTiwXtbAL9pmDLEy3kmq5jc6L+uxmfhCBlfWDhvxDb0ux8PI998PLZu
 1+gsv0TbrG1XSO7M15TxPpCoT5I8ja5kcOP15cADfl9GbX9kVAgCoF2W21d6RxMUiCww
 1qaUZd9ZfyFVLNge0t/vhKM5bIWnu/j96IeAYcAxoTxc8E7HNQIYR0C/RMha/sZdmuyv
 wIJ4Lqec4mYorWQN5XDaSiR9jC/yK0MyA7DWQoMXDUYoX/cVjA+/NX0Tor3M6dNsVMXC
 j5zXqLDdj2Zs7t3XsHKRT0hSndAVAMLU9lN+uu/gnCXH3kWWLo3Vjf3heCqNpLTZbqC0
 QraQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJJjN8N7sKtq6/thpWmejzEVS8fe9Qf+HLe1H4dsQXd2sc0y8voSTO7f7gYKF33OGZ3BKrFWg=@lists.denx.de
X-Gm-Message-State: AOJu0YwjYPDCDa3pGjMF2G4ewdckPKc+wwzFuZEX5//9Ts1IBD+ElKWC
 unnQw5FEkk2qWASqOKB4ksdB9E0u+AdjPvAnsSPmkKm1t9R4kLXgHlTVLuThUU15qdY16PSXEWh
 wSjePZl2D8P6zxHTRCuPqrDuJTW6Iuk/mkteTrdZgXw==
X-Gm-Gg: AY/fxX76jFiyFbslSn1eEF8Nrr+tx36qFssv5z83NR0IQ3KBCbqKTVi0x3/rjbiYOaK
 p7Kc8+iinHd2EZ/7EfCy+Xmnjy2XFEsGPeeMNp/DAJXrXUf97UuEEsN7+I7fBt8QtelDejK03L3
 z9rW3bRjsIhsxchBLQ3RAtEb/P6fEnznSB0cmo666YE6yU9A3o6oR9c9Lykv7Cc5p1AKmkXrLwe
 rVqqrNXZp+iYXthf/egwIAzynO0JNdZU2Pq8jNhoy0ZwTnLfyU/piDlM7zKsiGDtDYh3CDsYYGh
 MldPIDYJnbEVUXYN1QCYwT216CRrtHkrAu+yzomcjmHN+KDHdsucudRHLzgrrinK1NoWFpqoOrl
 M7gQCdOc=
X-Google-Smtp-Source: AGHT+IFQHcvIQFOA0tqQNTr7oysQTPApOlHtgcBKG7nQo82sYu5OKx/NY3760CfIR45JyenWc+i8+mww8/0BmuZJN9E=
X-Received: by 2002:a05:690c:7489:b0:788:1a92:4fd9 with SMTP id
 00721157ae682-78c9d7fa6c4mr11460827b3.33.1765352713765; Tue, 09 Dec 2025
 23:45:13 -0800 (PST)
MIME-Version: 1.0
References: <20251209235905.431884-1-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251209235905.431884-1-heinrich.schuchardt@canonical.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 10 Dec 2025 09:44:36 +0200
X-Gm-Features: AQt7F2rIv8Jperzgd6w9EbXa6rZI80tmE0otJLTQQ6zeeWmOE3EPY7ZznWXfIYI
Message-ID: <CAC_iWjJpt=efqtv+eumsUx4jR=rRsCmYzxLZL6kz6kiutowKZA@mail.gmail.com>
Subject: Re: [PATCH 1/1] configs: qemu_arm64: disable SEMIHOSTING
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Simon Glass <sjg@chromium.org>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
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

On Wed, 10 Dec 2025 at 01:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Semihosting allows a virtual machine to write to the host file system.
> Such dangerous settings should not be in a defconfig.
>
> Move it to a CI configuration override.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  .azure-pipelines.yml         | 1 +
>  .gitlab-ci.yml               | 1 +
>  configs/qemu_arm64_defconfig | 1 -
>  3 files changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.azure-pipelines.yml b/.azure-pipelines.yml
> index 25b0e4c985c..81a36da7114 100644
> --- a/.azure-pipelines.yml
> +++ b/.azure-pipelines.yml
> @@ -504,6 +504,7 @@ stages:
>          qemu_arm64:
>            TEST_PY_BD: "qemu_arm64"
>            TEST_PY_TEST_SPEC: "not sleep"
> +          OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
>          qemu_arm64_lwip:
>            TEST_PY_BD: "qemu_arm64_lwip"
>            TEST_PY_TEST_SPEC: "test_net_dhcp or test_net_ping or test_net_tftpboot"
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 08bea0dd234..28a32f9f4d3 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -387,6 +387,7 @@ qemu_arm64 test.py:
>    variables:
>      TEST_PY_BD: "qemu_arm64"
>      TEST_PY_TEST_SPEC: "not sleep"
> +    OVERRIDE: "-a CONFIG_SEMIHOSTING=y"
>    <<: *buildman_and_testpy_dfn
>
>  qemu_arm64_lwip test.py:
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 12ed6b61239..fd0bdad2d62 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -71,7 +71,6 @@ CONFIG_SYSRESET_PSCI=y
>  CONFIG_TPM2_MMIO=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_PCI=y
> -CONFIG_SEMIHOSTING=y
>  CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
>  CONFIG_TPM_PCR_ALLOCATE=y
> --
> 2.51.0
>
