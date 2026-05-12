Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B4BCD37BE
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 02:40:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDEE883EEF;
	Tue, 12 May 2026 04:40:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="OCmw8wke";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F30F845E3; Tue, 12 May 2026 04:40:56 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D3CE583CD3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 04:40:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f95d79484dab11f1b96f91537e34a508-20260512
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=0jmLDs1e0xUtwGyP0AF4IvxinHYJLsL2hs7uiUBap+o=; 
 b=OCmw8wke7D1X/9WCNmtMnnqbR2Cz1F0DKKQNRKFSV1yFV4LZMq0hE07vEdREiipEqb8X1S4Kn/+x1oQrXGsxDep8uLhmlFK0fyMtcvGBOlnDwwWgKoC2GZW9amugIJRbZ60my510BkA5/PQIiIbCY/A7rvA8sio65rVmWxHu9Ro=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:0d638f2f-76a6-4cbc-b7b0-11c2cfaf17ee, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:614539bf-65a8-4b41-ac18-3671578a914d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f95d79484dab11f1b96f91537e34a508-20260512
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1649440822; Tue, 12 May 2026 10:40:44 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 12 May 2026 10:40:43 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Tue, 12 May 2026 10:40:43 +0800
Message-ID: <119155049b093e293a536523036bbb3d939c4d39.camel@mediatek.com>
Subject: Re: [PATCH v3 06/10] cmd: ubi: reorganize command messages
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Tue, 12 May 2026 10:40:42 +0800
In-Reply-To: <CAFLszTjjde593ZKoZcSTTkKndC2XBKXCFLJzcYTafdD+1tZT-g@mail.gmail.com>
References: <cover.1777272283.git.weijie.gao@mediatek.com>
 <e9ca310e07d0e591339e0dbf3c1b893a1c43a03b.1777272283.git.weijie.gao@mediatek.com>
 <CAFLszTjjde593ZKoZcSTTkKndC2XBKXCFLJzcYTafdD+1tZT-g@mail.gmail.com>
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

On Tue, 2026-04-28 at 08:10 -0600, Simon Glass wrote:
> Hi Weijie,
> 
> On 2026-04-27T07:09:11, Weijie Gao <weijie.gao@mediatek.com> wrote:
> > cmd: ubi: reorganize command messages
> > 
> > This patch moves normal subcommand messages into the main command
> > function.
> > This will allow current and potential api functions being called
> > with clean
> > output.
> > 
> > A new function ubi_require_volume() is added for finding and
> > printing error
> > message if volume not found. The original ubi_find_volume() will be
> > silent
> > for being an api function.
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > cmd/ubi.c | 109 +++++++++++++++++++++++++++++++++++++++++++++----
> > -------------
> >  1 file changed, 79 insertions(+), 30 deletions(-)
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -806,31 +805,65 @@ static int do_ubi(struct cmd_tbl *cmdtp, int
> > flag, int argc, char *const argv[])
> >       if (strncmp(argv[1], 'remove', 6) == 0) {
> >               /* E.g., remove volume */
> > -             if (argc == 3)
> > -                     return ubi_remove_vol(argv[2]);
> > +             if (argc == 3) {
> > +                     int vol_id;
> > +
> > +                     vol = ubi_find_volume(argv[2]);
> > +                     if (!vol)
> > +                             return 0;
> > +
> > +                     vol_id = vol->vol_id;
> > +
> > +                     ret = ubi_remove_vol(argv[2]);
> 
> This seems wrong - previously 'ubi remove nonexistent' printed an
> error via ubi_find_volume() and returned ENODEV; now it silently
> returns 0. I think you should use ubi_require_volume() here.

I'll fix this.

> 
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -806,31 +805,65 @@ static int do_ubi(struct cmd_tbl *cmdtp, int
> > flag, int argc, char *const argv[])
> >               if (argc == 3) {
> > +                     if (!size) {
> > +                             vol = ubi_require_volume(argv[3]);
> > +                             if (!vol)
> > +                                     return 1;
> > +
> > +                             printf("No size specified -> Using
> > max size (%lld)\n",
> > +                                    vol->used_bytes);
> > +                             size = vol->used_bytes;
> > +                     }
> > +
> > +                     ret = ubi_volume_read(argv[3], (void *)addr,
> > 0, size);
> 
> When size is 0 the volume is now looked up twice,. i.e. here and
> again
> inside ubi_volume_read() - can you drop the fallback in
> ubi_volume_read() or move the 'No size specified' print back there
> guarded by a verbose flag.

I think we can do some modifications to ubi_volume_read:

static int __ubi_volume_read(struct ubi_volume *vol, ...) { ... }

int ubi_volume_read(const char *volume, ...)
{
	struct ubi_volume *vol = ubi_require_volume(volume);
	...
	return __ubi_volume_read(vol, ...);
}

And in do_ubi() we always call ubi_require_volume() to get vol and call
__ubi_volume_read with vol.

> 
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -806,31 +805,65 @@ static int do_ubi(struct cmd_tbl *cmdtp, int
> > flag, int argc, char *const argv[])
> > -     if (IS_ENABLED(CONFIG_CMD_UBI_RENAME) && !strncmp(argv[1],
> > 'rename', 6))
> > -             return ubi_rename_vol(argv[2], argv[3]);
> > +     if (IS_ENABLED(CONFIG_CMD_UBI_RENAME) && !strncmp(argv[1],
> > 'rename', 6)) {
> > +             ret = ubi_rename_vol(argv[2], argv[3]);
> > +             if (!ret) {
> > +                     printf("UBI volume %s renamed to %s\n",
> > argv[2],
> > +                            argv[3]);
> > +             }
> > +
> > +             return ret;
> > +     }
> 
> While you are here, please add an 'argc == 4' check to fix a
> pre-existing bug - i.e. argv[2]/argv[3] are dereferenced
> unconditionally.

OK.

> 
> > diff --git a/cmd/ubi.c b/cmd/ubi.c
> > @@ -806,31 +805,65 @@ static int do_ubi(struct cmd_tbl *cmdtp, int
> > flag, int argc, char *const argv[])
> > +                     else if (ret == -EEXIST)
> > +                             printf("Volume %s already exists!\n",
> > argv[2]);
> > +
> > +                     return ret;
> 
> Just to check: ubi_create_volume() returns -EEXIST, but
> verify_mkvol_req() returns positive errnos, so name-too-long or
> bad-alignment failures get no friendly message here. What do you
> think
> about handling the verify_mkvol_req() errors here too, or making that
> helper silent like ubi_find_volume()?

I found that the ubi layer will print error message in this case:
ubi0 error: ubi_create_volume: volume "test" exists (ID 2)
ubi0 error: ubi_create_volume: cannot create volume 11, error -17

So this modification is unnecessary and I'll remove this in next patch.

All error messages will be kept in verify_mkvol_req().

> 
> Regards,
> Simon

