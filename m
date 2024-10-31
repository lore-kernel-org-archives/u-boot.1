Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69506D767F4
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 18:16:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 005088928E;
	Thu, 31 Oct 2024 19:15:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lsk8hrB2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B716288E67; Thu, 31 Oct 2024 19:15:57 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8451488C05
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 19:15:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eugen.hristev@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3807dd08cfcso984458f8f.1
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730398555; x=1731003355; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c+JVRAJPpV8S+tp+YB80g7rtnQe50A67vDXBVxMT+Gc=;
 b=lsk8hrB2ZoJEHrchxuevxSZd6SGOdm7zg7zNevFjkKrhStn+1OcqsrK6Sz/emyIgek
 yTQEYNJSAhDczjhXEGk2KzS+jQTi3bI5SGcVUmiZlYIBqclYbS6FguJPF9oZr1lrLC8t
 /aeTG1zJq9XEgW2B1kLyu38Q/rCBlztuaJxvsL4vmDoFKeH7MgriuypkOk679I5+KrPS
 unz5hMo/yU50wQ61SHzCiict4jGWC8dyS56DLnbnqXjPTG+Kk9Hx4LH5TqbNz7kFN0iX
 76gtgxHRJzf5PGruJzu7W+xzwtLHg0aYQ6hSnIRQ0IJ1xSpIJIqA6KitBhois4nkDllX
 lsMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730398555; x=1731003355;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c+JVRAJPpV8S+tp+YB80g7rtnQe50A67vDXBVxMT+Gc=;
 b=QIrjmOKY7BZlJ4FZzujX/J7E4scDZBMqutthUvMKLMV7gILgFuDivkvkFrNSr2riw/
 d5+fdDTa30Xq/DI0VjOhFZWDUt1b/cCGocfcMY62vevRL9Jp4ZyarZEBaEnRugxFi2BS
 kD/YocgguxZI3FXUZYNEPCAgr37Rkm2SuSIBB4cmyVXR6qzY0c7yFnV+SB86sy3lZUC+
 aLgL2f31DJxtDL4tn98i83mAjbTPxbsfty/GOx2cFqHZcyqBkZy4foUJxiPb8L5qY1X0
 Ou5m7MwdOfyisMlkCWqOIccB2ZUsnxLErFjWnZyphG1YEJENRqfMGX/x3SbDlt+9nifA
 MhTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ3h23ibr2QC5cP78jDgFs77eBhm2ntmi4fafLgH6xjEVHZ2QogrQQ9yY7uUWzpzPzbx4q3VY=@lists.denx.de
X-Gm-Message-State: AOJu0Yy+Blcru6hBoJIqX36M+ybH/j5YRCrewJVaF3M6sSiSwjzSnjUf
 n3cpq2W62nq3dTPMkUzP8gb63dzchCz0kI9hmFoIv97+JFZAeu2lF+cZZMTZkNE=
X-Google-Smtp-Source: AGHT+IFRsmOHX8oNXb4qmwxtwLJZYj7HaFrAe1MToL7Z0j9bJOjCPqHS6uMEk2da+4CZNwX9VX9FiQ==
X-Received: by 2002:a05:6000:4014:b0:37c:d1ea:f1ce with SMTP id
 ffacd0b85a97d-381c7a6a643mr882820f8f.25.1730398554893; 
 Thu, 31 Oct 2024 11:15:54 -0700 (PDT)
Received: from [192.168.0.140] ([82.76.24.202])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c11898easm2845122f8f.117.2024.10.31.11.15.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Oct 2024 11:15:54 -0700 (PDT)
Message-ID: <e457b630-bd7d-4f7d-bd4e-20f0e3fbc9a2@linaro.org>
Date: Thu, 31 Oct 2024 20:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] rockchip: rock5b-rk3588: Enable automatic PCI
 enumeration
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Jonas Karlman <jonas@kwiboo.se>, u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>, FUKAUMI Naoki <naoki@radxa.com>
References: <20241031180212.116330-1-sebastian.reichel@collabora.com>
Content-Language: en-US
From: Eugen Hristev <eugen.hristev@linaro.org>
In-Reply-To: <20241031180212.116330-1-sebastian.reichel@collabora.com>
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

Hello Sebastian,

On 10/31/24 20:01, Sebastian Reichel wrote:
> PCI enumeration is required to detect the onboard Ethernet device.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>   configs/rock5b-rk3588_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/rock5b-rk3588_defconfig b/configs/rock5b-rk3588_defconfig
> index c54e13e8732c..e5b9f7d326b4 100644
> --- a/configs/rock5b-rk3588_defconfig
> +++ b/configs/rock5b-rk3588_defconfig
> @@ -17,6 +17,7 @@ CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SPL_SPI_FLASH_SUPPORT=y
>   CONFIG_SPL_SPI=y
>   CONFIG_PCI=y
> +CONFIG_PCI_INIT_R=y
>   CONFIG_DEBUG_UART=y
>   CONFIG_AHCI=y
>   CONFIG_FIT=y

This has been added and removed before, please see

https://lore.kernel.org/all/20231104130451.111020-1-martin.roukala@mupuf.org/T/

this commit adds it
5b269ed404dc ("configs: rockchip: rock5b-rk3588: Enable CONFIG_PCI_INIT_R")

this commit removes it again
191ece249a96 ("rockchip: rk3588-rock-5b: Enable support for PCIe SATA 
cards")

Eugen


