Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69412C54EFC
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:51:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 064D1812BE;
	Tue, 28 Jul 2026 09:51:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QUZjU9LwUSwB; Tue, 28 Jul 2026 09:51:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4282B81292
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785232281;
	bh=VFlVV65yxhGTJ1ss6rCO3eqJJBigSMemPqa1SkcA1BU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ed2r0vdMGoWpEugGFqLz9cFarVYzWr7AAUCVe0XFBn9KelQ+WbAc61P7jjflhbnZV
	 WFO6zR+GGFfiC4dVlq174DpGJ61LNnf9PiejMaaF6lu9TA5ytmabBFxCzT/lvfh4M1
	 lNhrOUf2mqYYTd8e8CYLysR5+oeIZ/MJfSVHcMrc8DTJQOwwaJLDYAHm3bSHvlfuPy
	 ccWuczPDSDwR+pz9XNjMUDCtOV/7i8qlRtqx1GmZjtRyMHRE+GBWP9w0GzIbUGbSWL
	 gQ1O0jGz7On52lWD5EuK4wI0MtkR4PFn1fS5MUicB1JxLv9+6CjAGaZzbCJxUWQ32v
	 37ZCxropcwlyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4282B81292;
	Tue, 28 Jul 2026 09:51:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BD14A2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:51:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AF1EC81292
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:51:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id njAFdSD9Mn9H for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:51:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 3BD3781290
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3BD3781290
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3BD3781290
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:51:18 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88DBB8494B; Tue, 28 Jul 2026 11:51:16 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 074FA848BA
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:51:14 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 85D2A60A9E;
 Tue, 28 Jul 2026 09:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8FB1F00A3A;
 Tue, 28 Jul 2026 09:51:11 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 41/75] usb: dwc3: import from kernel v5.17
In-Reply-To: <20260716134305.614278-42-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-42-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:51:09 +0200
Message-ID: <87pl071lyq.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785232272;
 bh=VFlVV65yxhGTJ1ss6rCO3eqJJBigSMemPqa1SkcA1BU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ZySTUt8S9rpKGRyoFPVLGNApv1GXSKPNEXTrl7+ZZBbZY0FZdQBQt5MVQzJkFqZ55
 /ebsdkeMoxWXM1p4HzzbiWxijQWOAN5t4OiI2jIeRgxNqAx4caebXOYi0eSsG9jz9s
 hyE6c/QsLuXC2My7CBbkYoi+AkCe4IL37nAqu3HjOmgQIpfIiMkNC4h7ANCZ8FN19W
 +X23PWD6w0DhRdwl0k3APnnVQvaDtix/JahEl9JGUFGQ9WG1937kRN6ZDOD+CpRBBI
 Ii6ldNYAPl8+hVEIwm7qBO1K3C0vDgDqPLc9UKmQbuV9GhHdPAISn1PBmKb9Xz/GbI
 TUCXjg0709fLg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ZySTUt8S
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZySTUt8S"; 
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
> Sync Linux kernel dwc3 changes from v5.16 to v5.17.
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
> List of commits: git log --oneline v5.16..v5.17
> Commits imported:
> 84918a89d6ef usb: dwc3: gadget: Let the interrupt handler disable bottom halves.
> 62e3f0afe246 usb: dwc3: pci: Fix Bay Trail phy GPIO mappings
> d7c93a903f33 usb: dwc3: pci: Add "snps,dis_u2_susphy_quirk" for Intel Bay Trail
> 038438a25c45 usb: dwc3: pci: add support for the Intel Raptor Lake-S
> 117b4e96c7f3 usb: dwc3: gadget: Prevent core from processing stale TRBs
> b470947c3672 usb: dwc3: xilinx: fix uninitialized return value
> 2cc9b1c93b1c usb: dwc3: xilinx: Fix error handling when getting USB3 PHY
> 9678f3361afc usb: dwc3: xilinx: Skip resets and USB3 register settings for USB2.0 mode
> b52fe2dbb3e6 usb: dwc3: qcom: Fix NULL vs IS_ERR checking in dwc3_qcom_probe
> fa0ef93868a6 usb: dwc3: dwc3-qcom: Add missing platform_device_put() in dwc3_qcom_acpi_register_core
> 74b39dfabd76 usb: dwc3: Drop unneeded calls to platform_get_resource_byname()
> 666f3de741f7 usb: dwc3: gadget: Support Multi-Stream Transfer
> 76c4c95dac0d usb: dwc3: gadget: Skip reading GEVNTSIZn
> a02a26eb0aea usb: dwc3: gadget: Ignore Update Transfer cmd params
> bc27117c7cdd usb: dwc3: gadget: Skip checking Update Transfer status
> 4ce3b45704d5 usb: dwc3: meson-g12a: fix shared reset control use

Drop pci, xilinx, qcom from the changelog. These touch "unused files" so
I'm pretty sure they are not "imported commits"

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

