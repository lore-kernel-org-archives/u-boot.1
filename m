Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDABFCD8CAD
	for <u-boot@archiver.kernel.org>; Tue,  9 Jun 2026 20:06:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09E6F848DF;
	Tue,  9 Jun 2026 22:06:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=superkali.me
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=superkali.me header.i=@superkali.me header.b="jsYnb/nV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 02BAC848E2; Tue,  9 Jun 2026 22:06:32 +0200 (CEST)
Received: from fr5000-r.dnsiaas.com (fr5000-r.dnsiaas.com [92.42.104.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0BE1848D8
 for <u-boot@lists.denx.de>; Tue,  9 Jun 2026 22:06:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=superkali.me
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hello@superkali.me
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=superkali.me; s=default; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JsCuaTHJmurSgjqsdu5jolHqfgFvuDfAeLj1KcvxhZc=; b=jsYnb/nVZmrg1gunnFLIaOd5ew
 ayOVxRQuglIEoYZAwCPP8BViYobGoVd6IUhlbOL/Zl9adp3xKrj8rGNkjR2HQSGHrgcvsbT50rC6L
 vYwV8S3U+3mxGAj2CdcYv5Vowiva0fce1GafpKfnb4o7d1IgaxqwCXGC3sYnQdrjB50+GrJkkErzy
 of+WqSIgynbAZVKu8eE2SnKtmLABens5ZlWfqBrjasLb3FFgHVWtGPfjCB/F6BcWvBsjXmDR9WF/U
 d3qPJl/B0qrHVlFaI0M2AI9ySehwGwPu68GE6dSRH2uWfMK4Do6EhLhQkdz1GVfYNguEGazsFWF/a
 7Ve4J5Ew==;
Received: from [81.57.40.39] (port=35270 helo=superkali.me)
 by fr5000-r.dnsiaas.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.99.4) (envelope-from <hello@superkali.me>)
 id 1wX2iR-0000000Auhf-3b83; Tue, 09 Jun 2026 22:06:27 +0200
From: Daniele Briguglio <hello@superkali.me>
To: Heiko Stuebner <heiko@sntech.de>,
	u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Philip Molloy <philip.molloy@analog.com>,
 Sean Anderson <sean.anderson@linux.dev>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Simon Glass <sjg@chromium.org>, Peter Korsgaard <peter@korsgaard.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: [PATCH v3 3/4] pci: pcie_dw_rockchip: drop clk_release_bulk calls
Date: Tue,  9 Jun 2026 22:06:25 +0200
Message-ID: <20260609200625.3260932-1-hello@superkali.me>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <1963052.CQOukoFCf9@diego>
References: <20260520-rock-5-itx-pcie-refclk-dtsi-v3-0-58f2cea72030@superkali.me>
 <20260520-rock-5-itx-pcie-refclk-dtsi-v3-3-58f2cea72030@superkali.me>
 <1963052.CQOukoFCf9@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - fr5000-r.dnsiaas.com
X-AntiAbuse: Original Domain - lists.denx.de
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - superkali.me
X-Get-Message-Sender-Via: fr5000-r.dnsiaas.com: authenticated_id:
 hello@superkali.me
X-Authenticated-Sender: fr5000-r.dnsiaas.com: hello@superkali.me
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

> Though the whole clk handling is quite strange.
> I would assume that it's always a
>   - clk-request
>       - clk-enable
>           something
>       - clk-disable
>   - clk-release
>
> That a clk-disable also hides in the clk-release is really surprising,
> and I guess a lot of places in u-boot will encounter the same
> imbalance - just mitigated by the fact that the double-disable
> won't matter.
>
> Directly in clk_get_bulk the problem is apparent ...
> The function tries to get all the clocks, and on error calls
> clk_release_all on the already gotten clocks.
>
> All of these clocks never got enabled, but are getting double-disabled
> by the clk_release_all() call.
>
> Very very strange ;-)

Right. clk_release_bulk() hides a clk_disable(), and clk_get_bulk() does
the same in its own error path: it calls clk_release_all() on clocks it
only ever requested, never enabled. Everywhere else that double-disable
is a no-op, so nobody notices. The gated-fixed-clock driver is what makes
it bite, since there the disable actually toggles the regulator.

Thanks for the review, and for testing on the rock-5-itx.

Daniele
