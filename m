Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD3DCD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:22:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B95784154;
	Mon,  8 Jun 2026 10:22:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lFa7dtAB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9136F846D3; Mon,  8 Jun 2026 10:22:26 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99C3D83EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:22:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E3D4D43503;
 Mon,  8 Jun 2026 08:22:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3FD1F00893;
 Mon,  8 Jun 2026 08:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780906942;
 bh=1nTY6SHcc2D4Wj4PCSzS7mI7LSDshGHqCuq7pbHYvRE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=lFa7dtABr7pIzO2Ij5j5fl/9Cfb4tNnP2/dM/GmHHRlS3qTGdX0u82GxFNt6s90xc
 gaC+W3aZ7k2TS3GNSRTQf5aL7XeEUlWvNbTwYq4YwKURzzevlXeHkDjsY/mhifO7c7
 xM7pdbpdUP5ShbwzVh4S70lCkGSvRDnlRrXNNS1nYO/WVB8tNApfma55nbMUFqiOyL
 BXFfquxqQ0YbeJjXl1RDIdiW9wrIvQg+cUC+t6e7l1gJ1ZTq04XqUoenu1ds+GZ4eJ
 WBbr/6vHrjOtjB0aevKqesI85J/2ia2TdedK6tBQKgmI0bl7jxDvWjDAu8hgK1NZXd
 HpHgFGAOSTF+g==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 06/11] test: Move EFI image-creation to its own file
In-Reply-To: <20260523085455.750591-7-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-7-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:22:20 +0200
Message-ID: <87zf15xwzn.fsf@kernel.org>
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

> Move setup_efi_image() to its own module.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
