Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1462FEE57DF
	for <u-boot@archiver.kernel.org>; Mon, 11 Sep 2023 05:32:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B3F486D10;
	Mon, 11 Sep 2023 07:32:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hWgAZ3TO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF9D686D11; Mon, 11 Sep 2023 07:32:12 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25D3886D09
 for <u-boot@lists.denx.de>; Mon, 11 Sep 2023 07:32:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bhupesh.sharma@linaro.org
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c0f4ad9eb1so20136a34.1
 for <u-boot@lists.denx.de>; Sun, 10 Sep 2023 22:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694410328; x=1695015128; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ey6Hr9jr5fDFa0pgv+y0SJNCoWCsunW6WI7wk+k7Vqs=;
 b=hWgAZ3TOlv07I5LD8idg+QnGSBBZPWod6P2ri8nNvs+mpjNirPyQNgO7A63axtFuQ8
 aC8wjKpvHlDzovKhbn8PEvDCjm94xxYMlP+1v3MQXOnf2L+D/lWy69mc6vbgJpX8lFnx
 damEilE6EygmBq40MJvLBvxO1uLuinT23X2nFCZKmbJ//viJNb+8KewvKXAzakbtrz8c
 1WIl9bYhZSvDlsQOJM7fbd2YKk65bvVH3CUeQpmeNyBWyoKEsrNqgaEcKhPSYWics8d+
 Qry6CPBVvuT7eHzwRJWqAszAWwC8E/cnMr8oqz9g60rMx/LPjHc181Q7lASV95Qe0blC
 951Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694410328; x=1695015128;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ey6Hr9jr5fDFa0pgv+y0SJNCoWCsunW6WI7wk+k7Vqs=;
 b=NeZBrcBV2/GrWCiLtF4T2sw7HWQwRMqh+RVYS/IVFeM6jIq0ENp7leJTc6nE3MuyYY
 Eiu8j3Blp/MlODD/2bl5ltkjs3dhG49MPhQ2+1QJW3wNAt2XAkA+Il7GXiaTceZXGiN8
 y3MFBCI7lx3ev9fpeIaWLpxXhoqRL94/lD2NCia3PUZhzG3mbjDUvQIbJ+zjvPeBRpBC
 SIW/Ubr7wh5MKVCA4J45uc23e2TBY7XfhVesDrvlkRBdVskFE166/WfmvfeYJ80reZL9
 RKgMQ/nzKyVUh/5Evt9ZI9WTDVQPqrSDJoAB9JvjageYpoDi8TUBFAhF7xpcd3ILbhRB
 Na8Q==
X-Gm-Message-State: AOJu0YxCnMGbuWR4RyIRm1quk1OmocQRzaXArsEzopydV844kxG3FB9W
 po4orqkx3PRtB4KODdGfSP5sUw==
X-Google-Smtp-Source: AGHT+IEV1/zlpB3nN0S9RU5HayBWqh2debVvFF8TtH7QoMbjL573YANQXK7vtIoz/ZoVZYVrqMr9BA==
X-Received: by 2002:a05:6358:919d:b0:139:d4cb:d9fd with SMTP id
 j29-20020a056358919d00b00139d4cbd9fdmr10469111rwa.3.1694410328630; 
 Sun, 10 Sep 2023 22:32:08 -0700 (PDT)
Received: from ?IPV6:2401:4900:1c60:c4b6:ac3f:9422:8dcf:f944?
 ([2401:4900:1c60:c4b6:ac3f:9422:8dcf:f944])
 by smtp.gmail.com with ESMTPSA id
 f13-20020aa78b0d000000b0068c62a45be6sm4877621pfd.179.2023.09.10.22.32.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 10 Sep 2023 22:32:08 -0700 (PDT)
Message-ID: <dec9662f-eae0-1f8c-423f-2bc69df2d6d7@linaro.org>
Date: Mon, 11 Sep 2023 11:02:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] ufs: ufs-renesas: Drop include common.h
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: trini@konsulko.com, Neha Malcom Francis <n-francis@ti.com>
References: <20230909025435.84441-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Bhupesh Sharma <bhupesh.sharma@linaro.org>
In-Reply-To: <20230909025435.84441-1-marek.vasut+renesas@mailbox.org>
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


On 9/9/23 8:24 AM, Marek Vasut wrote:
> The "#include <common.h>" is being phased out in favor of more fine
> grained header management, i.e. ideally include a subset of headers
> that are really needed. Remove it from this driver.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>   drivers/ufs/ufs-renesas.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-renesas.c b/drivers/ufs/ufs-renesas.c
> index f6086050cde..ae05bdc8102 100644
> --- a/drivers/ufs/ufs-renesas.c
> +++ b/drivers/ufs/ufs-renesas.c
> @@ -6,7 +6,6 @@
>    */
>   
>   #include <clk.h>
> -#include <common.h>
>   #include <dm.h>
>   #include <ufs.h>
>   #include <asm/io.h>

Reviewed-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>

Thanks.
