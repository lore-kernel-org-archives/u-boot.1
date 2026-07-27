Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1DEC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:56:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F44980CA3;
	Mon, 27 Jul 2026 08:56:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xcox1qGwWLxg; Mon, 27 Jul 2026 08:56:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 03EB880BF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142578;
	bh=mbMqdLZq7vNwpBYHnvRuubrTEeoJR8CaQ55cDUWkvCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CTs9iF0DiyMU4xMcCgHPeAvYqgUmNiTB7ytuo6DLI2G1h2Xk9ntSKna8ECiR4vs20
	 GYNMhEipXjh1Rh7qrGr9uPu3n9BUD8J23fVfHpZTqd6MtxhW6sEV9em23n+MV6pFmX
	 cnkU9ubR7k57ADexPxqJ6BUEUHpt8ooyAnkSFWsRb7PFcmgY3CsP8WLUVIA8v50VRV
	 9OzKYh7xrJ+OWBPDW2vyYiAG7FyeWkH4BROeMm6I6CONNm81ceqPhAzRKk9rBEd98h
	 uieSxjLjLPwSbgUWH4NeJ7VdPcNgkiS5VdmdLUuZ4nDoPZkn8JUzpiFtvoYWIFZXvA
	 AcByVTaIiKorA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 03EB880BF0;
	Mon, 27 Jul 2026 08:56:18 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DFF83490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D158D400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMgV0hgl0ysu for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:56:16 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 940194005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 940194005F
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 940194005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:56:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C3E984671; Mon, 27 Jul 2026 10:56:14 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01B2582991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:56:11 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7245F40291;
 Mon, 27 Jul 2026 08:56:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF49E1F000E9;
 Mon, 27 Jul 2026 08:56:09 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 09/75] usb: dwc3: import from kernel v4.6
In-Reply-To: <20260716134305.614278-10-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-10-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:56:07 +0200
Message-ID: <87ldaw6cbc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142570;
 bh=mbMqdLZq7vNwpBYHnvRuubrTEeoJR8CaQ55cDUWkvCs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=UaLRj+06WQanGRx5qJiLgDxhTs0BixEyQ7ztd7wLF/7bgSApdiPxRnwOmYblyAnXQ
 rMZR8kGh0OVziQP+KxoH+pu+m+k/E940Dmz8BGMX++jivcxvNl6cG9/1OPpDSYH4uo
 QHKvafQYXkWJxK6nut9S4kUHy9er7HNi9nDKRFoFicoiVl8MQO4lXwkQYXSQ2Dm5fw
 sn2bBvdWvWKTBwwBCbFImEHPWnHbp3vQrMrtk/7dHeS5aiTnPdMv8ZdIhkqO2JjNs+
 KfCzoJOEXEK0wuOErk0IWWXIMo51UyFUz5sIa3VfLNcY6LJgnAOfylnGxBiehx9KqW
 vBf9Wcuewwkng==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=UaLRj+06
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="UaLRj+06"; 
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
> Sync Linux kernel dwc3 changes from v4.5 to v4.6.
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
> List of commits: git log --oneline v4.5..v4.6
> Commits imported:
> 9772b47a4c29 usb: dwc3: gadget: Fix suspend/resume during device mode
> e6bdf8195b4a usb: dwc3: fix memory leak of dwc->regset
> 5c4ad318de3b usb: dwc3: core: fix PHY handling during suspend
> 45d49cb706e5 usb: dwc3: omap: fix up error path on probe()
> adf9a3ab90eb usb: dwc3: keystone: drop dma_mask configuration
> 1ffb4d5cc78a usb: dwc3: pci: add ID for one more Intel Broxton platform
> e901aa159dac usb: dwc3: gadget: fix endpoint renaming
> ad14d4e0308a usb: dwc3: gadget: release spin lock during gadget resume
> f59dcab17629 usb: dwc3: core: improve reset sequence
> 77966eb85e6d usb: dwc3: Validate the maximum_speed parameter
> 7580862b3e80 usb: dwc3: Enable SuperSpeedPlus
> 2c7f1bd9127a usb: dwc3: Update maximum_speed for SuperSpeedPlus
> ee5cd41c9117 usb: dwc3: Update speed checks for SuperSpeedPlus
> 1f38f88a24c8 usb: dwc3: Update register fields for SuperSpeedPlus
> c4137a9c841e usb: dwc3: DWC_usb31 controller check
> 3d755dcc20dd usb: dwc3: Remove impossible check for of_clk_get_parent_count() < 0
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

