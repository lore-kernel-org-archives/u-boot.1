Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4F8FA373B
	for <u-boot@archiver.kernel.org>; Fri, 13 Sep 2024 10:07:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C0D28855C;
	Fri, 13 Sep 2024 12:07:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1726222069;
	bh=x+N8SmeC2h0Amzi66RIeD047cOThb30pxbUW6tDb0kM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Yq3m475mJ0Wp07ih1f8rWVvqDvWQkwbgNm6fRRLWe4GOcVzO8LcNmUkV+TGnXxPei
	 qLCU6gkcJkpcqbsadbt1xiUKiW0HowlbBlA/hHSDUI3bzsqKU14ggejhAAYSgXxWW5
	 JBznIATfzONMytfu5DpRsnFH2X93oOZvhUAOn+iUNpckn+6xh4U67eEB9A5DmTFBJ4
	 8kbIc5c6yqWICMxQMeRo7rRWvYkhDiTrlIDDNOnJxpMVNUaFFO93pXrwoJoxbxUfWw
	 nw9U1V/m8V+bfzRVy46zbv7JIT5MewazfjOy+AU+J2v8487/TIpTwF6lfeusBJXKfN
	 aCkZXSUaMvtzA==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id EE15C8839A;
 Fri, 13 Sep 2024 12:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1726222067;
 bh=x+N8SmeC2h0Amzi66RIeD047cOThb30pxbUW6tDb0kM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CbwKcxaTNOki1ELD2QwSpbFhtSEXIq6us1HlUrdLfbAO8/C/yinZZcKDHtc+OMzcv
 U56Y0/sWcnZ2cCRvMdwwz4q+7gAic0+ogj/WgL9rQjJE3khLILH10KFEEIrK7LNVw4
 7pMc/DISdNLBe0r+YeKcscqZ+JPfIHgK2xlZc6xvFe442X0qfrmuxAobwmKaXZx304
 C+00LONh+7KWEGLWPd7krcv7nOKrA8RONa0OcCPqkGC0kMDqtqSLrlfqDSi5LCt812
 7tA47RMLK7wjMtmiV+6ltcGawclfFMMHD/hyG7s0lC40AJwBB/J5eCei8HWVHu887C
 /4L1PHRyknHGw==
Message-ID: <8bc9fe98-2f98-44bc-abd4-ad296a4141e5@denx.de>
Date: Fri, 13 Sep 2024 12:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/26] clk: imx8mm: Mark IMX8MM_SYS_PLL2 and
 IMX8MM_SYS_PLL3 as enabled
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Fabio Estevam <festevam@denx.de>, linux-amarula@amarulasolutions.com,
 michael@amarulasolutions.com, Miquel Raynal <miquel.raynal@bootlin.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
References: <20240913095622.72377-1-dario.binacchi@amarulasolutions.com>
 <20240913095622.72377-6-dario.binacchi@amarulasolutions.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240913095622.72377-6-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 9/13/24 11:55 AM, Dario Binacchi wrote:
> From: Michael Trimarchi <michael@amarulasolutions.com>
> 
> Both clock are enabled by the bootloader and we need to increase their
> reference count to avoid disable during reparent operation.
> 
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 
>   drivers/clk/imx/clk-imx8mm.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index 432348a15cad..0e71ceefe96c 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -176,6 +176,8 @@ static const char * const imx8mm_ecspi3_sels[] = {"clock-osc-24m", "sys_pll2_200
>   static int imx8mm_clk_probe(struct udevice *dev)
>   {
>   	void __iomem *base;
> +	struct clk *clk;
> +	int ret;
>   
>   	base = (void *)ANATOP_BASE_ADDR;
>   
> @@ -458,6 +460,13 @@ static int imx8mm_clk_probe(struct udevice *dev)
>   	clk_dm(IMX8MM_CLK_QSPI_ROOT,
>   	       imx_clk_gate4("qspi_root_clk", "qspi", base + 0x42f0, 0));
>   #endif
> +	ret = clk_get_by_id(IMX8MM_SYS_PLL2, &clk);
> +	if (!ret)
> +		clk_enable(clk);
> +
> +	ret = clk_get_by_id(IMX8MM_SYS_PLL3, &clk);
> +	if (!ret)
> +		clk_enable(clk);
This enables these PLLs for all boards, even the ones which do not need 
those are use those for other purposes like drive the CLKOUT outputs 
from them. Please describe DT consumers, do not hack board-specific 
changes into generic drivers.
