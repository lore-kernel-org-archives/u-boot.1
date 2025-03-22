Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D45C36001
	for <u-boot@archiver.kernel.org>; Sat, 22 Mar 2025 02:50:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F8BE80ECC;
	Sat, 22 Mar 2025 03:50:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1742611801;
	bh=KRi6biwGbmz/xx918GDoIf4ekkXaoRHU77EgDcQkhpE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PnbvhzIS3hxdxrd/QONxW2m9bYWyBMkARgOy7/okAdddCgUjmPCi1ioRIV1c1uAQl
	 KWjONmZ6FJhWvtMVpFZ2uelsZltySJG6hKCo7kOijIH1ZdBXz3YxbI2lsEv9h+wjgZ
	 isnsLBg9NP/58DYVd3ysn4ROEJuF/qfdRucFNmeTmmpLMXdCplHIXMO6xuUAQ7ykdQ
	 m0lC6QrznPD+3fXVEmfmby7GCiA2EILUTNA01JIDrTPGYDLgom5WCnpxj88VysKhjN
	 O7OD0WR8BAtadC3NrV9pLbGrgNvpvGz55PLJlXMKncbB12/yHzNbGAagFLSjFJRYHs
	 CSwWxLoi3et/A==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2224581DCC; Sat, 22 Mar 2025 03:49:58 +0100 (CET)
Received: from mx.denx.de (mx.denx.de
 [IPv6:2a03:4000:64:cc:545d:19ff:fe05:8172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3170E81CA8
 for <u-boot@lists.denx.de>; Sat, 22 Mar 2025 03:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=marex@denx.de
Authentication-Results: phobos.denx.de; dkim=pass (2048-bit key;
 unprotected) header.d=denx.de header.i=@denx.de header.b="RiuxInM8"; 
 dkim-atps=neutral
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 5B996101E8F4C; Sat, 22 Mar 2025 03:49:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
 t=1742611795; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=KRi6biwGbmz/xx918GDoIf4ekkXaoRHU77EgDcQkhpE=;
 b=RiuxInM8LIN7eew9JfykuYovoOeyxK5kOiJiCfEOYt6UlbM2vdExUI7RmEb02l/y+sbviI
 D5zn+qxAI8QjnwLhqaxrTPQiB4R4YICf1/5t4pVDDK+Wma7unGhJMCBnp8K2nC4tbXqnhr
 nOdNL84mhsNqByv+PIYuBXU4ilOUwfsjyrPrWygJWNSX9vKdd/NQJ3iA+CRZrcfQvIQ1mg
 oVZ8LScrrqEqWQMZLMfv3txSKxUv7+OvCs44eRABz6PtV5DfnSFxFKC8FjSUI7WTbONw0l
 wFZyphf8FgbaYj1/FAqISEhOZBS+jFxBr/5aXSuZo2noAbLZEcIqd/GVMiRCPg==
Message-ID: <766ea9e3-3ef0-4763-8e8d-c6341db08958@denx.de>
Date: Sat, 22 Mar 2025 02:55:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 05/19] scmi_protocols: add SCMI Performance domain
 management protocol message IDs
To: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>, Tom Rini <trini@konsulko.com>, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Alice Guo <alice.guo@nxp.com>, =?UTF-8?Q?Lothar_Wa=C3=9Fmann?=
 <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
 <20250321-imx95-v1-5-f2c8ba815f89@oss.nxp.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20250321-imx95-v1-5-f2c8ba815f89@oss.nxp.com>
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

On 3/21/25 8:15 AM, Alice Guo (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> SCMI Performance domain management protocol is intended for performance
> management of groups of devices or APs that run in the same performance
> domain. The functionality provided by the callee-side can be used by
> passing the corresponding message_id.
Reviewed-by: Marek Vasut <marex@denx.de>
