Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC0CCF2579
	for <u-boot@archiver.kernel.org>; Sun, 13 Oct 2024 12:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E36AA88EB7;
	Sun, 13 Oct 2024 14:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="sZonhC9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EBE4888EAF; Sun, 13 Oct 2024 14:42:20 +0200 (CEST)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E92788EB7
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 14:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 668FE1FA30;
 Sun, 13 Oct 2024 14:42:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1728823337;
 bh=SL7hPYP4nI36fOj800GBwDJP4zDoqOWUUk6QmJVWcss=; h=From:To:Subject;
 b=sZonhC9kgmRZY8oKuNDmKHgBd9/YL4ybffDU0F+un0/MPJB9x5GHYaiNEAcyUTIFc
 aG+S2QnBjG7ZmgZoMOPkAfiHw+R+vRgIqB0YtACctYshOvvVsUOPOcLij1WLAzRp2X
 E/sriaDqc738i2qxy5RD5ud0xIlvOEv9te2zdD9d0E2qLQ9Ni4fvMEePU44DuH/WuA
 s/TvrZoHZBKtXUgAFnV2OXVQLgL4rP7hCkjQf6UqwTPOnS4IcoIGaqr9MAFtAmZYg2
 KnCMM37RcLfM11q3k/CDGSICnb3txcTLKirbm7oU7bb9n3zUguP304VE08nI8e+022
 hdhmCxYfZX5QA==
Date: Sun, 13 Oct 2024 14:42:13 +0200
From: Francesco Dolcini <francesco@dolcini.it>
To: Heiko Schocher <hs@denx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Fabio Estevam <festevam@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, Marek Vasut <marex@denx.de>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: Re: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
Message-ID: <20241013124213.GA15299@francesco-nb>
References: <20241010082831.19983-1-hs@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241010082831.19983-1-hs@denx.de>
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

On Thu, Oct 10, 2024 at 10:28:31AM +0200, Heiko Schocher wrote:
> trying to load current flash.bin with uuu tool
> leads in not booting U-Boot as missing some bytes.
> 
> Align flash.bin in this case to 0x800 bytes, to
> make uuu and ROM api happy.

Are you sure that the issue is on this? Can you check
https://github.com/nxp-imx/mfgtools/issues/416 ?  Just sharing something
related when using UUU on OE generated binaries to confirm you are
not chasing the wrong issue here.

Francesco

