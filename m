Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943ABD41C02
	for <u-boot@archiver.kernel.org>; Wed, 13 Nov 2024 05:30:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA440890DA;
	Wed, 13 Nov 2024 06:30:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="byii2hdu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BF34890FD; Wed, 13 Nov 2024 06:30:30 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ABC5890D0
 for <u-boot@lists.denx.de>; Wed, 13 Nov 2024 06:30:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5cedea84d77so8418326a12.1
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 21:30:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731475828; x=1732080628; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DKrJbpWRaDd1GYUijQZs/ag6OlEvE2Rs3FfpeY/pjOY=;
 b=byii2hducz2T1LkyF7ERaUwWs24y4/DHrQkye79eeIU0tS3svbGEVnvZMT6i6ZHUxt
 7kUXALQBIedljYD5NZReZrja9tJ0v8GrbwnQWaKf3T/wwWdWV+Umab0EojDDAIVEbkkg
 l0riztPzJa3dBibAOCV9GPCTMXj61Qxj25UkEG5XM51+zQkzR8TjYZQluEujnJsi09ht
 6GqWSo4TWOMSNazX97Y+qxeEXetHau1lTMooxvh6/WFzwdbtJA3VT+BsoseApDnV3wT7
 NqUxz15ll3NnKzvHJIs1tqWRZds0v0iiJvXxfSlgtQSU34MvA40TErD2jf4S2pUe43pR
 Jrgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731475828; x=1732080628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DKrJbpWRaDd1GYUijQZs/ag6OlEvE2Rs3FfpeY/pjOY=;
 b=TzK+kTrGM3SwdDTzwjzHuV+IUaaMBRCQq0eUDWkvuDKklHfyiL6FhQ4rCsFTyNsVk3
 gaRRy2ScGAjn2fnWbgkTP12+y/grO/Dn0u8YWEnARf9cb89ndkXGb+H9caC8Y0VZ2HIt
 vH8/81zo4CYUJb7nM5O6gybhiLuetOSqaSNCleWfHa2M1ApDVEUpl1DmT12CAx6TFA9I
 Qp3ObMLa2zb3ZOBH87J5Q0t6kxHfrK2MXou6sEM6KYS6b4N5zlSxVDbJEHyAGzhXz2oR
 ZnGItjfhSZTspYTgM5UnE8ZknqHPBQcoy/bHQGyql3W0b6Ijj4pAld/oi+kEbIS+WBUj
 JBaw==
X-Gm-Message-State: AOJu0YyJxFtXoGAOYtNg2QybBNiM2reXvMOnyXAh7kenSkXygocfDfGh
 iq8QDzRo7aU8HOVqoHh+pDLo3biyOWJgFd5wCpasRL4V/hbIae4TXTim0h7eMlU=
X-Google-Smtp-Source: AGHT+IECTyaqT1PzHN9SUCivSn7X1YeyOUvZlKtdcaLRtPYHAk/PWUZugDtWQt2j4PeENVN5kuL39w==
X-Received: by 2002:aa7:dcd7:0:b0:5cf:6450:319f with SMTP id
 4fb4d7f45d1cf-5cf6450322emr757815a12.8.1731475827852; 
 Tue, 12 Nov 2024 21:30:27 -0800 (PST)
Received: from lion.caleb.rex.connolly.tech
 ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf537fc229sm1334487a12.44.2024.11.12.21.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 21:30:26 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
Subject: [PATCH] mmc: don't print 'MMC:' if there are no MMC devices
Date: Wed, 13 Nov 2024 06:30:08 +0100
Message-ID: <20241113053023.1870736-1-caleb.connolly@linaro.org>
X-Mailer: git-send-email 2.47.0
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

It may be the case that MMC support is enabled even though the board
we're booting on doesn't have any MMC devices. Move the print over to
the print_mmc_devices() function where we can only print it if we
actually have MMC devices.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 common/board_r.c         | 1 -
 drivers/mmc/mmc-uclass.c | 4 +++-
 drivers/mmc/mmc_legacy.c | 5 +++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/common/board_r.c b/common/board_r.c
index 62228a723e12..232a8fd19f03 100644
--- a/common/board_r.c
+++ b/common/board_r.c
@@ -384,9 +384,8 @@ static int initr_onenand(void)
 
 #ifdef CONFIG_MMC
 static int initr_mmc(void)
 {
-	puts("MMC:   ");
 	mmc_initialize(gd->bd);
 	return 0;
 }
 #endif
diff --git a/drivers/mmc/mmc-uclass.c b/drivers/mmc/mmc-uclass.c
index c8db4f811c2f..56fe29249c36 100644
--- a/drivers/mmc/mmc-uclass.c
+++ b/drivers/mmc/mmc-uclass.c
@@ -384,9 +384,11 @@ void print_mmc_devices(char separator)
 	     dev;
 	     uclass_next_device(&dev), first = false) {
 		struct mmc *m = mmc_get_mmc_dev(dev);
 
-		if (!first) {
+		if (first) {
+			printf("MMC:  ");
+		} else {
 			printf("%c", separator);
 			if (separator != '\n')
 				puts(" ");
 		}
diff --git a/drivers/mmc/mmc_legacy.c b/drivers/mmc/mmc_legacy.c
index 8f8ba34be717..f4a049a4a4d4 100644
--- a/drivers/mmc/mmc_legacy.c
+++ b/drivers/mmc/mmc_legacy.c
@@ -98,8 +98,9 @@ void print_mmc_devices(char separator)
 {
 	struct mmc *m;
 	struct list_head *entry;
 	char *mmc_type;
+	bool first = true;
 
 	list_for_each(entry, &mmc_devices) {
 		m = list_entry(entry, struct mmc, link);
 
@@ -107,8 +108,12 @@ void print_mmc_devices(char separator)
 			mmc_type = IS_SD(m) ? "SD" : "eMMC";
 		else
 			mmc_type = NULL;
 
+		if (first) {
+			printf("MMC:  ");
+			first = false;
+		}
 		printf("%s: %d", m->cfg->name, m->block_dev.devnum);
 		if (mmc_type)
 			printf(" (%s)", mmc_type);
 
-- 
2.47.0

