Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B995E83840
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 22:16:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C0D6B83AC5;
	Mon, 16 Feb 2026 23:16:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="qdNx1SUZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C11D583C6C; Mon, 16 Feb 2026 23:16:37 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9936A83AA9
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 23:16:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4fFHDc5l61z9tGQ;
 Mon, 16 Feb 2026 23:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1771280192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FO2bbSeXka4OPtEScvti4QxuFpt4cqaiHVzPaTFFdRI=;
 b=qdNx1SUZDQ0r7ubsiHhQ35ydIjTbj63L88bZ8uT9erAn9l4hWmVax5XI5NrGTdP63gHEmI
 VrQJTiQjTy/ULg64aBWEWN+6cGFknZWbO1DTiuuUxFleg4/co5Z6QHxBNyF1SGPpG+Sg3t
 AMd098OI/jVuo7HfitFDaWgVkH2DnfeCF77+2FQESrY7osqnsjWflI8gtnirIeifmHlz+I
 FXcVEx4raBrqSbIFq/sYHc/qqkz4WmJoLtAa4/iP9zb3pkA13iABM8d1tfEgrELrvyHiMf
 8yFkTGR2HCl3YzLWXHlNJWU85txCC54I58qJoOKzbA9I3Lq17YUxU1hLb00y+g==
Message-ID: <49aa54f6-78a0-4eb4-bd60-d7e17263e586@mailbox.org>
Date: Mon, 16 Feb 2026 23:16:24 +0100
MIME-Version: 1.0
Subject: Re: [RFC PATCH 00/20] boot: add OpenWrt boot method and on-demand FIT
 loading
To: Daniel Golle <daniel@makrotopia.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Martin Schwan <m.schwan@phytec.de>, Anshul Dalal <anshuld@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>, Aristo Chen <jj251510319013@gmail.com>,
 =?UTF-8?B?54mbIOW/l+Wujw==?= <Zone.Niuzh@hotmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Wolfgang Wallner <wolfgang.wallner@at.abb.com>,
 Frank Wunderlich <frank-w@public-files.de>,
 David Lechner <dlechner@baylibre.com>,
 Osama Abdelkader <osama.abdelkader@gmail.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Yegor Yefremov <yegorslists@googlemail.com>,
 Mike Looijmans <mike.looijmans@topic.nl>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>, u-boot@lists.denx.de
Cc: John Crispin <john@phrozen.org>, Paul Spooren <mail@aparcar.org>
References: <cover.1771275704.git.daniel@makrotopia.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <cover.1771275704.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 8ee93bfffdf4384da90
X-MBO-RS-META: 7euxd3x1m7jkii3ky7nrngi71i6fw7zb
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

On 2/16/26 10:21 PM, Daniel Golle wrote:

Hi,

> This RFC series adds a new boot method for OpenWrt's "uImage.FIT with
> embedded rootfs" firmware model, along with the underlying infrastructure
> to load FIT images on-demand directly from storage devices without copying
> them entirely to RAM first.
> 
> I would like to discuss the design with U-Boot maintainers and fellow
> OpenWrt developers before submitting a formal patch series.

[...]

> 4. On-demand loading: None of the existing methods support loading FIT
>     subimages directly from storage. OpenWrt's FIT images typically
>     contain a 5-20 MB squashfs that does NOT need to be copied to RAM —
>     the kernel maps it directly from flash. The bootloader only needs
>     to load the kernel and DTB (~5-10 MB), not the entire 20-50 MB
>     container. This requires a new loading abstraction.

Isn't this partial loading exactly what SPL does when the fitImage is 
generated with external data (mkimage -E) ? SPL loads and traverses the 
tree, and then loads the remaining chunks (files) only when needed if I 
recall it right ?

Can that SPL code be reused instead ?
