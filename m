Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF1BC369D7
	for <u-boot@archiver.kernel.org>; Fri, 25 Apr 2025 17:16:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A64B8296B;
	Fri, 25 Apr 2025 19:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1745601406;
	bh=O4Kct9bPs2n1GnxGTzAHlKn0u/xMUGIA7EvGKZ5TqMU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XDDbzcp0LZaFFnQpeyS4/g0fqOEtgQRVFjVx2l8uG1n68Qng/oK93LLKLrG9lfycR
	 tfebnc/fKVAKDQ3VLHLVToI6ULToi+9Z1SVr8A90+2ddDPxuOUdWP6Q9q1PDc+Unim
	 WfOWyGs3fvj4GZB6/5UP5FIi+mk5+IqanfX0S6eulbf6/nFFoWdj/M3vp6fXXv8ZgJ
	 7pMR2DLMPmxp7lJz0l4ETHcsMBXPF7G1GW61JndVBOKmKpDLjvOZTSs/mWuVhivQsb
	 JLO4lgbA0SwgHsSLRvH3yrvehjuMwqvvSUr4sZZ1nGD5O7fLMT23JOFeMKleeRKuiq
	 8OGHJDrxkb/yw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 60F87828B3; Fri, 25 Apr 2025 19:16:43 +0200 (CEST)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72E0C82918
 for <u-boot@lists.denx.de>; Fri, 25 Apr 2025 19:16:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="NkGHcne4"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 7044F10271412; 
 Fri, 25 Apr 2025 19:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1745601400; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=O4Kct9bPs2n1GnxGTzAHlKn0u/xMUGIA7EvGKZ5TqMU=;
 b=NkGHcne4sGF0bIZ+ihPn13y0LJU7KHErQ/y9qlNxxcVbZ7H1eVQ2zeMi4YPxRMivDeWX/Z
 GIjQ0SItMquS8v1/Ue16sHcO/bgjDXiWywyqPilZhrbCOcfML2NQESQatBPWiDKoEIu+05
 TE5YXuhGJ2I0NfwUvZlW+PsaWXdlpKPhslf3M5Gn4lLD0wiQNSTc00wUKOIx6vsFNS/c4W
 79ApL9mp6a40jTcomOwPC0EO9HBi2IrHEgGb65/nGWKAZ3MQAhcQHtQHa8Sng9/vURqoQD
 x7RsIcpTBtFCan4rpvYzPSL84njUQQUqguuuub+1zLhH95aQJPdveENUQc8qAA==
Message-ID: <991a3e98-c720-4e90-b8bd-1c2eaf413f1a@denx.de>
Date: Fri, 25 Apr 2025 19:09:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] Revert "arm64: dts: imx8mn: Include 32kHz oscillator
 clock in SPL DTs"
To: Fabio Estevam <festevam@gmail.com>
Cc: trini@konsulko.com, aford173@gmail.com, u-boot@lists.denx.de,
 Fabio Estevam <festevam@denx.de>
References: <20250425135220.1929510-1-festevam@gmail.com>
 <20250425135220.1929510-3-festevam@gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250425135220.1929510-3-festevam@gmail.com>
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
> From: Marek Vasut <marex@denx.de>
> 
> The 32 kHz oscillator was included in DT as a temporary workaround
> for the v2025.01 release. With a more appropriate fix in place for
> v2025.04, the workaround can be reverted.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
> ---
>   arch/arm/dts/imx8mn-u-boot.dtsi | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/arch/arm/dts/imx8mn-u-boot.dtsi b/arch/arm/dts/imx8mn-u-boot.dtsi
> index bb0e5b4e31c..8a9ef54c91d 100644
> --- a/arch/arm/dts/imx8mn-u-boot.dtsi
> +++ b/arch/arm/dts/imx8mn-u-boot.dtsi
> @@ -72,11 +72,6 @@
>   	bootph-all;
>   };
>   
> -&osc_32k {
> -	bootph-pre-ram;
> -	bootph-all;
> -};
See my comment on 4/4 , no, let's keep this.
