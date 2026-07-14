Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D0AC44508
	for <u-boot@archiver.kernel.org>; Tue, 14 Jul 2026 14:43:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2D4284AE6;
	Tue, 14 Jul 2026 16:43:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HzqAwl/g";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TZoR+/Y9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 203F684AE7; Tue, 14 Jul 2026 16:43:19 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5CBF84A12
 for <u-boot@lists.denx.de>; Tue, 14 Jul 2026 16:43:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4h029J3bHlzKw8S;
 Tue, 14 Jul 2026 16:43:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784040196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQmoffvFeGKWIS4Fi3SKS6WUetFUExzmQx0/ome+3nc=;
 b=HzqAwl/gaQSn+iJZ7PO9V72bXy3yAk11m2Dac2zQLGaUtSyM7Uu7WLL1e4iXY+mZm2kXfZ
 xaL4uIW7qQs36sH/zoCK+QPY7JbptInHdRnXxmrHGHtbk4uC88eRDNYZBhX7MrkgSlMXos
 OLX+eOaA1p0eTLEDGbdxD6FJrJWaycSH7YxI2rWejTnwd8FW9tOeO4med34h7XW38xQCAD
 bwIakS8hSeA0VULzitX18i70esr/rA+Vgo1Q3lQQK3rFT0IH/0I/lddX5EhJvzrswzTPj/
 elZAxyyvM0nDX1JBFLfwv/f1Qyds/doOhTI+mU8yVJcdesxlKyuJeD0rG80P2w==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b="TZoR+/Y9";
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <fa952b03-ecb6-4a08-92ea-79d6d4101f5e@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1784040195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qQmoffvFeGKWIS4Fi3SKS6WUetFUExzmQx0/ome+3nc=;
 b=TZoR+/Y9IrAxw9HsDQc/8U8J1J4xPjcNwlNIbtDpKF7QP7V3zgcXmLUTl9KgYIDcFPxjVN
 R912dSuKnmLXWcOF6opyvoenxd6o+Zh1Biw4ZPu7grAVx/EHZZT94e18oAXvS2UZsNK7lt
 wKwqWUhAG7Z8tF3HfJiM6KUygoWxUNdYHFTt3zqLJDrXCObM8cPmGH/+4upp2MNLO2+6UB
 619e0vyb/SHZpQK5HnDXmrah9IHfiIankgaz7ZyN1adzp3q3wgaBrpg1/0UfPcMcF3Qtw3
 gVAJYEKKgWwperoR6xnM78N61gXAlBEXmVm/zE6Z0L9PQCCkdEswrCwKEZ1LRg==
Date: Tue, 14 Jul 2026 16:43:10 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/10] usb: dwc3: generic: add board_usb_init/cleanup
 hooks
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Fabio Estevam <festevam@gmail.com>, Wang Jie <dave.wang@rock-chips.com>,
 Tom Rini <trini@konsulko.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>, Ye Li <ye.li@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Stefano Babic <sbabic@nabladev.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Balaji Selvanathan
 <balaji.selvanathan@oss.qualcomm.com>, Peng Fan <peng.fan@nxp.com>
References: <20260621-tcpci-dwc3-v2-0-990ecacc111c@nxp.com>
 <20260621-tcpci-dwc3-v2-7-990ecacc111c@nxp.com>
 <74b9d259-b180-4ca7-9cf6-1c93e175e1f4@mailbox.org>
 <alZB8CUrzBs1mTs8@shlinux89>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <alZB8CUrzBs1mTs8@shlinux89>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9e7f19ffc6d1e1a2672
X-MBO-RS-META: 5hxm7epe4emd8ixdk5remtddp4pnbao7
X-Rspamd-Queue-Id: 4h029J3bHlzKw8S
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

On 7/14/26 4:04 PM, Peng Fan wrote:
> On Sat, Jul 11, 2026 at 10:00:52PM +0200, Marek Vasut wrote:
>> On 6/21/26 4:06 AM, Peng Fan (OSS) wrote:
>>> From: Ye Li <ye.li@nxp.com>
>>>
>>> Call board_usb_init() during dwc3_generic_probe() and
>>> board_usb_cleanup() during dwc3_generic_remove() to allow
>>> board-level USB configuration (e.g. Type-C CC role, SS mux,
>>> VBUS control) before DWC3 core initialization.
>>>
>>> Signed-off-by: Ye Li <ye.li@nxp.com>
>>> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ...
>>>    	dwc3_shutdown_phy(dev, &priv->phys);
>>>    	unmap_physmem(dwc3->regs, MAP_NOCACHE);
>>> +	if (mode == USB_DR_MODE_HOST)
>>> +		board_usb_cleanup(dev_seq(dev), USB_INIT_HOST);
>>> +	else if (mode == USB_DR_MODE_PERIPHERAL)
>>> +		board_usb_cleanup(dev_seq(dev), USB_INIT_DEVICE);
>>> +
>> This is supposed to be generic DT based glue code, can we avoid the
>> board-specific callbacks entirely ?
> 
> We need to invoke TCPM configuration code, dropping board callbacks means
> we need put some #ifdef in dwc3 drivers:
> 
> #if CONFIG_IS_ENABLED(TYPEC_TCPM)
> static int dwc3_typec_setup(struct udevice *dev, struct dwc3_generic_priv *priv,
>                             enum usb_dr_mode mode)
> {
> 	/* Handling tcpm */	
> }
> #else
> static int dwc3_typec_setup(struct udevice *dev, struct dwc3_generic_priv *priv,
>                             enum usb_dr_mode mode)
> {
> 	return 0;
> }
> #endif
> 
> I could use above in V3.
The typec_sel and typec_en GPIOs look like something that could be 
handled by usb-c-connector , which could be made generic , can it not ?

How does Linux handle those GPIOs ?

I wanted to say look at the GPIO SBU mux Linux kernel driver, but that 
operates those GPIOs as OUTPUTs and I think you need INPUTs here?
