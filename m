Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63943C021A4
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 03:06:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB84680C66;
	Tue, 25 Feb 2025 04:06:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cGBcIcLr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BACB980C66; Tue, 25 Feb 2025 04:06:27 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D584807B1
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 04:06:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-472098e6eaeso4947121cf.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 19:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740452784; x=1741057584; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lBO4Tk4K8eV3Ezf8nMd9W9wGeIk7TXZVyW2xcc1bVRw=;
 b=cGBcIcLrQ5oDuNKoHZvlmVw2//dXnpdx12sGHS9qrYHDW4C3gVBqx++oTa3mFxa6JD
 t3UUO6lD8rPWXdwtXJtM1Td17KjMB2OBXp7m8N9m9IPWU+bRHOP5PIZMgQ6sb0iI3PmO
 8c9p6jshBDEEAX+NcJBh0fo6cCwp/8Kwg5WOgrWKGH71lv+Il0LWSjvZyLcfXXJji3Gi
 weYlshyDvIexk9BZbXgqkk4fYXTBBx0ZMdk9/o7vQp+f1Hy2OB7A6NbjOhhfvLd0o3or
 KYkzDaWrynm6XLKIxHMDjD2eCTDammjemfhjwHKxn6SKB2Csupmo1WbnMNkqtHR9hgLk
 U2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740452784; x=1741057584;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lBO4Tk4K8eV3Ezf8nMd9W9wGeIk7TXZVyW2xcc1bVRw=;
 b=jhu71CMIRkU7d69XkMH7GDZzJVxihGRgY9REwWrc0gvbqgn2PtPypHbPCFDqKpQ9vZ
 ME0Y7ouFdiIdh2hATnN0ecq1ZS07SwpipECDL27Tva5EYhN34x1l8w2ycfy8WFW3A3xz
 j3Eld0xCb2ia7FxhcuOhKnnawYG3e1rGK6hTmTejjFuUTr3gm5anvTRNnipVNovEAwcm
 0JTl15E/p3lD94nvN3XNM7UFrZP/hNXGvM98cEs2zO9ilhKrHWxuj/v98J+WkLAbCh3r
 anFGTVGx2SZ1TulmhBCF7T0zuUqLmqhDQCAEPZd3i1PzzHhkBOp5G+mpf94TaJlOGXhR
 pK+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXlkz9mJJgatPqh+kng2A6nB/YixqW/KXq4bf1MJXp2vkenMuSCKZJERKS/tz2yHLjgsd/VZyw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+UhS7ejJg0k3VDDaTNMGFpMaCOfQ+QZbFjlIwKdXUwHkXxb1y
 GZ8Q92ZpSzAkeEdHxIaqVZCoJz2xZWRpQYifV8PTgpLwfNwnvAHuS/fcbA==
X-Gm-Gg: ASbGncu5upRq2Qh3uwFclrFVXUPp5ubEYL2SOozRZrH4dgtPq3YE4aA59V9vCuPSguR
 9CSsjags8q9hroaifLWe+pimjIpKwylqy507f5/wF00SZTs6QZq5AGOR8ZPYZBkuTeBbujzuvcQ
 QvKNHqWmVND3vqZ6v0MYZ7+kNL3pJfF/T7Bsjq12i253nyWHfhyE5I4J3238mNkM1DRUGNQjW8D
 C+LC8GFRoBKP45/5RzIjgMvUXnzxJPmojiNvaRowyGd7yctpWqPmkIVO4nj7Hsuv3c+cgCc2Gvl
 aDcxK98pNTOLuRhEgPF8wV+1c8dO8263OZ/hR0H7Z+rqiYHpKeAC9WtsNI76AkUuXbu8aykN/DH
 2jg==
X-Google-Smtp-Source: AGHT+IFM07ncTIH0N5deA/gAlIsY48mW2V0b6uOxCoDc7VqSltoCzagtgifPAo4dlHPKF4eJt9Ae+A==
X-Received: by 2002:a05:6214:2aa2:b0:6d9:2fe3:bf0c with SMTP id
 6a1803df08f44-6e6ae7f5851mr70271246d6.4.1740452783900; 
 Mon, 24 Feb 2025 19:06:23 -0800 (PST)
Received: from [192.168.1.201] (pool-108-28-192-105.washdc.fios.verizon.net.
 [108.28.192.105]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e87b153fc2sm4595756d6.77.2025.02.24.19.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 19:06:22 -0800 (PST)
Message-ID: <cadbfe6b-b5dc-0ee0-f1eb-20c0136668b1@gmail.com>
Date: Mon, 24 Feb 2025 22:06:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] spl: return kernel image header size in os boot
Content-Language: en-US
To: Anshul Dalal <anshuld@ti.com>, u-boot@lists.denx.de
Cc: vigneshr@ti.com
References: <20250221151752.2618666-1-anshuld@ti.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20250221151752.2618666-1-anshuld@ti.com>
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

On 2/21/25 10:17, Anshul Dalal wrote:
> During kernel build process the header size is computed including the
> BSS whereas it's removed when creating the uncompressed image. Therefore
> the size of the uncompressed image on filesystem will be smaller than
> the size specifiedin the header.
> 
> Therefore it makes sense to return the header size back instead of the
> file size in falcon boot.
> 
> More info:
> https://lore.kernel.org/u-boot/20250214111656.2358748-1-anshuld@ti.com/
> 
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> ---
>   common/spl/spl_ext.c | 4 ++++
>   common/spl/spl_fat.c | 3 +++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
> index c5478820a9b..6d8d6544092 100644
> --- a/common/spl/spl_ext.c
> +++ b/common/spl/spl_ext.c
> @@ -17,6 +17,10 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
>   	ret = ext4fs_read(buf, file_offset, size, &actlen);
>   	if (ret)
>   		return ret;
> +
> +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
> +		return size;
> +
>   	return actlen;
>   }
>   
> diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
> index fce451b7664..ddf85e2cece 100644
> --- a/common/spl/spl_fat.c
> +++ b/common/spl/spl_fat.c
> @@ -55,6 +55,9 @@ static ulong spl_fit_read(struct spl_load_info *load, ulong file_offset,
>   	if (ret)
>   		return ret;
>   
> +	if (IS_ENABLED(CONFIG_SPL_OS_BOOT) && IS_ENABLED(CONFIG_CMD_BOOTI))
> +		return size;
> +
>   	return actread;
>   }
>   

Reviewed-by: Sean Anderson <seanga2@gmail.com>
