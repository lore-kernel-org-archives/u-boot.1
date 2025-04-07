Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B1DAC36010
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 12:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A5D8082E40;
	Mon,  7 Apr 2025 14:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ctPxCm7B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7D0982E58; Mon,  7 Apr 2025 14:36:31 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 717BD82E38
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 14:36:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 919B761129;
 Mon,  7 Apr 2025 12:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE515C4CEDD;
 Mon,  7 Apr 2025 12:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744029387;
 bh=V7z2Hvcbovg41HgwYgKZmgsgM5rTj2X5T7XsbSg7uzw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ctPxCm7Bvz89V4qx592fQrvOMnmRWJZ84hS3SH3n7OddsV+IY9oVuSQqNVL+t+GwB
 AgIQuKC2pgtAj2f7yKSc6IawQEjUYjjsi0lE4rD09qgbe1g8+QPRS0DMiPTwCqg+uA
 5v3y0AwKUwVAATvW36kKWTx+aPRTCbNsZxfGsU95m59Yvy1LjcWMRfFf2YZp48SAEB
 3TRU2NO5QoQwhfcHsgc3QEs23kx6yc75V4xGJg3OBfecm7arnFd03DHVH1TOIzLCvE
 Jy3X/vauaWA6It0KXI2TqvTq7uJH45UkJ+KnB7EMSdxXo/ItK3qE/1JYz3XMhqqUx0
 dwn1bv8XQFcYw==
Date: Mon, 7 Apr 2025 18:06:22 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: neil.armstrong@linaro.org, caleb.connolly@linaro.org,
 u-boot-qcom@groups.io, u-boot@lists.denx.de
Subject: Re: [PATCH 4/5] clk: stub: add qcom,glink-smd-rpm
Message-ID: <Z_PGxtHj7FOwmSJa@sumit-X1>
References: <20250407120536.236003-1-jorge.ramirez@oss.qualcomm.com>
 <20250407120536.236003-4-jorge.ramirez@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250407120536.236003-4-jorge.ramirez@oss.qualcomm.com>
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

On Mon, Apr 07, 2025 at 02:05:35PM +0200, Jorge Ramirez-Ortiz wrote:
> Add support for the resource power manager clocks over SMD/GLINK to be
> stubbed.
> 
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
> ---
>  drivers/clk/clk-stub.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 5fbbb07b7f7..09be2946bbc 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -15,6 +15,7 @@ static const struct udevice_id nop_parent_ids[] = {
>  	{ .compatible = "qcom,rpm-proc" },
>  	{ .compatible = "qcom,glink-rpm" },
>  	{ .compatible = "qcom,rpm-sm6115" },

This platform specific compatible can be dropped now.

Apart from that, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit


> +	{ .compatible = "qcom,glink-smd-rpm" },
>  	{ }
>  };
>  
> -- 
> 2.34.1
> 
