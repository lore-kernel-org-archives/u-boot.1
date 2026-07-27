Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B5B6C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id CFFC44064D;
	Mon, 27 Jul 2026 08:55:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1JinjaRZlo24; Mon, 27 Jul 2026 08:55:29 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C5012405CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142529;
	bh=5N26zqva4DDKDu6jz7NV4Bv7vSqS5ue3JuW/oBX+D8I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nq7T6th0pOBG3E9LAxRqJPgl/ILmjRIrWeqQIFXcycgpZ/hs8oKvLAV8lMn26RIil
	 tm1yytpoC18tTL3a2amEY93bIuiBCvploqkji5YaC59YT1EGsAB+jzBKsMxYwWPJ/n
	 feiwAYLiZ58fLTaXqvHL5+Z3HdT8u7vghH0U86L1hBXFR2IcjpjD5xAsTlUtzOnJwJ
	 GrPr+Pxu94mgbG7BOwQ/NgBYkOq7c+YNYMQqH7znRp6vEyqFoeTwgemExsD0gl7ky6
	 OqqWRCQYJpKmABl44Ihau4KbXTfIoRLsmgiD2iw9q00vP4s/o/0Vbwq4RBOvGQWdnf
	 njx3QCiyQk7uw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C5012405CD;
	Mon, 27 Jul 2026 08:55:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AF5BF45B
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:55:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A163D6066F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:55:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PWGdik8s1X3J for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:55:27 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 6B01E6065D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6B01E6065D
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6B01E6065D
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:55:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB04184671; Mon, 27 Jul 2026 10:55:25 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C738B82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:55:23 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AC937601DE;
 Mon, 27 Jul 2026 08:55:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F381F000E9;
 Mon, 27 Jul 2026 08:55:21 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 08/75] usb: dwc3: import from kernel v4.5
In-Reply-To: <20260716134305.614278-9-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-9-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:55:19 +0200
Message-ID: <87o6fs6cco.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142522;
 bh=5N26zqva4DDKDu6jz7NV4Bv7vSqS5ue3JuW/oBX+D8I=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=eoyuO8X0V5rtFqEVnBer0KF2YkifY70BAP0S53xf4ly0FY5Wwaii02j0jcW2sd3/h
 fRLq53Ezw7wNaTA4SpuKo16hVXv3GoGNAMUhe7lGGV/jlU78/OnCSAJ0/167HocW/q
 l8iTxr0799O4ZxXwfhYadyPeDGAq5zADaIJYqi348vNHIgtGApYObmwheabFTb4Cw5
 JGL8EBcqbR3+3i3YtgNH4AHJ1w8X7W8ivnhMOIN97x20wg9pf+OPBY1JMKC42MBQY+
 NSoSOnCBHks7HJCBQYb0mi/GAuzjgitg8EUZnF3n41ugvSviIHooXIt3Vcibg6pc5Y
 UmYYfIaGK0CRg==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=eoyuO8X0
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="eoyuO8X0"; 
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
> Sync Linux kernel dwc3 changes from v4.4 to v4.5.
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
> List of commits: git log --oneline v4.4..v4.5
> Commits imported:
> c450960187f4 usb: dwc3: Fix assignment of EP transfer resources
> 6a4290cc28be usb: dwc3: gadget: set the OTG flag in dwc3 gadget driver.
> 5072cfc40a80 usb: dwc3: of-simple: fix build warning on !PM
> d9261898a4b2 usb: dwc3: gadget: don't send extra ZLP
> 95ca961c758c usb: dwc3: gadget: pass a condition to dev_WARN_ONCE()
> 46a01427e969 usb: dwc3: trace: show request flags
> 04c03d10e507 usb: dwc3: gadget: handle request->zero
> b084662776be usb: dwc3: remove dwc3-qcom in favor of dwc3-of-simple
> 16adc674d0d6 usb: dwc3: add generic OF glue layer
> b5d335e5ea6a usb: dwc3: ep0: fix setup_packet_pending initialization
> ac7bdcc1b3ad usb: dwc3: gadget: simplify next_request() return check
> acc38c4970ca usb: dwc3: ep0: purge dev_dbg() calls
> 1407bf13e3bf usb: dwc3: core: purge dev_dbg() calls
> ec5e795cdefb usb: dwc3: gadget: purge dev_dbg() calls
> bb423984c28e usb: dwc3: gadget: simplify dwc3_gadget_ep_queue()
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

