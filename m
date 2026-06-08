Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BD4CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 09:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A8DD8405A;
	Mon,  8 Jun 2026 11:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ghK45Xhy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 913238466E; Mon,  8 Jun 2026 11:28:06 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9558083EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 11:28:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id ADF4343840;
 Mon,  8 Jun 2026 09:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E24061F00893;
 Mon,  8 Jun 2026 09:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780910882;
 bh=6drKdD52vKQRQ9G/im/fcjWvD1D53MWNlzA4kpHMNaE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ghK45XhyWwKwpa+UGamc7kCctrNaL3efAj/8k4FamYoYBA4OMIl4lQlfsQoOb4G4h
 Am51yzBYi8ggFVK0XZ9binOf+aFam4UeIdmIe0HcZGGM7ZDgVA/HlvAKXY5RLDugvn
 CxSVHUxHUMbQJK41sQC2OEzzXeCYVHh6miZfSMHATPeQu0H6Y/NVK3a6EH3Y7jGGXe
 twQg3qU+tg8ThF7Ga5iThfyO/fIiH6nO36buCm3s++tSwjb2hEZAVrjC6blOkBwbbq
 Ll0kT4sgFfZ9djG+xKQoZ3BCyZ1q51Q3UuTzC2q2BChENGvtqg2HA5GJ6Vfkxx63Bn
 wvvB13M2NnZDA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Francois Berder <fberder@outlook.fr>, u-boot@lists.denx.de
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Peng Fan
 <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Jaehoon Chung
 <jh80.chung@samsung.com>
Subject: Re: [PATCH] fastboot: Fix blk_dwrite error checking
In-Reply-To: <BESP194MB2805BBD03E7C92727F116585DA0D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
References: <BESP194MB2805BBD03E7C92727F116585DA0D2@BESP194MB2805.EURP194.PROD.OUTLOOK.COM>
Date: Mon, 08 Jun 2026 11:27:59 +0200
Message-ID: <87a4t5xty8.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Francois,

Thank you for the patch.

On Sun, May 24, 2026 at 21:25, Francois Berder <fberder@outlook.fr> wrote:

> blk_dwrite() returns the number of blocks written.
> The code was only checking if the return value was different
> than 0. Hence, partial writes were considered successful.
> Fix blk_dwrite error handling by checking that all blocks
> are written.
>
> Signed-off-by: Francois Berder <fberder@outlook.fr>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
