Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D905C35FFC
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 23:32:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE796810FE;
	Sun, 23 Mar 2025 00:31:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="YU5Eyyqy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BFA18197D; Sun, 23 Mar 2025 00:31:24 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A35B581C84
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 00:31:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4ZKwYh4Sy0z9smv;
 Sun, 23 Mar 2025 00:31:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1742686280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HbEpVN2aW3IAKNbuby1MLMYpx590qu14SWxbPHq8Srw=;
 b=YU5EyyqyED/jAAftg4BPOJx8eGEpcSqh5qbazIs3rtlHX/ZNTBnEp9kd5KzP0iuLEJS4Vb
 b56YtVhE7nqcf0q5zY7Jk2rD/j8HuSlUeUFVu+fGZJpLqlu4CKdDSiFPCcxJPMXNRHBI+P
 Jj6h4F2l69NXQfsl+Ty0H+IjUotwjHSooS1kmrA4DYob1kw6kHaPg3xbGFOsGs9X+F84nk
 pQkAh8OBnVHOKhesR4g9lJu7MXJpj32V28+YzvYOwSdBEMMxaCU2oB7gRMvAXdp7D525Oa
 QgnCmOLdNF69g8umrm+mnj/gEb5llobyhHy2olW+VXRUJGvUbT3KsIWbP71KwA==
Message-ID: <79324d06-601b-4127-bf7b-5029247f5a08@mailbox.org>
Date: Sun, 23 Mar 2025 00:30:57 +0100
MIME-Version: 1.0
Subject: Re: [PATCH V3 6/6] imx: imx9: Imply CPU_IMX by default
To: Adam Ford <aford173@gmail.com>, u-boot@lists.denx.de
Cc: aford@beaconembedded.com, festevam@gmail.com,
 Stefano Babic <sbabic@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Tom Rini <trini@konsulko.com>, Enrico Leto <enrico.leto@siemens.com>,
 Heiko Schocher <hs@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Yannic Moog <y.moog@phytec.de>, Sumit Garg <sumit.garg@kernel.org>,
 Gilles Talis <gilles.talis@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Ye Li <ye.li@nxp.com>,
 Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
 <c.stoidner@phytec.de>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20250322183812.784676-1-aford173@gmail.com>
 <20250322183812.784676-7-aford173@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250322183812.784676-7-aford173@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ajnfh81aogrwtw8fwo5mosz415sut8hp
X-MBO-RS-ID: 6f625a1745070375f8c
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

On 3/22/25 7:38 PM, Adam Ford wrote:
> The imx8_cpu driver is a CPU Driver that supports the i.MX9
> family. When it is enabled, it acts as an alternative to
> arch/arm/mach-imx/cpu.c, but the imx8_cpu supports the driver
> model where cpu.c does not.  Imply this newer driver by default.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
>   arch/arm/mach-imx/imx9/Kconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
> index c3e758e103a..579432a47fa 100644
> --- a/arch/arm/mach-imx/imx9/Kconfig
> +++ b/arch/arm/mach-imx/imx9/Kconfig
> @@ -11,6 +11,8 @@ config IMX9
>   	select HAS_CAAM
>   	select ROM_UNIFIED_SECTIONS
>   	imply IMX_TMU
> +	imply CPU
> +	imply CPU_IMX
Keep the list sorted.
