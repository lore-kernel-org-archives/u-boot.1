Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58094C54FCD
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:32:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F17940B62;
	Wed, 29 Jul 2026 09:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eSs-nY-v3nHn; Wed, 29 Jul 2026 09:32:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 880AF40B41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785317554;
	bh=x2gRB4cEAS3PQdGFBSGz9jlHCcYJgTS9js1zw6wXewk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cTFJlK2h1w6XyIE1/0ireI6k+zBg4E+/naMTSG7croFZDhQw7hiL5Di2ISmFRyfCo
	 H/0VitLMH6B9azIQQbIGCW/mxXzZT8QmewBOtLzF2OSpkPInfmoOkOCQkzAsA4zijf
	 ffaUEJK/wVRubqRSrXCG/svh2AWn6YY19+XIB84DiDOHBTyZKPFkFMO86mMROzQj8K
	 NiLSq30ktfaCqTwP31rJY6Dp9DbXu5kgLzAhEM/tXasTyJV7e9peepHt4Z2bJwGNOH
	 I0c/ifLe9qObIdAxnOUo8dg1ljy9fFVDESGxMwMvvXxScLXd5B7zaGeyaei9urrzED
	 SV1hCLGWIgagw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 880AF40B41;
	Wed, 29 Jul 2026 09:32:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8618245B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:32:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C5E360AE7
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:32:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R5t4njgOBHmN for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:32:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org F280E60AD1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F280E60AD1
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id F280E60AD1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:32:31 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 701E98494B; Wed, 29 Jul 2026 11:32:30 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 597638404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:32:28 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3A7A43213;
 Wed, 29 Jul 2026 09:32:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12AB71F000E9;
 Wed, 29 Jul 2026 09:32:25 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 60/75] usb: dwc3: import from kernel v6.16
In-Reply-To: <20260716134305.614278-61-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-61-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:32:24 +0200
Message-ID: <871pcmywd3.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785317546;
 bh=x2gRB4cEAS3PQdGFBSGz9jlHCcYJgTS9js1zw6wXewk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=W/T9gqDZOFN4ZJ/2OeJvqq8VokVXqybBL6x/RSfTYpXmKHkmCWnhejW7Z9uqVHzAr
 EX/5BTHyUarvqkYJZHqJatpyF6uoiUHviB/OyhhzZLMNloONFEcrZcitmz3eiBkMFy
 sEf8E4+pA5ip8kRbOXiHQLDSDMgC4yzsF5eP+fsZnZyPgJWO4JsE4rAfrT5R7PneWF
 OyjXtnpyosEBjhx+fRIdfspU/7jf3/YZb2bzahfbLZX9ekNbZJPDrLCEWn38TZp6Sv
 yUa8nn4FeOuxMxoGGZ46xab5QhTpbX0YglZSX06yvWkJUM+JJ2dbqvCAu9Xklq7zau
 u636fwDY3iLKw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=W/T9gqDZ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="W/T9gqDZ"; 
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
> Sync Linux kernel dwc3 changes from v6.15 to v6.16.
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
> List of commits: git log --oneline v6.15..v6.16
> Commits imported:
> ef8abc0ba49c usb: dwc3: qcom: Don't leave BCR asserted
> 80e083943775 usb: dwc3: gadget: Fix TRB reclaim logic for short transfers and ZLPs
> 630a1dec3b0e usb: dwc3: Abort suspend on soft disconnect failure
> 657bfcbbfa38 usb: dwc3-exynos: add support for ExynosAutov920
> e33ebb133a24 usb: dwc3: qcom: Use bulk clock API and devres
> 4c0fca65d105 usb: dwc3: qcom: Fix error handling in probe
> 45ebb7baf235 usb: dwc3: qcom: use modern PM macros
> 1881a32fe14d usb: dwc3: qcom: Transition to flattened model
> 2dc9f137e194 usb: dwc3: qcom: Don't rely on drvdata during probe
> 170940f7e685 usb: dwc3: core: Don't touch resets and clocks
> 613a2e655d4d usb: dwc3: core: Expose core driver as library
> b958b03c82d2 usb: dwc3: qcom: Snapshot driver for backwards compatibilty
> 00b157f8f64b usb: dwc3: exynos: add support for Exynos2200 variant
> 850e634006f4 usb: dwc3: core: Avoid redundant system suspend/resume callbacks
> 8da7644493b4 usb: dwc3: Specify maximum number of XHCI interrupters

Some commits listed here are not imported. For example: qcom, exynos.
Please drop them from the changelog.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

