Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FFCC9830E
	for <u-boot@archiver.kernel.org>; Sat, 17 Jan 2026 01:39:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1D3A838BB;
	Sat, 17 Jan 2026 02:39:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Hejzfx1q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDA1983966; Sat, 17 Jan 2026 02:39:44 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C578397D
 for <u-boot@lists.denx.de>; Sat, 17 Jan 2026 02:39:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dtKCG0wW4z9v27;
 Sat, 17 Jan 2026 02:39:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1768613978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vipUX0TmiroHeIgv1G0uDNlt+zrMKZpwQsegt3VrCUU=;
 b=Hejzfx1qc285M8TnYHonIBIcxsrWsicOXOFY0yd98Q05EFgbUFEbEX7C/t+kr8vpBNqj22
 2fZq/cKfI78OVFo9081tBeHsA73Yo/EB/xkowFTmfkPLOFLQD68oYSkT6Lg01e4WNjRIlf
 1cviUzLgi14szLxE11X1er8Ts5S4vEznJuVs5kxaMPf/73+z+HVJMXKZel6L0WFJwB9M7e
 hve/JHMDQX02OnPjlqn4A8BWCeyMt52wHCM3Ez90WfuhWo31T9KIhZYlx9c6ZERW2W5yzR
 lNUF8lk6WUeQEdsmnu2W4yggZOz+m9vXGEXQk9Jb/K/0Jruuxvuj00RorKoHYw==
Message-ID: <41e4a66a-38e8-47ed-b599-4974733b1524@mailbox.org>
Date: Sat, 17 Jan 2026 02:38:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] clk: clk_resolve_parent_clk(): resolve external
 clocks by id
To: chiffathefox <chiffathefoxx@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Patrice CHOTARD <patrice.chotard@st.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Lukasz Majewski <lukma@denx.de>, Maksim Kiselev <bigunclemax@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, u-boot@lists.denx.de
References: <20260115031114.220888-1-chiffathefoxx@gmail.com>
 <20260115031114.220888-2-chiffathefoxx@gmail.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260115031114.220888-2-chiffathefoxx@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: e022fa8fb7cfb81a2f4
X-MBO-RS-META: 4bhyzmffe5kmdd6ou5q6pjw1bqz5qx8w
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

On 1/15/26 4:11 AM, chiffathefox wrote:
> When referencing clocks in DTS registered by another driver,
> clk_resolve_parent_clk() is supposed to return the name
> of the child device that provides the requested clock.
> However, in reality, it returns the name of the parent DTB
> node (e.g. clock-controller@1a240000). Such devices, for
> instance the exynos7870-cmu-peri driver, do not store any
> clock information in their dev->uclass_priv_ because they
> expect you to call dev->ops->get_rate with the appropriate
> clk->id. So when you try to resolve a clock that depends on
> an externally referenced clock, the resolution fails on the
> parent clock because it doesn't have a  dev->uclass_priv_.
> With this change clk_resolve_parent_clk() will take an
> extra step to actually resolve the child device.
> 
> Signed-off-by: chiffathefox <chiffathefoxx@gmail.com>
> ---
> 
>   drivers/clk/clk-uclass.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk-uclass.c b/drivers/clk/clk-uclass.c
> index 0584429bed6..bea45fc396f 100644
> --- a/drivers/clk/clk-uclass.c
> +++ b/drivers/clk/clk-uclass.c
> @@ -430,6 +430,7 @@ clk_resolve_parent_clk(struct udevice *dev, const char *name)
>   {
>   	struct udevice *parent;
>   	struct clk clk;
> +	struct clk *c;
>   	int ret;
>   
>   	ret = uclass_get_device_by_name(UCLASS_CLK, name, &parent);
> @@ -440,7 +441,11 @@ clk_resolve_parent_clk(struct udevice *dev, const char *name)
>   	if (!clk.dev)
>   		return name;
>   
> -	return clk.dev->name;
> +	ret = clk_get_by_id(clk.id, &c);
> +	if (ret)
> +		return name;
> +
> +	return c->dev->name;
>   }
>   
>   int clk_release_all(struct clk *clk, unsigned int count)

The issue description looks very similar to what this commit fixes:

0e9055b1488f ("clk: scmi: Fix priv initialization in scmi_clk_gate()")

Is this related ?

Can you share an example / test which triggers the problem ? (ideally, 
use sandbox or sandbox64, that would make it reproducible for others too)

Thank you

+CC Peng/Patrice.
