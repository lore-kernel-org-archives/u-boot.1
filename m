Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67FFCAC592
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 18:47:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5A0832F9;
	Mon, 22 Sep 2025 20:47:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="n/5kgzN6";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wHsYoR6a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B3679833ED; Mon, 22 Sep 2025 20:47:31 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7CCB183211
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 20:47:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cVsYF0sR2z9sr7;
 Mon, 22 Sep 2025 20:47:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758566849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFydSxYQ7vrFgknXBBEVOeXDKrh/LBHaXb2ICe8shhk=;
 b=n/5kgzN6lCfuK37nD/TeTXufiHJ3oEyi4mLt+apnWgz0KmQkP8rZxxrQz/UsCGMKRJJmIF
 aw0XK6Lwi/DI2tFFCWpaDgcZytY+8IbzvzLidd5LScxFJvl6Wab4ulNCRDi9ERli2qQQmY
 4sn9IVi0wek9z5ba6guyutsdwMJ+ym99OGmicHe1dkRsliWUYiezoj7cqoUdYLXkjxk3Ms
 txgsxrNrBaCOKNq8DNfUDMqBsxZau3v34mEKPtpizL8mrTCZE3z6BuBpIBebbfwFd5bAre
 WBqDLAsQveKQBCXI5SG5aQJNDxoNiZZ8GyflTFkRxfuEAWeCg4eqzDALmV1Lfw==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wHsYoR6a;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=marek.vasut@mailbox.org
Message-ID: <e05c9282-1736-4056-97b7-939b913dbfd4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1758566847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFydSxYQ7vrFgknXBBEVOeXDKrh/LBHaXb2ICe8shhk=;
 b=wHsYoR6abH8TYuVT4u+jCuy4ug7y+Gn2uABH7x2NKOnKHKnLUjHbYGB2XDIMtn7rPnMTSg
 2K54JszlC3q+Xa7FvoxIagnRrXxBHgHJ87R/CmY7wRQ+VJFGn5KO/gANOCjMCqOzThXLTv
 Rixn5Hg8vXZfGmh5M12w6IYH/AwffBpggIBgqZ5nTgF2F2VAQ1T4mdGoaAobk1xpihW56K
 PeTR37PxapgIR87KlpJAST+qeGzzKN57Z8r2Q7VNlakwvQhX7p0iAXLN3Wdbw2mPKlxiDY
 n4gktMmnHNdMa4BtbFsQGdTYxJa1eK4i9cucNsjdKvwsMvNzSo7MzBGa5jpQYw==
Date: Mon, 22 Sep 2025 20:47:24 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3] env: spi: Fix gd->env_valid for the first write
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com,
 Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass <sjg@chromium.org>
References: <493603eba5d4eabf2b281e1f438fd19fc0587712.1758557017.git.michal.simek@amd.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <493603eba5d4eabf2b281e1f438fd19fc0587712.1758557017.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 9c1859784aaf308f3e6
X-MBO-RS-META: pp4i9oyju4otxsgeyb3yuzexyac4xxt1
X-Rspamd-Queue-Id: 4cVsYF0sR2z9sr7
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

On 9/22/25 6:03 PM, Michal Simek wrote:
> When both SPI environment locations are invalid (gd->env_valid ==
> ENV_INVALID), the first call to saveenv writes to the primary location and
> sets the active flag. However, the logic for updating gd->env_valid
> incorrectly sets it to ENV_REDUND, which does not match the actual location
> written. This causes the first two writes to target the same location, and
> alternation only begins after the second write.
> 
> Update the logic to alternate gd->env_valid based on whether the last write
> was to the primary or redundant location, ensuring the first write sets
> ENV_VALID and subsequent writes alternate as expected. This aligns
> env_valid with the actual storage location and fixes the alternation
> sequence from the first write.
> 
> With this change, the "Valid environment" printout correctly reflects the
> active location after each save, and the alternation between primary and
> redundant locations works as intended from the start.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>

Reviewed-by: Marek Vasut <marek.vasut@mailbox.org>
