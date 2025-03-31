Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DEE0C3600B
	for <u-boot@archiver.kernel.org>; Mon, 31 Mar 2025 14:14:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0832381E1C;
	Mon, 31 Mar 2025 16:14:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nNIlhH4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8F6281E60; Mon, 31 Mar 2025 16:14:26 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 594448129B
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 16:14:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-3912fdddf8fso3435293f8f.1
 for <u-boot@lists.denx.de>; Mon, 31 Mar 2025 07:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743430464; x=1744035264; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mEuLWp4cZ4S48xtLz45x8R/XPmajJuca7cM6+Ab5OR8=;
 b=nNIlhH4gJMRQFyv3GGBNLtnyoD1aCSw7P2mWd3sO8qSTJfgNI699LHXLOvn7W6A9H9
 /n+MhLQOiNfDTXDdboKrmlLBEdYlHYiqdR0/+guEcvmRNbncHTYJwkdvEIW/Qp7TWLrW
 Injk4bUyvT5kH0FmQh4v9QjQwBAABVqVpWwnwstrpQV6Im1q+dkpjZNxasKDHoLYiIhV
 pInU9JFqHD001hJAG2Lh1sKUE4E+s+h0x4bshuoCuUjA2JduL8k2U8alX8n0TXFjsG3o
 3csrC/q8drl4uPf/1jNlNWwQZmuJj0S9jw3OkRN9r4Z6mE5LILO5sRDgasaLB6kaexLq
 ZnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743430464; x=1744035264;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mEuLWp4cZ4S48xtLz45x8R/XPmajJuca7cM6+Ab5OR8=;
 b=DtvBUX1Yym2+ycvYviPpwMXHxfBkNQJvRdwNJC1bzJdi9IYEIndb/4eUahXhBarUVl
 AxheRXA5xD45Urt5rxUz0CoZzPuk2VvmUJ+HitskAVLn4KAnEB0NsSe0e4xb4PEA9E30
 VSge3ADFYa3DuxPy3Fyx266tbGn+gXjN9na/Ms6HtMbZJwEKRwUOw5TwmkK5TSN2bd+2
 KMbFrKnjf2GAKiIj+pNgZHkEAh0zuaMi0WW0ItxCjL4XeK8Bm40SZxswTbPWq6JnGBPW
 LzWOm4iWd2xH5GiGa3TPW4HaDNd3i+70hM/RrqzXMsBOs2Xw3TEJ263SPIxYZ2P1CN7Y
 23WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBOCmq+1E26VTt0rO/AnJPz/wqNvvlZL542lh30Ls0mXSZS8GCPMftRlbcGNvrephXGZ+eP5I=@lists.denx.de
X-Gm-Message-State: AOJu0Yw3rPqqYN7QSSRbgUph91OB0piYbi4HfpKCqRSsl+lvHTR9QRG6
 7KmfWXRTw+Pgd4S4+tfRsKij9jethKhOK1tH/Gw0XKdTZuxm4al4T55CK1WNrmhXNStV/O+YGAY
 mnJIUmSO7
X-Gm-Gg: ASbGncsdmKwQQXwSg+XCjBxvg7HrJ0s3z+jdV2N9DRqDA7aSzE0mNcXbHSdNP7RVZVt
 UkpTdywz2jdYnOU5efCN86CBDjkgUzCayAJ6rAzN6DxuXKsMuNSvmxwiT5NiUY2DoZKW2XH+Rim
 Kk0N34P2+Xq3YMDxY8C0KOKnpmoMuBe0RiffAd/2HEDTvBrbfnCqQHq4Iu1+g6EZxr6Sc/QMBG3
 wrZa6vRTFYIz+IjnmdVuqAZgYhRKtYNk9nh9+VjD3eDcBXNvFg3H5UMUCootHhRUu4YaH8LFT8p
 1U1VdIOz51BccmLFVvVRkMonCzwmh8xq3MA8hn0EeyfoDxMO8oXgNAb20XQkdtD24WlwEyKpzDX
 UmPOT7TiGLzqtiQJcOxARNxDp
X-Google-Smtp-Source: AGHT+IFjwOkZuwppvTMiArg2mTjymKTntG+tAwcPJuqCf3ibIfhDV5tzpleZiueWqMeOhIiIU3jc5A==
X-Received: by 2002:a05:6000:2cf:b0:391:2e6a:30fa with SMTP id
 ffacd0b85a97d-39c0c13b7ecmr10704886f8f.27.1743430463726; 
 Mon, 31 Mar 2025 07:14:23 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:26ff:1b86:d0f9:9aad?
 ([2a01:e0a:3cb:7bb0:26ff:1b86:d0f9:9aad])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b79e0a3sm11528717f8f.71.2025.03.31.07.14.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 31 Mar 2025 07:14:23 -0700 (PDT)
Message-ID: <84e047e7-f90e-4435-8f3d-132d970749ac@linaro.org>
Date: Mon, 31 Mar 2025 16:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] lwIP sandbox tests
To: Simon Glass <sjg@chromium.org>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, u-boot@lists.denx.de
References: <20250314215525.579655-1-jerome.forissier@linaro.org>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250314215525.579655-1-jerome.forissier@linaro.org>
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

Hi Simon,

Any feedback on this series?

https://patchwork.ozlabs.org/project/uboot/list/?series=448553

Thanks,

-- 
Jerome

On 3/14/25 22:55, Jerome Forissier wrote:
> This series enables most of the driver model tests for network features
> with NET_LWIP (test/dm/eth.c and test/dm/dsa.c).
> - Patches 1-5 fix a few bugs (device selection) and add missing features
> (sandbox timer, restart support) to NET_LWIP
> - Patch 6 decouples the sandbox ethernet driver from NET
> - Patch 7 adds missing static IP addresses that NET_LWIP needs
> - Patches 8 and 9 update the tests to use a common interface to send
>   ICMP packets (do_ping(...) instead of net_loop(PING))
> - Patch 10 enables DM_DSA and the associated tests with NET_LWIP
> - Patch 11 adds a sandbox64 configuration with NET_LWIP=y
> - Patch 12 adds that configuration to the CI
> 
> Jerome Forissier (12):
>   net: lwip: do_ping() should return CMD_RET_FAILURE when no device
>   net: lwip: fix initialization sequence before a command
>   net: lwip: provide net_start_again()
>   net: lwip: add restart support to ping
>   net: lwip: use timer_early_get_count() when CONFIG_SANDBOX_TIMER=y
>   drivers: net: sandbox: add support for NET_LWIP
>   sandbox: provide static IP addresses for eth{2,3,5,6,7}
>   net: ping: make do_ping() available via <net.h>
>   test: dm: eth, dsa: update tests for NET_LWIP
>   net: lwip: allow DM_DSA=y when NET_LWIP=y
>   configs: add sandbox64_lwip_defconfig
>   CI: add sandbox64_lwip
> 
>  .azure-pipelines.yml             |   2 +
>  .gitlab-ci.yml                   |  11 ++
>  board/sandbox/sandbox.env        |   5 +
>  cmd/net.c                        |   3 +-
>  configs/sandbox64_lwip_defconfig |   5 +
>  drivers/net/Kconfig              |  14 +-
>  drivers/net/Makefile             |   1 -
>  drivers/net/sandbox-lwip.c       |  85 -----------
>  drivers/net/sandbox.c            | 240 ++++++++++++++++++++-----------
>  include/net-common.h             |  15 ++
>  include/net-legacy.h             |   3 -
>  include/net-lwip.h               |  10 +-
>  net/Makefile                     |   2 +-
>  net/lwip/dhcp.c                  |   3 +-
>  net/lwip/dns.c                   |   3 +-
>  net/lwip/net-lwip.c              |  86 +++++++++--
>  net/lwip/ping.c                  |  13 +-
>  net/lwip/tftp.c                  |   5 +-
>  net/lwip/wget.c                  |   6 +-
>  test/dm/Makefile                 |   2 -
>  test/dm/dsa.c                    |   8 +-
>  test/dm/eth.c                    |  77 +++++-----
>  22 files changed, 351 insertions(+), 248 deletions(-)
>  create mode 100644 configs/sandbox64_lwip_defconfig
>  delete mode 100644 drivers/net/sandbox-lwip.c
> 
