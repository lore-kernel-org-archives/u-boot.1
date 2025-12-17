Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21609D65C44
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 13:02:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9F51183B32;
	Wed, 17 Dec 2025 14:02:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EgIq4QwU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD83B83B48; Wed, 17 Dec 2025 14:02:18 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E224783979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 14:02:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4dWYqB6X11z9thy;
 Wed, 17 Dec 2025 14:02:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765976535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKS3dqD5miZkgih13+Zsv8nRcdMwIJsn8QSEZ8jxwEM=;
 b=EgIq4QwU7+sWIhMPaKsIqjjc9LdK0V6aFIarIudGRrD27+UHwLD81AUFb6MqSpZSUP579e
 Psr2POk93xItB6EFZkEv9va2b/spiHqtxCTLmKmJEzqVZU7a+Gr7JGpbssJn9IF2JeEwP3
 fR6/Viy+f/FAWwhBovf4RkKI6xe7DyQMhS0hu23FCjyX/ji7jMT8slwA03BtViVqU4gDOL
 +F5ADUXNL9vjKnWPChAyUHIArhgEHLIduNjI9wpPpK2+F/0q8QWP+/W3J+pifBwmnU01tZ
 2kY61RiG3gRC5Pn7ins/3RkdlJUaoa+tItFTyUu3joC5Xq8O37wz3VpznQ6N8g==
Message-ID: <c1b0ecd6-2697-4b81-9b63-1c5b3d243a86@mailbox.org>
Date: Wed, 17 Dec 2025 14:02:10 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/3] clk: scmi: Fix priv initialization in
 scmi_clk_gate()
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Alice Guo <alice.guo@nxp.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251215-sqqs-v2-0-9a15a22072b7@foss.st.com>
 <20251215-sqqs-v2-2-9a15a22072b7@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251215-sqqs-v2-2-9a15a22072b7@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 7f545c69c1c543cb914
X-MBO-RS-META: gu8bh1xje11m1ezn5wnui8mq8ptypx1k
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

On 12/15/25 8:38 AM, Patrice Chotard wrote:
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
> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> Cc: Alice Guo <alice.guo@nxp.com>
> Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Valentin Caron <valentin.caron@foss.st.com>
> Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
> Cc: u-boot@lists.denx.de
> Reviewed-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/clk/clk_scmi.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index f6132178205..5c99f3708c3 100644
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
> @@ -156,6 +156,15 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>   					     in_v2, out);
>   	int ret;
>   
> +	/*
> +	 * retrieve the correct priv which was set in scmi_clk_probe().
> +	 * in case CLK_CCF is set, priv was set in parent_priv
> +	 */
> +	if (!CONFIG_IS_ENABLED(CLK_CCF))

Please invert the conditional here , no need for the if (!...) .

> +		priv = dev_get_priv(clk->dev);
> +	else
> +		priv = dev_get_parent_priv(clk->dev);
> +
>   	ret = devm_scmi_process_msg(clk->dev,
>   				    (priv->version < CLOCK_PROTOCOL_VERSION_2_1) ?
>   				    &msg_v1 : &msg_v2);
> 
