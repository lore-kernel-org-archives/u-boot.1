Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADAC5C2A069
	for <u-boot@archiver.kernel.org>; Sun,  4 Jan 2026 04:34:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8371483C19;
	Sun,  4 Jan 2026 05:34:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="kxupJUJq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66B6E83BF1; Sun,  4 Jan 2026 05:34:12 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D92483AAD
 for <u-boot@lists.denx.de>; Sun,  4 Jan 2026 05:34:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dkPhb201jz9sxM;
 Sun,  4 Jan 2026 05:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767501247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wKwjht+AvvOm2EV2GS3+HySQi1hAeuLyePz8ndxPzTo=;
 b=kxupJUJqAe5+rvsPlKE0ZX0L4kZOEQVrRr0g9GTooyGfbphZvIG9Ka5cgEC5TENGDj7W36
 2mAxDWJwYXxST2yG+iX0S/USn3k7n27Yrt5bIX/vp09p8F2ahAiq28EfK+ee9TzKKoWVtQ
 pc97uui4Y6VnD/ZAd6GTHZwaoDaL9r8AprNusyKFe4Y2JIG//We8K9rTk13/TTRVqn6otq
 XBmLR9TXLUyDJeQErevuQhNY5iGAEC2i2HUbNj3bJX3jEZIvkcQM5KVrUo0Z7UeQ3KAeka
 5wfSColKnBKTanwalfst4Gn8n8e6HXbMLvqV9pW8jacB0Z+TU8X6oImxjfnSjQ==
Message-ID: <53502790-25e2-41ca-989d-8823a5e04526@mailbox.org>
Date: Sat, 3 Jan 2026 19:05:20 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 2/2] usb: dwc3-generic: add support for exynos7870
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20260103-usb-dwc3-exynos7870-v2-0-67441680d287@disroot.org>
 <20260103-usb-dwc3-exynos7870-v2-2-67441680d287@disroot.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260103-usb-dwc3-exynos7870-v2-2-67441680d287@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 254bf7324948af3f60f
X-MBO-RS-META: 4q964bfq1rd7hpancuyx5famq5io3oy7
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

On 1/3/26 1:28 PM, Kaustabh Chakraborty wrote:
> Exynos7870's DWC3 glue layer is quite simple, consisting of a few
> clocks, which is handled by this driver. Add the compatible string in
> here.
> 
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
