Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FEAC531D0
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 08:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B4C7C80C09;
	Mon, 27 Jul 2026 08:52:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id D4PQIJ2n9T0e; Mon, 27 Jul 2026 08:52:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1B7F680BCC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785142352;
	bh=f4gqBwLlMgMzjX2ZSoG3jBTdJp5sT/K3Bxvb9xJjXmQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VONoDsVCJqXUpNYKQT2c9GhHOmsudm8b35KSxtCS81b/uDKSTEmjGvIOH5ta33mqn
	 U2mNmN2ACKjp1hhFsGPYLVY04EMepNSr1lwcVc1x07C1RPYpTTagn+HHB4Fr572baN
	 FmBA0wkArn1yvMeXctN6gTntydr8nFCbIJPeqQZ6Az4zDkpJm3arVg8d/bQ4vcB0H/
	 Sr5JD3nEo8rEZ6Z6oTN4moy4pg3nICFKZ4Ue/+jCXVvaJhO3t/J/Q51pIWknfkaa9j
	 ivEIZJZgSsWQ05QkR4NR9w09u52PUmhthaR+xt9KHNe6LTaf1MXAGhUQkg0HtkNQxB
	 +CGM5KjfxLr3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1B7F680BCC;
	Mon, 27 Jul 2026 08:52:32 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 57E22490
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:52:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 52913400D8
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:52:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9QcoQraTzdMx for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 08:52:30 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom;
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=mkorpershoek@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4EDE44005F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4EDE44005F
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4EDE44005F
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 08:52:30 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id C7459846A3; Mon, 27 Jul 2026 10:52:28 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A568082991
 for <u-boot@lists.denx.de>; Mon, 27 Jul 2026 10:52:26 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 47A0441814;
 Mon, 27 Jul 2026 08:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C7B21F000E9;
 Mon, 27 Jul 2026 08:52:24 +0000 (UTC)
From: Mattijs Korpershoek <mkorpershoek@kernel.org>
To: Anders Roxell <anders.roxell@linaro.org>, u-boot@lists.denx.de,
 marex@denx.de
Cc: mkorpershoek@kernel.org, ilias.apalodimas@linaro.org,
 trini@konsulko.com, michal.simek@amd.com, alchark@flipper.net,
 jerome.forissier@arm.com, Jens Wiklander <jens.wiklander@linaro.org>,
 Simon Glass <sjg@chromium.org>, Anders Roxell <anders.roxell@linaro.org>,
 Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5 05/75] usb: dwc3: import from kernel v4.2
In-Reply-To: <20260716134305.614278-6-anders.roxell@linaro.org>
References: <20260716134305.614278-1-anders.roxell@linaro.org>
 <20260716134305.614278-6-anders.roxell@linaro.org>
Date: Mon, 27 Jul 2026 10:52:22 +0200
Message-ID: <87wlug6chl.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1785142345;
 bh=f4gqBwLlMgMzjX2ZSoG3jBTdJp5sT/K3Bxvb9xJjXmQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=SjX/G4RAMDG/gOmfVn6H7qJ+KqntVBeX6K3FK7DTstABIDV03qin7QRXBzVG3+X6R
 olfCLJYfGKYQJBl6X5waWhMNmBsLBC40XhpKolBslG0QkzRSbVoByBiDoEVU/0NO/J
 V3TRd0VLm5DjSbnCpGz1S2yv5RPlYTbxBISki+phTi8m2WQ3lMk4vN6KiS2/SEhtPn
 QGyJ7GCGONoAyi+jtwg8uOzRdOOSyPX/7ygwm7rArpn5rpwL6xWpiYP9Ash5ALeO2F
 yc5auE7DWs/DD0sliohpCHhy/MiwMJaGKHXKzSiW8VCwmXErN5Q41MndaJDfNHA3pM
 Th0laoouSrW8Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=SjX/G4RA
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=mkorpershoek@kernel.org
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="SjX/G4RA"; 
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
> Sync Linux kernel dwc3 changes from v4.1 to v4.2.
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
> List of commits: git log --oneline v4.1..v4.2
> Commits imported:
> aebda6187181 usb: dwc3: Reset the transfer resource index on SET_INTERFACE
> 43cacb03aabe usb: dwc3: core: avoid NULL pointer dereference
> 50641056d833 usb: dwc3: Use ASCII space in Kconfig
> e18b7975c885 usb: dwc3: gadget: don't clear EP_BUSY too early
> 76e838c9f776 usb: dwc3: gadget: return error if command sent to DEPCMD register fails
> 891b1dc02295 usb: dwc3: gadget: return error if command sent to DGCMD register fails
> 88bc9d194ff6 usb: dwc3: add ULPI interface support
> a89d977cc04c usb: dwc3: pci: add quirk for Baytrails
> 3e10a2ce98d1 usb: dwc3: add hsphy_interface property
> 45bb7de213d8 usb: dwc3: setup phys earlier
> c5cc74e8c12b usb: dwc3: soft reset to it's own function
> 2917e7181589 usb: dwc3: cache hwparams earlier
> 6c89cce0476f usb: dwc3: store driver data earlier
> f699b94789a6 usb: dwc3: ULPI or UTMI+ select
> b5699eeee68f usb: dwc3: USB2 PHY register access bits
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> Reviewed-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

I've file-compared with the mentioned Linux kernel release, and this
looks good to me:

Reviewed-by: Mattijs Korpershoek <mkorpershoek@kernel.org>

