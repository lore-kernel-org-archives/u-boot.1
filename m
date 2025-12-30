Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAF3E95A8D
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 13:37:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3BC283E0F;
	Tue, 30 Dec 2025 14:37:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="q5+n0L6O";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="b3r3zG2I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA6E83EA6; Tue, 30 Dec 2025 14:37:23 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D40283B0B
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 14:37:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4dgYzj1mGFz9t0l;
 Tue, 30 Dec 2025 14:37:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767101841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npkV/dRSwp2j8bXRgASFJl7FXgQhFtr+cMlMwQHeY5Y=;
 b=q5+n0L6OpvWMRLreOgyKJkfxO2zuPylM541zIb7Rgsa6Q4g6AvbXPJTreTvxh0XkRgzoQf
 tOpQAlLof38Na+rRiuDjzAnd21yicFtucOBQnpIedeyd7sWW+q3TG7GJCabsWGwYXCJ53d
 YsmfKWv1Q0tw1FlyxP51lZy7FxTyZmqkdxuaimZ+facbtJoIn2x6uT4KDwfjy0pVJikELi
 /qmb/tQQGbYgRxUF45JUALQqjLN6MkQ+zwubTRDHtx0fsC2jHIGDdar1u6ApxjamFlvyNC
 SvoDD0W0C9FKidnVJB3ZydM/WmIBuH8S8jVuo5L8Rbq1ZVi3YSEHnn5UdocV1g==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=b3r3zG2I;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <ce85424e-b18f-4dc7-b62b-a8220e9ed7a1@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1767101839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=npkV/dRSwp2j8bXRgASFJl7FXgQhFtr+cMlMwQHeY5Y=;
 b=b3r3zG2IWkB8N0ZBrD1u8EpC56HRp737P8vRsNW31/0xY2SmQDkK4Jfi4HzMJ/unuiOh6r
 g7vggCLULO5quKUZ4++lZMFqT5ynu4CylFHzCUapjkCtDAiy1sxBxdIxJT1p/7sxxChwAM
 qQlbqRYDhHHtmDtkKU7Hyi1Sc6Ib6fC81lvcaNuaLUH0cLZ7L/q6SkQ3FqOIo1jEb9qMt9
 +m0Bk479y3sSdbY58go+H1O/CF/2NJwKJ5Y7ID2z4gytgOOFmv9KjwS2F/6IHeNCdJWA9z
 P74TSGN3ogrGlxdbnPhLCPHF6j9PLOBKmK+LGdx14UG8FYuSI4F9LzUH6A0NKg==
Date: Tue, 30 Dec 2025 14:37:14 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: Add power stabilization delay in mmc_power_on()
To: ziniu.wang_1@nxp.com, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, bhimeswararao.matsa@gmail.com,
 xypron.glpk@gmx.de, kauschluss@disroot.org, andrew.goodbody@linaro.org,
 tanmay.kathpalia@altera.com, ye.li@nxp.com, haibo.chen@nxp.com,
 u-boot@lists.denx.de
References: <20251230103950.1543515-1-ziniu.wang_1@nxp.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251230103950.1543515-1-ziniu.wang_1@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 181d9314c4d3b89b838
X-MBO-RS-META: h6xqyjfkfhi66e8c8wbzhkwowz9tg8yn
X-Rspamd-Queue-Id: 4dgYzj1mGFz9t0l
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

On 12/30/25 11:39 AM, ziniu.wang_1@nxp.com wrote:
> From: Luke Wang <ziniu.wang_1@nxp.com>
> 
> After enabling vmmc supply, add 10ms delay to allow voltage to
> stabilize before SD initialization starts. Without this delay,
> some SD cards fail to initialize because the initial clock cycles
> are sent while power is still ramping up.
Details please. Which exact cards ? With which controller/SoC ? Does 
this problem happen on another SoC/controller ?

Without useful details, this is a NAK.
