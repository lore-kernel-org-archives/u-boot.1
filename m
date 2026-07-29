Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A41C54F51
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:24:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5BE6E8111C;
	Wed, 29 Jul 2026 09:24:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4nk72nfrx26; Wed, 29 Jul 2026 09:24:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E1464810F5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785317042;
	bh=O+NMeitEVaj+dA9PjE+U3COJg/ZliIiRoAdW2OCaEDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=b3lpJuYrwdRYxli8Me6fbemw7Pys+4x+yySgmBATAXF+lQNZN3tpTBsvVv6srXw+u
	 ysJYFa1i7j5ruudfs/cJV5xfGvr68j7zNFdVB1q0LqdDcK4UwssxBwQLm+r6CriZbH
	 K0X9jmPiVUm5reYUn16TOQwJAO+RSRMKFc7cOTxxUAu+8L7w+jZ9r9qUixeVmcDxJ7
	 naFFz5TyMt5Bq0fJ0Ayxyvg6RGkOMp+38ThOd9+kFDBeAOpaEkDAyx6GY39eEkXAQz
	 doqlFMZtCDcNiuvvfNY9SHEcI9j74nR3/8xDm/imN1/TbgtdcmF6mWy54IQhWN3Pds
	 VH16Wo+ixM4FA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E1464810F5;
	Wed, 29 Jul 2026 09:24:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4ECDF3B0
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34F2360AF2
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:24:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sEJEuX7wFP_F for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:23:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C319660AC9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C319660AC9
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C319660AC9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:23:58 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id EE44A8494B; Wed, 29 Jul 2026 11:23:56 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B8DA8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:23:54 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7E3DE60A5E;
 Wed, 29 Jul 2026 09:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844671F000E9;
 Wed, 29 Jul 2026 09:23:52 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 53/75] usb: dwc3: import from kernel v6.9
In-Reply-To: <20260716134305.614278-54-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-54-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:23:50 +0200
Message-ID: <87ldauywrd.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785317033;
 bh=O+NMeitEVaj+dA9PjE+U3COJg/ZliIiRoAdW2OCaEDY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=oicytKqtorzmrDY+QjoTIVikgOCVhLyvKTIog6L5GMiyRG+4hEo+bgMkxxVkj/hu+
 6XmWr1s5P8oHtNl7QIztya5YMnwQ5LRZAjPrmfa1/S1NVDEm3zHyhulG2LzC1Idy/Q
 o96rBswbSlBZDP+g4ru5dbzZ0x8XwHB9+rN+4Oh0v27NB8Y+EtDbgU/SzKycm9TDo8
 Ge9hG75erEdDPmyfcovUm5lOBfi+Y2neNplNqGXSme1Y7EY0q57OxQdbl11aLs57qq
 8TnunUnI8jNS6XtCzzOPNM3aHF3fUBATaZewF/hzNdUa/6FO7XHy3KvxhYZtcorDfo
 jeheee74u93EA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=oicytKqt
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="oicytKqt"; 
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
> Sync Linux kernel dwc3 changes from v6.8 to v6.9.
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
> List of commits: git log --oneline v6.8..v6.9
> Commits imported:
> 6d735722063a usb: dwc3: core: Prevent phy suspend during init
> f2e0eee47038 usb: dwc3: ep0: Don't reset resource alloc flag
> f121531703ae usb: dwc3: pci: Drop duplicate ID
> f9aa41130ac6 usb: dwc3: Properly set system wakeup
> 1e43c86d84fb usb: dwc3: core: Add DWC31 version 2.00a controller
> f0b9c578408e usb: dwc3-am62: add workaround for Errata i2409
> d78ff37567c9 usb: dwc3-am62: Fix PHY core voltage selection
> 4ead695e6b3c usb: dwc3-am62: Disable wakeup at remove
> 6661befe4100 usb: dwc3-am62: fix module unload/reload behavior
> 8d36c0e433e0 usb: dwc3: of-simple: Add compatible for hi3798mv200 DWC3 controller
> 41717b88abf1 usb: dwc3: qcom: Remove ACPI support from glue driver
> a6ba1e453174 usb: dwc3: apply snps,host-vbus-glitches workaround unconditionally
> b65bdf7fd605 usb: dwc3: Fix an IS_ERR() vs NULL check in dwc3_power_off_all_roothub_ports()
> 50c72a46eb41 usb: dwc3: gadget: Remove redundant assignment to pointer trb
> b311048c174d usb: dwc3: gadget: Rewrite endpoint allocation flow
> 2d2a3349521d usb: dwc3: Add workaround for host mode VBUS glitch when boot
> 44481a010344 usb: dwc3-of-simple: Stop using of_reset_control_array_get() directly

Please drop from the changelog the commits that were not imported (for
example pci, qcom, dwc3-of-simple)

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

