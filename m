Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1497BC02181
	for <u-boot@archiver.kernel.org>; Wed, 22 Jan 2025 16:16:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7393D80977;
	Wed, 22 Jan 2025 17:16:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737562602;
	bh=QMnraHmTqsq0FiQGhC9YbuTmfAOs8ba4JvHULnOBMIc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zqFpffaQNpu7S5wtCGB7KhrgZXAjNEWvv8545AB898BZm377iyL3V9gb5jmEJlFBq
	 IK0/5//v4jeASY21Fjevvv0dWFvHkior6R6kv/zlrM3oz3PSk/SlB/IAR/x8ei5XfO
	 9PVpoeGz0K3HwWkmbm5LnBrNtOahux6QGQ2foDIQIaN/LA8mmkLpaOQjgUpvzVPBP/
	 01D/YMtjRI4M72qLwbnmT6vjvyjRkpZQQdEJ/0p/+XoEVe6ppOYMrf7SZ/aneK20VZ
	 3Nh8PhdQhnFmp+wzZaXSCr5r/mbvHMYF0tN3IRT8x2TQ5OT8bjSUUU26f0Gjo+dZeF
	 IDbjTyo6cjURQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 346F880A22; Wed, 22 Jan 2025 17:16:42 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D1EE380944
 for <u-boot@lists.denx.de>; Wed, 22 Jan 2025 17:16:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="AhyZDGVE"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 43A62101EC11C; Wed, 22 Jan 2025 17:16:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737562598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QMnraHmTqsq0FiQGhC9YbuTmfAOs8ba4JvHULnOBMIc=;
 b=AhyZDGVEQqNEcx0VC6UMyZ3bvZ28j5DomZYFpiwL7ZP6j0gCgHT2uhJ+xFQVmrg4FK2XvH
 h+atP0gQz7FPOJCCAVQtsGY2e7Os0Yvy8dK/R6o3buVj+u8qYWaygck0gaSRTIlbGaquBk
 dTDCMyj0gEGa0qCp5b/o2a1PwzJwd5R2IlybW2+sYKckcjrSdjEZRz71thNOCyCPefllQb
 MxNnXY2oLzBMaC6v9NXLJHZDiORy+BX1GSurPNVzlyi+3W87Clxo7jxpYw6OHAg9eDIsj8
 cXEhISJhuJcg3r+GT0O+Ct+mlF+h78VsOPbTqwYufWKfuMcnHm+WR0Zj4A18YA==
Message-ID: <00c65b0b-12fd-4d95-b12b-6e31180cc57d@denx.de>
Date: Wed, 22 Jan 2025 17:14:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: maintain qcs9100_defconfig
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Varadarajan Narayanan <quic_varada@quicinc.com>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
References: <20250122160951.1861910-1-caleb.connolly@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250122160951.1861910-1-caleb.connolly@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 1/22/25 5:09 PM, Caleb Connolly wrote:
> Add this to ARM SNAPDRAGON maintainers entry.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba31f86feb6d..5a575f43277f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -630,8 +630,9 @@ R:	Sumit Garg <sumit.garg@linaro.org>
>   L:	u-boot-qcom@groups.io
>   S:	Maintained
>   T:	git https://source.denx.de/u-boot/custodians/u-boot-snapdragon.git
>   F:	configs/qcm6490_defconfig
> +F:	configs/qcs9100_defconfig
>   F:	drivers/*/*/pm8???-*
>   F:	drivers/gpio/msm_gpio.c
>   F:	drivers/mmc/msm_sdhci.c
>   F:	drivers/phy/msm8916-usbh-phy.c

For a follow up patch , here is a hint:

- Rename every qualcomm related file to include e.g. _msm_ or qualcomm 
substring, this could work for defconfigs where msm or qualcomm can be a 
prefix , and for drivers too.
- Use N: pattern match on _msm_ and qualcomm to automatically get CCed 
on all qualcomm related changes

Maybe that helps.
