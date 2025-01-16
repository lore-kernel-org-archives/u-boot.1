Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F871C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:08:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E024C80214;
	Thu, 16 Jan 2025 14:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="AL64te51";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D65F8801B0; Thu, 16 Jan 2025 14:08:17 +0100 (CET)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99465801B0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 14:08:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-e549dd7201cso1540118276.0
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 05:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737032894; x=1737637694; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hqCQTngYHTd6Ou9o9xiYAAySuiG8WOVd++buhDTlFzE=;
 b=AL64te51xVmwPOg3DI9kCUzOMC2z8uS3vjBhuHDNMUn0BhMjmb13hNU5v9i20FXMJJ
 Al2Xneicf4OO4CZT5Abgwmsjy2x40wDB7VYdKvXl3HflApOHB/Uixx3cGKMOIGzXUN45
 BktASypHKEfiLR6Pysl8ZWBIUSVOeR6oNRTmzmKEwKazqjYYCINb4+4bo4BIHRmcyjJx
 z74ZS8kBHiueCJa8C8rlfT4xRKzmJxJ0mxj4333Lw6dQlLahVE0uSQSVyrVj2MLw7Vip
 hJ4xWJ5GzdsWHmPn2qOajFdIR5nuvBHO4pj3UOQGAcnyEifv0z2zfOYaYRmXV6/+fKiz
 NyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737032894; x=1737637694;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hqCQTngYHTd6Ou9o9xiYAAySuiG8WOVd++buhDTlFzE=;
 b=swsFlJyfQb5MdjZmioQdRqWs4+g7HuT5IdUqN1fWssPy9d2G1KC6LwXtNNwyOT3yFB
 4IHWdacyjTYuasiynu0jzuJlT75HZ61jn7QFAwg7tMI1xKo1Wje/JMrmICLnLSKAEHSq
 Qm6nuXI14jb4vcpX77D+S0vm2H5uYD6Vm1NSMK5lon95ldrbTYg/vbkxxK3ULSWQjsgN
 IkD06oJ7RmRLYH8HOjojoOTT/oPryahZHzQMOs0AUYRnwzvcpY2z5gH41oxCp/lS7Fga
 AKrbsAWiYfw7VESvLIqBh4dLdnNH5RVqzyBioUyZkEjrcEXchJDs6Fa+kGME/7HQjYgY
 xywQ==
X-Gm-Message-State: AOJu0YyeyK/ps8+f51xPW9OLfkbF1TEXaKXOM0d0LjSXesqvsoNONMUW
 V5bxN4Rccdem6GuaccJohkFCtnPOW0NG1Cb7FdYZEGEhCLQWAEBMvfmXAUmQ+nrF/Frqf9BpUS6
 cxdFbpEU599/PWj2BM+l7PTTMQygvPaZvpy5/mg==
X-Gm-Gg: ASbGnct2/UUhQzB6fl4S204zMDkV9ViLMoQV3tsADnRf3m2Lq2Zt3Vnmb3dmOaR5FI/
 LwStfPf8YfzZMLg/0jUGcsIGv6ye7yXaQ1cynmg==
X-Google-Smtp-Source: AGHT+IHVFbnbhhiK5mg7+1+nzNXU1iXzqtDZ4iNYuQ+T0mGHC5bu/q2s4xicQhg0S4hrJi0fFNEvaCueax1o1gHhzZo=
X-Received: by 2002:a05:690c:7405:b0:6ef:94db:b208 with SMTP id
 00721157ae682-6f53125c4f9mr279133957b3.24.1737032894476; Thu, 16 Jan 2025
 05:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20250115200144.951530-1-raymond.mao@linaro.org>
 <20250115200144.951530-7-raymond.mao@linaro.org>
In-Reply-To: <20250115200144.951530-7-raymond.mao@linaro.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 16 Jan 2025 15:07:38 +0200
X-Gm-Features: AbW1kvagzSAPsP8392q-F1n8rykll17nT0GtNBBuDYWGOUHYaf4rQeWGmqNNS-k
Message-ID: <CAC_iWj+2U36V6SSa8ST6JvU4SMTqD97cOvE-VVy00=+roRyWyA@mail.gmail.com>
Subject: Re: [PATCH 6/6] board: qemu-arm: select TPM_PCR_ALLOCATE
To: Raymond Mao <raymond.mao@linaro.org>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Tim Harvey <tharvey@gateworks.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Michal Simek <michal.simek@amd.com>
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

On Wed, 15 Jan 2025 at 22:02, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Enable PCR allocate and system reboot when algorithms don't match
> among the values from TPM device, U-Boot support and evenlog.
>
> Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> ---
>  configs/qemu_arm64_defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/qemu_arm64_defconfig b/configs/qemu_arm64_defconfig
> index 0c7107c1f4..6ba3cb1bbd 100644
> --- a/configs/qemu_arm64_defconfig
> +++ b/configs/qemu_arm64_defconfig
> @@ -73,3 +73,4 @@ CONFIG_SEMIHOSTING=y
>  CONFIG_MBEDTLS_LIB=y
>  CONFIG_TPM=y
>  CONFIG_GENERATE_SMBIOS_TABLE_VERBOSE=y
> +CONFIG_TPM_PCR_ALLOCATE=y
> --
> 2.25.1
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
