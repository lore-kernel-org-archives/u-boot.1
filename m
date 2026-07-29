Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD895C54FCD
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:20:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5372860AE4;
	Wed, 29 Jul 2026 09:20:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P0CHhQdqYQM1; Wed, 29 Jul 2026 09:20:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CDE1E60AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785316799;
	bh=ZQDEDY1+/6sXClTZLP3kFU+HFsctE/unj/gDPEqjPAo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EOyqH83PzG/MLJ3eY12+fDQZNpuxyUU3QW5UuvPCcClnOCiIG5CW9KxX5fWb7Msl+
	 ICBDtDi9M5HFi2pcGpAWq9yAYSvv4L4p242iZAvo0Q/EldzRy0t1kGGtyZDHjOHjL/
	 g8+mr6w2huodRyvmFRLR77fmxnU+MD/trQ6NJ5ZhsuKOSzJmC4L3QTTdVgUhoN2MjV
	 ruxOMFhi2P7fh8d9FSh7mZw5ePvTm9XabsDP1wWME0Qx5vtS8fElLzaW+iFPWE/2Dc
	 x1A5ymqydkqWKBJqPeoh5dYqcruyhdGCVmVP8CJan1m4UFh4kIQPdbhrdUbw8m1OKW
	 zUTPyIwiDjDBA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDE1E60AD1;
	Wed, 29 Jul 2026 09:19:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 5AF4545B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4CE52401A3
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:19:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wPeBl2k_zJg8 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:19:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 38B254009C
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 38B254009C
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 38B254009C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:19:57 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0D8C8494B; Wed, 29 Jul 2026 11:19:55 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A039F8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:19:52 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3C33B60A5E;
 Wed, 29 Jul 2026 09:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4D81F000E9;
 Wed, 29 Jul 2026 09:19:50 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH v5 50/75] usb: dwc3: import from kernel v6.6
In-Reply-To: <20260716134305.614278-51-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-51-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:19:47 +0200
Message-ID: <87tspiywy4.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785316790;
 bh=ZQDEDY1+/6sXClTZLP3kFU+HFsctE/unj/gDPEqjPAo=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=lIrsgn9LNsH8V+vd2YuecZZtk41U8jbJfGUFV+jnN2Mg1l4Qt///eFE8m+GZavflo
 AtX/JDK5jF4Mlu5RxAfYLSxmWcjoxkpPs2qvC2i4rmPusL9wwLlH+GfLe48gIjz1kT
 NV6iLnV92TMu0c1no43514SypUCYF1d6ZR4xFrf7ZJMEqNRKonlv0u9g9CCxogcGw4
 qHA4p7XuyN9sXagfc2fa3Rjv95dv/4mJzPI5P+nbVje1nUaLUp1/14tRrM/RE9t2Tl
 jJsC06NxB3u7mSSwbGKsjCdc8BO4pYVrgn2aPyYEsVQ5z4XDRbXISSwQmwKuN6hgE2
 cnX6pNlY7DBCw==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=lIrsgn9L
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="lIrsgn9L"; 
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
> Sync Linux kernel dwc3 changes from v6.5 to v6.6.
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
> List of commits: git log --oneline v6.5..v6.6
> Commits imported:
> 8bea147dfdf8 usb: dwc3: Soft reset phy on probe for host
> 592d7a4663d2 usb: dwc3: exynos: Add support for Exynos850 variant
> 8d1de0ebce71 usb: dwc3: remove unnecessary platform_set_drvdata()
> 1fa206bb764f usb: dwc3: meson-g12a: do post init to fix broken usb after resumption
> fb57f829beef usb: dwc3: dwc3-octeon: Verify clock divider
> d9216d3ef538 usb: dwc3: dwc3-octeon: Add SPDX header and copyright
> 540264746d83 usb: dwc3: dwc3-octeon: Dump control register on clock init failure
> dc0092ce24dc usb: dwc3: dwc3-octeon: Move node parsing into driver probe
> c61101631cdc usb: dwc3: dwc3-octeon: Avoid half-initialized controller state
> 23f87bcac649 usb: dwc3: dwc3-octeon: Pass dwc3_octeon to setup functions
> 417840663ab8 usb: dwc3: dwc3-octeon: Use _ULL bitfields defines
> 976f82e8aa3c usb: dwc3: dwc3-octeon: Convert to glue driver
> 3609699c32aa usb: dwc3-am62: Rename private data
> 484468fb0f7d usb: Explicitly include correct DT includes

Please drop the commits that were not imported from the changelog (for
example exynos, octeon)

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

