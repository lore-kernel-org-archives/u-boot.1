Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6449CD6E48
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 12:54:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CB9683D77;
	Thu, 13 Nov 2025 13:54:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="BKfF0jME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 76BD083DDD; Thu, 13 Nov 2025 13:54:17 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D98583C62
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 13:54:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EA88C103621; Thu, 13 Nov 2025 13:54:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1763038454;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=sbn6n/g6/AM+F7LADATre8WDOOTs8ckGT11iPLosAyw=;
 b=BKfF0jME4ZohNzptOPnF2bqjz+L5dVwyuHR38axYX2IPB2jXIOGy6EXEvjfzq2G1/sinez
 IeqPEC2y9Y7KKPJh/w5sKqQmZyPQipaq7s3BE26Ar9LqV6rfEQJcy0Duaydu/HHbvTFRpc
 kWza+WAQdwOs+68tX1C/LLkvr1oX5NHCpybbOE4KPCY4o2p9kWMz54jEz2Vgej2UcOLPV1
 PCIQRYUvLrloYcPEE2pjej7CBehw1xYkDTpO6FcqZhU60uRXlX5dAk+x+0BbdRC5b+PG3r
 uv9GcBGURn5KDYA/g7BUKhePVfcaLY8FdF/vK49mAIrATT75m35e6bb1HDiDVg==
Message-ID: <5a76ffc8-c41e-b2ff-4d95-8f93048dfd21@nabladev.com>
Date: Thu, 13 Nov 2025 13:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] sandbox: Fix DT compiler pin warnings in sandbox DTs
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Christian Marangi <ansuelsmth@gmail.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon Glass
 <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <20251113115658.947953-1-marek.vasut+renesas@mailbox.org>
 <20251113115658.947953-2-marek.vasut+renesas@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251113115658.947953-2-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Marek,

On 13.11.25 12:56, Marek Vasut wrote:
> Trivially fix the following warnings in sandbox DTs, which show up with
> DTC 1.7.2. Assign pin groups less confusing node names with pins- prefix
> to avoid confusing DT compiler into thinking the node is really a bus node:
> 
> "
> arch/sandbox/dts/.test.dtb.pre.tmp:1831.20-1841.5: Warning (i2c_bus_bridge): /pinctrl/i2c: incorrect #address-cells for I2C bus
> arch/sandbox/dts/.test.dtb.pre.tmp:1831.20-1841.5: Warning (i2c_bus_bridge): /pinctrl/i2c: incorrect #size-cells for I2C bus
> arch/sandbox/dts/test.dtb: Warning (i2c_bus_reg): Failed prerequisite 'i2c_bus_bridge'
> arch/sandbox/dts/.test.dtb.pre.tmp:1848.20-1856.5: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #address-cells for SPI bus
> arch/sandbox/dts/.test.dtb.pre.tmp:1848.20-1856.5: Warning (spi_bus_bridge): /pinctrl/spi: incorrect #size-cells for SPI bus
> arch/sandbox/dts/test.dtb: Warning (spi_bus_reg): Failed prerequisite 'spi_bus_bridge'
> "
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Christian Marangi <ansuelsmth@gmail.com>
> Cc: Dinesh Maniyam <dinesh.maniyam@altera.com>
> Cc: Guillaume La Roque <glaroque@baylibre.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Svyatoslav Ryhel <clamor95@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   arch/sandbox/dts/test.dts | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
