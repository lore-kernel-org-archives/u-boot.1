Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DD1D3B7EA
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 11:54:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D53383700;
	Tue,  9 Dec 2025 12:54:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ryvD/EtU";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="OqExDojl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41D7D838A0; Tue,  9 Dec 2025 12:54:33 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1815836C8
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 12:54:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dQchk1mdHz9tlB;
 Tue,  9 Dec 2025 12:54:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765281270;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeGLgfilyAZEnzKZkvxXQTuOjDYzJf3dSV9ODDWlv8Y=;
 b=ryvD/EtUrl0OnhfkAAm8vJGSuLSjX0qdvJr6jcUTl8YaLB3JXHotjdGGR0GbHwV3oZI1Hr
 X/HDZ2i/gALXtXAn/d/Lps8e+iVHlO6WUdOcUMLRAJEcbn/pP8dQfHkiczOkKBEOoZ3kAs
 HCBIaUinNwP+juXfU94Sx8eVt/PK6zNV+EUgCgiN3YSQieI+vNfC9vlL1jF/hmyCSRHlBP
 Rya8wSFu+QPwhliW2Vf+Tyr6dbL5s55cNI31lfKE3EHPcbM/icPLwAuUxo2+w9gMlBV67q
 u0lKOTDjSKX6Z+GSGwEDdfKIgOOYmpjFhqah/FnDxE65pmATCD/U+xklF01L+Q==
Message-ID: <3d8c5338-9a14-4f27-9dd4-d84929f9c6c5@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765281268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SeGLgfilyAZEnzKZkvxXQTuOjDYzJf3dSV9ODDWlv8Y=;
 b=OqExDojl7qjqL3qgFEiDvMhG5KJKIEuKMtvwMryHGsyUftyM1f0pWJeFjwAJwX+KgdmqF6
 kQtsqcJ9Ch88Qm6DcoI5WQpuAHxAVYpVrvJ1t3W1m16Cp6frtET4n/BU+8w0Br/6pw7uzu
 bVG3FFiZSJrdPaZqnv+zodAjaeLOTgRcYKXJWInWvOjT3W+3bz5pCN9yEBVJnqR+vsW1oW
 KjgfAQyGl7fC3kB24Tki6/UWJ+eX0lL7iVkhamNYxsCmKz55tJM/MAJGswZr4HfCwKeClW
 +Ew/MvHojlsk/cTOTbi22OFeEOCHTM8vQqP4PvUecNNcxm+ooLCHv+qy12x98g==
Date: Tue, 9 Dec 2025 12:54:15 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] clk: scmi: Fix priv initialization in scmi_clk_gate()
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251208-sqqs-v1-0-290f0594e30b@foss.st.com>
 <20251208-sqqs-v1-2-290f0594e30b@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251208-sqqs-v1-2-290f0594e30b@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 52d5e4e96058e67f1b8
X-MBO-RS-META: abwogmno3wwxcrwh4pz7ikwoa347airr
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

On 12/8/25 2:51 PM, Patrice Chotard wrote:
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
> ---
>   drivers/clk/clk_scmi.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
> index f6132178205..e1c20f2c47c 100644
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
> @@ -156,6 +156,11 @@ static int scmi_clk_gate(struct clk *clk, int enable)
>   					     in_v2, out);
>   	int ret;
>   
> +	if (!CONFIG_IS_ENABLED(CLK_CCF))
> +		priv = dev_get_priv(clk->dev);
> +	else
> +		priv = dev_get_parent_priv(clk->dev);
> +
Shouldn't this be doing similar resolution like existing code ?

168 static int scmi_clk_get_ctrl_flags(struct clk *clk, u32 *ctrl_flags)
169 {
170         struct clk_scmi *clkscmi;
171         struct udevice *dev;
172         u32 attributes;
173         struct clk *c;
174         int ret;
175
176         ret = clk_get_by_id(clk->id, &c);
177         if (ret)
178                 return ret;
179
180         dev = c->dev->parent; // <-----------------------------
181
182         clkscmi = container_of(c, struct clk_scmi, clk);
183
184         if (!clkscmi->attrs_resolved) {
185                 char name[SCMI_CLOCK_NAME_LENGTH_MAX];
186                 ret = scmi_clk_get_attibute(dev,
                           ^^^^^^^^^^^^^^^^^^^^^^^^^
...
  90 static int scmi_clk_get_attibute(struct udevice *dev, int clkid, 
char *name,
  91                                  u32 *attr)
  92 {
  93         struct scmi_clock_priv *priv = dev_get_priv(dev);
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
