Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5392E77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 10:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20047801A0;
	Fri,  3 Jan 2025 11:27:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="bJRd6Qm4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03A47802EF; Fri,  3 Jan 2025 11:27:57 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C100780196
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 11:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so86940545e9.0
 for <u-boot@lists.denx.de>; Fri, 03 Jan 2025 02:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1735900073; x=1736504873; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=iRq+87k9ZRtRbyY+8i62hQgQ7JwAyYtAaXnZKF8dNX0=;
 b=bJRd6Qm42WzqGYlzrx8qvT/kBgtBY71BQnO5wHrjVE5t+/lWwZy7pnJY8xvazRvLtf
 cAh7BIKOn7rS+fNrXhYfu/QSybAcCh4cGxtzyul2aeazRW9DEdeA9x+WES8aDv1a90iG
 D80+U0GvAyY0+P0SRrsytO2uCaMpD8Vn3duM20iV7nEB+YaRPTUl48rE4O+n/eLRt3fS
 hGXNZR+sHzhkw+tvWkvgQ97Q3ihWskSKS5dKMdqUHCrOK04m6lcYRvTqef+Smx9tgKfq
 qcqvbwKTTMihN+vFzmeHNFRBMrfbWWeUh7ghMUb3VVAP6auqYR5f+RD7ixMlx/YzB5gc
 Np/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735900073; x=1736504873;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iRq+87k9ZRtRbyY+8i62hQgQ7JwAyYtAaXnZKF8dNX0=;
 b=v9NBSFq2L25LoC1qSiMtFONYopZ3g0DK4RDE2W11bk+GRqqZipcuBQPUnec8lkIaVm
 SEkA+TvAh8KaBjG16yNcyGTBXYCgLlDrgLG1zmZI8pK3UuFm17VnAgPKVRsAvCxKSCq8
 h1vbfntXTreyP65CIli6/nd2az6VGoVDAYDOS/ySqA9aUONiIWfKfN6TpvSniQ6p+vEz
 GcBqPomWDH9UQMIwbO3XFfvBiKY7aXoAZ+cBz5k5SjQywJ/TiJ4PSvj15FXW8A0Zg9EM
 iRu5HFPxAi+MI8K/IQEmAbyaBTSn/+cb2vrpXVyF0mwmiCC0zzC5EabG6SPt9Ypxiw05
 LH0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQqShV18cPJu6Xg6Kt2ZUrUcFtM/JIBi4ho8VDkkEH4j9V1VnxtbM6q9lDSuuNWnVtxMtNfvM=@lists.denx.de
X-Gm-Message-State: AOJu0YwhIWYAagbTTvM1t86TUyoEekc4EktgVE6AXxpcaoyBwV13Wm5L
 UHpvkAne6zkc2wF7frUa5q1nAOOEw3SWvzstXM/BgvHvdFH2Qiewl72UQhXJkiWXXF/LVs+qFEX
 5
X-Gm-Gg: ASbGncsUe3Qj7dJQLOT61963Oq4i6Hz2Gd9d6gDhRcCdQZh0kdsRazUmC+lwa5CZcpO
 aZgBpjd5ie2E3LdJg+Ncy1ue4ueie+fDMFMQZFs2xQHsSdTYy8WbbPlKNGjigFSkEU2+Iqun2dR
 uIn6gzLJ0K0ICNQhuZst9vAgwMg42Hl3oV7HeG28DMyb+dq3AtFc+IEw2DU2Z+iQtCrol/byqHb
 OOsYllKTmfRhm3oArdv5s8rAf6Bq9NrJ28XbMekx4ob9UkHZg58UEhmWXBj
X-Google-Smtp-Source: AGHT+IEYv4CMqEItLWWFMgsg9W9oWYBnUc3IhUWVjQWn/FQjFaOnny5zdRFjaIkRbHKzlYMR+O7EMA==
X-Received: by 2002:a05:600c:4f84:b0:434:fec5:4ef5 with SMTP id
 5b1f17b1804b1-43668643743mr407179655e9.14.1735900073050; 
 Fri, 03 Jan 2025 02:27:53 -0800 (PST)
Received: from [192.168.2.177] ([207.188.163.222])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c4b0sm479409045e9.35.2025.01.03.02.27.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 02:27:52 -0800 (PST)
Message-ID: <63d9fb2c-1533-4023-9b89-09a9077bb940@suse.com>
Date: Fri, 3 Jan 2025 11:27:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rpi: Add identifiers for the new RPi 5 series
To: Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.denx.de
References: <20241229144607.1051889-1-pbrobinson@gmail.com>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20241229144607.1051889-1-pbrobinson@gmail.com>
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



On 29/12/2024 15:46, Peter Robinson wrote:
> The Raspberry Pi foundation have released the Raspberry
> Pi 500, CM5 an CM5 lite devices so add the assoicated
> revision identifers so we can detect them.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>

Acked-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   board/raspberrypi/rpi/rpi.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/board/raspberrypi/rpi/rpi.c b/board/raspberrypi/rpi/rpi.c
> index 18be244aa79..1e43c631898 100644
> --- a/board/raspberrypi/rpi/rpi.c
> +++ b/board/raspberrypi/rpi/rpi.c
> @@ -193,6 +193,21 @@ static const struct rpi_model rpi_models_new_scheme[] = {
>   		DTB_DIR "bcm2712-rpi-5-b.dtb",
>   		true,
>   	},
> +	[0x18] = {
> +		"Compute Module 5",
> +		DTB_DIR "bcm2712-rpi-cm5-cm5io.dtb",
> +		true,
> +	},
> +	[0x19] = {
> +		"500",
> +		DTB_DIR "bcm2712-rpi-500.dtb",
> +		true,
> +	},
> +	[0x1A] = {
> +		"Compute Module 5 Lite",
> +		DTB_DIR "bcm2712-rpi-cm5l-cm5io.dtb",
> +		true,
> +	},
>   };
>   
>   static const struct rpi_model rpi_models_old_scheme[] = {

