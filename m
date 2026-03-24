Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F05EF532C4
	for <u-boot@archiver.kernel.org>; Tue, 24 Mar 2026 06:50:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E428352B;
	Tue, 24 Mar 2026 07:50:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RkYGDGlR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FF05836D3; Tue, 24 Mar 2026 07:50:16 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0C55B80077
 for <u-boot@lists.denx.de>; Tue, 24 Mar 2026 07:50:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 29F2D401AF;
 Tue, 24 Mar 2026 06:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2066C19424;
 Tue, 24 Mar 2026 06:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774335007;
 bh=JhvktiuEWNM2ByykeyrMWRardX3yxhJFMU/Vz6HFO9k=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RkYGDGlRzFKg7yO1XqBJnK2L5HpnJ6RgqYtzI5jbqBeFxoB2euQoaGIlkxwFk152f
 0SKOs+XC1yth/pUTs5du1zlkLBAQKA5UZEk9ZfzPIgGP93GP5s7KKhuXnn0w3ffOgK
 6vSJ/agy4LZB4/RYIiLAx9xvjy+L4bPSVxXHSs10VkTsNRfDgK2QV4zFxXY3wkn2uv
 oA+HRBqgS9yOMj7euDuW/OnXr8buIo6h9LwcEZqzj4eSLwcxrzf5/sFB34RUkwmdGZ
 wuWZdutfw5MDSDgztE/3mF8ReMotXtNIJ4ltie07ktgeVMRjnQBCqJToE1npnPVBuS
 Kt8Hoygh5xPSQ==
Date: Tue, 24 Mar 2026 12:19:58 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 David Wronek <david.wronek@mainlining.org>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>,
 Swathi Tamilselvan <swathi.tamilselvan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Julien Stephan <jstephan@baylibre.com>
Subject: Re: [PATCH 5/5] drivers: ufs: qcom: Initialize and enable clocks
 before hardware access
Message-ID: <acI0Flg4gUKmP2FQ@sumit-xelite>
References: <20260319-ufs_probe_clk-v1-0-08c085d6b15d@oss.qualcomm.com>
 <20260319-ufs_probe_clk-v1-5-08c085d6b15d@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-ufs_probe_clk-v1-5-08c085d6b15d@oss.qualcomm.com>
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

On Thu, Mar 19, 2026 at 03:07:42PM +0530, Balaji Selvanathan wrote:
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
>  drivers/ufs/ufs-qcom.c | 45 +++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 37 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ufs/ufs-qcom.c b/drivers/ufs/ufs-qcom.c
> index dc40ee62daf..c63e550c881 100644
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
> @@ -49,12 +50,34 @@ static int ufs_qcom_enable_clks(struct ufs_qcom_priv *priv)
>  
>  static int ufs_qcom_init_clks(struct ufs_qcom_priv *priv)
>  {
> -	int err;
>  	struct udevice *dev = priv->hba->dev;
> +	struct clk clk;
> +	int err;
> +	long rate;
> +	u32 max_freq;
> +
> +	/* Get maximum frequency for core_clk_unipro from device tree */
> +	max_freq = ufs_qcom_get_core_clk_unipro_max_freq(priv->hba);
> +
> +	/* Get and configure core_clk_unipro */
> +	err = clk_get_by_name(dev, "core_clk_unipro", &clk);
> +	if (err) {
> +		dev_err(dev, "Failed to get core_clk_unipro: %d\n", err);
> +		return err;
> +	}
> +
> +	rate = clk_set_rate(&clk, max_freq);
> +
> +	if (rate < 0) {
> +		dev_err(dev, "Failed to set core_clk_unipro rate to %u Hz: %ld\n",
> +			max_freq, rate);
> +	}
>  
>  	err = clk_get_bulk(dev, &priv->clks);
> -	if (err)
> +	if (err) {
> +		dev_err(dev, "clk_get_bulk failed: %d\n", err);
>  		return err;
> +	}
>  
>  	return 0;
>  }
> @@ -561,6 +584,18 @@ static int ufs_qcom_init(struct ufs_hba *hba)
>  
>  	priv->hba = hba;
>  
> +	err = ufs_qcom_init_clks(priv);

I would just drop this wrapper and directly invoke clk_get_bulk() here.

> +	if (err) {
> +		dev_err(hba->dev, "failed to initialize clocks, err:%d\n", err);
> +		return err;
> +	}
> +
> +	err = ufs_qcom_enable_clks(priv);

There is already a comment related to this API:

/*
 * The PHY PLL output is the source of tx/rx lane symbol
 * clocks, hence, enable the lane clocks only after PHY
 * is initialized.
 */

Shouldn't PHY be initialized before clocks being enabled?

> +	if (err) {
> +		dev_err(hba->dev, "failed to enable clocks, err:%d\n", err);
> +		return err;
> +	}
> +
>  	/* setup clocks */
>  	ufs_qcom_setup_clocks(hba, true, PRE_CHANGE);
>  
> @@ -579,12 +614,6 @@ static int ufs_qcom_init(struct ufs_hba *hba)
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

While at it, I see this POST_CHANGE setup invoked twice. Can you check
as to why that is needed?

-Sumit
