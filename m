Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3122C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:52:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DF1DE40930;
	Tue, 28 Jul 2026 09:52:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jNXLZW472AGx; Tue, 28 Jul 2026 09:52:48 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E55FE408F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785232368;
	bh=Zz4nfWwUrJ93xNzz2WNr3o9RFrysQ+HrGPjor1pc7uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vJLxy3fGIFzfqnxzeQW8carmQMqm1DkBS5Il7TUGQPHBTEZwh+RUZ2QBEhyx4Ndh+
	 Bue9+gJe838YYAbecNJp8RyjHiEP8LCHjuZ2Q9Ajxe7aXhbsh0VUQNsX4+kYp6RJpy
	 fqkV8o6awgqQzeYl2LL1BdzdpIfqOM/kD+MN8DVB0xG90+AOCxvynZyJlmsxj1KKTO
	 HVtEM+eNFJ7sdPPUrPNLUFVa+oylLxeRdIi5BkbcNOOdQ63YWdFGoFyJ4ckUhVaxo1
	 PuVak1b6rFMd7C8sVnkhgpE/DtsTBOipltrfc9tFOW/0hs2PD31H/dQoMcUcUtgIbC
	 hGDxzMG1D0+/g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E55FE408F8;
	Tue, 28 Jul 2026 09:52:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1DD842E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:52:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 047FE607B6
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:52:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q8ddlqCczaZo for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:52:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D63556075F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D63556075F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D63556075F
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:52:45 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADEC98494B; Tue, 28 Jul 2026 11:52:43 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 118D1848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:52:41 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 488F443A36;
 Tue, 28 Jul 2026 09:52:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951241F000E9;
 Tue, 28 Jul 2026 09:52:38 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 42/75] usb: dwc3: import from kernel v5.18
In-Reply-To: <20260716134305.614278-43-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-43-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:52:36 +0200
Message-ID: <87mrvb1lwb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785232359;
 bh=Zz4nfWwUrJ93xNzz2WNr3o9RFrysQ+HrGPjor1pc7uk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=nyn2RsO3rKNVmLBCrMUGZxLNsdVlyCn0GIMyQPGl6i4h1W/9QSVup98wyLsAu3bRO
 6eMcMv62FVmGFvFpF9d6J0DuPkS4lFXmSwOf5AvHwYFNdn3cBIr6Vmy4k/DRDbkujE
 ek3uYNFK4+GuVtVuAW07Y0v89cxr7yNHyunKynYgKZvCwvC/KaIo8g7HZQd1m3Xk4w
 8WqmEaaFmyU3w4RC5/q9RvQDN8i8MY/bGybVFCDaAqkJoZDvZsRBPnLkDteqNUwEab
 DZn7IfAIsfMI3Mk2SVpoqx1TYhrqx+XJJS1JGCYwdvphxMtC8X0eyR9nU+MpFHgD5R
 lp8nmlHDX0YRg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=nyn2RsO3
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="nyn2RsO3"; 
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

Hi Anders,

Thank you for the patch.

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v5.17 to v5.18.
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
> List of commits: git log --oneline v5.17..v5.18
> Commits imported:
> c7428dbddcf4 usb: dwc3: gadget: Return proper request status
> 973e0f7a847e usb: dwc3: pci: add support for the Intel Meteor Lake-P
> f4fd84ae0765 usb: dwc3: core: Only handle soft-reset in DCTL
> ab7aa2866d29 usb: dwc3: Try usb-role-switch first in dwc3_drd_init
> f28ad9069363 usb: dwc3: core: Fix tx/rx threshold settings
> 4e64cd7763ca usb: dwc3: fix backwards compat with rockchip devices
> 0066472de157 usb: dwc3: Issue core soft reset before enabling run/stop
> e4cf6580ac74 usb: dwc3: gadget: Wait for ep0 xfers to complete during dequeue
> e192cc7b5239 usb: dwc3: gadget: move cmd_endtransfer to extra function
> 26d27a1080a7 usb: dwc3: gadget: ep_queue simplify isoc start condition
> ecb0a2f1e9e2 usb: dwc3: pci: Add support for Intel Alder Lake
> ac01df343e5a usb: dwc3: omap: fix "unbalanced disables for smps10_out1" on omap5evm
> aa6812be1feb usb: dwc3: gadget: Give some time to schedule isoc
> 62b20e6e0dde usb: dwc3: core: do not use 3.0 clock when operating in 2.0 mode
> 9d52107185b6 usb: dwc3: imx8mp: Add support for setting SOC specific flags
> 81915384b5d1 usb: dwc3: imx8mp: rename iomem base pointer
> 850ebb27aed8 usb: dwc3-meson-g12a: constify drvdata structs
> a5d847b0afd3 usb: dwc3: pci: Also apply Bay Trail GPIO mappings to ulpi-device
> 582ab24e096f usb: dwc3: pci: Set "linux,phy_charger_detect" property on some Bay Trail boards
> e285cb403994 usb: dwc3: pci: Set the swnode from inside dwc3_pci_quirks()
> e51879d85a4d usb: dwc3: drd: Don't check against CONFIG_OF
> 596c87856e08 usb: dwc3: Program GFLADJ
> 5114c3ee2487 usb: dwc3: Calculate REFCLKPER based on reference clock
> 33fb697ec7e5 usb: dwc3: Get clocks individually
> a102f07e4edf usb: dwc3: drd: Add support for usb-conn-gpio based usb-role-switch

Drop pci, imx8mp, drd patches from changelog as they are touching
"unusef files"

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

