Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE66C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 08:42:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0462D83A9C;
	Thu, 10 Apr 2025 10:42:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="uOlijI+k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A06D83A5C; Thu, 10 Apr 2025 10:42:09 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53722812BC
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 10:42:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A7E0743D42;
 Thu, 10 Apr 2025 08:42:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD496C4CEE3;
 Thu, 10 Apr 2025 08:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1744274525;
 bh=nE9MncxNXhndvKUEXh7voeCNr5wwwOvQU9guhiKmTGY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=uOlijI+koMQuQlauiucSIPHeMUyxYyI97CoC/uJIBdBYqymjc5hY7B6Adzg1wFG7t
 HpMMRKHEtCd/X7WQAiLrKDpcaKx4Z72JGk4RheMsDW/FZE+EvfoapYnzX5h3ElLiit
 Qc0smnHpuX5rr4u0bryjnQqxlg9Qvznoxcx0BIxRNP2Tgy6TAn+DK/371eUL+uo5sf
 FE3/7DyMuv6w0q8EOs4dM+MGVBsAF2BM/fpGO4oM5kn/zzACWENfGleOQ9icSfReYU
 sKlSGkVZcSSog+oigzRHJhDndnat1MvwSRIwouLrfsjdDi2KvaIwzQ4EzmRjuf44RH
 sulQ4BqnwP5EA==
Date: Thu, 10 Apr 2025 14:11:58 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: Re: [PATCH 0/6] Qualcomm: cleanup OF_LIVE fixup and fix RB1/2
Message-ID: <Z_eEVo0_DYVMYgkE@sumit-X1>
References: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409-livetree-fixup-v1-0-76dfea80b07f@linaro.org>
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

Hi Caleb,

On Wed, Apr 09, 2025 at 07:17:23PM +0200, Caleb Connolly wrote:
> Introduce a new event to signal that the live tree has been built,
> allowing boards to perform fixups on the tree before devices are bound.
> Crucially this allows for devices to be enabled or disabled, but also
> allows for properties that are parsed during the bind stage to be
> modified (such as dr_mode for dwc3).

Looks like a nice platform override available with OF_LIVE.

> 
> With this in place, mach-snapdragon is switched over to use the event
> and some hacky U-Boot specific DT overrides (which had to be undone
> prior to booting an image) are removed in favour of fixing up the
> livetree (which is not passed on to further boot stages).
>

Nice.

> Finally, some minor fixes are made for the QCM2290 RB1 board, the sdcard
> is enabled and it now uses USB host mode in U-Boot like it's bigger
> sibling the RB2.

FWIW, for the series:

Tested-by: Sumit Garg <sumit.garg@oss.qualcomm.com>

-Sumit

> 
> ---
> Caleb Connolly (6):
>       event: signal when livetree has been built
>       mach-snapdragon: use EVT_OF_LIVE_INIT to apply DT fixups
>       mach-snapdragon: of_fixup: skip disabled USB nodes
>       clk/qcom: qcm2290: show clock name in set_rate()
>       mach-snapdragon: of_fixup: set dr_mode for RB1/2 boards
>       pinctrl: qcom: qcm2290: fix off by 1 in pin_count
> 
>  arch/arm/dts/qrb4210-rb2-u-boot.dtsi   |  6 -----
>  arch/arm/mach-snapdragon/board.c       |  1 -
>  arch/arm/mach-snapdragon/of_fixup.c    | 41 ++++++++++++++++++++--------------
>  arch/arm/mach-snapdragon/qcom-priv.h   | 14 ------------
>  common/event.c                         |  3 +++
>  drivers/clk/qcom/clock-qcm2290.c       |  2 +-
>  drivers/pinctrl/qcom/pinctrl-qcm2290.c |  2 +-
>  include/event.h                        |  9 ++++++++
>  lib/of_live.c                          |  3 +++
>  9 files changed, 41 insertions(+), 40 deletions(-)
> ---
> base-commit: e4ffc6a323586d700d88c73c319c25c740aedb49
> change-id: 20250409-livetree-fixup-0d7451cc3af3
> 
> Caleb Connolly <caleb.connolly@linaro.org>
> 
