Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380EDE81BA8
	for <u-boot@archiver.kernel.org>; Mon,  9 Feb 2026 12:03:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A48583BDD;
	Mon,  9 Feb 2026 13:03:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="d2hPbH+L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E85283C54; Mon,  9 Feb 2026 13:03:23 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1A8283BDD
 for <u-boot@lists.denx.de>; Mon,  9 Feb 2026 13:03:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f8jyH5WWfz9spH;
 Mon,  9 Feb 2026 13:03:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1770638599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6aZQVppNI8Rn5OYngUrErfBM5izQbTIoLYDszQK74U=;
 b=d2hPbH+L2CNsv7nrilo0XSCjRuQ61cuG9VYLN/z1G+GmnhnLpE6oqPAuA7SVwHmnJXXuMJ
 TnCJZv38ZLBWdwB7gNDIgCY2Fwar1NH4kPHAdeCmWIyjwHpFYSo+/kndKcklaNhkQob3Mf
 S0KIxihSHmNeBhpS1kdKs+u8TV5jcEUQQtO/OexwJ2Z+3XxxMKY57JLOx4CXkvFh0ERKkA
 7h6WutZ6gmM4raKt5gj2hHqmxHZaktUDppRK1uznx0mG3miH6Ul5R2QOBaYglvBpf7PCrJ
 QhOhDhvZehkYOU7XzixVBDKKVsE98atrCdU4s1SXdbt19JLfEHjIDRObh1hRiQ==
Message-ID: <4ea57849-c96b-4cc3-8ff5-90640c0a6b44@mailbox.org>
Date: Mon, 9 Feb 2026 13:02:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v6 2/2] usb: musb-new: Add compatibles for ti,musb-am33xx
To: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>
References: <20260209-topic-musb-probing-v2026-01-v6-0-efce26b4917a@baylibre.com>
 <20260209-topic-musb-probing-v2026-01-v6-2-efce26b4917a@baylibre.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260209-topic-musb-probing-v2026-01-v6-2-efce26b4917a@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: f6061f5b5eb3bb2f54a
X-MBO-RS-META: 7ndqqb9cbzkejh3beim1jicg479iny6r
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

On 2/9/26 10:24 AM, Markus Schneider-Pargmann (TI.com) wrote:
> The upstream devicetree am33xx.dtsi does not have a "ti,am33xx-usb"
> compatible, it uses "ti,sysc-omap4" for the same node. The
> implementation of ti-musb uses a wrapper driver that binds to
> ti,am33xx-usb and creates new devices ti-musb-host and
> ti-musb-peripheral depending on the dr_mode property.
> 
> To avoid this wrapper driver with the upstream devicetree, add
> compatibles for "ti,musb-am33xx" to both ti-musb-host and
> ti-musb-peripheral. Add a bind function that checks for the correct
> dr_mode value and rejects binding if it is not the correct driver.
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
