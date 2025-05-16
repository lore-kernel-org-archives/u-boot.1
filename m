Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EB5C3ABD8
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 12:48:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31EEE8006D;
	Fri, 16 May 2025 14:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yO+quJhR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 413A180079; Fri, 16 May 2025 14:48:23 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E38A680050
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 14:48:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43edecbfb94so22217605e9.1
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 05:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747399700; x=1748004500; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IAtr0o+tz+o80qc+SXQBfhXV+HcUkvJ5HR8PzSwpzws=;
 b=yO+quJhRGpxCgof232ORWGafbOZu5KJXAIbdgd+MqWVLfJ84kMAd5giiph6sCaBSwW
 RmBUHV5R7MjYUMY8XIj3Z0RDsuFpM9VK66qZAOll9xOsqMn2kBs02HISCZKqke4Vm57E
 gHnLs18CuJMZfIEdAeqxOEG6inrMIX/P7rMigdm0JlNI9c2E0jVWyKEqfNLNn2FoQlyQ
 ypjDHxdz1rTzuW5AcStq/+6SJdIcL6gDHOUH55MwRl/7fYnua/3TS8bnsvW9XxQqJaJU
 Gh6Awtn2U5bYUJfvfPTQTiGuHX4df1fl24hX2TPn6kqta9g3fQSytb8oEsxFw71Ds0ML
 ggzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747399700; x=1748004500;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IAtr0o+tz+o80qc+SXQBfhXV+HcUkvJ5HR8PzSwpzws=;
 b=OI0KJ4ZTUIAtXGLs4uSZIT5Gz37QFpaGRf4z/u20pa5o2T7HPRQJ20igZgyAuagpUc
 KHhX0rPOuSp3G0kgAOg+AJnG/ilQAUbwFO/TLOC/9W6YPFL5RpB0zrf/sPTFGAcZxdwS
 iLz49xgXFwA+LKDHYcQNLG0ZYIqqMwp57/dl8Uo2un3O/wfl1S5MTqQCbfENVojhyd4k
 DpLhV3wHhrSMe9GFivyzdjzA/8hCaScWZquDZAbKt+15pR2VS7yHqXJycbwc0AUJL5JP
 IkXWg8nWwT3DOJ+6hLBfBtTfyAGs8yvNz/V7dnzwepb+amuncDVn4uwYOqO692iX9lJe
 T0xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLaxYtiQbckRM29H1i53PTDCTm1RCpp4IqqenzD8mpBNDNL0X3vxDNiSTnMSWQRx9V5jaICOg=@lists.denx.de
X-Gm-Message-State: AOJu0Yyx11qllRZIOGNZh0NOR4aF2VVI2nyijmISUHX/YpnQgCb3AhNm
 Y1WyEC2J58cdmqR8wnknGoGuQBTpnfQj18nVdqh+T6HvStKVLWCk+gpnMgYboh3oMzc=
X-Gm-Gg: ASbGnctsBT0xTstrm28gLwNUROLqk61w5fU5DM8adD28FPJtOOUhE54GSPMoJw2rGOa
 yFzYInjcrOLmaqsISjn8Yk6xhWGTqmRc4C7A6YxJ1D2YxHzDbjbw3qlMF3ts8M8AUUIBgBj0Ga4
 E0DsJsS6bcarbNrR2L6F5GOkTKbeTeBagKPzooW8eh4EjKJ5ia0ZpFECcF1lOVR19YGvkxJx//4
 Nub7RPlGtxF0FOU7gMBliv9Xmi5mL+PWNWr8LOmHE8R7wbFwl1ZmJoY04K7GZt6tjTep8s59qZQ
 Tssg6hq7rjNGf4scG9EXlwdoC8cHA58CxQCJRky5dSFn9yoZ2qvsmtZRqnin+71hvdDR49RIM+f
 qN+v0fmZ3JcL78Hvq586mrqXH
X-Google-Smtp-Source: AGHT+IFcqtRqCmhbI8kiCnVDBSST4U4n3MOllocCs1GW5UfxV5m1wyTRB8CKp8R/8KzfqMOkFImPfg==
X-Received: by 2002:a05:600c:1e8b:b0:43d:9f2:6274 with SMTP id
 5b1f17b1804b1-442fd6205c7mr34780805e9.14.1747399700244; 
 Fri, 16 May 2025 05:48:20 -0700 (PDT)
Received: from [10.61.0.89] (110.8.30.213.rev.vodafone.pt. [213.30.8.110])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442fd59708esm31996745e9.37.2025.05.16.05.48.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 May 2025 05:48:19 -0700 (PDT)
Message-ID: <8eefe742-10e1-4d64-88c1-73a0d4f5e36b@linaro.org>
Date: Fri, 16 May 2025 13:48:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/22] global: Avoid indirect inclusion of <env.h> from
 <net.h>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Huan 'Kitty' Wang <HuanWang@gehealthcare.com>,
 "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>,
 Angus Ainslie <angus@akkea.ca>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jan Kiszka <jan.kiszka@siemens.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Le Jin <le.jin@siemens.com>,
 Martyn Welch <martyn.welch@collabora.com>, Niel Fourie <lusus@denx.de>,
 Ramon Fried <rfried.dev@gmail.com>, Rick Chen <rick@andestech.com>,
 Simon Glass <sjg@chromium.org>, Tim Harvey <tharvey@gateworks.com>,
 Wolfgang Wallner <wolfgang.wallner@br-automation.com>
References: <20250514225002.15361-1-trini@konsulko.com>
 <20250515234154.1859366-1-trini@konsulko.com>
 <20250515234154.1859366-22-trini@konsulko.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <20250515234154.1859366-22-trini@konsulko.com>
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

On 5/16/25 00:31, Tom Rini wrote:
> Now that env_get_ip() has been removed, the include file <net.h> does
> not need anything from <env.h>. Furthermore, include/env.h itself
> includes other headers which can lead to longer indirect inclusion
> paths. To prepare to remove <env.h> from <net.h> fix all of the
> remaining places which had relied on this indirect inclusion to instead
> include <env.h> directly.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v3:
> - New patch
> 
> Cc: "Huan 'Kitty' Wang" <HuanWang@gehealthcare.com>
> Cc: "Ying-Chun Liu (PaulLiu)" <paul.liu@linaro.org>
> Cc: Angus Ainslie <angus@akkea.ca> (supporter:PURISM LIBREM5 PHONE)
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ian Ray <ian.ray@gehealthcare.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: Jerome Forissier <jerome.forissier@linaro.org>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Le Jin <le.jin@siemens.com>
> Cc: Martyn Welch <martyn.welch@collabora.com>
> Cc: Niel Fourie <lusus@denx.de>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Rick Chen <rick@andestech.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tim Harvey <tharvey@gateworks.com>
> Cc: Wolfgang Wallner <wolfgang.wallner@br-automation.com>
> ---
>  board/BuR/brppt2/board.c                            | 1 +
>  board/advantech/imx8mp_rsb3720a1/imx8mp_rsb3720a1.c | 1 +
>  board/andestech/ae350/ae350.c                       | 1 +
>  board/data_modul/common/common.c                    | 1 +
>  board/gateworks/gw_ventana/gw_ventana.c             | 1 +
>  board/ge/b1x5v2/b1x5v2.c                            | 1 +
>  board/keymile/kmcent2/kmcent2.c                     | 1 +
>  board/purism/librem5/librem5.c                      | 1 +
>  board/siemens/iot2050/board.c                       | 1 +
>  board/ti/j721e/evm.c                                | 1 +
>  boot/bootmeth_efi.c                                 | 1 +
>  boot/bootmeth_pxe.c                                 | 1 +
>  cmd/pxe.c                                           | 1 +
>  drivers/net/pfe_eth/pfe_firmware.c                  | 1 +
>  lib/efi_loader/efi_bootmgr.c                        | 1 +
>  lib/efi_loader/efi_net.c                            | 1 +
>  net/lwip/dhcp.c                                     | 1 +
>  net/lwip/dns.c                                      | 1 +
>  net/lwip/net-lwip.c                                 | 1 +
>  net/lwip/tftp.c                                     | 1 +
>  net/lwip/wget.c                                     | 1 +
>  test/dm/dsa.c                                       | 1 +
>  22 files changed, 22 insertions(+)

Reviewed-by: Jerome Forissier <jerome.forissier@linaro.org> # net/lwip
