Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30BE7CD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:13:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92B53843B6;
	Tue, 19 May 2026 11:13:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="BPHXGMJm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8939B84676; Tue, 19 May 2026 11:13:31 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C868B84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:13:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f9cdc4a2536211f1a3561939bc42ff46-20260519
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=TeNNH0zjbtST/8XunezjO9uJbDCgBDT6DJ3osHimnxs=; 
 b=BPHXGMJm0Bx1o21Pl1BbWQytTaNS6yHyvbuHiVLWH/Fv+uZVERWI0m1HRRtndaQrlFKphqzygXE1UpX2Wg2RAoKL3UtRjv+dUJw5dQI8q4u/23elLRIsSroQtXm2x6jCG0oI1Gv5kNfzFg4Qrg9baJDsAiPGUWErS6PpVanv+wA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:e4bd4e25-7476-4790-b80a-fcb56d5f101f, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:9091e75, CLOUDID:5d4bf71e-023f-4f87-9e9c-6c116c694fb3,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f9cdc4a2536211f1a3561939bc42ff46-20260519
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1014551898; Tue, 19 May 2026 17:13:18 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 19 May 2026 17:13:17 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 19 May 2026 17:13:17 +0800
Message-ID: <5fde328bddbcd7a5666cc796532ad19c31a791fa.camel@mediatek.com>
Subject: Re: [PATCH v4 10/10] env: ubi: add support to create environment
 volume if it does not exist
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Tue, 19 May 2026 17:13:16 +0800
In-Reply-To: <CAFLszTj2akYxyTix3gLCgNo1b0ee7-mMnMvDxV+tPwtAQ3Uxhg@mail.gmail.com>
References: <cover.1778657347.git.weijie.gao@mediatek.com>
 <4139e7bef0bb12225a18e3b205dd66b77d8ce543.1778657347.git.weijie.gao@mediatek.com>
 <CAFLszTj2akYxyTix3gLCgNo1b0ee7-mMnMvDxV+tPwtAQ3Uxhg@mail.gmail.com>
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

On Fri, 2026-05-15 at 06:59 -0600, Simon Glass wrote:
> Hi Weijie,
> 
> On 2026-05-13T08:02:45, Weijie Gao <weijie.gao@mediatek.com> wrote:
> > env: ubi: add support to create environment volume if it does not
> > exist
> > 
> > When U-Boot is booting from a fresh device, the environment volume
> > may not
> > exist in the factory UBI image. This is a common case where factory
> > UBI
> > image contains only volumes with valid data.
> > 
> > With the current design, even if the volume is created manually,
> > the
> > environment will still be unusable (e.g., saveenv) before a reboot.
> > 
> > This patch adds support to automatically create missing volumes
> > before
> > loading environment. This will make environment available at first
> > boot.
> > 
> > There are two options:
> > CONFIG_ENV_UBI_VOLUME_CREATE: whether to enable volume creation
> > CONFIG_ENV_UBI_VOLUME_STATIC: create static volume (default is
> > dynamic)
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > env/Kconfig | 20 +++++++++++++++++++
> >  env/ubi.c   | 65
> > ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
> >  2 files changed, 74 insertions(+), 11 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> > diff --git a/env/Kconfig b/env/Kconfig
> > @@ -716,6 +716,26 @@ config ENV_UBI_VOLUME_REDUND
> > +config ENV_UBI_VOLUME_CREATE
> > +     bool "Create UBI volume if it does not exist"
> > +     depends on ENV_IS_IN_UBI
> > +     help
> > +       This option is useful if U-Boot will be booted from a fresh
> > device
> > +       where the environment volume has not been created.
> > +       This is a common case where factory UBI image contains only
> > volumes
> > +       with valid data.
> > +       By enabling this option, any missing environment volumes
> > will be
> > +       created before loading.
> > +       If CONFIG_ENV_UBI_VOLUME_REDUND is also enabled, both
> > volumes will be
> > +       created,
> 
> Trailing comma should be a full stop. Also drop the CONFIG_ prefix -
> the Kconfig convention is to refer to the symbol as
> ENV_UBI_VOLUME_REDUND.

I'll fix this.

> 
> Regards,
> Simon

