Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00ADCC5DF81
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 09:00:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFA9B4071D;
	Mon, 24 Aug 2026 09:00:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DQWLL-noPAEF; Mon, 24 Aug 2026 09:00:50 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787562050;
	bh=6umqV3fyozB09KDR+eb2iDRp8mOe2Tew4eHO1d+zMeU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X16eTDuNGRDcO9ZNUgQu4xKG/LsHtrBonwlduPEd48rcGf7WXsCvpCsC8Yu+JV8b7
	 zTkXsDQhWDqgckqQ9t1CRfDYnr0ulWsj/6OfoeGNUbSdQyv7HuyTluhcE5zncHWfIa
	 tRH789OHnsfhKVcuyuDchtLWSM8JmalNnG7vN5BSjBO9Dw1CYFxNk+XMk9bCjbi77a
	 C0RBYOEZHaSJTw4S8g4raMznEL/zqAqXPVL23Hv5w3fKAQiyLjALM+yV0rvp2zr8U3
	 cNFUpkHAVLgkVja1nIgYoQDIwTvvMwZL7RzXhKlIfe08ZjZjn2WkQFHxl/Rhf8qRhZ
	 n3ASRd+wqFH0Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7583B406BF;
	Mon, 24 Aug 2026 09:00:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8786F386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:00:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E276406BF
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:00:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id USYsaGtYEKob for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 09:00:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=VMhfvGPB
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BCE584068F
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 09:00:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7A8F1600C8;
 Mon, 24 Aug 2026 09:00:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D631F000E9;
 Mon, 24 Aug 2026 09:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787562047;
 bh=6umqV3fyozB09KDR+eb2iDRp8mOe2Tew4eHO1d+zMeU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=VMhfvGPBg22OV1i9zGaDgoPxzbFYv/M3AfUb1lDbGgsIdbAIF6khJwapSQDd/255l
 FRmqxxhClD780ImNT82Oi/KgwxxqTZgi1cblswsEou+wsHSURxa2CkXR+lR/TmoDQ2
 xBCKyP7y2a7CaMh2Kx+cWUqCQgCkUcMKMGbWdi9Efdl0u149JF3QpXLQnbW0InGCsM
 0Oo3HvXBX2l9NCJsLEzGZbUH9iiqCYo7hMEsTSj+7PfuCLB1hLeAg1Owc9sgQ47EHO
 /mnRnke+u6VnCnOfPE+DDcK1r5m0sRSZmqhjS9DgrmoQLkf1SIi0q4mwE01NtbX0mE
 XEJS511+fza9Q==
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: ilias.apalodimas@linaro.org, trini@konsulko.com, michal.simek@amd.com,
 alchark@flipper.net, jerome.forissier@arm.com, Jens Wiklander
 <jens.wiklander@linaro.org>, Anders Roxell <anders.roxell@linaro.org>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Lukasz Majewski
 <lukma@denx.de>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v6 34/87] usb: dwc3: import from kernel v5.9
In-Reply-To: <20260821084829.2070426-35-anders.roxell@linaro.org>
References: <20260821084829.2070426-1-anders.roxell@linaro.org>
 <20260821084829.2070426-35-anders.roxell@linaro.org>
Date: Mon, 24 Aug 2026 11:00:44 +0200
Message-ID: <878q5voptv.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Hi Anders,

Thank you for the patch.

On Fri, Aug 21, 2026 at 10:47, Anders Roxell <anders.roxell@linaro.org> wrote:

> From: Jens Wiklander <jens.wiklander@linaro.org>
>
> Sync Linux kernel dwc3 changes from v5.8 to v5.9.
>
> The following files are preserved across the import:
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
> List of commits: git log --oneline v5.8..v5.9
> Commits imported:
> df561f6688fe treewide: Use fallthrough pseudo-keyword
> bc9a2e226ea9 usb: dwc3: gadget: Handle ZLP for sg requests
> d2ee3ff79e6a usb: dwc3: gadget: Fix handling ZLP
> 5d187c0454ef usb: dwc3: gadget: Don't setup more than requested
> f5e46aa4a124 usb: dwc3: gadget: when the started list is empty stop the active xfer
> c5a7092f4015 usb: dwc3: gadget: make starting isoc transfers more robust
> ca14378560db usb: dwc3: gadget: add frame number mask
> 10623b879da3 usb: dwc3: Replace HTTP links with HTTPS ones
> 62fb45d317c5 USB: ch9: add "USB_" prefix in front of TEST defines
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

