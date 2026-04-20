Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6729F36C3A
	for <u-boot@archiver.kernel.org>; Mon, 20 Apr 2026 07:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 008C7839D5;
	Mon, 20 Apr 2026 09:28:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Es0TDCD6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9621840D8; Mon, 20 Apr 2026 09:28:00 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82D6C83693
 for <u-boot@lists.denx.de>; Mon, 20 Apr 2026 09:27:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 72594b2a3c8a11f1ae70033691e9ac7d-20260420
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=w/1w0cTJe4vsuIHX8JHyM281JV23OvrQbAds8p42Z7o=; 
 b=Es0TDCD6alhlHv44zOFhMD3cHro0eetTAbhfXGnUn6AoxZA7DwD9w8rqhGmDVZJD6ONw8AId0u90NiPGLVGMFFcokOQJiWnofTSqcJp33H5eBH5wysVeDi7HGL54HiRb0yiAFFizoZNKihezlFSmtaPck78EUhwn6e/eteRekhE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:746b6dd0-3aca-498b-9ee3-86b8f15f0499, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:2c742295-f8ef-4ca8-bea0-143568f9ca1d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 72594b2a3c8a11f1ae70033691e9ac7d-20260420
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1395537116; Mon, 20 Apr 2026 15:27:54 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 20 Apr 2026 15:27:53 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 20 Apr 2026 15:27:52 +0800
Message-ID: <20fe278b75a677602e54bb7dcb7318df91180d94.camel@mediatek.com>
Subject: Re: [PATCH 3/3] env: ubi: add support to create environment volume
 if it does not exist
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Mon, 20 Apr 2026 15:27:52 +0800
In-Reply-To: <CAFLszTi3KR_juVymVmfpqw1NvvrPVipfa6-bZjsdX6NpxBFbyg@mail.gmail.com>
References: <cover.1776392312.git.weijie.gao@mediatek.com>
 <ba4fd0352a7e9a38c0cddaa3056a926cf9715631.1776392312.git.weijie.gao@mediatek.com>
 <CAFLszTi3KR_juVymVmfpqw1NvvrPVipfa6-bZjsdX6NpxBFbyg@mail.gmail.com>
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
> > env: ubi: add support to create environment volume if it does not
> > exist
> > 
> > Add an option to allow environment volume being auto created if not
> > exist.
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > env/Kconfig |  6 ++++++
> >  env/ubi.c   | 20 ++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
> 
> Could you beef up the Kconfig help text for ENV_UBI_VOLUME_CREATE -
> e.g. mention when users might want to enable this, such as on first
> boot of a fresh device where the UBI partition exists but no volumes
> have been created yet.

OK.

> 
> > diff --git a/env/ubi.c b/env/ubi.c
> > @@ -105,6 +105,18 @@ static int env_ubi_save(void)
> > +int __weak env_ubi_volume_create(const char *volume)
> > +{
> > +     struct ubi_volume *vol;
> > +
> > +     vol = ubi_find_volume((char *)volume);
> 
> Does this function need to be weak?

Is unnecessary at all. I added in my early test.

> 
> ubi_find_volume() prints "Volume %s not found!" when the volume does
> not exist. Since the whole point of this function is to handle
> missing
> volumes, this message will appear every time auto-creation is used.
> Please can you either add a quiet variant of ubi_find_volume(), or
> suppress the message here?

As I replied in 2/3, I'll move these messages into the main command
function.

> 
> > diff --git a/env/ubi.c b/env/ubi.c
> > @@ -134,6 +146,11 @@ static int env_ubi_load(void)
> > +     if (IS_ENABLED(CONFIG_ENV_UBI_VOLUME_CREATE)) {
> > +             env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME);
> > +             env_ubi_volume_create(CONFIG_ENV_UBI_VOLUME_REDUND);
> > +     }
> 
> The return value from env_ubi_volume_create() is not checked. If
> volume creation fails (e.g. no space left), the subsequent
> ubi_volume_read() will also fail, but the error message will not
> indicate the underlying problem. Please can you check the return
> value
> and print an appropriate message if creation fails?

OK.

> 
> Regards,
> Simon

