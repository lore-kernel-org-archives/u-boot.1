Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865D5C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:13:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D306C406B0;
	Mon, 27 Jul 2026 09:13:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SiRZoI7avXWT; Mon, 27 Jul 2026 09:13:30 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6C65440563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143610;
	bh=tyZryXwgWdFRV8KTy+2RwQHvSiZ7k69WjtpnON+A+C0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZRRlrnUloZQD3MgxDMOcvXvHQAdsB/w2ukAdjWFAUuKKJ8LrN16D8iVubXRjQi1/Y
	 i663pKt+HBmdExL9+qh/dFX3gc4SGouzglfoRwJHsuYkJGPgJbcQoVRtWj3qmjU9ps
	 Dvn/SiRulj1+fH3INz2H6SOPwb5ITTAewPboKsOGkW2bomPRfyRDHsgXrZvMiAGR6R
	 TQLil8KMhocFsad1A+9qN8dj2SRggN7I2jTxku4duTx9qXs6X6pSZzL7FiTiv2iG0s
	 2Nccur8BJZ/6DXu3vrSAEL5UyfVmeAGVKEU3sojQRbcJx7FQXyI/j3nHZ/0fkxaN98
	 fuvQB4+CDey2w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6C65440563;
	Mon, 27 Jul 2026 09:13:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 882883B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7A16A400F3
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vFwI5gMVriPi for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:13:27 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 1F4F4400D8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1F4F4400D8
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1F4F4400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:13:27 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C27184671; Mon, 27 Jul 2026 11:13:25 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D04682991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:13:23 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1EA34601DE;
 Mon, 27 Jul 2026 09:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 202531F000E9;
 Mon, 27 Jul 2026 09:13:20 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 23/75] usb: dwc3: import from kernel v4.20
In-Reply-To: <20260716134305.614278-24-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-24-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:13:18 +0200
Message-ID: <87ecgo4wy9.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785143601;
 bh=tyZryXwgWdFRV8KTy+2RwQHvSiZ7k69WjtpnON+A+C0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=j6PYOM9s5T5w4Urre8Z8woW8EKojOPas/5AXJJLIGcCxvwhl2PlknWVxyLTZSNw72
 EJnBX8t41udX7Bgj4F8m6riH9IdzASj/nIhKKF1ZNBh/Gigu7jwzVKsGViVv8rHKTx
 7fjPcCp/ubyeaZtl2AELpG/rvGu/hpBcm3Z4yYBTxYcEebDqsmwmI7GxpOGfIRlD56
 aCCioqIZgYyAiJ8xF3WeE1FBibxrAksNNrDDUKhDSQTyNQEQ2sbuzoDgJLzBNkGHfK
 YcLtygn/C/yIU0A2EcAp0AwjHHWGFojVFgtGs1VfQhKyMv29cBJ8FtfZB/5kANp9Ev
 gCSGYONefHpcA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=j6PYOM9s
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="j6PYOM9s"; 
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
> Sync Linux kernel dwc3 changes from v4.19 to v4.20.
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
> List of commits: git log --oneline v4.19..v4.20
> Commits imported:
> 38317f5c0f2f Revert "usb: dwc3: gadget: skip Set/Clear Halt when invalid"
> 2fc6d4be35fb usb: dwc3: gadget: fix ISOC TRB type on unaligned transfers
> 7b412b04a0c7 usb: dwc3: Fix NULL pointer exception in dwc3_pci_remove()
> ba3a51ac32eb usb: dwc3: gadget: Properly check last unaligned/zero chain TRB
> 08fd9a82fda8 usb: dwc3: core: Clean up ULPI device
> 6af19fd10595 usb: dwc3: Fix spelling of 'optimizations'
> 87dd96111b0b usb: dwc3: gadget: Check ENBLSLPM before sending ep command
> 3def4031b3e3 usb: dwc3: add EXTCON dependency for qcom
> 4c19cc14064d usb: dwc3: exynos: Add support for Exynos5433 variant with all clocks
> 9f2168367a0a usb: dwc3: exynos: Rework clock handling and prepare for new variants
> 1e041b6f313a usb: dwc3: exynos: Remove dead code
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

