Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BE9C0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C2AD80E88;
	Fri, 24 Jan 2025 16:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732391;
	bh=zxoj2/tEB93Rr19u6q1OuloxuBU/be0Fv4FZHTuxxec=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KQJ/DtAaON638bL8sEV16N9ZE+fevQ0G3sF/DwlReE7p+r0mnxXpOrk/MI3ppEUnP
	 A3VeeCVGwlJN3MBGv/A/LgYn+xEEljD7dGqAp0le5UNMuqhFxK4auqm5FZDErPXlIo
	 gbE0v7dwQqumPo7ZIUjPckBsb7v0U1QsznL1bXrdcL1R9tmU/B44Vev+6V5kAoGN/Q
	 8htgEZEe9ZDj8n+gpbrSpzyRbveumL5vtWCa7lbrxX+1wCbaG4eb53rOgLxUEraLDU
	 FSB7L3gX+pNp4A5gukAPLb4gsA6tZ/GdNrdzvfe/0/ONyYLUjUtdHzyWZ/khDBHWms
	 h1YKL/jbz5lpg==
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4A6E80BAD; Fri, 24 Jan 2025 16:26:29 +0100 (CET)
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF368809D2
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="iXZvwF1k"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BAF05108882D7; Fri, 24 Jan 2025 16:26:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zxoj2/tEB93Rr19u6q1OuloxuBU/be0Fv4FZHTuxxec=;
 b=iXZvwF1kIzfN8AksoZ6xnG7UskqD+bSmPcpEPNG/A5bRR5hteGZoZ2z+q0k9AumrAjAxRv
 6Vhrp283slQdUDCakNQpqzklUDBr6AMDB3Xk+NY42Cb+n/X0xIejayolWckPBKNGw6uuzh
 LmSc6lWgoBPmSWXeUxGAIQ+UwQVGIh0IrA9ec+IX/HjRA+RPY9MWPcn47hMpRkMAMhjH0g
 lYgch+dbZCbWGi0+fCmNgpem3WB8hDyIJDzYtfNJDohnBGJBMiQ0aV60nUE/3YIlvr8mkd
 ZLrLKpvWOzqdD8oOgOyylqw7rJ9FwLUmnrJVL5pCQlyca1V66PsWR9EhJ/Fwlw==
Message-ID: <45677197-c3e6-4789-9f2a-17fa211aafa2@denx.de>
Date: Fri, 24 Jan 2025 15:43:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 14/20] imx9: add i.MX95 Kconfig and Makefile
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo
 <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-14-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-14-93b28a514dea@oss.nxp.com>
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

On 1/15/25 2:29 PM, Alice Guo wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> This patch adds i.MX95 Kconfig and Makefile. i.MX95 uses SCMI.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>   arch/arm/mach-imx/imx9/Kconfig  | 8 ++++++++
>   arch/arm/mach-imx/imx9/Makefile | 9 +++++++--
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index 54c6b117fcff21be5c3800ebd1dc30f8ea12ac42..660529555e9b3d38a6fb70c77858bd9de7473461 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -21,6 +21,14 @@ config IMX91
>   	select IMX9
>   	select ARMV8_SPL_EXCEPTION_VECTORS
>   
> +config IMX95
> +	bool
> +	select IMX9
> +	select ARMV8_SPL_EXCEPTION_VECTORS
> +	select SCMI_FIRMWARE
> +	select DM_MAILBOX
> +	select SCMI_TRANSPORT_SMT_INTR
> +	select SPL_IMX_CONTAINER_USE_TRAMPOLINE
Keep the list sorted.
