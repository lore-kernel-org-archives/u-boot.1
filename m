Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57934C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:29:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9003080EEE;
	Tue, 28 Jul 2026 09:29:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fXtntTJUpHTs; Tue, 28 Jul 2026 09:29:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AD87F80E90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785230962;
	bh=926kJEwStkQ8La2uJMJYzZffYJdO54EeYZixoc5qdbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X8DTX+cRw5jB8d1TG7KjTCnUknzE3XBxnccjYBJc28k6gZxXHyFIJmc3Or9tom+su
	 KKfW8ZEdQcg2gXU1GQccJE2KSx1z/bVu6eH1FsitVtmPn6FWKZ8UyC/bzQ8kwF4nTH
	 fBkVDYCnDavQiJ3XWWD9+YACw9QgtVKnOVUcNlc3znflEzkYfp01Gb5MIRroQVWAOR
	 6S4S15sOPQdpi5Jl8NQpOdbqvpdZjAaE43uteFmMnTz35Hkt3OO7BG8ZSF2RiPjnWz
	 rccRaCIw56U94+kiO4uSyYLjuebALp3FQKFeo4RHT74z+N/PhsRgkHHAhK/e9vRVAn
	 iDHS6HAQWzI2Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD87F80E90;
	Tue, 28 Jul 2026 09:29:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2219E2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:29:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 090DA40889
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:29:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id whCNXy_kYH9Q for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:29:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org A0D58405FA
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A0D58405FA
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A0D58405FA
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:29:19 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003E3848BA; Tue, 28 Jul 2026 11:29:17 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF63B82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:29:15 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7420641FF1;
 Tue, 28 Jul 2026 09:29:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B7F1F000E9;
 Tue, 28 Jul 2026 09:29:13 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 39/75] usb: dwc3: import from kernel v5.15
In-Reply-To: <20260716134305.614278-40-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-40-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:29:11 +0200
Message-ID: <87v79z1mzc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785230954;
 bh=926kJEwStkQ8La2uJMJYzZffYJdO54EeYZixoc5qdbs=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=JufxogpnRYOJ14naK8skWwkA/EHgDBannEMITjt4PLw3U7MQ7UhoFgZL+gBY0OS6u
 74+p+CdlU37C4y4bF2FF9OGcn0VxAABp7EsmmIIbqXTJE3AJvlHf9soCNCOOFOqzBq
 3F5PJY2FykTNQAZju1QdXhZLi+lBP1hMwFELqs6iaaKyfJiy7xFjtM2S+Cu7Wndket
 EaO3wPXLmCtl47f/ejQ0B4WnJpEgn/D3FWgP+U0xlKph1/+7kmn+rQmjgC+2ZbPT6v
 FqQR4YrVXdXAr4nK1VUwxQp2GWxlG+mvfVLGGTKzY3TKTXMNl6sI5FuRy95EMVO38n
 6saSCIgNMFfwA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Jufxogpn
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jufxogpn"; 
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

On Thu, Jul 16, 2026 at 15:42, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v5.14 to v5.15.
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
> List of commits: git log --oneline v5.14..v5.15
> Commits imported:
> 268bbde716e3 usb: dwc3: gadget: Revert "set gadgets parent to the right controller"
> 8cfac9a6744f usb: dwc3: core: balance phy init and exit
> 1abade64563e usb: dwc3: pci: add support for AMD's newer generation platform.
> 6a48d0ae01a6 usb: dwc3: imx8mp: request irq after initializing dwc3
> 843714bb37d9 usb: dwc3: Decouple USB 2.0 L1 & L2 events
> 175006956740 usb: dwc3: qcom: add IRQ check
> baa2986bda3f usb: dwc3: meson-g12a: add IRQ check
> 0132bf6f3958 drivers: usb: dwc3-qcom: Add sdm660 compatible
> c6e23b89a95d usb: dwc3: gadget: set gadgets parent to the right controller
> 26f94fe8e739 usb: dwc3: drd: use helper to get role-switch-default-mode
> 8e6cb5d27e82 usb: dwc3: dwc3-qcom: Fix typo in the dwc3 vbus override API
> cefdd52fa045 usb: dwc3: dwc3-qcom: Enable tx-fifo-resize property by default
> 9f607a309fbe usb: dwc3: Resize TX FIFOs to meet EP bursting requirements

Drop pci, imx8mp, qcom and drd commits from the changelog since they are
not applied (because we skipped these files)

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
