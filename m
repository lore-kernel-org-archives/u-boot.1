Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91E8C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:26:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62F5580D7F;
	Mon, 27 Jul 2026 09:26:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JszdaDWvWgu; Mon, 27 Jul 2026 09:26:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 07F0980C76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785144395;
	bh=tc9dfWSBqKdH2IF/zorIRhf4JTUnec4Q7io+kQR/or4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VLJonZA5SihGv0KqXgYIhURkLQXhtIMYOWNwuFk0Xqq+KdTXVApKZXoYrk7CBOSOW
	 xn5q5wNl+VAvQrFHZHftOso17L/ZSTmiMofN8pvAYTdfMe4IcHUjXe+Pq1hurmVzMr
	 u1N7igLTonamYI8Fu3cyQOjgtx9QKIgcMHzPX1O6eTaCHvvXUao4OO4/COnAsgROR/
	 WnizYxa6adUqokdrgh+HcAReD/mtvIsDVg13VRX7nhIALvjrs0TeInUexdmKCve3BO
	 pkNnlCf+Dthm4Pf6rOLa6MSf6zYaxuObvoeuOGGf5EhZO3WVPKjVtHNrvhFxnOH1o3
	 bsKRc4LaLA8LQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 07F0980C76;
	Mon, 27 Jul 2026 09:26:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id B908E26C
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9FC674051D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:26:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eNc7PhcYlHu3 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:26:32 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 719B940503
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 719B940503
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 719B940503
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:26:32 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB11F84671; Mon, 27 Jul 2026 11:26:30 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B37DD82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:26:28 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3B8E343B87;
 Mon, 27 Jul 2026 09:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702521F000E9;
 Mon, 27 Jul 2026 09:26:26 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 29/75] usb: dwc3: import from kernel v5.5
In-Reply-To: <20260716134305.614278-30-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-30-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:26:23 +0200
Message-ID: <87wlug3hs0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785144387;
 bh=tc9dfWSBqKdH2IF/zorIRhf4JTUnec4Q7io+kQR/or4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=BgU5w2MlpIRJ55zyaWtBQKc0WWJAPZxt5GdUqG+WnI8EcSCHWnERBljNTsb5ncLlj
 rHNu6wbG1+W8E485QEAypkCAltVUyGJapYRnVTRsuHcaZjQcLQT+C/WVTcfK2g0M50
 mKOScIYu69NrZwUu2zAW5c8/cyiv+3Y63cwpnT6lHHT/FTA2s+MksqVdzYT9LQhEir
 1lKJLxWnqfgEuuaQVWkGv7HDoJDz6ddhUpLI6jPOiiLtr7997oogg2CRyC5XGIada/
 dptOf024kH4xXnWEibkKJ7GD3yDyG00RHwq1aEGFJnJJQznFjZp4YK3stVwmz5+uVZ
 oTOsLaA3kZQzQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=BgU5w2Ml
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="BgU5w2Ml"; 
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
> Sync Linux kernel dwc3 changes from v5.4 to v5.5.
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
> List of commits: git log --oneline v5.4..v5.5
> Commits imported:
> ea0d762775e2 usb: dwc3: gadget: Fix request complete check
> 3c3caae4cd6e usb: dwc3: pci: add ID for the Intel Comet Lake -H variant
> 2d7b78f59e02 usb: dwc3: ep0: Clear started flag on completion
> d3abda5a98a1 usb: dwc3: gadget: Clear started flag for non-IOC
> 8c7d4b7b3d43 usb: dwc3: gadget: Fix logical condition
> c3afa2224345 usb: dwc3: Fix Kconfig indentation
> dcf5a2c390a3 usb: dwc3: create debugfs directory under usb root
> 726b4fba94be usb: dwc3: of-simple: add a shutdown
> 038761ce68c2 usb: dwc3: debug: Remove newline printout
> 9ba3aca8fe82 usb: dwc3: Disable phy suspend after power-on reset

> c2c1c66b5d43 usb: Fix Kconfig indentation

We don't touch the Kconfig (as mentioned in the commit message).
Therefore we should drop this commit from the list of imported commits.

Also, I've file-compared with the mentioned Linux kernel release, and
that part looks good to me.

After removing the "c2c1c66b5d43 usb: Fix Kconfig indentation" line,
please add:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
