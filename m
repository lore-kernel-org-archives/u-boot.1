Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E844FC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:02:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26F2E60675;
	Mon, 27 Jul 2026 09:02:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u45egNipFS-T; Mon, 27 Jul 2026 09:02:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4AE4E60627
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142926;
	bh=EVgvLO8JHQRTB1xe0dQAhwy8DrfUGFlpoMh99LnpNDQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XSlx64OukP9b5rMlwf6qXm8Z/2YCKZZZYQvdFr1thDqfR8Y8TvE5StqD6q0Y4TzF2
	 Ktzr8fsm4w3LJBrjjEa0x9FHeXeusVtlV8R4kPf33n3ZtZ76k7TB14UDXse9MalZoG
	 DMcYdVYKlIMNBxXPSg2iaFou8OeT2k+YP5WhzciA6W9FcoKKz+WYvLCRSWhOE6EwS9
	 v23Xchslv3uRzQPHASa/POIMgHJMCU73yzHiXXspYi/JYtx2dDuhQYAVQSPv93j35R
	 YxN7Cdq+JC9lpnS4uxz0vD6BjpiVdacAoD1/6v8fbm6TN50CyluJwge7vw9bMcDGPG
	 nACUiuxeYEuTQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4AE4E60627;
	Mon, 27 Jul 2026 09:02:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 14CF1357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:02:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EF55B60627
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:02:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b74aD9aIi0Eg for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:02:04 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org A353C605EE
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A353C605EE
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A353C605EE
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:02:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1323484671; Mon, 27 Jul 2026 11:02:02 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6BBA82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:01:59 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7CB89601DE;
 Mon, 27 Jul 2026 09:01:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0B91F000E9;
 Mon, 27 Jul 2026 09:01:57 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 15/75] usb: dwc3: import from kernel v4.12
In-Reply-To: <20260716134305.614278-16-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-16-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:01:55 +0200
Message-ID: <874ihk6c1o.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142918;
 bh=EVgvLO8JHQRTB1xe0dQAhwy8DrfUGFlpoMh99LnpNDQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=GxQ8Q88lPLKtw7XQ4UrNo/pQKAOzwTt9UcWdn7lZHvmmzLdM6lGr5YZ8eMGWTfeXg
 dUYQXN6miJr7aVexQD8jnnEAMZeM9bZbtvDAjGbgAq716DQmXl+TAL8V/a/smdn7I5
 PCper72KQ7JxMgprGuELUpHlrBkUMAJ56hRrWsEyhi3SbidmgQJvUEItH5qkb1b+nZ
 YXrrQJEDsQjLXA3D0ANd2YBecxCIn5Le/UtToJ84JXtdDu8KJXt7gxEKU/vYFnDGBr
 2GjQPmMY+pp9Qf8Ngn1adJxH48nF6D7/uMONEwgzVxO+rXpnBi5ytcyWMWVJgK0BnQ
 ymt/9T6FaohOQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=GxQ8Q88l
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="GxQ8Q88l"; 
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

On Thu, Jul 16, 2026 at 15:41, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v4.11 to v4.12.
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
> List of commits: git log --oneline v4.11..v4.12
> Commits imported:
> 018047a1dba7 usb: dwc3: keystone: check return value
> d325a1de49d6 usb: dwc3: gadget: Prevent losing events in event cache
> f1d6826cae30 usb: dwc3: gadget: Fix ISO transfer performance
> 682179592e48 usb: dwc3: pci: add Intel Cannonlake PCI IDs
> 9840354ff429 usb: dwc3: Add dual-role support
> 41ce1456e1db usb: dwc3: core: make dwc3_set_mode() work properly
> b202c42cbf81 usb: dwc3: debugfs: remove unnecessary | operator
> 6b3261a27428 usb: dwc3: core: add current_dr_role member
> d6e5a549cc4d usb: dwc3: simplify ZLP handling
> 4199c5f8bccd usb: dwc3: ep0: improve handling of unaligned OUT requests
> d686a5ff6a2d usb: dwc3: ep0: pass dep as argument to internal functions
> 7d5e650a5fdb usb: dwc3: ep0: use immediate SETUP on TRB
> b5c7ed5cca82 usb: dwc3: expose dwc3_trb_type_string()
> 90abb425d949 usb: dwc3: debugfs: return strings that match tracepoints
> 26c9f3e391d1 usb: dwc3: debugfs: make use of dwc3_gadget_link_string()
> 2df301cd3d71 usb: dwc3: debugfs: downcase OTG on 'mode' file
> ff3f0789b3dc usb: dwc3: use BIT() macro where possible
> aad7c2596495 usb: dwc3: trace: change format for string to cmd trace
> af771d731b8e usb: dwc3: gadget: Fix starting microframe for ISOC
> 3a932b0f50f4 usb: dwc3: exynos: change goto labels to meaningful names
> f3bcfc7e68f0 usb: dwc3: remove dwc3_gadget_init_hw_endpoints
> 47d3946ea220 usb: dwc3: refactor gadget endpoint count calculation
> 8261bd4e91e2 usb: dwc3: make macros safe to expression arguments
> 05428ba983e6 usb: dwc3: remove dwc3_log_msg trace class
> 1966b8657d05 usb: dwc3: make sure UX_EXIT_PX is cleared
> 4a56e413b50c usb: dwc3: pci: Switch to devm_acpi_dev_add_driver_gpios()
> 2c93e790e825 usb: add CONFIG_USB_PCI for system have both PCI HW and non-PCI based USB HW
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

