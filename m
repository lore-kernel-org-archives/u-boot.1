Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8795CCCFA00
	for <u-boot@archiver.kernel.org>; Fri, 31 Oct 2025 15:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1401839DE;
	Fri, 31 Oct 2025 16:52:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="t4escKaY";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RUmQmtw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EFF74839DF; Fri, 31 Oct 2025 16:52:03 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B083C839D5
 for <u-boot@lists.denx.de>; Fri, 31 Oct 2025 16:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cylpn2Py0z9tvt;
 Fri, 31 Oct 2025 16:52:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761925921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBNOiNmKlFnCVIByGgDJx4ML9TVOo3A31FyHkIkgWYQ=;
 b=t4escKaY4XYwnJ12dJsmdreFbK7tmc/IdIm8CouN8uWhpk5tzfjIhEP8DwOAEI3lzPHozC
 QcNk3EkH+xDjrVr3Na2Rb+ihu2KI24zQBiI6hIlQgPv7ycCLc5MygG7Yi/ocVXntm5gMI4
 /Q1u2Fxq6k3Rx4N1cM0Kr56vfzsUIGcGSLvG5qcMH1D0k+GqmxTri+S9xJpIeastZbzBJh
 Sh7pnyXYXVzKzKa/iwBc+x0hOWFRfzTI262M/Zj3A6rq1D90tJNqaReFEtrOpzUMyj3/gz
 GR0MWkLDUbwcMNCz0DuMxi7idjviEI2JxM+6kLEG5rYfM3HbUnZ7X+iY34asFA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=RUmQmtw5;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <ac552ba3-832c-4cfb-aa39-c80949df7900@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761925919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uBNOiNmKlFnCVIByGgDJx4ML9TVOo3A31FyHkIkgWYQ=;
 b=RUmQmtw5TVqwl3SvebzgzJQjIXxjw7f8g6HYDYWm9tKet80pX3NZU2KW5HBIBOcGsbt0TF
 hoZlVKYoXwsgtndTwk8M+sW9fNd5+CPoEUphd3kVjy1ElvjKVWFyOHq1M2xA0lwMRUASaf
 wSUSCLagE+99KjUYjoA2ubrMQ9iyCfuO5mV/NNiibzBbVUdQwOBaW96h1C2HjzhGwpuhVR
 5mWWvpkQM/ruITRJp2VFiIqbwmSK4UiSqdjt+pmk39U5cDAg7vHCm18CnLWYHTuZxqHdhD
 FHtX9WD+bwo1qrpDZub6bE7bPXJF3LwiZnpFjbCjvY5g4HP4dk6YjrhGe2Y08w==
Date: Fri, 31 Oct 2025 16:51:55 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/5] net: phy: aquantia: refresh format
To: Beiyan Yun <root@infi.wang>, u-boot@lists.denx.de
Cc: Yao Zi <ziyao@disroot.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Siddharth Vadapalli <s-vadapalli@ti.com>
References: <20251031152348.60571-1-root@infi.wang>
 <20251031152348.60571-2-root@infi.wang>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251031152348.60571-2-root@infi.wang>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: z9964u617br6suh33hjxjxf31hf7yi44
X-MBO-RS-ID: 7bb58d59a33518310e1
X-Rspamd-Queue-Id: 4cylpn2Py0z9tvt
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

On 10/31/25 4:21 PM, Beiyan Yun wrote:
> Refresh format using clang-format.
> 
> Signed-off-by: Beiyan Yun <root@infi.wang>
> 
> ---
> 
> Changes in v4:
> - New
> 
>   drivers/net/phy/aquantia.c | 159 +++++++++++++++++--------------------
>   1 file changed, 75 insertions(+), 84 deletions(-)
> 
> diff --git a/drivers/net/phy/aquantia.c b/drivers/net/phy/aquantia.c
> index 903fcd667f6..439c4c48bdc 100644
> --- a/drivers/net/phy/aquantia.c
> +++ b/drivers/net/phy/aquantia.c
> @@ -18,28 +18,28 @@
>   #include <asm/byteorder.h>
>   #include <fs.h>
>   
> -#define AQUNTIA_10G_CTL		0x20
> -#define AQUNTIA_VENDOR_P1	0xc400
> +#define AQUNTIA_10G_CTL 0x20
> +#define AQUNTIA_VENDOR_P1 0xc400
>   
> -#define AQUNTIA_SPEED_LSB_MASK	0x2000
> -#define AQUNTIA_SPEED_MSB_MASK	0x40
> +#define AQUNTIA_SPEED_LSB_MASK 0x2000
> +#define AQUNTIA_SPEED_MSB_MASK 0x40
#define<space>MACRO<tab>0xvalue

is perfectly fine format.
