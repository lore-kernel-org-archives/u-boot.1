Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7900BFF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 07:48:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA9CD803C6;
	Fri,  1 May 2026 09:48:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="njjRyH7o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2286E80F0E; Fri,  1 May 2026 09:48:00 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 219AD80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2F12D43B10;
 Fri,  1 May 2026 07:47:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB21C2BCB4;
 Fri,  1 May 2026 07:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777621676;
 bh=/96gMTv6uSTMqR1apjmKBHmejf/DSYDuDODwKVFQxSM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=njjRyH7ob4EBCUveKdRTf33FOj/wycjOnxjWwCHJcxZxpfj9Fa5ig7wj/nEXgBwI7
 FNiivrya2vzbD/n3yrPQfruqk9tjtr2RMH11WbTEAxl2C+RnQKr1gufMAvSS0Hro0M
 ydxQHcNDHNT8fpXp4b5yNAn2YRMELgfuapVABdvMSATXNShHr8Y8846753FWyr0fNC
 MoDViJZz7TF5oeaYEfftAoR48gQ67pyrxR+sZSIY0GUUmcGfhIwQ7vKS1T8FMZeaqJ
 U3f4J9fqXW6fnmMp5tOyKKjipOQUM4DPuGErwdOIUfU0hw/hKs2WuKlhlA4xdrOg0d
 5QnmX5x1w52uw==
Date: Fri, 1 May 2026 13:17:48 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Jens Reidel <adrian@mainlining.org>, Luca Weiss <luca.weiss@fairphone.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH v2 7/7] ufs: qcom: Remove redundant POST_CHANGE clock
 setup call
Message-ID: <afRapICPq2WZH2GE@sumit-xelite>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
 <20260427-ufs_clk-v2-7-36e10a7c0ef6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-ufs_clk-v2-7-36e10a7c0ef6@oss.qualcomm.com>
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

On Mon, Apr 27, 2026 at 02:56:11PM +0530, Balaji Selvanathan wrote:
> The ufs_qcom_init() function was calling ufs_qcom_setup_clocks() with
> POST_CHANGE twice. The first call after setting PA_TXHSADAPTTYPE
> correctly enables the device reference clock. The second call after
> ufs_qcom_advertise_quirks() is redundant as the clock is already
> enabled.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Newly added in v2
> ---
>  drivers/ufs/ufs-qcom.c | 1 -
>  1 file changed, 1 deletion(-)
>

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index ae33f62fbee..f5f5a6eb110 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -605,7 +605,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  		 priv->hw_ver.step);
>  
>  	ufs_qcom_advertise_quirks(hba);
> -	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
>  
>  	return 0;
>  }
> 
> -- 
> 2.34.1
> 
