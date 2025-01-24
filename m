Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6980FC0218B
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 15:27:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE08F80C83;
	Fri, 24 Jan 2025 16:26:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1737732397;
	bh=H7f/d1tKUaxIZyn7bJhpg2sgJq+QShvNZKB3MsulMuU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GagSoHOWU4adaII8Q47Tq8En9pp+FMdC+70mLH54IDiIWQ4RhFT+p95WmsVPrm+7V
	 5ARVcjKFUavPe0o0lWlZ0M7yAGsqihguPh6xm0xX5i3k5681l+yytECH2iCKOejFIE
	 j/skNs9Q7nMH8LxFPNEWLIVYoTDbkPQUEbkRtOjm+DDJ+52kEbolJwUnRRv9QI4cF8
	 9czBIvi0iUsOiBYfzAvBkYn2cfJktw76ADhgndDU4GEzHzMyYdwyEj+AnTRqWDiCCf
	 A9QPvVh8TwrhT94KviMz12YJYzlhLANseOcmU+RS0IV6kegn6i4BUY+s4Et6te3RN+
	 7GXm1aApUCBfQ==
Received: by phobos.denx.de (Postfix, from userid 109)
 id BE4D480C6E; Fri, 24 Jan 2025 16:26:35 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4FD980BAB
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:26:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="apln8BGC"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BD8BC101D2386; Fri, 24 Jan 2025 16:26:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1737732393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H7f/d1tKUaxIZyn7bJhpg2sgJq+QShvNZKB3MsulMuU=;
 b=apln8BGC8UriXbCOeIIunb/Tml4L7ykDwa2XPM/IuDb/mrESO+54XujfINIes3Ej7v0PWx
 TndcqeJGFdTk/f+Pk4N9mFEuh3EbFqDAgZHnnxb5LrfULaZ8ZtvKpBq8LFfAWsUSzT02BI
 0yajO+s488qL/mwsIAaDh1Hax6w9qcWuxltQr9WugOWKtMeLTlrIaLIM/VZFBx3twxLbu6
 ex4e7VOIwAkFVVy/DkeI/ME0A83zBM+edjR7YrKzBysHrJHksOaTQeGIXddzU3tVlJc+Qd
 R2YR4Tj439iWzSlVn0HPu3ue/cHznuht5LDUuy/J6qe3n7Z86tIKbjTQwSONfg==
Message-ID: <a7d28bcc-1565-43b2-bc02-52a71ba6da6b@denx.de>
Date: Fri, 24 Jan 2025 15:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 15/20] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
To: Alice Guo <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo <alice.guo@nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
 <20250115-imx95-v1-15-93b28a514dea@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250115-imx95-v1-15-93b28a514dea@oss.nxp.com>
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
> From: Alice Guo <alice.guo@nxp.com>
> 
> i.MX95 only supports low power boot, which means A55 is kicked by M33.
> There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
> for i.MX95.
> 
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> ---
>   arch/arm/mach-imx/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 134e42028c3787d78e28af03d40c41a8b2b1981b..daf6443aa5b40b6410f2645937239a4ec785fa34 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
>   
>   config IMX8_ROMAPI
>   	def_bool y
> -	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
> +	depends on IMX8MN || IMX8MP || IMX8ULP || (IMX9 && !IMX95)
Would it make sense to introduce IMX91 and IMX93 symbols instead and 
select those two instead of this negative match ?
