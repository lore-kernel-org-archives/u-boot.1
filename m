Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26EBCD8CAD
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 01:05:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 514CB848D8;
	Wed, 10 Jun 2026 03:05:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="OvhRz8mJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CBD284911; Wed, 10 Jun 2026 03:05:51 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7976848D7
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 03:05:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 808c0b96646811f1b1788b6acf885367-20260610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=954KZeTYRBFx88lN5Z8udogegy992116ZN6G+YTb4DM=; 
 b=OvhRz8mJ7FbRgJyypd9ZWp1HWOBCv6s+O90N4In3hWT1VzyybpqemT7C+AuKuGxZouHruqkbIx4X69WzbhhK4cdO0iV18uyip5ySMwK/c2C7wjQvNTJNXbSY52s/1R/XqhQ82w1HRoV+9ISy7yhBGSIuadrwZ4f3V4MfneTnJ8I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.15, REQID:bb8bdf40-9840-4d32-af51-b32370ca7a58, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e276073, CLOUDID:301c832a-13d2-4d29-83ea-b8014339a000,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|136|836|865|888|898,
 TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:99|1,File:130,RT:0,Bulk:nil,QS:nil
 ,BEC:-1,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 808c0b96646811f1b1788b6acf885367-20260610
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2036634063; Wed, 10 Jun 2026 09:05:42 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 10 Jun 2026 09:05:40 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Wed, 10 Jun 2026 09:05:40 +0800
Message-ID: <ccec2dffffeecfc4597f100ba41ea002ba2bbe62.camel@mediatek.com>
Subject: Re: [PATCH] arm: mediatek: mt7988: restore full DRAM bank reporting
From: Weijie Gao <weijie.gao@mediatek.com>
To: David Lechner <dlechner@baylibre.com>, <rmandrad@gmail.com>
CC: <u-boot@lists.denx.de>, <trini@konsulko.com>, <ryder.lee@mediatek.com>,
 <chunfeng.yun@mediatek.com>, <igor.belwon@mentallysanemainliners.org>,
 <jstephan@baylibre.com>, <GSS_MTK_Uboot_upstream@mediatek.com>,
 <emanuele.ghidoli@toradex.com>
Date: Wed, 10 Jun 2026 09:05:39 +0800
In-Reply-To: <CAMknhBFHpn3ZQSdvNABfSqumk8PqUU6BBxSErN8fpaQ=HT29Kg@mail.gmail.com>
References: <20260602162233.2418471-1-rmandrad@gmail.com>
 <CAMknhBFeV8qio29t1zNhoBNdumbWh2ErOE99dQEphDKZN8GodQ@mail.gmail.com>
 <003e01dcf4ec$6a507830$3ef16890$@gmail.com>
 <CAMknhBFPN8rk35ijCQK8ACM=joV-tXuX1m6sYCVEFPYegMjXxA@mail.gmail.com>
 <CAMknhBGng1iVxs7+5cWPaAyjOxBs8Dbzp3fuHhHWHbi3eJs3fw@mail.gmail.com>
 <000a01dcf4fb$3ba10810$b2e31830$@gmail.com>
 <CAMknhBFHpn3ZQSdvNABfSqumk8PqUU6BBxSErN8fpaQ=HT29Kg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Fri, 2026-06-05 at 17:00 +0200, David Lechner wrote:
> > On Fri, Jun 5, 2026 at 4:30 PM David Lechner <dlechner@baylibre.com
> > > wrote:
> > > 
> > > On Fri, Jun 5, 2026 at 3:07 PM <rmandrad@gmail.com> wrote:
> > > > > On Tue, Jun 2, 2026 at 6:24 PM Rudy Andram <
> > > > > rmandrad@gmail.com> wrote:
> > > > > > 
> > > > > > MT7988 detects the full installed DRAM in dram_init(), but
> > > > > > after
> > > > > > commit bddd6bbef3dc ("arm: mediatek: mt7988: drop
> > > > > > dram_init_banksize()") it fell back to the generic
> > > > > > dram_init_banksize() implementation.
> > > > > > 
> > > > > > That generic path populates bd->bi_dram[0].size with
> > > > > > get_effective_memsize(), which is capped by
> > > > > > CFG_MAX_MEM_MAPPED.
> > > > > > On
> > > > > > MT7988 this limits the exported DRAM bank to 3 GiB even
> > > > > > when 8
> > > > > > GiB is installed.
> > > > > 
> > > > > Can we just remove the #define CFG_MAX_MEM_MAPPED (and the
> > > > > header file that contains it)? Or is it used somewhere else?
> > > > > 
> > > > 
> > > > Not the header file as   TARGET_MT7988 sets
> > > > SYS_CONFIG_NAME="mt7988" in arch/arm/mach-mediatek/Kconfig
> > > 
> > > We could drop that config too since the header will be empty.
> > > 
> > > > 
> > > > In the mt7988 I don't see CFG_MAX_MEM_MAPPED used elsewhere
> > > > than
> > > > just in common/memsize.c where it limits
> > > > get_effective_memsize()
> > > > 
> > > > Unsetting/removing CFG_MAX_MEM_MAPPED would take u-boot above
> > > > 4gb...
> > > > Some MediaTek ARM64 ports may keep U-Boot below 4 GiB because
> > > > peripherals such as MMC need DMA buffers below 4 GiB ... so, it
> > > > may
> > > > work on my setup but not others. Also, not an expert on u-
> > > > boot  I
> > > > would suggest for others to comment/review
> > > > 
> > > 
> > > What I've done on the other MediaTek platforms for now is add
> > > this to
> > > init.c to take care of the 4GB DMA limit.
> > > 
> > > phys_size_t get_effective_memsize(void) {
> > >        /*
> > >         * Limit gd->ram_top not exceeding SZ_4G. Because some
> > > peripherals like
> > >         * MMC requires DMA buffer allocated below SZ_4G.
> > >         */
> > >         return min(SZ_4G - gd->ram_base, gd->ram_size); }
> > 
> > Meh... I've just realized that this probably doesn't fix the issue
> > as it does basically the same thing as CFG_MAX_MEM_MAPPED. I will
> > have to come back to this next week when I have more time.
> > 
> > > 
> > > There has been some ongoing discussion of a better way to handle
> > > this
> > > in general though, the last few weeks. I need to check the
> > > mailing
> > > list to see if any progress was made since then.
> > > 
> > > If there isn't something yet, I would still propose to drop
> > > CFG_MAX_MEM_MAPPED and add this function so that everything is
> > > the
> > > same.
> 
> 
> 
> On Fri, Jun 5, 2026 at 4:53 PM <rmandrad@gmail.com> wrote:
> > 
> > Was just about to reply on that... happy to drop this patch and let
> > you work on a solution just thought to report my findings but would
> > suggest in the meantime to revert
> > bddd6bbef3dc ("arm: mediatek: mt7988: drop dram_init_banksize()")
> 
> I just saw [1] that has a new config option to address the DMA
> address
> limit and [2] that renames the config option. [1] has already been
> applied to master, so perhaps we could still drop CFG_MAX_MEM_MAPPED
> and use this new option instead? Otherwise, yes, I will consider the
> revert.

The NETSYS DMA of all filogic platform chips can only use DRAM below
4GiB and that's why we added CFG_MAX_MEM_MAPPED to limit the usable
memory in U-Boot.

> 
> [1]: 
> https://lore.kernel.org/u-boot/20260603141814.12672-1-marek.vasut+renesas@mailbox.org/
>  
> [2]: 
> https://lore.kernel.org/u-boot/20260604173330.8586-1-marek.vasut+renesas@mailbox.org/
>  

