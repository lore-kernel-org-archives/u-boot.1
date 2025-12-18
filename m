Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812EDD6ACE4
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 10:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD3E483C54;
	Thu, 18 Dec 2025 11:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IGJyhfEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D22FB83D00; Thu, 18 Dec 2025 11:49:30 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3082083C2B
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 11:49:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 15354600AC;
 Thu, 18 Dec 2025 10:49:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E143C116C6;
 Thu, 18 Dec 2025 10:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766054966;
 bh=UP9kka30IqbPOLKozlSF8LILkEHT2jWQJSRGg4KPogk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=IGJyhfEn2EIn/t1wOZwu5IJ7wxW8xiKqJEP0fSpNJjOEJ10cGIqGbhk+VBi9fPrGC
 kORLm1ABMbBre5lODH49rkl3aPtwDCKO/NiuYVgg+omaqKQM2n5uwMmL1rgFJlsWV6
 hyg63faxvXl/FGKXe4R5vo9ZwwsOYc9+E19wEIbQFW7y6NWiA7t6LX5e2+sJbeew9b
 7a9dlmJrwrpic3FEgetaeuOXY8QYlz1aEivWd7Obn+HTkvjBFyUw3rIIowf/JoYUQ2
 bTt1W4UE6UsSr2zmjC51TqseGZH8N9VHksV7EG0kaWNoO8ZZt6U2Pyl0YsX2hUXmgj
 IGVwORIbqxnMA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anshul Dalal <anshuld@ti.com>, Sjoerd Simons <sjoerd@collabora.com>,
 Martyn Welch <martyn.welch@collabora.com>, Mattijs Korpershoek
 <mkorpershoek@kernel.org>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anshul Dalal <anshuld@ti.com>
Subject: Re: [PATCH master] doc: board: ti: fix alt name for tispl.bin in
 DFU mode
In-Reply-To: <20251218-dfu_doc_fix-v1-1-d7a9eb033b92@ti.com>
References: <20251218-dfu_doc_fix-v1-1-d7a9eb033b92@ti.com>
Date: Thu, 18 Dec 2025 11:49:23 +0100
Message-ID: <87ike4cbf0.fsf@kernel.org>
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

Hi Anshul,

Thank you for the patch.

On Thu, Dec 18, 2025 at 10:31, Anshul Dalal <anshuld@ti.com> wrote:

> The alt name for tispl binary is "tispl.bin" and not "tispl", this patch
> fixes the documentation to the correct alt name.
>
> Fixes: def64b493748 ("doc: board: Add document for DFU boot on am62x SoCs")
> Fixes: 3633fdbb6b90 ("ti: add support for AM6254atl SiP")
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> ---
