Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB82F36C31
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 07:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 52D1783693;
	Mon, 20 Apr 2026 09:19:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="N4GiJqLD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12446839D5; Mon, 20 Apr 2026 09:19:09 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F42A805D7
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:19:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 3252a2f23c8911f19a16598d5ca7f8ec-20260420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=W6Gy10LtZV0oYL0wh/ms1059Tu/V2x9ew1HjCPcX3ms=; 
 b=N4GiJqLDbjK7HW5+hrJ0yEO47BnBT1AMdAmnhr61D3sJKtzv9p6vRGA//6sJLqbgR7Y7vMU3h7TwT2FZxMkedRAhnipC0QVV6AwQsZp51HP9py7o+u6qr5gvPL8BC16rnjUFP3EarzkhuHaaTgN5dbI80YB6XA6minKvSqfdfh4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:e896877c-fcbe-4920-a77e-8c997bf6f2cd, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:23059f8f-6df4-4a3d-a7a4-fbdc42d669ce,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3252a2f23c8911f19a16598d5ca7f8ec-20260420
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 739357487; Mon, 20 Apr 2026 15:18:57 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 20 Apr 2026 15:18:56 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 20 Apr 2026 15:18:56 +0800
Message-ID: <7a5fd195af42407ad79de05235beabff083b94b3.camel@mediatek.com>
Subject: Re: [PATCH 1/3] cmd: ubi: expose more APIs to public
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Mon, 20 Apr 2026 15:18:56 +0800
In-Reply-To: <CAFLszTiVYt0ShOO83nT7UqZSW4Z0ZpP3goooOkeNOTwYGq60nw@mail.gmail.com>
References: <cover.1776392312.git.weijie.gao@mediatek.com>
 <f0024175a615b0217cb3f2181d7957a9f59b9ec8.1776392312.git.weijie.gao@mediatek.com>
 <CAFLszTiVYt0ShOO83nT7UqZSW4Z0ZpP3goooOkeNOTwYGq60nw@mail.gmail.com>
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
> > cmd: ubi: expose more APIs to public
> > 
> > Export ubi_detach/ubi_create_vol/ubi_find_volume/ubi_remove_vol to
> > public for better ubi manipulation used by other modules.
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > cmd/ubi.c           | 10 +++++-----
> >  include/ubi_uboot.h |  5 +++++
> >  2 files changed, 10 insertions(+), 5 deletions(-)
> > diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> > @@ -47,9 +47,14 @@
> > +extern int ubi_create_vol(char *volume, int64_t size, int dynamic,
> > int vol_id,
> > +                       bool skipcheck);
> > +extern struct ubi_volume *ubi_find_volume(char *volume);
> > +extern int ubi_remove_vol(char *volume);
> 
> The volume parameter should be const char * since these functions do
> not modify the string. In patch 3/3, env_ubi_volume_create() receives
> a const char * and has to cast away const when calling these
> functions. Please can you fix the signatures in both cmd/ubi.c and
> ubi_uboot.h to take const char *volume.

OK. We need another patch to change all existing functions with char *
to const char *.

> 
> Regards,
> Simon

