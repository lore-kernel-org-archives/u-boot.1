Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A24FC369D3
	for <u-boot@archiver.kernel.org>; Mon, 28 Apr 2025 08:25:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D8F780FDA;
	Mon, 28 Apr 2025 10:25:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kySWCSfU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D517D820B7; Mon, 28 Apr 2025 10:25:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC81D80BAD
 for <u-boot@lists.denx.de>; Mon, 28 Apr 2025 10:25:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 67B465C5DF6;
 Mon, 28 Apr 2025 08:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8866C4CEE4;
 Mon, 28 Apr 2025 08:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1745828707;
 bh=nIGJo8lHOGOdyz5tjjLgIkrhoK7YuJJWo0z5ImVusy0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kySWCSfUqttmyrjGUjJ+db/W6Z7rMTTf9tPggiod84OLEzZasbPE+pboLwapdg1AO
 UdbyZfpiwjB2cgjuuPISF8uP2ZEx9rPqjsNafRjiueTpgP8zi8Ap2A4fjgNeqb21xE
 M+FLmF1y3oLe5FJlKcVJu1K0GaNynMq248F4XMNCKHVUIgWdm4CEMVrs/tkwS2AlQG
 7D2w82VHT/aqfu7+Q/g/MMDFSdfgRxvDZKrCL+cb+1pRi1XWi3SB8eolTdcCfjNS5z
 QLn8JKBGoAT7q61Jiog7ZgENvi5z/B7bpu5ZFlPI3fJOQdKQPgFzL4gBbh75EmbQdY
 29+eUNbreWEXw==
Date: Mon, 28 Apr 2025 13:54:59 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: trini@konsulko.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, sjg@chromium.org,
 ilias.apalodimas@linaro.org, sughosh.ganu@linaro.org,
 me@samcday.com, marex@denx.de, robert.marko@sartura.hr,
 seashell11234455@gmail.com, ycliang@andestech.com,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH v1 1/3] mach-snapdragon: Do not define reset_cpu() if
 SYSRESET is enabled
Message-ID: <aA87W3wylwsZbKRr@sumit-X1>
References: <20250410120208.4142087-1-quic_varada@quicinc.com>
 <20250410120208.4142087-2-quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410120208.4142087-2-quic_varada@quicinc.com>
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

On Thu, Apr 10, 2025 at 05:32:06PM +0530, Varadarajan Narayanan wrote:
> If CONFIG_SYSRESET is enabled, the reset_cpu() function defined in
> arch/arm/mach-snapdragon/board.c conflicts with the definition of
> reset_cpu() in drivers/sysreset/sysreset-uclass.c resulting in duplicate
> symbol error while compiling. So, do not include it if CONFIG_SYSRESET
> is enabled.

I would rather like to see all Qcom platforms migrating to SYSRESET but
this looks reasonable to me as of now, FWIW:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
>  arch/arm/mach-snapdragon/board.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 2ef936aab75..2254e0b55a1 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -187,10 +187,12 @@ int board_fdt_blob_setup(void **fdtp)
>  	return ret;
>  }
>  
> +#if !IS_ENABLED(CONFIG_SYSRESET)
>  void reset_cpu(void)
>  {
>  	psci_system_reset();
>  }
> +#endif
>  
>  /*
>   * Some Qualcomm boards require GPIO configuration when switching USB modes.
> -- 
> 2.34.1
> 
