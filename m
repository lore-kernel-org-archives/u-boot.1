Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C41EFF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 07:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDD45803C6;
	Fri,  1 May 2026 09:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QwEFEZSC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F0A280F0E; Fri,  1 May 2026 09:38:31 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F08A80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 29B4243F3A;
 Fri,  1 May 2026 07:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2B0C2BCB4;
 Fri,  1 May 2026 07:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777621108;
 bh=2WQ3NxvBf5uGOhlNLQNM8g8j95YBqeZovgU3Hcyq28w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QwEFEZSCxJQGI/IGFKwu0ynnyM7w7B7bobk73niOsbnRxbUER1vZZFMO20bcy0Yxq
 6c88+wpoO/R8YGYVg01RV+T7m5UHvDyjRNbJVTPBKvjm01TkiYUnglfT8YhStzUrnR
 Q35HJSZOMzaoEXqYsm/tCEW5Gn8mk8Bf0FIqdLhu9ASwB3SSur/D5ZsiUBVLV14Mkp
 cxoQZw1NIkmZPuE4Q3AwhE8ntW9A6YbRL3qFYFk/xSfVQnCv4dX+RiVP+7s9mCWMON
 8QXjPs37eSvX05ZKhRgmD2GfWSFxVpbpnM7f9UU42Jfz+qkKBPTvywcHfx0fQxYYuc
 TinxeGq3JRGLg==
Date: Fri, 1 May 2026 13:08:19 +0530
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
Subject: Re: [PATCH v2 1/7] clk: stub: Sort compatible strings alphabetically
Message-ID: <afRYaxij2x-CJbay@sumit-xelite>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
 <20260427-ufs_clk-v2-1-36e10a7c0ef6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-ufs_clk-v2-1-36e10a7c0ef6@oss.qualcomm.com>
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

On Mon, Apr 27, 2026 at 02:56:05PM +0530, Balaji Selvanathan wrote:
> Reorder compatible strings in stub_clk_ids to maintain alphabetical
> order for easier maintenance.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Newly added in v2
> ---
>  drivers/clk/clk-stub.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index 117266ac778..ddcaaa00d91 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -50,10 +50,10 @@ static struct clk_ops stub_clk_ops = {
>  
>  static const struct udevice_id stub_clk_ids[] = {
>  	{ .compatible = "qcom,rpmcc" },
> -	{ .compatible = "qcom,sdm670-rpmh-clk" },
> -	{ .compatible = "qcom,sdm845-rpmh-clk" },
>  	{ .compatible = "qcom,sc7180-rpmh-clk" },
>  	{ .compatible = "qcom,sc7280-rpmh-clk" },
> +	{ .compatible = "qcom,sdm670-rpmh-clk" },
> +	{ .compatible = "qcom,sdm845-rpmh-clk" },
>  	{ .compatible = "qcom,sm6350-rpmh-clk" },
>  	{ .compatible = "qcom,sm8150-rpmh-clk" },
>  	{ .compatible = "qcom,sm8250-rpmh-clk" },
> 
> -- 
> 2.34.1
> 
