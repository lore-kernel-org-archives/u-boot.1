Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81770C531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 09:16:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D107960687;
	Mon, 27 Jul 2026 09:16:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LdwG8ah3DjP8; Mon, 27 Jul 2026 09:16:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0D12F6065D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785143766;
	bh=+g+4hYs3UQwFRa4N1uPyElvMsiwF3pqsbH993rHQVN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=I6tC8TSDUqrCMF284OhVj5crFpSK6VrIes6Umk+D4DakKwGPNiIrbZvLCxfrFf+Lj
	 8F558rao35LC3WwEyg0/q5KEU32l7VpBVyXJJJcLvlacEAAjIRXTpCgn7d74BO4kKM
	 m8GPdOTGIvWAzQBqCKKeQ/BWb0gnGt5vpapL0NmZf8CUmLfEy3ZyH4QczqY7EDmZg7
	 C6wqQ+kmZs4u5qprkR8IG4EdIn9ZHaUw7JjdXFUWW+dQsiiazjO98h/m5yVrvCqQzn
	 yj7QcNQKa24NQGKwMluI43r26+b9qYWn5vpfWZzj4LOGY5671LJh5oBxKJowRYQ+59
	 0GwLB5WQd07Eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0D12F6065D;
	Mon, 27 Jul 2026 09:16:06 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B86C0357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:16:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B5E1F40578
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:16:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TWg9ryxSCdO3 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 09:16:03 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 8790140577
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8790140577
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8790140577
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 09:16:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E58A884671; Mon, 27 Jul 2026 11:15:49 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D684A82991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 11:15:43 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51289438F4;
 Mon, 27 Jul 2026 09:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ACB1F000E9;
 Mon, 27 Jul 2026 09:15:41 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 25/75] usb: dwc3: import from kernel v5.1
In-Reply-To: <20260716134305.614278-26-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-26-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 11:15:39 +0200
Message-ID: <878q6w4wuc.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785143742;
 bh=+g+4hYs3UQwFRa4N1uPyElvMsiwF3pqsbH993rHQVN4=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=gyU4ryghHCs8gQ1ME3ceulP05zXJi1lmm2bZlHgEQEehatpzDq4iCq1c3hFwNSo/B
 Nrzxp8xw/wUeYOF97TZq2P6h7Rq2GuF48xiO6MEs27SslUVoOklWHppHRVYIGuAVxD
 oI+xmgw5xJ75m8BQuTwtB1s4oudaJShE+W6AFGxirBPNQ2Jiv1Aog+f9nVhgBjwStt
 iPzphHFp2ZPp+IwOSYZMdu4LnK6hRVfauuqm0ggPm8Q+CqPwZBGVRmuUFjGOgW66Sn
 Iw7D/U9Tcl0ze76+DFVmi4r5lXsnomzlVLRY5QYTjeNqYk+yNp3NIEz2ZKZHDwNDhz
 tVAQPr9qq+QAA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=gyU4rygh
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="gyU4rygh"; 
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
> Sync Linux kernel dwc3 changes from v5.0 to v5.1.
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
> List of commits: git log --oneline v5.0..v5.1
> Commits imported:
> 7ae622c978db usb: dwc3: pci: add support for Comet Lake PCH ID
> 98bba546e82d usb: dwc3: drd: Defer probe if extcon device is not found
> c7152763f02e usb: dwc3: Reset num_trbs after skipping
> c5353b225df9 usb: dwc3: gadget: don't enable interrupt when disabling endpoint
> 9c7ebc99b382 usb: dwc3: haps: Workaround matching VID PID
> 1381a5113caf usb: dwc3: debug: purge usage of strcat
> 7790b3556fcc usb: dwc3: trace: pass trace buffer size to decoding functions
> 3aec99154db3 usb: dwc3: gadget: remove DWC3_EP_END_TRANSFER_PENDING
> 9f45581f5eec usb: dwc3: gadget: early giveback if End Transfer already completed
> 974a1368c33e usb: dwc3: gadget: don't use resource_index as a flag
> acbfa6c26f21 usb: dwc3: gadget: clear DWC3_EP_TRANSFER_STARTED on cmd complete
> 7c3d7dc89e57 usb: dwc3: gadget: remove req->started flag
> b2b6d601365a usb: dwc3: gadget: prevent dwc3_request from being queued twice
> a3af5e3ad3f1 usb: dwc3: gadget: add dwc3_request status tracking
> eca6b49430c6 usb: dwc3: keystone: Add support for ti,am654-dwc3
> 169e3b68cadb usb: dwc3: gadget: Fix OTG events when gadget driver isn't loaded
> 54c9da1bcec4 usb: dwc3: qcom: Add support for MSM8998
> cae8dc3b685f USB: add missing SPDX lines to Kconfig and Makefiles
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

