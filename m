Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F87CC54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:30:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CFE0981144;
	Wed, 29 Jul 2026 09:30:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wY9TFDepRQQl; Wed, 29 Jul 2026 09:30:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0A5C68113B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785317430;
	bh=A/bEVMgW0A+C24r0Kjq8jupZblbFhigggXRtZ1ZYOR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DaiP0VYAIHUb7+UK5DXRpVXFMGiog67OoJ1fMUIan4cWy/bPkAG3dSm9jVlQM+Kjt
	 usUk0G18mTh9nBxy03VPhT7PqeTsO1sfmJTbcicKrnkbap2c6tkPXoECCfR51XjmJS
	 VI/7/vG4Tbjm9+NQuFElTOwzXiCQzAbwzcrF7JXdKUxNBg/zF55fVb25CA6c7hLo8X
	 mbh+/BEJTuaDLwg6x3LuSzC+H1L48xZOjBwVEwWmhxm7wSLvd/wjuavp/aVptTXwtR
	 r1wm5V+RaAQ60344jWJ2JsHeBAWxGewap8qC7EhR6wpkF9o5uGC14j2/RBdPffPm1V
	 Yl0WnNEdWQ4YA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0A5C68113B;
	Wed, 29 Jul 2026 09:30:30 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 101BE788
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA5C38113B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:30:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NT8sMhgyPbrQ for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:30:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 92D9F8112D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92D9F8112D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 92D9F8112D
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:30:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0E0B8494B; Wed, 29 Jul 2026 11:30:25 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CD18404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:30:23 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B475560A6C;
 Wed, 29 Jul 2026 09:30:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3751F000E9;
 Wed, 29 Jul 2026 09:30:21 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 58/75] usb: dwc3: import from kernel v6.14
In-Reply-To: <20260716134305.614278-59-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-59-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:30:19 +0200
Message-ID: <877bmeywgk.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785317422;
 bh=A/bEVMgW0A+C24r0Kjq8jupZblbFhigggXRtZ1ZYOR4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=MT1TrvCpTrc6g6oZ+gNcbaCZvqk33jCrlV6FI5Pf6UaOgykeXUw2dwqHxpm74VAUR
 Cl6AZHRxX4JRoAodhLcRfESBG2sUucc3GHuN40vXL+Z5hD95udB9YF4dA+rmrcdcXk
 jrXBAewVbfz415FZFHDlZ/AJZSrC1/0YkrQo18qgTh2p7CIsZaWIfHkDIXWOkiZq6n
 P38QZB7okf+769Q4pMbHWRbqlQjweJDKG3ptpPmC6mlFh/eGGoYw2b3Xm50PTmbQgR
 oqgmZF3gpVHzMRfmd729vnpEMo11eREJeS97VO538k0SfifVH3YS4NsYrCJ+JOre0L
 z4SYspcYsSNAg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=MT1TrvCp
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="MT1TrvCp"; 
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
> Sync Linux kernel dwc3 changes from v6.13 to v6.14.
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
> List of commits: git log --oneline v6.13..v6.14
> Commits imported:
> cc5bfc4e16fc usb: dwc3: Set SUSPENDENABLE soon after phy init
> 69c58deec196 usb: dwc3: gadget: Prevent irq storm when TH re-executes
> d3a8c28426fc usb: dwc3: Fix timeout issue during controller enter/exit from halt state
> 1ed3af5a2aae usb: dwc3: Document nostream_work
> 66e0ea341a2a usb: dwc3: core: Defer the probe until USB power supply ready
> dcfe437492e2 usb: dwc3: gadget: Reinitiate stream for all host NoStream behavior
> 7d3934884bab usb: dwc3: omap: Fix devm_regulator_get_optional() error handling
> e84a7da8c5d6 usb: dwc3: st: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr()
> a266462b937b usb: dwc3-am62: Fix an OF node leak in phy_syscon_pll_refclk()
> e3a9bd247cdd usb: dwc3: Skip resume if pm_runtime_set_active() fails
> 533561a8aad5 usb: dwc3: omap: Use devm_regulator_get_optional()
> 1ff24d40b3c3 usb: dwc3: gadget: Fix incorrect UDC state after manual deconfiguration
> 31d500c2d0d4 usb: dwc3: dwc3-am62: Re-initialize controller if lost power in PM suspend
> 04d5b4c23f3b usb: dwc3: core: Disable USB2 retry for DWC_usb31 1.80a and prior
> 686d4a2c26b4 usb: dwc3: remove unused sg struct member

Some commits listed here are not imported. For example: st.
Please drop them from the changelog.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

