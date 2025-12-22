Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D178FD711D5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 08:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FBED83BF1;
	Mon, 22 Dec 2025 09:42:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="li6pW8Zd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 29D7483C28; Mon, 22 Dec 2025 09:42:18 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 365AA83AAE
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 09:42:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dZWps2yVqz9tTb;
 Mon, 22 Dec 2025 09:42:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766392933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IJiIu6PkEwS3qbtdbeOfHGQo6fOPxcPoEVsl0dEm5Q=;
 b=li6pW8ZdT38mL4dfgnQjmgZSx46IC1muBspJZ/t3CWDywxn3VN5AwdBSas8ivLm5EUe0Ea
 aDjcQdu/pJC9VQat8l5bhrCq+FfphPLLiqNJGPKH/QTsdAlOnttov38CfS+qkZrsFT/4h5
 pGzJGZivq1Nhg8BDsmr70tnLA8lAg6tMWJ8B9wEPsn7I7MggN2UtUjCQbR8dO/Oemp5RWZ
 +uRn4XQPJNklQTk4aPvPFIt369WY4vh3XfRnj3BWGcfzJAuuPAD+R6Es78/dlGFy0Dx1wt
 +1J2n0WtjpSQI4erxQxeEPjXrbP9ChVKB2ga8p49aqsIlynTGtY1dKXqFtmIjQ==
Message-ID: <0f08a8cc-dcbd-4641-941b-dc6c48313787@mailbox.org>
Date: Mon, 22 Dec 2025 09:42:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] mips: Reduce size in gardena-smart-gateway-mt7688
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
References: <20251219202121.4180810-1-trini@konsulko.com>
 <20251219202121.4180810-2-trini@konsulko.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <20251219202121.4180810-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: a520f4806a9958ff289
X-MBO-RS-META: fb64q6wd3g4q3phi677s6u6somnx8o8x
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

On 12/19/25 21:13, Tom Rini wrote:
> This platform is near the binary size limit for U-Boot. Disable booting
> some unlikely OS options in order to reclaim some space.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Stefan Roese <stefan.roese@mailbox.org>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan

> ---
>   configs/gardena-smart-gateway-mt7688_defconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/configs/gardena-smart-gateway-mt7688_defconfig b/configs/gardena-smart-gateway-mt7688_defconfig
> index 3c2bcc6a3c44..3bfb004cf2b3 100644
> --- a/configs/gardena-smart-gateway-mt7688_defconfig
> +++ b/configs/gardena-smart-gateway-mt7688_defconfig
> @@ -48,6 +48,10 @@ CONFIG_SPL_SYS_MALLOC_SIMPLE=y
>   CONFIG_SPL_NOR_SUPPORT=y
>   CONFIG_HUSH_PARSER=y
>   CONFIG_CMD_LICENSE=y
> +# CONFIG_BOOTM_NETBSD is not set
> +# CONFIG_BOOTM_PLAN9 is not set
> +# CONFIG_BOOTM_RTEMS is not set
> +# CONFIG_BOOTM_VXWORKS is not set
>   # CONFIG_CMD_ELF is not set
>   # CONFIG_CMD_XIMG is not set
>   CONFIG_CMD_MEMINFO=y

