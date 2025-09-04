Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0612DCA1012
	for <u-boot@archiver.kernel.org>; Thu,  4 Sep 2025 00:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EDC5834E5;
	Thu,  4 Sep 2025 02:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=mediatek.com header.i=@mediatek.com header.b="DBZjtvFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B0C87834E5; Thu,  4 Sep 2025 02:23:44 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDFE8835FE
 for <u-boot@lists.denx.de>; Thu,  4 Sep 2025 02:23:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=mediatek.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=weijie.gao@mediatek.com
X-UUID: 622f1ee6892511f0bd5779446731db89-20250904
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com;
 s=dk; 
 h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID;
 bh=vVsuPmY7slncSS3vHxfRV1GrdH9uC20hYx2BuJuqQGY=; 
 b=DBZjtvFHHS+bEw0PoqYPNJB0XipHRZqHIGSt1PM4rv71EUqz2LVh583JNmebhm5cPA7rRWmYbQn8YjUfYRsVOwXdw8CX3GcwYFI5PJNokCzfVgxen0Ff9yOl0u6KUmHe25ksotHU8ir+VP/Ol0UUqOZ+WLk/fuVb4V9p3YwdqoE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3, REQID:fba61159-ab02-418a-826e-605258348569, IP:0,
 UR
 L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
 elease,TS:0
X-CID-META: VersionHash:f1326cf, CLOUDID:a2492c6c-8443-424b-b119-dc42e68239b0,
 B
 ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102,TC:-5,Content:0|15|5
 0,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
 OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 622f1ee6892511f0bd5779446731db89-20250904
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by
 mailgw01.mediatek.com (envelope-from <weijie.gao@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 2031475666; Thu, 04 Sep 2025 08:23:30 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 4 Sep 2025 08:23:27 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 4 Sep 2025 08:23:27 +0800
Message-ID: <5ada4f98b8d09bd78915bef278dee780de5d7fa2.camel@mediatek.com>
Subject: Re: [PATCH v3 2/5] misc: fs_loader: allow using long script name in
 request_firmware_into_buf_via_script()
From: Weijie Gao <weijie.gao@mediatek.com>
To: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
CC: <u-boot@lists.denx.de>, GSS_MTK_Uboot_upstream
 <GSS_MTK_Uboot_upstream@mediatek.com>, Tom Rini <trini@konsulko.com>, "Lucien
 . Jheng" <lucienzx159@gmail.com>
Date: Thu, 4 Sep 2025 08:23:28 +0800
In-Reply-To: <20250903133600.52169228@karo-electronics.de>
References: <cover.1756885599.git.weijie.gao@mediatek.com>
 <038e8258c903367dccd9c7cd1adb51bcf2bdf307.1756885599.git.weijie.gao@mediatek.com>
 <20250903133600.52169228@karo-electronics.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Wed, 2025-09-03 at 13:36 +0200, Lothar Waßmann wrote:
> External email : Please do not click links or open attachments until
> you have verified the sender or the content.
> 
> 
> Hi,
> 
> On Wed, 3 Sep 2025 16:38:30 +0800 Weijie Gao wrote:
> > Use cmd_process() to remove the length limit of script name used
> > for
> > run_command().
> > 
> > Signed-off-by: Weijie Gao <weijie.gao@mediatek.com>
> > ---
> >  drivers/misc/fs_loader.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/misc/fs_loader.c b/drivers/misc/fs_loader.c
> > index 87acd385e23..6a6796c1931 100644
> > --- a/drivers/misc/fs_loader.c
> > +++ b/drivers/misc/fs_loader.c
> > @@ -232,18 +232,15 @@ int request_firmware_into_buf_via_script(void
> > **buf, size_t max_size,
> >                                        const char *script_name,
> >                                        size_t *retsize)
> >  {
> > +     char *args[2] = { (char *)"run", (char *)script_name };
> > 
> 
> const char *args[2] = { "run", script_name };
> does not work?
> 
> I don't see any need for a non-const 'args' here.

We'll get compiler warning if using const char *[]:

  CC      drivers/misc/fs_loader.o
drivers/misc/fs_loader.c: In function
'request_firmware_into_buf_via_script':
drivers/misc/fs_loader.c:243:33: warning: passing argument 3 of
'cmd_process' from incompatible pointer type [-Wincompatible-pointer-
types]
  243 |         ret = cmd_process(0, 2, args, &repeatable, NULL);
      |                                 ^~~~
      |                                 |
      |                                 const char **
In file included from include/image.h:35,
                 from include/spl.h:17,
                 from drivers/misc/fs_loader.c:22:
include/command.h:278:64: note: expected 'char * const*' but argument
is of type 'const char **'
  278 | enum command_ret_t cmd_process(int flag, int argc, char *const
argv[],
      |                                                    ~~~~~~~~~~~~
^~~~~~

> 
> 
> Lothar Waßmann

