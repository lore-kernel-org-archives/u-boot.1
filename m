Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CAFF43848
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 15:45:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDDC8407E;
	Wed, 15 Apr 2026 17:45:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="WNpin63l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A039984206; Wed, 15 Apr 2026 17:45:29 +0200 (CEST)
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com
 [95.215.58.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A097E83B99
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 17:45:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
Date: Wed, 15 Apr 2026 15:43:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1776267925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8TF6h5D6tUnvKrsKZzxeDMivoMuOEPv+GbGcIqBCUyU=;
 b=WNpin63lBrU7GwFX3lz6f8uj0qPq40kRbgB5Q1OvNO1jAx7dHvTjXBQ3wMt9RMROjXrkkt
 DKYSCJuNyp7z6x9PXggnnM6AhMKk1+3VZxhlJsnTc3ClUNDUdrhfnegld8iO/Emh5wSJ1n
 M2sRH3Si1xY+MStWibUvzWTlR1Xo5t6KCFaf7CkTp1tg1ibDyhriD5n04eawdSTzK+SNkw
 JYgTuTTadz2mBnwVNL6cyt+oiKOe5UDABkgUNpdtsxBU5q+czIqEEl4tFGbys7BvM4CP3S
 OHtxW2bKBmQMiK6VkwRxJmhsYfCtMhRWsS9li1KuB52Jvmmht7WRrc1D8BI74g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Ferass El Hafidi <funderscore@postmarketos.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent (TI.com) <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Anshul Dalal <anshuld@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Martin Schwan <m.schwan@phytec.de>, David Zang <davidzangcs@gmail.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Ferass El Hafidi <funderscore@postmarketos.org>
Subject: Re: [PATCH v2 0/2] Autoboot prompt customization and bootmenu
 cosmetics
References: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
In-Reply-To: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
Message-ID: <tdjl2v.1us1as3kw6qcc@postmarketos.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Migadu-Flow: FLOW_OUT
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

Thank you all for your review, I sent a v3 which is mostly untouched,
but adds a patch to convert docs to reStructuredText.

On Wed, 08 Apr 2026 16:34, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
>This is a small patch series to make the autoboot prompt configurable
>regardless of if CONFIG_AUTOBOOT_KEYED is enabled, which is very useful
>with a splash screen. My usecase is, with some ANSI magic, moving the
>autoboot prompt to the very bottom of the screen and highlighted, with a
>splash screen shown.
>Something like this: https://ircb.dersco.re/uploads/funderscore/efa2a27132e56891
>It feels wrong to require AUTOBOOT_KEYED only for that usecase.
>
>Also, the bootmenu now prints ANSI_CLEAR_LINE before each entry, which
>has the effect of highlighting the entire line entry on vidconsole, just
>like eficonfig. I can drop that one if it's not very useful, just
>thought it would look nice.
>
>Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>---
>Changes in v2:
> - Remove #ifdef/#endif near printf in print_boot_delay: no need to
>   guard the printf as CONFIG_AUTOBOOT_PROMPT must be set
> - Link to v1: https://lore.kernel.org/r/20260405-ui-cosmetics-v1-0-bffec3cac741@postmarketos.org
>
>---
>Ferass El Hafidi (2):
>      autoboot: allow custom prompt without requiring AUTOBOOT_KEYED
>      cmd: bootmenu: ANSI_CLEAR_LINE before entry name
>
> boot/Kconfig      | 30 +++++++++++++++---------------
> cmd/bootmenu.c    |  2 +-
> common/autoboot.c |  2 +-
> 3 files changed, 17 insertions(+), 17 deletions(-)
>---
>base-commit: 0da1866a8fdd4d4bc4837ef2af281dbe010ae16b
>change-id: 20260331-ui-cosmetics-aae207abed6b


Best regards,
Ferass
