Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0CA8C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:22:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3F787606C7;
	Mon, 27 Jul 2026 09:22:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3i8HcNIi4VTb; Mon, 27 Jul 2026 09:22:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2CFD560675
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785144146;
	bh=qFsZohbsiuTKP80gosbRk7d2kIlw8kl40ow8dDZLR2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mswOjTgXqrwuoMRR3VN8auWvk3KzD2p3KXJviBxpc/BMRi8+Iz+CB8tXW4FeOrIZl
	 IhBo0M0NZ/N5nvNP/SmTuyBznxovuykiPtTTEbDuGj3BKv5uz/wdrYerOWnWdqqAgt
	 np7OKPKpbcu3iAFSp6qstB2U3wIwG1VbAA0y8nEEPaNamN/pEtyU0ecqKEFnK5dRJG
	 Qv/5kXUuErHzrHXTV3FQxpcgRfJx28U0xe1bzyJhuz5uSaVOEzR2i7ok8HV1OuSja3
	 VUddXJt8p8ghWe23PgvpAqsYBfP2hQ+B+mgIIZKPacq/5ayrCAKOmQEQxeRVGYwPKf
	 /DMlhZLiUheuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2CFD560675;
	Mon, 27 Jul 2026 09:22:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 54BAE42A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:22:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5273F405BB
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:22:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4-GrqWN0emDt for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:22:24 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 17C56405A4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 17C56405A4
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 17C56405A4
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:22:23 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E35E84671; Mon, 27 Jul 2026 11:22:22 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E8AF82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:22:20 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBB994387F;
 Mon, 27 Jul 2026 09:22:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2541E1F000E9;
 Mon, 27 Jul 2026 09:22:17 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 27/75] usb: dwc3: import from kernel v5.3
In-Reply-To: <20260716134305.614278-28-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-28-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:22:16 +0200
Message-ID: <8733x44wjb.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785144138;
 bh=qFsZohbsiuTKP80gosbRk7d2kIlw8kl40ow8dDZLR2M=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=VHmZZnQ1M/JRl4dBf/fEi8R33BTHbT6p6nm3LrDH9bYFFWryN6yhvZ8xdPFPZ5kKU
 T+X063pgVkARsy2fCYKG0COD7Vtqp9WcZX+PCO2RRov342eR/tmlUlvEXNQrJB1wN4
 ElqVhraxGX00pZykxEbbi0Wmabwzu3CHIXMMTR+mYGYCyKNiond1BMPR0JvbvFtnav
 AdT+XBUUGzVdOgdT2Xj4zNUoV/YmFu66yX7YYgxiuRLlICk1axPVT/6f/kWx5Mzhx2
 2a8cM3/W+jTAbHrehXfJObB8vSqThd9F+8gY768/o34A6SK3EYutYsob6+w2L1H8W0
 z6rl5TVtJswoQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=VHmZZnQ1
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="VHmZZnQ1"; 
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
> Sync Linux kernel dwc3 changes from v5.2 to v5.3.
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
> List of commits: git log --oneline v5.2..v5.3
> Commits imported:
> 332694f8a4f7 Revert "usb:gadget Separated decoding functions from dwc3 driver."
> 3db1b636c07e usb:gadget Separated decoding functions from dwc3 driver.
> b3649dee5fbb usb: dwc3: pci: add support for TigerLake Devices
> aa23ce847dda usb: dwc3: remove unused @lock member of dwc3_ep struct
> dbb0569de852 usb: dwc3: pci: Add Support for Intel Elkhart Lake Devices
> 729dcffd1ed3 usb: dwc3: gadget: Add support for disabling U1 and U2 entries
> 4d20a6107050 usb: dwc3: qcom: Use of_clk_get_parent_count()
> dc1b5d9aed17 usb: dwc3: Fix core validation in probe, move after clocks are enabled
> 7f5d6a469617 usb: dwc3: qcom: Improve error handling
> a6e456209d08 usb: dwc3: qcom: Start USB in 'host mode' on the SDM845
> 2bc02355f8ba usb: dwc3: qcom: Add support for booting with ACPI
> f90db10779ad usb: dwc3: meson-g12a: Add support for IRQ based OTG switching
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

