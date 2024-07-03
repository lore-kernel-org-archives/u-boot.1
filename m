Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D16C30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 11:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46C3E887EA;
	Wed,  3 Jul 2024 13:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YHgXW9TU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F864887E7; Wed,  3 Jul 2024 13:57:08 +0200 (CEST)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFE1B887FB
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 13:57:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-718b714d362so2964931a12.0
 for <u-boot@lists.denx.de>; Wed, 03 Jul 2024 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720007824; x=1720612624; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+I9TchBx23JDj+hUIieWsPqlF1ReNk4bsPTZ8/ar1GE=;
 b=YHgXW9TUyz4RtUBv0mF7A5+oC+Bl3qPFCTTJmb+bn1dnwzQmvEkCoKAAgGZUQW1eYc
 qTaovVlS7Y/P95ISwUjnTy2Zp2aJhV5sdOEH54YOr2+8X0He9ke5XFa+LEBe6kfp6s3i
 XtZdjYvtECzkpObrcqvk/pk7KZ1s3ueQ26wrfwgt6CJm9sVNSbx4ALnnMVCv3U2617lT
 oFdm79tavdNv+eK0b7qK3F34hVHt9iqQMEy59XCMDBax5F3NHGAJQi56Pfjqrs7iElm9
 FKhSsuxnCYJmXGll6ySmb4awyFMTx360XYmM3Ang/UzoTo5ZCD46NyK83Tt1yJ9NtbHJ
 fv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720007824; x=1720612624;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+I9TchBx23JDj+hUIieWsPqlF1ReNk4bsPTZ8/ar1GE=;
 b=YjXnX7pT+opVVLkv31FlbMICV8CEIEJ0hWZTSR1hgFi/d/UPivyIvQ11MMzdiZ02pi
 ou0NbcOrCR0fPjl390hdxPVEU4bErSvgJPBqaYU3Yd37yWsK2NiiksJgeouWxtvsXSKa
 fANvTiiVxzJ+hSqqWyj9XWwCuYFWfBEAPAjKqlQFPE/x1+Vx2m+A1mvxrYTR30IRzJup
 NPJ01oLqSKkKsndFu2vyjQBtXXndxStm/Nu7UcSlKuH+itre2cMRFxUNR0OVJ5t3wsj7
 NXKh0MDLvhc0WyU2M8ssac57joUvXtzYm0bnB3FS2U7Mut7vSJqoDWnJv7Eyjbmub2tC
 oiCw==
X-Gm-Message-State: AOJu0YxRexn+blOkPwfACeLxJNvto0PKGAkRIIw8oE+MrYXq6UbKIeSV
 GKXXi5mw75NuWYWljeT1T43VvL9t+YvVqPN5rp5IPUK6OBN4hlu34/uEOb9QqCq/sFDlX6O6GUU
 v7g3qe8lp6tk6KQ9ELwyT06xuedWAKWGfe1Z7+Q==
X-Google-Smtp-Source: AGHT+IHCf4pQ+Ik8CKrt6N4XDsYr5XBl5YE2SenTW0JpJASuM/BLvatqi4eiXxoA1uqWI1g1Tk8kIZZnrqJUiRckFtc=
X-Received: by 2002:a17:90a:2ecb:b0:2c9:6928:ac9b with SMTP id
 98e67ed59e1d1-2c96928aeeamr2668008a91.15.1720007823976; Wed, 03 Jul 2024
 04:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-30-raymond.mao@linaro.org>
In-Reply-To: <20240702182325.2904421-30-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jul 2024 14:56:27 +0300
Message-ID: <CAC_iWjJmGnUm6Q1u_Yg0d8O4kgz79zK5pe6KvN_wxf6rWA5VOA@mail.gmail.com>
Subject: Re: [PATCH v4 29/29] configs: enable MbedTLS as default setting
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Bin Meng <bmeng@tinylab.org>, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Alexander Gendin <agendin@matrox.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

On Tue, 2 Jul 2024 at 21:35, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Enable MbedTLS as default setting for qemu arm64
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
> Changes in v2
> - None.
> Changes in v3
> - None.
> Changes in v4
> - removed the unused CONFIG_MBEDTLS_LIB_TLS.
>
>  configs/qemu_arm64_defconfig | 4 ++++
>  configs/sandbox_defconfig    | 3 +++
>  2 files changed, 7 insertions(+)
>
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 7e166f43908..9e2c490192c 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -67,4 +67,8 @@ CONFIG_TPM2_MMIO=y
>  CONFIG_USB_EHCI_HCD=y
>  CONFIG_USB_EHCI_PCI=y
>  CONFIG_SEMIHOSTING=y
> +CONFIG_MBEDTLS_LIB=y
> +CONFIG_MBEDTLS_LIB_CRYPTO=y
> +CONFIG_MBEDTLS_LIB_X509=y
>  CONFIG_TPM=y
> +CONFIG_EFI_SECURE_BOOT=y
> diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
> index 93b52f2de5c..679bbf69936 100644
> --- a/configs/sandbox_defconfig
> +++ b/configs/sandbox_defconfig
> @@ -343,6 +343,9 @@ CONFIG_FS_CBFS=y
>  CONFIG_FS_CRAMFS=y
>  CONFIG_ADDR_MAP=y
>  CONFIG_CMD_DHRYSTONE=y
> +CONFIG_MBEDTLS_LIB=y
> +CONFIG_MBEDTLS_LIB_CRYPTO=y
> +CONFIG_MBEDTLS_LIB_X509=y
>  CONFIG_ECDSA=y
>  CONFIG_ECDSA_VERIFY=y
>  CONFIG_TPM=y
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
