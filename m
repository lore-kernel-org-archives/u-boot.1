Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ABFEC369A1
	for <u-boot@archiver.kernel.org>; Tue,  8 Apr 2025 09:14:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF6FB833C6;
	Tue,  8 Apr 2025 11:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="C1F388t1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBE8C830F4; Tue,  8 Apr 2025 11:13:47 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B10F4833AD
 for <u-boot@lists.denx.de>; Tue,  8 Apr 2025 11:13:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43d0c18e84eso27168575e9.3
 for <u-boot@lists.denx.de>; Tue, 08 Apr 2025 02:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744103625; x=1744708425; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mAe4tHQP5khDrN77TZDHRTl0ByXEeF2B4kSGsel0u4Y=;
 b=C1F388t13Ryb+/Sg+RjzAnD1zcHgGg+eB9Y71jkW38Rvb7yBPsF9PAFjySzrsgo721
 YOVrLGqVxykocSQSjMXclM7RDlNhMS4mZGG1gxrKZMWa7dWM6ZUHYZHr7FStr4uk/1Pl
 yREPXkzZTeRuM1kljvbSdIRTyi779maY7WKv5Nt+eGQiWQW3qtXvNFINFlSsJEhxmoP5
 0A4vSLwhLpvI9H2qY4i/oulYiQ7j3fLtvjDh41d2tvZyS4MRaokKxiq8K8nKHlGaHcJT
 ECF04WdnmV6lf+9B8evaV6ZkAbrMc+zRP3lxLSLS5o+0tREUQgU0jxuE2fcw2NS0I8uB
 1DsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744103625; x=1744708425;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mAe4tHQP5khDrN77TZDHRTl0ByXEeF2B4kSGsel0u4Y=;
 b=m85OMq2MdtrDH+nMKvk8HQs7+rBc460/OfYnlp96dF2JhbT+/dDxwNp/P1jMSKaJqh
 8LNpIY6Eckfx0Fhc2ds9MmTkGE0AHtNdAQgQ4/NgbnsBT5zD8YRaRslS1eB71r6yCJ6S
 qX+Gr8xwPPggNNliJOrMTwAdpmyRpIgV+TLFAvo4rXg0vRDL/e5xH6gSSSuup4TQjSDJ
 TV13bh7GSdUP6iRFXi+/uEo+pvcQ1aRaNENbR1QqvBv/jAQxRy/QvMmBLn+sJ66bhE06
 vKAp8rqGlhnaliL47IMHuOwwM9KHZGaJU8XSpIsdmDB3M4Npu3apvY3ZQ6CxvLRwSrS5
 yLsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMlNo7zFlma/JqN3GqxjgXYhxJdCa5C50p4JwuT/LexBM0DgLTXOJ6plZG3C7BCmzXZgGZiTw=@lists.denx.de
X-Gm-Message-State: AOJu0YxkCSdmIln9Uz3vqbffHUjzJ3E9ZT6oorJDUsIzoAN+fNWPvrWk
 btEBvBIcb12k2Zg/gz5mQm29u7u1KHtnZJ43QDRXqu6rw1+pkkGw+0gROs/cRbQ=
X-Gm-Gg: ASbGncsZMejmzI4k8NbqOHCHXuDmpcfCDYkBPw3OCh/I4L1TroB7kYD10tZiPcRUNdx
 vMerKPn7Zhe4Z/GRnukHfIC5+FUqye3IumB+hBdhHkWc6N2gfGqgPSqxas7yzCvd8aeUgffiVPO
 XebpPZ3T5jqb+zRiOD3TAGuDcMAWAHVo7uOdZI+NpZBObJmwWFQvBhIVWXHFsN758ADgnJgOw8G
 1OyqYZGzlYNQ01KkTGgqHczD/vn8HYqwHoW7JAw4JR4tZEuqjCePBLY4FhixDqMCFNKU1f3hsH5
 It+O1V346EUC04B804zl8V0thAX0J1hNKxQcOUcTbC5acS/qVlnm4Z3VjuqvVrysTA==
X-Google-Smtp-Source: AGHT+IFNioOcA/4731dais8d6kICqBylAlzNDqCP8FcLRRkYSYCa1yNq0yqlGPnf5ihImcTf6i8z6w==
X-Received: by 2002:a05:600c:3d06:b0:43d:1c3:cb2e with SMTP id
 5b1f17b1804b1-43f18908631mr1210565e9.17.1744103625101; 
 Tue, 08 Apr 2025 02:13:45 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec366aa29sm155056555e9.39.2025.04.08.02.13.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 02:13:44 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 08 Apr 2025 11:13:40 +0200
Subject: [PATCH v2 1/3] part: add part_get_info_cached() API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-topic-gpt-cache-v2-1-de76e47debb7@linaro.org>
References: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
In-Reply-To: <20250408-topic-gpt-cache-v2-0-de76e47debb7@linaro.org>
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5729;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=UiBwH4PW7AbDnj3cPMfGLbVVQiR1T4VFUD/X9WbUuXk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn9OjGCcRuVr2Zkr+4bJ/sw32gaQH5v243yXUj326V
 NBAqZp2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ/ToxgAKCRB33NvayMhJ0RZnEA
 Ckt9C3Cooz1E/89vf3GvCQG0UzFAxz0QTCjltUJtWM8utBUeR3n4+DSNmWWjWciw4gB8xFWPYFACRz
 qVtFatCBDZFg6L9aAPGgmE7vVnYVbu9Q1Yr/tKJhfsbvFZkylhYXQtPH5qlENJqHXxEKcUN88mGL69
 /iIQj0z8g5iAx/lulO9HG3D5bHwKMZ00RoMsCZg+J5pGjeKrzSv2shh4LUsAgAa7xbghtChTckrhUt
 4TQwqYKcpHhRx3E0znPacqXdkeVmY3rtM/xbmSkb/Cts9O4P+PSpVXd/4ltr5iq8bQf2FbzCqiv7qq
 Lux8a+sSKqrb4Gx0/nbVH1bgJ1wQbHKQp0vRpIAFiHYyhSGEvywHLzv1yff+5rRLYSzo/b2WemTkhJ
 IAhCHepH/ckUFpl1i94rKFBSWvPW2rljLcvsj/1H6UI0Ttb4MlFuXGE9zODoPCWPRfww0d7kOw89K5
 8Jl0Iuxy41KcidZUfFH2Lj/tnaTOh0vyQ2q+BatDb1vMKmF3lTC495ekWT7VwBBpm/LBvcceVyxVC1
 LMobq8ZSeZ04TYwUh1l5AUJNSK55n25IXE3lvMnp4xXfy2fql3FMKqFOfqtalUiso+TQaqr8OIzFI5
 KsDlsNdNgNjMNCtO2ahGTvrQ5dBeMUCz9Lc2iOuRV0yp/ZWGHLrAO2ytSwKw==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Introduce a new part_get_info_cached() API that's used to
get the part_info of a blk_desc allowing to use an eventual
partition scanning cache to avoid rescanning the entire disk
partition scheme for each partition number.

The part_get_info_cached_free() is also added to hint the
partition code to flush any cached data from this disk.

The equivalent ops are added that directly maps to those
added functions.

This API is designed to be used as a direct replacement of
part_get_info() in codes scanning all partitions for a same
disk, like in blk-uclass. With this, a lot of unnecessary
computation is saved, leading to a faster boot time when
partitions are scanned, especially with storage medias
with potentially multiple large hardware partitions like
UFS, NVMe or eMMC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 disk/part.c    | 55 ++++++++++++++++++++++++++++++++++++++++++++-----------
 include/part.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+), 11 deletions(-)

diff --git a/disk/part.c b/disk/part.c
index 303178161c083ec6e1b767b4f06ac5773576ca60..1d09c0511c75d457c81cab040c3f5caa924ee945 100644
--- a/disk/part.c
+++ b/disk/part.c
@@ -335,8 +335,8 @@ void part_print(struct blk_desc *desc)
 		drv->print(desc);
 }
 
-int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
-			  struct disk_partition *info)
+static int _part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
+				  struct disk_partition *info, bool cached)
 {
 	struct part_driver *drv;
 
@@ -356,24 +356,57 @@ int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 			      desc->part_type);
 			return -EPROTONOSUPPORT;
 		}
-		if (!drv->get_info) {
-			PRINTF("## Driver %s does not have the get_info() method\n",
-			       drv->name);
-			return -ENOSYS;
-		}
-		if (drv->get_info(desc, part, info) == 0) {
-			PRINTF("## Valid %s partition found ##\n", drv->name);
-			return 0;
+		if (cached && drv->get_info_cached) {
+			if (drv->get_info_cached(desc, part, info) == 0) {
+				PRINTF("## Valid %s partition found ##\n", drv->name);
+				return 0;
+			}
+		} else {
+			if (!drv->get_info) {
+				PRINTF("## Driver %s does not have the get_info() method\n",
+				       drv->name);
+				return -ENOSYS;
+			}
+			if (drv->get_info(desc, part, info) == 0) {
+				PRINTF("## Valid %s partition found ##\n", drv->name);
+				return 0;
+			}
 		}
 	}
 
 	return -ENOENT;
 }
 
+int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
+			  struct disk_partition *info)
+{
+	return _part_get_info_by_type(desc, part, part_type, info, false);
+}
+
+int part_get_info_cached(struct blk_desc *desc, int part,
+			 struct disk_partition *info)
+{
+	return _part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info, true);
+}
+
 int part_get_info(struct blk_desc *desc, int part,
 		  struct disk_partition *info)
 {
-	return part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info);
+	return _part_get_info_by_type(desc, part, PART_TYPE_UNKNOWN, info, false);
+}
+
+void part_get_info_cached_free(struct blk_desc *desc)
+{
+	struct part_driver *drv;
+
+	if (blk_enabled()) {
+		drv = part_driver_lookup_type(desc);
+		if (!drv)
+			return;
+		if (!drv->get_info_cache_free)
+			return;
+		drv->get_info_cache_free(desc);
+	}
 }
 
 int part_get_info_whole_disk(struct blk_desc *desc,
diff --git a/include/part.h b/include/part.h
index fcb3c13dea4de6346ad98d6ce320ef36747dda85..8c98865146306fb66509576068c45de01b9cedb6 100644
--- a/include/part.h
+++ b/include/part.h
@@ -216,6 +216,34 @@ struct blk_desc *mg_disk_get_dev(int dev);
  */
 int part_get_info_by_type(struct blk_desc *desc, int part, int part_type,
 			  struct disk_partition *info);
+
+/**
+ * part_get_info_cached() - Get partitions from a block device but save the
+ * disk partition map between different partitions.
+ *
+ * Call to part_get_info_cached_free() is required when scanning of the
+ * block device is finished.
+ *
+ * If the partition driver doesn't support cached part_info, the
+ * normal part_info will be called instead.
+ *
+ * @desc:	Block device descriptor
+ * @part:	Partition number to read
+ * @info:	Returned partition information
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+int part_get_info_cached(struct blk_desc *desc, int part,
+			 struct disk_partition *info);
+
+/**
+ * part_get_info_cached_free() - Free the saved disk partition map
+ * from a previous call of part_get_info_cached().
+ *
+ * @desc:	Block device descriptor
+ */
+void part_get_info_cached_free(struct blk_desc *desc);
+
 int part_get_info(struct blk_desc *desc, int part,
 		  struct disk_partition *info);
 /**
@@ -463,6 +491,22 @@ struct part_driver {
 	int part_type;
 	/** @max_entries:	maximum number of partition table entries */
 	const int max_entries;
+	/**
+	 * @cache_free_cache_free:	Free any parsing data stored from get_info_cached()
+	 *
+	 * @get_info_cache_free.desc:	Block device descriptor
+	 */
+	void (*get_info_cache_free)(struct blk_desc *desc);
+	/**
+	 * @get_inf_cachedo:		Get information about a partition, and save
+	 *				the resulting parsing data for the next partition.
+	 *
+	 * @get_info_cached.desc:	Block device descriptor
+	 * @get_info_cached.part:	Partition number (1 = first)
+	 * @get_info_cached.info:	Returns partition information
+	 */
+	int (*get_info_cached)(struct blk_desc *desc, int part,
+			       struct disk_partition *info);
 	/**
 	 * @get_info:		Get information about a partition
 	 *

-- 
2.34.1

