Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0204AC4345F
	for <u-boot@archiver.kernel.org>; Thu, 25 Apr 2024 08:44:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5012B88F16;
	Thu, 25 Apr 2024 10:44:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; secure) header.d=xff.cz header.i=@xff.cz header.b="eBiSuj1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 37E3588F1A; Thu, 25 Apr 2024 10:44:36 +0200 (CEST)
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 25B4188F16
 for <u-boot@lists.denx.de>; Thu, 25 Apr 2024 10:44:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=megi@xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
 t=1714034672; bh=tGGA0zqEMXy0YhxWhGZVMKwfBM5iLJW7NPsgV3JbQ94=;
 h=Date:From:To:Subject:X-My-GPG-KeyId:References:From;
 b=eBiSuj1ZtWtddQiw0nhlDZOcV7id7azzgB6kys6lRbpwQzVONyig9l2KtBxsy3pzV
 4ntbnIaEE0c0flUowffgbUsN3YxLxNXzURRIMtOUPRaUkrVWTiSrbsNW48kW2YBk/n
 ac7biEmiqDCfzRuWegIL18wmFaEfxEzqGxRfMGb8=
Date: Thu, 25 Apr 2024 10:44:32 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, 
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Igor Prusov <ivprusov@sberdevices.ru>
Subject: Re: [PATCH] clk: zynq: Fix EMIO clock use detection for gem0
Message-ID: <ccgd4qq74wiccuzkelcbdsjayvanpi5b7bukayj7dgx3ejyh7o@ro3y7bchnvx5>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
 Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Igor Prusov <ivprusov@sberdevices.ru>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240416084456.2821567-1-megi@xff.cz>
 <ca63cfb0-5e5f-4522-8cda-87dec22588c9@amd.com>
 <5gv2fqik5vtygldqmv23tpcsyaftazblm4atk3igweduivmiqu@aeoflxwzlvx3>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5gv2fqik5vtygldqmv23tpcsyaftazblm4atk3igweduivmiqu@aeoflxwzlvx3>
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

On Thu, Apr 25, 2024 at 10:23:42AM GMT, megi xff wrote:
> On Wed, Apr 24, 2024 at 04:34:05PM GMT, Michal Simek wrote:
> > 
> > 
> > On 4/16/24 10:44, Ondřej Jirman wrote:
> > > From: Ondrej Jirman <megi@xff.cz>
> > > 
> > > According to TRM, the bit that differentiates between MIO and EMIO
> > > clocks is bit 6. This resolves failure to set clock when using EMIO
> > > clock for ethernet.
> > 
> > Not sure which TRM you are using but here
> > 
> > https://docs.amd.com/r/en-US/ug585-zynq-7000-SoC-TRM/Register-slcr-GEM0_RCLK_CTRL
> > 
> > SRCSEL it is bit 4 not bit 6.
> 
> Maybe TRM is wrong? :)
> 
> I have XSA produced by Vivado that has:
> 
> GEM0_RCLK_CTRL:
> 
>     EMIT_MASKWRITE(0XF8000138, 0x00000011U ,0x00000011U),
>     // .. CLKACT = 0x1
>     // .. ==> 0XF8000140[0:0] = 0x00000001U
>     // ..     ==> MASK : 0x00000001U    VAL : 0x00000001U
>     // .. SRCSEL = 0x4
>     // .. ==> 0XF8000140[6:4] = 0x00000004U
>     // ..     ==> MASK : 0x00000070U    VAL : 0x00000040U
>     // .. DIVISOR = 0x1
>     // .. ==> 0XF8000140[13:8] = 0x00000001U
>     // ..     ==> MASK : 0x00003F00U    VAL : 0x00000100U
>     // .. DIVISOR1 = 0x5
>     // .. ==> 0XF8000140[25:20] = 0x00000005U
>     // ..     ==> MASK : 0x03F00000U    VAL : 0x00500000U
>     // .. 

Eh, I take this back. :) Copied the wrong comment.

regards,
	o.

> https://megous.com/dl/tmp/20e2593dbe9e0b3b.png
> 
> GEM0_CLK_CTRL:
> 
>     EMIT_MASKWRITE(0XF8000140, 0x03F03F71U ,0x00500141U),
>     // .. CLKACT = 0x1
>     // .. ==> 0XF8000148[0:0] = 0x00000001U
>     // ..     ==> MASK : 0x00000001U    VAL : 0x00000001U
>     // .. SRCSEL = 0x0
>     // .. ==> 0XF8000148[5:4] = 0x00000000U
>     // ..     ==> MASK : 0x00000030U    VAL : 0x00000000U
>     // .. DIVISOR = 0x10
>     // .. ==> 0XF8000148[13:8] = 0x00000010U
>     // ..     ==> MASK : 0x00003F00U    VAL : 0x00001000U
>     // ..
> 
> https://megous.com/dl/tmp/65c6ee01818a06ea.png
> 
> So the PS init sequence in XSA suggests that GEM0_RCLK_CTRL layout
> actually matches the GEM0_CLK_CTRL documentation.
> 
> I guess Vivado is right and TRM is wrong, since HW works as expected
> with the PS configuration that doesn't match the TRM.
> 
> > > 
> > > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > > ---
> > >   drivers/clk/clk_zynq.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/clk/clk_zynq.c b/drivers/clk/clk_zynq.c
> > > index e3cefe2e0c72..78e6886a000c 100644
> > > --- a/drivers/clk/clk_zynq.c
> > > +++ b/drivers/clk/clk_zynq.c
> > > @@ -42,6 +42,8 @@
> > >   #define CLK_CTRL_DIV3X_SHIFT	20
> > >   #define CLK_CTRL_DIV3X_MASK	(ZYNQ_CLK_MAXDIV << CLK_CTRL_DIV3X_SHIFT)
> > > +#define CLK_CTRL_GEM_EMIO	(1u << 6)
> > > +
> > >   DECLARE_GLOBAL_DATA_PTR;
> > >   #ifndef CONFIG_SPL_BUILD
> > > @@ -161,7 +163,7 @@ static enum zynq_clk_rclk zynq_clk_get_gem_rclk(enum zynq_clk id)
> > >   	else
> > >   		clk_ctrl = readl(&slcr_base->gem1_rclk_ctrl);
> > > -	srcsel = (clk_ctrl & CLK_CTRL_SRCSEL_MASK) >> CLK_CTRL_SRCSEL_SHIFT;
> > > +	srcsel = (clk_ctrl & CLK_CTRL_GEM_EMIO);
> >
> > Definitely using SRCSEL_MASK is not ideal solution because mask is 0x3 and
> > in gem case it is single bit. But based on description you should be getting
> > correct values even with 0x3 because SHIFT is correct.
> 
> Well, it doesn't help that the code is almost all refering to CLK_CTRL while
> actually accessing gem1_rclk_ctrl in the struct.
> 
> In any case it can't detect the case when sourcing the clock from EMIO and
> not one of the PLLs, apparently.
> 
> The failure I'm talking about is here in zynq_gem.c:
> 
>         ret = clk_get_rate(&priv->tx_clk);
>         if (ret != clk_rate) {
>                 ret = clk_set_rate(&priv->tx_clk, clk_rate);
>                 if (IS_ERR_VALUE(ret)) {
>                         dev_err(dev, "failed to set tx clock rate %ld\n", clk_rate);
>                         return ret;
>                 }
>         }
> 
> And all I get is "failed to set tx clock rate" from U-Boot and no ethernet.
> 
> regards,
> 	o.
> 
> > Thanks,
> > Michal
