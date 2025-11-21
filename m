Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89605CFA776
	for <u-boot@archiver.kernel.org>; Fri, 21 Nov 2025 10:58:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F9E8388D;
	Fri, 21 Nov 2025 11:58:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ofgfGA0y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3693838A5; Fri, 21 Nov 2025 11:58:44 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D3B835FD
 for <u-boot@lists.denx.de>; Fri, 21 Nov 2025 11:58:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 2FA2640136;
 Fri, 21 Nov 2025 10:58:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E22C4CEF1;
 Fri, 21 Nov 2025 10:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763722721;
 bh=Z4fSOUrhI92m1uvd0nOW/ccBwrIzwYr7jyDmV8k13z0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=ofgfGA0yPov7cJf+nHyy+do2y2vt1X69ir48h6f/lNHfxPjOflwa0+pzRH0q+heav
 bkALe5VvKJB1is+Vcx+rMErZ5l6PXCKffJe16KZLVfo6/dqNerX9cKNGV7XQSxGkLD
 goyXU+j/wjx9n+MqSD+WwEjgmSmHyqQiCI0HSLvApDn0DduISb2fpuwk121huioYeU
 lrVQp+hZFr0PfX1WbO+N0bZsgPdn5q1bn0fUQAF14ML2uhX/GpuJjt5+sCOKAXvbJ0
 G8g0idXRKIEHvs/EcPTAWPmf8DdjTZR+KTt/7MhJnqPZPYdL/l4HWoOh/UL4DYRte+
 jMy6IQez9uDeg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Mattijs Korpershoek <mkorpershoek@kernel.org>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v2] test/py: Use aligned address for overlays in
 'extension' test
In-Reply-To: <20251113115811.947992-1-marek.vasut+renesas@mailbox.org>
References: <20251113115811.947992-1-marek.vasut+renesas@mailbox.org>
Date: Fri, 21 Nov 2025 11:58:38 +0100
Message-ID: <87v7j33b4x.fsf@kernel.org>
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

Hi Marek,

Thank you for the patch.

On Thu, Nov 13, 2025 at 12:57, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> The 'extension' test would set 'extension_overlay_addr' variable to
> decimal 4096 due to conversion in python. The 'extension_overlay_addr'
> is however sampled using env_get_hex("extension_overlay_addr", 0);
> which converts the 4096 to 0x4096 and uses that as DT overlay address,
> which is unaligned. Fix this by setting extension_overlay_addr to 0x1000
> as intended, which is aligned.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
