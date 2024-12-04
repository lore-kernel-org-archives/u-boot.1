Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 358BEE7716D
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 22:25:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44DB589497;
	Wed,  4 Dec 2024 23:25:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="sH1oSKij";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DF6489495; Wed,  4 Dec 2024 23:25:08 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D610889485
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 23:25:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rogerq@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id CCF57A40F8E;
 Wed,  4 Dec 2024 22:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DA7C4CECD;
 Wed,  4 Dec 2024 22:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1733351104;
 bh=gV2bIuTY67yPFlHlsytztlYiSXB+nySNzXY3s/OY1Yk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sH1oSKij11Ift8wGVbwK07CyxXIzJsT8enQ6BnVXzaz9qnnishKWKl6rCLDUCYq4w
 2QuOVIQZPoEjahVyuOuHHmTS9QZOQtpzHQCBRV8OD4m0FMuu1IgqYKlu4rjD4kYoDo
 frQoYRNQA02eWF5hzeIfz/MjDsdWusG6eQbrxtLpvBkGjilcCDTGbHnsTMNIYokh56
 DnJFOW3sPzcsHmEhV7bM1GzcX0mPpUFvwz/WXY6zXSL2RTEiN7GvVPcnzyfde+53+3
 EC/OyF9Jrw69QwmYO8KUJNWiKXdm7yVQibmO0sP0qy0dn5WYyEPXjjLGYMzJfMp8P2
 9kejRjOXvGwQw==
Message-ID: <ec0100fa-e46d-4915-9281-033c6dbd2b00@kernel.org>
Date: Thu, 5 Dec 2024 00:24:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] usb: dwc3-generic: set "mode" based on caller of
 dwc3_generic_probe()
To: Siddharth Vadapalli <s-vadapalli@ti.com>, vigneshr@ti.com, bb@ti.com,
 trini@konsulko.com, marex@denx.de, hnagalla@ti.com,
 mkorpershoek@baylibre.com, caleb.connolly@linaro.org,
 neil.armstrong@linaro.org, jan.kiszka@siemens.com, jonas@kwiboo.se,
 j-humphreys@ti.com, nm@ti.com, devarsht@ti.com, ilias.apalodimas@linaro.org
Cc: u-boot@lists.denx.de, srk@ti.com
References: <20241126120322.1760862-1-s-vadapalli@ti.com>
 <20241126120322.1760862-2-s-vadapalli@ti.com>
Content-Language: en-US
From: Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20241126120322.1760862-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 26/11/2024 14:03, Siddharth Vadapalli wrote:
> There are only two callers of "dwc3_generic_probe()", namely:
> 1. dwc3_generic_peripheral_probe()
> 2. dwc3_generic_host_probe()
> Currently, the "mode" is set based on the device-tree node of the
> platform device. Also, the DWC3 core doesn't support updating the "mode"
> dynamically at runtime if it is set to "OTG", i.e. "OTG" is treated as a
> separate mode in itself, rather than being treated as a mode which should
> eventually lead to "host"/"peripheral".
> 
> Given that the callers of "dwc3_generic_probe()" clarify the expected
> "mode" of the USB Controller, use that "mode" instead of the one
> specified in the device-tree. This shall allow the USB Controller to
> function both as a "Host" and as a "Peripheral" when the "mode" is "otg"
> in the device-tree, based on the caller of "dwc3_generic_probe()".
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>

