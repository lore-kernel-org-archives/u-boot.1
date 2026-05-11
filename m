Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40F94CD3427
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 02:13:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98601846C6;
	Mon, 11 May 2026 04:13:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="cEA7eooS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 206DB846CB; Mon, 11 May 2026 04:13:12 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F73E846C3
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 04:13:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f0c669984cde11f1a4e839cc21f16abe-20260511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=x8z4Da1P3y9GqyxEXaKq7nXeaVounjmTdlJJsIavmgQ=; 
 b=cEA7eooSN7+LnTef7rTyZQBf1xHhEpQpkag4/vkzT/LcZe2XGFIOyCNC36HQGAAIxQ4im4uhqiK9dXkmXiy7ELpLLt+SNGDxYjzs8pI2EJfqmDy2ePU0CXnDkljVilfaUf8W285onbGCkMr+/94fPhWbaThK4Tj99MD6e3599Os=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:b732f928-8b74-499e-97c6-23dad08db686, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:ac7e6545-8360-4d24-8500-9b9380fa4b0d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f0c669984cde11f1a4e839cc21f16abe-20260511
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1994378110; Mon, 11 May 2026 10:13:03 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 11 May 2026 10:13:01 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 11 May 2026 10:13:01 +0800
Message-ID: <98a82a4dfb6174fdfa6e538729f96461816e8ef1.camel@mediatek.com>
Subject: Re: [PATCH v3 07/10] cmd: ubi: export more APIs to public
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Mon, 11 May 2026 10:13:01 +0800
In-Reply-To: <CAFLszTjNBo_jgqv9wmceu=qeYNUrvXczM2Dft6DdMxDdJrhU-A@mail.gmail.com>
References: <cover.1777272283.git.weijie.gao@mediatek.com>
 <cb7f6ba95951ed3437b6f0cc85179cf4b78f2a97.1777272283.git.weijie.gao@mediatek.com>
 <CAFLszTjNBo_jgqv9wmceu=qeYNUrvXczM2Dft6DdMxDdJrhU-A@mail.gmail.com>
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
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > cmd/ubi.c           | 10 +++++-----
> >  include/ubi_uboot.h |  5 +++++
> >  2 files changed, 10 insertions(+), 5 deletions(-)
> > diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> > @@ -47,10 +47,15 @@
> >  int ubi_mtd_param_parse(const char *val, struct kernel_param *kp);
> >  int ubi_init(void);
> >  void ubi_exit(void);
> > +int ubi_detach(void);
> >  int ubi_part(const char *part_name, const char
> > *vid_header_offset);
> >  int ubi_volume_write(const char *volume, const void *buf, loff_t
> > offset,
> >                    size_t size);
> >  int ubi_volume_read(const char *volume, void *buf, loff_t offset,
> > size_t size);
> > +int ubi_create_vol(const char *volume, int64_t size, bool dynamic,
> > int vol_id,
> > +                bool skipcheck);
> > +struct ubi_volume *ubi_find_volume(const char *volume);
> > +int ubi_remove_vol(const char *volume);
> 
> Please squash patch 9 (the kernel-doc comments) into this one.
> Exporting an API and documenting it belong in the same change -
> otherwise reviewers cannot judge the function contract from this
> patch
> alone.
> 
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -270,7 +270,7 @@ static struct ubi_volume
> > *ubi_require_volume(const char *volume)
> >       return vol;
> >  }
> > 
> > -static int ubi_remove_vol(const char *volume)
> > +int ubi_remove_vol(const char *volume)
> >  {
> >       int err, reserved_pebs, i;
> >       struct ubi_volume *vol;
> 
> Hmm, now that this is public, the mixed return convention is a bit
> awkward: ubi_remove_vol() returns positive ENODEV/EROFS in some paths
> and negative values from ubi_change_vtbl_record()/ubi_eba_unmap_leb()
> in others. ubi_create_vol() has the same issue. Worth a follow-up so
> external callers get a consistent convention - ideally negative errno

Using uniformed negative return value is apparently better.
Patch 9 will also benefit from this: we can safely say returning -ve on
error.

The ubi layer does return negative value in all paths already. I plan
to change all return value in ubi.c to negative in all functions and
return 1 (CMD_RET_FAILURE) for the command handler. 

> 
> Reviewed-by: Simon Glass <sjg@chromium.org>

