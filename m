Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF53CD8CAA
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 10:53:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F412B84942;
	Tue,  9 Jun 2026 12:53:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="GK8qx2qF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA1388493F; Tue,  9 Jun 2026 12:53:22 +0200 (CEST)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A09B84911
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 12:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gZQk81bWRz9tlV;
 Tue,  9 Jun 2026 12:53:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781002400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mBEYbNZhfbLociXXjX3qtSyuiEjCjaTcO29F100/+Oo=;
 b=GK8qx2qFnEbKlC2gWOXKnyxTq/2FTxNqbo2nNHORQuwIIOGLEwjuXGZ5w0MMCGfBWDtOce
 yyWaStPhd+8XURBSqF6FMVzBdhoUDGsuJLkzKvzd/GZIJt7SjVsfzU1CYe6RdF474V3o5E
 ufrUTT3zbVIfF3ovs+yzIcr02vAmgGt55jF3LQG2DlPlRID+adunXm7eYH7X7+U5hw6Cpr
 vLmE+0orv99aPsA/tJ3HdhPoyrhbetf7bzu0uH0fNQRoLtoS/ytNuuqpoWnKCwiwRE6pex
 pROZPmNXoR+mGh/YgSm95hXrhpGX0WIPe3UjM4ygMZjpbZpGYOSYFYVV+PEfug==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Juuso Rinta <juuso.rinta@nokia.com>,
	u-boot@lists.denx.de
Subject: Re: [PATCH RESEND] watchdog: octeontx_wdt: fix DT matches to Marvell
 compatibles
Date: Tue,  9 Jun 2026 12:53:11 +0200
Message-ID: <20260609105316.1172918-5-stefan.roese@mailbox.org>
In-Reply-To: <20260504-rinta-octeontx-wdt-compatible-v1-1-660f3800d33a@nokia.com>
References: <20260504-rinta-octeontx-wdt-compatible-v1-1-660f3800d33a@nokia.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ae8e8b28ab20205e7dc
X-MBO-RS-META: gyer4rdopox6jbyonbndthe5ftrnsqp9
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

On 5/4/26 12:36, Juuso Rinta wrote:

> The OcteonTX watchdog driver currently matches arm,sbsa-gwdt.
> On systems with multiple watchdog devices this can be ambiguous since
> arm,sbsa-gwdt is a generic SBSA binding.
>
> Replace the SBSA match with SoC-specific Marvell compatibles
> marvell,cn10624-wdt and marvell,cn9670-wdt.
>
> These compatibles align with the upstream Linux device tree binding:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/watchdog/marvell,cn10624-wdt.yaml
>
> Reviewed-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Applied to u-boot-watchdog/next

Thanks,
Stefan
