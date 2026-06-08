Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7AD3CD8C92
	for <u-boot@archiver.kernel.org>; Mon,  8 Jun 2026 08:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2805F84154;
	Mon,  8 Jun 2026 10:21:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="InIOO3eU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A826484704; Mon,  8 Jun 2026 10:21:07 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B213083EEF
 for <u-boot@lists.denx.de>; Mon,  8 Jun 2026 10:21:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 353FB40618;
 Mon,  8 Jun 2026 08:21:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 964341F00893;
 Mon,  8 Jun 2026 08:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780906864;
 bh=MziqcaExXdRgxnOYYdK7AzG5q8VpFn1EnelnliTqvps=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=InIOO3eUwKc+IWKlx3Qp8es1+pk2k0QLm9a5tFNVhFRAMAUMYHbiJVlCwXaAM32Cb
 yhS1wCNDSpd9Yhm1Q6c0V8YQ3VPemwLgv9isFHGd/wGXi0RVwo/c/AgJ/ITQ2I9xCn
 3GfjgWZJvX7qWnQuiMjIg7qhUNglxnSyROMWjGLOlRCeJBhKWgwKVgXcUG1f3qIS7P
 Dr3RGW2aBixkiKJj4lCE2Qn06F/a5Yq8V+2IB+nwpJgcZe3WUGsX0nI82LDjzTiFav
 SHBwhyPh9t9gb6P/DUxnkH3lZuVCvLaSoSpCBe6mroePnm9Mt+z8nBr8+ybVtgNmGE
 5XzH5JCA9EYAA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2 05/11] test: Move Android image-creation to its own file
In-Reply-To: <20260523085455.750591-6-sjg@chromium.org>
References: <20260523085455.750591-1-sjg@chromium.org>
 <20260523085455.750591-6-sjg@chromium.org>
Date: Mon, 08 Jun 2026 10:21:02 +0200
Message-ID: <8733yxzbm9.fsf@kernel.org>
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

> Move setup_android_image() function to its own module.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
>
