Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B096C47DAF
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 11:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EA47D87859;
	Mon, 22 Jan 2024 12:10:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="gd2ICZta";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25D858780E; Mon, 22 Jan 2024 12:10:47 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEDA987859
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 12:10:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-7beda2e6794so69371439f.1
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 03:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1705921843; x=1706526643; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yUkMSoCgNFXmEJbIbnFmCKZE3HBrjk6TiodNcIrCRAw=;
 b=gd2ICZtawZ8SUVzgPXNJKBhCCyogj8WSXmwQzPXBJUxQpy22FUgf9JuWC0PxrKrGzI
 2ct2aXP710FW/MAqFhokjSCvRT73ZOp0ldHxFf2X2fl/UbHPWQ2qB9P/63GonPP1WiX2
 BrjP8mFqxsp8s2TKZ6D0MhhL4qxj0ozE4vA10YjT070jIasA2FOVu47k+dCcs97HmYXI
 16K+nvnVuIBhTRPF3VltOANmtr+lrb0Qe4ndXXTbDjZAJCLDaw6C29COK22nOKnRwgKL
 OyqBbdXj9izxxIMW2QxDAtYrI3dNbxVdoPWxdHZoSLvleXYQP4aaA6Wcdqqx3mGmZB0I
 ZXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705921843; x=1706526643;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yUkMSoCgNFXmEJbIbnFmCKZE3HBrjk6TiodNcIrCRAw=;
 b=GRpZGsguAjOzf3KfHpfjxMxK4uHJgDQ3ouTx36THkbcVWaIIhOWB1AUdlAcTnsnsEa
 Tc6Wq4SIEPsI/YOB9INE883em+9AlabGsFHNpN3T8lNqk7v6hd/YcB+6Mhii1qIdfdbm
 4SrSbRC9yp+DX8FQEGOvBtwHceRhne9OhV/QfgD6JRNZz6vT/nyMSWAErvx5gmp2p1kL
 E1VUxfSHyF5PeEHWVepV2dXcz+1dbee0PEYXEsFrQ9utITko64Qcswz+RbLa4/rlDmU8
 1wtxAXc5wRKaz71evOC6pzfRIB9GBgDUIsZGL2eKRyrDe14TTRLJGZM6zA2iiVTgK09o
 WZHQ==
X-Gm-Message-State: AOJu0YxKvQOYblt+WjrkE1F+JnUtR56zPW9KvvBwjuQHDo5uUv2IdcE4
 fLjwrNptHoTjOTf98pabioKlefeJ/29GqWA751Rc5h/310HrMSIIGeWlxN5GzePSt5qsmbH9fVf
 9cBqceg==
X-Google-Smtp-Source: AGHT+IHiRU7BcB+gIy0kqBhssbeYP22mw6+rym5y7juPOUXMKrVBskGF26VNxtXfg1Wkt9c03zPX4g==
X-Received: by 2002:a05:6602:1681:b0:7ba:c855:9ce5 with SMTP id
 s1-20020a056602168100b007bac8559ce5mr3175092iow.11.1705921842988; 
 Mon, 22 Jan 2024 03:10:42 -0800 (PST)
Received: from ThinkPad-T490.dc1.ventanamicro.com
 ([2401:4900:5306:c1c1:3bc5:9efa:4b71:9731])
 by smtp.googlemail.com with ESMTPSA id
 z16-20020a6b5c10000000b007bf2bfd2da7sm5206365ioh.28.2024.01.22.03.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jan 2024 03:10:42 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Johan Jonker <jbx6244@gmail.com>,
 Joshua Watt <jpewhacker@gmail.com>,
 Tobias Waldekranz <tobias@waldekranz.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v3 1/2] part: Add a function to find ESP partition
Date: Mon, 22 Jan 2024 16:40:21 +0530
Message-Id: <20240122111022.229805-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240122111022.229805-1-mchitale@ventanamicro.com>
References: <20240122111022.229805-1-mchitale@ventanamicro.com>
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
Changes in v3:
- Fix part_get_esp signature and header in part.h

 disk/part.c    | 16 ++++++++++++++++
 include/part.h | 13 +++++++++++++
 2 files changed, 29 insertions(+)

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
index db34bc6bb7d..1aa6fe44ffb 100644
--- a/include/part.h
+++ b/include/part.h
@@ -690,6 +690,14 @@ int part_get_type_by_name(const char *name);
  */
 int part_get_bootable(struct blk_desc *desc);
 
+/**
+ * part_get_esp() - Find the EFI system partition
+ *
+ * @desc: Block-device descriptor
+ * Return: the EFI system partition, or 0 if there is none
+ */
+int part_get_esp(struct blk_desc *desc);
+
 #else
 static inline int part_driver_get_count(void)
 { return 0; }
@@ -700,6 +708,11 @@ static inline struct part_driver *part_driver_get_first(void)
 static inline bool part_get_bootable(struct blk_desc *desc)
 { return false; }
 
+static inline int part_get_esp(struct blk_desc *desc)
+{
+	return 0;
+}
+
 #endif /* CONFIG_PARTITIONS */
 
 #endif /* _PART_H */
-- 
2.34.1

