Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D51FC54FCC
	for <u-boot@archiver.kernel.org>; Fri, 20 Feb 2026 09:02:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7AD1F83D17;
	Fri, 20 Feb 2026 10:02:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="duxMSdKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C1E583D2E; Fri, 20 Feb 2026 10:02:11 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAB9583A41
 for <u-boot@lists.denx.de>; Fri, 20 Feb 2026 10:02:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4F74143F9C;
 Fri, 20 Feb 2026 09:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E03C116C6;
 Fri, 20 Feb 2026 09:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1771578127;
 bh=wKNoOoR06oTnL5cVgk/FRJFte0/jtMWZtTpKnkY66LE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=duxMSdKwxmj9oEFS0D60v81b4RbpkSpIIKVuvg3a4SB3T/2UIjWtFXbjTwgYg4P/P
 qkDZ+xJPTvvL5L2cEpmTHtMDnAbcB3J7wS+hJ/NoHmUUyCEU63djL8wRmhlb38JcZ9
 7wtgJIRwVja9caLE1fMczcJ99o8RNYpFztrLH+nwoLZpzQU/07MiwVUwjEnvis7SOn
 0gd/QAFpijDnIer7Obwo3XtTSEgphPsFcPbE3ZPh3sUJzl5VnFTFFrI7Ls7cLJscdx
 vFh5AeDwjyBvaOMV014Zbxbg0PjHjEu5pDZaWkczq9Hg0XqTXYbqNHFGty6BmW44kh
 PsmeWGIth/Pdg==
Date: Fri, 20 Feb 2026 14:31:56 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
Cc: casey.connolly@linaro.org, u-boot@lists.denx.de, u-boot-qcom@groups.io,
 trini@konsulko.com, jh80.chung@samsung.com, peng.fan@nxp.com,
 neil.armstrong@linaro.org, tien.fong.chee@altera.com,
 miquel.raynal@bootlin.com, msp@baylibre.com,
 alif.zakuan.yuslaimi@altera.com,
 balaji.selvanathan@oss.qualcomm.com, w.egorov@phytec.de,
 varadarajan.narayanan@oss.qualcomm.com, rui.silva@linaro.org,
 ilias.apalodimas@linaro.org, me@samcday.com,
 marek.vasut+renesas@mailbox.org
Subject: Re: [PATCH v8 2/4] power-domain: Add warning when power-domain
 driver is missing
Message-ID: <aZgjBLn0fiaXL6rY@sumit-xelite>
References: <20260213111009.1254360-1-aswin.murugan@oss.qualcomm.com>
 <20260213111009.1254360-3-aswin.murugan@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213111009.1254360-3-aswin.murugan@oss.qualcomm.com>
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

On Fri, Feb 13, 2026 at 04:40:07PM +0530, Aswin Murugan wrote:
> Update dev_power_domain_ctrl() to log a warning if the power-domain
> driver is not found (-ENODEV). Return 0 in this case to allow continued
> execution, while preserving error handling for other failures.
> 
> Reviewed-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> Signed-off-by: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> ---
> Changes in v8:
> - No changes in v8

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> Changes in v7:
> - Cleaned up the warning logic in drivers/power/domain/power-domain-uclass.c
>   when power-domain driver is missing
> 
> Changes in v6:
> - Newly added the change in drivers/power/domain/power-domain-uclass.c to give warning
>   when power-domain driver is missing
> ---
>  drivers/power/domain/power-domain-uclass.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/power/domain/power-domain-uclass.c b/drivers/power/domain/power-domain-uclass.c
> index d9fa8ad4bd2..52f56f57658 100644
> --- a/drivers/power/domain/power-domain-uclass.c
> +++ b/drivers/power/domain/power-domain-uclass.c
> @@ -10,6 +10,7 @@
>  #include <malloc.h>
>  #include <power-domain.h>
>  #include <power-domain-uclass.h>
> +#include <dm/device_compat.h>
>  #include <dm/device-internal.h>
>  
>  struct power_domain_priv {
> @@ -184,6 +185,12 @@ static int dev_power_domain_ctrl(struct udevice *dev, bool on)
>  					    "#power-domain-cells", 0);
>  	for (i = 0; i < count; i++) {
>  		ret = power_domain_get_by_index(dev, &pd, i);
> +
> +		if (ret == -ENODEV) {
> +			dev_warn(dev, "power-domain driver not found\n");
> +			return 0;
> +		}
> +
>  		if (ret)
>  			return ret;
>  		if (on)
> -- 
> 2.34.1
> 
