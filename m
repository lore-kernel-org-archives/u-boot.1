Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B95E7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF40B80312;
	Thu, 19 Dec 2024 19:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R0l2bAuC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89AC48021A; Thu, 19 Dec 2024 19:29:20 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60A2A8021A
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3a9c9f2a569so7593385ab.0
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632956; x=1735237756; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YvP3mZlpqQ9O31IN0/D3RWtN4h/a7ECbVueMxPoJT84=;
 b=R0l2bAuCDyCxYBhlG79653bJJIfTHlKTHhUN1M7mY6DhJPt4+yuFt9184z8G4AW78K
 7HLilhq9HCS2FLs7lgy1EiJxahGAJPRfg54D3kfyeY/fLb+TM2MlJIUJWaLlDH2RLPAl
 o0+91uESoKCjNV2NsE7GUCRNjSU6uQlCFfX9U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632956; x=1735237756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YvP3mZlpqQ9O31IN0/D3RWtN4h/a7ECbVueMxPoJT84=;
 b=k5Ug13KWX2ZU62UAM+1DTevkyiS7NIVGJJja1rblDpgUjx1SAlIGQienFJTorN7R8a
 8QuPwocilSaWlKp3Rv8oB9tdpt6QrboQekeNKUG5v5vrJupqc5rgCd8qop5cS/tUYd92
 MXssDgXkBSsa5Qp5tg3cMh2j8LrhR081ce5W57XQ/yddc1SmByI7OaUlgqU62aHyXFmi
 tz3x3dACjiJ3LpMPvGweA5Rli6BOqKSoT9IoyOn12MnDwHx4Mth6QSGP/SEM7GTs/202
 pg8aTuCAoRXlVkGzIHMsYVMaL96yH1zeWnVH5ows7X60QgWV8BtcNie5s4YLVTxwnQmT
 uRMA==
X-Gm-Message-State: AOJu0YzhOeV36pLCeaFOFtDHKZ0JPr77sLfi2zF/ce9R5Epta4Isii3w
 4JPmAK72Dp4/bZmDmS2apNPrZinPrzNJnswEmL6LRYKYEKxx6c1m/mryCFE2bR6HH57SPH4kEoE
 =
X-Gm-Gg: ASbGncs5LNCteVMEF4cEgP9W31ZMF4Samrh6d0ehhN3nXk+VDsjnJ5jGzP/RdSpSviz
 LYrU02cP5RqYnPQH/1SVTJEbMn6tUJ+CqBskckUEoAnpAgS6sGN2ZLH9GECokGJtQ8DL0SoUTMd
 ofWG3IaGiGIjSXCtYn7yB8FsFr88n8hjAj8DeDgXckqaqJYoMNLi5l8ANWnelDNog6bIhVxQXsV
 90Q06biWbt2AAIHW1loE+jLRnHw1bPsFDIAyl7tgvH3dHP6JIehq7hDck7RAK7AE5O5pTuplaYG
 gN2mwnRBkOfueghVgQ==
X-Google-Smtp-Source: AGHT+IEgWqOBmzXDN+mkvAgv4d4m0l2ZPOILKAF/zs/+Igs3ja61tcICEFIKSyegB7cSy+1P5ppn7A==
X-Received: by 2002:a05:6e02:3891:b0:3a7:dfe4:bd33 with SMTP id
 e9e14a558f8ab-3c2d2561dacmr1337755ab.6.1734632956161; 
 Thu, 19 Dec 2024 10:29:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:14 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 01/19] spl: mmc: Avoid size growth in spl_mmc_find_device()
 debug
Date: Thu, 19 Dec 2024 11:28:49 -0700
Message-Id: <20241219182907.2609704-2-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

The for() loop ends up being in the code even if the log_debug() does
nothing. Add a condition to fix this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Add new patch to avoid size growth in spl_mmc_find_device() debug

 common/spl/spl_mmc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index 1f696593216..fe4230170a0 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -81,8 +81,10 @@ static int spl_mmc_find_device(struct mmc **mmcp, int mmc_dev)
 	struct uclass *uc;
 
 	log_debug("Selecting MMC dev %d; seqs:\n", mmc_dev);
-	uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
-		log_debug("%d: %s\n", dev_seq(dev), dev->name);
+	if (_LOG_DEBUG) {
+		uclass_id_foreach_dev(UCLASS_MMC, dev, uc)
+			log_debug("%d: %s\n", dev_seq(dev), dev->name);
+	}
 	ret = mmc_init_device(mmc_dev);
 #else
 	ret = mmc_initialize(NULL);
-- 
2.34.1

