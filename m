Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A39EDE9B6
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 12:21:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85CD58705F;
	Thu, 14 Sep 2023 14:21:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="BmPEGOKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86D358705B; Thu, 14 Sep 2023 14:21:11 +0200 (CEST)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6733887035
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 14:21:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68bed2c786eso800578b3a.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 05:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1694694067; x=1695298867; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srLYChDeZfUYUPCNNMlISRGplZgWwZlpFwuLNMy2wbY=;
 b=BmPEGOKWQU8+ORtzPQKlwwRzboul/NiEOijeL6dMhvimBrvcgMC5gWtA03bwUqRMFl
 DaJ/UyfkVdkue40/y1NJFgMsybzTMroXXD+2rTtLZaFpUxnZsM7/XCFBGK42YKwYn3sU
 tPLA4TviYFiaDIAoNS0nUPMDsYcEiKkEiYNJsUmFr/bZwd1wx2hBX4vQR5O2LmCewi9b
 IXUJvn0xu/KSsQwSmbUE8q9eN3wlm4rvpYTb4HKoKi6dCwkLtgo38WwnAj6HhBf4/gJ3
 8lPDDZKEDukitjlYK7MmODRGR2SiMA6wQbxnHz7ZogrYQU/HDhBBKcOPWhrYbpdwR2JW
 r6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694694067; x=1695298867;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srLYChDeZfUYUPCNNMlISRGplZgWwZlpFwuLNMy2wbY=;
 b=PGhvauPmlTiZuH6zwDRaRl5PkQlo6F20TqJ9oSd7E9H0FQh94/4WIWbinntv1DK4Op
 /+KXGyZu8fdcIN8xz9VakPW8VzOW53g4RxzCk638U/qVO8192fOdvIA2Kra60468Wa8L
 IlRPoAVsBiLlMKOkyLZBuO9mTWRGvsSUMTv1au2udixTqFRtt3rlv9bpcN4HXZDBfXrz
 MFmxnxc2rG6E45HGinuHDBYfQpjY5f2yzS8mzZgm5Qx9ltwoJ4D84M6ETV+M1AX6lhH0
 ziSBrY1Lsxw1+f5njgL7o/+xL5UEJJhmBK0rf9aFn7wIxprDh9gcxB9kItU3OMINxipj
 SDeA==
X-Gm-Message-State: AOJu0YzjlkqrtDg9k36Gic0flRYgcpVzY298R5hK84DXfVCOnaAVRjEm
 FvTGJesiiDs3QO8EXW86oM6oT6fRm6AscOXe5Nc4HQ==
X-Google-Smtp-Source: AGHT+IFkI8DxvC+ptI/EKlOfQVZsAWOKgG+cKBl7CmUq/YJzQUgLmxanqThlRmexTjaVjS887H28uw==
X-Received: by 2002:a05:6a20:3d93:b0:154:6480:83a4 with SMTP id
 s19-20020a056a203d9300b00154648083a4mr5974686pzi.14.1694694067323; 
 Thu, 14 Sep 2023 05:21:07 -0700 (PDT)
Received: from mchitale-vm.. ([103.97.165.210])
 by smtp.googlemail.com with ESMTPSA id
 t17-20020a1709028c9100b001bdb85291casm1447796plo.208.2023.09.14.05.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Sep 2023 05:21:06 -0700 (PDT)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sean Anderson <sean.anderson@seco.com>, Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v1 1/2] part: Add a function to find ESP partition
Date: Thu, 14 Sep 2023 15:38:20 +0530
Message-Id: <20230914100821.755904-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230914100821.755904-1-mchitale@ventanamicro.com>
References: <20230914100821.755904-1-mchitale@ventanamicro.com>
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
 include/part.h | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/disk/part.c b/disk/part.c
index 72241b7b23..2be0866671 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -841,3 +841,19 @@ int part_get_bootable(struct blk_desc *desc)
 
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
index db34bc6bb7..036f9fd762 100644
--- a/include/part.h
+++ b/include/part.h
@@ -689,6 +689,13 @@ int part_get_type_by_name(const char *name);
  * @return first bootable partition, or 0 if there is none
  */
 int part_get_bootable(struct blk_desc *desc);
+/**
+ * part_get_esp() - Find the EFI system partition
+ *
+ * @desc: Block-device descriptor
+ * @Return the EFI system partition, or 0 if there is none
+ */
+int part_get_esp(struct blk_desc *desc);
 
 #else
 static inline int part_driver_get_count(void)
@@ -700,6 +707,9 @@ static inline struct part_driver *part_driver_get_first(void)
 static inline bool part_get_bootable(struct blk_desc *desc)
 { return false; }
 
+static int part_get_esp(struct blk_desc *desc)
+{ return 0; }
+
 #endif /* CONFIG_PARTITIONS */
 
 #endif /* _PART_H */
-- 
2.34.1

