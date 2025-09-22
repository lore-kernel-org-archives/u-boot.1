Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4721BCAC5A7
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 01:32:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97833833D0;
	Mon, 22 Sep 2025 03:32:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="GUth0G16";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11663833E8; Mon, 22 Sep 2025 03:32:17 +0200 (CEST)
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7DDB18317B
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 03:32:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: f2fca434975311f0b33aeb1e7f16c2b6-20250922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=tbSn7vpBXO4y2DxbyPhMy4V4QKRJUKWddE3S68DF3IY=; 
 b=GUth0G16lkm4gVfNHdUo3VqqMfVyMIKgM/iZRi9VHn8vSCT2sKB093LFvbMGzKvY3rY+NFdFiYEl+aRPaKZAgOsijFTzxFvYZHlouyD5/1kecuF+D5GVwOEd8Bpsqxer86Np79mnwkKVR/yivvhQz8R/DgPz26ktlbxAnhZd50s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4, REQID:7dbd4dbe-8744-4a37-9910-ce7ddd56c9f1, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:1ca6b93, CLOUDID:11e989f8-ebfe-43c9-88c9-80cb93f22ca4,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|836|888|898,TC:-5,Co
 ntent:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,
 COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f2fca434975311f0b33aeb1e7f16c2b6-20250922
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by
 mailgw02.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 936340156; Mon, 22 Sep 2025 09:32:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 22 Sep 2025 09:32:04 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Mon, 22 Sep 2025 09:32:03 +0800
Message-ID: <029374f7e12d6f41ed313b5cced994878b57dabd.camel@mediatek.com>
Subject: Re: [PATCH] misc: fs_loader: Use buffer pointer in
 request_firmware_into_buf_via_script()
From: Weijie Gao <weijie.gao@mediatek.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, <u-boot@lists.denx.de>
CC: Lucien.Jheng <lucienzx159@gmail.com>, Alif Zakuan Yuslaimi
 <alif.zakuan.yuslaimi@altera.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, Ryder Lee
 <ryder.lee@mediatek.com>, Sky Huang <SkyLake.Huang@mediatek.com>, Tom Rini
 <trini@konsulko.com>
Date: Mon, 22 Sep 2025 09:32:03 +0800
In-Reply-To: <20250921223537.108188-1-marek.vasut+renesas@mailbox.org>
References: <20250921223537.108188-1-marek.vasut+renesas@mailbox.org>
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

Hi Marek,

On Mon, 2025-09-22 at 00:35 +0200, Marek Vasut wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Use plain buffer pointer in request_firmware_into_buf_via_script()
> instead of a pointer to pointer. The later is not necessary as the
> request_firmware_into_buf_via_script() does not modify the buffer
> pointer. Update the mediatek driver to match.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: "Lucien.Jheng" <lucienzx159@gmail.com>
> Cc: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Ramon Fried <rfried.dev@gmail.com>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Sky Huang <SkyLake.Huang@mediatek.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: u-boot@lists.denx.de
> ---
>  drivers/misc/fs_loader.c             | 4 ++--
>  drivers/net/phy/mediatek/mtk-2p5ge.c | 6 +++---
>  include/fs_loader.h                  | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> index 32aff35835b..d641647e040 100644
> --- a/drivers/misc/fs_loader.c
> +++ b/drivers/misc/fs_loader.c
> @@ -228,7 +228,7 @@ int request_firmware_into_buf(struct udevice
> *dev,
>         return ret;
>  }
> 
> -int request_firmware_into_buf_via_script(void **buf, size_t
> max_size,
> +int request_firmware_into_buf_via_script(void *buf, size_t max_size,
>                                          const char *script_name,
>                                          size_t *retsize)
>  {
> @@ -270,7 +270,7 @@ int request_firmware_into_buf_via_script(void
> **buf, size_t max_size,
>         if (retsize)
>                 *retsize = size;
> 
> -       memcpy(*buf, (void *)addr, size);
> +       memcpy(buf, (void *)addr, size);
> 
>         return 0;
>  }
> diff --git a/drivers/net/phy/mediatek/mtk-2p5ge.c
> b/drivers/net/phy/mediatek/mtk-2p5ge.c
> index ab5007389a9..0e704bdb04d 100644
> --- a/drivers/net/phy/mediatek/mtk-2p5ge.c
> +++ b/drivers/net/phy/mediatek/mtk-2p5ge.c
> @@ -249,7 +249,7 @@ int __weak mt7987_i2p5ge_get_fw(void **fw, size_t
> *fwsize,
>                 return -ENOMEM;
> 
>         ret = request_firmware_into_buf_via_script(
> -               &pmb, MT7987_2P5GE_PMB_FW_SIZE,
> +               pmb, MT7987_2P5GE_PMB_FW_SIZE,
>                 "mt7987_i2p5ge_load_pmb_firmware", fwsize);
>         if (ret) {
>                 free(pmb);
> @@ -263,7 +263,7 @@ int __weak mt7987_i2p5ge_get_fw(void **fw, size_t
> *fwsize,
>         }
> 
>         ret = request_firmware_into_buf_via_script(
> -               &dsp, MT7987_2P5GE_DSPBITTB_SIZE,
> +               dsp, MT7987_2P5GE_DSPBITTB_SIZE,
>                 "mt7987_i2p5ge_load_dspbit_firmware", dspfwsize);
>         if (ret) {
>                 free(pmb);
> @@ -476,7 +476,7 @@ int __weak mt7988_i2p5ge_get_fw(void **fw, size_t
> *size)
>                 return -ENOMEM;
> 
>         ret = request_firmware_into_buf_via_script(
> -               &pmb, MT7988_2P5GE_PMB_FW_SIZE,
> +               pmb, MT7988_2P5GE_PMB_FW_SIZE,
>                 "mt7988_i2p5ge_load_pmb_firmware", size);
>         if (ret) {
>                 free(pmb);
> diff --git a/include/fs_loader.h b/include/fs_loader.h
> index 1cf6d6dd05f..3afd9e62b4a 100644
> --- a/include/fs_loader.h
> +++ b/include/fs_loader.h
> @@ -87,7 +87,7 @@ int get_fs_loader(struct udevice **dev);
>   *   env set fw_addr ${loadaddr} && env set fw_size ${filesize}
>   * Return: 0 on success, negative value on error.
>   */
> -int request_firmware_into_buf_via_script(void **buf, size_t
> max_size,
> +int request_firmware_into_buf_via_script(void *buf, size_t max_size,
>                                          const char *script_name,
>                                          size_t *retsize);
>  #endif
> --
> 2.51.0
> 

Reviewed-by: Weijie Gao <weijie.gao@mediatek.com>

Best Regards,
Weijie

