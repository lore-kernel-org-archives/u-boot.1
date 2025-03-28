Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12245C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 12:52:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97E4681951;
	Fri, 28 Mar 2025 13:52:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="cbD+akIf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D31FB81951; Fri, 28 Mar 2025 13:52:07 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7EA798129B
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 13:52:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 71B961F997;
 Fri, 28 Mar 2025 13:52:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1743166324;
 bh=xKlIGPohK3rPWDah3/faTkiXjpfKNnoZEusuoSKvjz4=; h=From:To:Subject;
 b=cbD+akIfki90cAfxrUgA5f4EDY7OKoaWtVEBjbATNjV1VGS4NOeHA7yywg0g28YLA
 BfNGXSoiVE6v/TrDQ6SujA74js63rhUlZx8alYWV7lA/7CcPDCZljFUNboQ8YcMnAR
 m0vYm7TeM8N7P02DTSfanXkPfYpVPKB/cPUddfNUHaJZZUC5CrqN1m7ZiWOIk6KYwU
 ILxaXpKkAe5ozuZ4E95p+fl6akRnTrEB7o/IT4rRpNKPT3ahk7rbENceo3LOB4U7K7
 PYC1LNgPT9EvktdecZEJC1Y4i5aWWODUwjkNFNTfFpUWsok2uf7vgSZF04xtSRoNGk
 wHAcfUQtqP+Pw==
Date: Fri, 28 Mar 2025 13:52:00 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: rafael@beims.me
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Tom Rini <trini@konsulko.com>,
 Rafael Beims <rafael.beims@toradex.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] toradex: apalis-imx6: Fix build failure when
 CONFIG_VIDEO_IPUV3 is enabled
Message-ID: <20250328125200.GA46189@francesco-nb>
References: <20250328102051.2614040-1-rafael@beims.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328102051.2614040-1-rafael@beims.me>
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

On Fri, Mar 28, 2025 at 11:20:40AM +0100, rafael@beims.me wrote:
> From: Rafael Beims <rafael.beims@toradex.com>
> 
> If CONFIG_VIDEO_IPUV3 is enabled without also having CONFIG_IMX_HDMI
> enabled, the build fails for the Apalis iMX6 board.
> 
> Fixes: 592f4aed6db7 ("arm: imx: initial support for apalis imx6")
> Signed-off-by: Rafael Beims <rafael.beims@toradex.com>
Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

Francesco

