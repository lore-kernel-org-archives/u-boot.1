Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F634D1358B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 00:26:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C231288C66;
	Mon, 28 Oct 2024 01:26:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="T2QfkxAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BFA9188E31; Mon, 28 Oct 2024 01:26:13 +0100 (CET)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39BF888744
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 01:26:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 3214670e94c311efb88477ffae1fc7a5-20241028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=oMbS/EH00dJAoXKyX2UPkmgTdGa+G0gw0C2YAbMXySQ=; 
 b=T2QfkxAiOvo2a4XT3XufguAj4zUBHHsO3GZL1mHmO+OhyAWxVDt4m2ri+o1hs3N3jatGpjNsdJ3JdiMTC9PJU7GcIgMk0whbIxI9aqN+pg9RQOVkuRkfd0Bet1BjmReKkM+sZ0/7rtYBxNPXsH8JO3+v2KgfbCBzaG2ftTqhL98=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42, REQID:6001a975-b80b-49d2-ae21-eda2caf82509, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:b0fcdc3, CLOUDID:e5a4f0cc-110e-4f79-849e-58237df93e70,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|-5,EDM:-3,IP:ni
 l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
 :1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 3214670e94c311efb88477ffae1fc7a5-20241028
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1045997676; Mon, 28 Oct 2024 08:25:55 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 28 Oct 2024 08:25:53 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 28 Oct 2024 08:25:52 +0800
Message-ID: <37e445c29de0c1ef020d56a7d4da2916d692545b.camel@mediatek.com>
Subject: Re: [PATCH] menu: fix the logic checking whether ESC key is pressed
From: Weijie Gao <weijie.gao@mediatek.com>
To: Daniel Golle <daniel@makrotopia.org>
CC: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>, "John
 Crispin" <john@phrozen.org>
Date: Mon, 28 Oct 2024 08:25:52 +0800
In-Reply-To: <Zx1Bpb7_9TEqBeyB@pidgin.makrotopia.org>
References: <20241021005642.153511-1-weijie.gao@mediatek.com>
 <Zx1Bpb7_9TEqBeyB@pidgin.makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--17.249300-8.000000
X-TMASE-MatchedRID: 1GZI+iG+MtcOwH4pD14DsPHkpkyUphL9meN8m2FdGic3xO2R3boBWFbu
 qIY+/skQkABPgKBt/0rgeVsWtxJp0WPkhAGNSaN3mlaAItiONP3g8xL52+Q822Gf9yHLcNDMbJj
 pMBHuF/QRJCbXaYp1fqnUWePIzN8a9QpB8/MBSuNLLfjo9MtJbH4rryovYbmmNpQs7YDMMqCsqn
 EkU6FrjAEDWLTBQkhts7S5DIVWf2brISsbLnWmvOE86+k9uTZHXru95hSuhjT+TXZJvYxoed/LI
 yZs19Oqjqso2umFZbaZ4TZMmYnlr3OAMSqhBqB6u7cJpvn2W2LV9PSyputFJx//bz4/xYKAVJJX
 8FgSLdXi8zVgXoAltkWL4rBlm20vjaPj0W1qn0SQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.249300-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP: D89AA8626CA05EE938C3EC67FAA7C06B1408AE0D1C5B4FB3FC39A3C1F6B7E60A2000:8
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

On Sat, 2024-10-26 at 20:23 +0100, Daniel Golle wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Hi!
> 
> On Mon, Oct 21, 2024 at 08:56:42AM +0800, Weijie Gao wrote:
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
> 
> The patch helps to fix the problem when dealing with single key
> presses. However, apparently this is not enough to fix the issue in
> all situations. I still manage to drop into U-Boot console with an
> extra '[A' when simply holding down the arrow-up key for a while.
> 

Holding down the arrow-up key for a while can cause the PC to send
large amounts of data to the UART Rx FIFO. Since filogic UARTs usually
have only 32 bytes FIFO, it's very easy to cause Rx FIFO overflow,
and then you'll still be dropped into U-Boot console due to data loss. 
I've already confirmed this during solving this issue and this can only
be solved by increasing the baudrate.


