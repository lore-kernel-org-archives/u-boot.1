Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DEEC52D6F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 12:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA23488B9F;
	Wed,  7 Aug 2024 14:10:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dfoVgIbO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BC6DE866EB; Wed,  7 Aug 2024 14:10:49 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFD3488A6C
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 14:10:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-52efc60a6e6so2654461e87.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723032647; x=1723637447; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jTl+Mx4HhcYWMHe2WfOVOszTfR4rCGOh/hcKmZHYww4=;
 b=dfoVgIbO5f3Di5cFJqzQiw4tfh6gEgY6Bgos31+nyJsY/8kJGlEerRLzhtmBvI4NRg
 D/bzQPm/ZluEiq3hyHutuAa1ugOvkZOD3muNO5EWGDu9yjCdlagz7ON2gwAidkARMfEi
 8OGHW5LdCGddCAmgkN92SFaURqUBClxSa7f4woLZKUdUqlZGD8LVSkKdaUij6U0rjv/A
 7nlA1PFVeC7oq52ciZDfNGkyiVSlnefF12ZHUWnSNyP9xSwAWONR8rc8BeidB3UI7IP5
 132LyVdoMzdxllyp1BccE/Bv8A15aSFiluyeHkK3a5Vx0Rt9754slRegzt9AU/y3Ok2N
 zZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723032647; x=1723637447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jTl+Mx4HhcYWMHe2WfOVOszTfR4rCGOh/hcKmZHYww4=;
 b=e8HLeLU31di7ljHIRDShYnfxzswkJDB9b6DBsrhFkeiWIKuOFVgEGcpu93rD+DX6nW
 5lUS06Fl5i6hzWLU/kTrPXlH5Xberr81orlywbR+RavqkKiWYOTxIWYjrfFPxA8vTwFi
 YQdFoIsL1/VODNTPXInItSYhSgaJcPDJvQ6k4X5V+N3TJS+ZcpEBu9JF7JmybGz/pBIC
 7OmSVTg7FEZu1ZkZoMEvnVYLtqkgNsfsxS6MIrTsQ1+inFBEYk05Xg6VVIt95hz5DJ5n
 FB3SB/H/opEy+f4KeDeksj+TM6psMah2xqMVZtsFB9t7EnWBsELxi3Uve6tSX2GOF40D
 L00A==
X-Gm-Message-State: AOJu0Yybr5sfgUPBjwWIBIqAWW3MolN3NC5ANDZRjY+TU5j3DEx/Brdi
 LRYp+BxZmMW+o+URPa4COS0Dwhuqp7a2VMzN++sm/fiUTu3hhc3P
X-Google-Smtp-Source: AGHT+IFs3NwLmTJ4r5xErSUaDcD86dRApiBaHpIlfZLneWYw+Ip3MMuhFjqc/U/C0rZqvA1ayYVilg==
X-Received: by 2002:a05:6512:ba7:b0:52c:9e82:a971 with SMTP id
 2adb3069b0e04-530bb36640fmr12511626e87.7.1723032646721; 
 Wed, 07 Aug 2024 05:10:46 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5b83a152e4dsm7026597a12.48.2024.08.07.05.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 05:10:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v2 1/1] disk: add TegraPT support
Date: Wed,  7 Aug 2024 15:10:24 +0300
Message-ID: <20240807121024.11318-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807121024.11318-1-clamor95@gmail.com>
References: <20240807121024.11318-1-clamor95@gmail.com>
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

TegraPT is compatible with EFI part but it can't pass Protective MBR check.
Skip this check if CONFIG_TEGRA_PARTITION is enabled, storage uclass is MMC
and devnum is 0. Note, eMMC on supported devices MUST be aliased to mmc0.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 disk/Kconfig    |  8 ++++++++
 disk/part_efi.c | 13 +++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/disk/Kconfig b/disk/Kconfig
index ffa835eb35..75a849ec8c 100644
--- a/disk/Kconfig
+++ b/disk/Kconfig
@@ -49,6 +49,14 @@ config SPL_MAC_PARTITION
 	default y if MAC_PARTITION
 	select SPL_PARTITIONS
 
+config TEGRA_PARTITION
+	bool "Enable Nvidia Tegra partition table"
+	select PARTITIONS
+	select EFI_PARTITION
+	help
+	  Say Y here if you would like to use U-Boot on a device with
+	  Nvidia Tegra partition table.
+
 config DOS_PARTITION
 	bool "Enable MS Dos partition table"
 	default y if BOOT_DEFAULTS
diff --git a/disk/part_efi.c b/disk/part_efi.c
index b1a03bd165..350a8a6dc5 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -318,6 +318,19 @@ static int part_test_efi(struct blk_desc *desc)
 	/* Read legacy MBR from block 0 and validate it */
 	if ((blk_dread(desc, 0, 1, (ulong *)legacymbr) != 1)
 		|| (is_pmbr_valid(legacymbr) != 1)) {
+
+		/*
+		 * TegraPT is compatible with EFI part, but it
+		 * cannot pass the Protective MBR check. Skip it
+		 * if CONFIG_TEGRA_PARTITION is enabled and the
+		 * device in question is eMMC.
+		 */
+		if (IS_ENABLED(CONFIG_TEGRA_PARTITION))
+			if (!is_pmbr_valid(legacymbr) &&
+			    desc->uclass_id == UCLASS_MMC &&
+			    !desc->devnum)
+				return 0;
+
 		return -1;
 	}
 	return 0;
-- 
2.43.0

