Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7982FC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D4ECC60B09;
	Wed, 29 Jul 2026 09:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ss39sQyNF0A9; Wed, 29 Jul 2026 09:25:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 197D660AEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785317122;
	bh=k49ivMOrPVAuwrFCe8N8M9fwZNSrW/6O3LZURxpCgQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ID2unoa1EV9poEbdPenThciqYbX7XRatMOvTuwgiH8LzO/UMg1RromFPYa4fMp0rc
	 8VtLfYeA19e3ygMHcWO8DElflCP9OCxrCYVevTEbI84DnvLJsqWc3y3F3EwGx1GSh1
	 gETWLfZhLbHmNXncRy2wW7ij2zwyNhTB0pdE+T8fqXILdj5mjiXLm8v88Sfuv8e20M
	 4N/WoU8cOdh7S0IslODRcC4E8Vcfj6OQ4TZHS3zOc4ZmiszNV3kFK9UlkKrtHLqphI
	 u+CQpLtE4+rIl1NgXKf9LeyV3I+1QSJPGGPOOrMSHxOiUUFIfaCtxK9Oap6SLcxpaJ
	 I5E//XkNT6PkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 197D660AEC;
	Wed, 29 Jul 2026 09:25:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B5F4126C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:25:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B3B5340B33
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:25:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XVuxJXiR3aj3 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:25:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 98B2140B17
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 98B2140B17
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 98B2140B17
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:25:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489D98494B; Wed, 29 Jul 2026 11:25:17 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 008C38404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:25:14 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0EDE9402EA;
 Wed, 29 Jul 2026 09:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF231F000E9;
 Wed, 29 Jul 2026 09:25:12 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 54/75] usb: dwc3: import from kernel v6.10
In-Reply-To: <20260716134305.614278-55-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-55-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:25:09 +0200
Message-ID: <87ik5yywp6.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785317112;
 bh=k49ivMOrPVAuwrFCe8N8M9fwZNSrW/6O3LZURxpCgQg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=UmJJLKx1/TkWnsv98ruzcId/o49+AqsC6sE0suFde+QaJ+Ks/O1hRfL3XJwrxtwNR
 sCjAuwJDGKqHN7Kaq5xMh3oFAEA98+3xWe7CW0hzY1sZkY2OrirLgcRaRgZ3pi0ufa
 WOE5tJTaGXsP3a9NWU+mGmBM+TIRhPyv9qXN1H0pu84Sz+bO3HqBrYBnn4ISEzjmm7
 XWP5iDfwHmQpWfibhuKrjJNdnfmY0vm3bu8tBcTsbPFpiYrAYpIKk4vUkxVaiGMBV6
 7q4bXRK5rAOgcJvafRIlyPYoPJdZ1ww8g4OqOvqEbJnCrSvyBdCSDPlpz8rTkUhF5G
 ndPF74NzGwIfw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=UmJJLKx1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="UmJJLKx1"; 
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
> Sync Linux kernel dwc3 changes from v6.9 to v6.10.
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
> List of commits: git log --oneline v6.9..v6.10
> Commits imported:
> 2bf35ea46d0b usb: dwc3: pci: add support for the Intel Panther Lake
> fc1d1a712b51 usb: dwc3: core: Workaround for CSR read timeout
> 7838de15bb70 usb: dwc3: core: remove lock of otg mode during gadget suspend/resume to avoid deadlock
> 2c92ca849fcc tracing/treewide: Remove second parameter of __assign_str()
> 01be965ce5ab usb: dwc3: core: Fix unused variable warning in core driver
> 1d26ba0944d3 usb: dwc3: Wait unconditionally after issuing EndXfer command
> 9b780c845fb6 usb: dwc3: exynos: add support for Google Tensor gs101
> 3f12222a4beb usb: dwc3: core: Fix compile warning on s390 gcc in dwc3_get_phy call
> a160e1202ca3 usb: dwc3: qcom: Add multiport suspend/resume support for wrapper
> 5df44c6f4f39 usb: dwc3: qcom: Enable wakeup for applicable ports of multiport
> 2bfc9916a0e4 usb: dwc3: qcom: Refactor IRQ handling in glue driver
> 6410c8033ba7 usb: dwc3: qcom: Add helper function to request wakeup interrupts
> 30a46746ca5a usb: dwc3: core: Refactor PHY logic to support Multiport Controller
> 89d7f9629946 usb: dwc3: core: Skip setting event buffers for host only controllers
> 921e109c6200 usb: dwc3: core: Access XHCI address space temporarily to read port info
> 684e9f5f97eb usb: dwc3: exynos: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
> 606c096adc79 usb: dwc3: Select 2.0 or 3.0 clk base on maximum_speed
> 0fb782b5d5c4 usb: dwc3: pci: Don't set "linux,phy_charger_detect" property on Lenovo Yoga Tab2 1380

Please drop the commit that were not imported from the changelog. (for
example qcom, exynos, pci)

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

