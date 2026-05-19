Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4884CD4851
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 09:07:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA75E843B6;
	Tue, 19 May 2026 11:07:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="T2RsCq+5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 066808460E; Tue, 19 May 2026 11:07:44 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93D5884119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 11:07:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 2be1743a536211f1b5a00d44d12bea5a-20260519
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=WKL2JDoC10fT3HrtDbZKhUh7hgGoKCenrdRIZRphPfg=; 
 b=T2RsCq+5B+p8LeTHp/kIGDGVQUC6G85Z2cuuRr/a/pyLDkcdgkIVLmvwEQzQiD69kd8Sflm04sz07d8IJmRSeTE6LGROvkiwEuLPzLnTUWwULKUwHmd0O7cT30YH0VIrYSIszWuZq9tuZ7N7ZBE9In72uTNfI6fZf1Q4bN+7Xtc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:2f448aa6-8786-4859-99f2-911092bb931a, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:9091e75, CLOUDID:d433f71e-023f-4f87-9e9c-6c116c694fb3,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2be1743a536211f1b5a00d44d12bea5a-20260519
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 833130473; Tue, 19 May 2026 17:07:33 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 19 May 2026 17:07:32 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 19 May 2026 17:07:31 +0800
Message-ID: <dac07916a1fe83753912f2a4d3c63e85ddeabdfc.camel@mediatek.com>
Subject: Re: [PATCH v4 08/10] cmd: ubi: export more APIs to public
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Tue, 19 May 2026 17:07:31 +0800
In-Reply-To: <CAFLszTi8ii_CM7HQQw_rjON6izUzQ89dt4xhXSD7EceU1O+n7A@mail.gmail.com>
References: <cover.1778657347.git.weijie.gao@mediatek.com>
 <84adac247cd407e093dd7455138fbd794e91d933.1778657347.git.weijie.gao@mediatek.com>
 <CAFLszTi8ii_CM7HQQw_rjON6izUzQ89dt4xhXSD7EceU1O+n7A@mail.gmail.com>
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

On Fri, 2026-05-15 at 06:58 -0600, Simon Glass wrote:
> Hi Weijie,
> 
> On 2026-05-13T08:02:45, Weijie Gao <weijie.gao@mediatek.com> wrote:
> > cmd: ubi: export more APIs to public
> > 
> > Export the following functions to public:
> > 
> > - ubi_detach(): this is paired with ubi_part(). One may call this
> > function
> >   to completely clean up the ubi subsystem after using ubi_part().
> > 
> > - ubi_{create,find,remove}_vol: this is a set of functions for
> > volume
> >   management.
> > 
> > The original ubi_create_vol is renamed to __ubi_create_vol to allow
> > the new
> > ubi_create_vol() being used as a wrapper for __ubi_create_vol()
> > with volume
> > name.
> > 
> > Also, comments are added for all exported functions.
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > cmd/ubi.c           | 23 ++++++++++----
> >  include/ubi_uboot.h | 91
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 108 insertions(+), 6 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -213,8 +213,8 @@ bad:
> >       return err;
> >  }
> > 
> > -static int ubi_create_vol(const char *volume, int64_t size, bool
> > dynamic,
> > -                       int vol_id, bool skipcheck)
> > +int ubi_create_vol(const char *volume, int64_t size, bool dynamic,
> > int vol_id,
> > +                bool skipcheck)
> 
> The commit message is now out of date - it says ubi_create_vol() is
> renamed to __ubi_create_vol() and wrapped.

This is my mistake. They should be ubi_remove_vol()/__ubi_remove_vol()

> 
> > diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> > @@ -47,11 +47,102 @@
> > + * ubi_part() - attach UBI to MTD partition
> > + * @part_name: name of the MTD partition to attach
> > + * @vid_header_offset: VID header offset (string)
> > + *
> > + * This function detaches any existing UBI device, then probes for
> > the
> > + * specified MTD partition, and then scans it to initialize UBI.
> > + *
> > + * @vid_header_offset is optional and is usually set to NULL.
> > + *
> > + * Return: 0 on success, 1 if partition not found, or -ve on
> > error.
> > + */
> >  int ubi_part(const char *part_name, const char
> > *vid_header_offset);
> 
> Just to check, where does the '1 if partition not found' come from?
> My
> reading of ubi_dev_scan() / do_ubi() is that a missing partition
> surfaces as a negative errno. If there is no path that returns +1,
> please drop that clause.

Before changing all return value to negative, this function does return
1 after printing "Error, no volume name passed". Now this value is
changed to -ENODEV. I'll update this.

> 
> Regards,
> Simon

