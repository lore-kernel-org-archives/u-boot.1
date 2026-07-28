Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272B7C53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 09:19:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D17BB81331;
	Tue, 28 Jul 2026 09:19:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPJHGBLOy68T; Tue, 28 Jul 2026 09:19:16 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EF05481328
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785230356;
	bh=+AjMxRyk+N2tU3n2eZrqja+bD26hgZZOMr8wvdtisd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uCAW73OcIDBE/HsDhjnq97huq3mDrn1qJALH24IF/KwjpM85Eqc+w4KwfOQtQRCrE
	 l18fH8EobsnewYWeKmakomy1pXwnduxiS/55LXTcIi1urzzuYIKDKjJ5Kvcq/zON8s
	 UlbHnhLXzWRd2XrpofzpUak1THu56zMBgguXWOQgVB7cg8+TsXmcoL/6GXCjWv7CWK
	 EUQqpM8AM60B+L9K23rwiTlmVViqpHlLZqqZNTfyAx4ukbpKNNURWCmukoN6n8I33h
	 /sVrxjcx7o5V8OZQ58M787ROpP4SdeYr9jY9Z/NSM9MA76HsHHCY63POYRci2xttaw
	 g5jy3f3wRLZ6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF05481328;
	Tue, 28 Jul 2026 09:19:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 724B42E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:19:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 645C140278
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:19:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cWBxoDyiNiao for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 09:19:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 51F89400D3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 51F89400D3
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 51F89400D3
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 09:19:13 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF41C82991; Tue, 28 Jul 2026 11:19:11 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A490682991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 11:19:09 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 459AE441FD;
 Tue, 28 Jul 2026 09:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E2341F00A3A;
 Tue, 28 Jul 2026 09:19:07 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 35/75] usb: dwc3: import from kernel v5.11
In-Reply-To: <20260716134305.614278-36-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-36-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 11:19:05 +0200
Message-ID: <877bmf320m.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785230348;
 bh=+AjMxRyk+N2tU3n2eZrqja+bD26hgZZOMr8wvdtisd0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=oPN5XmyuulyDeU1UkVJs16Mpa9g9Zck768LWFA/s5Xeulmd92Ai+OAtnLNRAnM+Zz
 EPbTWKSgurMGE/eHX81RvJdMgUCRWyY+Jp+L9a9NheOqgv9Zia+CtVYTPRTA9P6hyB
 3V7oUDZME74thWx3bVhBmY12qZDQIB6jKLshlhXd1CrSHEOqACA3053lzFt0iKdQ+n
 rJkl9v3duNpuI0yaytl7Mxx0L6lYD+TFiD81wJXEgfiZvcab3e6ESo5XUPB48D8COH
 xEEp23YoHvWOU2+nJOxmOCeMBpCWVvBTwlpyAiml46u/R3BkWwLWQjdOk876O5fDNz
 DqeptpbtxZRrQ==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=oPN5Xmyu
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="oPN5Xmyu"; 
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
> Sync Linux kernel dwc3 changes from v5.10 to v5.11.
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
> List of commits: git log --oneline v5.10..v5.11
> Commits imported:
> 0e5a3c8284a3 usb: dwc3: fix clock issue during resume in OTG mode
> a5c7682aaaa1 usb: dwc3: gadget: Clear wait flag on dequeue
> a1383b3537a7 usb: dwc3: gadget: Restart DWC3 gadget when enabling pullup
> e5f4ca3fce90 usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression
> fca3f1381057 usb: dwc3: ulpi: Replace CPU-based busyloop with Protocol-based one
> ce722da66d3e usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion

ulpi.c is part of the unused files, so we should drop these 3 commits
from the changelog.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

> a5ada3dfe6a2 usb: dwc3: meson-g12a: disable clk on error handling path in probe
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
