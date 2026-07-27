Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D034C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 12:22:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B91E180DE7;
	Mon, 27 Jul 2026 12:22:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WjqYqs0X3bpV; Mon, 27 Jul 2026 12:22:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E98F880DDA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785154978;
	bh=aKukmf6EPgKP702oKU2EZBjnvRFDQEkaNTVhBC1uwe8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zMyw7pJ6ZA4waZrDs6YyfMvheCzwN82ZUBA0fNvsGyaELBL/AYzu4A4feo2Dkekm0
	 Jt/dRQKnr5rtSdemMK1JhqBPI3bKMl/9OX8KsHWX+nvqCMUpuP95KcaN1VF32M6XsI
	 9CGh1KWNxO087nevLB8aNvKaAluzeHdc2XTMDf+C8d7A/dEk4qydbFrQW7+WB7CgyY
	 f3767fCU3bEX/lXBqx2E62X3aWcOnE5YUFqqBlENSveypmevihKpctyM2oet1NTHDf
	 9aTrEFgMm7W2sSP9mfEbkNspeqcG/3BoV78goP0Jl/k6ae90YppvFNjzG9/0kAP4/c
	 1NCuknaCIvonw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id E98F880DDA;
	Mon, 27 Jul 2026 12:22:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BB02F69
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A085A80DDA
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:22:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6BLCdYYQ6S2A for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 12:22:56 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org BCA4D80B52
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BCA4D80B52
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BCA4D80B52
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 12:22:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0BEA84671; Mon, 27 Jul 2026 14:22:51 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB78282991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 14:22:49 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E563E40A59;
 Mon, 27 Jul 2026 12:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A8C1F000E9;
 Mon, 27 Jul 2026 12:22:47 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 30/75] usb: dwc3: import from kernel v5.6
In-Reply-To: <20260716134305.614278-31-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-31-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 14:22:45 +0200
Message-ID: <87tspk39m2.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785154967;
 bh=aKukmf6EPgKP702oKU2EZBjnvRFDQEkaNTVhBC1uwe8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Da6UWLRaCDthHntunRD4UR0rfIYBNp+/otXuS2OBvsVDGyK2VEYvhpYu2z0D48JxN
 1/UrmT5Co6DY4cqu0nwcf2AA+58ty4ILi/H5Lc+kJrQNFonmpMQStDpb05R+6eK0gj
 66KcXV6I9nHkzcLDuA/MwScix5wMjlHpEZUVJSjnsB0YDKRzE9fqOs7/FF9ERgxVTI
 VqmOTEc+JrW0mkqRgp2m6jbyZz7TdvefK57bt/JqZDCa1y6v6CIe/j1qDZZxIQQ9wQ
 vF0bH9JaFd4psl/LbULwzdS9tEpAc2Z+YkiuBRAuYyLl1R/Wz/rvsrNQleBFScsd0x
 AAQrMY5zsFhqQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Da6UWLRa
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Da6UWLRa"; 
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
> Sync Linux kernel dwc3 changes from v5.5 to v5.6.
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
> List of commits: git log --oneline v5.5..v5.6
> Commits imported:
> dad2aff3e827 usb: dwc3: gadget: Update chain bit correctly when using sg list
> 42cd5ffe46c1 usb: dwc3: debug: fix string position formatting mixup with ret and len
> 5ee858975b13 usb: dwc3: gadget: Check for IOC/LST bit in TRB->ctrl fields
> f5ae88690955 usb: dwc3: pci: add ID for the Intel Comet Lake -V variant
> cf2f8b63f7f1 usb: dwc3: gadget: Remove END_TRANSFER delay
> da10bcdd6f70 usb: dwc3: gadget: Delay starting transfer
> c58d8bfc77a2 usb: dwc3: gadget: Check END_TRANSFER completion
> 09ed259fac62 usb: dwc3: turn off VBUS when leaving host mode
> 2e708fa3b898 usb: dwc3: gadget: Clear DCTL.ULSTCHNGREQ before set
> 1b6009ea88ec usb: dwc3: gadget: Set link state to RX_Detect on disconnect
> 5b738211fb59 usb: dwc3: gadget: Don't send unintended link state change
> dea7b202bd9c usb: exynos: Rename Samsung and Exynos to lowercase
> 5eb5afb07853 usb: dwc3: use proper initializers for property entries
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

