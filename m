Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13CCBD13588
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 02:58:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6575A8895E;
	Mon, 28 Oct 2024 03:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="hjS9ScuS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42A9C87BF4; Mon, 28 Oct 2024 03:58:21 +0100 (CET)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9DBD88C53
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 03:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 74efb4c494d811efbd192953cf12861f-20241028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=EwYNu9mVZfGRtY+H37VECl/E2HmLc0HVinGoir3iaL0=; 
 b=hjS9ScuSiIlvsnfHVIXW/5EMZnmdMD1W4+8itShZH+zaWLSzn6UmRPlYkBs8x988Dlm4JKfqdvAMyoQ6qkYWoLWbe4TL3rrRxTG1QBvuSGJvNYvpSH9SgAhVVI4GOACpIzWyzitj1MBacONT+LSbD86Mc4H9oKUcBkKejkaggDc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42, REQID:d58514ca-fe34-407d-9062-108b410dffe6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0fcdc3, CLOUDID:8d5d322e-a7a0-4b06-8464-80be82133975,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 74efb4c494d811efbd192953cf12861f-20241028
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1857443754; Mon, 28 Oct 2024 10:58:06 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Oct 2024 10:58:05 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 28 Oct 2024 10:58:04 +0800
Message-ID: <6db33dd28da63dabc198788f28bfa00425d7f62e.camel@mediatek.com>
Subject: Re: [PATCH] menu: fix the logic checking whether ESC key is pressed
From: Weijie Gao <weijie.gao@mediatek.com>
To: Marek Vasut <marek.vasut@mailbox.org>, Daniel Golle <daniel@makrotopia.org>
CC: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, "John
 Crispin" <john@phrozen.org>
Date: Mon, 28 Oct 2024 10:58:04 +0800
In-Reply-To: <d00691ed-815e-4db9-b5d7-b09c32ead593@mailbox.org>
References: <20241021005642.153511-1-weijie.gao@mediatek.com>
 <Zx1Bpb7_9TEqBeyB@pidgin.makrotopia.org>
 <37e445c29de0c1ef020d56a7d4da2916d692545b.camel@mediatek.com>
 <d00691ed-815e-4db9-b5d7-b09c32ead593@mailbox.org>
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

On Mon, 2024-10-28 at 03:33 +0100, Marek Vasut wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> On 10/28/24 1:25 AM, Weijie Gao wrote:
> > Hi Daniel,
> > 
> > On Sat, 2024-10-26 at 20:23 +0100, Daniel Golle wrote:
> > > External email : Please do not click links or open attachments
> > > until
> > > you have verified the sender or the content.
> > > 
> > > 
> > > Hi!
> > > 
> > > On Mon, Oct 21, 2024 at 08:56:42AM +0800, Weijie Gao wrote:
> > > > It's observed that the bootmenu on a serial console sometimes
> > > > incorrectly quitted with superfluous characters filled to
> > > > command
> > > > line input:
> > > > 
> > > > >   *** U-Boot Boot Menu ***
> > > > > 
> > > > >       1. Startup system (Default)
> > > > >       2. Upgrade firmware
> > > > >       3. Upgrade ATF BL2
> > > > >       4. Upgrade ATF FIP
> > > > >       5. Load image
> > > > >       0. U-Boot console
> > > > > 
> > > > > 
> > > > >   Press UP/DOWN to move, ENTER to select, ESC to quit
> > > > > MT7988> [B
> > > > 
> > > > Analysis shows it was caused by the wrong logic of
> > > > bootmenu_loop:
> > > > 
> > > > At first the bootmenu_loop received the first ESC char
> > > > correctly.
> > > > 
> > > > However, during the second call to bootmenu_loop, there's no
> > > > data
> > > > in the UART Rx FIFO. Due to the low baudrate, the second char
> > > > of
> > > > the down array key sequence hasn't be fully received.
> > > > 
> > > > But bootmenu_loop just did a mdelay(10), and then treated it as
> > > > a
> > > > single ESC key press event. It didn't even try tstc() again
> > > > after
> > > > the 10ms timeout.
> > > > 
> > > > This patch fixes this issue by letting bootmenu_loop check
> > > > tstc()
> > > > twice.
> > > 
> > > The patch helps to fix the problem when dealing with single key
> > > presses. However, apparently this is not enough to fix the issue
> > > in
> > > all situations. I still manage to drop into U-Boot console with
> > > an
> > > extra '[A' when simply holding down the arrow-up key for a while.
> > > 
> > 
> > Holding down the arrow-up key for a while can cause the PC to send
> > large amounts of data to the UART Rx FIFO. Since filogic UARTs
> > usually
> > have only 32 bytes FIFO, it's very easy to cause Rx FIFO overflow,
> > and then you'll still be dropped into U-Boot console due to data
> > loss.
> > I've already confirmed this during solving this issue and this can
> > only
> > be solved by increasing the baudrate.
> 
> Does CONFIG_SERIAL_RX_BUFFER help with those overflows ?

CONFIG_SERIAL_RX_BUFFER can't fully elimate the overflow. I can still
reproduce this issue by holding down the arrow-up key for more than
15 seconds.

