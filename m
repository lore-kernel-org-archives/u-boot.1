Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE17D59D84
	for <u-boot@archiver.kernel.org>; Fri, 12 Dec 2025 18:26:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8EC38367F;
	Fri, 12 Dec 2025 19:26:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cM2GSDv1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 41DE0835B3; Fri, 12 Dec 2025 19:06:38 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C62D81D6A
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 19:06:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-7b80fed1505so1515704b3a.3
 for <u-boot@lists.denx.de>; Fri, 12 Dec 2025 10:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765562793; x=1766167593; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AphIyp/2QMRgEQTlIdo1nG8jJhkQ09PDAv0B+2dnUnE=;
 b=cM2GSDv1vD2r3Y24vbnKb0EOQWVdZZEPNSzkjV/n8Rf85bikkZKQdMVx4fqMVju7bN
 ckHXiKlHtXPrVdEB9GGw0m5ERc/csQk0W7QqBM5u4veGdRsW82AVf4Wgxfv8Sg7PvKym
 RBnh0tC2lr3o4UiMzmMqPFFCfbeOU0RlO7LmKJ1r40iYLnzSaxM0QhPqwwzy/AJ+mZMm
 taJ3x1MlAa3iCwT+AilxjW8RWjLNPW0vca0SDa3lQWleHafhAuAOJFuN0HxhYvR25pjz
 CriDPLzjVD/w2x9vrbWGBQqzLMGL3cTxhx/OiasBNVsIKcVP0YMeZDtlc8Boi6jExn6E
 vjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765562793; x=1766167593;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AphIyp/2QMRgEQTlIdo1nG8jJhkQ09PDAv0B+2dnUnE=;
 b=boFwu++B+ueN7RfLmx64ko1GjLcNgpoKwTTPUfP0C4QBuK+6uNzsA3I5UkNF9512QN
 09O0shI3rhxVW5o0e+MYEzQC0DjJLCfvVpjhxrCZTpLKk7qj2yXA9yxS8veHAwTrWyRH
 yUxp+z5EcNV03ojtxhpcsl6ZXbRZKihwj7qZ9kKZ788iKQv7y1ln7LJ5bUxGPKv83KK3
 sJYPYJdBhSKpqkuthm6952bEqn7I0BOWOsePoXrlW9n/Rbzt8tz8pZxHJrQTRJ8dbIZf
 j0aym8O5IeuduXYEoLfm/V+1nMTt6kyMvbwP6OBXf8pdexnHuxsMcc2aL/ZsmCX6r0HJ
 foJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRP76NqYjnJV8JtzMlcgoVIwXJJ4tWGyNFHq11OGsyEbZnaiDkm5kDutWr7FxxeKI73taPUxs=@lists.denx.de
X-Gm-Message-State: AOJu0YxemHRXRNXsNvlymsPL80yfqIvSWMMJ2yeUfmKI93/rfICX3ZHz
 K5FqaLaqVU7WXKB8fT95+WVk8dif14pL1QDILoeol+eovzb93yxrCFsoif1WAw==
X-Gm-Gg: AY/fxX4gedu1cydqjtcirc/qVbNfByYvQYY0dffS3IUltVDiKyJF+tdFA6NOGIXVfP4
 eugf4aIQajCllzEabJE6Z53ajEXeSyb1Pq3+Qn3rf6APBw+73tXoT5kmbTZtwVDIA+xl/ND+Pju
 dX97xPNLnRJsxrKciYjmRo+LyEPLRUxfXzGvvjLSLLIDDevCG1Fi0+1u/dmAtyY6dLlX+ITsxGe
 ce+Hqlqnrqo3E6Wm/SPjauwEkYx/yrmMF3ubO6S1PDHPpNdTHB7nFLvjiacoav5yn5jEUWJjOQH
 loM5d1d40yGigFgQPz1M+ZYtFbK6bBMdJ37sg+d5JHLaahl8g4EgIFteUmgbJwetfcIvax/378v
 TC2NsabiGDa9MbUyTIDplJ/+jziTgfMfVgzAPA+IsuaHVYRsuIh03rrRKea4b9UZyKMgwz8p3RN
 lPnJQ/C5zaDaFSIu6Ko41F0qYq/nXbCRDk+SD01EVKV7RSzjWKu2s3W1KaIPsp+W50Kl1CsrLTZ
 Uu4UOXdNmUWjCDO94pKSE+Ojit2CihDz50=
X-Google-Smtp-Source: AGHT+IFAHRzA7/kRZ71sqR3Ybaa6Xn9DG40ZMfO8IWsJtOIqkxZ8OUij3fTHkE9pJ61D0aIVMGTh5g==
X-Received: by 2002:a05:6a20:6a28:b0:364:387:8f4e with SMTP id
 adf61e73a8af0-369ae490337mr2945298637.34.1765562793409; 
 Fri, 12 Dec 2025 10:06:33 -0800 (PST)
Received: from visitorckw-work01.c.googlers.com.com
 (14.250.194.35.bc.googleusercontent.com. [35.194.250.14])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c0c264211cbsm5590255a12.11.2025.12.12.10.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Dec 2025 10:06:32 -0800 (PST)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: lukma@denx.de,
	trini@konsulko.com
Cc: andrew.goodbody@linaro.org, aford173@gmail.com, sean.anderson@seco.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de,
 Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] clk: versaclock: Fix incorrect error check in
 versaclock_probe()
Date: Fri, 12 Dec 2025 18:06:15 +0000
Message-ID: <20251212180615.4112751-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.52.0.239.gd5f0c6e74e-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 12 Dec 2025 19:26:55 +0100
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

The error check during the registration of FODs is incorrect. The code
currently checks IS_ERR(pll_name) immediately after assigning
fod_name[n].

Since pll_name is checked in a previous block, this condition will
always be false, causing any allocation failure in
versaclock_get_name() for fod_name to be ignored. This could lead
to usage of an invalid pointer.

Fix the condition to check fod_name[n] instead.

Fixes: dcf2cee77f2d ("clk: clk_versaclock: Add support for versaclock driver")
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 drivers/clk/clk_versaclock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
index 19a787eaf0c..1dbde75f180 100644
--- a/drivers/clk/clk_versaclock.c
+++ b/drivers/clk/clk_versaclock.c
@@ -945,7 +945,7 @@ int versaclock_probe(struct udevice *dev)
 	/* Register FODs */
 	for (n = 0; n < vc5->chip_info->clk_fod_cnt; n++) {
 		fod_name[n] = versaclock_get_name(dev->name, "fod", n);
-		if (IS_ERR(pll_name)) {
+		if (IS_ERR(fod_name[n])) {
 			ret = PTR_ERR(fod_name[n]);
 			goto free_fod;
 		}
-- 
2.52.0.239.gd5f0c6e74e-goog

