Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5EFCD4F54
	for <u-boot@archiver.kernel.org>; Wed, 27 May 2026 16:11:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EADDE84843;
	Wed, 27 May 2026 18:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BzLw0VmL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF52184843; Wed, 27 May 2026 18:11:17 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 535A784857
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 18:11:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e5fd39cf11so4868431a34.0
 for <u-boot@lists.denx.de>; Wed, 27 May 2026 09:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779898274; x=1780503074; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klRG24jKT8E1A27bz6KBc0UOjuhJk6CdlS6c/O0hmtE=;
 b=BzLw0VmLRZDhoVgoeiafa8squO4s38t6zCFzAQ0RtJDOxYN0coj9AhyhaP/GOc2aQ7
 viSo52nj87Yz2ItXrnRi/cnfVj+bVoaEJBY7vnr0RF9ALSm8LyU1jb7tDmW1qdK7kHjn
 Rt4PMEr6wvIWTtLqny5/08jmPW4DP/5KV+yAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779898274; x=1780503074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=klRG24jKT8E1A27bz6KBc0UOjuhJk6CdlS6c/O0hmtE=;
 b=cLWZ1t6anxkOT8Sxeo40GrlO8f5xcgiu0KAaOqTjwgSmH0XznPsluYEuY9MrgIs4SO
 HeQ3zwOfIJ621nIZATCgnf2AJ/2vWKLYjwwjQQqzequfUxgOgKQSFUQUqHl2R+euCHpX
 kHnBB3HZiopciw/OHKBYYIVqTRvuF7A+We3SOKYSE/0RDeZ6wFLev1zIYkgz6cRnRt+M
 CtRgtDIcmLdbe6kMHtuxPRLbc2LVdeITN4Y/kKlVv7RpfFzYm+lAVGVGivIL4nf5Kawt
 BX+QRBb6OhTQ7oB8Hr6huunwv1461TZKOVtMeTnijXGjoFLT4RQ8eEpPK03GLotoZ/+z
 ++CQ==
X-Gm-Message-State: AOJu0YzMir7Lq5gyebIzPnS6Khin4x+KJMUUTHjXkV749oK9XXmMIIzk
 v+Kcr8vVscQK0cmGE1RHFjOI1GzHERL1NvxOrxoHa9YX0iS8ggzbWIGxAWXY8Uq9P1phkCoEL2O
 Z1VtutpqT7FRyTA==
X-Gm-Gg: Acq92OHUb2T/fQhze9C0HuNlzS/VVhyxne3OjGMfpMfhIhhQ22lrrN590+T2XrkPAu9
 vh04Wj2tDXnK80u8ZUfwyVXQ7X5+RztAws7nOGCRz7B9jObYGJ9dFETx0LW/PekDRJtLUSFUBgC
 9QqlbLMn1mxUcM5LuvcZGv2v09nCeuWzBQka0knIMw4zVRgeHns47L7lTntkrezEARtkxMbwpWL
 VeiQ0lkgCxVA+HVTpWsW+YVWsUtrULPdBPl2K50Tqlgb/dyOH0Xn3mfSkG8cgXxY3RjOkGRg0Np
 mITCZCubSirNDUWo4crYvqoWVFvLAEVDMRxxhrzWptqyPraNhsGNAaU3kF2JZMAMlBOwrHUCxgS
 T7tNrjlAC0FkSw/iApoHwplgrndaSeH6paXCxsLV6W8XfM+29NnoLOjq7myt8FrihR/aIQv01pB
 q9avQscEiYuPsKwtOvOgEY94VK4QmU
X-Received: by 2002:a05:6830:2696:b0:7dc:e37b:b5d3 with SMTP id
 46e09a7af769-7e5fec8a6e3mr16313472a34.7.1779898274123; 
 Wed, 27 May 2026 09:11:14 -0700 (PDT)
Received: from chromium.org ([174.51.25.52]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6065e7cb6sm12102085a34.16.2026.05.27.09.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 09:11:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Adam Lackorzynski <adam@l4re.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 04/13] blk: Use hex indices for the device name
Date: Wed, 27 May 2026 10:10:14 -0600
Message-ID: <20260527161033.3273795-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527161033.3273795-1-sjg@chromium.org>
References: <20260527161033.3273795-1-sjg@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

It is confusing to use decimal values in device names. For example, with
virtio:

  => dm tree
  ...
  pci           5  [ + ]   pci_bridge_drv        |   |-- pci_0:1.5
    virtio        5  [ + ]   virtio-pci.m          |   |   `-- virtio-pci.m#5
   blk           0  [ + ]   virtio-blk            |   |       |-- virtio-blk#5
   partition     0  [ + ]   blk_partition         |   |       |   |-- virtio-blk#5:1
   partition     1  [ + ]   blk_partition         |   |       |   |-- virtio-blk#5:14
   partition     2  [ + ]   blk_partition         |   |       |   |-- virtio-blk#5:15
   partition     3  [ + ]   blk_partition         |   |       |   `-- virtio-blk#5:16
   bootdev       2  [ + ]   virtio_bootdev        |   |       `-- virtio-blk#5.bootdev
   pci           6  [ + ]   pci_bridge_drv        |   |-- pci_0:1.6
   ...
  => ls virtio 0:14
  ** Invalid partition 20 **
  Couldn't find partition virtio 0:14

Fix this by using hex for both the block-device number and the partition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/block/blk-uclass.c     | 2 +-
 drivers/virtio/virtio-uclass.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/blk-uclass.c b/drivers/block/blk-uclass.c
index 73c24fd9176..47ab60994c1 100644
--- a/drivers/block/blk-uclass.c
+++ b/drivers/block/blk-uclass.c
@@ -798,7 +798,7 @@ static int part_create_block_devices(struct udevice *blk_dev)
 	for (count = 0, part = 1; part <= MAX_SEARCH_PARTITIONS; part++) {
 		if (part_get_info(desc, part, &info))
 			continue;
-		snprintf(devname, sizeof(devname), "%s:%d", blk_dev->name,
+		snprintf(devname, sizeof(devname), "%s:%x", blk_dev->name,
 			 part);
 
 		ret = device_bind_driver(blk_dev, "blk_partition",
diff --git a/drivers/virtio/virtio-uclass.c b/drivers/virtio/virtio-uclass.c
index c36e9e9b3a7..927f05e2ccd 100644
--- a/drivers/virtio/virtio-uclass.c
+++ b/drivers/virtio/virtio-uclass.c
@@ -230,7 +230,7 @@ static int virtio_uclass_post_probe(struct udevice *udev)
 		return 0;
 	}
 
-	snprintf(dev_name, sizeof(dev_name), "%s#%d", name, dev_seq(udev));
+	snprintf(dev_name, sizeof(dev_name), "%s#%x", name, dev_seq(udev));
 	str = strdup(dev_name);
 	if (!str)
 		return -ENOMEM;
-- 
2.43.0

