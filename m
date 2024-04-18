Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2195BC4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 18:14:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C8888869F;
	Thu, 18 Apr 2024 20:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1713464049;
	bh=6e4LV9/mGo1RiOZDlPsBZdp6zAf6LcUFLkRwIGLklDE=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M+ph/AcHhKnrRhF+2Rbe2ILSN7ZpRSd0kJk6PF1ZHN8IgEpqagWQM/tAYuW76IvZN
	 C8n2QdExWcpPqI18qASBoNeIRlS/FiFZ0sZMCKpaqyCbC0FIh6+6pqTkMrx/78EQMW
	 Jy8LjUYKIoXYj7HJI1clsprKDf9FjIXsm9hbM4URbzRsgvsTNEnkE4ocQg55l/eMWK
	 ohOJbMXV+B3HchKd3x/q3mPXExytDboAbbzPTwRKKLcytPLaKPv7pOhwVxYVCPvUDf
	 fPtNZ5GuoFQWmASwUEw4s2l37k4n70IneF2fCy5gv9bpiIQsNCrZVw4ZpSwgnfefc6
	 bM/9STexls4yg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 2267288691;
 Thu, 18 Apr 2024 20:14:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1713464046;
 bh=6e4LV9/mGo1RiOZDlPsBZdp6zAf6LcUFLkRwIGLklDE=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=vbEB3QHMQRB8falDv1hStsw05xdjFV7yoE0zx7/86V3ZQg0x2LkkPSPsA/pcb18+X
 x0koPoA+uptiHPQHLb+qs1iQspHDEjTJ+52XshApdY2sfpPfslj6XitSag90lvPtEU
 gkyp6O5TGZMytQOG5p+Rw+HO3LdspqxoYEoXT0Lxy1cbb/kyrm4JyBCjcohkgWWLr1
 cFJgscngThhKSX+k9D9kQWM/Hte/WW5Seg5FZ1OC8csgCtNif2kcMeYIiZUjKnzTRn
 v1SJ72iKiuxOjnZH5AWVtGB+s013GmO4+2KBwbUurNpqsKuOtsM3akXX9Qfjzp08Yo
 js1ZzZkOAs/yQ==
Message-ID: <b47af088-17e7-4a28-9d1d-dbbd0d4f5dca@denx.de>
Date: Thu, 18 Apr 2024 20:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] clk: imx8mm: Add support for PCIe clocks
To: Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Sumit Garg <sumit.garg@linaro.org>, Fabio Estevam <festevam@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
References: <20240418175612.4068609-1-tharvey@gateworks.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240418175612.4068609-1-tharvey@gateworks.com>
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

On 4/18/24 7:56 PM, Tim Harvey wrote:
> Add support for PCIe clocks required to enable PCIe support on
> iMX8MM SoC.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v2: no changes
> ---
>   drivers/clk/imx/clk-imx8mm.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
> index b5c253e49663..c2f01b385201 100644
> --- a/drivers/clk/imx/clk-imx8mm.c
> +++ b/drivers/clk/imx/clk-imx8mm.c
> @@ -66,6 +66,15 @@ static const char *imx8mm_i2c3_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_
>   static const char *imx8mm_i2c4_sels[] = {"clock-osc-24m", "sys_pll1_160m", "sys_pll2_50m", "sys_pll3_out", "audio_pll1_out",
>   					 "video_pll1_out", "audio_pll2_out", "sys_pll1_133m", };
>   
> +static const char *imx8mm_pcie1_ctrl_sels[] = {"clock-osc-24m", "sys_pll2_250m", "sys_pll2_200m", "sys_pll1_266m",
> +					       "sys_pll1_800m", "sys_pll2_500m", "sys_pll2_333m", "sys_pll3_out", };
> +
> +static const char *imx8mm_pcie1_phy_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll2_500m", "clk_ext1", "clk_ext2",
> +					      "clk_ext3", "clk_ext4", "sys_pll1_400m", };
> +
> +static const char *imx8mm_pcie1_aux_sels[] = {"clock-osc-24m", "sys_pll2_200m", "sys_pll2_50m", "sys_pll3_out",
> +					      "sys_pll2_100m", "sys_pll1_80m", "sys_pll1_160m", "sys_pll1_200m", };
> +
>   #ifndef CONFIG_SPL_BUILD
>   static const char *imx8mm_pwm1_sels[] = {"clock-osc-24m", "sys_pll2_100m", "sys_pll1_160m", "sys_pll1_40m",
>   					 "sys_pll3_out", "clk_ext1", "sys_pll1_80m", "video_pll1_out", };
> @@ -256,6 +265,15 @@ static int imx8mm_clk_probe(struct udevice *dev)
>   		imx8m_clk_composite("usb_bus", imx8mm_usb_bus_sels, base + 0x8b80));
>   
>   	/* IP */
> +	clk_dm(IMX8MM_CLK_PCIE1_CTRL,
> +	       imx8m_clk_composite("pcie1_ctrl", imx8mm_pcie1_ctrl_sels,
> +				   base + 0xa300));
> +	clk_dm(IMX8MM_CLK_PCIE1_PHY,
> +	       imx8m_clk_composite("pcie1_phy", imx8mm_pcie1_phy_sels,
> +				   base + 0xa380));
> +	clk_dm(IMX8MM_CLK_PCIE1_AUX,
> +	       imx8m_clk_composite("pcie1_aux", imx8mm_pcie1_aux_sels,
> +				   base + 0xa400));

Maybe this should be behind IS_ENABLED() like the SPI clock to avoid 
growth of SPL ?
