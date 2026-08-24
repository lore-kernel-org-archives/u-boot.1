Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAAB5C5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 08:58:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F37986074E;
	Mon, 24 Aug 2026 08:57:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qt-nHaR7Ho86; Mon, 24 Aug 2026 08:57:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787561877;
	bh=QL62QwnmsenEYUjjBss9WwP0BTRctS3vrRid3C/VxkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1EMLgVQWbOgIOoexRdvOmpu3MNL6a8+adMKzHBU3ChltBBHolFdU8mOqpE04BCO4g
	 wAswdyRsi9apPoU7DZdXalN9Pf+wjictX/o5p6GPCyJzPonXwUho3Ta68y3zLhR18K
	 IMq1JocEv5D5BrGRdbC04RHOTPat40zUFPpfWq7ojdXkP4Wb7CcKwfxxVQg8qz9dXc
	 snAtJ/cR8VSHKAH8O/8gYWxR14BHWyVcOd8mIZUVpAb5hL9A4CodPU3bhhbxZzZlDL
	 XkKNDr++1OeTNLu2y5SPFNF+K776G6cvLC6hA7HeyftiF/+NWOjW5rBwyc4W8+xeEZ
	 Y7iD1xE1Q9uEA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id BD8DD6060A;
	Mon, 24 Aug 2026 08:57:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 200063AD
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:57:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 11CEF80E01
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:57:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHJlMMVgCJDD for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 08:57:56 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=XYzGvSab
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 00ED380AA2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 08:57:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 781D1404A7;
 Mon, 24 Aug 2026 08:57:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8DF1F000E9;
 Mon, 24 Aug 2026 08:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787561875;
 bh=QL62QwnmsenEYUjjBss9WwP0BTRctS3vrRid3C/VxkA=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=XYzGvSabMf7n43YD8+NaXAOGYLUQbuUFKX9btOxW1rOCSunC7DQlcDrGMAC5Hj6q+
 DTXKAKdfh0I9LRPIZTX77Mv4W0mshbJp19PuNoFx/k1cz1AFI4R9gybU5bgMXrsOtF
 rbz/6scP8LPFTaYv0zsdcTrWE21sSTDCKaiBCTDr3zwVVCzGceJcXlEVtVik/Gjpjx
 +RRgaA8OTnIgipQ5wxbawIf/13/uwlPogvGkeWE8MwrwAfWU3j8IoHm3dXnNpTF07G
 U9lc29GJoUygVx43n2V6ZVLVUGyDPx3dK9ts7DdWD+rwh1qtOCBSd+Pvs0QABT2N/m
 ziNiQb4MJAefg==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, michal.simek@amd.com,
 alchark@flipper.net, jerome.forissier@arm.com, Jens Wiklander
 <jens.wiklander@linaro.org>, Simon Glass <sjg@chromium.org>, Anders Roxell
 <anders.roxell@linaro.org>, Marek Vasut <marek.vasut+usb@mailbox.org>,
 Lukasz Majewski <lukma@denx.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 27/87] usb: dwc3: import from kernel v5.2
In-Reply-To: <20260821084829.2070426-28-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-28-anders.roxell@linaro.org>
Date: Mon, 24 Aug 2026 10:57:52 +0200
Message-ID: <87ecfnopyn.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Anders,

Thank you for the patch.

On Fri, Aug 21, 2026 at 10:47, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v5.1 to v5.2.
>
> The following files are preserved across the import:
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
> List of commits: git log --oneline v5.1..v5.2
> Commits imported:
> 2e487d280525 usb: dwc3: Rename DWC3_DCTL_LPM_ERRATA
> 8d791929b2fb usb: dwc3: Fix default lpm_nyet_threshold value
> dd24f9b604d3 usb: dwc3: debug: Print GET_STATUS(device) tracepoint
> b873e2d0ea1e usb: dwc3: Do core validation early on probe
> c729969b2b69 usb: dwc3: gadget: Set lpm_capable
> 41a91c606e7d usb: dwc3: move synchronize_irq() out of the spinlock protected block
> 75ecb9dd56a7 usb: dwc3: Free resource immediately after use
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

