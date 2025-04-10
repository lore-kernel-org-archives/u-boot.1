Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EADAC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:51:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2F8F83AB9;
	Thu, 10 Apr 2025 10:51:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HV2o6gpz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F3CA283ABF; Thu, 10 Apr 2025 10:51:10 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DBC4183A98
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:51:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 8857A5C4445;
 Thu, 10 Apr 2025 08:48:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CEAEC4CEDD;
 Thu, 10 Apr 2025 08:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744275067;
 bh=8gp0M3MmENAXtxwp8GLnBGiZcmnG0jTsn/CZ5FoTDzY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HV2o6gpzpOq2pz5RMgAyiQ5sYXXthJFfjCoVNgqj+BPQNbYR3fRwKXGOHDjZnUiE+
 ijntXb7s7Mmmgo0boO87eeQlNNN0kb+zabLWzkk61Hqk6comMbfu4eHDcw5Oa4zYdc
 kDcE/jdCjrpJNJRoTMrW+DvTWhyn3QaGqmSSonKUD9EvX0IHgeidjIrLH1OnN3LzL2
 fdv4tDsbV5owfmSxdrKCftQLOrDdFRCq3mHM7Rj6Ok3BxYYuOUPjOROa0FcTVZoRBU
 izJRmI/NgrGyY0iMFoXU2X40H/DKyIMNe0PQTgjjyb1aQMaGujA5aS/hOj/NnUDkks
 jlPSEP6fMeadg==
Date: Thu, 10 Apr 2025 14:21:01 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 3/6] mach-snapdragon: of_fixup: skip disabled USB nodes
Message-ID: <Z_eGdanjdHktL_I9@sumit-X1>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
 <20250409-livetree-fixup-v1-3-76dfea80b07f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-livetree-fixup-v1-3-76dfea80b07f@linaro.org>
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

On Wed, Apr 09, 2025 at 07:17:26PM +0200, Caleb Connolly wrote:
> There's no need to waste time fixing up nodes that aren't used on this
> device. Skip them.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/mach-snapdragon/of_fixup.c | 2 ++
>  1 file changed, 2 insertions(+)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/arch/arm/mach-snapdragon/of_fixup.c b/arch/arm/mach-snapdragon/of_fixup.c
> index d4e24059212c552de7fa7555d2ab8a1ea4fc4cb2..b39036e8e0890fdf834a0dfe6966ef3dd365f3d2 100644
> --- a/arch/arm/mach-snapdragon/of_fixup.c
> +++ b/arch/arm/mach-snapdragon/of_fixup.c
> @@ -107,8 +107,10 @@ static void fixup_usb_nodes(void)
>  	struct device_node *glue_np = NULL;
>  	int ret;
>  
>  	while ((glue_np = of_find_compatible_node(glue_np, NULL, "qcom,dwc3"))) {
> +		if (!of_device_is_available(glue_np))
> +			continue;
>  		ret = fixup_qcom_dwc3(glue_np);
>  		if (ret)
>  			log_warning("Failed to fixup node %s: %d\n", glue_np->name, ret);
>  	}
> 
> -- 
> 2.49.0
> 
