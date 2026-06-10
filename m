Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CCCCD8CB2
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:23:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8688284979;
	Wed, 10 Jun 2026 14:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="vc7bp6NO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 62708848BC; Wed, 10 Jun 2026 14:21:56 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81913848BF
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gb4dp5cqwz9v06;
 Wed, 10 Jun 2026 14:21:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TVr9vD/rcOXpmDW5oY/IwKPS3ZGmts5c7YoyV7peAEo=;
 b=vc7bp6NOxfFO1qgQGDE+4aBCr/uu2LuWEonfE68udhAtrpyS78znCzET5UxLTRlPKqpOox
 ZHUpUvqIaA6NEo5JuFXXUBtA6whlgZnHl+4x1JQXTlfIStreCWfn9LfYSHFJSz0j2VIw3L
 VM8b9oFSfw/PaGWaTc/G5UVojm9racIn4PqT1momD2wu+vfe4rfK5C7f+jlQaXwssez/nT
 D75WeLoHM4bEe+5i4kwdku/H41BUHgum9k7UzpfyjutqbYm1bcZvMz9Neow2cY+S3LcYVl
 fRP/4OISSLQEmpD3WpZNC7mEcXbpLMyBzS7nFLk73F9kNfDBP8B5v88QnWEBaQ==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Vincent Jardin <vjardin@free.fr>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 4/5] board: freebox: nbx10g: add device serial and MAC
 address initialization
Date: Wed, 10 Jun 2026 14:21:30 +0200
Message-ID: <20260610122132.2674311-14-stefan.roese@mailbox.org>
In-Reply-To: <d036fdc1da96fac3f14c1874991d05100efe51b2.1778247592.git.vjardin@free.fr>
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr>
 <d036fdc1da96fac3f14c1874991d05100efe51b2.1778247592.git.vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 69ce9c4bff677052f75
X-MBO-RS-META: 7cny1rfcky14weaixiuy1thimjuwkn9i
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

On 5/8/26 15:54, Vincent Jardin wrote:

> Read device identification data from a dedicated eMMC region. This
> provides:
>
> - Unique device serial number for identification and tracking
> - Factory-programmed MAC address for network interfaces
> - Bundle information for device variant identification
>
> The serial structure includes CRC32 validation to detect corruption.
> On read failure or invalid data, sensible defaults are used to ensure
> the system remains bootable.
>
> The fbxserial command provides two subcommands:
> - fbxserial show: Display serial info (default)
> - fbxserial init: Initialize ethaddr from serial info
>
> Use CONFIG_PREBOOT="fbxserial init" to automatically set MAC addresses
> during boot. This approach avoids patching shared board code.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Applied to u-boot-marvell/next

Thanks,
Stefan
