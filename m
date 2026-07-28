Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6304DC54F4C
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0ED6E8134E;
	Tue, 28 Jul 2026 12:22:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wEnviexwiG01; Tue, 28 Jul 2026 12:22:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3798C8127E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785241378;
	bh=uwJclL3Uft6+93XjGDjXShL9I0ONC+DaPEkd9LpdiGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CX48ZdZk16Ky/szlD9aKzPr6Jljlg46E4lz2tznV/mLFSQ+nz6akpcDnYW/Myrhbw
	 wEkTjQ4NsmDATe0PsXlT7PEH11ksNe/n5rYvUlhCx7pNJNsLx/ZhCnuB5gPzePdPb3
	 wXp+J2xwbhPcgRw99OFb+KmzeCXhGeXABqNEXTk5ueh/kxC+Rt7tNwLVM3yyxlVcsq
	 WCF33rlMcFJoU3KMixLj49TgJjDXGRff8pKH+Q6HLZVbV7RBcQkBk6jzKiVsektPzf
	 NmH9vGzR2miEcUrBNlPc8QlUacKQk4Y5IzflP3nOxoWIrO9NJoOg0hN14kzdwB6JBP
	 hHOuouh/DH/4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3798C8127E;
	Tue, 28 Jul 2026 12:22:58 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D989A2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BF4F460866
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C208G-FlCWSV for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:22:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org AB33E60861
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AB33E60861
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB33E60861
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:22:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 462B78494B; Tue, 28 Jul 2026 14:22:53 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BB4582991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 14:22:51 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D990B60A9B;
 Tue, 28 Jul 2026 12:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17C7C1F000E9;
 Tue, 28 Jul 2026 12:22:48 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 49/75] usb: dwc3: import from kernel v6.5
In-Reply-To: <20260716134305.614278-50-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-50-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 14:22:47 +0200
Message-ID: <87zezbz4ko.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785241369;
 bh=uwJclL3Uft6+93XjGDjXShL9I0ONC+DaPEkd9LpdiGo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=XMNITgegZmx//xDWlg8651cab6rod9jdoltyZEYD2CEioGZ1JPOF0VlTU0a9thdc9
 J7vP743oyFY20USyMsTCQD0guxYZscy4yBggGrH46tyuQQlspzKBC40lfkev4p+dPk
 lCQAWaGwqIMDFPWPYlhSXCaxnsmkk9CECar1NADaOA1GS3fJezJJkn8xiI12JDhEa/
 RVtJlVxli27xPObQ/sOdRrSLdzGyV3VyaD2K/TP7239KUU2wlsXlM9OpflbUJ/74ez
 9ExhAhMHG2hAJZipnQfOcDjdO3o4JlKw2xOIuWKo+gj+eAIf6a4xfHqvSZyGBF5+oL
 DV8XYUaOUSoAA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=XMNITgeg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="XMNITgeg"; 
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
> Sync Linux kernel dwc3 changes from v6.4 to v6.5.
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
> List of commits: git log --oneline v6.4..v6.5
> Commits imported:
> 3ddaa6a27457 usb: dwc3: Properly handle processing of pending events
> b32b8f2b9542 usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy
> 734ae15ab95a Revert "usb: dwc3: core: Enable AutoRetry feature in the controller"
> e835c0a4e23c usb: dwc3: don't reset device side if dwc3 was configured as host-only
> c0aabed9cabe usb: dwc3: gadget: Propagate core init errors to UDC during pullup
> 01052b91c980 usb: dwc3-meson-g12a: Fix an error handling path in dwc3_meson_g12a_probe()
> 60d5b71933c4 usb: dwc3: qcom: use dev_err_probe() where appropriate
> 4a944da70712 usb: dwc3: qcom: Fix an error handling path in dwc3_qcom_probe()
> 8fd95da2cfb5 usb: dwc3: qcom: Release the correct resources in dwc3_qcom_remove()
> 097fb3ee710d usb: dwc3: qcom: Fix potential memory leak
> b4a4be847184 USB: fix up merge of 6.4-rc4 into usb-next
> 5b3eb973bf38 usb: dwc3-xilinx: Convert to platform remove callback returning void
> 2f6453761e7c usb: dwc3-st: Convert to platform remove callback returning void
> d662268dcca8 usb: dwc3-qcom: Convert to platform remove callback returning void
> abe04efc13ed usb: dwc3-omap: Convert to platform remove callback returning void
> 86a2b452179b usb: dwc3-of-simple: Convert to platform remove callback returning void
> 3ffea6e0f34c usb: dwc3-meson-g12a: Convert to platform remove callback returning void
> 039e3dede538 usb: dwc3-keystone: Convert to platform remove callback returning void
> 3791a3e6f455 usb: dwc3-imx8mp: Convert to platform remove callback returning void
> 8257d5f548d6 usb: dwc3-exynos: Convert to platform remove callback returning void
> 890258e22117 usb: dwc3-am62: Convert to platform remove callback returning void
> 0176568702a5 usb: core: Convert to platform remove callback returning void
> 6bae03b0484b usb: dwc3-meson-g12a: support OTG switch for all IP versions
> 813f44d57e19 usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens
> 2f28c3c9c347 usb: dwc3: Add error logs for unknown endpoint events
> ec5eb43813a4 usb: dwc3: core: add support for realtek SoCs custom's global register start address

Please drop the patches that were not applied from the changelog (for
example the qcom ones)

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

