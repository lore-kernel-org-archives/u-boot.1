Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7FACF857C
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 09:40:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CDB884090;
	Thu, 20 Nov 2025 10:39:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UCzMpgZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8061C84099; Thu, 20 Nov 2025 10:39:58 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 810B3838FA
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 10:39:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 3564C4033F;
 Thu, 20 Nov 2025 09:39:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978D8C4CEF1;
 Thu, 20 Nov 2025 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1763631595;
 bh=z1GkhXBj6WLcWULMDjnKUGvxQW8JSMv42ab6iQcDhrI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=UCzMpgZ9FUBYSE2HbtDs1JImGAF8FmVwac9DOrq9L3nKhATuSVbMZ57/z3QcK3y1K
 6DjvRvBsfrgLeuEHTc8/bBBWjjVo3sQG/ozOVEw77lNp9QPvPgN/+FTmUrbvx195NY
 kVULHgEphMdCVAifJbwJnuwHOcNiDQWvuD0JrV8oJfA46WDf5Dmomn+mTJOPzB9z5Y
 3Fi/yRYraadRLiszpDxjaGxrXPwegBzoCSKyhtq+AG19t0zhzs2pRzPWUMJdnakFHr
 AeUl8c8WhsoryoZlG4qxRcqCsbQ4attopG2K8y/jMbUQJlRYUurm4zdNlWbEXnySdw
 Ngs/7wi9IT4Qw==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, Aaron Kling
 <webgeek1234@gmail.com>, Eddie Kovsky <ekovsky@redhat.com>, George Chan
 <gchan9527@gmail.com>, Julien Masson <jmasson@baylibre.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Nicolas Belin
 <nbelin@baylibre.com>, Sam Day <me@samcday.com>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v3 2/2] test/py: android: Point fdt command to aligned
 addresses
In-Reply-To: <20251119193311.127633-2-marek.vasut+renesas@mailbox.org>
References: <20251119193311.127633-1-marek.vasut+renesas@mailbox.org>
 <20251119193311.127633-2-marek.vasut+renesas@mailbox.org>
Date: Thu, 20 Nov 2025 10:39:52 +0100
Message-ID: <87cy5davpz.fsf@kernel.org>
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

On Wed, Nov 19, 2025 at 20:32, Marek Vasut <marek.vasut+renesas@mailbox.org> wrote:

> Newer versions of libfdt strictly check whether the FDT blob
> passed to them is at 8-byte aligned offset, if it is not, then
> the library fails checks with -FDT_ERR_ALIGNMENT . Currently,
> 'abootimg get dtb --index=1 addr size' may return non 8-byte
> aligned FDT address which points directly into the abootimg.
> Copy the result into temporary location before validation to
> avoid FDT alignment check failure.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
