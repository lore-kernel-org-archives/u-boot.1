Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3D7C44501
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 10:48:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BBFC184118;
	Wed,  8 Jul 2026 12:48:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="HmnZuG1n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E3E8843B6; Wed,  8 Jul 2026 12:48:16 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F175F838D7
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 12:48:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so3669355e9.2
 for <u-boot@lists.denx.de>; Wed, 08 Jul 2026 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783507692; x=1784112492; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=F2nkJH94TTrgerifuxqWkF7boW+uWJ6kp8cFPqF9AlI=;
 b=HmnZuG1nQDSeFkmNYrVzrPvi56XJjIE3Y/2FXbaMb3P4rHpERyV4LBrtRcE3B7iL2z
 cw5Ky0/MXNs8k3puMqwxP+ssM4MvovHYWg5CNoLQTnbr31v1acseXto5BygSQ57HcStr
 WtMkbF+MeQyYyoFBDt0Xnr8sNA9lMJ2aXiVuqh29KYT9W4QD8IivOdfSrdF/yLNMbQvC
 nN1G6Dl/oYX88EX4NSpeuUyKGlvEGnJBxRrFeXoY8jIVdHT+5gXRKpTqrk2E3plVwLep
 5j6stdo7xstWhBFOiB+SrM2HvWD+pAE7MY2ut6j7dpEgIsTsaeJMjM9/mxZ6MCkPleif
 mi4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783507692; x=1784112492;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F2nkJH94TTrgerifuxqWkF7boW+uWJ6kp8cFPqF9AlI=;
 b=q0p1fZKzd3tYAky6BQv+sMbW3YcZFTP8fJ7Rg8mX61oIVvBVLgFQ4ORucUlMEe1bxr
 uqjT5BWuF/c6E9bXllMeOjYjM+TB0ZqzKCFm37nksJ5emX8oSE87Ss80zpEFIOqq0BNG
 Nc4mTs7DqQlNrrXlIcbR3j1jzK2YsoPz3YxiXuiCjKzz1CAS1DE6pg+XurCPI/zHEq+W
 q0BcG/toJC/XnRDIOCZV1v9dKHx1XEWsoiIpxMtPstDaJ210/Z5cDjX0RD0Oz7T5e8wD
 G+Lzo2BKfT0u+bH/3IxBgeMf9L/zyive91ejDoQ7JCy9IaZGmTVaeRERSrbEoLqIbo3p
 vV4w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoLzNs2wEnE+sd6RT8EgnAeffL8LA5Rn7T8H6cvYMD2hgrH8IB7AbKorOurtJ2URbkMsJpoJxw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz03HyrbtxsxYaNsvGa+IaBPC4apw3a8QZz9Uwj3AJFpX+kXM9e
 dhTV0UQ5fIohJ5VtvlE9h9ile8hNuPUnIM12BsVcr28ZhIzmXIDydH3xwVRfwY+7woo=
X-Gm-Gg: AfdE7cnxSqNiThT/+5jTrHsZJtSPOZf8CkXeL3DRg6W8ajZainm1BZKQRkiwssd1LEP
 DG6lHEf/z1bdsqp40MG7rfQ+vCZ1VjDGgPWatYmFxQMPkzVKyx8uQdthfOz6wg9deFO28xIHxrK
 ckIHlei2QyF8yYOuQdmb3Lx9TViNCIs1pCXO48DUDouOFWIyNL7JNnWKVQYUlTk3EK/0oN4vXE2
 u2MPwHv+9bwjzYIzmRzsipIcZ4ciBfZfTkW4Y4bpRqZUbO4Vjujo1xNBwjcYuGHDuu2xplVLo7d
 C/ersj7dK56nELCAphOPVdgqi37ncF/YuC9XOad4puSjCeKqlBh2hoj1MA7e0prLbnkGffND8vI
 nBkNwl+SYWZlhNrMvGEE8TK3McKFbZQJkVHent72EBrUA8IMYcefvuYaQFXUaeDkmk0UnUHPRLP
 FEJGFA6nlGqdUrcEupuPMz7TWzqB9MrmV2XGtbc0GlTxM7pXpHf8diH6D4LPqn0W5Gez7sKEo=
X-Received: by 2002:a5d:5f82:0:b0:475:f0c2:5b05 with SMTP id
 ffacd0b85a97d-47df07a463emr2027133f8f.59.1783507692362; 
 Wed, 08 Jul 2026 03:48:12 -0700 (PDT)
Received: from [192.168.0.25] (static-163-111-87-188.ipcom.comunitel.net.
 [188.87.111.163]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960816sm40139133f8f.29.2026.07.08.03.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 03:48:11 -0700 (PDT)
Message-ID: <5fbc9e5f-1a34-4bce-a49e-d861a3f79bc8@suse.com>
Date: Wed, 8 Jul 2026 12:48:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpi: copy /chosen/bootloader partition and set
 boot_partition
To: Gregor Herburger <gregor.herburger@linutronix.de>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Filip_Kokosi=C5=84ski?= <filip.kokosinski@gmail.com>,
 Anders Roxell <anders.roxell@linaro.org>
References: <20260708-tryboot-v1-1-13a14aeacf71@linutronix.de>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20260708-tryboot-v1-1-13a14aeacf71@linutronix.de>
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



On 08/07/2026 08:30, Gregor Herburger wrote:
> The Raspberry Pi has the "tryboot" feature where it can boot from a
> different partition enabling failsafe A/B updates. After boot the
> firmware sets 'partition' property in /chosen/bootloader. Copy this
> property to the device tree and set the env variable boot_partition.
> This allows boards to create a bootcmd based on the boot partition.
> 
> Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   board/raspberrypi/rpi/rpi.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 1da5df92351..7a2ff646ac8 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -480,6 +480,20 @@ static void set_serial_number(void)
>   	env_set("serial#", serial_string);
>   }
>   
> +static void set_boot_partition_fdt(void)
> +{
> +	void *fdtp = (void *)gd->fdt_blob;
> +	u32 partition;
> +
> +	partition = fdt_getprop_u32_default(fdtp, "/chosen/bootloader", "partition", 1);
> +	if (!partition) {
> +		printf("Failed to the get partition property.\n");
> +		return;
> +	}
> +
> +	env_set_ulong("boot_partition", partition);
> +}
> +
>   int misc_init_r(void)
>   {
>   	set_fdt_addr();
> @@ -489,6 +503,7 @@ int misc_init_r(void)
>   	set_board_info();
>   #endif
>   	set_serial_number();
> +	set_boot_partition_fdt();
>   
>   	return 0;
>   }
> @@ -641,6 +656,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>   
>   	/* copy uart clk as provided by the firmware */
>   	copy_property(fdt, fw_fdt, "/clocks/clk-uart", "clock-frequency");
> +
> +	/* Copy the boot partition */
> +	copy_property(fdt, fw_fdt, "/chosen/bootloader", "partition");
>   }
>   
>   int ft_board_setup(void *blob, struct bd_info *bd)
> 
> ---
> base-commit: ee5d46b45ec0c63f8f9dd1e816e0dac3452ccc3d
> change-id: 20260708-tryboot-c11aa44bf1cc
> 
> Best regards,
> --
> Gregor Herburger <gregor.herburger@linutronix.de>
> 

