Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC934C47077
	for <u-boot@archiver.kernel.org>; Tue, 16 Jan 2024 12:37:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E4E879F6;
	Tue, 16 Jan 2024 13:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="QL/C3vuV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E21879D1; Tue, 16 Jan 2024 13:37:02 +0100 (CET)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02F6E879A3
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 13:37:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso4926900a12.2
 for <u-boot@lists.denx.de>; Tue, 16 Jan 2024 04:36:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705408618; x=1706013418; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VTNaSM9U0EZxYwK3bD+iQzK6ozH5SJ+wTFzT0gjtXdM=;
 b=QL/C3vuVRrFev7oqn18wmYdcuAUFB3+A1yaJ4WXaIt7AYwwviuvRiFizscwrpCX7Gi
 4TaY8/zTFnybvnET4pSR6FYWKj8Nam0SWCgf3EseMkYrd0D6e2y5kU/rGDwDxN5cEyQP
 52nG9chkeAdwnXjsUgkVsvEPeytglVggB2SrpAdSDTlNnYFOGNa15reUjNWvQK3ujCXH
 DGzDipcrQS3GQBh0007hiN72iLjDSyo67MS52NhWAQS01q1PtVDYvaF0vxGVBrZw51wV
 k9Xw+ytAr0ZBVpzKk/GOaXxU8p0WtwQgId4gpBagM9TTqbwsa/xsAQwvuejpR7GlLeya
 LQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705408618; x=1706013418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VTNaSM9U0EZxYwK3bD+iQzK6ozH5SJ+wTFzT0gjtXdM=;
 b=BD18J79AFCPuH+9Kamg4bzgpPMpPhc6r1CHR6wGdYLXrAtexPQZ46JG0Zl78oyu+fR
 4+slp9qLrpjGbD+H8JXgRDUpwsuiOqOieNgVR7/aTxL9uwZdNF6olTuEniFGtewBf7bq
 WaDx8IVVSrdWL7qcp8iXiCgeiJVFXi839DLKPA2Ww/mFetIgLulZc2OHsWIwq/fRAH0J
 9A7SVcY+hFUPpEt+YQ297yhi4nVTVc9PF9xWSKKjwZZFQhJzrb4X9TF6uRqlq4BNn0Cw
 OktYRn7sMPSsNZTg/BlJ9pF7fL/W2FHalNzwg0yZ7SN0/5fJFPz1E1JzWLIuGW9Y4Xrd
 tvQA==
X-Gm-Message-State: AOJu0Ywv4kHC8najDVD+aqo+mEq3/t17gtSwmGzmGMSusve5V3r6/Qag
 uL8YI7oqlcwio0XCPYW8eLrHWergUM8ADw==
X-Google-Smtp-Source: AGHT+IGLcdiOhXL/CzaQx0GwmfHofKil/0620liozIESryP/8h7MTs/xq4uTa6wGjaW6lGn+lwgEZg==
X-Received: by 2002:a05:6a20:d046:b0:19b:1f00:29d3 with SMTP id
 hv6-20020a056a20d04600b0019b1f0029d3mr1506406pzb.7.1705408618233; 
 Tue, 16 Jan 2024 04:36:58 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:562a:8545:ac:19eb:49f7:baa8])
 by smtp.googlemail.com with ESMTPSA id
 mt1-20020a17090b230100b0028e8160327esm449544pjb.0.2024.01.16.04.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 04:36:57 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng@tinylab.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Johan Jonker <jbx6244@gmail.com>, Joshua Watt <jpewhacker@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] part: Add a function to find ESP partition
Date: Tue, 16 Jan 2024 18:06:42 +0530
Message-Id: <20240116123643.563412-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116123643.563412-1-mchitale@ventanamicro.com>
References: <20240116123643.563412-1-mchitale@ventanamicro.com>
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

If a disk has an EFI system partition (ESP) then it can be used to
locate the boot files. Add a function to find the ESP.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 disk/part.c    | 16 ++++++++++++++++
 include/part.h | 11 +++++++++++
 2 files changed, 27 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 36b88205eca..6b1fbc18637 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -848,3 +848,19 @@ int part_get_bootable(struct blk_desc *desc)
 
 	return 0;
 }
+
+int part_get_esp(struct blk_desc *desc)
+{
+	struct disk_partition info;
+	int p;
+
+	for (p = 1; p <= MAX_SEARCH_PARTITIONS; p++) {
+		int ret;
+
+		ret = part_get_info(desc, p, &info);
+		if (!ret && (info.bootable & PART_EFI_SYSTEM_PARTITION))
+			return p;
+	}
+
+	return 0;
+}
diff --git a/include/part.h b/include/part.h
index db34bc6bb7d..30e049c8f19 100644
--- a/include/part.h
+++ b/include/part.h
@@ -690,6 +690,14 @@ int part_get_type_by_name(const char *name);
  */
 int part_get_bootable(struct blk_desc *desc);
 
+/**
+ * part_get_esp() - Find the EFI system partition
+ *
+ * @desc: Block-device descriptor
+ * @Return the EFI system partition, or 0 if there is none
+ */
+int part_get_esp(struct blk_desc *desc);
+
 #else
 static inline int part_driver_get_count(void)
 { return 0; }
@@ -700,6 +708,9 @@ static inline struct part_driver *part_driver_get_first(void)
 static inline bool part_get_bootable(struct blk_desc *desc)
 { return false; }
 
+static inline bool part_get_esp(struct blk_desc *desc)
+{ return false; }
+
 #endif /* CONFIG_PARTITIONS */
 
 #endif /* _PART_H */
-- 
2.34.1

