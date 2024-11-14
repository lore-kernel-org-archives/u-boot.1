Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9BED68B30
	for <u-boot@archiver.kernel.org>; Thu, 14 Nov 2024 15:22:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7E7895D6;
	Thu, 14 Nov 2024 16:22:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="y+wnhtul";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DAC3895FF; Thu, 14 Nov 2024 16:22:40 +0100 (CET)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA1689121
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 16:22:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-720be27db27so624902b3a.2
 for <u-boot@lists.denx.de>; Thu, 14 Nov 2024 07:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731597756; x=1732202556; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NWAeRPaGSmDcpPIdIfNMJVX1rZQQknl/a1jrm++yQXE=;
 b=y+wnhtulpMhdI45ByNdtzLOIc4VSKg0uidsYgsIbHUGomPoR2ycM3lj04oR47uipKx
 DPbP6wfN4R4u4RXddAJT/4o17aMbplzjqfz+R4w4xgH/KduZXliEFvxhRyUflWDZnq+G
 0juTnZBc/YVSw3uTNMTeQoLOBqwphqA+pEqi/mSmISpxj2amIjdaXTWBebFF5nDzMUA+
 ThXD6Filca1rBrmzFCbX8vxavzEWbCAsBw+5R9JBA7MVmnVrjACLw+W0PTBVSu3dhJr7
 +HiIBuNsncGLOSNmwoaR89vvMYeHgyq42AkKTEwrz3VPwACXcIWLRn2svWYpcq9P8JAG
 rQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731597756; x=1732202556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NWAeRPaGSmDcpPIdIfNMJVX1rZQQknl/a1jrm++yQXE=;
 b=ct6NpF3wZqJSISnXVX2Z/1tRAtiQBF+w1jYumz4OOOj4RsxVXddc7+7tURql3NeRhc
 SK71VCW6hb56kCBjFfXCa3Ad34I4wZ4asKyhZnHekJTAJad7txuyDfpovyd7V4/5iR/G
 K0lpeY4JMmYGT4JBQshy45TbE9NPKRIfHTZTTT+I/xhGTp3bcM1m9wWnXaG2TYcwDDnN
 USpU3NYkNgyRqZDR38Q/ujHTXt1gvVXFrF0BQhK/jmxvfglQSHFdj8y9iw+6A1xlOIug
 wyAIYd9M6BpbVcUvq/1541u5zIG74R0IDZ63ErSXKyBOJusyi/Uc39F5/QbRDaW1yukD
 +esQ==
X-Gm-Message-State: AOJu0YwAG/GYusYUetnuRitq+8kyLRz+pbgxQpW9C9EoD46NiRpWHfpl
 fuK+3BJ7h83/BfHItbrDLmEXbw7+q7wT3ux9Ut5eWFPAiU49cVJ8/d1CEJcZUYval6RcVF95rjB
 UbzfqEaiOy3batu87G4Yp0S3i0GtJ5qDjjKBP2A==
X-Google-Smtp-Source: AGHT+IG6chIho/kFSDhXtBr/wqlyA77sBgqtaTWG5rKLbZduGEsuBwMjNbqpNtIoo499rp/hOxjPX4jFSZQ8b1Tbzn8=
X-Received: by 2002:a05:6a00:14c8:b0:71e:41b3:a56b with SMTP id
 d2e1a72fcca58-7244a5d67d6mr14956681b3a.24.1731597756310; Thu, 14 Nov 2024
 07:22:36 -0800 (PST)
MIME-Version: 1.0
References: <20241111210959.560738-1-adrianox@gmail.com>
In-Reply-To: <20241111210959.560738-1-adrianox@gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 14 Nov 2024 17:22:00 +0200
Message-ID: <CAC_iWjJ4LjTopsPuVk2za+eetVUZ-2Mofe-PGOgKv49XkJ71Kg@mail.gmail.com>
Subject: Re: [PATCH v3 00/15] efi_loader: efi http and ipconfig drivers
To: Adriano Cordova <adrianox@gmail.com>
Cc: u-boot@lists.denx.de, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 jerome.forissier@linaro.org, xypron.glpk@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Adriano,

On Mon, 11 Nov 2024 at 23:10, Adriano Cordova <adrianox@gmail.com> wrote:

> Add support for EFI_HTTP_PROTOCOL, EFI_HTTP_SERVICE_BINDING_PROTOCOL,
> and EFI_IP4_CONFIG2_PROTOCOL.
>
> This series depends on the series 'wget: Expose wget to applications',
> also found at:
> https://github.com/0n41rd4/u-boot/commits/http-driver-wget
>
> The fist two patches of this series are not efi specific and have also
> been sent to the corresponding maintainers, but this series depends on
> them, so they are added here for redundancy. A branch with both series
> of patches, concatenated, is at:
> https://github.com/0n41rd4/u-boot/commits/efi-http-driver


It would help a lot if we had pointers (or an EFI app) using this protocol
to test. Are you using any of that for devel/debugging?

Thanks
/Ilias

>
>
> Adriano Cordova (13):
>   net: net_utils: Move ip_to_string to lib/net_utils.c
>   net: wget: let wget_with_dns work with dns disabled
>   efi_loader: device_path: add definition of
>     DEVICE_PATH_SUB_TYPE_MSG_IPV4
>   efi_loader: device_path: add efi_dp_from_ipv4
>   efi_api: add definitions for HTTP and IP4_CONFIG2 protocols
>   efi_loader: efi_net: add efi_net_set_addr, efi_net_get_addr
>   efi_loader: device_path: add support for HTTP device path
>   efi_loader: net: set EFI bootdevice device path to HTTP when loaded
>     from wget
>   efi_loader: net: add support to send http requests and parse http
>     headers
>   efi_loader: efi_net: add EFI_IP4_CONFIG2_PROTOCOL
>   efi_loader: efi_net: add EFI_HTTP_PROTOCOL
>   efi_selftest: add test for HTTP protocol
>   efi_selftest: add test for IPv4 Config2 protocol
>
> Heinrich Schuchardt (2):
>   efi_loader: add IPv4() to device path to text protocol
>   lib: uuid: display HTTP and IPV4 Config II protocols
>
>  include/efi_api.h                        | 220 +++++++++
>  include/efi_loader.h                     |  42 ++
>  include/net-common.h                     |  10 +
>  lib/efi_loader/Kconfig                   |  17 +
>  lib/efi_loader/Makefile                  |   2 +
>  lib/efi_loader/efi_device_path.c         |  95 +++-
>  lib/efi_loader/efi_device_path_to_text.c |  23 +
>  lib/efi_loader/efi_http.c                | 563 +++++++++++++++++++++++
>  lib/efi_loader/efi_ipconfig.c            | 216 +++++++++
>  lib/efi_loader/efi_net.c                 | 316 ++++++++++++-
>  lib/efi_selftest/Makefile                |   2 +
>  lib/efi_selftest/efi_selftest_http.c     | 315 +++++++++++++
>  lib/efi_selftest/efi_selftest_ipconfig.c | 173 +++++++
>  lib/net_utils.c                          |  11 +
>  lib/uuid.c                               |  14 +
>  net/lwip/wget.c                          |   1 +
>  net/net.c                                |  11 -
>  net/wget.c                               |  39 +-
>  18 files changed, 2038 insertions(+), 32 deletions(-)
>  create mode 100644 lib/efi_loader/efi_http.c
>  create mode 100644 lib/efi_loader/efi_ipconfig.c
>  create mode 100644 lib/efi_selftest/efi_selftest_http.c
>  create mode 100644 lib/efi_selftest/efi_selftest_ipconfig.c
>
> --
> 2.43.0
>
>
