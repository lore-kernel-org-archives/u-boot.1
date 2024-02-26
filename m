Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D097C54E49
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:55:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B41E887ED1;
	Mon, 26 Feb 2024 09:54:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708937683;
	bh=fBEmiKzgZp8oxqI0VOigpiPrHJsPlMTp9P6rMMHq+E0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mi/My6z9fcvAn6iJGi65TIAMbLJErV900f8wWz+2lw5mHhZPb4TfDE1JgxkCSMasY
	 IodpH9kudRIMd/++f8KiZ6LZAtAM8UGeDai+WCzsp3/gEaGdBfzw9uTQcGVCmasWtf
	 SBQ6TPY936viVqACHs3RtgZBA7TsynJVT8VtPsAcuFNk6gMk+2ph3CTe1bWRC07qZ+
	 br7LabLk9g6t0cG0/MQSLGUldOEcg6UUhW4G6A4m184JxhHEUq0/YWmgb4gRmNOBOP
	 ed4Hxl9G7dk3uJxFSOfMgQNPpw1RNUK3cXRleX85KOgyWniH3N07O/bOKVXgB29R5z
	 DjpwWR3/MGMmg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 4590687EAC;
 Mon, 26 Feb 2024 09:54:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708937681;
 bh=fBEmiKzgZp8oxqI0VOigpiPrHJsPlMTp9P6rMMHq+E0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BNefqd130mZrt3LSj/y9YnalP+XDSsO6LFAi/SaJ9WXcnSeo8t571ZtnLCHEUOXGW
 43eLMicGBai5NIJAYyct1IHBwawl+5IA/Gq1eSk24sp/mAPhXKYdFI4czuNZx0/1Q9
 VJTZ14TAIEsfPlD/5Umdf8Ky2/Fqpa6g4Hn3+NS6pFIMEYgI1+/gfcdJOQmgzDpSWI
 +hdX47uzVxAZjYocs8BVXBZ1s1D0+/qUpLdZkolA1LUjva2uDsHuv0Mk3py2hdR9SP
 Da7D1vY4iRh9C2ZiEvGNKYyexI3vG35H8kWpZK29W86/cX2TZZVPBlZMpZUGNnvVxS
 4GGwgUpns6K7w==
Message-ID: <8c36eac1-2b6b-4810-b4c9-1b8912bfe81e@denx.de>
Date: Mon, 26 Feb 2024 09:40:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] imx8mp: power-domain: Expose high performance PLL
 clock
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-5-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240226080433.3307154-5-sumit.garg@linaro.org>
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

On 2/26/24 9:04 AM, Sumit Garg wrote:
> Expose the high performance PLL as a regular Linux clock, so the
> PCIe PHY can use it when there is no external refclock provided.
> 
> Inspired from counterpart Linux kernel v6.8-rc3 driver:
> drivers/pmdomain/imx/imx8mp-blk-ctrl.c

Commit ID, please, see previous comments in this series.

[...]

> +static int hsio_pll_clk_enable(struct clk *clk)
> +{
> +	void *base = (void *)dev_get_driver_data(clk->dev);
> +	u32 val;
> +	int ret;
> +
> +	/* Setup HSIO PLL */
> +	clrsetbits_le32(base + GPR_REG2,
> +			P_PLL_MASK | M_PLL_MASK | S_PLL_MASK,
> +			FIELD_PREP(P_PLL_MASK, 12) |
> +			FIELD_PREP(M_PLL_MASK, 800) |
> +			FIELD_PREP(S_PLL_MASK, 4));

These magic numbers 12, 800, 4 could use explanation (why these 
numbers?) and a dedicated macro .

> +	/* de-assert PLL reset */
> +	setbits_le32(base + GPR_REG3, PLL_RST);
> +
> +	/* enable PLL */
> +	setbits_le32(base + GPR_REG3, PLL_CKE);
> +
> +	/* Check if PLL is locked */
> +	ret = readl_poll_sleep_timeout(base + GPR_REG1, val,
> +				       val & PLL_LOCK, 10, 100000);
> +	if (ret)
> +		dev_err(clk->dev, "failed to lock HSIO PLL\n");
> +
> +	return ret;
> +}
> +
> +static int hsio_pll_clk_disable(struct clk *clk)
> +{
> +	void *base = (void *)dev_get_driver_data(clk->dev);
> +
> +	clrbits_le32(base + GPR_REG3, PLL_CKE);
> +	clrbits_le32(base + GPR_REG3, PLL_RST);

Can you clear both at once, or do they have to be cleared in sequence ?

[...]

The series is starting to look much better compared to V1 btw , these ^ 
are only nitpicks .
