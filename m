Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08723D6ACD5
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 09:13:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A62E83C54;
	Thu, 18 Dec 2025 10:13:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="xpg3A8QP";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZKH7uw0N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9476D83CAA; Thu, 18 Dec 2025 10:13:11 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AEE3A83C2B
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 10:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dX4hN2hS3z9tHg;
 Thu, 18 Dec 2025 10:13:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766049188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qf9LVesuPVduFcEa78XOJlJs/qX1Kr43H/XPsPIeK9o=;
 b=xpg3A8QPbnVZlDm7nTvaSRv9+4IymcPuCk2Uzik1LwAYHhfDsZ7Q1SkO0vtcyW+qKPE340
 ExPO6OSxzkCRqPSMswiZOjl3rQseH5QWeMsAf/yoPQhAJe2f5pzXieGHB80e7XjFf1hJAH
 q4Tf96Pje2zenJuypknetk6bGft9xT+FUXrr19jg+wMK0yamM3WjcNXPg4z7r4u1F5cKp+
 yO8YUUedRg9QP/hes9QwaeE3mfNEo5gAY0bwHii9YwyYwoPFsKcM5SsV+Z4jx/RfXqCMlB
 Wi2rMcW+8FotGvIGVKnh6/84nvZV5vwXOHco83Skz8fTk1oDjVBIW06EQAdp4Q==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=ZKH7uw0N;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <93f17cf0-542c-4c0c-a97f-40dd328afd5d@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766049186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qf9LVesuPVduFcEa78XOJlJs/qX1Kr43H/XPsPIeK9o=;
 b=ZKH7uw0N6VIz3rBxsREiyZ5cgSjNZkvsbdDS0IcBV9FlW42kqG1cl10xSSU3PncFlWGB05
 WygdHF39fJ7EFZewvhx1txO7/caAv8h27VVShsP41HJTQd2qZgPoqeiqMIecSbRvfMpwJG
 LT1t42Ivbb3AAZ/dQK2MaTMA1GEDtuJ/Qjte4JgrK5hcTb0ZqKf0+rxaQrdBIZVu8vpPs4
 4sdf9E2ClewIn+jjqSpxd+Nql4V4rThXVeO8H8NR3evSMpZaHK1ZGg1ykh7XRpFfm6fcjD
 YpINNhIo0Ow2gO7jGRae3VOxQqIVQ9DmA3GOmm65KmxgsbD4coT5hQSnXo/efA==
Date: Thu, 18 Dec 2025 10:13:02 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 2/3] clk: scmi: Fix priv initialization in
 scmi_clk_gate()
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
 <20251218-sqqs-v4-2-ff95bf2062ab@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251218-sqqs-v4-2-ff95bf2062ab@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1ea47b4464eab0e0e86
X-MBO-RS-META: eo43pjyehm7ynwiu6kz4dk9pneg1hisz
X-Rspamd-Queue-Id: 4dX4hN2hS3z9tHg
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

On 12/18/25 9:26 AM, Patrice Chotard wrote:
> In scmi_clk_probe(), in case of CLK_CCF is not enabled, parent private
> data is not set, so in scmi_clk_gate(), an uninitialized priv struct is
> retrieved.
> 
> SCMI request is performed either using scmi_clk_state_in_v1 or
> scmi_clk_state_in_v2 struct depending of the unpredictable value of
> priv->version which leads to error during SCMI clock enable.
> 
> Issue detected on STM32MP157C-DK2 board using the SCMI device tree
> stm32mp157c-dk2-scmi.dts.
> 
> Fixes: 0619cb32030b ("firmware: scmi: Add clock v3.2 CONFIG_SET support")
> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> ---
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Valentin Caron <valentin.caron@foss.st.com>
> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/clk/clk_scmi.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index f6132178205..a4fc4f8da89 100644
> --- a/drivers/clk/clk_scmi.c
> +++ b/drivers/clk/clk_scmi.c
> @@ -137,7 +137,7 @@ static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
>   
>   static int scmi_clk_gate(struct clk *clk, int enable)
>   {
> -	struct scmi_clock_priv *priv = dev_get_parent_priv(clk->dev);
> +	struct scmi_clock_priv *priv;
>   	struct scmi_clk_state_in_v1 in_v1 = {
>   		.clock_id = clk_get_id(clk),
>   		.attributes = enable,
> @@ -156,6 +156,16 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>   					     in_v2, out);
>   	int ret;
>   
> +	/*
> +	 * In scmi_clk_probe(), in case of CLK_CCF is set, SCMI clock
> +	 * version is set in dev's parent priv struct. Otherwise
> +	 * SCMI clock version is set in dev priv struct.
> +	 */
> +	if (CONFIG_IS_ENABLED(CLK_CCF))
> +		priv = dev_get_parent_priv(clk->dev);
> +	else
> +		priv = dev_get_priv(clk->dev);
On your hardware, do you have CCF enabled or not ?

What does this print output if added here ?

printf("clk->dev->name=%s clk->dev->parent->name=%s\n", clk->dev->name, 
clk->dev->parent->name);

I think it should be something like this:

clk->dev->name=scmi-325 clk->dev->parent->name=protocol@14
