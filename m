Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7779FE6F09E
	for <u-boot@archiver.kernel.org>; Sun,  3 Nov 2024 15:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C703A88E96;
	Sun,  3 Nov 2024 16:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="K9u+j/q9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33AB788EF5; Sun,  3 Nov 2024 16:45:50 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31D3188E41
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 16:45:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E3B9E3FA67
 for <u-boot@lists.denx.de>; Sun,  3 Nov 2024 15:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1730648744;
 bh=38sEGsxFRCZ7T3iImLwgrT+C3XQfW/3vvpo0WuKBhvg=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=K9u+j/q9cDxW8oMjfBQzu7nfiqSWGNjNfNzNOSxToldQ1YZMC9gqaJeZKe2a01i3L
 1vG2yjoiL0h90c2ztfeoH4tJjHxD+kIB0EeaSGximlQ4JQsc7DF6i0B9JaayikpIn+
 FJf/Cx5oDyW2qf5vMrJuvh8hgai8NkZ3uHkOzx4uBoVUhkRQTQqP3q2SkyoGLhwBPw
 9A151jQK2g1uJNQJVjFR10b9FMwetze25KqIF/Hes2MtiN1Y2zGgqrcdXp+cNzAE97
 rqiCgpMmnl1CtK7aE34B/DDqfwJ3/1HfxB3oNrPmatBOXzP36uBiYTt4mW6wonfmx7
 VczgemSaFNbaA==
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43152cd2843so20639835e9.3
 for <u-boot@lists.denx.de>; Sun, 03 Nov 2024 07:45:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730648744; x=1731253544;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=38sEGsxFRCZ7T3iImLwgrT+C3XQfW/3vvpo0WuKBhvg=;
 b=p3PyhA03x9/8LIVIgtedImdxw2vPFs0tBgFgSFoP/dRxRH2GnuEEDQybxtuSm6XRcf
 M83yXCtnUMWGUMvjD6RdXmIZOGf5ddjnJpOMZQVag/hdWwo77DBtk9Slri+oRFkSKqRq
 VMVTqj8OFxzWpNlkuPqBsgHb/AE0u4CS65chCK//tjpzV0M/sywNW5b2NFlqYYHe4aE1
 QgLDhBvG2ZqX+lvrRCtaAUm5RiTbUyc95B04I0o5BlqAj8PaSdrOXSftJAcs45TaUoJF
 3443KEy43NmiDhI9LdRSUbbuQquIoAsUiymEo9JHEQQxU4ojJNV4TpsSYFEyxaSFfmYW
 NXIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmBAVHIVUanPbBcOq86n1yCczc+sMpt+6uGslaP6dBWRQJDPpGI7nzzPQ3JHHzBgRoV5rMMWk=@lists.denx.de
X-Gm-Message-State: AOJu0YylJfnym0ERz7gdC2bfSztf57/882iUQDj3z/1hYc+mjxQcLiJO
 9LkQt8O/rA1yeSvXeNxixeuWILlUFF5FCEf4FE4UIlPhXG8BWaT/X3FmR/ce/fNsl5qoGhLecIT
 bcgLtUwUppYN2P5tutYdOm8HmvKOf7qyCE7vblXHtvJlnG5uoZoXgqmWQGez8OZG6UKc=
X-Received: by 2002:a05:600c:4753:b0:431:5632:4497 with SMTP id
 5b1f17b1804b1-431bb9d1122mr166291025e9.26.1730648744061; 
 Sun, 03 Nov 2024 07:45:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IERIU1rar7x7hN/mCeOb9D9OfLWxOR4TImXoGtE5e6lF0h6+LLyPXJOG+6P4EIZ/kCZDUPOGQ==
X-Received: by 2002:a05:600c:4753:b0:431:5632:4497 with SMTP id
 5b1f17b1804b1-431bb9d1122mr166290845e9.26.1730648743621; 
 Sun, 03 Nov 2024 07:45:43 -0800 (PST)
Received: from [192.168.123.161]
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d5ab2aasm126139855e9.6.2024.11.03.07.45.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Nov 2024 07:45:42 -0800 (PST)
Message-ID: <ae7eadd9-175f-4903-b272-71bf9c862e3f@canonical.com>
Date: Sun, 3 Nov 2024 16:45:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] configs: enable UNIT_TEST on qemu_arm_defconfig
To: Tom Rini <trini@konsulko.com>
Cc: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Simon Glass <sjg@chromium.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Marek Vasut <marex@denx.de>,
 u-boot@lists.denx.de
References: <20241103071200.82853-1-heinrich.schuchardt@canonical.com>
 <20241103071200.82853-4-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20241103071200.82853-4-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 11/3/24 08:12, Heinrich Schuchardt wrote:
> The lib_test_uuid_to_le test fails on 32-bit systems. But we never caught
> this in our CI because we never ran any of our C unit tests on 32-bit.
> 
> Enable CONFIG_UNIT_TEST on qemu_arm_defconfig.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   configs/qemu_arm_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/qemu_arm_defconfig b/configs/qemu_arm_defconfig
> index d042aea49bb..cc4f4540fd5 100644
> --- a/configs/qemu_arm_defconfig
> +++ b/configs/qemu_arm_defconfig
> @@ -67,3 +67,4 @@ CONFIG_TPM2_MMIO=y
>   CONFIG_USB_EHCI_HCD=y
>   CONFIG_USB_EHCI_PCI=y
>   CONFIG_TPM=y
> +CONFIG_UNIT_TEST=y

Before merging this patch we also have to fix the lib_test_dynamic_uuid 
which fails on 32-bit.

Best regards

Heinrich

