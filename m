Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BA43C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:28:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9676F8111A;
	Wed, 29 Jul 2026 09:28:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Q1sYbJJPwPD; Wed, 29 Jul 2026 09:28:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5E992810F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785317280;
	bh=PgZFxGL7VNb24cnRRcxyGUSvbAkilkvuigWn01zZJ3Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKvIe2+tAu/sHpOV0BP5uMLUaAABAT0tK1P9i6GyreUrobjcm5u3TOr/CnUKd49vh
	 Hk3IRe7GCMHi/TtRcqTrMh2++LUZV7BgWJl0h2AoY3bu6FzDCkrB/XwY9vdGyk3O+3
	 DptZBhYL6JYJv1kCf/87/19BKVLCYO4QqILD764SyJbk92nkofWKa+oiOYYkrh/2nI
	 5MZIXxpMJujoeLfhJB0rKAw6ybzT6HdsCldh8TznKy6wck0eQXYLxuyX6jBtXpHAKw
	 MXdShgl9TvLkEa5BQecjDlW18EAfaov4OXR3LY+bDwGCI+hzTpi0mpxmhURWleZ5yX
	 517A2cUg9hkxQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5E992810F5;
	Wed, 29 Jul 2026 09:28:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D7513B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:27:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 18EE460AEF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:27:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id bJ-E0ywh9-mZ for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:27:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org ADAF860ADD
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ADAF860ADD
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id ADAF860ADD
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:27:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 016BE8494B; Wed, 29 Jul 2026 11:27:56 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B36008404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:27:53 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7BA743C8A;
 Wed, 29 Jul 2026 09:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0C9E1F000E9;
 Wed, 29 Jul 2026 09:27:50 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 56/75] usb: dwc3: import from kernel v6.12
In-Reply-To: <20260716134305.614278-57-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-57-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:27:48 +0200
Message-ID: <87cxw6ywkr.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785317271;
 bh=PgZFxGL7VNb24cnRRcxyGUSvbAkilkvuigWn01zZJ3Q=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=dJ21qggMwwaAyT6xim897D1uI7bQ/Nhp1EZpuzXhgeJm9uwbhZgGPgFtkm5Utbg6Y
 JV7mRPmkxwKrtsQPfijvrUJQyIRJF8e2pSYe903F1qlWI9oRrqf1CsTTJ6n5wiXyPM
 uth1mgi+xKduoG0jl5fXbJL+X3gr1wSDFCOyTUorkuHu4fzOxkraPlJs1Irp8bPOnm
 eEXNXhSBdlOekAGvjVjhNeh/EtSq4O6FKwpmmKsscRzsUkmCATtCKUFzeaiGP480Qn
 E3ODMrfmbRfW0DWN5/p21DNxma81xWHGHdcvJ7d7os0u0ScUR8M8WMdzPL4ohslJOa
 whK9A/qbDBQ8A==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=dJ21qggM
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="dJ21qggM"; 
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
> Sync Linux kernel dwc3 changes from v6.11 to v6.12.
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
> List of commits: git log --oneline v6.11..v6.12
> Commits imported:
> 9cfb31e4c89d usb: dwc3: fix fault at system suspend if device was already runtime suspended
> 705e3ce37bcc usb: dwc3: core: Fix system suspend on TI AM62 platforms
> c96e31252110 usb: dwc3: Wait for EndXfer completion before restoring GUSB2PHYCFG
> 0d410e8913f5 usb: dwc3: core: Stop processing of pending events if controller is halted
> 897e13a8f9a2 usb: dwc3: re-enable runtime PM after failed resume
> e8afd5ace118 usb: dwc3: rtk: Clean up error code in __get_dwc3_maximum_speed()
> 4664b73859dc usb: dwc3: imx8mp: disable SS_CON and U3 wakeup for system sleep
> a9400f1979a0 usb: dwc3: imx8mp: add 2 software managed quirk properties for host mode
> e23593ee41fa usb: dwc3: xilinx: simplify with dev_err_probe
> 819c0c31a78e usb: dwc3: rtk: return directly and simplify with devm_platform_ioremap_resource
> f93e96c544ca usb: dwc3: rtk: use scoped device node handling to simplify error paths
> 17d206a3687e usb: dwc3: qcom: simplify with devm_platform_ioremap_resource
> a85f13d50925 usb: dwc3: qcom: use scoped device node handling to simplify error paths
> 34e8df2fb2de usb: dwc3: imx8mp: use scoped device node handling to simplify error paths
> 81d905b10220 usb: dwc3: imx8mp: simplify with dev_err_probe
> 3fdfebc58e0d usb: dwc3: imx8mp: simplify with devm_clk_get_enabled
> fcc78cce2f96 usb: dwc3: st: simplify pdev->dev usage
> a93c3ad6a9b2 usb: dwc3: st: simplify with dev_err_probe
> bde053252c02 usb: dwc3: st: use scoped device node handling to simplify error paths
> f35860242548 usb: dwc3: Use of_property_read_variable_u32_array() to read "power"
> 89b7539123bf usb: dwc3: imx8mp: Switch to RUNTIME/SYSTEM_SLEEP_PM_OPS()

Some commits listed here are not imported (for example rtk, xilinx,
imx8mp, st).
Please drop them from the changelog.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

