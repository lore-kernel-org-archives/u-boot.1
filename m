Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B487E67816
	for <u-boot@archiver.kernel.org>; Sat,  2 Nov 2024 22:24:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7096890B1;
	Sat,  2 Nov 2024 23:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 92DC8890B9; Sat,  2 Nov 2024 23:24:09 +0100 (CET)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D07489080
 for <u-boot@lists.denx.de>; Sat,  2 Nov 2024 23:24:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=daniel@makrotopia.org
Received: from local
 by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.98) (envelope-from <daniel@makrotopia.org>)
 id 1t7MXL-000000007dI-4038; Sat, 02 Nov 2024 22:24:04 +0000
Date: Sat, 2 Nov 2024 22:23:36 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Weijie Gao <weijie.gao@mediatek.com>
Cc: u-boot@lists.denx.de,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, John Crispin <john@phrozen.org>,
 Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v2 1/3] menu: fix the logic checking whether ESC key is
 pressed
Message-ID: <ZyamaLOiEMCd3c92@pidgin.makrotopia.org>
References: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
 <ZyPXqwcbREjnPc-1@pidgin.makrotopia.org>
 <cdb9a83d244a77e5ffb2a3d069607f16447b723e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb9a83d244a77e5ffb2a3d069607f16447b723e.camel@mediatek.com>
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

On Fri, Nov 01, 2024 at 03:20:11PM +0800, Weijie Gao wrote:
> Hi Daniel,
> 
> On Thu, 2024-10-31 at 19:16 +0000, Daniel Golle wrote:
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> > 
> > 
> > On Tue, Oct 29, 2024 at 05:47:10PM +0800, Weijie Gao wrote:
> > > It's observed that the bootmenu on a serial console sometimes
> > > incorrectly quitted with superfluous characters filled to command
> > > line input:
> > > 
> > > >  *** U-Boot Boot Menu ***
> > > > 
> > > >      1. Startup system (Default)
> > > >      2. Upgrade firmware
> > > >      3. Upgrade ATF BL2
> > > >      4. Upgrade ATF FIP
> > > >      5. Load image
> > > >      0. U-Boot console
> > > > 
> > > > 
> > > >  Press UP/DOWN to move, ENTER to select, ESC to quit
> > > > MT7988> [B
> > > 
> > > Analysis shows it was caused by the wrong logic of bootmenu_loop:
> > > 
> > > At first the bootmenu_loop received the first ESC char correctly.
> > > 
> > > However, during the second call to bootmenu_loop, there's no data
> > > in the UART Rx FIFO. Due to the low baudrate, the second char of
> > > the down array key sequence hasn't be fully received.
> > > 
> > > But bootmenu_loop just did a mdelay(10), and then treated it as a
> > > single ESC key press event. It didn't even try tstc() again after
> > > the 10ms timeout.
> > > 
> > > This patch fixes this issue by letting bootmenu_loop check tstc()
> > > twice.
> > > 
> > > Tested-By: E Shattow <lucent@gmail.com>
> > > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> > Tested-by: Daniel Golle <daniel@makrotopia.org>
> > 
> > Together with 2/3 and 3/3 this now avoids dropping into the U-Boot
> > shell
> > as long as the menu is short enough. In case of menus with 8 entries
> > of
> > more I still manage to drop into shell when holding the arrow down
> > key
> > before the last item has been reached.
> > That being said, it's already a very big improvement that this now
> > only
> > happens when holding down a button traversing over a menu with a high
> > number of items.
> 
> I didn't encounter with this.
> Did you try enabling CONFIG_SERIAL_RX_BUFFER?

Combined with CONFIG_SERIAL_RX_BUFFER it does resolve the issue and I no
longer manage to get dropped into console.

Thank you a lot for taking care of this!

