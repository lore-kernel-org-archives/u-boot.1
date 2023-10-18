Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE57CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 14:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A980686FB3;
	Wed, 18 Oct 2023 16:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IFu3vqiu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5712486FBA; Wed, 18 Oct 2023 16:01:16 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCADE86FB5
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 16:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jbx6244@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9b95622c620so1187640366b.0
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697637672; x=1698242472; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pC+wOosOvusXq5DFVoEwRSsUgWv6hTG0o4c91N1zhgs=;
 b=IFu3vqiuxVwlssjUT8rij2sVThEFGJKXBDc+m1IKJqrsgTpZ++g+GPIRv0REoL4qMz
 SfXl2vrDCxhLXh3YubzW2hgTiBQ+yo99BSxC0vSEDYvyBTCZCKiF6nQbzag2yEoUPwxQ
 Z5LbNBgbw563SjZxosB/2jW54voKdgvK7OXdX3YpflsUstRvmqWUZUOk1kzU30dWKjiw
 P7KXthejuXvB+pvT1GI45wQc4HwyH8U8h5aEly+oiHdtgh3RKMhm2jR25wEcF3c0P5yx
 nXboR89JzmqkbKoyTg1YuG/ls+PFZX2u5Pj9VJjTxYbbFoQ8McJSgMV0f51zxTx2+K3U
 7fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697637672; x=1698242472;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pC+wOosOvusXq5DFVoEwRSsUgWv6hTG0o4c91N1zhgs=;
 b=ZuKTNMBLn7Yz0FjeHGsPjGzJlwZwvG/etAWh/HBVvy6B9p/ptFaUbWqabRyssaTohI
 N6cku1bEwttt5ySAatb6SnwtR/oqDUqI6NW9Dgzd/LZh8TSAs0wgQSWHIksP7w/EYXru
 fF3LjHz7R/Sx/HFenSX+fyacYooTglZ/WUbKH9KAY6MtqKJuZp6/IeWg5tM2aDK8ZRYs
 vxQOP1fpeOaq/oJ1UEuD2k2zSp1dGjCPR6M0WqHzYRkLlpHx2ASRwfRE4zcTfjHkyMGz
 hPOo7gxxjY3Gk9rcPjZmF72Qfr/m47DDLglZbc34nZ+8Ie9n1ispkZpRTEclWhupx8cp
 j2Jw==
X-Gm-Message-State: AOJu0YyjPdsrR9d+V8CW0uDcFlcm/49jf8vYAT4hXyg4OEB6AoLJk9zk
 sk0GyC92lfIaS8stvfvUkjQ=
X-Google-Smtp-Source: AGHT+IF3BJOKUEBcNCgEFxx6MX+QhJnXA/HHpZUH8jJ8lcceE/JPigMqzAwXWgQf8RjlTyQ3SwEl5A==
X-Received: by 2002:a17:907:3f04:b0:9bf:2d82:53b9 with SMTP id
 hq4-20020a1709073f0400b009bf2d8253b9mr4101356ejc.59.1697637672166; 
 Wed, 18 Oct 2023 07:01:12 -0700 (PDT)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
 by smtp.gmail.com with ESMTPSA id
 hx10-20020a170906846a00b009a13fdc139fsm1739054ejc.183.2023.10.18.07.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 07:01:11 -0700 (PDT)
Message-ID: <ee332375-8812-8e12-da1c-9973d10a41af@gmail.com>
Date: Wed, 18 Oct 2023 16:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v5 4/8] rockchip: block: blk-uclass: add bounce buffer flag to
 blk_desc
To: kever.yang@rock-chips.com
Cc: sjg@chromium.org, philipp.tomsich@vrull.eu,
 dario.binacchi@amarulasolutions.com, michael@amarulasolutions.com,
 marex@denx.de, u-boot@lists.denx.de
References: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Language: en-US
In-Reply-To: <7fd0d9d1-2e93-a48b-edfd-6d4fec314a60@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Currently bounce buffer support is enabled for all block devices
when available. Add a flag to blk_desc to enable only on demand.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V5:
  New patch
---
 drivers/block/blk-uclass.c | 4 ++--
 drivers/scsi/scsi.c        | 4 ++++
 include/blk.h              | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 30ad5bbb0024..77066da352a3 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -441,7 +441,7 @@ long blk_read(struct udevice *dev, lbaint_t start, lbaint_t blkcnt, void *buf)
 			  start, blkcnt, desc->blksz, buf))
 		return blkcnt;

-	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
+	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
 		struct blk_bounce_buffer bbstate = { .dev = dev };
 		int ret;

@@ -478,7 +478,7 @@ long blk_write(struct udevice *dev, lbaint_t start, lbaint_t blkcnt,

 	blkcache_invalidate(desc->uclass_id, desc->devnum);

-	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER)) {
+	if (IS_ENABLED(CONFIG_BOUNCE_BUFFER) && desc->bb) {
 		struct blk_bounce_buffer bbstate = { .dev = dev };
 		int ret;

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 7411660d465e..779a34bd2f1c 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -459,6 +459,9 @@ static void scsi_init_dev_desc_priv(struct blk_desc *dev_desc)
 	dev_desc->product[0] = 0;
 	dev_desc->revision[0] = 0;
 	dev_desc->removable = false;
+#if IS_ENABLED(CONFIG_BOUNCE_BUFFER)
+	dev_desc->bb = true;
+#endif	/* CONFIG_BOUNCE_BUFFER */
 }

 #if !defined(CONFIG_DM_SCSI)
@@ -606,6 +609,7 @@ static int do_scsi_scan_one(struct udevice *dev, int id, int lun, bool verbose)
 	bdesc->lun = lun;
 	bdesc->removable = bd.removable;
 	bdesc->type = bd.type;
+	bdesc->bb = bd.bb;
 	memcpy(&bdesc->vendor, &bd.vendor, sizeof(bd.vendor));
 	memcpy(&bdesc->product, &bd.product, sizeof(bd.product));
 	memcpy(&bdesc->revision, &bd.revision,	sizeof(bd.revision));
diff --git a/include/blk.h b/include/blk.h
index 76bd5baf9959..7c7cf7f2b102 100644
--- a/include/blk.h
+++ b/include/blk.h
@@ -68,6 +68,7 @@ struct blk_desc {
 	/* device can use 48bit addr (ATA/ATAPI v7) */
 	bool	lba48;
 	unsigned char	atapi;		/* Use ATAPI protocol */
+	unsigned char	bb;		/* Use bounce buffer */
 	lbaint_t	lba;		/* number of blocks */
 	unsigned long	blksz;		/* block size */
 	int		log2blksz;	/* for convenience: log2(blksz) */
--
2.39.2

