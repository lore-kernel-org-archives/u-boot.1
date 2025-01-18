Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDECC02183
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 03:11:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C1B28069D;
	Sat, 18 Jan 2025 04:11:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="jMdnxnH/";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="ZDng+gXc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41C5F80657; Sat, 18 Jan 2025 04:11:20 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C52380657
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 04:11:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4YZhT20Qbcz9t06;
 Sat, 18 Jan 2025 04:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737169878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0EHuwTriUgvsHBDr+tjg/+3cHz7U45PMUwaC+89PFLU=;
 b=jMdnxnH/N2vNltBet1rH+v5jCjT+ge2Z0MmoZS8/n3EKdUiU+81EZllcp8cfbejhUa8DJe
 emXe9n/zwOEJ9GawNTO9RmYvpdPFTeha7zCyv0kRV/kGOrGKTjVsttS0NPp8Q7vR32uXwm
 fs3n7xHMoa7HJOjN1PImyyjTr++yVyPn06eZzS3H3hip5RCY/yf/NsLc1ZdhkF0n8P7fAz
 fTcVnYIbvlcGhFHq9nUE6vuSGMOfyJhLvncM5HeAEkphNrykcQ6SYT+ZA7r9JqdqSzzpC5
 ASdk8u3zQPk1myxrQ0Smxr0XcBkBiNoKdcsBJqgBXMoVxLHMRdLGD3LEFFifrQ==
Message-ID: <0c91cb53-b05d-47f0-b908-41698b3d9f7b@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1737169876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0EHuwTriUgvsHBDr+tjg/+3cHz7U45PMUwaC+89PFLU=;
 b=ZDng+gXcGcdQUw2rKoyIceeMOsS7wfvW4vllilev6iz/BR9ACv9xMR7jacKH4O5ONtr9Y/
 2S8vB/hYZ4+fB9JyW8/Ips5HLMNg2mHyLsbd0eE0xkbLEvcXNmKr/JIHki6u6s8fTN8D9q
 hw+NsZAPWrZL+WPiz9N53OVmOKAi52EmyXIMddJxGwCUuA38mUW1VW4qyiAUTE8opxVLNg
 whU/9x4nM4pr9n2anTvkBGIGSQ0HFVRj4lWM35GjmLVI7/Dymv6N6Og5TvbUJVtL+rL7YW
 r2jqrtEiHOxt32wgrD7vNwDE6aiZchMzlTM+2cWm65YhfNjE2LhM6tSLEYFEDQ==
Date: Sat, 18 Jan 2025 04:11:12 +0100
MIME-Version: 1.0
Subject: Re: [PATCH] mmc: Simplify poll CD logic in case cyclic framework is
 enabled
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Rasmus Villemoes <ravi@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kever Yang <kever.yang@rock-chips.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Ronald Wahl <ronald.wahl@legrand.com>, Simon Glass <sjg@chromium.org>,
 Tim Harvey <tharvey@gateworks.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20250118030857.29509-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20250118030857.29509-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 0996a9ee792a5e293b6
X-MBO-RS-META: asjsntx9qyp8eyrhwjajtxrpdrocwefj
X-Rspamd-Queue-Id: 4YZhT20Qbcz9t06
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

On 1/18/25 4:08 AM, Marek Vasut wrote:
> Simplify 90cc07fd786d ("mmc: Poll CD in case cyclic framework is enabled")
> according to suggestions by Rasmus. The struct cyclic_info is zero-size in
> case CONFIG_CYCLIC is not enabled and does not add any size to struct mmc,
> so it can unconditionally be part of that structure. This allows clean up
> of all the other conditionals in mmc.c which can now be unconditionally
> present, as they also add no extra space.
Please ignore v1 and review v2, I forgot to drop the __maybe_unused , 
fixed in V2 .
