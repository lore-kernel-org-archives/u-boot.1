Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1EFBFF885E
	for <u-boot@archiver.kernel.org>; Mon, 27 Apr 2026 13:40:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5197E83AA9;
	Mon, 27 Apr 2026 15:40:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="YSD1rvEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BC3783BC4; Mon, 27 Apr 2026 15:40:47 +0200 (CEST)
Received: from mx.nabladev.com (mx.nabladev.com
 [IPv6:2a00:f820:417:0:178:251:229:89])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A22AF80433
 for <u-boot@lists.denx.de>; Mon, 27 Apr 2026 15:40:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=nabladev.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marex@nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 4235C109D7A; Mon, 27 Apr 2026 15:40:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1777297244;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=ktvZSKcRfxlHyna4Fuwc009HSu8a0219QRLpkTRFJxw=;
 b=YSD1rvEUb1UxU5rZn7biKnq3yNfkQprrZIB15k4ynT9h+sndHcanBt0WUVGCtKmfqoeWqX
 RQz7NMfnQYpz72F6S2jFKiS/iq7d7L9TcixxAvO5X7GlNTW2Erru+87k/RlMk8KA4BZR2D
 DLYstiu+47OKJ+fAN6z0W5ObvAMt2rURgygajw9lwA1K96CoZB0LuAl0do2qirWSET6tTC
 J+++A9CSFombiQvUBR1qaZhQxZjjKZpypXQfaa4bZVHjItZX2CRAi2BlACnDPr5oEa5yFj
 tKZlQxXelW9PYnS6fbjbfzp3efIgiWq5X9EReTQETNBMBI87bHUHSgsqoG7QSg==
Message-ID: <9f07c0ed-0d0c-462e-b237-146f641dffb7@nabladev.com>
Date: Mon, 27 Apr 2026 15:40:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] imx9: scmi: soc: Add support for detecting
 primary/secondary bmode on MX95
To: Fedor Ross <fedor.ross@ifm.com>, "NXP i.MX U-Boot Team"
 <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jacky Bai <ping.bai@nxp.com>, Rasmus Villemoes <ravi@prevas.dk>,
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>,
 Ji Luo <ji.luo@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>
References: <20260427-b4-imx95_img_set_sel-v2-0-b5d760ebc89b@ifm.com>
 <20260427-b4-imx95_img_set_sel-v2-2-b5d760ebc89b@ifm.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260427-b4-imx95_img_set_sel-v2-2-b5d760ebc89b@ifm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 4/27/26 3:32 PM, Fedor Ross wrote:
> Implement the 'getprisec' subcommand of 'bmode' command for i.MX95 by
> reading out the ROM log events. This event is set by the BootROM if it
> switched to the secondary copy due to primary copy being corrupted.
> 
> Signed-off-by: Fedor Ross <fedor.ross@ifm.com>
Reviewed-by: Marek Vasut <marex@nabladev.com>
