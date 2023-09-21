Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B4BCD493C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:57:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0EA886D4A;
	Thu, 21 Sep 2023 03:57:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Kj8gF3Cc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B724886D42; Thu, 21 Sep 2023 03:57:45 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF05486D0C
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-79329a8f78bso20542339f.3
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261459; x=1695866259; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vy+OSsAw9p44CDHD/da6p9nUe3NcjHsvR6/t2CloHM=;
 b=Kj8gF3CcAJYfL4zCdQKqZ5EwxP/ljmjCwp3NxwyNydVnRr1X2in7ZLkZVD3xFWSwxZ
 1SqDkaymiTKF0bjYOlZLAvZ+LxNTmbCgmPFjQixjYdp9lQ4Gii8GWNwc44O2TeJYmYmQ
 mS7gThYWhMIxAWjtLf7TcLynj7uBvDeoNymLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261459; x=1695866259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vy+OSsAw9p44CDHD/da6p9nUe3NcjHsvR6/t2CloHM=;
 b=sHkkyKBzJg3u1FQmOMe+oz1wWSkWqDr6Fn6vFwTQ4eScDpQG5p9/ogW6/X8sURNMtu
 IpUnuNwcIn5UVUBeMJR0BJQ7BxlCbh294890hgCIoP5CKFlXiIy5qNy/SWI4TUnDSEca
 /agVukbSnWwaB1F3u8htPNnbZZxRTvmAXI0oFNv1+3ZP9M0/u2hsXqjyi7brkfHEW2Ym
 2jKY5BDA2G049oW342JNFW20h94OXL1WvZ/vXyH085YG7sEzMWnAiqvxFch9REsU5nCz
 AsF8trt1nmaAVfBxEPvRidedsMPZc/8oo4M2PlUW/Zj6FDUG85fDFinMiSdvtbC1kFcG
 XPDA==
X-Gm-Message-State: AOJu0YxXCQBJ1BxZmKaooBVGnF30ImejCy3u+cn/5lU6G12NJ9whOCge
 lAy9ZjONXV6xIUZ11n+WV4ShCsTKByjuBVTNZIA=
X-Google-Smtp-Source: AGHT+IFXnRpKKgBAX690hnihcZHgNz6IEoOIX5H1Du34giidZdIsQisAicBiymwiClOLLaurbOnOgA==
X-Received: by 2002:a05:6e02:12e8:b0:351:ab2:2626 with SMTP id
 l8-20020a056e0212e800b003510ab22626mr310370iln.24.1695261459260; 
 Wed, 20 Sep 2023 18:57:39 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Simon Glass <sjg@chromium.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Nikhil M Jain <n-jain1@ti.com>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH v2 01/32] dm: core: support reading a single indexed u64 value
Date: Wed, 20 Sep 2023 19:56:50 -0600
Message-ID: <20230921015730.1511373-2-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

From: Michal Simek <michal.simek@amd.com>

Add helper function to allow reading a single indexed u64 value from a
device-tree property containing multiple u64 values, that is an array of
u64's.

Co-developed-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 arch/sandbox/dts/test.dts |  1 +
 drivers/core/of_access.c  | 16 ++++++++++++----
 drivers/core/ofnode.c     | 30 ++++++++++++++++++++++++++++++
 include/dm/of_access.h    | 19 +++++++++++++++++++
 include/dm/ofnode.h       | 12 ++++++++++++
 test/dm/ofnode.c          |  8 ++++++++
 6 files changed, 82 insertions(+), 4 deletions(-)

diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 63fda15da764..d4693e3c7a93 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -301,6 +301,7 @@
 		uint-value = <(-1234)>;
 		int64-value = /bits/ 64 <0x1111222233334444>;
 		int-array = <5678 9123 4567>;
+		int64-array = /bits/ 64 <0x1111222233334444 0x4444333322221111>;
 		str-value = "test string";
 		interrupts-extended = <&irq 3 0>;
 		acpi,name = "GHIJ";
diff --git a/drivers/core/of_access.c b/drivers/core/of_access.c
index 57f10445b122..1bb4d8eab709 100644
--- a/drivers/core/of_access.c
+++ b/drivers/core/of_access.c
@@ -570,26 +570,34 @@ int of_read_u32_index(const struct device_node *np, const char *propname,
 	return 0;
 }
 
-int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
+int of_read_u64_index(const struct device_node *np, const char *propname,
+		      int index, u64 *outp)
 {
 	const __be64 *val;
 
 	debug("%s: %s: ", __func__, propname);
 	if (!np)
 		return -EINVAL;
-	val = of_find_property_value_of_size(np, propname, sizeof(*outp));
+
+	val = of_find_property_value_of_size(np, propname,
+					     sizeof(*outp) * (index + 1));
 	if (IS_ERR(val)) {
 		debug("(not found)\n");
 		return PTR_ERR(val);
 	}
 
-	*outp = be64_to_cpup(val);
+	*outp = be64_to_cpup(val + index);
 	debug("%#llx (%lld)\n", (unsigned long long)*outp,
-              (unsigned long long)*outp);
+	      (unsigned long long)*outp);
 
 	return 0;
 }
 
+int of_read_u64(const struct device_node *np, const char *propname, u64 *outp)
+{
+	return of_read_u64_index(np, propname, 0, outp);
+}
+
 int of_property_match_string(const struct device_node *np, const char *propname,
 			     const char *string)
 {
diff --git a/drivers/core/ofnode.c b/drivers/core/ofnode.c
index a4dc9bde085c..8311282abf69 100644
--- a/drivers/core/ofnode.c
+++ b/drivers/core/ofnode.c
@@ -344,6 +344,36 @@ int ofnode_read_u32_index(ofnode node, const char *propname, int index,
 	return 0;
 }
 
+int ofnode_read_u64_index(ofnode node, const char *propname, int index,
+			  u64 *outp)
+{
+	const fdt64_t *cell;
+	int len;
+
+	assert(ofnode_valid(node));
+
+	if (ofnode_is_np(node))
+		return of_read_u64_index(ofnode_to_np(node), propname, index,
+					 outp);
+
+	cell = fdt_getprop(ofnode_to_fdt(node), ofnode_to_offset(node),
+			   propname, &len);
+	if (!cell) {
+		debug("(not found)\n");
+		return -EINVAL;
+	}
+
+	if (len < (sizeof(u64) * (index + 1))) {
+		debug("(not large enough)\n");
+		return -EOVERFLOW;
+	}
+
+	*outp = fdt64_to_cpu(cell[index]);
+	debug("%#llx (%lld)\n", *outp, *outp);
+
+	return 0;
+}
+
 u32 ofnode_read_u32_index_default(ofnode node, const char *propname, int index,
 				  u32 def)
 {
diff --git a/include/dm/of_access.h b/include/dm/of_access.h
index c556a18f7d9c..9361d0a87bfb 100644
--- a/include/dm/of_access.h
+++ b/include/dm/of_access.h
@@ -333,6 +333,25 @@ int of_read_u32(const struct device_node *np, const char *propname, u32 *outp);
 int of_read_u32_index(const struct device_node *np, const char *propname,
 		      int index, u32 *outp);
 
+/**
+ * of_read_u64_index() - Find and read a 64-bit value from a multi-value
+ *                       property
+ *
+ * @np:		device node from which the property value is to be read.
+ * @propname:	name of the property to be searched.
+ * @index:	index of the u32 in the list of values
+ * @outp:	pointer to return value, modified only if return value is 0.
+ *
+ * Search for a property in a device node and read a 64-bit value from
+ * it.
+ *
+ * Return:
+ *   0 on success, -EINVAL if the property does not exist, or -EOVERFLOW if the
+ *   property data isn't large enough.
+ */
+int of_read_u64_index(const struct device_node *np, const char *propname,
+		      int index, u64 *outp);
+
 /**
  * of_read_u64() - Find and read a 64-bit integer from a property
  *
diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 0f38b3e736de..0a85db31f360 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -434,6 +434,18 @@ int ofnode_read_u32(ofnode node, const char *propname, u32 *outp);
 int ofnode_read_u32_index(ofnode node, const char *propname, int index,
 			  u32 *outp);
 
+/**
+ * ofnode_read_u64_index() - Read a 64-bit integer from a multi-value property
+ *
+ * @node:	valid node reference to read property from
+ * @propname:	name of the property to read from
+ * @index:	index of the integer to return
+ * @outp:	place to put value (if found)
+ * Return: 0 if OK, -ve on error
+ */
+int ofnode_read_u64_index(ofnode node, const char *propname, int index,
+			  u64 *outp);
+
 /**
  * ofnode_read_s32() - Read a 32-bit integer from a property
  *
diff --git a/test/dm/ofnode.c b/test/dm/ofnode.c
index 6fbebc7da085..b74f5c2ebcff 100644
--- a/test/dm/ofnode.c
+++ b/test/dm/ofnode.c
@@ -967,6 +967,14 @@ static int dm_test_ofnode_u64(struct unit_test_state *uts)
 	ut_asserteq_64(0x1111222233334444, val);
 	ut_asserteq(-EINVAL, ofnode_read_u64(node, "missing", &val));
 
+	ut_assertok(ofnode_read_u64_index(node, "int64-array", 0, &val));
+	ut_asserteq_64(0x1111222233334444, val);
+	ut_assertok(ofnode_read_u64_index(node, "int64-array", 1, &val));
+	ut_asserteq_64(0x4444333322221111, val);
+	ut_asserteq(-EOVERFLOW,
+		    ofnode_read_u64_index(node, "int64-array", 2, &val));
+	ut_asserteq(-EINVAL, ofnode_read_u64_index(node, "missing", 0, &val));
+
 	return 0;
 }
 DM_TEST(dm_test_ofnode_u64, UT_TESTF_SCAN_FDT);
-- 
2.42.0.515.g380fc7ccd1-goog

