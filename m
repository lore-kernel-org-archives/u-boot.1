Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45475C53200
	for <u-boot@archiver.kernel.org>; Wed, 29 Jul 2026 09:31:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1044F60AF1;
	Wed, 29 Jul 2026 09:31:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SjsM-T8nUP3R; Wed, 29 Jul 2026 09:31:28 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4B91460AD1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785317488;
	bh=uEJCiW7XanOQDjjOzB6Z9ZJ8T5FKlM74Bv/ED2uTwDY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gXH4IvENnUd43TPauIY1cgZtCy04JjHs3CThLatxR/Gp56UaoDklI3Nd6AAtcq6mS
	 VR8lsINuonXbSrVmJziE91YpITb9JAU2/hJaIXsXIbUBvg69tkEIoTEnc5v2Gjn8uj
	 iAg9AiTjpw74WGZtvfN5qtK34OdldzCbDQP+tVq+Ku7Hui3xCUBDOCRuLPRa//6nbq
	 WKX3lxao+mzht4MtmM3avYsJ2uSXDFt8tWU7lRrj98LamocYCUgyvYu90jVGhwjq0d
	 UU8SiGLBHQVHM4LTyi1DJWWXQTmYy1LDQvQgRUGoG2Qw6CV7ZpvR72xu1hw5BZOT6B
	 9/zNdzofhZ7uA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4B91460AD1;
	Wed, 29 Jul 2026 09:31:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 75B2A26C
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:31:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5C0C660AD1
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:31:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WdKyYJYhOdSU for <u-boot@lists.u-boot-project.org>;
 Wed, 29 Jul 2026 09:31:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=mkorpershoek@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org E901B60AC9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E901B60AC9
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E901B60AC9
 for <u-boot@lists.u-boot-project.org>; Wed, 29 Jul 2026 09:31:25 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 444858494B; Wed, 29 Jul 2026 11:31:24 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B0408404D
 for <u-boot@lists.denx.de>; Wed, 29 Jul 2026 11:31:22 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C7F1243730;
 Wed, 29 Jul 2026 09:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2048E1F01558;
 Wed, 29 Jul 2026 09:31:19 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>, Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 59/75] usb: dwc3: import from kernel v6.15
In-Reply-To: <20260716134305.614278-60-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-60-anders.roxell@linaro.org>
Date: Wed, 29 Jul 2026 11:31:18 +0200
Message-ID: <874ihiywex.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785317480;
 bh=uEJCiW7XanOQDjjOzB6Z9ZJ8T5FKlM74Bv/ED2uTwDY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Xo0dJ9N6dZAotxvnKwXFQyDj97DWBFvAQwRuS2OkWb3NxYrhdW3ShKqy1Hx0WGU2i
 Knh/XkyTqsYfjNC21lLuLGFe928DovENb3BsYxQAEReSOpSxUP8e0FcV75mMmLfGmf
 BfIhdHXb+1MGT4SBso4Eqhqay5UZeczT8yFhg1Ip8JR9EoPI7qxtpE8QOd5rdNQeok
 pVIeUUivVCWQ/j4qKQo5soHYtB2g8Pg5WeQh/ydA9KfTYBkJdV1p5AWKqsyQ4UsrRp
 n0se2ZtoriFOGHnKrAMw4QkWW59//Fja7cBAZsfYZg04VsXBZABkO7oQYqFwu6/2Mg
 AK7CE9EvQlyNQ==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=kernel.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=Xo0dJ9N6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="Xo0dJ9N6"; 
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
> Sync Linux kernel dwc3 changes from v6.14 to v6.15.
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
> List of commits: git log --oneline v6.14..v6.15
> Commits imported:
> 2372f1caeca4 usb: dwc3: gadget: Make gadget_wakeup asynchronous
> 63ccd26cd1f6 usb: dwc3: gadget: check that event count does not exceed event buffer length
> 38d6e60b6f3a usb: dwc3: xilinx: Prevent spike in reset signal
> 042c3dd1f2d3 usb: dwc3: Don't use %pK through printk
> 811d22141369 usb: dwc3: exynos: add support for exynos7870
> 07959ad5775f USB: dwc3: Use syscon_regmap_lookup_by_phandle_args
> 461f24bff868 usb: dwc3: gadget: Avoid using reserved endpoints on Intel Merrifield
> 5425191f85fe usb: dwc3: gadget: Add support for snps,reserved-endpoints property
> eafba0205426 usb: dwc3: gadget: Refactor loop to avoid NULL endpoints

Some commits listed here are not imported. For example: xilinx, exynos.
Please drop them from the changelog.

With that fixed:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

