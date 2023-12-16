Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F687C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 20:11:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFD3087AF3;
	Sat, 16 Dec 2023 21:11:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="2L/lPAxB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19E987BD2; Sat, 16 Dec 2023 21:11:25 +0100 (CET)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1C13877A1
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 21:11:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3agR-ZQcKBp0JLOFQWCDLLDIB.9LJR-8LLQIFPQP.ABKU.AB@flex--moritzf.bounces.google.com
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-5d10f5bf5d9so13489607b3.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 12:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1702757482; x=1703362282; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=NJ/DQza+yhnRA098C7WiyN0jCB++sZX4L2sKa0tDSTw=;
 b=2L/lPAxBlsRaTesIAV9AsLXnaI1Zoi5HfMcB2i6dzsuGDL0Yi9rsa3z4y1p6ev692K
 NlyabmfROSYozkylQqPtk+EikIaOwOi/f0Bzs6MBXlap4pO3dgMelZQzyx2yd/qVtFDf
 yl9iAZljlcDTwck21aSlbLevxqoxTmNAt/kBFGs2MqpH4FB5WmqZASqh256Hl63WWoBF
 VmdvocLz97uL6bpzuitIYD+ZLaLuzGTuHxfLch+sIgvcdLo9vaLE9a6OQFHCYYNxUhUl
 cN20oo1UOWdM2dLmQdzpMZymdWQP0COnCDXVicw5IvsX/mpUNah/iAl2q/T1gLVzAcH8
 nKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702757482; x=1703362282;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NJ/DQza+yhnRA098C7WiyN0jCB++sZX4L2sKa0tDSTw=;
 b=q+ZFio1TPFJ9ZoIqDPKUBQY2QjG47976pLfjTNUqEfv7OF82FVBxFFHMo2zOkbbgqw
 wgxJ/gwwZ+2pPJqo5pX0He6402JEWWlw+Du1vZrD/KDIzrrYAV5p6Grjy6WdiXQ2d7Cu
 GKQhSI8r89QsmJ/UYLFdE2DYaT1Em9W2YDnSoASs55cchkXxvbn1BPMgiFFQ577ufDlh
 Xeu3Hf2bikF8ZlXmHs60oqKt0y4fQGU7M2Kq0Ivd+dkGa1KjB8AV9xu/Qy0svBZ1n1IE
 7s1Z0kz7B+lOPDNi7azHXPluNBqNJK7Z348jlc+5yhmtxQIrLO9Vc3p2ZlMwjTuZ78PG
 MWyQ==
X-Gm-Message-State: AOJu0YymAXVS6hEgzlu/1s6laX4g+ZisVJZtwxMNBD24tedk/FAZc59Z
 sbqCzvIPJ4b6yQCoAv+hkH5NJLuLXCxp
X-Google-Smtp-Source: AGHT+IHA/ucAJfAEn3nHMnxQHEqzv+nb4OTmuOpUU+Fn/fnIIMzljxies20fOlAYnByj0RuTF91SsBb9dbH8
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:ab8c:0:b0:dbc:c82d:7f0a
 with SMTP id
 v12-20020a25ab8c000000b00dbcc82d7f0amr86955ybi.9.1702757482433; Sat, 16 Dec
 2023 12:11:22 -0800 (PST)
Date: Sat, 16 Dec 2023 20:11:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231216201120.2735840-1-moritzf@google.com>
Subject: [PATCH v2 1/2] nvme: Fix error code and log to indicate busy
From: Moritz Fischer <moritzf@google.com>
To: bmeng.cn@gmail.com, sjg@chromium.org, wenbin.song@nxp.com, 
 u-boot@lists.denx.de, trini@konsulko.com
Cc: mdf@kernel.org, patrick@blueri.se, Moritz Fischer <moritzf@google.com>
Content-Type: text/plain; charset="UTF-8"
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

Return -EBUSY if controller is found busy rather than -ENOMEM
and update the error message accordingly.

Fixes: 982388eaa991 ("nvme: Add NVM Express driver support")
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Moritz Fischer <moritzf@google.com>
---
Changes from V1:
- Added Simon's Reviewed-by
---
 drivers/nvme/nvme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/nvme.c b/drivers/nvme/nvme.c
index c39cd41aa3..ec45f831a3 100644
--- a/drivers/nvme/nvme.c
+++ b/drivers/nvme/nvme.c
@@ -835,8 +835,8 @@ int nvme_init(struct udevice *udev)
 	ndev->udev = udev;
 	INIT_LIST_HEAD(&ndev->namespaces);
 	if (readl(&ndev->bar->csts) == -1) {
-		ret = -ENODEV;
-		printf("Error: %s: Out of memory!\n", udev->name);
+		ret = -EBUSY;
+		printf("Error: %s: Controller not ready!\n", udev->name);
 		goto free_nvme;
 	}
 
-- 
2.43.0.472.g3155946c3a-goog

