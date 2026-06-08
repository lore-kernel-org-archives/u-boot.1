Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B272BCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:23:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 471C184154;
	Mon,  8 Jun 2026 10:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l141A4Yc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE7684715; Mon,  8 Jun 2026 10:23:18 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCEDE83EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A3C7E43B3B;
 Mon,  8 Jun 2026 08:23:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03731F00893;
 Mon,  8 Jun 2026 08:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780906995;
 bh=6mnDBTFiSc1/b1OOSSlBal+M5YTp6cGK+hn4LwthBO8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=l141A4Yct/xNodJee5lFNhgya1PKLLvwcCobxkEdVrONB9dEGyqx1VUJ8hvnsnYxQ
 njQz320q6QxYYqK8GKBfiCVzbCUvJNgnkkhKWfFevWVuNj4D5eTBunCsIorHAzPm3u
 9roE40vbCp9INX1khseK7KnZwC5y1R1LXpdiCLPpPZm+ojGBAlXU4bJxWsu3PsJ+Sz
 lo/NaC+pSstVLEwcaUORWaqNpmWpAvpwLJcTFajby+c8B4YI4+o1q5VqeH4UypsvJi
 QBwY/o2unm99BGNJrGAgKOXtMsfwP3pmTqbUeWPDd/FvnP0/0klbssNzc2bty2zWtA
 uqu0xpxfLgrpg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 07/11] test: Move the configuration-editor setup to
 its own file
In-Reply-To: <20260523085455.750591-8-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-8-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:23:12 +0200
Message-ID: <87wlw9xwy7.fsf@kernel.org>
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

Hi Simon,

Thank you for the patch.

On Sat, May 23, 2026 at 02:54, Simon Glass <sjg@chromium.org> wrote:

> Move setup_cedit_file() to its own module.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
