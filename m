Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49369EBFD21
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 09:22:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A34C5836AC;
	Mon, 13 Apr 2026 11:22:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cN8U/GU/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C74F839DF; Mon, 13 Apr 2026 11:22:48 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21A6D8352B
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 11:22:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id BEC746111B;
 Mon, 13 Apr 2026 09:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A70C116C6;
 Mon, 13 Apr 2026 09:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776072164;
 bh=23mmiKy9dtu72Cx/2ny7Fs3oaBctpSBQxtcBxh/pJgo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cN8U/GU/ZMXWgXuAYkpsOYjhdCnfMUai0D3NE2v+EAESiOwNGcMfGvjc+7LEoG6Bk
 WIkDRUIhzEbB1f6GOiRmCJ7R05EG2NG0JFuZY/ymBxyuuPMZPcg+reKWvXQoMdC3cQ
 JBFkVS+cosFwcZr/q7nM3NV4hmA5+3ChRt3T3Tyhlg+IUPM2A4y2vTtXqPdlhf7jTE
 1gYbqDcC4e57xEII6LOYW97nYsqPtWmgV4C/ZhxIFqbkLd7vU1D6VsDNMAIVUBhXPz
 SBYJ0KOrQGe2QVCJVhOR+567Wf59h4gos8uQDeIRf68yHexb6U8hx4q3zhq0c0EA2G
 vSqw0F03YOrYQ==
Date: Mon, 13 Apr 2026 14:52:37 +0530
From: Sumit Garg <sumit.garg@kernel.org>
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 George Chan <gchan9527@gmail.com>
Subject: Re: [PATCH 0/2] ARMv8 timer fixes for platforms without EL2
 configuration
Message-ID: <ady13cCo-bim0zsE@sumit-xelite>
References: <20260406-timer-v1-0-f7c5a290c459@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-timer-v1-0-f7c5a290c459@oss.qualcomm.com>
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

Hi Balaji,

On Mon, Apr 06, 2026 at 04:25:35PM +0530, Balaji Selvanathan wrote:
> This series addresses timer-related issues on ARMv8 platforms where
> U-Boot runs at EL1 without a Hypervisor present. This is commonly
> encountered when using tools like snagboot for
> recovery and development.

As discussed offline too, the snagboot flow has to be fixed in this case
since booting in NS EL1 without properly initialized NS EL2 isn't the
right thing to do.

-Sumit

> 
> On such platforms, U-Boot runs at EL1 but EL2 timer control
> registers may not be properly configured as Hypervisor is not present.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Balaji Selvanathan (2):
>       armv8: timer: Add option to use virtual counter at EL1
>       snapdragon: Set timer frequency for ARMV8_CNTFRQ_BROKEN platforms
> 
>  arch/arm/cpu/armv8/Kconfig         | 19 +++++++++++++++++++
>  arch/arm/cpu/armv8/generic_timer.c | 13 +++++++++++++
>  arch/arm/mach-snapdragon/board.c   | 17 +++++++++++++++++
>  3 files changed, 49 insertions(+)
> ---
> base-commit: 47e064f13171f15817aa1b22b04e309964b15c2c
> change-id: 20260406-timer-07c406ca4987
> 
> Best regards,
> -- 
> Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> 
