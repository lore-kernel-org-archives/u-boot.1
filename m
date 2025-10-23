Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A92CCD1BC
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 12:01:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A128334F;
	Thu, 23 Oct 2025 14:01:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="YCt8O6s8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6543B835B0; Thu, 23 Oct 2025 14:01:06 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFCDB8323A
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 14:01:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 3079F3F691
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 12:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761220862;
 bh=0eMaHW4jmMmBSqYRWxSBJiY/cqdXWClK9551W8O/87E=;
 h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
 In-Reply-To:Content-Type;
 b=YCt8O6s89K7ZhqKQjIBTuJEZoCfnKUZBafNbGUAjP1UzwSuhWdePMP95dnR9QkOKK
 zX2lrYxfMU73gKHYz+GpMVFVnBNtdXGUXu2u4Fd8qOee8ziEweBKQcqPczM2KdKXZE
 /SAZ8c4g9UT3jdc3b7ri1RfnRG47HAcVRytdAqjJmbgfHB9UJaPOVKTwjKXcpT3vVy
 xswYIV0h/rPBq5fN7SLLS9Wudywq57/i8J1SWjIhZMrZvhK2O7ZfPrJqTO9Ri4YyCf
 G5y/BAyQA/0H3Y8gPGsEZ050CQYHypSLc1LWbY60g788tvTy7fJfUsQMssE8STklUD
 Z2H+R/9IEiAqV7CogVc3scI6S1qUkEDMqliQespLQMjs2hZbG+D1Hh1VsFopbIrZp6
 SxLTKvdxLm1/w4s3I8fMaDPuTJzH56TGo7MU8P6eYfRoNt8PvYiqPbR7mxg+OQzMJH
 99I/IjEMAewa9SuTFJUwpjN2C5zC45Sr6UHknlYjdj9K6tcMjVynD7gd5wTWMv3+Hf
 EpIamPRtj+ERg619qs1pDH9GeYFGHsoxblQwE8BL/G97x+0Vt9pysFlbVnrWzG5UsB
 +vP1xcy/7UDcNMti3xGnVBNRDsuFuXZQ/nEMxfczVlq0Z62wLLuCh/OUk2uG327Zsk
 aYNqlIZVUg6SpmRe1ebDrM/c=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47106720618so4770085e9.1
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 05:01:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220862; x=1761825662;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0eMaHW4jmMmBSqYRWxSBJiY/cqdXWClK9551W8O/87E=;
 b=H0g46o1RVh34w9UVGRLwpGmzF2Lcb3LYEMesXtkgAvCU8Dtn7AX7tNnkPpBRmjjIWj
 6Xv3BxUF8lv62YgoaKW873pr/9Qi1BNAuj+KS5eLyCWMl0tgo0xkghuNBYrzbPk50DoX
 UH2gIqeAJanB70eQv9tkJ7gWV4pjgECmdAbNuHBa/vpqvpLRuPeh7mqpVUH1c+5/3kR5
 DWom1ehtqzGmWgXDu3o3FknjcWUa6jM5Ol2ZUs/HoHc/1+vrJyTQE1ooEOfFETvMIIew
 vj/4NKSjFgAv2vODtJhduwI8pazBmH12OEaI/jNd6C/CnhjelXQTeWNS77KGirXPQUjk
 50Lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5ZJPZjIXj37dgTdim312DlNhWUntol3vW83k84i2785pcpaNzISKs7AkdRH38HLm4yvDSbSg=@lists.denx.de
X-Gm-Message-State: AOJu0YxpnVW6Tcgwv68/KY2gKWWNrnRdQq2XO/0drd22FWanAjjUwtxW
 E9Wu7st608SLkiTE0E9in0vhPk924gzf2M6yqTiY8wiKC42xkAJ34btZPZJVTmSrvr7MNv4DziQ
 +S2ZLjz+Nk++Ygh9REFFme8UwzJmf0CuBjV28jSh1WmKrNqw02ttlw4CF/r4nu7Dju1K/Ui4=
X-Gm-Gg: ASbGncsVe1Z6Y/Dhb/89AOuEo1BhPF1Jkjjjt3OFkwG2t1OS4wqu6vDCAsBIxwPebux
 k2T6M3OCIDKodlH1U89ha+pWpxFL1phK4tBuO5f6yw+gz1qFtwGANJ8ClfDmjSXa3H9GTN9XvA7
 ZF175VbtyPk0ste1Z5MU5Pl2CVL5rIv3wZApV/8cnXztFe9Eh1Sh8K3XzJmnFJXXNfzUp17vYAE
 xfTALRtwyDfjPeTfT+uBoDDYa5wTL53hNzsa1KxI3YIA95eViqJEudWENX8V+WI7/Hj1COdTCRW
 8YuM18QvXLdYkLu+3QAYNsZwImi7Bm+s+HkCQl9FnXNn7zamkl/5HCzNewJBGu8e3JBdQqmt9FD
 YfC17twz4MEZ+INLGqsocIzNPu1lAXVOsSHQqKsP+jyzu4rXnZa1kqFg6xJAic4U=
X-Received: by 2002:a05:600c:1d9c:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-47117917babmr193280655e9.31.1761220861587; 
 Thu, 23 Oct 2025 05:01:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0qhHEa0RG23YMtLnCbZdR4FZg1GeB3SS3JtckUNby3NWLLmul2mdR62cite7fJa6Mx1lE/g==
X-Received: by 2002:a05:600c:1d9c:b0:45f:2cb5:ecff with SMTP id
 5b1f17b1804b1-47117917babmr193280315e9.31.1761220861200; 
 Thu, 23 Oct 2025 05:01:01 -0700 (PDT)
Received: from ?IPV6:2a00:2381:43b9:32:f5b4:9544:a6ae:e055?
 ([2a00:2381:43b9:32:f5b4:9544:a6ae:e055])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427f685sm95693375e9.2.2025.10.23.05.01.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Oct 2025 05:01:00 -0700 (PDT)
Message-ID: <8f4a01c1-dd8b-493a-b0b5-01b7a82f23c6@canonical.com>
Date: Thu, 23 Oct 2025 13:00:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [resend PATCH v4] disk: dos: Add all options for EFI System
 Partitions
To: Peter Robinson <pbrobinson@gmail.com>
References: <20251008150832.627727-1-pbrobinson@gmail.com>
Content-Language: en-US
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mark Kettenis <kettenis@openbsd.org>, u-boot@lists.denx.de
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20251008150832.627727-1-pbrobinson@gmail.com>
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

On 10/8/25 16:08, Peter Robinson wrote:
> The EFI spec states that the ESP can be any of FAT12/16/32 but for
> compatibility doesn't necssarily require the partition to be the
> EFI partition table ID of 0xef. A number of arm devices will not
> find their firmware on a FAT partition with an ID of 0xef so also
> allow the original FAT12/16/32 partition IDs as they are also
> permissable for an ESP.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> Reviewed-by: Mark Kettenis <kettenis@openbsd.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Hello Peter,

Please, read the Microsoft documentation:

"The Extensible Firmware Interface System Partitions on an MBR disk is 
identified by partition type 0xEF." [1]

The other partition types like 0x06 have non-ESP use and should never be 
taken for an ESP.

Updating partition tables is trivial. Just fix the buggy partition table 
entry on your ARM devices instead of this cumbersome patch.

Best regards

Heinrich

[1]
https://learn.microsoft.com/en-us/troubleshoot/windows-server/backup-and-storage/guid-partitioning-table-disk-faq


> ---
> 
> 
> v2:
> - Add 0x0c option
> - Make hex constants consistent
> - Move from if to switch statement
> v3:
> - Fix switch brain fart
> v4:
> - Drop boot_ind out of switch
> 
> This is just a resend, it fell off my radar, and there was a CI failure.
> 
>   disk/part_dos.c | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/disk/part_dos.c b/disk/part_dos.c
> index 18dd35c9b98..92d6fa6e028 100644
> --- a/disk/part_dos.c
> +++ b/disk/part_dos.c
> @@ -39,10 +39,21 @@ static int get_bootable(dos_partition_t *p)
>   {
>   	int ret = 0;
>   
> -	if (p->sys_ind == 0xef)
> +	switch (p->sys_ind) {
> +	case 0x01:
> +	case 0x06:
> +	case 0x0b:
> +	case 0x0c:
> +	case 0xef:
>   		ret |= PART_EFI_SYSTEM_PARTITION;
> +		break;
> +	default:
> +		break;
> +	}
> +
>   	if (p->boot_ind == 0x80)
>   		ret |= PART_BOOTABLE;
> +
>   	return ret;
>   }
>   

