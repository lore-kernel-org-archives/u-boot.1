Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D431DCC6B38
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 11:18:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D550481467;
	Fri, 16 Oct 2026 11:18:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pzhmF4OAIstH; Fri, 16 Oct 2026 11:18:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 04D5981423
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792149497;
	b=W77ZtC/6vjB0ArNyyGPeOp9pxL5llI13x3bjPs5BkHxYyz4I7FHmgFrL2j1G3Rcf/leU
	 ApejNvkJXdGWFDRZkRZs7m9OFvRtEgzTnC6H2lOjbpqBUrDeYb7j6Bd4E71VfzhbRFv1x
	 Ge/Snr5gvAAfDqquzvx9EBl6p1h3PCSfHqaA8mzC8PXTqBV+R0+rYpSmKTAFPgkCJ05GY
	 nObAxVYLy2KuXuMDNutHMC0GIsMCWLu1W2DQL9vl50EqEQ8KGpvEti2Q37/LZUnlQU+Ef
	 AsSUff7K5MdyREn2JfH2N0V4pH14cYtbkVEW9zBBmn6X5Xj/LEml4y7X8KCqEZO4wMw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792149497;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vLSQClhaP3VzRyJfKwep1ckDCb99x+6nBtEFZaN/TdM=;
	b=eAcSFx5pFKdAlhjtT68QN+CcLx/iNUVQkqRniAwZZtNKEZFoYnzPp+m5k/To75uDRea7
	 R/AnWeF3A/Lxfl228FSSdaFhOwX7tysgRchP0ALeQ23NQ3IRzWWJcm7MzDj6IU93sFqCc
	 rU5pXNV5GiZe4Vf1Xjv6cULQpRe2L9TCeV0dfRpyzmjFluuBzCP9uHp7cr1cJTbS/mQwo
	 Bmd+p6fH0utwuPY8MzNiRhvk90yaQd6jKiHM7sjtTSm/Xb0wcOgTrXX39GKkXR0DBeWJO
	 lfYbmUzyzaHK4VCWGOqpAg5lwbKywe2M2UKGJxvh47wVSAcbry9kGIFE/ynTHzDVxKQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792149497;
	bh=vLSQClhaP3VzRyJfKwep1ckDCb99x+6nBtEFZaN/TdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fJ/31vkxzIx9KDwq1Psz6U2anijivIwJToYf0w3hYxRLYyQDW9+w/wvLTPhq0Kf+F
	 vFtqBs1kKCiQBliN7VhLCIhLuuPhevSz6FhneMK9tpIZpGqJEXkgMBArlEDWV73hmk
	 KrvHwV+LyyhO9fdG6XW8yyhhmxTqXX9DlWpbJnC4IK8UoEStyhKXwhsWqyzrUJYZw/
	 vY9k9taWlBnG+8R26VhA6t9LUBB7aU+wcvalBb8X43gd91VBtHCunb13mT1LXI55ul
	 rqL0DSHiDEeaajvHpkNJvmh0QyPXTBT2Q9TSydS6hhPCUeb+1avKecxpG1/vhvnG24
	 ALWTcpbkpwTYA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04D5981423;
	Fri, 16 Oct 2026 11:18:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id D198D2A8
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 11:18:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C3442409F6
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 11:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lD9ZGxVPIR-2 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 11:18:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 731DF409CE
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:d548::42ad"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792149495;
 b=Xmxs06wn+7nSUkkmgFY5V59T91k4G3XBRIfxUhyusjG85oxn5U4XtDLWe1PJgss6og/F
 4UgvzgkWRcMqKixnurHvPtbF+4u+LlqToSDmP8HR08/d2UaqRh7gEvxj6DaA0exOkE+9N
 /5ppBfEuD7iAphM3Z0tJljjj8oL6K/FH8jti5qM2/oPBTZ5UmAVXYl0B4O0RrFO2MM406
 R5kaAPh9gyvc8KZHGNKOzJphzc1Qj00pDo3Bhuf9oJRelhizLRW8aOhaskrbgD9K26IKB
 UoLUBbqmgImXKaeCIBRCyAZQsOCgWW5RmWMZwm7d5q/i5uk5CFTFj5014twUdQtKXtg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792149495;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=vLSQClhaP3VzRyJfKwep1ckDCb99x+6nBtEFZaN/TdM=;
 b=cU6nJAxcAPMaIMtN2qYGn4I04KSmuJFig7OU+cEns0e1gAYLAGiwyNzGp2WCGmKJ35l4
 1JO/JRddmy8C3wBQR1FFAwEF5k0mHHka8yn+oAr8O8WQlYBYGrglu/tM8ZR36SiMHtdVb
 i19Zm6t3zKLXsUchycPu4S1TT/HtbS9GcXa5IQzfLAfrhn3lKSnZOEdK5BR+TMPk6uV9U
 NrjmkYagkk9RZlWW8A2GQYGxaZaR5TMXuBGkfaH05z8+OxQDVtorkBptmUJNZ0MZf1I27
 h6B4jTRPw3hKYxeuonVAEMpeEuN/MxZY+2XA24mv0NLSn+EOyn74jX3lf+TcjCNQdIA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=e4pTt+QJ; 
 arc=none smtp.remote-ip="2001:1600:19:d548::42ad"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:d548::42ad; helo=smtp-42ad.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=e4pTt+QJ
Received: from smtp-42ad.mail.infomaniak.ch (smtp-42ad.mail.infomaniak.ch
 [IPv6:2001:1600:19:d548::42ad])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 731DF409CE
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 11:18:13 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch
 [10.7.10.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5j184cZjz7Xq;
 Fri, 16 Oct 2026 13:11:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1792149068;
 bh=vLSQClhaP3VzRyJfKwep1ckDCb99x+6nBtEFZaN/TdM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=e4pTt+QJRZ8RuLG+1Rb4aG+vJLJ9XWcInGyAaMizuNC5lORXrSwmiLEBs3dJAgEcZ
 jRT28Om/1jCuCahkwMJHqzkc5nGVDiIregNxqY2ByibV3ywmTIRb5Le17PtwBZWVni
 b2rTboe2AKJPApWIxk8uMKQPGjKtyZtO71lqMNhuTDa8R97i6p7X6BnefF/05i4ESz
 9eS10YU3MAJbFIJlndGKt0f44Tq6cs9twltNeDLJaYZnPevvluUUvLq2gRb2cfP7nk
 qqxPKmrxIoMUxrkT6HWK/NXSNHM02jmI+2IL3NCY74G/EuRQDCbY8GwbysckI38xDD
 sR+4LAmID9QUw==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j5j171WJ9zGjm; Fri, 16 Oct 2026 13:11:07 +0200 (CEST)
Message-ID: <71957510-7b09-4d52-a45a-76cba3d8675e@0leil.net>
Date: Fri, 16 Oct 2026 13:11:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rng: rockchip_rng: Enable clocks when reading data
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <20261004211349.62883-1-jonas@kwiboo.se>
 <20261004211349.62883-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20261004211349.62883-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Infomaniak-Routing: alpha
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

Hi Jonas,

On 10/4/26 11:13 PM, Jonas Karlman wrote:
> The vendor TF-A blobs for RK3562 leave the TRNG and RK RNG clocks gated
> when returning to U-Boot proper.
> 
> Try to enable clocks while reading or otherwise accessing TRNG/RKRNG
> regs to ensure random data can successfully be read on affected SoCs.
> 
> This is not expected to have any impact on SoCs using a clock driver
> with unimplemented enable/disable ops.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
[...]
> @@ -306,6 +308,10 @@ static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
>   	if (!pdata->soc_data || !pdata->soc_data->rk_rng_read)
>   		return -EINVAL;
>   
> +	ret = clk_enable_bulk(&pdata->clks);
> +	if (ret && ret != -ENOENT)

Because I was confused that clk_enable_bulk() could return -ENOENT, 
maybe add a comment stating this is to catch clock drivers that 
implement a .enable() callback and return -ENOENT for unsupported 
clocks? RK3399 and PX30 seem to be the only one doing that on Rockchip. 
Same comment for rockchip_rng_probe().

I'm also not entirely sure this is proper, shouldn't we rather implement 
support for the clocks instead of just saying "it's fine, don't worry"? 
I think only RK3399 would be impacted (as only RK3399 and PX30 clock 
drivers implement an .enable, and PX30 DTS doesn't have clocks 
specified), with missing support for HCLK_M_CRYPTO[01], 
HCLK_S_CRYPTO[01], and SCLK_CRYPTO[01].

While looking at it, I also saw that there are resets in the node, maybe 
something we'll need to control in the future too?

> +		return ret;
> +
>   	for (i = 0; i < len / RK_HW_RNG_MAX; i++, buf += RK_HW_RNG_MAX) {
>   		ret = pdata->soc_data->rk_rng_read(dev, buf, RK_HW_RNG_MAX);
>   		if (ret)
> @@ -317,6 +323,7 @@ static int rockchip_rng_read(struct udevice *dev, void *data, size_t len)
>   						   len % RK_HW_RNG_MAX);
>   
>   exit:
> +	clk_disable_bulk(&pdata->clks);
>   	return ret;
>   }
>   
> @@ -336,12 +343,22 @@ static int rockchip_rng_of_to_plat(struct udevice *dev)
>   static int rockchip_rng_probe(struct udevice *dev)
>   {
>   	struct rk_rng_plat *pdata = dev_get_priv(dev);
> -	int ret = 0;
> +	int ret;
> +
> +	ret = clk_get_bulk(dev, &pdata->clks);> +	if (ret && ret != -ENOENT && ret != -ENOSYS)

I think what you want is clk_bulk_get_optional() from the Linux kernel, 
so please implement that in U-Boot. We have it for reset, clk (not for 
bulk yet) and gpio, so this is the right way to go.

Cheers,
Quentin
