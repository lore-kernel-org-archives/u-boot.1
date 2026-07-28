Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65781C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:25:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 23620812E8;
	Tue, 28 Jul 2026 09:25:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9IG_GPMuPoz5; Tue, 28 Jul 2026 09:25:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 71909812B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785230735;
	bh=A3s0F3sDySApWzy2rK3eYZLA6rtHQljgYvgzOSG4scw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=umwriunEfEIv54RolOS9stQ+JiniAgIX4VithyFkyANRZB3N/nX7taq9w9Exg9L15
	 4igZx5eDyLx0ToalxlwdS6V5lU06K2WUFabzgIiKDCJ8l4riMNPvwWoDUgZ0fPBYm1
	 cfMErqOd/Qj/W6VpnqS7+Wp2hgpK5uEO963V4fqIQ8XmHIwvDmQgES0hluxdp2nKql
	 81/vJi64gd4nC3AbK40h6RfU80FF6reJpLLzKJcSiE7O3dSGk9nLJLFwvlXRydtN1C
	 +dLo1tCe4JaJIvuED6JkbKyuUKDSz/e+0UN1W+CoaPF/XuM8bKFSjfWvHnhY6raI2R
	 o35VS8BS/mQ3Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 71909812B4;
	Tue, 28 Jul 2026 09:25:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CF2F145B
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:25:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C11F2607B6
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:25:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rRWWSXcUJwWj for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:25:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B849A60721
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B849A60721
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B849A60721
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:25:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86C7A848BA; Tue, 28 Jul 2026 11:25:30 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B694882991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:25:27 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6969842D78;
 Tue, 28 Jul 2026 09:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD0E61F00A3A;
 Tue, 28 Jul 2026 09:25:25 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 38/75] usb: dwc3: import from kernel v5.14
In-Reply-To: <20260716134305.614278-39-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-39-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:25:23 +0200
Message-ID: <87y0ev1n5o.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785230726;
 bh=A3s0F3sDySApWzy2rK3eYZLA6rtHQljgYvgzOSG4scw=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=e60pFRPDn9wxu90PJa5tGZkSyxDrI+5gieVNh+Xn+lyFZGw+crBx5ZH5OWDq2qYdZ
 b2UOPWHPwdFdPoY3WvuqKKqtKyFzxOA20huVUYKAx6AiRtjP3fiC/PHA9fqaAlV3xs
 HLJU3pX9KA0b/EVuHdWiUr32qFTuC3e7mnoFIGCE/0cv/3kU9GtvbEmf3d7A/Gdo0P
 Wl4GG/JOXAPHZUGfv8EI4qIzVlQ3bkOA3N6+D5X17SGu/hfEGzUrVHnDeEQLuPT8fI
 MtDdN7XEqM766W9JF2uqPrnhgbrFGxNunBrpPyIrwPLkP+i3B8WZjwycQorW15i0sN
 8eIEMT7lzbH/w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=e60pFRPD
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="e60pFRPD"; 
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
> Sync Linux kernel dwc3 changes from v5.13 to v5.14.
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
> List of commits: git log --oneline v5.13..v5.14
> Commits imported:
> 4a1e25c0a029 usb: dwc3: gadget: Stop EP0 transfers during pullup disable
> 51f1954ad853 usb: dwc3: gadget: Fix dwc3_calc_trbs_left()
> 664cc971fb25 Revert "usb: dwc3: gadget: Use list_replace_init() before traversing lists"
> cb10f68ad815 usb: dwc3: gadget: Avoid runtime resume if disabling pullup
> d25d85061bd8 usb: dwc3: gadget: Use list_replace_init() before traversing lists
> 40edb52298df usb: dwc3: avoid NULL access of usb_gadget_driver
> 84524d1232ec usb: dwc3: Fix debugfs creation flow
> 8562d5bfc0fc USB: dwc3: remove debugfs root dentry storage
> 45d39448b4d0 usb: dwc3: support 64 bit DMA in platform driver
> 2a042767814b usb: dwc3: core: fix kernel panic when do reboot
> 5ff90af9da8f usb: dwc3: debugfs: Add and remove endpoint dirs dynamically
> ab00a41e73dc usb: dwc3: trace: Remove unused fields in dwc3_log_trb
> 457d22850b27 usb: dwc3: pci: Fix DEFINE for Intel Elkhart Lake
> 374ac7448caa usb: dwc3: remove repeated setting of current_dr_role

Drop trace, pci patches since we don't touch any of the files from their
diffstat.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

