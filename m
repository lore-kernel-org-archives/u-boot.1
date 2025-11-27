Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00FFD111A8
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 18:09:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C0648430C;
	Thu, 27 Nov 2025 19:09:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="BeX6ZKLc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F1D8783B03; Thu, 27 Nov 2025 19:09:52 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18B008437E
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 19:09:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dHPbK1NRpz9skc;
 Thu, 27 Nov 2025 19:09:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1764266989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xq3hVB/E/2HxrRP10zqQ5KJbvu8Pz9KRVBJSNeZxvXs=;
 b=BeX6ZKLc9BMG6BHf696EDZ84Kl8UBtxl5UV1dAFaVllGqa1uXWJ7HSGB561mUpHz6SChlV
 321knfYtY2OpcVuoLdnfgfs+DwjV++1H7cB/kqFp2Y20KO/ktVO1uaYTTc7BdLdDYS7KIq
 S+8g76NomGuA7Hc3lBB1+KsYWfMpDQbBhoG2fMEDyUUhn1XGzxfPfcZmUAlDD6aMIl61m/
 kAtbTU+vgTtmceyQnl5IIg4xZe+n4ybn4zch4vraWYWb1TVtqMjOLPoCATcP+Bd43nNH0q
 VTYn28nscdI2LrBymhunXSnjCgQVxYDDrodOeOoLsdysmq9IxWCT3E5qhKi5pg==
Message-ID: <850d9627-1928-4902-9770-2313f349e703@mailbox.org>
Date: Thu, 27 Nov 2025 19:09:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] usb/xhci: avoid noisy 'Register NbrPorts' message
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Bin Meng <bmeng.cn@gmail.com>
Cc: Andre Przywara <andre.przywara@arm.com>, u-boot@lists.denx.de
References: <20251127175425.639086-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251127175425.639086-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 4pxii1ohgswd64grq4c9wggzcy68ikag
X-MBO-RS-ID: babf470a3747a6f7853
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

On 11/27/25 6:54 PM, Heinrich Schuchardt wrote:
> We should avoid overwhelming users with non-essential messages.
> 
> 'Register NbrPorts' is a debug message for EHCI. Do the same for XHCI.
> 
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
