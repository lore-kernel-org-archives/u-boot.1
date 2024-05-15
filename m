Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559A1C25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 07:08:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8CF388191;
	Wed, 15 May 2024 09:08:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Yr8X6FSe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 888BB881EA; Wed, 15 May 2024 09:08:52 +0200 (CEST)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F32B878AA
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 09:08:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=kabel@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 853F9CE1372;
 Wed, 15 May 2024 07:08:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29DBC116B1;
 Wed, 15 May 2024 07:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1715756926;
 bh=OHxBDCAnrsHhZXwuh8HWMPAjSEj3jaiOTQMbdDQZm8E=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Yr8X6FSeFRYt66oN1q722C7ROe/GcKOxoJQQDA4aIAXe0ZurXJJlW1h6WUM3tglw6
 sPSfNDBoF8XI8ISKZ3UR0lWuj7Lgm9rQrYeYtck0Qg0BNmt5h6v8fEGj0GtxQjDuA9
 Shp5ga9xM9RbRXaxVBrX0xT6KHexFKWVjCMcfSMhmbtKejTG0nS2ttSdEVDptnAU0w
 1l7Cc1MEoO3Z/+8DGYoiySFLc30x6hJYVt7zRSQg+tNgc5k/dBdhJVCDv0qMKUWe+A
 QCLV3e2e1/lt8GsbAxPaF1ZK7aGe3A8a8FacsoscV6otWh+glw3NVMolQdDaApfGro
 b9/eRDk26W3Mw==
Date: Wed, 15 May 2024 09:08:38 +0200
From: Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To: lukas.funke-oss@weidmueller.com
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>, Lukas Funke
 <lukas.funke@weidmueller.com>, Algapally Santosh Sagar
 <santoshsagar.algapally@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Taedcke <christian.taedcke@weidmueller.com>, Heinrich Schuchardt
 <xypron.glpk@gmx.de>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Jonas
 Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, Qu
 Wenruo <wqu@suse.com>, Simon Glass <sjg@chromium.org>, Stefan
 Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>, Stefan Roese
 <sr@denx.de>, Tanmay Shah <tanmay.shah@amd.com>, Tom Rini
 <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>, Wan Yee Lau <wan.yee.lau@intel.com>
Subject: Re: [PATCH 0/3] Add eFuse access for ZynqMP
Message-ID: <20240515090838.6cfc424d@dellmb>
In-Reply-To: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
References: <20240514140416.156747-1-lukas.funke-oss@weidmueller.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.41; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Tue, 14 May 2024 16:04:13 +0200
lukas.funke-oss@weidmueller.com wrote:

> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> 
> This series adds a driver to read and write ZynqMP eFuses [1]. The
> driver can be accessed by the 'efuse_read' and 'efuse_write' subcommands
> of the 'zynqmp' command.

Vendor specific commands aren't great.

There is the 'fuse' command in u-boot. You need to implement the
  fuse_read()
  fuse_sense()
  fuse_prog()
  fuse_override()
functions.

See for example arch/arm/mach-mvebu/efuse.c, or other implementations.

Please don't invent new vendor specific commands in new code, it is an
antipattern.

Marek
