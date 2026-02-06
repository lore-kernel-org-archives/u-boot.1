Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310B5EE2084
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 10:21:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1A3C83A64;
	Fri,  6 Feb 2026 11:21:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="glA4aNPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A7583AA7; Fri,  6 Feb 2026 11:21:07 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19BC78382A
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 11:21:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1C0E5600CB;
 Fri,  6 Feb 2026 10:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F4EC19423;
 Fri,  6 Feb 2026 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1770373261;
 bh=owEaYCpxJQ7S0uECItfKofW3K5fmq9HPsHQ48HTphy4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=glA4aNPWIMDkR+JKWgJij9hArLsNYlSYZhXtYua0ruzOyOao/PX5y3e666Do5nOfJ
 YbTeZta61rUPGVOsNziy7cbq/mB+tIv5RvvNi2nbZwEqJePxsALdMHJMZM4TI648R/
 tez+lpDpiil1Wlt9OWgSkbd6DoUOvnxPC8eXfK29xnwekVRVdoIwWTqsss1y+B6rrC
 HLJHYHSrPWhJyUvQH9ssH9zXe/ZEQixt7BTu6dWL3mR9IzSgJGCUa3LzMIT+Kmf5Qk
 eicVhqJGvrKkeu3bfWCoCu1bq3d9VxRIa2f/wrpoLobwMy0jppUZOhGHZL4U71aD4w
 GS/TgX9swSnQA==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Heiko Schocher <hs@nabladev.com>, U-Boot Mailing List
 <u-boot@lists.denx.de>
Cc: Adrian Freihofer <adrian.freihofer@siemens.com>, Heiko Schocher
 <hs@nabladev.com>, Dmitrii Merkurev <dimorinny@google.com>, Mattijs
 Korpershoek <mkorpershoek@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH v1 1/2] fastboot: mmc: make boot partition offset
 configurable
In-Reply-To: <20260124054712.7939-2-hs@nabladev.com>
References: <20260124054712.7939-1-hs@nabladev.com>
 <20260124054712.7939-2-hs@nabladev.com>
Date: Fri, 06 Feb 2026 11:20:58 +0100
Message-ID: <87sebekwad.fsf@kernel.org>
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

Hi Heiko,

Thank you for the patch.

On Sat, Jan 24, 2026 at 06:47, Heiko Schocher <hs@nabladev.com> wrote:

> From: Adrian Freihofer <adrian.freihofer@siemens.com>
>
> Add a weak function fb_mmc_get_boot_offset() to allow to override
> the default offset (0) when writing to eMMC boot partitions.
> This enables support for devices with non-standard boot partition
> layouts, such as those requiring an offset for correct bootloader
> placement.
>
> The imx8qxp processors are an example where older revisions need a
> 32kB offset.
>
> Signed-off-by: Adrian Freihofer <adrian.freihofer@siemens.com>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

I'm fine with this commit message but I also like the one that Peng
suggested[1]

Up to you to decide if you want to respin to update.

[1] https://lore.kernel.org/all/aXbGZ22OTwTbbGEw@shlinux89/

> ---
>
>  drivers/fastboot/fb_block.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
