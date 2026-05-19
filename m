Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0874FCD4F5B
	for <u-boot@archiver.kernel.org>; Tue, 19 May 2026 08:57:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9FF843B6;
	Tue, 19 May 2026 10:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="KQy8Cxoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F009E8460E; Tue, 19 May 2026 10:57:04 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E95BE84119
 for <u-boot@lists.denx.de>; Tue, 19 May 2026 10:56:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: ae0d9350536011f1b5a00d44d12bea5a-20260519
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=JslFNC6UnClCOXDCYdLf2AHxuNnW6RjgxiaSfJb5ZTw=; 
 b=KQy8CxoaFxFhPuVdqJBF2SY6drg93dR9TcxC3RNGomCvjs8TylKV7i7jfYJJYFq2PnYwUEUe0Tvzt1It8oVqyFW49Uhq7pwUVFt1U0z7K1dWggTlfN99LHC2xZWQDMjZEcJ9P6MT5pixelLvrlXD4B3HSDlByPaGqv9S1/kksqE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.14, REQID:bfb0ed58-7a76-4e03-848c-73dcd8c8dd20, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:9091e75, CLOUDID:256d1222-bef7-463f-902c-5f40f7404c33,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: ae0d9350536011f1b5a00d44d12bea5a-20260519
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 476850173; Tue, 19 May 2026 16:56:52 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 19 May 2026 16:56:52 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 19 May 2026 16:56:52 +0800
Message-ID: <0a6cf246d76577b7141f7b754e0a7b5c52cc2216.camel@mediatek.com>
Subject: Re: [PATCH v4 06/10] cmd: ubi: change all positive error return
 value to negative
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Tue, 19 May 2026 16:56:51 +0800
In-Reply-To: <CAFLszTjNQr71HkgTFf6vtc7z7VnUt-EtCx2OCgCvC=aG4mPSMg@mail.gmail.com>
References: <cover.1778657347.git.weijie.gao@mediatek.com>
 <8a1af52cc1bccfc0e98255118da9b2df0b420a9f.1778657347.git.weijie.gao@mediatek.com>
 <CAFLszTjNQr71HkgTFf6vtc7z7VnUt-EtCx2OCgCvC=aG4mPSMg@mail.gmail.com>
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

On Fri, 2026-05-15 at 06:56 -0600, Simon Glass wrote:
> Hi Weijie,
> 
> On 2026-05-13T08:02:45, Weijie Gao <weijie.gao@mediatek.com> wrote:
> > cmd: ubi: change all positive error return value to negative
> > 
> > Change all return value using errno codes to negative. This makes
> > it
> > consistent with the linux ubi layer.
> > 
> > Also, to follow the standard definition of U-Boot command, in the
> > do_ubi()
> > command handler, the return value is converted to CMD_RET_FAILURE
> > for error
> > returning, and CMD_RET_USAGE for incorrect usage.
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > cmd/ubi.c | 106 ++++++++++++++++++++++++++++++++++++---------------
> > -----------
> >  1 file changed, 62 insertions(+), 44 deletions(-)
> 
> Reviewed-by: Simon Glass <sjg@chromium.org>
> 
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -761,7 +762,7 @@ static int do_ubi(struct cmd_tbl *cmdtp, int
> > flag, int argc, char *const argv[])
> >                       return ubi_check(argv[2]);
> > 
> >               printf("Error, no volume name passed\n");
> > -             return 1;
> > +             return CMD_RET_FAILURE;
> 
> A missing argument is a usage error, not a runtime failure. Please
> use
> CMD_RET_USAGE here, and likewise for the 'Incorrect type' and 'no
> volume name passed' paths in the create handler, so the user sees the
> help text.

OK. I'll change the remaining two to CMD_RET_USAGE.

> 
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -677,7 +674,7 @@ int ubi_part(const char *part_name, const char
> > *vid_header_offset)
> >       mtd = get_mtd_device_nm(part_name);
> >       if (IS_ERR(mtd)) {
> >               printf("Partition %s not found!\n", part_name);
> > -             return 1;
> > +             return PTR_ERR(mtd);
> >       }
> 
> PTR_ERR() returns long but ubi_part() returns int. Please cast, or
> just return a specific errno like -ENODEV

Returning -ENODEV is a better choice.

> 
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -806,34 +807,46 @@ static int do_ubi(struct cmd_tbl *cmdtp, int
> > flag, int argc, char *const argv[])
> >               }
> >               /* E.g., create volume */
> >               if (argc == 3) {
> > -                     return ubi_create_vol(argv[2], size, dynamic,
> > id,
> > -                                           skipcheck);
> > +                     ret = ubi_create_vol(argv[2], size, dynamic,
> > id,
> > +                                          skipcheck);
> > +                     if (ret)
> > +                             return CMD_RET_FAILURE;
> > +                     return 0;
> >               }
> 
> This three-line conversion is repeated about seven times in do_ubi().
> Since the called functions already print their own errors, a helper
> or
> just 'return ret ? CMD_RET_FAILURE : 0;' would cut the duplication.
> What do you think?

That's OK. I'll modify them.

> 
> Regards,
> Simon

