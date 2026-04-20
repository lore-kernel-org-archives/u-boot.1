Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F700F36C39
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 07:25:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63FFD84181;
	Mon, 20 Apr 2026 09:25:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="dmwxSkV6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F10DE84198; Mon, 20 Apr 2026 09:25:32 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39F16840D8
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 127078963c8a11f19a16598d5ca7f8ec-20260420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=WYvpR1loXY2DcU+xA3u3q9xaQyz00G3T3FuuS4oGVag=; 
 b=dmwxSkV6pmiLDOrQHyl2L0idUo2r7PJrYyvPv5ZEi0iNuS51mzBTJh+wQ9Fw+KywNJGBR2D4WUZzWW3dHwo8h7c+PE4LQHkiwxpdcf5iNsw/VKtvOWPtva5me8+9tS4TgqTlv1zlH6DXmb1CS3f3i/pG8gEhDTO3FyCf3K/QI3w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:5e55d03d-9187-496a-805f-b1e1b4530e7b, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:c5189f8f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 127078963c8a11f19a16598d5ca7f8ec-20260420
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1989494496; Mon, 20 Apr 2026 15:25:13 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 20 Apr 2026 15:25:12 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 20 Apr 2026 15:25:12 +0800
Message-ID: <1219110f4621405d5312a7376d35d1bc6638618f.camel@mediatek.com>
Subject: Re: [PATCH 2/3] cmd: ubi: allow creating volume with all free
 spaces in ubi_create_vol
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Mon, 20 Apr 2026 15:25:12 +0800
In-Reply-To: <CAFLszThHeX97x6Ebc_7TZiRs3ez2MC05Kf0ir+yo9=09NHThHg@mail.gmail.com>
References: <cover.1776392312.git.weijie.gao@mediatek.com>
 <17d1fc9a1ecdd0a5d54907b8816ef62793387a42.1776392312.git.weijie.gao@mediatek.com>
 <CAFLszThHeX97x6Ebc_7TZiRs3ez2MC05Kf0ir+yo9=09NHThHg@mail.gmail.com>
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

On Sat, 2026-04-18 at 12:47 +1200, Simon Glass wrote:
> Hi Weijie,
> 
> On 2026-04-17T02:35:14, Weijie Gao <weijie.gao@mediatek.com> wrote:
> > cmd: ubi: allow creating volume with all free spaces in
> > ubi_create_vol
> > 
> > Although the ubi command itself supports creating volume with all
> > free spaces, the api ubi_create_vol() does not.
> > 
> > Since negative size in invalid, this patch replaces negative size
> 
> is invalid
> 
> > with all free space size in ubi_create_vol().
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > cmd/ubi.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -226,7 +226,11 @@ int ubi_create_vol(char *volume, int64_t size,
> > int dynamic, int vol_id,
> > +     if (size < 0)
> > +             req.bytes = ubi->avail_pebs * ubi->leb_size;
> > +     else
> > +             req.bytes = size;
> 
> When size is negative, the printf() below still prints the original
> negative size rather than the computed req.bytes

OK. As you mentioned in patch 3/3, I think maybe we can move these
printf logs to the command's main function to avoid logs being printed
every time these API functions are called.

> 
> Regards,
> Simon

