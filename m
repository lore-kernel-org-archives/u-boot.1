Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE81C53219
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C219040549;
	Mon, 27 Jul 2026 08:42:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XOdFaPgToNQG; Mon, 27 Jul 2026 08:42:36 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F26A640565
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785141756;
	bh=o49nuhxENcND6qzwotXm1eA1+pCm7itQ/b92GMC30o8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IAodBprHnsmfXdog+kwDSqcULOsXPEBebc/aDStdRZBc6v80otHwT3JlwO/xZXUIp
	 REjuwBgog3CPPJkagx5mty0s97KtVnlC3ducPJ549TSBe/uuyx9TkY6QkpaMRdr1E/
	 3iCaX4jkpnsAvyr6IYWFvibTHgH0zBTwIhp+UVJoVq7C0vGCC2VmEoi2ntanz+szVs
	 b5eRoUn01Y4PxnYWWqF24Awyf0R/g9P/TIjyHWVwKQJFn80XSm19tA7Qr3Gt845xVQ
	 Y0hWMNbAMaIxU/tWgQBsqDTmglIY0w1nHaLdMZAZSX/zfgU3tBrhh+SF/1fWu3hwbD
	 or/+GLMA2fFEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F26A640565;
	Mon, 27 Jul 2026 08:42:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B364F42A
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:42:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9206540565
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:42:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NonZNZzpDye5 for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:42:33 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 58CB140549
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58CB140549
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 58CB140549
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:42:33 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF00984671; Mon, 27 Jul 2026 10:42:30 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC2A782991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:42:28 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A453B601EC;
 Mon, 27 Jul 2026 08:42:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26581F000E9;
 Mon, 27 Jul 2026 08:42:26 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 02/75] usb: dwc3: import from kernel v3.19
In-Reply-To: <20260716134305.614278-3-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-3-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:42:24 +0200
Message-ID: <87a4rc7rin.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785141747;
 bh=o49nuhxENcND6qzwotXm1eA1+pCm7itQ/b92GMC30o8=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ni3I77fQXHiaxj5C6K3Ih2xU8c+n66O58saK+KF45LgHkUKpUBlEiH8S5sVuEqOcY
 nlnXMTOBNr11NGrW2tsXmNnwTi2xnN02e2pSUJKSQVQlrtrcKoimVQGPblQDuvsdQZ
 egMLNLCZXwlXrl1ZlOhDKzS4fz0wpc1iyQcNxLOCgmEeN5r8kphh5LqVZ8oGwnU5bk
 n7VwOhAMUG13sMrN7KW73b5035duoKcVfJ30PJcROJpFJv6z0UdlM1GQx2kzZJlYKA
 N27h1WcmVClWL8gafD++lqUQefjjm68k4ategnneroP5h/lFF36cUa6jY7CZUFQTJW
 EhLHXPLHoGxnA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=ni3I77fQ
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="ni3I77fQ"; 
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
> Sync Linux kernel dwc3 changes from v3.19-rc1 to v3.19.
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
> List of commits: git log --oneline v3.19-rc1..v3.19
> Commits imported:
> 39e60635a015 usb: dwc3: gadget: Stop TRB preparation after limit is reached
> ec512fb8e561 usb: dwc3: gadget: Fix TRB preparation during SG
> 84a2b61b6eb9 usb: dwc3: pci: add support for Intel Sunrise Point PCH
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Compared this commit with v3.19 in linux. I don't see anything odd here,
so:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

