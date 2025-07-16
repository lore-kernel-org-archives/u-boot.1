Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33BD6C83F22
	for <u-boot@archiver.kernel.org>; Wed, 16 Jul 2025 10:14:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D74A831D7;
	Wed, 16 Jul 2025 12:14:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BLULHMZ9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8145831E1; Wed, 16 Jul 2025 12:14:33 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6629A831AC
 for <u-boot@lists.denx.de>; Wed, 16 Jul 2025 12:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E55F6445A8;
 Wed, 16 Jul 2025 10:14:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 731D4C4CEF1;
 Wed, 16 Jul 2025 10:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1752660869;
 bh=SXXyTW007p8MmX/iE0295rv/VCJAyt1Le7/DhaJELAs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BLULHMZ9XOrY+/ToRNocPkFTKFH+t6aMEb3V3Kg23meHDppm2RsPNVGgehvj6CJyX
 pI7ZxEO41DNgyAJd2dIp8zbjY7s3ckAnNVrcFCVcK3RXkpe9hQ3+gp4d4qc3Af2GJT
 oPNP2x7/y91wuKDAr3DseU8IUTJzZWadtLwQ7rQO7bcA0lnjbCYWHGr1OgbQZLu0K5
 cx67xvcXFaPAVC4sSRYkNG6VXXTGmBZVWjjH4cchUwCPyBSzUxDkqLIwXRCF5re7uS
 52UPAtkjdapPVCmhTPnaKsxz+C6i8mF0cDr6ReEGh560koAbt5RYRq5weAo0VFJ5fU
 UPuNnZEO7ST0Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Mattijs Korpershoek <mkorpershoek@kernel.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sam Protsenko <semen.protsenko@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-dfu-20250716 into master
In-Reply-To: <87y0so30tv.fsf@kernel.org>
References: <87y0so30tv.fsf@kernel.org>
Date: Wed, 16 Jul 2025 12:14:27 +0200
Message-ID: <87tt3c30jg.fsf@kernel.org>
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


And, apparently I forgot to update my subject line again. It should be
"u-boot-dfu-20250716", not "u-boot-dfu-next-20250716".

Sorry about that !

On Wed, Jul 16, 2025 at 12:08, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:

> Hi Tom,
>
> Please find the following fixes for master:
>
> Android:
> - Fix printing lbaint_t format in AVB and android_ab messages
>
> DFU:
> - Fix dfu_config_interfaces() for single interface DFU syntax
>
> CI Job:
> - https://source.denx.de/u-boot/custodians/u-boot-dfu/-/pipelines/27074
>
> Please note that this is probably my last pull request before my
> paternity leave. I plan to be out in August and September.
> Becoming a dad will be a life-changing event for me, so I'd like to
> not be on my computer for the early months :)
>
> As we discussed on IRC, thanks a lot for keeping an eye out for
> fastboot, android AB/AVB, USB gadget and DFU.
>
> Regards,
> Mattijs
>
> The following changes since commit b379335f141e3ddca0cdbb5d9d39af0444530542:
>
>   configs: Resync with savedefconfig (2025-07-07 14:15:18 -0600)
>
> are available in the Git repository at:
>
>   https://source.denx.de/u-boot/custodians/u-boot-dfu.git tags/u-boot-dfu-20250716
>
> for you to fetch changes up to 772526fb9f55a1fea439ea3a6923136cd121cc88:
>
>   dfu: Fix dfu_config_interfaces() for single interface DFU syntax (2025-07-15 11:27:19 +0200)
>
> ----------------------------------------------------------------
> u-boot-dfu-20250716
>
> Android:
> - Fix printing lbaint_t format in AVB and android_ab messages
>
> DFU:
> - Fix dfu_config_interfaces() for single interface DFU syntax
>
> ----------------------------------------------------------------
> Sam Protsenko (1):
>       dfu: Fix dfu_config_interfaces() for single interface DFU syntax
>
> Tom Rini (2):
>       boot/android_ab.c: Make use of LBAF for printing lbaint_t
>       common/avb_verify.c: Make use of LBAF for printing lbaint_t
>
>  boot/android_ab.c   | 3 +--
>  common/avb_verify.c | 4 ++--
>  drivers/dfu/dfu.c   | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
