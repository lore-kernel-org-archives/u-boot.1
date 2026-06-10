Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78820CD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:23:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D8F484949;
	Wed, 10 Jun 2026 14:21:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="Nf6Jvr6D";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1986484954; Wed, 10 Jun 2026 14:21:52 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2DE18489D
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gb4dh3r9Gz9vLm;
 Wed, 10 Jun 2026 14:21:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9KFn8gLkzEi47GzJrx+ADtH/6hs0UPp8Cdw5Ofe5l8=;
 b=Nf6Jvr6Dxa0j3j3B35zQxeLS1NPlKkb1cNVKRtE+qG3XqkzprXQ12WZtsudauKdFphp6DO
 bJ0qlSs517Fj/9Km8HOOyxjNAz6ou1cBmVK6Mco2dgAFI6Ypa1AijX+9betsZW9CBpzKfl
 wNXiLbbC2jyytyOQG8YGEJgnbNk4HIalCxXUFMh0RMrTFuKGU+Q5JN6zXrfaPviRTNk6Fz
 VV1ZLJpal2OK7ss/HgUdOb9isD+yAz8zuVInP8ORWwRay7VaUpPcpytebzlT0x8or1Ueln
 24PmBcdIDZJQhutUWqikgwMdDmG4/+x5rWm7Bckbhxous585UHVlfuPRMIbwPw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Stefan Roese <sr@denx.de>, Robert Marko <robert.marko@sartura.hr>,
 Konstantin Porotchkin <kostap@marvell.com>, Ben Schneider <ben@bens.haus>
Subject: Re: [PATCH] arm: mvebu: Drop unnecessary BOARD_EARLY_INIT_F usage
Date: Wed, 10 Jun 2026 14:21:25 +0200
Message-ID: <20260610122132.2674311-9-stefan.roese@mailbox.org>
In-Reply-To: <20260325190022.3428531-1-trini@konsulko.com>
References: <20260325190022.3428531-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: o544wca9eokrh9rnjaexu6pppix387t9
X-MBO-RS-ID: bcc8fea056343f46b67
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

On 3/25/26 13:00, Tom Rini wrote:

> All of these platforms enable CONFIG_BOARD_EARLY_INIT_F and then have a
> do-nothing board_early_init_f function. Change to not enabling the
> option and so not needing an empty function.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
