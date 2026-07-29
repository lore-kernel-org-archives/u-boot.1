Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E77C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:26:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 27A3A40B17;
	Wed, 29 Jul 2026 09:26:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GBrI8dRnIjTA; Wed, 29 Jul 2026 09:26:46 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 40FF540913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785317206;
	bh=DJtY2z81Hvwq5lZRa4Pa6xctGOi2/Igga87fDvt4qrY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HCud9IzN4PD8EycH7CqFBPiuXvEyLStfEWk7BetLVnoxuZcIdhQXG47fi5Ccbv0dI
	 DRqHpnoYCW5KvrYRfVywYgwV/gKYXq/CxvJZCNhagrI+7CWRkmDaVZ/F4psWKYuTLj
	 knyDrOFS8Dg33qixQy8Cn+UP09Df83jkViUH6CEd8Vg45fiVhO5voQ5UBlYYlU9HdU
	 qoD0c43TZm9LuLIhiboALyEAvO5HvVQWeS6r+dF/FIRfnO8AL1oFOkYyjO2KSZz46U
	 ZaSVY1Xa9G9EnGGf9+h9KcQWRcHDFkrOdBjfS7Ye4JOXoIZ/y1Noqr56/DMBrRPHlP
	 TJIEQst7bvtAA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 40FF540913;
	Wed, 29 Jul 2026 09:26:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id ACC0926C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:26:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F4C860AEF
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:26:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JUyHvTgmjdo8 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:26:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 356CC60AC9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 356CC60AC9
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 356CC60AC9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:26:43 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA1418494B; Wed, 29 Jul 2026 11:26:40 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CA1C88404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:26:38 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4264240704;
 Wed, 29 Jul 2026 09:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F3181F000E9;
 Wed, 29 Jul 2026 09:26:36 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 55/75] usb: dwc3: import from kernel v6.11
In-Reply-To: <20260716134305.614278-56-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-56-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:26:34 +0200
Message-ID: <87fr12ywmt.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785317197;
 bh=DJtY2z81Hvwq5lZRa4Pa6xctGOi2/Igga87fDvt4qrY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=fD7GRr8dWXCu1v+lOQQofMg5E/HciQ+W1PWqdheE0cqNQk20+ViVMZGpt+U/arSdR
 NV/jlGe/mUsjTTow8IzYZxwNBsRGYgY9zrUyJ8WWqxz69LKo+dNcX7B8H2FUTuHSrZ
 fV35PiThfzrfQRNROIg2tsg7H233Rs6gLdH4bIOdNAJhl7H2ftfrwMKvGOCYR9a1O3
 NJnlT5Ed55iCrOF8QNF/YiLdXzJSSrAhE2cuFSoy5YOLuwHjdhZrhCw0EhbIKoZeab
 xMj46gO3n3aLdLNUdHN2KQXjB8GoigaIrj2iRF5CN0vI7NxBcUJldCQE8jd0t9By7o
 9O6DdWkc4WJyw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=fD7GRr8d
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="fD7GRr8d"; 
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
> Sync Linux kernel dwc3 changes from v6.10 to v6.11.
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
> List of commits: git log --oneline v6.10..v6.11
> Commits imported:
> 9149c9b0c7e0 usb: dwc3: core: update LC timer as per USB Spec V3.2
> 00dcf2fa449f usb: dwc3: Avoid waking up gadget during startxfer
> cd4897bfd14f usb: dwc3: st: add missing depopulate in probe error path
> ddfcfeba8910 usb: dwc3: st: fix probed platform device ref count on probe error path
> 72fca8371f20 usb: dwc3: ep0: Don't reset resource alloc flag (including ep0)
> 16f2a21d9d7e usb: dwc3: xilinx: add missing depopulate in probe error path
> 2aa765a43817 usb: dwc3: omap: add missing depopulate in probe error path
> 14e497183df2 usb: dwc3: core: Prevent USB core invalid event buffer address access
> d504bfa6cfd1 usb: dwc3: enable CCI support for AMD-xilinx DWC3 controller
> 179264157bba usb: dwc3: core: Check all ports when set phy suspend
> b7ec7fd63256 usb: dwc3: Support quirk for writing high-low order

Please drop the commits from the changelog that were not imported. (For
example st, xilinx)

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

