Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B9FAC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:48:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0B0316063E;
	Mon, 27 Jul 2026 08:48:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PPaVqi9u25dd; Mon, 27 Jul 2026 08:48:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8BBAD605D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142110;
	bh=ScwBWyXO51lgDI4OdiOfqduqhK/CNk9I3BmQxtWL358=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tYOCyeNMQZpWZaMevsokZbjC3FJxSC/vSyy9zbwKYupN5jLzdYWurw3/mm/1c0pLm
	 fY0+qJT2u2E6mZ0b2CqT54T2DD4I1ah9cQzhoIT4NJWkYhv44sFoP3W4H3baFsV2I3
	 4qBpD3V4q87uUI8m3XUwQvosmRYQFrlURZBxCQfEI3MuIyh41A1Xcp0tSC1i12QC/w
	 pyusLjcHeYlusQZ9mfvfRemqgJUT8UwvJ4XHf6lhC8TRnzkODlE+Mwh0vueoaukRhv
	 M/eaEPcin4tfpbcM017Url/WKPeHXC3rzq17QMfazcvMfS/zLXJVLts+QHpsEABwBa
	 zXRZNRT6NUlvQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8BBAD605D0;
	Mon, 27 Jul 2026 08:48:30 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id EE9AE45B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:48:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E065B40592
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:48:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5XALgoRraFEf for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:48:28 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org EE6FC40536
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE6FC40536
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id EE6FC40536
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:48:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3CAE846A3; Mon, 27 Jul 2026 10:48:25 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E26F82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:48:23 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D94AC40655;
 Mon, 27 Jul 2026 08:48:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188621F000E9;
 Mon, 27 Jul 2026 08:48:20 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 04/75] usb: dwc3: import from kernel v4.1
In-Reply-To: <20260716134305.614278-5-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-5-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:48:18 +0200
Message-ID: <874ihk7r8t.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142101;
 bh=ScwBWyXO51lgDI4OdiOfqduqhK/CNk9I3BmQxtWL358=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=MZar2Y6uMUhEQIoyHFuvWOWj/XdKfCWMwReddR8I7UjnjjMUljwOgA4AlHsp1XuxX
 skTyHamgMOyDkRXYuweG35181FhC0l9ZJe3FXc1I71R4MSmmr1k3/zXQZNTGTfZm6h
 dXq8WgST9p2xAh33l4cEpFhYwTI3pTl2JXbSiNzAILMKUOb9MkIxfno5hLOYI1eYFR
 aMLMrwX7uM0mAjPIZxb4IEPtCwM8nbgg6CvPNPT8A2s80dLI7McOYRxE91un810OZ6
 JdVNje77zQ7lUN9di3gT6VP5VSy3KxrBTIBgVc1wNCtaJEraS/8EZ+3rDROIZy8NZZ
 xa8Qt/D+OzxuQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=MZar2Y6u
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="MZar2Y6u"; 
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
> Sync Linux kernel dwc3 changes from v4.0 to v4.1.
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
> List of commits: git log --oneline v4.0..v4.1
> Commits imported:
> 459e210c4fd0 usb: dwc3: gadget: Fix incorrect DEPCMD and DGCMD status macros
> 228321904089 usb: dwc3: dwc3-omap: correct the register macros
> eac68e8f979b usb: dwc3: make LPM configurable in DT
> adf9c3c85615 usb: move definition of PCI_VENDOR_ID_SYNOPSYS to linux/pci_ids.h
> 8f2c9544aba6 usb: dwc3: gadget: drop unnecessary loop when cleaning up TRBs
> 3d0184d08757 usb: dwc3: omap: call of_platform_depopulate() instead
> 3da1f6ee3563 usb: dwc3: core: only reset res->start in case of error
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

