Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F378CCD37AC
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 03:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A98E8341A;
	Tue, 12 May 2026 05:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="pWhyhWFO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56AA783DBF; Tue, 12 May 2026 05:54:39 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C73BD83015
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 05:54:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 41b502b04db611f1b96f91537e34a508-20260512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=kpbVjd1RGy06dUQXnOBExkA87EvMmSrEedZ6lJq7A88=; 
 b=pWhyhWFO0vokoF32SsKGIn1Xt1Mmabj00sGpzGn2n/ypEMey2JlYNUgSpW4zBCkDFo3b2+kG+ZHTm59RsPNHXtSoZgbKKI/AXDeC9PdnZLQf80BpcGGXSOt2Aq+TuS5YdtJY1XaOMFiWA0YyjLrYDrU/9Ne3EipTz7qRgBdyDKA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:82fa3c1c-d972-4ed0-808c-5d5093a55d88, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:66444d71-3b7f-4b26-b2f9-40f0deecb36d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 41b502b04db611f1b96f91537e34a508-20260512
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 117313224; Tue, 12 May 2026 11:54:20 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 12 May 2026 11:54:20 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 12 May 2026 11:54:20 +0800
Message-ID: <38927d5e49677c9147c9edc9100d3c4ff26bb523.camel@mediatek.com>
Subject: Re: [PATCH v3 10/10] env: ubi: add support to create environment
 volume if it does not exist
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Tue, 12 May 2026 11:54:19 +0800
In-Reply-To: <CAFLszTgnQuEN3m8yyC_upE=tucO93O4Lb9SwMmBzqAxE9TuDQA@mail.gmail.com>
References: <cover.1777272283.git.weijie.gao@mediatek.com>
 <d7ec0e5d655f8c2f1d159908f74d00927d7a0776.1777272283.git.weijie.gao@mediatek.com>
 <CAFLszTgnQuEN3m8yyC_upE=tucO93O4Lb9SwMmBzqAxE9TuDQA@mail.gmail.com>
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

On Tue, 2026-04-28 at 08:11 -0600, Simon Glass wrote:
> Hi Weijie,
> 
> On 2026-04-27T07:09:11, Weijie Gao <weijie.gao@mediatek.com> wrote:
> > env: ubi: add support to create environment volume if it does not
> > exist
> > 
> > Add an option to allow environment volume being auto created if not
> > exist.
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > env/Kconfig | 11 +++++++++++
> >  env/ubi.c   | 35 ++++++++++++++++++++++++++++++++++-
> >  2 files changed, 45 insertions(+), 1 deletion(-)
> > diff --git a/env/Kconfig b/env/Kconfig
> > @@ -699,6 +699,17 @@ config ENV_UBI_VOLUME_REDUND
> > +config ENV_UBI_VOLUME_CREATE
> > +     bool "Create UBI volume if not exist"
> > +     depends on ENV_IS_IN_UBI
> > +     help
> > +       This option is useful if u-boot will be booted from a fresh
> > device
> > +       where environment volume hasn't been created in the UBI
> > partition.
> > +       This is a common case where factory UBI image contains only
> > volumes
> > +       with valid data.
> > +       By enabling this option, environment volume(s) will be
> > created before
> > +       loading if not exist.
> 
> Please use 'U-Boot' rather than 'u-boot' and tidy the grammar (e.g.
> 'if it does not exist', 'where the environment volume has not been
> created', 'any missing environment volumes will be created before
> loading'). Also mention that with CONFIG_ENV_REDUNDANT both volumes
> are created.

OK.

> 
> > diff --git a/env/ubi.c b/env/ubi.c
> > @@ -134,6 +151,15 @@ static int env_ubi_load(void)
> > +     if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
> > +             create1_fail =
> > env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME);
> > +             create2_fail =
> > env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME_REDUND);
> > +             if (create1_fail && create2_fail) {
> > +                     env_set_default(NULL, 0);
> > +                     return -ENODEV;
> > +             }
> > +     }
> 
> Just to clarify the intent: if only one creation fails, this falls
> through and the subsequent ubi_volume_read() prints 'Unable to read
> redundant env from ...' which is confusing on a fresh device. Clearer
> to fail (or print a dedicated message) as soon as either creation
> fails - what do you think?

There's one case:
One volume exists and contains valid env data, and another one is
missing.
If we still failed to create the missing one (perhaps due to no space
left in UBI), we can continue to read the valid volume.

So I think it's better to add a check before reading:
if (!create1_fail) {
	read1_fail = ubi_volume_read(...);
} else {
	read1_fail = create1_fail;
}

> 
> > diff --git a/env/ubi.c b/env/ubi.c
> > @@ -105,12 +105,29 @@ static int env_ubi_save(void)
> > +     ret = ubi_create_vol(volume, CONFIG_ENV_SIZE, true,
> > UBI_VOL_NUM_AUTO,
> > +                          false);
> 
> The dynamic flag is hard-coded to true. Sensible default, but please
> mention the choice in the commit message or Kconfig help.

Ah. I remind that this is the reason I added __weak in the first patch.
One can override this function to create static volume.
I'll add another Kconfig to allow user to choose the volume type.

> 
> The commit message is quite terse - normally we like to see a
> motivation (fresh device with a factory UBI image lacking the env
> volume) - also note that for CONFIG_ENV_REDUNDANT both volumes are
> created.

OK. I'll modify it.

> 
> Regards,
> Simon

