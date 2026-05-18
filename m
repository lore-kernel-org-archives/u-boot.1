Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16817CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:03:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B10983FEE;
	Mon, 18 May 2026 10:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Mb8Xx/tv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D326884659; Mon, 18 May 2026 10:03:10 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF09383AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:03:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso1185126f8f.1
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091388; x=1779696188; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3kUxLqbC0P3UuFWIgSUC4ZsSZFAvo9EAvScdPo4WIgY=;
 b=Mb8Xx/tvzTuTn+XplzLP9LCipcQomOxTu2u+N0W1BHl5VjqMxMcqWZml2nBdOr02ar
 wSVH5zyxaY9+tGmWmf1kd+L5CwdfiO1oQsnXNhPRo7soI3VTPg0nw7+/BrNfisaPMahz
 YBfjgYHFO4/9kHvH7pW9iw+vcDJFe7+GBjk0flY9ck6OTMiWpCsSlOc4Xhb3lHp7JZRR
 Oh1CWvHPRbBmU3J4HDirsVPqEi3WHRVp6HoXmQ+1XCudD7om5SXKeoXqxrZRGjNqAXXR
 CnwYY8qas7a47OU20lTuIkmXoeva4uKLkgTRK3Jwz9yWSv4n2H5crcrXeo8jn2Fnlc2A
 CUWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091388; x=1779696188;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3kUxLqbC0P3UuFWIgSUC4ZsSZFAvo9EAvScdPo4WIgY=;
 b=PLKdQJdpHZeIG+655xRezZ6dJOaQbYhAv/MEebur4+XcptDJoOHrAOH6bH7LsM8/gI
 ueq2W9/VD3aZtJbU+B1SByzNlAPKaY/vq04mZl4XgOf2ERhTubP9p2bNq/V7DPlESPK4
 NWrFOqTFeW5ryI3AIA8zK812/JDvsk73YV0VpqWLwgPvL3OCP7839+HkLr9UX+v2/nKK
 AoP8d/AEDoSo25Om/tFCJKTK7Tr4Icvj3rlOxMOw5OGgdcf4X8pso15vCj0XCskmv5Fc
 SIytaKsv9OJvbhsH86K3g98BzAxIxhMigPkmmG6JWt1OIl+DmCoN+PmIIvBQo23QozLW
 Mdgw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9YX8tlDxSoTaPQBC8O/tzPKxi/onENOcS7XBm5MA20Qfp9K9a7AicHtGFPZBXS6g0QixXLJ7g=@lists.denx.de
X-Gm-Message-State: AOJu0YxrahiNSiYttHTydt748eJJmkRLNxwGjqhRf7XMQYsvl7PGc9tc
 6NHS+St0rZexgoqCbYdbz40wXB6UWo8zJ830tADoLOP2aoJA7chEAKdWzozOMiRlyZg=
X-Gm-Gg: Acq92OHkWxGVYgjDDKjDet3HTRa+xjUuAw4npWefxNu+VYbGMka/2z2fsBQU7uMqAwq
 ut41HSGeLm2shFK/pVj4rqN6Uc9ochPYRI43VUddSaVnWHMVHGmmLBy6g5FKQs8crQJvI4RwXI8
 mWU7Ct/FrfVmG9AGwESTr2/Kwfec+GCkgNUqZj8Ge4+m83rb0x/tgjoOw6g18phW17E3K8jDYYu
 R5QETJ0WXkHWPd1hPAIOVEgYfu51JJC4z+I7ZvR/u6qCtnDLZacolb7bHlqRHPy9iwsLTnn3ulf
 RC9X8vy1crF8Ke01+0XMESkHk9AclQzSA9mRhvt9bL3nIoVCXpkBOXYYXeHaNO4nq5aYdtNel/p
 hynG825b9P7mCHtNhYxjnq/clNXD5rQ4KIxXfabi8NUDcYavY30R+XXx3IawgcZjPpJpqx34XWm
 wjwM2GzXbP8cX/p8L+HhW8uWn5dmVE8+go3mK2mxjnRrhPmIb242Q6jHdFi6+mI+INKg==
X-Received: by 2002:a05:6000:3108:b0:43d:7ba4:6b5a with SMTP id
 ffacd0b85a97d-45e5c587914mr20959637f8f.22.1779091388118; 
 Mon, 18 May 2026 01:03:08 -0700 (PDT)
Received: from [192.168.1.36] (p4fc3dd86.dip0.t-ipconnect.de. [79.195.221.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e767ee0sm33214926f8f.1.2026.05.18.01.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:03:07 -0700 (PDT)
Message-ID: <e718cef2-30ce-4a0d-991e-b1969aa4717a@linaro.org>
Date: Mon, 18 May 2026 10:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] board/qualcomm: qcom-phone: Add poweroff command
Content-Language: en-US
To: Biswapriyo Nath <nathbappai@gmail.com>, Sumit Garg
 <sumit.garg@kernel.org>, u-boot-qcom@groups.io, u-boot@lists.denx.de,
 Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Danila Tikhonov <danila@jiaxyga.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20260512-ufs-sm61x5-v1-0-c022cf988e89@gmail.com>
 <20260512-ufs-sm61x5-v1-3-c022cf988e89@gmail.com>
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260512-ufs-sm61x5-v1-3-c022cf988e89@gmail.com>
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

Hi Biswapriyo,

On 12/05/2026 16:44, Biswapriyo Nath wrote:
> This command helps to shutdown the device directly from serial command
> line. Or, the phone has to be booted into recovery mode to power off.

Awesome, this has been sorely needed :D

Would you mind spinning a v2 and moving the config option to
qcom_defconfig so the command is available on all boards?

(in case you didn't know, b4 trailers -U will pull in the reviewed-by tags)

Thanks,

> 
> Signed-off-by: Biswapriyo Nath <nathbappai@gmail.com>
> ---
>  board/qualcomm/qcom-phone.config | 1 +
>  board/qualcomm/qcom-phone.env    | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/board/qualcomm/qcom-phone.config b/board/qualcomm/qcom-phone.config
> index d24094eefddb..e4727fa8b930 100644
> --- a/board/qualcomm/qcom-phone.config
> +++ b/board/qualcomm/qcom-phone.config
> @@ -5,6 +5,7 @@ CONFIG_PANIC_HANG=y
>  # We use pause in various places to allow text to be read
>  # before it scrolls off the screen
>  CONFIG_CMD_PAUSE=y
> +CONFIG_CMD_POWEROFF=y
>  CONFIG_BOOT_RETRY=y
>  CONFIG_BOOT_RETRY_TIME=1
>  CONFIG_BUTTON_REMAP_PHONE_KEYS=y
> diff --git a/board/qualcomm/qcom-phone.env b/board/qualcomm/qcom-phone.env
> index e91ae3ecdfbd..f9911340295f 100644
> --- a/board/qualcomm/qcom-phone.env
> +++ b/board/qualcomm/qcom-phone.env
> @@ -40,6 +40,7 @@ bootmenu_6=Dump clocks=clk dump; pause
>  bootmenu_7=Dump environment=printenv; pause
>  bootmenu_8=Board info=bdinfo; pause
>  bootmenu_9=Dump bootargs=fdt print /chosen bootargs; pause
> +bootmenu_10=Power off=poweroff
>  
>  # Allow holding the volume down button while U-Boot loads to enter
>  # the boot menu
> 

-- 
// Casey (she/her)

