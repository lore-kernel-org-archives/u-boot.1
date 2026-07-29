Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DF9AC53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 865E460AF9;
	Wed, 29 Jul 2026 09:29:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GP96Kw2UYr9q; Wed, 29 Jul 2026 09:29:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9DAD460AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785317348;
	bh=ELH0riq4j1rMY3liZnN55+zZ4erWuAIx2hjl4O0ArKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pVHbxPBrxFPo2j2nOHZVjo+cU5RlobtyC86VnBA7m0bmenqi68hENmj8qygAZGrbx
	 hMDn3A3vU5I0k0M8ZmUxNX3rBzIirkKrFC67EbJB6JQKsQr56C4/ASxOywSOSZvYc6
	 zc8dzIViBgpVkxUqXmPzjMhvjClg86vID4G5I4EAot7scqO9zi5jv/bXg3pvcKes2U
	 DdSOfjRlI5RUu6XC3N8a4VYQUG1EjMzApM2wgeJ9dIPvcIXG8+OHHVzVLAsTmsGE3v
	 EtPPYymLggtzF/L0nhZaYWZLeDSk65KMt0JbcgJ3sTs8AAt8+ZoYcoCkQvLFBQ4yYb
	 7CoUPHGTmc4pg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9DAD460AD1;
	Wed, 29 Jul 2026 09:29:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B4C4045B
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B68040B33
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:29:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XWRPuYYW_wd9 for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:29:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3AE2140913
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3AE2140913
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3AE2140913
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:29:06 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 961D58494B; Wed, 29 Jul 2026 11:29:04 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45FF8404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:29:01 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97A8260A5E;
 Wed, 29 Jul 2026 09:29:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 911BB1F000E9;
 Wed, 29 Jul 2026 09:28:59 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 57/75] usb: dwc3: import from kernel v6.13
In-Reply-To: <20260716134305.614278-58-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-58-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:28:57 +0200
Message-ID: <87a4raywiu.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785317340;
 bh=ELH0riq4j1rMY3liZnN55+zZ4erWuAIx2hjl4O0ArKE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=LrIGwHASL6hFupIF0ASq5melZUKvj1oBBdzx6CObP1I0XkLF4PMhhLUPnJKq2y1wZ
 uwNHocH3ZWfyVt3wV8uN3RMcwLRehL4YrSGuc/V4/K0UPv+UCWC/doL6neHWxI2qH9
 j+ptq0mNLTtiL+pJhSFbkWb0yl8KkPVINopCoMTOYJ52aaPUiEF1glGeEz1efabWR3
 jkmrJmc9i5iam+tgq04lICbCeQKmxoAciNSi3v9D0HdFigrpgUTbmai2UzweB6txmG
 j6SDT68hzcQWw1hwgmW/o2lj9Owti699BfwozFsNXvErbryKCgQTP20IQvJYu3e/wu
 onK4K6q0eDcaw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=LrIGwHAS
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="LrIGwHAS"; 
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
> Sync Linux kernel dwc3 changes from v6.12 to v6.13.
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
> List of commits: git log --oneline v6.12..v6.13
> Commits imported:
> 625e70ccb7bb usb: dwc3-am62: Disable autosuspend during remove
> 01ea6bf5cb58 usb: dwc3: gadget: fix writing NYET threshold
> a48f744bef9e usb: dwc3: xilinx: make sure pipe clock is deselected in usb2 only mode
> a4faee01179a usb: dwc3: imx8mp: fix software node kernel dump
> f5313c8b418c usb: dwc3: gadget: Remove dwc3_request->needs_extra_trb
> 61440628a4ff usb: dwc3: gadget: Cleanup SG handling
> b7fc65f5141c usb: dwc3: gadget: Fix looping of queued SG entries
> 02a6982b0ccf usb: dwc3: gadget: Fix checking for number of TRBs left
> 5d2fb074dea2 usb: dwc3: ep0: Don't clear ep0 DWC3_EP_TRANSFER_STARTED
> ce25e2a8d82d usb: dwc3: core: Set force_gen1 bit for all applicable SuperSpeed ports
> 61eb055cd304 usb: dwc3: gadget: Add missing check for single port RAM in TxFIFO resizing logic
> 6ff78df5b3d0 usb: Use (of|device)_property_present() for non-boolean properties
> b95d0899c8bf usb: use "prompt" instead of "bool" for choice prompts
> fad16c823e66 usb: dwc3: gadget: Refine the logic for resizing Tx FIFOs
> 9a0749d61a9a usb: Switch back to struct platform_driver::remove()
> 57d7a6b93822 usb: dwc3: Correct some typos in comments

Some commits listed here are not imported. (For example xilinx, imx8mp).
Please drop them from the changelog.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

