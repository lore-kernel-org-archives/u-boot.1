Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE82FC43458
	for <u-boot@archiver.kernel.org>; Sun,  5 Jul 2026 20:06:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2CE9F846FD;
	Sun,  5 Jul 2026 22:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="EDbpnoFQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="yngTZtHc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EC5184832; Sun,  5 Jul 2026 22:06:55 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87673846F8
 for <u-boot@lists.denx.de>; Sun,  5 Jul 2026 22:06:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gtdmr6Z4bz9tdq;
 Sun,  5 Jul 2026 22:06:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783282013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE+w6BSH+ruOrmyduj6vdwFcaLOW2HR9h2UGwqAX9iE=;
 b=EDbpnoFQ6MKFrNAOYro04eJA3cJtFy3tpOyEpV2Py8+etkAz40o3myqb4a03N0DHMlumCP
 2XdHzqC9Cn0VQ1IXZ4SdlmScAeXMr5U4UtedMyZaa2QqAgZAOlYDG6x3RsMeuw5SUmoGhe
 R8BA9MOfvDdXhDiyrsAHhSjiYrS6imuJkG1Z9eAGM9U3eaVv9HLH5SmgXz1lJBvyiKNqL1
 vK85ElnP4Ifak5+uLWijHKe1LskaqAxSVX4E2S6gB/i+Pg+Af1BET0uLEBbXDWfqA4ZwJO
 mD+Van8Z+oVuMU0KQjrrKptD2ppYlVg0pDHllzNO+bUSdQsWkaf9CY/ZqzGXOA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=yngTZtHc;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <57d54ca6-78d1-4fbf-b77b-27b02a90c998@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1783282011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aE+w6BSH+ruOrmyduj6vdwFcaLOW2HR9h2UGwqAX9iE=;
 b=yngTZtHcuKeFEKlkbc9d6MQGAARdVjZVcUSQAJpzETB273Yk3CQh16Tx92+h3ReGYVAGnC
 2YTpV9anmsM0A3Q1SQGwD4N8dXfYBecBL46Qhl5UGdHLpiXogkgq4omMQWzNMT6DIBRmia
 fqWlYJD2Xm6hKKzi05LQZY+O3RmTY2dKoSQbeH1LYglnhvxKkpmNrqWvaRDtjmuzrdF2LW
 IEMs2F2p/nle8/83sMSUDsD7nPgFRBDGgH0JfPjk0sCHrdhvPbHue+z3TZg3q534eJ67oN
 qF5S6+jtL30rV2mppan7BV2T+Bf1RZU8HjI6regGOrzq0Vrz4ksfwVuPaxt2RQ==
Date: Sun, 5 Jul 2026 18:00:12 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] usb: gadget: Add Renesas RZ/N1 USBF controller
 support
To: Romain Gantois <romain.gantois@bootlin.com>, u-boot@lists.denx.de
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Kever Yang <kever.yang@rock-chips.com>, Peter Robinson
 <pbrobinson@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 George Chan <gchan9527@gmail.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Herve Codina <herve.codina@bootlin.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Ralph Siemsen <ralph.siemsen@linaro.org>, Simon Glass <sjg@chromium.org>,
 Peng Fan <peng.fan@nxp.com>, Kory Maincent <kory.maincent@bootlin.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao
 <raymond.mao@riscstar.com>, Stefan Roese <stefan.roese@mailbox.org>,
 Philip Molloy <philip.molloy@analog.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 David Lechner <dlechner@baylibre.com>, Julien Stephan
 <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>
References: <20260702-rzn1-usbf-v2-0-00ceecebaea6@bootlin.com>
 <20260702-rzn1-usbf-v2-2-00ceecebaea6@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260702-rzn1-usbf-v2-2-00ceecebaea6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: p1jbk6rto9eqyp9gs1moqnzmkztrr4k8
X-MBO-RS-ID: 53d66704e7c42b7211b
X-Rspamd-Queue-Id: 4gtdmr6Z4bz9tdq
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

On 7/2/26 10:11 AM, Romain Gantois wrote:
> From: Herve Codina <herve.codina@bootlin.com>
> 
> Add support for the Renesas USBF controller. This is an USB2.0 UDC
> controller available in the RZ/N1 SoC.
> 
> This driver was originally written by Hervé Codina for the Linux kernel.
> Suspend/resume features have been removed in this U-Boot port.
> 
> Linux revision this was ported from:
> 
> 74851fbb6d64 usb: gadget: renesas_usbf: Handle devm_pm_runtime_...

Please use the canonical short format:

74851fbb6d64 ("usb: gadget: renesas_usbf: Handle 
devm_pm_runtime_enable() errors")

But diff between the Linux kernel driver file and this driver shows 
changes in indent and removed spin lock invocations, can you retain 
those and possibly stub them with noop functions instead ? At least the 
spinlocks and indent should be doable.

[...]

> +static const struct udevice_id usbf_match[] = {
> +	{ .compatible = "renesas,rzn1-usbf" },
> +	{} /* sentinel */
> +};
> +
> +U_BOOT_DRIVER(usbf_renesas_udc) = {
> +	.name	= "usbf_renesas",
> +	.id = UCLASS_USB_GADGET_GENERIC,
> +	.of_match = usbf_match,
> +	.ops = &usbf_gadget_generic_ops,
> +	.probe = usbf_probe,
> +	.remove = usbf_remove,
> +	.priv_auto	= sizeof(struct usbf_udc),
> +};

Nitpick, please use either space or tab before = , but use only one and 
use it consistently.

Thank you !
