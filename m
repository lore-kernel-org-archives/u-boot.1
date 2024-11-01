Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29BC4E674AA
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 07:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C9ED888EB;
	Fri,  1 Nov 2024 08:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="ZwmAFoym";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 925AD888EB; Fri,  1 Nov 2024 08:20:27 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B5FC88360
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 08:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: bcb0a010982111efbd192953cf12861f-20241101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=uekRhUeYO6KUawMPL+OY1Ayi/VptuakyrLi756mvbrA=; 
 b=ZwmAFoymc1GdBrzAvv7ms1G0zbBmmDwqX5djA/tEmoADk4J1meOky+lqqiKapCcjIhGb0r4WWlHaXgvwIB708YxlXCPQEzt1zZN1Eg6lHo8COr5su+PJFMPT79Qh+L/4hFJPcoiiFKXnxydCepD/3H8QZMo+cD/4kF2jPQlT/Pw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42, REQID:706c3e78-f018-4bf1-b77c-a5c790a8d8d8, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0fcdc3, CLOUDID:177a63e7-cb6b-4a59-bfa3-98f245b4912e,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
 RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
 SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bcb0a010982111efbd192953cf12861f-20241101
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1797081364; Fri, 01 Nov 2024 15:20:13 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Nov 2024 15:20:12 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Nov 2024 15:20:11 +0800
Message-ID: <cdb9a83d244a77e5ffb2a3d069607f16447b723e.camel@mediatek.com>
Subject: Re: [PATCH v2 1/3] menu: fix the logic checking whether ESC key is
 pressed
From: Weijie Gao <weijie.gao@mediatek.com>
To: Daniel Golle <daniel@makrotopia.org>
CC: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, "John
 Crispin" <john@phrozen.org>, Simon Glass <sjg@chromium.org>
Date: Fri, 1 Nov 2024 15:20:11 +0800
In-Reply-To: <ZyPXqwcbREjnPc-1@pidgin.makrotopia.org>
References: <e6909b36be18c73f378c9e011112ee10b9299194.1730194901.git.weijie.gao@mediatek.com>
 <ZyPXqwcbREjnPc-1@pidgin.makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK: N
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

Hi Daniel,

On Thu, 2024-10-31 at 19:16 +0000, Daniel Golle wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> On Tue, Oct 29, 2024 at 05:47:10PM +0800, Weijie Gao wrote:
> > It's observed that the bootmenu on a serial console sometimes
> > incorrectly quitted with superfluous characters filled to command
> > line input:
> > 
> > >  *** U-Boot Boot Menu ***
> > > 
> > >      1. Startup system (Default)
> > >      2. Upgrade firmware
> > >      3. Upgrade ATF BL2
> > >      4. Upgrade ATF FIP
> > >      5. Load image
> > >      0. U-Boot console
> > > 
> > > 
> > >  Press UP/DOWN to move, ENTER to select, ESC to quit
> > > MT7988> [B
> > 
> > Analysis shows it was caused by the wrong logic of bootmenu_loop:
> > 
> > At first the bootmenu_loop received the first ESC char correctly.
> > 
> > However, during the second call to bootmenu_loop, there's no data
> > in the UART Rx FIFO. Due to the low baudrate, the second char of
> > the down array key sequence hasn't be fully received.
> > 
> > But bootmenu_loop just did a mdelay(10), and then treated it as a
> > single ESC key press event. It didn't even try tstc() again after
> > the 10ms timeout.
> > 
> > This patch fixes this issue by letting bootmenu_loop check tstc()
> > twice.
> > 
> > Tested-By: E Shattow <lucent@gmail.com>
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> 
> Reviewed-by: Daniel Golle <daniel@makrotopia.org>
> Tested-by: Daniel Golle <daniel@makrotopia.org>
> 
> Together with 2/3 and 3/3 this now avoids dropping into the U-Boot
> shell
> as long as the menu is short enough. In case of menus with 8 entries
> of
> more I still manage to drop into shell when holding the arrow down
> key
> before the last item has been reached.
> That being said, it's already a very big improvement that this now
> only
> happens when holding down a button traversing over a menu with a high
> number of items.

I didn't encounter with this.
Did you try enabling CONFIG_SERIAL_RX_BUFFER?

> 
> 
> > ---
> >  common/menu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/common/menu.c b/common/menu.c
> > index 8cc9bf06d9c..48ab7f0f398 100644
> > --- a/common/menu.c
> > +++ b/common/menu.c
> > @@ -525,14 +525,15 @@ enum bootmenu_key bootmenu_loop(struct
> > bootmenu_data *menu,
> >                               struct cli_ch_state *cch)
> >  {
> >       enum bootmenu_key key;
> > -     int c;
> > +     int c, errchar = 0;
> > 
> >       c = cli_ch_process(cch, 0);
> >       if (!c) {
> >               while (!c && !tstc()) {
> >                       schedule();
> >                       mdelay(10);
> > -                     c = cli_ch_process(cch, -ETIMEDOUT);
> > +                     c = cli_ch_process(cch, errchar);
> > +                     errchar = -ETIMEDOUT;
> >               }
> >               if (!c) {
> >                       c = getchar();
> > --
> > 2.45.2
> > 

