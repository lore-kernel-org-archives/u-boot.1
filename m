Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80054C27C40
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 20:14:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFE53846DF;
	Wed, 23 Aug 2023 22:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JYqjCuVY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7379E80778; Wed, 23 Aug 2023 22:14:08 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 898B7846DF
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 22:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=pali@kernel.org
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 24098618FF;
 Wed, 23 Aug 2023 20:14:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E31C433C8;
 Wed, 23 Aug 2023 20:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1692821643;
 bh=jHIfCHBM27xYEJCa1LkiACR/Jfvxp4EluJbTqKTlxL8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JYqjCuVYkBdgSjG4uiB7dn4C1FnqtoD/ll/nApUOetn/pOgMo6eiNjfps4Jt2jXJb
 ubl9Y1smETM6vDiq4Xfg985XuixZ5PksoY7S5//FDjtQRPmSVKIkmqC5mrTAEzTXxM
 1xAV6BrjNoiCwnf6AHVeY5eOuu3DQfgCfC4Epv2JNGIqRxjnJRsjOodrtSPj47SjdD
 w9SIkXM0i2n6PBqQrqdIY83m3QykN+S2vtKaYCuMrW9ZcHdtubz47LveRANYErPfbQ
 UZ2ovUFYxTfZ3qTAVrHcgcyoy/zhBNPl92ASb5dbcYrF5PjboTgbH4iQL1Y5XXDrMA
 QgxDWzsCA/x6w==
Received: by pali.im (Postfix)
 id 303817F5; Wed, 23 Aug 2023 22:14:00 +0200 (CEST)
Date: Wed, 23 Aug 2023 22:14:00 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Mayuresh Chitale <mchitale@ventanamicro.com>,
 Stefan Roese <sr@denx.de>, Sean Anderson <sean.anderson@seco.com>,
 Bin Meng <bmeng.cn@gmail.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] doc: describe TPL/VPL/SPL boot
Message-ID: <20230823201400.m4l6hl7zy6x6srzd@pali>
References: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823195728.39438-1-heinrich.schuchardt@canonical.com>
User-Agent: NeoMutt/20180716
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

On Wednesday 23 August 2023 21:57:28 Heinrich Schuchardt wrote:
> +Booting from TPL/SPL
> +====================
> +
> +The main U-Boot binary may be to large to be loaded directly by the Boot ROM.
> +This was the main driver for splitting up U-Boot into multiple boot stages with
> +successively larger binaries.
> +
> +U-Boot typically goes through the following boot phases where TPL, VPL, and SPL
> +are optional. While many boards use SPL only few use TPL.
> +
> +TPL
> +   Very early init, as tiny as possible. This loads SPL (or VPL if enabled).

This is not truth. SPL loads TPL. Or at least it was about year ago for powerpc plat.

> +VPL
> +   Optional verification step, which can select one of several SPL binaries,
> +   if A/B verified boot is enabled. Implementation of the VPL logic is
> +   work-in-progress. For now it just boots into SPL.
> +
> +SPL
> +   Secondary program loader. Sets up SDRAM and loads U-Boot proper. It may also
> +   load other firmware components.

SPL initializes NAND then loads TPL from NAND, TPL initialize DDR and then loads U-Boot.
