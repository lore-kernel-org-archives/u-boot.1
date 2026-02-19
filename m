Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB84E9A053
	for <u-boot@archiver.kernel.org>; Thu, 19 Feb 2026 17:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E81783D0B;
	Thu, 19 Feb 2026 18:23:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="DbZaD3Hg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8091F83D17; Thu, 19 Feb 2026 18:23:21 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6360183946
 for <u-boot@lists.denx.de>; Thu, 19 Feb 2026 18:23:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from francesco-nb (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 3EFB61FBB2;
 Thu, 19 Feb 2026 18:23:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1771521798;
 bh=NPCF1mm4bFvONwlRtF7J8TdZBCjpp9CKLOrTXUxgHMU=; h=From:To:Subject;
 b=DbZaD3HgLUo/esr1CH8ICbj7yS1/OvQdZjKqbqb0IkKU984TuLMPwRUCRBZSdHGau
 eZaVdI0Og3lpob4nbacFWq4rtt30kHmV206g9KuP8f0SGYggpNu/nDxOecoFbuPu74
 m+nxDGMk0lxShQrScLKTnkNO2mCeKOQfyljnPl1exniJahuNxESPBCRti7ROP1/ttF
 MWdjOUNP/Z8X8V28hC25148GYCPROuFCO9QaLT972+uRiBTxDSDR4FGLgH3okDMNMN
 l8Y9NomKHKuR0Z5+SdOO1JbUDkWIuBi/ww2JGf8JZX5GPfZzhKMHalmPGOELq/BJoP
 GLpB2CCUiMBMA==
Date: Thu, 19 Feb 2026 18:23:14 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Wadim Egorov <w.egorov@phytec.de>
Cc: trini@konsulko.com, francesco.dolcini@toradex.com, ggiordano@phytec.com,
 anshuld@ti.com, m-chawdhry@ti.com, bb@ti.com, u-boot@lists.denx.de,
 upstream@lists.phytec.de
Subject: Re: [PATCH] arch: arm: dts: k3-r5: Drop a53_0 clock overrides in
 board files
Message-ID: <20260219172314.GA344723@francesco-nb>
References: <20260219102721.102254-1-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219102721.102254-1-w.egorov@phytec.de>
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

Thanks for the patch.

On Thu, Feb 19, 2026 at 11:27:20AM +0100, Wadim Egorov wrote:
> The a53_0 clock properties are already set correctly in their
> common k3-<soc>-r5.dtsi includes. Stop overriding them in
> the r5 board device trees.
> 
> Fixes the following error message:
>   Failed to set clock rates for '/a53@0': -61
> 
> Signed-off-by: Wadim Egorov <w.egorov@phytec.de>


U-Boot SPL 2026.04-rc2-00034-gec24dd5dee18-dirty (Feb 19 2026 - 18:18:09 +0100)
SYSFW ABI: 4.0 (firmware rev 0x000b '11.2.5--v11.02.05 (Fancy Rat)')
Set clock rates for '/a53@0', CPU: 800MHz at Speed Grade 'K'

Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com> # Verdin AM62 Solo

Francesco

