Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D431CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 05:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A83C8391C;
	Tue, 28 Oct 2025 06:25:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="XnsIegE4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF89383976; Tue, 28 Oct 2025 06:25:20 +0100 (CET)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 781FB838F8
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 06:25:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=hs@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id BFD53106D53; Tue, 28 Oct 2025 06:25:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1761629117;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=eunDqbcfdMaEnpkGQUdLI5xjjqeJDWX4JNSqwNEDca4=;
 b=XnsIegE4v9CLIkz5wkHsG9iQLU5y+88Siu4l0N1iPxowGgHb1zFRNOWoSoXrKTAFNTz910
 7lHEUelfi4VHt7PLQgtIq7VgXz43wJ48NznBo4WFElmaTrz+1cyzos+gwUmAQb4NNFA9Oi
 62xa0AuYgvEEc6Uqge404BhgM0mMvbvpTotvnmMyLOBU6tLN1TYk8wny3ebNyIb0jywzgt
 f0ZV3sPKGR+j6150eEkB/Gycsu8c89UJQVNO8IrAmEA5OT/eQwxaXtTGmgRHYbAGzU9T/2
 SBLYRiKU7A3uhZGcBcwU/WLVFRirCjb1W7dSGcJHpmm5leWCAz/I2YicrDz7Aw==
Message-ID: <52939ad9-ef5a-14c4-003b-892b9794c9c8@nabladev.com>
Date: Tue, 28 Oct 2025 06:25:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] i2c: rcar_i2c: Add R-Car Gen5 support
Content-Language: en-US
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Minh Le <minh.le.aj@renesas.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20251027163826.11785-1-marek.vasut+renesas@mailbox.org>
From: Heiko Schocher <hs@nabladev.com>
In-Reply-To: <20251027163826.11785-1-marek.vasut+renesas@mailbox.org>
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

On 27.10.25 17:38, Marek Vasut wrote:
> From: Minh Le <minh.le.aj@renesas.com>
> 
> Add support for R-Car Gen5 SoCs into the driver.
> I2C on R-Car Gen5 is treated the same as Gen3 and Gen4.
> 
> Signed-off-by: Minh Le <minh.le.aj@renesas.com>
> Signed-off-by: Hai Pham <hai.pham.ud@renesas.com>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org> # Tweak commit message
> ---
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Heiko Schocher <hs@nabladev.com>
> Cc: Minh Le <minh.le.aj@renesas.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   drivers/i2c/rcar_i2c.c | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Heiko Schocher <hs@nabladev.com>

Nitpick, dummy question below...

> diff --git a/drivers/i2c/rcar_i2c.c b/drivers/i2c/rcar_i2c.c
> index 3bd5108fd23..9562119bb5b 100644
> --- a/drivers/i2c/rcar_i2c.c
> +++ b/drivers/i2c/rcar_i2c.c
> @@ -368,6 +368,7 @@ static const struct udevice_id rcar_i2c_ids[] = {
>   	{ .compatible = "renesas,rcar-gen2-i2c", .data = RCAR_I2C_TYPE_GEN2 },
>   	{ .compatible = "renesas,rcar-gen3-i2c", .data = RCAR_I2C_TYPE_GEN3 },
>   	{ .compatible = "renesas,rcar-gen4-i2c", .data = RCAR_I2C_TYPE_GEN3 },
> +	{ .compatible = "renesas,rcar-gen5-i2c", .data = RCAR_I2C_TYPE_GEN3 },
>   	{ }
>   };

.. I cannot find this new compatible node in U-Boot

$ grep -lr "renesas,rcar-gen5-i2c" doc/device-tree-bindings/
$ grep -lr "renesas,rcar-gen5-i2c" dts/upstream/
$

nor in current (v6.18-rc3) linux tree... is there already a patch
for linux, which introduces it? But is seems trivial to me, so I
am fine with it.

Thanks!

bye,
Heiko
-- 
Nabla Software Engineering
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Geschäftsführer : Stefano Babic
