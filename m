Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522C9C3DA64
	for <u-boot@archiver.kernel.org>; Thu,  1 Aug 2024 05:48:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C59A488AC2;
	Thu,  1 Aug 2024 07:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ITEfxvcf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAA7588ADC; Thu,  1 Aug 2024 07:48:26 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1376B88ACA
 for <u-boot@lists.denx.de>; Thu,  1 Aug 2024 07:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=clamor95@gmail.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a7a94478a4eso319619666b.1
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 22:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722491304; x=1723096104; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CSKDlCRUkmJthEm50ThqusoNqvaIEj4I2eEkVlMdUsc=;
 b=ITEfxvcfVqcHa4tP7bh3D0XdG1SIl2vCSwLbDZHCehr47ZGwAzgHVuHa5Ni1GL/6jv
 tz30lp1kMMWtz6p+m6u4SsDip5qPArOP1UIRujdefMO2kRhqDv97GGJIlnUji3oTWhc6
 cnk3WNjzYu1UiEJ6wraD/Hu+H72gij3x5DEZRHTOskC0+w696rR7R5/JNPNGrhBLzhHH
 jivcbwSXk0fyfKoJGoxjzAl1U0TH56kbCEJjWH9lXVuekNropIOs3fzux4TltZSf6TF6
 ZgNfsTt4dLiFKJePjpYkvflG4DWO+rMEQlz+Wdcm2OSVKOSn6ZG76Zlh6VJdKKJfeM7E
 EQwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722491304; x=1723096104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSKDlCRUkmJthEm50ThqusoNqvaIEj4I2eEkVlMdUsc=;
 b=fe6DyJ2QHYwIZBqCaeO0WR+YF11FJY2Ypu7Oc2kEhtGzaBCxHL+89UqeqnPj8qt1PV
 ariGk4SanpaNPopblB372wk7OddnaPs62I4waYhd3yJg8YiksV1VtcmjAxOXTYqv8WG5
 wkMJ8PH5Ir9ZgP0AQjMlaCXmfGG+j72Y2oAp75zRcGKiapJ+k3lb1MJDPBJzqVLgWS/8
 bBL+aB1vfcKSh32UJZZSalRo85k9IsODlR6cm/y9d3YCMrQZ3l7i3pJdvCHbKvZJOcc3
 yq1CzDpB+82384MArwuD9NlpWcPySsqOzEWyqHvmwQPV6ONZQkG3cSwCZ3BzmzuYUcHO
 YWpA==
X-Gm-Message-State: AOJu0YyyiZJZsY6HE4mGuUUgZCPjrliQeo2YF09J9wbdbtkgsfhvI/XN
 Ce0z/w1pwWKKJiRtBjlmHXWpK8qKJWO70iqS+hbR1WivPIZ+2dMb
X-Google-Smtp-Source: AGHT+IHDFTuuL9Jw1MrDKuKecKo3lwAP/0YMpM0i8n46hm+GJzFixZRXP34ajXPcvrD2sX6fNffwBQ==
X-Received: by 2002:a17:907:7ba3:b0:a73:9037:fdf5 with SMTP id
 a640c23a62f3a-a7dbcb94058mr18737366b.6.1722491304196; 
 Wed, 31 Jul 2024 22:48:24 -0700 (PDT)
Received: from xeon.. ([188.163.112.54]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23125sm849823666b.1.2024.07.31.22.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:48:24 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Tom Rini <trini@konsulko.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Simon Glass <sjg@chromium.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot@lists.denx.de
Subject: [PATCH v1 1/1] disk: add TegraPT support
Date: Thu,  1 Aug 2024 08:48:10 +0300
Message-ID: <20240801054810.7170-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801054810.7170-1-clamor95@gmail.com>
References: <20240801054810.7170-1-clamor95@gmail.com>
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
index b1a03bd165..3afc871409 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -318,6 +318,19 @@ static int part_test_efi(struct blk_desc *desc)
 	/* Read legacy MBR from block 0 and validate it */
 	if ((blk_dread(desc, 0, 1, (ulong *)legacymbr) != 1)
 		|| (is_pmbr_valid(legacymbr) != 1)) {
+
+		/*
+		 * TegraPT is compatible with EFI part but it
+		 * cannot pass Protective MBR check. Skip it
+		 * if CONFIG_TEGRA_PARTITION is enabled and
+		 * device is question is eMMC.
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

