Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE97C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 12:00:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 71F278393C;
	Fri, 25 Jul 2025 14:00:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="nDbL1+Qr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 111A88393F; Fri, 25 Jul 2025 14:00:55 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 072568391C
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 14:00:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 32ADA1488E19; Fri, 25 Jul 2025 14:00:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1753444851; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=TL7C+zdDa/wPsVbRBXOWwMH0O2oGQ7u6xc+c5r7fTgc=;
 b=nDbL1+QrM+FjMhRZcTx/0s2Jtivnq2JSP/RbGN+SL2xKtQcTtmE7/MuQZHUAn8pVYIWnJP
 iluHtTo6AsGLprQTdnfmAHIqmlwpbA34g1D4ErhMDlt+1iNXPdZjnsLqJrbK2cn9NVaUBe
 bpH84s58z4Xh6NIOEIkHLdBsDSDQd2ASFTih/KZFgbghj4Ta31hzxa1fzEEechsTojuytA
 DYY1A1lfAUSHciAFRkz4CrU1rvRk02ck2SLpRkJQw/3rCtGyj9TJeY2XvmpKqNg3RGfFgE
 rX85i2LyLv+wNMkFtuRP93VacJRVBTJDl4Xzv7i+3bJkatBOT24bc99kJBUZ6g==
Date: Fri, 25 Jul 2025 14:00:45 +0200
From: Alexander Dahl <ada@thorsis.com>
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Dahl <ada@thorsis.com>, Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/3] fpga: Remove lattice and ACEX1 support
Message-ID: <20250725-residence-stingray-818201348f2f@thorsis.com>
Mail-Followup-To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de,
 git@xilinx.com, p.bruenn@beckhoff.com,
 Alexander Graf <agraf@csgraf.de>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Muhammad Hazim Izzat Zamri <muhammad.hazim.izzat.zamri@altera.com>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 Simon Glass <sjg@chromium.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1753442748.git.michal.simek@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1753442748.git.michal.simek@amd.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Michal,

Am Fri, Jul 25, 2025 at 01:25:51PM +0200 schrieb Michal Simek:
> Hi,
> 
> when fpga drivers were enabled via sandbox some coverity issues came and
> make no sense to fix them when there is no user of these drivers that's why
> it is easier just remove them completely.
> 
> Another candidate for removal is FPGA_CYCLON2 which is enabled only by
> mx53cx9020_defconfig.

We use FPGA_CYCLON2 downstream with devices containing Altera Cyclone
III and IV or Efinix Trion T20 chips.  These are _not_ legacy devices,
few quantities per year, but still produced and sold.

If you need board code to keep the upstream support, I would need
to talk to some people here if we can upstream our board code, or at
least some of it.  That might be difficult though, so if there are
alternatives, please advise.  O:-)

Greets
Alex

> Patrick: Is this board still maintained?
> 
> Thanks,
> Michal
> 
> 
> Michal Simek (3):
>   fpga: xilinx: Check valid desc structure
>   fpga: Remove ancient ACEX1K support
>   fpga: lattice: Remove unused support
> 
>  configs/sandbox_defconfig |    2 -
>  drivers/fpga/ACEX1K.c     |  245 ---
>  drivers/fpga/Kconfig      |   12 -
>  drivers/fpga/Makefile     |    2 -
>  drivers/fpga/altera.c     |    5 +-
>  drivers/fpga/fpga.c       |   23 -
>  drivers/fpga/ivm_core.c   | 3149 -------------------------------------
>  drivers/fpga/lattice.c    |  379 -----
>  drivers/fpga/xilinx.c     |    3 +
>  include/ACEX1K.h          |   49 -
>  include/fpga.h            |    1 -
>  include/lattice.h         |  298 ----
>  12 files changed, 4 insertions(+), 4164 deletions(-)
>  delete mode 100644 drivers/fpga/ACEX1K.c
>  delete mode 100644 drivers/fpga/ivm_core.c
>  delete mode 100644 drivers/fpga/lattice.c
>  delete mode 100644 include/lattice.h
> 
> -- 
> 2.43.0
> 
> base-commit: 021783860f7e628f7c4e0c101707cd4250e6d61f
> branch: debian-sent3
