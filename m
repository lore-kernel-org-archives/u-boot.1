Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3840ECD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:22:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 822008493F;
	Wed, 10 Jun 2026 14:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="WkrEH7HC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05A3E848C5; Wed, 10 Jun 2026 14:21:41 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FDD2848D1
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gb4dY3j7Tz9v0r;
 Wed, 10 Jun 2026 14:21:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hG4GX8JvL96aMiQP/tYb1fGJ/9fcWDb/mkT4EFvjqg=;
 b=WkrEH7HC767qbpY8o7eBoTlV6y8cmqiLZMCH8VJTKnl8eq8vMV59CPWV6hCqUXoxIp8qgs
 B/xWrN7MwwdZTVnp5O1qO/ba5wDwYXPd+gvNZYDOS7IqgNDAYiELiatJVJWoVb6Qrts+77
 X7S5fkm+W45Tms6mh8ru8Dbx9aDuMIHteAoOtDbUpB/AqfNiKznc33m/azLzyoOg7gwXNd
 IMnpkK0l+4kz7TUkvuyD/9gOHuusqsm14CIsouwest6IhehCxcOf/6JfRjGYVFkBzGbyzU
 C7xcpZv9XWXBZvAFVZuSVOtF5IXMj1UrAp7qp6qnI/CVcitxSCK/VMG9HlPCpg==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Chris Packham <judge.packham@gmail.com>,
	trini@konsulko.com
Cc: u-boot@lists.denx.de,
	Sean Anderson <seanga2@gmail.com>
Subject: Re: [PATCH v3 1/3] mtd: nand: pxa3xx: Pass valid dev to dev_err()
Date: Wed, 10 Jun 2026 14:21:19 +0200
Message-ID: <20260610122132.2674311-3-stefan.roese@mailbox.org>
In-Reply-To: <20251218225936.2016920-2-judge.packham@gmail.com>
References: <20251218225936.2016920-1-judge.packham@gmail.com>
 <20251218225936.2016920-2-judge.packham@gmail.com>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 3y98rdyj64zpk1wsbf7hmg8qujb71n3f
X-MBO-RS-ID: 1d384f3467c063578ba
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

On 12/19/25 11:59, Chris Packham wrote:

> info->controller.active is not initialised so the dev_err() call ends up
> dereferencing a null pointer causing a crash instead of outputting the
> error. Add a dev member to struct pxa3xx_nand_info and use that instead
> of info->controller.active->mtd.dev.
>
> Fixes: 661c98121d49 ("mtd: nand: pxa3xx: Fix not calling dev_xxx with a device")
> Signed-off-by: Chris Packham <judge.packham@gmail.com>

Applied to u-boot-marvell/next

Thanks,
Stefan
