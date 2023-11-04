Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CABFCC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 19:33:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 546D68703A;
	Sat,  4 Nov 2023 20:33:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA66E86F6C; Sat,  4 Nov 2023 20:33:09 +0100 (CET)
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC44F87067
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 20:33:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=dolcini.it
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=francesco@dolcini.it
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it
 [93.49.2.63])
 by mail11.truemail.it (Postfix) with ESMTPA id 432B820285;
 Sat,  4 Nov 2023 20:33:07 +0100 (CET)
Received: from livingston (unknown [192.168.42.11])
 by gaggiata.pivistrello.it (Postfix) with ESMTP id E3E407F8EB;
 Sat,  4 Nov 2023 20:33:06 +0100 (CET)
Received: from pivi by livingston with local (Exim 4.96)
 (envelope-from <francesco@dolcini.it>) id 1qzMOI-0001IT-2p;
 Sat, 04 Nov 2023 20:33:06 +0100
Date: Sat, 4 Nov 2023 20:33:06 +0100
From: Francesco Dolcini <francesco@dolcini.it>
To: Nishanth Menon <nm@ti.com>
Cc: trini@konsulko.com, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Francesco Dolcini <francesco@dolcini.it>, Andrew Davis <afd@ti.com>,
 u-boot@lists.denx.de
Subject: Re: [PATCH V2 2/2] arm: mach-k3: Move TI dummy keys out of board
 folder
Message-ID: <ZUaccptWVlcqtyxU@livingston.pivistrello.it>
References: <20231104024511.3597476-1-nm@ti.com>
 <20231104024511.3597476-3-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231104024511.3597476-3-nm@ti.com>
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

On Fri, Nov 03, 2023 at 09:45:11PM -0500, Nishanth Menon wrote:
> This file is used to emulate customer keys on TI development board
> ecosystems, move it out of board/ directory and into mach-k3. And
> change the relative paths to absolute paths in the binman paths.
> 
> While at it, drop the reference in verdin-binman file which is
> redundant.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Reviewed-by: Francesco Dolcini <francesco.dolcini@toradex.com>

