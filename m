Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C1CC87FCC
	for <u-boot@archiver.kernel.org>; Thu, 31 Jul 2025 13:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77CA283857;
	Thu, 31 Jul 2025 15:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="fpLsMPo4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E99F8838DF; Thu, 31 Jul 2025 15:57:01 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 840FF83852
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 15:56:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mbrugger@suse.com
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a6cd1a6fecso851367f8f.3
 for <u-boot@lists.denx.de>; Thu, 31 Jul 2025 06:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1753970203; x=1754575003; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=K4rT+rE/ck8O/mgidMKd+RFo20OuI6V5zfDO//dGfTg=;
 b=fpLsMPo4xWJ0foUmzf8IcRD+oRAwwhi4bJHx58DTfj5+YDr6jUNQDbcyP1+Phj5ecF
 hxlPHhr36GlFvbs7shpyfyDukKpsjzN/Ks/W+E4kYDNNQMDPPAlq/1Ne0bA3XToI6dBV
 uOI5ZQijWlKJhTDBs8WIE+OT2Re7zlXzRvpp5LSwsLJokhR1SAdaPkFo1OCJ9E0/8qU7
 hxpjqEtIn8814ygjMGGjpIQvMOLidUicPFD35/PgjQAAX2npSv4cxvEeISSN227ZWnQc
 uoDi/H763BFezrzDXzUQSVZ/4fymOxgTM3lWdIWtQdMYqSVjFdWawokt0YgNvGLaJgOG
 +Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753970203; x=1754575003;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4rT+rE/ck8O/mgidMKd+RFo20OuI6V5zfDO//dGfTg=;
 b=Mcv3172Q3YEXC8A3NW11zUx3K3NgT0WdZey+5EyntswxnR9xI0qZl/Io4WZiXjDPbo
 lDYg2IBcY1KO2k261k8CWM2jNx6GGLCs6c3hb0GMgk24Xw1Kqfs0f8NoAXcv/YoOixKY
 rVi2NhLzh6pn79D3R4xqK3k3PR5EzD6AF3+iPIfno6EbMM+lOvcDFkMmLm9YzwR0i+1d
 fPhm1ZPSqx0UNqq+33xrSXip+BG9/pHAw0p51loHpsszMQvn8SYSddguCio+lRUNGv71
 O7s5snQsshKuMYMBOgCYtpPhI50SF8H/GpYzPiAMxUeRTVPrhZP9rJy1C3OQ1fHCE+5r
 /Mfw==
X-Gm-Message-State: AOJu0YytmR84dlbtXsPLCY/lV2piZ0j7WQezeg6QYoCJRqnj1TiIEMQU
 nVbaO7YdJN1ZFElzLJ7Q7+mlarMnaaH5+/FWPebE/iLvBX7xdzL2HnHYSgac2qOasLk=
X-Gm-Gg: ASbGnctLe3VXbol5m9yWD4yq/s31MygBopgge6cwScaa5AziA09STBBWAKfMvzXDYUc
 hOQY1luYBG+Y0SY3I+3ZAaekyLc8NQSWivHq3WZ1pm7M9e9PlDCc5pPLi1S6xlPOapaMD09YwEc
 tEHABh1PO3TEnVlnP4BQc3t/sonemykNZDMMgoBh7KdXnoCG2MAhD+shoPSPCnYgQMefewg2z+L
 W4JfNasiji0WgZJPBbCN53Mrn62nUOTfQy2MuOGRY1xUvwlLCYsI1vFJoecmvxhdJXbKprefw0u
 xFDeJtSIjIg4I01CvRozZ1d1gVpY+x31A+D8K0gGAUEFbBkOC5tkEo0Yg8BJjTHK7Em9J2MEoQ+
 hIz+Lbt1wQRUVvjJAbU73x9afIheBBVWU8w==
X-Google-Smtp-Source: AGHT+IFpmQt+EgBqDOjsU1UE2jWidPgx2J2W3bmfVtpyrI8GtFgdhJo4PHvR6qNww5rQeX0MRjJUMg==
X-Received: by 2002:adf:f008:0:b0:3b6:d7c:f4ce with SMTP id
 ffacd0b85a97d-3b79503b386mr5033446f8f.54.1753970202906; 
 Thu, 31 Jul 2025 06:56:42 -0700 (PDT)
Received: from [192.168.2.177] ([91.116.220.47])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c3abf33sm2490064f8f.7.2025.07.31.06.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 06:56:42 -0700 (PDT)
Message-ID: <e7d9adbc-84eb-49b5-9eeb-60e961be93f4@suse.com>
Date: Thu, 31 Jul 2025 15:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: bcm2835-host: Remove duplicate NULL test for cmd
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250729-mmc_bcm2835-v1-1-2184f316fc21@linaro.org>
Content-Language: en-US, ca-ES, es-ES
From: Matthias Brugger <mbrugger@suse.com>
Autocrypt: addr=mbrugger@suse.com; keydata=
 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
 PVrr2NoUqi/bxI8fFQJD1jVj8K0=
In-Reply-To: <20250729-mmc_bcm2835-v1-1-2184f316fc21@linaro.org>
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



On 29/07/2025 14:05, Andrew Goodbody wrote:
> In bcm2835_send_cmd the test for a previous command not being complete
> depends on cmd not being NULL so a second test in the code block is
> redundant as it is guaranteed to be true. Remove the test and the
> unreachable code following it.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

Reviewed-by: Matthias Brugger <mbrugger@suse.com>

> ---
>   drivers/mmc/bcm2835_sdhost.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/bcm2835_sdhost.c b/drivers/mmc/bcm2835_sdhost.c
> index 720127468d3..4ec8c672038 100644
> --- a/drivers/mmc/bcm2835_sdhost.c
> +++ b/drivers/mmc/bcm2835_sdhost.c
> @@ -689,10 +689,7 @@ static int bcm2835_send_cmd(struct udevice *dev, struct mmc_cmd *cmd,
>   		       readl(host->ioaddr + SDCMD) & SDCMD_CMD_MASK, edm);
>   		bcm2835_dumpregs(host);
>   
> -		if (cmd)
> -			return -EILSEQ;
> -
> -		return 0;
> +		return -EILSEQ;
>   	}
>   
>   	if (cmd) {
> 
> ---
> base-commit: 182cb30084516c3085d2ca5dde3f105f7625d774
> change-id: 20250729-mmc_bcm2835-c97e9597c25c
> 
> Best regards,

