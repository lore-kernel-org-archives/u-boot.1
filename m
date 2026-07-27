Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0910DC53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:01:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0E6580CBF;
	Mon, 27 Jul 2026 09:01:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IjIW4ftIav3k; Mon, 27 Jul 2026 09:01:07 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EE34680C93
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142867;
	bh=gvCUqIapBwBAN2cLp1nzsj65SWN3jEi4jS+9o/oo3hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0fBW5h9WU28IFgZMlo/ubdScLN9X70gC8Me7bS8ol1kpcY98bHo0cuB7wWktNAYA+
	 5ktYWl04x+wUbK9gMkUuGBQv7zveFepGiUN/mUpYU2jnoE5KeKrd+fc77Rcj2kh0oH
	 0im3HBio7Sh3kO2TmcqtJFSHYAQfDfKdY6mfNb6CBVCZ0+97GjovhrMgnDbi5MEVrA
	 z9EyA9I5u0mdK8WEzE9DY4ukbrNXKrcaVRhxju7rJ2AABtDPzoLu2/8ZvCzhV0Cxdk
	 BgjNWNB9yPqAgV4nnFJcfIM33PNYKdRoTL3iL97aWc8TDoU3zqto2et6OjLP0IYtjF
	 0FtJLLAN9eEbg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id EE34680C93;
	Mon, 27 Jul 2026 09:01:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 80DBF3B1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:01:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 729894065F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:01:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vAx3rqNDvvYE for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:01:05 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 75B0F405DC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75B0F405DC
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75B0F405DC
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:01:04 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3455E84671; Mon, 27 Jul 2026 11:01:02 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C95B582991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:00:59 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CE5444BB0;
 Mon, 27 Jul 2026 09:00:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D4C1F000E9;
 Mon, 27 Jul 2026 09:00:57 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 14/75] usb: dwc3: import from kernel v4.11
In-Reply-To: <20260716134305.614278-15-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-15-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:00:55 +0200
Message-ID: <877bmg6c3c.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142858;
 bh=gvCUqIapBwBAN2cLp1nzsj65SWN3jEi4jS+9o/oo3hk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=cofohvRLuzI5dWOrN3UNPy6faJZxfVheyyvnpDmmT+7X2Kpkm++hhSENjrNe5luez
 ZPU1A9jelQCtAkcOaWIwlEoMlYuD9Au0RJ7JX5vH4yHeJwjq5Z0kTI4rTQ4MOXISnq
 Ms/zCE/LcuzHRJHYg0Bd32HubmA8MgsNCEWy3095U82nRAElQWs9mevNwUMPoV+BkP
 WYBM0mg5Mx5jqaRIgeDNxc7zB7Zztz3cdARK964vpbEFZpXp3E2LunCxRG9P5IdWqR
 NJPVUUEPGyW3Yux3G+bzMRfQnSBKaB2D86mWaK1jv2SsqVTL0VOFjJIqsxw2zGLwXw
 XYRJV3faf+7YA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cofohvRL
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="cofohvRL"; 
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
> Sync Linux kernel dwc3 changes from v4.10 to v4.11.
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
> List of commits: git log --oneline v4.10..v4.11
> Commits imported:
> de288e36fe33 usb: dwc3: gadget: delay unmap of bounced requests
> 35b2719e72d3 usb: dwc3: gadget: make to increment req->remaining in all cases
> 0913750f9fb6 usb: dwc3-omap: Fix missing break in dwc3_omap_set_mailbox()
> 1551e35ea418 usb: dwc3: gadget: Fix system suspend/resume on TI platforms
> 73561128eb72 usb: dwc3: Fix incorrect type for utmi mode
> cf3113d893d4 usb: dwc3: gadget: properly increment dequeue pointer on ep_dequeue
> 7369090a9fb5 usb: dwc3: gadget: make Set Endpoint Configuration macros safe
> e42a5dbb8a3d usb: dwc3: host: pass quirk-broken-port-ped property for known broken revisions
> 28781789051e usb: dwc3: gadget: read IN ep FIFO size from HW
> ffb80fc672c3 usb: dwc3: gadget: skip Set/Clear Halt when invalid
> 538967983b88 usb: dwc3: ep0: Fix the possible missed request for handling delay STATUS phase
> c773bb0b9264 usb: dwc3: omap: Replace the extcon API
> c6267a51639b usb: dwc3: gadget: align transfers to wMaxPacketSize
> 905dc04ea796 usb: dwc3: gadget: allocate bounce buffer for unaligned xfers
> e49d3cf4926a usb: dwc3: gadget: extract __dwc3_prepare_one_trb()
> 843053093f47 usb: dwc3: gadget: simplify dwc3_prepare_one_trb()
> 0e4018ff5d12 usb: dwc3: exynos: Remove MODULE_ALIAS()
> 3e27b3f66a56 usb: dwc3: exynos remove suspend clock unspecified debug message
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

