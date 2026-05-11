Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F82CCD3427
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 08:27:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE24C84868;
	Mon, 11 May 2026 10:27:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="Bts/TiCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 210CA84867; Mon, 11 May 2026 10:27:57 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0457084844
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 10:27:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 4a5474084d1311f1b96f91537e34a508-20260511
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=I0zHO45Lv5T8vngNzf16JCPf/kvDVY0cgGcF/dE2bJU=; 
 b=Bts/TiCHH+vN8u37NF6a13frljKhB/+UeZLAVv1NKECki9ESIk2Ng15fWYvb6vY1BYiXs6T7Rj3liSckb4sof1j8KaYs4UCD7p/InnhbFSIFTf0P1eOBzD0BRa+Lq+rOosIZWkUE6lsbXPGRt8wc8TcmMjbqFug285AiNFbZswY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:f7513fa6-ae0b-4100-8fbc-0a031b9778e6, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:00f14171-3b7f-4b26-b2f9-40f0deecb36d,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|865|888|898,TC:-
 5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:0,Bulk:nil,QS:nil,BEC:-1
 ,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 4a5474084d1311f1b96f91537e34a508-20260511
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 1096287304; Mon, 11 May 2026 16:27:47 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 11 May 2026 16:27:46 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.2562.29 via Frontend Transport; Mon, 11 May 2026 16:27:45 +0800
Message-ID: <a180a411ef345182c2177280e53d453a08bd5954.camel@mediatek.com>
Subject: Re: [PATCH v3 09/10] ubi: add comments for exported ubi API functions
From: Weijie Gao <weijie.gao@mediatek.com>
To: Simon Glass <sjg@chromium.org>
CC: <u-boot@lists.denx.de>
Date: Mon, 11 May 2026 16:27:45 +0800
In-Reply-To: <CAFLszThT-jyw5OjAkZGWpKKi0d0NARL8O1f6etR7YUCOvWc_vQ@mail.gmail.com>
References: <cover.1777272283.git.weijie.gao@mediatek.com>
 <dd48da7aa5d821b56528824bfd4b57e014947a03.1777272283.git.weijie.gao@mediatek.com>
 <CAFLszThT-jyw5OjAkZGWpKKi0d0NARL8O1f6etR7YUCOvWc_vQ@mail.gmail.com>
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

On Tue, 2026-04-28 at 08:08 -0600, Simon Glass wrote:
> Hi Weijie,
> 
> On 2026-04-27T07:09:11, Weijie Gao <weijie.gao@mediatek.com> wrote:
> > ubi: add comments for exported ubi API functions
> > 
> > This patch adds comments for exported ubi command API functions.
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > 
> > include/ubi_uboot.h | 86
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 86 insertions(+)
> > diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> > @@ -47,14 +47,100 @@
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
> > int ubi_part(const char *part_name, const char *vid_header_offset);
> 
> Most error paths in this file return positive errno values, so '-ve
> on
> error' is not quite right. Please double-check and document the
> actual
> convention.
> 
> > diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> > @@ -47,14 +47,100 @@
> > + * ubi_volume_read() - read data from UBI volume
> > + * @volume: name of the volume to read from
> > + * @buf: buffer to hold the read data
> > + * @offset: start offset for reading
> > + * @size: number of bytes to read
> > + *
> > + * This function reads data from the specified UBI volume. If
> > @size is zero,
> > + * the function reads the entire volume content starting from
> > @offset.
> > + *
> > + * Return: 0 on success, or -ve on error.
> > + */
> > int ubi_volume_read(const char *volume, void *buf, loff_t offset,
> > size_t size);
> 
> Same here early-exit paths return positive errno (ENODEV, EBUSY,
> EBADF, ENOMEM) while the read loop negates ubi_eba_read_leb()'s
> error.
> Better to normalise to one convention, and please be consistent
> across
> all of these.

For the above two comments for returning -ve, I'll send another patch
to change all return value to negative.

> 
> > diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> > @@ -47,14 +47,100 @@
> > + * This function creates a new UBI volume with the specified
> > parameters.
> > + * If @size is negative, all available spaces will be used.
> > + * if @vol_id is negative, volume ID will be selected and assigned
> > by UBI.
> > + *
> > + * Return: 0 on success, or -ve on error.
> > + */
> > int ubi_create_vol(const char *volume, int64_t size, bool dynamic,
> > int vol_id,
> >                  bool skipcheck);
> 
> Capitlal I on 'If'. Also 'all available spaces' reads better as 'all
> available space'. Also worth mentioning that @vol_id should be
> UBI_VOL_NUM_AUTO for auto-assignment.
> 
> > diff --git a/include/ubi_uboot.h b/include/ubi_uboot.h
> > @@ -47,14 +47,100 @@
> > + * ubi_detach() - detach UBI from MTD partition
> > + *
> > + * This function performs the cleanup of the UBI subsystem to make
> > sure the
> > + * MTD partition can be safely used by other purpose, or be
> > attached again
> > + * with ubi_part().
> > + *
> > + * Any mounted UBIFS will be unmounted automatically.
> > + *
> > + * Return: 0 on success.
> > + */
> > int ubi_detach(void);
> 
> 'used by other purpose' should be 'used for another purpose'. Since
> this only ever returns 0, you could say 'Return: 0' and drop 'on
> success'.

I'll fix the rest two comments.

> 
> Regards,
> Simon

