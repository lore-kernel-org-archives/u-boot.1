Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F338C369C2
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:16:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 502B882918;
	Fri, 25 Apr 2025 19:16:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745601404;
	bh=nTQwn7pmMqBP8Txgkew9j0XkLj9MN98CbJY319hL1K8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n2jWmV1jF4qe6ATZgiy4WUQcQBOwwHblgmZ8QqMBBv/F1ZPpawZUXkwgEAOxfeAoX
	 kfMxbOtxOA2YkyjvKdVHyIAGaudr8HnZa7EIiawQYJVWtkzwQ1bq2e167U0hw9KHij
	 XWoWi7GpzYl7/yzR85x14ljLlT7gq4kczgfvhSz+4p9WjTcF8imD8uZoqsME7LIlGc
	 CQTqoTyoauL70m7xZWjs9FOFyCbeaU24n8S9GkpmSoQKFfTmnqOaYnYCdZww+K/6Nn
	 sYXY8p634eNHXBX7YN+yceKivKksjPpvHHD4LI9J6riVEEwG+53qyskfVKHQH78SXX
	 bXPvVutnTWllw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id B5509828B3; Fri, 25 Apr 2025 19:16:42 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C14C8828B3
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:16:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="KC0noJrC"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D906010275AD5; 
 Fri, 25 Apr 2025 19:16:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745601399; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=nTQwn7pmMqBP8Txgkew9j0XkLj9MN98CbJY319hL1K8=;
 b=KC0noJrCiZ/gX+B8594vlWFnaJ3z4u0RSJf95UV+9VSdUVUDnkSUC7CwYkh9ZZ7hxswwtM
 xapFSi9xlKqnYuCeqch2CElhxCtyIMv/EkseJ+ZwGaIEl43Sg3n31CyPgeUo7lTJLjvXTP
 LAoix7kAlCiXrWTdB8slfAtRkzNnQ8vsXYIGJbBaocHXKfpiyABMc5RJjgbeKpC7bUljWX
 ed7gKkDI1Zc15FlNPRbXoskM+tAm/ppg/25XJQ444bsDfYJYqenBVcwGqKuFRH2G2kXQDu
 zgQOJQRmQqd2+S6JTTmdZT94MVxXxa2kzbngtUYGcezGH+p0s/WmJGnHzf5nwg==
Message-ID: <7519231b-6297-4efc-9d2b-297baa17ac8c@denx.de>
Date: Fri, 25 Apr 2025 19:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm64: dts: imx8mm: Allow osc_24m to be available in
 SPL
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250425135220.1929510-1-festevam@gmail.com>
 <20250425135220.1929510-4-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250425135220.1929510-4-festevam@gmail.com>
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

On 4/25/25 3:52 PM, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> Align the osc_24m node with the imx8mn, so that it can be available in SPL.
> 
> This fixes a long pause in SPL when loading U-Boot proper.
> 
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>   arch/arm/dts/imx8mm-u-boot.dtsi | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/dts/imx8mm-u-boot.dtsi b/arch/arm/dts/imx8mm-u-boot.dtsi
> index abb3aa5b635..a1ae2371773 100644
> --- a/arch/arm/dts/imx8mm-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mm-u-boot.dtsi
> @@ -229,6 +229,10 @@
>   	/delete-property/ assigned-clocks;
>   	/delete-property/ assigned-clock-parents;
>   	/delete-property/ assigned-clock-rates;
> +#ifdef CONFIG_SPL_BUILD
> +	clocks = <&osc_24m>;
> +	clock-names = "osc_24m";
> +#endif
>   };
No SPL-specific ifdefs in DT please , sorry but NAK , I already did this 
last year and it was rejected, and that totally makes sense. Just 
include the 32kHz clock source in SPL DT and that's the right fix.
