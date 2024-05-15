Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9063C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 21:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1242E88312;
	Wed, 15 May 2024 23:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1715807166;
	bh=ATcXEPRD4imDRLeeWXv8M7TYLJRL4W9cLw3BcwVop9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IP072bGiefN0ze6mLtQDJxovOuby8htx8saulDXeekneADRNjg8mFHa5iTMeF1IbI
	 95ohRD3Ry4WKGbht/VAtLuUOScX0vZGD9QeSqdOTyh3g3bTZd1E/GAEVpxRyXmXbc9
	 rdIXtKCQjbbatiSteRt1VNDbZQ+HLJqPF0I4jOsaapudbsuSxRRW7VY2lFi878xyTK
	 mYHdinCe6KwR6mYukR94o1M5heHxZJX96/UlH2XU3DkCCv5EkuPo8SzYMardjGJklT
	 eDKTGdzvyhmbOnRowuGMR4D0Sx72Ge2JCwHATMryr+jqDgQ+RmYwOyo6vcyEQnbgwD
	 HZDa51S2RSTZA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 6436A87F19;
 Wed, 15 May 2024 23:06:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1715807164;
 bh=ATcXEPRD4imDRLeeWXv8M7TYLJRL4W9cLw3BcwVop9s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mT/sQrR6e9c7PZ8jOtm1GGqKHD/f9Fjp7tyTIDhMNayCkC1bT7bZAQwRAaaA3KPhB
 E8sZIP/AGt3MYf2uSKIV+6Tlf45bdhl0Skjk2TmllorbyuzLvXzhEmy1EzLnzQcfm6
 v/IXJV/UGev3Ris65oJ3vHyvTyi0oVJRtu947dI17J0oQRKCJqox8Y0WEnOoGYl5l7
 dV5JscyWPg1k8OXAp9EWzFJNwacEae2d09CBG7pO7xh1t5DekQvE8bI548sLXvwSQ/
 8MO45rL8hGDKkX4l/J0J1JHIdPRGDVEN+stvme50hl6AStjdoqcGj8LYcyS36jr7+d
 uofqrLFN2yhyw==
Message-ID: <f4e559f7-8b41-47e2-9b00-eb44b90dc97a@denx.de>
Date: Wed, 15 May 2024 23:06:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fdt: automatically add /chosen/kaslr-seed if DM_RNG is
 enabled
To: Tim Harvey <tharvey@gateworks.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Devarsh Thakkar <devarsht@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>
References: <20240515205049.3005256-1-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240515205049.3005256-1-tharvey@gateworks.com>
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

On 5/15/24 10:50 PM, Tim Harvey wrote:

[...]

> diff --git a/boot/fdt_support.c b/boot/fdt_support.c
> index 874ca4d6f5af..3455d60d69dc 100644
> --- a/boot/fdt_support.c
> +++ b/boot/fdt_support.c
> @@ -8,6 +8,7 @@
>   
>   #include <abuf.h>
>   #include <env.h>
> +#include <kaslrseed.h>
>   #include <log.h>
>   #include <mapmem.h>
>   #include <net.h>
> @@ -300,6 +301,15 @@ int fdt_chosen(void *fdt)
>   	if (nodeoffset < 0)
>   		return nodeoffset;
>   
> +	if (IS_ENABLED(CONFIG_DM_RNG) && !IS_ENABLED(ARMV8_SEC_FIRMWARE_SUPPORT)) {
> +		err = fdt_kaslrseed(fdt);
> +		if (err) {
> +			printf("WARNING: could not set kaslr-seed %s.\n",
> +			       fdt_strerror(err));
> +			return err;

Is this warning really a critical boot-breaking error ?

> +		}
> +	}
> +
>   	if (IS_ENABLED(CONFIG_BOARD_RNG_SEED) && !board_rng_seed(&buf)) {
>   		err = fdt_setprop(fdt, nodeoffset, "rng-seed",
>   				  abuf_data(&buf), abuf_size(&buf));

[...]

The rest looks good !
