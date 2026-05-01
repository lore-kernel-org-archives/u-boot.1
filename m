Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A080FF8864
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 07:39:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F776803C6;
	Fri,  1 May 2026 09:39:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="C/6Vh+mt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B66E83A91; Fri,  1 May 2026 09:39:14 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64A0680086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:39:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E5CFD43F3A;
 Fri,  1 May 2026 07:39:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DA63C2BCB4;
 Fri,  1 May 2026 07:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777621150;
 bh=MHzSEtX9ICB5RLfT1JOQbPMVWq4b1tVuitzlGyEVjPQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=C/6Vh+mtCz5JgDJmeSaeHPKSQYI+WBu3JNLPtCiDWypQndD/jxRHzBoGHTwcar3qu
 EYdMNbncQgTkmVVbXZDF5zvDNfVNxh0z25hwFO+MVkD5Zd8mHCCKWnAU1gTMRHRQi5
 xfp0v2ZXLBBa4kFkNNr7PPwTqiGuB6Qlu08z6zm/sPHVQWHkwJUE92l+rajjvUaaEV
 gZkQsowT5yHSCvMks8GyN5Jm6YzsjqbdpVSEcPgN86LbbWk3+yI36/3r1OXlEbBLDJ
 kSEMtpt0UFa5YRrFwN/ftYvTAFLibqJ0sggbqi3sQcBWN7YCJMEHR+er9UMhG8ptyi
 Eq6s6UEILHFgg==
Date: Fri, 1 May 2026 13:09:02 +0530
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
Subject: Re: [PATCH v2 2/7] clk: qcom: clk-stub: Add compatibles for
 QCS615/SA8775P
Message-ID: <afRYlrMxJ5jyX_uA@sumit-xelite>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
 <20260427-ufs_clk-v2-2-36e10a7c0ef6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-ufs_clk-v2-2-36e10a7c0ef6@oss.qualcomm.com>
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

On Mon, Apr 27, 2026 at 02:56:06PM +0530, Balaji Selvanathan wrote:
> Add RPMH clock compatible strings for QCS615 and SA8775P
> SoCs to enable clock framework support on these platforms.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Removed sc7280 compatible which was already there
> ---
>  drivers/clk/clk-stub.c | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/clk/clk-stub.c b/drivers/clk/clk-stub.c
> index ddcaaa00d91..4a6c71016da 100644
> --- a/drivers/clk/clk-stub.c
> +++ b/drivers/clk/clk-stub.c
> @@ -49,7 +49,9 @@ static struct clk_ops stub_clk_ops = {
>  };
>  
>  static const struct udevice_id stub_clk_ids[] = {
> +	{ .compatible = "qcom,qcs615-rpmh-clk" },
>  	{ .compatible = "qcom,rpmcc" },
> +	{ .compatible = "qcom,sa8775p-rpmh-clk" },
>  	{ .compatible = "qcom,sc7180-rpmh-clk" },
>  	{ .compatible = "qcom,sc7280-rpmh-clk" },
>  	{ .compatible = "qcom,sdm670-rpmh-clk" },
> 
> -- 
> 2.34.1
> 
