Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 089F7CCA462
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 08:56:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A477C8140A;
	Fri, 16 Oct 2026 08:56:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Y4m8ao8VWh0V; Fri, 16 Oct 2026 08:56:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org A9D94813F9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792140974;
	b=dKhRUYPzAayK7jin0QLGHsAuWlOp+3FiNTnH3MRUsQTZNOUnISWuhdzZ+VaUaPtlP2I/
	 GAo1iiHq+cOxdgkRF6L7ku64wba45CN3EFtodBSMjM02B7ssIs9comc/rKW+CwApKR5K3
	 alu9uLEGcHTYoy4lLNSWVYlJxJKrrOBWGJNSKbshPlyhSI7wZ7QCUI+KxXa8KUWkCcJGh
	 FceZYqBDMyEs51ZwKmx0iYBLc+dSJn1epvmq9R3vEv3ONW2cTzRvNqsLjf6BX/0zZI292
	 /24E+tkLymAtmaeoH0k/m2JODa6QlVDVr6ztYFQa/8IwtnkpvNDskzj5IsgzR7Aoelg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792140974;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Infomaniak-Routing:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=0TBgCbl69s8HHEVl8bQpe/eiPXMFO/cBrXy/ZGqDM2Q=;
	b=rfDH/i9rCZldRDqMHDHYh/E2imFYggRgnQbGSI3txTbxS2fcumSI7Fzf9sPJn14IPeAt
	 /36g1Kelv35N4BV3rbjE66z0DfoCRKYBQwhTObPZCkBQP+b8cYnqNeqQODYPd6Sqk3WhC
	 Ew+6IzJpRa1QeyMrkIev7utyYOgq4W2D1e8VCuWoCZ/LNdPjx0+Lc0tWrg5moYjZGmD+s
	 10sfP496LNpkmIdK0OeiqKC+edfDRIS2OmufRJ0bh+CWk+PvXu3sKXoGC4ovbNAuRqz7R
	 h2an/C1WKVfxprCyeagpen2X8079xP5A4i2on+x5WmTt5Veskce/2Rd7tGXlOk4OS4Q==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=UAaAr58n;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792140974;
	bh=0TBgCbl69s8HHEVl8bQpe/eiPXMFO/cBrXy/ZGqDM2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bZPeFFikJpBhe9yVKidS/e7s/7l8QEH8zIm+wHKO6VEf/B+y1BSpo8Upi6AniXjYi
	 n62LAa8vrzAOInMJ1Nu7HnV/rIrGP7s7A4LiT4wP83NNf6f4rN60qqmB0yJxnl+ItX
	 yxRHH2QL2HXUQtrWJRzMr4uQSsy+Ov9VtNUcxEfTOn5HAn9pWoD5uGkAE63yv+sTEC
	 y4oOesT1tLPj7/xREDCu6HexaJCxkxp+jVJ4dtPmV/l7WY7TldyUWcirwcjqVo6Zgt
	 KSBj4FcvsbYdv2ZB49EgLT2Zu0g3/3U+u2+I+VCszGMp8LUqKWCKhuEgWOnei6f7xW
	 5J8oZyhBCRobQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A9D94813F9;
	Fri, 16 Oct 2026 08:56:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5926C1AB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:56:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3F317813F9
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:56:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Iy3jvHdrxZV5 for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 08:56:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org D7435812B1
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:b8b8::190b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792140972;
 b=mAfj7XqJE1Rm+l2TkViSzEuccsTMYcgqn7kOFMvdH5aW0Tn7MvjaheDecAxPvc8Q+tsa
 txqhhIpf9kREu9Nr8Cl6Yg9xuM3y5WQajqoj5hGKq3qZ2Hl0M7v9eqf3OQuTv/oaFTy6h
 QfqD0YOv7vzKEj0nLNPU7DHKJENfPnr1kcBkzopFbEpOMAnzmJLuLnvjsl4LNNhr/J+tc
 gZ3uSSrocNFO97skaGzfHnWK73kbcrXvAa/gG367+LbBLZi7h2zs3NoovgLL2ntlzuP6U
 d6Rails51/wQ11DezkVbQRgzSV/dCX3nD0FuH5HgbgACZ6xPzn+1b64hSe5YAgTUKhw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792140972;
 h=Received-SPF:Received:DKIM-Signature:Received:Message-ID:Date:
 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Infomaniak-Routing;
 bh=0TBgCbl69s8HHEVl8bQpe/eiPXMFO/cBrXy/ZGqDM2Q=;
 b=rzAMGeBywmehc2uAWg2S5g8GE4B67ee3n4nOs0UGPMQDB9DxZKJL3J9inYLPVjYrdc0a
 QBKQg2nNU8ktNU6tNNW5QpK2jWrxJb+smQUujcUwH0EIGoJJObjgExpj7uarBb5O6pKRD
 gS1YxtO7CvrebmKQ96dKWrwXC/mKW1fPxUCQGSSaLiX/pm949uQ2KT7QV7h0CjShMEFpk
 xLxmflH/9a8TNSg9s86sN/yS4BcZF2KL6OEr3jhL3e9iomBnnTRgbzRrj3VlzRzuX13g5
 +Y2qSbPlYzfexiwl8QQYPxk5Osa6L0/tbpWO+YOvmco7gTxScUJdKf0w14kNweKxXkw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=0leil.net;
 dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256
 header.s=20231125 header.b=UAaAr58n; 
 arc=none smtp.remote-ip="2001:1600:19:b8b8::190b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:b8b8::190b; helo=smtp-190b.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=UAaAr58n
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::190b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D7435812B1
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 08:56:10 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4j5f1M3cqGzgRL;
 Fri, 16 Oct 2026 10:56:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1792140967;
 bh=0TBgCbl69s8HHEVl8bQpe/eiPXMFO/cBrXy/ZGqDM2Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UAaAr58nnd00Jq7hp0bxWGEHprgJxuGl59kBFuRIl2GYypbTkZuukjDRwZ7+FO//v
 D5YrI/tSoWO0v58AUzQJbhLn2Sc7brW1yw6eAkBJ/Eca3BrcWp2gPza6m9VyuywMXB
 /RpCFyyGZzbuJgUZsPo2bB6P98KsjKlGud/ByDghELV4bE2soJ5Wbs479gZ0lmukBh
 DCi3V6razuCgF+0cQtcXXEMMO1Z+eLvFnOCoMjU2iM2JYq50gg//p0EBaM5mbgV18k
 4IUWP+YsTCjiPlYnVoL6yZY1j3YcYimF8gEpZgxV39qr/pNUKOGc0K3GbARsY5iPLk
 JTJUZY5wO2kBA==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4j5f1K6W4YzQQ9; Fri, 16 Oct 2026 10:56:05 +0200 (CEST)
Message-ID: <62137c50-424d-43f9-a29b-67b8f9accdf4@0leil.net>
Date: Fri, 16 Oct 2026 10:56:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/30] sysreset: rockchip: Add rockchip_sysreset_bind()
 helper
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Simon Glass <sjg@chromium.org>,
 Massimo Pegorer <massimo.pegorer+oss@gmail.com>
Cc: u-boot@lists.u-boot-project.org
References: <20260805174509.2968252-1-jonas@kwiboo.se>
 <20260805174509.2968252-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <u-boot@0leil.net>
In-Reply-To: <20260805174509.2968252-2-jonas@kwiboo.se>
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

Hi Jonas, Massimo,

On 8/5/26 7:44 PM, Jonas Karlman wrote:
> The sysreset_rockchip driver uses the rockchip_get_cru() helper to get
> the CRU base address. However, use of this helper adds unnecessary
> abstractions and limits the driver to only work for a single SoC.
> 
> Add a rockchip_sysreset_bind() helper intended to be used in clock
> drivers. This helper expects the CRU base address and the offset to the
> global reset state register as parameters in addition to the offset to
> the first and second global software reset register.
> 
> The helper wraps similar handling as existing clock drivers, and will
> be extended to make use of the CRU base address and state register
> offset after all clock drivers have been converted to use this helper.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   arch/arm/include/asm/arch-rockchip/clock.h | 15 +++++++++++
>   drivers/sysreset/sysreset_rockchip.c       | 31 ++++++++++++++++++++--
>   2 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/include/asm/arch-rockchip/clock.h b/arch/arm/include/asm/arch-rockchip/clock.h
> index cf8bb0f04636..1b12867b489b 100644
> --- a/arch/arm/include/asm/arch-rockchip/clock.h
> +++ b/arch/arm/include/asm/arch-rockchip/clock.h
> @@ -186,6 +186,21 @@ void rk3288_clk_configure_cpu(struct rockchip_cru *cru, struct rk3288_grf *grf);
>   
>   int rockchip_get_clk(struct udevice **devp);
>   
> +/*
> + * rockchip_sysreset_bind() - Bind system reset device as child of clock device
> + *
> + * @pdev: clock udevice
> + * @cru_base: base address of the clock/reset unit registers
> + * @glb_rst_st: offset of the global reset state register
> + * @glb_srst_fst: offset of the first global software reset register
> + * @glb_srst_snd: offset of the second global software reset register
> + * Return: 0 success, or error value
> + */
> +int rockchip_sysreset_bind(struct udevice *pdev,
> +			   unsigned long cru_base,
> +			   unsigned int glb_rst_st,
> +			   unsigned int glb_srst_fst,
> +			   unsigned int glb_srst_snd);
>   /*
>    * rockchip_reset_bind() - Bind soft reset device as child of clock device
>    *
> diff --git a/drivers/sysreset/sysreset_rockchip.c b/drivers/sysreset/sysreset_rockchip.c
> index 00308f9a33b7..39cb16ec5456 100644
> --- a/drivers/sysreset/sysreset_rockchip.c
> +++ b/drivers/sysreset/sysreset_rockchip.c
> @@ -4,10 +4,11 @@
>    */
>   
>   #include <dm.h>
> -#include <errno.h>
> +#include <dm/device-internal.h>
> +#include <dm/lists.h>
> +#include <stdlib.h>
>   #include <sysreset.h>
>   #include <asm/arch-rockchip/clock.h>
> -#include <asm/arch-rockchip/cru_rk3328.h>
>   #include <asm/arch-rockchip/hardware.h>
>   #include <linux/err.h>
>   
> @@ -42,3 +43,29 @@ U_BOOT_DRIVER(sysreset_rockchip) = {
>   	.id	= UCLASS_SYSRESET,
>   	.ops	= &rockchip_sysreset,
>   };
> +
> +int rockchip_sysreset_bind(struct udevice *pdev,
> +			   unsigned long cru_base,
> +			   unsigned int glb_rst_st,
> +			   unsigned int glb_srst_fst,
> +			   unsigned int glb_srst_snd)
> +{
> +	struct udevice *sysreset_dev;
> +	struct sysreset_reg *priv;
> +	int ret;
> +
> +	ret = device_bind_driver(pdev, "rockchip_sysreset", "sysreset",
> +				 &sysreset_dev);
> +	if (ret)
> +		return ret;
> +
> +	priv = malloc(sizeof(struct sysreset_reg));
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->glb_srst_fst_value = glb_srst_fst;
> +	priv->glb_srst_snd_value = glb_srst_snd;
> +	dev_set_priv(sysreset_dev, priv);
> +

I think you went the right way but stopped half-way through. Look at 
what we've already done for the rockchip_reset driver 
(drivers/reset/reset-rockchip.c, bound when rockchip_reset_bind() is 
called from drivers/clk/rockchip/clk_px30.c for example).

Here the very important part I believe we should be using is 
device_bind_driver_to_node() on the dev_ofnode(pdev). This means that 
the driver's parent is the clock driver, but its node is the same as the 
clock driver. This means you have easy access to the base register 
address by simply calling dev_read_addr_ptr() on the sysreset's udevice 
and you can handle different logic by checking the compatible, without 
accessing the parent udevice for that.

Now, the issue is that the register offsets (and later on, bit fields 
for the reset cause) aren't stable across all SoCs. Since the driver is 
bound to a node, we can simply manually call the same functions from the 
core that figure out which compatible was used to probe a device (the 
one used for the CRU driver) and then use its .data field to get ops() 
for a specific SoC.

Essentially:
- call device_bind_driver_to_node() with rockchip_sysreset on the node 
of CRU device,
- in rockchip_sysreset->probe, set the cru_base address with 
dev_read_addr_ptr(),
- define an array of struct udevice_id with the supported compatibles, 
and .data set to the appropriate struct which contains necessary 
information for the driver to work on that SoC, so possibly register 
offsets (hardcoded offsets are fine here), function pointers if it's 
more complicated, etc. Most notably, this should NOT be added to the 
sysreset_rockchip U_BOOT_DRIVER's of_match pointer, as I believe two 
drivers cannot try to match against the same compatible otherwise we'll 
have issues, (this of course needs to be properly documented as having 
been made on purpose),
- in rockchip_sysreset->probe, figure out the proper compatible by 
reimplementing the beginning of lists_bind_fdt() until 
device_bind_with_driver_data(), then extract the .data and call that 
whenever needed. I would avoid storing the .data part in the udevice_id 
array of the CRU driver as while it'll work by accessing the CRU's 
.data, it doesn't really make sense to store sysreset data in the CRU 
driver.

For space constraints, we can always have a slew of #ifdef to make sure 
we only compile the code for an SoC that is supported (but we can have 
them all on for your dream of a single U-Boot proper binary).

I think what we're trying to reimplement here is the Linux MFD 
subsystem, which we currently don't have in U-Boot as far as I know. I'm 
well aware that device_bind_driver_to_node() is supposed to only be 
called for nodes without a compatible property (which isn't our case), 
but we already use this mechanism for the rockchip_reset driver, so I 
guess it's fine to use it again for rockchip_sysreset driver.

What do you think?

If that works, I think we should think about modifying the 
rockchip_reset binding logic to use the same as described above once 
we're done with rockchip_sysreset. More explicit and easier to follow IMO.

Cheers,
Quentin
