Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B183CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8218A846A7;
	Mon,  8 Jun 2026 10:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UuPpdN+W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26BCE84701; Mon,  8 Jun 2026 10:13:28 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AF0084154
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6378143CB4;
 Mon,  8 Jun 2026 08:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F3C1F00893;
 Mon,  8 Jun 2026 08:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780906404;
 bh=ptEML5iQdSTv2dmmRTczV16uYakrNkggvqtCpsG1AIg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=UuPpdN+WxHGSuC+9ll0gbdhP7VqFMQrHmJNudB2XuJ5gINRfs7VpEDkPtZUJHsu+y
 bm0DeAX2dXjGOb0uxHdeb/8sZgoHuNmpR1SS3dAZAlIvExMsfcE0wmkxEsk4OB5MLo
 yd0v6SfufCKXl4LBwyOiAPscwlmAY0e0foIx1fPOrg2LZ0UI4Lu7ve131SNvtMRhAL
 5R4fmo5U4iU4ThoXnJS1oA8ePOKCwkuE0XStYPhp3GVdY1m+2nYHYXYxRR5cO0SiXZ
 VqZZMFuiMJ5CqoiJDroygNIDvPOuWOmiPsrGup/mbizlZm9fP/I5SluHtj8m3S6qQT
 9AIq6xhOl1pXg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 03/11] test: Move script image-creation to its own file
In-Reply-To: <20260523085455.750591-4-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-4-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:13:21 +0200
Message-ID: <87bjdlzbz2.fsf@kernel.org>
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

> Move setup_script_image() to its own module. The image exercises the
> script bootmeth and is modelled on Armbian 22.08 Jammy, so name the
> module and function after what they test rather than the distribution.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
