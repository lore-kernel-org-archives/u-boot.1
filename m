Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087B7FF885A
	for <u-boot@archiver.kernel.org>; Fri,  1 May 2026 07:43:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 661B9803C6;
	Fri,  1 May 2026 09:43:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tNt2+JuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E2F281E18; Fri,  1 May 2026 09:43:38 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C09B80086
 for <u-boot@lists.denx.de>; Fri,  1 May 2026 09:43:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0EF0243989;
 Fri,  1 May 2026 07:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC4BC2BCB4;
 Fri,  1 May 2026 07:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777621412;
 bh=pV6BOkTs6SdC/S+t/Hw1HiPS12oP0TJlyhGtcuBJg/s=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tNt2+JuV5+U3ROOsCMtffY0mJ5RQWhNxfkYAgFquiU3mBmlLjMkSH1AuoD9tPMk2Z
 fqXTdchDT/ZfQP5CNmqibyJS7q+oIibSKVxT70Lsuh3LOTe1dPzxlgxVAfubFgWE/z
 RIb7eIp0wLX3S9kfk/IMZ9sZry6bgKGFHrxtFPDCj8zLjKZOUOBHHCWWiJUR7pklbz
 7E/QlDXCb6sH3j0f+0RwvWauePLO4ymVOxwi4LDl4zHVJk8646pMgZ1vto6+1f815j
 Aghn/mkKfctnxiNAinKPo+t7Xe2bLuj1CiiIleiyNk0jXgfe1VISUH0Z7pbCtnCQG5
 bRJwd9flpfCEw==
Date: Fri, 1 May 2026 13:13:23 +0530
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
Subject: Re: [PATCH v2 6/7] drivers: ufs: qcom: Initialize and enable clocks
 before hardware access
Message-ID: <afRZmyPhBLU-bwYU@sumit-xelite>
References: <20260427-ufs_clk-v2-0-36e10a7c0ef6@oss.qualcomm.com>
 <20260427-ufs_clk-v2-6-36e10a7c0ef6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427-ufs_clk-v2-6-36e10a7c0ef6@oss.qualcomm.com>
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

On Mon, Apr 27, 2026 at 02:56:10PM +0530, Balaji Selvanathan wrote:
> Move UFS clock initialization and enabling before hardware setup
> to ensure clocks are running when accessing UFS registers.
> 
> Previously, U-Boot depended on earlier bootloader stages to
> initialize UFS clocks. When these bootloaders failed to do so,
> UFS registers became inaccessible, causing initialization to fail.
> This change makes U-Boot initialize and enable UFS clocks early
> in the init sequence, removing the dependency on previous
> bootloaders.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Remove ufs_qcom_init_clks function and move the clock enabling and
>       rate set codes to ufs_qcom_init
> - Add clk_release_bulk if ufs_qcom_enable_clks fails
> ---
>  drivers/ufs/ufs-qcom.c | 53 ++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 36 insertions(+), 17 deletions(-)

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index dc40ee62daf..ae33f62fbee 100644
> --- a/drivers/ufs/ufs-qcom.c
> +++ b/drivers/ufs/ufs-qcom.c
> @@ -30,6 +30,7 @@
>  #define UFS_CPU_MAX_BANDWIDTH	819200
>  
>  static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable);
> +static u32 ufs_qcom_get_core_clk_unipro_max_freq(struct ufs_hba *hba);
>  
>  static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>  {
> @@ -47,17 +48,6 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>  	return 0;
>  }
>  
> -static int ufs_qcom_init_clks(struct ufs_qcom_priv *priv)
> -{
> -	int err;
> -	struct udevice *dev = priv->hba->dev;
> -
> -	err = clk_get_bulk(dev, &priv->clks);
> -	if (err)
> -		return err;
> -
> -	return 0;
> -}
>  
>  static int ufs_qcom_check_hibern8(struct ufs_hba *hba)
>  {
> @@ -557,10 +547,45 @@ static void ufs_qcom_dev_ref_clk_ctrl(struct ufs_hba *hba, bool enable)
>  static int ufs_qcom_init(struct ufs_hba *hba)
>  {
>  	struct ufs_qcom_priv *priv = dev_get_priv(hba->dev);
> +	struct udevice *dev = hba->dev;
> +	struct clk clk;
> +	u32 max_freq;
> +	long rate;
>  	int err;
>  
>  	priv->hba = hba;
>  
> +	/* Get maximum frequency for core_clk_unipro from device tree */
> +	max_freq = ufs_qcom_get_core_clk_unipro_max_freq(hba);
> +
> +	/* Get and configure core_clk_unipro */
> +	err = clk_get_by_name(dev, "core_clk_unipro", &clk);
> +	if (err) {
> +		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
> +		return err;
> +	}
> +
> +	rate = clk_set_rate(&clk, max_freq);
> +	if (rate < 0) {
> +		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
> +			max_freq, rate);
> +	}
> +
> +	/* Get all clocks */
> +	err = clk_get_bulk(dev, &priv->clks);
> +	if (err) {
> +		dev_err(dev, "clk_get_bulk failed: %d\n", err);
> +		return err;
> +	}
> +
> +	/* Enable clocks */
> +	err = ufs_qcom_enable_clks(priv);
> +	if (err) {
> +		dev_err(dev, "failed to enable clocks: %d\n", err);
> +		clk_release_bulk(&priv->clks);
> +		return err;
> +	}
> +
>  	/* setup clocks */
>  	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
>  
> @@ -579,12 +604,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  		 priv->hw_ver.minor,
>  		 priv->hw_ver.step);
>  
> -	err = ufs_qcom_init_clks(priv);
> -	if (err) {
> -		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
> -		return err;
> -	}
> -
>  	ufs_qcom_advertise_quirks(hba);
>  	ufs_qcom_setup_clocks(hba, true, POST_CHANGE);
>  
> 
> -- 
> 2.34.1
> 
