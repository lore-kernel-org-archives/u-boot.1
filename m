Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBED1C6FD1F
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 00:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265448819E;
	Wed,  3 Apr 2024 02:39:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="daJALjTz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D44B881A7; Wed,  3 Apr 2024 02:39:54 +0200 (CEST)
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01A5888141
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 02:39:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jh80.chung@samsung.com
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240403003948epoutp023f5d9ef2e2eaa1cc7d195f18c779bc27~CnjvWnJTp2789827898epoutp02N
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 00:39:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240403003948epoutp023f5d9ef2e2eaa1cc7d195f18c779bc27~CnjvWnJTp2789827898epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1712104788;
 bh=4Fz+cR4ABBd5v1W+QmjkaShYgXjEqlvwewIRteDQexA=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=daJALjTzY80PvdJzUDJ5sMunWC7T+Yk4ZvsM+Ot6Q6Mfu1SI8DMDzcr7Tr20V1EPx
 VR2t0Y8XSUAPpuu6f37WBkmHqxD381Y2nc6PetMwk0fvWx6hse8XQ2ZRtSwm931Ydc
 eejymaAEVIcAUK2BvA/ErvYLfoSHbtWnR7GMUg0s=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
 epcas1p1.samsung.com (KnoxPortal) with ESMTP id
 20240403003947epcas1p17718a8b3c6058be83a86a633b86947e0~Cnju41kr92150621506epcas1p10;
 Wed,  3 Apr 2024 00:39:47 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.36.132]) by
 epsnrtp4.localdomain (Postfix) with ESMTP id 4V8Qr255wXz4x9QF; Wed,  3 Apr
 2024 00:39:46 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
 epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
 83.06.10076.155AC066; Wed,  3 Apr 2024 09:39:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
 epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
 20240403003945epcas1p4bb700e4390a5c5d29dbe241cb621db7a~CnjsiKZ-J0412504125epcas1p4-;
 Wed,  3 Apr 2024 00:39:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
 epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20240403003945epsmtrp19ca604487c11fe768395b9c174f1c159~CnjshhOwL2940429404epsmtrp11;
 Wed,  3 Apr 2024 00:39:45 +0000 (GMT)
X-AuditID: b6c32a39-59dff7000000275c-da-660ca55138a5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
 epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
 29.8D.07541.055AC066; Wed,  3 Apr 2024 09:39:44 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20240403003944epsmtip14732deab3ced73ca610a872acd96a2d7~CnjsTfILt0474504745epsmtip1F;
 Wed,  3 Apr 2024 00:39:44 +0000 (GMT)
Message-ID: <01f712ed-a07c-4db7-b7c1-9dc0f7efd898@samsung.com>
Date: Wed, 3 Apr 2024 09:39:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mmc: hi6220-dwmmc: handle clocks and resets if
 CONFIG_CLK and CONFIG_DM_RESET enabled
To: forbidden405@outlook.com, Peng Fan <peng.fan@nxp.com>
Cc: u-boot@lists.denx.de
Content-Language: en-US
From: Jaehoon Chung <jh80.chung@samsung.com>
In-Reply-To: <20240201-mmc-v2-1-9f09dc1335fd@outlook.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDKsWRmVeSWpSXmKPExsWy7bCmrm7gUp40g57NUhb/bu5ht/ix6gur
 xdu9newOzB5n7+xg9Nj4bgeTx+bXL5gDmKOybTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwM
 dQ0tLcyVFPISc1NtlVx8AnTdMnOANikplCXmlAKFAhKLi5X07WyK8ktLUhUy8otLbJVSC1Jy
 CkwL9IoTc4tL89L18lJLrAwNDIxMgQoTsjMOLJnFWDBDsWLW3AeMDYynpboYOTkkBEwkPh6c
 wNjFyMUhJLCDUeLZ7hdsIAkhgU+MEnee8UIkvjFKrH08h6WLkQOs49ZkX4j4XkaJpheT2SCc
 94wS319PZAHp5hWwk/g6+x87iM0ioCIx99JPVoi4oMTJmU/AakQF5CXu35oBViMsUCwx6+0n
 JhBbRMBSYtby02A2s4CExJJD91khbHGJW0/mg8XZBHQktn87DmZzAtUvPrmPDaJGXmL72znM
 IAdJCNxilzjSd4oF4k8Xia1nj7NB2MISr45vYYewpSRe9rexQzQ0M0osXXKQFcLpYZT413Ad
 qsNYYv/SyUwg/zMLaEqs36UPsY1P4t3XHlZIsPBKdLQJQVSrSFx6/ZIJZv7dJ/9ZIWwPiW+P
 Z7NDQms3o8TLTRcZJzAqzEIKmFlIHp2F5KFZCJsXMLKsYhRLLSjOTU8tNiwwhUd3cn7uJkZw
 MtSy3ME4/e0HvUOMTByMhxglOJiVRHh/enOmCfGmJFZWpRblxxeV5qQWH2I0BUbPRGYp0eR8
 YDrOK4k3NLE0MDEzMjaxMDQzVBLnPXOlLFVIID2xJDU7NbUgtQimj4mDU6qBaeGWnLc1TDtb
 Hvizd90RP6U8/YY7N6fVulnht81LXFaYTi/q9jk18+f/WatXnQwNEOPjUv28ymKJWavaa9bz
 OQbiVx57vU5uNMx3PminelnT+eDrUPs/B/drB/Ro6NxeeCbM9NRJzzjHKbwBxz/9a3C0qEz3
 lvGpXmRStPVolcaEUzPi2hk159soLZm38LDSa0Wh1MMb76XPjbGafIiz5fuMJWu/m0WU+BQL
 mrD4W6775fz50X6hRbJ8qie2NdyLO5TE7KL6kiGgg5fb0Vype1fC8WaBqVqHPMwWRB367MBb
 xu1496Su6KvD/O0nWI/llPTVsniX9jaIG5QHz0rovSe00WPbyu9ng7zONtYrsRRnJBpqMRcV
 JwIA8VC7Qg8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnG7gUp40g+MhFv9u7mG3+LHqC6vF
 272d7A7MHmfv7GD02PhuB5PH5tcvmAOYo7hsUlJzMstSi/TtErgyDiyZxVgwQ7Fi1twHjA2M
 p6W6GDk4JARMJG5N9u1i5OIQEtjNKHH33WKWLkZOoLiUxOenU9kgaoQlDh8uBgkLCbxllDj2
 ygfE5hWwk/g6+x87iM0ioCIx99JPVoi4oMTJmU/AxogKyEvcvzUDrEZYoFhi1ttPTCC2iICl
 xKzlp8FsZgEJiSWH7rNCzE+XmLyolRUiLi5x68l8sBo2AR2J7d+Og9mcQL2LT+4DO41ZQF1i
 /TwhiHJ5ie1v5zBPYBSaheSKWUgmzULomIWkYwEjyypGydSC4tz03GTDAsO81HK94sTc4tK8
 dL3k/NxNjOCA19LYwXhv/j+9Q4xMHIyHGCU4mJVEeH96c6YJ8aYkVlalFuXHF5XmpBYfYpTm
 YFES5zWcMTsF6J3EktTs1NSC1CKYLBMHp1QDk7Pa+cX3Q0M7Ty6r94k+wJXGsLHplTL3I4He
 s/cko1RLhW2cUx6e5LnoOzsm51PBhGYRtk72xd3rW/UNzuu5J50/b1eh/uC7VP3+qTWsM7Ru
 Xz2gumJ9kvd015/9kV6Rh1YdOfYgXe74HN2PFklbO472eyqxvj7jMuVaxKLKfVxcxg3+eVIc
 xwoVY+7d2+Bz1HaOTXi7/1p/TpZfWUr3bvbwqH7NvOEh0bm3bVZnV67zvw8bg35EWj65f1rO
 Xv6w3TLLcH3NgL3VC80umk7axeT+22rG7nCnTd17NQ5cW/Cr6aVfx8mr29S2xxe61vgGHr17
 ttvzutxOde/n9vtEniufi+2q/JB0ZIP700kySizFGYmGWsxFxYkAdhNLt+cCAAA=
X-CMS-MailID: 20240403003945epcas1p4bb700e4390a5c5d29dbe241cb621db7a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240403003945epcas1p4bb700e4390a5c5d29dbe241cb621db7a
References: <20240201-mmc-v2-0-9f09dc1335fd@outlook.com>
 <20240201-mmc-v2-1-9f09dc1335fd@outlook.com>
 <CGME20240403003945epcas1p4bb700e4390a5c5d29dbe241cb621db7a@epcas1p4.samsung.com>
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

Hi,

On 2/1/24 23:05, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> This can avoid hardcoding a clock rate in driver. Also can enable the
> clocks and deassert the resets if the pre-bootloader does not do this
> for us.
> 
> Currently only enabled for Hi3798MV200.
> 
> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
> ---
>  drivers/mmc/hi6220_dw_mmc.c | 61 ++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/hi6220_dw_mmc.c b/drivers/mmc/hi6220_dw_mmc.c
> index 71962cd47e..a4b8072976 100644
> --- a/drivers/mmc/hi6220_dw_mmc.c
> +++ b/drivers/mmc/hi6220_dw_mmc.c
> @@ -5,15 +5,24 @@
>   */
>  
>  #include <common.h>
> +#include <clk.h>
>  #include <dm.h>
>  #include <dwmmc.h>
>  #include <errno.h>
>  #include <fdtdec.h>
>  #include <malloc.h>
> +#include <reset.h>
>  #include <asm/global_data.h>
> +#include <dm/device_compat.h>
>  
>  DECLARE_GLOBAL_DATA_PTR;
>  
> +enum hi6220_dwmmc_clk_type {
> +	HI6220_DWMMC_CLK_BIU,
> +	HI6220_DWMMC_CLK_CIU,
> +	HI6220_DWMMC_CLK_CNT,
> +};
> +
>  struct hi6220_dwmmc_plat {
>  	struct mmc_config cfg;
>  	struct mmc mmc;
> @@ -21,6 +30,8 @@ struct hi6220_dwmmc_plat {
>  
>  struct hi6220_dwmmc_priv_data {
>  	struct dwmci_host host;
> +	struct clk *clks[HI6220_DWMMC_CLK_CNT];
> +	struct reset_ctl_bulk rsts;
>  };
>  
>  struct hisi_mmc_data {
> @@ -32,7 +43,29 @@ static int hi6220_dwmmc_of_to_plat(struct udevice *dev)
>  {
>  	struct hi6220_dwmmc_priv_data *priv = dev_get_priv(dev);
>  	struct dwmci_host *host = &priv->host;
> +	int ret;

If CONFIG_CLK and DM_RESET aren't enabled, this value is a dead code.
It also needs to initialize.

>  
> +	if (CONFIG_IS_ENABLED(CLK) && CONFIG_IS_ENABLED(DM_RESET)) {
> +		priv->clks[HI6220_DWMMC_CLK_BIU] = devm_clk_get(dev, "biu");
> +		if (IS_ERR(priv->clks[HI6220_DWMMC_CLK_BIU])) {
> +			ret = PTR_ERR(priv->clks[HI6220_DWMMC_CLK_BIU]);
> +			dev_err(dev, "Failed to get BIU clock(ret = %d).\n", ret);
> +			return log_msg_ret("clk", ret);
> +		}
> +
> +		priv->clks[HI6220_DWMMC_CLK_CIU] = devm_clk_get(dev, "ciu");
> +		if (IS_ERR(priv->clks[HI6220_DWMMC_CLK_CIU])) {
> +			ret = PTR_ERR(priv->clks[HI6220_DWMMC_CLK_CIU]);
> +			dev_err(dev, "Failed to get CIU clock(ret = %d).\n", ret);
> +			return log_msg_ret("clk", ret);
> +		}
> +
> +		ret = reset_get_bulk(dev, &priv->rsts);
> +		if (ret) {
> +			dev_err(dev, "Failed to get resets(ret = %d)", ret);
> +			return log_msg_ret("rst", ret);
> +		}
> +	}
>  	host->name = dev->name;
>  	host->ioaddr = dev_read_addr_ptr(dev);
>  	host->buswidth = fdtdec_get_int(gd->fdt_blob, dev_of_offset(dev),
> @@ -56,11 +89,37 @@ static int hi6220_dwmmc_probe(struct udevice *dev)
>  	struct hi6220_dwmmc_priv_data *priv = dev_get_priv(dev);
>  	struct dwmci_host *host = &priv->host;
>  	struct hisi_mmc_data *mmc_data;
> +	int ret;

Ditto.


Best Regards,
Jaehoon Chung

>  
>  	mmc_data = (struct hisi_mmc_data *)dev_get_driver_data(dev);
>  
> -	/* Use default bus speed due to absence of clk driver */
>  	host->bus_hz = mmc_data->clock;
> +	if (CONFIG_IS_ENABLED(CLK) && CONFIG_IS_ENABLED(DM_RESET)) {
> +		ret = clk_prepare_enable(priv->clks[HI6220_DWMMC_CLK_BIU]);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable biu clock(ret = %d).\n", ret);
> +			return log_msg_ret("clk", ret);
> +		}
> +
> +		ret = clk_prepare_enable(priv->clks[HI6220_DWMMC_CLK_CIU]);
> +		if (ret) {
> +			dev_err(dev, "Failed to enable ciu clock(ret = %d).\n", ret);
> +			return log_msg_ret("clk", ret);
> +		}
> +
> +		ret = reset_deassert_bulk(&priv->rsts);
> +		if (ret) {
> +			dev_err(dev, "Failed to deassert resets(ret = %d).\n", ret);
> +			return log_msg_ret("rst", ret);
> +		}
> +
> +		host->bus_hz = clk_get_rate(priv->clks[HI6220_DWMMC_CLK_CIU]);
> +		if (host->bus_hz <= 0) {
> +			dev_err(dev, "Failed to get ciu clock rate(ret = %d).\n", ret);
> +			return log_msg_ret("clk", ret);
> +		}
> +	}
> +	dev_dbg(dev, "bus clock rate: %d.\n", host->bus_hz);
>  
>  	dwmci_setup_cfg(&plat->cfg, host, host->bus_hz, 400000);
>  	host->mmc = &plat->mmc;

