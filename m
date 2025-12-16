Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBFBD609B1
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 15:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0DC480325;
	Tue, 16 Dec 2025 16:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="StSBeW1N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C105083623; Tue, 16 Dec 2025 16:40:23 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 20AE680107
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 16:40:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4dW1N24QqWz9tPv;
 Tue, 16 Dec 2025 16:40:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1765899618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+cOUqsuZ1D/Zd5CaPXtQN/jKhkHur7GO9rOIveedFn8=;
 b=StSBeW1NYs4T0yHQq6yZsF48GR7AdGZE1lXgBxXPd8iVjv4BVCOWykrhh3++eCIeJ+XtQX
 YM3hnhM0v8Etma1eCTPihTC9JmctsBD9c2K82joZ7xmi4sNiLw2j1b3qLGrB6wreN+i2fB
 sv0FglXpKcWme0pzY4ozOMcH2V4r+WSD4suWNqzE742LKFQBN02TItcDZH0VvAhJ0l55/u
 KiaQy5+De9AWyvK4FNyBOdFwQK9jUEFF6Qt4MUusWC95tC7n5ck6xUzsVbI8gd4UXWnP4l
 mKeKeKD3II1uCEzTVAMghOgi1bm4RllJfkHiJx5Gk5DLoNjlJKf5HejgQywsjA==
Message-ID: <a9c78f0b-ec57-4af6-b577-3c6570d31b7a@mailbox.org>
Date: Tue, 16 Dec 2025 12:13:21 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] usb: dwc3-generic: allow fallback of dr_mode property
 to "otg"
To: Kaustabh Chakraborty <kauschluss@disroot.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>
References: <20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org>
 <20251017-usb-dwc3-exynos7870-v1-1-fe46e2ed1908@disroot.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251017-usb-dwc3-exynos7870-v1-1-fe46e2ed1908@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: c4d1c7900a45479d7a0
X-MBO-RS-META: f61wojgrgxihatfccwmg1sap85oj68ec
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

On 10/17/25 5:30 PM, Kaustabh Chakraborty wrote:
> Documentation [1] states that the default value of the dr_mode property
> is "otg". In this driver however, this case is not handled. Add simple
> logic to fall back to USB_DR_MODE_OTG if its reported to be
> USB_DR_MODE_UNKNOWN.
> 
> Link: https://elixir.bootlin.com/u-boot/v2025.10/source/dts/upstream/Bindings/usb/usb-drd.yaml#L23 [1]
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
How does the driver end up with "unknown" state in the first place ? 
What is triggering this problem ? (this should be in the commit message)
