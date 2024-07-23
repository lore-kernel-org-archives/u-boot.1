Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20A97C3DA63
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 20:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 651CD87876;
	Tue, 23 Jul 2024 22:43:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mail.de header.i=@mail.de header.b="VQ5Odtza";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BF80A87D8C; Tue, 23 Jul 2024 22:43:10 +0200 (CEST)
Received: from shout02.mail.de (shout02.mail.de [IPv6:2001:868:100:600::217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3A6886E1B
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 22:43:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=seb-dev@mail.de
Received: from postfix03.mail.de (postfix03.bt.mail.de [10.0.121.127])
 by shout02.mail.de (Postfix) with ESMTP id 3B0F7241003;
 Tue, 23 Jul 2024 22:43:06 +0200 (CEST)
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
 by postfix03.mail.de (Postfix) with ESMTP id 1AF08801A9;
 Tue, 23 Jul 2024 22:43:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
 s=mailde202009; t=1721767386;
 bh=WUmWfMLxH3czyUUQjlD53Oo3ow1K5ftOu1qO+k8Zmqw=;
 h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
 b=VQ5OdtzaAWhyIpvUB5C9ZbCu9c7CV9PHrKqY8bAaYN9fuUTQK5zKBRUY8ig7piUtg
 YQ3Uw3804te6Pggj3pG1A50WPTlibibr+mBORyPEQ2TpUsq4AnIrdHz6H90wSOL8zV
 oaCcrnYuDqUXbyM1TiveA2ACJFJpGFsBUhRBcJapA7MPB9qvk4nw04CSd2SQyu0Jcn
 SPkhm/LMFbH7Dbfak6rJUIEBaMIPLeqLb/7s/WiXr0/fFYgP1EjWU0jIuNrOwwooHF
 b2Fz+2gtsQ5c2x5RcM68LovUS8MPkY3MCH6aboH2QJG7k+s+GaJHSd4fSswXgkl3px
 YNU/AwJ/3lIaQ==
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp01.mail.de (Postfix) with ESMTPSA id 324E7240DBF;
 Tue, 23 Jul 2024 22:43:03 +0200 (CEST)
Message-ID: <aef94fef-c256-4a44-ad32-d534e7ee0f76@mail.de>
Date: Tue, 23 Jul 2024 22:43:00 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/5] phy: rockchip: naneng-combphy: Introduce PHY-IDs
 to fix RK3588 muxing
To: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <cover.1721161722.git.seb-dev@mail.de>
 <ed6198ccb2635f0e950e3c21fa8898216bf949fa.1721161722.git.seb-dev@mail.de>
 <7fd8f4e2-1661-43d5-b753-94549351dbf8@kwiboo.se>
From: Sebastian Kropatsch <seb-dev@mail.de>
In-Reply-To: <7fd8f4e2-1661-43d5-b753-94549351dbf8@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for
 further information)
X-purgate: clean
X-purgate-size: 5235
X-purgate-ID: 154282::1721767385-0EE221F9-7B01E1BE/0/0
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

Hi Jonas,

Am 21.07.2024 um 20:40 schrieb Jonas Karlman:
> Hi Sebastian,
> 
> On 2024-07-16 22:42, Sebastian Kropatsch wrote:
>> Fix multiplex configuration for PCIe1L0 and PCIe1L1 in PCIESEL_CON for
>> RK3588 to correctly select between Combo PHYs and PCIe3 PHY.
>> Currently, the code incorrectly muxes both ports to Combo PHYs,
>> interfering with PCIe3 PHY settings.
>> Introduce PHY identifiers to identify the correct Combo PHY and set
>> the necessary bits accordingly.
>>
>> This fix is adapted from the upstream Linux commit by Sebastian Reichel:
>> d16d4002fea6 ("phy: rockchip: naneng-combphy: Fix mux on rk3588")
>>
>> Fixes: b37260bca1aa ("phy: rockchip: naneng-combphy: Use signal from comb PHY on RK3588")
>> Signed-off-by: Sebastian Kropatsch <seb-dev@mail.de>
>> ---
>>   .../rockchip/phy-rockchip-naneng-combphy.c    | 49 ++++++++++++++++++-
>>   1 file changed, 47 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>> index 1b85cbcce8..7d61913af1 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
>> @@ -67,12 +67,15 @@ struct rockchip_combphy_grfcfg {
>>   };
>>   
>>   struct rockchip_combphy_cfg {
>> +	unsigned int num_phys;
>> +	unsigned int phy_ids[3];
>>   	const struct rockchip_combphy_grfcfg *grfcfg;
>>   	int (*combphy_cfg)(struct rockchip_combphy_priv *priv);
>>   };
>>   
>>   struct rockchip_combphy_priv {
>>   	u32 mode;
>> +	int id;
>>   	void __iomem *mmio;
>>   	struct udevice *dev;
>>   	struct regmap *pipe_grf;
>> @@ -270,6 +273,8 @@ static int rockchip_combphy_probe(struct udevice *udev)
>>   {
>>   	struct rockchip_combphy_priv *priv = dev_get_priv(udev);
>>   	const struct rockchip_combphy_cfg *phy_cfg;
>> +	fdt_addr_t addr;
>> +	int id;
>>   
>>   	priv->mmio = (void __iomem *)dev_read_addr(udev);
>>   	if (IS_ERR(priv->mmio))
>> @@ -281,6 +286,26 @@ static int rockchip_combphy_probe(struct udevice *udev)
>>   		return -EINVAL;
>>   	}
>>   
>> +	addr = dev_read_addr(udev);
> 
> dev_read_addr(udev) is already called above, maybe we can use the
> returned value from that call?

Yes that is true. While priv->mmio seems to be the base address of the
memory-mapped I/O region for the device, it seems to be more complex
than being simply of type fdt_addr_t. To my non-expert eye it seems
more error-prone, more unclear and less future-proof (what if __iomem
changes somehow?). Please correct me if I'm wrong.
I tried to keep it very close to the Linux implementation to make future
changes/imports from the Linux driver as easy as possible.

We could use the 'addr' variable in the priv->mmio definition though.

> Or this could be changes to match other reg value matching done in other
> rockchip phy drivers, e.g. something like:
> 
> 	ret = ofnode_read_u32_index(dev_ofnode(udev), "reg", 0, &reg);
> 	if (ret) {
> 		dev_err(udev, "failed to read reg[0] property\n");
> 		return ret;
> 	}
> 	if (reg == 0 && dev_read_addr_cells(udev) == 2) {
> 		ret = ofnode_read_u32_index(dev_ofnode(udev), "reg", 1, &reg);
> 		if (ret) {
> 			dev_err(udev, "failed to read reg[1] property\n");
> 			return ret;
> 		}
> 	}

This solution looks more complex to me. What would the advantage
of this solution be?

>> +	if (addr == FDT_ADDR_T_NONE) {
>> +		dev_err(udev, "No valid device address found\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Find the phy-id based on the device's I/O-address */
>> +	priv->id = -ENODEV;
>> +	for (id = 0; id < phy_cfg->num_phys; id++) {
>> +		if (addr == phy_cfg->phy_ids[id]) {
>> +			priv->id = id;
>> +			break;
>> +		}
>> +	}
>> +
>> +	if (priv->id == -ENODEV) {
>> +		dev_err(udev, "Failed to find PHY ID\n");
>> +		return -ENODEV;
>> +	}
>> +
>>   	priv->dev = udev;
>>   	priv->mode = PHY_TYPE_SATA;
>>   	priv->cfg = phy_cfg;
>> @@ -421,6 +446,12 @@ static const struct rockchip_combphy_grfcfg rk3568_combphy_grfcfgs = {
>>   };
>>   
>>   static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
>> +	.num_phys = 3,
>> +	.phy_ids = {
>> +		0xfe820000,
>> +		0xfe830000,
>> +		0xfe840000,
>> +	},
>>   	.grfcfg		= &rk3568_combphy_grfcfgs,
>>   	.combphy_cfg	= rk3568_combphy_cfg,
>>   };
>> @@ -436,8 +467,16 @@ static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
>>   		param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
>>   		param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
>>   		param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
>> -		param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
>> -		param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
>> +		switch (priv->id) {
>> +		case 1:
>> +			printf("rk3588_combphy_cfg: priv->id was configured to 1");
> 
> Please drop printf calls.
> 
>> +			param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
>> +			break;
>> +		case 2:
>> +			printf("rk3588_combphy_cfg: priv->id was configured to 2");
> 
> Please drop printf calls.

Yes, these are forgotten from debugging and shouldn't be there.

Cheers,
Sebastian
