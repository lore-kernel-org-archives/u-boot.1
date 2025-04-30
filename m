Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C955AC369DC
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 08:32:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED71382B07;
	Wed, 30 Apr 2025 10:32:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="tuUK12L7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25E7682B11; Wed, 30 Apr 2025 10:32:49 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E89E58216C
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 10:32:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7C17A3FC4A
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1746001966;
 bh=0wZBX+tjlhJX9KikQBdoLtotHF05hyQG2FdbUL24sk8=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=tuUK12L7ZoqDD5fSo0TN3p0BFKcYDkOWDySqfoQK7qf+Qx4sCDgI0E92iF0tMAIPL
 +qaeRvZMZJDpRCkFkDHoYwgNxgjm4RdoRgay3lv6j9w1rh0M36HGwDgGnUm+nnfvmO
 98HbNzqs33B7hTDhpEQ5nnYXtCrK1luEdhPIz9S7ZYiQMrI4afcx/D8VSsvvBJLGBy
 UM7QHMTMdS89ybo18q+QWa4cqrtR93hKey0xaWtdBT/hYMVb0NZGcoR5gY+lOeAs7+
 Fo+xS3xDEyCJd99xf25iDS3FAvRJ7/uocn/dxUwEG+ztysqNK/2V1MmBrs2aSnQFtz
 xuV0/cAphYpqA==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-39131f2bbe5so1908696f8f.3
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 01:32:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746001966; x=1746606766;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wZBX+tjlhJX9KikQBdoLtotHF05hyQG2FdbUL24sk8=;
 b=tT4Yv1jkC+K7r6I69Lm6scO8je/OsX21UBPj2cIfZWEWWIVubv3yNAvClxU1C/RA+s
 pLb7GbeZs5T6oa5d/Xj3y7PbyZzM3Ege2C9kRAWg+bPeDCgpZRoKTE7PROTK26xrBb5o
 XCDe5YMgWCan63NgbfG5ACqJZMbFxUoMer2GxkGE+upLX+wmmcIpXSvuYg5f1WtpLCg6
 g5RYNsA2PvWA06vxyoc2STLSo7y1Eq7d1TgquwFc+FPG5RbA6l3udXdnSjFDHIvu6ZTL
 BqXe2M7fc8CXQdPvizXoemRVLonDrX7+C8Xa8vwSDFYU4mf3+nYPlfsluJFtS7fNiTD4
 IfVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTEKtnN2vcO119oxA8qWuIhop6WFJ/8xi+m3YAWf+tU3a/DdrzXEPeSeBFi6DlTQtJVAwrELc=@lists.denx.de
X-Gm-Message-State: AOJu0Yx09YE537pws58EaqpFlVjPGHZwxBUNvZhHSn1fR5eaN0HAxt7r
 4ibVSiPV11AtSAVWlYcvJmz3fQxwjw8hdaYBF7k3UswperCEzW1vxvNWvc9FXMp9DepsBLIu0dJ
 nVr1MFoMiUI0psuh+7o/xYmkm8aSK+U3aPjNlDz6FfpnoILN0FxGPXjmGgh4980I+W5E=
X-Gm-Gg: ASbGnctu89DDuYQ7Cl+pcQG9dL6UTGVf9yXw3T6Zm0+UZAoozDWS+V0G13Aolz1YsPC
 bdyHsItaD+LcsxG6RTXvNO0H51iq+SzZn2RUc90qLgFYMVPyjabAZLysWkLX+Iq6SUiOnAdZVMZ
 pNmxNBZCv3oYRWqjL0tkbIjtL1aBvQi4vyekCi0qTCRkfK2n44ozb9d3h8U8j9J0puaE+FV7n9c
 77qsJlGjuzu1xwPezcrqdjl+cJy6yzH3q6ZIP/dFJ1HP3pxFxGgp5Y1yLqwux6ZU+OpUKv4PneP
 gwuq7p02jU3v7P3J/IQlKl9sWZ1jvbc9W5KFWScvaqZ7TIBU4aeqXlKm1+wtUWMQKRFjR7Qpeqa
 4wg==
X-Received: by 2002:adf:f7c3:0:b0:3a0:90c6:469e with SMTP id
 ffacd0b85a97d-3a090c646a5mr551133f8f.35.1746001966050; 
 Wed, 30 Apr 2025 01:32:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBbrwUghsBpVgARFgQ8MSL1FozCrpaG2EhevN3kun5bpHxSFSNYj1kkmrWJB0kgBf2/Y8XKQ==
X-Received: by 2002:adf:f7c3:0:b0:3a0:90c6:469e with SMTP id
 ffacd0b85a97d-3a090c646a5mr551112f8f.35.1746001965669; 
 Wed, 30 Apr 2025 01:32:45 -0700 (PDT)
Received: from ?IPV6:2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4?
 ([2a02:3035:6e0:9d1c:a02f:5865:bfa0:f5d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4742sm16020379f8f.23.2025.04.30.01.32.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 01:32:45 -0700 (PDT)
Message-ID: <b1eefdec-6d0c-41d0-b895-ec14e8bfdc2f@canonical.com>
Date: Wed, 30 Apr 2025 10:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] boot: let BOOTSTAGE_RECORD_COUNT default to 50
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
References: <20250430073405.14396-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20250430073405.14396-1-heinrich.schuchardt@canonical.com>
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

On 30.04.25 09:34, Heinrich Schuchardt wrote:
> BOOTSTAGE_RECORD_COUNT=30 is too small to record booting a FIT image
> with EFI kernel, initrd, dtb as seen on the StarFive VisionFive 2
> board.
> 
> Increase the default for BOOTSTAGE_RECORD_COUNT to 50.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>   boot/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/boot/Kconfig b/boot/Kconfig
> index fb37d912bc9..2456856a572 100644
> --- a/boot/Kconfig
> +++ b/boot/Kconfig
> @@ -1170,7 +1170,7 @@ config BOOTSTAGE_REPORT
>   config BOOTSTAGE_RECORD_COUNT
>   	int "Number of boot stage records to store"
>   	depends on BOOTSTAGE
> -	default 30
> +	default 50
>   	help
>   	  This is the size of the bootstage record list and is the maximum
>   	  number of bootstage records that can be recorded.


Here is a bootstage report for the board:

StarFive # bootstage report
Timer summary in microseconds (40 records):
        Mark    Elapsed  Stage
           0          0  reset
   3,181,398  3,181,398  board_init_f
   3,229,302     47,904  board_init_r
   4,182,564    953,262  eth_common_init
   4,276,615     94,051  eth_initialize
   4,280,818      4,203  main_loop
   4,380,713     99,895  usb_start
   5,684,111  1,303,398  cli_loop
  56,443,312 50,759,201  bootm_start
  56,443,313          1  boot_get_kernel
  56,448,158      4,845  fit_image_load
  56,448,186         28  fit_image_load
  56,448,187          1  fit_image_load
  56,451,971      3,784  fit_image_load
  56,483,951     31,980  fit_image_load
  56,483,956          5  fit_image_load
  56,483,984         28  fit_image_load
  56,484,001         17  fit_image_load
  56,484,008          7  fit_image_load
  56,488,891      4,883  fit_image_load
  56,488,918         27  fit_image_load
  56,488,919          1  fit_image_load
  56,524,164     35,245  fit_image_load
  56,524,170          6  fit_image_load
  56,524,201         31  fit_image_load
  56,524,216         15  fit_image_load
  56,528,502      4,286  fit_image_load
  56,533,091      4,589  fit_image_load
  56,533,118         27  fit_image_load
  56,533,119          1  fit_image_load
  56,562,211     29,092  fit_image_load
  56,562,216          5  fit_image_load
  56,562,219          3  fit_image_load
  56,562,232         13  fit_image_load
  56,566,246      4,014  fit_image_load
  56,575,882      9,636  bootm_load_os
  56,575,893         11  boot_ramdisk_high
  56,585,438      9,545  do_bootm_efi

Accumulated time:
                 14,772  dm_f
                 88,688  dm_r
