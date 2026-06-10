Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2504CD8CB9
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 12:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DBC1848DC;
	Wed, 10 Jun 2026 14:21:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="eKQTHRlB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 615C1848BC; Wed, 10 Jun 2026 14:21:55 +0200 (CEST)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B68A848DC
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 14:21:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stefan.roese@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org
 [IPv6:2001:67c:2050:b231:465::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gb4dn5cNTz9v64;
 Wed, 10 Jun 2026 14:21:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1781094109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJ8aN1Ts69hfuj3oMIXLqC7NlXkKCjknqjfnm51BkKQ=;
 b=eKQTHRlB6NhauOvHYFuPyxE0gJF/u1b9gPqQ3wfF8jC6NHYkVI81jgtPsuMe8trBiq3+Co
 o7nJAuCIK9hyfkybTC0jC+0IQnLb89aLT1D3oYdMdKgUT+AKlidYfvP5LqPAUYc1RGa4Zf
 mr6HMWyxqqkFty7G/fTQynpE9OFKUmqagPxykFCl2DJMmHb6sAtrYpqpMS88UC1TmVgoH2
 8+oR59QUE1D1MshOHmc1UeU2C2NEN14UsCbP1M2hTT1rW5aMVWG4B6qzKLqTQmzWLhdDPa
 F5My58IstpUnj8QfMfUpXUnaH5RUOC9135RcOSiotXnEqFl4tAzYqbprj6kZKw==
From: Stefan Roese <stefan.roese@mailbox.org>
To: Vincent Jardin <vjardin@free.fr>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v3 3/5] board: freebox: nbx10g: add emmcboot for dual-bank
 eMMC boot
Date: Wed, 10 Jun 2026 14:21:29 +0200
Message-ID: <20260610122132.2674311-13-stefan.roese@mailbox.org>
In-Reply-To: <a4e3b37e6a02f949b02386166040f9add8e75925.1778247592.git.vjardin@free.fr>
References: <cover.1776762022.git.vjardin@free.fr>
 <cover.1778247592.git.vjardin@free.fr>
 <a4e3b37e6a02f949b02386166040f9add8e75925.1778247592.git.vjardin@free.fr>
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: u79hhwrqmdq5j4grd5h6oxiajnrwmwy9
X-MBO-RS-ID: fd7f2c769376be624a7
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

> Add the emmcboot command as board-specific support for the Nodebox 10G.
>
> This is a legacy boot format that has been in production on this board
> for many years so it cannot change anymore. It implements a dual-bank
> boot system for reliable firmware updates:
>
> - Bank0: Stable/fallback boot image
> - Bank1: Newer/test boot image with reboot tracking
>
> The boot order depends on the nrboot counter stored in eMMC:
> - Healthy state (counter < 4): Try Bank1 first, then Bank0
> - Degraded state (counter >= 4): Try Bank0 first, then Bank1
>
> Each bank stores an image tag with CRC32 validation. The counter uses
> a bit-counting scheme for wear leveling and tracks consecutive failed
> boots to trigger automatic fallback.
>
> Signed-off-by: Vincent Jardin <vjardin@free.fr>
> Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Applied to u-boot-marvell/next

Thanks,
Stefan
