Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D035CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:19:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 294A184154;
	Mon,  8 Jun 2026 10:19:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bhtrY6B4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D4F18846A7; Mon,  8 Jun 2026 10:19:15 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D9A8D83EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:19:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E226400B9;
 Mon,  8 Jun 2026 08:19:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2AA1F00893;
 Mon,  8 Jun 2026 08:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780906751;
 bh=FMD3bbidi+0SWHKPT91s8baD+HVtuVVk/zuh+AlnPDY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=bhtrY6B4plWIx9Wnrm46LREVKq2tJBr3erpQrNBGCjONxLzqtDMacS9ljR4az+5AW
 +2hv7crPm8W9/PX6WXj291bdTQ0m4DOD1oVdvxvSKE0/bTz7nh8FTSE3SXiMmJYkqb
 nMeuZ/Hb2GoDv8X81fR2NkIvTj1FByBo11kFeQBf4m+GcalRjVEeN3LeoEkCP7n3aw
 EVmIwHY6sHQWNHRDn0htJS8NYCQ5Zc781zd+aJtdv0HnximJtWLlzUTgyChxKJjsbP
 2Ce+ZtaJSwlq2ebYBFPM2F/LSQ53/7J0PtxgfY9F1vYMOJCRS7PU+qWaAsXwSjiGQ2
 On4vl1D5Fo2pg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 04/11] test: Move ChromeOS image-creation to its own
 file
In-Reply-To: <20260523085455.750591-5-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-5-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:19:09 +0200
Message-ID: <875x3tzbpe.fsf@kernel.org>
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

> Move setup_cros_image() to its own module. This function creates disk
> images with a ChromiumOS partition layout.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
