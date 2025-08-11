Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FEEC87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 14:22:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 90057832BF;
	Mon, 11 Aug 2025 16:22:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="hYZSe75M";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D68A832C8; Mon, 11 Aug 2025 16:21:59 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5B99883013
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 16:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4c0xfC3hjBz9shX;
 Mon, 11 Aug 2025 16:21:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754922115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4VcMh9RPaV8DcRte9NZtap2mIlwfebYSQFgnxUW2o4=;
 b=hYZSe75MHVuQ/d9mtw2D3ZFEKKPsEMiq2RyJgJzdQNSrSyuu9ZWtnn4AcE2FKCFEnQg9eZ
 BtU22pso8A9AveKAP3x1gqFLJzEfy227ldmW1pDrKP7ifytyR5xz6aaNlZSqANhwQt12BP
 d94qIi8/ydVAcJla+fxlf8MDghWoLzQ4LiqaVGJDmVgN28pnhgeDyniTJV7crR3VRoo9g9
 GkQR1WpSQMMvgClP3Yks/uwkBkSUjOhpXAaPzkjT97h00C/Pixwg7/rsmJ2Otf8Bi5dRQR
 ItD6L0G0aznmpF3uWdNc3Kw8xfCrRnz1OqrWiGgMxo5F/psV1ucK1qd0HXtDkA==
Message-ID: <89c2aeff-bfa9-43fd-8b33-df37e116674c@mailbox.org>
Date: Mon, 11 Aug 2025 16:21:53 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 6/6] arm: dts: imx8mp-dhcom-som: Remove deprecated
 sd-vsel-gpios
To: Frieder Schrempf <frieder@fris.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>, u-boot@dh-electronics.com
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20250811131213.211124-1-frieder@fris.de>
 <20250811131213.211124-7-frieder@fris.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250811131213.211124-7-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 6gbxqjqpacpnetcgwqa4ta3pj37ojya3
X-MBO-RS-ID: 3d4e5185edfac6e56d7
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

On 8/11/25 3:12 PM, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> The sd-vsel-gpios property in the root of the PMIC node is deprecated
> and therefore not parsed by the driver anymore. We can safely remove
> this as it wasn't used anyway due to the pad not having the correct
> pinmux settings.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>

I'll eventually finish switch of two leftover boards to OF_UPSTREAM and 
drop this whole file, thanks for the reminder.
