Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E448CEACF0
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 23:09:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E192D841CD;
	Sat, 15 Nov 2025 00:08:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rthOrX8k";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="F4loeDxD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF65B8429E; Sat, 15 Nov 2025 00:08:57 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10814840B3
 for <u-boot@lists.denx.de>; Sat, 15 Nov 2025 00:08:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4d7XrR5WXLz9tQG;
 Sat, 15 Nov 2025 00:08:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763161735;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5wlc1z5+EB05VeGve0TkXZmRgBc2hTRHyjXKkKOWl4=;
 b=rthOrX8kFixTRYsDJbMSLHkYyQwQQnm2q8iVSJ2xLRz/x6ngSP4FfjblMTPtIiHIzV0KJq
 mrvMpDfUZ0ZRQRNDX8Zd6FVGs+RtZYuhvESEnIYxEiTWHwFWqGIGKQ4IL1tgHzAcdYEpMF
 RpHT2GLxK/dqA1xUaDnDv0qK+NyfIsafjhoZHgX8iMxCu4XpTFxLQROqLAA2VW8e5AXpiU
 F4+RemX83UHLggwJBMaReYn5OHi4ulgFWfcs42mHuygwqGbLQCttB3JWpBE+527sRMgdx1
 UjzMTWeSUhRjHDdjktYrbeUkRxGTN5PkAqGvwnaiH/FhhJcnJgkSpZmC5iv7bw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=F4loeDxD;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <4a71038b-ce5b-4119-9493-4e33642a8528@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1763161733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l5wlc1z5+EB05VeGve0TkXZmRgBc2hTRHyjXKkKOWl4=;
 b=F4loeDxDOvyVEdyEEtr2kzSYTNP7lGC5MrfiwXxA2xoW89TR7Lo7QuNrV6iYX7CYrBhfcS
 /K+8uFu9wtHbBQ5qHattARu210CYCmFHcsLxowy54yD5V2nowyJ3HjZzq2pGEE6cxWPdHC
 GL1XUgANUVdwNvoHptQe9fZs7vaVvQ50Cdb43E8fXltj46QmWCHI9uumg1vw9zXBg8c8f4
 Lot6z45bBFfPNOlXIPJwQvGhvSLvW4s9iprQZgSz7IuO32ppCerp9ma28bPlIqX60LEvua
 XnxV0/ZvrPKsvElfUFaVVmoTgSf8RSWuGX56rkD/cD56jQjAn68oRTaisaxpHw==
Date: Sat, 15 Nov 2025 00:08:47 +0100
MIME-Version: 1.0
Subject: Re: [PATCH 2/6] clk: scmi: Force call of scmi_clk_get_attribute()
 during probe
To: Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de
Cc: Patrick DELAUNAY <patrick.delaunay@foss.st.com>,
 U-Boot STM32 <uboot-stm32@st-md-mailman.stormreply.com>,
 Alice Guo <alice.guo@nxp.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Tom Rini <trini@konsulko.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Leo Yu-Chi Liang
 <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Michal Simek <michal.simek@amd.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Yao Zi <ziyao@disroot.org>
References: <20251114154259.4035206-1-patrice.chotard@foss.st.com>
 <20251114154259.4035206-3-patrice.chotard@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251114154259.4035206-3-patrice.chotard@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 254c8cfdd1b2c6f48e9
X-MBO-RS-META: 96kwebzjrjbdp7czmgecwg85ui1rb18n
X-Rspamd-Queue-Id: 4d7XrR5WXLz9tQG
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

On 11/14/25 4:41 PM, Patrice Chotard wrote:
> Since commit fdb1bffe2827 ("clk: scmi: Postpone clock name resolution"),
> all clocks which are parent clocks are name "scmi-%zu" which
> leads to error during their children clocks registration.
> 
> In order to not cancel boot time optimization done in
> commit 3547e315c188 ("clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES"),
> choice has been done to re-introduce scmi_clk_get_attribute() call
> during scmi_clk_probe() under new CLK_SCMI_FORCE_ATTRIBUTE flag.
> 
> This restores boot on stm32mp13 and stm32mp2 family boards.
> 
> Fixes: fdb1bffe2827 ("clk: scmi: Postpone clock name resolution")
SCMI spec says that clock IDs have to be monotonic and incrementing, 
without gaps . This driver registers all SCMI clock for you exactly this 
way. What exactly is the problem on STM32 ? Are you maybe missing some 
reparenting somewhere else ? Maybe the clock parent resolution should 
happen when the clock are first used, just like attributes are now 
resolved when the clock are first used ?

This kind of a workaround with Kconfig symbol is not the right solution.
