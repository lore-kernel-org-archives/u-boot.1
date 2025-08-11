Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F22FC87FDB
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 14:22:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6B3C832BF;
	Mon, 11 Aug 2025 16:22:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oMzF/3wN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAB55832C8; Mon, 11 Aug 2025 16:22:39 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D155F83013
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 16:22:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4c0xfz5yfsz9smW;
 Mon, 11 Aug 2025 16:22:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1754922155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/bynT6l3jIi2lvAX8t8ut2qos2ubC/8mrEPMj4qrUw=;
 b=oMzF/3wNs1ahFnNyfcQIdVPnAK3Jk8d4s0EpHkMwXpfK/pEW0rvy82j5p1MdEda/hBvpht
 4X6AxQLfSzIXukIOseSLv0n3nbCMviMVLmmYqGYE4KGG2qPAxQd0uZQW+71bMLhVo7smvQ
 xO3oH9+xPJrKTTNf9fXAGXNCiaqsSsBFZ6o6MiIOHkBKS2Ks/rP9HWu175KktgYP+K1VEp
 yzVBvqJw2Fg1nuJddtQyy/IwtanZ6TZcd1iwDuwe1A6I4rG7kPV8LWoJVWbwT1sVElVjMP
 FlF4XBxaeFY5W9p4VKNrtgQs/p4DENf9SZt8OCPoX4GX6wcodjDJ2C7F5jr2zw==
Message-ID: <ad506f26-975e-47bc-85f5-41a9db1ac1ac@mailbox.org>
Date: Mon, 11 Aug 2025 16:22:33 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 5/6] arm: dts: imx8mp-data-modul-edm-sbc: Remove
 deprecated sd-vsel-gpios
To: Frieder Schrempf <frieder@fris.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
References: <20250811131213.211124-1-frieder@fris.de>
 <20250811131213.211124-6-frieder@fris.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250811131213.211124-6-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: d341849330b274c90e3
X-MBO-RS-META: t61oohu9om9fsawohquy8rtmu8wog1c4
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
