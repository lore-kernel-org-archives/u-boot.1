Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DA4C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:08:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCEFB40648;
	Mon, 27 Jul 2026 09:08:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M5FaZTCa1i1J; Mon, 27 Jul 2026 09:08:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BA0C40631
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143298;
	bh=6QRXVcRY3qcPnQgqsYwkoo7/yMamOklAu4xsA7+XCGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Jwwvd1QZSnW69iQ9ARCMy4CTDGU9/3DWjIMbYcb0eYhE5YFjunGIM1B/RcarpIx5c
	 xZYqSekOAOfJewWCe4f8hHdj/T5TskxU/qNwDXd2HQNDAIYY6XWTa6Ok59AEGhfe4s
	 M6boOCwliREAgpe5MwgEeZXMFzxYF/NgL3BnXZn52vi2jQIiGTLiZw73ulk+k707YW
	 VIFJCXsVk+HV5gzF2jX0BuKoV8qEa6NMZj5fOfGIF64Lur99B6Diy2elouIjpHeqAq
	 XqZAm4BglInOQQqXhB3JQssg4DgPYkwVP6ifNgJSh5Kvmhct7p2TgblZZAvlypIWnG
	 49zFsvm+UX/mA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2BA0C40631;
	Mon, 27 Jul 2026 09:08:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 088F739E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:08:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E8142605EE
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:08:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id M3uqkykPHBQ7 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:08:16 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 9ABFD605E0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9ABFD605E0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ABFD605E0
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:08:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E92AB84671; Mon, 27 Jul 2026 11:08:13 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3DF482991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:08:11 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 534A041332;
 Mon, 27 Jul 2026 09:08:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86BE71F000E9;
 Mon, 27 Jul 2026 09:08:09 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 18/75] usb: dwc3: import from kernel v4.15
In-Reply-To: <20260716134305.614278-19-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-19-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:08:07 +0200
Message-ID: <87tspk4x6w.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785143290;
 bh=6QRXVcRY3qcPnQgqsYwkoo7/yMamOklAu4xsA7+XCGo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ZqgdE2el4JdsuCdBVlyyfSQY5FdmM49WcJDSzuSM/swNEkSfhW24TssJ8guApvJS3
 s132dphlRSqvLoKtzshVi07CZpPuRx2ahFJjO4SIekryDwEImNyf4JIIqHJRa8BV22
 m448IVMd7G+RHVVy7WfLtk4BsMuUO+4z0DVlt/Kd+EW+2axmhS9KJXik3ZnKwgmGtk
 /ir3C5v3hRru4Z1Mx7FC8pXnKaMYKZgFAOx2ZsTQNFxureDEkay1JSFuQQOGmPSoBB
 zNYBYRHtyv1aqCbBLJBKg1U6320nPH0uEhIdxFyTYLds5E0JtgCA2alyga3phvt41A
 j6auaUOdlKYiw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=ZqgdE2el
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZqgdE2el"; 
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
> Sync Linux kernel dwc3 changes from v4.14 to v4.15.
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
> List of commits: git log --oneline v4.14..v4.15
> Commits imported:
> ec5bb87e4e2a usb: dwc3: gadget: Fix PCM1 for ISOC EP with ep->mult less than 3
> a0d8c4cfdf31 usb: dwc3: of-simple: set dev_pm_ops
> ded600ea9fb5 usb: dwc3: of-simple: fix missing clk_disable_unprepare
> 8722e095f5a4 usb: dwc3: gadget: Wait longer for controller to end command processing
> b5ea47570b5e USB: dwc3: Remove redundant license text
> 5fd54ace4721 USB: add SPDX identifiers to all remaining files in drivers/usb/
> 644cbbc3ab4d usb: dwc3: core: Notify current USB mode to USB3 PHY as well
> 8eed00b237a2 usb: dwc3: pci: Runtime resume child device from wq
> 689bf72c6e0d usb: dwc3: Don't reinitialize core during host bus-suspend/resume
> 06c47e6286d5 usb: dwc3: of-simple: Add support to get resets for the device
> d6d9c2a3eac2 usb: dwc3: of-simple: Re-order resource handling in remove
> 86763723eee8 usb: dwc3: ep0: Clean up unused variables
> 7fdca766499b usb: dwc3: gadget: simplify __dwc3_gadget_kick_transfer() prototype
> 502a37b98a7b usb: dwc3: gadget: cache frame number in struct dwc3_ep
> 64e010802997 usb: dwc3: gadget: simplify __dwc3_gadget_ep_queue()
> ccb94ebf9e65 usb: dwc3: gadget: check for lack of TRBs a bit earlier
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

