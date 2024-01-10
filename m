Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D65C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 05:05:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A25F878B1;
	Wed, 10 Jan 2024 06:05:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ILKXhFU9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F5F0878B1; Wed, 10 Jan 2024 06:05:00 +0100 (CET)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com
 [IPv6:2607:f8b0:4864:20::114a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6632986D23
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 06:04:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=3eSWeZQcKBnAacfWhnTUccUZS.Qcai-PcchZWghg.RSbl.RS@flex--moritzf.bounces.google.com
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-5eba564eb3fso64577377b3.1
 for <u-boot@lists.denx.de>; Tue, 09 Jan 2024 21:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1704863097; x=1705467897; darn=lists.denx.de;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qfUu9qKYebs02MzE7qC5FwMIntLww9t9NcP4q4OWkmg=;
 b=ILKXhFU9BOVrn+RiPTs2SrzBUuP1q54naK4oVvrHPiTtkyXRVJUWVpPxr6uBsjtM8h
 erUCUdYaOyap81blTYA87rPnNZ1B5E8wdew7+y0vB1EOypefQt3XXfLEkeVb/vgnQfJy
 7L4SbRZU6+wYu01BGs6NMLS2K/tvcuELm+OIYty9kBGbkYmdb6dHOGj3uHYkHibLuDHD
 x+BOgLM8GPHtemJG+QY1+46EKTIekrcm0KbO/7VQwNuOvfDkEAgIDzzOgLqryMSZNGgh
 FZBuZX1B++jDLenzRaWhD1KLOR4ZOtzV1TOO3MMp928XbL9/vEFMiwx5D3ECX3bwl90w
 Nqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704863097; x=1705467897;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qfUu9qKYebs02MzE7qC5FwMIntLww9t9NcP4q4OWkmg=;
 b=Wqzfadc0H2A4iIKla12Om01JBgo5lM0X1RTMSr3rMWSbpE7nDuhokP81Ic8pJ5zp0q
 FxypX7GKtF9R2FSNk7BgN3Nd73CRF8SWoXWAX5PfgmYFGnGJVOfvlKtTPyhUCJPWihve
 xvAxS0mxFF0JlW/hDhCHokOTytgpxEduqGRLb+UvGVFrlAAzHszwNot7x6J8N+eftbEI
 kyNkCk69mo7YVP/dEzyXedaeVd64HXKAL5CT1uzygIWMGZigaZ+1mSUI2UKAwFSpRETI
 1x8G6n9hZU1P7FknFe9/UN3/tyU8nBmhReV8E4FEvC0CIjZ4GgQivwAuk5O0/ZeGQnT/
 ruGA==
X-Gm-Message-State: AOJu0YylX/Xw8ltLTJlbBtk98lQfeqjdFhwfz+Om67v5bgCSk2KcFE6r
 CXMod+Qwg4mD35vthDH7/b8siQH2K84BPV9/ydA=
X-Google-Smtp-Source: AGHT+IEcu8tIvpYcl/PhFFfj5cRcMOvnKXWKNoqNjEdLK8NMR6sskgSs9mi6D0adLHJ02Brf8i2+tcH2ZlKs
X-Received: from morats.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:d9e])
 (user=moritzf job=sendgmr) by 2002:a25:8012:0:b0:db5:4766:e363
 with SMTP id
 m18-20020a258012000000b00db54766e363mr158148ybk.6.1704863097166; Tue, 09 Jan
 2024 21:04:57 -0800 (PST)
Date: Wed, 10 Jan 2024 05:04:47 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20240110050448.1441657-1-moritzf@google.com>
Subject: [PATCH v2 RESEND 1/2] nvme: Fix error code and log to indicate busy
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

