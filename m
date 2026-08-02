Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDFFC55171
	for <u-boot@archiver.kernel.org>; Sun,  2 Aug 2026 04:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A290E60648;
	Sun,  2 Aug 2026 04:35:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V1VGwnhGCq1A; Sun,  2 Aug 2026 04:35:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C602760641
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785645323;
	bh=GAJJzvqIoC72Jd5uXxRJmGeM5KvaULa96JMptXHBxoc=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=LZKWOdfGxP3B4NnMy4AYVy88sXeobSWAbHlVEnMB3yA4+bisuX/vP+/McOOsqf7ax
	 P9eNx24EX4gNMcKedKEfcRIapBX/anhaBmSlOL9BRm0y1tL3+x70oYgi2Qd1FHiBhu
	 oqIxZbfPqbqUoZ652tBTphPYVQthRuuWt4mAriVqN4bFGjtyfQpMnBb6CqFEM0765+
	 rL94Z39k+Rc7SlbPYBjxtYmr3v+nBg3tUxyRwcq5R/oa2HDP/BjhThdGHRfwi3LO0k
	 KPYXRyKV/PD1uvonTScth5lSm+O+I9QlQycrXoY8Sro/pNvE+/gZZpcV4RU7po88Gw
	 equdjT3bjKu5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C602760641;
	Sun,  2 Aug 2026 04:35:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 78FAC1389
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:35:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5EAA880D7F
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:35:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RfDHD_Q-L7L7 for <u-boot@lists.u-boot-project.org>;
 Sun,  2 Aug 2026 03:35:40 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.161;
 helo=mout-p-103.mailbox.org; envelope-from=marek.vasut@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 6AAA980D7A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6AAA980D7A
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 6AAA980D7A
 for <u-boot@lists.u-boot-project.org>; Sun,  2 Aug 2026 03:35:38 +0000 (UTC)
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hCQS74zzgzKn2d;
 Sun, 02 Aug 2026 05:35:35 +0200 (CEST)
Message-ID: <631912b3-55fd-4927-880f-b773969f1877@mailbox.org>
Date: Sun, 2 Aug 2026 05:30:16 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 01/17] pinctrl: renesas: r906g032: handle pin subgroups
To: Ralph Siemsen <ralph.siemsen@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Senthil Nathan Thangaraj <senthilnathan.thangaraj@amd.com>,
 Abbarapu Venkatesh Yadav <venkyada@qti.qualcomm.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Naman Trivedi <naman.trivedimanojbhai@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Boon Khai Ng <boon.khai.ng@altera.com>, Ye Li <ye.li@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Robert Marko <robert.marko@sartura.hr>, Jim Liu <jim.t90615@gmail.com>,
 Ben Wolsieffer <ben.wolsieffer@hefring.com>, Stanley Chu
 <yschu@nuvoton.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Angelo Dureghello <angelo@kernel-space.org>, Anshul Dalal <anshuld@ti.com>,
 David Lechner <dlechner@baylibre.com>, Daniel Palmer <daniel@thingy.jp>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Phil Edworthy <phil.edworthy@renesas.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Udit Kumar
 <u-kumar1@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Johan Jonker <jbx6244@gmail.com>, Simon Glass <sjg@chromium.org>,
 Julien Stephan <jstephan@baylibre.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>
References: <20260731-rzn1-2026-07-v1-0-af2ce80db9d8@linaro.org>
 <20260731-rzn1-2026-07-v1-1-af2ce80db9d8@linaro.org>
Content-Language: en-US
In-Reply-To: <20260731-rzn1-2026-07-v1-1-af2ce80db9d8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ba34759758caf8270b2
X-MBO-RS-META: sfgbnrrwge5b1djfz9ho8fktj6pm8m8m
X-Rspamd-Queue-Id: 4hCQS74zzgzKn2d
X-Mailman-Approved-At: Sun, 02 Aug 2026 04:35:23 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785641735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAJJzvqIoC72Jd5uXxRJmGeM5KvaULa96JMptXHBxoc=;
 b=H+arKamRmCI2tR4uySTJ+7dCF4I217MBnong/kAClq6hXLKOghW9uFLmqAwJ+om5R544QO
 JkXdCzkZcR1L1PYkTOu2pxpCJPMyZvDOIpv+cJuBzVUV+CCtE2OEKyAHeg3W2+ml2joQSh
 QDZDwZL7TKFfG/r5ipEvzgt0k7bA5+CH4x75qjvxU1jqOEazCLjkDKhk8k4HjOf8sYumM+
 BcCwa1brKsd+UGL/6q3KMcucuupFqNNvwZ3++Uz47FyF6vrRKBYtmk/KolSenVwpuSjv1m
 RPplRh03fxd/0JkYO6caMEZsoi73U50PHDc9bX9URkTXCVFrqcFq5gUq4eYTbw==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1785641733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GAJJzvqIoC72Jd5uXxRJmGeM5KvaULa96JMptXHBxoc=;
 b=FA0H+rMw5VN3rYnPwgfJ1hLJ/Vu+i0l4VCM7hpRuxttfqZQ8LaBMqL1syXB6+GUsuXruNj
 u96qgV44ldAKb2kL/D8VlCUDzggRwY6tXsGXyg4D/rwmVswdJsHXbHDJLJR4NqEe3/+LtB
 ldE6wDL6+o7iE1yOu6XU+wqdHqVST348QIosVvT73I+fmtAXYlC90/MCkHUUGGgG+XNl1m
 u8q8DN2hX9A+Jx1Iv7yDfyFVNZ1SPMcuLRasT8ELORjWQjhLA4fFKe/rfHs3jPRK7hG61Q
 MWQXaTaEjBgBm1X7mAZBFdLx635XEmbp5QsE/q/BxX6RBWN4FDYFOh2fp6andA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=H+arKamR; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=FA0H+rMw
X-Mailman-Original-Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=FA0H+rMw;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/31/26 6:33 PM, Ralph Siemsen wrote:
> Add simple recursion support to the .set_state method. This makes it
> possible to use subbroups

subgroups (typo)

> in the device tree, which in turn allows
> setting multiple pins with different bias/drive-strength properies.

properties (another typo)

> Fixes: e4aea57fa773 ("pinctrl: renesas: add R906G032 driver")
> Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>   drivers/pinctrl/renesas/pinctrl-rzn1.c | 15 +++++++++++++--
>   1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pinctrl/renesas/pinctrl-rzn1.c b/drivers/pinctrl/renesas/pinctrl-rzn1.c
> index fdc43c8e714..8b13a2cea75 100644
> --- a/drivers/pinctrl/renesas/pinctrl-rzn1.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rzn1.c
> @@ -298,6 +298,7 @@ static int rzn1_pinconf_set(struct rzn1_pinctrl_priv *priv, unsigned int pin,
>   static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>   {
>   	struct rzn1_pinctrl_priv *priv = dev_get_priv(dev);
> +	struct udevice *child;
>   	int size;
>   	int ret;
>   	u32 val;
> @@ -317,8 +318,6 @@ static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>   
>   	/* Number of pins */
>   	ret = dev_read_size(config, "pinmux");
> -	if (ret < 0)
> -		return ret;

Is this removal of error checking correct ?

>   	size = ret / sizeof(val);
>   
> @@ -338,6 +337,18 @@ static int rzn1_pinctrl_set_state(struct udevice *dev, struct udevice *config)
>   		rzn1_hw_set_lock(priv, LOCK_ALL, 0);
>   	}
>   
> +	/*
> +	 * Handle subnodes recursively, so that pin groups work.
> +	 * Note that properties are *NOT* inherited from parent.
> +	 */
> +	for (device_find_first_child(config, &child);
> +	     child;
> +	     device_find_next_child(&child)) {

device_foreach_child() ?

> +		ret = rzn1_pinctrl_set_state(dev, child);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return 0;
[...]
