Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46356C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:12:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 116858131B;
	Tue, 28 Jul 2026 09:12:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6wVGGsnxXEFx; Tue, 28 Jul 2026 09:12:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C56C881317
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785229936;
	bh=3GDAXy99R0GftTxNaL4/btRUOhWBjsnFUbufaGg07Mo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ND3CoRfZAIF6yQkT5Heb3r8YsEfM1wCmhafHuoveOBkQCL7I3aqNevyAkfY0FCjuY
	 FlvRa+xA7Ny0m6ZaWsUU7EgsGwjWyJ/4iVHyxlbQJXW2c+/ZUd1uEiGS+dyPUWS1vE
	 NQUiriMa6sMOYLsD9Y/gaSErwFQeS9IqaWba34FUr70XMehslX1JjoZwBqMlIDNMKu
	 I2bSWpXJe86KwDlMFm4HSMmFvLpII4JYO4p9fvN77MWkVwJEZaH8CV4PFh9YGSc6N6
	 1hLeP4+EA7ccG3xugix6ttQLAbsSP1ekBsh2FpTk8x9sICN9GjBj+QQJ+APQKZ1FYG
	 ECg0c7AHC5YyQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C56C881317;
	Tue, 28 Jul 2026 09:12:16 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4898D42A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:12:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2F47760735
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6tFAPIbN7Xol for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:12:14 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 67516606C2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67516606C2
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67516606C2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:12:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9DFD84873; Tue, 28 Jul 2026 11:12:11 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7255F82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:12:09 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D4C0B40773;
 Tue, 28 Jul 2026 09:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388101F00ACA;
 Tue, 28 Jul 2026 09:12:07 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 33/75] usb: dwc3: import from kernel v5.9
In-Reply-To: <20260716134305.614278-34-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-34-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:12:05 +0200
Message-ID: <87cxw732ca.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785229927;
 bh=3GDAXy99R0GftTxNaL4/btRUOhWBjsnFUbufaGg07Mo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=FNe2DLIEXgb5O6vywvXQTo7GgI8mmStt1nOHPylwx1jYTrdQhEfzpF7KW1omWTMFe
 Rnq8HwiB+/6zWWJAXhzSoHcxU9kgVLc1acF32rtYH95o0xcsl18mLCqWq+SV5fgf3B
 vaLKVrju1mxaypkzWptNptjwHlpiZaE4B3fDAJ337KiTQ7M9XHsmjrJ+fj1qDCtFPA
 iAk0KUK/S3WHs1H74bfNG5o9dF+lkAHkiCRETKnE0T0VL21MkEeud9cLybxvCZpam0
 9+7p4FlyZC1vJsA4J7jigmc9kCy49BoBsYtKIiJ0fcBvbRVUiyZJjV1i6H1Ori6vQb
 FBRakGS9611EA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=FNe2DLIE
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="FNe2DLIE"; 
 dkim-atps=neutral
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v5.8 to v5.9.
>
> The following files are preserved accross the import:
> Makefile Kconfig dwc3-meson-g12a.c dwc3-meson-gxl.c dwc3-omap.c
> dwc3-uniphier.c dwc3-generic.h dwc3-generic.c dwc3-generic-sti.c
> dwc3-layerscape.c ti_usb_phy.c
>
> Skipping unused files:
> debugfs.c drd.c dwc3-exynos.c dwc3-haps.c dwc3-imx8mp.c dwc3-keystone.c
> dwc3-octeon.c dwc3-of-simple.c dwc3-pci.c dwc3-qcom.c dwc3-qcom-legacy.c
> dwc3-rtk.c dwc3-st.c dwc3-xilinx.c host.c trace.c trace.h ulpi.c
>
> Note that this is a raw import and doesn't build.
> A fixup commit at the end of the series fixes that.
>
> List of commits: git log --oneline v5.8..v5.9
> Commits imported:
> a6498d51821e Revert "usb: dwc3: meson-g12a: fix shared reset control use"
> df561f6688fe treewide: Use fallthrough pseudo-keyword
> bc9a2e226ea9 usb: dwc3: gadget: Handle ZLP for sg requests
> d2ee3ff79e6a usb: dwc3: gadget: Fix handling ZLP
> 5d187c0454ef usb: dwc3: gadget: Don't setup more than requested
> db123bea9625 usb: dwc3: convert to devm_platform_ioremap_resource_byname
> f5e46aa4a124 usb: dwc3: gadget: when the started list is empty stop the active xfer
> c5a7092f4015 usb: dwc3: gadget: make starting isoc transfers more robust
> ca14378560db usb: dwc3: gadget: add frame number mask
> 7a410953d1fb usb: dwc3: meson-g12a: fix shared reset control use
> 10623b879da3 usb: dwc3: Replace HTTP links with HTTPS ones
> b789710de583 usb: dwc3: dwc3-qcom: Do not define 'struct acpi_device_id' when !CONFIG_ACPI

Are we actually importing this? Since it's marked as "unused files" in
the commit message I think we should drop this from the git log

> 26ef796f9306 usb: dwc3: dwc3-of-simple: Function headers are not good candidates for kerneldoc
> 4d72cf0cb9e2 usb: dwc3: dwc3-haps: Function headers are not suitable for kerneldoc
> 3c373454a9f2 usb: dwc3: dwc3-omap: Do not read DMA status
> fb678a5a76a4 usb: dwc3: ulpi: File headers are not doc headers
> 7679defc3e29 usb: dwc3: drd: File headers are not doc headers

Same for ulpi and drd here.

> 62fb45d317c5 USB: ch9: add "USB_" prefix in front of TEST defines
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/usb/dwc3/core.c   |   7 +-
>  drivers/usb/dwc3/core.h   |   2 +-
>  drivers/usb/dwc3/debug.h  |   2 +-
>  drivers/usb/dwc3/ep0.c    |  12 +--
>  drivers/usb/dwc3/gadget.c | 149 +++++++++++++++++++++++++++++++-------
>  drivers/usb/dwc3/gadget.h |   4 +-
>  drivers/usb/dwc3/io.h     |   2 +-
>  7 files changed, 137 insertions(+), 41 deletions(-)
>
