Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4DCCCD184
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 16:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3DE9840F5;
	Thu,  9 Oct 2025 18:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="cdSme2Wp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F6983D0B; Thu,  9 Oct 2025 18:58:33 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 94537842D2
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 18:58:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=n-francis@ti.com
Received: from fllvem-sh03.itg.ti.com ([10.64.41.86])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 599GwP02058473;
 Thu, 9 Oct 2025 11:58:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760029105;
 bh=071TDXFCpkA5Xn5pJ7gC9cykJ5uVVThWel1COMSLaOA=;
 h=Date:Subject:To:CC:References:From:In-Reply-To;
 b=cdSme2Wp2TpMyGS5GH2Q0oVRW5PuYJlMWpIyz9wvVZJNshuN2PnFRcmRKgPUI8jPG
 +QEr+XPfb+r2CSdYNPm6jS0s3eoEkeNBwpGFxspAL1OAo2WPfEENq1Wg0SOOy3ht5h
 F6v+i+BofhJiPTHuBgZT7nBlCYzS7iHyUmhPAE50=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by fllvem-sh03.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 599GwPiX1570939
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Thu, 9 Oct 2025 11:58:25 -0500
Received: from DFLE207.ent.ti.com (10.64.6.65) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 9
 Oct 2025 11:58:25 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 9 Oct 2025 11:58:25 -0500
Received: from [10.249.131.198] ([10.249.131.198])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 599GwMN7326526;
 Thu, 9 Oct 2025 11:58:23 -0500
Message-ID: <6535d9ce-ea5c-498a-846b-40bf999c4c99@ti.com>
Date: Thu, 9 Oct 2025 22:28:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ufs: Add bRefClkFreq attribute setting
To: Jared McArthur <j-mcarthur@ti.com>, <u-boot@lists.denx.de>
CC: Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini
 <trini@konsulko.com>, Bhupesh Sharma <bhupesh.linux@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>
References: <20250827185056.954640-1-j-mcarthur@ti.com>
 <20250827185056.954640-3-j-mcarthur@ti.com>
Content-Language: en-US
From: "Francis, Neha" <n-francis@ti.com>
In-Reply-To: <20250827185056.954640-3-j-mcarthur@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

On 8/28/2025 12:20 AM, Jared McArthur wrote:
> A UFS device needs its bRefClkFreq attribute set to the correct value
> before switching to high speed. If bRefClkFreq is set to the wrong
> value, all transactions after the power mode change will fail.
> 
> The bRefClkFreq depends on the host controller and the device.
> Query the device's current bRefClkFreq and compare with the ref_clk
> specified in the device-tree. If the two differ, set the bRefClkFreq
> to the device-tree's ref_clk frequency.
> 
> Taken from Linux kernel v6.17 (drivers/ufs/core/ufshcd.c and
> include/ufs/ufs.h) and ported to U-Boot.
> 
> This patch depends on the previous patch: "ufs: Add support for
> sending UFS attribute requests"
> 
> Signed-off-by: Jared McArthur <j-mcarthur@ti.com>
> ---
>  drivers/ufs/ufs.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/ufs/ufs.h | 10 ++++++
>  2 files changed, 99 insertions(+)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 9e67dd86232..4bffbf87749 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -10,6 +10,7 @@
>  
>  #include <bouncebuf.h>
>  #include <charset.h>
> +#include <clk.h>
>  #include <dm.h>
>  #include <log.h>
>  #include <dm/device_compat.h>
> @@ -1773,6 +1774,92 @@ out:
>  	return err;
>  }
>  
> +struct ufs_ref_clk {
> +	unsigned long freq_hz;
> +	enum ufs_ref_clk_freq val;
> +};
> +
> +static const struct ufs_ref_clk ufs_ref_clk_freqs[] = {
> +	{19200000, REF_CLK_FREQ_19_2_MHZ},
> +	{26000000, REF_CLK_FREQ_26_MHZ},
> +	{38400000, REF_CLK_FREQ_38_4_MHZ},
> +	{52000000, REF_CLK_FREQ_52_MHZ},
> +	{0, REF_CLK_FREQ_INVAL},
> +};
> +
> +static enum ufs_ref_clk_freq
> +ufs_get_bref_clk_from_hz(unsigned long freq)
> +{
> +	int i;
> +
> +	for (i = 0; ufs_ref_clk_freqs[i].freq_hz; i++)
> +		if (ufs_ref_clk_freqs[i].freq_hz == freq)
> +			return ufs_ref_clk_freqs[i].val;
> +
> +	return REF_CLK_FREQ_INVAL;
> +}
> +
> +void ufshcd_parse_dev_ref_clk_freq(struct ufs_hba *hba, struct clk *refclk)
> +{
> +	unsigned long freq;
> +
> +	freq = clk_get_rate(refclk);
> +
> +	hba->dev_ref_clk_freq =
> +		ufs_get_bref_clk_from_hz(freq);
> +
> +	if (hba->dev_ref_clk_freq == REF_CLK_FREQ_INVAL)
> +		dev_err(hba->dev,
> +			"invalid ref_clk setting = %ld\n", freq);
> +}
> +
> +static int ufshcd_set_dev_ref_clk(struct ufs_hba *hba)
> +{
> +	int err;
> +	struct clk *ref_clk;
> +	u32 host_ref_clk_freq;
> +	u32 dev_ref_clk_freq;
> +
> +	/* get ref_clk */
> +	ref_clk = devm_clk_get(hba->dev, "ref_clk");
> +	if (IS_ERR((const void *)ref_clk)) {
> +		err = PTR_ERR(ref_clk);
> +		goto out;
> +	}
> +
> +	ufshcd_parse_dev_ref_clk_freq(hba, ref_clk);
> +	host_ref_clk_freq = hba->dev_ref_clk_freq;
> +
> +	if (host_ref_clk_freq == REF_CLK_FREQ_INVAL)
> +		goto out;
> +
> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_READ_ATTR,
> +				      QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &dev_ref_clk_freq);
> +
> +	if (err) {
> +		dev_err(hba->dev, "failed reading bRefClkFreq. err = %d\n", err);
> +		goto out;
> +	}
> +
> +	if (dev_ref_clk_freq == host_ref_clk_freq)
> +		goto out; /* nothing to update */
> +
> +	err = ufshcd_query_attr_retry(hba, UPIU_QUERY_OPCODE_WRITE_ATTR,
> +				      QUERY_ATTR_IDN_REF_CLK_FREQ, 0, 0, &host_ref_clk_freq);
> +
> +	if (err) {
> +		dev_err(hba->dev, "bRefClkFreq setting to %lu Hz failed\n",
> +			ufs_ref_clk_freqs[host_ref_clk_freq].freq_hz);
> +		goto out;
> +	}
> +
> +	dev_dbg(hba->dev, "bRefClkFreq setting to %lu Hz succeeded\n",
> +		ufs_ref_clk_freqs[host_ref_clk_freq].freq_hz);
> +
> +out:
> +	return err;
> +}
> +
>  /**
>   * ufshcd_get_max_pwr_mode - reads the max power mode negotiated with device
>   */
> @@ -2000,6 +2087,8 @@ static int ufs_start(struct ufs_hba *hba)
>  		return ret;
>  	}
>  
> +	ufshcd_set_dev_ref_clk(hba);
> +
>  	if (ufshcd_get_max_pwr_mode(hba)) {
>  		dev_err(hba->dev,
>  			"%s: Failed getting max supported power mode\n",
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 53137fae3a8..def39d4ad24 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -172,6 +172,15 @@ enum query_opcode {
>  	UPIU_QUERY_OPCODE_TOGGLE_FLAG	= 0x8,
>  };
>  
> +/* bRefClkFreq attribute values */
> +enum ufs_ref_clk_freq {
> +	REF_CLK_FREQ_19_2_MHZ	= 0,
> +	REF_CLK_FREQ_26_MHZ	= 1,
> +	REF_CLK_FREQ_38_4_MHZ	= 2,
> +	REF_CLK_FREQ_52_MHZ	= 3,
> +	REF_CLK_FREQ_INVAL	= -1,
> +};
> +
>  /* Query response result code */
>  enum {
>  	QUERY_RESULT_SUCCESS                    = 0x00,
> @@ -684,6 +693,7 @@ struct ufs_hba {
>  	u32			capabilities;
>  	u32			version;
>  	u32			intr_mask;
> +	enum ufs_ref_clk_freq dev_ref_clk_freq;
>  	enum ufshcd_quirks	quirks;
>  
>  	/* Virtual memory reference */

Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

