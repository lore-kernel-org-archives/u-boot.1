Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3F51C83F25
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 09:34:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA7328334D;
	Tue, 22 Jul 2025 11:34:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="WOsy/6Bd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8676483381; Tue, 22 Jul 2025 11:34:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A7283346
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=dd2a=2D=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1753176866;
 bh=HO5Tpc0GUw+fRcc61WfW58XpHoDRwSs/5vf0rj6bOZg=;
 b=WOsy/6BdZwgP3QC/VV+LHc8fI7xbRf6EkU53euuIOkLk70wQ7BMUHpk5rZplmvCJ5FncAG4QH
 n02VDk7B/uV1BwdFxbbr9acgO8FCDTVii/X8pOp7W9X0vi5xYfGxd225MD0s/pU3okMxDdlwArl
 9da14hoV6EPImWGFwfEh21VtOTwadxulyN7WCEM5P/G63D9gV/EWdOgG7trLtmGqgdeG08BWRcF
 yp/WnGBmuhZ1CrIYt8A7VnKMhtynZVDBqqYicGeCnzABrpLx83KSHrTKCO8r6rjkMeXXmoRMKPI
 swaM+KVB6/0f0+otmJO1oSmJcPwVpcuDti+8DvEwd/iA==
X-Forward-Email-ID: 687f5b1f3a34fab0dace9a38
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.1.6
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <1c37d473-d2c4-4a80-aa78-be19a68daebb@kwiboo.se>
Date: Tue, 22 Jul 2025 11:34:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: rockchip-inno-usb2: Fix Synchronous Abort on
 usb start
To: Alex Shumsky <alexthreed@gmail.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250703060517.3909695-1-alexthreed@gmail.com>
 <CAF4oh-NPW_nYdMoeh0y0wVK3e1c4gyroTvJUKh5tuXFNFvDOnw@mail.gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <CAF4oh-NPW_nYdMoeh0y0wVK3e1c4gyroTvJUKh5tuXFNFvDOnw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Alex,

On 7/3/2025 8:29 AM, Alex Shumsky wrote:
> Hi Jonas,
> 
> This time I had difficulties to reproduce Synchronous Abort on a real board, but
> then I spotted a difference with my previous tests.
> "usb start" abort happen when I boot upstream/current u-boot proper from
> SD-card by older SPL/TPL installed on eMMC (stock/proprietary u-boot from 2019
> installed by STB manufacturer).
> There is no Sync Abort with upstream SPL/TPL. Looks like NULL dereference are
> still there but some SPL/TPL init code prevents it from aborting.

Thanks for taking a closer look at this and use of different TPL, SPL
and/or TF-A versions is very likely the reasons why we initially had
different results (a sync abort vs none).

I only have one small remark on this,

> 
> On Thu, Jul 3, 2025 at 9:05 AM Alex Shumsky <alexthreed@gmail.com> wrote:
>>
>> Fix NULL pointer dereference that happen when rockchip-inno-usb2 clock
>> enabled before device probe. This early clock enable call happen in process
>> of parent clock activation added in ac30d90f3367.
>>
>> Fixes: 229218373c22 ("phy: rockchip-inno-usb2: Add support for clkout_ctl_phy").
>> Fixes: ac30d90f3367 ("clk: Ensure the parent clocks are enabled while reparenting")
>> Co-authored-by: Jonas Karlman <jonas@kwiboo.se>
>> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
>> ---
>>
>> Changes in v2:
>> - rework patch (add NULL check to code instead of dts modification)
>>
>>  drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 19 ++++++++++++++-----
>>  1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> index 88b33de1b2..3cc5956aed 100644
>> --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
>> @@ -167,20 +167,27 @@ static struct phy_ops rockchip_usb2phy_ops = {
>>         .of_xlate = rockchip_usb2phy_of_xlate,
>>  };
>>
>> -static void rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap **base,
>> -                                       const struct usb2phy_reg **clkout_ctl)
>> +static int rockchip_usb2phy_clkout_ctl(struct clk *clk, struct regmap **base,
>> +                                      const struct usb2phy_reg **clkout_ctl)
>>  {
>>         struct udevice *parent = dev_get_parent(clk->dev);
>>         struct rockchip_usb2phy *priv = dev_get_priv(parent);
>>         const struct rockchip_usb2phy_cfg *phy_cfg = priv->phy_cfg;
>>
>> -       if (priv->phy_cfg->clkout_ctl_phy.enable) {
>> +       // phy_cfg can be NULL if this function called before probe (when parent
>> +       // clocks are enabled)

Please use /* block comment style */ here, with that fixed this is:

Reviewed-by: Jonas Karlman <jonas@kwiboo.se>

Regards,
Jonas

>> +       if (!phy_cfg)
>> +               return -EINVAL;
>> +
>> +       if (phy_cfg->clkout_ctl_phy.enable) {
>>                 *base = priv->phy_base;
>>                 *clkout_ctl = &phy_cfg->clkout_ctl_phy;
>>         } else {
>>                 *base = priv->reg_base;
>>                 *clkout_ctl = &phy_cfg->clkout_ctl;
>>         }
>> +
>> +       return 0;
>>  }
>>
>>  /**
>> @@ -206,7 +213,8 @@ int rockchip_usb2phy_clk_enable(struct clk *clk)
>>         const struct usb2phy_reg *clkout_ctl;
>>         struct regmap *base;
>>
>> -       rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
>> +       if (rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl))
>> +               return -ENOSYS;
>>
>>         /* turn on 480m clk output if it is off */
>>         if (!property_enabled(base, clkout_ctl)) {
>> @@ -230,7 +238,8 @@ int rockchip_usb2phy_clk_disable(struct clk *clk)
>>         const struct usb2phy_reg *clkout_ctl;
>>         struct regmap *base;
>>
>> -       rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl);
>> +       if (rockchip_usb2phy_clkout_ctl(clk, &base, &clkout_ctl))
>> +               return -ENOSYS;
>>
>>         /* turn off 480m clk output */
>>         property_enable(base, clkout_ctl, false);
>> --
>> 2.43.0
>>
>> base-commit: 7027b445cc0bfb86204ecb1f1fe596f5895048d9
>> branch: fix-rk3328-usb2phy-clock-v2

