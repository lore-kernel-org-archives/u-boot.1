Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 413E8C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:22:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 985AD40B48;
	Wed, 29 Jul 2026 09:22:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YaQIjIwU3H-H; Wed, 29 Jul 2026 09:22:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A9C9D40AD9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785316956;
	bh=GFEl1DXG6ScFEaojy+ki64i/URMqT881R2R+6KSNcak=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0Uz4c31nJ2ZeLcT7vYOh6p3FSu7vrb3scuk+bS5MAniGAfa0nfry0MpzeDE3mZeg1
	 DEjwr1y+SkcVBsw8s/z3qKYGBeAtgTRSNA5t8AV28rEGduqNh03BE9ARd/+3Ro86wF
	 AcoEpc0h+DybE2kDD/LC6xUU8tS1NdC3yDW3Wfb7QzIfN2sPW2ZiqRwWlXK7aeSC79
	 oRtK8WhDD4ya0dPJwrpQWckU4YFVCx7N2cPQwTdGnWayx0MNdDMHm33i5AqvRpPFFu
	 znYuUzpVqOynSdaFYeSmx/alshILV10yWPX8iMfVBF5f1cuwAeeXWHodQ3XWVEY5/r
	 kX9FCGsZ7DAGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A9C9D40AD9;
	Wed, 29 Jul 2026 09:22:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 78404788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:22:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5E425401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:22:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7iFUbxKAyvg8 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:22:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 035C74009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 035C74009C
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 035C74009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:22:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F2598494B; Wed, 29 Jul 2026 11:22:31 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 072198404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:22:29 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF81F60A5E;
 Wed, 29 Jul 2026 09:22:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CA31F000E9;
 Wed, 29 Jul 2026 09:22:26 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 52/75] usb: dwc3: import from kernel v6.8
In-Reply-To: <20260716134305.614278-53-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-53-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:22:25 +0200
Message-ID: <87o6fqywtq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785316947;
 bh=GFEl1DXG6ScFEaojy+ki64i/URMqT881R2R+6KSNcak=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Q/W2fm6+RIItA/Xikfp+bYHOjNhFAMVKaQc0qWXMVRTs/ySLKqY8ncICCEbOOPjYK
 XSl7/PNcDzS9g+EQ24KAwLYl43adkUjcMykZJzIZd4MdrD9e3ZxVmHo3gFxVc/n+yo
 uXxToIRLHkEH2txPxVTIkOee5OSC7P5zuUdGkyWcszKvGtYcP7SHzIzF3LOUI1Xt1K
 kkIVfKG0PtCgnmEDTvHh09M2IsWlkigGMGU5a8e+gBtRs1hSOsttIXTFHF5Devxwz0
 SZlQTtXBhPGOsMcGcMd1CXXc9liPL5U3R7XpyAPZ/Ic1m02yZbRkYDGEk+XfSE2ZXE
 D3LmUD8E+9Rpg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Q/W2fm6+
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Q/W2fm6+"; 
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
> Sync Linux kernel dwc3 changes from v6.7 to v6.8.
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
> List of commits: git log --oneline v6.7..v6.8
> Commits imported:
> b191a18cb5c4 usb: dwc3: gadget: Don't disconnect if not started
> 7d708c145b26 Revert "usb: dwc3: Support EBC feature of DWC_usb31"
> 61a348857e86 usb: dwc3: gadget: Fix NULL pointer dereference in dwc3_gadget_suspend
> de4b5b28c87c usb: dwc3: pci: add support for the Intel Arrow Lake-H
> 817349b6d26a usb: dwc3: host: Set XHCI_SG_TRB_CACHE_SIZE_QUIRK
> aefdcd89d72b usb: dwc3: qcom: Rename hs_phy_irq to qusb2_phy_irq
> 3c7af52c7616 usb: dwc3: gadget: Queue PM runtime idle on disconnect event
> 68c26fe58182 usb: dwc3: set pm runtime active before resume common
> 398aa9a7e77c usb: dwc3: Support EBC feature of DWC_usb31
> 91736d0619eb usb: dwc3: core: set force_gen1 bit in USB31 devices if max speed is SS
> e9d40b215e38 usb: dwc: ep0: Update request status in dwc3_ep0_stall_restart
> 730e12fbec53 usb: dwc3: gadget: Handle EP0 request dequeuing properly
> afe28cd686ae Revert "usb: dwc3: don't reset device side if dwc3 was configured as host-only"
> 7059fbebcb00 Revert "usb: dwc3: Soft reset phy on probe for host"
> c084af69a8f4 usb: dwc3: imx8mp: Fix smatch warning
> 53b5ff83d893 usb: dwc3: xilinx: improve error handling for PM APIs

Please drop the commits that were not imported (for example qcom,
imx8mp, xilinx)

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

