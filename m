Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF349CD5BAB
	for <u-boot@archiver.kernel.org>; Sun, 24 May 2026 23:11:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3E8A83FF5;
	Mon, 25 May 2026 01:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YgQ1MKR4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0E884867; Sun, 24 May 2026 16:57:35 +0200 (CEST)
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com
 [IPv6:2607:f8b0:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10061846D3
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 16:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=prashant.kamble223@gmail.com
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b9ea536877so57747015ad.1
 for <u-boot@lists.denx.de>; Sun, 24 May 2026 07:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779634651; x=1780239451; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MWqMgAZFtfcpo9p9gdABFR5nZKnQPGmZB2I1mr1zrXo=;
 b=YgQ1MKR41x63GRayQj9LSh3qoRvtOeiB6Q/H3n4BKu7nYoPe+qq0Yy0k0STQFKhPaX
 AkHyWLgM32JuQf0FFU0U9ztUmHeSPjEQyTPlCDj/zR3T29JcTpEcoi7ceTCH82B7xkO7
 6BdauyCPmZ/3JlyM+tB4x33sQ3WX2khEeZntElNJbIvSpDVygg+lTjKQZgySOz7T/wIs
 ocnlJ702PzhWRsK346vsiZ+RJJoLya3SCCFrSoYye/ncBcg3UoCr5b+5UKj91EaRX5Jp
 wf0iHvU4gBERHo+g3N79U4LI2CAoO8FBmS5u64BUYY6KZtA4o87pfmWIcWaRk5Y3+qAD
 b2DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779634651; x=1780239451;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MWqMgAZFtfcpo9p9gdABFR5nZKnQPGmZB2I1mr1zrXo=;
 b=qF6RNr2ipyPkwxbYcOicBwgoelLGD/v9Ab46HwliV7TC9oKX5DLFycsozS+vqpqcGQ
 sHMl9S4N6pV22hadbnUHV6ky0WXLTPqxttOf1Ada9k0BF4xS55+t1G6aMTbDjq/bGTlg
 MBXfBwTff4ysjHoARX4hTdhRktomyp6zubCrjNGDwSory6SHSqyGumU6dwVLBD/p7mod
 wKIsLd5XFUINxNiwZPGUVrFB6jYNcW39X4zc+YqZ9qIVxbZy6i3egM/n2zH2Rbl0Im/w
 tWYFMKImrkgd1Cix9E5d6nOO9aeXYpMGwx/46W9Ga5/7NpBS48jGg2cnTbSXmXY1huMB
 Xh9g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/52B9iBSfTHvb0CLzvwM1uVmTzW9W0KxAjgCUiN2l1COC8ZwE3TBqtTaYgO4unpSRXC+elyOc=@lists.denx.de
X-Gm-Message-State: AOJu0YzZ1rIcXupeH756W8IQA1j839J9IB+n16pZWOyathClEw8yVeRj
 lpkabTEnYnRgOKjGCh3E+n058t1G2mLDuHCvSzZFjL/GvuXeRiTBrX6r
X-Gm-Gg: Acq92OEV62Ho0vldzeOT6oE7N5NaQf3DW8gsvRl5YH6oFQUu4fwq1UJ0Uh/jy3JuwYD
 H8PxwhiVZySVwq6RRODxuWwBHJ3GhyT+isyh4LohLEq17B1+YzRCl71ocgMOvg0AJRmD7rQhfrh
 a4TSHMMCprMBvoJkEccbg9m4OU0E6X5/txdQmK+EsqLdt3uOhB4bqP2t2THjVbztFal4U1EXXOk
 VE5UNHHandv0Wc30y20VJIPZCkYP72NbD5coZ2GRtISWSmIebxN4tmkFWPsgzqxUUVg2Tfxk2ez
 kwZy9/qfXQVgAKaUGldYmmGHiNG6D22CpcggSl8nemdZMH98ejDwF+urPOPG5CCMqK2tc7MROq6
 3PlSimsijpRlJW01CFpi+8pdpFYFqShv/a5xsKFSe7kS+a9TSRl/y9rxrtJfMFQyD3E7lq0txet
 vnOqUss/tZt0bqL2E2SVdBScHVzM3NQnXTQ/RUoHLzpg55ozsf+VqOK6Lv8VuHOZkYUKjiUIAK9
 vlz+dmW6LJzL1xTqNbW
X-Received: by 2002:a17:902:d50c:b0:2be:9e09:463 with SMTP id
 d9443c01a7336-2bea23c6713mr136457695ad.23.1779634651346; 
 Sun, 24 May 2026 07:57:31 -0700 (PDT)
Received: from prashant-Victus-by-HP-Gaming-Laptop-15-fa0xxx..
 ([49.205.205.62]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58dd75bsm90186985ad.69.2026.05.24.07.57.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 07:57:30 -0700 (PDT)
From: Prashant Kamble <prashant.kamble223@gmail.com>
To: 
Cc: prashant.kamble223@gmail.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Tom Rini <trini@konsulko.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
Subject: [PATCH] nvme: free prp_pool on nvme_init() failure paths
Date: Sun, 24 May 2026 20:27:16 +0530
Message-ID: <20260524145721.9206-1-prashant.kamble223@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 25 May 2026 01:11:45 +0200
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

nvme_init() allocates prp_pool after configuring the admin queue,
but some later error paths return without freeing it.

Free prp_pool before freeing the queue array in the failure paths
after nvme_setup_io_queues() and namespace ID buffer allocation.

This fixes a memory leak during NVMe initialization failures.

Signed-off-by: Prashant Kamble <prashant.kamble223@gmail.com>
---
 drivers/nvme/nvme.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index da7dad9f52b..9df7824b1c5 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -886,14 +886,14 @@ int nvme_init(struct udevice *udev)
 	if (!ndev->prp_pool) {
 		ret = -ENOMEM;
 		printf("Error: %s: Out of memory!\n", udev->name);
-		goto free_nvme;
+		goto free_queue;
 	}
 	ndev->prp_entry_num = MAX_PRP_POOL >> 3;
 
 	ret = nvme_setup_io_queues(ndev);
 	if (ret) {
 		log_debug("Unable to setup I/O queues(err=%dE)\n", ret);
-		goto free_queue;
+		goto free_prp_pool;
 	}
 
 	nvme_get_info_from_identify(ndev);
@@ -903,7 +903,7 @@ int nvme_init(struct udevice *udev)
 	id = memalign(ndev->page_size, sizeof(struct nvme_id_ns));
 	if (!id) {
 		ret = -ENOMEM;
-		goto free_queue;
+		goto free_prp_pool;
 	}
 
 	for (int i = 1; i <= ndev->nn; i++) {
@@ -948,6 +948,8 @@ int nvme_init(struct udevice *udev)
 
 free_id:
 	free(id);
+free_prp_pool:
+	free((void *)ndev->prp_pool);
 free_queue:
 	free((void *)ndev->queues);
 free_nvme:
-- 
2.43.0

