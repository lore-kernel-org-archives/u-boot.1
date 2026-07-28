Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F113EC53219
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 12:13:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 684F260876;
	Tue, 28 Jul 2026 12:13:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2kBg-JBTBlug; Tue, 28 Jul 2026 12:13:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B340E60856
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785240782;
	bh=FtxbYMNrdKQPpbVntU225DgmEvzD9lXjHF1CCjVlh6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0ECKkPByfJ8E3aiWH1Pe8mN7AbFIDV98Da9wIQSOI5OY4cjbNfhkTKjGXLT+GHbjK
	 q+ZIQta4NjnJXkk0TXxv29anRBsJ7hqwF9hB5cgzE5aLpS7WfTR3mstotZi97eq80J
	 3BEOtBdLxkPNH9Pj64no6r3OLvSP7HhdjmFJoM9JxUAEK/sB1wh1yCmqBOCYBVnfT6
	 OOz/6SHOMfLiclxtd3cjseWxSY4itqL/NN4nSU+5bZ9JNJqiDlcZRNB1HiwwqOu291
	 ldW8Q0ZkVCF0eCNHY4kl8q3FtD0LzaAPKGUuqncORvjoXtzimT57g6K4SdmwDqCzLq
	 b1SGF4IZaHkJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B340E60856;
	Tue, 28 Jul 2026 12:13:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2010F2E5
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:13:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 11E06409AF
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:13:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aM1ToLl-hbJI for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 12:13:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 95956409A2
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95956409A2
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95956409A2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 12:13:00 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 059548494B; Tue, 28 Jul 2026 14:12:59 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7A0E82991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 14:12:56 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 386BA41E51;
 Tue, 28 Jul 2026 12:12:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837601F000E9;
 Tue, 28 Jul 2026 12:12:54 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 47/75] usb: dwc3: import from kernel v6.3
In-Reply-To: <20260716134305.614278-48-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-48-anders.roxell@linaro.org>
Date: Tue, 28 Jul 2026 14:12:52 +0200
Message-ID: <875x1z1fej.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785240775;
 bh=FtxbYMNrdKQPpbVntU225DgmEvzD9lXjHF1CCjVlh6w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Ln/UV1zAzwx99tSk0zkcgkZQLBZWhAyvVH8zcJbqbmyEQ6bjLxTGe3fjdhos/+yQH
 7v9H9FM2aWBf/pL5Bc3IriUT/RtFiWjvamoOZPbV0qBlnXhx3+SOwUUw6wYb8bKEha
 h2pIOyfHl2+ldJsTmcieh/AveDGf/FfHfZpDBm7W4bXBCGFp5JGk6/gsMqUOdJe4ZZ
 EVwkvp0Sa9r0ftDA5pgaS8jT+joD8g0klSnlh+a82Ej5q96vUQNVQltpylSkujofY/
 J79+uT4MTsbmf2HtdElPwi2l1nFMCGkJk6q/PkOqjUmdoenLWn8ITqJgkByHXUG8MS
 JcRqe5BinMqHQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=Ln/UV1zA
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ln/UV1zA"; 
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
> Sync Linux kernel dwc3 changes from v6.2 to v6.3.
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
> List of commits: git log --oneline v6.2..v6.3
> Commits imported:
> ec799c8a92e0 usb: dwc3: pci: add support for the Intel Meteor Lake-S
> d8a2bb4eb758 usb: dwc3: gadget: Add 1ms delay after end transfer command without IOC
> 02c1820345e7 usb: dwc3: Fix a typo in field name
> e3eafcf0fabe usb: dwc3: xilinx: Remove unused of_gpio,h
> 8e5248c3a877 usb: dwc3: pci: add support for the Intel Meteor Lake-M
> be308d68785b USB: dwc3: fix memory leak with using debugfs_lookup()

Please drop the irrelevant patches that were not applied from the
changelog.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

