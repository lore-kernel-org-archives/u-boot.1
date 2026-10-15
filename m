Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9109CCC6B34
	for <u-boot@archiver.kernel.org>; Thu, 15 Oct 2026 08:23:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 28CB140766;
	Thu, 15 Oct 2026 08:23:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w5pe_jrVeit6; Thu, 15 Oct 2026 08:23:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 1743E40807
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792052611;
	b=aD5HrzZ4qa9OOo+dOy/4SbraOm4ZzgFuiIU399TLCYqeQzLWVMBcPX2ERMNGyfZwc2gN
	 cWyzZj4jx+IcxkWgkUh72u8L9s+wjXJOhUCHaQK+k5ZJdepwQyCdD0xArXqFtqlwcngXM
	 Oz+Tma84ymcoTO94YzhjTwqyoNrcySqPc90hQfNb4l4AITruegJx+EwK0+W0p1Mu1K2I8
	 NDvHugfCaxjExk/JF5/p0NjaqTbf7eHaztYX73sUf2c/zGDkpvWwQDnYVLHUjoO1FNlKl
	 +zWur8ue6OrNKEdgeRb073NOQumKdyTjX3ojaeGrx/XHUX2g4DdiD8g6/lTf9GlvN0A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792052611;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:References:From:Subject:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=2zk6t5iY1dYmneziOV+90l6NFAU5dol7Mh7Vc0gZdtg=;
	b=GFxjfqcfobfMjElKh24FoEATwip6H2aR6Fr10dM51P7DY6MxL5GKA4lBEjb7gM0uDcbs
	 OWh64xkndSG8leIbVRA7grBgg/9T4KF8CuM9o+yL7ynrbV3+9yHWAGzLZXYSvUEu+E13L
	 WwYpmJ+LI+W0kDzALoEeZxkJqA+0hTTaKD02L5QyBMa1u/cuWHtCSVVoi8zPAPAf6Kh1K
	 G0kwmaK4w/SUmmnq0hTfkG9NmLucOsGqIzCrWSy1AlNrVfYHj8lYp2VUlglWGpJ1/bL0P
	 yPrgUsktqO/0yFVicjOJKfuguTlhvVgayi2ja4xcazP3L5ilcUf8g9s5tFQZunLR5Ag==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792052611;
	bh=2zk6t5iY1dYmneziOV+90l6NFAU5dol7Mh7Vc0gZdtg=;
	h=Date:To:References:From:Subject:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FFmCjQpCc3ycVh77WESWe4BF/VPuQztGiAyVitLCh7zMY1v0ffxYmyBvKcCzHllnN
	 S5jd2+MxdJoQIce17mPEZU75y1J5RO2z+q8Rxy4v6iTPUMxj0DXCdLdYWjbDPcjmGK
	 r6OSKRU9gzv+L5OAH+YEMahtr945soTtWV30g8LrbbiGU0Y3B+640lpcpfNXtDf0k1
	 twdyGPMyVX1JNudtxg6l2FxsgVTwOsRbqztWPBGYmRvn93noHEHB4mQqmJ/DGmbbMs
	 VKfDBAKF0lGcALhJxMsYe4ztKFh5bTv7ofaUQw8KW0wo+LFias7LTFm7tYI/8Cj46w
	 zMFz6Hx6Ge3/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1743E40807;
	Thu, 15 Oct 2026 08:23:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 077EF769
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:23:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 05103607DB
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:23:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8EF6f2jeKYBr for <u-boot@lists.u-boot-project.org>;
 Thu, 15 Oct 2026 08:23:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5E0AF6069F
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792052609;
 b=pYra5tzKTtRlw7wVn97+prDSZgmPa3NInucOnvi4olST31HQ0G8vkF5xrQ9shHDn2lNF
 6qB/CqYRiZatDNB1HOx+wiWihIUUPsoYaFJSA1+78CsjFwSLBVt5qbDAnL5HcKOGIQWyb
 4OvdCOJ9yziAXOGNE21w/A70xl68dHa4fD7D5Vm/IOvgv9rdcFgSkbnAc4GJg3CMVB1I8
 +wJfzSNBu4KpIo/XtR3ddM8RNdptY6IX5iVXD/EDOoGpMvTLAXzs0ah0KrWgda/kOFLTq
 jvAlKKN+8AE2gsPH2qQs9q7ExrCVAwkE9Pi9LK6Y16F2zvKUp9l8n1wk9E9QXBpyAAQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792052609;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
 User-Agent:Content-Language:To:References:From:Subject:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=2zk6t5iY1dYmneziOV+90l6NFAU5dol7Mh7Vc0gZdtg=;
 b=ZTGQE3NdXvekvIM2AKkht0LznVxf4HrXGeiE1KxGq6VMe/bgRqiMARQ/cTbuw5sOzpmD
 An/RGVyy9oPjk+zFjnId1/IAsEfEZWrE117cDRDtX3dv1jPuxotfDceZ2b7gvvYehw8+b
 12M6Hd8pyIDaPX15WcKmAyWTrhXWkooki+nzLNjgnFGkLJOaxJErrDpeqJH+Ff02umA93
 KtrnBUIaiAkrEA9vp7YGDS+rxDsZ/pO8wJzAep9y0SmRRRQkjP3Z3HLZkjjxXYXrCoAQZ
 mLWqlr5We04HeUFGuMXZ0v7CVs9haTntnru3wpQWcpRbUMv1A6zpgdlUxkkWDm7lINw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=nabladev.com;
 dkim=pass header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=fT28BY+O; 
 arc=none smtp.remote-ip="2a00:f820:417:0:178:251:229:89"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:f820:417:0:178:251:229:89; helo=mx.nabladev.com;
 envelope-from=hs@nabladev.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256
 header.s=dkim header.b=fT28BY+O
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5E0AF6069F
 for <u-boot@lists.u-boot-project.org>; Thu, 15 Oct 2026 08:23:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 0648C1057EC; Thu, 15 Oct 2026 10:22:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1792052597;
 h=from:subject:date:message-id:to:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=2zk6t5iY1dYmneziOV+90l6NFAU5dol7Mh7Vc0gZdtg=;
 b=fT28BY+OtMmJo5HAOcqpHqCzTmDqbPUYNy37J6kpX5NLSgz/J3CHKa/PCF/9MIfPQW3YXj
 lzwNUyW0zilAush9YgAoA4xocfr21LCW+8uDisDafMx078VO7/bSkbxp1YK2arX+EtfTpE
 qNxu7rie2ANrCD4JXYaD3/36dKCrgYC/MEFirRyFTc1CmLGqSYp80WJI1C3kHGEH+T8B3P
 3G7SDvncRX9DxSJW9gVYwUqVptAxGK9QuRXU28KPieboTTc871chJyiKQeWgt9TADczv8t
 bGpebXnvQLHjGh5BHZMrPpWGmDnyvpWbcj1D4ywqa3dLj2HBYGj/DgA+GXCTcA==
Message-ID: <ec34c46d-519b-964f-1d64-4e32d841ce54@nabladev.com>
Date: Thu, 15 Oct 2026 10:21:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>,
 trini@konsulko.com, ilias.apalodimas@linaro.org, peng.fan@nxp.com,
 jh80.chung@samsung.com, tanmay.kathpalia@altera.com,
 casey.connolly@linaro.org, neil.armstrong@linaro.org, sumit.garg@kernel.org,
 lukma@nabladev.com, Michael.Srba@seznam.cz,
 balaji.selvanathan@oss.qualcomm.com, aswin.murugan@oss.qualcomm.com,
 u-boot@lists.u-boot-project.org, u-boot-qcom@groups.io
References: <20261007174151.2590649-1-gurumoorthy.santhakumar@oss.qualcomm.com>
 <20261007174151.2590649-2-gurumoorthy.santhakumar@oss.qualcomm.com>
From: Heiko Schocher <hs@nabladev.com>
Subject: Re: [PATCH v1 1/5] i2c: geni: Add 32MHz clock and chip probing support
In-Reply-To: <20261007174151.2590649-2-gurumoorthy.santhakumar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hello Gurumoorthy Santhakumar,

On 07.10.26 19:41, Gurumoorthy Santhakumar wrote:
> Add support for 32MHz GENI SE clocks through dedicated timing tables
> selected via the qcom,geni-se-clk-32mhz DT property. Also add chip
> probing support.
> 
> Depends on:
> misc: qcom_geni: Add minicore support
> Link: https://lore.kernel.org/u-boot/20261005-spl-v10-1-c4ca29bf27ed@oss.qualcomm.com/
> 
> Signed-off-by: Gurumoorthy Santhakumar <gurumoorthy.santhakumar@oss.qualcomm.com>
> ---
>   drivers/i2c/geni_i2c.c | 76 ++++++++++++++++++++++++++++++++++++------
>   1 file changed, 66 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/i2c/geni_i2c.c b/drivers/i2c/geni_i2c.c
> index 7498cbcb41a..9edba3dd551 100644
> --- a/drivers/i2c/geni_i2c.c
> +++ b/drivers/i2c/geni_i2c.c
> @@ -96,18 +96,35 @@ struct geni_i2c_priv {
>    * clk_freq_out = t / t_cycle
>    * source_clock = 19.2 MHz
>    */
> -static const struct geni_i2c_clk_fld geni_i2c_clk_map[] = {
> -	{I2C_SPEED_STANDARD_RATE, 7, 10, 11, 26},
> -	{I2C_SPEED_FAST_RATE, 2,  5, 12, 24},
> -	{I2C_SPEED_FAST_PLUS_RATE, 1, 3,  9, 18},
> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
> +	{I2C_SPEED_STANDARD_RATE, 7, 10, 12, 26},

value changes from 11 -> 12 ? Why?

> +	{I2C_SPEED_FAST_RATE, 2,  5, 11, 22},
> +	{I2C_SPEED_FAST_PLUS_RATE, 1, 2,  8, 18},
>   };

You change here the values for I2C_SPEED_FAST_PLUS_RATE.

Have you checked, that the frequency is still the same with this settings?

Ah, I found your settings also in the linux driver!

It came in through commit
"""
commit a815975cbaeb4ab29f45312ef23be2871b2e8b82
Author: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Date:   Wed Jan 22 12:16:34 2025 +0530

     i2c: qcom-geni: Update i2c frequency table to match hardware guidance
"""
I see this as a seperate patch, and please refer to the above
linux commit ... sorry for this nitpick...

>   
> -static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni, unsigned int clk_freq)
> +/* source_clock = 32 MHz */
> +static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
> +	{I2C_SPEED_STANDARD_RATE, 12, 9, 10, 26},
> +	{I2C_SPEED_FAST_RATE, 4,  3, 9, 19},
> +	{I2C_SPEED_FAST_PLUS_RATE, 2, 3, 5, 15},
> +};
> +
> +static int geni_i2c_clk_map_idx(struct geni_i2c_priv *geni,
> +				unsigned int clk_freq, bool use_32mhz)
>   {
> -	const struct geni_i2c_clk_fld *itr = geni_i2c_clk_map;
> +	const struct geni_i2c_clk_fld *itr;
> +	int array_size;
>   	int i;
>   
> -	for (i = 0; i < ARRAY_SIZE(geni_i2c_clk_map); i++, itr++) {
> +	if (use_32mhz) {
> +		itr = geni_i2c_clk_map_32mhz;
> +		array_size = ARRAY_SIZE(geni_i2c_clk_map_32mhz);
> +	} else {
> +		itr = geni_i2c_clk_map_19p2mhz;
> +		array_size = ARRAY_SIZE(geni_i2c_clk_map_19p2mhz);
> +	}
> +
> +	for (i = 0; i < array_size; i++, itr++) {
>   		if (itr->clk_freq_out == clk_freq) {
>   			geni->clk_fld = itr;
>   			return 0;
> @@ -262,6 +279,38 @@ static int geni_i2c_xfer_rx(struct geni_i2c_priv *geni, struct i2c_msg *msg, u32
>   	return geni_i2c_fifo_rx_drain(geni, msg);
>   }
>   
> +/* Probe to see if a chip is present. */
> +static int geni_i2c_probe_chip(struct udevice *dev, uint chip_addr,
> +			       uint chip_flags)
> +{
> +	struct geni_i2c_priv *geni = dev_get_priv(dev);
> +	u32 m_param = (chip_addr << SLV_ADDR_SHFT) & SLV_ADDR_MSK;
> +	u32 status;
> +	ulong start;
> +
> +	(void)chip_flags;
> +
> +	/* Add delay before chip detect to prevent the bus going undefined. */
> +	mdelay(1);
> +
> +	qcom_geni_i2c_conf(geni);
> +	writel(0, geni->base + SE_I2C_TX_TRANS_LEN);
> +	geni_i2c_setup_m_cmd(geni, I2C_ADDR_ONLY, m_param);
> +	writel(1, geni->base + SE_GENI_TX_WATERMARK_REG);
> +
> +	start = get_timer(0);
> +	while (get_timer(start) < I2C_TIMEOUT_MS) {
> +		status = readl(geni->base + SE_GENI_M_IRQ_STATUS);
> +		if (status & M_CMD_DONE_EN) {
> +			writel(status, geni->base + SE_GENI_M_IRQ_CLEAR);
> +			return (status & SE_I2C_ERR) ? -ENODEV : 0;
> +		}
> +		udelay(10);
> +	}
> +
> +	return -ETIMEDOUT;
> +}
> +
>   static int geni_i2c_xfer(struct udevice *bus, struct i2c_msg msgs[], int num)
>   {
>   	struct geni_i2c_priv *geni = dev_get_priv(bus);
> @@ -468,6 +517,8 @@ static int geni_i2c_probe(struct udevice *dev)
>   	ofnode parent_node = ofnode_get_parent(dev_ofnode(dev));
>   	struct geni_i2c_priv *geni = dev_get_priv(dev);
>   	u32 proto, tx_depth, fifo_disable;
> +	u32 clk_freq;
> +	bool use_32mhz;
>   	int ret;
>   
>   	geni->is_master_hub = dev_get_driver_data(dev) & GENI_I2C_IS_MASTER_HUB;
> @@ -538,19 +589,24 @@ static int geni_i2c_probe(struct udevice *dev)
>   	geni_i2c_config_packing(geni, BITS_PER_BYTE,
>   				PACKING_BYTES_PW, true, true, true);
>   
> -	/* Setup for standard rate */
> -	return geni_i2c_clk_map_idx(geni, I2C_SPEED_STANDARD_RATE);
> +	clk_freq = dev_read_u32_default(dev, "clock-frequency",
> +					I2C_SPEED_STANDARD_RATE);
> +	use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");

Hmm.. this property is not defined in linux code... do you plan to push this
to linux?

It seems to me, this is not needed in the linux driver at all!


Could you check, if you can adapt geni_i2c_clk_map_idx() to the one from linux?

They get the current clock from geni_se_clk_freq_match(). Is it possible to
port this to u-boot?

Thanks!

> +
> +	return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
>   }
>   
>   static int geni_i2c_set_bus_speed(struct udevice *dev, unsigned int clk_freq)
>   {
>   	struct geni_i2c_priv *geni = dev_get_priv(dev);
> +	bool use_32mhz = dev_read_bool(dev, "qcom,geni-se-clk-32mhz");
>   
> -	return geni_i2c_clk_map_idx(geni, clk_freq);
> +	return geni_i2c_clk_map_idx(geni, clk_freq, use_32mhz);
>   }
>   
>   static const struct dm_i2c_ops geni_i2c_ops = {
>   	.xfer		= geni_i2c_xfer,
> +	.probe_chip	= geni_i2c_probe_chip,
>   	.set_bus_speed	= geni_i2c_set_bus_speed,
>   };
>   
> 

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
