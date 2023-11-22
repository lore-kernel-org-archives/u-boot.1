Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FC6C61D99
	for <u-boot@archiver.kernel.org>; Wed, 22 Nov 2023 23:52:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BDFF88767F;
	Thu, 23 Nov 2023 00:52:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Inqo1r+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 362D387671; Thu, 23 Nov 2023 00:52:22 +0100 (CET)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61470875F5
 for <u-boot@lists.denx.de>; Thu, 23 Nov 2023 00:52:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3MJReZQcKBgUrtwny4klttlqj.htrz-gttyqnxyx.ijs2.ij@flex--moritzf.bounces.google.com
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-d9ce4e0e2bdso282581276.3
 for <u-boot@lists.denx.de>; Wed, 22 Nov 2023 15:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1700697136; x=1701301936; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=8Gu1JgAg7xh4M4Sj67PDrdLpqnH744OBKZ8qwSIvF4I=;
 b=Inqo1r+KX0KTDO0AmeqG3OX13MX6HJj8R8Yq41EdWynZViGHIyipGV3CLfpVg4nUMr
 slJwHjAAXfzwLWUFmPiQbb92MClanE5/wUQ6Q6kDwTIsr/SrrazSLEm8mIRN6K7T6YeF
 F9I6Ts3KF8CEyxrGzvxdz2JQnpUS91Ea9u274TJ5LJansi4glBhYzc6WxrK4Il3ACDlK
 YgBDbaUmYcJ8Vf10CVTD5XHbkHvp8rd0mFaihoAyVfZtUurjwaCn5m9Xt6K9ruT6a1yr
 t5u4OjwihiDenuwsNyo71+35NCMHsAV2B0NWOc9awfOwbcUA8fQ5C2XMct0Q8Tghp0O5
 c36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700697136; x=1701301936;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8Gu1JgAg7xh4M4Sj67PDrdLpqnH744OBKZ8qwSIvF4I=;
 b=G3Ce4w6eseSxlLtsXKg6UGFRpT4CNcNVus3Z+ayYnWiT+CKRugFK6t94KVlITKk2mQ
 Lg5YNCl2ouvRDdJKtz75GOnhDqMieBTnxqWl2yID7bPQqJ+t73Wx2/4jrrJ0uyfch6Dx
 i0sq5QMSCDIveoU9keJBhDAZkr+5g7sF9LvDnqkXEj1doQXgAGgj/jAqFjBXyuFJtuqi
 +SJtGOcg/1+0XDv6sQ6Io0Ilg179r/R8BRk2c2a6LqlEDaFZ5BvASrJDBdfbZ+LnB1gz
 xmDJiyMrPtTjl9Hm5poXLEXM26/7uogctrjU2GyIePi3ncehAQC8t+q/H5MvoxL1Hq7Y
 XYdA==
X-Gm-Message-State: AOJu0YzhcGD74vs91KcPkwQj9iTco6xhYY42H4SMk9P3u94dJJfk8duw
 5sJYHORQXihXMgr1s+7vNEj0DcxBIUux
X-Google-Smtp-Source: AGHT+IG6iQcAwaTouepFHWlLnh0MEXv1KnJaMCgVKI1/bdZaQZSdIHmhZsfcIlDpIDBu2o1+dgO05T8zYYDn
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:e908:0:b0:dae:b98c:6ffa
 with SMTP id
 n8-20020a25e908000000b00daeb98c6ffamr98473ybd.8.1700697136093; Wed, 22 Nov
 2023 15:52:16 -0800 (PST)
Date: Wed, 22 Nov 2023 23:52:00 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231122235202.630114-1-moritzf@google.com>
Subject: [PATCH 1/2] nvme: Fix error code and log to indicate busy
From: Moritz Fischer <moritzf@google.com>
To: bmeng.cn@gmail.com
Cc: zhikang.zhang@nxp.com, wenbin.song@nxp.com, u-boot@lists.denx.de, 
 patrick@blueri.se, Moritz Fischer <moritzf@google.com>
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
Signed-off-by: Moritz Fischer <moritzf@google.com>
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
2.43.0.rc1.413.gea7ed67945-goog

