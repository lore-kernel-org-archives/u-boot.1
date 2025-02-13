Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD1DC0219D
	for <u-boot@archiver.kernel.org>; Thu, 13 Feb 2025 14:42:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E35C80EBD;
	Thu, 13 Feb 2025 15:42:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="Ka3I2g7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3F4A980ECB; Thu, 13 Feb 2025 15:42:28 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B3D180C96
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 15:42:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5de5e3729ecso1929771a12.0
 for <u-boot@lists.denx.de>; Thu, 13 Feb 2025 06:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739457745; x=1740062545; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=viS4Lan7MfNW9iOeksGk29TyutFvwoExv7fRrpJGCG4=;
 b=Ka3I2g7BeHOJV24DNVhcxM7AbOS4qaMgysNFpW5VWlTzaIPygiv3+1ajLp9evwShkd
 U6NG0KAnaCS7orOxBfK8n9gFNW+RqoXkthpzqsO/6Eddq8yXGV34/At7AAV6/6XqY9cq
 H4P+FJ5Q+L9Hr8hST/Mzppo2EXvUbSB0zqlQqcLIz9B4Gm/l87fPuBoE8ETFpsvHHI37
 EbeWhyNIHIu8kwkU2Zlogx9DwYzbq48TDsCS7K/P+1QZ8Pz+4LOYVf08GrW4TfcXI1gr
 C1UeF7fVsf9EniP+q7DZN0DxoDZOKZMKnuiUC2p49KeYBkLhSGOJnZtBTK4n+Zthi2WD
 Z1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739457745; x=1740062545;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=viS4Lan7MfNW9iOeksGk29TyutFvwoExv7fRrpJGCG4=;
 b=I1LQcjycUJyicNCNz2pq2ltpe4dSFK6riiqmYsb6vdNnfyUNXgJok3upwRwKediPgJ
 pLWd6nFo7QzywYRFJF70SZT/bsllTnSf1sgBlFuAw1Zdk1x6cEYw3Zu/P7JOeeDjOfAF
 1oyJvz/AEIwd6tBN4iepWZ8UgQQpGXBfonzOMheyEDaKlfSeurTCyF1ceo8Ce39XXrHd
 lsiUCNNKX+SoR/mHw4aVGMHixhwecBiXpZ9FwU5cwOLtVoQQCdNCPlp7gkWHDoApXiMR
 qP4s3iU18QyH/tublh+RvJlBaauw/6jYQtUd9LbJVJRPoXmBQNqI9FMbsUeGg4FCpbWP
 XPdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUtPhNwYpJEYLJjsJgT/I0YOiwrXJfp/MvJp/Uev6lNXHkSosJxDTEgQJ9yy4FH5abCzwiZXAw=@lists.denx.de
X-Gm-Message-State: AOJu0YwqYQYALlm4Af2wTa5B9eMY0Njry2+bTr/VP6+6xPDA0A05uLAV
 2GOccMNeev1N4kWfbNWaQEDs9UX3c1w4NGKtjL7JLhaVzd1m9lVmRuK0u4u6g+Y=
X-Gm-Gg: ASbGnct5JWgT5fDXRZ6uBa012vvkKJgiFiQWL1Jnyun1lbfY41hbwOfnXXODj1VihsI
 tGo5j6YQAGNUZOafLCL9VEGXeU51ynP3533YACEQubecUDSEGvssEA6iNJYgqGnkmBIOeAVkneu
 FNgRFBSPwtkOCd/RRKgZpdaY5+adRJIW0/T58HkAIl/WyEIy58jyw/hiHkOoT5wN5TztPHxmd3v
 PwgUqea3CcErf2ePczFK0Yy3bsRhhWSIgyEnMP014h6LSJ4RHiVI7DzoPhOW31zHLDNQ+fqMgqx
 sxNvqE97+YQA
X-Google-Smtp-Source: AGHT+IFNQa2Y6AofjLjk2j8esCoRD3tvKMnNyvyQUywApy8vhAiaYfCyTT7KxwzSYlcqu4kn2DnErw==
X-Received: by 2002:a05:6402:510d:b0:5dc:a452:3fb1 with SMTP id
 4fb4d7f45d1cf-5deb088ef87mr6560322a12.19.1739457744623; 
 Thu, 13 Feb 2025 06:42:24 -0800 (PST)
Received: from [192.168.2.177] ([81.0.8.231]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5dece270cbcsm1341098a12.49.2025.02.13.06.42.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Feb 2025 06:42:24 -0800 (PST)
Message-ID: <6bb31aeb-fce0-4b07-bee7-d0faa36017b4@suse.com>
Date: Thu, 13 Feb 2025 15:42:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Raspberry Pi: Keep warnings from firmware in DT, if
 any
To: Fiona Klute <fiona.klute@gmx.de>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250212113902.1495183-1-fiona.klute@gmx.de>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250212113902.1495183-1-fiona.klute@gmx.de>
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



On 12/02/2025 12:39, Fiona Klute wrote:
> The /chosen/user-warnings property is created by the RPi firmware if
> there are warnings to report, keep it to make debugging easier.
> 
> For example, if the firmware config.txt contains
> "dtoverlay=error-example" and that example references an undefined
> symbol "&nosuchdev" the warning can be read after boot:
> 
> $ cat /proc/device-tree/chosen/user-warnings
> dterror: can't find symbol 'nosuchdev'
> Failed to resolve overlay 'error-example'
> 
> Signed-off-by: Fiona Klute <fiona.klute@gmx.de>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   board/raspberrypi/rpi/rpi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 647716127c7..6ca7cd74eff 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -616,6 +616,9 @@ void  update_fdt_from_fw(void *fdt, void *fw_fdt)
>   	/* kernel address randomisation seed as provided by the firmware */
>   	copy_property(fdt, fw_fdt, "/chosen", "kaslr-seed");
>   
> +	/* warnings from the firmware (if any) */
> +	copy_property(fdt, fw_fdt, "/chosen", "user-warnings");
> +
>   	/* address of the PHY device as provided by the firmware  */
>   	copy_property(fdt, fw_fdt, "ethernet0/mdio@e14/ethernet-phy@1", "reg");
>   }

