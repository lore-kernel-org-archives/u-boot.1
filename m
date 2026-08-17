Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0696C5B572
	for <u-boot@archiver.kernel.org>; Mon, 17 Aug 2026 04:01:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42600404F2;
	Mon, 17 Aug 2026 04:01:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0w7nYGDRbqmX; Mon, 17 Aug 2026 04:01:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 81FC0404C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786939293;
	bh=1EoR3mSUO10eSFSMw989D0c9SrnId5x0x41YO0SJGNk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P6/DFkdGANks7Kgdoxrpzu7jgXBp86W9ywwEt45u6dPY+2Aopymh6YkP/R1fa2YM1
	 asPL2VtzDL7eCkqv2w5cc6cVXBGSq1z/Q/jF2m0ASEcWJV4FehZ+gG+0TSvLKfL5AD
	 z+7t8MaQ/JPYv/2HE4kk3X1bb0ZFSaSNS2XXnQDZZQgdXx2ox3Q/tDGDHiAGj7bScT
	 YHSHrhtdeCC8q799+1jKOAviEdoNgBVMZzNskSfGL9Z19MeBlRFAfPsK/FKOgYHXrG
	 661HTR69uXIBE8gKFOsfSEEOP6MzLwDz84nUDVsxg3WpIv9m+TNUF6hMPNfvrDrA/7
	 Vxg0rHooMsT/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81FC0404C9;
	Mon, 17 Aug 2026 04:01:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D20F336
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 02:12:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3A98F40634
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 02:12:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xCp0VKqpx8WC for <u-boot@lists.u-boot-project.org>;
 Mon, 17 Aug 2026 02:12:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 822B940632
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 822B940632
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=J2ce5diK
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 822B940632
 for <u-boot@lists.u-boot-project.org>; Mon, 17 Aug 2026 02:12:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC97740163;
 Mon, 17 Aug 2026 02:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623471F000E9;
 Mon, 17 Aug 2026 02:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786932738;
 bh=1EoR3mSUO10eSFSMw989D0c9SrnId5x0x41YO0SJGNk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=J2ce5diKL97rRGoI5iR2EbycS4jdXzQPByS6uolC3ZnpPBagN6ko8heandoduHsFa
 py+gp4jHuwAukAGRdN+C4mwYEH6W2oA9l0XlRB8eGbhIkZxvIOQx7IrMUqNkVL/xee
 5GAhd8ud6rS3JozAdNmKG1IcHsWKmbw5nmHxOGkFelf/z5EpjWlT5CDzkOGzxNdzCJ
 yYJ/PPw3OMACbb/MSDAB9baxPW5seKKNYsp9eyowYgykSqKIuEbjNmzazRYyhzDob7
 vGwbBYdobXwfrAKUX4vHOVLfFNxc1MNpoG4zxmUxzbajXUoK6n7rKMISJbMpEo9N2g
 6QlUzDZl7ABJg==
Date: Mon, 17 Aug 2026 02:12:16 +0000
From: Yixun Lan <dlan@kernel.org>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>
Subject: Re: [PATCH v8 02/11] pinctrl: k1: fix drive strength configuration
Message-ID: <20260817021216-GKB566872@kernel.org>
References: <20260802-m4-v8-0-e916643205f3@riscstar.com>
 <20260802-m4-v8-2-e916643205f3@riscstar.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260802-m4-v8-2-e916643205f3@riscstar.com>
X-Mailman-Approved-At: Mon, 17 Aug 2026 04:01:30 +0000
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 00:40 Sun 02 Aug     , Eric Chung wrote:
> Fix drive strength configuration by:
> - Using FIELD_PREP() to properly set the PAD_DRIVE mask bits
> - Not overriding io_type with IO_TYPE_EXTERNAL for external pins
> - Returning the pin number instead of 0 from pinmux_property_set
> - Removing redundant zero-initialization of the mask variable
> 
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> 
Checked this patch, the logic looks ok to me (only few minor comments),
And you can still add my R-B, thanks

Reviewed-by: Yixun Lan <dlan@kenrel.org>

> ---
> v6:
> - Fix drive strength configuration.
> ---
>  drivers/pinctrl/spacemit/pinctrl-k1.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pinctrl/spacemit/pinctrl-k1.c b/drivers/pinctrl/spacemit/pinctrl-k1.c
> index a6a22eacac7b..6ed511879daf 100644
> --- a/drivers/pinctrl/spacemit/pinctrl-k1.c
> +++ b/drivers/pinctrl/spacemit/pinctrl-k1.c
> @@ -9,6 +9,7 @@
>  #include <dm/device_compat.h>
>  #include <dm/pinctrl.h>
>  #include <dm/read.h>
> +#include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/errno.h>
>  #include <linux/io.h>
> @@ -386,10 +387,12 @@ static int spacemit_pinmux_set(struct udevice *dev, unsigned int pin,
>  static int spacemit_pinmux_property_set(struct udevice *dev, u32 pinmux_group)
>  {
>  	u32 pin, mux;
> +	int ret;
>  
>  	pin = spacemit_dt_get_pin(pinmux_group);
>  	mux = spacemit_dt_get_pin_mux(pinmux_group);
> -	return spacemit_pinmux_set(dev, pin, mux);
> +	ret = spacemit_pinmux_set(dev, pin, mux);
..
> +	return ret ? ret : pin;
I'd prefer doing as below, which would more explicitly tell that's an error handler
	if (ret < 0)
		return ret;
	
	return pin;

>  }
>  
>  static const struct pinconf_param spacemit_pinconf_params[] = {
> @@ -406,7 +409,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  	struct spacemit_pinctrl_data *data;
>  	struct spacemit_pinctrl_priv *priv = dev_get_priv(dev);
>  	void __iomem *addr;
> -	u32 mask = 0;
> +	u32 mask;
This isn't a necessary change, which doesn't alter any logic or fix anything,
and more worse, the follow-up patch drop line of this variable

I mean bringing in unrelated change only increase the review burden..

>  	unsigned int io_type;
>  	u8 ds;
>  	bool found;
> @@ -433,7 +436,8 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  		for (i = 0; i < priv->nr_io_pins; i++) {
>  			if (priv->io_pins[i].pin != pin_selector)
>  				continue;
> -			io_type = priv->io_pins[i].io_type;
> +			if (priv->io_pins[i].io_type != IO_TYPE_EXTERNAL)
> +				io_type = priv->io_pins[i].io_type;
>  			break;
>  		}
>  		if (io_type != IO_TYPE_3V3 && io_type != IO_TYPE_1V8) {
> @@ -441,7 +445,7 @@ static int spacemit_pinconf_set(struct udevice *dev, unsigned int pin_selector,
>  			return -EINVAL;
>  		}
>  		ds = spacemit_get_drive_strength(io_type, argument);
> -		clrsetbits_le32(addr, PAD_DRIVE, ds);
> +		clrsetbits_le32(addr, PAD_DRIVE, FIELD_PREP(PAD_DRIVE, ds));
>  		break;
>  	case PIN_CONFIG_POWER_SOURCE:
>  		for (i = 0, found = false; i < priv->nr_io_pins; i++) {
> 
> -- 
> 2.51.0
> 

-- 
Yixun Lan (dlan)
