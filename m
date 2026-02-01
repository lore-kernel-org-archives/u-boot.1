Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3350FE65298
	for <u-boot@archiver.kernel.org>; Sun,  1 Feb 2026 18:36:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AECD483C02;
	Sun,  1 Feb 2026 19:36:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="HxZ0RL1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6666083B03; Sun,  1 Feb 2026 19:36:26 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8E31083B86
 for <u-boot@lists.denx.de>; Sun,  1 Feb 2026 19:36:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4f3z3V557Rz9tYL;
 Sun,  1 Feb 2026 19:36:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1769970982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OYKh1NG1Pux3WYPwPVzdDUTfpnQX8gIFpPvmaemoAUc=;
 b=HxZ0RL1azibeenrGIP3vzxztgBrHbP1xg7jT46nEnozRCYSRHlwjbMTHTaJHoh/axP/CWn
 hI+YFu68gUYAKxxjYPEypyGpbTzy1JFBitiZ/Ze7DCLFI/Sk/qUIoToGBfklmykCnDjAnn
 FhegeS8biaJrrwHSXx1UehpPpCarbx8iPylrA2Nm0HL14nJundg+8LJRh25NJFD4nOtoyr
 XD3yqKcLAWdKPLiagkrbg4oAGHFOQU8XdceSfUGCEJhJFE9T5NkUKsM7+z6CWcjsvms2v9
 n/rbUTeDI6j9qma1a//v5sWePUa1G6q3d9HtVJyC4JFeMZOGa9XGdYGv1VW6zw==
Message-ID: <f0eee23c-7838-4291-b86a-cdd97fcb3c5f@mailbox.org>
Date: Sun, 1 Feb 2026 19:19:31 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v5 2/2] usb: musb-new: Add compatibles for ti,musb-am33xx
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>
References: <20260130-topic-musb-probing-v2026-01-v5-0-195b23c7948f@baylibre.com>
 <20260130-topic-musb-probing-v2026-01-v5-2-195b23c7948f@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260130-topic-musb-probing-v2026-01-v5-2-195b23c7948f@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: cc3780e3d4a6d04f4f9
X-MBO-RS-META: wru1bib6yfuh51d7sm71k4t6yj4kwfiz
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

On 1/30/26 5:28 PM, Markus Schneider-Pargmann (TI.com) wrote:

> +static const struct udevice_id ti_musb_host_ids[] = {
> +	{ .compatible = "ti,musb-am33xx" },
> +	{ }
> +};

[...]

> +static const struct udevice_id ti_musb_peripheral_ids[] = {
> +	{ .compatible = "ti,musb-am33xx" },
> +	{ }
> +};
Can we have one copy of those IDs in the driver ?
