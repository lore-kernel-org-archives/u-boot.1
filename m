Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B14BED10C03
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 19:23:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC4988DB2;
	Sat, 26 Oct 2024 21:23:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2486388E41; Sat, 26 Oct 2024 21:23:33 +0200 (CEST)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1FFAA88B4B
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 21:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1t4mNh-000000005X6-1C17; Sat, 26 Oct 2024 19:23:25 +0000
Date: Sat, 26 Oct 2024 20:23:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH] menu: fix the logic checking whether ESC key is pressed
Message-ID: <Zx1Bpb7_9TEqBeyB@pidgin.makrotopia.org>
References: <20241021005642.153511-1-weijie.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021005642.153511-1-weijie.gao@mediatek.com>
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

Hi!

On Mon, Oct 21, 2024 at 08:56:42AM +0800, Weijie Gao wrote:
> It's observed that the bootmenu on a serial console sometimes
> incorrectly quitted with superfluous characters filled to command
> line input:
> 
> >  *** U-Boot Boot Menu ***
> >
> >      1. Startup system (Default)
> >      2. Upgrade firmware
> >      3. Upgrade ATF BL2
> >      4. Upgrade ATF FIP
> >      5. Load image
> >      0. U-Boot console
> >
> >
> >  Press UP/DOWN to move, ENTER to select, ESC to quit
> >MT7988> [B
> 
> Analysis shows it was caused by the wrong logic of bootmenu_loop:
> 
> At first the bootmenu_loop received the first ESC char correctly.
> 
> However, during the second call to bootmenu_loop, there's no data
> in the UART Rx FIFO. Due to the low baudrate, the second char of
> the down array key sequence hasn't be fully received.
> 
> But bootmenu_loop just did a mdelay(10), and then treated it as a
> single ESC key press event. It didn't even try tstc() again after
> the 10ms timeout.
> 
> This patch fixes this issue by letting bootmenu_loop check tstc()
> twice.

The patch helps to fix the problem when dealing with single key
presses. However, apparently this is not enough to fix the issue in
all situations. I still manage to drop into U-Boot console with an
extra '[A' when simply holding down the arrow-up key for a while.

