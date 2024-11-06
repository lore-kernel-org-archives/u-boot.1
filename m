Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD13D44D6A
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 13:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E7478902D;
	Wed,  6 Nov 2024 14:53:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NPDfdfFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B29889159; Wed,  6 Nov 2024 14:53:57 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9519C88D54
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 14:53:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so57271935e9.1
 for <u-boot@lists.denx.de>; Wed, 06 Nov 2024 05:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730901235; x=1731506035; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Yfz8AQIlZSaGXjxvlXaIQOwxdBF1TjvCtWLQtVj/nzI=;
 b=NPDfdfFxXtWAcnIP2cL3l24ae+isxvOIueT8pnkKNJgSSlcFi9LlgQpDuSBKZTMn+K
 h11TaAFdAhkTlkMfAPpnKyTzPXL0t77JDZJzYH50Bd96fPJDAFr6Xn5NL0Fmj4+B8Poj
 BN0l8cAtuhy3kVzphm4vkXLuqTJIvSMy2W/XCGIRZ9IQ25VDRND+y4sXkAFBIeuP1YbE
 SE2SgLiMuf93iDt9zYw+ob01j0rL4u2jDw3R0KVCINx5zkzGL2j5PanM3SX8GyaupjZ1
 0KnEi2YEbLJLvNI110DcLuHfdYQLogfoN9z367BfvCPr6hxyqwiG3K0CFN0qWPQhIhhN
 uWWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730901235; x=1731506035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Yfz8AQIlZSaGXjxvlXaIQOwxdBF1TjvCtWLQtVj/nzI=;
 b=O2omN605aQs5SAuJJIXM/H2DYCavkJHtoP5u55TlwxyXTXhru0kzYs52GJ2ggKt1st
 DrpaItPVo1ucSwwnsi83TMHb29Msx474YUcEJyb1Q0Kfws0tMFXf/WJ4XhtcWXsrMEOZ
 NAmaH6bGe3XFfeRfUY+MhopHBUD+Mg+5HWMBESmz1EfEc9SJRVLjUXx15LToGtgjrX/h
 FkLyyz+updQcwmHy8Oi4I3SY9u/QcPNkj7vwkEtH//ibScWghoGjEFvZUogCNEjMO+WN
 ff1kUy+On6zbxom08Jm/w0/jBc7kNPCz2Mmp5U5dUxWUU7qimhd/ZkZF3qojwL9Iw4N7
 c8yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcV2bd9mEoCxrEessFDGUjSHj+ZKitUUzL6BwdpQIhszpJSOHMs35MGGc+Uk9qup6iNhTuQxs=@lists.denx.de
X-Gm-Message-State: AOJu0YywEmIsIoR3OWV90mtmu2sBIwMKw6GFp5gG0TtzJv7/U1o89dAx
 bQn77OolkiLbrXm15VMcnBnLzWhrDo+CZ9ChBdh9N3e3QL9hPwk6lUIuJQAMHsI=
X-Google-Smtp-Source: AGHT+IEy1KvUGp8Pej863nClRswJLK22zBEzRw+96xzSJ0oWT5UmtUnIVvIehK/EFtLdHDHNA83M0A==
X-Received: by 2002:a05:600c:1e03:b0:431:5df7:b337 with SMTP id
 5b1f17b1804b1-4319ac9a703mr351199535e9.8.1730901234996; 
 Wed, 06 Nov 2024 05:53:54 -0800 (PST)
Received: from [172.20.141.182] ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c10b7d20sm19511724f8f.7.2024.11.06.05.53.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 05:53:54 -0800 (PST)
Message-ID: <e22d434d-ca9d-4fc5-a732-39b2a4d2768c@linaro.org>
Date: Wed, 6 Nov 2024 13:53:53 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] doc: uefi: Describe UEFI HTTPs boot
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, raymond.mao@linaro.org
Cc: xypron.glpk@gmx.de, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Jonathan Humphreys <j-humphreys@ti.com>,
 Wei Ming Chen <jj251510319013@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Masahisa Kojima <kojima.masahisa@socionext.com>,
 Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
References: <20241024112449.1362319-1-ilias.apalodimas@linaro.org>
 <20241024112449.1362319-7-ilias.apalodimas@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20241024112449.1362319-7-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Ilias,

On 10/24/24 12:24, Ilias Apalodimas wrote:
> We now can use a combination og lwIP & mbedTLS and download from
> https://. Describe the config options needed to enable it as well
> as some limitations
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> ---
>  doc/develop/uefi/uefi.rst | 45 +++++++++++++++++++++++++++++++++++++--
>  1 file changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> index 0760ca91d4fc..e19dcaac8056 100644
> --- a/doc/develop/uefi/uefi.rst
> +++ b/doc/develop/uefi/uefi.rst
> @@ -681,8 +681,8 @@ UEFI variables. Booting according to these variables is possible via::
>  As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
>  command 'efidebug' can be used to set the variables.
>  
> -UEFI HTTP Boot
> -~~~~~~~~~~~~~~
> +UEFI HTTP Boot using the legacy TCP stack
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  HTTP Boot provides the capability for system deployment and configuration
>  over the network. HTTP Boot can be activated by specifying::
> @@ -715,6 +715,47 @@ We need to preset the "httpserverip" environment variable to proceed the wget::
>  
>      setenv httpserverip 192.168.1.1
>  
> +UEFI HTTP(s) Boot using lwIP
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +Similar to the above U-Boot can do EFI HTTP boot using lwIP. If we combine this
> +with mbedTLS we can also download from https://

The proper spelling is "Mbed TLS" [1]

[1] https://www.trustedfirmware.org/projects/mbed-tls/

> +
> +HTTP(s) Boot can be activated by specifying::
> +
> +    CONFIG_EFI_HTTP_BOOT
> +    CONFIG_NET_LWIP
> +    CONFIG_WGET_HTTPS
> +
> +For QEMU targets there's a Kconfig that supports this by default::
> +
> +    make qemu_arm64_lwip_defconfig
> +
> +The commands and functionality are similar to the legacy stack, with the notable
> +exception of not having to define an "httpserverip" if you are trying to resolve
> +an IP. However, lwIP code doesn't yet support redirects::
> +
> +    => efidebug boot add -u 1 netinst https://cdimage.debian.org/cdimage/weekly-builds/arm64/iso-cd/debian-testing-arm64-netinst.iso
> +    => dhcp
> +    DHCP client bound to address 10.0.2.15 (3 ms)
> +    => efidebug boot order 1
> +    => bootefi bootmgr
> +
> +    HTTP server error 302
> +    Loading Boot0001 'netinst' failed
> +    EFI boot manager: Cannot load any image
> +
> +If the url you specified isn't a redirect::
> +
> +    => efidebug boot add -u 1 netinst https://download.rockylinux.org/pub/rocky/9/isos/aarch64/Rocky-9.4-aarch64-minimal.iso
> +    => dhcp
> +    => bootefi bootmgr
> +    #######################################
> +
> +If the downloaded file extension is .iso or .img file, efibootmgr tries to
> +mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> +If the downloaded file is PE-COFF image, load the downloaded file and
> +start it.
> +
>  Executing the built in hello world application
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

With the spelling fixed:

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org>

Thanks,
-- 
Jerome
